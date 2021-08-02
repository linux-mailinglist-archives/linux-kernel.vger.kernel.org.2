Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75F433DDB22
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 16:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbhHBOes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 10:34:48 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:56394 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234390AbhHBOeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 10:34:37 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 172EEwkq014398;
        Mon, 2 Aug 2021 07:34:19 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by mx0a-0016f401.pphosted.com with ESMTP id 3a62652n2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Aug 2021 07:34:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjh/fZ/dr0dRBlWF7vEA2AiJcqtqyZYwR8xW0OvVhS0JR0qzQkip+Cp3hj2G/QG0QVoXWwkVchgXf4LpJM39oVadadiQNBqVUWgUS11lBmGaz6PLkuLWoa0GxEV4OLAc7yRCm2DkNc+GY73ygG9TOthVaJvPcHk/hBXAPz8mOUq2CP/W0KhvwqdhEVNzQrpqLVkcLjfz2BR/NqRp/S5Y30ffxPL11RahO9KTy0pcLPERjQKqV3gBLTSquaSRxqxxo7R/ACnK1dk2pbmdVqw4KDLOdoNvH/I0qirPD2BCiiDQyRMuC9EX+nS5hH9Zhl7FEyvr1IspXlfDHIbQZNQ4Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2roNmOUz44d/2OIa1DcQWOhgRp8zYW8w8VzWtRLyLhk=;
 b=F5B1Y/xsLPQIb9OL7l2K0WtSN/DDtsU85KfzfiE/yqBdbyTGjpjuz5I6xKaYrFqCUH/l1HcVqRK+vvO/s+iH97bCBx6fBaICu8qUCvj3AKbtZEJLrtGio9N/YtqZAZu5UzAUpmNDj6w3TMDchDdBvl50xJKOJi4KoUhzX0CwmkuEqOd8x/fsjmX+F8Cae9pqn2BAqy6Sp8zyeMRPju5LKIb6pMfYWUGBFqqVRlqEOtiHVBBD0xKfjI8gzYWPrHVq5l+dIUr/tZ1tSq5KervyMrqToMXexU+ScEgdxN/lIB3LWy2TIrF/bVPGGrOHvqk+pBGNtao7KyDXd6ZPNB71Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2roNmOUz44d/2OIa1DcQWOhgRp8zYW8w8VzWtRLyLhk=;
 b=qOy4yrGK4MpOETQOrO3vWhcOnHH0AlhkhdQ65X06fngpuJqEg88uHn+b3kwxY+pbEvqAr4AfxVl7KHKX0SyewiaWqvmkg9ZK5CePDW0/c6QKrqLO4Lz+t2qYcMcANfMgBhBlyqGv93IiciI1shPPzWwpOyGU4EiEfmL3x0Waj84=
Received: from CY4PR1801MB2070.namprd18.prod.outlook.com
 (2603:10b6:910:7e::28) by CY4PR18MB1045.namprd18.prod.outlook.com
 (2603:10b6:903:a6::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.26; Mon, 2 Aug
 2021 14:34:16 +0000
Received: from CY4PR1801MB2070.namprd18.prod.outlook.com
 ([fe80::f8b1:1b44:4fa8:e670]) by CY4PR1801MB2070.namprd18.prod.outlook.com
 ([fe80::f8b1:1b44:4fa8:e670%5]) with mapi id 15.20.4373.026; Mon, 2 Aug 2021
 14:34:16 +0000
From:   Bhaskara Budiredla <bbudiredla@marvell.com>
To:     Will Deacon <will@kernel.org>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v2 1/1] drivers: perf: Add LLC-TAD perf counter
 support
Thread-Topic: [EXT] Re: [PATCH v2 1/1] drivers: perf: Add LLC-TAD perf counter
 support
Thread-Index: AQHXYSVuC8kRuD0CeUC4VRRYSfcvZatgUYWAgAAxeVA=
Date:   Mon, 2 Aug 2021 14:34:16 +0000
Message-ID: <CY4PR1801MB2070C4C855DF5BA87BE8C2B3DEEF9@CY4PR1801MB2070.namprd18.prod.outlook.com>
References: <20210614135849.6076-1-bbudiredla@marvell.com>
 <20210802103401.GA27583@willie-the-truck>
In-Reply-To: <20210802103401.GA27583@willie-the-truck>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=marvell.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 439b1f5d-cd1b-423e-2585-08d955c29b5a
x-ms-traffictypediagnostic: CY4PR18MB1045:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR18MB1045ACF19E77AE1FC5FEF086DEEF9@CY4PR18MB1045.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tJ0AUcDClcr9c7BwoAEnlhXuzYbIaXImBi+UfEly2EoW7KWEdDdljKQm51QNWNr/fhugANapPynTCzKQz8FiPyLqbm+HzcNE9maGljY7LObEXOFiXYura6Yp3dUL8K9vS9afqIIB1la1B3resAk30KE8DN47CQo1pbrUjuDEwDkYLI/WY7az5/Yg2ZKJX1m1NuEshzk9XkZbKG0xOCP4A5Nr05c1o44lqynHeJ+2gbw0Vew8bwSC9ypDLKlRaSwlj7qIzyjaq7ngN0padu16Yz/RbItQcRB1GSCKsAhfLMTaxJPt0HacU9vs5/V2kxSxAnjLH+RlnhlL4z1bwAQ1GvB2pwK2UaR/sMFt1Ma5xnjwfvyerwycilNX2f1Ro+BJjyE5iAscZXG4gJf/wp/MMTChE+1OeY4bWtnsz9D1eEFKNiwzmASs5p2aiMPDykmcTLI2uIe36A1E4wd5ZMWZXWRPS6XCXqsRo5gJVlqHeAB6lOodQNbCP8AOKGdI8kdBrBTST6b4lKeR7prCCbqOM7l2kgPUcGZxlSM7KCFRX2E9oegPADmjjVPRZZ8IzGP2VGxX8SvBT7vu/+/xDw/Ip92XDhgAlmpVdomvVxEBTYBMMTl7/8m/quW2JLEcbbg4EvDC7ityjJFvdFeiK+vv3FB1t1hqi8DdEf2csZkUxN8mVygXltbRWSZy3XNHlFZZjYAxtqhQe+OQ8/qJIo8/gasT8ygXTYilz0+/91LmNbk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1801MB2070.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(122000001)(66476007)(66946007)(38100700002)(52536014)(7696005)(66446008)(38070700005)(86362001)(55016002)(2906002)(6506007)(76116006)(9686003)(6916009)(64756008)(66556008)(83380400001)(478600001)(5660300002)(71200400001)(316002)(33656002)(186003)(8936002)(8676002)(4326008)(54906003)(26005)(2004002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Qaxlq5modVzn09zS4lnWTdoXISoBvvNQvs34GBoVnsXExq+Aj7CFzogihVws?=
 =?us-ascii?Q?HDxjBI2QmGcvIhlZbqq6UYU+X+39P/1NCPbaUhM9LoNuxKoJuG30+NbjNyDl?=
 =?us-ascii?Q?YqAMyl02rLme7IhCdy2EdM5Eh2I8onUgVgOCyrhkz4+UWE3A8AFXgcBPmquh?=
 =?us-ascii?Q?rnBtgsku/gCaTgOFRW4ksJFV2qocLH4hgupq88AfWmGGPFLqX/zchT/747Un?=
 =?us-ascii?Q?9zEy3VJtXka2OGfEUwm/eNcz5izygtFdfRLn9x6QAFlTiC/+DJjuOAKZwbbs?=
 =?us-ascii?Q?9B12EP+lGlYqX7ko/gQ9Cm39CbKF6Tf0m/+9XyzVZeKnB1PfAFUIcNl6nXtc?=
 =?us-ascii?Q?VgfM+UJwzfpAN8K6YYsrIMWs8Bi50Vl9AhMZuUia0XW5svtMJm7Af0EHbwlb?=
 =?us-ascii?Q?4ZibTvGgpvUZ8Ghs73AAEhXjrDBv3lbpPU1SBq7p1jCcV3pTPd6d3sRJOkhC?=
 =?us-ascii?Q?p8qLW9Yh8buCwyj5gjAyYGyfAVgsv83rxHat8RVoCQ+phB5CjNIt1F7Pm20O?=
 =?us-ascii?Q?Xd48LOFdRfZwc/XW1amyUVxOSLRzRVRawEUeLO8ri/YjyjdMDA1M3TZZQR8s?=
 =?us-ascii?Q?ATUqr7Uv92hwHWyFx2dybv0rvSAEveBeiUWrmT8B0XQeuwDCDrsPbWbgYIOx?=
 =?us-ascii?Q?GqWlCH8yrQo005jGuNmyhBnDLYxoL5HTkr69YsFKeas6vXhSMluoyEam8plU?=
 =?us-ascii?Q?XmuD03ORWpZIC2KtkUtviCIOEukrFdQm0aUzQCzHGEPiYuA0lx+2IDpUY4Vu?=
 =?us-ascii?Q?G54V9VJHuSiFN48/xY7qwQCfYtou6kebqDWunVwmCU8i/gLDZReAywGUOCei?=
 =?us-ascii?Q?theBxGOO5ZcBeoJPjt96Vrw9mRcCxM3EOdYr5caXg1uvelwmniSPnk2AMgOY?=
 =?us-ascii?Q?QAn+9H1eJY5mBC4LLXMe5M19QHzxQhB6y4gvH91JB5DwRUPpqjz5nUAelh6A?=
 =?us-ascii?Q?GtafZJ+gl0GG1kVoqwmD/hDlh8eoRyXlRmxEpFKD1PukCb6XjYy6yrjos7V1?=
 =?us-ascii?Q?b0XwOpjRSWd2J4IvsfJVeJcBlM41S4hIvthfpFLdWTwBLEEdDYkIu6cPCgkO?=
 =?us-ascii?Q?cAFeHGZR1OAygQRoq79NHrR97eKqoecVX+EC/zQXnx/kVl45U+MBu0PwpRbj?=
 =?us-ascii?Q?a1kdOIluCiu2r4Es/DR9Zfc24UsEPxprs4yCGsyCc9E44nNONtr/MCIr8eCW?=
 =?us-ascii?Q?C6K/5HfAr+a9LyaZcI1KyC9BH0h7aRhXF/RN/TcauhD4v0jsA99IuGCznc3h?=
 =?us-ascii?Q?no9isWv5L20xnE69+7WIaQ5iwq0YEjnbPcxy3JcjJ0lUtqWulP4DiPUAbslO?=
 =?us-ascii?Q?sJ3pN/u6PwHcjzcHpyy9VbRa?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1801MB2070.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 439b1f5d-cd1b-423e-2585-08d955c29b5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2021 14:34:16.6359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xbCsn+ZPpni1LiffyA89ZPMTfoCf/JwtzwWo+bftyB8QUoE0LrLm3vcDwqYqQq9Ixvqg91NGUGFO7iYgcrqbig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR18MB1045
X-Proofpoint-ORIG-GUID: zMH_w3cvuADSPTGkM_DafBB9C_I5w9NC
X-Proofpoint-GUID: zMH_w3cvuADSPTGkM_DafBB9C_I5w9NC
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-02_05:2021-08-02,2021-08-02 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

>-----Original Message-----
>From: Will Deacon <will@kernel.org>
>Sent: Monday, August 2, 2021 4:04 PM
>To: Bhaskara Budiredla <bbudiredla@marvell.com>
>Cc: mark.rutland@arm.com; Sunil Kovvuri Goutham
><sgoutham@marvell.com>; linux-arm-kernel@lists.infradead.org; linux-
>kernel@vger.kernel.org; robh+dt@kernel.org; devicetree@vger.kernel.org
>Subject: [EXT] Re: [PATCH v2 1/1] drivers: perf: Add LLC-TAD perf counter
>support
>
>External Email
>
>----------------------------------------------------------------------
>On Mon, Jun 14, 2021 at 07:28:49PM +0530, Bhaskara Budiredla wrote:
>> This driver adds support for Last-level cache tag-and-data unit
>> (LLC-TAD) PMU that is featured in some of the Marvell's CN10K
>> infrastructure silicons.
>>
>> The LLC is divided into 2N slices distributed across N Mesh tiles in a
>> single-socket configuration. The driver always configures the same
>> counter for all of the TADs. The user would end up effectively
>> reserving one of eight counters in every TAD to look across all TADs.
>> The occurrences of events are aggregated and presented to the user at
>> the end of an application run. The driver does not provide a way for
>> the user to partition TADs so that different TADs are used for
>> different applications.
>>
>> The event counters are zeroed to start event counting to avoid any
>> rollover issues. TAD perf counters are 64-bit, so it's not currently
>> possible to overflow event counters at current mesh and core
>> frequencies.
>
>I couldn't spot where you disable sampling events, which rely heavily on
>detecting overflow. Probably need PERF_PMU_CAP_NO_INTERRUPT.

Sampling is not supported as counters are 64-bit. I will add
PERF_PMU_CAP_NO_INTERRUPT flag to pmu capabilities.

>
>> To measure tad pmu events use perf tool stat command. For instance:
>>
>> perf stat -e tad_dat_msh_in_dss,tad_req_msh_out_any <application> perf
>> stat -e tad_alloc_any,tad_hit_any,tad_tag_rd <application>
>>
>> Signed-off-by: Bhaskara Budiredla <bbudiredla@marvell.com>
>> ---
>>  .../bindings/perf/marvell-cn10k-tad-pmu.txt   |  20 +
>
>Adding the DT list for this ^^ as it looks a bit odd to me (also shouldn't=
 it be in
>YAML?)

It was just for reference. Actual entries expected to be
amended by ATF. I will fix the formatting.

>
>>  drivers/perf/Kconfig                          |   7 +
>>  drivers/perf/Makefile                         |   1 +
>>  drivers/perf/marvell_cn10k_tad_pmu.c          | 428 ++++++++++++++++++
>
>-ENODOCUMENTATION
>
>>  4 files changed, 456 insertions(+)
>>  create mode 100644
>> Documentation/devicetree/bindings/perf/marvell-cn10k-tad-pmu.txt
>>  create mode 100644 drivers/perf/marvell_cn10k_tad_pmu.c
>>
>> diff --git
>> a/Documentation/devicetree/bindings/perf/marvell-cn10k-tad-pmu.txt
>> b/Documentation/devicetree/bindings/perf/marvell-cn10k-tad-pmu.txt
>> new file mode 100644
>> index 000000000000..8b1f753303e2
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/perf/marvell-cn10k-tad-pmu.txt
>> @@ -0,0 +1,20 @@
>> +* Marvell CN10K LLC-TAD performace monitor unit
>> +
>> +Required properties:
>> +- compatible: must be:
>> +	"marvell,cn10k-tad-pmu"
>> +- tad-cnt: number of tad pmu regions
>> +- tad-page-size: size of entire tad block
>> +- tad-pmu-page-size: size of one tad pmu region
>> +- reg: physical address and size
>> +
>> +Example:
>> +
>> +/* Actual values updated by firmware at boot time */ tad_pmu {
>> +	compatible =3D "marvell,cn10k-tad-pmu";
>> +	tad-cnt =3D <1>;
>> +	tad-page-size =3D <0x1000>;
>> +	tad-pmu-page-size =3D <0x1000>;
>> +	reg =3D <0x87e2 0x80000000 0x0 0x1000>; };
>> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig index
>> 77522e5efe11..73dca11f8080 100644
>> --- a/drivers/perf/Kconfig
>> +++ b/drivers/perf/Kconfig
>> @@ -137,6 +137,13 @@ config ARM_DMC620_PMU
>>  	  Support for PMU events monitoring on the ARM DMC-620 memory
>>  	  controller.
>>
>> +config MARVELL_CN10K_TAD_PMU
>> +	tristate "Marvell CN10K LLC-TAD PMU"
>> +	depends on ARM64
>> +	help
>> +	  Provides support for Last-Level cache Tag-and-data Units (LLC-TAD)
>> +	  performance monitors on CN10K family silicons.
>> +
>>  source "drivers/perf/hisilicon/Kconfig"
>>
>>  endmenu
>> diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile index
>> 5260b116c7da..2db5418d5b0a 100644
>> --- a/drivers/perf/Makefile
>> +++ b/drivers/perf/Makefile
>> @@ -14,3 +14,4 @@ obj-$(CONFIG_THUNDERX2_PMU) +=3D
>thunderx2_pmu.o
>>  obj-$(CONFIG_XGENE_PMU) +=3D xgene_pmu.o
>>  obj-$(CONFIG_ARM_SPE_PMU) +=3D arm_spe_pmu.o
>>  obj-$(CONFIG_ARM_DMC620_PMU) +=3D arm_dmc620_pmu.o
>> +obj-$(CONFIG_MARVELL_CN10K_TAD_PMU) +=3D marvell_cn10k_tad_pmu.o
>> diff --git a/drivers/perf/marvell_cn10k_tad_pmu.c
>> b/drivers/perf/marvell_cn10k_tad_pmu.c
>> new file mode 100644
>> index 000000000000..99878de481f0
>> --- /dev/null
>> +++ b/drivers/perf/marvell_cn10k_tad_pmu.c
>> @@ -0,0 +1,428 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Marvell CN10K LLC-TAD perf driver
>> + *
>> + * Copyright (C) 2021 Marvell.
>> + *
>> + * This program is free software; you can redistribute it and/or
>> +modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#define pr_fmt(fmt) "tad_pmu: " fmt
>> +
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_device.h>
>> +#include <linux/cpuhotplug.h>
>> +#include <linux/perf_event.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/arm-smccc.h>
>> +
>> +#define TAD_PFC_OFFSET		0x0800
>> +#define TAD_PFC(counter)	(TAD_PFC_OFFSET | (counter << 3))
>> +#define TAD_PRF_OFFSET		0x0900
>> +#define TAD_PRF(counter)	(TAD_PRF_OFFSET | (counter << 3))
>> +#define TAD_PRF_CNTSEL_MASK	0xFF
>> +#define TAD_MAX_COUNTERS	8
>> +
>> +#define to_tad_pmu(p) (container_of(p, struct tad_pmu, pmu))
>> +
>> +struct tad_region {
>> +	void __iomem	*base;
>> +};
>> +
>> +struct tad_pmu {
>> +	struct pmu pmu;
>> +	struct tad_region *regions;
>> +	u32 region_cnt;
>> +	unsigned int cpu;
>> +	struct hlist_node node;
>> +	struct perf_event *events[TAD_MAX_COUNTERS];
>> +	DECLARE_BITMAP(counters_map, TAD_MAX_COUNTERS); };
>> +
>> +static int tad_pmu_cpuhp_state;
>> +
>> +static void tad_pmu_event_counter_read(struct perf_event *event) {
>> +	struct tad_pmu *tad_pmu =3D to_tad_pmu(event->pmu);
>> +	struct hw_perf_event *hwc =3D &event->hw;
>> +	u32 counter_idx =3D hwc->idx;
>> +	u64 delta, prev, new;
>> +	int i;
>> +
>> +	do {
>> +		prev =3D local64_read(&hwc->prev_count);
>> +		for (i =3D 0, new =3D 0; i < tad_pmu->region_cnt; i++)
>> +			new +=3D readq(tad_pmu->regions[i].base +
>> +				     TAD_PFC(counter_idx));
>> +	} while (local64_cmpxchg(&hwc->prev_count, prev, new) !=3D prev);
>> +
>> +	delta =3D (new - prev) & GENMASK_ULL(63, 0);
>> +	local64_add(delta, &event->count);
>> +}
>> +
>> +static void tad_pmu_event_counter_stop(struct perf_event *event, int
>> +flags) {
>> +	struct tad_pmu *tad_pmu =3D to_tad_pmu(event->pmu);
>> +	struct hw_perf_event *hwc =3D &event->hw;
>> +	u32 counter_idx =3D hwc->idx;
>> +	int i;
>> +
>> +	/* TAD()_PFC() stop counting on the write
>> +	 * which sets TAD()_PRF()[CNTSEL] =3D=3D 0
>> +	 */
>> +	for (i =3D 0; i < tad_pmu->region_cnt; i++)
>> +		writeq(0, tad_pmu->regions[i].base + TAD_PRF(counter_idx));
>
>writeq_relaxed() should be sufficient for this (and the others in this dri=
ver),
>no?

Yes, *_relaxed() is sufficient for writes. Taken.

>
>> +static ssize_t tad_pmu_event_show(struct device *dev,
>> +				struct device_attribute *attr, char *page) {
>> +	struct perf_pmu_events_attr *pmu_attr;
>> +
>> +	pmu_attr =3D container_of(attr, struct perf_pmu_events_attr, attr);
>> +	return sprintf(page, "event=3D0x%02llx\n", pmu_attr->id); }
>> +
>> +#define TAD_PMU_EVENT_ATTR(_name, _id)
>		\
>> +	(&((struct perf_pmu_events_attr[]) {				\
>> +		{ .attr =3D __ATTR(_name, 0444, tad_pmu_event_show, NULL),\
>> +		  .id =3D _id, }						\
>> +	})[0].attr.attr)
>
>Use PMU_EVENT_ATTR_ID instead?

Ok, taken.

>
>> +static int tad_pmu_probe(struct platform_device *pdev) {
>> +	struct device_node *node =3D pdev->dev.of_node;
>> +	struct tad_region *regions;
>> +	struct tad_pmu *tad_pmu;
>> +	struct resource *res;
>> +	u32 tad_pmu_page_size;
>> +	u32 tad_page_size;
>> +	u32 tad_cnt;
>> +	int i, ret;
>> +	char *name;
>> +
>> +	tad_pmu =3D devm_kzalloc(&pdev->dev, sizeof(*tad_pmu),
>GFP_KERNEL);
>> +	if (!tad_pmu)
>> +		return -ENOMEM;
>> +
>> +	platform_set_drvdata(pdev, tad_pmu);
>> +
>> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	if (!res) {
>> +		dev_err(&pdev->dev, "Mem resource not found\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	ret =3D of_property_read_u32(node, "tad-page-size", &tad_page_size);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "Can't find tad-page-size property\n");
>> +		return ret;
>> +	}
>> +
>> +	ret =3D of_property_read_u32(node, "tad-pmu-page-size",
>> +				   &tad_pmu_page_size);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "Can't find tad-pmu-page-size
>property\n");
>> +		return ret;
>> +	}
>> +
>> +	ret =3D of_property_read_u32(node, "tad-cnt", &tad_cnt);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "Can't find tad-cnt property\n");
>> +		return ret;
>> +	}
>> +
>> +	regions =3D kcalloc(tad_cnt, sizeof(*regions), GFP_KERNEL);
>
>devm_kcalloc() instead?

Agree, taken.

>
>Will
