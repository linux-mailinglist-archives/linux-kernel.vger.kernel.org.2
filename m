Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 432F53BF890
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 12:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbhGHKvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 06:51:15 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:45196 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231512AbhGHKvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 06:51:14 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 168Aj9T6009255;
        Thu, 8 Jul 2021 03:48:21 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by mx0a-0016f401.pphosted.com with ESMTP id 39nrnu1jhy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jul 2021 03:48:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SyIj9hlxwuK2fc6HNeZeNOfXBOcoVbycyw4dEGmyZunZSs9TcyCgC64LRvFS3aljiK4zf/8kkgcVhSpC4ylyHfDl9s5aNLnM7TcxnfINfDtYycg8zELFqDqZfq6+ToRdmhim8jIMkuH6UsDUvszWmGfeJqc+rvT1neO5GIlxaJE0wnpGj4vf1aR+pp6CVi9kFo5qV4eOZiS1aOb1JCZNTtqw2UYlEi6SxNYs85Jb6zLqPP9fZStUxVSSEh7Bx2vdsju51iXbQ0MOtdQf4ILw3Eu+iI0UuneJc/hVnfm9qWPIomSJnFUvLKfDHbPe5IdNYko5QauEkdsQqFEvzU0Z4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=syeIjh4PO5hpkSUtLh/FYIv/Xdn98n1bsCFaaHMEgAw=;
 b=hlu6mEVDypcAZpM6APcfwutugJArZvynaGdcQQg5tC1VPGO+pXKBv9/4igVOTeTjEHxQv/Uk7TnL+JFQwOFY9AlOXj/J51R/R9aA2wYT9QVa3pCjt7EH0Kw9sUjTkARQheor/bEnbkJFBbYhT8n2nqEA/jlL//xF+q9JLoncGhtcuSaZR9iFPkWr0pCFCJtNpg5H3iRZmAioj1P1LJYAaMwcp/n4dJz0F7RkQ+cuIOIlKRCtIyLOfEZdvwvA2ULf1o2cC5wPtah4VdSqI2sB7N2gOa/CwNM7md/b3vC+vn80hslBqcDLHJASgOKwUzXeS2LVg7tdzkg7ljniZdbBxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=syeIjh4PO5hpkSUtLh/FYIv/Xdn98n1bsCFaaHMEgAw=;
 b=R7CLNHuy4m5ynzftkr5p7aKHwOXsmBGlLwa9EnleKvm6lvvkynS/21n9CNo0Vp7FNy3Jq/3s/YdtFQCwhFltgkYmBC2GqegvNhyLD1j6ButdUHDye8oVVC9HRp+C9Xdqtf0wVU9Dphsc554VFblUvF0bI4sWBO+iUIa2XR52wH0=
Received: from CO6PR18MB4465.namprd18.prod.outlook.com (2603:10b6:303:13b::10)
 by CO1PR18MB4729.namprd18.prod.outlook.com (2603:10b6:303:e8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19; Thu, 8 Jul
 2021 10:48:18 +0000
Received: from CO6PR18MB4465.namprd18.prod.outlook.com
 ([fe80::7412:17a6:caa5:8df2]) by CO6PR18MB4465.namprd18.prod.outlook.com
 ([fe80::7412:17a6:caa5:8df2%9]) with mapi id 15.20.4308.022; Thu, 8 Jul 2021
 10:48:18 +0000
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "konrad.dybcio@somainline.org" <konrad.dybcio@somainline.org>,
        "saiprakash.ranjan@codeaurora.org" <saiprakash.ranjan@codeaurora.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "marcan@marcan.st" <marcan@marcan.st>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linu Cherian <lcherian@marvell.com>
Subject: RE: [EXT] Re: [PATCH] clocksource: Add Marvell Errata-38627
 workaround
Thread-Topic: [EXT] Re: [PATCH] clocksource: Add Marvell Errata-38627
 workaround
Thread-Index: AQHXcWQ/kwOpukHdIkqoSg2KEiIGgKs0HPqAgATIYeA=
Date:   Thu, 8 Jul 2021 10:48:18 +0000
Message-ID: <CO6PR18MB44652857D3ACBE95BD254976E3199@CO6PR18MB4465.namprd18.prod.outlook.com>
References: <20210705060843.3150-1-bbhushan2@marvell.com>
 <87im1p861y.wl-maz@kernel.org>
In-Reply-To: <87im1p861y.wl-maz@kernel.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=marvell.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 84b69b9c-fdd3-45df-e486-08d941fde571
x-ms-traffictypediagnostic: CO1PR18MB4729:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR18MB472956DB195B0F19A94AA38BE3199@CO1PR18MB4729.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VFwgyIhxeI96fBHIX6BPJeAssdFukiVVZKoYIknQcgjJLUMLIm+SCMKRNYBdO2CDNQ7f4KigY9kJkWIvAydJR4WX8zHcZZdg/vqy8uqVZs8MjgOaHypBrzuVc/CxaTIDPscrwjMILdRW9JWK+jOt2+ObzQ92kX5ajAaSo5NiUtg0SOkRyUqY5VoOBd6Czd4IJXmX+zFYnU/pBhXkqQgkhHyseQxcS72lBPHVE6zw4RtrzTM0dBjBZeSPB3Mj+md2ijYG7JEEnj7vTQDuFwosRhP2WGHyd1j/6/baRorLNa8AUBtoTloBXgrelFhmX3ZCwSEaxKr/jbVNBLnPcF2WwtU+Yn/yI2GEhHrDZy5uIiCl3ApbDq6WTRKK8ADJQNIQ9luj8EHgCjBAjo1pG9Dz1/DYsD5UpJO75v4RFbbgydyPVGnCPxE6iVtzK4uDPQ2vabmneT7euriEIlGf16lSEbfjn40djjgnjNPNMAWDp49JdGqHFvvEeTBIzgJfmlxTl9Ouu0vNFgs1gycBenPkhfWm78rKTdO2LQNvnnlPHTKNoBkedz/L/l5mrmynWfVh5xDeODqSOzGm/Mh+oESlWSWOY0m+9ABBEOjWGcdWmjWF/NmRJs5bkxSDek6Jj/F15PU48WQK6qGt/eykNXzCfA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR18MB4465.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(76116006)(8676002)(66446008)(8936002)(55016002)(186003)(9686003)(71200400001)(52536014)(55236004)(38100700002)(84040400003)(7416002)(66556008)(66946007)(64756008)(66476007)(7696005)(122000001)(30864003)(33656002)(107886003)(2906002)(478600001)(26005)(53546011)(4326008)(54906003)(83380400001)(6506007)(6916009)(316002)(5660300002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gxbFLqoIEAdwTgobIfdNWoDArrk1SKZ8AHuQrHmSdq8wQeFUWhEbXbBcPs6c?=
 =?us-ascii?Q?gWtQowugniavrD+idSkpHHkiWReKhY3vttcMjaqC/Gr1BQNH0npiSEO7foMo?=
 =?us-ascii?Q?avtfQsGeLg3gBJH5BIFkJOIvf4fZaITKrA4kG+cka2mT//O7hxEFzr+ql2WI?=
 =?us-ascii?Q?OVlsPKiJxgYUYnPXYXY1Iv3LtCfKgPe83D7/Ptt+VUKg5R+lau8Z5Fkyd992?=
 =?us-ascii?Q?5RMQd2Fr/EvxJZApP9ABAAUaPjBhV6D6hXOgTEf1Mv07dQyNC/5cF0tJJBi6?=
 =?us-ascii?Q?CChM+/yHLEPPjGYCCYQWg+T12pOtYPL3vVxZijo0tJrxaKNb2oV2s3/R4jFd?=
 =?us-ascii?Q?qSv04BI5zcI3qenuoGKKcWIVeDc8ISllmZ7Cz1vUm+TzQgFqqkPbNGjnhgB4?=
 =?us-ascii?Q?Zws4JryLez5BS2W6gQ+svNnq33vSGK6ksUhlpyIH3IdtPgUhFLswXkSNSToM?=
 =?us-ascii?Q?+vwgltXvkU6v3j43CCY/XoVmsUZ2YJEsMTgjLPJlLoXH8K7mFYZabsCsgbSt?=
 =?us-ascii?Q?sx+k8s09TLdJ/sNTbXrvRI2aMJh2ipdl/vO9RUNa1jQNQXy7oUv45Re5N3xp?=
 =?us-ascii?Q?tKRnPzfH3QgTNwBVGkaOid/mk/+niM/r47Mkt1QMKc7sy8qsiIfJgp0Uor0V?=
 =?us-ascii?Q?xJ1W4UI9Ke7SLzCS9eLO0RHAGy73AEOre7AKoqygDVLEnBaasbJx+3T/FFfT?=
 =?us-ascii?Q?IQMSGM0PSkcaEWzsir4Dm5WG2v8hJPmqLYkLOqihopvTsGcz/Q70kepRNOiy?=
 =?us-ascii?Q?VD5snyplokAL7NXYkismBpxhK3vpujgILVN0HZvdqC6pxumw4K1wq1nt3K8+?=
 =?us-ascii?Q?fXdqFSSIUjbHJYQ8ogEJgM9Sz59vAtZ8Ew4XjaH2+Ks4SzIEYdO7ijViKJwq?=
 =?us-ascii?Q?tyPW6/cpgd+b/s6zzQ1iYeOv/iUmkE7XUqqnzmHRhKbrJf0Q1Gq9AMSD6byH?=
 =?us-ascii?Q?8b4QOpgJFW5QEKyBBv8/1SqgmLeHCz3v1evvSXxoh4M1FYcPrBb2Qf7CWY+6?=
 =?us-ascii?Q?0GRk16cJZmtER2k2xDX0+GIqHXc9iD4Gtiq3HOJI2tnWnYVDCRyQ3kW6kviv?=
 =?us-ascii?Q?CnL6Gtq71qEvaMWswWcmvrfJItHhWIYeeRojHBBDHHAVAQpOHwjWUl/+/m+F?=
 =?us-ascii?Q?rhlyyMf4y0zt7l9VYBf5j3m4sd3VxRU1UrFOmWaYDY+sQYe07d86V32l+B87?=
 =?us-ascii?Q?OA5T5E9u72u8GPYP9wgB3LVIRM0q2PC+DRiRx5GLI5FnAVqihB7RkUNu3P13?=
 =?us-ascii?Q?8QC1lKT5ANHIp+y5XyhygUS3IAQdF++QonX1CI7oFxtYlC+iumusC7W5KO2l?=
 =?us-ascii?Q?6+g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4465.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b69b9c-fdd3-45df-e486-08d941fde571
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2021 10:48:18.0389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UvFdId2+LN3JQOWDVSg3tn5zmUJR6IvX3itwbwZVDEufOq+06tcMmlPGDspzSVN8MHwNBZ9lGmbg3IXRUbP5wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR18MB4729
X-Proofpoint-ORIG-GUID: _CWQNsvapsezfexcLvgJmsweCXjqXSj8
X-Proofpoint-GUID: _CWQNsvapsezfexcLvgJmsweCXjqXSj8
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-08_04:2021-07-06,2021-07-08 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

Similar questions are asked by Mark, response might be duplicated.

> -----Original Message-----
> From: Marc Zyngier <maz@kernel.org>
> Sent: Monday, July 5, 2021 2:57 PM
> To: Bharat Bhushan <bbhushan2@marvell.com>
> Cc: catalin.marinas@arm.com; will@kernel.org; daniel.lezcano@linaro.org;
> mark.rutland@arm.com; konrad.dybcio@somainline.org;
> saiprakash.ranjan@codeaurora.org; robh@kernel.org; marcan@marcan.st;
> suzuki.poulose@arm.com; broonie@kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Linu Cherian
> <lcherian@marvell.com>
> Subject: [EXT] Re: [PATCH] clocksource: Add Marvell Errata-38627 workarou=
nd
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> On Mon, 05 Jul 2021 07:08:43 +0100,
> Bharat Bhushan <bbhushan2@marvell.com> wrote:
> >
> > CPU pipeline have unpredicted behavior when timer interrupt appears
> > and then disappears prior to the exception happening.
>=20
> What kind of unpredictable behaviours? =20

This is a race condition where an instruction (except store, system, load a=
tomic and load exclusive) becomes "nop" if interrupt appears and disappears=
 before taken by CPU. This can lead to GPR corruption. For example interrup=
t appears after the atomic load instruction starts executing and disappears=
 before the atomic load instruction completes, in that case instruction (no=
t all) can become "nop". As interrupt disappears before atomic instruction =
completes, cpu continues to execute and while take stale value from registe=
r as other dependent got "nop".

> What happens if a guest isn't aware of  the erratum or actively tries to =
trigger it?

Errata applies to VM (EL1 virtual timer) as well. In addition extending the=
 workaround to timer context save/restore in kvm seems to work.
Can you help if we are missing something in VM?

>=20
> > Time interrupt appears on timer
> > expiry and disappears when timer programming or timer disable. This
> > typically can happen when a load instruction misses in the cache,
> > which can take few hundreds of cycles, and an interrupt appears after
> > the load instruction starts executing but disappears before the load
> > instruction completes.
> >
> > Workaround of this is to ensure maximum 2us of time
>=20
> maximum? I'm not sure how you can bound this. Or did you mean *minimum*?

It is minimum

>=20
> How was this value obtained? What guarantees that it is safe?

H/w team suggested same

>=20
> > gap between timer interrupt and timer programming which can de-assert
> > timer interrupt.
>=20
> What guarantees do you have on the propagation of the interrupt signal fr=
om the
> timer to the CPU, given that the GIC is involved in the middle of it?

As per suggestion from h/w team it is sufficient delay to cover propagation=
 delay.

>=20
> >
> > Signed-off-by: Linu Cherian <lcherian@marvell.com>
> > Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> > ---
> >  arch/arm64/include/asm/cputype.h     | 13 +++++++
> >  arch/arm64/kernel/cpu_errata.c       | 24 +++++++++++++
> >  arch/arm64/tools/cpucaps             |  1 +
> >  drivers/clocksource/Kconfig          | 13 +++++++
> >  drivers/clocksource/arm_arch_timer.c | 54
> > ++++++++++++++++++++++++++++
> >  5 files changed, 105 insertions(+)
> >
> > diff --git a/arch/arm64/include/asm/cputype.h
> > b/arch/arm64/include/asm/cputype.h
> > index 6231e1f0abe7..e9a76935ee0f 100644
> > --- a/arch/arm64/include/asm/cputype.h
> > +++ b/arch/arm64/include/asm/cputype.h
> > @@ -81,6 +81,13 @@
> >  #define CAVIUM_CPU_PART_THUNDERX_83XX	0x0A3
> >  #define CAVIUM_CPU_PART_THUNDERX2	0x0AF
> >
> > +#define MRVL_CPU_PART_OCTEONTX2_98XX    0x0B1
> > +#define MRVL_CPU_PART_OCTEONTX2_96XX    0x0B2
> > +#define MRVL_CPU_PART_OCTEONTX2_95XX    0x0B3
> > +#define MRVL_CPU_PART_OCTEONTX2_LOKI    0x0B4
> > +#define MRVL_CPU_PART_OCTEONTX2_95MM    0x0B5
> > +#define MRVL_CPU_PART_OCTEONTX2_95O     0x0B6
> > +
> >  #define BRCM_CPU_PART_BRAHMA_B53	0x100
> >  #define BRCM_CPU_PART_VULCAN		0x516
> >
> > @@ -117,6 +124,12 @@
> >  #define MIDR_THUNDERX_81XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM,
> > CAVIUM_CPU_PART_THUNDERX_81XX)  #define MIDR_THUNDERX_83XX
> > MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM,
> CAVIUM_CPU_PART_THUNDERX_83XX)
> > #define MIDR_CAVIUM_THUNDERX2
> MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM,
> > CAVIUM_CPU_PART_THUNDERX2)
> > +#define MIDR_MRVL_OCTEONTX2_98XX
> MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM,
> > +MRVL_CPU_PART_OCTEONTX2_98XX) #define MIDR_MRVL_OCTEONTX2_96XX
> > +MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM,
> MRVL_CPU_PART_OCTEONTX2_96XX)
> > +#define MIDR_MRVL_OCTEONTX2_95XX
> MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM,
> > +MRVL_CPU_PART_OCTEONTX2_95XX) #define MIDR_MRVL_OCTEONTX2_LOKI
> > +MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM,
> MRVL_CPU_PART_OCTEONTX2_LOKI)
> > +#define MIDR_MRVL_OCTEONTX2_95MM
> MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM,
> > +MRVL_CPU_PART_OCTEONTX2_95MM) #define
> MIDR_MRVL_OCTEONTX2_95O
> > +MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM,
> MRVL_CPU_PART_OCTEONTX2_95O)
> >  #define MIDR_BRAHMA_B53 MIDR_CPU_MODEL(ARM_CPU_IMP_BRCM,
> > BRCM_CPU_PART_BRAHMA_B53)  #define MIDR_BRCM_VULCAN
> > MIDR_CPU_MODEL(ARM_CPU_IMP_BRCM, BRCM_CPU_PART_VULCAN)
> #define
> > MIDR_QCOM_FALKOR_V1 MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM,
> > QCOM_CPU_PART_FALKOR_V1)
>=20
> This part should be is a separate patch.

Ok,

>=20
> > diff --git a/arch/arm64/kernel/cpu_errata.c
> > b/arch/arm64/kernel/cpu_errata.c index e2c20c036442..363f83adb333
> > 100644
> > --- a/arch/arm64/kernel/cpu_errata.c
> > +++ b/arch/arm64/kernel/cpu_errata.c
> > @@ -339,6 +339,23 @@ static const struct midr_range erratum_1463225[] =
=3D {
> >  	{},
> >  };
> >  #endif
> > +#ifdef CONFIG_MARVELL_ERRATUM_38627
> > +static const struct midr_range marvell_erratum_38627_cpus[] =3D {
> > +	/* Marvell OcteonTX 2, 95xx all passes */
> > +	MIDR_ALL_VERSIONS(MIDR_MRVL_OCTEONTX2_95XX),
> > +	/* Marvell OcteonTX 2, 95MM all passes */
> > +	MIDR_ALL_VERSIONS(MIDR_MRVL_OCTEONTX2_95MM),
> > +	/* Marvell OcteonTX 2, LOKI all passes */
> > +	MIDR_ALL_VERSIONS(MIDR_MRVL_OCTEONTX2_LOKI),
> > +	/* Marvell OcteonTX 2, 96xx all passes */
> > +	MIDR_ALL_VERSIONS(MIDR_MRVL_OCTEONTX2_96XX),
> > +	/* Marvell OcteonTX 2, 98xx pass 1.0 */
> > +	MIDR_REV(MIDR_MRVL_OCTEONTX2_98XX, 0, 0),
> > +	/* Marvell OcteonTX 2, 95O pass 1.0 */
> > +	MIDR_REV(MIDR_MRVL_OCTEONTX2_95O, 0, 0),
>=20
> Is there any part that is *not* affected?

This is fixed in newer revision of octeaonTx2 part.

>=20
> > +	{},
> > +};
> > +#endif
> >
> >  const struct arm64_cpu_capabilities arm64_errata[] =3D {  #ifdef
> > CONFIG_ARM64_WORKAROUND_CLEAN_CACHE
> > @@ -439,6 +456,13 @@ const struct arm64_cpu_capabilities arm64_errata[]=
 =3D
> {
> >  		.capability =3D ARM64_WORKAROUND_858921,
> >  		ERRATA_MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
> >  	},
> > +#endif
> > +#ifdef CONFIG_MARVELL_ERRATUM_38627
> > +	{
> > +		.desc =3D "MARVELL erratum 38627",
> > +		.capability =3D ARM64_WORKAROUND_MRVL_38627,
> > +		ERRATA_MIDR_RANGE_LIST(marvell_erratum_38627_cpus),
> > +	},
> >  #endif
> >  	{
> >  		.desc =3D "Spectre-v2",
> > diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps index
> > 49305c2e6dfd..99dbe80445ef 100644
> > --- a/arch/arm64/tools/cpucaps
> > +++ b/arch/arm64/tools/cpucaps
> > @@ -60,6 +60,7 @@ WORKAROUND_CAVIUM_TX2_219_PRFM
> > WORKAROUND_CAVIUM_TX2_219_TVM  WORKAROUND_CLEAN_CACHE
> > WORKAROUND_DEVICE_LOAD_ACQUIRE
> > +WORKAROUND_MRVL_38627
> >  WORKAROUND_NVIDIA_CARMEL_CNP
> >  WORKAROUND_QCOM_FALKOR_E1003
> >  WORKAROUND_REPEAT_TLBI
> > diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> > index eb661b539a3e..83feb502cf02 100644
> > --- a/drivers/clocksource/Kconfig
> > +++ b/drivers/clocksource/Kconfig
> > @@ -309,6 +309,19 @@ config ARM_ARCH_TIMER_EVTSTREAM  config
> > ARM_ARCH_TIMER_OOL_WORKAROUND
> >  	bool
> >
> > +config MARVELL_ERRATUM_38627
> > +	bool "Workaround for Marvell Erratum 38627"
> > +	default y
> > +	depends on ARM_ARCH_TIMER && ARM64
> > +	select ARM_ARCH_TIMER_OOL_WORKAROUND
> > +	help
> > +	  This option enables a workaround for Marvell Erratum
> > +	  38627. According to this errata CPU pipeline have
> > +	  unpredicted behavior when timer interrupt appears and
> > +	  then disappears prior to the exception happening.
>=20
> This wording is actually a lot clearer than the commit message. What happ=
ens if a
> guest plays with the timer?
>=20
> > +	  This Errata workaround is applicable only to some Marvell
> > +	  OcteonTX2 series of processors.
> > +
> >  config FSL_ERRATUM_A008585
> >  	bool "Workaround for Freescale/NXP Erratum A-008585"
> >  	default y
> > diff --git a/drivers/clocksource/arm_arch_timer.c
> > b/drivers/clocksource/arm_arch_timer.c
> > index be6d741d404c..d1c5e2aa2e7c 100644
> > --- a/drivers/clocksource/arm_arch_timer.c
> > +++ b/drivers/clocksource/arm_arch_timer.c
> > @@ -27,6 +27,7 @@
> >  #include <linux/acpi.h>
> >  #include <linux/arm-smccc.h>
> >  #include <linux/ptp_kvm.h>
> > +#include <linux/delay.h>
> >
> >  #include <asm/arch_timer.h>
> >  #include <asm/virt.h>
> > @@ -88,6 +89,8 @@ static enum vdso_clock_mode vdso_default =3D
> > VDSO_CLOCKMODE_NONE;
> >
> >  static cpumask_t evtstrm_available =3D CPU_MASK_NONE;  static bool
> > evtstrm_enable __ro_after_init =3D
> > IS_ENABLED(CONFIG_ARM_ARCH_TIMER_EVTSTREAM);
> > +static __always_inline void set_next_event(const int access, unsigned =
long evt,
> > +					   struct clock_event_device *clk);
> >
> >  static int __init early_evtstrm_cfg(char *buf)  { @@ -432,6 +435,48
> > @@ static __maybe_unused int erratum_set_next_event_tval_phys(unsigned
> long evt,
> >  	return 0;
> >  }
> >
> > +#ifdef CONFIG_MARVELL_ERRATUM_38627
> > +/* Workaround is to ensure maximum 2us of time gap between timer
> > +expiry
> > + * and timer programming which can de-assert timer interrupt.
> > + * Time calculation below is based on 100MHz as timer frequency is
> > +fixed
> > + * to 100MHz on all affected parts.
> > + */
>=20
> Please fix the comment style.
>=20
> > +static __always_inline
>=20
> Please drop this __always_inline. There is no hard requirement for it, an=
d you
> are about to *wait*, so waiting faster is... not that interesting. The co=
mpiler will
> figure it out.

Ok,

>=20
> > +void erratum_38627_set_next_event(const int access, unsigned long evt,
> > +				  struct clock_event_device *clk) {
> > +	int32_t tval;
> > +
> > +	tval =3D arch_timer_reg_read(access, ARCH_TIMER_REG_TVAL, clk);
> > +
> > +	/* Timer already expired, wait for (2 - expired time)us */
> > +	if ((tval > -200) && (tval < 0))
> > +		udelay(2 + tval/100);
> > +
> > +	/* Timer is about to expire, wait for 2us + time to expire */
> > +	if (tval >=3D 0 && tval < 200)
> > +		udelay(3 + tval/100);
>=20
> I read 3us here, which contradicts the comment. Also, even if you wait fo=
r an
> arbitrary amount of time, I still don't see what guarantees you may have =
that the
> interrupt will have actually be signalled.

Yes, minimum 2us,

If "0 < tval < 100", in that case we want to wait 2us after tval expiry, so=
 that turn out to be 2us + 1us (round up of 0 < tval < 100) =3D 3us.
For 99 < tval < 200, in that case we want to wait 2us after tval expiry, In=
 that case that turn out to be 2us + 2us (round up of  99 < tval < 200) =3D=
 4us.

>=20
> > +
> > +	set_next_event(access, evt, clk);
> > +}
> > +
> > +static __maybe_unused
> > +int erratum_38627_set_next_event_tval_virt(unsigned long evt,
> > +					   struct clock_event_device *clk) {
> > +	erratum_38627_set_next_event(ARCH_TIMER_VIRT_ACCESS, evt, clk);
> > +	return 0;
> > +}
> > +
> > +static __maybe_unused
> > +int erratum_38627_set_next_event_tval_phys(unsigned long evt,
> > +					   struct clock_event_device *clk) {
> > +	erratum_38627_set_next_event(ARCH_TIMER_PHYS_ACCESS, evt, clk);
> > +	return 0;
> > +}
> > +#endif
> > +
> >  static const struct arch_timer_erratum_workaround ool_workarounds[] =
=3D
> > {  #ifdef CONFIG_FSL_ERRATUM_A008585
> >  	{
> > @@ -479,6 +524,15 @@ static const struct arch_timer_erratum_workaround
> ool_workarounds[] =3D {
> >  		.read_cntvct_el0 =3D arm64_858921_read_cntvct_el0,
> >  	},
> >  #endif
> > +#ifdef CONFIG_MARVELL_ERRATUM_38627
> > +	{
> > +		.match_type =3D ate_match_local_cap_id,
> > +		.id =3D (void *)ARM64_WORKAROUND_MRVL_38627,
> > +		.desc =3D "Marvell erratum 38627",
> > +		.set_next_event_phys =3D
> erratum_38627_set_next_event_tval_phys,
> > +		.set_next_event_virt =3D erratum_38627_set_next_event_tval_virt,
> > +	},
> > +#endif
> >  #ifdef CONFIG_SUN50I_ERRATUM_UNKNOWN1
> >  	{
> >  		.match_type =3D ate_match_dt,
>=20
> You need to update Documentation/arm64/silicon-errata.rst.

Will do,

>=20
> Overall, this patch raises *a lot* of questions...

Looking forward to understand all possible cases we need to extend workarou=
nd.

>=20
> 	M.
>=20
> --
> Without deviation from the norm, progress is not possible.
