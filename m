Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA0934EF2C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 19:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbhC3RP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 13:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbhC3RPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 13:15:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD70C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 10:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LJtqlA/kBtvsZ15zWdvm9iToMqA/4o6fu3tBvHGlUbE=; b=uN/gUIM3FbrA6Yt5NM7B2fbtIe
        8UfbsYnN9nI87Nr6eFY6tQ0CChy1RgEX6bl0bWqNYXlv0DwivCeECg51AnZkBSMK5pUmgoz4Z2HaR
        sdJJV8wtsC3NB1xedzwLwCd2E4uWna1a9gIk5YXPL6NZ60NuiVjI8lX6ngwtFivQM3j9qyUYvC2h1
        fxY2yX5KStgOt9vCM2OO2qNn8pKyl0y5OdV1cR5ztUhuMvsreODAB2L+ywz/Xp3wmyGsLt8aUIWzD
        XJPKlzcyt1ICa5zarD+uo3ei1mgwIwQYOxw9+vLKYjXSMc5kUgdGxvjIy6F+duvPmPQt2P4tJQcbp
        Z3TuXxAA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lRHx6-003Ljx-6f; Tue, 30 Mar 2021 17:15:00 +0000
Date:   Tue, 30 Mar 2021 18:14:52 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Huang Ying <ying.huang@intel.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: Move page_mapping_file to pagemap.h
Message-ID: <20210330171452.GO351017@casper.infradead.org>
References: <20210317123011.350118-1-willy@infradead.org>
 <YGNbt87KmByKVs0P@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGNbt87KmByKVs0P@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 08:11:19PM +0300, Mike Rapoport wrote:
> On Wed, Mar 17, 2021 at 12:30:11PM +0000, Matthew Wilcox (Oracle) wrote:
> > page_mapping_file() is only used by some architectures, and then it
> > is usually only used in one place.  Make it a static inline function
> > so other architectures don't have to carry this dead code.
>  
> As the original commit that replaced page_mapping() with
> page_mapping_file() [cb9f753a3731 ("mm: fix races between swapoff and flush
> dcache")] missed arch/nds32 I think it'll make sense to add the below hunk
> to this patch:
> 
> diff --git a/arch/nds32/mm/cacheflush.c b/arch/nds32/mm/cacheflush.c
> index 6eb98a7ad27d..ad5344ef5d33 100644
> --- a/arch/nds32/mm/cacheflush.c
> +++ b/arch/nds32/mm/cacheflush.c
> @@ -238,7 +238,7 @@ void flush_dcache_page(struct page *page)
>  {
>  	struct address_space *mapping;
>  
> -	mapping = page_mapping(page);
> +	mapping = page_mapping_file(page);
>  	if (mapping && !mapping_mapped(mapping))
>  		set_bit(PG_dcache_dirty, &page->flags);
>  	else {

Good catch, but it's its own distinct problem, so I'd make it a separate
patch.
