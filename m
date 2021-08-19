Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2F03F1A10
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 15:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239655AbhHSNLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 09:11:38 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3676 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbhHSNLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 09:11:37 -0400
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Gr4qw1JDvz6BHHt;
        Thu, 19 Aug 2021 21:10:04 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Thu, 19 Aug 2021 15:10:59 +0200
Received: from [10.47.82.51] (10.47.82.51) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 19 Aug
 2021 14:10:58 +0100
Subject: Re: [EXT] Re: [PATCH v2 2/4] perf/marvell: CN10k DDR performance
 monitor support
To:     Bharat Bhushan <bbhushan2@marvell.com>,
        "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210810094307.29595-1-bbhushan2@marvell.com>
 <20210810094307.29595-3-bbhushan2@marvell.com>
 <c4e9c893-9130-7024-e24e-c63e232be4be@huawei.com>
 <CO6PR18MB4465D5490C1F6141DB454064E3C09@CO6PR18MB4465.namprd18.prod.outlook.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <72430f0f-c22f-0e8a-76db-99fc95d68b49@huawei.com>
Date:   Thu, 19 Aug 2021 14:10:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <CO6PR18MB4465D5490C1F6141DB454064E3C09@CO6PR18MB4465.namprd18.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.82.51]
X-ClientProxiedBy: lhreml730-chm.china.huawei.com (10.201.108.81) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/08/2021 12:52, Bharat Bhushan wrote:
>> Is there anything to stop using adding COMPILE_TEST as a dependency?
>> This really helps build coverage testing for other archs
> Just keeping same as other drivers

I think then that may be something which could be improved for other 
drivers.

> 
>>> +	help
>>> +	  Enable perf support for Marvell DDR Performance monitoring
>>> +	  event on CN10K platform.
>>> +
>>>    endmenu
>>> diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
>>> index 5260b116c7da..ee1126219d8d 100644
>>> --- a/drivers/perf/Makefile
>>> +++ b/drivers/perf/Makefile
>>> @@ -14,3 +14,4 @@ obj-$(CONFIG_THUNDERX2_PMU) += thunderx2_pmu.o
>>>    obj-$(CONFIG_XGENE_PMU) += xgene_pmu.o
>>>    obj-$(CONFIG_ARM_SPE_PMU) += arm_spe_pmu.o
>>>    obj-$(CONFIG_ARM_DMC620_PMU) += arm_dmc620_pmu.o
>>> +obj-$(CONFIG_MARVELL_CN10K_DDR_PMU) += marvell_cn10k_ddr_pmu.o
>>> diff --git a/drivers/perf/marvell_cn10k_ddr_pmu.c
>> b/drivers/perf/marvell_cn10k_ddr_pmu.c
>>> new file mode 100644
>>> index 000000000000..8f9e3d1fcd8d
>>> --- /dev/null
>>> +++ b/drivers/perf/marvell_cn10k_ddr_pmu.c
>>> @@ -0,0 +1,606 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/* Marvell CN10K DRAM Subsystem (DSS) Performance Monitor Driver
>>> + *
>>> + * Copyright (C) 2021 Marvell.
>>> + */
>>> +

...

>>> +/* Event counter value registers */
>>> +#define DDRC_PERF_CNT_VALUE_BASE		0x8080
>>> +#define DDRC_PERF_CNT_VALUE(n)	(DDRC_PERF_CNT_VALUE_BASE + 8 * (n))
>>> +
>>> +/* Fixed event counter enable/disable register */
>>> +#define DDRC_PERF_CNT_FREERUN_EN	0x80C0
>>> +#define DDRC_PERF_FREERUN_WRITE_EN	0x1
>>> +#define DDRC_PERF_FREERUN_READ_EN	0x2
>>> +
>>> +/* Fixed event counter control register */
>>> +#define DDRC_PERF_CNT_FREERUN_CTRL	0x80C8
>>> +#define DDRC_FREERUN_WRITE_CNT_CLR	0x1
>>> +#define DDRC_FREERUN_READ_CNT_CLR	0x2
>>> +
>>> +/* Fixed event counter value register */
>>> +#define DDRC_PERF_CNT_VALUE_WR_OP	0x80D0
>>> +#define DDRC_PERF_CNT_VALUE_RD_OP	0x80D8
>>> +#define DDRC_PERF_CNT_VALUE_OVERFLOW	BIT_ULL(48)
>>> +#define DDRC_PERF_CNT_MAX_VALUE		GENMASK_ULL(48, 0)
>> I assume all these macros are used...
> Yes, do you see any unused?

I didn't check

> 
>>> +
>>> +struct cn10k_ddr_pmu {
>>> +	struct pmu pmu;

Thanks,
john
