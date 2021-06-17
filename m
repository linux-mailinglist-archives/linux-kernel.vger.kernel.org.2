Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 975743AB3DA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 14:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbhFQMnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 08:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbhFQMns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 08:43:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36783C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 05:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6buJ1EzwuAkSghHPh7appt09mi8sVKMXWYQqJKpVxtQ=; b=TvkE86lgS/8sg7Iv/GbSjgmfR1
        lCDZTb3RWjU40fLyNYsLCIZytLxziAsc/zUOz7FLogKU/wd7lQY0mF7p+dYw/NV97CjIrkYfngFMT
        vaqK0lTs8HpvSobY6SrHaIPfvIqDNTMaX80gG7C98v0rDQHCmS7CPymXcl8RdeVTVc5i5HiHwCrYE
        r6/F7HNUtyNEyA0vi3AUqy/Gp8BgLsVMPI3o2j8yntn4brsVPviYRWMXP1vZllPfWaGsabW7pHGP9
        JYHNWaVuXqoYlrxqL9IQRLXgh8Nbi0LMtbeFLcu+f5Xi3+cgUu1pfDxUoM22g8DjG5lV6tvdB3+7N
        XpVNOEVg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltrKG-00981p-37; Thu, 17 Jun 2021 12:40:55 +0000
Date:   Thu, 17 Jun 2021 13:40:52 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Janghyuck Kim <janghyuck.kim@samsung.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Atish Patra <atish.patra@wdc.com>,
        Gavin Shan <gshan@redhat.com>,
        Zhengyuan Liu <liuzhengyuan@tj.kylinos.cn>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/2] mm: support fastpath if NUMA is enabled with numa off
Message-ID: <YMtC1JfSKbx421sX@casper.infradead.org>
References: <CGME20210616081628epcas2p3f919d10029cbe01efa1212a5b861af38@epcas2p3.samsung.com>
 <20210616083745.14288-1-janghyuck.kim@samsung.com>
 <YMo1wik1plVotC1N@casper.infradead.org>
 <20210617115544.GB183559@KEI>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617115544.GB183559@KEI>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 08:55:44PM +0900, Janghyuck Kim wrote:
> On Wed, Jun 16, 2021 at 06:32:50PM +0100, Matthew Wilcox wrote:
> > On Wed, Jun 16, 2021 at 05:37:41PM +0900, Janghyuck Kim wrote:
> > > Architecture might support fake node when CONFIG_NUMA is enabled but any
> > > node settings were supported by ACPI or device tree. In this case,
> > > getting memory policy during memory allocation path is meaningless.
> > > 
> > > Moreover, performance degradation was observed in the minor page fault
> > > test, which is provided by (https://protect2.fireeye.com/v1/url?k=c81407ae-978f3ea4-c8158ce1-0cc47a31384a-10187d5ead74c318&q=1&e=cbc91c9b-80e1-4ca0-b51a-9f79fad5b0c1&u=https%3A%2F%2Flkml.org%2Flkml%2F2006%2F8%2F29%2F294).
> > > Average faults/sec of enabling NUMA with fake node was 5~6 % worse than
> > > disabling NUMA. To reduce this performance regression, fastpath is
> > > introduced. fastpath can skip the memory policy checking if NUMA is
> > > enabled but it uses fake node. If architecture doesn't support fake
> > > node, fastpath affects nothing for memory allocation path.
> > 
> > This patch doesn't even apply to the current kernel, but putting that
> > aside, what's the expensive part of the current code?  That is,
> > comparing performance stats between this numa_off enabled and numa_off
> > disabled, where do you see taking a lot of time?
> > 
> 
> mempolicy related code that I skipped by this patch took a short time,
> taking only a few tens of nanoseconds that difficult to measure by
> sched_clock's degree of precision. But it can be affect the minor page
> fault test with large buffer size, because one page fault handling takes
> several ms. As I replied in previous mail, performance regression has
> been reduced from 5~6% to 2~3%.

I'm not proposing you use sched_clock.  Try perf.

