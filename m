Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 060AE4479DA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 06:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236026AbhKHFO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 00:14:58 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:21694 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235206AbhKHFOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 00:14:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1636348331; x=1667884331;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3iw0Zz5z4OjWBAcE9EaKn7B7UOUbGMiLpb4Qqiy9ntY=;
  b=gpU3stzSdF/56pG+KFFQ9iZVDiN+PB2jeFI8NQ5KR1VPhRzkFcs8M8Zw
   5gT0zf/nfCUD7NOl6pV9X0g9qlzPAZvnnnnwIE8gB8EGaBQIK/I7euyTE
   FI+NqyyLWcjC2Hal3eVnOjEKIfofrWN65HT0BQ4z7DP+ZMVFLYl/vNXN1
   Ca8s1DyycBSKfWA3JbLdbwv8U64uLGe5EvGZpXlr+g4G0+bWdEEFG2Wax
   6pYpGI54SgQYz4/Svzsa71bVl5sJpZQIlTRtCGYg1CpziZlmwYqHluwLF
   rB75xQw/tlEChV/20t8FdYKrms2Vngc+kHDD7VB9eZaGMAyjZL6T3Tsc/
   A==;
IronPort-SDR: ud0pVLAt/XI6GvtsPjOO9Fc1nVy6rx/VK+l4ZZJxj94Ca7EthQJfgsgShmax3S7jwxM2zTdmQt
 iAR6iqevtOIvBmimLqKrrC5aLw6QvMqUDKYked2r6QK6u2FFSTHiOSVspfK1iobFoe1P7xW7ca
 m1yPVvrDLtZG/kGf1HiGDNPpJKiBTIiL4LQ1FMar1/l2oWx1T5SDjkMb4+lJM2X8ayi5A08tNY
 lrAbvtKOIi97FjG1Ahhu3TSke7BtKXu8VJArVzM2C8ScnpUh1FB8wxv8dpphA+qHJBCsZ0o84L
 5fKFFA4IyLYzVsmK9ZePgZTy
X-IronPort-AV: E=Sophos;i="5.87,217,1631602800"; 
   d="scan'208";a="143100325"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Nov 2021 22:12:05 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sun, 7 Nov 2021 22:12:05 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14 via Frontend
 Transport; Sun, 7 Nov 2021 22:12:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZOwNREpPSzKG6cV1xT+bA7Lju0Ejzg/U4L0dbEqZqqDfD4VozPlVm2CgbcyjA+FaHWOwWp3Rcr/WOxPG1oxljv2gHES5R4ZFWaJP2VCEVcsDThOgNP3zXyEMwn7PTIhpWvJJQjF0gpbwSC1JvgD09rE6w8bNJXatz69NVY+H341SA+n+pDnrheiZlC0wwzE0y5mOyO9DBuY6oE3Y2TlgqP9E8KX2+Swx8vjIfxnPIIznn7liEVDE/qFloN3vbyyYimbMeSNYqAzHljqnywyK0I0xgDJNuGfL5wdFpvROR+tu6aCJp65ftHYFtoxvkTTEAxGtcqbaSvNiGGcbV0DUIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4L745m2OmehPvNeFQOnxrTIUDs95cM5LAC2jRurc7Ms=;
 b=FDCWe3j1Np9g5drcNou4yS44nukRioCiXIyU0I4XFQKTUo2RptnEw+H9tw9Fjz3WDIh1dJi0/ZTf3o9OVcVkIKYt41xat4Fm7vnocDr4PPuPN1VQYG0MGEfrXiBcXGiX40Pk6rgHYG6z9Z5VHmFrbZ3vM/vd1wuQrDPBbvrriOrkuoFH1kq93rRmk5cStEpo/uPhHPNAaaqygFOyrXsa7FrC+uTGhd9uajd/gVz06e2IbVyxj88Cve2AawBJyuyySZIUNryOTawN1SlHS8Ve6GDFJPmVeNZXUdsquPR3QO7yDN1Ta1PFxWXSGCC+DJYh0EjNB+Iv0tgTijAh8343sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4L745m2OmehPvNeFQOnxrTIUDs95cM5LAC2jRurc7Ms=;
 b=Fyr4C6/aCr50pw5lqdFpja3EKAmNzcd3PBR7F5dxQNyQ6Xee85vkrh36wEhT7S4Ait+9rH5L6xjnQJbZ5XOUaIeda+dQFy9dKj960YJEcd2RCjkjq1/foAeYJL/HUoIRx2SkxElagdpb26sJducOACw7ZT10aZj4RjmQi3Ux4Xg=
Received: from CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9)
 by MWHPR11MB1997.namprd11.prod.outlook.com (2603:10b6:300:2a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Mon, 8 Nov
 2021 05:12:01 +0000
Received: from CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::fc7a:748b:9fd:b66b]) by CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::fc7a:748b:9fd:b66b%4]) with mapi id 15.20.4669.016; Mon, 8 Nov 2021
 05:12:01 +0000
From:   <Kavyasree.Kotagiri@microchip.com>
To:     <sboyd@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <Nicolas.Ferre@microchip.com>, <Eugen.Hristev@microchip.com>,
        <Manohar.Puri@microchip.com>, <robh+dt@kernel.org>,
        <mturquette@baylibre.com>, <Kavyasree.Kotagiri@microchip.com>
Subject: RE: [PATCH v10 0/3] Add driver for lan966x Generic Clock Controller
Thread-Topic: [PATCH v10 0/3] Add driver for lan966x Generic Clock Controller
Thread-Index: AQHX0HrODaqCiC7TlE2x8wXpDPfd1av5G8/g
Date:   Mon, 8 Nov 2021 05:12:01 +0000
Message-ID: <CO1PR11MB486571940F4F7037A08EDA9A92919@CO1PR11MB4865.namprd11.prod.outlook.com>
References: <20211103061935.25677-1-kavyasree.kotagiri@microchip.com>
In-Reply-To: <20211103061935.25677-1-kavyasree.kotagiri@microchip.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 895a1a47-44ad-4015-08f1-08d9a2764c44
x-ms-traffictypediagnostic: MWHPR11MB1997:
x-microsoft-antispam-prvs: <MWHPR11MB1997E5E331C98E26D46B10FA92919@MWHPR11MB1997.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lfmP6qBL/58YHa+8B/7lwBWeExpxJapGWMreEbQkSYu1cVjleZIzYKJ4TfnQSe+J5IvtSxT3X78dVHXQTK3fEPouBUhlKxfuXU1/8oSwHrEXacBKR8PHcmF84abup8eYFdlBRWbqFSjm3S9Rk0LzMZ6et+cO1p0rrRGI+I4qZHjVVlFCbR3dvnYrhc1annDSvr8OlE/k0yU6rXJo6oDywr1wTWGGFzG/tHlxeBY1wJFJyXaSh8PduM+yY23nYtl5Ok3Nxs1o01B3G8P7pfOsyIQ+q5Io7KLFmr4pbyC33RS+IjXMcHlOBZExUVnd58gGjU+y8e8PXgOVtZpjpORV/mF2coi7xmo0h+qWUBLBpxCaT3WeOaj3vKNXYkJolnt1feg0lSk88guLxHQmriRDrn60Eo8EguzYUuLzHphOjIVQr43MGKVNdu8214tSdd3DxVBYuYeDXU3h0d9cvOYOuCTAS2LZFSB64fPnS+RGv3VxHCSLAeqT39+ojXMIJQw9p4U3d1aoQiR4BIIT4UDldr/Y9lnTt0p6iPqHgROvYqSOCcFEg/F3tW1pjbGqx8yQ3in4+HjV3tL36XQz+skDV9MNXcPB0YZ8pt0N5zpI5jYZuceJm7HpMyE9tGYtwKMLhGdBWj75P0uwN/vUYw8koLbwnPA5QicNw8wmJijgfvIbpKJ2/7ibtrkjbEv3KTNgXitaogXdQxaDRMSGU/Un1ujl9mF3+bIt0fCIRbYYqLo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(7696005)(86362001)(122000001)(83380400001)(107886003)(8676002)(54906003)(5660300002)(2906002)(26005)(8936002)(33656002)(55016002)(71200400001)(4326008)(6506007)(508600001)(9686003)(186003)(64756008)(66446008)(66946007)(6916009)(66556008)(66476007)(52536014)(38070700005)(38100700002)(76116006)(53546011)(41533002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?U02TS3ZpFjcGxa/qDwLDsTn/fNXwKZgWg7O2U1J6bTTtroytmQCrKQAT4CmJ?=
 =?us-ascii?Q?CT20D+anTCZThVAQpXUDftj5IVCPkdMyFHv8Zc2R+684Mlhvu6dcPr8SSteV?=
 =?us-ascii?Q?y31fT6MLxIKlJcj2nGkr0FsdMLF/yaEhAv4KGnSH9/hipJo2PpNOtJqx52cx?=
 =?us-ascii?Q?UPP1OAzJquDwmgGDd4W2HckNwj+han/OpEKm5ysAhdkvpUWa1gCArYWUg3gM?=
 =?us-ascii?Q?jAvx8sAyFCo58eQe4mGr1QZGqnRlZyiR2CTyAZA46upOZE+k/wYBLyWTP1Z3?=
 =?us-ascii?Q?5Bf5iJ7aJ9YgIHrG0CHKuWqBvHfHAGbLeSTPZMPfLFGFB16G+cTnSCchV/m5?=
 =?us-ascii?Q?K9KsJqk1j95pZdO60zXf8vTzzk4OjashxZTqaBkEiXFKSt7M5loMHxaMyBDC?=
 =?us-ascii?Q?GocOmOr13ORp1loNQ39bCAOiEK8En5JFsdD5Ddoe0B7+fTJ9FHbo9G4O4Jhd?=
 =?us-ascii?Q?ixG7jrtTbg7fcGqcrd/HsLxGWsr/aG6txhvoJEGxe22Yun10XjGcu8x+jMyD?=
 =?us-ascii?Q?oYfmyT45W4TSXhQb3x1oQANYCkE+zSPTlLTjyq2KQVy5q4ZQ5+V7zVp+eS3O?=
 =?us-ascii?Q?BvXlr3iC6c2bPByCOPxEvmXYyQFPynN51A91aWgsO7yU4Yf3+HStFJGOQama?=
 =?us-ascii?Q?/z1ZjYamIyh/DIciPrJ6QZz3nxJeFsXUKCoahqeXAUZIiGTZyD4G12GA0u0+?=
 =?us-ascii?Q?bJW8cblSeANeJQ9+mCdciacW20bA5voZCjmv9E1ZE3c4kudf3UUPOgXxhQ2V?=
 =?us-ascii?Q?xFMbuf1U2ac18GxHOEbMHkvg0pNIDBzE7HxTct/p1k5E9I1dx52pakQLvtnd?=
 =?us-ascii?Q?7kPWb6jkt/eIL7pP84qjYBs0uR1fvx5Yr0763u7Xeb2rbDZHnDY35kb2yTPD?=
 =?us-ascii?Q?01wjYO96ohY4G+lNNzd0td9mPmlI+o0EoZMAKeeE5WzRxW3L2CCZpurgTlcr?=
 =?us-ascii?Q?TWSNyyuRN2bPZGa4BgusCMY8nLm+joASACg6v16lquYDgY7m77Fa2cHIbiu1?=
 =?us-ascii?Q?hCh9EST2VyoXLjz/7TQs1egHszJ2BTyv60QxXrKERTHmdEwOit+ocLltkpgY?=
 =?us-ascii?Q?AKTPEFSEwrEQ3ZMIxMV7dV+1IxWxCEOBVyuE6iIIf3Pma5u1ZCVyZz0kLtBO?=
 =?us-ascii?Q?5ZEg2sotVYi634uyFO9u6HWql50Rk9MgdslK4IloiGnArQpvvpc/QlmqgrL5?=
 =?us-ascii?Q?RSRDBPybk/4D8f0o2E/A3JsECSTsb4m694OFMoVBMBg1Z0zAi22ZENKOmGXm?=
 =?us-ascii?Q?SbuRwsEnLX3I+UV49Leq6vdrfEA+dEjh5UFWCdHeBzFGzo6bBgz9QLbY+kLT?=
 =?us-ascii?Q?Fw9VmPlvcEsoqhFxXTRqsKrbeR07ZTQPMt6EuIufwsrRQPum6WPfXOOc0Wbz?=
 =?us-ascii?Q?OW77JtJehzM+HLCQ9Klq+grU2+sa+n3RJqKftAEq0u3emAyeIoIBvbtnN10D?=
 =?us-ascii?Q?sPDEv2HrCWV1SxCbyqiCoY5bidP82hQvLXHs8mG2SNgBR9oltp5BeJMOX/sD?=
 =?us-ascii?Q?I5iPdQTg65sBJ3QQH7Skovbs4wF4Bu9I3tG40JqK9I+p4zbyBV4bvU/MMmbf?=
 =?us-ascii?Q?iXk4IXTyOOMUhKP4zPOBT7Sk6VFZsYhr24HlgDN5Y4sNzEp5/2rMM3qIXJeT?=
 =?us-ascii?Q?lww6h3jZc7512DrsydsByQMTGKxLxA7U+XVe7io1Y77woGY6m/JGRZoDOkx6?=
 =?us-ascii?Q?ORcw65mer+H+zNCR/BTbTuhAQMhUAP86mWmvK9ZhLoN5/Z1G?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 895a1a47-44ad-4015-08f1-08d9a2764c44
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2021 05:12:01.7032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TrU8XLZ0ku4RYHpkX/wCu1ynP1wyrrz69f6CfmCdAubwe5xWwzfeb2cDDzN2Bu3pprQ0K7fsoA9b1O9r5IsFakyvzmxqJ+Q6TNlzh0x06WVXY+ckwm618sSDAjNzQ7bM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1997
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Addressed your comments in v10 patch series.=20
Please let me know when you include my patches into PR.

Thanks,
Kavya
> -----Original Message-----
> From: Kavyasree Kotagiri [mailto:kavyasree.kotagiri@microchip.com]
> Sent: Wednesday, November 3, 2021 11:50 AM
> To: robh+dt@kernel.org; mturquette@baylibre.com; sboyd@kernel.org
> Cc: linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-
> clk@vger.kernel.org; UNGLinuxDriver <UNGLinuxDriver@microchip.com>;
> Nicolas Ferre - M43238 <Nicolas.Ferre@microchip.com>; Eugen Hristev -
> M18282 <Eugen.Hristev@microchip.com>; Kavyasree Kotagiri - I30978
> <Kavyasree.Kotagiri@microchip.com>; Manohar Puri - I30488
> <Manohar.Puri@microchip.com>
> Subject: [PATCH v10 0/3] Add driver for lan966x Generic Clock Controller
>=20
> This patch series adds a device driver for Generic Clock Controller
> of lan966x SoC.
>=20
> v9 -> v10:
> - Removed .name from lan966x_gck_pdata struct.
> - Removed "_clk" in fw_names like used in bindings
>=20
> v8 -> v9:
> - Added Acked-by to dt-bindings and Documentation file.
> - Changed clk_name "timer" to "timer1"
> - Updated devm_kzalloc in probe function.
>=20
> v7 -> v8:
> - Defined new constant DIV_MAX.
> - Corrected and updated prescaler divider condition check.
> - Added Acked-by.
>=20
> v6 -> v7:
> - Added Kconfig and Makefile entires for lan966x clock driver.
>=20
> v5 -> v6:
> - Added Acked-by to dt-bindings file.
> - Removed "_clk" in clock-names.
> - Added Reviewed-by to Documentation file.
>=20
> v4 -> v5:
> - In v4 dt-bindings, missed adding "clock-names" in required
>   properties and example. So, added them.
> - Returning proper error - PTR_ERR.
> - Removed unused variable "ret" in probe function.
>=20
> v3 -> v4:
> - Updated "clocks" and added "clock-names" in dt-bindings.
> - Used clk_parent_data instead of of_clk_get_parent_name().
>=20
> v2 -> v3:
> - Fixed dt_binding_check errors.
>=20
> v1 -> v2:
> - Updated license in dt-bindings.
> - Updated example provided for clock controller node.
>=20
> Kavyasree Kotagiri (3):
>   dt-bindings: clock: lan966x: Add binding includes for lan966x SoC
>     clock IDs
>   dt-bindings: clock: lan966x: Add LAN966X Clock Controller
>   clk: lan966x: Add lan966x SoC clock driver
>=20
>  .../bindings/clock/microchip,lan966x-gck.yaml |  57 +++++
>  drivers/clk/Kconfig                           |   7 +
>  drivers/clk/Makefile                          |   1 +
>  drivers/clk/clk-lan966x.c                     | 240 ++++++++++++++++++
>  include/dt-bindings/clock/microchip,lan966x.h |  28 ++
>  5 files changed, 333 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml
>  create mode 100644 drivers/clk/clk-lan966x.c
>  create mode 100644 include/dt-bindings/clock/microchip,lan966x.h
>=20
> --
> 2.17.1

