Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8E43270CD
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 06:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhB1Fru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 00:47:50 -0500
Received: from mga17.intel.com ([192.55.52.151]:49264 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229477AbhB1Frt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 00:47:49 -0500
IronPort-SDR: yXgbgvc7kNC9CtsPVPBZGNIE5nkE6vap2pTIHU7xVMYJ5ck85Lv3qOqiM8j3NrTOIqghztXB82
 PvbxNso72K6w==
X-IronPort-AV: E=McAfee;i="6000,8403,9908"; a="166068695"
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; 
   d="scan'208";a="166068695"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2021 21:47:07 -0800
IronPort-SDR: kpP/r/HfVSFaZrc2tHG62vir6vm7OpXqNQYFsuW1UGmI3F2p0yz4dycMaHR5zzqn/tx0rYH0Ns
 +jywudL52gLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; 
   d="scan'208";a="396019831"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 27 Feb 2021 21:47:07 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Sat, 27 Feb 2021 21:47:07 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Sat, 27 Feb 2021 21:47:07 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Sat, 27 Feb 2021 21:47:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KX08uEVTyUnidfRVd+3O9ws+znHg/D/HRmvUpS2dPCYh6y9xkO8/UqJ3QaRB1EPNJ/alCvI9dHXKIwj4eo1We4H8++scP7pclXpHxbsxDCxwIBYp06+f70ZkIEUvqBGkuUmQJCGMfyXsEkRhJ0vnZWkHCB2L4ZQTmo8AfeBcHWFAxdmsqDcqQUUW5eeiA3ocVatwxsfWueS52aa+VelPB2nU0+s43/BEnk+r6UbcAGBI/a0xhS+zaEfqgOdyufwSkxrVfIKBjarFRl60nmuUqeEYOEpSAT1YG89fQ+OUxBxuP+CsBiYealsHH21kqCMZEPBGLBM1Jt2tFOvuOkqSkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G86PuMX8DIxcgnCSFrZW/UJwXjmo/YsD1Q/c/L+gX0w=;
 b=OI6Ohg1GazK5vczMVHLgrfZKdXJ9wmPKYvE1ujmG07pge8bI53EFCrkTjDyVJjwbHkLKNjxHxOPYUBl325NnIfuVZl92g6psfd3Owk2RN5ZdjnKsgaZgcwORkgJJdIJ30UGzmFCd0KuEPDTEptY+0XXAkZW174rYYw6nStJ/xLaLq71x4/4rIYs80tVi/JARWvEKXiag5/H5rTcQhLD86+qisKTUQi1XXC0VQhf/RVfy7bGUagO9v2zdathFHqUJmdDE6XTcvbNcS4QpUQcsNO4b7CmE7ijAaHn4HFGF34g0kAoat4fy/yALs68SMhl9PlQ6Q/msU1m+GUvWwOpTEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G86PuMX8DIxcgnCSFrZW/UJwXjmo/YsD1Q/c/L+gX0w=;
 b=S+VshaoDv9RCVpqGt9/lnkAcypOgNXE/weo/kBnj8+kLWX/Eh1S4RFjyAZ2UM2X0j2++kXIqAchZy1THwIWaqwsaGuoUgn/5gj0eaxhILXafMF6ELUPsRQ+87q9sw1EZc6XzvdoHIvNABbLmBtwENS4oiZ8RVHVaawZvKj0paj0=
Received: from BYAPR11MB3095.namprd11.prod.outlook.com (2603:10b6:a03:91::26)
 by BYAPR11MB3014.namprd11.prod.outlook.com (2603:10b6:a03:91::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.26; Sun, 28 Feb
 2021 05:47:04 +0000
Received: from BYAPR11MB3095.namprd11.prod.outlook.com
 ([fe80::e47d:c2cb:fe53:e0e6]) by BYAPR11MB3095.namprd11.prod.outlook.com
 ([fe80::e47d:c2cb:fe53:e0e6%4]) with mapi id 15.20.3868.033; Sun, 28 Feb 2021
 05:47:04 +0000
From:   "Chen, Mike Ximing" <mike.ximing.chen@intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: RE: [PATCH 2/2] drivers: misc: add ripple counter driver
Thread-Topic: [PATCH 2/2] drivers: misc: add ripple counter driver
Thread-Index: AQHXDEo6dgMIhSeO9UO+cp3T6YCSu6psXLuw
Date:   Sun, 28 Feb 2021 05:47:03 +0000
Message-ID: <BYAPR11MB309522FA78A7A9420CD75A8BD99B9@BYAPR11MB3095.namprd11.prod.outlook.com>
References: <20210226141411.2517368-1-linux@rasmusvillemoes.dk>
 <20210226141411.2517368-3-linux@rasmusvillemoes.dk>
In-Reply-To: <20210226141411.2517368-3-linux@rasmusvillemoes.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: rasmusvillemoes.dk; dkim=none (message not signed)
 header.d=none;rasmusvillemoes.dk; dmarc=none action=none
 header.from=intel.com;
x-originating-ip: [69.141.163.46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d09014f6-10c9-4057-fc35-08d8dbac46b6
x-ms-traffictypediagnostic: BYAPR11MB3014:
x-ms-exchange-minimumurldomainage: kernel.org#8759
x-microsoft-antispam-prvs: <BYAPR11MB3014A3A5E02294F911AE8664D99B9@BYAPR11MB3014.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FSbqSZtfw5DBZaSPd3ffGXkMykUJ6X8DE4Z/OP06TazbkK/XYnDC2KryxLw6Hrvhxp/u4M7fJ1bruTNy/0QcI28Ao+cQz+KnpZhAvXtgtq+OodPyEnHu7lX5XLe3TOmGCMVulD/TG3aO/7710hy4+SuM7GhJmTU6370fDIgT3OCxWIXDWFwfaGpQGpENgW0NKS5pspl8/6+ySltZqevtzG8F8APsgs/aNuXjsUBkOLbPqvMJbC3Hjy+M3ZJz3iw2yOtjK5pztEcuciM7rjw1QcoglbM6CTui/BDhznX2lN/Pxjj2hfMlfAY/UD+GgUgYeTrh2mg7UEYJm+lSOZVPrb3aO8M6SI4CefCPsP4WHW+tR3QavPMjFyMLrZbRzDYTA+ixoDXWjU+Cpe+VObnHbzBF0zDcHm7jjkPPi1HQAuUuhqcsnrFH0tKiHZQfoSCZdlofpW2Z4eJd/iEUQ5Wfe+Xs7q4B6Hu4Fhcw5sjBD5yQuT5z5Bo2rOQ/LVJzTM6jp14XjCNdMHanPD/KOcme9cSWROqmSEtR33yGaftrGo8ubUwl7RU/rEhonffAhPXHCzu9P1CZZU94UT2IOsKk4BFcIrn7r0wNxSxYkgWwKyw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(136003)(396003)(376002)(346002)(53546011)(6506007)(7696005)(33656002)(316002)(110136005)(4326008)(8936002)(86362001)(2906002)(8676002)(54906003)(9686003)(55016002)(966005)(186003)(478600001)(26005)(64756008)(66446008)(66556008)(66476007)(76116006)(71200400001)(83380400001)(52536014)(5660300002)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?LuDc5iawUXMOC6jjhd2RWXzjg5gSxUcWkbMqiYRJUAghHeR/KbCnnViObMjw?=
 =?us-ascii?Q?EjKGDVCGPTkr+Nd0ch4y6ztwkYkVpPQs+ipFE1IwblCchR6umHK1IZd98qIT?=
 =?us-ascii?Q?B0XCakRu3oOTaMuHfCL4c6T3RzdfwvWN/t/6wTjCs9bL/HTjP6fKeRvGPSgm?=
 =?us-ascii?Q?Q8NOKQ70Al+T1Ge46OiLhVp9qeTIN7xqUI7utyiaPan1SkgLYSBWMTBTuxnh?=
 =?us-ascii?Q?crfEjOb/u6hbni9Dn0/y+7Tc62IukE3tLlCBF/Z6wj/9tcfI0OFtH4D8W3jU?=
 =?us-ascii?Q?FWDW2z6weX6Ifx58eDL7BD/95xDu1LZgAA648A7e/BQtF7+R8V3Rj1oj8kQR?=
 =?us-ascii?Q?9MCut/R9/7h7FI1TkEYXw/5S7SKUfhCwNsduT7MevKic9s9DK3xRJtDIjYx5?=
 =?us-ascii?Q?+IAl/3XUjHn3TekCBwinq5mfyvhn4qRkATihXYIv/cSuIcVkE1r7j6qUuRUo?=
 =?us-ascii?Q?eRaFCXXKgaFHge37SmJqwbRv0Hj6M8PvHbvqS1et4mbA8ydKAtuFLuT0vNLe?=
 =?us-ascii?Q?j+ZHxryQBSCxiXlg1BWZVqLlzsTeyN6m/klyVks4QiHzmkgSSZ7enQj1bkdU?=
 =?us-ascii?Q?WNUY5Pn2yNiPhq9EQNv/yrSknqimOL103ftRi1N+pZa+RTg5uOaYONwBabAF?=
 =?us-ascii?Q?VKht8N0sexw2jMKJKDjTchbfDmVgbYMAjTGV92hgB6EibXJzTNfIwOMvJ61d?=
 =?us-ascii?Q?ZONrENs9I0Zog9xuuo71x58D64dP4pAiBA9s1Nfqfw/4/StG6fCOAcjDU7rH?=
 =?us-ascii?Q?AiiRRODY1v4/tPtvSPD/adZRjfEL0I4ujmXLOQFnhbLps4EHe810uO1EY7NF?=
 =?us-ascii?Q?6LF5vrKMXMZ1EvLFFIjAijVayrpIWNeOXu5wtXT33eQkEaTXn9TUhcuJgdGD?=
 =?us-ascii?Q?2BsG7IVuGLbaJ92ENxAQM0ylOkH0Gq1QTBU8zctzm+1kxvx18Wg5asPzlBo5?=
 =?us-ascii?Q?44y0yfm/1DRqKRZ04GMuo6DCcrOgaknxAjdQzWjSZdRLBv0YExIjP8sK4+/R?=
 =?us-ascii?Q?mV/32nlA1EK7eg9UTUiPonBdV3qOYBLjEBFdaodYpcwlhipCuW9sycHDE5oV?=
 =?us-ascii?Q?bviHd7hMP6RmeUYlRQDLohUKP1Dpp28iG1BnKuhAlOQk98GposzTiOIrtiOT?=
 =?us-ascii?Q?kSsx3OQJoB9IOdlJsks5+znO9fUy2dAlHv7U6+CcH1/at2Yc3lcInGEh3FdK?=
 =?us-ascii?Q?KPfZu4jgbbkREi5qGuSp1Av5hPv3kE+yqLqMLZz2TfPRJhKTvS1MaorzCljB?=
 =?us-ascii?Q?vSt75n2r2g7OALeVi8GmMiuQD7vKT5DYlLOOwAjR/scTrxIaSYG+03kuJCFM?=
 =?us-ascii?Q?iSoGWTRp7FjNjlutcY/+dvcs?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d09014f6-10c9-4057-fc35-08d8dbac46b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2021 05:47:03.8651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X6hx0v+AjYdU84W3SI/7mftvAKXG9LH0WeCAeLwUEQyaO4hCsn3Wci4s5gl3hIeHGBEX7/fPBR7rbehxRoQGYDjizjkR43+YGNSzy2xzvg0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3014
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Sent: Friday, February 26, 2021 9:14 AM
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Rob Herring
> <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Arnd Bergma=
nn
> <arnd@arndb.de>; linux-clk@vger.kernel.org; Rasmus Villemoes
> <linux@rasmusvillemoes.dk>
> Subject: [PATCH 2/2] drivers: misc: add ripple counter driver
>=20
> The only purpose of this driver is to serve as a consumer of the input
> clock, to prevent it from being disabled by clk_disable_unused().
>=20
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  drivers/misc/Kconfig      |  7 +++++++
>  drivers/misc/Makefile     |  1 +
>  drivers/misc/ripple-ctr.c | 31 +++++++++++++++++++++++++++++++
>  3 files changed, 39 insertions(+)
>  create mode 100644 drivers/misc/ripple-ctr.c
>=20
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index f532c59bb59b..44b0b6ce42df 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -445,6 +445,13 @@ config HISI_HIKEY_USB
>  	  switching between the dual-role USB-C port and the USB-A host ports
>  	  using only one USB controller.
>=20
> +config RIPPLE_CTR
> +	tristate "Trivial ripple counter driver"
> +	help
> +	  This provides a stub driver for a ripple counter, whose
> +	  only purpose is to request and enable the clock source
> +	  driving the counter.
> +
>  source "drivers/misc/c2port/Kconfig"
>  source "drivers/misc/eeprom/Kconfig"
>  source "drivers/misc/cb710/Kconfig"
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index 99b6f15a3c70..d560163068a9 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -56,3 +56,4 @@ obj-$(CONFIG_HABANA_AI)		+=3D habanalabs/
>  obj-$(CONFIG_UACCE)		+=3D uacce/
>  obj-$(CONFIG_XILINX_SDFEC)	+=3D xilinx_sdfec.o
>  obj-$(CONFIG_HISI_HIKEY_USB)	+=3D hisi_hikey_usb.o
> +obj-$(CONFIG_RIPPLE_CTR)	+=3D ripple-ctr.o
> diff --git a/drivers/misc/ripple-ctr.c b/drivers/misc/ripple-ctr.c
> new file mode 100644
> index 000000000000..f086eaf335df
> --- /dev/null
> +++ b/drivers/misc/ripple-ctr.c
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +static int ripple_ctr_probe(struct platform_device *pdev)
> +{
> +	struct clk *clk;
> +
> +	clk =3D devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +	return clk_prepare_enable(clk);
> +}
> +
> +static const struct of_device_id ripple_ctr_ids[] =3D {
> +	{ .compatible =3D "linux,ripple-counter", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ripple_ctr_ids);
> +
> +static struct platform_driver ripple_ctr_driver =3D {
> +	.driver	=3D {
> +		.name		=3D "ripple-counter",
> +		.of_match_table	=3D ripple_ctr_ids,
> +	},
> +	.probe	=3D ripple_ctr_probe,
> +};
> +module_platform_driver(ripple_ctr_driver);

Missing MODULE_LICENSE() tag?
See https://www.kernel.org/doc/html/latest/process/license-rules.html#licen=
se-identifiers

> --
> 2.29.2

