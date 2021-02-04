Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAA130EF52
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 10:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235085AbhBDJLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 04:11:03 -0500
Received: from gentwo.org ([3.19.106.255]:46368 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234992AbhBDJIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 04:08:25 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id 1185A3F4C8; Thu,  4 Feb 2021 09:07:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 0EFAB3E974;
        Thu,  4 Feb 2021 09:07:27 +0000 (UTC)
Date:   Thu, 4 Feb 2021 09:07:27 +0000 (UTC)
From:   Christoph Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Vincent Guittot <vincent.guittot@linaro.org>
cc:     Bharata B Rao <bharata@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, guro@fb.com,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        aneesh.kumar@linux.ibm.com, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>
Subject: Re: [RFC PATCH v0] mm/slub: Let number of online CPUs determine the
 slub page order
In-Reply-To: <CAKfTPtBLnig+M0pjoYEYtDbVLT=J5fkn9__RrsiTrUB_51XcZw@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2102040851170.76039@www.lameter.com>
References: <alpine.DEB.2.22.394.2101210959060.100764@www.lameter.com> <d7fb9425-9a62-c7b8-604d-5828d7e6b1da@suse.cz> <CAKfTPtDy3Ynk2nGCTWiXjz9-4vuSHB3pGuafoTUBPFNO1ac3PA@mail.gmail.com> <786571e7-b9a2-4cdb-06d5-aa4a4b439b7e@suse.cz> <20210123051607.GC2587010@in.ibm.com>
 <CAKfTPtAjyVmS5VYvU6DBxg4-JEo5bdmWbngf-03YsY18cmWv_g@mail.gmail.com> <66652406-25e4-a9e7-45a1-8ad14d2e8a36@suse.cz> <20210126230305.GD30941@willie-the-truck> <alpine.DEB.2.22.394.2101270907260.673600@www.lameter.com> <81424d71-c479-4c4a-de14-0a9b3f636e23@suse.cz>
 <20210203111009.GB2869122@in.ibm.com> <CAKfTPtBLnig+M0pjoYEYtDbVLT=J5fkn9__RrsiTrUB_51XcZw@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Feb 2021, Vincent Guittot wrote:

> > So what is preferrable here now? Above or other quick fix or reverting
> > the original commit?
>
> I'm fine with whatever the solution as long as we can use keep using
> nr_cpu_ids when other values like num_present_cpus, don't reflect
> correctly the system

AFAICT they are correctly reflecting the current state of the system.

The problem here is the bringup of the system and the tuning therefor.

One additional thing that may help: The slab caches can work in a degraded
mode where no fastpath allocations can occur. That mode is used primarily
for debugging but maybe that mode can also help during bootstrap to avoid
having to deal with the per cpu data and so on.

In degraded mode SLUB will take a lock for each operation on an object.

In this mode the following is true

  kmem_cache_cpu->page == NULL
  kmem_cache_cpu->freelist == NULL

   kmem_cache_debug(s) == true

So if you define a new debug mode and include it in SLAB_DEBUG_FLAGS then
you can force SLUB to fallback to operations where a lock is taken and
where slab allocation can be stopped. This may be ok for bring up.

The debug flags are also tied to some wizardry that can patch the code at
runtime to optimize for debubgging or fast operations. You would tie into
that one as well. Start in debug mode by default and switch to fast
operations after all processors are up.


