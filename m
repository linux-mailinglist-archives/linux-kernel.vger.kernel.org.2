Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C33DA38FD87
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 11:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbhEYJNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 05:13:52 -0400
Received: from vmi485042.contaboserver.net ([161.97.139.209]:39972 "EHLO
        gentwo.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232199AbhEYJNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 05:13:51 -0400
Received: by gentwo.de (Postfix, from userid 1001)
        id D377CB0084B; Tue, 25 May 2021 11:12:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id CDE87B00814;
        Tue, 25 May 2021 11:12:17 +0200 (CEST)
Date:   Tue, 25 May 2021 11:12:17 +0200 (CEST)
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
Subject: Re: [RFC 07/26] mm, slub: return slab page from get_partial() and
 set c->page afterwards
In-Reply-To: <20210524233946.20352-8-vbabka@suse.cz>
Message-ID: <alpine.DEB.2.22.394.2105251110550.107680@gentwo.de>
References: <20210524233946.20352-1-vbabka@suse.cz> <20210524233946.20352-8-vbabka@suse.cz>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 May 2021, Vlastimil Babka wrote:

> The function get_partial() finds a suitable page on a partial list, acquires
> and returns its freelist and assigns the page pointer to kmem_cache_node.
	in kmem_cache_cpu ??

> In later patch we will need more control over the kmem_cache_node assignment,

kmem_cache_cpu?

> so instead return the page pointer to get_partial()'s caller and assign it
> there. No functional change as all of this still happens with disabled irq.

Instead of passing a kmem_cache_cpu pointer pass a pointer to a pointer to
a page ....
