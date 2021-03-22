Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADA934365B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 02:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhCVBlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 21:41:36 -0400
Received: from mail-eopbgr80078.outbound.protection.outlook.com ([40.107.8.78]:34945
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229614AbhCVBlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 21:41:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7AaDIlmlOZ4s5t6Ddq1dBoaFztOTbfLAmLLYQV4jKEHeCTEq54d+qUlsJOCpoF0Qd/Tv1mviPV4577Fbr+PJsbUjRyXsNgFSAmVDKiIk2pvCoDQOkvbVosEpoj92vZVL/Tf2+8t/nz39uJeuygpeW565QTktZy5LcfvGJhfXfCf7BnWTniE7k1LAneNrjQV5Yz8/RbDVtRrqM2NpC38wdShenGvpNGg/didmesSZFLABvoqbnwiO4Zyll1yE2Q9jZnOs8VLgsCRn7e/SYeZQ6MUmE6AZ4qjVFDRO6UQBPmAniuubp3uQLd+c3xFF33N0ho8LmR2tCi8SMnoii+WNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=trx+8pEWFBFVxsDMc11jQPgA498gSKI+j+LwXN0X7wo=;
 b=STeHeb3Pnmm1RTn02lpcvtED6LCtE9+abQIWqA43l1ZEp48NdMunlDLuYratJQG9cSV/Xp1VZezEp8LBfIvBegP47oc/l0gleD3SxxcAQO/XVcvgb6Ai3nPujozRcDelkVejAiT+lHO7znvRBwrxKZmpT9nkxv+9NVkyYV+InlXKxu0lJAbtDR0WhtVbEhCbZ+16x63ikFptaVJz83GpaSLHdsQJngD6JiQCIRb7sIp/YI+NYrJkiIh+DERrojtHW1pyAlV4Ifx0nh9LRaFsGC0pLwmAq5+xUw51cgF7tDh0V87MTvcJTckeLs2g+54U7DUXP0cBFL93I2w80Ils1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=trx+8pEWFBFVxsDMc11jQPgA498gSKI+j+LwXN0X7wo=;
 b=ZDDp6j6oA0o3zqtQ6voUyZpOjHJs8GOigMiKn+G4P8eaOGT+/JZ8w8NJAx+LbiM1tDt7ZBf9wvumYadyRzqrJ/L+gRt3mr8zFFn2YBsfpL/uyRiMhsUsBsQrIvlrRzx8GDAwQkhOW34LEZyZj10JgiBdg5eQgDGEmbLZ7XywMHA=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB5468.eurprd04.prod.outlook.com (2603:10a6:10:86::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 01:41:08 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d58c:d479:d094:43d0]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d58c:d479:d094:43d0%9]) with mapi id 15.20.3955.025; Mon, 22 Mar 2021
 01:41:08 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Frank Li <frank.li@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Ying Liu <victor.liu@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lznuaa@gmail.com" <lznuaa@gmail.com>
Subject: RE: [PATCH 1/1] firmware: imx: scu-pd: add missed ADC1 pd
Thread-Topic: [PATCH 1/1] firmware: imx: scu-pd: add missed ADC1 pd
Thread-Index: AQHXHQY1bM7QDJYObkKlRyjg6hmxpqqPPrkA
Date:   Mon, 22 Mar 2021 01:41:08 +0000
Message-ID: <DB6PR0402MB27607CC2B5592F886461632F88659@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <20210319212352.31869-1-Frank.Li@nxp.com>
In-Reply-To: <20210319212352.31869-1-Frank.Li@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 41dfef6f-35cf-44fe-db7d-08d8ecd390e1
x-ms-traffictypediagnostic: DB7PR04MB5468:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB5468BCAE2B7084DB09EFCC3388659@DB7PR04MB5468.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vNv7exKwZl0tvLIMILJsv7+3UN27wT5kgalFK1XubDBoNB0U+X+zUhGxbQA/8JXBJQ0dcdUGdvmVcSW+Sv32zTiPlulzPa4A2tMFkkUSXUXQzVvMFAcxblLhD6ypOV0bSHdvmbEvMvO5vXHghdzBFRw3bciUUCUWgEesLKVx9xnXeRRlbJP5WRXbcBJiWuxgM5sPy6NJU4JMgRtekD7Qg6NdJZEtWkkbX9ix5T52AOnNk3DY17xDH/91fKTD2fGF7S0K4Xgf9ITlNQVZED2gyajrE6Mk8oLLRZNdPrH0TAYbupdl5Sya4KtexSt2VclEN50y6Xi0PTb2yByfOUbTtxSKBnTg3dBNJiNsOOUAlf3WQJXtSFiJqMhbj6U8za2Rl5QUDsbO6A0Dy/ZEWcqOrV1RCWu5aNqmMmY+0mKYpYMQwDyM3t2QQwkY05MWeARxGk4G3texYtal+7ZSat6I+PXQ4wHq+0D0LG3H5AoKJYkFfMDNLYtFJY/SQo2lw238xnmGFuAhqmwRjwimdnypMRk0P0OHFbu0iDvgtZBEUDbOACVQo9IX0UYYgRYy2ib8vvymdfLb7ma0VSjC3wsxLKHUaFhvqQZ7Aag26/ROOC0iotVqadIAuDzbkMWCDmbpkcQxBt+2SkDaYowPfrq1wyoKoix5s9X/br+5G/eqUbiU/e35MCKZhhS5PC4Kok53
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(2906002)(110136005)(316002)(7696005)(921005)(478600001)(5660300002)(6506007)(4744005)(71200400001)(9686003)(38100700001)(55016002)(52536014)(33656002)(66446008)(66556008)(66476007)(26005)(44832011)(83380400001)(86362001)(8936002)(66946007)(8676002)(76116006)(186003)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ulSQykA1gz/hak8bR9aeWmkJCYochRtMbQs28tyhN92KOppbVxoSM0thr392?=
 =?us-ascii?Q?dVjWX4/9oEVsC2DCYIoJeHR5FO7H0b3Hp9yrJ3y5TtjEVEVZ/3cwXEYgwEGm?=
 =?us-ascii?Q?6ua6JmhlTdKvro71z9aRhiCzWUmIVteeO9lYfH8pp+3em2XGwpUtdkC9tCT8?=
 =?us-ascii?Q?UkAcgmr5EJmjEP6R669U19LeoYa3FDUN/E+VuxT7jCamNpd5bmu5qjkwJh0N?=
 =?us-ascii?Q?VUxvEqjlsqH2fsvGoqu9nbZOxfD7SI7tCMb8OFnB6oyhqVwRkpLcLzkOacr7?=
 =?us-ascii?Q?RzVpTsscYUXpaox6Us0lcF4zCx/F8dPoQRrs1g/WloWLQlZsvWZy/HYGefjG?=
 =?us-ascii?Q?wihwVGuQkmSjHyR5H79WaR08xA7Xo6k8Mc1JzTmVsw/+o4pzxocwAcZtNAlb?=
 =?us-ascii?Q?g/aV8LTmyu71fUQDavC+mfTvrTsY7yBmg8MRLIVRDUtGL3UwxExjY14pjU16?=
 =?us-ascii?Q?zMr0zInFdGiwU/AVl1JZxtmnHDrsY9WcBNulO5iJbi5V+WoNV/eudhLhWqEy?=
 =?us-ascii?Q?0drcOVjkwmrqVgCS6KLH8k2jhvaEHEM+bIJR0WpF32PZQs5kzLfnROyrnOeT?=
 =?us-ascii?Q?NHPRcGufVfpUqvcsIig9C7LHWg5YV23XxUXHuWfkmVYggp4fD/xYCP8itLx4?=
 =?us-ascii?Q?hwdlGLSKatbyTsUykn31iwODGduOX24+2wUD7iXnazEuDrYbHkiwYST240of?=
 =?us-ascii?Q?qOdcU45Q/rPK5fNyERL+igMibYTA549mkFqOKDWEOCFKvv3otzIYgepvwgfh?=
 =?us-ascii?Q?Uz8SIxVl5vhOKzBhN83wYOkt+sXA9Usq55ZgrXAT/+/FjyaRGrVG3+pkMMCB?=
 =?us-ascii?Q?0U05Cw8wog+MAjdyC91tbGXIeU4F3kayfwVV8YKBxk1OSh48Je+zuRxBUtbH?=
 =?us-ascii?Q?XO1hVTHKwhMqMRxVfPANWEX7ankM+wwSaXQwfe3YJuRvHInKF5GbMm9JrLsn?=
 =?us-ascii?Q?IOGdKOmFgZLFZC8CjEbhvI2SQ+yAVe8+wrAiuiEe8l457ZfJrNk/cn0W2Jmp?=
 =?us-ascii?Q?8RwCDJCruvIfrI5b3ndtKdzFja/1Q4+ZTmiQ8igM0rPaO2zE9iM7v2txKPgS?=
 =?us-ascii?Q?C8aoX9Ija7HRH2146d2dv2QmXHXfwFEnjUQ6V13wLE00mRczaE6McW69sP37?=
 =?us-ascii?Q?9DCvSoj1XMYAFawUubjHJJzc4zE06LpxDikJbGAImslww1XWyjf03YOK2cw8?=
 =?us-ascii?Q?dgfakvAiakAwBxGd5zeSdUjYgpxAuxYObnzcZPqb6TCXF8LqzpHrNMG38qLG?=
 =?us-ascii?Q?vrAFvw3I7a/C6R41OQoxvpwDRmmCtsdys9HsR4dow2u4P4bOZ+3tPF4p96bb?=
 =?us-ascii?Q?0Jwut6YFmZ2J1BTMMlROiYFm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41dfef6f-35cf-44fe-db7d-08d8ecd390e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2021 01:41:08.4001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BoC26ePu6zJltwgczgsqR//sFmMkmMg+jqPTOeXTJyJpzK+4ERFfX44ERr0qh9tIrhBjwWw4kmzLwI56GAIS6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5468
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH 1/1] firmware: imx: scu-pd: add missed ADC1 pd
>=20
> ADC1 is not defined in pd driver on 8QM.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  drivers/firmware/imx/scu-pd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/firmware/imx/scu-pd.c b/drivers/firmware/imx/scu-pd.=
c
> index 338800d16c653..966de5e5fc44a 100644
> --- a/drivers/firmware/imx/scu-pd.c
> +++ b/drivers/firmware/imx/scu-pd.c
> @@ -136,7 +136,7 @@ static const struct imx_sc_pd_range
> imx8qxp_scu_pd_ranges[] =3D {
>  	{ "can", IMX_SC_R_CAN_0, 3, true, 0 },
>  	{ "ftm", IMX_SC_R_FTM_0, 2, true, 0 },
>  	{ "lpi2c", IMX_SC_R_I2C_0, 4, true, 0 },
> -	{ "adc", IMX_SC_R_ADC_0, 1, true, 0 },
> +	{ "adc", IMX_SC_R_ADC_0, 2, true, 0 },
>  	{ "lcd", IMX_SC_R_LCD_0, 1, true, 0 },
>  	{ "lcd0-pwm", IMX_SC_R_LCD_0_PWM_0, 1, true, 0 },
>  	{ "lpuart", IMX_SC_R_UART_0, 4, true, 0 },
> --

Reviewed-by: Peng Fan <peng.fan@nxp.com>
