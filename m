Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3742738E881
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 16:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbhEXOSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 10:18:04 -0400
Received: from foss.arm.com ([217.140.110.172]:42508 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232929AbhEXORy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 10:17:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61598139F;
        Mon, 24 May 2021 07:16:26 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5ED4B3F719;
        Mon, 24 May 2021 07:16:24 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linuxppc-dev@lists.ozlabs.org,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Scott Cheloha <cheloha@linux.ibm.com>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Geetika Moolchandani <Geetika.Moolchandani1@ibm.com>
Subject: Re: [PATCH 2/3] powerpc/numa: Populate distance map correctly
In-Reply-To: <20210520154427.1041031-3-srikar@linux.vnet.ibm.com>
References: <20210520154427.1041031-1-srikar@linux.vnet.ibm.com> <20210520154427.1041031-3-srikar@linux.vnet.ibm.com>
Date:   Mon, 24 May 2021 15:16:22 +0100
Message-ID: <87im386wuh.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/21 21:14, Srikar Dronamraju wrote:
> +int arch_populate_distance_map(unsigned long *distance_map)
> +{
> +	int i;
> +	int distance = LOCAL_DISTANCE;
> +
> +	bitmap_set(distance_map, distance, 1);
> +
> +	if (!form1_affinity) {
> +		bitmap_set(distance_map, REMOTE_DISTANCE, 1);
> +		return 0;
> +	}
> +
> +	for (i = 0; i < distance_ref_points_depth; i++) {
> +		distance *= 2;
> +		bitmap_set(distance_map, distance, 1);

Do you have guarantees your distance values will always be in the form of

  LOCAL_DISTANCE * 2^i

because that certainly isn't true for x86/arm64.

> +	}
> +	return 0;
> +}
> +
>  /*
>   * Returns nid in the range [0..nr_node_ids], or -1 if no useful NUMA
>   * info is found.
> --
> 2.27.0
