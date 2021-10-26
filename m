Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFD0343B8EF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 20:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238040AbhJZSHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 14:07:04 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:28652 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236706AbhJZSHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 14:07:02 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19QEo8Te012605;
        Tue, 26 Oct 2021 11:04:27 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by mx0b-0016f401.pphosted.com with ESMTP id 3bx4dx4epe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Oct 2021 11:04:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ScMKatPyGY0iD01IWvAXYIMywnTLKWKyyYf41185rkRCGjaSf6R4FbybQQlAgHn+ya9VASf7MnPtLWJDt34A5AcIDXQUpmja718dHilVYpZvjLywBwLZeINSq2Xp8jBZ+tbyzv9cXD8HWycQY4vgLtBu/yn6SKN1vqtL2X94zx/qdNmKMvwuxw/Pmf6gZer5CivEuNRUO2fvj1SMpNgEoAsoanzVs7rWMblmma+ijAtQnCj51fnzLTuLQLI1xVa6nC5IEuLhxzw3OfGglTT15h+EErAQSrs/ag0M0R4e+8qKZ3cR4Of0QwPcgjwGSEjcEDu8tf5EMwud4jUHat3nTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2C5vIkcNZdwB18YeShNG37v1hwnTcuBYMBq/3IgQgs=;
 b=BkI+BYJFI8MrMHrDM9cZMQxZzzqtMURIvNKUIMotQW2l+BNr0GAd0cRLZ0OsC7lwQ7s7Cl6rFNL0LonffX1ND+xdlHm75OJXShhlsanNZVFNThmLWWfK78Ke4ZOQozq0VQYLEqNFkZc3Wi96jo2qib4Jy/3kWXvGqTS44G47xxQ3y3co5oPEJxPIper4oYsSGm/r6nPFQzWzETPX0WUUP7yAmEw3MtNawsIyB9f4oCdjsXaDWHYO2ausViD5MLwnJBXjMn4NKV2s2r97L7W1ISxM+0tCl1bwp+POFN0vJUhFvfOIeVBEqMUaf0CY2pG63C/3AfTVnoLh52YTleY1Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2C5vIkcNZdwB18YeShNG37v1hwnTcuBYMBq/3IgQgs=;
 b=gS5fQDyKiRQw5wgTfhdtutpJS2IuOQi92M4zBiHtDAZ4WLHF2nn7ESmOoK9u5rU6h1oRrUkVhXcVK18R+scvHDz5VMkmo9j2faNd/HIPs88Uy4pmP79UHXbKCrW/A/UtBsm7ihSKPtLndWaLGohDKjsHm84ZgwWip+KXQ2SK/+s=
Received: from BN6PR1801MB2068.namprd18.prod.outlook.com
 (2603:10b6:405:6b::11) by BN8PR18MB2642.namprd18.prod.outlook.com
 (2603:10b6:408:95::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Tue, 26 Oct
 2021 18:04:22 +0000
Received: from BN6PR1801MB2068.namprd18.prod.outlook.com
 ([fe80::7152:fa66:c68f:4aa1]) by BN6PR1801MB2068.namprd18.prod.outlook.com
 ([fe80::7152:fa66:c68f:4aa1%5]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 18:04:22 +0000
From:   Bhaskara Budiredla <bbudiredla@marvell.com>
To:     Will Deacon <will@kernel.org>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v6 1/2] drivers: perf: Add LLC-TAD perf counter
 support
Thread-Topic: [EXT] Re: [PATCH v6 1/2] drivers: perf: Add LLC-TAD perf counter
 support
Thread-Index: AQHXxDU0fs8Ti3gsr061fUNlWkdeOqvlE5IAgABqEsA=
Date:   Tue, 26 Oct 2021 18:04:22 +0000
Message-ID: <BN6PR1801MB206859B1C46EEEB10226EE17DE849@BN6PR1801MB2068.namprd18.prod.outlook.com>
References: <20211018153057.23217-1-bbudiredla@marvell.com>
 <20211018153057.23217-2-bbudiredla@marvell.com>
 <20211026094356.GA21352@willie-the-truck>
In-Reply-To: <20211026094356.GA21352@willie-the-truck>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e49a136-7839-4c3f-720f-08d998ab0a08
x-ms-traffictypediagnostic: BN8PR18MB2642:
x-microsoft-antispam-prvs: <BN8PR18MB264231466E316A5030E6C857DE849@BN8PR18MB2642.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bJUxZgPMDkuWoDwd2JWHl0EhfmC68YqUvfYeA4nu/+n3eB9CAeDdSsjQwKuH0JpWHnqZHm+vCQ6uL2cmmqTt1V9gAvYgSt32VpSW8QEn6/SZOAjxKCGa0Ott3Gvx0JsP0ICXVHYGZDpHOWdl456xIxorjri0U1c4rsR/gRKA1vCz7PCKY+6b/wAeOJyyd8be2hvx8kWu5aPKf+HBN0q5euFDdIE8WMAXc93gAvERZ8JINgn1svte1Nvw+8fndhdLJsrzu3mx88l6ylWTZv2xOBuYGSHYxNKRYkUpkHclT3XUdEYGNTe/xyo7k8WyPo5H+Jg/2jP0td02vjjDxrbhTwnjuNvMt64b6AmHC97E3amdAgxz7lUIJyoYYeVOj0rI3XC2TZBS/eceovpgbj2N/HTd1lmBAs7D+DvWKI+j/Ia361kusGKL1azrlSrbwPqeCWrCRqHM+6WXCSvvOpCRHgmd6xMFqWcr6WKWYZDXIJqmV3qIAxbdby+48JLwfVk9hH4v/ctc6HfdinfplprkNXZ1edUZ6JqrmfpJzOo/HSBN54+4ByEIZaoJeqOEp2ShOeQa9tYnpYOshoBfY0ObNf8QeOQ6HEGNk510Cw4vbpd5pYdMJ74M37RvR2tSx/8NGqeIiP7Ietvvi8w/4+d7bcIt5xoBYrEnMion5jhFSbrwMyaPUOFitncDb4F91JjeY0va0pEN7nuyWe7m22o+/4kc4IMXDoZjq7IqGvbquhA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1801MB2068.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52536014)(6916009)(83380400001)(6506007)(33656002)(508600001)(55016002)(8936002)(7696005)(4326008)(5660300002)(2906002)(8676002)(54906003)(316002)(186003)(76116006)(9686003)(66476007)(66556008)(64756008)(38070700005)(66946007)(66446008)(122000001)(38100700002)(86362001)(71200400001)(26005)(2004002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?f6oam8WSWHyj3vGqQd327d+HmDpMqE0cKFbjHm1vcCI+eG9BEgEc1l+EwKX3?=
 =?us-ascii?Q?bkKEqIF/fS9ROJSJJh6QA6PqbRvktG70eIIotKzwqwO31avvS+D2tNKemkmc?=
 =?us-ascii?Q?y8v+TBw8Jp0+0+nfvzz9Xw3JRIGCilKxrI6ajn8gJdUL8LGd9az9VOPrsN38?=
 =?us-ascii?Q?EvgakESjKYYzJ4IMam3FSl7lfsm6MVMUskPpeGSO8VvbLYyDiiKlXEfBSpO+?=
 =?us-ascii?Q?ragRWCFdVaE9oTfU/Sudc5Df3J4e+heHdhBFN18S4hh4wkq1Gci+QeH3HMCP?=
 =?us-ascii?Q?1thhv7IEKBY9xp3b/xtJW+PB/ZtDKZULk1f4qFdkBhSFW9X9Aq/nZb/67G5B?=
 =?us-ascii?Q?Dc6Fh4XVmS/zDXZjn+TguAlwk86lsGt8rvY4Ir+OMC6CmdhvWGO8SfEAY+Ng?=
 =?us-ascii?Q?MTyltreelSQqgbKJ88Y9DUm+m2wvvXjhfZpVY6fOues97T7t4imfE5f7pbZJ?=
 =?us-ascii?Q?luW1RJCSz8HW5ZcLoKQOahOT5W/3D6NrKP7MqoUx+DAB6dj2jR31BO40kLn0?=
 =?us-ascii?Q?C0QJwyC3jb6hIkrPG8307Ka+A0AX1WolEjIHbEN9VnG1/b163yrzge3/rZAF?=
 =?us-ascii?Q?8nxDEPnoJbdq4O8AnMiGsMmxQ3sI0dNT7QEJVlzv6YkUAktMAhPkkWJA5+Fc?=
 =?us-ascii?Q?yT7NeOcl1buMqmy9OOiYLpSRPZpJAzhii99rN4z47HUxADLgci1e7/v8pskb?=
 =?us-ascii?Q?QCFQyBbxh3nvaLZ+JudbhsFkUOHZQlF+Z30B+y+VeIj/F2eH5z2+yja4ksmq?=
 =?us-ascii?Q?+1MC/b+F01LDH6FKvnrIdVMDFxB2JTM051k7zmZX6uvBNLtbWh4LEaaK92oD?=
 =?us-ascii?Q?4OgJVupYAo1ag7DSsOZH0ou38+LtpBh22SQiNogJ48PyKIFaMOkeFiz9JNxu?=
 =?us-ascii?Q?9H/ERVPB8slDAyieFXdiLpjJhcZyPvCjDhTuVDPfqwC0ub7tV+/H6ZVzWV8G?=
 =?us-ascii?Q?sGu6WXlD1vkyl8Mi8ONwY4ld5qrBkoVYX8gOd3t6YOJTbeu2OAiW4XeoAlGE?=
 =?us-ascii?Q?EI3mBj4HLXQLXhI6HX82p+bJhL2KAbK7eMBLoNibqu+v21z1ipn+GRxynRJG?=
 =?us-ascii?Q?THkoE96se78KWEfzAVgvvYYPxT/0DDVhRZkxcOr2YOg1K2DcehfCw08c3oWP?=
 =?us-ascii?Q?OphstdK8luIfnLnJnSDLnwEXyrPRuSJirbm0/3mDPgxmeq0JGOMh+aHNhMfb?=
 =?us-ascii?Q?rkAnIHooLHDVUSOa4xcVfACMquLo/KDyV6T7cKTJujs+0hYq/mlmxiYqGB+h?=
 =?us-ascii?Q?IbaI8l02rCqoQ/OtIRdncuceU2kI9awnOWV4VEE3h7pQHQHCJfuo8W03MWvT?=
 =?us-ascii?Q?pJlSRnUUKr/QXrnvNKugXtc7XyA8OB+Ir/aE92q6UxJBK3LTcVf02SJDBG9S?=
 =?us-ascii?Q?vcyszUZhAktHMGQBXaz/S3KWRA4HlwdRJv4UU7hDwSRj8QpK+dtdCygbkaRR?=
 =?us-ascii?Q?MNzAhdlZCet+1KWC46lEV1NcExqQ79Tor2IukSXOGLZ1f9MXL3r4fZDdkiH+?=
 =?us-ascii?Q?a1bcNCLdjHQ/Np/YZiy+vXOfg5cDa7RfJelLmqTpvUAFoNRUAGXMV7vjE/OF?=
 =?us-ascii?Q?zo1eIDSdqUF0ve+/1mxcpWZkOq0h07NnsXjVPvrDUY8VwV/bTshAH+z9mHOi?=
 =?us-ascii?Q?HQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1801MB2068.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e49a136-7839-4c3f-720f-08d998ab0a08
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2021 18:04:22.1932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cAHYdz/l66AkBIDBpfAMjO5+UIHwEkZQ4i+2ptGhnwHE9HMSo62pDqV5wT5ES0EJJ+d0XEvbRD8+V0L4cw4KpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR18MB2642
X-Proofpoint-GUID: hxeKJxv_Eme8aIZPXa9JHUVvyNYfHiyO
X-Proofpoint-ORIG-GUID: hxeKJxv_Eme8aIZPXa9JHUVvyNYfHiyO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-26_05,2021-10-26_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Will Deacon <will@kernel.org>
>Sent: Tuesday, October 26, 2021 3:14 PM
>To: Bhaskara Budiredla <bbudiredla@marvell.com>
>Cc: mark.rutland@arm.com; robh+dt@kernel.org; Bharat Bhushan
><bbhushan2@marvell.com>; Sunil Kovvuri Goutham
><sgoutham@marvell.com>; linux-arm-kernel@lists.infradead.org;
>devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
>Subject: [EXT] Re: [PATCH v6 1/2] drivers: perf: Add LLC-TAD perf counter
>support
>
>External Email
>
>----------------------------------------------------------------------
>On Mon, Oct 18, 2021 at 09:00:56PM +0530, Bhaskara Budiredla wrote:
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
>
>Is that something you will want to do in the future? If you go with your c=
urrent
>approach of exposing a single "tad" unit to userspace, then you won't be a=
ble
>to change that.
>

There is no intension to do partitioning of the TADs. I have thrown some li=
ght on it as it is a point to be stressed upon.


>For the L3 PMUs (including on TX2). we expose per-node PMUs so why
>shouldn't we do something similar here and expose each TAD region
>separately? Even if userspace drives them all together, it gives you more
>flexibility in the future if you _do_ want to be partition them up.
>

Marvell has no plans of providing per-node pmu statistics on CN10k platform=
s.


>> diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile index
>> 5260b116c7da..2db5418d5b0a 100644
>> --- a/drivers/perf/Makefile
>> +++ b/drivers/perf/Makefile
>> @@ -14,3 +14,4 @@ obj-$(CONFIG_THUNDERX2_PMU) +=3D
>thunderx2_pmu.o
>>  obj-$(CONFIG_XGENE_PMU) +=3D xgene_pmu.o
>>  obj-$(CONFIG_ARM_SPE_PMU) +=3D arm_spe_pmu.o
>>  obj-$(CONFIG_ARM_DMC620_PMU) +=3D arm_dmc620_pmu.o
>> +obj-$(CONFIG_MARVELL_CN10K_TAD_PMU) +=3D
>marvell_cn10k_tad_pmu.o
>> diff --git a/drivers/perf/marvell_cn10k_tad_pmu.c
>> b/drivers/perf/marvell_cn10k_tad_pmu.c
>> new file mode 100644
>> index 000000000000..aebb1a0028dc
>> --- /dev/null
>> +++ b/drivers/perf/marvell_cn10k_tad_pmu.c
>> @@ -0,0 +1,429 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Marvell CN10K LLC-TAD perf driver
>> + *
>> + * Copyright (C) 2021 Marvell
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
>> +
>> +#define TAD_PFC_OFFSET		0x0
>> +#define TAD_PFC(counter)	(TAD_PFC_OFFSET | (counter << 3))
>> +#define TAD_PRF_OFFSET		0x100
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
>
>If we expose each TAD individually, then this won't matter, but I'd be inc=
lined
>to move the counter summation outside of the cmpxchg() loop given that
>readq (why not _relaxed?) is probably quite slow.
>

As clarified above partitioning of TADs is ruled out and situation of expos=
ing individual TADs inappropriate.


>> +
>> +	delta =3D (new - prev) & GENMASK_ULL(63, 0);
>
>This mask doesn't do anything.
>

Agreed, and will delete it.


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
>> +		writeq_relaxed(0, tad_pmu->regions[i].base +
>> +			       TAD_PRF(counter_idx));
>
>Please use braces around a multi-line conditional statement.
>

Taken.

>Will


Thanks,
Bhaskara
