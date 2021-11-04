Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 046BC44546F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 15:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbhKDOEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 10:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbhKDOEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 10:04:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C3FC061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 07:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TcxeMmdf9PMM1bk2EyTfoeHBwMvJzyVyT3rTUBUqfjY=; b=f9B6oJqv03KRyTJYCdPePuVqh8
        DfHgyDJklMqgPHS9BtUAe+6plFoVMVlW2rJdPNbWSPFSkiPky/qrZmudNiHEjitYUSKYFSwMUFHvA
        LwGzJyky6L3T9mM+JVCF+gcHZy4IKLhyp6T5IsyfH0yqcjfHUHVxBtgeLLcWYw7n6RJvANZpejNJQ
        biK+oP8YntFy0sAjsVHzXIy7cGZ8PisYgebbPjx0Mk7sJKGvFRTu8H2+bno/GdRNStNcMLC86R6JL
        ESCamt9QSJ2mgI/EjZjyRmpZIPQG0+c6qU9gYVkGxLYdGiBbbywN6ppGGunP24d/rfbO1QG57CPtt
        5HsBoIvw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1midEi-005u4V-RG; Thu, 04 Nov 2021 13:57:18 +0000
Date:   Thu, 4 Nov 2021 13:57:00 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Chen Wandun <chenwandun@huawei.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: vmap: avoid -Wsequence-point warning
Message-ID: <YYPmrAGIBgMq2zQE@casper.infradead.org>
References: <20211104133549.1150058-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104133549.1150058-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021 at 02:35:40PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc warns about potentially undefined behavior in an array index:
> 
> mm/vmalloc.c: In function 'vmap_pfn_apply':
> mm/vmalloc.c:2800:58: error: operation on 'data->idx' may be undefined [-Werror=sequence-point]
>  2800 |         *pte = pte_mkspecial(pfn_pte(data->pfns[data->idx++], data->prot));
>       |                                                 ~~~~~~~~~^~
> arch/arm64/include/asm/pgtable-types.h:25:37: note: in definition of macro '__pte'
>    25 | #define __pte(x)        ((pte_t) { (x) } )
>       |                                     ^
> arch/arm64/include/asm/pgtable.h:80:15: note: in expansion of macro '__phys_to_pte_val'
>    80 |         __pte(__phys_to_pte_val((phys_addr_t)(pfn) << PAGE_SHIFT) | pgprot_val(prot))
>       |               ^~~~~~~~~~~~~~~~~
> mm/vmalloc.c:2800:30: note: in expansion of macro 'pfn_pte'
>  2800 |         *pte = pte_mkspecial(pfn_pte(data->pfns[data->idx++], data->prot));
>       |                              ^~~~~~~
> 
> This only appeared in one randconfig build so far, and I don't know
> what caused it, but moving the index increment out of the expression
> at least addresses the warning.

Would that randconfig include CONFIG_ARM64_PA_BITS_52?

#define __phys_to_pte_val(phys) (((phys) | ((phys) >> 36)) & PTE_ADDR_MASK)

because that's going to double-increment idx.  Or single increment.
Or whatever else the compiler feels like doing.
