Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEA843336F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 12:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235194AbhJSKZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 06:25:46 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:39472 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235203AbhJSKZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 06:25:43 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19J8IQcB030350;
        Tue, 19 Oct 2021 03:23:18 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by mx0b-0016f401.pphosted.com with ESMTP id 3bsfk4b6pj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Oct 2021 03:23:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSOgKZcQ/R19oXakduTYFwqonquVERSkXsACJKyfmtR9iovDFB9FnwB+MtDA2Wr3NWE7c5ZsEJc1HD4SK4hjpDwuddjJ7FX495WLskszo2X6+A8aBtzQLP52Dz0C+ovbwpyctEpQqRsCPZKN02Wb+15A1pa5GDK4FOitrnmZnUwNKcxpUZjCYw8oBlBxwIzOux58oMK+hpfbqF9jiQTYAoUStvXh54IToNwH8RGdQgQkiftsoIYk8Y6/w4uotV/rnckdd5p/1n7+tv8XfggSQ99AWku12iXV1OGWbKdwX3KMRgTsxclNa9A7/RMLFtdfD2Z3WTowhhJ+d3vilvuFLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YueM1EikZxFAavO1SvtWG9TvxDh6LAskmXg7NgnmA8E=;
 b=iXWT0lhi3tBpEJftDdvp0qHdfU9UwmL4ZrNA1fk0jzb8/hPKHz8JMjJeZzh15MoaeK8V33gR94Pls6rexP0h0Q9JOsMLcqdX5T2tjjiotnstRtVJ1gUmSD9GVK3kOnY5RC+z/mOm7JvK6grWMWBGKuY2iY0RLSAsdkGbgqohLDiomr+FIJTPnlhsY+N334zHNG5Ztc2xwBp2qaM2ShroDnb5Q6oUEJDrG7U6Nd/3kK1EPrJYabJ+a4iQMkRaJWf+PKuTLpF72x/zldRNGe1Um1TFvMEV6JCf3mGvsuIkkz9TbGCOx/RGabU6f+YqcvSJv2Y0V/yH8mfz3QGoy+tBdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YueM1EikZxFAavO1SvtWG9TvxDh6LAskmXg7NgnmA8E=;
 b=AxDc2h0YaV2wqiMeVhdxjUBdbcvmjdbYDi7aD3ZSMG6HHjQK8FwDmmmkGNxrtY4tv9v91FibErwJ5sO9nj6akZEOlmwbjjjz4PcEX8HgnkAXoWAVzaYENcgKOrvC4ojyNzueR1vzjOP5Ge+85TyEZ/oiKModYZf3+vKyeSOgqrI=
Received: from CO6PR18MB4465.namprd18.prod.outlook.com (2603:10b6:303:13b::10)
 by CO1PR18MB4665.namprd18.prod.outlook.com (2603:10b6:303:e4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15; Tue, 19 Oct
 2021 10:23:15 +0000
Received: from CO6PR18MB4465.namprd18.prod.outlook.com
 ([fe80::9da7:4d20:98ff:e441]) by CO6PR18MB4465.namprd18.prod.outlook.com
 ([fe80::9da7:4d20:98ff:e441%6]) with mapi id 15.20.4628.015; Tue, 19 Oct 2021
 10:23:15 +0000
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     Bhaskara Budiredla <bbudiredla@marvell.com>,
        "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bhaskara Budiredla <bbudiredla@marvell.com>
Subject: RE: [PATCH v6 1/2] drivers: perf: Add LLC-TAD perf counter support
Thread-Topic: [PATCH v6 1/2] drivers: perf: Add LLC-TAD perf counter support
Thread-Index: AQHXxDU0Kj3m9F9RVEKFywMUm7o1PavaHV2g
Date:   Tue, 19 Oct 2021 10:23:15 +0000
Message-ID: <CO6PR18MB4465FC637AD13455BD3E6370E3BD9@CO6PR18MB4465.namprd18.prod.outlook.com>
References: <20211018153057.23217-1-bbudiredla@marvell.com>
 <20211018153057.23217-2-bbudiredla@marvell.com>
In-Reply-To: <20211018153057.23217-2-bbudiredla@marvell.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96f265c4-63c8-4e0c-0444-08d992ea7681
x-ms-traffictypediagnostic: CO1PR18MB4665:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR18MB46657EDD78D531EF54D0F68CE3BD9@CO1PR18MB4665.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E0O7wl4CL6jkyXLDNhLQU2MVDsqr59nXngiH2PNZWsQFxTFYle8v2QHvPpADuUgfNxGlckUqOLCoFpA3tIZgSjtHqfMkHqJayvToYEAJFGZKpNsTHuuNwa3gsWgtjXulzvn5bN4FEyL8a3nAm/yS7/xeLOm0l7HJDfrGUDdv6eIQe13Qm876YPzbCkOGmiUOZ/9owsXH8XimoJk84vi0rHqyzRB0g2FMFNM9SCUDFcc4Yf4g/fGd0Jp5QbwqsaoQWA1ewC+Uea3NIt2hs7IvXOtF6LN8hrV99sMG+jiW9Cxu1GWkMf3rXlssH4DSn8y2Zfuii9pIZyyjWPbjU4qCPRho6J2rj8aKnqnufJADNIc2pxzabM4bou0ljN+4TCxUx3J8miIQ2y5NVgU7AnSSdKoVTRiy22PHbBZBWO0u2zwft35yIbhMgzg4ihbaZFsH0wBpUa9YQuQK5gtFhK+HleILnlJYJNkOuVSPwjZRRF0PlimGNx4hWNP/Yr42ATxWr7nJQrLfk6yfPAtlxvXhVbqnDmcWwpRBo12Yy3nY0RDKkPuspxHOK8b5ZxC1UTDa4j1/a+pCYBlRL+TPNWngsgtFVT4uMGGx03wb1ROPESZwZGzrrINYIXQKQ8YYEauVNoUhU4634BtzL2WVCixRRA4+wfU81fVmH+uhJf9uVBgv/92RH2t5pxK9rb31utsnByKkRofT5DpZ2oLbBhb9cbg/vYqhTn5sDDQbotCURpY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR18MB4465.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(4326008)(122000001)(6506007)(53546011)(54906003)(26005)(30864003)(33656002)(8936002)(8676002)(7696005)(2906002)(508600001)(6636002)(186003)(38070700005)(9686003)(5660300002)(110136005)(76116006)(66946007)(71200400001)(66476007)(66446008)(66556008)(64756008)(107886003)(55016002)(52536014)(83380400001)(86362001)(316002)(2004002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yIDgfvY5Y9v6SV91dDl6VFkcyBwsJ1dtUtjjE9V1Pg+S3etn99u485p4GCLp?=
 =?us-ascii?Q?w2KnbqWFguTiKiUUK5pHHaxo6J4tcW4t8qluSJJF9+OahHSAvxnb18jUhhTR?=
 =?us-ascii?Q?QzHua3VJGtvaAApEYfzQ7/JVU2jq8ajE5Ya+I8bnwx1xUBJRwDB28J9sw+bq?=
 =?us-ascii?Q?/w2MVUmIYaalmGEuM6dt6G5Ed1CLqTNeNwrVpGpmb8qPto4REsGH4lME58vz?=
 =?us-ascii?Q?bMe1mBncZapR3+S+/gyPKlXiMVD0ORjmxSSlT4TFKLvfHLqfSQp7gmosakk7?=
 =?us-ascii?Q?sy5oScgHSYKfDNI3F2XtsRc0YPlooekeYA9ildSAALcCcWHKggjtu8hsu7MG?=
 =?us-ascii?Q?OHb7e7Y54nA6t7swuSxyzA3BoACeJVFobB3j44GaUHThv1YEsaSXIkynpdkR?=
 =?us-ascii?Q?H8rqKKdfcka+9Guy06j80UwrFzic/vcjGpcNaaApWCGzVJVf3/0IJ6FmL0uM?=
 =?us-ascii?Q?ogC3Vs2XxhfG3viy8DHEZuH5wrtjl7eaEOG/89fMtybvkDQ5I7bX0VmAZGmq?=
 =?us-ascii?Q?zPrUQ20J0PBdHl5uajVz74kbTe8XxA8UzNhWWjMenjAU4EopXk2cC82HsGrs?=
 =?us-ascii?Q?5AbFG6nc2RCCKAszpoIp5uNZfGwI61rmfqjnz+7zKdhIF0VbpCACq49ZsJtg?=
 =?us-ascii?Q?6YxvfL1u6h0wZi3wnngoLUswunqj4dCXUnA51BIw9G69KtVa7ebBQK3b28Ty?=
 =?us-ascii?Q?/ctYzlugtHfgxj0jfb6nYpRz+rBINq9MxcNzZML7E+Z1W9mKbIHtYvEqVUhg?=
 =?us-ascii?Q?kAVz7lzrTfBo5AOnknpsJBj9ldr5BmDFVdUhqtRzQivCk9DJs5TPqOAEFKxc?=
 =?us-ascii?Q?gnPDJRfzdVRh2wVBEIBVSrpTM+n57yO2wMZ5pMbTQlHAfGSVapnX3aEC/hl+?=
 =?us-ascii?Q?lbMrAuDzxE+wVDggoRiKZNhz2mASrf1YL4aoYIi3Fp55XdLW3TSgg6RTcZPj?=
 =?us-ascii?Q?a3GGqDFFDiwceR+vXuVxOBUS4eIYajjgRzhgMe3g2T7oC/4BUX8h09Q2dCE4?=
 =?us-ascii?Q?ep2oFIT6xtNzt6dRctCDN2nq5YvBYnUPC9uW+nQo4LNKTe6E6RmlPUXFR6fH?=
 =?us-ascii?Q?mMDQ3TekDase2+Fz8bmSpEyEv4mEN/lg19pYglwC8jxvI1Af7872HAWwE9fQ?=
 =?us-ascii?Q?KHaEtoMybNvtHzRutuuAqkc+TbS0OCA6ixQb2a5y6vaoH3KqWs3o+dJUPGWK?=
 =?us-ascii?Q?LJsyyNI1DxJQ5vgCWCmDPE0VE6c894CnhK8tzvdYBzVLo2zTIRaL7tD/I1p3?=
 =?us-ascii?Q?I4rRmRLwnhbP4oCj756ytbKu41lABfIgLK2atafr4A0pPB8+I9+1yMmEtaZa?=
 =?us-ascii?Q?MyefnvZoORIoEfBOOJzbUWOe?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4465.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96f265c4-63c8-4e0c-0444-08d992ea7681
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2021 10:23:15.6849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UYFDtrRXecIF4F8PJmbMWSRWjE/vBbi9rZi4r83prA1TpJcbxQVYW9ORcveBh7zQMwd1g9fSH+KTJwMKCaEzxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR18MB4665
X-Proofpoint-ORIG-GUID: nTOtzqZWpXAlgwgjCLzATK6x_kxc6QKB
X-Proofpoint-GUID: nTOtzqZWpXAlgwgjCLzATK6x_kxc6QKB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-18_10,2021-10-19_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Bhaskara Budiredla <bbudiredla@marvell.com>
> Sent: Monday, October 18, 2021 9:01 PM
> To: will@kernel.org; mark.rutland@arm.com; robh+dt@kernel.org; Bharat
> Bhushan <bbhushan2@marvell.com>; Sunil Kovvuri Goutham
> <sgoutham@marvell.com>
> Cc: linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org; lin=
ux-
> kernel@vger.kernel.org; Bhaskara Budiredla <bbudiredla@marvell.com>
> Subject: [PATCH v6 1/2] drivers: perf: Add LLC-TAD perf counter support
>=20
> This driver adds support for Last-level cache tag-and-data unit
> (LLC-TAD) PMU that is featured in some of the Marvell's CN10K
> infrastructure silicons.
>=20
> The LLC is divided into 2N slices distributed across N Mesh tiles
> in a single-socket configuration. The driver always configures the
> same counter for all of the TADs. The user would end up effectively
> reserving one of eight counters in every TAD to look across all TADs.
> The occurrences of events are aggregated and presented to the user
> at the end of an application run. The driver does not provide a way
> for the user to partition TADs so that different TADs are used for
> different applications.
>=20
> The event counters are zeroed to start event counting to avoid any
> rollover issues. TAD perf counters are 64-bit, so it's not currently
> possible to overflow event counters at current mesh and core
> frequencies.
>=20
> To measure tad pmu events use perf tool stat command. For instance:
>=20
> perf stat -e tad_dat_msh_in_dss,tad_req_msh_out_any <application>
> perf stat -e tad_alloc_any,tad_hit_any,tad_tag_rd <application>
>=20
> Signed-off-by: Bhaskara Budiredla <bbudiredla@marvell.com>

Reviewed-by: Bharat Bhushan <bbhushan2@marvell.com>

Thanks
-Bharat

> ---
>  drivers/perf/Kconfig                 |   7 +
>  drivers/perf/Makefile                |   1 +
>  drivers/perf/marvell_cn10k_tad_pmu.c | 429 +++++++++++++++++++++++++++
>  3 files changed, 437 insertions(+)
>  create mode 100644 drivers/perf/marvell_cn10k_tad_pmu.c
>=20
> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index 77522e5efe11..2ce46f7ad639 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -137,6 +137,13 @@ config ARM_DMC620_PMU
>  	  Support for PMU events monitoring on the ARM DMC-620 memory
>  	  controller.
>=20
> +config MARVELL_CN10K_TAD_PMU
> +	tristate "Marvell CN10K LLC-TAD PMU"
> +	depends on ARM64 || COMPILE_TEST
> +	help
> +	  Provides support for Last-Level cache Tag-and-data Units (LLC-TAD)
> +	  performance monitors on CN10K family silicons.
> +
>  source "drivers/perf/hisilicon/Kconfig"
>=20
>  endmenu
> diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
> index 5260b116c7da..2db5418d5b0a 100644
> --- a/drivers/perf/Makefile
> +++ b/drivers/perf/Makefile
> @@ -14,3 +14,4 @@ obj-$(CONFIG_THUNDERX2_PMU) +=3D thunderx2_pmu.o
>  obj-$(CONFIG_XGENE_PMU) +=3D xgene_pmu.o
>  obj-$(CONFIG_ARM_SPE_PMU) +=3D arm_spe_pmu.o
>  obj-$(CONFIG_ARM_DMC620_PMU) +=3D arm_dmc620_pmu.o
> +obj-$(CONFIG_MARVELL_CN10K_TAD_PMU) +=3D marvell_cn10k_tad_pmu.o
> diff --git a/drivers/perf/marvell_cn10k_tad_pmu.c
> b/drivers/perf/marvell_cn10k_tad_pmu.c
> new file mode 100644
> index 000000000000..aebb1a0028dc
> --- /dev/null
> +++ b/drivers/perf/marvell_cn10k_tad_pmu.c
> @@ -0,0 +1,429 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Marvell CN10K LLC-TAD perf driver
> + *
> + * Copyright (C) 2021 Marvell
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#define pr_fmt(fmt) "tad_pmu: " fmt
> +
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/cpuhotplug.h>
> +#include <linux/perf_event.h>
> +#include <linux/platform_device.h>
> +
> +#define TAD_PFC_OFFSET		0x0
> +#define TAD_PFC(counter)	(TAD_PFC_OFFSET | (counter << 3))
> +#define TAD_PRF_OFFSET		0x100
> +#define TAD_PRF(counter)	(TAD_PRF_OFFSET | (counter << 3))
> +#define TAD_PRF_CNTSEL_MASK	0xFF
> +#define TAD_MAX_COUNTERS	8
> +
> +#define to_tad_pmu(p) (container_of(p, struct tad_pmu, pmu))
> +
> +struct tad_region {
> +	void __iomem	*base;
> +};
> +
> +struct tad_pmu {
> +	struct pmu pmu;
> +	struct tad_region *regions;
> +	u32 region_cnt;
> +	unsigned int cpu;
> +	struct hlist_node node;
> +	struct perf_event *events[TAD_MAX_COUNTERS];
> +	DECLARE_BITMAP(counters_map, TAD_MAX_COUNTERS);
> +};
> +
> +static int tad_pmu_cpuhp_state;
> +
> +static void tad_pmu_event_counter_read(struct perf_event *event)
> +{
> +	struct tad_pmu *tad_pmu =3D to_tad_pmu(event->pmu);
> +	struct hw_perf_event *hwc =3D &event->hw;
> +	u32 counter_idx =3D hwc->idx;
> +	u64 delta, prev, new;
> +	int i;
> +
> +	do {
> +		prev =3D local64_read(&hwc->prev_count);
> +		for (i =3D 0, new =3D 0; i < tad_pmu->region_cnt; i++)
> +			new +=3D readq(tad_pmu->regions[i].base +
> +				     TAD_PFC(counter_idx));
> +	} while (local64_cmpxchg(&hwc->prev_count, prev, new) !=3D prev);
> +
> +	delta =3D (new - prev) & GENMASK_ULL(63, 0);
> +	local64_add(delta, &event->count);
> +}
> +
> +static void tad_pmu_event_counter_stop(struct perf_event *event, int fla=
gs)
> +{
> +	struct tad_pmu *tad_pmu =3D to_tad_pmu(event->pmu);
> +	struct hw_perf_event *hwc =3D &event->hw;
> +	u32 counter_idx =3D hwc->idx;
> +	int i;
> +
> +	/* TAD()_PFC() stop counting on the write
> +	 * which sets TAD()_PRF()[CNTSEL] =3D=3D 0
> +	 */
> +	for (i =3D 0; i < tad_pmu->region_cnt; i++)
> +		writeq_relaxed(0, tad_pmu->regions[i].base +
> +			       TAD_PRF(counter_idx));
> +
> +	tad_pmu_event_counter_read(event);
> +	hwc->state |=3D PERF_HES_STOPPED | PERF_HES_UPTODATE;
> +}
> +
> +static void tad_pmu_event_counter_start(struct perf_event *event, int fl=
ags)
> +{
> +	struct tad_pmu *tad_pmu =3D to_tad_pmu(event->pmu);
> +	struct hw_perf_event *hwc =3D &event->hw;
> +	u32 event_idx =3D event->attr.config;
> +	u32 counter_idx =3D hwc->idx;
> +	u64 reg_val;
> +	int i;
> +
> +	hwc->state =3D 0;
> +
> +	/* Typically TAD_PFC() are zeroed to start counting */
> +	for (i =3D 0; i < tad_pmu->region_cnt; i++)
> +		writeq_relaxed(0, tad_pmu->regions[i].base +
> +			       TAD_PFC(counter_idx));
> +
> +	/* TAD()_PFC() start counting on the write
> +	 * which sets TAD()_PRF()[CNTSEL] !=3D 0
> +	 */
> +	for (i =3D 0; i < tad_pmu->region_cnt; i++) {
> +		reg_val =3D readq_relaxed(tad_pmu->regions[i].base +
> +					TAD_PRF(counter_idx));
> +		reg_val |=3D (event_idx & 0xFF);
> +		writeq_relaxed(reg_val,	tad_pmu->regions[i].base +
> +			       TAD_PRF(counter_idx));
> +	}
> +}
> +
> +static void tad_pmu_event_counter_del(struct perf_event *event, int flag=
s)
> +{
> +	struct tad_pmu *tad_pmu =3D to_tad_pmu(event->pmu);
> +	struct hw_perf_event *hwc =3D &event->hw;
> +	int idx =3D hwc->idx;
> +
> +	tad_pmu_event_counter_stop(event, flags | PERF_EF_UPDATE);
> +	tad_pmu->events[idx] =3D NULL;
> +	clear_bit(idx, tad_pmu->counters_map);
> +}
> +
> +static int tad_pmu_event_counter_add(struct perf_event *event, int flags=
)
> +{
> +	struct tad_pmu *tad_pmu =3D to_tad_pmu(event->pmu);
> +	struct hw_perf_event *hwc =3D &event->hw;
> +	int idx;
> +
> +	/* Get a free counter for this event */
> +	idx =3D find_first_zero_bit(tad_pmu->counters_map,
> TAD_MAX_COUNTERS);
> +	if (idx =3D=3D TAD_MAX_COUNTERS)
> +		return -EAGAIN;
> +
> +	set_bit(idx, tad_pmu->counters_map);
> +
> +	hwc->idx =3D idx;
> +	hwc->state =3D PERF_HES_STOPPED;
> +	tad_pmu->events[idx] =3D event;
> +
> +	if (flags & PERF_EF_START)
> +		tad_pmu_event_counter_start(event, flags);
> +
> +	return 0;
> +}
> +
> +static int tad_pmu_event_init(struct perf_event *event)
> +{
> +	struct tad_pmu *tad_pmu =3D to_tad_pmu(event->pmu);
> +
> +	if (!event->attr.disabled)
> +		return -EINVAL;
> +
> +	if (event->attr.type !=3D event->pmu->type)
> +		return -ENOENT;
> +
> +	if (event->state !=3D PERF_EVENT_STATE_OFF)
> +		return -EINVAL;
> +
> +	event->cpu =3D tad_pmu->cpu;
> +	event->hw.idx =3D -1;
> +	event->hw.config_base =3D event->attr.config;
> +
> +	return 0;
> +}
> +
> +static ssize_t tad_pmu_event_show(struct device *dev,
> +				struct device_attribute *attr, char *page)
> +{
> +	struct perf_pmu_events_attr *pmu_attr;
> +
> +	pmu_attr =3D container_of(attr, struct perf_pmu_events_attr, attr);
> +	return sysfs_emit(page, "event=3D0x%02llx\n", pmu_attr->id);
> +}
> +
> +#define TAD_PMU_EVENT_ATTR(name, config)			\
> +	PMU_EVENT_ATTR_ID(name, tad_pmu_event_show, config)
> +
> +static struct attribute *tad_pmu_event_attrs[] =3D {
> +	TAD_PMU_EVENT_ATTR(tad_none, 0x0),
> +	TAD_PMU_EVENT_ATTR(tad_req_msh_in_any, 0x1),
> +	TAD_PMU_EVENT_ATTR(tad_req_msh_in_mn, 0x2),
> +	TAD_PMU_EVENT_ATTR(tad_req_msh_in_exlmn, 0x3),
> +	TAD_PMU_EVENT_ATTR(tad_rsp_msh_in_any, 0x4),
> +	TAD_PMU_EVENT_ATTR(tad_rsp_msh_in_mn, 0x5),
> +	TAD_PMU_EVENT_ATTR(tad_rsp_msh_in_exlmn, 0x6),
> +	TAD_PMU_EVENT_ATTR(tad_rsp_msh_in_dss, 0x7),
> +	TAD_PMU_EVENT_ATTR(tad_rsp_msh_in_retry_dss, 0x8),
> +	TAD_PMU_EVENT_ATTR(tad_dat_msh_in_any, 0x9),
> +	TAD_PMU_EVENT_ATTR(tad_dat_msh_in_dss, 0xa),
> +	TAD_PMU_EVENT_ATTR(tad_req_msh_out_any, 0xb),
> +	TAD_PMU_EVENT_ATTR(tad_req_msh_out_dss_rd, 0xc),
> +	TAD_PMU_EVENT_ATTR(tad_req_msh_out_dss_wr, 0xd),
> +	TAD_PMU_EVENT_ATTR(tad_req_msh_out_evict, 0xe),
> +	TAD_PMU_EVENT_ATTR(tad_rsp_msh_out_any, 0xf),
> +	TAD_PMU_EVENT_ATTR(tad_rsp_msh_out_retry_exlmn, 0x10),
> +	TAD_PMU_EVENT_ATTR(tad_rsp_msh_out_retry_mn, 0x11),
> +	TAD_PMU_EVENT_ATTR(tad_rsp_msh_out_exlmn, 0x12),
> +	TAD_PMU_EVENT_ATTR(tad_rsp_msh_out_mn, 0x13),
> +	TAD_PMU_EVENT_ATTR(tad_snp_msh_out_any, 0x14),
> +	TAD_PMU_EVENT_ATTR(tad_snp_msh_out_mn, 0x15),
> +	TAD_PMU_EVENT_ATTR(tad_snp_msh_out_exlmn, 0x16),
> +	TAD_PMU_EVENT_ATTR(tad_dat_msh_out_any, 0x17),
> +	TAD_PMU_EVENT_ATTR(tad_dat_msh_out_fill, 0x18),
> +	TAD_PMU_EVENT_ATTR(tad_dat_msh_out_dss, 0x19),
> +	TAD_PMU_EVENT_ATTR(tad_alloc_dtg, 0x1a),
> +	TAD_PMU_EVENT_ATTR(tad_alloc_ltg, 0x1b),
> +	TAD_PMU_EVENT_ATTR(tad_alloc_any, 0x1c),
> +	TAD_PMU_EVENT_ATTR(tad_hit_dtg, 0x1d),
> +	TAD_PMU_EVENT_ATTR(tad_hit_ltg, 0x1e),
> +	TAD_PMU_EVENT_ATTR(tad_hit_any, 0x1f),
> +	TAD_PMU_EVENT_ATTR(tad_tag_rd, 0x20),
> +	TAD_PMU_EVENT_ATTR(tad_dat_rd, 0x21),
> +	TAD_PMU_EVENT_ATTR(tad_dat_rd_byp, 0x22),
> +	TAD_PMU_EVENT_ATTR(tad_ifb_occ, 0x23),
> +	TAD_PMU_EVENT_ATTR(tad_req_occ, 0x24),
> +	NULL
> +};
> +
> +static const struct attribute_group tad_pmu_events_attr_group =3D {
> +	.name =3D "events",
> +	.attrs =3D tad_pmu_event_attrs,
> +};
> +
> +PMU_FORMAT_ATTR(event, "config:0-7");
> +
> +static struct attribute *tad_pmu_format_attrs[] =3D {
> +	&format_attr_event.attr,
> +	NULL
> +};
> +
> +static struct attribute_group tad_pmu_format_attr_group =3D {
> +	.name =3D "format",
> +	.attrs =3D tad_pmu_format_attrs,
> +};
> +
> +static ssize_t tad_pmu_cpumask_show(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct tad_pmu *tad_pmu =3D to_tad_pmu(dev_get_drvdata(dev));
> +
> +	return cpumap_print_to_pagebuf(true, buf, cpumask_of(tad_pmu-
> >cpu));
> +}
> +
> +static DEVICE_ATTR(cpumask, 0444, tad_pmu_cpumask_show, NULL);
> +
> +static struct attribute *tad_pmu_cpumask_attrs[] =3D {
> +	&dev_attr_cpumask.attr,
> +	NULL
> +};
> +
> +static struct attribute_group tad_pmu_cpumask_attr_group =3D {
> +	.attrs =3D tad_pmu_cpumask_attrs,
> +};
> +
> +static const struct attribute_group *tad_pmu_attr_groups[] =3D {
> +	&tad_pmu_events_attr_group,
> +	&tad_pmu_format_attr_group,
> +	&tad_pmu_cpumask_attr_group,
> +	NULL
> +};
> +
> +static int tad_pmu_probe(struct platform_device *pdev)
> +{
> +	struct device_node *node =3D pdev->dev.of_node;
> +	struct tad_region *regions;
> +	struct tad_pmu *tad_pmu;
> +	struct resource *res;
> +	u32 tad_pmu_page_size;
> +	u32 tad_page_size;
> +	u32 tad_cnt;
> +	int i, ret;
> +	char *name;
> +
> +	tad_pmu =3D devm_kzalloc(&pdev->dev, sizeof(*tad_pmu), GFP_KERNEL);
> +	if (!tad_pmu)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, tad_pmu);
> +
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "Mem resource not found\n");
> +		return -ENODEV;
> +	}
> +
> +	ret =3D of_property_read_u32(node, "marvell,tad-page-size",
> +				   &tad_page_size);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Can't find tad-page-size property\n");
> +		return ret;
> +	}
> +
> +	ret =3D of_property_read_u32(node, "marvell,tad-pmu-page-size",
> +				   &tad_pmu_page_size);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Can't find tad-pmu-page-size
> property\n");
> +		return ret;
> +	}
> +
> +	ret =3D of_property_read_u32(node, "marvell,tad-cnt", &tad_cnt);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Can't find tad-cnt property\n");
> +		return ret;
> +	}
> +
> +	regions =3D devm_kcalloc(&pdev->dev, tad_cnt,
> +			       sizeof(*regions), GFP_KERNEL);
> +	if (!regions)
> +		return -ENOMEM;
> +
> +	/* ioremap the distributed TAD pmu regions */
> +	for (i =3D 0; i < tad_cnt && res->start < res->end; i++) {
> +		regions[i].base =3D devm_ioremap(&pdev->dev,
> +					       res->start,
> +					       tad_pmu_page_size);
> +		if (IS_ERR(regions[i].base)) {
> +			dev_err(&pdev->dev, "TAD%d ioremap fail\n", i);
> +			return -ENOMEM;
> +		}
> +		res->start +=3D tad_page_size;
> +	}
> +
> +	tad_pmu->regions =3D regions;
> +	tad_pmu->region_cnt =3D tad_cnt;
> +
> +	tad_pmu->pmu =3D (struct pmu) {
> +
> +		.module		=3D THIS_MODULE,
> +		.attr_groups	=3D tad_pmu_attr_groups,
> +		.capabilities	=3D PERF_PMU_CAP_NO_EXCLUDE |
> +				  PERF_PMU_CAP_NO_INTERRUPT,
> +		.task_ctx_nr	=3D perf_invalid_context,
> +
> +		.event_init	=3D tad_pmu_event_init,
> +		.add		=3D tad_pmu_event_counter_add,
> +		.del		=3D tad_pmu_event_counter_del,
> +		.start		=3D tad_pmu_event_counter_start,
> +		.stop		=3D tad_pmu_event_counter_stop,
> +		.read		=3D tad_pmu_event_counter_read,
> +	};
> +
> +	tad_pmu->cpu =3D raw_smp_processor_id();
> +
> +	/* Register pmu instance for cpu hotplug */
> +	ret =3D cpuhp_state_add_instance_nocalls(tad_pmu_cpuhp_state,
> +					       &tad_pmu->node);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Error %d registering hotplug\n", ret);
> +		return ret;
> +	}
> +
> +	name =3D "tad";
> +	ret =3D perf_pmu_register(&tad_pmu->pmu, name, -1);
> +	if (ret)
> +		cpuhp_state_remove_instance_nocalls(tad_pmu_cpuhp_state,
> +						    &tad_pmu->node);
> +
> +	return ret;
> +}
> +
> +static int tad_pmu_remove(struct platform_device *pdev)
> +{
> +	struct tad_pmu *pmu =3D platform_get_drvdata(pdev);
> +
> +	cpuhp_state_remove_instance_nocalls(tad_pmu_cpuhp_state,
> +						&pmu->node);
> +	perf_pmu_unregister(&pmu->pmu);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id tad_pmu_of_match[] =3D {
> +	{ .compatible =3D "marvell,cn10k-tad-pmu", },
> +	{},
> +};
> +
> +static struct platform_driver tad_pmu_driver =3D {
> +	.driver         =3D {
> +		.name   =3D "cn10k_tad_pmu",
> +		.of_match_table =3D of_match_ptr(tad_pmu_of_match),
> +		.suppress_bind_attrs =3D true,
> +	},
> +	.probe          =3D tad_pmu_probe,
> +	.remove         =3D tad_pmu_remove,
> +};
> +
> +static int tad_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node=
)
> +{
> +	struct tad_pmu *pmu =3D hlist_entry_safe(node, struct tad_pmu, node);
> +	unsigned int target;
> +
> +	if (cpu !=3D pmu->cpu)
> +		return 0;
> +
> +	target =3D cpumask_any_but(cpu_online_mask, cpu);
> +	if (target >=3D nr_cpu_ids)
> +		return 0;
> +
> +	perf_pmu_migrate_context(&pmu->pmu, cpu, target);
> +	pmu->cpu =3D target;
> +
> +	return 0;
> +}
> +
> +static int __init tad_pmu_init(void)
> +{
> +	int ret;
> +
> +	ret =3D cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
> +				      "perf/cn10k/tadpmu:online",
> +				      NULL,
> +				      tad_pmu_offline_cpu);
> +	if (ret < 0)
> +		return ret;
> +	tad_pmu_cpuhp_state =3D ret;
> +	return platform_driver_register(&tad_pmu_driver);
> +}
> +
> +static void __exit tad_pmu_exit(void)
> +{
> +	platform_driver_unregister(&tad_pmu_driver);
> +	cpuhp_remove_multi_state(tad_pmu_cpuhp_state);
> +}
> +
> +module_init(tad_pmu_init);
> +module_exit(tad_pmu_exit);
> +
> +MODULE_DESCRIPTION("Marvell CN10K LLC-TAD Perf driver");
> +MODULE_AUTHOR("Bhaskara Budiredla <bbudiredla@marvell.com>");
> +MODULE_LICENSE("GPL v2");
> --
> 2.17.1

