Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3043C3C59E6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350805AbhGLJLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 05:11:47 -0400
Received: from vmi485042.contaboserver.net ([161.97.139.209]:60544 "EHLO
        gentwo.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346305AbhGLJIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 05:08:49 -0400
Received: by gentwo.de (Postfix, from userid 1001)
        id 00698B003AE; Mon, 12 Jul 2021 11:05:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id F1AFBB00352;
        Mon, 12 Jul 2021 11:05:58 +0200 (CEST)
Date:   Mon, 12 Jul 2021 11:05:58 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     Marcelo Tosatti <mtosatti@redhat.com>
cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Nitesh Lal <nilal@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Saenz <nsaenzju@redhat.com>
Subject: Re: [patch 3/5] mm: vmstat: optionally flush per-CPU vmstat counters
 on return to userspace
In-Reply-To: <20210709174428.241607867@fuller.cnet>
Message-ID: <alpine.DEB.2.22.394.2107121056560.409981@gentwo.de>
References: <20210709173726.457181806@fuller.cnet> <20210709174428.241607867@fuller.cnet>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jul 2021, Marcelo Tosatti wrote:

> +
> +	if (!static_branch_unlikely(&vmstat_sync_enabled))
> +		return;
> +
> +	cpu = smp_processor_id();
> +
> +	if (housekeeping_cpu(cpu, HK_FLAG_QUIESCE_URET))
> +		return;
> +
> +	per_cpu(vmstat_dirty, smp_processor_id()) = true;
> +}

And you are going to insert this into all the performance critical VM
statistics handling. Inline?

And why do you need to do such things as to determine the processor? At
mininum do this using this cpu operations like the vmstat functions
currently do. And, lucky us, now we also have
more issues why we should disable preemption etc etc while handling vm
counters.


