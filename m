Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 979FE359C6F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 12:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233537AbhDIK6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 06:58:35 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:9527 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbhDIK6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 06:58:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617965901; x=1649501901;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Sz1+AkwyCIDtiOikQgu2tlRLQJguHYHOk6J43o63DlI=;
  b=mtEfZN42Apa9K/SGNw20xLBYTBONSGraz7zJAJyRV3VmwfHnn+2Bgu79
   hDhyajAXQMNwBQMEdtKpxbZHqkWf8M0UaW56TDYkdkRVq8sZ6PJMx8mrj
   CtOOTkDSwTPM+A8jLiF+knUfYV584p8rOIwFCcU55cckzEx/LZX33PzkR
   clMx8BebHPWvozMLdv7t28URWBpSJhYzhwopnIczysKPxJNQZ1su9W4qr
   CpQNB+2u9itEUjg4kpRvuV0e+V+Pc3b/J710NQtWASrY3PsETK47Cutvo
   IEhldR5nPGardEv8vWZygLAZlQ6mpZImpMB+puy9athb7gP3HbT64eqUX
   g==;
IronPort-SDR: kfJzPVFFaXmQQOViXMg/TSzLkbezVxUMOjAmrnU/rgofYZIT5lYhGsJF7sLOXPPZ/oDGn8XRoI
 iUGY9S1FLYCzT0mwW3Ov2TfADHn61jXP8NOy1s0MmHRKpLMiIoivopLH9RwWyHN6AmTd+vHbWB
 mqDxPKtdb92aAaGzM4/qbxsb+IlbhmuH+mOSxgtzJgpJS+xmVdOCkqIS59lWCCpgBKsfTtU+zG
 gjCMgr96EmxDuCM88wAOBGLtpWAIkHDQPALakianzN7jSWTBQXswy4qv1NSrPr7M7ZqKc4BuYl
 Kw0=
X-IronPort-AV: E=Sophos;i="5.82,209,1613458800"; 
   d="scan'208";a="122419471"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Apr 2021 03:58:20 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 9 Apr 2021 03:58:20 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Fri, 9 Apr 2021 03:58:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bSjdmVlOvTG6H6rxtMLBHl9IdYDSCr71LCfLTFyVmsDo1kTV3vzpiEe4Zuxtr/SwJNdP6duhfPsxOBJ/YJ2HVhhnZI6gPl91q3Jbsb1bBH5K+mZ8N+uHu2R7ucfxENpnxi6CHZaTSdzuQvXuBhEUyV/LUe+mQv4YeFUWFw8Pm7ePiKYRlRt3cvIeCtSH+/B8rPTRIK+rGLop9dTFo7Eh45T+yFQwmkkBOjHb5ShwYOQLg2OHKZWnY++EM3Ru3N8LTA/R14IQrapxk4myefIqL7fkgIp8ecbSV4sv4e2QXbS4Ctk5OFyuI43F3dsL/mG+WxE/VweXjI9S6tA7XulHwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cv5Uidt5q1caBMI4kYQ6ICnO1/fzhxYuqJSqzJCf0lI=;
 b=XxRmYp/yMrDAXgkU7OoeQPSukPKviPYLszZxLXjvIiD3rmK+0HZvmJJfzGIgSTf/634euRVlAmRMvnMh1RD8H0+uHTGJ4cJWrF4UCHh7wp1oCFFQX+nWjTF5ikcqmPV933TpYKUyqkySakx+6UlihdUmmgtek7kZsGcm6eYTkSwolPcq7pw5w9xiPfAoVGldt87TXyj4DVtRxgOXFiyawbTo6dBsziLcDJufF1Mx4GBHTXpTRhGJ0wfv4BjvxItVyixcJp+WtdYofnC5245oe9M9LF8AcPZN5G+2Y6v05yrSqSyf//lqHqvchv98/EjirT2Jy47+kllcCOpWkPfdlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cv5Uidt5q1caBMI4kYQ6ICnO1/fzhxYuqJSqzJCf0lI=;
 b=Yczc7WPLoo/F1JF8EPEYqFv1JD36airP84DjkAvBifPmMb1YYHjqwirKj79XJUm2GFma/5A09H7xYN+57gdOkZ5AKA4jTZUNqIV0yyyjS8uhKvwt/AoX2Egn5BgbffCYE2LsMyhSwbOTgvcn+cy+LV7KrWZOBN1JHPihWdCiLoI=
Received: from DM6PR11MB2777.namprd11.prod.outlook.com (2603:10b6:5:bf::31) by
 DM5PR11MB1546.namprd11.prod.outlook.com (2603:10b6:4:d::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.17; Fri, 9 Apr 2021 10:58:17 +0000
Received: from DM6PR11MB2777.namprd11.prod.outlook.com
 ([fe80::380f:b21a:cba2:7c18]) by DM6PR11MB2777.namprd11.prod.outlook.com
 ([fe80::380f:b21a:cba2:7c18%5]) with mapi id 15.20.4020.021; Fri, 9 Apr 2021
 10:58:17 +0000
From:   <Ludovic.Desroches@microchip.com>
To:     <Dan.Sneddon@microchip.com>
CC:     <sam@ravnborg.org>, <bbrezillon@kernel.org>, <airlied@linux.ie>,
        <daniel@ffwll.ch>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/atmel-hlcdc: Allow async page flips
Thread-Topic: [PATCH] drm/atmel-hlcdc: Allow async page flips
Thread-Index: AQHXJXfXeUh7nXiQTEai0pdL09hZoKqsE4wA
Date:   Fri, 9 Apr 2021 10:58:17 +0000
Message-ID: <20210409105816.cfffdr3edzi4yntm@sekiro>
References: <20210330151721.6616-1-dan.sneddon@microchip.com>
In-Reply-To: <20210330151721.6616-1-dan.sneddon@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: microchip.com; dkim=none (message not signed)
 header.d=none;microchip.com; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [109.210.128.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fab70d63-d64a-4784-07c5-08d8fb466164
x-ms-traffictypediagnostic: DM5PR11MB1546:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB15465660E8D11DF17F8F8AA8EF739@DM5PR11MB1546.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:989;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5W/TObVu7lZcNLCPf0Zky7hP8qDGkFMTQPNV8Zqe3GqUxj0+4zMlEg+829I7fuVZmJJ1qEb+seu9aAwa3FPcQ7P5OXIMAppORG1Ilt1MSXUey2apxAjUzSl0Cg8zWo9naChL2V7Nq7vP2r64nhsWv1zpQbUlIeHny1gaOjoD6yDPvlaVKz1eewTOIVCtzwfQ1+TcK+s9KPGxBKO6gWnEYvIDYb9U7aDWkDknOPJ5O7DFpns1CJPTgP6gfd1Hn3ObjFmVB88ffN3vhrBuW6pnl21bLV+4BQAKlRflfRgRYsYHx+O7O5xFv8NwvJUH9pKRgw8bQqv6lPBKrS5ubor7/t3yv/+pPI5kCOrrpZ8G0wzV7KsMJzJBvteo1Wk72u7jpJpnMqs0/CHnFs4SSCKruUnpwDI4/vr+O8n97p3cF8a3S0tPQWd68gdvGOQm2PcWOh8ZUQaSie8Fbi/1tdoUFOPpVDPn9faTuDTNENIesUt1lF6Yx8OeMek2xdUYFF9c663EZ6QzVEKAY2YrxkVp+gSV32T63KX8+/NhmAujWRYjnK7MG3rudTAsmT0XMYgtKJ+eOAm5k9fgpi45YyArGnTDKLzc7QIQFwe2srcnC3zd7L4eDZmTGRro3cjqP2dRPEE+60ItMI/zImW7H2COEcF9VRsfMdIGNdec71R6iPU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2777.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(376002)(39860400002)(346002)(396003)(366004)(136003)(8676002)(6512007)(8936002)(478600001)(4326008)(2906002)(91956017)(6862004)(71200400001)(38100700001)(9686003)(6486002)(86362001)(64756008)(66446008)(66556008)(186003)(66476007)(5660300002)(26005)(4744005)(54906003)(6636002)(316002)(33716001)(6506007)(1076003)(76116006)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?gGXbvLobml7lEdrPySjqogaVO3JS+XmNCMGfn6uG2lpJaVsHrZF7r8BTIUzj?=
 =?us-ascii?Q?xfz7Rb5mBAzBrRaZvkt371tcuImCVwjQkPZNihCyBRsSgpt3DhuZoh7RZqCj?=
 =?us-ascii?Q?GNsaVEI3zcyOwNxUcwu9xTIOiwVIGF5uBUKLAn1FZzyv+oRu9DwLujugLgLM?=
 =?us-ascii?Q?v851nTPjGpjakuAA7nfYob3Dx0VAIkYpkCkecGqAHTWPQJxtWnBB6ZmvlvFQ?=
 =?us-ascii?Q?4cRTZ7xMeWH6v7BE+RunuZzGZxdXLuzh++zHKuqjTz8nlqVdDNEKYZ7DGaIm?=
 =?us-ascii?Q?QNeBMTvV/JZkGFE64/eas9ReSGbXTb9dO2hA287S7/ikhIO+psLLdiSbL9JB?=
 =?us-ascii?Q?c7NMrud5t6YTTmp8Fx2ecRnboR+R98iOnJmX5rjF7ucZTRYx81sZ1+SmlwGI?=
 =?us-ascii?Q?EGr6upheLLspf71QzNrtTElVMoadq3m2W1rH3r8qGEefuxSH3eIAHHer03zj?=
 =?us-ascii?Q?jRzjM+YIebBsWjF2g7y2XDchfM4w4Ix4tDnSnGTrPWLi8Pu869QvPQuB2wH9?=
 =?us-ascii?Q?eWXi6Ajusvxk9dghby8d4mH1Cv6uM8akXYYPBQODid2Q8jc0TF+vNaHTZSwK?=
 =?us-ascii?Q?peJiSy1l5AI/tfQXWd6Qrn8o1ueGL3vdCD2i4l7bCOXY2HYUDpXC0TtnFdPv?=
 =?us-ascii?Q?7B3oZew9GyUKi9aJDsvNwjoVxFD0pnx3akO8RERGAUE/RdOf2BgdjJ/PMOxy?=
 =?us-ascii?Q?zkZtItaudkshybUGkaYNSyscxtIvV4GFPakyhY+cM34Q7OAiff0p86ZOmymE?=
 =?us-ascii?Q?siXkdSDDZwEQOsnSxzSi9Jx2kE+yK44S/06OkU/vfb441ZcJ1ASEiNlM4F1a?=
 =?us-ascii?Q?jzVD0AC1iilCHzHiNIC47aZ9l1IKDMIEZnFNY6UZrdNfHvwgtMmxHoMgHkQZ?=
 =?us-ascii?Q?YOS/j3Eo48YpNJsd5Srj1wZpxDV6SC3AJVbThfMz4D2UvKDwGmJMDubzRC3O?=
 =?us-ascii?Q?sab69+9+uaRYQRuI8YZiSr9i4VADMcW8pcZ6bsLa64w77iEz5/x3li86J+iu?=
 =?us-ascii?Q?irEvdDt2IGEQ79IcjKq4RvYUe22vZbE9kpVjwaDdpKMbcjUmFQv7quiJjNMu?=
 =?us-ascii?Q?j9dBqM7Hxj2+kH6xoXmAQP/xmnd1j5nx3gop1k8P28TVAw1toXuWiC9Jese4?=
 =?us-ascii?Q?G8jZNGnQ/mFWHMruINRKF4up3s3we57mL1VziGmWn4XJRpYTmX5P0qDg9dYE?=
 =?us-ascii?Q?FdDita61VSlsbAcdzprXb5ZCB79WK1o4XaTyD8HwZbpuzA23YNeeyTBkVO8r?=
 =?us-ascii?Q?JtbV5Syf7WuGBCjKCdptPIixlNVFZyjKj3s0iRHY/og/adh0fi1e1pVCyJg/?=
 =?us-ascii?Q?qyRK8kaM5HahzxOQ5cLrYw/R0uGz3SLk+0g/KUTwpeN01A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1511BFD5948D864DB42045638CAC2F84@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2777.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fab70d63-d64a-4784-07c5-08d8fb466164
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2021 10:58:17.1804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wrIdEXiV5azwTRn/EkC8jT2jpTHKgc3xO6O5YupE6K27ztvnVnJPhLEXWRn3cSuM1v66mXL3Emo+6v1jfH2uDDrUCStQn7NIayBAr6drCjU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1546
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 08:17:20AM -0700, Dan Sneddon wrote:
> The driver is capable of doing async page flips so we need to tell the
> core to allow them.
>=20
> Signed-off-by: Dan Sneddon <dan.sneddon@microchip.com>
Tested-by: Ludovic Desroches <ludovic.desroches@microchip.com>=20

Thanks,
Ludovic

> ---
>=20
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/d=
rm/atmel-hlcdc/atmel_hlcdc_dc.c
> index 871293d1aeeb..f6c3d8809fd8 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> @@ -686,6 +686,7 @@ static int atmel_hlcdc_dc_modeset_init(struct drm_dev=
ice *dev)
>  	dev->mode_config.max_width =3D dc->desc->max_width;
>  	dev->mode_config.max_height =3D dc->desc->max_height;
>  	dev->mode_config.funcs =3D &mode_config_funcs;
> +	dev->mode_config.async_page_flip =3D true;
> =20
>  	return 0;
>  }
> --=20
> 2.17.1
> =
