Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86EBC390049
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 13:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbhEYLst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 07:48:49 -0400
Received: from outbound-smtp35.blacknight.com ([46.22.139.218]:50213 "EHLO
        outbound-smtp35.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229896AbhEYLss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 07:48:48 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp35.blacknight.com (Postfix) with ESMTPS id 97F821848
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 12:47:17 +0100 (IST)
Received: (qmail 2807 invoked from network); 25 May 2021 11:47:17 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.23.168])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 25 May 2021 11:47:17 -0000
Date:   Tue, 25 May 2021 12:47:15 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [RFC 04/26] mm, slub: simplify kmem_cache_cpu and tid setup
Message-ID: <20210525114715.GN30378@techsingularity.net>
References: <20210524233946.20352-1-vbabka@suse.cz>
 <20210524233946.20352-5-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210524233946.20352-5-vbabka@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 01:39:24AM +0200, Vlastimil Babka wrote:
> In slab_alloc_node() and do_slab_free() fastpaths we need to guarantee that
> our kmem_cache_cpu pointer is from the same cpu as the tid value. Currently
> that's done by reading the tid first using this_cpu_read(), then the
> kmem_cache_cpu pointer and verifying we read the same tid using the pointer and
> plain READ_ONCE().
> 
> This can be simplified to just fetching kmem_cache_cpu pointer and then reading
> tid using the pointer. That guarantees they are from the same cpu. We don't
> need to read the tid using this_cpu_read() because the value will be validated
> by this_cpu_cmpxchg_double(), making sure we are on the correct cpu and the
> freelist didn't change by anyone preempting us since reading the tid.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Wow, that's a fun approach to avoiding disabling preemption but the
validation check against preemption remains the same so;

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
