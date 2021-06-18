Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01EB73AD5D8
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 01:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234200AbhFRX3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 19:29:03 -0400
Received: from mx0a-00268f01.pphosted.com ([148.163.148.236]:21712 "EHLO
        mx0a-00268f01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230024AbhFRX3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 19:29:02 -0400
X-Greylist: delayed 369 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Jun 2021 19:29:02 EDT
Received: from pps.filterd (m0105196.ppops.net [127.0.0.1])
        by mx0a-00268f01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15IN98aY016018;
        Fri, 18 Jun 2021 23:26:06 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by mx0a-00268f01.pphosted.com with ESMTP id 398t5g250y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Jun 2021 23:26:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dy/Mle2Oi8M3CVhNxwxLJuPXm6MYPrGTGbR/nNrQE7zQTYG51TegIsTLM4jVVLC7sLhmvxV9DtdJmnYvYyIM2uc9VLfuxHeWEiaxnedjzEajFcisLteM1BByJ0klc26AGGrWbpatnyfcFJCxs6NgWbbQHyxXpxzxc/OmLt2MapLAhCJMp19qt4nPTK4NDbolEwFJJtxeVA8HkYXw80JhGbu0F/oqBwwEWTnyPkqnUIw+HLS2Q2w49+oLsgDkKm1ee49V3ioYK7P+fPwblWEuwu0FZigYAebCpkDk53lKYigl5oOXgi9OnvFUByH82IqeiCs1RUXWRJwHNYi8Q3BHuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=li1V/gpPvLIk4CCX2gjzknxORZCgZ8DvXkjjeoOkvaY=;
 b=LpdMR6IANNXqjA7Ljq4pDzmoMPXtxPgMCeMZpapcAnjT9UxsAYd4Pr230n+U2aYvXWZt87J0N+R0fqBxo4urXnnxND0WgVrAi8Ho4uHMfJcqSmkmxn08oVVcFUb59QD9Nh8oMyxAV8/sCC2Pe7iRR8Uh80cIUt8k+3myyKegG4XBch3j+p05IFzgGztyeIjj9ihnS/TzG3VcY0tSygo3w+U34UOIWRpfmG7a7IxGufyBgZzyUyXklR00zz0e0C558f0qXyevEIu+8jXkpZkUy5j3UcjdMHFR4jlCu4qouGIK/rNRn1vYgUJJBYTzjy+v8MBy2S8Z5laGRG+Y5a6nJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=equinix.com; dmarc=pass action=none header.from=equinix.com;
 dkim=pass header.d=equinix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=equinixinc.onmicrosoft.com; s=selector2-equinixinc-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=li1V/gpPvLIk4CCX2gjzknxORZCgZ8DvXkjjeoOkvaY=;
 b=ao8crM/CcOKd/W0q3Oonty3cAd7k05fVsed6O9AkuBYxuM9aVFvJrUEE+kOe8V2xVlBGfWLfQ4HTGfOsjTOEXjEL9BG71/BOLZb1OSwAqfa4WarhkP4ozadWgZaJinOP2kiHnb8qzFBXE3Pw4MXD//r+oOzWnVsra14sCpG222w=
Received: from DM5PR04MB0762.namprd04.prod.outlook.com (2603:10b6:3:f3::13) by
 DM5PR04MB1212.namprd04.prod.outlook.com (2603:10b6:3:a2::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.24; Fri, 18 Jun 2021 23:26:04 +0000
Received: from DM5PR04MB0762.namprd04.prod.outlook.com
 ([fe80::d9ba:6e7f:b51e:6cab]) by DM5PR04MB0762.namprd04.prod.outlook.com
 ([fe80::d9ba:6e7f:b51e:6cab%2]) with mapi id 15.20.4219.027; Fri, 18 Jun 2021
 23:26:04 +0000
From:   Zev Weiss <zweiss@equinix.com>
To:     Andrew Jeffery <andrew@aj.id.au>
CC:     "openipmi-developer@lists.sourceforge.net" 
        <openipmi-developer@lists.sourceforge.net>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "minyard@acm.org" <minyard@acm.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tmaimon77@gmail.com" <tmaimon77@gmail.com>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "avifishman70@gmail.com" <avifishman70@gmail.com>,
        "venture@google.com" <venture@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tali.perry1@gmail.com" <tali.perry1@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "chiawei_wang@aspeedtech.com" <chiawei_wang@aspeedtech.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "benjaminfair@google.com" <benjaminfair@google.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "joel@jms.id.au" <joel@jms.id.au>,
        "KWLIU@nuvoton.com" <KWLIU@nuvoton.com>
Subject: Re: [PATCH v4 08/16] ipmi: kcs_bmc: Decouple the IPMI chardev from
 the core
Thread-Topic: [PATCH v4 08/16] ipmi: kcs_bmc: Decouple the IPMI chardev from
 the core
Thread-Index: AQHXZJlOx+4tEFa7006+6O/7RaWCzA==
Date:   Fri, 18 Jun 2021 23:26:04 +0000
Message-ID: <20210618232603.GC9658@hatter>
References: <20210608104757.582199-1-andrew@aj.id.au>
 <20210608104757.582199-9-andrew@aj.id.au>
In-Reply-To: <20210608104757.582199-9-andrew@aj.id.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: aj.id.au; dkim=none (message not signed)
 header.d=none;aj.id.au; dmarc=none action=none header.from=equinix.com;
x-originating-ip: [24.181.166.149]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 52a42a0d-31ad-4bf0-3c16-08d932b07153
x-ms-traffictypediagnostic: DM5PR04MB1212:
x-microsoft-antispam-prvs: <DM5PR04MB1212AFD6740864FDCE088464C30D9@DM5PR04MB1212.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:901;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VafWRHu1ZILGHQJAaYiqyDp5f9sEmuCZ9mcnTKX0MlWvSluFG7OfHTQrUfcI4lnmbZ5WieRWQf69FqoXxu9zP88CQARiOLyKdTM0HSLjh0BhPwkEc/LFNsdobjMTAajgxRVXWq8AttxPTfvuA2fNEkXscNZg/q9hEyRoMA5d9SQ8Bdp+VRZLzbSm+7kYGx0l7JodjfTIMjld3O+lN+S5IjyaIJI2QiiKqxjWHlN9oNd67J/+VtXp0j2FgSQ4abMyiDL9x/Kiy8lcTqDj+JW1ICqvT7qV88t9JIOGI/Mpq9pn/g1KvNokivWOgaFN1Xq/bx1spZcpntP9DzGWfZ8vqun37ZGcoyDeDXO3GOAgpcJYanboaDd6BQK1qqDH5tmZDSY54Mj6q3KaqqUZ96ixUeZ0ouuF2kqK7noi+1m0VvWuGawAz/0LQgK3PmyGkfiL7ESR3NvdfZKyIF83Ix8siTWIkaz4iUYFJIe2jE7n0QLtR+pfropXyydNyIvOuMVR6wxxGtzfOs/kd08Bhrkp18Pf//Nybn9shpWEKfvBWH9+kgQgr6QcKLUwF4D+Giy6G314NaKA1B0qkftae51wbMZWg+29q7pNknTi5WFJSzM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR04MB0762.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(136003)(366004)(396003)(346002)(39860400002)(376002)(4744005)(86362001)(6506007)(83380400001)(186003)(76116006)(2906002)(316002)(33656002)(478600001)(4326008)(5660300002)(33716001)(54906003)(122000001)(38100700002)(8676002)(26005)(7416002)(6916009)(1076003)(6512007)(66946007)(66556008)(8936002)(66446008)(64756008)(71200400001)(66476007)(6486002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ioFoyzjWSSBZHSmHbhR/Gghvsqy2ptX271ieNkUk5FWgZ//roQp3N/GhPMcL?=
 =?us-ascii?Q?xL5VsOeMwKr1+UpBjlq1Vs9AEMCW5grFQONin0MlM2S+M8+gC0nY1alZ1rGg?=
 =?us-ascii?Q?YUv3QG+Cu9nl4Dz7isvGSdV5bK8G5GKgJ1MVvMXecA/OoQqQY/ZFFhBlrUuy?=
 =?us-ascii?Q?L6d0YXARvA/+DHWRPuHqU6T5N1Gspg2ZGk2AlJQmDypFnjCsxh+CFIKEd2Lb?=
 =?us-ascii?Q?YBRek3Tcp17SSxse2OnFgwuAc9LKUF+MP4FnuxgcqEZ1YC1d2j4nL0Qpl0qP?=
 =?us-ascii?Q?B5vt3gstEBpW7/fKGyPqreaCEWjxGxmpAmvMnrdYK8QQ9qwo5lLTwOAHMENH?=
 =?us-ascii?Q?J2Aa1y5PF9VVDlrFu8R/z1KrB66oTO+m8LJ0NaAL5mLB/GIqtSAkPu3+I982?=
 =?us-ascii?Q?ZQVMWnit/yVC7bAfZh+X14LaO5F6EkNusbrq4HO+nrygzyNGHXoQzrwZmX9W?=
 =?us-ascii?Q?l9TU6z1TaF2UXo33s6lvYX+8zTBaEFt95OpN3hUEdyZKc4gJUV2D065p2r/7?=
 =?us-ascii?Q?tTh5FGBdy8V1hl0r0SQzqDEFcQ7yUYfsSAyT02CuyKVABFnGFViUWb+6lqK5?=
 =?us-ascii?Q?8Ef3XREAMEOipuxvAck8CcMPDJTwxzjToGz6oObgNZ9+bEVbrtBfRbCr4hpR?=
 =?us-ascii?Q?/pdTOhJ1IEz0PBc9mae5AhaopRpDKnFoqLKehaE5Q1KAfABqmQXN8OulKRmh?=
 =?us-ascii?Q?G+0Xv5g9XL09MGtUb1L17vXOjCSgOrCaXHKsX0IFPkPfyGOe2oNtpFCjGBAQ?=
 =?us-ascii?Q?uMN2UgflH+e3HB5G+VPwC90dmBMmtUIYq2VMoxWXqrwroXB4aVm1c/0/Ntmj?=
 =?us-ascii?Q?ge6HSkzXbXIG3spTSOc7CHKn9J6Re5T41wblU5rYVvVn5QXql6NxyKnR303U?=
 =?us-ascii?Q?X0WqJTxdpctgc1axlbAVrzlufwNGfDCeM4P1MzVN40/sVE1EynzVPfGgaU9W?=
 =?us-ascii?Q?nEiIEM8EC02vd3UdRczmQABJo/RO5PuMHzwclQWwBXJG1jZdrmDubDe81i32?=
 =?us-ascii?Q?nCsrUVRbTcOY1WJXWu9TJEJa3XKrvWUAq4QkS0ylJd5brnqGm5ZCxNLYFN8+?=
 =?us-ascii?Q?vp6HaB53G6ey/qddEI9shcwhTkVWVY7RyLOXl78dvhDS+dW758t8LFfSgyuw?=
 =?us-ascii?Q?ox++/GWLOlryhd38vSSaID8LA0C0wCBj9Fu8UTIX2+vrByWPh5PNCOPfKMEC?=
 =?us-ascii?Q?kdoAKsteJK7snRV6u2fOcCqCLU1lfa2nQ0gSv7hXltYdzFjcQJSteBQ4s7MY?=
 =?us-ascii?Q?iS6PlDmYdjhqA5Xtz6jrS93ZSPOnWizuvOrNZRH5aU0hqPVssjITaV5ExFgC?=
 =?us-ascii?Q?0Vo0rTkeFp8j8Tfm4wyvo69g?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2C6197FE3601F941923E62DDDEE23977@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: equinix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR04MB0762.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52a42a0d-31ad-4bf0-3c16-08d932b07153
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2021 23:26:04.5789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72adb271-2fc7-4afe-a5ee-9de6a59f6bfb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uUf227+KpMHIMhImdCDKMYxHzZ6oSOib0mbxaPQtfxy+J9O9l2ftluVMPgsB2Yj4MDHf7FTaWw+2XnhNxEQGBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB1212
X-Proofpoint-GUID: ZZ7ib3hHweYQCSrr_4OXnkKOrdAMQjuT
X-Proofpoint-ORIG-GUID: ZZ7ib3hHweYQCSrr_4OXnkKOrdAMQjuT
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-18_12:2021-06-18,2021-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106180136
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 05:47:49AM CDT, Andrew Jeffery wrote:
>Now that we have untangled the data-structures, split the userspace
>interface out into its own module. Userspace interfaces and drivers are
>registered to the KCS BMC core to support arbitrary binding of either.
>
>Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
>---
> drivers/char/ipmi/Kconfig             | 13 +++++
> drivers/char/ipmi/Makefile            |  3 +-
> drivers/char/ipmi/kcs_bmc.c           | 80 +++++++++++++++++++++++++--
> drivers/char/ipmi/kcs_bmc_cdev_ipmi.c | 31 +++++++++--
> drivers/char/ipmi/kcs_bmc_client.h    | 14 +++++
> 5 files changed, 128 insertions(+), 13 deletions(-)
>

Reviewed-by: Zev Weiss <zweiss@equinix.com>
