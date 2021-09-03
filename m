Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D70CB3FFCEC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 11:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348747AbhICJUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 05:20:18 -0400
Received: from mail-am6eur05on2068.outbound.protection.outlook.com ([40.107.22.68]:51297
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348667AbhICJUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 05:20:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5F5yrhjrdcsIYa9Iga5g9uAAX3aHCsf3AZTameCORmw=;
 b=ciUjakbuDBbbloQtYP5+99pxVVukURcAjdKMCy+3JpvHVcK4Xb9WOnSjB7n+WNv9OkiREiNEh/LlFIy17dX5/viDZ8gujgJLlQBRg0fGX1jh7f40Ft6pFKq13ERClNrJ2iPhUOuyQgnIbk1bFOlEQYd3FrDzpRgeBU9DLHQPQT8=
Received: from AM0PR08CA0031.eurprd08.prod.outlook.com (2603:10a6:208:d2::44)
 by DBBPR08MB4234.eurprd08.prod.outlook.com (2603:10a6:10:c1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Fri, 3 Sep
 2021 09:19:15 +0000
Received: from VE1EUR03FT033.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:208:d2:cafe::b7) by AM0PR08CA0031.outlook.office365.com
 (2603:10a6:208:d2::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend
 Transport; Fri, 3 Sep 2021 09:19:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT033.mail.protection.outlook.com (10.152.18.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.19 via Frontend Transport; Fri, 3 Sep 2021 09:19:14 +0000
Received: ("Tessian outbound 56612e04f172:v103"); Fri, 03 Sep 2021 09:19:14 +0000
X-CR-MTA-TID: 64aa7808
Received: from af2d9f4ec51f.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id FD5D80FD-B9BE-48ED-B195-4525B2FE05BF.1;
        Fri, 03 Sep 2021 09:19:08 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id af2d9f4ec51f.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 03 Sep 2021 09:19:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=njI7RA45v6B9kP7AnNGKjlCT5zA4rTA2NNMWrqCsLcdWoBz8f7Wg4VWrCqRh1Dc+5uO19OKYD8DkUFj8vKeby2aqbvK8kjCbXyqENKTAPsd1ccPlIU0iB1mZbTVtlnlmSDZrxl9Y7EQWtoq68q1gXhwv46IABViAb57MYMo+9LVH7L8a81J3qEI1El6P6UD/mcYH6ITymr/W8xLBbJJrDqrga7h6ykb6xE1EXCgJEei5KeE0KRnO0L3w6DeP+eN5gsTTu5fbKUBFyfN+eUC3UbxRXJt3wGDjt3X0MLAjZBjnAFoy/EFX+QTizsXclr002OkzMN/vG3gFj+prjCbXTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=5F5yrhjrdcsIYa9Iga5g9uAAX3aHCsf3AZTameCORmw=;
 b=kGH7tQvFF0fkItjMZpARqTN/f3G1RsqHyk1cSdzqWMKBmas8vUHsFM14U9/jo2iEul0ZQmL3Wmhl4cQY9dEAA7S+9zAcrxj9jEPQDY9TzHzMslQQxjmeB4rYO46HLznBS9ZHN3fTh3TNHjjt+0hTnsJ6IEm/sjvNzzMPylAjB93Q50SefkFjAuQGhhem9jrbNB0k2ngP6rdYJTQgPqteeYUG4BgGrVfNTS+btIG4izqLeAaYaBHAh4jW7ML+JXgSUkKBOFVFTJI6hgunn6gxi10Q3O3K4kzxux84S0Z0IgLiaM56ln2Ej6OT+BoD7o4488R2usz+fxe8GmV27Tu6FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5F5yrhjrdcsIYa9Iga5g9uAAX3aHCsf3AZTameCORmw=;
 b=ciUjakbuDBbbloQtYP5+99pxVVukURcAjdKMCy+3JpvHVcK4Xb9WOnSjB7n+WNv9OkiREiNEh/LlFIy17dX5/viDZ8gujgJLlQBRg0fGX1jh7f40Ft6pFKq13ERClNrJ2iPhUOuyQgnIbk1bFOlEQYd3FrDzpRgeBU9DLHQPQT8=
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AM7PR08MB5477.eurprd08.prod.outlook.com (2603:10a6:20b:10f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Fri, 3 Sep
 2021 09:18:55 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::a443:3fd9:42c2:4b85]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::a443:3fd9:42c2:4b85%5]) with mapi id 15.20.4478.021; Fri, 3 Sep 2021
 09:18:55 +0000
From:   Justin He <Justin.He@arm.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     James Morse <James.Morse@arm.com>,
        Alexandru Elisei <Alexandru.Elisei@arm.com>,
        Suzuki Poulose <Suzuki.Poulose@arm.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Liu Shixin <liushixin2@huawei.com>,
        Eric Auger <eric.auger@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Shenming Lu <lushenming@huawei.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] KVM: arm64: vgic: Add memcg accounting to vgic
 allocations
Thread-Topic: [PATCH 1/2] KVM: arm64: vgic: Add memcg accounting to vgic
 allocations
Thread-Index: AQHXn5F7FYSWF48R9Ey6xBuf+xK+E6uRCosAgAD/d4A=
Date:   Fri, 3 Sep 2021 09:18:55 +0000
Message-ID: <AM6PR08MB4376BC9B6EF50A1B17A4E106F7CF9@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <20210902002801.32618-1-justin.he@arm.com>
 <877dfyx3bf.wl-maz@kernel.org>
In-Reply-To: <877dfyx3bf.wl-maz@kernel.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 7BC161EBBC1FF8418BB6D3C1777279FF.0
x-checkrecipientchecked: true
Authentication-Results-Original: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: c949dfe1-4678-4694-7061-08d96ebbe619
x-ms-traffictypediagnostic: AM7PR08MB5477:|DBBPR08MB4234:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DBBPR08MB42342BCA453191C7A1753094F7CF9@DBBPR08MB4234.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:4502;OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 9zSovdHcNr88cgNS2JmfwQy0D0/C8B8AeEVfO336DZgwfs9BmIaBYIKDcDD/fvRR9uUswC3IBC+8VPMok2T8haxXr+cV7fAceLU/txH5+SQD/k+tGfVqrfIoZLX5v4KLS4RlA3tgCMwt/Mf5JhAaDpnN+nuSJBgqXhf0eIRyW+bBWKOT9Evso0Pthkp0hEY+gDRItc4Qy+3gJ0WV9Mk9fH9OrA9H3MgFFAvOq3qOZOaW9vBqnOX2ucIgJJ3au2dP7S/LlFJI3CHl+gRH4teiKTzXDf3lKNM9g0dQNW6Pg1gpgsz1O8NVdlSFtrG31WvbWO2q+0IZAlq5sN9IvugWiVB00OUtqVqR3izztZUbHM1XPqMZAby/0Uh2bq8CQWjY7zmGqEUe8ggfimrSQITkDAD2JxIzaWcRIDSVYej2feUziZEtmV9KX/0q6U/YYstgY6+WzAXC5wzVEcvMKPoGIuB9RW2qpw6zj2MugDxulSI5/nJyVG3iW5+FROQF3Lks7CSSSuD66rVt404z40aTSjdZEKLHTz1AOhj6GQcm0BW3tsTl26ZY/VS24cWEcBh2BSXsYW62/0dTsNAdntfgHGsxKT1w1eJUmgtTrM/v/EJ5OOAzVmFqAET/CSBJg19VSq3ijl9aBPrGK0JGwEavh2Vy0TQnsPNFuUz3LjsAN2KajsXDot2wwVGIhN/O+v6vEb9nE3KVmdFi/cr/CA/oPA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(39850400004)(376002)(346002)(26005)(66446008)(186003)(4326008)(64756008)(15650500001)(66556008)(7416002)(86362001)(76116006)(478600001)(38070700005)(8936002)(122000001)(66946007)(8676002)(71200400001)(66476007)(38100700002)(5660300002)(53546011)(7696005)(52536014)(6916009)(6506007)(9686003)(2906002)(83380400001)(33656002)(54906003)(55016002)(316002);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5477
Original-Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT033.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 5012f825-7aee-4f4e-8235-08d96ebbdade
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hr8aAdTAysLJ3iauunT0ryyHeil0hwTVCJoN4X0n09hW5AhsD8/AYER7ZqJthMH5lCodeaEBSDKaPuZWrGwc2E9SiUZcnzl7mXa1DNPI0RQqdiFhIwamHDX1vkfZ801d6oqtG9dR4kzks/YI5HNiCOnq5GtZMueOoBHoB6PggkGdDHJkHHs7qIJB7ynIrJG8ZHt6+udBD7k64DbpS4GV8IXzFOje0+dGKXdL2KtCjCIcMuUWAJu9kqfWzjvqGREbh76hO8hr981HX9pmV+w76IptTs0VAun5AVUHcAkRQMUvoDTqsJPlqpGWbva935saylLOVLjYon2ZWvqr17S6k5Oxs2QQXvhDOf6n1ye4jaCw77fkYZUWTTL/xZhSgXYnBCowEMsSklv8kMJ2Oe80ir2tYg5NWw8GOc0qhwpKYAslzvF/eZnpZ20UxZF+elNFsbhC5+ziiFX18Je3iS7qqRWcjMpsix50d5YCZqT5oIsUOUamvl7ZI/bntDd4TjzrIvRq4D51MCfhmzjc5UaYo18bF1v4Vm3M9ZAyJvgo4X/S645S//AV2YKX4Hh86FLuoaFaUw+YhyBWW+g5woyQ9curQ1Xrz3QrSFrSDNDwPTER/OF3nd39Ot/7nVLrE8r1TTIqVLJzYjFfYd/rR0jAL1BTbDAF1+iLzcdh6DaCEn1w0kk4wLmSY8y/p00+i4vdQgMzpvs0FnsgZdKzEMjoBQ==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(186003)(53546011)(356005)(508600001)(26005)(55016002)(6506007)(70586007)(2906002)(86362001)(9686003)(54906003)(82310400003)(81166007)(336012)(36860700001)(7696005)(47076005)(6862004)(52536014)(8936002)(83380400001)(8676002)(316002)(33656002)(5660300002)(15650500001)(70206006)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2021 09:19:14.6553
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c949dfe1-4678-4694-7061-08d96ebbe619
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT033.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4234
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc

> -----Original Message-----
> From: Marc Zyngier <maz@kernel.org>
> Sent: Friday, September 3, 2021 2:04 AM
> To: Justin He <Justin.He@arm.com>
> Cc: James Morse <James.Morse@arm.com>; Alexandru Elisei
> <Alexandru.Elisei@arm.com>; Suzuki Poulose <Suzuki.Poulose@arm.com>;
> Catalin Marinas <Catalin.Marinas@arm.com>; Will Deacon <will@kernel.org>;
> Liu Shixin <liushixin2@huawei.com>; Eric Auger <eric.auger@redhat.com>;
> Kees Cook <keescook@chromium.org>; Nick Desaulniers
> <ndesaulniers@google.com>; Shenming Lu <lushenming@huawei.com>; Sami
> Tolvanen <samitolvanen@google.com>; Lorenzo Pieralisi
> <Lorenzo.Pieralisi@arm.com>; Xiaoming Ni <nixiaoming@huawei.com>; Zenghui
> Yu <yuzenghui@huawei.com>; linux-arm-kernel@lists.infradead.org;
> kvmarm@lists.cs.columbia.edu; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 1/2] KVM: arm64: vgic: Add memcg accounting to vgic
> allocations
>=20
> Jia,
>=20
> Once again: please add a cover letter when you have a patch
> series. It isn't rocket science, and Git will do it for you.
>=20

Okay
> On Thu, 02 Sep 2021 01:28:00 +0100,
> Jia He <justin.he@arm.com> wrote:
> >
> > Inspired by commit 254272ce6505 ("kvm: x86: Add memcg accounting to KVM
> > allocations"), it would be better to make arm64 vgic consistent with
> > common kvm codes.
> >
> > The memory allocations of VM scope should be charged into VM process
> > cgroup, hence change GFP_KERNEL to GFP_KERNEL_ACCOUNT.
> >
> > There remained a case in vgic_set_kvm_info() since this allocation is
> > global, not in VM scope.
> >
> > Signed-off-by: Jia He <justin.he@arm.com>
> > ---
> >  arch/arm64/kvm/vgic/vgic-debug.c   |  2 +-
> >  arch/arm64/kvm/vgic/vgic-init.c    |  2 +-
> >  arch/arm64/kvm/vgic/vgic-irqfd.c   |  2 +-
> >  arch/arm64/kvm/vgic/vgic-its.c     | 14 +++++++-------
> >  arch/arm64/kvm/vgic/vgic-mmio-v3.c |  2 +-
> >  arch/arm64/kvm/vgic/vgic-v4.c      |  2 +-
> >  6 files changed, 12 insertions(+), 12 deletions(-)
> >
> > diff --git a/arch/arm64/kvm/vgic/vgic-debug.c b/arch/arm64/kvm/vgic/vgi=
c-
> debug.c
> > index f38c40a76251..e6a01f210df9 100644
> > --- a/arch/arm64/kvm/vgic/vgic-debug.c
> > +++ b/arch/arm64/kvm/vgic/vgic-debug.c
> > @@ -92,7 +92,7 @@ static void *vgic_debug_start(struct seq_file *s,
> loff_t *pos)
> >  		goto out;
> >  	}
> >
> > -	iter =3D kmalloc(sizeof(*iter), GFP_KERNEL);
> > +	iter =3D kmalloc(sizeof(*iter), GFP_KERNEL_ACCOUNT);
>=20
> This really isn't an allocation made in the context of a VM. I don't
> think this hunk belongs here.

Yes, indeed


--
Cheers,
Justin (Jia He)


