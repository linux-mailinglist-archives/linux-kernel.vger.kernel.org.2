Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFDB342A0D4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 11:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235542AbhJLJSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 05:18:25 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:23134 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235306AbhJLJSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 05:18:24 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19C8RHlI025341;
        Tue, 12 Oct 2021 02:16:15 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by mx0b-0016f401.pphosted.com with ESMTP id 3bmpv4v0ea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Oct 2021 02:16:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8eHGF1SgEQhFaONIjm+TW66mXJbUGiy8BEPn7WBqfyUDNKNNzTkXM+udcicQXb/ZHdbb1m5mcNM+vIYrQYuoPEE79AWbMhIZOpNzGvn6cOGjd4op3C/jYwjcQbU+0aO6NB7iLw4Fn1yehXgvv4gzmzBLuvBcRmQ6/FYZFIx8/yFJmcEl1+3kAiixMIE9aUMiCLhnOHiq/VYy9ksGj8wneshF8NaOfoiBKpKRCVTOc2mKMU/0m83F3YXqtPkRUl+nI6XZkDjmYLFdtCpl5+Vcpi+v8Qb4nxr2RHzEzsfd67ihlfDygPd+j8d+2SuhiVNI21xbYDfHOti7Vu60vpNbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wu/4ZYsIznVYPYGtUZnA0Jg2PQYqIskDAQgxYg79hDE=;
 b=hYl4gMP8ZFmvF4lUul9uc0E9D8NB/KzdKCHidVzavQPtkFA7g0L5AoJX4LS1GF+5Z9OOLEcZj26j2CPjYA9K+8vFjB1OGdoNKsqgOHNQNL72ch+73ymE3Cdvzn2JBYfCFPwN7hDXRYdIE/VMpZfi5CxhrMs744nG5TrM58RvcaxTKR/TJg9TpT2XOnAa5ItWIaYDPrwU+hDzVX73cu9o0/xknLCak0DC7QWujPRaKsnGiKmrLRGVCw1l/bzjuPgtR0s9/H7XOo5eCt28/pneClhZoiIatuj5Dm1A8AR750A6bhkUV0BieWS46U+bNY4Y6hEOFuIcYuVLNhslNbAGBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wu/4ZYsIznVYPYGtUZnA0Jg2PQYqIskDAQgxYg79hDE=;
 b=KOjQ16q3YEHmNKcckwa6X907NHSqKIoISBywAFBinXZJGnKF1iLwZghtHx/KDPwCd/AXnAQTolGpwBgiuXexR0uD8hBJbIf7r1SpPzHorFwjj8+UOVLAJ6OiO2dipvbCvuROJZG9PZqa+cwfqxyafM49JfSZRF3a2v3H/7dT6rk=
Received: from CY4PR1801MB2070.namprd18.prod.outlook.com
 (2603:10b6:910:7e::28) by CY4PR18MB1304.namprd18.prod.outlook.com
 (2603:10b6:903:114::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Tue, 12 Oct
 2021 09:16:14 +0000
Received: from CY4PR1801MB2070.namprd18.prod.outlook.com
 ([fe80::9de0:2038:e0cd:e491]) by CY4PR1801MB2070.namprd18.prod.outlook.com
 ([fe80::9de0:2038:e0cd:e491%6]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 09:16:13 +0000
From:   Bhaskara Budiredla <bbudiredla@marvell.com>
To:     Bharat Bhushan <bbhushan2@marvell.com>,
        "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 2/4] perf/marvell: CN10k DDR performance monitor
 support
Thread-Topic: [PATCH v4 2/4] perf/marvell: CN10k DDR performance monitor
 support
Thread-Index: AQHXrd2Tdoh8fcjm302tQkFioaOIjKvPIvVwgAAQglA=
Date:   Tue, 12 Oct 2021 09:16:13 +0000
Message-ID: <CY4PR1801MB2070C952470F81D26C1BB43ADEB69@CY4PR1801MB2070.namprd18.prod.outlook.com>
References: <20210920050823.10853-1-bbhushan2@marvell.com>
 <20210920050823.10853-3-bbhushan2@marvell.com>
 <CO6PR18MB4465FC607A2836EE98807965E3B69@CO6PR18MB4465.namprd18.prod.outlook.com>
In-Reply-To: <CO6PR18MB4465FC607A2836EE98807965E3B69@CO6PR18MB4465.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f621555-bfb4-4389-600c-08d98d60f062
x-ms-traffictypediagnostic: CY4PR18MB1304:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR18MB130485B9FBD1A923F4D93B3BDEB69@CY4PR18MB1304.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YFAUCClPzoQs611czEab3tk7KtPEEmEL6phoRPxCjrSA5oay9Vx5IthY+ySBEAiGYN/N/xnjnA86H+s0bZjEmKCBra7pZFpTiroxPnIYcvee51QM1kOB+f2E3kJb81cFUXBsSdx+7Jmh+D62OkhkAGqL4tNdPp3ajpT0VOT2gSA1NeWTEiD+KV6dQYD3E+Qf8N/bhqNz4iWv79LvjTU47GjMg1M2+Gk3oXev/FRYW2D4tQUd2pujGyZ+kS/8Wqqa0c7NqMfdWbbwuK+XbHs7kU8fr8pKDMomBkPRuiPoZEUVPBy9hyFwTYRio7LDFiFPpZWQifoWQfScKzD22T6qibW7dGfgcluNz2zEq0DTkDMvEqU2hwiWw4ys2XVPIfDWxf1E1uq3hQyXQePH/9kxKy24nLOjFN+ITHDj3qGbciskiSrsTz46Km8I4iVY40thl8V38vIWDGtx8/P7TZQkxjYGqKSReNzNzoyfsdP00WnBshxCE4OVteNeLtkFA6qhLn1jyQ5ayiS3OgZ+458wlOQPU92Ye+5x43AMVOLVtAmfkWFv+gBxzX0Y5pOnwWZ9utdpaV9Qgxfl00k/0g7InTcT0eMDrshJJVS7k1mbFmTJNjCRD43wLKJifi/AXka63xr+LO8HqEmmwAGd52WNVfcZ7rR97hf3plSZc7TexCc6Kmb42SBVvWGBvFFblUVTxpBlGBatt2NbNhfWzFyrSg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1801MB2070.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(33656002)(2906002)(86362001)(38100700002)(122000001)(71200400001)(83380400001)(508600001)(9686003)(6506007)(66946007)(186003)(26005)(8936002)(8676002)(110136005)(5660300002)(52536014)(38070700005)(66446008)(66556008)(64756008)(55016002)(66476007)(76116006)(316002)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rJl9SNPEWmkk1Fs6hBNZ2baV02KCw6gyF94JPSHYxA35x+2deZjf01np2VNV?=
 =?us-ascii?Q?ssnsVi1+aTS0EMQGAOYV/A8J3dil7yWnvnqubywe5xWeFxEuHCJcomo1FCl6?=
 =?us-ascii?Q?X11oC7Q981v3fdMoeL/uWgtrk+htDJeW5NlM2R7uJu3MEmw7e/e71yxISFVh?=
 =?us-ascii?Q?EIGTEd4HKWiOw1o5Rp2SAbgM9zYSKUYRMDb3hn9cebies3HjYKr2rPNvA0zB?=
 =?us-ascii?Q?phbKZZpMEax/fpN5Ze60woOngNbDOQP1qQzH9EqETXtTCtSIo/IzWnApwsCZ?=
 =?us-ascii?Q?rUjL+J916hAgO/amU90/t+79tFc2m70sa1JEwLTLOPpX5RvgDA/c9xAFRwad?=
 =?us-ascii?Q?TY3iqf493BlILPj6IYvwJnMZQ/54mhD/yctHurPhK1pE3c//E8ewBmHG0wIG?=
 =?us-ascii?Q?EZ41qsBjrMN/teDlfG2D7M5PAkdjgEWmgEyoMcpDVnxnnIC+aCKDgdbv/JV1?=
 =?us-ascii?Q?u4PfpB3v89Z9VlsG5mNZz5bAg+evIh64DJue4zFEtEvp+KN7MohSOTOWQV3d?=
 =?us-ascii?Q?lODtuOLKNUkuDpNelX4NTdqZyTAmLD9ivnM7r0RIeAyPr0J9dWrmEXUjV3AP?=
 =?us-ascii?Q?vIvRDZ2o0hJl+UqMqJ+U/PdXv9gxU54jL5JB6HtnOgH0cBLGD9UV5/9TzKly?=
 =?us-ascii?Q?nP6KKQaXmIvfmsDEi+q8MjkOZCoEppNKzMHJzUaQbDR00jNyMOS83/+JLnq9?=
 =?us-ascii?Q?oTFBYYjK6UAbL0Kftjw0avpnIWyoxPNKQge5RIJaBYXIVdcFZvQLaN6O1In5?=
 =?us-ascii?Q?axp73ZCtBwOjVelj8n+Jj2tIkh94bFqQ657COtawyLE3I54Aigj58Em9+NdE?=
 =?us-ascii?Q?ZnoY8IxWA3o3ljkYOsGgUBIoxDQ9TXawa89Tp3FcM1JvIbBTjMordPFiZzqX?=
 =?us-ascii?Q?nija+5BzHGEGVQcrvYNcOYAesAJ7Z/bg5QDjQJiAhqQXdQhcccswJa7U7bTP?=
 =?us-ascii?Q?6u0BngKosRgBVJ8bmo5078Q0PUGVpka2JSroUQbCfOb+NG54Pw6gwHlvfs/M?=
 =?us-ascii?Q?xioZKJdv3xYJJdTl9aSpnlB0K7c3PQNc9xXgN8D/5mlLWwTivrYnZOZ3zi/p?=
 =?us-ascii?Q?lcJFVHxAeqDT7CMDj7oH9xlgUj3bOrAxj0Amdz4IqX9oAspKjcVXM6Z0hlWH?=
 =?us-ascii?Q?eAdXRn3muocRPhLXYT2YzlVtKIa3xLO/+aUjkWcK3P6qcbYmEglGTgsbH0In?=
 =?us-ascii?Q?LDQJcEKWUmGvg724QATvxJvfynvx9x12Eex8jq4p5zRTBUzcJzyN3qMLmIlo?=
 =?us-ascii?Q?bKB48oZ8025H60/qrIp34RQy1mu4ypPHb6egBTHjiDt2scT0NMiCt9D0ig/1?=
 =?us-ascii?Q?WJp6pRj5leV8nAEkAPYBvSTB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1801MB2070.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f621555-bfb4-4389-600c-08d98d60f062
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2021 09:16:13.8102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6+pCpqprvChowyK1XwFil9qqKfqcH8G97jR6nD3VKWp8zVa3yeSy9sPIZRy8cJZTj5+WsBIED1kHWaI17ycOlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR18MB1304
X-Proofpoint-ORIG-GUID: vn0FyavbfbDPFmCD2BON2jkpeSlBupIF
X-Proofpoint-GUID: vn0FyavbfbDPFmCD2BON2jkpeSlBupIF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-12_02,2021-10-11_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[...]

>>
>> v2->v3:
>>  - Add COMPILE_TEST as a dependency

This is missing.

>>  - Switch to sysfs_emit()
>>  - Error propagation when invalif event requested
>>  - Switch to devm_platform_get_and_ioremap_resource()
>>  - Other review comments on v2.
>>
>> v1->v2:
>>   - writeq/readq changed to respective relaxed version
>>   - Using PMU_EVENT_ATTR_ID
>>
>>  drivers/perf/Kconfig                 |   7 +
>>  drivers/perf/Makefile                |   1 +
>>  drivers/perf/marvell_cn10k_ddr_pmu.c | 599
>> +++++++++++++++++++++++++++
>>  3 files changed, 607 insertions(+)
>>  create mode 100644 drivers/perf/marvell_cn10k_ddr_pmu.c
>>
>> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig index
>> 77522e5efe11..41a80a4b8d29 100644
>> --- a/drivers/perf/Kconfig
>> +++ b/drivers/perf/Kconfig
>> @@ -139,4 +139,11 @@ config ARM_DMC620_PMU
>>
>>  source "drivers/perf/hisilicon/Kconfig"
>>
>> +config MARVELL_CN10K_DDR_PMU
>> +	tristate "Enable MARVELL CN10K DRAM Subsystem(DSS) PMU
>Support"
>> +	depends on ARM64
>> +	help
>> +	  Enable perf support for Marvell DDR Performance monitoring
>> +	  event on CN10K platform.
>> +
>>  endmenu
