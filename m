Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 502393AAFF4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 11:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbhFQJnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 05:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbhFQJnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 05:43:03 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8EC9C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 02:40:55 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id e7so2630082plj.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 02:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=XjLNVS8FTx5mg1CNbMomnZVz+ZmOYcIpwKWpVxPSZ9w=;
        b=BrhlGOFiuNTlT066ZSqQu5rrq81YOSSFJOCCKunAZiZjib4sCKF/bPaYURHAw27dwq
         38+zt/0BmrWQ+sfHpwVFgLbG4748X9/IHC0igLCedTDs1uAJqQX3xDidPmJJrzNmAbr0
         fbaEnXZbgmU6Ecyj6cDtn0QGi9j52zV/YZcNw4GjmZsqaokY+/xSlw2W1YSXcgMGZAsz
         ov879So3M6wOtTi6SX1Eaf3D5Zcm9XSWQ9JGLPYmx/YfmX287MHNaJq5SU70ixh1pupE
         DfKzpZZTdzoXw2GJ8VlLLYdHV3BiFLindJD1tqVxGDoYdY3bC4BnVXvkWOKE/kza/A+b
         cHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=XjLNVS8FTx5mg1CNbMomnZVz+ZmOYcIpwKWpVxPSZ9w=;
        b=KZ7LhAqxzs/lKy1bm5l2RFSQ379WAc0X8ZjVwPpn4ASw5TMwH+2GrnDbCAkKOrZD6M
         WqgP6xsFE6F4MfCnDMCERkn85sgM0M4a+hSWOgBmXBqqE5/DZZSfxMbQDdPMFJ3ToS6S
         4aUCO4Q5Fvs+QWv/IaKX6Uat4N5ueMG8IDybC5L0K7iuvSNbzaIGZClMMGSps1CHMwIe
         olorou12KP+3/C6+Vuqh0mcSqrKHn9Ikxx8FkLe+I1nq5IgaWnU/885pfd9tf20v+Qcy
         XNjsqHw3tuVgdg4WYTTcqQtxI+NfqU3xGPqt0xFEgxIgaUCUHJ2dDpXj7a2/xGNadfcq
         M3JA==
X-Gm-Message-State: AOAM531T48yddDe1MSenOiBNV1SxZ+H3CqVXEFbOXCnflB7R4U7YqPZo
        QE8X6kmH3y3aSTzJyc7vJvE=
X-Google-Smtp-Source: ABdhPJz+u2UcyjxbBbFK4ixz6KbeUvY89VrD/B59FbeE5DroDqZHQH+18TpNb8AHQBe2f7CUP/+vdw==
X-Received: by 2002:a17:903:2310:b029:109:e746:89a2 with SMTP id d16-20020a1709032310b0290109e74689a2mr3775750plh.8.1623922855231;
        Thu, 17 Jun 2021 02:40:55 -0700 (PDT)
Received: from localhost (60-242-147-73.tpgi.com.au. [60.242.147.73])
        by smtp.gmail.com with ESMTPSA id h8sm4506707pjf.7.2021.06.17.02.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 02:40:54 -0700 (PDT)
Date:   Thu, 17 Jun 2021 19:40:49 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] mm/vmalloc: unbreak kasan vmalloc support
To:     akpm@linux-foundation.org, Daniel Axtens <dja@axtens.net>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        David Gow <davidgow@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Uladzislau Rezki <urezki@gmail.com>
References: <20210617081330.98629-1-dja@axtens.net>
In-Reply-To: <20210617081330.98629-1-dja@axtens.net>
MIME-Version: 1.0
Message-Id: <1623922742.sam09kpmhp.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Daniel Axtens's message of June 17, 2021 6:13 pm:
> In commit 121e6f3258fe ("mm/vmalloc: hugepage vmalloc mappings"),
> __vmalloc_node_range was changed such that __get_vm_area_node was no
> longer called with the requested/real size of the vmalloc allocation, but
> rather with a rounded-up size.
>=20
> This means that __get_vm_area_node called kasan_unpoision_vmalloc() with
> a rounded up size rather than the real size. This led to it allowing
> access to too much memory and so missing vmalloc OOBs and failing the
> kasan kunit tests.
>=20
> Pass the real size and the desired shift into __get_vm_area_node. This
> allows it to round up the size for the underlying allocators while
> still unpoisioning the correct quantity of shadow memory.
>=20
> Adjust the other call-sites to pass in PAGE_SHIFT for the shift value.
>=20
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: David Gow <davidgow@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D213335
> Fixes: 121e6f3258fe ("mm/vmalloc: hugepage vmalloc mappings")

Thanks Daniel, good debugging.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> Signed-off-by: Daniel Axtens <dja@axtens.net>
> ---
>  mm/vmalloc.c | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)
>=20
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index aaad569e8963..3471cbeb083c 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2362,15 +2362,16 @@ static void clear_vm_uninitialized_flag(struct vm=
_struct *vm)
>  }
> =20
>  static struct vm_struct *__get_vm_area_node(unsigned long size,
> -		unsigned long align, unsigned long flags, unsigned long start,
> -		unsigned long end, int node, gfp_t gfp_mask, const void *caller)
> +		unsigned long align, unsigned long shift, unsigned long flags,
> +		unsigned long start, unsigned long end, int node,
> +		gfp_t gfp_mask, const void *caller)
>  {
>  	struct vmap_area *va;
>  	struct vm_struct *area;
>  	unsigned long requested_size =3D size;
> =20
>  	BUG_ON(in_interrupt());
> -	size =3D PAGE_ALIGN(size);
> +	size =3D ALIGN(size, 1ul << shift);
>  	if (unlikely(!size))
>  		return NULL;
> =20
> @@ -2402,8 +2403,8 @@ struct vm_struct *__get_vm_area_caller(unsigned lon=
g size, unsigned long flags,
>  				       unsigned long start, unsigned long end,
>  				       const void *caller)
>  {
> -	return __get_vm_area_node(size, 1, flags, start, end, NUMA_NO_NODE,
> -				  GFP_KERNEL, caller);
> +	return __get_vm_area_node(size, 1, PAGE_SHIFT, flags, start, end,
> +				  NUMA_NO_NODE, GFP_KERNEL, caller);
>  }
> =20
>  /**
> @@ -2419,7 +2420,8 @@ struct vm_struct *__get_vm_area_caller(unsigned lon=
g size, unsigned long flags,
>   */
>  struct vm_struct *get_vm_area(unsigned long size, unsigned long flags)
>  {
> -	return __get_vm_area_node(size, 1, flags, VMALLOC_START, VMALLOC_END,
> +	return __get_vm_area_node(size, 1, PAGE_SHIFT, flags,
> +				  VMALLOC_START, VMALLOC_END,
>  				  NUMA_NO_NODE, GFP_KERNEL,
>  				  __builtin_return_address(0));
>  }
> @@ -2427,7 +2429,8 @@ struct vm_struct *get_vm_area(unsigned long size, u=
nsigned long flags)
>  struct vm_struct *get_vm_area_caller(unsigned long size, unsigned long f=
lags,
>  				const void *caller)
>  {
> -	return __get_vm_area_node(size, 1, flags, VMALLOC_START, VMALLOC_END,
> +	return __get_vm_area_node(size, 1, PAGE_SHIFT, flags,
> +				  VMALLOC_START, VMALLOC_END,
>  				  NUMA_NO_NODE, GFP_KERNEL, caller);
>  }
> =20
> @@ -2949,9 +2952,9 @@ void *__vmalloc_node_range(unsigned long size, unsi=
gned long align,
>  	}
> =20
>  again:
> -	size =3D PAGE_ALIGN(size);
> -	area =3D __get_vm_area_node(size, align, VM_ALLOC | VM_UNINITIALIZED |
> -				vm_flags, start, end, node, gfp_mask, caller);
> +	area =3D __get_vm_area_node(real_size, align, shift, VM_ALLOC |
> +				  VM_UNINITIALIZED | vm_flags, start, end, node,
> +				  gfp_mask, caller);
>  	if (!area) {
>  		warn_alloc(gfp_mask, NULL,
>  			"vmalloc error: size %lu, vm_struct allocation failed",
> @@ -2970,6 +2973,7 @@ void *__vmalloc_node_range(unsigned long size, unsi=
gned long align,
>  	 */
>  	clear_vm_uninitialized_flag(area);
> =20
> +	size =3D PAGE_ALIGN(size);
>  	kmemleak_vmalloc(area, size, gfp_mask);
> =20
>  	return addr;
> --=20
> 2.30.2
>=20
>=20
