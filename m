Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B597E404908
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 13:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235211AbhIILO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 07:14:29 -0400
Received: from mail-eopbgr1310101.outbound.protection.outlook.com ([40.107.131.101]:47232
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234871AbhIILO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 07:14:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lttUntgyn0d/3lg/qolQwWAtJqtiFPAGCHtUxJDoC1YxsCT2k5E6z9lbmkKC6xAoHAxkqBWp5clXzqADNdXH1OTFJkIHf7DfVmeF4lMbuX/9kkJjI495HndIwBMbZIb2rLlP5hGupMM1E6R7wus4l65euThKn7NX3yr2qQmPsrOxeAyz7GJRTdof85BGKWMfIFzhMbCchrP1Zqsa/VRCq8GNOd0CW8+m59Qfy2UzV7V+3Y+ljPCSXl80TMhSpjZiuAolN8MZlaPa38CNJvQmF4vK4Va5X5UPdT0HIANJLgLP1e7S/19z0+8hLqJBk7TOTtkBtvTcjqHVa4KeTw3PFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=dqzHRQfMortu4DdLYW+4tZ7+lguBz0pGBRV+QuyHANU=;
 b=fC7afgNFbL+5afoxVyZBpEgyAAwETCklU8S797Jwq10y2rLZrmr6kJhyHirJlm844PnNill7ROJCwlm9rG8iXEsR1jsEfQmLtfkKKXVwyif0AHP7EPn4yrgjUnLuQJmN7Cz7w3ISISGo4Cxoq49s0X2XT4oUL8m5M1etitWJPETaHe0Hy+gBep7g4JXZUYlQ/Qg9m54HsCmNytKg8ypmrbcclSojaq+FdvJqEhSKkbDuG883wKIV3EwddEOXkzrR2rYpLDi7GA1uY7bx3yQeUVuXSfDaUEkiwd3raWQU6YvfcmYLMIGFEqcU6ZQS5P54ZOuroOKF+k7uKnpoMO5ISg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqzHRQfMortu4DdLYW+4tZ7+lguBz0pGBRV+QuyHANU=;
 b=Ngv5fON5RMyv2IMUJd4p0CSLqfokRhCVCLDK5/xAMvlXgAJfsipS42AGJQEQzXKnzfEsiRVWfac/VZUvj8jnfWJfFVOZbn3wLwrzj90VZczfYI/wdnS3lkFf4vujtwMNol83z5oj1Bxvr6QYc4F9R1b9UarzjwyaWAOiPG51Wb1OqGSQu8kOgwWyVrNUijbpmiUN7bY0YJfgcWzgBm0n1Xc8HdHj812EEXifwfBom4KiTwrTxfYrKxweB2gG9DQodLjG87ja2Pv4/fz976l9Ie+ze4VZ7nqaDi/kDPPnkgfAvyoDBJp8mk/H7SxhY77hUnNHAV1DzAcUojMxog0RUA==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by HK0PR06MB2579.apcprd06.prod.outlook.com (2603:1096:203:6f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Thu, 9 Sep
 2021 11:13:15 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::e129:fce0:90bf:3c79]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::e129:fce0:90bf:3c79%3]) with mapi id 15.20.4478.026; Thu, 9 Sep 2021
 11:13:15 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Alan Stern <stern@rowland.harvard.edu>,
        Tony Prisk <linux@prisktech.co.nz>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Tao Ren <rentao.bupt@gmail.com>, BMC-SW <BMC-SW@aspeedtech.com>
Subject: RE: [PATCH v3] usb: ehci: handshake CMD_RUN instead of STS_HALT
Thread-Topic: [PATCH v3] usb: ehci: handshake CMD_RUN instead of STS_HALT
Thread-Index: AQHXpUTHQLNMzg5Z5UqQTztzogOWBqubP/yAgABJ3iA=
Date:   Thu, 9 Sep 2021 11:13:15 +0000
Message-ID: <HK0PR06MB32027203A59270D0A30A855680D59@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20210909063652.17282-1-neal_liu@aspeedtech.com>
 <YTmr1TCOhV39WQXQ@kroah.com>
In-Reply-To: <YTmr1TCOhV39WQXQ@kroah.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2090bdfa-a867-40ab-eae2-08d97382d223
x-ms-traffictypediagnostic: HK0PR06MB2579:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0PR06MB2579E55DB54F1E4483E737D580D59@HK0PR06MB2579.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KD1jRIr373laEX+ol4MUdkLKSO1KQJVYNoozJlnBpexzHp77JI1ep5NKpTIrFYNR4c0hJcWpF3LtOqM2GPDeA/SYj53wP0CPZw2dqAQ+Fdc3z0+Ryyw7I2Vyq+/Hvu8MHCBtIKlOmphDBr6iVlkX3IS8b2b+QL0Hu4M/kW8Yie65kdlrDX55exP/vyfpr/376rF6Yn3kYN6S2xOvrVkJIh9eAua3nSHkF2x2ELCaB5ZVyXG/Y2lqmJYO2bn705C1i1/BzUrsciqfm8SRn5bJASm0KzRf5yiq0/qIA9yNnFXtWdGoNiH5h+5jQUlXhZThIEO83dbtMK+bVqzTrK3hi0fpahChHRUZI7/OALFI0pjh274BfumiWHc4BVbAynsmSt2MZIMGHvG42vJQAXZFcwvdotk1Pu7Dt5kLOc2senUCD4LW/jHndDP/6tA333N0wz3is5DGYN+vtO9FKeOk4oZ8d/XWnv0djd16dSNkq3vk05EYXS2Povqk15xRWG0GAFxbAagC+d5GWV4Xtc+oUplyuDTCeIiw/1EI4c+TAvPiLAcsUbSZcevq28Jvuxy6B/fuziharPuzHz6orZ2AzwkwDCo9/Y64CNLkgMyTLDhu5HcT+Vpwg6bHwxWTKrVHPYzi69JKwQkSANrlRH4+PA1z0i3JM3cGWUHLymho/A1vAbuYGhjLM2O1y9RK+3csvwKIdCP2J6quLz7nvwqdUw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(376002)(396003)(346002)(366004)(136003)(83380400001)(7696005)(186003)(33656002)(38100700002)(52536014)(5660300002)(4326008)(86362001)(53546011)(6506007)(26005)(8676002)(55016002)(71200400001)(122000001)(6916009)(107886003)(9686003)(38070700005)(66446008)(64756008)(66946007)(66476007)(478600001)(66556008)(76116006)(316002)(54906003)(8936002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZWXjV5QSNIt0LAngwAQA0wUWSHBaHphFZkVlMmJiIP8Os+5KmGA1S23QJtdL?=
 =?us-ascii?Q?vQvuhVA+wWXcmBrt0s/ska8PX/7yPrAwdAdR+a4hYyS2wbD1TFGv0ZfTktja?=
 =?us-ascii?Q?SuXCMEKboyPk/fE+ZQnRGZINs/I5DhADXGECNNf2xjcXtgh/cjYYkVfNCvyD?=
 =?us-ascii?Q?S/yr9FHXJ++v3z514ba2pJ5ZmRlqXMi89BLiRVOKxZtHQaYaRV7Jv8xFEBdQ?=
 =?us-ascii?Q?DNx29aqY2UgfvblujFtmCgjkroUzaLdOwEK3ibRzJpZGDdJL4cOBs2xuuYeB?=
 =?us-ascii?Q?lRNkO2QyMq0Zar/acPNT803PkVeZk6ULa6VcP7r8bwC2KCJpSEQcX7NtngdE?=
 =?us-ascii?Q?oEeyv9vIglr0yjuvNuOzRYEDvdoQsuiNGWiofVhWppa02j4+K9oqi1tBr8mB?=
 =?us-ascii?Q?yUkxRGnQFlW2UgQ985LwL6sAzTvQd2JNj8GYxu6msOrVXDqwxrYVgK60Qs34?=
 =?us-ascii?Q?BGqiWYY+31hYkvMq8mHECwqTgsmXYqIlCjMl1aBUvSDUF1ett4QOYIlOqDXk?=
 =?us-ascii?Q?oCDUV54MTX67xpwzbQ4KTU7zXxgY5SJy2FxZHGrsAmhynqFxTd2p5O+k99z5?=
 =?us-ascii?Q?6K5R0fUxDrVqWHPX5mArvA8zA/1loOOglyHDET2riHoZ/1YM1KA+SByXsj49?=
 =?us-ascii?Q?K5k0aoESLc6X9zSm3oJLNxF+G4Ii2MjkW0Rs1MAfcUJgPv+T2q2PS4uI2lev?=
 =?us-ascii?Q?lPe6ITj3wzB3/JLvVzkof68GZuTvpBRV/kt7Rot58B+sDzMROS6VoblYka5v?=
 =?us-ascii?Q?lDF/+MdgDesdJj3HtLwDFPBbRGyt7S3zwChg7opbdU9fzaj3f/EttR5GqJDz?=
 =?us-ascii?Q?l/eOTU/KePOSM+dbVueBkUpL+0fZUsBEr7MKVymXq0eENgQ1wdF2qNrhY1yA?=
 =?us-ascii?Q?41AS6CNTCDUpo2zsF3ESJcNmKlW8lJE8AcL/vlSacNHfM4xF9qe3T26mgMKg?=
 =?us-ascii?Q?B6Iyl/SOsdaVBVut8wQxKCm85iYKzUE+w/jfFglTC4LO36mPHmvVSiEaxays?=
 =?us-ascii?Q?u1KJwzvXur51PlZ768q+DtjX1/J0cse8EZde20ZGosQu++T3N+530yI2HoA5?=
 =?us-ascii?Q?/scVsq5DLfuR2P4l6U+HN5JERnNUoeZMT6yWH5P6kvj2Er0ajThBvgGFeorr?=
 =?us-ascii?Q?BE0N+QaUcFwIVO/1spI0DQrZ42J/u9v7ZOfYOZe3854WGbGVsRzWkZUn6yTr?=
 =?us-ascii?Q?jG0zhceVRlHTj437ZFgeVaffNDg8kE+aSfDGHnprbCLZxilgqtF3B+O2l8vq?=
 =?us-ascii?Q?m91QweERMzWDXFrzwxOqm0CrXVyH+AWYupkG3/5+vEEdZQFlUvfLJ/mDVCVG?=
 =?us-ascii?Q?Lv8pdX59pf3uvYzhPUxDaiqL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2090bdfa-a867-40ab-eae2-08d97382d223
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2021 11:13:15.6099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bbeWmiCn6Z6S/RJFy077BUfsjV/qXXfKMVp8iqy9syN6HsK9g7Gr4lCqN0jHl0mwTENBOCms1IOEkPJEtFgcng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2579
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Thursday, September 9, 2021 2:38 PM
> To: Neal Liu <neal_liu@aspeedtech.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>; Tony Prisk
> <linux@prisktech.co.nz>; linux-usb@vger.kernel.org;
> linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Tao R=
en
> <rentao.bupt@gmail.com>; BMC-SW <BMC-SW@aspeedtech.com>
> Subject: Re: [PATCH v3] usb: ehci: handshake CMD_RUN instead of STS_HALT
>=20
> On Thu, Sep 09, 2021 at 02:36:52PM +0800, Neal Liu wrote:

Fix STS_HALT handshake failure for Aspeed 2500/2600 platform.

Change since v2:
- Use my "real" name for both the Signed-off-by: line and the From: line.

Change since v1:
- Handshake CMD_RUN status on startup instead of easily skip it.

---
> > For Aspeed, HCHalted status depends on not only Run/Stop but also
> > ASS/PSS status.
> > Handshake CMD_RUN on startup instead.
> >
> > Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> > Acked-by: Alan Stern <stern@rowland.harvard.edu>
> > Reviewed-by: Tao Ren <rentao.bupt@gmail.com>
> > Tested-by: Tao Ren <rentao.bupt@gmail.com>
> >
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
>=20
> Hi,
>=20
> This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> a patch that has triggered this response.  He used to manually respond
> to these common problems, but in order to save his sanity (he kept
> writing the same thing over and over, yet to different people), I was
> created.  Hopefully you will not take offence and will fix the problem
> in your patch and resubmit it so that it can be accepted into the Linux
> kernel tree.
>=20
> You are receiving this message because of the following common error(s)
> as indicated below:
>=20
> - You did not specify a description of why the patch is needed, or
>   possibly, any description at all, in the email body.  Please read the
>   section entitled "The canonical patch format" in the kernel file,
>   Documentation/SubmittingPatches for what is needed in order to
>   properly describe the change.
>=20
> - This looks like a new version of a previously submitted patch, but you
>   did not list below the --- line any changes from the previous version.
>   Please read the section entitled "The canonical patch format" in the
>   kernel file, Documentation/SubmittingPatches for what needs to be done
>   here to properly describe this.
>=20
> If you wish to discuss this problem further, or you have questions about
> how to resolve this issue, please feel free to respond to this email and
> Greg will reply once he has dug out from the pending patches received
> from other developers.
>=20
> thanks,
>=20
> greg k-h's patch email bot

Do you prefer fixing canonical patch format inline or sending new patch v4?
I added more description and the changes from previous version.

Thanks

-Neal
