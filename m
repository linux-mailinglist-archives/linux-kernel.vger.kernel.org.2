Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 864CF3B9D37
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 10:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhGBICr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 04:02:47 -0400
Received: from vmi485042.contaboserver.net ([161.97.139.209]:58512 "EHLO
        gentwo.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229519AbhGBICq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 04:02:46 -0400
Received: by gentwo.de (Postfix, from userid 1001)
        id 7720FB0079B; Fri,  2 Jul 2021 10:00:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 7601BB00255;
        Fri,  2 Jul 2021 10:00:11 +0200 (CEST)
Date:   Fri, 2 Jul 2021 10:00:11 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     Marcelo Tosatti <mtosatti@redhat.com>
cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Nitesh Lal <nilal@redhat.com>
Subject: Re: [patch 0/5] optionally sync per-CPU vmstats counter on return
 to userspace
In-Reply-To: <20210701210336.358118649@fuller.cnet>
Message-ID: <alpine.DEB.2.22.394.2107020958430.201080@gentwo.de>
References: <20210701210336.358118649@fuller.cnet>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jul 2021, Marcelo Tosatti wrote:

> The logic to disable vmstat worker thread, when entering
> nohz full, does not cover all scenarios. For example, it is possible
> for the following to happen:
>
> 1) enter nohz_full, which calls refresh_cpu_vm_stats, syncing the stats.
> 2) app runs mlock, which increases counters for mlock'ed pages.
> 3) start -RT loop
>
> Since refresh_cpu_vm_stats from nohz_full logic can happen _before_
> the mlock, vmstat shepherd can restart vmstat worker thread on
> the CPU in question.

Can we enter nohz_full after the app runs mlock?

> To fix this, optionally sync the vmstat counters when returning
> from userspace, controllable by a new "vmstat_sync" isolcpus
> flags (default off).
>
> See individual patches for details.

Wow... This is going into some performance sensitive VM counters here and
adds code to their primitives.

Isnt there a simpler solution that does not require this amount of
changes?

