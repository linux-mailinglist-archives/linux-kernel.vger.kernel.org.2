Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 010013D528B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 06:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbhGZDty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 23:49:54 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:18146 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230321AbhGZDtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 23:49:53 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16Q4PDmB011265;
        Sun, 25 Jul 2021 21:29:55 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by mx0a-0016f401.pphosted.com with ESMTP id 3a1avp997r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 25 Jul 2021 21:29:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MC0MQxX6x/MSQM4n3PAv9titw4rimjVAl1RFtvlA+kynct5doGPp4reb3uDys2Z1qje/pNPmeMDdEHmnBCqM3nySHwOUXWlsK9KuZIG9cWU4z3vNsfENRRgOPP+0DgYbI7ReWHuypxFsm4rev2GrpNx7AxHudibDK//Cp/q1L4EHdBo0AkMol6weylDJyqmOzFogfFh5JUZhyKlSP6ZP/iKulqO6vf6ByzGQpSmgQXh4YzYPFlotb8QLsZj+izSligc7SnfdoqNvZjgFsCTWhnMhsh2Ct6oJX16IotiwtXASEVm//J28jxPTuzCm1ROuc0InISpknBfWeTy70M7ueg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9gzMPHOhN53m6IS967/MO3EFHne5s8mCY/f5Xv7dsI=;
 b=gWhzEDdK7eSFW9npMnSM53Ucw4hSWT9iM8rRcxFgRdzjdor90fw4QjoNmQcOP1yXPXAzvLlAJ81L3S6cAY1u42EiNng6dggVWl4uiiLI4+/PSae7Usb9l28NGac5AKEnY/TTZj+ym+PNoxzS/iOcNyMa6FtL97dKD89s0aW0lCG/IFT51gNdeaN9JyR8nybq9zXYTq1e45RwPdxVS9mQmMN2L6iMnRzc9ctibVPh5g3ZNm1KrX60CnIiNNlG11qhwe6M4gMmEN/xdN0+sKgRiWhUOY9WV0X42XYe6NR0Ys8nDKNtvj/Y1QH/xt2CUJipy+Ia89b6q/2G6/Su3QU2fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9gzMPHOhN53m6IS967/MO3EFHne5s8mCY/f5Xv7dsI=;
 b=lbQjb31zhSpqSyaOgldJGlmOTAA22xYh5hyRDRw1Z0jSMnKnkOJ0rakP+lPDQQJmmPj/PJqf98Cc52Yfh+jyfAjgEqGwkUiUGouze/or+4gGOfL8kdgty/Pg3dC4DIKODT7t1vXhkxdXz7ZiMPtALD6T+KyY7ebBiLST+pGEBMM=
Received: from CO6PR18MB4465.namprd18.prod.outlook.com (2603:10b6:303:13b::10)
 by CO1PR18MB4746.namprd18.prod.outlook.com (2603:10b6:303:e9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Mon, 26 Jul
 2021 04:29:53 +0000
Received: from CO6PR18MB4465.namprd18.prod.outlook.com
 ([fe80::7412:17a6:caa5:8df2]) by CO6PR18MB4465.namprd18.prod.outlook.com
 ([fe80::7412:17a6:caa5:8df2%8]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 04:29:53 +0000
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
Thread-Index: AQHXcWQ/kwOpukHdIkqoSg2KEiIGgKs0F7CAgAAR5yCABNAjgIABJ6DwgAb/o4CAE6bNMA==
Date:   Mon, 26 Jul 2021 04:29:53 +0000
Message-ID: <CO6PR18MB4465AAE7916DCFECE9D47EA2E3E89@CO6PR18MB4465.namprd18.prod.outlook.com>
References: <20210705060843.3150-1-bbhushan2@marvell.com>
 <20210705090753.GD38629@C02TD0UTHF1T.local>
 <CO6PR18MB4465687A22FE724E59D4225CE3199@CO6PR18MB4465.namprd18.prod.outlook.com>
 <20210708114157.GC24650@C02TD0UTHF1T.local>
 <CO6PR18MB4465C85A872D7CE4138EBF8FE3149@CO6PR18MB4465.namprd18.prod.outlook.com>
 <20210713161233.GB13027@C02TD0UTHF1T.local>
In-Reply-To: <20210713161233.GB13027@C02TD0UTHF1T.local>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=marvell.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65fc025a-3065-449a-ce61-08d94fee03ae
x-ms-traffictypediagnostic: CO1PR18MB4746:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR18MB4746A543A5F3AA38937905A8E3E89@CO1PR18MB4746.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XD4Uvi/BjtnJ4YAc068IZqH6ZZu317Z8sBxflTp69CccwjTeXOeqyTz0SopcSn0mJ4sO17sZeS5mtSbiAu60HK2TFFM5L3GCD840Zqgj3w09TbPkdhsHhxumyKCxMp3wqTh27TJvre5dhFZoZ09TwGs4t9SqKVnepZ8Ds1praKEsfzqBkUIqnDPIatl8CQzA+4HcmYY0D5/gAJSR68Nn8Vn9Nkko77SW5eJsN53t9ymvfEucoUr1w/KXylMxgfQRnU0vDOcymQ2NqyrmznXvtmv9RaMpRl/JtcG7iyQA798f/akp3O1b0WKqx3cIyazoLg8D4xXV9QBgdalyUkJketcf1lKWi2F0E51cVt2iLVq3rNT3IKVqRe9R7aKfnuz54EeU1pGHJw/NdYqP8WQQDL6AetpftpfNg/KAsMTJj6QNMERjfF25Mh79ANX5VDqYXW/ZWZcZafq9jOQ13AEFFqNfIXSHVU2wnXJhhJDS1kwDrdhfY7gyAUR8CDe+H3i+pPkFNCnDteu60eElm7DhmOHhFEZ3bCK/fqQL0EG+uCZy/K8dvz+a3Sk31eGKYQNuONk4ppBlYC+Ul9k1GtUzgkJyowRa58h4Ofm4yUMLHwq1KaU6HAWUpXFszgbHbTCfmyNA1oiqVZEwtyMMYGICc6D8dVlBmsY+Dpkf43eLR9BXMLm6JU6p8BpllPRUbFiBymYVIG/cgomfCHaXDWO5AwmRxHAonK4wmTNBslgq0aU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR18MB4465.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(39850400004)(396003)(136003)(84040400004)(107886003)(8676002)(26005)(5660300002)(478600001)(76116006)(316002)(6916009)(52536014)(55016002)(71200400001)(7416002)(8936002)(38100700002)(122000001)(7696005)(186003)(30864003)(2906002)(4326008)(53546011)(64756008)(66556008)(66446008)(66946007)(9686003)(66476007)(6506007)(54906003)(33656002)(86362001)(83380400001)(3714002)(38070700004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7bEORaUVyxZRqQk0VrqwG+CR2pqqfY1z8feC/xeSDg6K+AOu5OjL7bZxcjvx?=
 =?us-ascii?Q?1uw7uFazYdACzTTd4E+fo0oh7EOhwAdDAdCl0TVIFeAm0PGvtStx1f5gXfVN?=
 =?us-ascii?Q?fr1U9U+GryEAbZnmulj5kLrJKYNLPa0dxgBtr8sS2iiNMUKwi8/oW6IRvSHX?=
 =?us-ascii?Q?Sqx7CPi3+Onp9ym6IuYHhPrZ1VFaVNcigmsSyCCUmEz0s1PF2AdqjCug8TQt?=
 =?us-ascii?Q?DnjHPNEtcX5Hso2oHvCp6Bah15I8ZnU0dKBh/XyQfz7sAbph6k2Hm5QwnqiV?=
 =?us-ascii?Q?IxrZt+eXxhD7BZkDfSXJDNUlSMrr7mF4mbLulWtRW9g3aFDN+LlN6+1sQ3DF?=
 =?us-ascii?Q?PuPRkpYd7lLL/fYHC/Kdb7+QV1EUIqsNe3GocMVxkjHH2da2PU8Z+WhZCOKi?=
 =?us-ascii?Q?hk/iNHN8JzDjLnIc01mTQ/ppmu2SMRk1yKkh8fbbnEsYFQiM/PKyFqKPnv7g?=
 =?us-ascii?Q?N1gkv7K144m/+fu61Jka2/Uc2ra895NVC8aU51ZHUztf1Z4mlOB3WbjGz/EG?=
 =?us-ascii?Q?ic/imQzfbp7IrPgLmFJ29zpMbi959KLHsZt6xo1DKDmO4yNSF2feMJQGCdRG?=
 =?us-ascii?Q?fCen24wUu0p3W1miLwu9wJJkr1VzyfPzKrJVCck/+5m4By2BzrxdYrxRt45W?=
 =?us-ascii?Q?TAc93ow4gv+o8txpGfLleVlgyvEvVEvtn9qtDc/eAhaTUVvna92UTbGLQuw/?=
 =?us-ascii?Q?8NfsyR5UXfCrkpzALe0X0JP43Tna0jTcL7t6cDMRplo4mu5DhmxRoECa238c?=
 =?us-ascii?Q?Pe5H5g44ns1JmLYtJmwUeYDAnSa1tH2KydnggB65He8nyGirGZdX3ItR77jP?=
 =?us-ascii?Q?oY8flAYsFrUsolaj/FTI3R+qVY4EhG+yV+3WuQNS1yE++YBZT99L0bKN/iAr?=
 =?us-ascii?Q?xLiVxwfQbjnRjtdEf59D+/7D+Slewdcq5V62e/fV6gna6/M8shAtv57/dW6W?=
 =?us-ascii?Q?d5d2qEtJXTyvKs8GBNd+WVs3jgLCOlx2D6i0Y9MiCyj6S1l0nH7Lw6OHsDQr?=
 =?us-ascii?Q?ob4fW3pNLwHrmbtWA4yfx/CBHV0xLPx3Gjwt/TuOA6r4wgcuBA+CcCt4kccD?=
 =?us-ascii?Q?ch7E+ebvXMIht2cM2WP84l4nwjNBPv1+FyrrTkoPH70VDUz4cLUaWQr2A8vq?=
 =?us-ascii?Q?kstwqvldEOa93IqopnZ+cIbgbJUVlb98FVQ1Q3IGqixE6u9ZSLjzbR73GP/v?=
 =?us-ascii?Q?Os/jmO1WhLrURwDfjItMXgYpMUAwlagg/RfPPyIOGgoRpjPvwnworW170RH4?=
 =?us-ascii?Q?7tEXzqzL5vSQp1ydyUiiylk4zBBfzpYTh89bPrKMzdzSeL87THgdyWWRvOfe?=
 =?us-ascii?Q?dABXp0OjvHw+/YwS3xzMZPTM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4465.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65fc025a-3065-449a-ce61-08d94fee03ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2021 04:29:53.0472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G2CNgFTsd9RND08+w1F4bzaGEUKWlbHLYIyo61LTeNxE4hwKdcIN4ors+JqYGXM8nSUfvTyEZ6KEfjUJVPOcbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR18MB4746
X-Proofpoint-GUID: 2cILV6fKtIakugxb_2crmbrxxcd89dku
X-Proofpoint-ORIG-GUID: 2cILV6fKtIakugxb_2crmbrxxcd89dku
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-26_01:2021-07-23,2021-07-26 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for delayed response

Please see inline

> -----Original Message-----
> From: Mark Rutland <mark.rutland@arm.com>
> Sent: Tuesday, July 13, 2021 9:43 PM
> To: Bharat Bhushan <bbhushan2@marvell.com>
> Cc: catalin.marinas@arm.com; will@kernel.org; daniel.lezcano@linaro.org;
> maz@kernel.org; konrad.dybcio@somainline.org;
> saiprakash.ranjan@codeaurora.org; robh@kernel.org; marcan@marcan.st;
> suzuki.poulose@arm.com; broonie@kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Linu Cherian
> <lcherian@marvell.com>; Sunil Kovvuri Goutham <sgoutham@marvell.com>
> Subject: Re: [EXT] Re: [PATCH] clocksource: Add Marvell Errata-38627
> workaround
>=20
> On Tue, Jul 13, 2021 at 02:40:22AM +0000, Bharat Bhushan wrote:
> > Hi Mark,
> >
> > > -----Original Message-----
> > > From: Mark Rutland <mark.rutland@arm.com>
> > > Sent: Thursday, July 8, 2021 5:12 PM
> > > To: Bharat Bhushan <bbhushan2@marvell.com>
> > > Cc: catalin.marinas@arm.com; will@kernel.org;
> > > daniel.lezcano@linaro.org; maz@kernel.org;
> > > konrad.dybcio@somainline.org; saiprakash.ranjan@codeaurora.org;
> > > robh@kernel.org; marcan@marcan.st; suzuki.poulose@arm.com;
> > > broonie@kernel.org; linux-arm- kernel@lists.infradead.org;
> > > linux-kernel@vger.kernel.org; Linu Cherian <lcherian@marvell.com>
> > > Subject: Re: [EXT] Re: [PATCH] clocksource: Add Marvell Errata-38627
> > > workaround
> > >
> > > On Thu, Jul 08, 2021 at 10:47:42AM +0000, Bharat Bhushan wrote:
> > > > Hi Mark,
> > > >
> > > > Sorry for the delay, was gathering some details.
> > > > Pease see inline
> > > >
> > > > > -----Original Message-----
> > > > > From: Mark Rutland <mark.rutland@arm.com>
> > > > > Sent: Monday, July 5, 2021 2:38 PM
> > > > > To: Bharat Bhushan <bbhushan2@marvell.com>
> > > > > Cc: catalin.marinas@arm.com; will@kernel.org;
> > > > > daniel.lezcano@linaro.org; maz@kernel.org;
> > > > > konrad.dybcio@somainline.org; saiprakash.ranjan@codeaurora.org;
> > > > > robh@kernel.org; marcan@marcan.st; suzuki.poulose@arm.com;
> > > > > broonie@kernel.org; linux-arm- kernel@lists.infradead.org;
> > > > > linux-kernel@vger.kernel.org; Linu Cherian
> > > > > <lcherian@marvell.com>
> > > > > Subject: [EXT] Re: [PATCH] clocksource: Add Marvell Errata-38627
> > > > > workaround
> > > > >
> > > > > External Email
> > > > >
> > > > > ----------------------------------------------------------------
> > > > > ----
> > > > > --
> > > > > Hi Bharat,
> > > > >
> > > > > On Mon, Jul 05, 2021 at 11:38:43AM +0530, Bharat Bhushan wrote:
> > > > > > CPU pipeline have unpredicted behavior when timer interrupt
> > > > > > appears and then disappears prior to the exception happening.
> > > > > > Time interrupt appears on timer expiry and disappears when
> > > > > > timer programming or timer disable. This typically can happen
> > > > > > when a load instruction misses in the cache,  which can take
> > > > > > few hundreds of cycles, and an interrupt appears after the
> > > > > > load instruction starts executing but disappears before the loa=
d
> instruction completes.
> > > > >
> > > > > Could you elaborate on the scenario? What sort of unpredictable
> > > > > behaviour can occur? e.g:
> > > >
> > > > This is a race condition where an instruction (except store,
> > > > system, load atomic and load exclusive) becomes "nop" if interrupt
> > > > appears and disappears before taken by CPU. For example interrupt
> > > > appears after the atomic load instruction starts executing and
> > > > disappears before the atomic load instruction completes, in that
> > > > case instruction (not all) can become "nop". As interrupt
> > > > disappears before atomic instruction completes, cpu continues to
> > > > execute and while take junk from register as other dependent got "n=
op".
> > >
> > > Thanks for this; I have a number of further questions below.
> > >
> > > You said this doesn't apply to:
> > >
> > > * store
> > > * system
> > > * load atomic
> > > * load exclusive
> > >
> > > ... but your example explains this happening for an atomic load,
> > > which was in that list. Was the example bad, or was the list wrong?
> >
> > The load atomic completes successfully. It doesn't become a nop. A
> > loads atomic is significant just because it's an instruction which has
> > a long time between executing an retiring. This provides a window of
> > vulnerability when an interrupt asserts and then deasserts. This
> > stimulates the bug and causes other instructions executing in
> > parallel,  which can get nop.
>=20
> Thanks for clarifiying; this was not clear from your initial description.
>=20
> > > It's not entirely clear to me which instructions this covers. e.g.
> > > is "system" the entire system instruction class (i.e. all opcodes
> > > 0b110101010_0xxxxxxx_xxxxxxxx_xxxxxxxx), or did you mean something
> > > more specific? Does "store" include store-exlcusive?
> > >
> > > Other than that list, can this occur for *any* instruction? e.g.
> > > MOV, SHA256*, *DIV?
> >
> > There are two general classes of instructions. Those that only change
> > a gpr or PC. These are arithmetic, floating point, branch. Loads with
> > no side effects also fall into this category. These are the
> > instructions that can erroneously be nop'd. The other category are
> > instructions that can change architectural state more than a GPR.
> > These include all stores, atomic loads, exclusive loads, loads to
> > non-cacheable space,msr,mrs,eret,tlb*,sys,brk,etc, these does not get
> > "noped"
> >
> > >
> > > Does this only apply to a single instruction at a time, or can
> > > multiple instructions "become nop"?
> >
> > Can be multiple,
> >
> > >
> > > When an instruction "becomes nop", will subsequent instructions see
> > > a consistent architectural state (e.g. GPRs as they were exactly
> > > before the instruction which "becomes nop"), or can they see
> > > something else (e.g. garbage forwarded from register renaming or othe=
r
> internal microarchitectural state)?
> >
> > > > > * Does the CPU lockup?
> > > > No
> > > >
> > > > > * Does the CPU take the exception at all?
> > > > No
> > > >
> > > > > * Does the load behave erroneously?
> > > > No,
> > > >
> > > > > * Does any CPU state (e.g. GPRs, PC, PSTATE) become corrupted?
> > > >
> > > > yes, GPRs will get corrupted, will have stale value
> > >
> > > As above, is that the prior architectural value of the GPRs, or can
> > > that be some bogus microarchitectural state (e.g. from renaming or ot=
her
> forwarding paths)?
> >
> > The instructions that become a nop doesn't write the GPR and because
> > this is an OOO machine the GPR result isn't the prior architectural
> > value but whatever crap is leftover in the physical register.
>=20
> Ok, so that's a potential information leak from a different context (e.g.=
 higher EL),
> depending on what happened to be left in that physical register.
>=20
> Consider a malicious guest at EL1. What prevents it from triggering this
> deliberately, then inspecting the GPRs after taking the IRQ in order to r=
ead prior
> secrets?
>=20
> > > > > Does the problem manifest when IRQs are masked by DAIF.I, or by
> > > > > CNT*_CTL_EL0.{IMASK,ENABLE} ?
> > > >
> > > > No, there are no issue if interrupts are masked.
> > >
> > > If a write to CNTV_CTL_EL0.IMASK races with the interrupt being
> > > asserted, can that trigger the problem?
> >
> > If interrupt is enabled (DAIF) - then it will be taken, and no issue
> > But if interrupts are disabled then following sequence can see the race
> >  1)	interrupt is disabled (DAIF)
> > 2)	TVAL/ENABLE/IMASK at timer h/w programming to de-assert interrupt.
> > 	Race of Irq asserted before irq de-asserted, than this short window of
> assertion will be considered as spike from timer h/w block
> > 3)	Enable DAIF
> > 	Because of propagation delay CPU sees assertion and de-assertion
> > (spike), errata hit
> >
> > Will add "isb" around interrupt enablement in next version of patch.
>=20
> ... why?
>=20
> That doesn't seem to follow from the abvoe, so I think I'm missing a step=
.
>=20
> > > If a write to DAIF.I races with the interrupt being asserted, can
> > > that trigger the problem?
> >
> > No race with writing to DAIF.I with interrupt assertion, Writing
> > DAIF.I =3D 0 (enablement of interrupt) can race with de-assertion, whic=
h
> > can lead to hitting errata
>=20
> Ok.
>=20
> That *might* make it possible to bodge around the timer specifically, but=
 as
> below I don't think we can ensure this is safe in the presence of virtual=
ization,
> nor when considering other interrupts.
>=20
> > > From your description so far, this doesn't sound like it is specific
> > > to the timer interrupt. Is it possible for a different interrupt to t=
rigger this, e.g:
> > >
> > > * Can the same happen with another PPI, e.g. the PMU interrupt if tha=
t
> > >   gets de-asserted, or there's a race with DAIF.I?
> > >
> > > * Can the same happen with an SGI, e.g. if one CPU asserts then
> > >   de-asserts an SGI targetting another CPU, or there's a race with
> > >   DAIF.I?
> > >
> > > * Can the same happen with an SPI, e.g. if a device asserts then
> > >   de-asserts its IRQ line, or there's a race with DAIF.I?
> >
> > No issue with edge triggered, but this can happen with any level sensit=
ive
> interrupt.
>=20
> Ok.
>=20
> So that'll include at least the PMU and
>=20
> > > If not, *why* does this happen specifically for the timer interrupt?
> > >
> > > > > > Workaround of this is to ensure maximum 2us of time gap
> > > > > > between timer interrupt and timer programming which can de-asse=
rt
> timer interrupt.
> > > > >
> > > > > The code below seems to try to enforce a 2us *minimum*. Which is
> > > > > it supposed to be?
> > > >
> > > > Yes, it is minimum 2us.
> > > >
> > > > >
> > > > > Can you explain *why* this is supposed to help?
> > > > With the workaround interrupt assertion and de-assertion will be
> > > > minimum 2us
> > > apart.
> > >
> > > I understood that, but why is that deemed to be sufficient? e.g. is
> > > it somehow guaranteed that the CPU will complete the instruction that=
 would
> "become nop"
> > > in that time?
> >
> > With this delay we avoid spike, either this this will becomes an
> > actual interrupt or the spike never visible to core.
> >
> > > > > I don't see how we can guarantee this in a VM, or if the CPU
> > > > > misses on an instruction fetch.
> > > >
> > > > This errata applies to VM (virtual timer) as well, maybe there is
> > > > some gap in my understanding, how it will be different in VM.
> > > > Can you help with what issue we can have VM?
> > >
> > > A VCPU can be pre-empted by the host at *any* time, for an arbitrary
> > > length of time. So e.g. you can have a scenario such as:
> > >
> > > 1. Guest reads CNTx_TVAL, sees interrupt is 4us in the future and
> > >    decides it does not need to wait
> > > 2. Host preempts guest
> > > 3. Host does some processing for ~3.9us 4. Host returns to guest,
> > > with 0.1us left until the interrupt triggers 5. Guest reprograms
> > > CNTx_TVAL, and triggers the erratum
> >
> > Yes, when timer expire just before tval written (race condition) , so
> > there is assertion-followed by de-assertion, As interrupts are enabled
> > in host, interrupt will be visible as spike to host.
>=20
> Ok, so that's a recipe for the guest to attack the host.
>=20
> > We will apply workaround whenever entering to guest (add a delay
> > before exiting to guest in case guest timer is going to expire).
>=20
> I think this is papering over the problem.
>=20
> You've said this can happen for *any* level-triggered interrupt. AFAIK, n=
othing
> prevents a malicious guest from deliberately asserting and de-asserting a=
 level-
> triggered interrupt (e.g. by writing to the GIC distributor), and I also =
note that the
> GIC maintenance interrupt is level-triggered.
>=20
> So, as above:
>=20
> 1) A guest can deliberately cause information to be leaked to itself via
>    the corrupted GPRs. I haven't seen any rationale for why that is not
>    a problem, nor have I seen a suggested workaround.
>=20
> 2) A guest *may* be able to trigger this while the host is running. I
>    haven't seen anything that rules this out so far.
>=20
> 3) Even in the absence of virtualization, it would be necessary to
>    workaround this for *every* level-triggered interrupt, which includes
>    at the timer, PMU, and GIC maintenance interrupts, in addition to any
>    other configurable PPIs or SPIs.
>=20
> Without a fix that covers all of those, I don't think the workaround is v=
iable.

This patch covers workaround for ARM arch timer in non-virtualized cases.

While we are considering different scenarios which can trigger the issue.
After discussing with HW folks internally we have come to a conclusion that=
 there is no=20
single workaround which will fix all the scenarios. The host timer interrup=
t workaround is
different from virtualization and from other interrupt sources.

While we are working on other workarounds, we want to push timer workaround=
 first
as currently that's the one customers are encountering right now and want a=
 upstream
accepted patch soon. Other workarounds will take time to test and qualify.

Wrt drivers disabling the interrupt, except changing the driver, we don't s=
ee any common
place where we can add a workaround. Please let me your take on this.

Thanks
-Bharat

>=20
> Thanks,
> Mark.
