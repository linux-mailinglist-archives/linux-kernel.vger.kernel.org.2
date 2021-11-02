Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4090442E6A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 13:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbhKBMuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 08:50:14 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:45173 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhKBMuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 08:50:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1635857258; x=1667393258;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DZUcZcHqALQ4+UhMh7jslj10ipoGPWk6sk+ihB2fR6A=;
  b=GaFO55Tq+csEIlRjUv8CLtgS2JKfdLiJQaZVgq9LyRSx3398l1Gkx4nO
   gjVZZtmnfkmRAS710dENwESgT2b/OlTDXeoM2yRfQ+CoWpWY/EBZl5K43
   PB890vH8twRYtgB67Kd9hIBa4nvRTTjO1YXn1QPnN0P3O4esyl+Jni9C6
   2685o1EMUs5s0K0hlDldhhzfTfNRH9RA4FaVyV2Su5WBveWBoUGp9N+ru
   11/cY3WBIhL0w4/CSFqaj8JSrv1QtYB2gCvHLnQ0ALNDeQjdklYXz9msJ
   fB1oFsdiNqIgcPxpZrCIK0Gc2iBIYGcylIxpSFQKZWJzfe75Kb/2MI60p
   w==;
IronPort-SDR: F2SlwY9SzhVyphytmZx0V9EcCqOgQVvze6SeDih5GcwoBkG0cfIcd+MfzTYghUcJ0goF001MAr
 MJIVGgF9QBcAxp8Fq2uqh91/gN7CN2dUrH37kG4jLjWMomdtOd+xQZl0nBR813FCe6lZf/Ya+Y
 0vCUz9dGsAwYVucJ67yrLNUsKocsOHsbGNM6kXeFKqm3p4mAQE1rIACzTcEYLvgaedAjNF8uTG
 o2bfOdzKoDVCBhz89ieUM8CUBaSb/XH9hS4PO/FYT9q7WsnIYiIYrJwkr1CDqWvHyzktkE1c4Q
 Ddro8k8rHDPLNWESKOWQ3nDn
X-IronPort-AV: E=Sophos;i="5.87,202,1631602800"; 
   d="scan'208";a="150413429"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Nov 2021 05:47:37 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 2 Nov 2021 05:47:37 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14 via Frontend
 Transport; Tue, 2 Nov 2021 05:47:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S7Kr9HDbDAqSGZ8hf/spzHSAmDJYVmLjdODbRKBKy17KRE5eg5CdBOhI2gI6rcvWB8cLknlJRFIbTuEWQxT5L5jBaYE7qcy1+fkGQ0m8OVaXsbX7KKan+5zsJ5pK/oaYFLuHRyskFqdmySub1UGeFUD3pvW+Fhk7a0Eo+q+5dUXTV59C9A/W/xARZoumHhaNBreyNCoYwIq29611Hkb490wcRaoHJQIeNdt8IrMh+mZyxCYByrTniOEcRQcQokoNjpT7jcvqBdSen17HOpb4pa/BuYRFJNngKbLttBfbrJaXNgZOg41/nQ2C5PytqQEZlT8yPVZW0KzEvIwh36QIjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDFk5b/0qJRD0pK6a/pnuvhZotB6PiGes0hjWMH7fr0=;
 b=KTMaxWFLLZPLpq7AclH2KzlcmFw+LqDc5EMprQYOJijCq4HSnLLKo5ePIwcgP/9x0Mq4A/+1ZyOnheEBoqSRjmHM/tx231xO0WdixjLRzn97y2DzEQuhKoiOMVCWnjbYY6LOjlJ9DdKzqfTTSHn8Fp+LGg2z3H/ZNxvasG2zQ6fmZcCmXSXRwjppyGQUI8k707L+8guZCcIk8k3StPFLmkG8VyjFhb9oaxQXgwMUTjvQL66vjfYAkfKA0ivlvdYdK+w4MkAoHzAnsJczxWGdJI7vFD1BtWndtbf7FalP1XJVg7NRz9kKImQ8xojqvxjxyTROqp4grCiAfhQVWjYKHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDFk5b/0qJRD0pK6a/pnuvhZotB6PiGes0hjWMH7fr0=;
 b=IumRkwp5OrVRPJrTYeeTU09MgRsJ138BlhAkJ+9YMajPXxtVPqNzP4jVmeeZQJs1mmI9SzyzEn4oovHoYdD768Nu8zBuhXP77I5bTJ/+dkm00p1mteui+FYmw3qBJsrP6YsREVTpVPH0tbanUpkoS27RgArmLxQv5eFfHcZMReA=
Received: from CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9)
 by CO1PR11MB5010.namprd11.prod.outlook.com (2603:10b6:303:93::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13; Tue, 2 Nov
 2021 12:47:27 +0000
Received: from CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::fc7a:748b:9fd:b66b]) by CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::fc7a:748b:9fd:b66b%5]) with mapi id 15.20.4649.020; Tue, 2 Nov 2021
 12:47:27 +0000
From:   <Kavyasree.Kotagiri@microchip.com>
To:     <sboyd@kernel.org>, <robh+dt@kernel.org>, <mturquette@baylibre.com>
CC:     <Nicolas.Ferre@microchip.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>, <Eugen.Hristev@microchip.com>,
        <Manohar.Puri@microchip.com>
Subject: [PATCH v9 0/3] Add driver for lan966x Generic Clock Controller
Thread-Topic: [PATCH v9 0/3] Add driver for lan966x Generic Clock Controller
Thread-Index: AQHXxLyyXrq0ORj5M02kh5PHyHuV8avwRQwQ
Date:   Tue, 2 Nov 2021 12:47:27 +0000
Message-ID: <CO1PR11MB4865DDA9CB07F699288CC762928B9@CO1PR11MB4865.namprd11.prod.outlook.com>
References: <20211019074030.31294-1-kavyasree.kotagiri@microchip.com>
In-Reply-To: <20211019074030.31294-1-kavyasree.kotagiri@microchip.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 83681562-e168-4a7d-d3da-08d99dfeed06
x-ms-traffictypediagnostic: CO1PR11MB5010:
x-microsoft-antispam-prvs: <CO1PR11MB501032837E41B5CF48D93936928B9@CO1PR11MB5010.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hqp0R3XTvklJwFxBfA4jaInr7c+tUI20IwwY2LoPHy0/CoLd22IaMsDD7YJW7DjFViMOt3g3ZkXM/jEDKJ9Bq/zfc9q2GPSsF9YuXXa8pCkKAV3JFTzBQqLbwuJN6oB1MYoDRd7KRkbSs/wLbyrM/zPvtMcfyzpcpDXLF4zTWBxYoOS1HShXmPUAQ5nawMz1Svu3Rh4eGo3iLPp4tSoBWwseTgHlcnJm+rONUo/SPJgJ9PUvksN4ZGdwRdtOBW+D1DhX69243jwTOV70kb7i0TXgwFuscj6C6Tng5Nvw4LSPLLwZAENhIzBfKaaFud9B6m4jcbNf+upfVD9wkajwam0sRokF3V2TBNOKu6VArNjfEL5a7M0N0mukyU9+pzRJXM2U6713x25KvQeQENpXQ2WZ9QYcEW5UEaYYxXdC6v/c2kxTDrgCEF/GudpuoDsTA6T6xnKe73D9P2GeCD3ssSR6QbcptL4MI/e1QTF5MacBAdmdvIQHWs7vTyLEbhmFWGwIiT/FMh+kChqpP+bMeFYWuL/NqRYfUBqgmgITwm7TtIqtltlIa/aUQPZ6XvXxNphmS2ReavuENIH/+Cd0wOSmNMOb9BQCCmGcWxCMkD5CkqHsxYuiFfkCmVbiEStDXZPuQ641tGEwL8WsZLgHz6G9P6eB4YxJY5dUnqejmOh2aWOrsr+fxJAX7j9S7K/MF+diGG+ec6JiS8EWNto0ok/Iqy0B83QT9yU/tOsm1Fo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(8936002)(110136005)(83380400001)(8676002)(33656002)(4326008)(38100700002)(122000001)(316002)(508600001)(55016002)(107886003)(86362001)(38070700005)(9686003)(71200400001)(53546011)(186003)(7696005)(66556008)(66476007)(64756008)(6506007)(66946007)(52536014)(26005)(66446008)(76116006)(2906002)(54906003)(41533002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pPI2N0D8LfcXk2Kx68xaotFJpmeJW8iLhMHeAAsY1uaeyf+2KBc1Qdap5o0N?=
 =?us-ascii?Q?aq7mruDOwkbaDoYyariJfR9ne1Dv4bxVSiZF29SOk9NbYSvYWp9+deWeRcRX?=
 =?us-ascii?Q?od8GOo3qrxsOm/fR5d6RoMBhjj8Sz+UDhT2jXJJxOTHTNLaHPFKfrMdlakxU?=
 =?us-ascii?Q?xQaIM+rSjW5H/r3mPatQX55Ox9Z/PAH0sNhEq6TPVLS+5EyHfTvPWKSFpZv0?=
 =?us-ascii?Q?3sxhJ7CfORSUuB2p/yhEuqp8/yLnZYOlO8ky10yPREttObaAuNHKz5j4Erkq?=
 =?us-ascii?Q?jRKaBnuJOcRNn51+zTdCCBvhHKAmOoq1wzYuCuVgOaKos0YBcJ/f1Wuxv6Xp?=
 =?us-ascii?Q?3hGGRzk3DMJzhrEd66vubOnW4Ta4qUWN0T8sMnSTHyqdzEXY2/ldcxIcPMoZ?=
 =?us-ascii?Q?ds5u7KgGUp0jSFTmxI1AYTgVlu4/URmoqnHUZwe5NTG4FWLHKFWFogbS7+aM?=
 =?us-ascii?Q?fUlMCm0PWzA92HDnGnc/ICX2KZLVJ3brELr9bhrRqHwDnw0WbPH3VmTJMtwi?=
 =?us-ascii?Q?zc79HHOjyWNn63vTkxkeEkc0IUD4iLKfw9Na1VoAWpfIEMG08kQ7W0Gyvabd?=
 =?us-ascii?Q?+rk6p9PCIn3Sc+3JCQau29jqOUFDyDVqrTOVeHdgLphN2wSAIqHJ8zKiBSvb?=
 =?us-ascii?Q?HVtG5DRzu/wS+phfpG7MFEnxfU7OLWqgsDp4r+3kBL+GiJHkvV2WTv7K+c5A?=
 =?us-ascii?Q?aYnUD0bt2jMhEUpS4GRQTq3RGaVInf3iDwrf7uIykQk8RZ3EI2H3UJPjAldy?=
 =?us-ascii?Q?SO5tJJLXjh3YKykevE/gPrrPnJI2MK4NHwrGpOfbwWZa82fWBOWJXyN02kEE?=
 =?us-ascii?Q?YH7y0A4vxM478E2CoMvsewtFIDUV39ap1yCp4LpBhvKkiTGaf8X4rRNuaSrI?=
 =?us-ascii?Q?FFQIKadwryJ0pKM7REN83MXsMsw9rUlNjKj7f+VAUDsS6X7FIK2CGwmNxeAT?=
 =?us-ascii?Q?oZkbSZQjr9hMeTTOtP7N62S05p/4slgX/OFMAjy3IKkktTDfNXpSkooN3/hD?=
 =?us-ascii?Q?ZyAKORYMXeLx1hrcCDuiDRQC1whwOFtjDPbTCvy79YCfmwdkbVD7zEekQhDk?=
 =?us-ascii?Q?SQUsyJLjYn3VnCWRS70rCJNptWRQ0Epj4cxnkbHdZUObxuwYlWWxr0Uw+51V?=
 =?us-ascii?Q?h7128zn4uq2P1oZc8FuALqhQBaPveV/kuX1H+2gN18u1G7JE9qnGhyFDaM78?=
 =?us-ascii?Q?Hcf+sliVP12uoq2TepKNtAIT3OuZMU+f0aOk9s7DuAae30ICTBye20EMJs9k?=
 =?us-ascii?Q?Vxqd4MYx/q51AYXlEmPLxRQwSWRxxEKFVWt9q8S/HIlYtKJGDza40EZg/03e?=
 =?us-ascii?Q?j+K3wscd2EMRNvgjylfqBRxtlyHJsvABxUxGLLu2GrOJU60xYkBT6USsw5G7?=
 =?us-ascii?Q?6CGuzmv+H6H0cOaQSJysNbw+5xieb0ut+RhSYSGayq2IVknDaA0aZyvDAEJH?=
 =?us-ascii?Q?2BsKiLJqeOGLZDOlzpvQKOJU/K3KNbLuKO+h0cAqKRhm66gl+1S1OfgmvkGI?=
 =?us-ascii?Q?lqNM+Vt0SqHrGgGPYVRNdt/Oa32pV0ojrycC0IX+04NokRv7qupwd63oQHKc?=
 =?us-ascii?Q?lJHCeW2l+Nn19WWoUPrX2JQS1vUjaZIH5vvEc6SEgRwKH6SnRdDfUZt/pjWW?=
 =?us-ascii?Q?7ZEENmLqGK4tobqCkm9Dtu2stkLGEniCLPdqcZsESb9LWi2y8jgb4b9YojTp?=
 =?us-ascii?Q?TQzoKS8WWbjollE8cj4FsHz+ayt2Nmwvw7RCS+Y5uwSzXH4L?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83681562-e168-4a7d-d3da-08d99dfeed06
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2021 12:47:27.1625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yf3WQHN2ooA2E1VZqr69kSM9YU58718EeR9v7M3F/+PEzOx7vEgO5nA9ZFWRpwZHlZbCeHVws4D0B9KLlAQ6CA3JcXYqNM9ET6JS4GHVveMlHzkeHAzjKhXE36Ja/0Ku
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5010
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Could you please let me know if this patch series will be taken for 5.16?

Thanks,
Kavya
> -----Original Message-----
> From: Kavyasree Kotagiri [mailto:kavyasree.kotagiri@microchip.com]
> Sent: Tuesday, October 19, 2021 1:10 PM
> To: robh+dt@kernel.org; mturquette@baylibre.com; sboyd@kernel.org
> Cc: Nicolas Ferre - M43238 <Nicolas.Ferre@microchip.com>; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-
> clk@vger.kernel.org; UNGLinuxDriver <UNGLinuxDriver@microchip.com>;
> Eugen Hristev - M18282 <Eugen.Hristev@microchip.com>; Kavyasree Kotagiri
> - I30978 <Kavyasree.Kotagiri@microchip.com>; Manohar Puri - I30488
> <Manohar.Puri@microchip.com>
> Subject: [PATCH v9 0/3] Add driver for lan966x Generic Clock Controller
>=20
> This patch series adds a device driver for Generic Clock Controller
> of lan966x SoC.
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

