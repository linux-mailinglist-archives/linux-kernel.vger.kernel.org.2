Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78A3A45E70E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 06:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237023AbhKZFPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 00:15:04 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:36897 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245677AbhKZFNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 00:13:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1637903390; x=1669439390;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=c6/WKTAVFbanUy9hYu5jX8t7Z0OQ12vts/AwtvTajxI=;
  b=cutV7lvjG8OMdDcKdVmKsEe5a+y49m+hwn2Y08HevrhjGUYXvEwRIHMd
   TAUJU2ml927++cGsLLDkL55p9E3U1wlzLXHufw3pUm4/bOLBqNu5+gJoI
   L5tBpzNPf1JitfFqJSUgxbedu08fnAWCaR/BihmlscIpPC8SyZdb2/lRi
   JofVmLYsbx8j5SXu4U3aTo3yluCVG1yeiZBzWDLf9EAYkMCAFzQGzSd5X
   TyF6ah2uIlhKuc2FY2nNC6jBIw2qfBWPOSzwiiaztHvFrUIMavzbRM9GJ
   qAhLrzdsxWkwm8YYLWQP4aHXD/aIpV9y6jmWD98Jnxn5ngtisg8G+JRRz
   g==;
IronPort-SDR: fPJRbeCm4C7GI3dXi6tXrjt79sANP80jl5F7R2lu78HeoFJUK98Z7cuw22k998o+byuFu66Vna
 Hu2WP3EvZ2GzLUekErg/Pd5vdsCCe2SpUE+WamnvdcnadOEBYWpof70w8o1juORRpMUOgRnP6d
 0CKUvTSzkOPM/wL/IQL9z6b0gyoWuxNwRsou+p/ge1qKh0BsvVpLHcLJZqvwTB64deLWHdsoeR
 xxkqd6r5YpRRuPRgZS+8HUMu1fTiRPGX1AKkWpfXhF9nBT8uZdNROoKf+ss71A6I8J3zsF8OzX
 MQlADNo18vlmI6IKsbs+g+m2
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="153300619"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Nov 2021 22:09:49 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 25 Nov 2021 22:09:49 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14 via Frontend Transport; Thu, 25 Nov 2021 22:09:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TirvchWfxSWHYKGVCayc7iw5hdcZYYypU5AaZdpz9Zx14k7E18oIIRbxn+kj6Vk7j+ojF0Y/y3zKceN9z8pE8S0LP+KzWQm/SngEsZ7EYdu4osZIYf6GSqF1ojJ5GLy3lu+9M4GpQALn2xW0/CXrJwYoKDBZ483B3W70MF0rXqHmnXdEhswLPDPGXASbrc4lAqQoPxLp2wshJQa0l5FpBRmafFnZScZ+HGd/k7mRjJ8kuBQWSM00+yeUAbxG9Y5mXThytEVVFljJPbMlTwuzYj95SkxG9G4bt05tQspsfU7HmotdPPtY9RHQ3E7a2j+EtYszbgM2JRnmvxOv0Jzlig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYt2vwg5aQ1AUTqcSPOoDZ7W3i17/6jfeskkPa0dDKw=;
 b=kmMf+W9ChfGgQhnr201U3B1JKvLb6VVf0Qw2U+2bO96VC7pM1k4XRpK8d86VPMrJnlIL1DIpp88neF9lfLn0Sw7KNsFA1qyVY4DGYqvxyGmA5vI8ZO5UWjjane2KhOirEqnkIV6opbzSl4nrm/gZ8olDOuET3F0S+E5HFVRFY8m0+EP31Hsi+WsnScsyvr6kcs8iGJeP0ceAxVxX3QagybQpjrTlgQXBOMmCCcYBqm581wVepOMZ6FhN3vZZ6IaiaufC7GcjCPiHxgOycuxsY8SjdeoCKVJjPudPFxhreaDg5pI3eGgMTtsZwnaet45ocdV85rPNLUhwkZPKq/ljsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYt2vwg5aQ1AUTqcSPOoDZ7W3i17/6jfeskkPa0dDKw=;
 b=sKw7oaLMRBh+TID8pN0DuSwJbBZHIBYPTuBvq4o5wplNT4X0fJoJQc0k/PTjQRY0JaFXCb+7gYT2ONRgqPSSUr1arUjF+I2+0lyMkq3OfPama8Z4gxCaiSC3fM9PbENyldGR5Ki5dcYU7FbPsc/ww+BzwgqUyIdwp7dF51Vkm1w=
Received: from CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9)
 by MW3PR11MB4588.namprd11.prod.outlook.com (2603:10b6:303:54::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Fri, 26 Nov
 2021 05:09:46 +0000
Received: from CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::9c2c:29bd:3533:c0b6]) by CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::9c2c:29bd:3533:c0b6%6]) with mapi id 15.20.4690.027; Fri, 26 Nov 2021
 05:09:46 +0000
From:   <Kavyasree.Kotagiri@microchip.com>
To:     <sboyd@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <Nicolas.Ferre@microchip.com>, <Eugen.Hristev@microchip.com>,
        <Manohar.Puri@microchip.com>, <robh+dt@kernel.org>,
        <mturquette@baylibre.com>
Subject: RE: [PATCH v10 0/3] Add driver for lan966x Generic Clock Controller
Thread-Topic: [PATCH v10 0/3] Add driver for lan966x Generic Clock Controller
Thread-Index: AQHX0HrODaqCiC7TlE2x8wXpDPfd1av5G8/ggBxJ7/A=
Date:   Fri, 26 Nov 2021 05:09:46 +0000
Message-ID: <CO1PR11MB486550115951B586DC078FE892639@CO1PR11MB4865.namprd11.prod.outlook.com>
References: <20211103061935.25677-1-kavyasree.kotagiri@microchip.com>
 <CO1PR11MB486571940F4F7037A08EDA9A92919@CO1PR11MB4865.namprd11.prod.outlook.com>
In-Reply-To: <CO1PR11MB486571940F4F7037A08EDA9A92919@CO1PR11MB4865.namprd11.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 571cc449-3f80-4c59-48ba-08d9b09af6fe
x-ms-traffictypediagnostic: MW3PR11MB4588:
x-microsoft-antispam-prvs: <MW3PR11MB458809C76B2B32137D45228192639@MW3PR11MB4588.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DEOmNp+SpA5Yi2YeC8eceK4VeDu49Rt3DZvc8pRL96TN5sZP5QMTKHUnWGvbgDUoYWYF5G2s2MiBBoXZWq7zb5Oum8Pjfcgi1K1les5cnANqYSvg9MoKBq732b5jdtiNM/GfdLK15BCpXNebFlGeWBMM+rezu19Q2Cy9H6MzWZ3ZjVYP7nAvz9QaPCcm9j+dXCz9tBQHoAvopgi509wZIWaOlefm0KOFJTMjc1a0aecPg6loASSUZH/khYxKz+7Cg6PDA2z3N+WEFz8UU/7S/IConS47U3V5NpR45yN/KYIkhs6n0ngFiXpu7xN9VxLeHcEYX6oukSePqJp91SOMbsAhbGoo/rTdGUxB/ZboqpIXBCqPOHBmTiJxwbgFEWUJ5IHmVnyT6qo57HuYjtTgt9Qf+WVJ7hYOT/bxiSX/06k+3uJSrh3Plt0mF/iDtrZn/uFj46WbR+1+lHeqAVsAbXUfpJ3oF8rgmVs2BCY+da9u7yuiZEU5t1DXXjzFw+4swfeqLkb/G2XhfopqLeTws7xHinnTI1cEXSqP6jkJ1I3hWItdXDh+Sr2pS+8ULoLiLMLG0xDGM+fLkag3pRevSoJoZ1W+pWBahFPIrcIqoALhvtlW28riN4fAMVZuZuh7XG7jTpSc9u+8X68kE+3zgsjfnemAjDb45/goIHbjGlUFnpA71+4J003fT03UYRdsPAZ1DGjb5tfpIsznwYN9n4l7C1hQ7VK5AtLUvd4VTr4yvKM4bdcTGAqrTeCQoMXX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(9686003)(122000001)(76116006)(7696005)(54906003)(66946007)(316002)(6506007)(6916009)(52536014)(5660300002)(38100700002)(64756008)(66446008)(66476007)(66556008)(33656002)(186003)(8936002)(8676002)(53546011)(86362001)(38070700005)(4326008)(508600001)(2906002)(71200400001)(83380400001)(55016003)(26005)(41533002)(491001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HOhESS0dLN81A3LAy5K6zq+KjKY+qN8W3HXKToyL6RFvdzlHEkOLBjB8rEYn?=
 =?us-ascii?Q?vHNyJmrEtER51TRdRfhcVE+6RTunF4myTG+PykuQRfkt2+RkypzgyPlDT4KA?=
 =?us-ascii?Q?JfOO9kDpu1R/HkzrPv7pUDVRnVF7Z2k/UAtcJ0K7AQQgFM8CO1gr4zmIrjnt?=
 =?us-ascii?Q?ERCcA6Lb/7wCOCfK7LCDe0JWuoSkT16sXXjaybxHURU3B4IJ8aBHqLRv8TSH?=
 =?us-ascii?Q?sTrhZWkPOHXQ6Gb6c1SIwnIUc5U6iQIjKqyYTt0Ct5xFfnetuyDIEgPgIUXL?=
 =?us-ascii?Q?jB1hv+aPyNMeKr2l89YbrQutEAgWsY2Nd9ms0BBqGVQFBMgTdb5d9cvyg93s?=
 =?us-ascii?Q?XK0tS9xcPGjLj2VHxBxdgQWokSgVKJB1pKj9CQL71yTDwcVsSjQLynWg7AwE?=
 =?us-ascii?Q?9oQlNr77FdHyjcw/LA1kddAZysUgvPBx7bETZoWbs9CSjW9LDUXlJh+lBXfW?=
 =?us-ascii?Q?kIQja461BsaLtWYSpmCVIaxUK8Xb5/luu5XHuYb2lbO5yMVpX6pgivBjSh1u?=
 =?us-ascii?Q?yeJ/5VKjZxmFKuBRtpi7TXNx8EzJAdfqsALpKOcxHSsR6c9fMK95NaenhimC?=
 =?us-ascii?Q?n7tuIjeWuZD6xDwoCwcbZ4W5wChl9ZHWmJyjK6qy5TRWg6ZzCKDpV6fZQyqV?=
 =?us-ascii?Q?gtEmuloLQD+30UU4oZA9ImrDO7QOLrA2+OcZSB95qLWZHyh/uCeOQys01Gfe?=
 =?us-ascii?Q?gq2SnM4tfE0lMp1qN/4xWmj8lOTBoxFUu21UVteZlj/kTJ2/Q8qmnwYOzgyM?=
 =?us-ascii?Q?NpidA/Lm96GMBKZcmHJRrAHC/KlrzkkiE20YT02ZQSZ5bd8ok3KII61dfmzK?=
 =?us-ascii?Q?QgWqFgl06xEUECKSzUCFKzIC0gkwHul5xE2UJq297dlnhvK9jtkHGEzxr71N?=
 =?us-ascii?Q?i2V2vA8rzKgd7PCFpMpogoeWg7TS7j3cYAG8LJwO1aEI1U3DRNej4rqYfxRG?=
 =?us-ascii?Q?d1bRdYZo/tbWpr2XTKehK2phegVkNOLG1CfEwjxi8h9PzwLmMr6CmDiugi6y?=
 =?us-ascii?Q?mUGM9VD1Y5zUBhd0RpyeZZaqrMcfyQNUaprnteWzpp5sPnMEzk+pJCepui2B?=
 =?us-ascii?Q?Rfhr6nzzPgUJBY5HVFY4bqdO4rh51Mgpf3gJCGK5IXDHyPmM0V4qWy5TZofa?=
 =?us-ascii?Q?WjXNH8JnYsEqdBuUcgrgDcRCRGCf0wt0kD5D85MYbtvDX3GLu6Xksw/L0Rwt?=
 =?us-ascii?Q?frN79+tVEZls7vHiDskd0Al04YFWaFubvOURjLbA5UHwfFWRN9eCB97Zkvnv?=
 =?us-ascii?Q?OeP5GJWpxKPMP7UEHIj5bNMoZzeaRW8V3DPcXlOOphYD79ke4HoV72FmZ1S1?=
 =?us-ascii?Q?eG4sP/Ihbk9N8OdHi4LDYKeiiAqcDJuzB2Ne1qstZQqSOvdlHH2bwASJ6DHK?=
 =?us-ascii?Q?ZayEsOzvb3+fQkEItrRoFPfuCzVU4sH26lA/2d9kUviNt9TptMYUFQ0DHq3/?=
 =?us-ascii?Q?14Fgo2ZEnlSWhtAXrdz5ITIV5hH289rVpBvEB6eO3u99nCfPtE3z3qlCDYkd?=
 =?us-ascii?Q?wcvt55ov8eoGQWQZ9cZJIQAfLWCq++/PKxC+v9Z70NQGSdBnzVPTXNUpyTfm?=
 =?us-ascii?Q?v8vVils3znFPNVXvIodjDMRQVNADSfdQd5vU3vJpahW4uPO6xGpcxwMNRjgP?=
 =?us-ascii?Q?mt0CEgWrz8QbWZEFdb9JYHBS3b6ot/R//qfprn7e/NKpEp20pYJucpCmo6pB?=
 =?us-ascii?Q?1MgrJf+aCD2xMW2i2m2ypJetwPzsk3amPc2UJlDjyHhksOfL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 571cc449-3f80-4c59-48ba-08d9b09af6fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2021 05:09:46.3723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lIySq9mfWHb/EsDjeE3jpeAGtP2dpk9iKmOYFcpIGRwGdoe1dG7ndr5AQlOPjcmf13mOy2qc+vp2pfTy0eXeh0Kce3TFwMM03g83eODijHYtvQnulWSWKrHx73t/s6oF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4588
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Please provide your comments on this. I am waiting for the response on this=
 patch series so that I can submit further lan966x code which have dependen=
cies on this gck driver.

Thanks,
Kavya

> -----Original Message-----
> From: Kavyasree Kotagiri - I30978
> Sent: Monday, November 8, 2021 10:42 AM
> To: sboyd@kernel.org
> Cc: linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-
> clk@vger.kernel.org; UNGLinuxDriver <UNGLinuxDriver@microchip.com>;
> Nicolas Ferre - M43238 <Nicolas.Ferre@microchip.com>; Eugen Hristev -
> M18282 <Eugen.Hristev@microchip.com>; Manohar Puri - I30488
> <Manohar.Puri@microchip.com>; robh+dt@kernel.org;
> mturquette@baylibre.com; Kavyasree Kotagiri - I30978
> <Kavyasree.Kotagiri@microchip.com>
> Subject: RE: [PATCH v10 0/3] Add driver for lan966x Generic Clock Control=
ler
>=20
> Hi Stephen,
>=20
> Addressed your comments in v10 patch series.
> Please let me know when you include my patches into PR.
>=20
> Thanks,
> Kavya
> > -----Original Message-----
> > From: Kavyasree Kotagiri [mailto:kavyasree.kotagiri@microchip.com]
> > Sent: Wednesday, November 3, 2021 11:50 AM
> > To: robh+dt@kernel.org; mturquette@baylibre.com; sboyd@kernel.org
> > Cc: linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-
> > clk@vger.kernel.org; UNGLinuxDriver <UNGLinuxDriver@microchip.com>;
> > Nicolas Ferre - M43238 <Nicolas.Ferre@microchip.com>; Eugen Hristev -
> > M18282 <Eugen.Hristev@microchip.com>; Kavyasree Kotagiri - I30978
> > <Kavyasree.Kotagiri@microchip.com>; Manohar Puri - I30488
> > <Manohar.Puri@microchip.com>
> > Subject: [PATCH v10 0/3] Add driver for lan966x Generic Clock Controlle=
r
> >
> > This patch series adds a device driver for Generic Clock Controller
> > of lan966x SoC.
> >
> > v9 -> v10:
> > - Removed .name from lan966x_gck_pdata struct.
> > - Removed "_clk" in fw_names like used in bindings
> >
> > v8 -> v9:
> > - Added Acked-by to dt-bindings and Documentation file.
> > - Changed clk_name "timer" to "timer1"
> > - Updated devm_kzalloc in probe function.
> >
> > v7 -> v8:
> > - Defined new constant DIV_MAX.
> > - Corrected and updated prescaler divider condition check.
> > - Added Acked-by.
> >
> > v6 -> v7:
> > - Added Kconfig and Makefile entires for lan966x clock driver.
> >
> > v5 -> v6:
> > - Added Acked-by to dt-bindings file.
> > - Removed "_clk" in clock-names.
> > - Added Reviewed-by to Documentation file.
> >
> > v4 -> v5:
> > - In v4 dt-bindings, missed adding "clock-names" in required
> >   properties and example. So, added them.
> > - Returning proper error - PTR_ERR.
> > - Removed unused variable "ret" in probe function.
> >
> > v3 -> v4:
> > - Updated "clocks" and added "clock-names" in dt-bindings.
> > - Used clk_parent_data instead of of_clk_get_parent_name().
> >
> > v2 -> v3:
> > - Fixed dt_binding_check errors.
> >
> > v1 -> v2:
> > - Updated license in dt-bindings.
> > - Updated example provided for clock controller node.
> >
> > Kavyasree Kotagiri (3):
> >   dt-bindings: clock: lan966x: Add binding includes for lan966x SoC
> >     clock IDs
> >   dt-bindings: clock: lan966x: Add LAN966X Clock Controller
> >   clk: lan966x: Add lan966x SoC clock driver
> >
> >  .../bindings/clock/microchip,lan966x-gck.yaml |  57 +++++
> >  drivers/clk/Kconfig                           |   7 +
> >  drivers/clk/Makefile                          |   1 +
> >  drivers/clk/clk-lan966x.c                     | 240 ++++++++++++++++++
> >  include/dt-bindings/clock/microchip,lan966x.h |  28 ++
> >  5 files changed, 333 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml
> >  create mode 100644 drivers/clk/clk-lan966x.c
> >  create mode 100644 include/dt-bindings/clock/microchip,lan966x.h
> >
> > --
> > 2.17.1

