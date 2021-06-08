Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A18A739EE84
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 08:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhFHGJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 02:09:47 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:5280 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhFHGJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 02:09:46 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4FzfmQ2p5zz1BK3r;
        Tue,  8 Jun 2021 14:03:02 +0800 (CST)
Received: from dggema757-chm.china.huawei.com (10.1.198.199) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 14:07:49 +0800
Received: from [127.0.0.1] (10.69.38.203) by dggema757-chm.china.huawei.com
 (10.1.198.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 8 Jun
 2021 14:07:49 +0800
Subject: Re: [PATCH v3 0/9] drivers/perf: Use general macro to simplify event
 attributes
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>
References: <1623123201-45634-1-git-send-email-liuqi115@huawei.com>
From:   "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <e9f98b16-45b4-d876-56da-20218e2b43de@huawei.com>
Date:   Tue, 8 Jun 2021 14:07:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1623123201-45634-1-git-send-email-liuqi115@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.38.203]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema757-chm.china.huawei.com (10.1.198.199)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

Please ignore this patchset, as I forget to add changelog.
I'll resend this latter.

Thanks,
Qi

On 2021/6/8 11:33, Qi Liu wrote:
> This patchset applies a general EVENT_ATTR_ID to simplify event
> attributes in many PMU drivers.
> 
> Qi Liu (9):
>    perf: Add EVENT_ATTR_ID to simplify event attributes
>    drivers/perf: hisi: Simplify EVENT ATTR macro in HiSilicon PMU driver
>    drivers/perf: Simplify EVENT ATTR macro in SMMU PMU driver
>    drivers/perf: Simplify EVENT ATTR macro in qcom_l2_pmu.c
>    drivers/perf: Simplify EVENT ATTR macro in qcom_l3_pmu.c
>    drivers/perf: Simplify EVENT ATTR macro in xgene_pmu.c
>    drivers/perf: Simplify EVENT ATTR macro in fsl_imx8_ddr_perf.c
>    drivers/perf: Simpilfy EVENT ATTR macro in arm_dsu_pmu.c
>    arm64: perf: Simplify EVENT ATTR macro in perf_event.c
> 
>   arch/arm64/kernel/perf_event.c           |  5 +----
>   drivers/perf/arm_dsu_pmu.c               |  2 +-
>   drivers/perf/arm_smmuv3_pmu.c            |  7 ++-----
>   drivers/perf/fsl_imx8_ddr_perf.c         |  7 ++-----
>   drivers/perf/hisilicon/hisi_uncore_pmu.c |  7 +++----
>   drivers/perf/hisilicon/hisi_uncore_pmu.h |  2 +-
>   drivers/perf/qcom_l2_pmu.c               |  7 ++-----
>   drivers/perf/qcom_l3_pmu.c               |  5 +----
>   drivers/perf/xgene_pmu.c                 | 11 ++++-------
>   include/linux/perf_event.h               |  6 ++++++
>   10 files changed, 23 insertions(+), 36 deletions(-)
> 

