Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADD1A430981
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 15:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343792AbhJQN70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 09:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242336AbhJQN7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 09:59:23 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141D9C061765
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 06:57:14 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id c4so6282254pgv.11
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 06:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vWrZOTdKFrgcy42SxMlc7V3lqy+UcNVETVqwTjA4s3c=;
        b=HdEOpTxRDxGvMKF0wIP/9e7i2s2ft+YDEmJALR4eU8vO/3rqHk5fGPLQUmews4SA+n
         2ujiMPXTa7jixotepFI8Fs0I43sIMGx8vDFu1Q9eRNb7afqQ6b7RY9PAGrrZoSjzStHC
         zOUEkoXe3Hczc0rcZ90+EC8VNB4ovJZPOxWmAeFWFPA/DohjaN3SmYmSZh5mbYv6FAwh
         jh7kjzXdXUNkah5qaCrtb7GDDmfdRLsZPcEFzbn3lH9efz1JC0EWxXjSRSqvo5wgJXYs
         zZzBBoAX3GGnmgjBUw9nhAc5SPm6Z3OHCf2NfYuIWaB+O44r9r0Am0rMsEJ3GyKhSvrf
         OElw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vWrZOTdKFrgcy42SxMlc7V3lqy+UcNVETVqwTjA4s3c=;
        b=dCFI3szpDdongRBL65QBGm2F6CbyfWGuMYrEYg0tYRDDfprEbfo++C10CglbuPhn7g
         8tvIKptRjS3fXvdI0DkpfkZrAC2jGB5sCo97+oRA/pXMbS7SASMYC2xseRSIc1zp58Xa
         l5cMJ6uHGdWRXJsZJMLEG+S54ZQEeSEka1Y0v3dA/E0DJQpGYIqRZGRrE0/eXv8kNitT
         av9Lrq1ZnBIDWVOvLoq3/+hrf6P0AT+4BSTOkG/2x1o60Uztj3tRNxGule2aO5rPnYmw
         q3yqUt/mdDELpC/sG/uFgZHi3ZkcK6d+4VY2M1laRrqOF3vJ+rrm1qzkin/yC3SPeJ6Z
         YHaQ==
X-Gm-Message-State: AOAM531lAirXnZII/fU8sKF0vE7EkftpQfjvNEj2F/03oqASd/ahRQfK
        Lu3oiFJ7dsyaiQpAPKgCy5o=
X-Google-Smtp-Source: ABdhPJxSi59NOS28ivaSgsB9AKrEaVSN3sQnOat5Gb+n0T7nNPOinvtWMYcXQOHT7a3l9WcfJFZJmA==
X-Received: by 2002:a63:7a08:: with SMTP id v8mr18219771pgc.63.1634479033449;
        Sun, 17 Oct 2021 06:57:13 -0700 (PDT)
Received: from kvm.asia-northeast3-a.c.our-ratio-313919.internal (24.151.64.34.bc.googleusercontent.com. [34.64.151.24])
        by smtp.gmail.com with ESMTPSA id a21sm9991790pju.57.2021.10.17.06.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 06:57:13 -0700 (PDT)
Date:   Sun, 17 Oct 2021 13:57:08 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: Do we really need SLOB nowdays?
Message-ID: <20211017135708.GA8442@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
References: <20211017042852.GA3050@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
 <20211017133618.GA7989@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211017133618.GA7989@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 17, 2021 at 01:36:18PM +0000, Hyeonggon Yoo wrote:
> On Sun, Oct 17, 2021 at 04:28:52AM +0000, Hyeonggon Yoo wrote:
> > I've been reading SLUB/SLOB code for a while. SLUB recently became
> > real time compatible by reducing its locking area.
> > 
> > for now, SLUB is the only slab allocator for PREEMPT_RT because
> > it works better than SLAB on RT and SLOB uses non-deterministic method,
> > sequential fit.
> > 
> > But memory usage of SLUB is too high for systems with low memory.
> > So In my local repository I made SLOB to use segregated free list
> > method, which is more more deterministic, to provide bounded latency.
> > 
> > This can be done by managing list of partial pages globally
> > for every power of two sizes (8, 16, 32, ..., PAGE_SIZE) per NUMA nodes.
> > minimal allocation size is size of pointers to keep pointer of next free object
> > like SLUB.
> > 
> > By making objects in same page to have same size, there's no
> > need to iterate free blocks in a page. (Also iterating pages isn't needed)
> > 
> > Some cleanups and more tests (especially with NUMA/RT configs) needed,
> > but want to hear your opinion about the idea. Did not test on RT yet.
> > 
> > Below is result of benchmarks and memory usage. (on !RT)
> > with 13% increase in memory usage, it's nine times faster and
> > bounded fragmentation, and importantly provides predictable execution time.
> > 
> 
> Hello linux-mm, I improved it and it uses lower memory
> and 9x~13x faster than original SLOB. it shows much less fragmentation
> after hackbench.
> 
> Rather than managing global freelist that has power of 2 sizes,
> I made a kmem_cache to manage its own freelist (for each NUMA nodes) and
> Added support for slab merging. So It quite looks like a lightweight SLUB now.
> 
> I'll send rfc patch after some testing and code cleaning.
> 
> I think it is more RT-friendly becuase it's uses more deterministic
> algorithm (But lock is still shared among cpus). Any opinions for RT?

Hi there. after some thinking, I got a new question:
If a lightweight SLUB is better than SLOB,
Do we really need SLOB nowdays?

And one more question:
    in Christoph's presentation [1], it says SLOB uses
    300 KB of memory. but on my system it uses almost 8000 KB.
    what's is differences?

[1] https://events.static.linuxfound.org/sites/events/files/slides/slaballocators.pdf

SLUB without cpu partials:

memory usage:
   after boot:
       Slab:               8672 kB
   after hackbench:
       Slab:               9540 kB

Performance counter stats for 'hackbench -g 4 -l 10000':
          48463.05 msec cpu-clock                 #    1.995 CPUs utilized
            944154      context-switches          #   19.482 K/sec
              8161      cpu-migrations            #  168.396 /sec
              4117      page-faults               #   84.951 /sec
       52570808507      cycles                    #    1.085 GHz
       65083778667      instructions              #    1.24  insn per cycle
         234990576      branch-misses
       23628671709      cache-references          #  487.561 M/sec
         739599271      cache-misses              #    3.130 % of all cache refs

      24.287392120 seconds time elapsed

       1.509198000 seconds user
      46.942748000 seconds sys

> current SLOB:
>     memory usage:
>         after boot:
>             Slab:               7908 kB
>         after hackbench:
>             Slab:               8544 kB
>   
>     Time: 189.947
>     Performance counter stats for 'hackbench -g 4 -l 10000':
>          379413.20 msec cpu-clock                 #    1.997 CPUs utilized          
>            8818226      context-switches          #   23.242 K/sec                  
>             375186      cpu-migrations            #  988.859 /sec                   
>               3954      page-faults               #   10.421 /sec                   
>       269923095290      cycles                    #    0.711 GHz                    
>       212341582012      instructions              #    0.79  insn per cycle         
>         2361087153      branch-misses                                               
>        58222839688      cache-references          #  153.455 M/sec                  
>         6786521959      cache-misses              #   11.656 % of all cache refs    
> 
>      190.002062273 seconds time elapsed
> 
>        3.486150000 seconds user
>      375.599495000 seconds sys
> 
> SLOB with segregated list + slab merging:
>     memory usage:
>        after boot:
>            Slab:               7560 kB
>         after hackbench:
>            Slab:               7836 kB        
> 
> hackbench:
>     Time: 20.780
>     Performance counter stats for 'hackbench -g 4 -l 10000':
>           41509.79 msec cpu-clock                 #    1.996 CPUs utilized          
>             630032      context-switches          #   15.178 K/sec                  
>               8287      cpu-migrations            #  199.640 /sec                   
>               4036      page-faults               #   97.230 /sec                   
>        57477161020      cycles                    #    1.385 GHz                    
>        62775453932      instructions              #    1.09  insn per cycle         
>          164902523      branch-misses                                               
>        22559952993      cache-references          #  543.485 M/sec                  
>          832404011      cache-misses              #    3.690 % of all cache refs    
> 
>       20.791893590 seconds time elapsed
> 
>        1.423282000 seconds user
>       40.072449000 seconds sys
> -
> Thanks,
> Hyeonggon
