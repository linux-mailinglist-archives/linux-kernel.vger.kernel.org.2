Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57AB93C689F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 04:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbhGMCnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 22:43:41 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:15846 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233444AbhGMCnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 22:43:39 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16D2eOVs000327;
        Mon, 12 Jul 2021 19:40:24 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by mx0a-0016f401.pphosted.com with ESMTP id 39rvu5h0w4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jul 2021 19:40:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=com0jYMVGffjPhp9e30/6VqSIGZ+6BK5cCyqYmAvl53NaQr6yMFt/9mxFVvvCrZJ2SlroVFacBXZaCRkjsFzsuVZYPaQDfodIXM6JcmpsMFaKX0vGwDMw4gOd7Z4JqBdDSiceoGIkRKE7lGd1CxHaJrkMRZWQtNux9AhHx2o1NuB9ZjRvDlEhnVX8JTxQi4zcUuHGwLuBWersK3nhPEt1RBussG8PgH20g6S41ghTHjnFXMlQ+klXSFXlWuD2/pfr+gpA+dR0RGjNHFXZJU++jUFOOq8tj/6yvF3YE6KNCVPO1RzTaPsXedABV8FRuYXtNJf4x37Zu+TmwGDfTKo6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ngxtCpF4mMrERI5KVbteOMaN2D1LrWWdG5FlJgnTNSw=;
 b=h6RcC5heGCx6O1E0EbCKyIUJPefDbwSiDDKCpRI0685an6Ux7tvv8tOqizpNOk822qYPf8KK5niACLg6ws/5xUki9fHhDd8pr/yVQ1i1nrFYKE86q6AYxlUUz0ACNoX+ghVKr4izmF5G/Y8tOhtj/WiRr00xhBlNn+FJbTqO5oxOwEK5LffukEkna8sbCKo3Y91DhGF+hs0UV86UpICIkSCQriQ/BLkdtgHYd9e1CehnpL4Oi1DDJX/barxJxvYaY0DJLXgg4+/WFVyrSmhLCN9CGwEh9MYN0HffmitfWbKEkF0sCDUEA2TvUI9QWRgyjQxZ6OLZuqNAjgj3QbbKeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ngxtCpF4mMrERI5KVbteOMaN2D1LrWWdG5FlJgnTNSw=;
 b=VaOVwjg6cGWFLmrjSRg455PXrU0Lz9pRq39S8hlG/08XKcIdVM4K/U3TaRiW6RSrfSnHmBfm0kI63vTsarkDajZ+cnbw7zt8jK3iFTQVSYG5s4Y8DlX6EjCWcgHb0qbbmfXP5j+CPbZHePwCRfCkEVL4j43nflJF95scGqmD7a8=
Received: from CO6PR18MB4465.namprd18.prod.outlook.com (2603:10b6:303:13b::10)
 by CO1PR18MB4537.namprd18.prod.outlook.com (2603:10b6:303:fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19; Tue, 13 Jul
 2021 02:40:23 +0000
Received: from CO6PR18MB4465.namprd18.prod.outlook.com
 ([fe80::7412:17a6:caa5:8df2]) by CO6PR18MB4465.namprd18.prod.outlook.com
 ([fe80::7412:17a6:caa5:8df2%9]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 02:40:23 +0000
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
        Linu Cherian <lcherian@marvell.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>
Subject: RE: [EXT] Re: [PATCH] clocksource: Add Marvell Errata-38627
 workaround
Thread-Topic: [EXT] Re: [PATCH] clocksource: Add Marvell Errata-38627
 workaround
Thread-Index: AQHXcWQ/kwOpukHdIkqoSg2KEiIGgKs0F7CAgAAR5yCABNAjgIABJ6Dw
Date:   Tue, 13 Jul 2021 02:40:22 +0000
Message-ID: <CO6PR18MB4465C85A872D7CE4138EBF8FE3149@CO6PR18MB4465.namprd18.prod.outlook.com>
References: <20210705060843.3150-1-bbhushan2@marvell.com>
 <20210705090753.GD38629@C02TD0UTHF1T.local>
 <CO6PR18MB4465687A22FE724E59D4225CE3199@CO6PR18MB4465.namprd18.prod.outlook.com>
 <20210708114157.GC24650@C02TD0UTHF1T.local>
In-Reply-To: <20210708114157.GC24650@C02TD0UTHF1T.local>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=marvell.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa09fc92-8a18-49e6-a545-08d945a79029
x-ms-traffictypediagnostic: CO1PR18MB4537:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR18MB45371A8922BFCA7DB8FCC1C4E3149@CO1PR18MB4537.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0s26zGP5+V8m1UatitFK6K3PzOayLjmDX/DOgaveo2kovhN0rTAvHsy2vwklw3Hg2NcWBjVeukhszH0bJRMDFcUgI/aZBy7/K88nIOtu7xIMPX6G70C4yyelfW1nih10pqCcf82pGdShI6iTGv8fKvYRCsB7m5n/jT2WtvM7dNN251wnkiCsnfQe3qPRxJJMCkBTo0wLU5E1WgKMTiwsYXFGvE4opKa266xUE/nmk2vNLenFtiLuiRXq4uRKR2LgDwdyVLln+/0IeJSat0KivOkQzvDTcBJGgJ6cmeKCAM5YdxWk3UI7NLWAuKWSbJbGLJRIrs2EavOx+5OsxqmE/mwcBpOvMSJcS+Bgbs+kOsFwmwNsUHvXCoOo51Q6YCpth+sfkWtE1AikIJ814+KGfbnEBIM6bB6eqEFXSlVqqeIqEZT1oELSFlQnVceR6JuV7tMvgDlB+b/3EHKk7WgJ6FlGw7+D8fUuLAWpMrD4y4TGPkfDmznFSUwrrPlVKMn6l0ZVK3+tUtBei6WnYFdd6aARctaZf/RWnGN3Yhjm0u1Pp/8Yky8yfFkLFeWbiOXIXkgm54DbTQES21g3LCf2zC7vWIyzMOL9zph0MPlxTbd5mud84mF3MS94XkX2be+7inp21YTZQ993CdYOfxCn5gOU+WyZ4EB791JsNQfwkzxSg4S+f+zInvv5EoTlWxl3Ajwh622XW8YKtaid/kiLpA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR18MB4465.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(366004)(396003)(39850400004)(7696005)(71200400001)(83380400001)(4326008)(2906002)(7416002)(54906003)(6916009)(86362001)(186003)(64756008)(38100700002)(66446008)(33656002)(66476007)(8936002)(316002)(107886003)(66946007)(55016002)(5660300002)(9686003)(76116006)(6506007)(53546011)(52536014)(8676002)(66556008)(84040400003)(478600001)(26005)(122000001)(3714002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gbgpBqzhXBY/2QLhaHt3EArt8UppIgOv8oQAjPlTt+Rp+WsErWsJJLcVUWfL?=
 =?us-ascii?Q?h/0BGBUIg7ZqRdAOSRrH2b3CKVCNoN/ZKnXm7W5sy9X3AJGHho5nybEryT5p?=
 =?us-ascii?Q?HtDNVrZez6wu+TiAL2z/nV0dK8vqUOZbUlOa4m7rDRHLVocQ/+U3/KNq6lr6?=
 =?us-ascii?Q?+ITzLHL2yvsqBB321kWiTofTd2xnr21Wk6c08SOXvIYPc7rvZeBDMYd35B3d?=
 =?us-ascii?Q?7vogVs10nh82Ao78NKtj8AiHmKQnZBbJeWRuaFvko+9t8rTYmBnqmZduKQKT?=
 =?us-ascii?Q?ZUfJOtEaKGwByQ1+15+kt4wE/NsMBAoFYB2qVBtgNZd1CC6k8jfATxgU1WGT?=
 =?us-ascii?Q?cJBbbhBsE5Kgq2oxu6X/YrZkAPOxbIs86k47h+bJkWEofYEe00bJ7JbJUYT8?=
 =?us-ascii?Q?/TEorh8vSY5yW/DAEqzc9rJDwn6ufe/xVix7gRfs0/OCyvxGzm6C3ZcILZJe?=
 =?us-ascii?Q?GKGn5O0HNpx7OMJjzqTMXpUrFI07XJ4C+flL36bYv9D68YeNyhA4sDnCDFea?=
 =?us-ascii?Q?QvgmY1gZSJgTt8iTY9x9d2FyKB4JULVXTJO3Y3aihO4VmDwUjByzY7Q1WjOy?=
 =?us-ascii?Q?MSGFrR7jfX+n1u+n2ZP4U9NE6FdlBV2GuE1oEfo00YkS8RIV8jAH1a+lw4Py?=
 =?us-ascii?Q?WhJmVw2Y8NpIzh6DcMy4NOP65Wh2J86iXREIRVGyfwEZRe4OyV2d3TtwCYiN?=
 =?us-ascii?Q?wtsw7amSd+o7RVlY1JTnQ3bWIajb/0Ervs0jYkIBWAbIgqRpxg7Dsgne+m0w?=
 =?us-ascii?Q?OQYawvLlyQ1H/8DozQTVXxtFRk4BrNC6ys9G6IctWbpaSnRW2bKUmBp6gVmN?=
 =?us-ascii?Q?NaO3jRY/7r7KPoV96JW/NeVddxb3F9z5i6Ap0dG22LPJvrJeZ7DtOIbFxDnZ?=
 =?us-ascii?Q?ip4x5QOhMiLy3jP3Q6NVEV3Hc24Aef+adb9KYOiDleI4EJ0v/eETZlReIhjL?=
 =?us-ascii?Q?MsJSxygCT6x8p+n9fTwLDJcuqMAKb5IgZE8d+bLXKegyISfQZUC69tWzuWeE?=
 =?us-ascii?Q?mWcksRydeAfupu57S0uEEASEeh0EVaC92Eh4kd3tnaW5NEE55bTkaWkGvD1q?=
 =?us-ascii?Q?YpPEnTREBpx84Q6/bE1kPsO63v4HTS2q2npfQBGU6rdyoXvIvb9SQkkMAz8Z?=
 =?us-ascii?Q?CBb9qx8KPGaCVd4bkPTnzeXN3JAQAfmX8mzBV78nonv9aT5uhYglA6HX+Vx9?=
 =?us-ascii?Q?oGl8YdbRz46H0GIRGt3AJVeM10rMpzK+yKgS7Tlr7cd6UqMD15IRaZ3n3Orb?=
 =?us-ascii?Q?SZpSMa5X13dHLWKSLFTgs7KGZjqhlUTZU1m+uiM/huoN38bmRQRjLWSc/ymZ?=
 =?us-ascii?Q?UdqwRZw5xW1iJ0Ka5lJi3mrh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4465.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa09fc92-8a18-49e6-a545-08d945a79029
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2021 02:40:22.8506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dBuXPQcbEZlIaBqe7Vob3FMVSDJ3W96riLMsi8BoY1SwTgr+h4aofP8r4kzeIyLmTERkNOOibK0aZM2RplrYnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR18MB4537
X-Proofpoint-GUID: T3_m_EnL2m5zZiE2kJu6rzte2i4Sg25h
X-Proofpoint-ORIG-GUID: T3_m_EnL2m5zZiE2kJu6rzte2i4Sg25h
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-12_14:2021-07-12,2021-07-12 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

> -----Original Message-----
> From: Mark Rutland <mark.rutland@arm.com>
> Sent: Thursday, July 8, 2021 5:12 PM
> To: Bharat Bhushan <bbhushan2@marvell.com>
> Cc: catalin.marinas@arm.com; will@kernel.org; daniel.lezcano@linaro.org;
> maz@kernel.org; konrad.dybcio@somainline.org;
> saiprakash.ranjan@codeaurora.org; robh@kernel.org; marcan@marcan.st;
> suzuki.poulose@arm.com; broonie@kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Linu Cherian
> <lcherian@marvell.com>
> Subject: Re: [EXT] Re: [PATCH] clocksource: Add Marvell Errata-38627
> workaround
>=20
> On Thu, Jul 08, 2021 at 10:47:42AM +0000, Bharat Bhushan wrote:
> > Hi Mark,
> >
> > Sorry for the delay, was gathering some details.
> > Pease see inline
> >
> > > -----Original Message-----
> > > From: Mark Rutland <mark.rutland@arm.com>
> > > Sent: Monday, July 5, 2021 2:38 PM
> > > To: Bharat Bhushan <bbhushan2@marvell.com>
> > > Cc: catalin.marinas@arm.com; will@kernel.org;
> > > daniel.lezcano@linaro.org; maz@kernel.org;
> > > konrad.dybcio@somainline.org; saiprakash.ranjan@codeaurora.org;
> > > robh@kernel.org; marcan@marcan.st; suzuki.poulose@arm.com;
> > > broonie@kernel.org; linux-arm- kernel@lists.infradead.org;
> > > linux-kernel@vger.kernel.org; Linu Cherian <lcherian@marvell.com>
> > > Subject: [EXT] Re: [PATCH] clocksource: Add Marvell Errata-38627
> > > workaround
> > >
> > > External Email
> > >
> > > --------------------------------------------------------------------
> > > --
> > > Hi Bharat,
> > >
> > > On Mon, Jul 05, 2021 at 11:38:43AM +0530, Bharat Bhushan wrote:
> > > > CPU pipeline have unpredicted behavior when timer interrupt
> > > > appears and then disappears prior to the exception happening. Time
> > > > interrupt appears on timer expiry and disappears when timer
> > > > programming or timer disable. This typically can happen when a
> > > > load instruction misses in the cache,  which can take few hundreds
> > > > of cycles, and an interrupt appears after the load instruction
> > > > starts executing but disappears before the load instruction complet=
es.
> > >
> > > Could you elaborate on the scenario? What sort of unpredictable
> > > behaviour can occur? e.g:
> >
> > This is a race condition where an instruction (except store, system,
> > load atomic and load exclusive) becomes "nop" if interrupt appears and
> > disappears before taken by CPU. For example interrupt appears after
> > the atomic load instruction starts executing and disappears before the
> > atomic load instruction completes, in that case instruction (not all)
> > can become "nop". As interrupt disappears before atomic instruction
> > completes, cpu continues to execute and while take junk from register
> > as other dependent got "nop".
>=20
> Thanks for this; I have a number of further questions below.
>=20
> You said this doesn't apply to:
>=20
> * store
> * system
> * load atomic
> * load exclusive
>=20
> ... but your example explains this happening for an atomic load, which wa=
s in
> that list. Was the example bad, or was the list wrong?

The load atomic completes successfully. It doesn't become a nop. A loads at=
omic is significant just because it's an instruction which has a long time =
between executing an retiring. This provides a window of vulnerability when=
 an interrupt asserts and then deasserts. This stimulates the bug and cause=
s other instructions executing in parallel,  which can get nop.

>=20
> It's not entirely clear to me which instructions this covers. e.g. is "sy=
stem" the
> entire system instruction class (i.e. all opcodes
> 0b110101010_0xxxxxxx_xxxxxxxx_xxxxxxxx), or did you mean something more
> specific? Does "store" include store-exlcusive?
>=20
> Other than that list, can this occur for *any* instruction? e.g. MOV, SHA=
256*,
> *DIV?

There are two general classes of instructions. Those that only change a gpr=
 or PC. These are arithmetic, floating point, branch. Loads with no side ef=
fects also fall into this category. These are the instructions that can err=
oneously be nop'd. The other category are instructions that can change arch=
itectural state more than a GPR. These include all stores, atomic loads, ex=
clusive loads, loads to non-cacheable space,msr,mrs,eret,tlb*,sys,brk,etc, =
these does not get "noped"

>=20
> Does this only apply to a single instruction at a time, or can multiple i=
nstructions
> "become nop"?

Can be multiple,

>=20
> When an instruction "becomes nop", will subsequent instructions see a
> consistent architectural state (e.g. GPRs as they were exactly before the
> instruction which "becomes nop"), or can they see something else (e.g. ga=
rbage
> forwarded from register renaming or other internal microarchitectural sta=
te)?



>=20
> > > * Does the CPU lockup?
> > No
> >
> > > * Does the CPU take the exception at all?
> > No
> >
> > > * Does the load behave erroneously?
> > No,
> >
> > > * Does any CPU state (e.g. GPRs, PC, PSTATE) become corrupted?
> >
> > yes, GPRs will get corrupted, will have stale value
>=20
> As above, is that the prior architectural value of the GPRs, or can that =
be some
> bogus microarchitectural state (e.g. from renaming or other forwarding pa=
ths)?

The instructions that become a nop doesn't write the GPR and because this i=
s an OOO machine the GPR result isn't the prior architectural value but wha=
tever crap is leftover in the physical register.

>=20
> > > Does the problem manifest when IRQs are masked by DAIF.I, or by
> > > CNT*_CTL_EL0.{IMASK,ENABLE} ?
> >
> > No, there are no issue if interrupts are masked.
>=20
> If a write to CNTV_CTL_EL0.IMASK races with the interrupt being asserted,=
 can
> that trigger the problem?

If interrupt is enabled (DAIF) - then it will be taken, and no issue
But if interrupts are disabled then following sequence can see the race
 1)	interrupt is disabled (DAIF)=20
2)	TVAL/ENABLE/IMASK at timer h/w programming to de-assert interrupt.
	Race of Irq asserted before irq de-asserted, than this short window of ass=
ertion will be considered as spike from timer h/w block
3)	Enable DAIF=20
	Because of propagation delay CPU sees assertion and de-assertion (spike), =
errata hit

Will add "isb" around interrupt enablement in next version of patch.

>=20
> If a write to DAIF.I races with the interrupt being asserted, can that tr=
igger the
> problem?

No race with writing to DAIF.I with interrupt assertion,
Writing DAIF.I =3D 0 (enablement of interrupt) can race with de-assertion, =
which can lead to hitting errata


>=20
> From your description so far, this doesn't sound like it is specific to t=
he timer
> interrupt. Is it possible for a different interrupt to trigger this, e.g:
>=20
> * Can the same happen with another PPI, e.g. the PMU interrupt if that
>   gets de-asserted, or there's a race with DAIF.I?
>=20
> * Can the same happen with an SGI, e.g. if one CPU asserts then
>   de-asserts an SGI targetting another CPU, or there's a race with
>   DAIF.I?
>=20
> * Can the same happen with an SPI, e.g. if a device asserts then
>   de-asserts its IRQ line, or there's a race with DAIF.I?

No issue with edge triggered, but this can happen with any level sensitive =
interrupt.

>=20
> If not, *why* does this happen specifically for the timer interrupt?
>=20
> > > > Workaround of this is to ensure maximum 2us of time gap between
> > > > timer interrupt and timer programming which can de-assert timer int=
errupt.
> > >
> > > The code below seems to try to enforce a 2us *minimum*. Which is it
> > > supposed to be?
> >
> > Yes, it is minimum 2us.
> >
> > >
> > > Can you explain *why* this is supposed to help?
> > With the workaround interrupt assertion and de-assertion will be minimu=
m 2us
> apart.
>=20
> I understood that, but why is that deemed to be sufficient? e.g. is it so=
mehow
> guaranteed that the CPU will complete the instruction that would "become =
nop"
> in that time?

With this delay we avoid spike, either this this will becomes an actual int=
errupt or the spike never visible to core.

>=20
> > > I don't see how we can guarantee this in a VM, or if the CPU misses
> > > on an instruction fetch.
> >
> > This errata applies to VM (virtual timer) as well, maybe there is some
> > gap in my understanding, how it will be different in VM.
> > Can you help with what issue we can have VM?
>=20
> A VCPU can be pre-empted by the host at *any* time, for an arbitrary leng=
th of
> time. So e.g. you can have a scenario such as:
>=20
> 1. Guest reads CNTx_TVAL, sees interrupt is 4us in the future and
>    decides it does not need to wait
> 2. Host preempts guest
> 3. Host does some processing for ~3.9us
> 4. Host returns to guest, with 0.1us left until the interrupt triggers 5.=
 Guest
> reprograms CNTx_TVAL, and triggers the erratum

Yes, when timer expire just before tval written (race condition) , so there=
 is assertion-followed by de-assertion, As interrupts are enabled in host, =
interrupt will be visible as spike to host.
We will apply workaround whenever entering to guest (add a delay before exi=
ting to guest in case guest timer is going to expire).

Thanks
-Bharat

>=20
> Thanks,
> Mark.
