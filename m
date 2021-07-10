Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 777193C36DC
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 23:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbhGJVNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 17:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhGJVNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 17:13:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2356C0613DD
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jul 2021 14:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3Fv3JaRsdV1s9RLb16qwGkvG9CqOP8qJx48U5nNcWB4=; b=Yp8zWtcy26W2BtPEMT2CjH4Gke
        Xn0rxqYx1pvRTOyswBT7QbQVhezMkXCivxY/pAHYdNfrYrXGkhi1bX6tAENIzIYRHlyqu/BhHNQdZ
        tDNNw6xlT1+HwBxBXpOclx21UHLponACB9rhAXi8Ed7DYAk/f/nlSrMW/VG4E7IBkwo6XFzPR15o8
        ueSy/D43aRuxoGnBRt9q8nx6kGuIVvUq2lY4l42PlEIZgfQuWTSa/RwP6oEO57EeikrTk39qtHCrT
        Kndgc+qQP15tp+fsINoHMvLfqHkMJTO7u2bWVNeTeTgdUNjMa0xR1SdgHvYAax+G2+P5j/GL0NRFN
        4itYNJYA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2KEd-00FlRk-Rz; Sat, 10 Jul 2021 21:10:06 +0000
Date:   Sat, 10 Jul 2021 22:10:03 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     qiang.zhang@windriver.com, mgorman@techsingularity.net,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: avoid hard lockups in __alloc_pages_bulk()
Message-ID: <YOoMq0Bl6M/LV6mJ@casper.infradead.org>
References: <20210710112929.232268-1-qiang.zhang@windriver.com>
 <20210710114613.0db3ac139a7b3102a6ca3ad4@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210710114613.0db3ac139a7b3102a6ca3ad4@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 10, 2021 at 11:46:13AM -0700, Andrew Morton wrote:
> On Sat, 10 Jul 2021 19:29:29 +0800 qiang.zhang@windriver.com wrote:
> 
> > From: Zqiang <qiang.zhang@windriver.com>
> > 
> > The __alloc_pages_bulk() mainly used for batch allocation of
> > order-0 pages, in the case of holding pagesets.lock, if too
> > many pages are required, maybe trigger hard lockup watchdog.
> 
> Ouch.  Has this been observed in testing?  If so, can you please share
> the kernel debug output from that event?

This should be fixed in the caller by asking for fewer pages.
The NFS and vmalloc cases have already been fixed for this.
