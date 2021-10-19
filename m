Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76A45432F0A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 09:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234468AbhJSHOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 03:14:10 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:38360 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234459AbhJSHOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 03:14:08 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6391C1FD8D;
        Tue, 19 Oct 2021 07:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634627515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UefmwQIGLvsZBjtrKg1+QbB5tD5XPzyGVrbS0wlWjHU=;
        b=deEwLGdIGCFDic17x8oLHhHXzi6BsTun2ooHaqgHjOWFbGVC1IeYwA6DoeUDww+iRvxsyV
        Qg53DUB51FRsEltYKJWZrpdDhXP5mgh1PnHNFqtA9hP9O2D2bW8nqsGHFDn3xPGfbapIsi
        oIvjSOeMB0/dyoJw1MfH2GHDQO0R4QE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634627515;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UefmwQIGLvsZBjtrKg1+QbB5tD5XPzyGVrbS0wlWjHU=;
        b=nDO4+qNKx1AP9FuGiTXihCqvUtdAVU8bQxF01VfbyBwIRFw7oWBpUDrizNkEIuaNpP5819
        Vu3BffWHtzGJhsCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 44DA413F09;
        Tue, 19 Oct 2021 07:11:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id D2oYELtvbmFcaAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 19 Oct 2021 07:11:55 +0000
Message-ID: <bf496398-d42f-05dc-927d-b4c601bd2d19@suse.cz>
Date:   Tue, 19 Oct 2021 09:11:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2] mm, slub: Use prefetchw instead of prefetch
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20211011144331.70084-1-42.hyeyoo@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211011144331.70084-1-42.hyeyoo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/21 16:43, Hyeonggon Yoo wrote:
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

Wouldn't expect such noticeable difference. Maybe it would diminish when
repeating and taking average. But guess it's at least not worse with
prefetchw, so...

> Link: https://lkml.org/lkml/2021/10/8/598 
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

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
> 

