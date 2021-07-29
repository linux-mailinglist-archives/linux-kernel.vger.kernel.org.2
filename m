Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94EBD3DA7C2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 17:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237913AbhG2PnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 11:43:10 -0400
Received: from outbound-smtp08.blacknight.com ([46.22.139.13]:47313 "EHLO
        outbound-smtp08.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237909AbhG2PnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 11:43:08 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp08.blacknight.com (Postfix) with ESMTPS id 10A421C47F0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 16:43:04 +0100 (IST)
Received: (qmail 15224 invoked from network); 29 Jul 2021 15:43:03 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 29 Jul 2021 15:43:03 -0000
Date:   Thu, 29 Jul 2021 16:43:02 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mike Galbraith <efault@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH v3 31/35] mm, slub: optionally save/restore irqs in
 slab_[un]lock()/
Message-ID: <20210729154302.GF3809@techsingularity.net>
References: <20210729132132.19691-1-vbabka@suse.cz>
 <20210729132132.19691-32-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210729132132.19691-32-vbabka@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2021 at 03:21:28PM +0200, Vlastimil Babka wrote:
> For PREEMPT_RT we will need to disable irqs for this bit spinlock. As a
> preparation, add a flags parameter, and an internal version that takes
> additional bool parameter to control irq saving/restoring (the flags
> parameter is compile-time unused if the bool is a constant false).
> 
> Convert ___cmpxchg_double_slab(), which also comes with the same bool
> parameter, to use the internal version.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

On arm64 allmodconfig, the following build warning was new

 In file included from ./include/linux/spinlock.h:54,
                  from ./include/linux/mmzone.h:8,
                  from ./include/linux/gfp.h:6,
                  from ./include/linux/mm.h:10,
                  from mm/slub.c:13:
 mm/slub.c: In function '___cmpxchg_double_slab.isra.0':
 ./include/linux/irqflags.h:177:3: warning: 'flags' may be used uninitialized in this function [-Wmaybe-uninitialized]
   177 |   arch_local_irq_restore(flags);  \
       |   ^~~~~~~~~~~~~~~~~~~~~~
 mm/slub.c:408:17: note: 'flags' was declared here
   408 |   unsigned long flags;
       |                 ^~~~~
 In file included from ./include/linux/string.h:262,
                  from ./include/linux/bitmap.h:10,
                  from ./include/linux/cpumask.h:12,

No idea what's special about arm allmodconfig that confuses the
compiler.

-- 
Mel Gorman
SUSE Labs
