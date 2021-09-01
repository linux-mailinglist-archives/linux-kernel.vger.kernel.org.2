Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3013FD160
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 04:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241632AbhIACfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 22:35:34 -0400
Received: from mail-eopbgr1310109.outbound.protection.outlook.com ([40.107.131.109]:54912
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241128AbhIACfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 22:35:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IcP1B1QQNmv+lEz0RA2xPV89czOCdfwmVkt3wpPZICfSrH4etgGSnVEP6fj0ioKQwlVZ0i1uqjjU/wXfk0OHxUyAQDH9F8fZf98lY04wQYqjaji1dPXr54lgy+aHcZfCDjPf+9vD789ed73mhm852cs42tatL0Dmay07s42UHhxPADusc6S5+N6yiLveHroL49I1TDA9waxJ4mKoy3wcFeU6KePDaS92IWf0kMUASgYsUiBD6C5mtzbDvykkh3i62doFSmWP7wQ0L9xAoyshpbli765+kCDmWoQDx23zDGkOEEOLmnBKdeuEjzV922S+KfMhXAsaVNQyf3pBoL9wzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4NVkFtGhDQetLeWI4h9p8YGqAUM9LIzoEYOgVzu/DTc=;
 b=UxgXxLkSl7bEPcM/iViZ+8EeurITdauPqT+5VWqvfwxmldTBTgZOEVK8RNJJbtZBPlRyJbhhFBsAomqIPobcNhpBDuvLs5mF8ZgJ/aZ6fnylw2mRV9opD1BeC+HCiJbWiRs6BR0fvyN5QLAgAUbTmdhBT23LEYX365IkCQ/vWbk6aTe4PQiU3e+E8gR9RR8R3+7aOnFXCaXv4ERFWF7hL3T7VVnWmE9YvqjJgoQB5PVXKyPf+3TtaOWkao4FmDOG68j1qAVL9BBYitUUWGcqQJEgFjttG4EKaqlQS+ec2oCTGZ6DcxQ5uQxRTE3GDgN8moR1KHj41xPN+Dc2ZRvPdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4NVkFtGhDQetLeWI4h9p8YGqAUM9LIzoEYOgVzu/DTc=;
 b=KQ8QwJ1yeQjStiPslgwb9aCqCFgYS6NiwaVI2mNWnxGLneAcd/b3eAs4YcAquu0uVz2ljxcBWFVFJC0k7G4WAqZkbIZDTnWIghH+xyq+dxHFPKDzSps4Gk+DpL0fvZQ1AFBiU3MtsO2K5Nqed9W904VGWOlxLlubhBGFMN2iNLkvEPuSxTj2e2FWqQA11YY/hLq37eABQ63zDAvSgEgOQmzNLEF5Wgz+5Wd0ySYxosEHV1B1vEC+3kW7kHJFwgADbE1GUMbsaEWrjwDhAkqhEFvmVuLA85KGc8QDB3vuDxANtb+6KKBGHYLqDOrA5z6YFrOQoIGet4HSFGyBeGS9nQ==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by HK0PR06MB2419.apcprd06.prod.outlook.com (2603:1096:203:50::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.21; Wed, 1 Sep
 2021 02:34:32 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::8425:37a2:1ae0:9674]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::8425:37a2:1ae0:9674%5]) with mapi id 15.20.4457.025; Wed, 1 Sep 2021
 02:34:32 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tony Prisk <linux@prisktech.co.nz>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Tao Ren <rentao.bupt@gmail.com>, BMC-SW <BMC-SW@aspeedtech.com>
Subject: RE: [PATCH] usb: host: ehci: skip STS_HALT check for aspeed platform
Thread-Topic: [PATCH] usb: host: ehci: skip STS_HALT check for aspeed platform
Thread-Index: AQHXmkn/+OFxJTac2UeWzgoF+9FcjKuF6XAAgAiU45A=
Date:   Wed, 1 Sep 2021 02:34:32 +0000
Message-ID: <HK0PR06MB32025ED058C0461FDC5BFBBB80CD9@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20210826071525.27651-1-neal_liu@aspeedtech.com>
 <20210826152824.GC228824@rowland.harvard.edu>
In-Reply-To: <20210826152824.GC228824@rowland.harvard.edu>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: rowland.harvard.edu; dkim=none (message not signed)
 header.d=none;rowland.harvard.edu; dmarc=none action=none
 header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a10b3d75-f480-4ffc-c38a-08d96cf107fa
x-ms-traffictypediagnostic: HK0PR06MB2419:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0PR06MB2419FF998F6D7A2099D6B88080CD9@HK0PR06MB2419.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:785;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lRG1KgJfCOfKuNcnVaf8C2KbJ0hMs4j8BhomEEnVv6IRTrwYhsMsn59sDtvu10zD1fkw+oiZJ3YYJhmwASwNTCeO0KhIRWg5OLDEtvL4cVpoJs/AZ/2LffIXBWSxy4OsdBwk5Zgf1aKsL9bkofsp2P43VqZ6k0sF7A5buHOzHviCTMmTnkQc8aCinrjgq32SguGbwwhlMkGbKZdc+6f35mvGqIEkj1131R6+mhi45BMcHsYEaFPtdIMUzMKOVvk8bkbTdys1i1ZsvrQGfuV7IPHR7VbEw9cf+u8SsQIMe86D4kyOoXShiIE/caJ+Pxke6M+nda3oJMsgX9vOvD6NPd7f9FRNSBKcuLJ97uYxswa/JGhwVtV7XMJZuai1OrbeUZ9s6xTvO6RzXQPT+lJNUxk2YyGq9QOaiMlEt0xThi+FLBCDaq8VjYu0gKZx3B5WRmWhx53b87hwdGqR1PmrvNC1ItihzjMPlLreILNT62MZyKiRq0pwlM35u/Xf46vkJAowZYM2zvoA+F36lsjRr2KWt2bCaeDM05U5nra9on+rPMQZNjTFgO/DvSOMZN462Gg6XNFwaHYVqNyt4vymf/RSi9tj4Fogkoxaxiyx6BH2uT/irIRb6/D2LaP8lZsj8QZAkWcLaPwouL44Xj4lDy0yJVTd1Ci8ho1x6xCU4A1rNPaA8EC5GYLFKVhyW5yulIg8I6MeFcFHXNHjoaSm6g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(346002)(396003)(39840400004)(366004)(38070700005)(66946007)(71200400001)(76116006)(9686003)(55016002)(316002)(33656002)(86362001)(2906002)(7696005)(54906003)(66556008)(122000001)(53546011)(6506007)(26005)(186003)(107886003)(38100700002)(8676002)(6916009)(52536014)(66446008)(4326008)(508600001)(5660300002)(8936002)(64756008)(66476007)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EWx/E0aGAqlnQdtIp7EjzPYHV2I4Mp1MiCLOeoYvEP7Ps11Hh1IhKVEJoMrF?=
 =?us-ascii?Q?n5goykJu42BYx/eusduf9UvyHjBZcxWxtsxkbFys17Uyz3Wrrj/5fkc9xdsQ?=
 =?us-ascii?Q?NKS5XJRZqKfeSVLdUTxlmgX+pcNAUwJjglLFz6wO0/9udz6wLYpZaw/n/qsT?=
 =?us-ascii?Q?4tTGBGSYiJ1B32WV0fVpQkROQD+G1oQ7evM3v6Df3Dj+Lip4CZlG0wp09AoN?=
 =?us-ascii?Q?NXvDgTUlUWVpEmNalNdCCoeHMNlXtIULMvZP+MxNRtCH7HkZBpxGr5VePtXw?=
 =?us-ascii?Q?X0ypS92sHOQ40hMeCYc4wu/UlLU1uBwHrn4A8VCb9+bx3sq1oEACD8cwdd0P?=
 =?us-ascii?Q?4fxClRfL7dPDdDs1EIWxSGhzTIsM+qDNLpMagYoG2PwgCfqDh4c9JAYwAS+y?=
 =?us-ascii?Q?iBqGtFHd/MAvfIQGmkkk1saZ6i/efxDoX1E8NPEdoIe8RgX/LRwywls4KtHj?=
 =?us-ascii?Q?ylU2A5esWXvXuVMt9V4p4SwESmIrhQM8UoOYhchQqI7kQQAbbJV03iK4OJmC?=
 =?us-ascii?Q?0EITSvhP0xNgzIzwfioSTuatOUtnCq6JHPP//g+M8tdQr33YG8HmXpOH43VM?=
 =?us-ascii?Q?7ATG0APzefm4sesKyEMQ/H3gNSHWQhXCvDYL83GbApgXShlQWLAEGjEzJmj/?=
 =?us-ascii?Q?CT6lRlrzuLAhDVch+ET0966PHx4YyzIbb8LrVp4HEPxWMi1X+8sW9eB7izI7?=
 =?us-ascii?Q?454mXdl284M9Lh5vcWz4zBrkA5kL46wwe6ogI2EDhXpG+FS3vbIKoDIKBJzh?=
 =?us-ascii?Q?/0nAjYSxNA5HaPFbOV8xaekbO+B5rAh6WsRo22j56ooQTdGTeMHJdTub+5sR?=
 =?us-ascii?Q?T/YGckVgxYUI8zgXL9vWMPoC5BSFKc1FsA4GmMyCfm5JIzQQI3rpyBKhaJvz?=
 =?us-ascii?Q?FebSp1on7+R29628nXMLUiDPGgP2L+xO0jabrMJoCVUAKJ86ADbaqhoJxIEZ?=
 =?us-ascii?Q?xwRglNeCJUYOKnyTjmb14CIt0fmjRDS+kKZWvqMTi6mQICFiWC7zeyHEHX3g?=
 =?us-ascii?Q?her8xoNOlE28u10+WcTKnPYsgVTk13NSoiyhKheEQvD+d5y+YGQvoRYc+ikD?=
 =?us-ascii?Q?pziJteCqHaGFcO43z2JbV7NlhIgRb0d7C6RSvxf29EYX4Ddelk9tgNhJE5Md?=
 =?us-ascii?Q?LPutLVNYvQ3o8Fe1ABUkK+MxbGAyPrmexYUyNDA8uKYk8J23hJq2LylYRRbg?=
 =?us-ascii?Q?ozBQonLkyLZ5B++uzfzk6jAP8yoErjxJ1mB1E9AuLpMCOlZIvcxlaW1XnKeB?=
 =?us-ascii?Q?WXFkxsWQzLmzpaw+i8fTsF3BNDej6TOq7PYLH5TeJktygoe6GqmuLDA+Q+lM?=
 =?us-ascii?Q?VduV18aQiC6LYyPxI6WTeAlJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a10b3d75-f480-4ffc-c38a-08d96cf107fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2021 02:34:32.4779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pIjmBtFaW39IpiITK0vaEMqo+Gpee2/5dMlh0vifcXoxqLdjdA5JzncNzyw2fBLqdAsqOAoW2lwPASW9aRrz0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2419
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Alan Stern <stern@rowland.harvard.edu>
> Sent: Thursday, August 26, 2021 11:28 PM
> To: Neal Liu <neal_liu@aspeedtech.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Tony Prisk
> <linux@prisktech.co.nz>; linux-usb@vger.kernel.org;
> linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Tao R=
en
> <rentao.bupt@gmail.com>; BMC-SW <BMC-SW@aspeedtech.com>
> Subject: Re: [PATCH] usb: host: ehci: skip STS_HALT check for aspeed plat=
form
>=20
> On Thu, Aug 26, 2021 at 03:15:25PM +0800, neal_liu wrote:
> > STS_HALT also depends on ASS/PSS status for apseed.
> > Skip this check on startup.
> >
> > Signed-off-by: neal_liu <neal_liu@aspeedtech.com>
> > ---
> >  drivers/usb/host/ehci-hcd.c      | 10 +++++++++-
> >  drivers/usb/host/ehci-platform.c |  6 ++++++
> >  drivers/usb/host/ehci.h          |  1 +
> >  3 files changed, 16 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
> > index 10b0365f3439..a539e11502ef 100644
> > --- a/drivers/usb/host/ehci-hcd.c
> > +++ b/drivers/usb/host/ehci-hcd.c
> > @@ -634,7 +634,15 @@ static int ehci_run (struct usb_hcd *hcd)
> >  	/* Wait until HC become operational */
> >  	ehci_readl(ehci, &ehci->regs->command);	/* unblock posted writes */
> >  	msleep(5);
> > -	rc =3D ehci_handshake(ehci, &ehci->regs->status, STS_HALT, 0, 100 * 1=
000);
> > +
> > +	/* For Aspeed, STS_HALT also depends on ASS/PSS status.
> > +	 * Skip this check on startup.
> > +	 */
> > +	if (ehci->is_aspeed)
> > +		rc =3D 0;
> > +	else
> > +		rc =3D ehci_handshake(ehci, &ehci->regs->status, STS_HALT,
> > +				    0, 100 * 1000);
>=20
> You must not do this.  You are assuming the controller will always begin
> operating within 5 ms of the time it is told to start.  What happens if y=
ou are
> wrong?
>=20
> There must be some way for the aspeed controller's host computer to tell
> when the controller has started running.  Find out what it is and use it.
>=20
> Alan Stern

We can check the command RS bit to tell the controller has started running.
I'll sent next patch within this change.
Thanks

-Neal Liu
