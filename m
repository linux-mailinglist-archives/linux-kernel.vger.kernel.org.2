Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 107E0428781
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 09:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234320AbhJKHPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 03:15:55 -0400
Received: from vmi485042.contaboserver.net ([161.97.139.209]:45436 "EHLO
        gentwo.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231163AbhJKHPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 03:15:54 -0400
Received: by gentwo.de (Postfix, from userid 1001)
        id 180B9B0025F; Mon, 11 Oct 2021 09:13:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 15A60B00100;
        Mon, 11 Oct 2021 09:13:52 +0200 (CEST)
Date:   Mon, 11 Oct 2021 09:13:52 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [RFC] Some questions and an idea on SLUB/SLAB
In-Reply-To: <20211009001903.GA3285@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
Message-ID: <alpine.DEB.2.22.394.2110110909150.130815@gentwo.de>
References: <20211009001903.GA3285@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Oct 2021, Hyeonggon Yoo wrote:

>  - Is there a reason that SLUB does not implement cache coloring?
>    it will help utilizing hardware cache. Especially in block layer,
>    they are literally *squeezing* its performance now.

Well as Matthew says: The high associativity of caches and the execution
of other code path seems to make this not useful anymore.

I am sure you can find a benchmark that shows some benefit. But please
realize that in real-life the OS must perform work. This means that
multiple other code paths are executed that affect cache use and placement
of data in cache lines.


>  - In SLAB, do we really need to flush queues every few seconds?
>    (per cpu queue and shared queue). Flushing alien caches makes
>    sense, but flushing queues seems reducing it's fastpath.
>    But yeah, we need to reclaim memory. can we just defer this?

The queues are designed to track cache hot objects (See the Bonwick
paper). After a while the cachelines will be used for other purposes and
no longer reflect what is in the caches. That is why they need to be
expired.


>   - I don't like SLAB's per-node cache coloring, because L1 cache
>     isn't shared between cpus. For now, cpus in same node are sharing
>     its colour_next - but we can do better.

This differs based on the cpu architecture in use. SLAB has an ideal model
of how caches work and keeps objects cache hot based on that. In real life
the cpu architecture differs from what SLAB things how caches operate.

>     what about splitting some per-cpu variables into kmem_cache_cpu
>     like SLUB? I think cpu_cache, colour (and colour_next),
>     alloc{hit,miss}, and free{hit,miss} can be per-cpu variables.

That would in turn increase memory use and potentially the cache footprint
of the hot paths.

