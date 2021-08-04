Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6350C3E092C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 22:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240816AbhHDUK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 16:10:59 -0400
Received: from mail-dm6nam08on2112.outbound.protection.outlook.com ([40.107.102.112]:24288
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239671AbhHDUK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 16:10:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3XMinFm7/9tB0+1u8ak10cyN6CONrbQiT33qgxda2vzeGfiP4+LmwvD9tO7M7n2Ff/1he0OEu9YmfRKPvuzYCNyaB/qtV6mR3/i7mcz1QEtJ5hjpN1Zhn4WabV2vk9FyrvViHXmGmb9Wreev6DxDxJAiB2V4nCJV9jxRlDetg+xh8Xq91FCqsbk6bbS6MbH/T4tioOosO6w6gJ8+BtdK7c3m1Aa+Us+us0y4gMdz36U2/a+peCS6Zr00uCwwx/1WUse5/QzSKyNzY5iXtyWv28aBu5E0QSLChZT0XZX/4CkycW7QoiFyJuuulcS20N0f45hRetVxtTW4CmHswcCwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGyzjTArzJ0AwjPmU0XO8VDAnhEJEH20ktqf+diEE48=;
 b=I5lkGHiwXyWkPamARO6YdILt00kCjtc4t8I6mYfzZPppnrCk3uRyaHMtExDRPauTZQBN/tyLN/EMjqMxCyqBIqQHDPy6tSkaPdqWUu7cuQPj5VtntRwXRJczlxpIlrVlyxCW3eCufF658l5vLsovtTBRRTvksLdjam4cPiXBzyQ8oLYBYjvUYi4sGxY/sgXGLt62s/QgH8D/xG33OX9tWybzJeEGzJqs8L4AxZuRU4h2tXXa6bpuZ9Jk0MIJVdD956YX1nlEzb+obqN7l0qMTtip6DNl0aV++c/HropmsbjVuNcD8B0rLUd2xtGZgXV0k/bzXj31TuuZ8vfY4uke/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGyzjTArzJ0AwjPmU0XO8VDAnhEJEH20ktqf+diEE48=;
 b=ixHJkLM3QVY0gb+IoCDroe5aYZ2q5ces6nGpOdW1yzSbKjRx5JnukvAc15LyXHNGBUx/84nI3ZHGRgumSckXDAMi0e/9vMRalgd6v3a4SYGJACXJKHiMBUYEzCAoYTaqT7C5luJVJ4GN5UAfCfK3VT//phZWA52Zcra6gCzByOo=
Received: from MW4PR21MB2002.namprd21.prod.outlook.com (2603:10b6:303:68::18)
 by MWHPR21MB1598.namprd21.prod.outlook.com (2603:10b6:300:87::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.1; Wed, 4 Aug
 2021 20:10:43 +0000
Received: from MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::601a:d59b:f64e:5433]) by MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::601a:d59b:f64e:5433%7]) with mapi id 15.20.4415.005; Wed, 4 Aug 2021
 20:10:43 +0000
From:   Sunil Muthuswamy <sunilmut@microsoft.com>
To:     Marc Zyngier <maz@kernel.org>, Robin Murphy <robin.murphy@arm.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Boqun Feng <Boqun.Feng@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: RE: [EXTERNAL] Re: [RFC 1/1] irqchip/gic-v3-its: Add irq domain and
 chip for Direct LPI without ITS
Thread-Topic: [EXTERNAL] Re: [RFC 1/1] irqchip/gic-v3-its: Add irq domain and
 chip for Direct LPI without ITS
Thread-Index: Add0L2f934gE0okbTBC5z2WK9cOcFQCFdR6AAvoodNAA8PnXAACGZfqQAA3HAwAAM+eEgAAWMdVA
Date:   Wed, 4 Aug 2021 20:10:43 +0000
Message-ID: <MW4PR21MB2002860BAED850B2B52D6E2BC0F19@MW4PR21MB2002.namprd21.prod.outlook.com>
References: <MW4PR21MB2002BA20FA4A8DAA1C27F4C6C0199@MW4PR21MB2002.namprd21.prod.outlook.com>
        <87a6mt2jke.wl-maz@kernel.org>
        <MW4PR21MB2002E51429F7E13B61A34FFEC0E89@MW4PR21MB2002.namprd21.prod.outlook.com>
        <87tuka24kj.wl-maz@kernel.org>
        <MW4PR21MB20027EAC23E8053210364E2BC0F09@MW4PR21MB2002.namprd21.prod.outlook.com>
        <b2dea108-9166-dc9d-abd0-d22491f78568@arm.com> <87r1f9wooc.wl-maz@kernel.org>
In-Reply-To: <87r1f9wooc.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 007768ae-20e2-4108-e715-08d95783f04c
x-ms-traffictypediagnostic: MWHPR21MB1598:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB159877600858E3B16CDB87A3C0F19@MWHPR21MB1598.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NXpoKh2UT0wS8r1xXKHWdMdv2Hn5s8J6zcJiVfNUihwd0KeDYKkqsEHuVb/ziUjae+8Pg0cN97uJJWQirkD/3o/bTZQBJ1BS5sLuUomut2Wz+r4pNYwlxiWlONTw1+bpHnpo+XVtFlDI1TnMahgsCW7U2f9QE0+xF5Sdz1woZ9ocbmHxLOxiFkD9l6mch2tvfc0Axaa1HzUUpyaGcU+hPfr2HlOqPcZDbiGkyoVmyVMlUi9PRbecij4qZTrDnBp9Uqht70Hf01d1aMo9/tmW9i0OgxVl+W42aCKVUdcAhgPlrZv0tpGIUV8jy3r+cTtwjKFgHvmbjaxW20c2Wi9qqLEE7Fse7X2Itz4AREuE+NqnqzEKu6tdAF+NZliBpXODC8kwkYwIZ2rBssos5fdkk7Bhot6a4xgP7rdfxdp+rQPlJ3MdfsGMKbNS9Xq2WCSvdKU68t9E1u784Quht6EGTMw67QhjN0jYs3lJwQMAUoE/4ObwAZGls4mbdz8jcmOcvdlkfbUoDnP3QYSpKkuR0t4N2IfXcFRvDtxaQkYgMLDR/eWmnZi6dsVCO7GT2lvFZsK7qz/Bz3n6Yf6JWR/DilBAqRaAE9OlFzaKgypeWxBrL7j0J7MkMG0Faz2FYv//eIpycPG/Yyux1Nu2voYpS2M3XLLAgzSUImx9/SWlA02e25O4EkT7wXR1Lv8ZocNZEry9XOKLTqvI3xUj4MJ/EA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR21MB2002.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(122000001)(55016002)(38070700005)(8676002)(52536014)(4326008)(53546011)(8936002)(5660300002)(9686003)(64756008)(66446008)(86362001)(2906002)(83380400001)(186003)(82950400001)(71200400001)(8990500004)(82960400001)(54906003)(110136005)(316002)(76116006)(66556008)(66476007)(508600001)(33656002)(7696005)(6506007)(38100700002)(10290500003)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UrZrImJl3emGtlD80RofkrnJNGVorB8X3l0BbucYmHP0XuC1Oshz4jOyrBpQ?=
 =?us-ascii?Q?LHPDBXGEq487wib0Ib+bPEMRktrefkGbxACmDU88qZSnjqUc13Za3UfTe8AH?=
 =?us-ascii?Q?ROjxS61tx/m9+ytCJaGfYjLFy5upDQw/yIBGkDim2oasNy/pdV9oTVuoQkKM?=
 =?us-ascii?Q?5fl/F6JqL4fVsFKHG+noneWTkQ2v4pfLKOe10zwBCguxW44TX9BCydvd9GnO?=
 =?us-ascii?Q?SqYK1wp3/0Axex48TruyHFFutn3V++0nM52AE5/iQDFZwbHHJ+r3pAnIECay?=
 =?us-ascii?Q?3idf5KKN370Yxclu054In9S360tWd7nddPnQXuqDta4wKKx/rGTuaApPhLCQ?=
 =?us-ascii?Q?DRyA39DbhCl3JZjPcKZdA2RVCEt8nMe8s89lsREyBcrr4yyu6aiTjZbvcrLT?=
 =?us-ascii?Q?VjDw7UHNSPz+9718B8mANRb90bIwT1xUuvOgIbtZaweePMNy5SmNAFz6sKPN?=
 =?us-ascii?Q?itPJNGSM4v09nVsSTmbkxVKgggzHgEWY2ol+aNBbeArXHQhOI0RbWcUlT2Me?=
 =?us-ascii?Q?kNHUFQez0LTyGUpAynKEahQhl/4FGaMU0oEzjo6VU3Y83d9pfOzDzhavolfF?=
 =?us-ascii?Q?mkLKydXuvZmpMMNmzf4UImH5HQZjKRKzMHSf4r+QLuZXOCdk148VvEItdGw5?=
 =?us-ascii?Q?HJx6Tgf3CkdO8AzOLjxZvex3HJ8Bmd9yEikBFRtpaZ5ZIDLJTd2mElspLsRU?=
 =?us-ascii?Q?H5WTjYqq0NHcakGryNlkD/kUpn422mVskIn5GF8hn27HcOrF2cTKOp9qLGC1?=
 =?us-ascii?Q?HyySJjaaKMFRNKrflPb68aU8ym88H+2wq2n8KdussS6NRv//HXDkNdIt1ExI?=
 =?us-ascii?Q?/OrUISZVv5fN4egYRxgo0BvXI4q1ujRq0xf24y0Wp7/U1udXLwpCydTZZsI+?=
 =?us-ascii?Q?WZZv12Orm+SYvacqRLdJgopzBhxh367s/uJJboji/EgWPAJ53+JszkRJcGc1?=
 =?us-ascii?Q?3o2zR12ChxPrvn4EoTIoIGA3RjAb3+i9dNHJ7RdNmYf8HTx2smIsiFgdAvaq?=
 =?us-ascii?Q?A4uvartVKdcxc2pBkVSZb18vYR2rH27aSxPQvN7v3F6qAWtk42ecHG0592eF?=
 =?us-ascii?Q?VT5kHLcRgoU5HG3S+/uKUuR12Uhd0ygYEgSqbJ4amJc6opSO7hCBBKVCyG9Z?=
 =?us-ascii?Q?ZQTTBM3kdLSmafE5jP4Bog9Spv72kaNXiA6qDC1ERgl5iJdIj5+Fc+gdDjaI?=
 =?us-ascii?Q?Poz4HeW+Wc1o+NtAQwMpmwbpxSQmPJLQXlY5JMdbU88Bk+Mq/SVGLzT6a2Oi?=
 =?us-ascii?Q?l1ltcotp1KMBwA0xxbxpKJbiv3jNFAn7TSKHs4tgZ0FDSObr2Va3LoWzBazW?=
 =?us-ascii?Q?tjLbjdjU64PpVj8s5YpsDdVs+hv0U1WaGS/Y02tgS6uy6WcKMxPdSyAYpw68?=
 =?us-ascii?Q?dtf4Br/L5AA47DPhJznb/wqVCMM0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR21MB2002.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 007768ae-20e2-4108-e715-08d95783f04c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2021 20:10:43.1817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2luRjFMYsZudfC3V9CglV1ncYP17PI+BmrqpydzkBteglGAfC3+u/G4B9uKqHT3eiMuRDq4W7LbQMHkLpneasAgEBlWtA3rv0oDlleKKdgg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB1598
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, August 4, 2021 2:21 AM,
Marc Zyngier <maz@kernel.org> wrote:
>
> On Tue, 03 Aug 2021 09:35:12 +0100,
> Robin Murphy <robin.murphy@arm.com> wrote:
> >
> > On 2021-08-03 03:11, Sunil Muthuswamy wrote:
> > >   On Saturday, July 31, 2021 2:52 AM,
> > >   Marc Zyngier <maz@kernel.org> wrote:
> > >>
> > >> [...]
> > >>
> > >>>> I also want to understand *how* you are going to plumb this into b=
oth
> > >>>> ACPI and DT, given that neither understand how to link a PCI endpo=
int
> > >>>> to a set of RDs.
> > >>>>
> > >>>> 	M.
> > >>>
> > >>> One way to do this for NUMA-aware systems would be to use the NUMA
> > >>> related information that is available with PCI endpoints or root co=
mplex, to
> > >>> pick a Redistributor/CPU that is in the NUMA node, as specified by =
the PCI
> > >>> endpoint/root complex. In DT PCI devices can specify this using
> > >>> 'numa-node-id' and in ACPI using the '_PXM (Proximity)'. For system=
s that
> > >>> are not NUMA-aware, we can go with *any* Redistributor/CPU.
> > >>
> > >> This makes zero sense. From the point of view of a device, all the R=
Ds
> > >> should be reachable, and firmware has no say in it. Dealing with
> > >> interrupt affinity is the responsibility of the endpoint driver, and
> > >> NUMA affinity is only a performance optimisation.
> > >>
> > >>> Is there any additional information we would be able to gather from=
 ACPI
> > >>> or DT that's not there currently, that would be useful here?
> > >>
> > >> You will need some firmware information describing that a given set =
of
> > >> devices must use the RDs for their MSIs. Just like we currently
> > >> describe it in IORT for the ITS. You cannot /assume/ things. At the
> > >> moment, there is nothing at all, because no-one (including Microsoft=
)
> > >> thought it would be a good idea not to have an ITS, which is also wh=
y
> > >> ACPI doesn't describe MBIs as a potential MSI provider.
> > >>
> > > I am a little bit confused by your above comment. Maybe you can help =
me
> > > understand the ask. You indicate that from the point of the view of t=
he
> > > device, all the RDs should be reachable. But, then if we define a map=
ping
> > > between PCI endpoint and RD in the firmware, we would be doing exactl=
y
> > > the opposite. i.e. restricting the RDs that are reachable by the devi=
ce. Can
> > > you please clarify?
>=20
> Not at all. What I am saying is that you need to describe that the
> MSIs have to be routed to the RDs, and there is no way to express this
> at the moment.
>=20
> > >
> > > Is your concern that the device should be able to only DMA to a subse=
t of
> > > GIC Redistributor, for the MSIs? If so, in the IORT, there is "memory=
 address
> > > size limit" for both device and root complex nodes. In the implementa=
tion,
> > > we can enforce that the GICR is within that range. And, if a device d=
eviates
> > > further than that (ex: by having accessibility gaps within the GICR r=
ange),
> > > then that is out of scope for support.
> >
> > No, please don't try to abuse the Memory Address Size Limit - that has
> > far more chance of adversely affecting normal DMA operation than of
> > being any use here.
> >
> > I believe the point Marc was trying to make is that firmware should
> > not associate a device with any one *specific* redistributor, however
> > ACPI currently has no way to describe that MSIs can target
> > redistributors *at all*, only ITS groups - there is no such concept as
> > a "redistributor group".
>=20
> Thanks Robin.
>=20
> That is exactly my point. There is no linkage whatsoever between a
> device generating MSIs and the redistributors. In that respect, this
> is the same issue we have with DT, as none of the firmware interfaces
> can currently describe MSIs directly targeting the RDs. The only way
> to describe MSIs with GICv3 in ACPI is to describe an ITS, and you
> cannot use the *absence* of an ITS to decide and use DirectLPIs.
>=20
> Given the state of things, using DirectLPI means that you need to
> extend the firmware interfaces. This means both an extension to the DT
> binding, and an update to the ACPI spec. There is no way around this.
>=20
> Thanks,
>=20
> 	M.
>=20
Thanks Marc and Robin for clarifying. I see and understand the point
about having explicit MSI mappings in the firmware specification for
Direct LPIs for generic hardware support.

Hey Mark, would you be willing to consider a scoped down implementation of
GIC Direct LPI with just an IRQ chip implementation and no
Direct LPI PCI-MSI IRQ chip. This will allow a MSI provider (such as Hyper-=
V vPCI) to
provide a PCI-MSI IRQ chip on top of the Direct LPI IRQ chip and enable
PCI-MSI scenarios, and avoid building in assumptions in other cases (like P=
CI) where
firmware specification is not available.
- This scoped down implementation would allow Microsoft to build virtual
PCI on top, to enable our business needs.
- If there's a need for a generic support for a Direct LPI PCI MSI IRQ, tha=
t could
drive firmware revision efforts, and we are happy to assist there.

Looking forward to hearing back.

Thanks,
Sunil
