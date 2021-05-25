Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE4F38FD5D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 11:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbhEYJFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 05:05:23 -0400
Received: from vmi485042.contaboserver.net ([161.97.139.209]:39930 "EHLO
        gentwo.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230437AbhEYJFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 05:05:23 -0400
Received: by gentwo.de (Postfix, from userid 1001)
        id 13826B003B1; Tue, 25 May 2021 11:03:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 126C5B00034;
        Tue, 25 May 2021 11:03:53 +0200 (CEST)
Date:   Tue, 25 May 2021 11:03:53 +0200 (CEST)
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
Subject: Re: [RFC 05/26] mm, slub: extract get_partial() from
 new_slab_objects()
In-Reply-To: <20210524233946.20352-6-vbabka@suse.cz>
Message-ID: <alpine.DEB.2.22.394.2105251103320.107680@gentwo.de>
References: <20210524233946.20352-1-vbabka@suse.cz> <20210524233946.20352-6-vbabka@suse.cz>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 May 2021, Vlastimil Babka wrote:

> The later patches will need more fine grained control over individual actions
> in ___slab_alloc(), the only caller of new_slab_objects(), so this is a first
> preparatory step with no functional change.

Acked-by: Christoph Lameter <cl@linux.com>

