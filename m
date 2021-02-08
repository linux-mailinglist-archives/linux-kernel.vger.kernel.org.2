Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2CB314070
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 21:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236805AbhBHU0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 15:26:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235986AbhBHTCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 14:02:34 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11484C061788
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 11:01:54 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id a17so18548054ljq.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 11:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8pqhdeRC3f5+oXF00/LNR4GyCgSd0C0aI5uiNvoPwIQ=;
        b=oNU15KazCL+KgVUExu0qk8wT3Ae19v82VIJ906txss4RN00b1Izwrm48c/DDcbFBrP
         gP2le+VheSKZspNNFTDLshUTqgU6qJUrxQDD0RvotT65wwg3vM3k6pQv6Wvdro6vkhzK
         g4uvTRLcyZrg+rTjVXEG3OQ/dP0pgj2D3cv3p0IIIz70W/vfS9glJl/H60Vs6H6sq7Nx
         RvnRdR3knB1Iq0rDvGZipj0ysbf1Y7cVij6u6ms+ooJg1GxJzXc/3cfEJUeXdhSh99te
         JyuPyHe/hThZ/U5vnHqvGxXflq0hpQV8jwmYq7TkjKthO7oxtgPex164BujoZDWedpBU
         lJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8pqhdeRC3f5+oXF00/LNR4GyCgSd0C0aI5uiNvoPwIQ=;
        b=aWYzESAcYm4kZHiytRT/VNJJVQrcnDulXa1at+iGJRTr9F7sxTdGRMJO6GtilurMQS
         g8oMS1N7nhMmTDfAflKf7b3DIyHWT+ITy7dTgGAUFzeA0O885Kk9HyHi/u9RWudniORt
         p0cvx/pcXVmZzBuhEJFDROIFLORxv4cdRLd1X2kZiwUgcJvGuhaDo6fol8CJ2vxNJnq+
         0eXLimRw821EBcJxasZ0Obd23yMWYE31SwY+okotTR60ICrw4XZe1pQeFovnGvL/EEhS
         3QeCmzT1yxEwnmw+w6mQDLQvjcuOnyU8LcNtETEUjH650U73SgD+5/rnepP/fAyKSVzT
         x1TQ==
X-Gm-Message-State: AOAM532GgCf5uO3C/U4FueB9Mc3iPgpEBPMWhSgIAii+lClF/qzcmpA9
        T7is1bzdkUlhCAO7Y+KT1ic=
X-Google-Smtp-Source: ABdhPJyVdxzMzjalyUYM8ESVucaFT3SUi9SJB1qRrWnXO/EZJDW0sDX7LqLI/sHiRfbW2x9fm0kKHg==
X-Received: by 2002:a2e:81c7:: with SMTP id s7mr6786278ljg.178.1612810912524;
        Mon, 08 Feb 2021 11:01:52 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id j5sm2190773lfu.139.2021.02.08.11.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 11:01:51 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Mon, 8 Feb 2021 20:01:50 +0100
To:     Serapheim Dimitropoulos <serapheim.dimitro@delphix.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, osandov@osandov.com,
        serapheim@delphix.com
Subject: Re: [PATCH] mm/vmalloc: use rb_tree instead of list for vread()
 lookups
Message-ID: <20210208190150.GA22808@pc638.lan>
References: <20210208155303.10523-1-serapheim@delphix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208155303.10523-1-serapheim@delphix.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 03:53:03PM +0000, Serapheim Dimitropoulos wrote:
> vread() has been linearly searching vmap_area_list for looking up
> vmalloc areas to read from. These same areas are also tracked by
> a rb_tree (vmap_area_root) which offers logarithmic lookup.
> 
> This patch modifies vread() to use the rb_tree structure instead
> of the list and the speedup for heavy /proc/kcore readers can
> be pretty significant. Below are the wall clock measurements of
> a Python application that leverages the drgn debugging library
> to read and interpret data read from /proc/kcore.
> 
> Before the patch:
> -----
> $ time sudo sdb -e 'dbuf | head 2500 | wc'
> (unsigned long)2500
> 
> real	0m21.128s
> user	0m2.321s
> sys	0m19.227s
> -----
> 
> With the patch:
> -----
> $ time sudo sdb -e 'dbuf | head 2500 | wc'
> (unsigned long)2500
> 
> real	0m1.870s
> user	0m1.628s
> sys	0m0.660s
> -----
> 
> Signed-off-by: Serapheim Dimitropoulos <serapheim@delphix.com>
> ---
>  mm/vmalloc.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 49ab9b6c001d..86343b879938 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2851,6 +2851,7 @@ long vread(char *buf, char *addr, unsigned long count)
>  {
>  	struct vmap_area *va;
>  	struct vm_struct *vm;
> +	struct rb_node *node;
>  	char *vaddr, *buf_start = buf;
>  	unsigned long buflen = count;
>  	unsigned long n;
> @@ -2860,17 +2861,15 @@ long vread(char *buf, char *addr, unsigned long count)
>  		count = -(unsigned long) addr;
>  
>  	spin_lock(&vmap_area_lock);
> -	list_for_each_entry(va, &vmap_area_list, list) {
> -		if (!count)
> -			break;
> -
> +	va = __find_vmap_area((unsigned long)addr);
> +	if (!va)
> +		goto finished;
> +	while (count) {
>  		if (!va->vm)
> -			continue;
> +			goto next_node;
>  
>  		vm = va->vm;
>  		vaddr = (char *) vm->addr;
> -		if (addr >= vaddr + get_vm_area_size(vm))
> -			continue;
>  		while (addr < vaddr) {
>  			if (count == 0)
>  				goto finished;
> @@ -2889,6 +2888,12 @@ long vread(char *buf, char *addr, unsigned long count)
>  		buf += n;
>  		addr += n;
>  		count -= n;
> +
> +next_node:
> +		node = rb_next(&va->rb_node);
> +		if (!node)
> +			break;
> +		va = rb_entry(node, struct vmap_area, rb_node);
>
You can also improve it. Instead of rb_next() you can directly access
to a "next" element via "va->list" making it O(1) complexity.

--
Vlad Rezki
