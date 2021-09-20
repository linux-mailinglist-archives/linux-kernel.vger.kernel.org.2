Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0A5E411314
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 12:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234712AbhITKsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 06:48:51 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:29462 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234538AbhITKsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 06:48:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632134838; x=1663670838;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UonkBgk17Os9iy8oFS/25hsj8hT411Q4VLHL6C0XCQQ=;
  b=vSJcAKvhwjJMD2cMy0TIZtBeWFczeqcC+jYjGK/3p2OGlmI9va89iM1s
   3K1ULgr8bL6NBk52hc02UYPEYe3Nqj0y2Z9D+uy8hq3Nbi5RD2S5ZuDd0
   9uWn9g9wGv/+ODWQU1tRYyFqboSVRbgM03GEp8Uz2ws9mHeonO63SZh6y
   4AVi7y5p0EaqAMAjRkXPuJ5/OX7Xf4ElMZwxfZEqggL/1iAkM47L7cqet
   b4yx3xzXfFOCzz4n7LFIU1Z17E5O7Hj1xIFAS24nBn0yb4qV/4QokXeS8
   UlKlpE4IpRcjrwcF1QmD3ZLh86C4JFlaZ/cpNQ6Gcqu9u/YARby0nfpEZ
   g==;
IronPort-SDR: Csk60ls+nnw7rc+ZKRkY/w42ottl8Twp14ACK3/xjuCG18mOOBaNB3BG02M2CtmeTfgs2GTyGu
 U1i/tdYpAlCoDOEluWVRK98uQKbu4mslxVB7Xn6kvm9F2R2NENZiiZnVJJdPSjDra1h8nOL+EC
 kUKvRLZXsC4mXl5g377AXlP5o2/1/zYQmyIP00MFWBh5BOjdmx3gLlXAUcElvwtGvrSXdLljVK
 1CURgnlm/yVzIt1UG/ULm+D277j1S7bAF1AAOyG5hjPU/fGyAPB5fYmlWgslZ4DpWb/gjfrVLb
 1cyCJZ/+2WInDvczg4e1ZJqT
X-IronPort-AV: E=Sophos;i="5.85,308,1624345200"; 
   d="scan'208";a="69903378"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Sep 2021 03:47:17 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 20 Sep 2021 03:47:17 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14 via Frontend Transport; Mon, 20 Sep 2021 03:47:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHFe05whlt5W4cSnKtHw/ugX0ovOGARee3AeZlUBJzuRuiJ+4mjuCEFFY5xUMFWTzTnYDJVqRsHRe6y2jE+el0PSxbS8ccM17T/KjpuUfhW6StMmuDLXKin74BGm9/Ope436tAoL6BnPEqSATUFNNvLts+ZiNfG1+DrzTav+U4Mn9TG035pS2R7baYzgYlLDE8nfM3ElWIsDOAzWDagedHifxGX3ehGgo2au0d07XvVromQYrRXwKsmhB2UAXo/ORDBEj3VLHpLKWlBeVHW9ukk8VxIj8ZJqZ93q/0yRrq3+BQkE8gmyazMI2sdD+Wjy7toCjFuTytswRUfhCkjQng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=oWZmddWHnRH0PY461HRwWNEaAt2hgln0m06UMmB7u6U=;
 b=fOWXYPVByXo+xBynfxLKxx930eyMYbWap38b1dxmAjLonTcxZbihn3jKNq4TQkWyQnSOsQw9X1cOIpv1N1dgUdtLyo9mONdS4xSTKeUhYHaONXv7EQ7ygohWYhnm54gqhmsNtDPe9RM8dVwNzte3qHzqujZGNQVKMPrcXkYwSMmN/k7mZoM7XM8o6kD3exXOprbP6/SANWSgPe3i5DqY0ax1szflfYmQKzc8jW8Ogo6SSL4wKE2EfboKRZP1IXhiG+RTOtKmcMRuFdtY9dbTrmdXueskiffWDcCoOfbzHOqxHLgjWx4uK8P/0IUwSEgtlsw6dBxjplNmgGBw2m3K6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWZmddWHnRH0PY461HRwWNEaAt2hgln0m06UMmB7u6U=;
 b=siEzJPaQKPlNl5ulXlyopziMhoHP2LH5aRdeHCc5ZBIzpJAXw4fH9AhnLsDGLuKy+qMVvkVwRvSyD/uZ9iI5xAthej0p9B2G8GWCKwMCK076TFWb45PNHDQqq28LC+HXPaKNraqIEJTj6CkFCdj+beMmpNX9LSqb+hkCZoq+nbA=
Received: from CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9)
 by CO1PR11MB5043.namprd11.prod.outlook.com (2603:10b6:303:96::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Mon, 20 Sep
 2021 10:47:14 +0000
Received: from CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::5137:b7aa:4740:1018]) by CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::5137:b7aa:4740:1018%6]) with mapi id 15.20.4523.018; Mon, 20 Sep 2021
 10:47:14 +0000
From:   <Kavyasree.Kotagiri@microchip.com>
To:     <alexandre.belloni@bootlin.com>
CC:     <Ludovic.Desroches@microchip.com>, <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Manohar.Puri@microchip.com>,
        <Madhuri.Sripada@microchip.com>, <Nicolas.Ferre@microchip.com>
Subject: RE: [PATCH v2] ARM: at91: add basic support for new SoC lan966x
Thread-Topic: [PATCH v2] ARM: at91: add basic support for new SoC lan966x
Thread-Index: AQHXnlICK4tJGF9um0OyzDxKZPeipauoVqqAgAAOjICABGRUEA==
Date:   Mon, 20 Sep 2021 10:47:14 +0000
Message-ID: <CO1PR11MB4865E29F8FDB5C87CCF5649992A09@CO1PR11MB4865.namprd11.prod.outlook.com>
References: <20210831102138.2476-1-kavyasree.kotagiri@microchip.com>
 <8610dd7a-a6eb-0c65-f66e-b4f9fdbce854@microchip.com>
 <YUSnIfzWpQ+YGWkB@piout.net>
In-Reply-To: <YUSnIfzWpQ+YGWkB@piout.net>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5795a19f-a09c-4236-d6ed-08d97c240202
x-ms-traffictypediagnostic: CO1PR11MB5043:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR11MB504324C784B650AFE30F007692A09@CO1PR11MB5043.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hYAMNrlGVbcS4+RyBC5SPgrRs0Y6XNUMzDpwrrGpNDHOp2cZNgQoH79csYvMGDrEWtgxYsIsBOby/0g7rYFKT2Q5WU9/JbBQ38jmK10YGtb6yWhXRIzd0D0gKZcyg1glo2YfYgdOGLpnp62J0vLjdzA9GZTskJrqQyQOdsoJwxG2pGSl/fGIqfEzsPxyKUSEfBCjI0Mm7LkV0X1x9VCBoAMf0j/Wqd/BQb6DVeFFTYfc3HCoo6Uf/loEwMPhz/PairjjVA6XxWEebwlNo3qcyJj2nlmfIE7f0C5OzUHor2ayd6Q9TLLWshExtdmkCD5yLAsgC/Ww+hbfi2tEtyYeXNdaGInk3e3Llgo9VJTtNp1tzVc/iGEf7zy6LsiVuSRqzUz+UEAA2x9GVHSeOhKBZyrQgzcs27m528kladoXSXBRXP7eTimBdX1ngcmMfB0LUn9YOEVahtVrNGhes30sEfPxdWiqbOVdj3ow418q+bFnsPSTDDoAX3gYFZH1Ls7MafG96dcl5pDBUgleqDhPCZAK+ayOtyBHTGItLUPiC0RnKVliF+52ZIZPEbNYddp2vl9afrPvvEqfQhcXsihWaOsNnOhHTCrhHcP+yb/219D5dcCtJa52EZ8BhAfUoj4KSjRp+lU8j3ojmF8gGB2tGh+EjegO1xXyeQkQG3knK9K+xHqeBU1Zq+NSh0rVRWu5348XGBPIsT4KBY9AKLr1O2xKrQQJd8yP0HHGGMK6wwZj4j62xw+msMk8NC5pGnhefo/qNdKnXdiL4H2pIvFyrKRbbD87y4jHsNcjgqLc6kw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(64756008)(122000001)(38100700002)(33656002)(66946007)(66476007)(66556008)(38070700005)(83380400001)(53546011)(86362001)(76116006)(66446008)(54906003)(26005)(6916009)(52536014)(107886003)(9686003)(8936002)(8676002)(2906002)(5660300002)(4326008)(71200400001)(7696005)(55016002)(966005)(6506007)(508600001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aKKVA0CpHW2PGzDGRtMSiISCPpRPqPAKtD8R9XyzkyQjxHqBTM33VcrHMkQm?=
 =?us-ascii?Q?Md6u8AJOsW2qfWey1VoTxo8n1CMHN+mWdz8w/B8uHJeP+gbcNIezenJx6xhG?=
 =?us-ascii?Q?p7jHdcAS0gILh3bn5lxlIcylVpo+eBd9SXk6Jb9BbwE4V+sUflNngpYIBSmn?=
 =?us-ascii?Q?ExGQ5zKTgbotmfwSFbSvpTrxolzib3ftSYkXZ+WBYKhn/D3RDp4igtIBfWkD?=
 =?us-ascii?Q?tG4HXC8j9fwb65ln/K9Zj1R2BNtb1XqW1qNSwSDa0hOduqTb1nHS+2TLsOq3?=
 =?us-ascii?Q?nnVu115XcJqdfCXVXrcM6OkaY/MMATBztsaAf8kf6wVI9U32mZCPKinF717q?=
 =?us-ascii?Q?P/yTpFZ/LOpUBQj5udEskPrOJLCpZrSM0c6MtAmDNbTxbeX2rStFDbULYO4D?=
 =?us-ascii?Q?5sVox6D6hVBAmdWWMFrio2UUfnBk0gucry6/pX+ReQe1FlS33itAQOjoEC0d?=
 =?us-ascii?Q?C+owfNXeb6nRuZPjcPouNJuJe2ZH7JEeiB79g6rQe1NPhDqqILTKcojLF9pI?=
 =?us-ascii?Q?S+dXujNI+v67/xWGaRmneXW54ynRnPoiNFxGJO0J4X4AIGQzB6FUVyO3Djhc?=
 =?us-ascii?Q?7vhJEuvYQ2mXa+B6TvlyrpePrAG/bWd4NU0P6lWlqVv5fc7aSmag2t5Urvgs?=
 =?us-ascii?Q?Vxwhi5lK5lO6ddElh7atAia3RXcdJQgR4UJZ/jBxblox7MyoiQ2eAy5lc+Gp?=
 =?us-ascii?Q?jxTTi3AysaNvVLlq4ALlDMxmJSj4vlb+16e06IyrboyQT2R6j8FuOrEj1z/X?=
 =?us-ascii?Q?iN4hpg655DTjQnPFVki9i5U4iBG/RIHh9hPx8c+2s2yc6+utyW/bqTyZ4Gd2?=
 =?us-ascii?Q?74LQL/WQyFx2QwAqkWQItNQc6hOouoBed7rBjjW8huvueAGxIj+iQBW8KGHH?=
 =?us-ascii?Q?oV/YwTyDEuNZ5L+lra26ymyIAhogHRGEZWKZN8falNW6wBGBEaoWiTs3Tnqa?=
 =?us-ascii?Q?dbfXXNP+0+6eimaBpMCXW8KDIUNrkouZe/95XJOgjD3HI8uLDTnsTtbzPmAG?=
 =?us-ascii?Q?37ce9n7Pm6K0gdJUC1j4BHDH22ZZ4AcXGAIT9a5ybhkYkza3K9tVuBxzPqha?=
 =?us-ascii?Q?P9FoFQpZ891UeXHJoZzpdomJpts4dXD+l0dApk+OnxMKnb6z8/9gU1lgfkEl?=
 =?us-ascii?Q?Kb1KxI/YsGKVzg+UndILiicF9ictYSEegUx9Ipv/yE4tvbecptFB54gR3dT9?=
 =?us-ascii?Q?EZ/sE7U4wWdh3pBVkY9/+8dRLwMLJbtSU5VKQUu3Si2MwoHjHAZWHyeeswQx?=
 =?us-ascii?Q?AqPz/6+h0zD+RnN0+9bX7RG+8bRTAcRnIXuW0AdldtG0B2iJOqYlRdyTud63?=
 =?us-ascii?Q?+0M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5795a19f-a09c-4236-d6ed-08d97c240202
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2021 10:47:14.2619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WocsQ9dBBjQmRoQb6SHn34GeYgoxJpBBl6S2pYbNjLbGMFdaPo8nIDDE7DEV3f0DdncosnlUo5R171Fz3zO3i6mU58d33OrPzNDST22MJYv8JHRsjKhnxfiyzrH4Tzc+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5043
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Alexandre Belloni [mailto:alexandre.belloni@bootlin.com]
> Sent: Friday, September 17, 2021 8:03 PM
> To: Nicolas Ferre - M43238 <Nicolas.Ferre@microchip.com>
> Cc: Kavyasree Kotagiri - I30978 <Kavyasree.Kotagiri@microchip.com>; Ludov=
ic
> Desroches - M43218 <Ludovic.Desroches@microchip.com>;
> linux@armlinux.org.uk; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; Manohar Puri - I30488
> <Manohar.Puri@microchip.com>; Madhuri Sripada - I34878
> <Madhuri.Sripada@microchip.com>
> Subject: Re: [PATCH v2] ARM: at91: add basic support for new SoC lan966x
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> Hello,
>=20
> I wanted to reply earlier but I still have a few comments...
>=20
> On 17/09/2021 15:41:01+0200, Nicolas Ferre wrote:
> > On 31/08/2021 at 12:21, kavyasree.kotagiri@microchip.com wrote:
> > > From: Kavyasree Kotagiri <Kavyasree.Kotagiri@microchip.com>
> > >
> > > This patch introduces Microchip LAN966X ARMv7 based SoC family
> > > of multiport gigabit AVB/TSN-capable ethernet switches.
> > > It supports two SKUs: 4-port LAN9662 with multiprotocol
> > > processing support and 8-port LAN9668 switch.
> > >
> > > LAN966X includes copper and serial ethernet interfaces,
> > > peripheral interfaces such as PCIe, USB, TWI, SPI, UART, QSPI,
> > > SD/eMMC, Parallel Interface (PI) as well as synchronization
> > > and trigger inputs/outputs.
> > >
> > > Signed-off-by: Kavya Sree Kotagiri <kavyasree.kotagiri@microchip.com>
> >
> > Your name fixed with your permission and as Rob suggested in a previous
> > series.
> >
> > > ---
> > > v1 -> v2:
> > > - Removed lan966x_dt_device_init().
> > >    System boots fine without this function.
> > >
> > >   arch/arm/mach-at91/Kconfig   | 13 +++++++++++++
> > >   arch/arm/mach-at91/Makefile  |  1 +
> >
> > Kconfig and Makefile files updated to avoid merge conflict with SAMA7G5
> that
> > was integrated in 5.15-rc1.
> >
> > >   arch/arm/mach-at91/lan966x.c | 25 +++++++++++++++++++++++++
> >
> >
> > >   3 files changed, 39 insertions(+)
> > >   create mode 100644 arch/arm/mach-at91/lan966x.c
> > >
> > > diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
> > > index ccd7e80ce943..06cb425af761 100644
> > > --- a/arch/arm/mach-at91/Kconfig
> > > +++ b/arch/arm/mach-at91/Kconfig
> > > @@ -122,6 +122,14 @@ config SOC_SAM9X60
> > >     help
> > >       Select this if you are using Microchip's SAM9X60 SoC
> > > +config SOC_LAN966X
> > > +   bool "ARMv7 based Microchip LAN966X SoC family"
> > > +   depends on ARCH_MULTI_V7
> > > +   select SOC_LAN966
> > > +   select DW_APB_TIMER_OF
> > > +   help
> > > +     This enables support for ARMv7 based Microchip LAN966X SoC
> family.
> > > +
>=20
> I don't think SOC_LAN966X is a good name or said differently as it is
> not part specific, I don't get why this isn't merged with SOC_LAN966. I
> would have one or the other.
>=20
I am using two different names to represent LAN966 as a new SoC family and=
=20
LAN966X as its SKU's - LAN9662 and LAN9668

> > >   comment "Clocksource driver selection"
> > >   config ATMEL_CLOCKSOURCE_PIT
> > > @@ -188,6 +196,11 @@ config SOC_SAMA5
> > >     select SOC_SAM_V7
> > >     select SRAM if PM
> > > +config SOC_LAN966
> > > +   bool
> > > +   select ARM_GIC
> > > +   select MEMORY
> > > +
> > >   config ATMEL_PM
> > >     bool
> > > diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-
> at91/Makefile
> > > index f565490f1b70..93cfd5b4e6d4 100644
> > > --- a/arch/arm/mach-at91/Makefile
> > > +++ b/arch/arm/mach-at91/Makefile
> > > @@ -6,6 +6,7 @@
> > >   # CPU-specific support
> > >   obj-$(CONFIG_SOC_AT91RM9200)      +=3D at91rm9200.o
> > >   obj-$(CONFIG_SOC_AT91SAM9)        +=3D at91sam9.o
> > > +obj-$(CONFIG_SOC_LAN966X)  +=3D lan966x.o
> > >   obj-$(CONFIG_SOC_SAM9X60) +=3D sam9x60.o
> > >   obj-$(CONFIG_SOC_SAMA5)           +=3D sama5.o
> > >   obj-$(CONFIG_SOC_SAMV7)           +=3D samv7.o
> > > diff --git a/arch/arm/mach-at91/lan966x.c b/arch/arm/mach-
> at91/lan966x.c
> > > new file mode 100644
> > > index 000000000000..154d616569ae
> > > --- /dev/null
> > > +++ b/arch/arm/mach-at91/lan966x.c
> > > @@ -0,0 +1,25 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > +/*
> > > + * Setup code for LAN966X
> > > + *
> > > + * Copyright (C) 2021 Microchip Technology, Inc. and its subsidiarie=
s
> > > + *
> > > + */
> > > +
> > > +#include <linux/of.h>
> > > +#include <linux/of_platform.h>
> > > +
> > > +#include <asm/mach/arch.h>
> > > +#include <asm/system_misc.h>
> > > +
>=20
> I'm not sure all those include are actually used.
>=20
> > > +#include "generic.h"
> > > +
> > > +static const char *const lan966x_dt_board_compat[] __initconst =3D {
> > > +   "microchip,lan966x",
> >
> > This compatibility string will need to be documented in
> > Documentation/arm/microchip.rst
> > and
> > Documentation/devicetree/bindings/arm/atmel-at91.yaml (or a similar fil=
e,
> as
> > you wish).
> >
> > You'll add it to your DT patches.
> >
>=20
> Yes and you'll have to document lan9662 and lan9668. Really, wildcards
> in the compatible strings are usually not a good idea.
>=20
> > > +   NULL
> > > +};
> > > +
> > > +DT_MACHINE_START(lan966x_dt, "Microchip LAN966X")
> > > +   /* Maintainer: Microchip */
> > > +   .dt_compat      =3D lan966x_dt_board_compat,
> > > +MACHINE_END
> > >
> >
> > All the rest looks good to me: no need to resend. It's queued in at91-s=
oc
> > branch targeting 5.16.
> > You'll see it appearing in linux-next in the next few days.
> >
>=20
> Well, I'm still wondering one thing, is arch/arm/mach-at91/lan966x.c
> necessary at all to boot the platform?
>=20
Yes, it is needed as it introduces new compatible string for new SoC LAN966=
X.
Could you please let me know if there is a different way to do this?

> --
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
