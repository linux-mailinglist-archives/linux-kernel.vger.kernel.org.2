Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9423C7948
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 23:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236463AbhGMVzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 17:55:39 -0400
Received: from mail-bn8nam11on2063.outbound.protection.outlook.com ([40.107.236.63]:1633
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234947AbhGMVzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 17:55:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FcLo5urE5nTcJXhLZq5AByAh4FpIse6kF307dY2vfU8XpXspUEmq7MQl+aE98X+2UHxgFuYUWDRsfgtBsZGMWBqRmn384G8OpqRO11vIl6dvrhsmsNTKMMkk8JLqhF2sh/i7LiPUR3WbbIwx6U7AGdSGo00p16UM5Zwz9VgE4dv0fe+ptnK/p3Sc9ThF5irR42NRrqxe8lbOShroM3IZ6WbCxM470N9CNIF8OFsa0Hti66tFgY5mYxDb9jAncBG5Nmdyrr94MP9XSHiJiqtqKmimAO+LQdQPkJVDn5OzI3Qmw1EU++KhzWULM6+S0jM/k4LjcKugN5WgPH9NmHxz9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQiX4z+9teJ3q7ryBZaQLLmuzytWuC1rypA0jziQefY=;
 b=XBblid3G7ujPwgZqM6BA9ej1loDXez3FMODBHompX2I6odd2d1KlrKeDcgXD+0WjQ+J9PszLYUcpvXEZhIIMr6M0GSxfAiBnZkYWeiYgCGgCIp76FVLGc4I5+fa4Ji+wyPzyJjIdsh0LdLqQWy8s5qjPutSpiOlUcB6/VPu3OJkNZoXffRA5zZcuviFkyunNMe17Hg704qLzXP2uktMzYJ8Pu1GtDUP8I6DCSuEPDRIpuBQ9tdsz4F/koygZAXNuVvSETtF9ELRTYChgsn40etgZDfOlOgtoCgadQR4NZ27AHblvJAosQm4qMq9j3MqVnqfHcuRDuOtYDJc2eRnPTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQiX4z+9teJ3q7ryBZaQLLmuzytWuC1rypA0jziQefY=;
 b=vaJmVLcmHs+CL+LGepeIiW6hrHgDzrzkwoQJWVUKXPR9reqT7u7kZlQDxyxQzAlAjSrv6nWIwk05vpALb8a7+YO5fNAOW4XzOu1fnd8lJ9V4GB2MYWVLdtdXrmnTuIFtWB90Xcu6usVDwEQCl0e/15HaD5FPAFygV0Yrpqjziv4=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by BYAPR05MB3975.namprd05.prod.outlook.com (2603:10b6:a02:8f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.14; Tue, 13 Jul
 2021 21:52:45 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::6850:f36b:29d2:2769]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::6850:f36b:29d2:2769%5]) with mapi id 15.20.4331.021; Tue, 13 Jul 2021
 21:52:45 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     Joerg Roedel <joro@8bytes.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Jiajun Cao <caojiajun@vmware.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v5 5/7] iommu/amd: Tailored gather logic for AMD
Thread-Topic: [PATCH v5 5/7] iommu/amd: Tailored gather logic for AMD
Thread-Index: AQHXeBaBI4ds/9zJPUSkM707TxU6GqtBcqQA
Date:   Tue, 13 Jul 2021 21:52:45 +0000
Message-ID: <80134D97-D8CD-40ED-88C3-4FAD620E4F12@vmware.com>
References: <20210713094151.652597-1-namit@vmware.com>
 <20210713094151.652597-6-namit@vmware.com>
 <d9818e0b-681c-29a0-d9cd-e2f4dc963eb4@arm.com>
In-Reply-To: <d9818e0b-681c-29a0-d9cd-e2f4dc963eb4@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8da13ce-3bf2-4669-884f-08d946488c12
x-ms-traffictypediagnostic: BYAPR05MB3975:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR05MB39758813E672BB3EA50F50E8D0149@BYAPR05MB3975.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WAf2IhcsHRb5Ye1N28ZfQrznVMo0kX2VO8Se3f5xYairjcFBXqSL7TJD5MnPrP1hhWwrCUBw0PWGfrZZvWh8mmArsAmHHSJ+c8lyt7XS2NVMe/RbruDY7X9PzZOrynZlTZh+RNC3mJaflPWjO09Ra9Lw+QB7alruWSCeA3f68hyHaGAlue8iTdv4U16OOkRxrAwkzRqvYSHkZmC9npX+aAk9O/+QyeYmqHmeXkN6+mp65iuraC+6DaWlp0m8y+kFeLZWAquer24gmDI1WZDHYYVyV4pkbWMufChhzP1tBbb8NDId69rcWmaHRqNINm1SIoO7zRa2tf4zatx66zh3wimwaRCDsX5ESP9d2f3gvO8xpl00oFfeyMejgVq1GA40HlcjL1zA05mJCgHGC/U4IsBM6NaQlO4tO5xoh80LVsc4y09rzbVs5LNvk7p9KmjaYqNfdNaZlngkBXd0v+ACHmjP0E24fk0o7TeKfqzMmTJW1NzF32LOOmnQIEf0f8Jw6E3oJanQKlKwti+KqZck8Gw5maak3EpGiUxrIYCcoZOL7g4vs9h4MKEsnB3vCB/y06BSurkXN1tlSny06qIXWGao7GM0//nJq0WR9k9KlCrqT2MghGykIy3NLmDQ9db0gb7tkLaizEp+E7BaeVKaaB7BWqv1Hc5nGpIQUA7H9OTfM7mxiv1jHIw2zNqrbC0yUC2EWV11F875cSPdwJag3j5dFvDmbh3PKk0y9UKFjjc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(136003)(346002)(39860400002)(122000001)(6916009)(6512007)(478600001)(66446008)(33656002)(186003)(64756008)(66946007)(71200400001)(66556008)(66476007)(38100700002)(54906003)(2906002)(76116006)(26005)(6506007)(53546011)(36756003)(8676002)(83380400001)(8936002)(86362001)(316002)(5660300002)(6486002)(2616005)(4326008)(38070700003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?o0cfB5PaxC83DKna/rAmlTw5jzBSuSaHSfFO+sWCgH6Xgo1QvYVng4L2xpYm?=
 =?us-ascii?Q?n3EBIsD4SeRtRCVQW9nnX3HSERsbrKA7lco+F/rBayOnO7xMhB+ODsSD2hsy?=
 =?us-ascii?Q?khXlhYedJoE9+kWUbsi9CuA2/ZeN1P7gPX8LfTEkG6EWgHcvgmQx+UPFmU9o?=
 =?us-ascii?Q?5TcijzWNNXz9YSE4YZ1qPZeJijtyYwqLF3srlxp/cAn8wOPqwSBSpiTI4N69?=
 =?us-ascii?Q?7VvOt9E5ClmkCJkVVLxiSI9Cn5uSsDreaKNBuMom68G/dkt4zC/M0bwUjcwV?=
 =?us-ascii?Q?7tXqsVZHWUYpBjvQnWUCfeqzry7jpg8UH7Kc9gCZHZ0M1LuxgIb1pnVU4bLT?=
 =?us-ascii?Q?cesRk+cI+NgyRXG9STeE0OhLuqw/+hISHNEMR6VChMkpicznrBL5eA62ukSf?=
 =?us-ascii?Q?HE2TYR1DmxG6ybWTYC5DDtx+zuUBy6a/GAy4SUOBLgIpu58yOOHu42ABARQB?=
 =?us-ascii?Q?tzLK4ehOTGnGAH3MRxKvlXbXH2ufQunD83F33n+B4TwsU4JQ+isbVs/Yy0KN?=
 =?us-ascii?Q?Ioqg/ZFY0JUxLTZYETbOTMhN50HWleyDzNtyMZDM2Nq6MQmAsekxh8yCGgJI?=
 =?us-ascii?Q?w/SqxpheC0Ky1YWBroLk7RdDqJNpw+yn5VUeszOAH3GQZarPeaR92Hk1ph6u?=
 =?us-ascii?Q?/4V9lXAqBp3i1CXtjgjgcbqrHu2KoZmJO1Mc7BNOivGy1cQS8J+3TrPwT6Kr?=
 =?us-ascii?Q?jnFq3HU/UzMCBEhU0HhUU4icfxrzNh4NdSTcE6abCdBzSrlNjorpkwbGSB3q?=
 =?us-ascii?Q?AYJDb7fsZD8cAWjqBwDA8uPjU3EbRYI2kpyZ1NAFvebC88K5MWa3Qjanakao?=
 =?us-ascii?Q?tO00K1LobA6t5mO2/VYN5wGm39Z4143G7ezjeBb2Awn/6jdKyEsflMsNgE3D?=
 =?us-ascii?Q?m7CrbgTVuMs2JdXRIV9gIOzACXFUJ0IxyL8w6YS/tDFhrClMYC6eyUlx7OjS?=
 =?us-ascii?Q?OLmCdgPYXhdwHX7gcJcRFYyiZpIwYGgkrB6JMZ9mPlSm+yKtMKwM9F3a5o5q?=
 =?us-ascii?Q?YGxBVUctXmiWzZ2r1ppXrtUyHRo63VcgV0IcXbEPaCiL4DtghpNJSCxDSjD0?=
 =?us-ascii?Q?wzj+VdWV5G+hTiM0fV+dWomy1yseS7vB8/pHFK8gdtcafLKawaWN9nkJWs6O?=
 =?us-ascii?Q?+WkOwvTabd51MRCKiUZOiZ8AaTLSTN/kBOCaPNdaPXu9ly3wgdU1MNLlR8uz?=
 =?us-ascii?Q?jykkef17AyJQ5HBkgJuFyXBr/Clen17XkodvoApBLK50sfm+BFY4KnHm+GY8?=
 =?us-ascii?Q?g2XIXAp/oi4OzM9GIaZ3eDRmYINzfhZGLpg5Vp40uQLTQNegFXOx982dZ+V7?=
 =?us-ascii?Q?2S+6vD1ldFJQZNJ6aQFD7V4I?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <56D0AFF61FD76949AEC2C48C5A77A3AE@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8da13ce-3bf2-4669-884f-08d946488c12
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2021 21:52:45.0752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bUdzp8jbqm5pylivNtcubUI2SpGIpHjqjU8HnaG4dLOh2Ws0Y2aRNn61ZSSwwIKGBsIQAvfBnwQDtbbF2XjjnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB3975
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 13, 2021, at 11:40 AM, Robin Murphy <robin.murphy@arm.com> wrote:
>=20
> On 2021-07-13 10:41, Nadav Amit wrote:
>> From: Nadav Amit <namit@vmware.com>
>> AMD's IOMMU can flush efficiently (i.e., in a single flush) any range.
>> This is in contrast, for instnace, to Intel IOMMUs that have a limit on
>> the number of pages that can be flushed in a single flush.  In addition,
>> AMD's IOMMU do not care about the page-size, so changes of the page size
>> do not need to trigger a TLB flush.
>> So in most cases, a TLB flush due to disjoint range is not needed for
>> AMD. Yet, vIOMMUs require the hypervisor to synchronize the virtualized
>> IOMMU's PTEs with the physical ones. This process induce overheads, so
>> it is better not to cause unnecessary flushes, i.e., flushes of PTEs
>> that were not modified.
>> Implement and use amd_iommu_iotlb_gather_add_page() and use it instead
>> of the generic iommu_iotlb_gather_add_page(). Ignore disjoint regions
>> unless "non-present cache" feature is reported by the IOMMU
>> capabilities, as this is an indication we are running on a physical
>> IOMMU. A similar indication is used by VT-d (see "caching mode"). The
>> new logic retains the same flushing behavior that we had before the
>> introduction of page-selective IOTLB flushes for AMD.
>> On virtualized environments, check if the newly flushed region and the
>> gathered one are disjoint and flush if it is.
>> Cc: Joerg Roedel <joro@8bytes.org>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Jiajun Cao <caojiajun@vmware.com>
>> Cc: Lu Baolu <baolu.lu@linux.intel.com>
>> Cc: iommu@lists.linux-foundation.org
>> Cc: linux-kernel@vger.kernel.org>
>> Cc: Robin Murphy <robin.murphy@arm.com>
>> Signed-off-by: Nadav Amit <namit@vmware.com>
>> ---
>>  drivers/iommu/amd/iommu.c | 23 ++++++++++++++++++++++-
>>  1 file changed, 22 insertions(+), 1 deletion(-)
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index bfae3928b98f..cc55c4c6a355 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -2048,6 +2048,27 @@ static int amd_iommu_map(struct iommu_domain *dom=
, unsigned long iova,
>>  	return ret;
>>  }
>>  +static void amd_iommu_iotlb_gather_add_page(struct iommu_domain *domai=
n,
>> +					    struct iommu_iotlb_gather *gather,
>> +					    unsigned long iova, size_t size)
>> +{
>> +	/*
>> +	 * AMD's IOMMU can flush as many pages as necessary in a single flush.
>> +	 * Unless we run in a virtual machine, which can be inferred according
>> +	 * to whether "non-present cache" is on, it is probably best to prefer
>> +	 * (potentially) too extensive TLB flushing (i.e., more misses) over
>> +	 * mutliple TLB flushes (i.e., more flushes). For virtual machines the
>> +	 * hypervisor needs to synchronize the host IOMMU PTEs with those of
>> +	 * the guest, and the trade-off is different: unnecessary TLB flushes
>> +	 * should be avoided.
>> +	 */
>> +	if (amd_iommu_np_cache && gather->end !=3D 0 &&
>=20
> iommu_iotlb_gather_is_disjoint() is also checking "gather->end !=3D 0", s=
o I don't think we need both. Strictly it's only necessary here since the o=
ther call from iommu_iotlb_gather_add_page() equivalently asserts that the =
gather is already non-empty via its gather->pgsize check, but one could arg=
ue it either way and I don't have a hugely strong preference.

You are correct (even if the compiler would have eliminated the redundancy)=
.

I will remove the redundant check.

>=20
> Otherwise, I love how neat this has all ended up, thanks for persevering!

Thank you for the thorough review!

Regards,
Nadav=
