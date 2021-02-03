Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5951B30D956
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 12:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbhBCL6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 06:58:38 -0500
Received: from mx2.cyber.ee ([193.40.6.72]:35513 "EHLO mx2.cyber.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233972AbhBCL6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 06:58:35 -0500
Subject: Re: [PATCH v2] sched/topology: fix the issue groups don't span
 domain->span for NUMA diameter > 2
To:     Barry Song <song.bao.hua@hisilicon.com>,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        mgorman@suse.de, mingo@kernel.org, peterz@infradead.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        linux-kernel@vger.kernel.org
Cc:     linuxarm@openeuler.org, xuwei5@huawei.com, liguozhu@hisilicon.com,
        tiantao6@hisilicon.com, wanghuiqiang@huawei.com,
        prime.zeng@hisilicon.com, jonathan.cameron@huawei.com,
        guodong.xu@linaro.org
References: <20210203111201.20720-1-song.bao.hua@hisilicon.com>
From:   Meelis Roos <mroos@linux.ee>
Message-ID: <d3ec7706-6560-70dd-d968-26460ce0c666@linux.ee>
Date:   Wed, 3 Feb 2021 13:57:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210203111201.20720-1-song.bao.hua@hisilicon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

03.02.21 13:12 Barry Song wrote:
> kernel/sched/topology.c | 85 +++++++++++++++++++++++++----------------
>   1 file changed, 53 insertions(+), 32 deletions(-)
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 5d3675c7a76b..964ed89001fe 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c

This one still works on the Sun X4600-M2, on top of v5.11-rc6-55-g3aaf0a27ffc2.


Performance-wise - is the some simple benhmark to run to meaure the impact? Compared to what - 5.10.0 or the kernel with the warning?

drop caches and time the build time of linux kernel with make -j64?

-- 
Meelis Roos
