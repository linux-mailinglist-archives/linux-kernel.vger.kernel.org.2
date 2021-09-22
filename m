Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBD384147F5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 13:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235759AbhIVLlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 07:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbhIVLk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 07:40:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA80C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 04:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tZq1SReOZM5no9c+5zSUWDpuhZmax+sW5KT+xZkE3Ks=; b=c3sp06S44e4D61s4gSsvVhM9FV
        hUf+CAxIT07xY031PRLyOqrgPpVvIKzlwjETkpxRCeuTQ+FcfBr6Ucj4uxXoz0fbKdknBJDM60yt2
        NbmgG7fstVOGLJGZJ+0nufBPsR50dBPQKIoIYm3FPd6ubN68qQauA9BYuRL4eYHbDw1BAO45bRq0E
        qMFN2tON9yTv4mhrErucP81OrVcMbZxZfM31lIBWNxRmB1SVybEiuVuhThqoc0sxYf3Z+cW+t6dHk
        QhJPOrGIE6W8xtG3NIkkR6rlrl/5n3nYF5Cdpqb/OW8i1yWChj+Bmw0D5ILj/EnCc1Gjh7wYb0KWt
        bCq8B3OA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mT0Yy-004jv5-N5; Wed, 22 Sep 2021 11:37:36 +0000
Date:   Wed, 22 Sep 2021 12:37:20 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Rongwei Wang <rongwei.wang@linux.alibaba.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, cfijalkovich@google.com,
        song@kernel.org, william.kucharski@oracle.com, hughd@google.com
Subject: Re: [PATCH v2 1/2] mm, thp: check page mapping when truncating page
 cache
Message-ID: <YUsVcEDcQ2vEzjGg@casper.infradead.org>
References: <20210906121200.57905-1-rongwei.wang@linux.alibaba.com>
 <20210922070645.47345-2-rongwei.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922070645.47345-2-rongwei.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 03:06:44PM +0800, Rongwei Wang wrote:
> Transparent huge page has supported read-only non-shmem files. The file-
> backed THP is collapsed by khugepaged and truncated when written (for
> shared libraries).
> 
> However, there is race in two possible places.
> 
> 1) multiple writers truncate the same page cache concurrently;
> 2) collapse_file rolls back when writer truncates the page cache;

As I've said before, the bug here is that somehow there is a writable fd
to a file with THPs.  That's what we need to track down and fix.

https://lore.kernel.org/linux-mm/YUdL3lFLFHzC80Wt@casper.infradead.org/

