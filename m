Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A0738FD6E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 11:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbhEYJIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 05:08:17 -0400
Received: from vmi485042.contaboserver.net ([161.97.139.209]:39960 "EHLO
        gentwo.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230471AbhEYJIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 05:08:16 -0400
Received: by gentwo.de (Postfix, from userid 1001)
        id 609CAB003B1; Tue, 25 May 2021 11:06:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 5F75AB00034;
        Tue, 25 May 2021 11:06:46 +0200 (CEST)
Date:   Tue, 25 May 2021 11:06:46 +0200 (CEST)
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
Subject: Re: [RFC 06/26] mm, slub: dissolve new_slab_objects() into
 ___slab_alloc()
In-Reply-To: <20210524233946.20352-7-vbabka@suse.cz>
Message-ID: <alpine.DEB.2.22.394.2105251106090.107680@gentwo.de>
References: <20210524233946.20352-1-vbabka@suse.cz> <20210524233946.20352-7-vbabka@suse.cz>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 May 2021, Vlastimil Babka wrote:

> The later patches will need more fine grained control over individual actions
> in ___slab_alloc(), the only caller of new_slab_objects(), so dissolve it
> there. This is a preparatory step with no functional change.

Acked-by: Christoph Lameter <cl@linux.com>

