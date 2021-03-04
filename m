Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A705332C93B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 02:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382217AbhCDBGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 20:06:00 -0500
Received: from mail-eopbgr60065.outbound.protection.outlook.com ([40.107.6.65]:6823
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1452937AbhCDAjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 19:39:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTAVTtsGnod9Hw98pcGb3BWrhjZhaurFCJn5VKjq/vc=;
 b=m5ARg5sMGSC9IaRleSv/DC1P5PYjfD7XKZ/E7r/gGpc9prgLuJdhuk5VGZ26aZahYWQnLVdfv55Bte54RxriGPgTTzmjxL6/1q4EeTTO0n4T7ENMcHBSS9xl3EwDOe8e30ENcsYFZFlUgh7GH3z/eAh2EsVGA4dlpOWkHQREFhU=
Received: from AM5PR0701CA0069.eurprd07.prod.outlook.com (2603:10a6:203:2::31)
 by AM0PR08MB4307.eurprd08.prod.outlook.com (2603:10a6:208:13d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Thu, 4 Mar
 2021 00:38:54 +0000
Received: from VE1EUR03FT046.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:203:2:cafe::f7) by AM5PR0701CA0069.outlook.office365.com
 (2603:10a6:203:2::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.9 via Frontend
 Transport; Thu, 4 Mar 2021 00:38:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT046.mail.protection.outlook.com (10.152.19.226) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Thu, 4 Mar 2021 00:38:54 +0000
Received: ("Tessian outbound a0a2a6bb2210:v71"); Thu, 04 Mar 2021 00:38:53 +0000
X-CR-MTA-TID: 64aa7808
Received: from 48cdb8434356.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 80F710F9-A5AE-47B6-8D3B-23B3A07AD4C6.1;
        Thu, 04 Mar 2021 00:38:48 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 48cdb8434356.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 04 Mar 2021 00:38:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JclXok/9er3lbqF+OeFMkKU0oeozeXEoqhX35unW+5zXjj+ixpxHjiZzQ80FLMHfgtA/gklCxm7MktaudMkj2saJnFLLM6kXeyoVNey63T5rJjyvUabcztg/mQ7EtjgHeIqGUJU7EAuIqxj7HwSqCUBtWdhZDx4oWaqen7c+ah0eugVCtKB8rFIUF2c75qmbGMpqlDTA4n6TB3tL6wBNZfTc6v2ne1fqHs1a9OoNm467Y5fMZfpyhlLrmckPcEq3krpJdmLuGEymDa+HIVuFjpa38GdGlKFuhar5oirBUheZ4aQzlRyZfndzpTXhwbPsptSSNGj732FHeHVUgWlAsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTAVTtsGnod9Hw98pcGb3BWrhjZhaurFCJn5VKjq/vc=;
 b=CRl27jmBe9vkQ+6/u4n9q74ax7F1mGW/DZs8LAVrtIM7Z1IMzVE7iPNctyQQkiK0mo0gi1IXkJ9aKAXRo2Tzp5Ox7O1WGqIivaXT3HZshfCCqYf95iF5WpqirV2fylTcWqMxF7D+meCU35aseXBYxlYFjePz2HnGE369oC8E6dwvy6NvqJxTnspa8DyBCW1yeAuOVWvRKzVjZ5o9P6Fi3U5rbQY2CBf6ZrATxQ75e1C5wWYmQcN3KO60mmW7WSVB0b/HLiyi1WwB89yXd3De5buD57RTDOprmi6XQ9X/vRVK8CS8t/PVBocwlKO/zMJYBN2X5pl9C0blgGyNwN3baA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTAVTtsGnod9Hw98pcGb3BWrhjZhaurFCJn5VKjq/vc=;
 b=m5ARg5sMGSC9IaRleSv/DC1P5PYjfD7XKZ/E7r/gGpc9prgLuJdhuk5VGZ26aZahYWQnLVdfv55Bte54RxriGPgTTzmjxL6/1q4EeTTO0n4T7ENMcHBSS9xl3EwDOe8e30ENcsYFZFlUgh7GH3z/eAh2EsVGA4dlpOWkHQREFhU=
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AM6PR08MB3477.eurprd08.prod.outlook.com (2603:10a6:20b:49::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.25; Thu, 4 Mar
 2021 00:38:44 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::5192:4597:8d30:5800]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::5192:4597:8d30:5800%4]) with mapi id 15.20.3912.019; Thu, 4 Mar 2021
 00:38:43 +0000
From:   Justin He <Justin.He@arm.com>
To:     Quentin Perret <qperret@google.com>, Marc Zyngier <maz@kernel.org>
CC:     "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        James Morse <James.Morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki Poulose <Suzuki.Poulose@arm.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will@kernel.org>, Gavin Shan <gshan@redhat.com>,
        Yanan Wang <wangyanan55@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] KVM: arm64: Fix unaligned addr case in mmu walking
Thread-Topic: [PATCH] KVM: arm64: Fix unaligned addr case in mmu walking
Thread-Index: AQHXD9bsiwf2wq23AEqHAHP4tBiTG6pyBrSAgAAU0gCAAOD8gA==
Date:   Thu, 4 Mar 2021 00:38:43 +0000
Message-ID: <AM6PR08MB4376251F80E3352C7CF649D9F7979@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <20210303024225.2591-1-justin.he@arm.com>
 <87sg5czhny.wl-maz@kernel.org> <YD9uSPQtlP2WTObe@google.com>
In-Reply-To: <YD9uSPQtlP2WTObe@google.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 9B857019160ECA40A8C8FDB551134B7A.0
x-checkrecipientchecked: true
Authentication-Results-Original: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=arm.com;
x-originating-ip: [203.126.0.113]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2b97f563-5b90-4308-7a9a-08d8dea5e3a6
x-ms-traffictypediagnostic: AM6PR08MB3477:|AM0PR08MB4307:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB43079D7436D5AD8B7456068DF7979@AM0PR08MB4307.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: NvyrT6W1FZOgUPy64RALs1jKSOGq/69bWxU6tHdiIoFD0Y2wdH8N7sbuGO3LuL+8bAoezSSvx4pNgVJRW3pe9t07Cc7xX1tZKtMVBCJj76puks8A3vXUVMEx19tg1xk/tH1aD3XxdftxpgQn2MQwRs6l5QCrQaWGDW/UyxlucJNhkBf9AkpeA0m/fblO0LHuqpPZYcQ6oBSmaKsCVyRQ0gNjL6GBP57B0qX92Oj2fEOSFXWBSi8rZyTmdLaXPSCREcfCBCKaxYNrIgU3lRK2/xf3mgaPSH6cMbpv/P2JaPd1gMvwKiC+eWkb5NnSvUNYUt8VQAtTSE/wahLcDdUoENReJXFFINxlcPbSd0acC40rMQYzi7C51QMiPIcQ7ZxJRVm4nqHbeaUv8BXbd0ewtRxzxuJoSwcmlcFRAUbis6fy4gbx4EEe+f4Y6edcL4T6DajJjVQNr7EslFm3e1quLLr/PwKo6uqNUrduLpnS7T4jKCpRWiVLXWA07ioYj42905rcuYNiPEgD/0YxIAZE1A==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(5660300002)(66476007)(66446008)(9686003)(54906003)(186003)(83380400001)(4326008)(66556008)(26005)(66946007)(64756008)(52536014)(8676002)(53546011)(110136005)(33656002)(71200400001)(6506007)(86362001)(55016002)(498600001)(7696005)(76116006)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?h+iysOKTOTJqS0CQncyReREVFD5rI11i1CFPY4WYKmBydoppufa4ci5tUctY?=
 =?us-ascii?Q?Cn8e8/ZKtObhFTCjQ6zaNKvvFI111hP3saUozz+9itrQk2DWG8WN3m3TOOez?=
 =?us-ascii?Q?8sEIPKweuVShXAaCbsPhuL0ZKUiPmIarHaZbtJj/CzEV+LhM9A2O1JpZ+W+f?=
 =?us-ascii?Q?N8dZfnWiGkQEcT8PKpoJNYrq+yy/4ZF4nrdrCGgrISatEEp3Uj/I5IFUOQC2?=
 =?us-ascii?Q?PjsZHTR3cKKhQFZM10d3gukhR4Jcbn4MFYLkcOKWH02Io1AI/FyoOBDvuoi5?=
 =?us-ascii?Q?+XIdyObsa7AHenJllHMkz8v8rTFpRbA+IBsyHfU58Nw6/odds6Pga1EYioub?=
 =?us-ascii?Q?liqtn4/lr/NrM+IhjWlyONoKset9OsEpmD3LW9xAFmNQlJq0XwFxscSMZpas?=
 =?us-ascii?Q?SfkpdSNypxa6EymJX0YEKgl4KHbVRFn+p4k+bYU50c8MOLKvb29nkzjGVqxB?=
 =?us-ascii?Q?0C4CRzR9mdwFbhiQiJxmy9FlpcQTOm22HGIaULyp0BAVcn9yIckOEQpVnWQI?=
 =?us-ascii?Q?z3v/1qTb+UT1DPPcU7klP7KkhjJ4Abs5xEVss0WntNzYvhreC2pkhvqRXX1a?=
 =?us-ascii?Q?WcC54BAgLNJVtRuVv80uM37wWku80jXc5pPU8C5BAa1Z6mJbFukm4PBQ9N8t?=
 =?us-ascii?Q?ZIsqIHAeDOrVyygLAVLw4iRJUUOCzgcHo2G+vILOmVFDUVhWGokDDLBud9C6?=
 =?us-ascii?Q?11pjgHQhho/Y5AMHU75cZpMLWtgmzlTnl8iSTBQzlKfKnGR+QezQ/2frNIVV?=
 =?us-ascii?Q?Jl0YpSqq5gWsJB9IwCL86kBdBJg6A546a1Y0TSe7RL/XwMcJu4MfAfoQm+oa?=
 =?us-ascii?Q?RUvAJhI0JYj+abBrIePbkgLqbpxw+gqTbPiDWvkH2bjtyqrlORZgDvloYgNq?=
 =?us-ascii?Q?R3A1YLK5uPUEphaQUlNUuE4z6mLJiMgdbtV5UgQYDYq1CggDy53dixQ02bZd?=
 =?us-ascii?Q?//h2v6wPpvSV5LIvqOlaLFff5svRYF8g3j6Dg+GC0QIHT02eLULF61+NSaY5?=
 =?us-ascii?Q?s8iuYr2agSl7zzRH3/GTwsTEm4yZdjX7ZYrI4i7SaFruoqSpOfcxPK3JVTOS?=
 =?us-ascii?Q?px4yK6GeAFvGpNfOmHsUWJ8F56rmQaP88E4m0yHwkkw/ITCFCtSrLsmwTcUu?=
 =?us-ascii?Q?tb4V0IOB4qJrHEUENo6rLB0A7+3w4REwvy5/NcQ1Tfl2qRxPB4bP/mtjx8Ta?=
 =?us-ascii?Q?SQyprqV2WiR1lN79LcpMmEeU0dtpflQvw8xyK6Cw4YgcIHj+Iyv6vqXEdGhA?=
 =?us-ascii?Q?aStJ8gnvu59bQkjrmkI3P8hXt8psB1EYIhxJGRj8eIO+G1Q2GZVALuax6c9A?=
 =?us-ascii?Q?f0Rfp6oVJynu2Go9ocGO3vA7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3477
Original-Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT046.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 393a21db-39b9-4648-3a82-08d8dea5dd59
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3BxbaV/p1IK8maiMDQpmpl+cud2gFE6e2K3OUSbUvc+qKg+NAQ5XYP7KAXhUDvSL8RNEDQ9NH9M1WSXIiNif+pU5mBbhE6udT0aD72UcymHThR93FALhFCI37gYBs66i6OwqkctaAsIu2SVOmJBpTQI8GxdpZzpORLjcNqzKY12IxHBr7xPYVfBnvX6cF7mjq6tW42AMaHFKV2YnBD11xYdCaRUzBp+52BubDP46dkcHdPn7fRQlOVCbkEg4Li4ffz7+p9pk3/GMPkJWSprahgqeehC91y9pGmJJQ5T5/t1Hajc5oU1/Tbh8GKHvKx1NI/MiQvQyNRwUGpJq4E6vlgXpoMNIkayts4oh1AwSAnflE8BRzTKKDBxCxbVB4HCe3gKHaZ0yboqYZBDgEsr3eHXVqYqV7zri89tVk+ejqhB75qphNpE+gwlz9qxJ72Iv1NoHhPfQc/n03NB7AD3YL5hRiVjpWWSF5hd25K/k8HPhMSRP+GbBNe8oBV4+/uwYAqT0rCYe5bbP8ypSlJLs5GSXiKdyjmIh9w+gqzvnuyKk53AvZ/xolzAGhl1SwY8ezHSyWy8QwmOZdI5vgCY34f9ChRWuQ5mSqNZg6myb3bW0hvqj9ej/4GowuU3p9Bb7+4sdOgTYQIb8UY95VT/oJejUN8tnf3lYbyQ7DniC1JI=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(396003)(376002)(46966006)(36840700001)(8676002)(186003)(9686003)(5660300002)(52536014)(8936002)(26005)(55016002)(54906003)(82740400003)(86362001)(316002)(36860700001)(356005)(478600001)(81166007)(110136005)(33656002)(70586007)(70206006)(83380400001)(6506007)(53546011)(336012)(82310400003)(2906002)(7696005)(47076005)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2021 00:38:54.1564
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b97f563-5b90-4308-7a9a-08d8dea5e3a6
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT046.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4307
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin and Marc
I noticed Marc had sent out new version on behalf of me, thanks for the hel=
p.
I hated the time difference, sorry for the late.

Just answer the comments below to make it clear.

> -----Original Message-----
> From: Quentin Perret <qperret@google.com>
> Sent: Wednesday, March 3, 2021 7:09 PM
> To: Marc Zyngier <maz@kernel.org>
> Cc: Justin He <Justin.He@arm.com>; kvmarm@lists.cs.columbia.edu; James
> Morse <James.Morse@arm.com>; Julien Thierry <julien.thierry.kdev@gmail.co=
m>;
> Suzuki Poulose <Suzuki.Poulose@arm.com>; Catalin Marinas
> <Catalin.Marinas@arm.com>; Will Deacon <will@kernel.org>; Gavin Shan
> <gshan@redhat.com>; Yanan Wang <wangyanan55@huawei.com>; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] KVM: arm64: Fix unaligned addr case in mmu walking
>=20
> On Wednesday 03 Mar 2021 at 09:54:25 (+0000), Marc Zyngier wrote:
> > Hi Jia,
> >
> > On Wed, 03 Mar 2021 02:42:25 +0000,
> > Jia He <justin.he@arm.com> wrote:
> > >
> > > If the start addr is not aligned with the granule size of that level.
> > > loop step size should be adjusted to boundary instead of simple
> > > kvm_granual_size(level) increment. Otherwise, some mmu entries might
> miss
> > > the chance to be walked through.
> > > E.g. Assume the unmap range [data->addr, data->end] is
> > > [0xff00ab2000,0xff00cb2000] in level 2 walking and NOT block mapping.
> >
> > When does this occur? Upgrade from page mappings to block? Swap out?
> >
> > > And the 1st part of that pmd entry is [0xff00ab2000,0xff00c00000]. Th=
e
> > > pmd value is 0x83fbd2c1002 (not valid entry). In this case, data->add=
r
> > > should be adjusted to 0xff00c00000 instead of 0xff00cb2000.
> >
> > Let me see if I understand this. Assuming 4k pages, the region
> > described above spans *two* 2M entries:
> >
> > (a) ff00ab2000-ff00c00000, part of ff00a00000-ff00c00000
> > (b) ff00c00000-ff00db2000, part of ff00c00000-ff00e00000
> >
> > (a) has no valid mapping, but (b) does. Because we fail to correctly
> > align on a block boundary when skipping (a), we also skip (b), which
> > is then left mapped.
> >
> > Did I get it right? If so, yes, this is... annoying.
> >

Yes, exactly the case

> > Understanding the circumstances this triggers in would be most
> > interesting. This current code seems to assume that we get ranges
> > aligned to mapping boundaries, but I seem to remember that the old
> > code did use the stage2_*_addr_end() helpers to deal with this case.
> >
> > Will: I don't think things have changed in that respect, right?
>=20
> Indeed we should still use stage2_*_addr_end(), especially in the unmap
> path that is mentioned here, so it would be helpful to have a little bit
> more context.

Yes, stage2_pgd_addr_end() was still there but the stage2_pmd_addr_end() wa=
s removed.
>=20
> > > Without this fix, userspace "segment fault" error can be easily
> > > triggered by running simple gVisor runsc cases on an Ampere Altra
> > > server:
> > >     docker run --runtime=3Drunsc -it --rm  ubuntu /bin/bash
> > >
> > > In container:
> > >     for i in `seq 1 100`;do ls;done
> >
> > The workload on its own isn't that interesting. What I'd like to
> > understand is what happens on the host during that time.

Okay

> >
> > >
> > > Reported-by: Howard Zhang <Howard.Zhang@arm.com>
> > > Signed-off-by: Jia He <justin.he@arm.com>
> > > ---
> > >  arch/arm64/kvm/hyp/pgtable.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/arch/arm64/kvm/hyp/pgtable.c
> b/arch/arm64/kvm/hyp/pgtable.c
> > > index bdf8e55ed308..4d99d07c610c 100644
> > > --- a/arch/arm64/kvm/hyp/pgtable.c
> > > +++ b/arch/arm64/kvm/hyp/pgtable.c
> > > @@ -225,6 +225,7 @@ static inline int __kvm_pgtable_visit(struct
> kvm_pgtable_walk_data *data,
> > >  		goto out;
> > >
> > >  	if (!table) {
> > > +		data->addr =3D ALIGN_DOWN(data->addr, kvm_granule_size(level));
> > >  		data->addr +=3D kvm_granule_size(level);
> > >  		goto out;
> > >  	}
> >
> > It otherwise looks good to me. Quentin, Will: unless you object to
> > this, I plan to take it in the next round of fixes with
>=20
> Though I'm still unsure how we hit that today, the change makes sense on
> its own I think, so no objection from me.
>=20
> Thanks,
> Quentin
