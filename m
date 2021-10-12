Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7039A429F38
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 10:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235110AbhJLIFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 04:05:54 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:17534 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234849AbhJLIEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 04:04:48 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19C0730X030602;
        Tue, 12 Oct 2021 01:01:34 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by mx0b-0016f401.pphosted.com with ESMTP id 3bmpv4ukcs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Oct 2021 01:01:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nn4IJ4NAU1AmW5WI1m7xXcTZx7DO5M8RurXVXkeulHV9MDvXu/Gh3GqP7z61bCRNa0PmljmO8pTFCXYxfmZx4MPFEJFM2IwTc5dLAxTzX0LaHX7cKX7kXV5It5Xs857rjh4vg6C7DqNwBN6UgAHxti515t9wvea9fh/fcoKOWaDgAZFlgXVRGMTU8afmA5QMcPd2AHCZ0g6jfZ9eaaTHzZw9msW+saCEfJiZAQjKiDAAzrNtt2e98wZyvOecj79cDrdv9tllxcPvWIiIMUcztrEvlpJHRg13TCqI6WIgo/UHnNPBq2eIWZsXVb7O1HIk9X7A4I4RFMkWSp2E5TTVNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M6XQkOSPyNtb6Xw+rylY4S5HmGuvPgnxXZPtTcyCFJY=;
 b=TVSBR/SMi5/Irnsa6HRgHPKrKwp4VP62zPbzvqe4m12cuhRenYkFMME7miTEi0dGrL9foTkVbQDXNZSW46ZCwIwDWR8F8XJetrndUzQfkCf/f9YgQSaRlVlmqAVNkcKv+Owtnm9IzDuYkumcximXPVGT5W6xhpBqqgPKohkvVBxlWGXWsZj+30UXfImn/LNAODdjqWQ+Hi4Ig7xwotdqQMARF3wo+fDa6bBYgxn4rjiqMiVCgBBK3LnQ60mju5Kl+CSenjaILo4NbN2HIH+ejL6U9zoN4mAxMprkLGC+M1tGtvyXCOkxXZy5hbksg5yy0U34TaZafgN/dNvEnHyZlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M6XQkOSPyNtb6Xw+rylY4S5HmGuvPgnxXZPtTcyCFJY=;
 b=nRgaz/qFkCMnovb/mPO6jilVrtRUtGEC1dgPawarkVdvOw3LUFZx/teRKuWRgViDJkXD+UMSVFhSlwrXBumiC3ainrYxzAiw67KDFLPGqaPYt+ESdBTz0NGPA44eHqUiscjAQSDqk9hCUZ4G5pSIJGM3bYrpcHN8QXtUbC57MnM=
Received: from CO6PR18MB4465.namprd18.prod.outlook.com (2603:10b6:303:13b::10)
 by CO1PR18MB4697.namprd18.prod.outlook.com (2603:10b6:303:e4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Tue, 12 Oct
 2021 08:01:31 +0000
Received: from CO6PR18MB4465.namprd18.prod.outlook.com
 ([fe80::9da7:4d20:98ff:e441]) by CO6PR18MB4465.namprd18.prod.outlook.com
 ([fe80::9da7:4d20:98ff:e441%6]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 08:01:31 +0000
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     Bharat Bhushan <bbhushan2@marvell.com>,
        "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bhaskara Budiredla <bbudiredla@marvell.com>
Subject: RE: [PATCH v4 2/4] perf/marvell: CN10k DDR performance monitor
 support
Thread-Topic: [PATCH v4 2/4] perf/marvell: CN10k DDR performance monitor
 support
Thread-Index: AQHXrd2Tdoh8fcjm302tQkFioaOIjKvPIvVw
Date:   Tue, 12 Oct 2021 08:01:30 +0000
Message-ID: <CO6PR18MB4465FC607A2836EE98807965E3B69@CO6PR18MB4465.namprd18.prod.outlook.com>
References: <20210920050823.10853-1-bbhushan2@marvell.com>
 <20210920050823.10853-3-bbhushan2@marvell.com>
In-Reply-To: <20210920050823.10853-3-bbhushan2@marvell.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 40d12eb4-3b52-47df-80b8-08d98d568064
x-ms-traffictypediagnostic: CO1PR18MB4697:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR18MB4697F215E6E01394D8D13147E3B69@CO1PR18MB4697.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ChxKl8GvSNIFeNpKCj9GH+2T9q5qGicEr/l8DSbLpmohSsH8EswHLoPa+upUm9oKiLKkMifdRKfRFhvk27OcYF+Kda1BvyauCaneqF5ZIh4ya8/1OkMskUdK2L6mB/jizChaUvNwnwJtPRECDoSo0RZ8TyWhmEC02RHFJVofxjrgmQJKon842X/2cUF7JeooatCfMd03XD+s+D0Ke+WGJ62VzgXs0N9/2yME/70NicsiZ60BoAXhXeX5xXXFouutwoVL8+gOhbWIznEspFS0I0OZ119xvy3QLXckvlixRHvvAo09PwDIT9XuebtUPpWd9P/fkD/D4WRXzv8oZUvU2ZtioyC51reKGoAx+Sdn+W7CCNHoNPa75WmoUFYl0+QS+tH0evIwRk6WoYohqrAxF6trlW9E4SmGNEXS1INMl6f4c4yUUX+Vi5NhZ/r/gDtWArhGjC9MTO3b7VvzjMwnA9q8rM3W4ZopTX/oxwHhFiHGAzDHXnvZ9faeQX2+3bf2X5FlJTfVpJItGdeWazRSvIfphgp3PErR+x+f9MbyKnz9EzPmGxECaLjOU0S1dXzjsD6MDfDL2XynVmyxn1Y1toLidjZAwflDNIT1INB+YdXu3YjOUelqq3J4NRK3jcFb6sCQycm5oJO0SLsVZAfqTCaIoWFwN5GB2m1gv3tb8S4fhoiE+Ui96GFTR2SRYcA2Qu5lWMN8AZDObBVaNbYcDg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR18MB4465.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(83380400001)(66946007)(66476007)(66556008)(64756008)(66446008)(30864003)(8676002)(71200400001)(186003)(2906002)(76116006)(508600001)(7696005)(52536014)(86362001)(316002)(5660300002)(38100700002)(55016002)(53546011)(6506007)(38070700005)(6636002)(26005)(33656002)(9686003)(110136005)(122000001)(579004)(559001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mLiMcce5dS5Ord+u8867HmO+bEDqORifJhEBXBE2WacaR1LfD4WolQESv+/b?=
 =?us-ascii?Q?3cAm8orDc3SG/vY/dAFgUk4qtbo0xhAegqJhMJiKU9huCEO6vdFT2M9kw0SN?=
 =?us-ascii?Q?HDkM/+f+Vwc9b/oFvpQ7/wLGQDKYQyj37QyR6zlJtgnhkWjed4FHk+HsufXE?=
 =?us-ascii?Q?JTwCNpbXu3BbXps7sCQlOFtGhV7kXChylSzjNCTZYlf0M8tkQr/q2gEYBpER?=
 =?us-ascii?Q?v2fbSGRjj/yC84z+ISKXhmuSoRdvsjeLxLqXvGvQ0dDIcjwELNb+A3rCoTQu?=
 =?us-ascii?Q?XybD2F9zHzOdFkgVg08+qIN+f07WHdt3cz0Alfu9EqclmoKk/2oon6iOXtPU?=
 =?us-ascii?Q?uykSQZxspskVSUEAPrtoEOB1NBHvnlZPNc9EbjkBb4qWSm6IzLg65OLZAO2j?=
 =?us-ascii?Q?ZVxCrsUJZDyqZo8iZjW9gtq9AXNhQLTRYqhqcyaSGNbnPXOTat+Ikc8lrRnB?=
 =?us-ascii?Q?WYMokAlwBvBiBEkxHTdNHg4ox+oA2x2CEeHkw12mXDTvgi78AjJw0xiKO8Kb?=
 =?us-ascii?Q?TpecaKVfnk93IUZyM17JwdHelYOPSvHHszjfAcgjpvr5OBpFacPqDzgEag6+?=
 =?us-ascii?Q?c1DWhApt/G/+IfCtCV3f7Qe4rp3gWN39Ng/EVA1/hnnYkofHcAH9WZWCvWRM?=
 =?us-ascii?Q?PLeQ94LcHCQpe/yob97N4fQSj6vkO/sy0GUpPxuwp/nXlFJMhWrTGxiyXeMn?=
 =?us-ascii?Q?B6TOPUT3JTMO4MhFbPODTmPRDMWAUSu6GX6ta/xegltRzjwd4EwvuyZGJ7hW?=
 =?us-ascii?Q?r3/IytYBeo3UcAD14AyOJah+9/kWYAWjF2Fku2ckX5ADQIZxyZNV9MSmhQ5B?=
 =?us-ascii?Q?qLVFtbsk446VnJPLxw2A0n/EeC4CoSIH3tlVPy5DWVJftwgSeQXi8NJfjmcQ?=
 =?us-ascii?Q?P/zslG/xgW+WmrKma1BN8DmM2yoMagQ5behN1C3gWSavlRH1e2PUM845mz45?=
 =?us-ascii?Q?Hc9I25MCbrj2BUoKMnOfatXvAQ4euSa/AsnSt2D7BhGjx+a9fPwFPRU5cKns?=
 =?us-ascii?Q?lfbfFwKE56yTJYzRBPGqBekazkDcBdv7Q3HI7ovBgtZ1Dc4wVW4Wa6aCa/p3?=
 =?us-ascii?Q?Q9jYcL39G97BTU4GACvfyIItmiKNg29meizVkEOLYINHlBwzmd702v6rF4es?=
 =?us-ascii?Q?BI7hH5MN8buJhl4ujRItxWKK+JwONNAItDbgpC5rUQpA4g3SV/+jpvKm8dtm?=
 =?us-ascii?Q?5gOwfONULF36S2TDmRu2GkBuNnWefe5xfedeA6/0k1rwba4mLlVbU8fWLxrO?=
 =?us-ascii?Q?lzptkee6OqmJKWjC6t80OJQnaosw4wxvMl3HJh53h9/ESd69VTz/HBLWvYNx?=
 =?us-ascii?Q?EL6sxAL+4uNiJezMY8NIS9b1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4465.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40d12eb4-3b52-47df-80b8-08d98d568064
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2021 08:01:30.7642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oGNpXQQXNTTsPAvlPChe3bD31CSs2XDrwVy6gqctDlfsimVmTqH8gWXXHm+2rK4G9Z9kyM6rU70FS8JwJoffTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR18MB4697
X-Proofpoint-ORIG-GUID: UwtzdNZvE3jd5fqXeDv8DnmEnGx8bPHS
X-Proofpoint-GUID: UwtzdNZvE3jd5fqXeDv8DnmEnGx8bPHS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-12_01,2021-10-11_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Bhaskara

> -----Original Message-----
> From: Bharat Bhushan <bbhushan2@marvell.com>
> Sent: Monday, September 20, 2021 10:38 AM
> To: will@kernel.org; mark.rutland@arm.com; robh+dt@kernel.org; linux-arm-
> kernel@lists.infradead.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: Bharat Bhushan <bbhushan2@marvell.com>
> Subject: [PATCH v4 2/4] perf/marvell: CN10k DDR performance monitor suppo=
rt
>=20
> Marvell CN10k DRAM Subsystem (DSS) supports eight event counters for
> monitoring performance and software can program each counter to monitor a=
ny
> of the defined performance event. Performance events are for interface be=
tween
> the DDR controller and the PHY, interface between the DDR Controller and =
the
> CHI interconnect, or within the DDR Controller.
> Additionally DSS also supports two fixed performance event counters, one =
for
> number of ddr reads and other for ddr writes.
>=20
> This patch add basic support for these performance monitoring events on C=
N10k.
>=20
> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> ---
> v3->v4:
>  - No Change
>=20
> v2->v3:
>  - Add COMPILE_TEST as a dependency
>  - Switch to sysfs_emit()
>  - Error propagation when invalif event requested
>  - Switch to devm_platform_get_and_ioremap_resource()
>  - Other review comments on v2.
>=20
> v1->v2:
>   - writeq/readq changed to respective relaxed version
>   - Using PMU_EVENT_ATTR_ID
>=20
>  drivers/perf/Kconfig                 |   7 +
>  drivers/perf/Makefile                |   1 +
>  drivers/perf/marvell_cn10k_ddr_pmu.c | 599 +++++++++++++++++++++++++++
>  3 files changed, 607 insertions(+)
>  create mode 100644 drivers/perf/marvell_cn10k_ddr_pmu.c
>=20
> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig index
> 77522e5efe11..41a80a4b8d29 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -139,4 +139,11 @@ config ARM_DMC620_PMU
>=20
>  source "drivers/perf/hisilicon/Kconfig"
>=20
> +config MARVELL_CN10K_DDR_PMU
> +	tristate "Enable MARVELL CN10K DRAM Subsystem(DSS) PMU Support"
> +	depends on ARM64
> +	help
> +	  Enable perf support for Marvell DDR Performance monitoring
> +	  event on CN10K platform.
> +
>  endmenu
> diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile index
> 5260b116c7da..ee1126219d8d 100644
> --- a/drivers/perf/Makefile
> +++ b/drivers/perf/Makefile
> @@ -14,3 +14,4 @@ obj-$(CONFIG_THUNDERX2_PMU) +=3D thunderx2_pmu.o
>  obj-$(CONFIG_XGENE_PMU) +=3D xgene_pmu.o
>  obj-$(CONFIG_ARM_SPE_PMU) +=3D arm_spe_pmu.o
>  obj-$(CONFIG_ARM_DMC620_PMU) +=3D arm_dmc620_pmu.o
> +obj-$(CONFIG_MARVELL_CN10K_DDR_PMU) +=3D marvell_cn10k_ddr_pmu.o
> diff --git a/drivers/perf/marvell_cn10k_ddr_pmu.c
> b/drivers/perf/marvell_cn10k_ddr_pmu.c
> new file mode 100644
> index 000000000000..9b6d5e716b94
> --- /dev/null
> +++ b/drivers/perf/marvell_cn10k_ddr_pmu.c
> @@ -0,0 +1,599 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Marvell CN10K DRAM Subsystem (DSS) Performance Monitor Driver
> + *
> + * Copyright (C) 2021 Marvell.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/perf_event.h>
> +
> +/* Performance Counters Operating Mode Control Registers */
> +#define DDRC_PERF_CNT_OP_MODE_CTRL	0x8020
> +#define OP_MODE_CTRL_VAL_MANNUAL	0x1
> +
> +/* Performance Counters Start Operation Control Registers */
> +#define DDRC_PERF_CNT_START_OP_CTRL	0x8028
> +#define START_OP_CTRL_VAL_START		0x1ULL
> +#define START_OP_CTRL_VAL_ACTIVE	0x2
> +
> +/* Performance Counters End Operation Control Registers */
> +#define DDRC_PERF_CNT_END_OP_CTRL	0x8030
> +#define END_OP_CTRL_VAL_END		0x1ULL
> +
> +/* Performance Counters End Status Registers */
> +#define DDRC_PERF_CNT_END_STATUS		0x8038
> +#define END_STATUS_VAL_END_TIMER_MODE_END	0x1
> +
> +/* Performance Counters Configuration Registers */
> +#define DDRC_PERF_CFG_BASE		0x8040
> +
> +/* 8 Generic event counter + 2 fixed event counters */
> +#define DDRC_PERF_NUM_GEN_COUNTERS	8
> +#define DDRC_PERF_NUM_FIX_COUNTERS	2
> +#define DDRC_PERF_READ_COUNTER_IDX
> 	DDRC_PERF_NUM_GEN_COUNTERS
> +#define DDRC_PERF_WRITE_COUNTER_IDX
> 	(DDRC_PERF_NUM_GEN_COUNTERS + 1)
> +#define DDRC_PERF_NUM_COUNTERS
> 	(DDRC_PERF_NUM_GEN_COUNTERS + \
> +					 DDRC_PERF_NUM_FIX_COUNTERS)
> +
> +/* Generic event counter registers */
> +#define DDRC_PERF_CFG(n)		(DDRC_PERF_CFG_BASE + 8 * (n))
> +#define EVENT_ENABLE			BIT_ULL(63)
> +
> +/* Two dedicated event counters for DDR reads and writes */
> +#define EVENT_DDR_READS			101
> +#define EVENT_DDR_WRITES		100
> +
> +/*
> + * programmable events IDs in programmable event counters.
> + * DO NOT change these event-id numbers, they are used to
> + * program event bitmap in h/w.
> + */
> +#define EVENT_OP_IS_ZQLATCH			55
> +#define EVENT_OP_IS_ZQSTART			54
> +#define EVENT_OP_IS_TCR_MRR			53
> +#define EVENT_OP_IS_DQSOSC_MRR			52
> +#define EVENT_OP_IS_DQSOSC_MPC			51
> +#define EVENT_VISIBLE_WIN_LIMIT_REACHED_WR	50
> +#define EVENT_VISIBLE_WIN_LIMIT_REACHED_RD	49
> +#define EVENT_BSM_STARVATION			48
> +#define EVENT_BSM_ALLOC				47
> +#define EVENT_LPR_REQ_WITH_NOCREDIT		46
> +#define EVENT_HPR_REQ_WITH_NOCREDIT		45
> +#define EVENT_OP_IS_ZQCS			44
> +#define EVENT_OP_IS_ZQCL			43
> +#define EVENT_OP_IS_LOAD_MODE			42
> +#define EVENT_OP_IS_SPEC_REF			41
> +#define EVENT_OP_IS_CRIT_REF			40
> +#define EVENT_OP_IS_REFRESH			39
> +#define EVENT_OP_IS_ENTER_MPSM			35
> +#define EVENT_OP_IS_ENTER_POWERDOWN		31
> +#define EVENT_OP_IS_ENTER_SELFREF		27
> +#define EVENT_WAW_HAZARD			26
> +#define EVENT_RAW_HAZARD			25
> +#define EVENT_WAR_HAZARD			24
> +#define EVENT_WRITE_COMBINE			23
> +#define EVENT_RDWR_TRANSITIONS			22
> +#define EVENT_PRECHARGE_FOR_OTHER		21
> +#define EVENT_PRECHARGE_FOR_RDWR		20
> +#define EVENT_OP_IS_PRECHARGE			19
> +#define EVENT_OP_IS_MWR				18
> +#define EVENT_OP_IS_WR				17
> +#define EVENT_OP_IS_RD				16
> +#define EVENT_OP_IS_RD_ACTIVATE			15
> +#define EVENT_OP_IS_RD_OR_WR			14
> +#define EVENT_OP_IS_ACTIVATE			13
> +#define EVENT_WR_XACT_WHEN_CRITICAL		12
> +#define EVENT_LPR_XACT_WHEN_CRITICAL		11
> +#define EVENT_HPR_XACT_WHEN_CRITICAL		10
> +#define EVENT_DFI_RD_DATA_CYCLES		9
> +#define EVENT_DFI_WR_DATA_CYCLES		8
> +#define EVENT_ACT_BYPASS			7
> +#define EVENT_READ_BYPASS			6
> +#define EVENT_HIF_HI_PRI_RD			5
> +#define EVENT_HIF_RMW				4
> +#define EVENT_HIF_RD				3
> +#define EVENT_HIF_WR				2
> +#define EVENT_HIF_RD_OR_WR			1
> +
> +/* Event counter value registers */
> +#define DDRC_PERF_CNT_VALUE_BASE		0x8080
> +#define DDRC_PERF_CNT_VALUE(n)	(DDRC_PERF_CNT_VALUE_BASE + 8 * (n))
> +
> +/* Fixed event counter enable/disable register */
> +#define DDRC_PERF_CNT_FREERUN_EN	0x80C0
> +#define DDRC_PERF_FREERUN_WRITE_EN	0x1
> +#define DDRC_PERF_FREERUN_READ_EN	0x2
> +
> +/* Fixed event counter control register */
> +#define DDRC_PERF_CNT_FREERUN_CTRL	0x80C8
> +#define DDRC_FREERUN_WRITE_CNT_CLR	0x1
> +#define DDRC_FREERUN_READ_CNT_CLR	0x2
> +
> +/* Fixed event counter value register */
> +#define DDRC_PERF_CNT_VALUE_WR_OP	0x80D0
> +#define DDRC_PERF_CNT_VALUE_RD_OP	0x80D8
> +#define DDRC_PERF_CNT_VALUE_OVERFLOW	BIT_ULL(48)
> +#define DDRC_PERF_CNT_MAX_VALUE		GENMASK_ULL(48, 0)
> +
> +struct cn10k_ddr_pmu {
> +	struct pmu pmu;
> +	void __iomem *base;
> +	unsigned int cpu;
> +	struct	device *dev;
> +	int active_events;
> +	struct perf_event *events[DDRC_PERF_NUM_COUNTERS]; };
> +
> +#define to_cn10k_ddr_pmu(p)	container_of(p, struct cn10k_ddr_pmu,
> pmu)
> +
> +static ssize_t cn10k_ddr_pmu_event_show(struct device *dev,
> +					struct device_attribute *attr,
> +					char *page)
> +{
> +	struct perf_pmu_events_attr *pmu_attr;
> +
> +	pmu_attr =3D container_of(attr, struct perf_pmu_events_attr, attr);
> +	return sysfs_emit(page, "event=3D0x%02llx\n", pmu_attr->id);
> +
> +}
> +
> +#define CN10K_DDR_PMU_EVENT_ATTR(_name, _id)
> \
> +	PMU_EVENT_ATTR_ID(_name, cn10k_ddr_pmu_event_show, _id)
> +
> +static struct attribute *cn10k_ddr_perf_events_attrs[] =3D {
> +	CN10K_DDR_PMU_EVENT_ATTR(ddr_hif_rd_or_wr_access,
> EVENT_HIF_RD_OR_WR),
> +	CN10K_DDR_PMU_EVENT_ATTR(ddr_hif_wr_access, EVENT_HIF_WR),
> +	CN10K_DDR_PMU_EVENT_ATTR(ddr_hif_rd_access, EVENT_HIF_RD),
> +	CN10K_DDR_PMU_EVENT_ATTR(ddr_hif_rmw_access,
> EVENT_HIF_RMW),
> +	CN10K_DDR_PMU_EVENT_ATTR(ddr_hif_pri_rdaccess,
> EVENT_HIF_HI_PRI_RD),
> +	CN10K_DDR_PMU_EVENT_ATTR(ddr_rd_bypass_access,
> EVENT_READ_BYPASS),
> +	CN10K_DDR_PMU_EVENT_ATTR(ddr_act_bypass_access,
> EVENT_ACT_BYPASS),
> +	CN10K_DDR_PMU_EVENT_ATTR(ddr_dif_wr_data_access,
> EVENT_DFI_WR_DATA_CYCLES),
> +	CN10K_DDR_PMU_EVENT_ATTR(ddr_dif_rd_data_access,
> EVENT_DFI_RD_DATA_CYCLES),
> +	CN10K_DDR_PMU_EVENT_ATTR(ddr_hpri_sched_rd_crit_access,
> +					EVENT_HPR_XACT_WHEN_CRITICAL),
> +	CN10K_DDR_PMU_EVENT_ATTR(ddr_lpri_sched_rd_crit_access,
> +					EVENT_LPR_XACT_WHEN_CRITICAL),
> +	CN10K_DDR_PMU_EVENT_ATTR(ddr_wr_trxn_crit_access,
> +					EVENT_WR_XACT_WHEN_CRITICAL),
> +	CN10K_DDR_PMU_EVENT_ATTR(ddr_cam_active_access,
> EVENT_OP_IS_ACTIVATE),
> +	CN10K_DDR_PMU_EVENT_ATTR(ddr_cam_rd_or_wr_access,
> EVENT_OP_IS_RD_OR_WR),
> +	CN10K_DDR_PMU_EVENT_ATTR(ddr_cam_rd_active_access,
> EVENT_OP_IS_RD_ACTIVATE),
> +	CN10K_DDR_PMU_EVENT_ATTR(ddr_cam_read, EVENT_OP_IS_RD),
> +	CN10K_DDR_PMU_EVENT_ATTR(ddr_cam_write, EVENT_OP_IS_WR),
> +	CN10K_DDR_PMU_EVENT_ATTR(ddr_cam_mwr, EVENT_OP_IS_MWR),
> +	CN10K_DDR_PMU_EVENT_ATTR(ddr_precharge,
> EVENT_OP_IS_PRECHARGE),
> +	CN10K_DDR_PMU_EVENT_ATTR(ddr_precharge_for_rdwr,
> EVENT_PRECHARGE_FOR_RDWR),
> +	CN10K_DDR_PMU_EVENT_ATTR(ddr_precharge_for_other,
> +					EVENT_PRECHARGE_FOR_OTHER),
> +	CN10K_DDR_PMU_EVENT_ATTR(ddr_rdwr_transitions,
> EVENT_RDWR_TRANSITIONS),
> +	CN10K_DDR_PMU_EVENT_ATTR(ddr_write_combine,
> EVENT_WRITE_COMBINE),
> +	CN10K_DDR_PMU_EVENT_ATTR(ddr_war_hazard,
> EVENT_WAR_HAZARD),
> +	CN10K_DDR_PMU_EVENT_ATTR(ddr_raw_hazard,
> EVENT_RAW_HAZARD),
> +	CN10K_DDR_PMU_EVENT_ATTR(ddr_waw_hazard,
> EVENT_WAW_HAZARD),
> +	CN10K_DDR_PMU_EVENT_ATTR(ddr_enter_selfref,
> EVENT_OP_IS_ENTER_SELFREF),
> +	CN10K_DDR_PMU_EVENT_ATTR(ddr_enter_powerdown,
> EVENT_OP_IS_ENTER_POWERDOWN),
> +	CN10K_DDR_PMU_EVENT_ATTR(ddr_enter_mpsm,
> EVENT_OP_IS_ENTER_MPSM),
> +	CN10K_DDR_PMU_EVENT_ATTR(ddr_refresh, EVENT_OP_IS_REFRESH),
> +	CN10K_DDR_PMU_EVENT_ATTR(ddr_crit_ref, EVENT_OP_IS_CRIT_REF),
> +	CN10K_DDR_PMU_EVENT_ATTR(ddr_spec_ref, EVENT_OP_IS_SPEC_REF),
> +	CN10K_DDR_PMU_EVENT_ATTR(ddr_load_mode,
> EVENT_OP_IS_LOAD_MODE),
> +	CN10K_DDR_PMU_EVENT_ATTR(ddr_zqcl, EVENT_OP_IS_ZQCL),
> +	CN10K_DDR_PMU_EVENT_ATTR(ddr_cam_wr_access,
> EVENT_OP_IS_ZQCS),
> +	CN10K_DDR_PMU_EVENT_ATTR(ddr_hpr_req_with_nocredit,
> +					EVENT_HPR_REQ_WITH_NOCREDIT),
> +	CN10K_DDR_PMU_EVENT_ATTR(ddr_lpr_req_with_nocredit,
> +					EVENT_LPR_REQ_WITH_NOCREDIT),
> +	CN10K_DDR_PMU_EVENT_ATTR(ddr_bsm_alloc, EVENT_BSM_ALLOC),
> +	CN10K_DDR_PMU_EVENT_ATTR(ddr_bsm_starvation,
> EVENT_BSM_STARVATION),
> +	CN10K_DDR_PMU_EVENT_ATTR(ddr_win_limit_reached_rd,
> +
> 	EVENT_VISIBLE_WIN_LIMIT_REACHED_RD),
> +	CN10K_DDR_PMU_EVENT_ATTR(ddr_win_limit_reached_wr,
> +
> 	EVENT_VISIBLE_WIN_LIMIT_REACHED_WR),
> +	CN10K_DDR_PMU_EVENT_ATTR(ddr_dqsosc_mpc,
> EVENT_OP_IS_DQSOSC_MPC),
> +	CN10K_DDR_PMU_EVENT_ATTR(ddr_dqsosc_mrr,
> EVENT_OP_IS_DQSOSC_MRR),
> +	CN10K_DDR_PMU_EVENT_ATTR(ddr_tcr_mrr, EVENT_OP_IS_TCR_MRR),
> +	CN10K_DDR_PMU_EVENT_ATTR(ddr_zqstart, EVENT_OP_IS_ZQSTART),
> +	CN10K_DDR_PMU_EVENT_ATTR(ddr_zqlatch, EVENT_OP_IS_ZQLATCH),
> +	/* Free run event counters */
> +	CN10K_DDR_PMU_EVENT_ATTR(ddr_ddr_reads, EVENT_DDR_READS),
> +	CN10K_DDR_PMU_EVENT_ATTR(ddr_ddr_writes, EVENT_DDR_WRITES),
> +	NULL
> +};
> +
> +static struct attribute_group cn10k_ddr_perf_events_attr_group =3D {
> +	.name =3D "events",
> +	.attrs =3D cn10k_ddr_perf_events_attrs,
> +};
> +
> +PMU_FORMAT_ATTR(event, "config:0-8");
> +
> +static struct attribute *cn10k_ddr_perf_format_attrs[] =3D {
> +	&format_attr_event.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group cn10k_ddr_perf_format_attr_group =3D {
> +	.name =3D "format",
> +	.attrs =3D cn10k_ddr_perf_format_attrs,
> +};
> +
> +static ssize_t cn10k_ddr_perf_cpumask_show(struct device *dev,
> +					   struct device_attribute *attr,
> +					   char *buf)
> +{
> +	struct cn10k_ddr_pmu *pmu =3D dev_get_drvdata(dev);
> +
> +	return cpumap_print_to_pagebuf(true, buf, cpumask_of(pmu->cpu)); }
> +
> +static struct device_attribute cn10k_ddr_perf_cpumask_attr =3D
> +	__ATTR(cpumask, 0444, cn10k_ddr_perf_cpumask_show, NULL);
> +
> +static struct attribute *cn10k_ddr_perf_cpumask_attrs[] =3D {
> +	&cn10k_ddr_perf_cpumask_attr.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group cn10k_ddr_perf_cpumask_attr_group =3D {
> +	.attrs =3D cn10k_ddr_perf_cpumask_attrs, };
> +
> +static const struct attribute_group *cn10k_attr_groups[] =3D {
> +	&cn10k_ddr_perf_events_attr_group,
> +	&cn10k_ddr_perf_format_attr_group,
> +	&cn10k_ddr_perf_cpumask_attr_group,
> +	NULL,
> +};
> +
> +static int ddr_perf_get_event_bitmap(int eventid, u64 *event_bitmap) {
> +	switch (eventid) {
> +	case EVENT_HIF_RD_OR_WR ... EVENT_WAW_HAZARD:
> +	case EVENT_OP_IS_REFRESH ... EVENT_OP_IS_ZQLATCH:
> +		*event_bitmap =3D (1ULL << (eventid - 1));
> +		break;
> +	case EVENT_OP_IS_ENTER_SELFREF:
> +	case EVENT_OP_IS_ENTER_POWERDOWN:
> +	case EVENT_OP_IS_ENTER_MPSM:
> +		*event_bitmap =3D (0xFULL << (eventid - 1));
> +		break;
> +	default:
> +		pr_err("%s Invalid eventid %d\n", __func__, eventid);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cn10k_ddr_perf_alloc_counter(struct cn10k_ddr_pmu *pmu,
> +					struct perf_event *event)
> +{
> +	u8 config =3D event->attr.config;
> +	int i;
> +
> +	/* DDR read free-run counter index */
> +	if (config =3D=3D EVENT_DDR_READS) {
> +		pmu->events[DDRC_PERF_READ_COUNTER_IDX] =3D event;
> +		return DDRC_PERF_READ_COUNTER_IDX;
> +	}
> +
> +	/* DDR write free-run counter index */
> +	if (config =3D=3D EVENT_DDR_WRITES) {
> +		pmu->events[DDRC_PERF_WRITE_COUNTER_IDX] =3D event;
> +		return DDRC_PERF_WRITE_COUNTER_IDX;
> +	}
> +
> +	/* Allocate DDR generic counters */
> +	for (i =3D 0; i < DDRC_PERF_NUM_GEN_COUNTERS; i++) {
> +		if (pmu->events[i] =3D=3D NULL) {
> +			pmu->events[i] =3D event;
> +			return i;
> +		}
> +	}
> +
> +	return -ENOENT;
> +}
> +
> +static void cn10k_ddr_perf_free_counter(struct cn10k_ddr_pmu *pmu, int
> +counter) {
> +	pmu->events[counter] =3D NULL;
> +}
> +
> +static int cn10k_ddr_perf_event_init(struct perf_event *event) {
> +	struct cn10k_ddr_pmu *pmu =3D to_cn10k_ddr_pmu(event->pmu);
> +	struct hw_perf_event *hwc =3D &event->hw;
> +
> +	if (event->attr.type !=3D event->pmu->type)
> +		return -ENOENT;
> +
> +	if (is_sampling_event(event)) {
> +		dev_info(pmu->dev, "Sampling not supported!\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (event->cpu < 0) {
> +		dev_warn(pmu->dev, "Can't provide per-task data!\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	/*  We must NOT create groups containing mixed PMUs */
> +	if (event->group_leader->pmu !=3D event->pmu &&
> +	    !is_software_event(event->group_leader))
> +		return -EINVAL;
> +
> +	/* Set ownership of event to one CPU, same event can not be observed
> +	 * on multiple cpus at same time.
> +	 */
> +	event->cpu =3D pmu->cpu;
> +	hwc->idx =3D -1;
> +	return 0;
> +}
> +
> +static void cn10k_ddr_perf_counter_enable(struct cn10k_ddr_pmu *pmu,
> +					  int counter, bool enable)
> +{
> +	u32 reg;
> +	u64 val;
> +
> +	if (counter > DDRC_PERF_NUM_COUNTERS) {
> +		pr_err("Error: unsupported counter %d\n", counter);
> +		return;
> +	}
> +
> +	if (counter < DDRC_PERF_NUM_GEN_COUNTERS) {
> +		reg =3D DDRC_PERF_CFG(counter);
> +		val =3D readq_relaxed(pmu->base + reg);
> +
> +		if (enable)
> +			val |=3D EVENT_ENABLE;
> +		else
> +			val &=3D ~EVENT_ENABLE;
> +
> +		writeq_relaxed(val, pmu->base + reg);
> +	} else {
> +		val =3D readq_relaxed(pmu->base +
> DDRC_PERF_CNT_FREERUN_EN);
> +		if (enable) {
> +			if (counter =3D=3D DDRC_PERF_READ_COUNTER_IDX)
> +				val |=3D DDRC_PERF_FREERUN_READ_EN;
> +			else
> +				val |=3D DDRC_PERF_FREERUN_WRITE_EN;
> +		} else {
> +			if (counter =3D=3D DDRC_PERF_READ_COUNTER_IDX)
> +				val &=3D ~DDRC_PERF_FREERUN_READ_EN;
> +			else
> +				val &=3D ~DDRC_PERF_FREERUN_WRITE_EN;
> +		}
> +		writeq_relaxed(val, pmu->base +
> DDRC_PERF_CNT_FREERUN_EN);
> +	}
> +}
> +
> +static u64 cn10k_ddr_perf_read_counter(struct cn10k_ddr_pmu *pmu, int
> +counter) {
> +	u64 val;
> +
> +	if (counter =3D=3D DDRC_PERF_READ_COUNTER_IDX)
> +		return readq_relaxed(pmu->base +
> DDRC_PERF_CNT_VALUE_RD_OP);
> +
> +	if (counter =3D=3D DDRC_PERF_WRITE_COUNTER_IDX)
> +		return readq_relaxed(pmu->base +
> DDRC_PERF_CNT_VALUE_WR_OP);
> +
> +	val =3D readq_relaxed(pmu->base + DDRC_PERF_CNT_VALUE(counter));
> +	return val;
> +}
> +
> +static void cn10k_ddr_perf_event_update(struct perf_event *event) {
> +	struct cn10k_ddr_pmu *pmu =3D to_cn10k_ddr_pmu(event->pmu);
> +	struct hw_perf_event *hwc =3D &event->hw;
> +	u64 prev_count, new_count, mask;
> +
> +	do {
> +		prev_count =3D local64_read(&hwc->prev_count);
> +		new_count =3D cn10k_ddr_perf_read_counter(pmu, hwc->idx);
> +	} while (local64_xchg(&hwc->prev_count, new_count) !=3D prev_count);
> +
> +	mask =3D DDRC_PERF_CNT_MAX_VALUE;
> +
> +	local64_add((new_count - prev_count) & mask, &event->count); }
> +
> +static void cn10k_ddr_perf_event_start(struct perf_event *event, int
> +flags) {
> +	struct cn10k_ddr_pmu *pmu =3D to_cn10k_ddr_pmu(event->pmu);
> +	struct hw_perf_event *hwc =3D &event->hw;
> +	int counter =3D hwc->idx;
> +
> +	local64_set(&hwc->prev_count, 0);
> +
> +	cn10k_ddr_perf_counter_enable(pmu, counter, true);
> +
> +	hwc->state =3D 0;
> +}
> +
> +static int cn10k_ddr_perf_event_add(struct perf_event *event, int
> +flags) {
> +	struct cn10k_ddr_pmu *pmu =3D to_cn10k_ddr_pmu(event->pmu);
> +	struct hw_perf_event *hwc =3D &event->hw;
> +	u8 config =3D event->attr.config;
> +	int counter, ret;
> +	u32 reg_offset;
> +	u64 val;
> +
> +	counter =3D cn10k_ddr_perf_alloc_counter(pmu, event);
> +	if (counter < 0)
> +		return -EAGAIN;
> +
> +	pmu->active_events++;
> +	hwc->idx =3D counter;
> +
> +	if (counter < DDRC_PERF_NUM_GEN_COUNTERS) {
> +		/* Generic counters, configure event id */
> +		reg_offset =3D DDRC_PERF_CFG(counter);
> +		ret =3D ddr_perf_get_event_bitmap(config, &val);
> +		if (ret)
> +			return ret;
> +
> +		writeq_relaxed(val, pmu->base + reg_offset);
> +	} else {
> +		/* fixed event counter, clear counter value */
> +		if (counter =3D=3D DDRC_PERF_READ_COUNTER_IDX)
> +			val =3D DDRC_FREERUN_READ_CNT_CLR;
> +		else
> +			val =3D DDRC_FREERUN_WRITE_CNT_CLR;
> +
> +		writeq_relaxed(val, pmu->base +
> DDRC_PERF_CNT_FREERUN_CTRL);
> +	}
> +
> +	hwc->state |=3D PERF_HES_STOPPED;
> +
> +	if (flags & PERF_EF_START)
> +		cn10k_ddr_perf_event_start(event, flags);
> +
> +	return 0;
> +}
> +
> +static void cn10k_ddr_perf_event_stop(struct perf_event *event, int
> +flags) {
> +	struct cn10k_ddr_pmu *pmu =3D to_cn10k_ddr_pmu(event->pmu);
> +	struct hw_perf_event *hwc =3D &event->hw;
> +	int counter =3D hwc->idx;
> +
> +	cn10k_ddr_perf_counter_enable(pmu, counter, false);
> +
> +	if (flags & PERF_EF_UPDATE)
> +		cn10k_ddr_perf_event_update(event);
> +
> +	hwc->state |=3D PERF_HES_STOPPED;
> +}
> +
> +static void cn10k_ddr_perf_event_del(struct perf_event *event, int
> +flags) {
> +	struct cn10k_ddr_pmu *pmu =3D to_cn10k_ddr_pmu(event->pmu);
> +	struct hw_perf_event *hwc =3D &event->hw;
> +	int counter =3D hwc->idx;
> +
> +	cn10k_ddr_perf_event_stop(event, PERF_EF_UPDATE);
> +
> +	cn10k_ddr_perf_free_counter(pmu, counter);
> +	pmu->active_events--;
> +	hwc->idx =3D -1;
> +}
> +
> +static void cn10k_ddr_perf_pmu_enable(struct pmu *pmu) {
> +	struct cn10k_ddr_pmu *ddr_pmu =3D to_cn10k_ddr_pmu(pmu);
> +
> +	writeq_relaxed(START_OP_CTRL_VAL_START, ddr_pmu->base +
> +		       DDRC_PERF_CNT_START_OP_CTRL);
> +}
> +
> +static void cn10k_ddr_perf_pmu_disable(struct pmu *pmu) {
> +	struct cn10k_ddr_pmu *ddr_pmu =3D to_cn10k_ddr_pmu(pmu);
> +
> +	writeq_relaxed(END_OP_CTRL_VAL_END, ddr_pmu->base +
> +		       DDRC_PERF_CNT_END_OP_CTRL);
> +}
> +
> +static int cn10k_ddr_perf_probe(struct platform_device *pdev) {
> +	struct cn10k_ddr_pmu *ddr_pmu;
> +	struct resource *res;
> +	void __iomem *base;
> +	char *name;
> +	int ret;
> +
> +	ddr_pmu =3D devm_kzalloc(&pdev->dev, sizeof(*ddr_pmu), GFP_KERNEL);
> +	if (!ddr_pmu)
> +		return -ENOMEM;
> +
> +	ddr_pmu->dev =3D &pdev->dev;
> +	platform_set_drvdata(pdev, ddr_pmu);
> +
> +	base =3D devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	ddr_pmu->base =3D base;
> +
> +	/* Setup the PMU counter to work in manual mode */
> +	writeq_relaxed(OP_MODE_CTRL_VAL_MANNUAL, ddr_pmu->base +
> +		       DDRC_PERF_CNT_OP_MODE_CTRL);
> +
> +	ddr_pmu->pmu =3D (struct pmu) {
> +		.module	      =3D THIS_MODULE,
> +		.capabilities =3D PERF_PMU_CAP_NO_EXCLUDE,
> +		.task_ctx_nr =3D perf_invalid_context,
> +		.attr_groups =3D cn10k_attr_groups,
> +		.event_init  =3D cn10k_ddr_perf_event_init,
> +		.add	     =3D cn10k_ddr_perf_event_add,
> +		.del	     =3D cn10k_ddr_perf_event_del,
> +		.start	     =3D cn10k_ddr_perf_event_start,
> +		.stop	     =3D cn10k_ddr_perf_event_stop,
> +		.read	     =3D cn10k_ddr_perf_event_update,
> +		.pmu_enable  =3D cn10k_ddr_perf_pmu_enable,
> +		.pmu_disable =3D cn10k_ddr_perf_pmu_disable,
> +	};
> +
> +	/* Choose this cpu to collect perf data */
> +	ddr_pmu->cpu =3D raw_smp_processor_id();
> +
> +	name =3D devm_kasprintf(ddr_pmu->dev, GFP_KERNEL,
> "mrvl_ddr_pmu_%llx",
> +			      res->start);
> +	if (!name)
> +		return -ENOMEM;
> +
> +	ret =3D perf_pmu_register(&ddr_pmu->pmu, name, -1);
> +	if (ret)
> +		return ret;
> +
> +	pr_info("CN10K DDR PMU Driver for ddrc@%llx\n", res->start);
> +	return 0;
> +}
> +
> +static int cn10k_ddr_perf_remove(struct platform_device *pdev) {
> +	struct cn10k_ddr_pmu *ddr_pmu =3D platform_get_drvdata(pdev);
> +
> +	perf_pmu_unregister(&ddr_pmu->pmu);
> +	return 0;
> +}
> +
> +static const struct of_device_id cn10k_ddr_pmu_of_match[] =3D {
> +	{ .compatible =3D "marvell,cn10k-ddr-pmu", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, cn10k_ddr_pmu_of_match);
> +
> +static struct platform_driver cn10k_ddr_pmu_driver =3D {
> +	.driver	=3D {
> +		.name   =3D "cn10k-ddr-pmu",
> +		.of_match_table =3D cn10k_ddr_pmu_of_match,
> +		.suppress_bind_attrs =3D true,
> +	},
> +	.probe		=3D cn10k_ddr_perf_probe,
> +	.remove		=3D cn10k_ddr_perf_remove,
> +};
> +
> +static int __init cn10k_ddr_pmu_init(void) {
> +	return platform_driver_register(&cn10k_ddr_pmu_driver);
> +}
> +
> +static void __exit cn10k_ddr_pmu_exit(void) {
> +	platform_driver_unregister(&cn10k_ddr_pmu_driver);
> +}
> +
> +module_init(cn10k_ddr_pmu_init);
> +module_exit(cn10k_ddr_pmu_exit);
> +
> +MODULE_AUTHOR("Bharat Bhushan <bbhushan2@marvell.com>");
> +MODULE_LICENSE("GPL v2");
> --
> 2.17.1

