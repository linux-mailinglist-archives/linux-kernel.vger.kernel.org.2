Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDCBE3877BD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 13:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239613AbhERLdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 07:33:35 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4728 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239909AbhERLdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 07:33:32 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fktzw4g0JzmhMZ;
        Tue, 18 May 2021 19:28:44 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 18 May 2021 19:32:12 +0800
Received: from [10.47.83.99] (10.47.83.99) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 18 May
 2021 12:32:10 +0100
Subject: Re: [patch 5/8] perf/arm-dsu: Use irq_set_affinity()
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Nitesh Lal <nilal@redhat.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Frank Li <Frank.li@nxp.com>, "Shawn Guo" <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "NXP Linux Team" <linux-imx@nxp.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>
References: <20210518091725.046774792@linutronix.de>
 <20210518093118.505110632@linutronix.de>
From:   John Garry <john.garry@huawei.com>
Message-ID: <4fe8eb68-c940-dd4b-6781-6cdaf052f4f5@huawei.com>
Date:   Tue, 18 May 2021 12:31:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20210518093118.505110632@linutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.83.99]
X-ClientProxiedBy: lhreml716-chm.china.huawei.com (10.201.108.67) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/2021 10:17, Thomas Gleixner wrote:
>   
> @@ -769,7 +769,6 @@ static int dsu_pmu_device_probe(struct p
>   	if (rc) {

nit: I think that someone will send a patch to remove these {} later...

>   		cpuhp_state_remove_instance(dsu_pmu_cpuhp_state,
>   						 &dsu_pmu->cpuhp_node);
> -		irq_set_affinity_hint(dsu_pmu->irq, NULL);
>   	}

Thanks,
John


