Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 861D84048A8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 12:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbhIIKnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 06:43:55 -0400
Received: from mail-eopbgr1300100.outbound.protection.outlook.com ([40.107.130.100]:15031
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233654AbhIIKny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 06:43:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iOq3uO27OkaNyXLBaGQt08B9IiOhWcVHAtpFppvj8bcNGo5Wfk7Yurt6VmnGe5iPHpVe8Wyq5XOIZaGD3thPCn8FVsu0vhOyD94bARf6ErJKyCHwVF/z9VfXDxxu4GWSa4VgKAZj2AebJltvPfP9NEp+DGPxSNG1hb5TcWRTSGMJ9fOVVTS+jRL3z/TYtHUsNurtbubXSo2b6Vr/tNnuhSJ/R6VclA51pumaWIgCzELh9iLr6/KYokgQ5K5m5M5J9WNYL4YQdqplX8PtdJ6BjkcaGexng9bZh7LXxNDQC+JpIsh3op1FySh8nDkcdBQECFzzWOn2JstDpx8f9EUaug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=iKPRtE9mxr9dpu1q9azfgaVhVJ0E2R3pRstw2JJrVOU=;
 b=HkHavtTOdnlTjkWmCiIZNTINZLIzn0mSkdxC+3mTAKmYegs1GuhI3GrB/+RwcYpF99qrZWRDuxta2Fybp5v6CrX7F5nC5eX5O7ayEKIyohpUo4OO+WFpOfI8X4h9NLip0AhxIjyxldeWf69b2L4TnLaTRLc/Npf/+xy/ye+tvfd4rtWl/Jbbc9zIlLHU7MfdpyiImiTSSCNQv6u+qEwPZ78kaaJXZfamera9ghGSbJmBMbHX4Fiix3fvPKRqzFGkAs/QkgM4m9QdAKJJOI3wKlMsxiPSy+f+QOArmtxIfzVEFAZOVBwgLbrpfXnC49mZrH0oPkWzQ+VVLw89gZy/MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iKPRtE9mxr9dpu1q9azfgaVhVJ0E2R3pRstw2JJrVOU=;
 b=S8gnD1L2eDozXeRpeyilwlvvijua+FS2GAPVmQT/u/Yg+SKJFmFI3bLWN6ZeejPPFHS4PhCsCLHdIRI3AZZ2MkAunqn6m1AgonDbjl7vlvNCiKeQgGDI/LpHE3j6+ATmhCZDt7pH6m3gEVf9TrC+3pHA2yr0rQEhDnpiS8NUMVN1Gdqw2ifKLfBl/xke8oiWAZe8Vl97qK+RYljRknvOCEOKoY66KVxYqtCI7LhHGkr1QOyVlRuDLgrxL0FDTL+o14jnhg3dRt5MUzKOAg2/2THPeuYi/vRUvp9N67gIqUHwxv9NMit/tLDB/bycalr9+tPrVUGfMvMaVM1fba5VNA==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by HK2PR0601MB1924.apcprd06.prod.outlook.com (2603:1096:202:c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Thu, 9 Sep
 2021 10:42:41 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::e129:fce0:90bf:3c79]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::e129:fce0:90bf:3c79%3]) with mapi id 15.20.4478.026; Thu, 9 Sep 2021
 10:42:41 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Tao Ren <rentao.bupt@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Tony Prisk <linux@prisktech.co.nz>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Subject: RE: [PATCH v2] usb: ehci: handshake CMD_RUN instead of STS_HALT
Thread-Topic: [PATCH v2] usb: ehci: handshake CMD_RUN instead of STS_HALT
Thread-Index: AQHXnuRSuVZoYfgvf0W+qrh69Uwfh6uOsZ2AgAyMaACAAAnu8IAABN8AgABEF8A=
Date:   Thu, 9 Sep 2021 10:42:40 +0000
Message-ID: <HK0PR06MB32024D58192273F54B3F31F780D59@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20210901035041.10810-1-neal_liu@aspeedtech.com>
 <YS8YuX9laah5d/NY@kroah.com> <20210909054531.GA10391@taoren-ubuntu-R90MNF91>
 <HK0PR06MB3202E3A5457474212F8ECC9080D59@HK0PR06MB3202.apcprd06.prod.outlook.com>
 <YTmr5jtlFYNuQb/j@kroah.com>
In-Reply-To: <YTmr5jtlFYNuQb/j@kroah.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff32e8d0-fe2a-46da-566c-08d9737e8c9b
x-ms-traffictypediagnostic: HK2PR0601MB1924:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK2PR0601MB1924530980D12D57AE76647280D59@HK2PR0601MB1924.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nkp0zRWBiNe3gvQOyK+jdICqovjbrtxQj5Y9PgqfIHHKpY04+A4+QYz3iZ006SI71KkKNdSlXCCY0S1rL1ohcpcTcTRVUkuTYnloH3e4Q4BMTNyI8P1VEUTgjqiIvKgcg1WZ0DqYz1aBYvVC0wB4ftFarbj/MP6DeVP9JWrLUk/PaqhT3DZeYkiRRv4DRbSgPGKQ/DwEFj1qjacac9wF1K2w6eV8iP4HR4Zg0ovGyQzyN9W/Yyq0M+diQwn/ukQ5tkE2h5QCSzdIArCIz4Fkq5R23E76GOCCP58mZeTSmxWv4Jj9oUj/oNP0KEnatN6j34wZZ/NSTGjJZkaXjbh1H6EoUpaDkAsibhBmlvj7lsKo2VwaUzE21bQazBdzJXJeSzRrcN5TTxGJ+wB6XNtEmaNMsA1C7PafhkyI6YarNt0Nprm4krHgi8bP9B1Wqfu6a4DdHkRbuwhuALRkwGoOnk9PmXFnglPZ33cNlQNOnMN/ejmOQAsjw1WMBnD0NKqQLKibe/2dNljAltuHHFg+ep+jey5ecfw92krWJxjEsNpC2q19h2XXaxDp4cvAUrQQ9xW8so5lPAsnAXOvPDkDn508PHe5qrs26q7Jy7Vgf/bNPSbsSenWpOOBFys/wwQhS5SlcTrpM0aEdT90HD7jSSe3C9n8qnWJKKK+LfvOENrAv7XNrN//BSpjcnlTGfdggHPEvplpL45Gbo+0Q5qXrA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39840400004)(396003)(366004)(346002)(376002)(86362001)(83380400001)(38070700005)(8936002)(2906002)(26005)(6506007)(53546011)(7696005)(4326008)(6916009)(33656002)(52536014)(71200400001)(186003)(122000001)(9686003)(5660300002)(478600001)(107886003)(8676002)(316002)(66946007)(54906003)(76116006)(55016002)(66446008)(64756008)(66556008)(38100700002)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?61WPROuDdEbPDY5D7kp2Cp1garIe8TmT81V2H57iD09qnWkaCmP4Ppzfb6KV?=
 =?us-ascii?Q?qpIDu5b8Nvkxsgz051KHZ/XeIRlKARQvQa8Mp9L21s+res9+4NPVRbx8ZluF?=
 =?us-ascii?Q?N4cIwufeOhQxT5rsPznpQkev1v1uHZu7+Yd5Vz7TFUExFe1bkAoliFpAL8g5?=
 =?us-ascii?Q?eDTx+/iDCua0tlL8aJt1oODZoi4qTKdiM29XPq4XsgSdbyqhmEVKl9Df8tP+?=
 =?us-ascii?Q?tuitdmBHuWYJRzPaRSN3qY07+iEB8p33y4c/mPTcde/7xHt2FHcZcPh4Ap+k?=
 =?us-ascii?Q?0/KhKaHf9Lt2XLFmVMff7wURPPQyNomZO83I3e+vznP6MsUa0cnhn7THZZ0T?=
 =?us-ascii?Q?xbFYneUmTH/cSsA6ePlxDB1itfQR0iExhHgzgJh9RfRfiHZdI1DmVyuc5++x?=
 =?us-ascii?Q?bxg+YKfUsnenGmbEITCitwMc55gyhFu5fji9EX86g0AGGIbEQSujho+E6IKd?=
 =?us-ascii?Q?xpwegak3HkXZBNKGndbRgOgrKHwGtJciXfnogFkCb5PLL943JspKqXXGWKXE?=
 =?us-ascii?Q?PeZR/JoOsqCpjmdlA8DVXu7OtN6rePhEMRSuPP5VzUIgGq/ktIcUP1mwngGb?=
 =?us-ascii?Q?2WICMNA2zxFzJXGPfEXFeMtCiRVn+V0+LX/VvKn8699AZUm6NEAYnMRrm0AA?=
 =?us-ascii?Q?r9HHVjAyUXi1vap4rMVmDjrRvSaFZGhKw68XpzgrC9T/jRITzvAQ7JhMRlFe?=
 =?us-ascii?Q?BJURYdt2+MY4Y6M+yEOkZezsh58WUDlbuN+yS/KlbdwoPS3/dRakqW74bVTZ?=
 =?us-ascii?Q?v0i97cB/Qbo8uX2HP7sSHhxti2hFbFj7d2orn0/sxWGKgrqWeZjYGgPIKMyj?=
 =?us-ascii?Q?tEWVz0NTaSXtmKycIHIwexpYAIHNAWgoTBqoe3/A4xGSGZeW0cP76GVUGwbD?=
 =?us-ascii?Q?rbtJ4F4PS913AEdfhv3lQ2D4f8NVbljzS1joi4uEw5ivCUYFJTyYewLicXNN?=
 =?us-ascii?Q?I+Z1T+H5lwJrW9P3nS8RD26vtkff//LoAcYCP47HDsKqX9IbXVOovwg6gWu3?=
 =?us-ascii?Q?fwPwsxK3apukmWJLkZWIiWIpqZ1CEEzKUxGBPXSh845fYOw0Z7bSN9VcWKkW?=
 =?us-ascii?Q?62WCEsiblWrYSdnPV5K3MlAMpr1M45zLxuT4tzFlSPI0hwpUD/NdxJJZsjOE?=
 =?us-ascii?Q?V3uloq/008e/l9cYss8IrsRv/Ifb4XFvqrfFC6dbrTYfUAt8sniAS5J5c/4X?=
 =?us-ascii?Q?c593qGdd1yBHdVSiYqmU/u/v5PzKK0q7EMdJHZbgCRzuStfq9UqDNztfU8A0?=
 =?us-ascii?Q?sCN+9p6oT2lhoEDWnL137ZR1xMHa0ZV9OvE0w/6kgDbWcmY1KHeL9674GxYM?=
 =?us-ascii?Q?567/7Ma2+2u1XAazTckiETo5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff32e8d0-fe2a-46da-566c-08d9737e8c9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2021 10:42:40.9321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: naPTiD2+PUeU/2TjAzzo0x8Wjz78PtLirA5RT6lNVbxT1Er7PRksWbgKxARazCuDOGzWuliCnm+8fBK5Lxq3Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR0601MB1924
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Thursday, September 9, 2021 2:39 PM
> To: Neal Liu <neal_liu@aspeedtech.com>
> Cc: Tao Ren <rentao.bupt@gmail.com>; Alan Stern
> <stern@rowland.harvard.edu>; Tony Prisk <linux@prisktech.co.nz>;
> linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; BMC-SW <BMC-SW@aspeedtech.com>
> Subject: Re: [PATCH v2] usb: ehci: handshake CMD_RUN instead of STS_HALT
>=20
> On Thu, Sep 09, 2021 at 06:23:10AM +0000, Neal Liu wrote:
> >
> > > Hi Neal,
> > >
> > > On Wed, Sep 01, 2021 at 08:07:53AM +0200, Greg Kroah-Hartman wrote:
> > > > On Wed, Sep 01, 2021 at 11:50:41AM +0800, neal_liu wrote:
> > > > > Retitle.
> > > > >
> > > > > For Aspeed, HCHalted status depends on not only Run/Stop but
> > > > > also ASS/PSS status.
> > > > > Handshake CMD_RUN on startup instead.
> > > > >
> > > > > Signed-off-by: neal_liu <neal_liu@aspeedtech.com>
> > > > > ---
> > > > >  drivers/usb/host/ehci-hcd.c      | 11 ++++++++++-
> > > > >  drivers/usb/host/ehci-platform.c |  6 ++++++
> > > > >  drivers/usb/host/ehci.h          |  1 +
> > > > >  3 files changed, 17 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/usb/host/ehci-hcd.c
> > > > > b/drivers/usb/host/ehci-hcd.c index 10b0365f3439..01c022e46aa2
> > > > > 100644
> > > > > --- a/drivers/usb/host/ehci-hcd.c
> > > > > +++ b/drivers/usb/host/ehci-hcd.c
> > > > > @@ -634,7 +634,16 @@ static int ehci_run (struct usb_hcd *hcd)
> > > > >  	/* Wait until HC become operational */
> > > > >  	ehci_readl(ehci, &ehci->regs->command);	/* unblock posted write=
s
> > > */
> > > > >  	msleep(5);
> > > > > -	rc =3D ehci_handshake(ehci, &ehci->regs->status, STS_HALT, 0, 1=
00 *
> 1000);
> > > > > +
> > > > > +	/* For Aspeed, STS_HALT also depends on ASS/PSS status.
> > > > > +	 * Skip this check on startup.
> > > > > +	 */
> > > > > +	if (ehci->is_aspeed)
> > > > > +		rc =3D ehci_handshake(ehci, &ehci->regs->command, CMD_RUN,
> > > > > +				    1, 100 * 1000);
> > > > > +	else
> > > > > +		rc =3D ehci_handshake(ehci, &ehci->regs->status, STS_HALT,
> > > > > +				    0, 100 * 1000);
> > > > >
> > > > >  	up_write(&ehci_cf_port_reset_rwsem);
> > > > >
> > > > > diff --git a/drivers/usb/host/ehci-platform.c
> > > > > b/drivers/usb/host/ehci-platform.c
> > > > > index c70f2d0b4aaf..c3dc906274d9 100644
> > > > > --- a/drivers/usb/host/ehci-platform.c
> > > > > +++ b/drivers/usb/host/ehci-platform.c
> > > > > @@ -297,6 +297,12 @@ static int ehci_platform_probe(struct
> > > platform_device *dev)
> > > > >  					  "has-transaction-translator"))
> > > > >  			hcd->has_tt =3D 1;
> > > > >
> > > > > +		if (of_device_is_compatible(dev->dev.of_node,
> > > > > +					    "aspeed,ast2500-ehci") ||
> > > > > +		    of_device_is_compatible(dev->dev.of_node,
> > > > > +					    "aspeed,ast2600-ehci"))
> > > > > +			ehci->is_aspeed =3D 1;
> > > > > +
> > > > >  		if (soc_device_match(quirk_poll_match))
> > > > >  			priv->quirk_poll =3D true;
> > > > >
> > > > > diff --git a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
> > > > > index 80bb823aa9fe..fdd073cc053b 100644
> > > > > --- a/drivers/usb/host/ehci.h
> > > > > +++ b/drivers/usb/host/ehci.h
> > > > > @@ -219,6 +219,7 @@ struct ehci_hcd {			/* one per
> > > controller */
> > > > >  	unsigned		need_oc_pp_cycle:1; /* MPC834X port power */
> > > > >  	unsigned		imx28_write_fix:1; /* For Freescale i.MX28 */
> > > > >  	unsigned		spurious_oc:1;
> > > > > +	unsigned		is_aspeed:1;
> > > > >
> > > > >  	/* required for usb32 quirk */
> > > > >  	#define OHCI_CTRL_HCFS          (3 << 6)
> > > > > --
> > > > > 2.17.1
> > > > >
> > > >
> > > > Hi,
> > > >
> > > > This is the friendly patch-bot of Greg Kroah-Hartman.  You have
> > > > sent him a patch that has triggered this response.  He used to
> > > > manually respond to these common problems, but in order to save
> > > > his sanity (he kept writing the same thing over and over, yet to
> > > > different people), I was created.  Hopefully you will not take
> > > > offence and will fix the problem in your patch and resubmit it so
> > > > that it can be accepted into the Linux kernel tree.
> > > >
> > > > You are receiving this message because of the following common
> > > > error(s) as indicated below:
> > > >
> > > > - It looks like you did not use your "real" name for the patch on e=
ither
> > > >   the Signed-off-by: line, or the From: line (both of which have to
> > > >   match).  Please read the kernel file,
> Documentation/SubmittingPatches
> > > >   for how to do this correctly.
> > > >
> > > > - This looks like a new version of a previously submitted patch, bu=
t you
> > > >   did not list below the --- line any changes from the previous ver=
sion.
> > > >   Please read the section entitled "The canonical patch format" in =
the
> > > >   kernel file, Documentation/SubmittingPatches for what needs to be
> done
> > > >   here to properly describe this.
> > > >
> > > > If you wish to discuss this problem further, or you have questions
> > > > about how to resolve this issue, please feel free to respond to
> > > > this email and Greg will reply once he has dug out from the
> > > > pending patches received from other developers.
> > > >
> > > > thanks,
> > > >
> > > > greg k-h's patch email bot
> > >
> > > Thank you Neal for the patch. I tried the fix on my CMM (AST2500)
> > > and Fuji
> > > (AST2600) BMC and it works on both platforms.
> > >
> > > Can you please address Greg's comments above and send out a new
> version?
> > > BTW, please don't forget to include Alan's Acked-by in the new versio=
n.
> > >
> > > Reviewed-by: Tao Ren <rentao.bupt@gmail.com>
> > > Tested-by: Tao Ren <rentao.bupt@gmail.com>
> > >
> > >
> > > Cheers,
> > >
> > > Tao
> >
> > Sure! I'll try to fix Greg's comments on next patch. I think the proble=
m is the
> first one.
> > And thanks for your review & test.
>=20
> Both problems are real, please fix them.

Thanks for pointing out.
