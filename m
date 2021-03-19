Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D212342017
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 15:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhCSOro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 10:47:44 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:47011 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230268AbhCSOrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 10:47:25 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1lNGP9-0008h7-Bz; Fri, 19 Mar 2021 15:47:11 +0100
Received: from suse-laptop.physik.fu-berlin.de ([160.45.32.140])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1lNGP8-0014sH-7N; Fri, 19 Mar 2021 15:47:11 +0100
Subject: Re: [PATCH] ia64: Ensure proper NUMA distance and possible map
 initialization
To:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        debian-ia64 <debian-ia64@lists.debian.org>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        Anatoly Pugachev <matorola@gmail.com>
References: <20210318130617.896309-1-valentin.schneider@arm.com>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <3c421868-d6a8-1da2-f876-49b6374270dc@physik.fu-berlin.de>
Date:   Fri, 19 Mar 2021 15:47:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210318130617.896309-1-valentin.schneider@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 160.45.32.140
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valentin!

On 3/18/21 2:06 PM, Valentin Schneider wrote:
> John Paul reported a warning about bogus NUMA distance values spurred by
> commit:
> 
>   620a6dc40754 ("sched/topology: Make sched_init_numa() use a set for the deduplicating sort")
> 
> In this case, the afflicted machine comes up with a reported 256 possible
> nodes, all of which are 0 distance away from one another. This was
> previously silently ignored, but is now caught by the aforementioned
> commit.
> 
> The culprit is ia64's node_possible_map which remains unchanged from its
> initialization value of NODE_MASK_ALL. In John's case, the machine doesn't
> have any SRAT nor SLIT table, but AIUI the possible map remains untouched
> regardless of what ACPI tables end up being parsed. Thus, !online &&
> possible nodes remain with a bogus distance of 0 (distances \in [0, 9] are
> "reserved and have no meaning" as per the ACPI spec).
> 
> Follow x86 / drivers/base/arch_numa's example and set the possible map to
> the parsed map, which in this case seems to be the online map.
> 
> Link: http://lore.kernel.org/r/255d6b5d-194e-eb0e-ecdd-97477a534441@physik.fu-berlin.de
> Fixes: 620a6dc40754 ("sched/topology: Make sched_init_numa() use a set for the deduplicating sort")
> Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
> This might need an earlier Fixes: tag, but all of this is quite old and
> dusty (the git blame rabbit hole leads me to ~2008/2007)
> 
> Alternatively, can we deprecate ia64 already?
> ---
>  arch/ia64/kernel/acpi.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/ia64/kernel/acpi.c b/arch/ia64/kernel/acpi.c
> index a5636524af76..e2af6b172200 100644
> --- a/arch/ia64/kernel/acpi.c
> +++ b/arch/ia64/kernel/acpi.c
> @@ -446,7 +446,8 @@ void __init acpi_numa_fixup(void)
>  	if (srat_num_cpus == 0) {
>  		node_set_online(0);
>  		node_cpuid[0].phys_id = hard_smp_processor_id();
> -		return;
> +		slit_distance(0, 0) = LOCAL_DISTANCE;
> +		goto out;
>  	}
>  
>  	/*
> @@ -489,7 +490,7 @@ void __init acpi_numa_fixup(void)
>  			for (j = 0; j < MAX_NUMNODES; j++)
>  				slit_distance(i, j) = i == j ?
>  					LOCAL_DISTANCE : REMOTE_DISTANCE;
> -		return;
> +		goto out;
>  	}
>  
>  	memset(numa_slit, -1, sizeof(numa_slit));
> @@ -514,6 +515,8 @@ void __init acpi_numa_fixup(void)
>  		printk("\n");
>  	}
>  #endif
> +out:
> +	node_possible_map = node_online_map;
>  }
>  #endif				/* CONFIG_ACPI_NUMA */
>  
> 

Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Could you send this patch through Andrew Morton's tree? The ia64 port currently
has no maintainer, so we have to use an alternative tree.

@Sergei: Could you test/ack this patch as well?

Thanks,
Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

