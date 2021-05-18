Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614E238762F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 12:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348378AbhERKMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 06:12:48 -0400
Received: from foss.arm.com ([217.140.110.172]:47658 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348377AbhERKMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 06:12:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6DD71FB;
        Tue, 18 May 2021 03:11:23 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.6.226])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 09E983F719;
        Tue, 18 May 2021 03:11:19 -0700 (PDT)
Date:   Tue, 18 May 2021 11:11:17 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Nitesh Lal <nilal@redhat.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, Frank Li <Frank.li@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>
Subject: Re: [patch 0/8] genirq, perf: Cleanup the abuse of
 irq_set_affinity_hint()
Message-ID: <20210518101117.GC82842@C02TD0UTHF1T.local>
References: <20210518091725.046774792@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518091725.046774792@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Tue, May 18, 2021 at 11:17:25AM +0200, Thomas Gleixner wrote:
> The modular PMU drivers use irq_set_affinity_hint() to set the affinity
> for the PMU interrupts, which relies on the undocumented side effect that
> this function actually sets the affinity under the hood.
> 
> Setting an hint is clearly not a guarantee and for these PMU interrupts an
> affinity hint, which is supposed to guide userspace for setting affinity,
> is beyond pointless, because the affinity of these interrupts cannot be
> modified from user space.
> 
> Aside of that the error checks are bogus because the only error which is
> returned from irq_set_affinity_hint() is when there is no irq descriptor
> for the interrupt number, but not when the affinity set fails. That's on
> purpose because the hint can point to an offline CPU.
> 
> Sigh, if people would at least talk if something is missing...
> 
> Clean up the mess by exposing irq_set_affinity() and converting the drivers
> over to that.

Sorry about this, and thanks for cleaning this up.

For the series:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> 
> Thanks,
> 
> 	tglx
> ---
>  drivers/perf/arm-ccn.c                        |    6 +---
>  drivers/perf/arm-cmn.c                        |    9 +-----
>  drivers/perf/arm_dmc620_pmu.c                 |    5 +--
>  drivers/perf/arm_dsu_pmu.c                    |    8 +----
>  drivers/perf/arm_smmuv3_pmu.c                 |   10 ++-----
>  drivers/perf/fsl_imx8_ddr_perf.c              |    5 +--
>  drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c |    3 --
>  drivers/perf/hisilicon/hisi_uncore_hha_pmu.c  |    3 --
>  drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c  |    3 --
>  drivers/perf/hisilicon/hisi_uncore_pa_pmu.c   |    3 --
>  drivers/perf/hisilicon/hisi_uncore_pmu.c      |    4 +-
>  drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c |    3 --
>  include/linux/interrupt.h                     |   35 +-------------------------
>  kernel/irq/manage.c                           |   33 +++++++++++++++++++++++-
>  14 files changed, 49 insertions(+), 81 deletions(-)
> 
> 
