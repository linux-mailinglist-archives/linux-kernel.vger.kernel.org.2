Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2FFE30BE3B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 13:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbhBBMdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 07:33:11 -0500
Received: from foss.arm.com ([217.140.110.172]:48908 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231380AbhBBMdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 07:33:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 702351FB;
        Tue,  2 Feb 2021 04:32:23 -0800 (PST)
Received: from localhost (unknown [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 079AB3F718;
        Tue,  2 Feb 2021 04:32:22 -0800 (PST)
Date:   Tue, 2 Feb 2021 12:32:21 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Zou Wei <zou_wei@huawei.com>
Cc:     xuewen.yan@unisoc.com, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, qperret@google.com,
        rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2] sched/topology: Mark some symbols with static
 keyword
Message-ID: <20210202123221.GA7003@arm.com>
References: <1606271447-74720-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1606271447-74720-1-git-send-email-zou_wei@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

+Xuewen Yan, who submitted a similar patch recently.

On Wednesday 25 Nov 2020 at 10:30:47 (+0800), Zou Wei wrote:
> Fix the following sparse warnings:
> 
> kernel/sched/topology.c:211:1: warning: symbol 'sched_energy_mutex' was not declared. Should it be static?
> kernel/sched/topology.c:212:6: warning: symbol 'sched_energy_update' was not declared. Should it be static?
> 
> Fixes: 31f6a8c0a471 ("sched/topology,schedutil: Wrap sched domains rebuild")
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>  kernel/sched/topology.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 5d3675c..2676687 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -208,8 +208,8 @@ sd_parent_degenerate(struct sched_domain *sd, struct sched_domain *parent)
>  #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
>  DEFINE_STATIC_KEY_FALSE(sched_energy_present);
>  unsigned int sysctl_sched_energy_aware = 1;
> -DEFINE_MUTEX(sched_energy_mutex);
> -bool sched_energy_update;
> +static DEFINE_MUTEX(sched_energy_mutex);
> +static bool sched_energy_update;
>  

Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>

Apologies for introducing these warnings with my previous patch.

Kind regards,
Ionela.

>  void rebuild_sched_domains_energy(void)
>  {
> -- 
> 2.6.2
> 
