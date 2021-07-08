Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 771793BF42B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 05:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbhGHDEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 23:04:01 -0400
Received: from mail-db8eur05on2064.outbound.protection.outlook.com ([40.107.20.64]:22621
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230387AbhGHDEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 23:04:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sq57MHOeWfoEJUMfKMNdYGQj79p7VE9kslsDa06QUde4nDnH9HdLYVHZaGn93ND/NAFB2Gm66aZbg+n5s/iNj6Er+pUTHTsjpdbAXGTdkIq7s0Dcan4xwMJOamoQ6xdbucr9KYelRZXZUXEgWl7qWez10RHoPjCKGrh0lMvWEwUIReKYmVL1FkIuXVbkqXFiOwlvxbevQpyfguKxPopk4gaD19hNfYGIEkqMjK3AotWav/cEbKBxPeAVM9zo+fKFMylfC5O5l+2vhyxy7OoSxnzW+BLF5CahWKuXlW3atw8XJlR/JRHNiOMwtppzbjxfmjRKMzDmkb28WpSSyIu4bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PS0+dzpmrJxeeMuiWXj3oRA+xYuCCdg2E4OFAQUDXKw=;
 b=BbmZMEywxqJ9F0kADhsEM/V/HB0W1b/sZVTemGgxKkZnpDt4pe1TEvSS0vowxV/+BX/5UKiqRGvrypOPrWhrBWTCiao/5hzvhE9+tJjrDAq4+Xllfcgrjn6EqwTFynb8tcyYTpVxzDcJfFc1Qw4Kx0jsWV9XiCSV3S+TSTMgLpyEOBa6WOKganfltZaxvcDQGjbuS5Zkx7VT21NitM02TOYSEqGYxyvr88tJjAMJ0vKtMaa8NkW4IsStqCGQ/iMwvAUvx9bYJhI+fega4utxQSDUhUBdNbxTLZ+YRQpQO4+VrILcYCUEyQyNf4mbxl2vDKm5to8i7MH29N9TIR8B7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PS0+dzpmrJxeeMuiWXj3oRA+xYuCCdg2E4OFAQUDXKw=;
 b=WJzCbVS9ijGg1mN4rdZAeRXIemW8D+UWn/OOwwNVxwsMw5Lu1OM2Ur5749Ro6Py7GWyJvpGffAVXegIdqsu8Mt3QdLy8Lv2BsJb22ER04WDw+jOVe94G8BY//tEs7lYd+/qurPNola5c5yIF0yiX6KMh9hsEgmSkjP0zGUIdDpY=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DBBPR04MB7884.eurprd04.prod.outlook.com (2603:10a6:10:1f2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23; Thu, 8 Jul
 2021 03:01:16 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c445:d742:eb76:86dd]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c445:d742:eb76:86dd%9]) with mapi id 15.20.4287.033; Thu, 8 Jul 2021
 03:01:15 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH] clk: not calculate new rate for protected clks
Thread-Topic: [PATCH] clk: not calculate new rate for protected clks
Thread-Index: AQHXVgSxg8DzlmcuR0ixKMBWM65yqas4nvwQ
Date:   Thu, 8 Jul 2021 03:01:15 +0000
Message-ID: <DB6PR0402MB27601F676286D00AE50B144988199@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <20210531103957.21886-1-peng.fan@oss.nxp.com>
In-Reply-To: <20210531103957.21886-1-peng.fan@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oss.nxp.com; dkim=none (message not signed)
 header.d=none;oss.nxp.com; dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1fd0224f-b774-4128-9330-08d941bca6e9
x-ms-traffictypediagnostic: DBBPR04MB7884:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DBBPR04MB78842356F64B736A87DF464BC9199@DBBPR04MB7884.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dWRgxvJqfBVQOxYe2GPMxKHHENfLedMT8I4RPeS/VeDg7JgIAKxZx9xM77O0Tt5kzlOpnbDSJYrwKVRAMBkmwOOLNCC5ilcllnttfznl5rSZ6B3oQ9DMn2YmkDCfYxrAwLN1cY7muLj/aMH68E16OoeJazVs8UeBt3p28tWCG8cZ+M6YKFiTqyOjuAWEOlh2dWe8G1By4Ltq+YWl1PhPCxzeQy/JsNwi3UASH79p+J1wRxTFcSqVpbU8wV9YSu9Ke1/ZELl8N7KiqHwy643L2Vn6Idx9ANLFGHTSZDJKgDXjf2IGf6FUq0TAq+UC4+psuL2Q8VW1JnxfQbJJYJNQ6lVCJDwXd0kS6YI6oBs1aetr5ot4PGGUmYYlplpub5/+qjk8QgFdb3V1Twdt6DHu0ltX7SlJcRZ/7cIf1bKWv/NvF6zPYjn7IUnpBBx2RVWpY4eCly95JU8xBQUR7o9RhrYJdxb+xFaMC2ypbnoAN6wnxr6vzH162jCVNj9UcqyTWdyBskGiMzSG8gELqeHK243rfrt6yDtVjkYa7Noy6mGCDWjEEtJ8GeTAax4LjYruAQ2+eoNfnKwbr5vy0J2rqKNXI2NmlfDBjzVBL1/yuRctuc8TGIT6CvAW/vvzFdNy+Di08f1I4pyLTkOrR7wL/A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(6506007)(55016002)(33656002)(4744005)(9686003)(2906002)(4326008)(64756008)(71200400001)(316002)(122000001)(478600001)(66446008)(110136005)(52536014)(7696005)(8676002)(26005)(38100700002)(66556008)(66946007)(76116006)(83380400001)(66476007)(5660300002)(54906003)(8936002)(86362001)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bL1u2Lnxz8HOk+87jYpf1WAydV0G/cR2KPJzx1FB1ei/4EoNK2os84SvZHCR?=
 =?us-ascii?Q?Br4Mg70ZsaY2ermX6ZK6nkUnwja/LfZrnkb07jyp+doQFk7AFxkel64JGsln?=
 =?us-ascii?Q?ZKXElrRxjjXZ8W+3M8K6SaL1VC0zMr0SqsnmZz/Pqz1Ww91N4yR2zXl3q1/k?=
 =?us-ascii?Q?4X9l4mm6AYSSYqQi5iR7c4VRdB8C0afu0loJlGPHhuSfBz4Xav+aiG/JhkZY?=
 =?us-ascii?Q?1Syn9s294lr404DvGdIfqfQbw4Jf2v7+P0/eyOcIFqtprTRCnxgtuNmEIRAC?=
 =?us-ascii?Q?UTvPIn1u3cQtF7mmawEGZTB3IEJbfVAz9r58JilI3RtSBEsInD+xweKBLCUl?=
 =?us-ascii?Q?x4PUJ3V46UamHO6RGwT/ZLQ4rN7gU8o2H/fEUEY+cbmDRjirbxzc3dqO7P5Z?=
 =?us-ascii?Q?Jh91LkWLTKTecmh7ecOEFoP2FExAkl1LXDZ7KSiYxOi+E7rnScMqle4pVMWe?=
 =?us-ascii?Q?jqMzLjDZgyzr3VYcg/06yBdMZi9Ev6MReie7tAfBfLr1oRkBypsXiTZ1VMgr?=
 =?us-ascii?Q?Ux+YXTtsgQBkWA4iNFiA65YLz6MQNq2KHkwNUVWi9TXz5upFHvGqDz0+BW5N?=
 =?us-ascii?Q?xTN1/0iVqXo402N6NeRKmwEY10g4DlxLCEDL545pcjgQ5F2L4F0lv0XUyMaY?=
 =?us-ascii?Q?CgJBxJXsKu/GKhtOHC4d4kETq9RX8HOKF2+I2ePMCCE7gw/BYIwny0tO1J4P?=
 =?us-ascii?Q?VjwjfA3ZV+L/kdmHakZ3dUE/zC1gm4cLqCckeTggRyUD4+ts1MlY8T6+UMdA?=
 =?us-ascii?Q?BxqWngO2TUl3kBVWspwfBPnfMFin9/1+IaUq6477Y/UmVWXHP/AndGz5n6Fw?=
 =?us-ascii?Q?DjnEUpAR8nm7i9wcZvXQ138kwiR30uB0fZmg4NoNr/Zoe+tLbbQKZ6p8xIfp?=
 =?us-ascii?Q?iUl5m/dj/1LsOTAf/Piz0gv0vsGdGGra5DZ2zd1g4CAIfwhJ7unEhs0FN2ay?=
 =?us-ascii?Q?XEJUXzNJPDrqr7WuKTl9W4D6PuVAYjoO0uBmuz1IH/5ciEErYnFYYGDzI17v?=
 =?us-ascii?Q?Ezm2GYapXg79BdIfvQk4nEgSBsgpBkGswiJp98ZUnILHQbtcvzFJRRONpju9?=
 =?us-ascii?Q?Jn9qdV0Rivz8HeMGAuBxmtHMa3ohvgwE+6Un5qSIizmzGy8ZHdru1rNNTbxV?=
 =?us-ascii?Q?tWB+TmBa5EdwO9jhRsbMHXa1gfjwLaE5sxudKA/vQrn2qHvpQm/FwKxY7Uv2?=
 =?us-ascii?Q?f6O2eHoETFOjFUJnS2QeE2odOwsPG4aZC7odtQ60xGIsCr2reZA+xR0Ezj6C?=
 =?us-ascii?Q?cP2/ZgmOkK4O3HsLzbnCHMtatnKqWGOOp4ZI1GTRHHYdYBOOgTAfEA8EzSQ2?=
 =?us-ascii?Q?d4pG2gOBcK4nvS04KcABT1G+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd0224f-b774-4128-9330-08d941bca6e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2021 03:01:15.8678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uYcRbUwg9qIuakhoGDZrY4emA48U7lm+o6p98wsxDUOklZfpWwbreP2n9jbAI7esrbPwuH9DcozbybaTnLP6fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7884
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH] clk: not calculate new rate for protected clks

Gentle ping...

Thanks,
Peng.

>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> If the protect_count of the parent clk is not 0, we not calculate new rat=
es for
> parent. Otherwise, the common clk framework may configure other child clk=
s
> that is under using.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/clk/clk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c index
> 65508eb89ec9..8ac121838e13 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -2002,7 +2002,7 @@ static struct clk_core *clk_calc_new_rates(struct
> clk_core *core,
>  	}
>=20
>  	if ((core->flags & CLK_SET_RATE_PARENT) && parent &&
> -	    best_parent_rate !=3D parent->rate)
> +	    best_parent_rate !=3D parent->rate &&
> +!clk_core_rate_is_protected(parent))
>  		top =3D clk_calc_new_rates(parent, best_parent_rate);
>=20
>  out:
> --
> 2.30.0

