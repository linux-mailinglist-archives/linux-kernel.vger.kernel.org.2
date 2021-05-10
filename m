Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 203BA379337
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 17:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbhEJP7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 11:59:02 -0400
Received: from foss.arm.com ([217.140.110.172]:33242 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230152AbhEJP64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 11:58:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 186AE168F;
        Mon, 10 May 2021 08:57:51 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3183F3F73B;
        Mon, 10 May 2021 08:57:50 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        bristot@redhat.com, yejune.deng@gmail.com
Subject: Re: [PATCH 1/2] sched: Make the idle task quack like a per-CPU kthread
In-Reply-To: <20210510151024.2448573-2-valentin.schneider@arm.com>
References: <20210510151024.2448573-1-valentin.schneider@arm.com> <20210510151024.2448573-2-valentin.schneider@arm.com>
Date:   Mon, 10 May 2021 16:57:47 +0100
Message-ID: <87k0o6int0.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/21 16:10, Valentin Schneider wrote:
> This requires some extra iffery as init_idle()
> call be called more than once on the same idle task.
>

While I'm at it, do we actually still need to suffer through this?

AFAICT the extra calls are due to idle_thread_get() (used in cpuhp) calling
init_idle(). However it looks to me that since

  3bb5d2ee396a ("smp, idle: Allocate idle thread for each possible cpu during boot")

we don't need to do that: we already have a

  for_each_possible_cpu(cpu)
    init_idle(cpu)

issued at init. So can't we "simply" rely on that init-time creation, given
it's done against the possible mask? I think the only thing that might need
doing at later hotplug is making sure the preempt count is right (secondary
startups seem to all prepare the idle task by issuing a preempt_disable()).
