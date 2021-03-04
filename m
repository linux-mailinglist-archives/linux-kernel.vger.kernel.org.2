Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B90732C9E4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 02:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239163AbhCDBPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 20:15:17 -0500
Received: from mail-eopbgr00052.outbound.protection.outlook.com ([40.107.0.52]:32766
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1356278AbhCDBEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 20:04:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AGJoCjGTOOxu6b1xQzju//OpBbXz2Le9eLdeOXbl2N8=;
 b=hwDZv0Nmy3q6ziTENWxZNCehoF0r13HKHddJh+ITh4ljEVeXih+H5L4ONCJNeIJFmLecNdq2gM8tzTJ9TZl9cPt6VtflcI6ssfwz8GTgJxyyi+k1GTPuKNAyeOjBTgWOvD4a76/8ek1/8XTGdLjsqnsR+MR1YluPeYGsRLvK+aI=
Received: from AM5P194CA0003.EURP194.PROD.OUTLOOK.COM (2603:10a6:203:8f::13)
 by DBBPR08MB4726.eurprd08.prod.outlook.com (2603:10a6:10:f0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Thu, 4 Mar
 2021 00:47:07 +0000
Received: from AM5EUR03FT014.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:203:8f:cafe::99) by AM5P194CA0003.outlook.office365.com
 (2603:10a6:203:8f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Thu, 4 Mar 2021 00:47:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT014.mail.protection.outlook.com (10.152.16.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Thu, 4 Mar 2021 00:47:06 +0000
Received: ("Tessian outbound 7213b86582b6:v71"); Thu, 04 Mar 2021 00:47:05 +0000
X-CR-MTA-TID: 64aa7808
Received: from a758f48e1fe0.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id B797A172-12FB-4670-9493-A40F0B7C1176.1;
        Thu, 04 Mar 2021 00:47:00 +0000
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id a758f48e1fe0.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 04 Mar 2021 00:47:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P0jdXRFUAnRdffZ1KsVnPzQ7sFhjLD4vTDkc9e0CGbWaGZ2H+M+NOKSIbsu2lNPmxzWo7oeMYoLWK4n1XNkNWwC7q2A98MJZ7vdSYVoXJYH5gsMGmYYgz2cOUJZIiXnjr28/7S0oNuc68ZOaS3NesTwJSufFvHl1SVJS6wtYHjLFiZ0spoqugCEpFPa2W2M//wuEOZLS72vYbUbcnBLkV1jG5jbl/lZTsDfGcUrn2dt8LJmCLTyVQuCJ9xFXuhOrX4486lst+S5NC+xaUyRTvMWMmLVpAAWrYHl8NbTFwZZm4fd2PZGqFWWCtvNqbzg/dwqk8bssNEQ3IjXkLXh73A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AGJoCjGTOOxu6b1xQzju//OpBbXz2Le9eLdeOXbl2N8=;
 b=TTRBU6bigKBQXMVNTgaSZJ9i2Cy/D+XR3c3ks92l9feiDcfvUzyNa5lsgzGAQcbdqNNqLbmGTAN9e+NGPqfR11vzPPG48HE7rLSbNEsBn0kkbqJmrAgD0giabEvKEBYZKNpcCvX0kZcqdkQEW1t1HKYs15ITjPEGFOIqXYNON5h8w40lSxNC0lgielgH1k3sWgEJi6fwn+c1vimop5GeO8h4izxP2CQKA1UwiH8Fo9fcuDIOQur/Ab1xgQSF9pCgT973lZy1SwWZY2fNM0QW/0y83y8pqJW7wdYc4Fx+qLQX5kRjZkVzychYl+A9jPIPRYo/baN/ZOgY9HjqRxebyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AGJoCjGTOOxu6b1xQzju//OpBbXz2Le9eLdeOXbl2N8=;
 b=hwDZv0Nmy3q6ziTENWxZNCehoF0r13HKHddJh+ITh4ljEVeXih+H5L4ONCJNeIJFmLecNdq2gM8tzTJ9TZl9cPt6VtflcI6ssfwz8GTgJxyyi+k1GTPuKNAyeOjBTgWOvD4a76/8ek1/8XTGdLjsqnsR+MR1YluPeYGsRLvK+aI=
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AM6PR08MB3125.eurprd08.prod.outlook.com (2603:10a6:209:46::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.28; Thu, 4 Mar
 2021 00:46:56 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::5192:4597:8d30:5800]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::5192:4597:8d30:5800%4]) with mapi id 15.20.3912.019; Thu, 4 Mar 2021
 00:46:56 +0000
From:   Justin He <Justin.He@arm.com>
To:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>
CC:     "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        James Morse <James.Morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki Poulose <Suzuki.Poulose@arm.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Gavin Shan <gshan@redhat.com>,
        Yanan Wang <wangyanan55@huawei.com>,
        Quentin Perret <qperret@google.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] KVM: arm64: Fix unaligned addr case in mmu walking
Thread-Topic: [PATCH] KVM: arm64: Fix unaligned addr case in mmu walking
Thread-Index: AQHXD9bsiwf2wq23AEqHAHP4tBiTG6pyIUoAgAB/+oCAACMoAIAAOX+g
Date:   Thu, 4 Mar 2021 00:46:55 +0000
Message-ID: <AM6PR08MB437695640C272E4F065A8B2DF7979@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <20210303024225.2591-1-justin.he@arm.com>
 <20210303112934.GA18452@willie-the-truck> <87mtvkys1y.wl-maz@kernel.org>
 <20210303211325.GA20055@willie-the-truck>
In-Reply-To: <20210303211325.GA20055@willie-the-truck>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: FE3E02CC55BB23418F7C08C9B85A2460.0
x-checkrecipientchecked: true
Authentication-Results-Original: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
x-originating-ip: [203.126.0.113]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b9e95445-c125-4d4e-aaba-08d8dea708ee
x-ms-traffictypediagnostic: AM6PR08MB3125:|DBBPR08MB4726:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DBBPR08MB47266B03EEDB20D0C4A92870F7979@DBBPR08MB4726.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:5516;OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: mnCIKnB9Nq1f6TH9EcFq3CiqGkxPjAvRQtoRzCs6pC8cEHZpCWyKt7pl/p7JyMZWucKVf0xwD2H3WMPMSyVWdveqDCCtvL7Ocp4DCz4yENIfc/CezIa0a/U1XoPiIGLnGy/Byr4lm7Md2FZPt2lzObMAw+zTEXspbgRl8nhMsw+9BxL8pWOa49nN7TE4UQlyJ2JKvcdpbZxsv76q4XlnFvO7yVxYNy2QEdTtRw9+QwT1jDw8g+J5bqSx74PJZOy/5OtyZgemd0/ZJGI28zlH5l+AOGIovNsUcszNscrGToSYSJmfmjzcEDqpLRt7o0HdcUqwK05SbzoVElFu5XRPHcw4Ba0wSOylkL9xZ5HSUif9Cga4MmufOCqVx04m4KdtHtBiqZQ80RySi693n0MeOQXq65HSkxDefz02tJkXSZrxaeKXyO6TLXTEvwvaxjHbTYYA25/gpas2CJV1eybvs8VqDcVxT7/bpEHcYBW3LjwP3MC7W3ZAZ9waxIEMIrAv7l26IEhJCDGL1sZzYsAKcRQJS/WUFpQMraZS4hjhm5dEz5u6NhTdmbSuYP5C6skNbk+PZEVCRjOnSi3dqgM3oArn/us9F0e5tdfSyNk2lj4=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(376002)(396003)(346002)(478600001)(66946007)(52536014)(66556008)(66476007)(9686003)(7696005)(316002)(64756008)(66446008)(55016002)(71200400001)(86362001)(110136005)(54906003)(2906002)(26005)(186003)(6506007)(8676002)(4326008)(8936002)(53546011)(966005)(76116006)(83380400001)(33656002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?U7o1ry6mhSVqhvTEHlWOcHCSTwxlw1imYXdSI55u5ULlMpACu3UBUF4xt4G2?=
 =?us-ascii?Q?N9KwgkvweOYJ+bsCBF8L4CoIlitnJSl6g5cv9WSSyV/ko19/wCXadd7+tQtR?=
 =?us-ascii?Q?xLbNQwaC3GvnlWXWBQ2O956eLqOC4CNwtE4k+wHpt7kRR2M2yC7Ee9XP5DHL?=
 =?us-ascii?Q?Om3Qi2HDGo/75HQCx/AePHHSoKvhkE8LkHJo7ye/TZ4r8AmcLra6feV0qzOe?=
 =?us-ascii?Q?qGkgN5GK9ayoiHMg44j78VeES3DmOPR9uJ6JSX4uRPN10N8SlhDf107Hww6o?=
 =?us-ascii?Q?AWZpltR2OOprcinyLgVSNNqdNQdljfXY3uK2hnjOwISJFqe9KRdyF+8p9wO0?=
 =?us-ascii?Q?DCqUGN0BgYTP+tK63kCAXjJJiVoluNmrlBXzdflQHon4ObPs2nbt9PBXdH8e?=
 =?us-ascii?Q?F9gM8iG2sfPr7s33lG+vVRxIaQ241YtpA+BfO8jQtf2BSM/jeAlib6k1Y3j6?=
 =?us-ascii?Q?HAT1LyHJuFdicZj8rFUhPq3vJYJ2l7TXnAIdIw3MuNwZPo620d6iXXmf0/y+?=
 =?us-ascii?Q?hNPQD2CqWzzywkAEMS/hWHOt4RWTAUhVI60KOp0a0RUclADf1/OL+90qDZYD?=
 =?us-ascii?Q?fy6k0uakTPK3WOiPOhICvATimj8SV4T8+BSFXGRgWGTxwg+hoDTnRT43unrf?=
 =?us-ascii?Q?lfGMvo1tGD7ST1HxadPri/zYqbcDB2agreciWUXR1dEt19wjdpCJ03EKYVdT?=
 =?us-ascii?Q?lrZyb9HXCBfBQkBxi8STfOlNc5qW5EWglWbwLOJKDDK6AsD9DTvL2XF8iyI9?=
 =?us-ascii?Q?glyZturBjLJaLbrftKIVR4OV4u+uHnFOxgkjtWxkyH2xvfdTUOYBR1whUxJX?=
 =?us-ascii?Q?dFgUzlcfmQItEPKUZOzB4WmzykjsTrVFh9udmLECR7QOh07IxvUpWhsd2yu8?=
 =?us-ascii?Q?J/lLSnUF3s5GZdLi/521rxkmF5OjOBUKRYwjfXnvVf4TLdUSNCZkf1rl4hAF?=
 =?us-ascii?Q?EkQtjgiksZ/honwcgDJhNNQW6zru9u7TNRNGktjlqvPNjdyYifbg1616l6Vm?=
 =?us-ascii?Q?Tk0VN9L7vcExxS78F/cz840lETKBaTS3Jp/OFeqlFUufZxke/4hxfC9c7ZyA?=
 =?us-ascii?Q?gcAq6J6EaKYaM8A+arZ8k9qEQETQ80s5DIXbGYaqC3i4mY7pH1jdLdQNcwsd?=
 =?us-ascii?Q?/7nOv9OA9prAbgP9z2iS0j5DfcYV1bu1FAU7ZF0/r2/sWPtLGTzdQWg3jYQk?=
 =?us-ascii?Q?/fFB77lj8zfm1ZLvJStWOoxrb/4HgSCwTwHCl1y4dnK6BwpGTlhhSC4ImrOq?=
 =?us-ascii?Q?nO9wq3KJvBqMJhaZ8d2NSVFBjCB4NiHntzcEoITlnFPFRcSaoJnESTrYmS4O?=
 =?us-ascii?Q?P3L3pzAu9Qr8cEqEb1dcyLXh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3125
Original-Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT014.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: ddf736f2-302e-46fc-69df-08d8dea70324
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TMfcROMWw+l8EjWK8/+tmmYynWBOGT9KO2HfNmR/KjiIRby/054Nffop4HXIwkN+2zzUjAtTulnWkcjAfxCU1I5IWaXXyCv7zCxGNlU8Mwmltlr5hlQb5qSy3Oeibhdq1CNEk9qQdSol/NBJAoZjTyBMubTIeUIF0r2CcRPSHC0epCfaJY8bMgsYgIYWbUIOgRIKk8abB0IOQfwownnl/YiNrNXCTyHDBymTxNGPF8yv/tJGqIHhq8jZyyGBI/lCJ3eEfGGEIxXRzP5/Ye/hxpMIRHx4NRjqKJUNR+0z905Ormi4KFhUzf3CmtTGoEzkIKsxa3IxvOyMRTcsnO0mVf8eXCwJk9cufdCCoD3v65ZIWpQBKioM4OtYkhJcLeP4BSPg5y/K1RrEGllFQxca+/kxkAGH6JYGGUFkG/YHRe1gpOOjTU1PYMNkOKsVOi8TPSz43mS9TG92G0XFD4Qq1gWCESsCOkwa30W7XqlgH+zfPIO44HB7S46Y2Euiv3wrsO7EmwLSzz5r5WFVRygV3EeD39C7TVBCyXr/iqEgyy0IaEq8EX4z3s/Qi29BmyOCFnk18n4EsPyNRVWHxYHlx7eUVgn0QwCc7V0OTpeVV21cJJPlRuKDf5QSTSjR5QLGZoLr6zCXjvz7Vc5D5oeivvNL3Lu+FCr4DJ4rnK0figNePI5mtw6wGQ1DTywbQultB/uWhDknbF6/iBSxOX6RyQGSesOnmQBxnzuQ1K8kwPc=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(136003)(346002)(36840700001)(46966006)(70586007)(36860700001)(4326008)(8936002)(26005)(70206006)(336012)(966005)(53546011)(54906003)(110136005)(7696005)(8676002)(33656002)(478600001)(316002)(6506007)(81166007)(356005)(55016002)(82740400003)(2906002)(5660300002)(52536014)(82310400003)(47076005)(186003)(86362001)(9686003)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2021 00:47:06.3129
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9e95445-c125-4d4e-aaba-08d8dea708ee
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT014.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4726
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc

> -----Original Message-----
> From: Will Deacon <will@kernel.org>
> Sent: Thursday, March 4, 2021 5:13 AM
> To: Marc Zyngier <maz@kernel.org>
> Cc: Justin He <Justin.He@arm.com>; kvmarm@lists.cs.columbia.edu; James
> Morse <James.Morse@arm.com>; Julien Thierry <julien.thierry.kdev@gmail.co=
m>;
> Suzuki Poulose <Suzuki.Poulose@arm.com>; Catalin Marinas
> <Catalin.Marinas@arm.com>; Gavin Shan <gshan@redhat.com>; Yanan Wang
> <wangyanan55@huawei.com>; Quentin Perret <qperret@google.com>; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] KVM: arm64: Fix unaligned addr case in mmu walking
>=20
> On Wed, Mar 03, 2021 at 07:07:37PM +0000, Marc Zyngier wrote:
> > From e0524b41a71e0f17d6dc8f197e421e677d584e72 Mon Sep 17 00:00:00 2001
> > From: Jia He <justin.he@arm.com>
> > Date: Wed, 3 Mar 2021 10:42:25 +0800
> > Subject: [PATCH] KVM: arm64: Fix range alignment when walking page tabl=
es
> >
> > When walking the page tables at a given level, and if the start
> > address for the range isn't aligned for that level, we propagate
> > the misalignment on each iteration at that level.
> >
> > This results in the walker ignoring a number of entries (depending
> > on the original misalignment) on each subsequent iteration.
> >
> > Properly aligning the address at the before the next iteration
>=20
> "at the before the next" ???
>=20
> > addresses the issue.
> >
> > Cc: stable@vger.kernel.org
> > Reported-by: Howard Zhang <Howard.Zhang@arm.com>
> > Signed-off-by: Jia He <justin.he@arm.com>
> > Fixes: b1e57de62cfb ("KVM: arm64: Add stand-alone page-table walker
> infrastructure")
> > [maz: rewrite commit message]
> > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > Link: https://lore.kernel.org/r/20210303024225.2591-1-justin.he@arm.com
> > ---
> >  arch/arm64/kvm/hyp/pgtable.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.=
c
> > index 4d177ce1d536..124cd2f93020 100644
> > --- a/arch/arm64/kvm/hyp/pgtable.c
> > +++ b/arch/arm64/kvm/hyp/pgtable.c
> > @@ -223,7 +223,7 @@ static inline int __kvm_pgtable_visit(struct
> kvm_pgtable_walk_data *data,
> >  		goto out;
> >
> >  	if (!table) {
> > -		data->addr +=3D kvm_granule_size(level);
> > +		data->addr =3D ALIGN(data->addr, kvm_granule_size(level));

What if previous data->addr is already aligned with kvm_granule_size(level)=
?
Hence a deadloop? Am I missing anything else?

--
Cheers,
Justin (Jia He)

> >  		goto out;
> >  	}
>=20
> If Jia is happy with it, please feel free to add:
>=20
> Acked-by: Will Deacon <will@kernel.org>
>=20
> Will
