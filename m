Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79352371110
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 06:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbhECE6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 00:58:03 -0400
Received: from mail-dm6nam12on2060.outbound.protection.outlook.com ([40.107.243.60]:8925
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229489AbhECE5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 00:57:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TP5J+xU2wMicXfC3h0I+4+RPkkP3Oy0M9I7UsPQ/trsk2D+kkLlRRh9dyhXHEibGkF50lZL+dWlxEo7x9V82Xha8ZO9HlDO91HjdMxTlvhIV/jv2Z1pm+C+Qx4ahJyq31/08jqBaee+J2HTWzI4wzaU3n6wny4ulAB8S8AHjg0HkdfJzvXXzqrcjVy3UdxHIBLPyedYK7HEd011vI1LIb3uwgNlTVLj5CGz+/NyqgNvYSHLio4lbm+k8EHSDcoRc1+zYKa3dZAu2SkPJNQ961q9Jwp7YGwig0whxu6fEYJSZ0UdmR4yURBQxG2jBkX8Q7mW4eBpjsjCFk4hj6buwVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1vVmL11QL+b29NL1iFjJS9Jp8yuHqKsX75eDjunB2A=;
 b=PRrT3x5aWRLXjRz9KrZdqnoJj90yz5q8pMgKOznmlRDS3sd7Vqa7W3l6X/m5zY5j1V01NCrmpLrKpc5dxVZFdOYzkVeZBc4jLSNr4qYljbUrF6RiJODxn5kW919+JsFQuZjNhdO1yffF1rl3cageAyRg5DyeWG70knfT6avQ/qRIeOSMqUR7TAX+1kwBtOSsb852qqQMyJ6YA05xirvJ5xAOwsqZcaaG3Z2Pb5suYxaxxBLXyt/dlTTiJiNmZ54ZP6pN9yfMTkra7mcKxd72RshT1A486AwsZEGrxjHbJhK7MRaV1fnuFbFriLuUPBfFmpss7uhg8YxK4O11jrogtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1vVmL11QL+b29NL1iFjJS9Jp8yuHqKsX75eDjunB2A=;
 b=powq8NbYIZAH8te6EpXObYgF4MpnMOh4wIGyxOhEj+14B5l0AiXOhzA6J15qrOBMoSOOy0h4RWzRiEYSLLpGhf6vziOJf7gpLOE0JT1FiTwy75wUEGZd7IoKvJXos5Y11ch64tWOFVRZCPJtsAqVKYgudAsqQKDfZJNxtZ+D2KY=
Received: from BYAPR02MB3941.namprd02.prod.outlook.com (2603:10b6:a02:f8::18)
 by SJ0PR02MB7600.namprd02.prod.outlook.com (2603:10b6:a03:320::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.40; Mon, 3 May
 2021 04:56:44 +0000
Received: from BYAPR02MB3941.namprd02.prod.outlook.com
 ([fe80::f9c6:6c2f:3084:89b8]) by BYAPR02MB3941.namprd02.prod.outlook.com
 ([fe80::f9c6:6c2f:3084:89b8%3]) with mapi id 15.20.4065.036; Mon, 3 May 2021
 04:56:44 +0000
From:   Rajan Vaja <RAJANV@xilinx.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "quanyang.wang@windriver.com" <quanyang.wang@windriver.com>,
        Jolly Shah <JOLLYS@xilinx.com>,
        Tejas Patel <tejasp@xlnx.xilinx.com>,
        Shubhrajyoti Datta <shubhraj@xilinx.com>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] clk: zynqmp: pll: Remove some dead code
Thread-Topic: [PATCH] clk: zynqmp: pll: Remove some dead code
Thread-Index: AQHXPn2fNc4/u5hEg0mmySXeuab37arRM+wQ
Date:   Mon, 3 May 2021 04:56:43 +0000
Message-ID: <BYAPR02MB394182A55D073BC6061F6D76B75B9@BYAPR02MB3941.namprd02.prod.outlook.com>
References: <71a9fed5f762a71248b8ac73c0a15af82f3ce1e2.1619867987.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <71a9fed5f762a71248b8ac73c0a15af82f3ce1e2.1619867987.git.christophe.jaillet@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: wanadoo.fr; dkim=none (message not signed)
 header.d=none;wanadoo.fr; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1536ac42-0e5d-4ce3-2b09-08d90defd929
x-ms-traffictypediagnostic: SJ0PR02MB7600:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR02MB7600C6FD0D330E8F9C022DCFB75B9@SJ0PR02MB7600.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5FT3W8cgFdqjZcMpdrKFaqMws1/KIbQFtePn6nsTI16AY0m2Oq4aewNuefBpUilzNmjXNTlNVa9k5isMOEAFjA4HMc0tHieBqGOB/1ptHbG2O+Q2MygaeWmO7nUcHLQH/aCjladWN2qPc7LFFdkBdMBpka6SXLultIXcpFoqNJQt2XVpj1SDdNfWOEJ62m2/9APIvM7Aly5Yw32Cdkl/hJxHI1VzdKzMOjq+099qkRXXgnLWdfvPU0N/M8TmGBLaE9cGkkjJf/4B6Uz8joELDvuDLArYu5DdndP0ZOjM3xgg9r/XhKgX36nlZSLOfH9DbD//ebtZ+Ct88TBv2CsxbT/z6fAbq7W1g02y2bZoPnNI9bgj+pzyT4P2Ez25SeV3TbkE9zQus646vRyIE6v1bo2vVgsMz3JJycyjLZeiRuaqEeHlU5DxbFPu2OXMv8oo4J/9UMZFKaRemz6yCTRXe6mPSNPacxLj40gOuVqgy/t79a3keew5xRi9g0JVjm9zrU0r7ZS+/V6oS2CCNR+11GODyFmzU5PpdQJtTqAguKSw0zoky0FXdVzSdDXSuYgTHR2uS/e8BecNuWcw+Bvg0zMxveY3PwdJ5a6GZuPhxzYyD4FhLFX2AZBMqjXkXBR5eUYLNv+JshFwMa6WTso0FA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB3941.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39850400004)(396003)(376002)(346002)(366004)(66946007)(53546011)(64756008)(5660300002)(66446008)(66556008)(66476007)(6506007)(86362001)(54906003)(76116006)(110136005)(83380400001)(33656002)(52536014)(38100700002)(7696005)(478600001)(186003)(26005)(8936002)(316002)(2906002)(9686003)(71200400001)(4326008)(8676002)(55016002)(6636002)(122000001)(21314003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?0Hgxv9LAKWbp67HxMVLSqGtCLsw+bG1UEFV306F3ARTHv4vFxfmRsZfTIVox?=
 =?us-ascii?Q?PM6lr3PgWlchmTygbp/utWE61Rf9afeW2C7FscXtIoL+6tuMg+4xRqLzPeyE?=
 =?us-ascii?Q?2+I9ZDxuvO2gPS/cAx0zWIeggF4PFomlEMzYHTRr/sE5e/DE2wAsaSzdQmH/?=
 =?us-ascii?Q?fU6LHcNNvTHGJRkalha1kHXDNacLKoSHssByKSB5l2jPQkFtRHcwxgKAp5b0?=
 =?us-ascii?Q?RuyQNNB/WUDXGtgtL3H88cqKzzN9R/gN5lIx2Nris7WzvRV1RW7qjfd8SJMY?=
 =?us-ascii?Q?MAtnWQOp5JIy7C+/0+etNs+yyMGZUgSeQdpbMIPpjhF6hC7fzMTICtsb6YiZ?=
 =?us-ascii?Q?SOGbbwFmd4uBWaJDcpjb9b2FFb9TA29RUkMORf0P8cYwBI684wZOT7GlijJ/?=
 =?us-ascii?Q?td+9lW95dEWr4IfiKo77uUNrCIecqftNihPAAbj0L9FJTtKnaIEMKDg4VIy1?=
 =?us-ascii?Q?dd5oOOplf/LN/1HKwn0/SHuK5Fl7gyNLeajIxUXrmEw+rKKnOnEfmBcAG9Fc?=
 =?us-ascii?Q?QLTJ5lGk6l6XkTZSUdjqmYMs+zqoTDd7whDLl95KYUX+tDdH8cABV13eRUiD?=
 =?us-ascii?Q?TgBJhI/s/qzDf9rpa1HeOr668AbM/F9odyiljQYl7CFvRb2yb8Wbyu8E6Ig+?=
 =?us-ascii?Q?AXO8Z3JmoSj0IyCwfxaOR5XWIQIo/vR3JCFRsTY2gCeSZcDzi/1rMBeAkZ/s?=
 =?us-ascii?Q?rsLaa0ZGoHVIU8E9wjYF2I2EvdsTGeOYFthfymJmcMbd7XammOYAl84SK/YZ?=
 =?us-ascii?Q?SBz4lH94ZSbyclR0WIhk0KOGnXvtpfgKNc7PNouXu+40cROqvlaEspThq67z?=
 =?us-ascii?Q?V+EVNko+iDsz27ju/FRiawTlgOAGZIKltJMEPk3hTyscJLSBB5aokG6rk6WA?=
 =?us-ascii?Q?L8HUHXEi1gs9tqTkd0p+OKVCU12EkGfWIe/xguLUZkdcSaSr1dbZAgXFyBlK?=
 =?us-ascii?Q?nA+wAZWCeG6Zf5HrLNk7P/o7r3LjMTawp4wvjBWXZSRv9Ob78QywX0aVPkIQ?=
 =?us-ascii?Q?uFusaotb+dNN9COdO8MxH7BnHRPzUe0tKdm2xmd51rr1V6IrCdfdOXqijONX?=
 =?us-ascii?Q?71yMNysqd1oyQVrM7+rxk2/qz7RIWuNvfmHS+VuG9aH1INtQVscryckdtuMY?=
 =?us-ascii?Q?y6izkFZUXbe1LtaWqHbwdMIp2D0moVvOXTykraG16hwRhOOLn9Z/HNYeMDqX?=
 =?us-ascii?Q?ZJhqTCjkTRNMZIMvY93MKCYo6tY1ywlvLPz4n7I0ZCw0MSPKFvDEsrVAnaLv?=
 =?us-ascii?Q?JbFfWONLk7rfdKfKturVP/BMMUB/fIfeuDUB+AVcc4zPVmpkg2ceoCLfOtTO?=
 =?us-ascii?Q?UY5zqn2uwBSMhX66jhybMZt0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB3941.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1536ac42-0e5d-4ce3-2b09-08d90defd929
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2021 04:56:44.0005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Jyttt/DWOgZQvVwLcpUpp7m6jfNvuL+G7cA3ruSFceJedEDTUfZMlquDv+QWUlCv1VODP8lqb8DYSCc0H37pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7600
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for the patch.

> -----Original Message-----
> From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Sent: 01 May 2021 04:55 PM
> To: mturquette@baylibre.com; sboyd@kernel.org; Michal Simek
> <michals@xilinx.com>; quanyang.wang@windriver.com; Rajan Vaja
> <RAJANV@xilinx.com>; Jolly Shah <JOLLYS@xilinx.com>; Tejas Patel
> <tejasp@xlnx.xilinx.com>; Shubhrajyoti Datta <shubhraj@xilinx.com>
> Cc: linux-clk@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linu=
x-
> kernel@vger.kernel.org; kernel-janitors@vger.kernel.org; Christophe JAILL=
ET
> <christophe.jaillet@wanadoo.fr>
> Subject: [PATCH] clk: zynqmp: pll: Remove some dead code
>=20
> 'clk_hw_set_rate_range()' does not return any error code and 'ret' is
> known to be 0 at this point, so this message can never be displayed.
>=20
> Remove it.
>=20
> Fixes: 3fde0e16d016 ("drivers: clk: Add ZynqMP clock driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> HOWEVER, the message is about 'clk_set_rate_range()', not
> 'clk_hw_set_rate_range()'. So the message is maybe correct and the
> 'xxx_rate_range()' function incorrect.
> ---
>  drivers/clk/zynqmp/pll.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/clk/zynqmp/pll.c b/drivers/clk/zynqmp/pll.c
> index abe6afbf3407..af11e9400058 100644
> --- a/drivers/clk/zynqmp/pll.c
> +++ b/drivers/clk/zynqmp/pll.c
> @@ -331,8 +331,6 @@ struct clk_hw *zynqmp_clk_register_pll(const char *na=
me,
> u32 clk_id,
>  	}
>=20
>  	clk_hw_set_rate_range(hw, PS_PLL_VCO_MIN, PS_PLL_VCO_MAX);
> -	if (ret < 0)
> -		pr_err("%s:ERROR clk_set_rate_range failed %d\n", name, ret);
[Rajan] Instead of removing, can we get return value of clk_hw_set_rate_ran=
ge() and
print in case of an error.

>=20
>  	return hw;
>  }
> --
> 2.30.2

