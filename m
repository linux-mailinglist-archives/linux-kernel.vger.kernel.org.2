Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83633398DB2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 17:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbhFBPDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 11:03:03 -0400
Received: from mail-io1-f41.google.com ([209.85.166.41]:40792 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbhFBPC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:02:59 -0400
Received: by mail-io1-f41.google.com with SMTP id e17so2841649iol.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 08:01:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XV3S2r7RfBVL2t6B+DjxdU3A89SJYVVG0oKOCJiH/mw=;
        b=kZZEHH+Dfm1Nk38AQ0hf+x+MpWCUeFWxHEzQJdalocrPs/iQqojOOyNmIMoGvdmxq4
         Rhfj81CIiv4wvEUQ1b2OVqtHOEKH6fd9/tJfgws9AyQIWIaL8wdaVlxZI4ShRTXDgM7c
         5k4wu7m8u0kKR56EnagEZVhMicMr8JWBcSbjEZRXhqT/uRKPufTIRj/v/wMxGSmC/BEP
         y3AZyi+fxIHSYdq5/EsMNAGF5++S6vGiBAYu0y8ttpr1+Vj8vuWUjOHxRzJU7f1+nbPi
         Bevs91HrjcY7Wpxk0HFXKVJJ8aPCRzEpbQP1iQqfJSKyYltYVxXmAUTPEPNPq8vdWBgN
         yKqQ==
X-Gm-Message-State: AOAM533ryyLUN8zEhIFlna8YxV1puQTi1KntKeOSIOWiQvUP0bEZ1feV
        qtj+/2W++N0e9Zb/Ycf2Wng=
X-Google-Smtp-Source: ABdhPJxtV4H9/gm6mEHZGR52+MUF18V76koPyWg7kZNbT91pxc9+P7CDTTIy+qtj2OlCJ16O9FKz9Q==
X-Received: by 2002:a02:970c:: with SMTP id x12mr30676547jai.21.1622646066391;
        Wed, 02 Jun 2021 08:01:06 -0700 (PDT)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id n9sm168429ilt.58.2021.06.02.08.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 08:01:05 -0700 (PDT)
Date:   Wed, 2 Jun 2021 15:01:04 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Bharata B Rao <bharata@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        aneesh.kumar@linux.ibm.com, tj@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, amakhalov@vmware.com, guro@fb.com,
        vbabka@suse.cz, srikar@linux.vnet.ibm.com, psampat@linux.ibm.com,
        ego@linux.vnet.ibm.com
Subject: Re: [RFC PATCH v0 0/3] CPU hotplug awareness in percpu allocator
Message-ID: <YLedMLpU0W1DjWko@google.com>
References: <20210601065147.53735-1-bharata@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601065147.53735-1-bharata@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Jun 01, 2021 at 12:21:44PM +0530, Bharata B Rao wrote:
> Hi,
> 
> This is an attempt to make the percpu allocator CPU hotplug aware.
> Currently the percpu allocator allocates memory for all the possible
> CPUs. This can lead to wastage of memory when possible number of CPUs
> is significantly higher than the number of online CPUs. This can be
> avoided if the percpu allocator were to allocate only for the online
> CPUs and extend the allocation for other CPUs as and when they become
> online. 
> 
> This early RFC work shows some good memory savings for a powerpc
> KVM guest that is booted with 16 online and 1024 possible CPUs.
> Here is the comparision of Percpu memory consumption from
> /proc/meminfo before and after creating 1000 memcgs.
> 
> 			W/o patch		W/ patch
> Before			1441792 kB		22528 kB
> After 1000 memcgs	4390912 kB		68608 kB
> 
> Note that the Percpu reporting in meminfo has been changed in
> the patchset to reflect the allocation for online CPUs only.
> 
> More details about the approach are present in the patch
> descriptions.
> 
> Bharata B Rao (3):
>   percpu: CPU hotplug support for alloc_percpu()
>   percpu: Limit percpu allocator to online cpus
>   percpu: Avoid using percpu ptrs of non-existing cpus
> 
>  fs/namespace.c             |   4 +-
>  include/linux/cpuhotplug.h |   2 +
>  include/linux/percpu.h     |  15 +++
>  kernel/cgroup/rstat.c      |  20 +++-
>  kernel/sched/cpuacct.c     |  10 +-
>  kernel/sched/psi.c         |  14 ++-
>  lib/percpu-refcount.c      |   4 +-
>  lib/percpu_counter.c       |   2 +-
>  mm/percpu-internal.h       |   9 ++
>  mm/percpu-vm.c             | 211 +++++++++++++++++++++++++++++++++-
>  mm/percpu.c                | 229 +++++++++++++++++++++++++++++++++++--
>  net/ipv4/fib_semantics.c   |   2 +-
>  net/ipv6/route.c           |   6 +-
>  13 files changed, 490 insertions(+), 38 deletions(-)
> 
> -- 
> 2.31.1
> 

I have thought about this for a day now and to be honest my thoughts
haven't really changed since the last discussion in [1].

I struggle here for a few reasons:
1. We're intertwining cpu and memory for hotplug.
  - What does it mean if we don't have enough memory?
  - How hard do we try to reclaim memory?
  - Partially allocated cpus? Do we free it all and try again?
2. We're now blocking the whole system on the percpu mutex which can
   cause terrible side effects. If there is a large amount of percpu
   memory already in use, this means we've accumulated a substantial
   number of callbacks.
3. While I did mention a callback approach would work. I'm not thrilled
   by the additional complexity of it as it can be error prone.

Beyond the above. I still don't believe it's the most well motivated
problem. I struggle to see a world where it makes sense to let someone
scale from 16 cpus to 1024. As in my mind you would also need to scale
memory to some degree too (not necessarily linearly but a 1024 core
machine with say like 16 gigs of ram would be pretty funny).

Would it be that bad to use cold migration points and eat a little bit
of overhead for what I understand to be a relatively uncommon use case?

[1] https://lore.kernel.org/linux-mm/8E7F3D98-CB68-4418-8E0E-7287E8273DA9@vmware.com/

Thanks,
Dennis
