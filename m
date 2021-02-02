Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8051F30B48D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 02:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbhBBBSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 20:18:10 -0500
Received: from mail-eopbgr1410138.outbound.protection.outlook.com ([40.107.141.138]:2048
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229554AbhBBBSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 20:18:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WNre9E3cpJdhZAG9ODoYTX+3vtxWaZ6Ks86xZyqObao2M5b5E/PgJM23FgSOPiwJxcFOSmLGtmOjQ2AIEePdaV84dvL1BU3TCoHzLvH7saTcYttfSUbJF8zVWdn2Ux0Bi6c16E0OgtkdMvtSkMP369SUM39XbeTmEfwpSSHiuWX91C7cpeDj+WmiZvqvqZA6lT2wHegvp8Me57Mups8KwOdIG+WfiPORw16a8CH2GE5vOOxKj0MSseGfipyVB977XBgccLATyYpc3zoBoVpX723j3YuxjHpW3U/Yxp5RH2DtPwUvNOL4BVUJo+u23dQ9+rwJ4w6rqgjBP8hkkGXRuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgRhnYDZFoFmQqhxy4xkrWaoxrYTxMHbzem7X3bILFY=;
 b=C6mmpxW0eXHACGSCN0JvxPYvymFqbIDRv9ObaUa4Q1jZ/95GTDYRaZNTxnIrfZTaCpq1ANvgBjdGa0uh+7+JptkIsz7qaXOMwq2txaTyLPKfwX3AuccN7FrCAfCTgcrn5DajHBv2na9f6NGJw8UhK2WreCM6Jb+Lu3SxNK9TYG5jfF/C6anLBlv5EnRv+2B2YPW26RVf3EntUK9TfwO1K15nmKCjFKOPESDxRPVS1HfPEeM8imFJJ57QshAXHvsMQqUFfYrbz2fxQCAEMqVQ8NQlsMiF9YSMglzitdogUNOmBDoudLBODTsOybqLPhhGeWop53Z+WW4V1rpQVNedDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgRhnYDZFoFmQqhxy4xkrWaoxrYTxMHbzem7X3bILFY=;
 b=Cb7pvd8HFUSH8352PWcS49TUUrSC4ap05QVpf4HHgnVEeen3GqGE6ibf37lWgA8O5ytEFwlVEH35LLLGLdzWISbFrHxXoW4UNgXrJz4iwxJ5P1wTFntxHhdjA/cF8+bCVChmt0dN36CSNLzsPP4edBIW4M6mIifkXZgw6hB3gfo=
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com (2603:1096:404:d5::22)
 by TYCPR01MB5741.jpnprd01.prod.outlook.com (2603:1096:400:b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Tue, 2 Feb
 2021 01:17:19 +0000
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::cb4:9680:bb26:8f3f]) by TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::cb4:9680:bb26:8f3f%4]) with mapi id 15.20.3805.026; Tue, 2 Feb 2021
 01:17:19 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     =?iso-8859-1?Q?Pali_Roh=E1r?= <pali@kernel.org>
CC:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Peter Chen <peter.chen@nxp.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jun Li <jun.li@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] usb: host: xhci-plat: fix support for
 XHCI_SKIP_PHY_INIT quirk
Thread-Topic: [PATCH v2] usb: host: xhci-plat: fix support for
 XHCI_SKIP_PHY_INIT quirk
Thread-Index: AQHW2UemNB5r1TTib029sWHXFxYWcaoFwTaAgCCRuICAAoBBAIAPxLcAgADnsXCAAFLOAIAJ1DCAgACo3vA=
Date:   Tue, 2 Feb 2021 01:17:19 +0000
Message-ID: <TY2PR01MB36929302951B0A782A00F6FCD8B59@TY2PR01MB3692.jpnprd01.prod.outlook.com>
References: <20201221150903.26630-1-pali@kernel.org>
 <20201223161847.10811-1-pali@kernel.org>
 <20201224055836.GB27629@b29397-desktop>
 <20210113232057.niqamgsqlaw7gojw@pali>
 <88b48c61-65e4-cc24-d90d-5fba92f05f27@linux.intel.com>
 <20210125142028.th4sscs27arhihm2@pali>
 <TY2PR01MB369295E3D3BF6D5700EC50CCD8BC0@TY2PR01MB3692.jpnprd01.prod.outlook.com>
 <20210126090606.svpamobnrbdxyhgg@pali> <20210201151153.zhk4tq5a3irnkahd@pali>
In-Reply-To: <20210201151153.zhk4tq5a3irnkahd@pali>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [240f:60:5f3e:1:b91a:f1ca:dcaa:6cff]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4dd6055e-16b6-4bf6-c937-08d8c718493f
x-ms-traffictypediagnostic: TYCPR01MB5741:
x-microsoft-antispam-prvs: <TYCPR01MB5741E0B6B8F07F06A441FECED8B59@TYCPR01MB5741.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: razT5XYJrq2xYRKIlAd3i46CyGSjpeFF3jKyqHzTXCVYFyR8fZ8S3C4chUGXfz5FcpRzFxOjrSVfHL2JHAs+r1M9QFfQyZqu0Tx9XJDiEog0oInzm/4N0ZGmirlWk/FSvPdbCCAy179DSxVa7/fqoJgex/JzzGP1GVttgKgPQ/4jK3MefACclxuilNA3ZnEPT+fgbCxh775uPdY0TU9AqtzRYwIzOvkgRisV8mI+DxumPaf8d0gglPnS7TvkNQpn9XYdD9XfsYt2ZMT6VIFclvm+DnNEFboL94up10emETeylx71UJ75h5GYNE40dF5PAlcdNa7/kXv4oZhMzjwX0m91dmJh1uoy/nPDPC2MfgXK3wpfQXT4dnjBdm11k4syM/qoZacocMoqUPSMeYLYyh0hFAGiUzzIs5oa3opA6jCfuE2foqNCsRrp00aTdWfeA2FNP2NPCFGoRIHPwWRrPaJlKvhfldxUUnGNNaXb+gGsl/jA7GgBdLO/Cbf6K2vQpN3/lYiQJmx6HJMd5TF6aw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3692.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(186003)(66446008)(4326008)(66946007)(66476007)(6916009)(64756008)(9686003)(5660300002)(55016002)(71200400001)(7696005)(66556008)(2906002)(54906003)(316002)(8936002)(33656002)(52536014)(8676002)(76116006)(86362001)(66574015)(478600001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?pbWFlOAuvhvV/mRh7J4PVI/DZK/i/5gpKjooqN/Qcakh02k666SMG/T1Xc?=
 =?iso-8859-1?Q?hyy8Dr/1psOQCmeq+AnTlrOwp0Ek8WcP+I6M8UC/DVACFoH3LAK61aaK1N?=
 =?iso-8859-1?Q?09IjtgCFa3lCHfwcAR1UDf4YtR1eHsHwmelsIiU/R7T22y+ah2xjmJNcjj?=
 =?iso-8859-1?Q?qLjf1DItpglg3pz1ReEnAkbSDKfwl1HvCVPo7EFkYGNZUHnckL+ka6P1V9?=
 =?iso-8859-1?Q?edKwyOA5aIjF98ldOdaLSq7ZwgZp+AoQYfm3dqsxbcaweBSy2M9CfXHoUZ?=
 =?iso-8859-1?Q?rxIOTpSXfmQDIUqCMv9UmJhnxftE0D5p+ORRr1SQ8Selh5TsXU/5helZo3?=
 =?iso-8859-1?Q?+gJUCgmlQIjK9e6r9UgS4ee0NmhWSPLZGmGFeQYhrXvsXt11k2SD/pEICF?=
 =?iso-8859-1?Q?u1H8q36gB8WnbUW4t/XV8gQ4fSWHh6aJyz6EuUfGumgx+Nd2F2qxzxSvIj?=
 =?iso-8859-1?Q?IUBGY20XnT7eP1Y2bJnL+huWzfsnQmsLs7lQ/GUsiSy3R5gLU1dTnJtxZP?=
 =?iso-8859-1?Q?R18hcYX8X6KR2g9XK+2VoLE6bbL27HJdfN7IWsQ7zTDx3E8pVo6Tv3zfE2?=
 =?iso-8859-1?Q?MROAl6j+wI7XcHQ8/z+LEtXFkQu1j6kydNYnkOzXtYoOF4gACeml3UvZOE?=
 =?iso-8859-1?Q?A9IZ25hDka+OHnZmTuJbuftNUtiRAocYZM33DPTA1x80FtaOdUAnrpYkDG?=
 =?iso-8859-1?Q?9fajJwSek4BAQCjUW2L8XvUvZ16JD877nklJk2t4Wvl2MqS2DHhgYf0saU?=
 =?iso-8859-1?Q?GUyMNcBUa7qiyvf+Iuf4+T7tM78tw9Q+OLgj3A8at3G2CBmdcBGt7BePOB?=
 =?iso-8859-1?Q?apm37y/q3YrMK/SNXo57BdWa1th9kwi3qYnkxXbXXM5BCdDT3/4ajsFqfe?=
 =?iso-8859-1?Q?M9e4PlxoEsFPTGFmIb9RpGzYYDERX00wDckIY34h05BeaOl6aYkNYOMc2P?=
 =?iso-8859-1?Q?OVMLaey6zv68Fm0qQADzl+kDPuZxAqrh+4+4ZVhFbnbTcTgubYUDE/IrJS?=
 =?iso-8859-1?Q?nFBfzEllNWvnglx9HTUCEu5luAcJxixJPd9wG8AszdG5Eg94YVMVEfyMmx?=
 =?iso-8859-1?Q?GyO+2Ke7US+0tzTvMSKkVhUlhFwL0+SM1iihjbHZVoa22fmgJY1PAUe7jo?=
 =?iso-8859-1?Q?ite4TXZx9yz86AKCv8roQ+XFW6Yk0=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3692.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dd6055e-16b6-4bf6-c937-08d8c718493f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 01:17:19.4035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6eMZuFC25EK/L1Gx8lgf1WvF2rPQ1ItI0Ibi7w67JNXiwsv6Kw4UlCHMRH9S015CgBomXZxhHE8fwfr8swrvvJvXAjddxnFJvzDWtxYacj8YSB2+8V46SGISkBSoDQi2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5741
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Pali Roh=E1r, Sent: Tuesday, February 2, 2021 12:12 AM
> On Tuesday 26 January 2021 10:06:06 Pali Roh=E1r wrote:
> > On Tuesday 26 January 2021 04:27:37 Yoshihiro Shimoda wrote:
> > > Hi Pali,
> > > > > I can see the benefit in this.
> > > > > In the xhci-plat case usb_create_hcd and usb_add_hcd are separate=
 steps, and
> > > > > we could both copy the xhci_plat_priv .quirks and run the .init_q=
urks before
> > > > > adding the hcd.
> > > > > I guess the current way is inherited from pci case where the earl=
iest place
> > > > > to do this after hcd is created is the hcd->driver->reset callbac=
k (which is
> > > > > set to xhci_pci_setup() or xhci_plat_setup()).
> > > > >
> > > > > xhci-rcar.c is using the .init_quirk to load firmware, we need to=
 check with
> > > > > them if this change is ok. (added Yoshihiro Shimoda to cc)
> > > >
> > > > Yoshihiro, is this change OK?
> > > >
> > > > Can we move forward? I really need to now how to handle regression =
in
> > > > xhci-mvebu driver. And one option is with this patch...
> > >
> > > Thank you for asking me about this topic. I tested the patch, but unf=
ortunately,
> > > this patch is possible to break a rcar platform because a phy initial=
ization is
> > > needed before the firmware loading if the platform uses the phy. (Not=
e that
> > > upstream code (salvator-common.dtsi) doesn't use the phy for xhci. Bu=
t,
> > > if we use the phy on other board with this patch, the xhci will not w=
ork.)
> > >
> > > So, I think we need to add a new function pointer for your case.
> >
> > Ok, thank you for testing! I will try to come up with other solution to
> > mentioned mvebu-xhci issue.
>=20
> Hello! New version of this patch is in following thread, please review it=
:
> "[PATCH v2] usb: host: xhci: mvebu: make USB 3.0 PHY optional for Armada =
3720"

Thanks! I'll review it.

Best regards,
Yoshihiro Shimoda

