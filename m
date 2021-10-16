Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2B9B430275
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 13:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234239AbhJPLkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 07:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbhJPLkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 07:40:51 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFF2C061570
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 04:38:43 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id y1so8052225plk.10
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 04:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QP2TA6Ec7uzA0cBpQjCQDWFiNkJrfHQ7sVVyDgvpxIg=;
        b=GDySYesuVM9VmsnRM9hFXW2rzdq3Ncz/Zp0lALN0S2PlX7xQzbFNuuF8WEpXO28wi9
         o6FpN76Y/qc9eb1Lpzqzv536vU3gadPE4PJcUjA0dUAy/wRC0kizoZ2GZKuaiLysBgnu
         hs4cTAnfHN2dJzk7zUXFcBOpNjWEF0okfrf5dqeyyZvn5TdXJ+prIAS1NctHE87D3/2i
         J5OGzt4T9i9bVcprxYFNBktAsSprPNbgPTxQwb+9pOvmTb3SqjHDTQeyeB05lBgL/mFv
         TeNSWD9JepaMHIQCliojg1zt05egOKiKSRBc7yMzXOilptVSRuwzJFeXcKVeN7vfE3Y2
         nJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QP2TA6Ec7uzA0cBpQjCQDWFiNkJrfHQ7sVVyDgvpxIg=;
        b=D7JAdxNvOcUoKlBlRl5rWoFFiw5qxg39B70yX4kIgGo1+4tzCLv+GxYnw72qtmCmBM
         Q6GV5fUnk46JubJ2QowF9Zw4l/QVxtB/yWYPf1hes+aGbAP1YkB91kXdhF4yGg6KsTpi
         qvn0VFwrAsnO14g+4PFWKPt5E9c8LHDOwxREm5/VLZIj8xaC/A4Xi0jA8bPjyyy6HdGE
         JfxiRU/+wKSsOWj33w5RgueQDtw5GpoiUnL865cfwf7JbXnbYP4Le1q9ACB5gcg/mdju
         eyHWu/YRB6T5fQu+Q8Ir7HZlKLTF02qx3ZJyrPQce7xgyQu9/CXZu7iM7NoSJQvXrE1n
         Kbfg==
X-Gm-Message-State: AOAM533RdPilWTV4KytfxNPPm2t+21TRy3iIB0KjO1NRqInoNRCG8+tS
        Yo44m1w0Ha5GZ8mqw0egsLA=
X-Google-Smtp-Source: ABdhPJyMF9+IkgTUuvkWIRJ1QwGTbW6KISxDkKVJR+kYIZ6txwG4OgJi2uLEdeiBmerSZsiF5fiPBQ==
X-Received: by 2002:a17:90a:4a04:: with SMTP id e4mr19756891pjh.51.1634384322816;
        Sat, 16 Oct 2021 04:38:42 -0700 (PDT)
Received: from kvm.asia-northeast3-a.c.our-ratio-313919.internal (24.151.64.34.bc.googleusercontent.com. [34.64.151.24])
        by smtp.gmail.com with ESMTPSA id g11sm8048610pfc.194.2021.10.16.04.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 04:38:42 -0700 (PDT)
Date:   Sat, 16 Oct 2021 11:38:38 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     linux-mm@kvack.org
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm, slub: Use prefetchw instead of prefetch
Message-ID: <20211016113838.GA12841@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
References: <20211011144331.70084-1-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211011144331.70084-1-42.hyeyoo@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, can you please update the patch to v2?

On Mon, Oct 11, 2021 at 02:43:31PM +0000, Hyeonggon Yoo wrote:
> commit 0ad9500e16fe ("slub: prefetch next freelist pointer in
> slab_alloc()") introduced prefetch_freepointer() because when other cpu(s)
> freed objects into a page that current cpu owns, the freelist link is
> hot on cpu(s) which freed objects and possibly very cold on current cpu.
> 
> But if freelist link chain is hot on cpu(s) which freed objects,
> it's better to invalidate that chain because they're not going to access
> again within a short time.
> 
> So use prefetchw instead of prefetch. On supported architectures like x86
> and arm, it invalidates other copied instances of a cache line when
> prefetching it.
> 
> Before:
> 
> Time: 91.677
> 
>  Performance counter stats for 'hackbench -g 100 -l 10000':
>         1462938.07 msec cpu-clock                 #   15.908 CPUs utilized
>           18072550      context-switches          #   12.354 K/sec
>            1018814      cpu-migrations            #  696.416 /sec
>             104558      page-faults               #   71.471 /sec
>      1580035699271      cycles                    #    1.080 GHz                      (54.51%)
>      2003670016013      instructions              #    1.27  insn per cycle           (54.31%)
>         5702204863      branch-misses                                                 (54.28%)
>       643368500985      cache-references          #  439.778 M/sec                    (54.26%)
>        18475582235      cache-misses              #    2.872 % of all cache refs      (54.28%)
>       642206796636      L1-dcache-loads           #  438.984 M/sec                    (46.87%)
>        18215813147      L1-dcache-load-misses     #    2.84% of all L1-dcache accesses  (46.83%)
>       653842996501      dTLB-loads                #  446.938 M/sec                    (46.63%)
>         3227179675      dTLB-load-misses          #    0.49% of all dTLB cache accesses  (46.85%)
>       537531951350      iTLB-loads                #  367.433 M/sec                    (54.33%)
>          114750630      iTLB-load-misses          #    0.02% of all iTLB cache accesses  (54.37%)
>       630135543177      L1-icache-loads           #  430.733 M/sec                    (46.80%)
>        22923237620      L1-icache-load-misses     #    3.64% of all L1-icache accesses  (46.76%)
> 
>       91.964452802 seconds time elapsed
> 
>       43.416742000 seconds user
>     1422.441123000 seconds sys
> 
> After:
> 
> Time: 90.220
> 
>  Performance counter stats for 'hackbench -g 100 -l 10000':
>         1437418.48 msec cpu-clock                 #   15.880 CPUs utilized
>           17694068      context-switches          #   12.310 K/sec
>             958257      cpu-migrations            #  666.651 /sec
>             100604      page-faults               #   69.989 /sec
>      1583259429428      cycles                    #    1.101 GHz                      (54.57%)
>      2004002484935      instructions              #    1.27  insn per cycle           (54.37%)
>         5594202389      branch-misses                                                 (54.36%)
>       643113574524      cache-references          #  447.409 M/sec                    (54.39%)
>        18233791870      cache-misses              #    2.835 % of all cache refs      (54.37%)
>       640205852062      L1-dcache-loads           #  445.386 M/sec                    (46.75%)
>        17968160377      L1-dcache-load-misses     #    2.81% of all L1-dcache accesses  (46.79%)
>       651747432274      dTLB-loads                #  453.415 M/sec                    (46.59%)
>         3127124271      dTLB-load-misses          #    0.48% of all dTLB cache accesses  (46.75%)
>       535395273064      iTLB-loads                #  372.470 M/sec                    (54.38%)
>          113500056      iTLB-load-misses          #    0.02% of all iTLB cache accesses  (54.35%)
>       628871845924      L1-icache-loads           #  437.501 M/sec                    (46.80%)
>        22585641203      L1-icache-load-misses     #    3.59% of all L1-icache accesses  (46.79%)
> 
>       90.514819303 seconds time elapsed
> 
>       43.877656000 seconds user
>     1397.176001000 seconds sys
> 
> Link: https://lkml.org/lkml/2021/10/8/598 
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> ---
>  mm/slub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 3d2025f7163b..ce3d8b11215c 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -354,7 +354,7 @@ static inline void *get_freepointer(struct kmem_cache *s, void *object)
>  
>  static void prefetch_freepointer(const struct kmem_cache *s, void *object)
>  {
> -	prefetch(object + s->offset);
> +	prefetchw(object + s->offset);
>  }
>  
>  static inline void *get_freepointer_safe(struct kmem_cache *s, void *object)
> -- 
> 2.27.0
> 
