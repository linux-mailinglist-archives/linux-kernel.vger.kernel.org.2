Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE4C38FC3C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 10:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbhEYIKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 04:10:20 -0400
Received: from vmi485042.contaboserver.net ([161.97.139.209]:39878 "EHLO
        gentwo.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232022AbhEYIJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 04:09:08 -0400
Received: by gentwo.de (Postfix, from userid 1001)
        id 570EFB003B1; Tue, 25 May 2021 10:06:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 536FEB00034;
        Tue, 25 May 2021 10:06:31 +0200 (CEST)
Date:   Tue, 25 May 2021 10:06:31 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [RFC 01/26] mm, slub: allocate private object map for sysfs
 listings
In-Reply-To: <20210524233946.20352-2-vbabka@suse.cz>
Message-ID: <alpine.DEB.2.22.394.2105251005260.107680@gentwo.de>
References: <20210524233946.20352-1-vbabka@suse.cz> <20210524233946.20352-2-vbabka@suse.cz>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 May 2021, Vlastimil Babka wrote:

> Slub has a static spinlock protected bitmap for marking which objects are on
> freelist when it wants to list them, for situations where dynamically
> allocating such map can lead to recursion or locking issues, and on-stack
> bitmap would be too large.
>
> The handlers of sysfs files alloc_calls and free_calls also currently use this
> shared bitmap, but their syscall context makes it straightforward to allocate a
> private map before entering locked sections, so switch these processing paths
> to use a private bitmap.

Right in that case a GFP_KERNEL allocation is fine and you can avoid the
static map.

Acked-by: Christoph Lameter <cl@linux.com>
