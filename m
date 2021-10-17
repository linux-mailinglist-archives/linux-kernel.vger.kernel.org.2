Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2648430964
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 15:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343741AbhJQNie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 09:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242392AbhJQNid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 09:38:33 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D519C061765
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 06:36:23 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id oa12-20020a17090b1bcc00b0019f715462a8so10697393pjb.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 06:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZTG0rQxetILHRfa9qDwDBnOP2er8Zp8xGRtK4Z0zndo=;
        b=IUVMlCIy4hEiGx6lOHG+uKZsi00lfJd1em5Tu4rHxxu/5jlK0aosfpxArSiONijhct
         eBvT2MBa77OiTlxxyjqON8tLolwJbN3k2DU+kty6cP2kumVBe/GqXZ5CJFjlUJtf8Eow
         B8cei6TvQz5Y/bxXk6nOtOlwvIimCqmjnFF2EL10pxxzM5eSmlBvo2zu8yG/ZWDwvsUQ
         MVSMeRtyvAAppLfbR28Imas0bpQpRwQXAbFH6PK/+0rOlHWFR0UmCPcHUshDm2Mj9MrW
         o+ofkTeDb7fnoLrnJ+K50oE79OtEGaUgeTxQvkg8wnerHXeBaZiYK6wHGLp5OHUzWKrT
         ItIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZTG0rQxetILHRfa9qDwDBnOP2er8Zp8xGRtK4Z0zndo=;
        b=lEW3rkSd98uT7DP9COmh/MiuNafGmjHjX7BeNyJ9sUV3d/Q4o7RK9pfL1ziKYawLnB
         ZqZd3Z4aBfUpn2AnQn+MLHPilA70zs+Iq3DJsop/rSK4BE7WJ6Seq/bLkLQR81db5+lp
         +ermXavRjuuvg2r84FRVaNPGuv7EtY2h1CfZ3Oy+AUMwfemTGgpm7LH+73rrgXs+kPFl
         bN/64T/sZlEn52Fa8++4Z3hjXE+3NBch40Gp1PX2aXdQ1GelGjyDIGZN5o5cuvztUkVm
         HZHhTGxxI4ODKJ2fnDRxmG/cjrj0MdBgGu4HHWKzvaRfK/LoawW/yHxQBPJaf9X4NjOv
         1roA==
X-Gm-Message-State: AOAM531fo56Iim13fYjyH1tLdgmK1NRSRm/bKYtBfebavR7gadC/MAWB
        9lJjjVVXAX7qbpFGkG7Mh5c=
X-Google-Smtp-Source: ABdhPJzUPugXC1TCZ5VIvmczslzq7tevs50JeeMWhb65kRxnzzPeefnNWde4loN1mtjfOIOMXoJheA==
X-Received: by 2002:a17:90a:a386:: with SMTP id x6mr26713944pjp.56.1634477782950;
        Sun, 17 Oct 2021 06:36:22 -0700 (PDT)
Received: from kvm.asia-northeast3-a.c.our-ratio-313919.internal (24.151.64.34.bc.googleusercontent.com. [34.64.151.24])
        by smtp.gmail.com with ESMTPSA id i124sm10524072pfc.153.2021.10.17.06.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 06:36:22 -0700 (PDT)
Date:   Sun, 17 Oct 2021 13:36:18 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: segregated list + slab merging is much better than original SLOB
Message-ID: <20211017133618.GA7989@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
References: <20211017042852.GA3050@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211017042852.GA3050@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 17, 2021 at 04:28:52AM +0000, Hyeonggon Yoo wrote:
> I've been reading SLUB/SLOB code for a while. SLUB recently became
> real time compatible by reducing its locking area.
> 
> for now, SLUB is the only slab allocator for PREEMPT_RT because
> it works better than SLAB on RT and SLOB uses non-deterministic method,
> sequential fit.
> 
> But memory usage of SLUB is too high for systems with low memory.
> So In my local repository I made SLOB to use segregated free list
> method, which is more more deterministic, to provide bounded latency.
> 
> This can be done by managing list of partial pages globally
> for every power of two sizes (8, 16, 32, ..., PAGE_SIZE) per NUMA nodes.
> minimal allocation size is size of pointers to keep pointer of next free object
> like SLUB.
> 
> By making objects in same page to have same size, there's no
> need to iterate free blocks in a page. (Also iterating pages isn't needed)
> 
> Some cleanups and more tests (especially with NUMA/RT configs) needed,
> but want to hear your opinion about the idea. Did not test on RT yet.
> 
> Below is result of benchmarks and memory usage. (on !RT)
> with 13% increase in memory usage, it's nine times faster and
> bounded fragmentation, and importantly provides predictable execution time.
> 

Hello linux-mm, I improved it and it uses lower memory
and 9x~13x faster than original SLOB. it shows much less fragmentation
after hackbench.

Rather than managing global freelist that has power of 2 sizes,
I made a kmem_cache to manage its own freelist (for each NUMA nodes) and
Added support for slab merging. So It quite looks like a lightweight SLUB now.

I'll send rfc patch after some testing and code cleaning.

I think it is more RT-friendly becuase it's uses more deterministic
algorithm (But lock is still shared among cpus). Any opinions for RT?

current SLOB:
    memory usage:
        after boot:
            Slab:               7908 kB
        after hackbench:
            Slab:               8544 kB
  
    Time: 189.947
    Performance counter stats for 'hackbench -g 4 -l 10000':
         379413.20 msec cpu-clock                 #    1.997 CPUs utilized          
           8818226      context-switches          #   23.242 K/sec                  
            375186      cpu-migrations            #  988.859 /sec                   
              3954      page-faults               #   10.421 /sec                   
      269923095290      cycles                    #    0.711 GHz                    
      212341582012      instructions              #    0.79  insn per cycle         
        2361087153      branch-misses                                               
       58222839688      cache-references          #  153.455 M/sec                  
        6786521959      cache-misses              #   11.656 % of all cache refs    

     190.002062273 seconds time elapsed

       3.486150000 seconds user
     375.599495000 seconds sys

SLOB with segregated list + slab merging:
    memory usage:
       after boot:
           Slab:               7560 kB
        after hackbench:
           Slab:               7836 kB        

hackbench:
    Time: 20.780
    Performance counter stats for 'hackbench -g 4 -l 10000':
          41509.79 msec cpu-clock                 #    1.996 CPUs utilized          
            630032      context-switches          #   15.178 K/sec                  
              8287      cpu-migrations            #  199.640 /sec                   
              4036      page-faults               #   97.230 /sec                   
       57477161020      cycles                    #    1.385 GHz                    
       62775453932      instructions              #    1.09  insn per cycle         
         164902523      branch-misses                                               
       22559952993      cache-references          #  543.485 M/sec                  
         832404011      cache-misses              #    3.690 % of all cache refs    

      20.791893590 seconds time elapsed

       1.423282000 seconds user
      40.072449000 seconds sys
-
Thanks,
Hyeonggon
