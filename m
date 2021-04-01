Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC5B1350F1D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 08:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbhDAGhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 02:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhDAGhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 02:37:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39860C0613E6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 23:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UnDsqWuvOuHdfoPwQZfisLiRixlJIZ0mZK0rwiZPBp4=; b=SeItDScDzhSk2FeB9nhoeHpmMQ
        FBuWTRohENB5eGO7fbkSTwV4gkO3YRWGqoAna5JxXiM1HIoPtwoR2ZU8k1rv79Xf1jXKjTDJqyU2s
        YnqWzS/O8iSgduV7PVWtbbczvwuWyxihagsNNeOD5JeHosFoo90yGpm9fJfcw3Nb1DOfTAyrqdG6K
        tUia+hUBgVON7cFLNbJANP9SdrVz4gC4/m3ksuGbhfc36f1kphPMARvOhfZJQcXeN/N0oxlaRdcOC
        nvt9q/5/hV7qps0n6k7ad/ZR6dBLkXp9mlMV6dMWoQ1wO17Ne0i5LIUInFVgy7gLZdtkfS5tOOumu
        l3sWMCiQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lRqx1-005ibZ-0P; Thu, 01 Apr 2021 06:37:10 +0000
Date:   Thu, 1 Apr 2021 07:37:07 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jiuyang Liu <liu@jiuyang.me>
Cc:     Alex Ghiti <alex@ghiti.fr>,
        Andrew Waterman <waterman@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] implement flush_cache_vmap and flush_cache_vunmap for
 RISC-V
Message-ID: <20210401063707.GA1362465@infradead.org>
References: <20210329015510.44110-1-liu@jiuyang.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329015510.44110-1-liu@jiuyang.me>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 01:55:09AM +0000, Jiuyang Liu wrote:
> +/*
> + * flush_cache_vmap and flush_cache_vunmap might modify PTE, needs SFENCE.VMA.
> + * - flush_cache_vmap is invoked after map_kernel_range() has installed the page table entries.
> + * - flush_cache_vunmap is invoked before unmap_kernel_range() deletes the page table entries
> + */

Please never ever write comments > 80 chars.  And please read the
coding style document.
