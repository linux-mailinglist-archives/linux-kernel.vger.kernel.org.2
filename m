Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D4F42C1F7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 15:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236210AbhJMOAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 10:00:12 -0400
Received: from mail-bn7nam10on2046.outbound.protection.outlook.com ([40.107.92.46]:54080
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235810AbhJMOAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 10:00:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lXCLeHg8E19jsDwpblV+EO3XucsznO7+XlC+wmuX54FfxjWepIllnaPf6kNVT5H0V9Lq3teF9H0LFpxcaAGtV5tCEr8qykvmVE5mZhIN9IbjBequSjAlcRceEZciKrHlIJ1NpS+QB4Cni+rXvr4HD6xY591VjJAp+Yn66PK1JnnXOfq429RH8J/9d8ne0jvysIq73/RAW6zXOC6ye2mjO8wXLsboIRRr/Vh5szN9t31Jbv6oHJNfn6Y3i2gs9rEew06PuvdFA/XE9Wdd44n8KZLeKWg/oPDiTFpe7wiuEoy41fEEkuSJ8sOvPlUuIk4+2dlrBhQRt8UWEdFV3qi++Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oU8VQj36Ahlx2bb+0ZxW6zWbE4ghXSayPQS27AOIaVk=;
 b=gqJQVU6UVWv8XWBFGaPioIYqoFJS2+EXo04yEVXTzLR5Qh0jNPwT6h5WG4Uye0e+GG6OAfi6gcXh4H1+V662ck1Wg9A55pSKUPbVUXC40ISKZlJDSuIZIMuMev4N6/00iSXqgvzBjQTfU2Y6leofzCrix2dsXYzg/ozSluKBAon6R4P9cpNahmEY+w1U7NV5adXPit+/MwBdmTttFwRat0TMXVzJOpNgmLlVWOVDjUhilcGT+iDODVRttPuNGljesvRMkFcyaLZsydiH3JMpmxP2r/CIbA9LXH2keSSS0qfwCP/HFhQ/TN34HjwYotmAR1JwQKlvS0ZdaEItdeUf0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oU8VQj36Ahlx2bb+0ZxW6zWbE4ghXSayPQS27AOIaVk=;
 b=K3shnn53hnxM3BMacKTbKa9ZfnXG/VeeHNBskdwYSsMe6l/8/h39M0WvOQ2v+uDYkQIEMXssMKwFlajvgzwNIf3Y2NQLuJ+zWhB4NqnDPccwNybdssnoipKTTjUEtudtZ3IkoCkONrXeiUn6uKAO6+L0t6Zjpw/DVX2SLbR5KYU=
Received: from SA1PR02MB8592.namprd02.prod.outlook.com (2603:10b6:806:1ff::18)
 by SA1PR02MB8479.namprd02.prod.outlook.com (2603:10b6:806:1fa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Wed, 13 Oct
 2021 13:57:59 +0000
Received: from SA1PR02MB8592.namprd02.prod.outlook.com
 ([fe80::6d3e:7010:c43d:fb23]) by SA1PR02MB8592.namprd02.prod.outlook.com
 ([fe80::6d3e:7010:c43d:fb23%7]) with mapi id 15.20.4608.016; Wed, 13 Oct 2021
 13:57:59 +0000
From:   Abhyuday Godhasara <agodhasa@xilinx.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     Michal Simek <michals@xilinx.com>, Rajan Vaja <RAJANV@xilinx.com>,
        Manish Narani <MNARANI@xilinx.com>,
        "zou_wei@huawei.com" <zou_wei@huawei.com>,
        Sai Krishna Potthuri <lakshmis@xilinx.com>,
        Jiaying Liang <jliang@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v4 0/6] Add Xilinx Event Management Driver
Thread-Topic: [PATCH v4 0/6] Add Xilinx Event Management Driver
Thread-Index: AQHXqjPsj2n6NIOYSUC8o2qDqfgxnKvRBXFQgAAKboCAAAG/AIAADkYw
Date:   Wed, 13 Oct 2021 13:57:59 +0000
Message-ID: <SA1PR02MB8592E68D021E12DCA45B70A2A1B79@SA1PR02MB8592.namprd02.prod.outlook.com>
References: <438b398c-a901-7568-11e0-cd9bf302343f@xilinx.com>
 <20210915131615.16506-1-abhyuday.godhasara@xilinx.com>
 <SA1PR02MB8592838B99062EFA6EAAE73DA1B79@SA1PR02MB8592.namprd02.prod.outlook.com>
 <YWbYKQXf8g8s55kG@kroah.com> <YWbZoPHDzc4e5Nme@kroah.com>
In-Reply-To: <YWbZoPHDzc4e5Nme@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5cefad77-b5ec-45a5-f171-08d98e517751
x-ms-traffictypediagnostic: SA1PR02MB8479:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA1PR02MB847952A53E63153F05535BA4A1B79@SA1PR02MB8479.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xaSJ+QhsixqGLRp6zysgjPQL38nR/1NV87eng6y3fT25NblXtf/ZVIEniJNECgFOye/8NusENhffw9UESsTDAA2joFLgbXYKevYMGNAYqKuB//iIfPZ34Hd3WnnqZF3sjUn7l1+Yimv6ajcvXO4AxfoghwqS45Arm+m6mzTqjKdwxQDXO9ee/xwpWJ0rpWOHrWS06PfNkxpBFBiqGZrZo75ndZrOYzgbBaHMghcBEK/vOk03p/LTMucMpNYcUP9f/MERgjQJcFAcg4+gKBe7t+tPm7HD2BDpE0E2inM//7KQHjHjXXF3Ew50Rkw05SG1+K92JYkkQDtVbKgOsVfaAyTGnMhWLpFLplLARZNAexgzrmYt1GboeBKCjQc9R+BfgKi+19EuJMycZznJd4tcXWsjQJhepYryrpFFhwlYq5dYRmkl0QbMik6KPPeZUBseZqwVqIphPw40aB6/NIVYazBOpdwHnKKbOj8fX9sTP6FpKfk2XQghC6nS2/7uysbUaP0QU7JJLceshVZ/hYoSjU+KtEfl06tOLcKeBlFKKnZwzgmqUt1Q7zTxWzSTIcL+HoTDgrmkNobozugFuAK+sPMyKct5d4gGMP+LwMoxXsYQlM38NnWITaParb8wKkEaUrDR9081mr2ZxqOMtR/nWItNkzYLixgr8ZcF1RMllgvoZwh8jhQrXE2bKWZJMI760XDRRWn4D8emrCqRYUXgWQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR02MB8592.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(55016002)(26005)(76116006)(508600001)(66556008)(52536014)(4326008)(38100700002)(33656002)(53546011)(7696005)(66446008)(66476007)(64756008)(66946007)(186003)(6916009)(83380400001)(86362001)(38070700005)(5660300002)(122000001)(6506007)(9686003)(54906003)(8676002)(316002)(71200400001)(8936002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PSCsP928VrV4GCJHVSb5TOI3tt+0r2b7A/vF87M8r+ihMTqUNeR/zIp+YJJL?=
 =?us-ascii?Q?3h3Df6hzHhuE1R0qIZG4rAb5TLYX71/Mf7rzkanf5GoNx1AG3A1sa9yrxfco?=
 =?us-ascii?Q?6pHXk/SYvmPjNEtvilS4Gc0LwpwN/Vmt+ROgmiiiZv2ZpXCrTD26hhxLLK+d?=
 =?us-ascii?Q?BPBpybnWmKERO0trbL4/2nubonsz2736k/M8RWsaI01LamBcZFntPuTSPOGD?=
 =?us-ascii?Q?r/pOo3zHwmJnFUB3vDsGGHzPG6C5X4G/zh903jTeEJ4Swa+NDNodMkoLQETm?=
 =?us-ascii?Q?kWzBBq5sTvmq4iG25/RWSABk9h2wxEUcE2hjUHWboMo1h8/XUUR0G03uLD7/?=
 =?us-ascii?Q?CGL/6mAZs/k5RqTG0gSce6XfqAGoWixBKo1jVjQvzXxOZz96tr1sG8S6g/s7?=
 =?us-ascii?Q?0QzA8FSZGMLB5WABAcjh0Zu99nPsE9HTkGv8A7FPkUSOW+ATHM3RUoGdgJuj?=
 =?us-ascii?Q?+d/8EqHt1MDwiRInwYx+50FIQH1vNnVhzUrOSIm45kFej5Rdz2dF2cPSVH85?=
 =?us-ascii?Q?BtlNmHUbiEMt55qRe21AJJiSI+OOLJIlmzemvaQQ2KJsbfaklOs7Nt8/ObB5?=
 =?us-ascii?Q?7mCihthMdKESHzz10U5u2oEK1QSOcDVyyaHiFOMdg8p6g2xQSp0NkZ65fNGv?=
 =?us-ascii?Q?kgWnHwIkKIz5B2aTLUIwY0vNh6/NkI3jbm0bQjp1iyZF4GyTbzGpRYZPunJE?=
 =?us-ascii?Q?QCNt73dLch+VjiTpQ2YauW7LbVxS2XT9nCE9aEnph6HcAH1PWphe6WVa2+p5?=
 =?us-ascii?Q?ArmrDUAj/j5+R3SyoU4PccD2gdLrH+MtAhgyMLJry+Ovqjxmqdl48GcHeVxE?=
 =?us-ascii?Q?HbXyRRLxY8/kHAGy0dYQETeDlSCROsg745D3wuX0TX/pZTqFAzSpeNQBjlDZ?=
 =?us-ascii?Q?qimS8YE1YYbydGRTSIdoaO1RYfWdOsdLNRAdqPJNZ6tvl7NDSBY+09cuR05T?=
 =?us-ascii?Q?FOtZVddOT61+Qy1xtn//9ejHyatfywR+mCPyT7bOBtn/vxFGrvsm0bm6p+xc?=
 =?us-ascii?Q?GxCjq8NBYWamopM4WwDjTB98dzM1qZ7tYDsK4ftBl13m1OG5BElCYLLAOMDw?=
 =?us-ascii?Q?GssTg9/8/nFCW3dIkSbdp+AQIkprQSGftPrM7PRJcAOunLEpwPBhTxkkYNXt?=
 =?us-ascii?Q?81vf7br+rOn3IirbcgBNWLAPf6p05zymMGIF/ohtvCQbAU+fJmK+wWutZeCy?=
 =?us-ascii?Q?5ESXIeVGitGS7IrYO2p68rDa76z+QGavc8GyTFCMoYljBXRRzruKAJ5i6pur?=
 =?us-ascii?Q?zf2n00wsCgkobRpLQYUetUde4NokOI8lwiwlOIg09UTNlPGyoft06+G1c52n?=
 =?us-ascii?Q?f17R5X7zg9O+4CQ6Cjn34YAm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR02MB8592.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cefad77-b5ec-45a5-f171-08d98e517751
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2021 13:57:59.3078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uT/o+J376D/Ae2LvK6MO+TjqBlTlkRPVWVuUVcTvtycrcZwX9YF1s9DN2zmj5D/GmZ/T6q+l60iR7GsIaNKWcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8479
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> -----Original Message-----
> From: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>
> Sent: Wednesday, October 13, 2021 6:36 PM
> To: Abhyuday Godhasara <agodhasa@xilinx.com>
> Cc: Michal Simek <michals@xilinx.com>; Rajan Vaja <RAJANV@xilinx.com>;
> Manish Narani <MNARANI@xilinx.com>; zou_wei@huawei.com; Sai Krishna
> Potthuri <lakshmis@xilinx.com>; Jiaying Liang <jliang@xilinx.com>; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH v4 0/6] Add Xilinx Event Management Driver
>=20
> On Wed, Oct 13, 2021 at 02:59:21PM +0200, gregkh@linuxfoundation.org
> wrote:
> > On Wed, Oct 13, 2021 at 12:27:58PM +0000, Abhyuday Godhasara wrote:
> > > Hi Greg,
> > >
> > > > -----Original Message-----
> > > > From: Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
> > > > Sent: Wednesday, September 15, 2021 6:46 PM
> > > > To: gregkh@linuxfoundation.org
> > > > Cc: Michal Simek <michals@xilinx.com>; Abhyuday Godhasara
> > > > <agodhasa@xilinx.com>; Rajan Vaja <RAJANV@xilinx.com>; Manish
> > > > Narani <MNARANI@xilinx.com>; zou_wei@huawei.com; Sai Krishna
> > > > Potthuri <lakshmis@xilinx.com>; Jiaying Liang <jliang@xilinx.com>;
> > > > Jiaying Liang <jliang@xilinx.com>; linux-kernel@vger.kernel.org;
> > > > linux-arm- kernel@lists.infradead.org
> > > > Subject: [PATCH v4 0/6] Add Xilinx Event Management Driver
> > > >
> > > > This Linux driver provides support to subscribe error/event
> > > > notification and receive notification from firmware for
> > > > error/event and forward event notification to subscribed driver via
> registered callback.
> > > >
> > > > All types of events like power and error will be handled from
> > > > single place as part of event management driver.
> > > >
> > > > Changes in v4:
> > > > - Rebase on latest tree
> > > >
> > > > Changes in v3:
> > > > - Update the commit message.
> > > >
> > > > Changes in v2:
> > > > - Removed updated copyright year from unchanged files.
> > > > - make sgi_num as module parameter for event management driver.
> > > > - Use same object for error detection and printing.
> > > >
> > > > Acked-by: Michal Simek <michal.simek@xilinx.com>
> > > [Abhyuday] Michal suggested to merge this via your tree. Please have =
a
> look.
> > > Please let me know if there is anything required from my side.
> >
> > Ok, I'll pick it up, thanks.
>=20
> Nope, I can not as for some reason it all did not show up on lore.kernel.=
org.
>=20
> Please resend this, with Michal's ack and I will be glad to pick it up.
[Abhyuday] Sent v5 with Michal's ack.

Thanks,
Abhyuday

>=20
> thanks,
>=20
> greg k-h
