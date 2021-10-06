Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 586A1423ACB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 11:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237936AbhJFJtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 05:49:06 -0400
Received: from mail-eopbgr30089.outbound.protection.outlook.com ([40.107.3.89]:63926
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229824AbhJFJtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 05:49:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXVfZLzwgHgV5nnXqM0a01MH7aR0rr47Pm4NN1p+0Y7u6AfAlZo48zISL0DHFHjlrJ0r3h26qvA5BnjEahNhTOvJ/GRMrLcu4Xnc0uMp2ZBmMenju7mXBPxI4QvfRunFDyujHbYVNSDxmKJBIGBipqu0eIzgZuKI27Y/V4X4NWoNfl+ojqiardrYzfHy49vWmzoEmu5SE/DuBrDS0msVpntXIAji0kicg+CMW3yPEa4Cf/iiNUSaFyjD45dnNJd+mudlELzFC3WhjmzW7RmvL1r55Jptqy4QkqribjAXYyIDpiBTYpfhxwjoNtOSIkvCPB7QCOhVeWMXlzYeP5u9FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Tr24d1whMGKqpMw+JLOvD4OuCuP/4pjHdooq+d33Co=;
 b=gv/tn+D3XH67YX4Ve9+1JQe5JTeIxl/bAkNTzPvh7Bbo3EcK0Tt7Jy/TwArSJRi/9BGHk+gOUxnBLhKW5ZIlTxTOYqtmvWzqlnZEVEI5DKelLRKQb7kE2i4r0DrhNLEptmNHU8XKkUkXSK1+92BdiCNids9dRcGiw3xN7KcPcra/DyAbKpe41UZfw0NI3FP2BpPlcSDIZA2Zy9emMEOAaHtwni5DiT2QQ78ssO6bn2bteZ7mVQZd1edjyeoPAsDaic26vlqM0KkrK3UOYtl8Di1OY8PYqaU+edbBvmGjcK/IYc9AnRarJs90n300FyB4MyereFgxOz4F6JCdMmFCCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=asem.it; dmarc=pass action=none header.from=asem.it; dkim=pass
 header.d=asem.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Tr24d1whMGKqpMw+JLOvD4OuCuP/4pjHdooq+d33Co=;
 b=KUrADKCjkn2m/8loHDXL6fY2ATaOPN8vJL33vRFzPw48UQ/RRFNZdvsNIPjH3di/ll0TXj8gQYwBGKWKhzx7y2nTq428Te06pwKUzNBXren9ZTytFasq8Sf7RqpmgYEdJh5NRK7TzqYcLsiIh09ZX7kewxoJNeX8njWlyF2tmWU=
Received: from DU2PR01MB8144.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:27a::19) by DU2PR01MB8142.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:278::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Wed, 6 Oct
 2021 09:47:09 +0000
Received: from DU2PR01MB8144.eurprd01.prod.exchangelabs.com
 ([fe80::f9ae:d9f5:ca8f:8ab2]) by DU2PR01MB8144.eurprd01.prod.exchangelabs.com
 ([fe80::f9ae:d9f5:ca8f:8ab2%7]) with mapi id 15.20.4566.022; Wed, 6 Oct 2021
 09:47:09 +0000
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Alan Stern <stern@rowland.harvard.edu>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Chris Chiu <chris.chiu@canonical.com>,
        Rajat Jain <rajatja@google.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] usb: core: hub: improve port over-current alert msg
Thread-Topic: [PATCH v1] usb: core: hub: improve port over-current alert msg
Thread-Index: AQHXufwIZA72+JkV70mKLonxSYksHqvEijuAgAD+vtA=
Date:   Wed, 6 Oct 2021 09:47:09 +0000
Message-ID: <DU2PR01MB81446E4F9959627F838631B9F9B09@DU2PR01MB8144.eurprd01.prod.exchangelabs.com>
References: <20211005151644.288932-1-f.suligoi@asem.it>
 <YVxxjUZDh8abDNjc@kroah.com>
In-Reply-To: <YVxxjUZDh8abDNjc@kroah.com>
Accept-Language: it-IT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=asem.it;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73278940-f9f3-4cce-6c03-08d988ae43e6
x-ms-traffictypediagnostic: DU2PR01MB8142:
x-microsoft-antispam-prvs: <DU2PR01MB8142C70053E046B0DFDE0DF0F9B09@DU2PR01MB8142.eurprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cmNZXDl2J7H5qR7IhQ+8uKjgVUv0y6n0uaYMabI6qPsgOgRcvAibPdxejo1Nd2x3+Ql1DpTKAcR4tc8NXZqQhbUfpKLcXErK4uisB12qRFJjrhdbyvn7xFbwbHOcjfUd9CHR/6UIAE2IZe0OrnwBm/Mckvf//I1Xg3j70rpbPMRYfw5FIb0UqJvqjdk9CwSqQbbMVG6kti8Ypkpd2PO4s3IflaxPsKIlV80BFBWCNTF5NwNEoF6r1NkR5RJLfRqj11EfoJ58Qun7032ECTtwVLTUBt1ZxyClxf4w+SZJ+TyDHpKvDV9oQm5ETdb8K09xvmxrJdc6C7fW9DstIsDDQJq8FQO41ALtV5HdThEZFRf0IuZ5teHAh4yVJxo7J9EMpjWrndia1MBqRyjT21/5ScK/Y0ULd61K7EPvNHJL7Ex+YKkjlg+ehYGxeSsPFQIbjvGCfQvtsIjLegWxkzRcSDDYgTT1hDIRtRv6vgcVFNbOpRe4l4r3FKqnBHtBnn7JEKec90+yvIINQiyXeybp62xRFdELgZdxnBweV/TZPPmLGamQ1R10qATkELWpaNVm2LtXodotaBF3AzfSOr2aQBisUq6YmCU5HtTB4g9xO/hwgvwP36qG+Ekp9kXwjN9EFikawelikVicQuHAl1CFu72ETQUgEJW6y/SNDOERNauuCewRIVv0cg5L3IUHL0VTxkf80vicGoojQIphOjwH2w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR01MB8144.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(396003)(366004)(136003)(39850400004)(376002)(346002)(316002)(71200400001)(4326008)(38070700005)(54906003)(7416002)(55016002)(83380400001)(15650500001)(9686003)(86362001)(122000001)(52536014)(6506007)(7696005)(6916009)(508600001)(186003)(66446008)(66476007)(64756008)(38100700002)(8676002)(26005)(66946007)(33656002)(8936002)(2906002)(76116006)(5660300002)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UBjwZNwaoihj2kQtYEgn5G5EUh/dZS2kBNEtjAc81aM/FOPdb47SkE7ki2rM?=
 =?us-ascii?Q?p4EOMcg1gTDDM/K9c6A2zNpTmFhWdptarEWpdTJ3ExCIbqiyPS4OOR1FL3pJ?=
 =?us-ascii?Q?vZqoAXDfezTBAoGUgnqZx4g7oEDbdJOcRVcDPSQbG00fgpYj3u5Z25br3pz/?=
 =?us-ascii?Q?v/dgZQgGDv3pQwG4uU+T+8oY3g5vKEn0R4FMiQ+RnLnVSIxqjywb46sHAbaA?=
 =?us-ascii?Q?FQc70zzcgaZP1UK9YfEObl5WWyvhBXnXTCTkV/CRvU255KWOCglnRNWVVrCA?=
 =?us-ascii?Q?vdBj/WpoDhSAmQpAIh3Zp4psVaAx3ilPviylsrHB0v2JxHQxUeV/+7CHhs2f?=
 =?us-ascii?Q?hxvEa8stDrWlPp+jzxmPCDhB76G23Sj7axUdkS9fOIWbJinB9VMyhlVe7m3Y?=
 =?us-ascii?Q?El6/xRQgNhxQgIbNaYATqMG5E0RI70Kfd3KA+ixbwvPI8cXSrH6lueOH7z7r?=
 =?us-ascii?Q?+LhAzRYdx8+nrva8It+3tW23p6TW1b4zPwx+TDa35oFgMe+FhsSOU3xJCULY?=
 =?us-ascii?Q?hSiH9X7tY/Zzw1d/0WIqJx0114RH0m0Ix4nAlamM5sRBJl55kc/I8ZWseTbA?=
 =?us-ascii?Q?oys2DIp9Ka5ZWcmXlspBEs43Oc03ZCTsevucVdTvYo/INIARgvDNoVvRAg1L?=
 =?us-ascii?Q?9gZHSEURCAI64H30sQ/rakKWmXVIDjqCxM/X0RCdoRSTGifeB4TMg+6sDxSM?=
 =?us-ascii?Q?hA69TgP9AJIfT7pzOrD1/vV/6MingW2lP0IYlgikSPQVB2ezmRp2XyjyF4+A?=
 =?us-ascii?Q?qyj+ERO5Kacm4bJH/VIppemLjV1qYgALnKlzonCXyaq+ybUp9Ml4Zhec/4Gb?=
 =?us-ascii?Q?FMq25pntNnRXjkIZAUiwiNbpmygF6gEpzAZsfSUoKHNyFJ9bHP/JRNNOS8de?=
 =?us-ascii?Q?jk4BOzWJ/ralWx0rFjl5IfGRAFdT7FrT+MhpDQdWs/WtapH4V0AvzQydILL5?=
 =?us-ascii?Q?07xleMWci8jzzcYwDudfAzb9K49JnZ29b6Znv6EvaZvX48wf0SPYZ2KAFGsT?=
 =?us-ascii?Q?fI7n78sTK/a2gT1G2bvDWgEy8yzq7K+E1RbLA255iu3kyPchy6pJiWVs/IPp?=
 =?us-ascii?Q?2D3NX66n1T8u4Be8M0ir6PqVsstQgvDhzqfumb6piGoQ6QmfUItd2qBY7w7s?=
 =?us-ascii?Q?WVgUqaVDX9npLV3WF8Dgdo4uSGGwRf7IThhzGYRUYTnQ/xmUAPm2ChIKyMi1?=
 =?us-ascii?Q?gFNNbXdlye837iNwqaC3z0bk9HhX579siGFBVxg2UPegZvMfEDW0QHp6Qnd4?=
 =?us-ascii?Q?Hx3EhGB252jjYkdRFwDoiS4algMaL68fHR3F2nOGj3ekiE7KXv/VbtO3v59r?=
 =?us-ascii?Q?OJI=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: asem.it
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR01MB8144.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73278940-f9f3-4cce-6c03-08d988ae43e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2021 09:47:09.4238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d0a766c6-7992-4344-a4a2-a467a7bb1ed2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u26a6nMJS0NnojY84iYPIBj+Q6Wxu5q70bxyBU9wq0egJkv3uPMd6ZRAIC/VQFD/dO9yLUF+gHXpd+o7/+q3vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR01MB8142
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> > (such as the TPS20xx, etc.), after the over-current
> > detection and the consequent shutdown, return
> > in the normal state.
>=20
> Please use the full 72 columns of the changelog text.

Ok

>=20
>=20
> >
> > So, in these cases, the over-current error message
> > never appears.
> >
> > To overcome this problem, the "over-current condition"
> > message is displayed even after some over-current events.
> >
> > Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
> > ---
> >  arch/arm64/boot/dts/Makefile | 1 +
> >  drivers/usb/core/hub.c       | 5 +++--
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefil=
e
> > index 639e01a4d855..bf26ce60d78a 100644
> > --- a/arch/arm64/boot/dts/Makefile
> > +++ b/arch/arm64/boot/dts/Makefile
> > @@ -8,6 +8,7 @@ subdir-y +=3D amlogic
> >  subdir-y +=3D apm
> >  subdir-y +=3D apple
> >  subdir-y +=3D arm
> > +subdir-y +=3D asem
> >  subdir-y +=3D bitmain
> >  subdir-y +=3D broadcom
> >  subdir-y +=3D cavium
>=20
> I do not think this change is part of this :(

right, my mistake, sorry!

>=20
> > diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> > index 86658a81d284..ff6c8e0e2673 100644
> > --- a/drivers/usb/core/hub.c
> > +++ b/drivers/usb/core/hub.c
> > @@ -5577,7 +5577,8 @@ static void port_event(struct usb_hub *hub, int
> port1)
> >  		msleep(100);	/* Cool down */
> >  		hub_power_on(hub, true);
> >  		hub_port_status(hub, port1, &status, &unused);
> > -		if (status & USB_PORT_STAT_OVERCURRENT)
> > +		if ((status & USB_PORT_STAT_OVERCURRENT) ||
> > +		    !(port_dev->over_current_count % 15))
>=20
> What is 15?

It's an empiric value to have a message about every 1.5 - 2 seconds (100ms =
* 15).
Ok, this value is not clear; I can change this fixed number in something li=
ke this:
...
#define USB_OC_COOL_DOWN_TIME		100	/* ms */
#define USB_OC_REPEATED_MSG_DELAY	1500	/* ms */
...
...
msleep(COOLING_DOWN_TIME);	/* Cool down */
...
    if ((status & USB_PORT_STAT_OVERCURRENT) ||
        !(port_dev->over_current_count %
           (USB_OC_REPEATED_MSG_DELAY / USB_OC_COOL_DOWN_TIME)))
	dev_err(&port_dev->dev, "over-current condition\n");


>=20
> >  			dev_err(&port_dev->dev, "over-current condition\n");
> >  	}
> >
> > @@ -5738,7 +5739,7 @@ static void hub_event(struct work_struct *work)
> >  			u16 status =3D 0;
> >  			u16 unused;
> >
> > -			dev_dbg(hub_dev, "over-current change\n");
> > +			dev_info(hub_dev, "over-current change\n");
>=20
> This is just going to be noisy, what can a user do with this?

Right, it's a redundant information.

>=20
> thanks,
>=20
> greg k-h

Thanks for your time,

Flavio
