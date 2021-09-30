Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 809DF41D06C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 02:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346536AbhI3AFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 20:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbhI3AFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 20:05:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B00C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 17:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gzbQERF6x+EIArRP2/cV+6lI/UWsckEqZ6f0LRsHXHE=; b=Ey0f+HiKfvoPWo/hz+noSNujur
        6gQgigq8p2t2KAHbZv1BxL0OSABG9G3Ktig6espCV3/GHaJYX9PLlythflNNGjNLRUC0CaVyfjBBa
        upFVYit1P3V6n35QOVJsXviB3CHJSPB402F3EEXwjgNYJTn+Qei0lT0pMo/5ll+ub141nSpThBFg8
        1TJr2e8SnFD3DbfK3B/pBi0WXOSZDqXMPfwIGfsh7cxDedXgXThhixbTQQeTUSV+63r7HQSNXZkk8
        T6nAGyd21JAIunBmt5LEYo0LzpQoTXGJdyXUgaTp1K+bu7bGQOuXT4ApbNKksvrrL1fNHHltzwmU8
        9DYjtniw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mVjVB-00CM5V-Bf; Thu, 30 Sep 2021 00:01:11 +0000
Date:   Thu, 30 Sep 2021 01:00:41 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Song Liu <song@kernel.org>
Cc:     Rongwei Wang <rongwei.wang@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        William Kucharski <william.kucharski@oracle.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v2 1/2] mm, thp: check page mapping when truncating page
 cache
Message-ID: <YVT+KWFA8hfSKU+m@casper.infradead.org>
References: <BC145393-93AC-4DF4-9CF4-2FB1C736B70C@linux.alibaba.com>
 <20210923194343.ca0f29e1c4d361170343a6f2@linux-foundation.org>
 <9e41661d-9919-d556-8c49-610dae157553@linux.alibaba.com>
 <CAPhsuW4cP4qV2c_wXP89-2fa+mALv-uEe+Qdqr_MD3Ptw03Wng@mail.gmail.com>
 <68737431-01d2-e6e3-5131-7d7c731e49ae@linux.alibaba.com>
 <CAPhsuW4x2UzMLwZyioWH4dXqrYwNT-XKgzvrm+6YeWk9EgQmCQ@mail.gmail.com>
 <dde441c4-febe-cfa1-7729-b405fa331a4e@linux.alibaba.com>
 <CAPhsuW5FONP=1rPh0oPLHsehjfGSDQWn8hKH4v=azdd=+WK2sA@mail.gmail.com>
 <YVSopxYWegtQJ3iD@casper.infradead.org>
 <CAPhsuW6_2_LxQRrs7xF3omgO22+6goDR=bEjKGRopaS-pHJB2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW6_2_LxQRrs7xF3omgO22+6goDR=bEjKGRopaS-pHJB2Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 04:41:48PM -0700, Song Liu wrote:
> The issue is NOT caused by concurrent khugepaged:collapse_file() and
> truncate_pagecache(inode, 0). With some printks, we can see a clear
> time gap (>2 second )  between collapse_file() finishes, and
> truncate_pagecache() (which crashes soon). Therefore, my earlier
> suggestion that adds deny_write_access() to collapse_file() does NOT
> work.
> 
> The crash is actually caused by concurrent truncate_pagecache(inode, 0).
> If I change the number of write thread in stress_madvise_dso.c to one,
> (IOW, one thread_read and one thread_write), I cannot reproduce the
> crash anymore.
> 
> I think this means we cannot fix this issue in collapse_file(), because it
> finishes long before the crash.

Ah!  So are we missing one or more of these locks:

	inode_lock(inode);
	filemap_invalidate_lock(mapping);

in the open path?
