Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5A63480FB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 19:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237709AbhCXSxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 14:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237620AbhCXSwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 14:52:39 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BD1C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 11:52:39 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id kr3-20020a17090b4903b02900c096fc01deso1699499pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 11:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=1PsUu1wvuY+IbxpzYcYpkxmAABt/cMEwYJjpOzi4DvU=;
        b=duRPvli4fF3XiNd8a6TBBUWAC8zazPyCBTUgPIAZR1FA4D4HNhLsL39v7QoC2gyiUs
         FL9/JMxnbLXo7CCsEUijvY/2Pa+krhPrA1vD4k3ZPewvY65dnfcY2BKRSVP9EjoA4tRE
         uR4YJ5R8/CyeKDaJWuRKCIQi1RiNSJ/6OI+lP09sDgb7FiCy46mxiqePEQLpE2tWtKIt
         4NahLjvAaEjF4b1CX/mHmelneQCBbkz4PiHZB+zISNTPF4F8cGCgwixWcBcBYPNSNXkQ
         ib7VXdMXywdDXi6NG3rRmbMs3H8SxMQmXVQr38si2oUDBRx9L2GwHdY8ZKYM1JE56jdc
         nZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=1PsUu1wvuY+IbxpzYcYpkxmAABt/cMEwYJjpOzi4DvU=;
        b=pruf4jnbI5/8qKtIenjXWhRTHBY/klVpMbULQVM0JiQByfq0MDEKrrkw1yvrLtTTBd
         ek68HbxaLIBxz4r6XwbrKmZW/LV3i0f1Ixc9g7P40o1TlGnhSmMgWJ17vXxCNF5WtYXt
         GRBTWCfq3rPCZiTMEvIHJg3nLu5q/kXdN/m3/j6KgS8h93X0F17ObVHXxNCAfVHA0t8g
         1XmerlsFHz7lycKwGN8GHBDKhc3I/5BHWdU2i5ZPlegfWKBMuhbfcA2dFUOiBmDbRpBY
         g5e9Ixj1QBFIHZ7kwmWc375kAS+Wo8ufKQnLz4t/JIPm+S6TDIUgJb43lPZjiJZInbh0
         rT6g==
X-Gm-Message-State: AOAM5318eI7wme+E/LLafLER4PCs0ze7nzR3qsX7I01sVjs55xoS4NPq
        asa+R3fkzZRFMwCn9/GoIrWR8w==
X-Google-Smtp-Source: ABdhPJw6Gi1c8x1UncjT9lCiUx10vwnbD/Pg3UAg5be5feHed9gAiUjHM92kNwIVA1EbXjSf/I58hA==
X-Received: by 2002:a17:90a:7a8b:: with SMTP id q11mr4909804pjf.215.1616611958778;
        Wed, 24 Mar 2021 11:52:38 -0700 (PDT)
Received: from [2620:15c:17:3:4192:718f:4827:be5] ([2620:15c:17:3:4192:718f:4827:be5])
        by smtp.gmail.com with ESMTPSA id d19sm3054560pjs.55.2021.03.24.11.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 11:52:38 -0700 (PDT)
Date:   Wed, 24 Mar 2021 11:52:37 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Uladzislau Rezki <urezki@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 4/4] MAINTAINERS: Add Vlad Rezki as vmalloc
 maintainer
In-Reply-To: <20210324150518.2734402-5-willy@infradead.org>
Message-ID: <fb2923d-3eef-974-c56b-3d95a031c98d@google.com>
References: <20210324150518.2734402-1-willy@infradead.org> <20210324150518.2734402-5-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Mar 2021, Matthew Wilcox (Oracle) wrote:

> People should know to cc Vlad on vmalloc-related patches.  With this,
> get-maintainer.pl suggests:
> 
> Uladzislau Rezki <urezki@gmail.com> (maintainer:VMALLOC)
> Andrew Morton <akpm@linux-foundation.org> (maintainer:MEMORY MANAGEMENT)
> linux-mm@kvack.org (open list:VMALLOC)
> linux-kernel@vger.kernel.org (open list)
> 
> which looks appropriate to me.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  MAINTAINERS                   | 7 +++++++
>  arch/arm64/kernel/module.c    | 3 +--
>  arch/arm64/net/bpf_jit_comp.c | 3 +--
>  arch/parisc/kernel/module.c   | 5 ++---
>  arch/x86/hyperv/hv_init.c     | 3 +--
>  5 files changed, 12 insertions(+), 9 deletions(-)

Looks like we got some extra cleanups with this :)

> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8c44fd8fd85d..8b9cb5525cb1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19282,6 +19282,13 @@ S:	Maintained
>  F:	drivers/vlynq/vlynq.c
>  F:	include/linux/vlynq.h
>  
> +VMALLOC
> +M:	Uladzislau Rezki <urezki@gmail.com>

Should be 'M' or 'R'?  (Not sure if Vlad will be pushing patches or not.)

> +L:	linux-mm@kvack.org
> +S:	Maintained
> +F:	mm/vmalloc.c
> +F:	include/linux/vmalloc.h
> +
>  VME SUBSYSTEM
>  M:	Martyn Welch <martyn@welchs.me.uk>
>  M:	Manohar Vanga <manohar.vanga@gmail.com>
> diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
> index fa4186459927..5e31bc901631 100644
> --- a/arch/arm64/kernel/module.c
> +++ b/arch/arm64/kernel/module.c
> @@ -53,8 +53,7 @@ void *module_alloc(unsigned long size)
>  		 */
>  		p = __vmalloc_node_range(size, MODULE_ALIGN, module_alloc_base,
>  				module_alloc_base + SZ_2G, GFP_KERNEL,
> -				PAGE_KERNEL, 0, NUMA_NO_NODE,
> -				_RET_IP_);
> +				PAGE_KERNEL, 0, NUMA_NO_NODE, _RET_IP_);
>  
>  	if (p && (kasan_module_alloc(p, size) < 0)) {
>  		vfree(p);
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 8aca5bf74685..f3a6c1b49c4e 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -1133,8 +1133,7 @@ void *bpf_jit_alloc_exec(unsigned long size)
>  {
>  	return __vmalloc_node_range(size, PAGE_SIZE, BPF_JIT_REGION_START,
>  				    BPF_JIT_REGION_END, GFP_KERNEL,
> -				    PAGE_KERNEL, 0, NUMA_NO_NODE,
> -				    _RET_IP_);
> +				    PAGE_KERNEL, 0, NUMA_NO_NODE, _RET_IP_);
>  }
>  
>  void bpf_jit_free_exec(void *addr)
> diff --git a/arch/parisc/kernel/module.c b/arch/parisc/kernel/module.c
> index 320807f755a7..7181c4f99059 100644
> --- a/arch/parisc/kernel/module.c
> +++ b/arch/parisc/kernel/module.c
> @@ -198,9 +198,8 @@ void *module_alloc(unsigned long size)
>  	 * easier than trying to map the text, data, init_text and
>  	 * init_data correctly */
>  	return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
> -				    GFP_KERNEL,
> -				    PAGE_KERNEL_RWX, 0, NUMA_NO_NODE,
> -				    _RET_IP_);
> +				    GFP_KERNEL, PAGE_KERNEL_RWX, 0,
> +				    NUMA_NO_NODE, _RET_IP_);
>  }
>  
>  #ifndef CONFIG_64BIT
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 4866351282b0..a256a955d05f 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -427,8 +427,7 @@ void __init hyperv_init(void)
>  
>  	hv_hypercall_pg = __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START,
>  			VMALLOC_END, GFP_KERNEL, PAGE_KERNEL_ROX,
> -			VM_FLUSH_RESET_PERMS, NUMA_NO_NODE,
> -			_RET_IP_);
> +			VM_FLUSH_RESET_PERMS, NUMA_NO_NODE, _RET_IP_);
>  	if (hv_hypercall_pg == NULL) {
>  		wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
>  		goto remove_cpuhp_state;
> -- 
> 2.30.2
> 
> 
> 
