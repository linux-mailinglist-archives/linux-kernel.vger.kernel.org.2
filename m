Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64D2A3E5086
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 03:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237187AbhHJBLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 21:11:04 -0400
Received: from mail-dm6nam12on2093.outbound.protection.outlook.com ([40.107.243.93]:37313
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230006AbhHJBLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 21:11:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aayyPFi/AfRivapM8QsZ2eZOH4sgmcaYljfve4jICPwfjQypKiwI2UyRb2AOGTKtUZiC/t8qRa1GoAXe8P8rGyl0tBwpTlANO9dBWZc7P26/qZQz0VM97lvU9PrZpGqKWxaPnWC8bZSxHvgwgvdOiKm8H9bhSJW6X6WHWopfjfoTbyaDsgTFEd7669KE9baybT/8QxK5UwslmLbYpYAcwGJ/ZBD4UONuLQFBKXFcdU1xUWSGOZypy7aRnSQQ1dTj/FsYXmjb7V8ZBpwA3sENE/z8ZGacg1Pt0sJ5UWPcC/JZ0pJ6VoBsUKBaoilaSfvMgtEX/62QvAxUaAtaUuW4iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mbRNde9XXi1YDm0NyC9qz27D4dqJZ0hwgIIUSyz0PJM=;
 b=f/3fPQHQYrTwSbEIjM7wyHxh9RSWEgmDrfQQwSGBiSmTcMbSUVlVlguVPYcv/yIaz3sGffDTJis0WOLFTnW5QerxGO6ISL3XArt3iEZOmISJHUm0PwAAYrchCazPpOkWTvuSLYWuDu6Olwqptz3Nb8Ts5Kskwj/6wB9AY85CElnwRhGQo4NYMrO7jI1zBR5lOh4RZSmsAq2FMLr3xsH2MqeHAS2UewBqSZeyAvS0QBPSAbo5wcJaheUzjRxtG8LDVF30zrosGNomgrPvw5MLLM0RhClLQi9k9GRxNhBQ0n/C21NI/oOezXy6afL/Zct04sZS95dYmCEiIEAXQj7QIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mbRNde9XXi1YDm0NyC9qz27D4dqJZ0hwgIIUSyz0PJM=;
 b=R8LOmmBDomOtV8uZVafDvos5d2t8pRbPMO84MJVuUjbaPCZHe1vi9/cqC6lM8WtNBg6OaOV48SENYrIcnsJpp1ccNw8sUSlV0sCe5cnjwD6dZLF7aLFheU5WIfuNk/ak3eFmECiwQxz7tYhAXxxV9YTUjGdk/iJGCb9YWrVv3UA=
Received: from MW4PR21MB2002.namprd21.prod.outlook.com (2603:10b6:303:68::18)
 by MWHPR21MB0509.namprd21.prod.outlook.com (2603:10b6:300:df::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.4; Tue, 10 Aug
 2021 01:10:40 +0000
Received: from MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::601a:d59b:f64e:5433]) by MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::601a:d59b:f64e:5433%6]) with mapi id 15.20.4436.006; Tue, 10 Aug 2021
 01:10:40 +0000
From:   Sunil Muthuswamy <sunilmut@microsoft.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     Robin Murphy <robin.murphy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Boqun Feng <Boqun.Feng@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: RE: [EXTERNAL] Re: [RFC 1/1] irqchip/gic-v3-its: Add irq domain and
 chip for Direct LPI without ITS
Thread-Topic: [EXTERNAL] Re: [RFC 1/1] irqchip/gic-v3-its: Add irq domain and
 chip for Direct LPI without ITS
Thread-Index: Add0L2f934gE0okbTBC5z2WK9cOcFQCFdR6AAvoodNAA8PnXAACGZfqQAA3HAwAAM+eEgAAWMdVAABp8m4AAR9tVAABSpR6AACDuVUAADyD2gAAhE8Vw
Date:   Tue, 10 Aug 2021 01:10:40 +0000
Message-ID: <MW4PR21MB20022D4903CDD8F989C30C50C0F79@MW4PR21MB2002.namprd21.prod.outlook.com>
References: <MW4PR21MB2002BA20FA4A8DAA1C27F4C6C0199@MW4PR21MB2002.namprd21.prod.outlook.com>
        <87a6mt2jke.wl-maz@kernel.org>
        <MW4PR21MB2002E51429F7E13B61A34FFEC0E89@MW4PR21MB2002.namprd21.prod.outlook.com>
        <87tuka24kj.wl-maz@kernel.org>
        <MW4PR21MB20027EAC23E8053210364E2BC0F09@MW4PR21MB2002.namprd21.prod.outlook.com>
        <b2dea108-9166-dc9d-abd0-d22491f78568@arm.com>  <87r1f9wooc.wl-maz@kernel.org>
        <MW4PR21MB2002860BAED850B2B52D6E2BC0F19@MW4PR21MB2002.namprd21.prod.outlook.com>
        <87wnp0b86y.wl-maz@kernel.org>
        <MW4PR21MB2002ABD170CC9786CDF5D493C0F39@MW4PR21MB2002.namprd21.prod.outlook.com>
        <87o8a81boi.wl-maz@kernel.org>
        <MW4PR21MB200286E2CF4DA229D7059598C0F69@MW4PR21MB2002.namprd21.prod.outlook.com>
 <87pmunasik.wl-maz@kernel.org>
In-Reply-To: <87pmunasik.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0db4f590-1697-4a7a-90dd-08d95b9bab69
x-ms-traffictypediagnostic: MWHPR21MB0509:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB050906AA225168C08112B4B7C0F79@MWHPR21MB0509.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mlsA87pHlKh8EDf+dsoU7vqGvUfXtfzkBOOlwx0xfzDI9B5oaI4ZOjYgajGy1ADsdISEPdN6assYrDbanvftgTmLAahQVyMtw+oFrNT5fos+mgdrd2OZ0Bt1z1ihIzz72VC5nzzshbX20SbaUKglyj5WQIVOsT5kFvkUgg8EiJvtL48fwB7gDTjcEFJHL8xBPhScLVDGWUGq7hGibGTeYqLOlqS3STcLtlpu6b/AIvs6ryNvFavcO0xURWGbNLugUGB0g357qMe1ZBfPCyntMx07UqGVwiWLxZtXtrRZMPVCYetoaI9JqZEmO+G7ahDOiRgO+CPavvAPPM02MxOjaGWBA5K1dzkx2+Pug8rh9cLqkTXA5gBEYampmPJiyxBrDqBo8JPU/ELgqBW0IlYR30GVRvBjDUhvwqJyp3i3xLG8xBn4X//E/wxfnhlIMaNcnYwsCeAXsibCJg4WILeRrDk1qqRfguCzJkbjV/AXzLXS/aY/WjstEMSruEs1UQ9QwSOGSet9hlGOlxnCFRnfr/f5Epv5wm9pMef/CT2R/c+R4sbacYRX/CwoFavNzTM/4UdJ8fjpNn/mDMAKEKpurhfLtcwIkAQLQkI7bxmCIB4+tMdgbAUk1W88puZhnvx8lLkTcH9enj95aAYBD+23NWUdBXiafTN6qjQDcoxu8ATb4OciYcslYjFjc9babW2KQaDICmHgzwvxa6pHaxgRgw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR21MB2002.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(52536014)(9686003)(66946007)(5660300002)(54906003)(33656002)(66556008)(38070700005)(66446008)(76116006)(6916009)(38100700002)(122000001)(10290500003)(2906002)(316002)(8936002)(64756008)(8990500004)(66476007)(55016002)(186003)(4326008)(82950400001)(82960400001)(83380400001)(8676002)(53546011)(6506007)(71200400001)(86362001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?c43ZwEEEz1398iNqQBkBa6eF2HGyOpLiZXGmuT5suYEJVZ0QZBnYnNNUboZJ?=
 =?us-ascii?Q?GEfuOZHVhIA97zt2LFt6dOhAnW4y7TKwiulFUkPmZ3LJuhiWkEEq50cdwDaj?=
 =?us-ascii?Q?al/rGo9uCUFTKejeBU+GjJS+NytG1h6Wh4M9q1gFVQIwo4bgm+6bsNQiElul?=
 =?us-ascii?Q?gXqn5eyZrF4nxhMANnxDSvb41f5cTFCQge8Lz2OKfxglsBgULIiMEDQkwImz?=
 =?us-ascii?Q?COMUvH1fOqzqIDWhtfn50mGy8Jltyzca+IEDl4rUduNA3IGcLfCMUDUu9v5C?=
 =?us-ascii?Q?LtsuKSjr3qpaaORTalr3EI/6c8NyB7XB8B7AbgcenJnaww7l/l9fgFL0PTJA?=
 =?us-ascii?Q?0bW8jIeHOUHt8TgNp2g2p9qTlCQaz5UMQjiTgHYQwfmyBIUkW/YWgqNAawQ8?=
 =?us-ascii?Q?UvgBu+5e5tONXfuVKSrufirO621gi0i6C52TI+s5+eY8x6g07BCsiuLwniNm?=
 =?us-ascii?Q?jd3GyUQF5+uhjJQAS2+tU+Fx4yizT/TshJYzUYp5cR6+TkeCK7uCUTfvJa5C?=
 =?us-ascii?Q?NaqO3JQFR2NxTUP3S+Glh08A4WrVYsmgTBtQTwTBkOecN+XzXNhX9ZW6Fak/?=
 =?us-ascii?Q?6GL7f6wRC3ooRqcc48GzpujgMjXWsEY2kT3VhvD74v2Y1skTTOILI1eeANau?=
 =?us-ascii?Q?FaU3Iv5gOTepehvwbQHv/MVRS8Rw6zDg8wKhkZZ5VuBY8wnLcfMM6/4+FHR/?=
 =?us-ascii?Q?8Qe/ERj85QNhUrN2kocjQenerbEy+J9GAHe/lhMSyNaW217qQ4zdXFwyy+4h?=
 =?us-ascii?Q?G5ZelyZV1LyCHNmJDPfENZjV9rUmTsNqaka31mw7Y3gnNsSy4aNKGKxloQPA?=
 =?us-ascii?Q?/dxKj3B7fZm0CKUtH9CFwPugBPpNEuTEBLi30b6LxvIAzAt6oBf+oLgoh009?=
 =?us-ascii?Q?rONNW4HwtlzkY107ya3CbOgAIkxL2/e9AIMNNkrXt1Ot12HRLAfDkycivZza?=
 =?us-ascii?Q?1wA01SK7WDv6QLM+nQC0Cv3GIU7B/8gIbuXJfjb4mLyHEkGtdDSKsO1X25G8?=
 =?us-ascii?Q?WaqCGLB1Q6lP8sjgQuImf59qpAavGb93jeRWHzKt9uHMA3vEpyLpgdZkfWF/?=
 =?us-ascii?Q?0VaVbEEvGHpm9jIcno6Wg0De38GNoaCCDKYe8ijpB4dOz6wchfek1sXppNqA?=
 =?us-ascii?Q?g58nZyBFAl5HNu8r8oQtOMxxWC6rmoP3Go/XTMMOHKEPhcCqPkNl3EbBG21w?=
 =?us-ascii?Q?H/+zHPWHyi7bQq3v4SSobJuUUD4xuJpxG057a32hA8KK8wFSN74+kk2w56be?=
 =?us-ascii?Q?nb2dBa6D/9Im/Kkks3jweLzqEOTMZVkJKcaVbiNn28N898FCfmDQOFWZdBKt?=
 =?us-ascii?Q?+9zHh3JY9MxcChOtFKlbkL5t6exqCuQVfaxbHANeALsRMT3lkdWYoA7BF1RM?=
 =?us-ascii?Q?VKNGNw0qG4byELOvWqHT5BFpqIZT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR21MB2002.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0db4f590-1697-4a7a-90dd-08d95b9bab69
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2021 01:10:40.1286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3byS5kX3iADGTj2fpsqQYRB3Lx707PO+pyzrPlNcugWwdbRmuAoZctjHuRUke0yRfQ4OcDAxL1sHkYXXujd1hoLB1y9Qj6a36Ejjti0EMz4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0509
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, August 9, 2021 2:15 AM,
Marc Zyngier <maz@kernel.org> wrote:
[...]
> If you plug directly into the GICv3 layer, I'd rather you inject SPIs,
> just like any other non-architectural MSI controller. You can directly
> interface with the ACPI GSI layer for that, without any need to mess
> with the GICv3 internals. The SPI space isn't very large, but still
> much larger than the equivalent x86 space (close to 1000).
>=20
> If time is of the essence, I suggest you go the SPI way. For anything
> involving LPIs, I really want to see a firmware spec that works for
> everyone as opposed to a localised Hyper-V hack.
>=20
Ok, thanks. Before we commit to anything, I would like to make sure
that I am on the same page in terms of your description. With that in
mind, I have few questions. Hopefully, these should settle the matter.
1. If we go with the SPI route, then the way I envision it is that the=20
    Hyper-V vPCI driver will implement an IRQ chip, which will take
    care of allocating & managing the SPI interrupt for Hyper-V vPCI.
    This IRQ chip will parent itself to the architectural GIC IRQ chip for
    general interrupt management. Does that match with your
    understanding/suggestion as well?

2. In the above, how will Hyper-V vPCI module discover the
    architectural GIC IRQ domain generically for virtual devices that
    are not firmware enumerated? Today, the GIC v3 IRQ domain is
    not exported and the general 'irq_find_xyz' APIs only work for
    firmware enumerated devices (i.e. something that has a fwnode
    handle).

3. Longer term, if we implement LPIs (with an ITS or Direct LPI), to
    be able to support all scenarios such as Live Migration, the
    Hyper-V virtual PCI driver would like to be able to control the
    MSI address & data that gets programmed on the device
   (i.e. .irq_compose_msi_msg). We can use the architectural
   methods for everything else. Does that fit into the realm of
   what would be acceptable upstream?

Thanks,
Sunil
