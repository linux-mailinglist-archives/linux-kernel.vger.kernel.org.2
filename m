Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9934132C292
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237698AbhCDAAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 19:00:23 -0500
Received: from vmi485042.contaboserver.net ([161.97.139.209]:38422 "EHLO
        gentwo.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1387965AbhCCUE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 15:04:26 -0500
Received: by gentwo.de (Postfix, from userid 1001)
        id 17718B007D1; Wed,  3 Mar 2021 20:55:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 0F843B005D8;
        Wed,  3 Mar 2021 20:55:49 +0100 (CET)
Date:   Wed, 3 Mar 2021 20:55:48 +0100 (CET)
From:   Christoph Lameter <cl@gentwo.de>
To:     Matthew Wilcox <willy@infradead.org>
cc:     Xunlei Pang <xlpang@linux.alibaba.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Wen Yang <wenyang@linux.alibaba.com>,
        Roman Gushchin <guro@fb.com>, Pekka Enberg <penberg@gmail.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v2 3/3] mm/slub: Use percpu partial free counter
In-Reply-To: <20210303193038.GE2723601@casper.infradead.org>
Message-ID: <alpine.DEB.2.22.394.2103032032070.897408@gentwo.de>
References: <1597061872-58724-1-git-send-email-xlpang@linux.alibaba.com> <1597061872-58724-4-git-send-email-xlpang@linux.alibaba.com> <alpine.DEB.2.22.394.2103021012010.860725@gentwo.de> <20210303142612.GC2723601@casper.infradead.org>
 <alpine.DEB.2.22.394.2103032012250.896915@gentwo.de> <20210303193038.GE2723601@casper.infradead.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Mar 2021, Matthew Wilcox wrote:

> > Can this be allocated in an interrupt context?
> >
> > And I am not sure how local_t relates to that? Percpu counters can be used
> > in an interrupt context without the overhead of the address calculations
> > that are required by a local_t.
>
> As I understand the patch, this counts the number of partially free slabs.
> So if we start to free an object from a completely full slab in process
> context, as "load x, add one to x, store x" and take an interrupt
> between loading x and adding one to x, that interrupt handler might
> free a different object from another completely full slab.  that would
> also load the same x, add one to it and store x, but then the process
> context would add one to the old x, overwriting the updated value from
> interrupt context.

this_cpu operations are "atomic" vs. preemption but on some platforms not
vs interrupts. That could be an issue in kmem_cache_free(). This would
need a modification to the relevant this_cpu ops so that interrupts are
disabled on those platforms.

Like this_cpu_inc_irq() or so?


> it's not the likeliest of races, and i don't know how important it is
> that these counters remain accurate.  but using a local_t instead of
> a percpu long would fix the problem.  i don't know why you think that
> a local_t needs "address calculations".  perhaps you've misremembered
> what a local_t is?

local_t does not include the address arithmetic that the this_cpu
operation can implicitly perform on x86 f.e. with an segment register or
maybe another register on another platform thereby avoiding the need to
disable preemption or interrupts.

Therefore a manual calculation of the target address for a local_t
operation needs to be done beforehand which usually means disabling
interrupts and/or preemption for the code segment. Otherwise we may end up
on a different processor due to scheduler or other interruptions and use
the percpu counter value of a different processor which could be racy.
