Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73E54428ACB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 12:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235868AbhJKKfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 06:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235780AbhJKKfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 06:35:07 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEFAC061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 03:33:07 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id d13-20020a17090ad3cd00b0019e746f7bd4so14427633pjw.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 03:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UPv5eAqFoWjAX3CQLmZH+52mh1iKuMebvF9Fe98WlZc=;
        b=N05ICMGlMILAHhelFs5f0qv0tS7SVcfT4Qp+ZMWT7Scmb0Ffr6l7bB5nXhWKa3FmKL
         RsJwuvQnAHUMjC04sGCXDdCga3Dq5pA74mPlR0+N/rGH6JuDNj+6dRTVwdxKn9LEYIAt
         3PNCGD6WIaZGY1+almlKrXLdxncwZa6LDhVO3jGSWOjQlZKl/gHwqHvwN3me9EF06HSO
         hxi5dS9Tgcamg6GICQjZh1qyxFNRo1arDS6g5rnwb30XTjrib4IfE0h7RsYuG90vlygs
         SvNRnxHJ+Z3HW8/eOyeJxAakw/qHbY1+P/X6ohVKOmlOY+5NTobDNkt1GmBI1jclo7UC
         B2bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UPv5eAqFoWjAX3CQLmZH+52mh1iKuMebvF9Fe98WlZc=;
        b=tn1FRPjuIiAqcl0puesQb1D0x1wc4ZLiHltMSXCeb5B4KW0o7zh0p7bylqXX3+Rg4N
         ea0cy8CiLTPBNCFUS5uMjkg8OWcN/ZPnuOerRbC7xb/TsnUjYP9QzhS65Bt7iQ/lF/7G
         ZkJlAtydPDq1mLeHms09S5z55FmKdoGRdhZy5MXVlKDZdEbjXpMGLq9a8chZiDbCurnV
         Hyi9t/OwtKlEZLYLArMcXJRP4/1bxlbwOLd1w2e5RIdIPX/nlb5sE3VeC2gpdVrrv5ky
         x7wTNCPjT/C8MSDScabamMQpgABxuFioozkIB9szeo0P/hU+938otp/co+DyzmFKoAoy
         SXUQ==
X-Gm-Message-State: AOAM530AhhS21bmZwzAfRrqgdSWiL6P5oEiTvB4aDzxnZwx23dH5WAdn
        ixvCge3oUPl9XW1ijYyf1sHyXSkhwUo=
X-Google-Smtp-Source: ABdhPJzGJV4mQ7sjRnzVuhVBnZ7Zt8sIpXQMjvqbspsqfeZEY4/gTIrnm1agBvCJFLRtAqOLtSTgjQ==
X-Received: by 2002:a17:90b:4b4d:: with SMTP id mi13mr28888307pjb.187.1633948386725;
        Mon, 11 Oct 2021 03:33:06 -0700 (PDT)
Received: from kvm.asia-northeast3-a.c.our-ratio-313919.internal (24.151.64.34.bc.googleusercontent.com. [34.64.151.24])
        by smtp.gmail.com with ESMTPSA id p3sm7323068pfb.205.2021.10.11.03.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 03:33:06 -0700 (PDT)
Date:   Mon, 11 Oct 2021 10:33:02 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     David Rientjes <rientjes@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Perf and Hackbench results on my machine
Message-ID: <20211011103302.GA65713@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
References: <20211008133602.4963-1-42.hyeyoo@gmail.com>
 <30a76d87-e0af-3eec-d095-d87e898b31cf@google.com>
 <904b6e72-cc2e-2e4d-5601-dacab734bf15@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <904b6e72-cc2e-2e4d-5601-dacab734bf15@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Vlastimil.

On Mon, Oct 11, 2021 at 09:21:01AM +0200, Vlastimil Babka wrote:
> On 10/11/21 00:49, David Rientjes wrote:
> > On Fri, 8 Oct 2021, Hyeonggon Yoo wrote:
> > 
> >> It's certain that an object will be not only read, but also
> >> written after allocation.
> >> 
> > 
> > Why is it certain?  I think perhaps what you meant to say is that if we 
> > are doing any prefetching here, then access will benefit from prefetchw 
> > instead of prefetch.  But it's not "certain" that allocated memory will be 
> > accessed at all.
> 
> I think the primary reason there's a prefetch is freelist traversal. The
> cacheline we prefetch will be read during the next allocation, so if we
> expect there to be one soon, prefetch might help.

I agree that.

> That the freepointer is
> part of object itself and thus the cache line will be probably accessed also
> after the allocation, is secondary.

Right. it depends on cache line size and whether first cache line of an
object is frequently accessed or not.

> Yeah this might help some workloads, but
> perhaps hurt others - these things might look obvious in theory but be
> rather unpredictable in practice. At least some hackbench results would help...
>

Below is my measurement. it seems prefetch(w) is not making things worse
at least on hackbench.

Measured on 16 CPUs (ARM64) / 16G RAM
Without prefetch:

Time: 91.989
 Performance counter stats for 'hackbench -g 100 -l 10000':
        1467926.03 msec cpu-clock                 #   15.907 CPUs utilized          
          17782076      context-switches          #   12.114 K/sec                  
            957523      cpu-migrations            #  652.296 /sec                   
            104561      page-faults               #   71.230 /sec                   
     1622117569931      cycles                    #    1.105 GHz                      (54.54%)
     2002981132267      instructions              #    1.23  insn per cycle           (54.32%)
        5600876429      branch-misses                                                 (54.28%)
      642657442307      cache-references          #  437.800 M/sec                    (54.27%)
       19404890844      cache-misses              #    3.019 % of all cache refs      (54.28%)
      640413686039      L1-dcache-loads           #  436.271 M/sec                    (46.85%)
       19110650580      L1-dcache-load-misses     #    2.98% of all L1-dcache accesses  (46.83%)
      651556334841      dTLB-loads                #  443.862 M/sec                    (46.63%)
        3193647402      dTLB-load-misses          #    0.49% of all dTLB cache accesses  (46.84%)
      538927659684      iTLB-loads                #  367.135 M/sec                    (54.31%)
         118503839      iTLB-load-misses          #    0.02% of all iTLB cache accesses  (54.35%)
      625750168840      L1-icache-loads           #  426.282 M/sec                    (46.80%)
       24348083282      L1-icache-load-misses     #    3.89% of all L1-icache accesses  (46.78%)

      92.284351157 seconds time elapsed

      44.524693000 seconds user
    1426.214006000 seconds sys

With prefetch:

Time: 91.677

 Performance counter stats for 'hackbench -g 100 -l 10000':
        1462938.07 msec cpu-clock                 #   15.908 CPUs utilized          
          18072550      context-switches          #   12.354 K/sec                  
           1018814      cpu-migrations            #  696.416 /sec                   
            104558      page-faults               #   71.471 /sec                   
     2003670016013      instructions              #    1.27  insn per cycle           (54.31%)
        5702204863      branch-misses                                                 (54.28%)
      643368500985      cache-references          #  439.778 M/sec                    (54.26%)
       18475582235      cache-misses              #    2.872 % of all cache refs      (54.28%)
      642206796636      L1-dcache-loads           #  438.984 M/sec                    (46.87%)
       18215813147      L1-dcache-load-misses     #    2.84% of all L1-dcache accesses  (46.83%)
      653842996501      dTLB-loads                #  446.938 M/sec                    (46.63%)
        3227179675      dTLB-load-misses          #    0.49% of all dTLB cache accesses  (46.85%)
      537531951350      iTLB-loads                #  367.433 M/sec                    (54.33%)
         114750630      iTLB-load-misses          #    0.02% of all iTLB cache accesses  (54.37%)
      630135543177      L1-icache-loads           #  430.733 M/sec                    (46.80%)
       22923237620      L1-icache-load-misses     #    3.64% of all L1-icache accesses  (46.76%)
 
      91.964452802 seconds time elapsed

      43.416742000 seconds user
    1422.441123000 seconds sys
	
With prefetchw:

Time: 90.220

 Performance counter stats for 'hackbench -g 100 -l 10000':
        1437418.48 msec cpu-clock                 #   15.880 CPUs utilized          
          17694068      context-switches          #   12.310 K/sec                  
            958257      cpu-migrations            #  666.651 /sec                   
            100604      page-faults               #   69.989 /sec                   
     1583259429428      cycles                    #    1.101 GHz                      (54.57%)
     2004002484935      instructions              #    1.27  insn per cycle           (54.37%)
        5594202389      branch-misses                                                 (54.36%)
      643113574524      cache-references          #  447.409 M/sec                    (54.39%)
       18233791870      cache-misses              #    2.835 % of all cache refs      (54.37%)
      640205852062      L1-dcache-loads           #  445.386 M/sec                    (46.75%)
       17968160377      L1-dcache-load-misses     #    2.81% of all L1-dcache accesses  (46.79%)
      651747432274      dTLB-loads                #  453.415 M/sec                    (46.59%)
        3127124271      dTLB-load-misses          #    0.48% of all dTLB cache accesses  (46.75%)
      535395273064      iTLB-loads                #  372.470 M/sec                    (54.38%)
         113500056      iTLB-load-misses          #    0.02% of all iTLB cache accesses  (54.35%)
      628871845924      L1-icache-loads           #  437.501 M/sec                    (46.80%)
       22585641203      L1-icache-load-misses     #    3.59% of all L1-icache accesses  (46.79%)
 
      90.514819303 seconds time elapsed
 
      43.877656000 seconds user
    1397.176001000 seconds sys

Thanks,
Hyeonggon
