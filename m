Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D97B41C149
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 11:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244987AbhI2JGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 05:06:51 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:15150 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244922AbhI2JGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 05:06:49 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18T8daLR008069;
        Wed, 29 Sep 2021 02:04:59 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by mx0b-0016f401.pphosted.com with ESMTP id 3bcfd49and-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Sep 2021 02:04:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cF5UCyiG5GRiebMhPzkWx9N3uhiP0teNzV9NpLhFcPx9Oja6WaqnPPRPhbYm602CwnMp7IoW0brRY+FVqlj6NzufpRQQ33yPfZJZ6/Ymx+p96Z8qa+slbBm3gZE//nWPVcTSWZOCX/eYQiimcIAbhCoQTDF59m7LrDNZZa7ug4ySnQ+cumhTEDpbmsBVdaxedo6kKq51SAjSnFdGD2srxk0Ipca17GqWTIQGap2v0jnqwKodJ60K61uPqNmV7xzc0dTHmUnTizlGi3aA6V7LBss4iAYhvonZpsa7GvmskT6jh0jgPTQP3H3T4pL3Cym8Zd7M8qUL3dcZCf3eJ4pXWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=xZTxc/PjKSX9Nf4JEb8B4q+gxmAU+kAWS6VLuFAj8pI=;
 b=d5VqHDB/tJNopE+PWH4phUTnXIg+ViO4KB+mCyo3LrYFgrdqYvwxSCjKLLakFCCyQ35wbC9MC/UdVc1LcHkw2Ns4zi8Lddf4/JZ9vT+gtZMjzFyvrpHeUBea5+qdlU4G+8cj0s+GYVbGn7CqhPK2nm9uw6PzDdrKBIrFo+oRCG9gbSPAsKgCa56T9YCOYVHd0mg+Z4YAyNqkSR9Md8iwjf6ziaX/MVLuFUXHw5IcPqjF3Gj/83EQpi5ppibZq8mNK2xW4uJwt0UrwSxzJUqz4UwMbLxw9K5hyvgFJVIfzyYScVRGyMfAv7v5YUd8e926dWit4Jz1Z1fazyJ8jRcKSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZTxc/PjKSX9Nf4JEb8B4q+gxmAU+kAWS6VLuFAj8pI=;
 b=RQuVAv5XmkQD+TxedM5SKFtcByTOQr5YgEOWMHgesOq07R1pxqK5/dcSMMMd5bDk5YdQEckljRJmpugChUddR6KkymEJ4aXHXurDTkpPy39w8eNaPIxBR0fcWeaeuyjNCQo7xMHPX999JTV1MPKexvo7gK6TDdksOJ9jNwx2UNw=
Received: from CO6PR18MB4465.namprd18.prod.outlook.com (2603:10b6:303:13b::10)
 by CO6PR18MB4499.namprd18.prod.outlook.com (2603:10b6:303:13e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Wed, 29 Sep
 2021 09:04:58 +0000
Received: from CO6PR18MB4465.namprd18.prod.outlook.com
 ([fe80::48c2:a5d8:8705:d232]) by CO6PR18MB4465.namprd18.prod.outlook.com
 ([fe80::48c2:a5d8:8705:d232%7]) with mapi id 15.20.4544.021; Wed, 29 Sep 2021
 09:04:58 +0000
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     Bharat Bhushan <bbhushan2@marvell.com>,
        "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maz@kernel.org" <maz@kernel.org>
Subject: RE: [PATCH v4 0/4] cn10k DDR Performance monitor support
Thread-Topic: [PATCH v4 0/4] cn10k DDR Performance monitor support
Thread-Index: AQHXrd2PjHFr6VjFMUaBh2+kP4e3Pqu6wvkg
Date:   Wed, 29 Sep 2021 09:04:57 +0000
Message-ID: <CO6PR18MB44651ED2D114CD0817A7296EE3A99@CO6PR18MB4465.namprd18.prod.outlook.com>
References: <20210920050823.10853-1-bbhushan2@marvell.com>
In-Reply-To: <20210920050823.10853-1-bbhushan2@marvell.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24c3d9ee-35e8-4ccc-239e-08d983283633
x-ms-traffictypediagnostic: CO6PR18MB4499:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO6PR18MB44995E20E89E61772837D29BE3A99@CO6PR18MB4499.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xmYbBe8q6a8uvDqzn1eHBehOoNNx62YVEHBJkNFRzYl/yX2ZmoWMolwBTOTH1y5ZicpFnd8x5CLDS2IFZgCMtzuItZt+sHkRVGnkaV+jZb5jK1GnDYT/htvpAThKw3ZlKpkNTRoBsyNAKHAWSKlN1pvZHrzYC6U53Sm4tcx3oDR5I4SRasllHlvZVJ8Xq42ipzveI1/6sSww7Xzfofz2WUSu4M43y3HJ6qVoPQRg2dYdt5WWEn2hopiAJkvCodZr55qgfyr9C6+AotWi3NyIsSVBbxZrYNn4t8YS+u1yok+TNhroYKuPy6Jfo15TDmeE/nVL7K7FwCl9p+yYcoh2FxddAGf6pEJtdHJxmGKe5O9zC1/pi/MlYFMw83A1uEc0GqlhzASgL/CorjIiTNNqZjsBMMsNG5ooT+k8qUo3bHPvnQi6/sdYZW5ZjF/TMcRz3XDNfIxyRQANyExAifrqteRKuG8RyJaYZ9CWTCVvN3GNEColh8zJlOb8nHBd2vPE7/TOs5INGxL9BkAThealPRB7cPL1lipw4q4vKBOOmqhY4xneA/pHzyJjsNmxx7wRyvtR8M9Rn81pHsFInwtzLa10ZLyLAfmFhz2TtGhx9Ij+JpujuZynMI6Cs3CmICWH0kmudmroFdjmFnXEl5aFhlqvkZHfkJPxes64HFCnggpVDTDLz3q0a4S4I4v7vqFczYHzCf/Bxb6HVLm9/1a0cA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR18MB4465.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(64756008)(186003)(508600001)(71200400001)(66476007)(9686003)(7696005)(33656002)(2906002)(86362001)(66946007)(66446008)(52536014)(55016002)(83380400001)(53546011)(122000001)(38070700005)(38100700002)(110136005)(8676002)(5660300002)(316002)(6506007)(26005)(8936002)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VsAqp+lAlc/DrjIyjEjDPYvXMPoeWelkCj37UmgYmG1NDOsaD33SPsqjoklt?=
 =?us-ascii?Q?9YoziYYUi9qQVu+o167JHtiURT4NyALrSQTneAPaiApwbbz+BKfStGQpRPKx?=
 =?us-ascii?Q?2/uSYWhoJRZIOyguHQCWNmf7by78uyMiUFJz1c0Jr0Jcp1HDwk29gL1G2/+0?=
 =?us-ascii?Q?hUpHuKMe5gGf2Z1eOBCeOzXeiQITzccRVAWrIvnYSXTO2YzFpqCrEDqhm/mq?=
 =?us-ascii?Q?6R21ZmzXzwUNMExxqvZhrxdgo2DIK8EsRPJUI0Y8VhotVFFW/N/0QHX34Wy5?=
 =?us-ascii?Q?FX4mL61pdHv1VNmTyedU2wAlWSsAdz9XSQQY5oH/dX/9nyIRKc+EiDg0yK6X?=
 =?us-ascii?Q?ide0IWZTUUeqhDu7s3n3ky8zXicU3MEdTvfAR7xqmHTlNmTNe353WruJrsAG?=
 =?us-ascii?Q?9BAs/OZYmuTF/aVeHV6bGWLZxmbnH9LR0W2qowB5TqCLkCB0mJfGFONhXkQW?=
 =?us-ascii?Q?fp9fhjQUzgMOE4iJTimnWEoGhueMOr981dQVz+yNdsosZ1hVuvHPBOCLgklz?=
 =?us-ascii?Q?k+qp2Alfetv0PnZSSJIXxmOSKa9I1Tb9OS5cv7N/0qFrtJgKDYIok814rmQ0?=
 =?us-ascii?Q?kDSgI9SG6f/I90Eo4QYkdhN1YnMLDdzL6e1MmCWoWgiiwi2PPwSydyEJww1S?=
 =?us-ascii?Q?O5aDBpI7RyXy2NPtNwe8HGfKoiK/6wqzXRO1HF6b2LE0+7QkJ8OkWN15L6ue?=
 =?us-ascii?Q?zjCcRAxGZ7GHec8vRsZo8YVSprbCkEvnf+6hh5plZMC2s5b6FxTnJWap9VnX?=
 =?us-ascii?Q?W/NVXvUhuZ8YZd6xGOy0R+gjQktx1SihVpxAVTa5umv09V9OPLLvEomnar5i?=
 =?us-ascii?Q?kD4BwIkoXBEH2lle91aazvuTcEFVrzsVnicMHiPx/pFLU1iJJCMRTv2VMYQq?=
 =?us-ascii?Q?OqWDaDQxZ/fLpnITPKUWrD/5sY0Wjzg0nDzWBQtRVJNASkhsqAhdGarLWTm7?=
 =?us-ascii?Q?1KNFRYMniCKXphO0RJTj7vSoS6kT35otWYaZCLnd2KqZmO8lyBcDnjfprbNt?=
 =?us-ascii?Q?WJ4lZeV/7d5LmAl2cT0Dyw4AD1DJJamm9+74SQxTgEM/86L335Jmlqnl+bvt?=
 =?us-ascii?Q?V/WSbtum6brlSdJepT5MLhJgq85dV3FjqC7DynaoWbvFfwHtuzvhzOckREzP?=
 =?us-ascii?Q?Zh/cCgeFpBJG2Ym8bRNVLONWZSfODmDv4Vuvu/Wr6HmO7Kry43qAoHDux9yA?=
 =?us-ascii?Q?lk16MLv3MCHVDcf5fJkjU6FMBFQxrtyhrATGQ9bgtf3YvBUGdDgWyvktpn6W?=
 =?us-ascii?Q?OwKELGvqxiOF+iSxaipmK2S5PSaekf0Bb+DmOEIQCi5mk7rTMP8LMTdSvu8t?=
 =?us-ascii?Q?C3Wiv6UR9JAgQzkqckf2XWzW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4465.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24c3d9ee-35e8-4ccc-239e-08d983283633
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2021 09:04:57.9593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Piz/yePMGzjXt7WKO3BIEmZHoC3+U+p0S5WlxTpd7rdr7ctKKDf1KhpknPJ+F72J1eVMyRibBTWIY55BUDhug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR18MB4499
X-Proofpoint-GUID: HrQcuWbluNOcSA3ysaNS-eM3LDHJj3f2
X-Proofpoint-ORIG-GUID: HrQcuWbluNOcSA3ysaNS-eM3LDHJj3f2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-29_02,2021-09-28_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

These patches are there in review for sometime now. In fact there are some =
more patches pending for review in "driver/perf" subsystem.
Tried reaching out Will Deacon but he seems to be not responding. Not sure =
who is going to review/pull these changes.

Can someone help on who is going to review and pull these (driver/perf subs=
ystem) changes?

Thanks
-Bharat


> -----Original Message-----
> From: Bharat Bhushan <bbhushan2@marvell.com>
> Sent: Monday, September 20, 2021 10:38 AM
> To: will@kernel.org; mark.rutland@arm.com; robh+dt@kernel.org; linux-arm-
> kernel@lists.infradead.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: Bharat Bhushan <bbhushan2@marvell.com>
> Subject: [PATCH v4 0/4] cn10k DDR Performance monitor support
>=20
> This patch series adds DDR performance monitor support on Marvell cn10k
> series of processor.
>=20
> First patch adds device tree binding changes.
> Second patch add basic support (without overflow and event ownership). Th=
ird
> and fourth patch adds overflow and event ownership respectively.
>=20
> Seems like 4th patch can be merged in second patch, For easy review it is
> currently separate
>=20
> v3->v4:
>  - Added Rob Herring reviewed-by for dt-binding patch
>=20
> v2->v3:
>  - dt-binding, ddrcpmu@1 -> pmu@87e1c0000000
>  - Add COMPILE_TEST as a dependency
>  - Switch to sysfs_emit()
>  - Error propagation when invalif event requested
>  - Switch to devm_platform_get_and_ioremap_resource()
>  - Other review comments on v2.
>=20
> v1->v2:
>  - DT binding changed to new DT Schema
>  - writeq/readq changed to respective relaxed
>  - Using PMU_EVENT_ATTR_ID
>=20
> Bharat Bhushan (4):
>   dt-bindings: perf: marvell: cn10k ddr performance monitor
>   perf/marvell: CN10k DDR performance monitor support
>   perf/marvell: cn10k DDR perfmon event overflow handling
>   perf/marvell: cn10k DDR perf event core ownership
>=20
>  .../bindings/perf/marvell-cn10k-ddr.yaml      |  37 +
>  drivers/perf/Kconfig                          |   7 +
>  drivers/perf/Makefile                         |   1 +
>  drivers/perf/marvell_cn10k_ddr_pmu.c          | 756 ++++++++++++++++++
>  include/linux/cpuhotplug.h                    |   1 +
>  5 files changed, 802 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/perf/marvell-cn10k-
> ddr.yaml
>  create mode 100644 drivers/perf/marvell_cn10k_ddr_pmu.c
>=20
> --
> 2.17.1

