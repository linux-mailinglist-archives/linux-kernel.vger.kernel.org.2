Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC24E305699
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 10:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235037AbhA0JO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 04:14:59 -0500
Received: from gentwo.org ([3.19.106.255]:54266 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231405AbhA0JLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 04:11:09 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id 99AAC3F55A; Wed, 27 Jan 2021 09:10:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 960993F05F;
        Wed, 27 Jan 2021 09:10:14 +0000 (UTC)
Date:   Wed, 27 Jan 2021 09:10:14 +0000 (UTC)
From:   Christoph Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Will Deacon <will@kernel.org>
cc:     Vlastimil Babka <vbabka@suse.cz>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bharata B Rao <bharata@linux.ibm.com>,
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
In-Reply-To: <20210126230305.GD30941@willie-the-truck>
Message-ID: <alpine.DEB.2.22.394.2101270907260.673600@www.lameter.com>
References: <20201118082759.1413056-1-bharata@linux.ibm.com> <CAKfTPtA_JgMf_+zdFbcb_V9rM7JBWNPjAz9irgwFj7Rou=xzZg@mail.gmail.com> <20210121053003.GB2587010@in.ibm.com> <alpine.DEB.2.22.394.2101210959060.100764@www.lameter.com> <d7fb9425-9a62-c7b8-604d-5828d7e6b1da@suse.cz>
 <CAKfTPtDy3Ynk2nGCTWiXjz9-4vuSHB3pGuafoTUBPFNO1ac3PA@mail.gmail.com> <786571e7-b9a2-4cdb-06d5-aa4a4b439b7e@suse.cz> <20210123051607.GC2587010@in.ibm.com> <CAKfTPtAjyVmS5VYvU6DBxg4-JEo5bdmWbngf-03YsY18cmWv_g@mail.gmail.com> <66652406-25e4-a9e7-45a1-8ad14d2e8a36@suse.cz>
 <20210126230305.GD30941@willie-the-truck>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jan 2021, Will Deacon wrote:

> > Hm, but booting the secondaries is just a software (kernel) action? They are
> > already physically there, so it seems to me as if the cpu_present_mask is not
> > populated correctly on arm64, and it's just a mirror of cpu_online_mask?
>
> I think the present_mask retains CPUs if they are hotplugged off, whereas
> the online mask does not. We can't really do any better on arm64, as there's
> no way of telling that a CPU is present until we've seen it.

The order of each page in a kmem cache --and therefore also the number
of objects in a slab page-- can be different because that information is
stored in the page struct.

Therefore it is possible to retune the order while the cache is in operaton.

This means you can run an initcall after all cpus have been brought up to
set the order and number of objects in a slab page differently.

The older slab pages will continue to exist with the old orders until they
are freed.

