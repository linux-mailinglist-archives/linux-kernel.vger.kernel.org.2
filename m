Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED8EB30BA3D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 09:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbhBBIsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 03:48:38 -0500
Received: from mga11.intel.com ([192.55.52.93]:12171 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229975AbhBBIsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 03:48:35 -0500
IronPort-SDR: 6nrJlgn7N6M7x9RI1xhKeny1Tvomx1NzOu3PJW1n7MyzcX2jA2g/aQpwZwW6U4LkW/TVMW0gUm
 vffgUn18rkGg==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="177312151"
X-IronPort-AV: E=Sophos;i="5.79,394,1602572400"; 
   d="scan'208";a="177312151"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 00:47:55 -0800
IronPort-SDR: avySLk35+vqkXKb0tLytWPJUIw3mv1QodxFp/NK64d9ys5wl02AaVN4LCnQRDVWT4oVJNVOvXN
 iHxc7JNzjzkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,394,1602572400"; 
   d="scan'208";a="413081090"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Feb 2021 00:47:54 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 2 Feb 2021 00:47:54 -0800
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 2 Feb 2021 00:47:54 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 2 Feb 2021 00:47:54 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 2 Feb 2021 00:47:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QgNOzC8mkH+Dz8n6CKksyZK9PldASEO0xwKzn8WZjSsZJ+MyMwpPV34REkmRaRxYFgCVq68YflZTLvPHm4uBcsDXxcK1Kf53L08P1PyvfgdNrQlKHRS4v2bIQb0dp41/0LGCgJ1rfdY7BCfPHRSK/VDMMMlmhRT0Zi8mUVoQIFpV5RKUk7zhRuWEm1gok8krgoeiKavvcdj85djxwNoS/+lP7iLowbLxOSjCD2vBzFR/xUBXzzXnfzf/Pk3zEFkdz5xmSxKWnwQ7IPb8DtO8xFtPXA/cTle/wZ7D0z7OGrw86L117LLQj76DW2OpCR7YY5yJtA1qQgK72l231BBZ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OlUz+k+ZKUD03w5sAX4BrJLZqxIwyaUZ7iangTgTIh0=;
 b=Jh9pa/K2/VQOCSJF7+6ZkSdxKf0qH0tr4lBdELfaaYNfouRNAQV831NmnjMm3Po7loTAqnWNxtlid+lYp1slZE6BSJ+VRBmlxlHE5GfQP/X0eKcDQrjSEI8Ba0UuuPYdQmh/485P5CddPYfS0WofUr+wutYq9uYoz04GkopEnlavWOVglLn/fZZnNBN9Z16vtaP2+Jq+SEqYweC3TFCsf33c/+9uuW9eZfytiboB9xraAE8ACwteulY9fRs5nDrdBYZORO+lOY7VhHKiRQ2zErJ4T7VcdVhuQ5I8WZo7J9BkhdQ9t3n06vJa+Uhy02GiEn6rJT8sWWE7X9CKyhhRIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OlUz+k+ZKUD03w5sAX4BrJLZqxIwyaUZ7iangTgTIh0=;
 b=LN8mfGtkRBuBTZJzlZgapnJ5cq5TjzeJjTRnJo/4mQjImi5d6637cac7NOyB/0DEIs2LKMbSEvl5/Dm1KJOZhfArkiZY33uDEpeSINHzk+6bUiK+dCV06T3Qct4eAPfPyhKY2qO3+pR5QXqCwBJxeHgvRtx3WAwzo3+9XjTbi9Q=
Received: from BL0PR11MB3234.namprd11.prod.outlook.com (2603:10b6:208:65::14)
 by MN2PR11MB4415.namprd11.prod.outlook.com (2603:10b6:208:192::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Tue, 2 Feb
 2021 08:47:46 +0000
Received: from BL0PR11MB3234.namprd11.prod.outlook.com
 ([fe80::d19a:edde:cd0:9835]) by BL0PR11MB3234.namprd11.prod.outlook.com
 ([fe80::d19a:edde:cd0:9835%7]) with mapi id 15.20.3805.023; Tue, 2 Feb 2021
 08:47:46 +0000
From:   "C, Udhayakumar" <udhayakumar.c@intel.com>
To:     Rob Herring <robh@kernel.org>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>
CC:     "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "palmerdabbelt@google.com" <palmerdabbelt@google.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "damien.lemoal@wdc.com" <damien.lemoal@wdc.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "peng.fan@nxp.com" <peng.fan@nxp.com>, "bp@suse.de" <bp@suse.de>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH v4 26/34] dt-bindings: misc: intel_tsens: Add tsens
 thermal bindings documentation
Thread-Topic: [PATCH v4 26/34] dt-bindings: misc: intel_tsens: Add tsens
 thermal bindings documentation
Thread-Index: AQHW9q6lj3FUU2CjtU+y+miynl+YGKpAa+8AgAQkwLA=
Date:   Tue, 2 Feb 2021 08:47:46 +0000
Message-ID: <BL0PR11MB323427EEAE8176C0033178A1E2B59@BL0PR11MB3234.namprd11.prod.outlook.com>
References: <20210130022124.65083-1-mgross@linux.intel.com>
 <20210130022124.65083-62-mgross@linux.intel.com>
 <1612027420.847882.1419429.nullmailer@robh.at.kernel.org>
In-Reply-To: <1612027420.847882.1419429.nullmailer@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [122.172.179.224]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af562de2-a38b-4746-e3d4-08d8c75736ad
x-ms-traffictypediagnostic: MN2PR11MB4415:
x-microsoft-antispam-prvs: <MN2PR11MB4415140682A04F63F789D505E2B59@MN2PR11MB4415.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eeL4HRoc8D5e73lSX6YL1CooR3DRTE/HD5eiPORIk4j6+XLuqwJblJ+SkMvbPbkH9X42nmaPbzTj7uMeFzfnFb8fFWkypMuWky78W4CyxpnaZWXnOfUJ/0oOst/YoPLTXPNj0AD0fhK0xOP62zxr9aiHWlgHXwirHtpTxTmfRIE+Xf/uWXseDMxqPoO3vPSfvdrVHWKaJVeuk0TFVDbRm6NxLdKbsiDqSbhBcYqomlKy1miDuqB+aq0GZq+4G4+wfZW5cbbTrSirbw49SBT/cCrum+KLHoGwJF96ia/56CyF1Ndf26AE5Hvb+qnZYfPxeyu1VWxUs92lqzZbIebU5d1W0RJDIeoOJ6yh3/UtAgBTa4GEeqZoZeiwSuz0GVeHuAdYIFbxoGU3up2uoHkh9OY/1ULSVdrFgLff5jI8W4GCSp/t89AsdVOtNoHnRU5fi4iFibpq8eDUNLSZQWLeAfLZl096fzgxsM7Y1mEzmUVxGj83qsGPIYEq1ee41wb/RfijakKsjkbmo//rtktOwZ/ZjNO30VYTOwGg+Vwsqz2jWV0HE5bllnE2K8ACsr+kcR8wbV7V8kWU/XeDiWIzzcuNmqpFWboZyK6PQFIsdMs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3234.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(71200400001)(55016002)(83380400001)(33656002)(110136005)(186003)(66476007)(66556008)(8936002)(64756008)(54906003)(66446008)(2906002)(7696005)(8676002)(86362001)(478600001)(66946007)(4326008)(76116006)(7416002)(5660300002)(26005)(9686003)(6506007)(55236004)(52536014)(316002)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?K0Uyqgqv10vcJXsfXYLiQjcqQaP3yDyzYSfv/16KRxMSVyq/QPKXkdo3rdI/?=
 =?us-ascii?Q?Z1pbMCD2umFUroPv7v35GU2BNscO/x78JAY7F5bgCY0ccvzW0Hec3YRMScBl?=
 =?us-ascii?Q?NWPBYOSXHAaLLZetarRjpUbPEwBhC/2WsGp6KUyo4hnP5LWNG2x5ZmtoxGMt?=
 =?us-ascii?Q?+I1upWcWBawAM0ccdf+cJpK/wmbszjD87644GYuWMSAt5Q/4kaedtOmDvZA5?=
 =?us-ascii?Q?E2SSoT2ijboU3gGm6y9PwgySBorsV5PhC0bwWi3z3bFMxLvCCX5n1vRRnyUM?=
 =?us-ascii?Q?jB/aibOefJGHqtSfJjHiZUXy089FND6A0bHyPcFhwZg0+54dB0tgPkCHPmzW?=
 =?us-ascii?Q?jLLHXtJDblBnBFiKpmeAfmls6BQmNWZ+Ydp6A3J9mSTVP6YlS3FxgT8lC9SZ?=
 =?us-ascii?Q?QvFDuFMlyxJXbwIJvWOfpHtKvEcGvR9gu02RaROZFGQDtU9W7lUNvO5gDgSy?=
 =?us-ascii?Q?7Tta1+ZXwlCtx5TAb00XYYd3jo6yjg8enaYvXxmDYuTEzKUCFWd7zcm74kCE?=
 =?us-ascii?Q?zWpsuhy9Dkz/Wi/gKhL+H27J7fFT272l5fVpsFmMBWdqZK4NPGZIo5ddV6PC?=
 =?us-ascii?Q?O5PSCqvjlXDxh4dX1Wb7Ok308Cb17mk1ADtP6CM39ZJFazT6jQ449dqgLiLn?=
 =?us-ascii?Q?RoAImRk39I9Y8GTr9THMKkMuTDG9+t35MxXbNViWvG2T7jXtKH456DnHu/Iq?=
 =?us-ascii?Q?9Vkj2HTAGa8BMxGcrSOVXMUkliEHKsTUO2dmkQlFf/8zaPP20isDxk9KK2KQ?=
 =?us-ascii?Q?jRh1RWRKWHFLq8n8QeBAHWxkDAtzLkhDt8huqooHejHnLp0YtH9X5lYusSK3?=
 =?us-ascii?Q?LFhT7iGUQl25IlvZX5WdkbgD7KcrouQvP0QRa6hyficJOch+qPcvqsbD2/9P?=
 =?us-ascii?Q?KM137qJy0abVd0kxV9GLzOWQtL0Ox3TVOf28kzWXMpXcAQgeiFiVvDRIcAFA?=
 =?us-ascii?Q?F/2Il8I2UJZSCw6Suj9wninnO7a+I/vX23lqTWx0s93uuo4duNJOwFZHEWd0?=
 =?us-ascii?Q?oldVqIfWz10FMVIDGgjTl8Wvau4r4995eLH4c23PMEAglvLyAfHiR7OANdYM?=
 =?us-ascii?Q?l/eABYl6?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3234.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af562de2-a38b-4746-e3d4-08d8c75736ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 08:47:46.5713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JEDU9ji9UOb7j+ChM5QASF8ULNUff/QyxhljHx+SDtAQmdAgF2kWcEtkHld3RsBkoyGFJCAX9ykLIbzzcfaEFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4415
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 29 Jan 2021 18:21:16 -0800, mgross@linux.intel.com wrote:
> > From: "C, Udhayakumar" <udhayakumar.c@intel.com>
> >
> > Add device tree bindings for local host thermal sensors Intel Edge.AI
> > Computer Vision platforms.
> >
> > The tsens module enables reading of on chip sensors present in the
> > Intel Bay series SoC. In the tsens module various junction temperature
> > and SoC temperature are reported using thermal subsystem and i2c
> > subsystem.
> >
> > Temperature data reported using thermal subsystem will be used for
> > various cooling agents such as DVFS, fan control and shutdown the
> > system in case of critical temperature.
> >
> > Temperature data reported using i2c subsytem will be used by platform
> > manageability software running in remote host.
> >
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: devicetree@vger.kernel.org
> > Acked-by: mark gross <mgross@linux.intel.com>
> > Signed-off-by: C Udhayakumar <udhayakumar.c@intel.com>
> > Signed-off-by: Mark Gross <mgross@linux.intel.com>
> > ---
> >  .../bindings/misc/intel,intel-tsens.yaml      | 118 ++++++++++++++++++
> >  1 file changed, 118 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/misc/intel,intel-tsens.yaml
> >
>=20
> My bot found errors running 'make dt_binding_check' on your patch:
>=20
> yamllint warnings/errors:
>=20
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-
> review/Documentation/devicetree/bindings/misc/intel,intel-
> tsens.example.dt.yaml: example-0: tsens@20260000:reg:0: [0, 539361280, 0,
> 256] is too long
> 	From schema: /usr/local/lib/python3.8/dist-
> packages/dtschema/schemas/reg.yaml
>=20
> See https://patchwork.ozlabs.org/patch/1433609
>=20
This lint warning is due to missing address-cells and size-cells fields.

make dt_binding_check dtbs_check DT_SCHEMA_FILES=3DDocumentation/devicetree=
/bindings/misc/intel,intel-tsens.yaml=20
  CHKDT   Documentation/devicetree/bindings/misc/intel,intel-tsens.yaml
  DTC     Documentation/devicetree/bindings/misc/intel,intel-tsens.example.=
dt.yaml
  CHECK   Documentation/devicetree/bindings/misc/intel,intel-tsens.example.=
dt.yaml

Will update the fix in next patch version.
---
Thanks,
Udhay

> This check can fail if there are any dependencies. The base for a patch s=
eries
> is generally the most recent rc1.
>=20
> If you already ran 'make dt_binding_check' and didn't see the above error=
(s),
> then make sure 'yamllint' is installed and dt-schema is up to
> date:
>=20
> pip3 install dtschema --upgrade
>=20
> Please check and re-submit.

