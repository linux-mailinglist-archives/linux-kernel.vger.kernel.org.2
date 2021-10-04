Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E910242121D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 16:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235435AbhJDO63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 10:58:29 -0400
Received: from vmi485042.contaboserver.net ([161.97.139.209]:57152 "EHLO
        gentwo.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234270AbhJDO60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 10:58:26 -0400
Received: by gentwo.de (Postfix, from userid 1001)
        id E033CB00424; Mon,  4 Oct 2021 16:56:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id DD8A4B00261;
        Mon,  4 Oct 2021 16:56:36 +0200 (CEST)
Date:   Mon, 4 Oct 2021 16:56:36 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Queueing is outside of SLUB nowdays
In-Reply-To: <20211001003908.GA2657@linux.asia-northeast3-a.c.our-ratio-313919.internal>
Message-ID: <alpine.DEB.2.22.394.2110041648220.294708@gentwo.de>
References: <20210927090347.GA2533@linux.asia-northeast3-a.c.our-ratio-313919.internal> <8aa15f4b-71de-5283-5ebc-d8d1a323473d@suse.cz> <20211001003908.GA2657@linux.asia-northeast3-a.c.our-ratio-313919.internal>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Oct 2021, Hyeonggon Yoo wrote:

> Looking at other layers, they implemented queuing layer outside of SLUB.
> See commit 795bb1c00dd ("net: bulk free infrastructure for NAPI context,
> use napi_consume_skb") for example. They made skb cache because SLUB is
> not suitable for intensive alloc/free.
>
> And because the queue is outside of slab, it can go lockless
> depending on it's context. (But it's not easy to do so in slab because
> slab is general purpose allocator.)

The queuing within in SLUB/SLAB is lockless.

> So current approach on place where slab's performance is critical
> is implementing queuing layer on top of slab.

If you have to use object specific characteristics to optimize then yes
you can optimize further. However, the slab allocators implement each
their own form of queuing that is generic.

> Then new question arising:
>     - Is that proper way to solve fundamental problem?

There is a problem?

>       - why not use SLAB if they need queuing?

SLAB is LIFO queuing whereas SLUB uses spatial considerations and queues
within a page before going outside. Slab requires disabling interrupts,
SLUB is optimized to rely on per cpu atomics and there are numerous other
differences.

>       - how does this approach work on SLAB?

SLAB has a lockless layer that is only requiring disabling interrupts. It
provides a generic queuing layer as well.

See my talk on Slab allocators awhile back.

https://www.youtube.com/watch?v=h0VMLXavx30
