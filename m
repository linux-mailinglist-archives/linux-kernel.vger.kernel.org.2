Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55FCD35A875
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 23:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234840AbhDIVpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 17:45:46 -0400
Received: from mail-co1nam11on2135.outbound.protection.outlook.com ([40.107.220.135]:9954
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234079AbhDIVpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 17:45:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RoV0AdKfnZbqOXZgbtIfGgX2XFIgi6C3ZyoVN4P7IfHoYR+xftFhyaOzSWgBzX+sc5FY1EcE4UiIjpPJnyalsiHXmRuQyAHE+8Ye3dN2tSMdSyEtGKgnuMbwuDgkNKkSzo2yByoDmzw9OZLiwQ1kf5Q/MYtCS5W5Hpx/vfVLk3nksqP5Hbv/7pCtKs3OHFDMIu4LvY/UxR3fcS0W89NGAidVDgWiNxlwi/nKfnZZYClI2JkwbxOlBrhoUMqQaGOgeGIaCj3Yi6R+xBJlVKwuqlqncC/ackewOMDzSy2Xvy5gF7xGptTwnG6T+Q/aYVDGytsGnj3NH1g4uaBytRhYOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RzPzg7IBafT1PUFoSiPwCWOB6PmL7FVwpxurR8Qsts=;
 b=Y8htwpr0HnmQHy7/0C0BA6BAXMkLabw2K6gTXLxtm6RF8yVoc89U4tw3V69K1sg8p/SnAsTD4oaCdZblKUJXE4plvd6j7sPN43n6OutSqJP1+YeY0vrS4dUD+fjnthLb2U5uIXyKqAHBCti8nWVR9ykGrOOfzrtXqx5CjQZNgUt4dWgK5HQGTDR2lwKffjethFobcapIQdNYZqNcaegdWwgC21CesHyJ+2FDeyMXyWXCNj95IT0F7u3J183vJ+i8wFEi6GyNPNDcJIf2NmitEu0VKXUZtUPqcgdmZAYUhgfQhwKdJxWJlYzn8WmfJ17oi/OoLb8g9X5Tb1rCV//k5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chelsio.com; dmarc=pass action=none header.from=chelsio.com;
 dkim=pass header.d=chelsio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chelsious.onmicrosoft.com; s=selector2-chelsious-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RzPzg7IBafT1PUFoSiPwCWOB6PmL7FVwpxurR8Qsts=;
 b=HWAWzJATW7gkyPeBLIB0fQsqJt2QWcRsSlmGcaHF7GweuIoDPtwRbcFMzmhXkmz0CIKosJEj5DhtzGCEKyytodMhWLX2dpNgFfFMntaV7WG2Ipe9xpRiakKRbO4Zrcg/ABQJdWfly9dMKhwhGrYRgWcRzPksJjNZHn4oUDwxhio=
Received: from MW3PR12MB4475.namprd12.prod.outlook.com (2603:10b6:303:55::24)
 by MW3PR12MB4457.namprd12.prod.outlook.com (2603:10b6:303:2e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Fri, 9 Apr
 2021 21:45:29 +0000
Received: from MW3PR12MB4475.namprd12.prod.outlook.com
 ([fe80::f1fd:22ed:7fb5:983d]) by MW3PR12MB4475.namprd12.prod.outlook.com
 ([fe80::f1fd:22ed:7fb5:983d%9]) with mapi id 15.20.3977.033; Fri, 9 Apr 2021
 21:45:29 +0000
From:   "Raju  Rangoju" <rajur@chelsio.com>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ramaraju Yelavarthy <ramaraju@chelsio.com>,
        "Raju Rangoju" <rajur@chelsio.com>,
        Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Subject: pull request: linux-firmware: update cxgb4 firmware to 1.25.4.0
Thread-Topic: pull request: linux-firmware: update cxgb4 firmware to 1.25.4.0
Thread-Index: AdctiTaQbV9CxbfgTXySIUiT7axwyA==
Date:   Fri, 9 Apr 2021 21:45:29 +0000
Message-ID: <MW3PR12MB44753AF63DA77A737AE8781ABC739@MW3PR12MB4475.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=chelsio.com;
x-originating-ip: [175.101.22.122]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 670f32e8-35d0-4c3e-9dd9-08d8fba0cb43
x-ms-traffictypediagnostic: MW3PR12MB4457:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR12MB445723E06DD7E86A41AF79BEBC739@MW3PR12MB4457.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MzNJkE0nLBCCu0Ry7hbrq/TcCviZs/Gq5Y4/iWistr8j84T2w5qJAyb/BVc6HhSWEqndYE4ShGI/1+RYJaiJNs0BNMv4IU1FjsA0ZB4p3X0VPrj97GJ6CTkMpR1RbHkLjbq1MEGkW1/aAl7vo2IvolZL9q27BeVGIu8iKbh4xewqYqOfNk9remWZnvYBVsYgpFz44Ey+LWAEBpK6hICgrD3AND+bzjpjmsdIRvf/Ent9r6oD/cjeyfzPUmG/1MD33PfIiHAw6JaU7cinMM4F2UDZ5nD38TGqoabm9heB2YsqfzQkG9pjsRjQlr4bzoaW6L4NDEYCOdbae+xl6WvhPvFde6gkwREs2M31ZJCAfrMVVTMPKqViyM/Vba3LS49rJrJr7gfqeXnQDjAbExqjAGPmHThzDboEyWxDtgMi7PeQJS4F9CggsOosdicBh83E+7EJNaLGjWyM0BPJe9Z0h19E8nEGsbjI93iNJcFAU1Vk42W9V5BTC3itkOsgludjHd/B/AGuO8KThSUSk0RlgNl48nMMTqnkP4Ex/xTFpCs4eHQ/FNn2sYvoEnYU61yHtHEfdZ8ed3dVSGBFUCBe/UJ62hFd6aRT34YVeISCn+2yryMEn4DpSKaA3Vz7dgPJ8VRFYOybJG5EkDuogHoK5BxeCJR6m602q/E+qvy5meA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4475.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(396003)(136003)(366004)(376002)(346002)(316002)(107886003)(4326008)(83380400001)(66446008)(66556008)(33656002)(186003)(64756008)(66476007)(52536014)(66946007)(9686003)(2906002)(26005)(76116006)(86362001)(5660300002)(38100700001)(478600001)(71200400001)(6916009)(8936002)(55016002)(6506007)(8676002)(54906003)(7696005)(15650500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?qgd5QA9eybO3nTy7ZQDnoGpcBAoBxAXpRgoV1vZM7AQNl7RV/5uk7Eop0pkT?=
 =?us-ascii?Q?iuTqVY45U8jEEDIZes0pKGLhtWByFD4FlLDKzVineURi4n2r8qn+/dJ/UC85?=
 =?us-ascii?Q?wCZ+BEVzo2wZJBVrAK3y8bpZOLAta9AZjLKmGtpOZvm1Gvet3FvmT53zLQQ9?=
 =?us-ascii?Q?o/2Nr8jCqkDS0ZPZ+7UvUKYOC4vfscNfghnpLNzIoQQxPtph4GrNrEBeCyVA?=
 =?us-ascii?Q?IQxosfZwHfBdzIsJmed6ZuJTnuISUQFVKTCnMimZfIsK9v5co8lal3om7owr?=
 =?us-ascii?Q?40kKmx+94X5ELCzAAfYUCiM+1qqXogvwHa2kAmuYXgH4bc9wrHEjkn2w1J1z?=
 =?us-ascii?Q?LTq1lgt1SviAf3+CVyPm/YCJvP6qIVW/S6W6E4WUy08z5+Z65B3n8ihlz+wy?=
 =?us-ascii?Q?hHDlOA/xQK9U5k9bEEVzSHzHPSA+Y7mFZXmU/fyKgwCdklpgXhakfbvGq/wu?=
 =?us-ascii?Q?E3ahnWNsRWmH8pMIzL5RQ6FFHYN4Eamz3vixd0qdVyPios23/53eZhiperoZ?=
 =?us-ascii?Q?nf70k0ysgSGzCvVhjEPYFeUZPv6YXRcF08StwpuURRx3h92QhCAONwxtjoUz?=
 =?us-ascii?Q?9VkJiRG8qBQ0oLy4BbUJv2XduNHsNBlAD9cYWu9QsRx8VPwD0XD4Nk5dfTju?=
 =?us-ascii?Q?v2f6hEfh8cOOibCqFVt3HihbClqA0A7ibPQ+TGVNTDtlsChTGazHZqALMN26?=
 =?us-ascii?Q?lRDUKf2V/ktt6ULa6JY0ZXJmHAV4p9+NfDw44oK+FxrtIKSVVGWYw/MfL2ad?=
 =?us-ascii?Q?qPYP9njs+zkIPEol73+xCyUyn7kePpgJhTYLIgP4gVX3Uuu5TBMuaHyiDwbr?=
 =?us-ascii?Q?rh4XK2upKdEuvZjq+PBuwfYsJ4W2Ea3jS+8IRA5nVNn6YwhLz6Zm+qMrjqTF?=
 =?us-ascii?Q?Esd6QZMWr89GgYAc6tJWMMpIYo15750w0/DFhOyEvtkzo7zM+zHzCJ/1jEns?=
 =?us-ascii?Q?nuKmypn32s4aBNjSr/kk7XFNK2ygX28nNci/+XP/LNhIDjnym6+IRT8afOIt?=
 =?us-ascii?Q?mkfO68ZHbYr8eSGQbdRRO2Z88mrU18LwD3GXu87UCCfsdhZcFtp9LajG6Hxj?=
 =?us-ascii?Q?qnjdp3PTqXFjzp5T+S2W3EF7Q2F+fKaDgzh3GPmwVrc3zg+racf9pSY6KSxY?=
 =?us-ascii?Q?l6GEnzPhzaZZDES6iCi08VNRhL3q4LFaPtrR5WqiUlH2lmR/r/X0jrMXujCU?=
 =?us-ascii?Q?piToxQEJMKbgjsDyvtEV1erffIZBipl6KeuTTCtDA3Gkt02S7u0EVxSMrs6M?=
 =?us-ascii?Q?O1tY4DLjQlJlMjA0SUfOw+0dlJRZNzqB/aocLeliHAmTzAurPB+S57DBdIyt?=
 =?us-ascii?Q?zmK8A9oeIErQWp44J5R10WdA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: chelsio.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4475.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 670f32e8-35d0-4c3e-9dd9-08d8fba0cb43
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2021 21:45:29.5843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 065db76d-a7ae-4c60-b78a-501e8fc17095
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FzAfgqB+1CG1NOAhDO/DB68BUOwFp313JLx+5FYIOqMgr4F134pXFyhA+R/VUK2GM+aq9Xs9TTenA1/QQ+L0RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4457
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Can you please pull the new firmware from the following URL?
git://git.chelsio.net/pub/git/linux-firmware.git for-upstream

The following changes since commit af1ca28f03287b0c60682ab37cc684c773de853f=
:

  amdgpu: add arcturus firmware (2021-04-05 10:40:08 -0400)

are available in the git repository at:

  git://git.chelsio.net/pub/git/linux-firmware.git for-upstream

for you to fetch changes up to 7daedba9b02bfbb47da89c4dae6f20c91a5e5402:

  cxgb4: Update firmware to revision 1.25.4.0 (2021-04-09 07:45:27 -0700)

----------------------------------------------------------------
Raju Rangoju (1):
      cxgb4: Update firmware to revision 1.25.4.0

 WHENCE                              |   6 +++---
 cxgb4/configs/t6-config-default.txt |   8 ++++++--
 cxgb4/t4fw-1.24.17.0.bin            | Bin 568832 -> 0 bytes
 cxgb4/t4fw-1.25.4.0.bin             | Bin 0 -> 569856 bytes
 cxgb4/t5fw-1.24.17.0.bin            | Bin 672768 -> 0 bytes
 cxgb4/t5fw-1.25.4.0.bin             | Bin 0 -> 675328 bytes
 cxgb4/t6fw-1.24.17.0.bin            | Bin 727040 -> 0 bytes
 cxgb4/t6fw-1.25.4.0.bin             | Bin 0 -> 728064 bytes
 8 files changed, 9 insertions(+), 5 deletions(-)
 delete mode 100644 cxgb4/t4fw-1.24.17.0.bin
 create mode 100644 cxgb4/t4fw-1.25.4.0.bin
 delete mode 100644 cxgb4/t5fw-1.24.17.0.bin
 create mode 100644 cxgb4/t5fw-1.25.4.0.bin
 delete mode 100644 cxgb4/t6fw-1.24.17.0.bin
 create mode 100644 cxgb4/t6fw-1.25.4.0.bin=
