Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F4E404597
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 08:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352597AbhIIGY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 02:24:26 -0400
Received: from mail-eopbgr1300091.outbound.protection.outlook.com ([40.107.130.91]:12960
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1352517AbhIIGYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 02:24:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OhtnO6VqMluUGsbN+9sn4Kd6l5oUed+VdK/Ux5e7919DMW/REVao3rnbW5I6/9MGGuJxQK8ri783fxCVYFsNDPxYwmr8zfxZr6erjOLKFSkzsn+IMhOqhTdovvgUKzDayzTBPlvcqCZne6n40uvEwwTAmg/wyc26bIz3oh7VvBCX9/BBSBYSHdrzDA6JdJzqIASFKgplnhIPTdabnFtmW2/nLN79tRPqjfFZPQUp4jAwKt0CmAcPC6onPeaE+mNEsxb8E+PCm0lz0tsDgEvP0pQ/jpCKlPWmaUawDy6VBX706jSS79PfxbQAo3RwNvsHWCwoAXyZyX8BOJWeCQkWWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=vTgP33bSqja6dDkooNdFvDYS/EOfk4jcnWZOm32iEBY=;
 b=eZyEuLgv+FCdgS15yrzVv2gRg6kHHctwr34g0jN4JMk6OunYgnmwtvl8mINcSqgU7ccvkQusw+odvk3o1QO3bt6qF8rKhbBJOIiFmWHv5sQjeZvLWt8F79IRCUPRLwgL5eewHBp9lCkpBStkloeZZ2UnIHmA64N38YAHwie++QIw7mltPi9Y+jKfKWrrwJAHTZ+qL6SaycppVPJNif4jG9sLXmoVBKt7DbM/XsnAXf2UlrU5ObAKWPaiLeuuA6Kkh0ihqV0CXdYFyKq9U+BKEbsIgvoI0UhA/82eXXQuoFH0spsaHN1BzaNwz6du5hEWkVOtCKofPMEJ8b+VDqKBuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTgP33bSqja6dDkooNdFvDYS/EOfk4jcnWZOm32iEBY=;
 b=xcDc86m50YRQf7ECv2kuKdGtrMdsejdDRs/rzoD/rdYs5nChWFSgQYaObncAKJd2kWLN9e5EMefmcbk8KdSqiC1LwpAZ0PBja61QKVMBnDfbyT5w1je/6yOvHsJeyablfm1wzxX8/GC0XEPplURyggqnPxYDZvTeT7+JdeQChQ6yZ+tCoIRINpDT+P1cZnAGipe8T7Io93HzvfBP3xO4y4RFcnaFT3lZvcFz1fDre1xyXtk/ko3OO3pX7o59RS9xrM4e7hOYD4rLhqOIjQMkCjRBBw1rWueO3PlYTfo8z0xulx5DrJhM2iXrEeg/I5Nzpv4giA/tZz84Bukn5b9rpg==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by HK0PR06MB3794.apcprd06.prod.outlook.com (2603:1096:203:b8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Thu, 9 Sep
 2021 06:23:10 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::e129:fce0:90bf:3c79]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::e129:fce0:90bf:3c79%3]) with mapi id 15.20.4478.026; Thu, 9 Sep 2021
 06:23:10 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Tao Ren <rentao.bupt@gmail.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Tony Prisk <linux@prisktech.co.nz>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Subject: RE: [PATCH v2] usb: ehci: handshake CMD_RUN instead of STS_HALT
Thread-Topic: [PATCH v2] usb: ehci: handshake CMD_RUN instead of STS_HALT
Thread-Index: AQHXnuRSuVZoYfgvf0W+qrh69Uwfh6uOsZ2AgAyMaACAAAnu8A==
Date:   Thu, 9 Sep 2021 06:23:10 +0000
Message-ID: <HK0PR06MB3202E3A5457474212F8ECC9080D59@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20210901035041.10810-1-neal_liu@aspeedtech.com>
 <YS8YuX9laah5d/NY@kroah.com> <20210909054531.GA10391@taoren-ubuntu-R90MNF91>
In-Reply-To: <20210909054531.GA10391@taoren-ubuntu-R90MNF91>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 46a063c7-3c96-4f35-657c-08d9735a4bbe
x-ms-traffictypediagnostic: HK0PR06MB3794:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0PR06MB3794C78DA55A0FBA40F6BFBE80D59@HK0PR06MB3794.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AnvXiTK1KKJ6X0DJAG6VoL1xNgzaXFJ5jLI9iIQUrOYoOVW5iquICigVmFbq28bBWxRZdpwaH91Z9/EW4jNfVh5JM4U1awGVdesnvG+Uva8D4zGKocup6lw1+qjR0I/MbEn3iAPL7NVIT+Ih1hRW19QYMfqdej43YMz5MlzS+TJmKpISYbbNslkZ5KU6jO+sz2JajDtsGPMrZGeRzAzLsYHYP9Ax9EwfoiPgIZzqhImjYvzysQykiJA6AZs8ukrYBP4mudR5dm1VVK+uxPlPIMlH9LgavaByePV7SJceihUT2iT4mNAubfBNtJXiG/qq9LGd9NfDHNmFERn4Kux+jHbZ0Gcw7uioFS7/vCl7nC1uu4miJ6b38iFM+aHPrr3k9JADze2bMx4TBEb2lo/y0jZzdsFoZ3BXdSoMOlp+h+rcF15xFge4hhkwSPc46LUHYjQjJedmBjUX9BaBNInLkI8inn+S1TdKVt0vrAd9X5KbjY1czIfvdi23VQOIUnahBMFDykEALgg7/mOOfomepekv9MSAf7X4ipAz3/9bwGqHV7l8IMyuiraBDHS1Txo2tFZRbDW6Fm3h/ftxdsEeurFi4BmZ3pF4BKwX00iYqOSZd/WIUc4Q/ylAfLBgXiJDJ6g4T0bwcJOGKiM104OLJ/eRBfofyjjeMAHKTIJdm3v+53fMeSuJfxmX6tN4jPL7kNy8da1BlUUlAQvlJscejQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(136003)(366004)(396003)(376002)(346002)(86362001)(8676002)(52536014)(186003)(76116006)(316002)(9686003)(26005)(66946007)(7696005)(4326008)(38100700002)(33656002)(83380400001)(66446008)(66476007)(66556008)(107886003)(2906002)(6506007)(5660300002)(54906003)(122000001)(55016002)(6916009)(71200400001)(8936002)(478600001)(64756008)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MtteHL2UEf7FQ1sBTFA9TqYkVOL3+0UFu2kz7HlH3zgnuwN4C9O819+MRj5M?=
 =?us-ascii?Q?lb9vPpoMpWHhDh+Q59gJmyONczuDpSJ+CS4SWlbNceFFeclojdwL8kKUkfdU?=
 =?us-ascii?Q?NpAGu/uJTHuanq16/SEO9GE7Kyzg0+1XokOqQlHisgDfdk2P9gxwc2ACbyAZ?=
 =?us-ascii?Q?cY1BXDmsrxbKn8fUqRUI5e2dRo7TQQLG58/z9GGS0qxrWUSWDGQf596mBHHA?=
 =?us-ascii?Q?1AQR1AVPA9l9sDV2DgR09bm9yeNqJd0f7cWn7/p1Ieu2aLTIeyhBYHDNu2DF?=
 =?us-ascii?Q?uYGD9ptQMKXOXl2NxIwjnJk1qq+ppLa713hJO6wkDX2DrGwaRhRokP8455MG?=
 =?us-ascii?Q?c0IGUHb775+9YVjcj1PA3vTeEVAojrx4OV3H4IlE/gZ13TUgSTB7AXPJtyBO?=
 =?us-ascii?Q?QZD4ju+uSvSIIAEhuKF/uLAudgnpFUOMIZUdp52NJWLMgITqrOuHPI1+dDjV?=
 =?us-ascii?Q?zkponMn7B038P2L4FGHSrNw3jMPZX7OXklxhqZdJk47pkGBwJauXp+NsAA4x?=
 =?us-ascii?Q?McAPoRQD44Zgp31eNoiQkKA9YsvW7kzY4+UtEVT8wdFlS6DAdo+UQvTU1hBZ?=
 =?us-ascii?Q?oDZudBB/CyBmE1T/5IukbcTmev5x74BHHzWxEWFE+nLqK19x3qLe0P68qcXB?=
 =?us-ascii?Q?PebRb2VvugeiMe0Wb8zOxXd/v9wZZztZJ4GWLFXE616MlHVPqzvGPFW6umPc?=
 =?us-ascii?Q?XuvoFbiZsNtjKDeqFEQWgvUL4lGTBxFIRJVeDqd4TmrSEJPay0RnZju1e+6Y?=
 =?us-ascii?Q?U4suzuLjEN7G0yBodqK8jUXIbAg7ujQJaq3lY/KuxZ/wVgKT1dlWYX0NWOiU?=
 =?us-ascii?Q?Jl4n/6qiTZAWgxcV0CvwUnzyk/+7j//Si1u97DqFx77jEBh7rUksuQ/J4uZG?=
 =?us-ascii?Q?5dZsPp/tCy+SF0z/Hfduj6clKIn3o6pPMRvKrTXpiwj58mjZwm5q0GttVXHx?=
 =?us-ascii?Q?ogzKtKtGEvhtsfJFmrl4gk197Ig03ywhtuoHY2LAHFYipgJpnm6ZStPuC2CW?=
 =?us-ascii?Q?T02aiEPMuDrQefXdLB15bIexA3pgJvc/I70paLrAyzQG18tk4WyNPGnFPP+t?=
 =?us-ascii?Q?TP1EdXLrjOYXCCG3BxMgutpo/CBD7ZAX83uGLDU/W84LfcfdIx/u87A+V8kJ?=
 =?us-ascii?Q?QZf6NBn3EVp5xmbM4LK1GZN5tp6+WQDzsGEGDWjG/9/L79BX/nNUDfdOUTRL?=
 =?us-ascii?Q?k23R8p6DN/vwL4CVEo12OYjx97+PHmqAw4vHjqO2c+htgWsljtNWToTuFUyl?=
 =?us-ascii?Q?IzYaUzxncyPWecV3D1xTvDc9XSOhZ2rmP9CDhwJehQp1fXg+fQXSyCXtbuVC?=
 =?us-ascii?Q?BlLBwHxQ3jQKEEU9VQ9m13q2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46a063c7-3c96-4f35-657c-08d9735a4bbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2021 06:23:10.3366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ymiJWvAhx6oLUWs2LSLmKbZ1my4bRUVRJZ4Yz2m82R/LQx50onU5aUP9rVe1mdawsNrHfvT5N7VATu1EkCM9lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB3794
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Hi Neal,
>=20
> On Wed, Sep 01, 2021 at 08:07:53AM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Sep 01, 2021 at 11:50:41AM +0800, neal_liu wrote:
> > > Retitle.
> > >
> > > For Aspeed, HCHalted status depends on not only Run/Stop but also
> > > ASS/PSS status.
> > > Handshake CMD_RUN on startup instead.
> > >
> > > Signed-off-by: neal_liu <neal_liu@aspeedtech.com>
> > > ---
> > >  drivers/usb/host/ehci-hcd.c      | 11 ++++++++++-
> > >  drivers/usb/host/ehci-platform.c |  6 ++++++
> > >  drivers/usb/host/ehci.h          |  1 +
> > >  3 files changed, 17 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/usb/host/ehci-hcd.c
> > > b/drivers/usb/host/ehci-hcd.c index 10b0365f3439..01c022e46aa2
> > > 100644
> > > --- a/drivers/usb/host/ehci-hcd.c
> > > +++ b/drivers/usb/host/ehci-hcd.c
> > > @@ -634,7 +634,16 @@ static int ehci_run (struct usb_hcd *hcd)
> > >  	/* Wait until HC become operational */
> > >  	ehci_readl(ehci, &ehci->regs->command);	/* unblock posted writes
> */
> > >  	msleep(5);
> > > -	rc =3D ehci_handshake(ehci, &ehci->regs->status, STS_HALT, 0, 100 *=
 1000);
> > > +
> > > +	/* For Aspeed, STS_HALT also depends on ASS/PSS status.
> > > +	 * Skip this check on startup.
> > > +	 */
> > > +	if (ehci->is_aspeed)
> > > +		rc =3D ehci_handshake(ehci, &ehci->regs->command, CMD_RUN,
> > > +				    1, 100 * 1000);
> > > +	else
> > > +		rc =3D ehci_handshake(ehci, &ehci->regs->status, STS_HALT,
> > > +				    0, 100 * 1000);
> > >
> > >  	up_write(&ehci_cf_port_reset_rwsem);
> > >
> > > diff --git a/drivers/usb/host/ehci-platform.c
> > > b/drivers/usb/host/ehci-platform.c
> > > index c70f2d0b4aaf..c3dc906274d9 100644
> > > --- a/drivers/usb/host/ehci-platform.c
> > > +++ b/drivers/usb/host/ehci-platform.c
> > > @@ -297,6 +297,12 @@ static int ehci_platform_probe(struct
> platform_device *dev)
> > >  					  "has-transaction-translator"))
> > >  			hcd->has_tt =3D 1;
> > >
> > > +		if (of_device_is_compatible(dev->dev.of_node,
> > > +					    "aspeed,ast2500-ehci") ||
> > > +		    of_device_is_compatible(dev->dev.of_node,
> > > +					    "aspeed,ast2600-ehci"))
> > > +			ehci->is_aspeed =3D 1;
> > > +
> > >  		if (soc_device_match(quirk_poll_match))
> > >  			priv->quirk_poll =3D true;
> > >
> > > diff --git a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h index
> > > 80bb823aa9fe..fdd073cc053b 100644
> > > --- a/drivers/usb/host/ehci.h
> > > +++ b/drivers/usb/host/ehci.h
> > > @@ -219,6 +219,7 @@ struct ehci_hcd {			/* one per
> controller */
> > >  	unsigned		need_oc_pp_cycle:1; /* MPC834X port power */
> > >  	unsigned		imx28_write_fix:1; /* For Freescale i.MX28 */
> > >  	unsigned		spurious_oc:1;
> > > +	unsigned		is_aspeed:1;
> > >
> > >  	/* required for usb32 quirk */
> > >  	#define OHCI_CTRL_HCFS          (3 << 6)
> > > --
> > > 2.17.1
> > >
> >
> > Hi,
> >
> > This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent
> > him a patch that has triggered this response.  He used to manually
> > respond to these common problems, but in order to save his sanity (he
> > kept writing the same thing over and over, yet to different people), I
> > was created.  Hopefully you will not take offence and will fix the
> > problem in your patch and resubmit it so that it can be accepted into
> > the Linux kernel tree.
> >
> > You are receiving this message because of the following common
> > error(s) as indicated below:
> >
> > - It looks like you did not use your "real" name for the patch on eithe=
r
> >   the Signed-off-by: line, or the From: line (both of which have to
> >   match).  Please read the kernel file, Documentation/SubmittingPatches
> >   for how to do this correctly.
> >
> > - This looks like a new version of a previously submitted patch, but yo=
u
> >   did not list below the --- line any changes from the previous version=
.
> >   Please read the section entitled "The canonical patch format" in the
> >   kernel file, Documentation/SubmittingPatches for what needs to be don=
e
> >   here to properly describe this.
> >
> > If you wish to discuss this problem further, or you have questions
> > about how to resolve this issue, please feel free to respond to this
> > email and Greg will reply once he has dug out from the pending patches
> > received from other developers.
> >
> > thanks,
> >
> > greg k-h's patch email bot
>=20
> Thank you Neal for the patch. I tried the fix on my CMM (AST2500) and Fuj=
i
> (AST2600) BMC and it works on both platforms.
>=20
> Can you please address Greg's comments above and send out a new version?
> BTW, please don't forget to include Alan's Acked-by in the new version.
>=20
> Reviewed-by: Tao Ren <rentao.bupt@gmail.com>
> Tested-by: Tao Ren <rentao.bupt@gmail.com>
>=20
>=20
> Cheers,
>=20
> Tao

Sure! I'll try to fix Greg's comments on next patch. I think the problem is=
 the first one.
And thanks for your review & test.

-Neal

