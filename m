Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81B213E3DF4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 04:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbhHICf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 22:35:29 -0400
Received: from mail-mw2nam08on2095.outbound.protection.outlook.com ([40.107.101.95]:45120
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229891AbhHICf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 22:35:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+5tE/WIDLc4PvwMT4NXy0dv26PSbsAgPBhGdc/BpVB0KoPjNEIxUzD+0+8QGi78IBqHi0uwn6G9H0XU0pcR6Ma1jJFUcRP69nVC4DLyGoc8JVFdlv6EGVjwAUJM0GHZudrAlWsxl9GYyjcEkoxGAGXYYz9yFhLsya0tUu2xBzWFRLEUta+WwLqUdAua4I1PnseEfw0XI6aZCUjOgO23TX6K8kgAuMpbv6cfwHdLthTIDSA0HHnegzSArzDuWqNyvN9htC/khg4sYn5qVFGjAJjqFpOZjI1MlyKkbrEt9QEQpFXgiZqLd1dvG0DGC4hSleDvNFd75zOe2UHT5K/KdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y5IkY3vbvf1SjpHj5GQVKVnSBrSazxgl1H3XhA0GVEU=;
 b=VwgiKT2PDJR4+2w04ziQc1Nyg+aaxdQ9/iOBNqZ6Ii6NGAI9iHOX6GhHa7WII0gly5cuymkCTcCwrGTVDJqPSCwoWEw5VYQZvTTvpQhb4l4uMIDULxZftJTqEeurtIVKnQc3r5FQe4Dcg7c8Dy1YoEzRlU7ziu6ycY5vTn0QSSkn5e0s/vf4KNr80jpqEb8r8gB7ENd5V+c13BJ4Kvxoo0fe+VYRqf3vt5n/acWU3dKZderTdCkyErOzwz7b1j01ppfdp/QW5nisZMb9vs9WkaIgMTj854S5QrzGrA7fg20tY/kir1oddueABvCqqJMxqevynjzM/LHjkrIRxoawIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y5IkY3vbvf1SjpHj5GQVKVnSBrSazxgl1H3XhA0GVEU=;
 b=C7Fvok6o8IUHaTwO/QGGE3T0XS0X61V6S15r/tslGQHDWWj75cyDK01ji2P00vTuTvEuBMVGzw2VYLtL3x8nCJuLVdxXWulVatCElhTp7pK7cbVsXTuppXOgjT1Ffoj34TZrr5ZWuCP4FnnJGtgvj7NSDKJXMpXQcrN5UnZecsk=
Received: from MW4PR21MB2002.namprd21.prod.outlook.com (2603:10b6:303:68::18)
 by MWHPR2101MB0730.namprd21.prod.outlook.com (2603:10b6:301:7f::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.5; Mon, 9 Aug
 2021 02:35:05 +0000
Received: from MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::601a:d59b:f64e:5433]) by MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::601a:d59b:f64e:5433%6]) with mapi id 15.20.4436.005; Mon, 9 Aug 2021
 02:35:05 +0000
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
Thread-Index: Add0L2f934gE0okbTBC5z2WK9cOcFQCFdR6AAvoodNAA8PnXAACGZfqQAA3HAwAAM+eEgAAWMdVAABp8m4AAR9tVAABSpR6AACDuVUA=
Date:   Mon, 9 Aug 2021 02:35:05 +0000
Message-ID: <MW4PR21MB200286E2CF4DA229D7059598C0F69@MW4PR21MB2002.namprd21.prod.outlook.com>
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
In-Reply-To: <87o8a81boi.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ab11917-8e3e-45f7-743f-08d95ade4c42
x-ms-traffictypediagnostic: MWHPR2101MB0730:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR2101MB0730A86AF257432059C8E3E6C0F69@MWHPR2101MB0730.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AxcqoXNFLGrlNV9QumKzHAT11tvrc1yQTxeFDiQMMssTvP4vuERxg5gud6y/Dw1x/baIbGtncJ+um2XItJhrSVhJ3K+RipvY2dcF/mDctaUxLuZmYyAyLwwgdYiM3V5DdeW0tko80RMTK7KFBLIFfAeE8GqRyfjIS/6T7ABV+GgkaGX/VYa8qguoM51uVOxU3ZydXFhu0C8AnVv7N9YOalTvYpXZ/xAwOI2w5XYRLUk+0JdyPIWhpVp3wRKKU5XICt+QRK6GkKkkxdRT/KFu7QPvYYJVCN3Ef1PyveBYvG6m8R5sfUH8+sixoUnkHCEmNXAEmDdsBOR03xBcXGclsuOfLq/C/mGbT081uwkyeSNNHt0gGWnRs0/J+5jiYa/oNCazYvWMlwX8whk+XCaR4WbqKmMalUHx4jl4VG0agr84FJwAzgsrw/3x4Kr26FGOaq79f6HRgBMItxAcMnAQK/XkhdStG8DQVVi5IkJWVuQaEA7sV8WgUDpgFQm6gjQqao6P/MZBVob3wmeZOrQRfV73Lr0lb2R/kEmTvuPS8geXaosKxEF8cLLx1iJRNvlKCu1OBNoeZUs9+xewZ/b/73RAs3+THWwrZohYXGwHhWFY/ck52B0vTKfbvkdvOhQCJR0FDIy1dXlhs0Vfwckh81go15r0OCXxkEz/V4386L8jQ+yKWYYmhkx6wdy1OZ7WLX1EYEZxwe/o7WCBWnSx/MVwHO5FmW5DBj0sP6lYI0k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR21MB2002.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(52536014)(122000001)(64756008)(5660300002)(6916009)(9686003)(6506007)(66446008)(66556008)(54906003)(82950400001)(55016002)(186003)(82960400001)(38070700005)(8936002)(10290500003)(86362001)(76116006)(508600001)(2906002)(8676002)(71200400001)(8990500004)(33656002)(83380400001)(316002)(66476007)(7696005)(4326008)(66946007)(134034003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bBTf0wtRUAl2Ek2Be9xTAYifaVMy1TTXl4lgkeA3JeNuR+Bmedcm/U/44bvf?=
 =?us-ascii?Q?mdyI8UFJ2L0yEgfez9b10SveEm7Nrsv4zyFFELiNBBvS8EDgbwEwtfvOxXVH?=
 =?us-ascii?Q?kquVBH3Mz6AKBEw7IFbQz87+8ek2cgvxo3haPGhpt/sSXgMTBFxp9w2SMIwV?=
 =?us-ascii?Q?Cktes+Aw6TWx59QO6zu7UyZFA6vxH1YCBWQ3hYlvNWKfQZEWcQaxwqHKgGd6?=
 =?us-ascii?Q?JIf6t1cdicu26QmK/BLKiFUsgVR5CerTKTznAt/5JnCpvGCpuYzBJ5JfJLMB?=
 =?us-ascii?Q?k37NxY2e5XuZL8pqa1OkCMCHSR47C9EtUDp0i72ngOIoqBEX856ibjnmb6sS?=
 =?us-ascii?Q?3ZkL/jD2WhNMB7UnQnG4ifXG6iHtivgtbqU2fxxVHvVcJVY5oCkXxMNNSbzG?=
 =?us-ascii?Q?mSksHr7s5rG29om6kjxDN+AEO41O1cj3Y6Sum7AnSX297TwR76a6TTM0jZ8O?=
 =?us-ascii?Q?KiNRf12+FZvIL5tBF6MbFpC2r+/7dFZEx1Eo073n/jot3/lKLyZJ1LDzOY/f?=
 =?us-ascii?Q?IB+tF4Tguu+2Vl2n6WSxDeC7PlkDladyb/0TlrGc/D86/DKwDGe4O+yYsQ2D?=
 =?us-ascii?Q?TJGMqY9uRlmm0nZFBhW3ZAWcphfK6b70Gl9ulY2Rm0F15AMZHIb1f8EHsSam?=
 =?us-ascii?Q?HtgOPirH6KfKec1gy3v7oCsLBI5SMD5rxWhJDTXUBF1o8nZ9jLmERtqBrECz?=
 =?us-ascii?Q?KER+L2qusIVk573upl6EccwMvGFtrHj2Ncz+CnTVJUahul5IuOXoF1jh6jhw?=
 =?us-ascii?Q?rGCQ5InRQ7UOL9INaIKb+c6P9J9Qgg2GX7rwm4Qtn2NnvVytZAcwClIyrEup?=
 =?us-ascii?Q?SELP8dszlDNZmxcEzI+RwAqZPXuPWqU1xuGT58wEVkHWyeCNAUSqtZEIceWV?=
 =?us-ascii?Q?/7ZWFLOpkThL0IpO0pWO1gzfDisllx/eMtjr0r3/h7OrrnwE0G98cJl4zeKu?=
 =?us-ascii?Q?NIbiXizHZOR6RQbtHmDZ3PwJrpV6ZIkJene8jgHLee9cPvag0Tf8BaJpz+ms?=
 =?us-ascii?Q?iTcOV1hD1AmzypH2LqZUWW0EgNvXPrEnbL7GiGZrEjIJcdQqehqEVi6rNS8d?=
 =?us-ascii?Q?tNqOF+jjAGgaq348iBzFZBG0rDXIEEFUH1UjBDrMuvN0MmCeO3ucO3AuEPAO?=
 =?us-ascii?Q?QFcvRIYqOhYawC5wKunhVUw1otsV7GAPPda/p2cgMO08ve8SxPqc73Gj9bFL?=
 =?us-ascii?Q?T3oA52AwTlO16EF2x4ZQERB+sfj491vDCGYcEniwVoRkESj5UdcMGYdWPoQR?=
 =?us-ascii?Q?xBPTOqF9gbiEZM9S4oUiFeBb2o7Z+bMr0DtfiB5yFvDjJCMXGtDI8ucx3eJH?=
 =?us-ascii?Q?RsumfEy1jrh+ydPD3wYEORfwIs3V828rhzZtRAsGD5pcU5nYzZQosSL2K8+7?=
 =?us-ascii?Q?7gWxdPg5eHyObouWavaReCxHWSxt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR21MB2002.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab11917-8e3e-45f7-743f-08d95ade4c42
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2021 02:35:05.6178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jGBKdCB8eMJqaAZ1Olc/ZsbLg+TClPPZEwpZprz3unJgZn5OsEoEQFNm8ojuCuRj7lJmtWPPXmcCA+nvUFEfqP/jZ4B4NK8fT3E1hakqz6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0730
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sunday, August 8, 2021 3:19 AM,
Marc Zyngier <maz@kernel.org> wrote:
>=20
> [+Lorenzo, as he deals with both PCI and ACPI]
>=20
> I think it is clear enough, but I don't see what this buys us other
> than turning DirectLPI into something that is essentially private to
> Hyper-V, just for the sake of sidestepping a firmware description.
> Furthermore, the Hyper-V "single MSI address" model doesn't match the
> way DirectLPI works (after all, this is one of the many reasons why we
> have the ITS).
>=20
> The architecture already gives you everything you need to make things
> work in Hyper-V. You can easily implement the DirectLPI support (you
> definitely need most of it anyway), and the PCI-MSI layer is
> *free*. All you need is a firmware description. Which I don't believe
> is the end of the world, given that DT is freely hackable and that
> IORT is an ARM-private extension to ACPI. I'm sure you know who to
> reach out to in order to start a draft (and if you don't, I can give
> you names offline).
>=20
That sounds reasonable. The DT extension here alone wont suffice for
Hyper-V and we would need the ACPI IORT extension here as well. Our
general experience with ACPI extension is that they can take time. But,
I am curious to hear from Lorenzo on his thoughts here and if just an
IORT extension means anything else in terms of timelines.

> I am not interested in expanding the GICv3 architecture support if it
> cannot be generally used in a way that is *compliant with the
> architecture*. If you think DirectLPIs can make the hypervisor
> simpler, I'm fine with it. But let's fully embrace the concept instead
> of hiding it behind a layer of PV muck. It will even have a chance of
> working on bare metal (such as on the machine that is humming behind
> me, or even the Fast Model).
>=20
Appreciate your inputs. Since we are discussing options, there is one more
option to enable Hyper-V virtual PCI for ARM64 that I do would like to
discuss. That option is to implement the IRQ chip completely within the
Hyper-V module itself. That IRQ chip will take care of allocating LPI vecto=
rs,
enabling the interrupt (unmask, mask etc..). It won't be a Direct LPI based=
,
but based on custom Hyper-V methods. That chip will parent itself to the
GIC v3 IRQ domain. The only extra thing needed for this is for the Hyper-V
IRQ chip to be able to discover the GIC v3 IRQ domain, for which it
cannot use the 'irq_find_matching_fwnode' method as Hyper-V virtual
PCI bus/devices are not firmware enumerated. I am not sure if there is any
other way to discover the GIC (DOMAIN_BUS_WIRED) domain.

What are your thoughts/feedback on the above? This will allow us to
enable the scenario for the business timelines we are targeting for, while
we wait for firmware spec updates. Long term we also want to use
architectural methods here as that helps the Hypervisor as well, and I
would be glad to pursue the firmware spec updates in parallel.

Thanks,
Sunil



