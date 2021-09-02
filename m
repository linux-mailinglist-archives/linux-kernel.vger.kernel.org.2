Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 002353FE74B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 03:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbhIBBxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 21:53:19 -0400
Received: from mail-eopbgr1300090.outbound.protection.outlook.com ([40.107.130.90]:51328
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229910AbhIBBxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 21:53:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BdbcFXwGus4rjG4Ni424YZb0pqLwtC/HsjFjCaK8AokGtD3y3zoNqf/FIAamlufUOfxaFXWnrMa+4sh7gJMkXhkfXUTj3ERlGxaJZPL8rehfE48jC+0M6GjSLeROwE/7w8fuIFZ+eg2YM7iDPaLg4Pby1lJrTZprlicrcXHYcOeTFygfOld3uiDi+LNvfFoiNLy5bM/d0lGCFhPIoQjlAjsVJRp5iJqYoYOMLZ2JLAlhzul3V/f+ieFmFS+oGBrdM4AolH4qy6XBFOUD64qpTjPCyEvF/XrD1B2k6kNAvR3HxFSEmfDJ3L79SA7VS8fPO4/Q0mnJOnWUcPvHzKjsLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=DOCRIwnZbQl24l43tT9UnbHtbDgWSd9tFh/yI/Lv4kQ=;
 b=fa3JqT8P9e/olZRDZNXZWNMBcw+mqPeMN5pD9A44WAzj/uCTo6F2aD8DYdYPWLXa4YsMf42Pvrifk+ir1e5bMIiI6tXKPJkLmK2enB6geducGLiVs8Z7pw6d335R9G8MIc5kpydW9aJTr5kbDz2Nm4AgmYyEs1adAmluHSqkb3D/VpF79kC/bHRNg1Y7XN5cvZWsoCQl189ygZSoACb2yyG3CdKh/BSqVUksHygWz2bIsYBSdEYI/kI10iY6TekzSH/mGNlQwBCG+9c8PnbBd8Fiqq4Xc0pDI0X36aD3uS4Q/i73d5WDGFWIkZJPv5pGVy8/1m7BVcBQGYHn4PAvkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOCRIwnZbQl24l43tT9UnbHtbDgWSd9tFh/yI/Lv4kQ=;
 b=O8U0PuGPInr7H8kekVH0mi8zAOiV8Boj4SSYgRjBH0VzHSoWfJdz/kwdOQGX2arXyCdSYF5AAzaDUFHFjAtGCoy5skimUcYrl3tnZJJ6VQ3fY3npbSAQV5EfI6HWeadCXIPXF5cDaINAC51dNkzv/emKWlElhFVzuTwcpNAMETY/BzPOuMK4+P/nUyfmjXXiIKCyAvScnhtnq329vod4tKSKR2v+0Vx2ULHfYqbrQumpdd36lL22/zaaaZ+tAIl/+TibL2xFa3wxwjLsm9c0kebFkIIQrxMYtsihwJ1P1JDdQnuTChppoDD9rR1ZLVHbBEt8I4zCpQKkgcaJGNzYRw==
Received: from TY2PR06MB3213.apcprd06.prod.outlook.com (2603:1096:404:97::16)
 by TY2PR06MB3264.apcprd06.prod.outlook.com (2603:1096:404:f9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Thu, 2 Sep
 2021 01:52:16 +0000
Received: from TY2PR06MB3213.apcprd06.prod.outlook.com
 ([fe80::585f:642c:ca7b:30ac]) by TY2PR06MB3213.apcprd06.prod.outlook.com
 ([fe80::585f:642c:ca7b:30ac%4]) with mapi id 15.20.4457.024; Thu, 2 Sep 2021
 01:52:15 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tony Prisk <linux@prisktech.co.nz>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Tao Ren <rentao.bupt@gmail.com>, BMC-SW <BMC-SW@aspeedtech.com>
Subject: RE: [PATCH v2] usb: ehci: handshake CMD_RUN instead of STS_HALT
Thread-Topic: [PATCH v2] usb: ehci: handshake CMD_RUN instead of STS_HALT
Thread-Index: AQHXnuRSuVZoYfgvf0W+qrh69Uwfh6uPYomAgACZrSA=
Date:   Thu, 2 Sep 2021 01:52:15 +0000
Message-ID: <TY2PR06MB3213D02995C616679B1DD47780CE9@TY2PR06MB3213.apcprd06.prod.outlook.com>
References: <20210901035041.10810-1-neal_liu@aspeedtech.com>
 <20210901164107.GD404634@rowland.harvard.edu>
In-Reply-To: <20210901164107.GD404634@rowland.harvard.edu>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: rowland.harvard.edu; dkim=none (message not signed)
 header.d=none;rowland.harvard.edu; dmarc=none action=none
 header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a9a5b67-2602-461a-dc30-08d96db44a57
x-ms-traffictypediagnostic: TY2PR06MB3264:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR06MB3264E8DB8A05FCFF32EF065580CE9@TY2PR06MB3264.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:162;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2lMg24flo0FBD/RK7WX09BuF9z5YDXHFroxQH8YablHpmnNcBIAIX1zVMchE36NrrR4dYljubJ0ZPx8MoADHiGcJYhCoaYm2jjwq42w1qOrmSnPoL1JLa0fPH7KFsRrFGx9rMQqw8bUGbZ48pWkOvKV9d2p45LFk4aPEkK/8yMBCPIUoUxWfnDoC8D/p3APLcu6KV2c9TmzG6YaLX8ZYmkxMeELzcPdyhEIgisaNwxQGbEKS2rqFCIFBnCSdRFVWfw50xrRMw0GGel29TruwgClrdoOTo0p3ph2jd/8gUvwe0hjUzUv9Y5trjE1RHHMc+Lshu3oGQ1PtOXSzkJ92Mv1rcdIXYwyIto+Ncx5QPaUaGWea81VxwgMcdJmvRmHfnIDbdFfyMa9c1lIbTGCXXIxmXgskx5sgOWdADNHOTZ0YKiXShvyTBOrnq4kXZY7dPV4QEDalNCHtRUaRFl6JymLWwRTRssw7FSKKIABrfBTBQuEQ6iVcizAxkTXoQE7iOX4i13g6cIz2/AeyvFS8VvtFCdsSjnR7flkx0WW+6xU7BL7hzXpWBAMYFI5LDlSluCxp3PIvLOTXXQ/NLPqq7oCojFJSyjCGkjF9upH0qSxAm9cJTmsf0MnRmXfk2Hx178rG9izZBmkp8raX6LEjDAY+sKHkpKww4yg1q/J3g9Cir6ApbTdigOn0OgXOkN1zZYAJ9pFPXaOM1Pp+KR7VeA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3213.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(396003)(376002)(346002)(136003)(366004)(122000001)(52536014)(5660300002)(66446008)(2906002)(71200400001)(38100700002)(66556008)(66476007)(66946007)(64756008)(76116006)(55016002)(9686003)(8676002)(4326008)(478600001)(38070700005)(33656002)(86362001)(8936002)(83380400001)(7696005)(316002)(54906003)(6916009)(6506007)(53546011)(26005)(186003)(107886003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FIwWkCzoOhKsq5jDWixwaTsLI6Q47ZYDwyqG4k7BQRntOmEMSrxn9T9D1tSi?=
 =?us-ascii?Q?yzcfqYV0KCBG1i6RB4x0u/YtiTT/8qfg1odR9wtwJBnhaN0m2HXyqT/7vfgu?=
 =?us-ascii?Q?W6YfhzU2fIFWCN+srp0fYgX5BstX0FOIzKeVth6Hwd2hagtdCT3azQqbyUWj?=
 =?us-ascii?Q?6gO55xT+QZwBVXoH5lmpd8yV8zl24elHEYwJhiBlQsJYQFunDWLNP6YiJd61?=
 =?us-ascii?Q?osNrGcUJ289xonwmO/lsmh7fWzX0vNa8RWUBRdnil/FzOxMaWx3Zzm6bISEX?=
 =?us-ascii?Q?x8QkijSylsz7++uFvC7UNSTLMSCtLet6Vb8J8e4e2SSWJnj6KezD/0II52jU?=
 =?us-ascii?Q?OBz+Z2B2PDbu91t9whSi0rhAubTcq4DydU7/HzBk/6MaebhlBJc3Qi3fuKhU?=
 =?us-ascii?Q?BFNeSE7hGiPd2ERV7Pasal6eyfJSP9l4+LoDsq2Rh0dA1f8+0LjeuiwrTVz3?=
 =?us-ascii?Q?ayyzQ8USEC80adrynj3Gy9ASXZ+zplPvm3mN7R4vfAV0I146yar436YHEwV2?=
 =?us-ascii?Q?aIO1tchdJzR4MnP+u7VANDvTyKQJoLDNNxdrKcJUv4bj2UTlAARjNdOspeDl?=
 =?us-ascii?Q?1onpM7+1NuR8/lYVBM3cI0VLBSnW+xS3kb3dSzLYfNVkuJpcJQWVrxEObV9e?=
 =?us-ascii?Q?iQhWoC7ceGxvdYTl6pO+hxodbwg5iDmQPfmXOWRjI9YDmBF264W0w5EaHJUD?=
 =?us-ascii?Q?RSK3nRRvFLvFYcwr7IwcGZkzG8SAm3eC0gIrDx3RIBQyRpKBPDwAbD6jtdcp?=
 =?us-ascii?Q?lYTdB/uQHoR8ACC/RP/AKk/0z1nkckPRKD4DZXjnE6mbEtE5mBX9KJfzRe6r?=
 =?us-ascii?Q?wCkTG1Lx10qnyQir47UWcEA0tR85edBZGSLp2Tg0C/IVQwQkIxhZruxTtIGg?=
 =?us-ascii?Q?SqvPzE2871bOp1ccsVT4esxtUWVcMZZhanNJzKmk/ssN3p6xxdaAp2GUOdh/?=
 =?us-ascii?Q?UYoazK+nAoF4ZAd0AQi8kJh1GW0eE6rK7YQPAe2mn8pHv3Gta7JDl8sva1Pk?=
 =?us-ascii?Q?B3x2qlgJpTjZhwPD3W6DlzocvYVwRpAEVkfvMGClxi5dRrvR734KjFoHNGtH?=
 =?us-ascii?Q?/t6g7NBbKgmhASt1fOx3H2k40eIDvuXT1c6fk5ey4t6t4g3XEFG5v8UjJEjj?=
 =?us-ascii?Q?PPcOKhG9jU8KFKt7GBkWJ5fTcDRXAEqO3cF4p4dlZ2cJeKrz067bNIRtbY4h?=
 =?us-ascii?Q?r1yLhcvGM5xFGFOpiDsNffzSr/iLju+iE4WlwZZmNEXIyZTG1oMWRXVp7pLH?=
 =?us-ascii?Q?kCJ7XcwCtIhSRaL3ylDw0N4RnA0KLHIFhFwyt4WdMN/wkEQLncAM3VqC1DuG?=
 =?us-ascii?Q?L6dD5abKOl+3U2Fc2BKwfwxn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3213.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a9a5b67-2602-461a-dc30-08d96db44a57
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2021 01:52:15.5880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iHE82Ti3zjTq+NOBEtR/mOyC2uWfE9cbuKYO2fDpm0EbFu8QDQ2kEOAEpJOtcy7kHka0LVGWu2rRy1hexXVnRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR06MB3264
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Alan Stern <stern@rowland.harvard.edu>
> Sent: Thursday, September 2, 2021 12:41 AM
> To: Neal Liu <neal_liu@aspeedtech.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Tony Prisk
> <linux@prisktech.co.nz>; linux-usb@vger.kernel.org;
> linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Tao R=
en
> <rentao.bupt@gmail.com>; BMC-SW <BMC-SW@aspeedtech.com>
> Subject: Re: [PATCH v2] usb: ehci: handshake CMD_RUN instead of STS_HALT
>=20
> On Wed, Sep 01, 2021 at 11:50:41AM +0800, neal_liu wrote:
> > Retitle.
> >
> > For Aspeed, HCHalted status depends on not only Run/Stop but also
> > ASS/PSS status.
> > Handshake CMD_RUN on startup instead.
> >
> > Signed-off-by: neal_liu <neal_liu@aspeedtech.com>
>=20
> I'm still a little doubtful about doing this, but if you guys say it work=
s for your
> hardware then I guess it's okay.
>=20
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
=20
Thanks for your review.

> > ---
> >  drivers/usb/host/ehci-hcd.c      | 11 ++++++++++-
> >  drivers/usb/host/ehci-platform.c |  6 ++++++
> >  drivers/usb/host/ehci.h          |  1 +
> >  3 files changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
> > index 10b0365f3439..01c022e46aa2 100644
> > --- a/drivers/usb/host/ehci-hcd.c
> > +++ b/drivers/usb/host/ehci-hcd.c
> > @@ -634,7 +634,16 @@ static int ehci_run (struct usb_hcd *hcd)
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
> > +		rc =3D ehci_handshake(ehci, &ehci->regs->command, CMD_RUN,
> > +				    1, 100 * 1000);
> > +	else
> > +		rc =3D ehci_handshake(ehci, &ehci->regs->status, STS_HALT,
> > +				    0, 100 * 1000);
> >
> >  	up_write(&ehci_cf_port_reset_rwsem);
> >
> > diff --git a/drivers/usb/host/ehci-platform.c
> > b/drivers/usb/host/ehci-platform.c
> > index c70f2d0b4aaf..c3dc906274d9 100644
> > --- a/drivers/usb/host/ehci-platform.c
> > +++ b/drivers/usb/host/ehci-platform.c
> > @@ -297,6 +297,12 @@ static int ehci_platform_probe(struct
> platform_device *dev)
> >  					  "has-transaction-translator"))
> >  			hcd->has_tt =3D 1;
> >
> > +		if (of_device_is_compatible(dev->dev.of_node,
> > +					    "aspeed,ast2500-ehci") ||
> > +		    of_device_is_compatible(dev->dev.of_node,
> > +					    "aspeed,ast2600-ehci"))
> > +			ehci->is_aspeed =3D 1;
> > +
> >  		if (soc_device_match(quirk_poll_match))
> >  			priv->quirk_poll =3D true;
> >
> > diff --git a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h index
> > 80bb823aa9fe..fdd073cc053b 100644
> > --- a/drivers/usb/host/ehci.h
> > +++ b/drivers/usb/host/ehci.h
> > @@ -219,6 +219,7 @@ struct ehci_hcd {			/* one per controller */
> >  	unsigned		need_oc_pp_cycle:1; /* MPC834X port power */
> >  	unsigned		imx28_write_fix:1; /* For Freescale i.MX28 */
> >  	unsigned		spurious_oc:1;
> > +	unsigned		is_aspeed:1;
> >
> >  	/* required for usb32 quirk */
> >  	#define OHCI_CTRL_HCFS          (3 << 6)
> > --
> > 2.17.1
> >
