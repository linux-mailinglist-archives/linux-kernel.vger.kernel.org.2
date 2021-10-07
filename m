Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2DF424E3F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 09:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240468AbhJGHrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 03:47:46 -0400
Received: from mail-eopbgr1320102.outbound.protection.outlook.com ([40.107.132.102]:62388
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240429AbhJGHrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 03:47:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fd0LLeqm9YRtm4sSZGEsNCMwhlCxedgXQk0gD02gyimve3oi629vnuHT1npFLWG26AN7pN54VLdKPfztQ6JEe4IkITeHhqEjkKZmA+SAo5vsDsC05Qgt4IoqLLHMDL6RMXHDs5cUfWP5V0H89ZSI73Hsa+3jmIeDSNNlAsGVAoreAR3ZindnLODrGQqp7yZ53OHA5sFKamJsDOds6yhhwSZYczSZzsoh/FR0MVnKDNPEvA30WS72O9sXia0JyJ/CieS4dHFmFbKDN0Nr92WVaMmGc9Nco5a/XnoFbcKdb3zJFfoakQE+T5s0BPoze8bSg1lztJ5eRVIXq67Fi5wtHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/SiGxu2zhgri78QV2Tw+BlHoO7LpEfdxEh0O3YEILI=;
 b=JAJ8YKZavNsZADqAbO42CSLqUzx9B3Q3OR5OP/GKP9EAJKp1zVTwFxzqc0q8NAaHCGR0to/hZRgnKkYj7vq2uhfKvk6iToKuQ3ZrQjrYZwmaM4/vtUKjL2Gi71IRIdZrtqMMG7oyVdY8jl0DZ8uK7k1yiyymc0do9lwx6dBNyW7U8oTn9BGhWSLNZKdUf7FfZuMOfuNXlrXpjlO2ArUZA19R22IzwGcJbThQs9ofeaMvtKdhv+1EFxT2MSeRv0k4tSifWNDHfSwhN3irR8BeAPfqO622V9YqgtfxWp6ZYVlFqbmU1OfXqbgA+JCbV+nmAgKTeiTemy8hHSpqjeF3jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/SiGxu2zhgri78QV2Tw+BlHoO7LpEfdxEh0O3YEILI=;
 b=vSB83U3qE3VqMRS7+ro78eCXIXbf1TA5Tj1cpjlZ+7pSdcmrzd1HYoidj3oWgxugwZs3q58GxrMymOTwCuVFVT9TJbroJbsHvC4mBajKC+04YdjaQptVUQ7CFltjHtVDpOkX+6q5Noy++Xd9SBpoxCjT0UUDdwpgPOlIGqKNpzJSBI5qPlUyxlpttMmHFwWAj/4rGqH4bXqhrunLYht5cJCdhJVap57GikFAHCsbefJNNEhlMQanwR6GirqRdId5lRak+fbdxIkxiuLYdy3t0ZWI1G4Y6bPSwzD5nab1ExTV/FuEiLV05UY2v1HOiCBkQVpC3BtaOdMbDgrkCSJPeA==
Received: from HK0PR06MB3380.apcprd06.prod.outlook.com (2603:1096:203:82::18)
 by HK2PR0601MB1922.apcprd06.prod.outlook.com (2603:1096:202:b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Thu, 7 Oct
 2021 07:45:48 +0000
Received: from HK0PR06MB3380.apcprd06.prod.outlook.com
 ([fe80::f4a0:ec4b:4af8:1b]) by HK0PR06MB3380.apcprd06.prod.outlook.com
 ([fe80::f4a0:ec4b:4af8:1b%7]) with mapi id 15.20.4566.023; Thu, 7 Oct 2021
 07:45:48 +0000
From:   Ryan Chen <ryan_chen@aspeedtech.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCHv3] clk:aspeed:Fix AST2600 hpll calculate formula
Thread-Topic: [PATCHv3] clk:aspeed:Fix AST2600 hpll calculate formula
Thread-Index: AQHXsbRv6xuXpttuYkWAu3oZNdj4AqvHOzbg
Date:   Thu, 7 Oct 2021 07:45:48 +0000
Message-ID: <HK0PR06MB3380A94CCB6F620BDCB666EFF2B19@HK0PR06MB3380.apcprd06.prod.outlook.com>
References: <20210925022354.10297-1-ryan_chen@aspeedtech.com>
In-Reply-To: <20210925022354.10297-1-ryan_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=none action=none
 header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e0ede143-a666-42d7-e02e-08d989667a71
x-ms-traffictypediagnostic: HK2PR0601MB1922:
x-microsoft-antispam-prvs: <HK2PR0601MB1922E2F639DAB296E72969CAF2B19@HK2PR0601MB1922.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:196;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uzoocQMGpedUZB0lhnrTujA5zd2a9dxkmeX/L4De4hlAoURIFU9cIlNk2EP/YBifGputumvvDaL0booUSl9o8LufMUAnKIrU2ZI/5I5lyPrgvsmtiHIl+6qVI+u5+tww04u2Jv9JD3AIgvKZ7N727rglAjj88k/XsfccxKaW+dYLcNvhGQiJRacCznj2YosSLInmjnkFo1jpiz3bRylAhuHGh0Pk/nsTGKhBn7XEfCDP/nLcyZWww+VWQfGidBfSZXgzVgtoPoxnLSL3imlcdSIDgssYOUN6guNrVkqBjipVsig1WV+/oMzHNoV/o9vNoI59QejocFECdyySrpuGk2CV2OwKCKepvHiKqZQ4+Ur6QaJQZkawMScodG/K0MvtkATun8jIG1ogYLQVEREGvLheJHOO9Y356MqsEPtL9gBcmBbHt3OGdiwWAIZTOslxecnHFO9+/Q9imwG3s0P602nW9zH6GR45qB0IYe7jNEhj8FNxD96S/PRhEzJqeuWB8SGsIf8yDgJI/D+6XxzLlwZko3SOwRsf4ep/6Gy9Yr/9Jbp4DBz0oNWTsT1wR/DwsNYA/WUgyWqbvTkmhvevhKerUI4jiAhE0f44RTlifgG+DmzSxFiDHb30VTqaTgncseqE6R6dvWhqswOHVU+86Xd3vEZuA6YqYV7dqyQe/gcx/Zpm+TikEXodrNUn8VdBnD86ztOLMnfsuxdeuTEcog==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3380.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(136003)(346002)(396003)(376002)(366004)(33656002)(316002)(86362001)(5660300002)(186003)(53546011)(55016002)(508600001)(2906002)(38070700005)(9686003)(38100700002)(76116006)(66476007)(66946007)(66446008)(64756008)(66556008)(6506007)(7696005)(8676002)(122000001)(83380400001)(110136005)(26005)(52536014)(8936002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/9rI9DQQrPTlfaiXhQEqZQF8pxd/RUZkSJsYAfVaEeQWJegT6MYlnP6FKeKk?=
 =?us-ascii?Q?FRCw5x9tepmq5+nLGAsdx+wnWBjPJebhAHE4iK9usj2j3BW2MLzePy4OdO74?=
 =?us-ascii?Q?ur1XCCrF6rd2T6Esd4lmBWBlBYRYibeCtDbqhC2Ev+9YWiMifgS4jMn5pzkV?=
 =?us-ascii?Q?1+EaaxTu5BFxseqV2PZAsqElBMliYooU9WanNKfss72u0j7gBp29im+j6mHA?=
 =?us-ascii?Q?qQguVqzTsLfLLyoWP6Q4HdEv4FCceEtAqjT7opRWgqgJ1YrTD/NKUd+3Q9CK?=
 =?us-ascii?Q?/ydpZPHtYKpBPifhthqQHTkqDJ2KN0+PHiA1FKYQJzOnrtCNjx8XquLkOudP?=
 =?us-ascii?Q?iFkP8rzdFYSX3JkqA7dZS1j0RbSjoypqo4jqJ8CH+JcaYqCXa1iLjnIzyMZW?=
 =?us-ascii?Q?MwVIIVhceB6wC6OqL3l8iCvrkoHdZ3W0djiEB6az+wAMDTYvbqW0oMTsmo5/?=
 =?us-ascii?Q?WwqW0KEwVzBp7nY06jM26QXiWoSNFzYNIdKBUOggijwyI8n8FiNRvxbyMGOu?=
 =?us-ascii?Q?5byzgh4ZliLeVfWDIDy7ORDV/6vX6CmraPMIhtEgTQ3hZsjyqaNLMnx1E7IQ?=
 =?us-ascii?Q?6gcINirUvrXza3a6I8ky/4WYix4h33yZiXGq3L7zdAGOoth1sShXZ/dXGHkY?=
 =?us-ascii?Q?mXNxslZm3Yr3XDoQcZ3H5qtakgPQxEBaIs3XLbQf1SBjAlZMY7Odz2hfHbp8?=
 =?us-ascii?Q?ELiHDPNWx2NoC/hYAMloKPxgxO0QYB6ZshShaaJ0Y+XekclDbGnRXmzA+cf9?=
 =?us-ascii?Q?zZNNKMYhTyTwzSK/i6SQJl6qJgaDbOHBiY/l4RneMCaXf0M+pZcBU6C3x31u?=
 =?us-ascii?Q?DdKGPz+hFr+z+yjDgdxg0HWRwRBk/HIlV+Av0vO4KE7Ozgg75auhRG6ac0Tg?=
 =?us-ascii?Q?XOI3c1jqIFI3BsIH3mizdXH7TRQOrgszBvTwKk/ZZunLDASoLCroySToM8J2?=
 =?us-ascii?Q?CTLzvnK6g/VnjP2ELbhk131p+7dMghejZKcIwYc2V1L9417SuqYJPU0y56+E?=
 =?us-ascii?Q?MBYGB57t4WjUNxX6XPiYdd0dLQcrLXGKfLL8dACD1Jd7srT46+2paUjnX60o?=
 =?us-ascii?Q?3+ouHtZdcC5a2HDUHTvdKFVfo1Q65pVgs7YGyrpOVoUPI8pelNmPMuagkBGU?=
 =?us-ascii?Q?VdxssYRDKJlYEowl0pXF/Wqnd8TGHPP8Q/qW46wxSGAYJ62xJVmok+BOnPi6?=
 =?us-ascii?Q?AHiyMtzN8DJAj0PQz9hluaJJowKwnElcTtVm+NY5Kd48lJNv+VrTgaJ7gZbz?=
 =?us-ascii?Q?AeQ4UHvfLSP5A9PyMrrR3D8LAsJg7Uwg+JUQVZiWjOlM8cm881KAs+6raA2q?=
 =?us-ascii?Q?vzvG/3/g/ODDEnUdKb6wttT7?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3380.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ede143-a666-42d7-e02e-08d989667a71
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2021 07:45:48.2759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1bKqA/ZoIjR6hXivn9Mi8V2XiK4xWKUO2pZBMmv/rEc8Bd9QBVt4ffDFabap4n9MRqjcDkZr8YAXCnWZVGGrBEXPuxPLG7M0aTdhzJ0tgU0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR0601MB1922
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Joel,
	Do you have time check this path?

Ryan Chen

Tel : 886-3-5751185 ext:8857

> -----Original Message-----
> From: Ryan Chen <ryan_chen@aspeedtech.com>
> Sent: Saturday, September 25, 2021 10:24 AM
> To: Ryan Chen <ryan_chen@aspeedtech.com>; Michael Turquette
> <mturquette@baylibre.com>; Stephen Boyd <sboyd@kernel.org>; Joel Stanley
> <joel@jms.id.au>; Andrew Jeffery <andrew@aj.id.au>;
> linux-clk@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCHv3] clk:aspeed:Fix AST2600 hpll calculate formula
>=20
> v2 -> v3: change else than if to directly else if
> v1 -> v2: add Fixes commit hash
>=20
> AST2600 HPLL calculate formula [SCU200]
> HPLL Numerator(M): have fixed value depend on SCU strap.
> M =3D SCU500[10] ? 0x5F : SCU500[8] ? 0xBF : SCU200[12:0]
>=20
> if SCU500[10] =3D 1, M=3D0x5F.
> else if SCU500[10]=3D0 & SCU500[8]=3D1, M=3D0xBF.
> others (SCU510[10]=3D0 and SCU510[8]=3D0)
> depend on SCU200[12:0] (default 0x8F) register setting.
>=20
> HPLL Denumerator (N) =3D  SCU200[18:13] (default 0x2)
> HPLL Divider (P)         =3D      SCU200[22:19] (default 0x0)
>=20
> Fixes: d3d04f6c330a ("clk: Add support for AST2600 SoC")
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  drivers/clk/clk-ast2600.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/clk-ast2600.c b/drivers/clk/clk-ast2600.c index
> 085d0a18b2b6..d30188355aaf 100644
> --- a/drivers/clk/clk-ast2600.c
> +++ b/drivers/clk/clk-ast2600.c
> @@ -169,6 +169,32 @@ static const struct clk_div_table ast2600_div_table[=
]
> =3D {  };
>=20
>  /* For hpll/dpll/epll/mpll */
> +static struct clk_hw *ast2600_calc_hpll(const char *name, u32 val) {
> +	unsigned int mult, div;
> +	u32 hwstrap =3D readl(scu_g6_base + ASPEED_G6_STRAP1);
> +
> +	if (val & BIT(24)) {
> +		/* Pass through mode */
> +		mult =3D div =3D 1;
> +	} else {
> +		/* F =3D 25Mhz * [(M + 2) / (n + 1)] / (p + 1) */
> +		u32 m =3D val  & 0x1fff;
> +		u32 n =3D (val >> 13) & 0x3f;
> +		u32 p =3D (val >> 19) & 0xf;
> +
> +		if (hwstrap & BIT(10))
> +			m =3D 0x5F;
> +		else if (hwstrap & BIT(8))
> +			m =3D 0xBF;
> +
> +		mult =3D (m + 1) / (n + 1);
> +		div =3D (p + 1);
> +	}
> +	return clk_hw_register_fixed_factor(NULL, name, "clkin", 0,
> +			mult, div);
> +};
> +
>  static struct clk_hw *ast2600_calc_pll(const char *name, u32 val)  {
>  	unsigned int mult, div;
> @@ -716,7 +742,7 @@ static void __init aspeed_g6_cc(struct regmap *map)
>  	 * and we assume that it is enabled
>  	 */
>  	regmap_read(map, ASPEED_HPLL_PARAM, &val);
> -	aspeed_g6_clk_data->hws[ASPEED_CLK_HPLL] =3D ast2600_calc_pll("hpll",
> val);
> +	aspeed_g6_clk_data->hws[ASPEED_CLK_HPLL] =3D ast2600_calc_hpll("hpll",
> +val);
>=20
>  	regmap_read(map, ASPEED_MPLL_PARAM, &val);
>  	aspeed_g6_clk_data->hws[ASPEED_CLK_MPLL] =3D ast2600_calc_pll("mpll",
> val);
> --
> 2.17.1

