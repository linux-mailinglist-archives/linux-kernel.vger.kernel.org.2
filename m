Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF303A159C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 15:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234722AbhFINbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 09:31:33 -0400
Received: from vmi485042.contaboserver.net ([161.97.139.209]:59594 "EHLO
        gentwo.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233302AbhFINbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 09:31:31 -0400
Received: by gentwo.de (Postfix, from userid 1001)
        id F1C9FB0026B; Wed,  9 Jun 2021 15:29:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id F022CB000A9;
        Wed,  9 Jun 2021 15:29:35 +0200 (CEST)
Date:   Wed, 9 Jun 2021 15:29:35 +0200 (CEST)
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
Subject: Re: [RFC v2 02/34] mm, slub: allocate private object map for sysfs
 listings
In-Reply-To: <20210609113903.1421-3-vbabka@suse.cz>
Message-ID: <alpine.DEB.2.22.394.2106091528280.60148@gentwo.de>
References: <20210609113903.1421-1-vbabka@suse.cz> <20210609113903.1421-3-vbabka@suse.cz>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jun 2021, Vlastimil Babka wrote:

> The handlers of sysfs files alloc_calls and free_calls also currently use this
> shared bitmap, but their syscall context makes it straightforward to allocate a
> private map before entering locked sections, so switch these processing paths
> to use a private bitmap.

Historically that was the case but there were various issues with
recursion via sysfs etc etc. alloca was too stack intensive.... Hopefully
this one will last.

