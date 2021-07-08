Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75DC63BF88D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 12:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbhGHKuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 06:50:51 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:19206 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231493AbhGHKuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 06:50:50 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 168Aipxk008768;
        Thu, 8 Jul 2021 03:47:45 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by mx0a-0016f401.pphosted.com with ESMTP id 39nrnu1jg6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jul 2021 03:47:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ktrp1mBtGQ/btb7S7Sbzowhxf2pwepoe4NpUiEqUpXRnNGyAabGcpszWIx/O8Yq7B811kjH7RIE2vZWtC8I5DBYURXrF9qOt6U1jjT6VFBPWeLgnmm+AeYeu+L78VlWe5O0BxvNPm2lm8/LNESiAkZa3amNm9zGM/7LZNPzQZxO4f30GEg7uyoJFTfA+aLX1uwe6VSMB9z3yQiDOxnZP45221dXcIpsNTXdoFOpjnt1LZAgDE81xVm8oGxSbZAI0UaI62Iiq9kto09nezeq8tcV5qu/MogEjuzVXJLURBFVQWsNrwme5OOu3+3IM/+p1X2xmHoV7BBN718qeMXj19Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHWZnmDHNP6Vfci8+hXzTfTAZBTc+ahWFK1tyMV8YGk=;
 b=EaZ4l7XRWgBJ8c9zsIV39wT+BLu6fnYPdH9q8lOjUXjKYVQlfyhKJ2BAghQKY6ENxXMgfycfXb730ailuVdE91sN+HkCfjXuj8GL5F28kKBizWDky9Vxi0VTvQE1/v7mARXe9ZMs7PMU2eUJFQwN9wu7CFsdtHT4QpPLaCp5vFk1Z8XSWYc5ZifEFNXmgw3rFFekf+hnPLDGzPYU4VTZJUnsdGiUm43u6ObSCbQBSHxGPTUbF9uLlUHInaIvLOZDMdzLIZ+AYEJ+pJyveCRSfimNsDKWTR+959IaYnWEx4T1uq9UNO2ZpuW3VlBvjy3DXHZ7N4J01lSPbdKcryGi7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHWZnmDHNP6Vfci8+hXzTfTAZBTc+ahWFK1tyMV8YGk=;
 b=nXbNEgzUk9aMfvHH7njtVg8Vvj2jgNdjO8QifP/19qjiOWTgb0ZFaPBpq21BNAz0aoVm38iSAGuwXjZqSrBDE5bkEGZQF59xldqXUwJoWw7xSBGua5yIZp7Sc39azIrEsURFGNWGyJkpIykFFj88kZRyDluflwZa3sIvAWo3ajo=
Received: from CO6PR18MB4465.namprd18.prod.outlook.com (2603:10b6:303:13b::10)
 by CO6PR18MB4467.namprd18.prod.outlook.com (2603:10b6:5:355::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Thu, 8 Jul
 2021 10:47:42 +0000
Received: from CO6PR18MB4465.namprd18.prod.outlook.com
 ([fe80::7412:17a6:caa5:8df2]) by CO6PR18MB4465.namprd18.prod.outlook.com
 ([fe80::7412:17a6:caa5:8df2%9]) with mapi id 15.20.4308.022; Thu, 8 Jul 2021
 10:47:42 +0000
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     Mark Rutland <mark.rutland@arm.com>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "maz@kernel.org" <maz@kernel.org>,
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
Thread-Index: AQHXcWQ/kwOpukHdIkqoSg2KEiIGgKs0F7CAgAAR5yA=
Date:   Thu, 8 Jul 2021 10:47:42 +0000
Message-ID: <CO6PR18MB4465687A22FE724E59D4225CE3199@CO6PR18MB4465.namprd18.prod.outlook.com>
References: <20210705060843.3150-1-bbhushan2@marvell.com>
 <20210705090753.GD38629@C02TD0UTHF1T.local>
In-Reply-To: <20210705090753.GD38629@C02TD0UTHF1T.local>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=marvell.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8d98a97-9ce0-4edf-6193-08d941fdd02b
x-ms-traffictypediagnostic: CO6PR18MB4467:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO6PR18MB4467624C15485BB53F7A82CEE3199@CO6PR18MB4467.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CCs5F7nB5htMrCpufCnE3Kjb8TDhEzpoUlQiLDh3ljOaDGXb1ViJ51H5hjxZepTDb36qcL57x2RlCNW5AvzkNlkyBLB1EiV1vXnkv2NfNGABRkxo7klUNw2EWZ0v1/+70XuT5PyMuCuGwsyNcyreDj0MCEIggu+332tcYkh9uSk3EK1QNw/QhT4laJwHKkr9VWitq9P83ys56ajozbarozRyBX4Qp5TG8gw9TogUYiLHUTTaLJrrVkoPD8pEo7plzW7AcgaryzI7gd4PlbOPbSe/8TDSrFOrY6vkx26kNK9qbQWnlAoGvEJoA9KJfnzmzyPz22QrtxmGS7qDoiYLwXdWofsyPQEIulcnqFzgSlE6DkUXuec5y0VuS4dWBPty8FHXdGzI6ggGIeNJ+h0qMqDVfotvvycAj5x3pwNaRbeDCM/CuPyIeN9rL107qF0+jYORN6s+Hg+l73h1S5EhfzwtoUwD+SFVdbwmXmUN5fBty4+XumXgmRUqKuvMng6TwhisR7qa3otuBt6hdQpTRB40Dflxi4EIzyPCeto4JYPe/bJS64foD2QRgnn81XPiOuIQlm6d2kthSFztjBSGUlk+Afj5XkSn126waIA0twm7TlN22vwjTBbbgRZDFztk4lhKn/Qki2LmcAZibWltow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR18MB4465.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(39850400004)(136003)(366004)(6506007)(53546011)(186003)(9686003)(83380400001)(86362001)(52536014)(33656002)(8676002)(107886003)(30864003)(7416002)(8936002)(76116006)(6916009)(2906002)(122000001)(38100700002)(5660300002)(66556008)(66476007)(66446008)(64756008)(478600001)(54906003)(7696005)(66946007)(84040400003)(55236004)(71200400001)(4326008)(26005)(55016002)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+9lUALErl48LaQ0dCI2kDxiaTUx+tw7Gf9daUHREFT/mpPrHBV1D56sPpIAw?=
 =?us-ascii?Q?/JMPBTG5+gSQjVPOyWiLh3CcZX1XVWzgBF/kYaUEZDyYy7o1Kl9c3DOkcMlC?=
 =?us-ascii?Q?tdDvEjiDXPqOX+fC4arymPkmWzV5JSEGLJhke1wqghhvqnTKimirznwXqB00?=
 =?us-ascii?Q?MZzy1sZcVldSbyNr7BIEm3Wkm7nLBUdG0nXQxm5bGAOMNbtEmzw0GkpejQRq?=
 =?us-ascii?Q?3L/RY9Ia2lUBkVpeMOVOlBUp2Wvl6No0SqqkSOQZPpkwqBOkg17KPtrww4wO?=
 =?us-ascii?Q?A9jOQb8nFB1ju2reSMaL3S0JYSd//I1yvfshZYKWeZXgPv1OC6EKEoVTxTVg?=
 =?us-ascii?Q?gSMiLggsUVYnHUVMDUdU99ynBszafn+7ncpT7i9DzG0ps+qz30BVTu2tCnfk?=
 =?us-ascii?Q?cbpojvgEeWdVt4ubikYevnxgu117MgjhqcnTM66yLLhNdFyJhziuGciSkZ8B?=
 =?us-ascii?Q?VJUHhGdLDnXIZbWGXx15FXjECPxE9fSkVkatkx1TYmNxO25hjZivcgI3fU2F?=
 =?us-ascii?Q?86QlG3ZpSx/kFCb14SXI3tB8i3KtxDMTLOsIESpsuV/FeDrXHElkubEFyKgh?=
 =?us-ascii?Q?FEEq6cFvch+jWRmXgF5W3iq4Uud33oQ+yvWL8HsT4xx/XtrD8BTgpg7B9Qg1?=
 =?us-ascii?Q?yI+JdUh2Zrq161bnw5QHx2U3PzNSWLbRfWxt0Rh9nYrv7GooKnbbyTB8Rmy9?=
 =?us-ascii?Q?yZ05eLNFh9p7BdTSHGaMS2PWSEGXCv7hKQw/7u2bChlh48s+jN5Q9Id0+ijx?=
 =?us-ascii?Q?Xv+iN/RN6aQRj1YFMEyC2uMFdmjhrlUINcDphjeRk1uasYX2053fDJyZQrJN?=
 =?us-ascii?Q?mSu3Sp+Te/0FzWvi8A43wCxUL7R63pMeoXipfWWTlQjcHv+em64X0SSJVTeU?=
 =?us-ascii?Q?ZlQKNwbsqvuaZf0bLNedHXbUreOdJ1GWiOHUqFKcQVuc44mcjZNFWBgfqbDv?=
 =?us-ascii?Q?ImBxVJt4O7MHlI/RcjAoceTDE1d8JtYSNyJAES95itAEg8aLhH1O1Er93jS0?=
 =?us-ascii?Q?I8dqoE/vdHgYWqY9XA4tAZUGplqeT6sRB1o0muOf8DlW6RCUXdF8YcF6hw0j?=
 =?us-ascii?Q?EpSnRwJ+k0TjhPVQPiJ0FmfLNTveRqZyjOIwDCfJEW2s0kiHa+dJJxdzMuqi?=
 =?us-ascii?Q?ppYmJTd44i0mYgGga7OapH/UAveHFz1QUonYrU8VNflbb5qmBzyl64PNK4ki?=
 =?us-ascii?Q?YK7bkmB7f6958A6qcVcQEXcW6qR90MHRLZ6schMnwlcLZpMQny4v1fE8/355?=
 =?us-ascii?Q?72xiv4xshDkIn3dDbvynf9JN9BFU1Gc8LHr10joH/5CHnK8lGOxzlfM0WPu8?=
 =?us-ascii?Q?dgQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4465.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8d98a97-9ce0-4edf-6193-08d941fdd02b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2021 10:47:42.3297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5p74pDgSl0VqaRgupcg5G8FDDCvpMBlMIyoa1G753v9CCTRxydyAvredQPC6DstvM1lMB9WPTTiMgijq1BIO6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR18MB4467
X-Proofpoint-ORIG-GUID: -tKUNc0wqtAyPKIBeCcmLftG699PRWZw
X-Proofpoint-GUID: -tKUNc0wqtAyPKIBeCcmLftG699PRWZw
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-08_04:2021-07-06,2021-07-08 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Sorry for the delay, was gathering some details.
Pease see inline

> -----Original Message-----
> From: Mark Rutland <mark.rutland@arm.com>
> Sent: Monday, July 5, 2021 2:38 PM
> To: Bharat Bhushan <bbhushan2@marvell.com>
> Cc: catalin.marinas@arm.com; will@kernel.org; daniel.lezcano@linaro.org;
> maz@kernel.org; konrad.dybcio@somainline.org;
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
> Hi Bharat,
>=20
> On Mon, Jul 05, 2021 at 11:38:43AM +0530, Bharat Bhushan wrote:
> > CPU pipeline have unpredicted behavior when timer interrupt appears
> > and then disappears prior to the exception happening. Time interrupt
> > appears on timer expiry and disappears when timer programming or timer
> > disable. This typically can happen when a load instruction misses in
> > the cache,  which can take few hundreds of cycles, and an interrupt
> > appears after the load instruction starts executing but disappears
> > before the load instruction completes.
>=20
> Could you elaborate on the scenario? What sort of unpredictable behaviour=
 can
> occur? e.g:

This is a race condition where an instruction (except store, system, load a=
tomic and load exclusive) becomes "nop" if interrupt appears and disappears=
 before taken by CPU. For example interrupt appears after the atomic load i=
nstruction starts executing and disappears before the atomic load instructi=
on completes, in that case instruction (not all) can become "nop". As inter=
rupt disappears before atomic instruction completes, cpu continues to execu=
te and while take junk from register as other dependent got "nop".
>=20
> * Does the CPU lockup?
No

> * Does the CPU take the exception at all?
No

> * Does the load behave erroneously?
No,

> * Does any CPU state (e.g. GPRs, PC, PSTATE) become corrupted?

yes, GPRs will get corrupted, will have stale value

>=20
> Does the problem manifest when IRQs are masked by DAIF.I, or by
> CNT*_CTL_EL0.{IMASK,ENABLE} ?

No, there are no issue if interrupts are masked.

>=20
> > Workaround of this is to ensure maximum 2us of time gap between timer
> > interrupt and timer programming which can de-assert timer interrupt.
>=20
> The code below seems to try to enforce a 2us *minimum*. Which is it suppo=
sed
> to be?

Yes, it is minimum 2us.

>=20
> Can you explain *why* this is supposed to help?
With the workaround interrupt assertion and de-assertion will be minimum 2u=
s apart.

>=20
> I don't see how we can guarantee this in a VM, or if the CPU misses on an
> instruction fetch.

This errata applies to VM (virtual timer) as well, maybe there is some gap =
in my understanding, how it will be different in VM.
Can you help with what issue we can have VM?

>=20
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
> > QCOM_CPU_PART_FALKOR_V1) diff --git a/arch/arm64/kernel/cpu_errata.c
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
> > +static __always_inline
> > +void erratum_38627_set_next_event(const int access, unsigned long evt,
> > +				  struct clock_event_device *clk) {
> > +	int32_t tval;
> > +
> > +	tval =3D arch_timer_reg_read(access, ARCH_TIMER_REG_TVAL, clk);
> > +
> > +	/* Timer already expired, wait for (2 - expired time)us */
> > +	if ((tval > -200) && (tval < 0))
> > +		udelay(2 + tval/100);
>=20
> Isn't this ensuring a 2us *minimum* rather than *maximum* ?

Minimum 2us, will correct
>=20
> > +
> > +	/* Timer is about to expire, wait for 2us + time to expire */
> > +	if (tval >=3D 0 && tval < 200)
> > +		udelay(3 + tval/100);
>=20
> Again, this appears to be waiting for 2us *minimum*.

Yes, minimum 2us,

If "0 < tval < 100", in that case we want to wait 2us after tval expiry, so=
 that turn out to be 2us + 1us (round up of 0 < tval < 100) =3D 3us.
For 99 < tval < 200, in that case we want to wait 2us after tval expiry, In=
 that case that turn out to be 2us + 2us (round up of  99 < tval < 200) =3D=
 4us.

>=20
> What if when we did the read we have 2.01 us to go? Is the expectation th=
at we'll
> manage to execute this code and set the next event in less that 2us?

2us is safe value and already considers the time between reading of tval an=
d programming timer.
Expectation is that it will take few cycles in programming timer after read=
ing tval.

Thanks
-Bharat

>=20
> Thanks,
> Mark.
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
> > --
> > 2.17.1
> >
