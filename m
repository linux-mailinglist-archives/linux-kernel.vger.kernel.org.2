Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C634330F345
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 13:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236015AbhBDMgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 07:36:55 -0500
Received: from foss.arm.com ([217.140.110.172]:57668 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235711AbhBDMgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 07:36:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FC0AD6E;
        Thu,  4 Feb 2021 04:36:06 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D26A33F73B;
        Thu,  4 Feb 2021 04:36:04 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Qais Yousef <qais.yousef@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH 0/8] sched/fair: misfit task load-balance tweaks
In-Reply-To: <66efcfb1-d6ee-248a-e337-d690cda1bb5a@arm.com>
References: <20210128183141.28097-1-valentin.schneider@arm.com> <20210203151400.ommltjjyuok4yj5e@e107158-lin> <jhjim792dro.mognet@arm.com> <66efcfb1-d6ee-248a-e337-d690cda1bb5a@arm.com>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Thu, 04 Feb 2021 12:36:02 +0000
Message-ID: <jhj4kis2eod.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02/21 13:03, Dietmar Eggemann wrote:
> How did you verify the benefit of these changes?
>
> It's clear that you need a platform with capacity_orig diffs <20%
> between CPU types (like Pixel4 - SD855 (4x261, 3x871, 1x1024) or QC's
> RB5 platform - SD865 (4x284, 3x871, 1*1024)) but which
> benchmark/testcase did you use?

Benchmark is the usual culprit:

  https://lisa-linux-integrated-system-analysis.readthedocs.io/en/master/kernel_tests.html#lisa.tests.scheduler.misfit.StaggeredFinishes

This test spawns 1 CPU hog per CPU, and screams whenever a CPU of capacity
X is running a hog while another CPU of capacity Y > X has been idling for
"too long" (a few ms). IOW it makes sure upmigration happens in a timely
manner.

Some of the test platforms (Juno (4+2 big.LITTLE), HiKey960 (4+4
big.LITTLE)) show some improvements due to the last 2 patches.

As for systems with CPUs in the [819-1024] "deadzone", Ionela's been kindly
running said test on said RB5, and the upmigrations look just fine with the
patches applied.
