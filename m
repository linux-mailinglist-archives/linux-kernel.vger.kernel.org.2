Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 021D345D20D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 01:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346631AbhKYAcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 19:32:55 -0500
Received: from mail-eopbgr80085.outbound.protection.outlook.com ([40.107.8.85]:38658
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244652AbhKYAax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 19:30:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFu3oc/Sjx5d0ToQ3NmcZse6JAf7SA4byLJ+c88LW8d2F1qLwD9QeDuJR7lEgLQbM8lVnXQFLDOcjgvYtQVD5hlgffsvBQ3pbaEM7feMDAdekFWyQq82gMh5FLBKYSkK9Itb70pFGO24KJtU0QFnHSFw0j2wYhBedbEdOH+rsR18R9/hBVv7MkT+iKGstsQfwdAAotThzEehgbiR2Sf3jVGMe8gx66AtYCOorabBbfW+FmWX9YywLbalYbBYzCMeaAbFV5A5wfQ9M9ZCptWpAHakxR1Fc95dq836HE+Gp17Mu9kI2bXlFkwVNqTaC1edE91zmhxhwrsImttXxgaFYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lwkIZ2fbszSJtQYnJpM93Za2kRUUXxcnPuDlJsN96O4=;
 b=MZ45yr2AYl6dgJSrn3Nx6CW5ZPMORodpAY8oG8pZsUWlZjMxHA3Lhpacc2KFomRfXUaazo6c1Qqm3lSx6a6UQAl+LYNDDzgYmXT/6g4IfqWzQEqzCoIatb4jh+JWorS9/t75ydI4BCVbksQurfOdXBhQ1ZpxntQV0o+ebUyW8J1KxqaqoW1d/lKiouPrOc0u3yoyKfQ3UDKI6Hh5bzMYpeb2Cz5Nk/tM8PAfWVp7CuLvFgcRqQ96CAAztZ7mauNrTPj0YQykRicj2Y/Srd2hztqRWfgdg/xdT7s9q3JF1sqDm3I6Ed3preBp8nAkbBEAlDhjqjMyjk7UBeZZM2krPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwkIZ2fbszSJtQYnJpM93Za2kRUUXxcnPuDlJsN96O4=;
 b=i+GSl2ivNwds0NN23X9dN/3WL+zH7GW8VhutWqP2RblXB94dMAZPpT0SX4FPS6qrpQBh/zJbGLgAb5P9hb7bEpw4G+4UNCychHVgf6v4NDJ1TVFugbbwD4b2RHT5qapgzzopS8Y4TCsBW4QWhHGYlTjpiGRCMRCTB9EBwJlpCJc=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8478.eurprd04.prod.outlook.com (2603:10a6:10:2c4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Thu, 25 Nov
 2021 00:27:40 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43%9]) with mapi id 15.20.4713.027; Thu, 25 Nov 2021
 00:27:40 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] mailbox: imx: Fix an IS_ERR() vs NULL bug
Thread-Topic: [PATCH] mailbox: imx: Fix an IS_ERR() vs NULL bug
Thread-Index: AQHX4ULbPmzdSb+TpEijaM96T42qk6wTY+EA
Date:   Thu, 25 Nov 2021 00:27:40 +0000
Message-ID: <DU0PR04MB9417AC0DD29F7610DE794C0688629@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20211124145126.GC13656@kili>
In-Reply-To: <20211124145126.GC13656@kili>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d2778bdd-5c1d-41e5-2ce5-08d9afaa63eb
x-ms-traffictypediagnostic: DB9PR04MB8478:
x-microsoft-antispam-prvs: <DB9PR04MB84783F097D0183339F37F8E188629@DB9PR04MB8478.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:213;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DBsuDaPB/yhBHCbHxqXESGCPw0IhfcZevXA0T1zI1ihGlHKO3caDZ8NBEK2BJmtqB2VPdjhJRwVQjcJu91lQLXPWuFRQxcuEr/59IKEPbM1mGXFer8gz3b1wyR8zhgABql46fWoc9k189Z0POYixwbh4I9PZB4JzVEQH66m2NhZNO+pZ/AwXgZHo3Vzds3EekJB+M51c7J/363pPHFhkYgBx25jeE+CdSHqQ2yf4pxXRfs1K7+8RMTUkrr0cb83eM29bEYJCC2FZR7ynuhh3aPYJiChEUUpQ9Sqo6kgSTXznlCXSpjnPs1Y4CPLIQuy7fGHzzWefE2LX2rd5XFD9saNmkJjzyPbBlhSpQ0i26YJgcTp4hbYfEkKhZpDR9TbabM4UdBg7E732XpnJz9Q3e/ofn/1BYWiC04AH2cyEVTiUuKzWJUNMswnfEvrHavoRHGzCBsBd1PP8kxxqmwOqcJ4gz4zTnEc9zYaBQUcrfLJ9/LYDUIvnaMGKm2bMELDqVJ+4oUY14WlSUjeVchF2f3Veyok5fyDSw72MiIFfsMW7DdxVi7m4EG53D+iZnL4CWbfBVoHP0fuiiSUFFgmn8TYAewxxuOf2hvfwPn6EEo//WnZ/YaJSlUxI/ddmUqYq/u9Ob+3jt1/Y9YdLAgUTc8khvsq2ZkLTB24bvmixN3ZNLtapzkHjFSFrfuLqwqGl0lkyQHq4JSYiPH0DjwzTVA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(33656002)(86362001)(8936002)(52536014)(66946007)(44832011)(76116006)(8676002)(4326008)(66476007)(316002)(66446008)(110136005)(2906002)(38070700005)(7696005)(64756008)(66556008)(186003)(15650500001)(26005)(38100700002)(5660300002)(4744005)(508600001)(55016003)(71200400001)(122000001)(9686003)(6506007)(54906003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pdmUxXtdbgqjBFe2ywCrrtdSr693L+GB+LZWux0pAfDd6YRQQZPAZkW9iwxJ?=
 =?us-ascii?Q?+L4Cih6OLT83KcCxtEqx4jqPhD/tw4BEUxSuy+GGbbOyyfMG8qnzwzmXPtfQ?=
 =?us-ascii?Q?ds58pm2i34chpSXQcpDA0cPqr9A/yTHqizvRIdR8mAx/MLR4GHtUIg5qlQVH?=
 =?us-ascii?Q?vyoG+NznokyJc06qeZgROFpqefdhKXfGD8n+F0M5/lztqsqPqR24CCxqE7Gw?=
 =?us-ascii?Q?ZoQewNOxe4lfiffrxFdh9p3d6Wf3ZVlF/PzArJZA9h5xLphPuQFWWH6n8gSk?=
 =?us-ascii?Q?rb6c5aR3Amc7pdMJj5Esvq3pUfGyyYNnVD+iVifWVMbjNI3dsnPuYcFhie9q?=
 =?us-ascii?Q?oj8d7GWl2QFSeVVPXJD34ShG/dUsltzO2CVZZTNmEp4GSVfBJwLI/RvvpsKy?=
 =?us-ascii?Q?gTGekgA7zRCV+pVwyhak2pNWHPAPR8o4oiwFj3JGyhCIcx9YJfj8Tyr/0Sc3?=
 =?us-ascii?Q?a9t+ZrGDHPzXJbd9OdGYrfViqvQQjufbMKb06bn8Glv9JpxxMu44er9mugq/?=
 =?us-ascii?Q?N8j46/vHm4BBVqnXmENBKFgdhM3cMkTde5SnlcQEryXCA9lC1GP+sRagScVz?=
 =?us-ascii?Q?+/BVWjIpg/IaIu2LHe1pvjKzPmDAjdfsdU1eUrJJnX7f7Cz/Sk1I9EnTDUzk?=
 =?us-ascii?Q?zdAA/oZJ5nreu4Qj0vKhqr+IwdJUCLELbVVtT6PV5lsBfAYD1mxUQGTD8eN5?=
 =?us-ascii?Q?8ZLQWVMP1jV+J2VhIIe8iIEyeO0065YASwS9euQVebZnudc7Ve2FWhDgiOG/?=
 =?us-ascii?Q?ws+LLQ/2dV5NgGO7pwN7LLWeS+BJYU8EBPeu8VOsmn5iSTNIaEfgnoTSwXeJ?=
 =?us-ascii?Q?bsjnmVsMItaufI+0JprmvVGujH5PE6kb7JPyr1k0TlztsZIx9YdrHhP2GOWf?=
 =?us-ascii?Q?FHF24dLPG4GgDCd+YBGzl8xBT2zJ1ypnS2A6cuLu6SfsE4LNCbw5JdukRuzy?=
 =?us-ascii?Q?XtGIRb4NS107sx7CjK/7aQGYobjERVTSwWiCHgLghW6D38GZHI4Sl4oOnkfn?=
 =?us-ascii?Q?neDlFkrey8L8tPSZUmeqtOBhKiLl/JtjHUTRhuic6UqFzmWT9PDQ48j8hO4I?=
 =?us-ascii?Q?E6n4bpy2Q5Ta3pBb8sRsVPA3p2KpPtwG5ztyUrHok7/WMYbZT61ch8344TgV?=
 =?us-ascii?Q?891YEGYIIJKFdNSo2DaD7CWfjFqc9v5+hS8doYiskJlR1SXBkKkinI6C7d9H?=
 =?us-ascii?Q?E2xO/oDqMupYfaTL6lsxG1Hb+thlHbE0VYOciSwlNECC56h5OYRySM5BjX5i?=
 =?us-ascii?Q?SmJz4B/mzTtlyrlrcZ3F7lQ5xsnYo089h81wuX4pEG4Jdde6wNli6f0D6Zj+?=
 =?us-ascii?Q?h26o3zQFKX7jFlXTx7tQB6ZjtP/4v8mGuFV6eZcTrgphiDM/G3UDdfJpxa/w?=
 =?us-ascii?Q?YoA/BjdjZFkUMNb58pWgQHb2qU618RGcC6DKdmLdERMD0EsbiPto7xoJjscw?=
 =?us-ascii?Q?GdNV+U/QTNoLj1Pn9j5z+t4XuLWjgQeoVpFFwPvGfyWw/OWRjGxkeJj48v6d?=
 =?us-ascii?Q?triIRP2OV1cfgF9D+i5XxhGoA9LJw/F3znQyAc6FOzE/wjYx8gPpYN10E4mU?=
 =?us-ascii?Q?mrbC2kBpAuCleQXc+oqws2I1Hls1mIFb7+n5lHXOlBnSdKOffBebJw6Po9bP?=
 =?us-ascii?Q?h5bghkJUOcZoh5DGihHK2lk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2778bdd-5c1d-41e5-2ce5-08d9afaa63eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2021 00:27:40.4069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8/ryocoXeDMQTXy8is1DH6ku+CScONN3bXqIm4x04KBLSWFuL6OJbk+XbpPlENzme+r4q0mA0FAajMa7GR081w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8478
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH] mailbox: imx: Fix an IS_ERR() vs NULL bug
>=20
> The devm_kzalloc() function does not return error pointers, it returns NU=
LL on
> failure.
>=20
> Fixes: 97961f78e8bc ("mailbox: imx: support i.MX8ULP S4 MU")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

> ---
>  drivers/mailbox/imx-mailbox.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.=
c
> index ffe36a6bef9e..544de2db6453 100644
> --- a/drivers/mailbox/imx-mailbox.c
> +++ b/drivers/mailbox/imx-mailbox.c
> @@ -563,8 +563,8 @@ static int imx_mu_probe(struct platform_device
> *pdev)
>  		size =3D sizeof(struct imx_sc_rpc_msg_max);
>=20
>  	priv->msg =3D devm_kzalloc(dev, size, GFP_KERNEL);
> -	if (IS_ERR(priv->msg))
> -		return PTR_ERR(priv->msg);
> +	if (!priv->msg)
> +		return -ENOMEM;
>=20
>  	priv->clk =3D devm_clk_get(dev, NULL);
>  	if (IS_ERR(priv->clk)) {
> --
> 2.20.1

