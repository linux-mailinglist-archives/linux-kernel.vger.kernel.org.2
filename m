Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED3923AFA6B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 03:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhFVBGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 21:06:20 -0400
Received: from mail-eopbgr00053.outbound.protection.outlook.com ([40.107.0.53]:3463
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229663AbhFVBGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 21:06:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2fKENCBqUxhfYZTK4oQkMH2EP74+uWiBgMmHgBkoJFqHhWgriHbOeGlFCUhLLhnx6BtEFhbzNJsqQaE0hmtrgKD9O5r2w22g3pfcJmE9LiymwtJw2HE4qZ1kC0G1lkfWJJnisza1TPLsBBu3tloua27F7Zay5XyslG7X0k/0z34MlCLKDVhtO6VmUelBc6aGAOCijjezxu9GdI0OjgWhVTje8tXFCHJ7bZwPCe8wHqsu4s2L7XZzFTC+KeHD8rxUE81SYK6aqmkYsugpdFWGd/7haykYQuOoVSIZZRzYNynGTpihXVGm+0joS0QGn8JaR9P+ETEZNWC3XqC9ccvWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2fuJ9wzdV5Nf0kCDqSVA95GS/u69Ur3+/1MqIbkQKM=;
 b=Iq61/MDv06izK5Y3J4Kdhujf8qwI4wFpueosvFEMeYL7HE/admcu6PPpWRgQAHJHmuWGwvA5wlDdKRpVF231C/puUtLfrgYD47OQ9eD7khvkqsmV8xVmZiod9gqT+45ATJAlfFZhB+Qed5w/GTRoipSTG3MV3UhPvY+betDZRKEj7J6SJeO/N/fRdYuJDAai4osfvPeUTnuvXI78G0JnMMgfZjEG6Il3lX3DAK961flmvbvOygYqYCQxpWg2wG7FXGz2EMsmJve3A81fOKG7yqU5rqUmIG2Zga65rZcqSoOijQreIkgmw/7wnCajZplkcrGt4NqFGO4K3AUkD0AtKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2fuJ9wzdV5Nf0kCDqSVA95GS/u69Ur3+/1MqIbkQKM=;
 b=diqSzrQZPgyO5QhScbX6sZIePG7zNCkb9WvyyPZjHIwNNHs3LTbjR91K/9WEIfQm3ADzpUkwX2GTgUYqNtwe+LOSs7pj4Kojf0Gsk1okuB5TLLwUfP6JNaI2oFp8CCLnOdClklJwplzCd3aVTPZ4OI7C3syFqAGE2WahotCij7g=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (10.172.251.142) by
 DB6PR04MB3125.eurprd04.prod.outlook.com (10.170.216.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.23; Tue, 22 Jun 2021 01:04:01 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c445:d742:eb76:86dd]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c445:d742:eb76:86dd%9]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 01:04:01 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2 0/4] mailbox: imx: add i.MX8ULP MU support
Thread-Topic: [PATCH V2 0/4] mailbox: imx: add i.MX8ULP MU support
Thread-Index: AQHXU6R6K6QSx37q5k+p0a7yiEn/XqsfXa6Q
Date:   Tue, 22 Jun 2021 01:04:00 +0000
Message-ID: <DB6PR0402MB27600C3D228997E89D1DFA2688099@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <20210528100603.21759-1-peng.fan@oss.nxp.com>
In-Reply-To: <20210528100603.21759-1-peng.fan@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oss.nxp.com; dkim=none (message not signed)
 header.d=none;oss.nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac75cda3-d080-47dc-f1cc-08d935199f3e
x-ms-traffictypediagnostic: DB6PR04MB3125:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR04MB31252F38A4A61380FB6EADD288099@DB6PR04MB3125.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5b6J+TxAV8H6vSlW9yTOMdcudtRg7SnKc7PhO9p8LgEPhCQiXx27EHtFzTHDecbUGZE5a32aEIkYPCfDBzw6mrYMmr2vglPyunpWHfRH+G0Iivf2hzYSlfJSelB7Osn9bNZAvAY011OQ4LmWOawwTT9+aQrym4dwmdh/sohBeGFy/XrJ0nnbHGuywb559A+5bA1TqilgrJI5nN8HVCjkXNliCqT+DuRk/qCyxGoV+3yJ4gbzOPBH3JEsHagRh7sN4afCFoFrZmIetlPkJV073hB1QY/z4qY3bT4yAqP7xJtQVqRgWsZVLFzRXJGR94l1fTI4DUfRKbbgQfToaAe825pdNyQpWv0h/FprnuMktn0CDd3DPRK7oPxwRBaKzTuShvFY1jw9M2LdcNJw55JmzUBr3u5R6OeuHGvS6mxYItEIz4BimpAuYFIrIgjgCeT7m5dvi/c7wxE767WcgPVx4R/yxs7cP3uOJPu72OceDnr4aFRPNa8sKBrqiXfpVkTEh0S/ByV1JI5Ce1fjNcDvBBHNjkmKbqe83NAcG6/qGm9ePOeKWdG0NQR26lsZG3NytaHTP3fLqiHB/+DXphMoEvq0fkb6siqyeA6b9IOtK+E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(346002)(366004)(136003)(15650500001)(55016002)(9686003)(66446008)(64756008)(66556008)(66946007)(122000001)(66476007)(4326008)(38100700002)(44832011)(83380400001)(76116006)(5660300002)(478600001)(4744005)(54906003)(110136005)(186003)(26005)(316002)(86362001)(52536014)(7696005)(2906002)(7416002)(71200400001)(8936002)(33656002)(8676002)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qhtYlKm1ZmU1FicaqNYv4j+HZPkRdSGa9Rvqf1hNqvJ6zOQ1pciUAtehmDTw?=
 =?us-ascii?Q?Ik+xLP5X+ijcPDFqxGGcvMxAufsIVRR2N12M0WaxxgrTpMvS+IOAYhE99Y1+?=
 =?us-ascii?Q?+GzMKk8qnSycdez7QAfPHuVMSlopt+Y6baGzkb2JbiWvDcAv3idte0zZMzCd?=
 =?us-ascii?Q?TM1zTqDgTCnOmTktAymLcalvI6sEbxvbW58q7H6mQx5AZ3Aws74Pyo5EPIi4?=
 =?us-ascii?Q?M66hTeWl7731ta08mPTg/XCFgDrf31p1GzxfbNFH4e12114YesEFNq4p32du?=
 =?us-ascii?Q?/fHWbu7I2XmdVTOn0a0TK6XPHAkTXRmamlNCmnG8Bdh3oDgwuaHj68nKT7yh?=
 =?us-ascii?Q?fYl9XuJK1MvVynzc32tl3nF15mU8t+g3qleNyeu4W94QmeH/tmelIAUVJfq0?=
 =?us-ascii?Q?RDjpift746Iot1Qg1HAGOOMCpTvKZBlSYdg2OUngo+87qgEx4FPJH+EOmwLC?=
 =?us-ascii?Q?kDhwzy74g/oYyT8ctXlZXyk0wUBc/+bSIDWVivr6t+jpqo3ORD3BfaW2zAKw?=
 =?us-ascii?Q?GrKD7Xv3j0WP1frPBjQA2k5ejs28g01z3zPvt+JAxSFQYJk+BYiAzzTenThh?=
 =?us-ascii?Q?EgCrp9FAKxSDa5D+vzpXZsyWsWQa2TkDpWPFzmEmULfJqr9DsC21QNQu5K8J?=
 =?us-ascii?Q?Pj2INrii57YSq21iNyauU3g4taSel52XuKLYB0f3hi2Zk9/bjlQ+0oD0G1sV?=
 =?us-ascii?Q?U2TPO3utXkFttOGR6ciqwstWIIBBpbuQV8/FIMB7rnMJmvV0dvkjn+y4J7bA?=
 =?us-ascii?Q?/E23sZcZfhCjzXGnI8+Cb35FjZdFsjk16w9K53jmnBgU17ZApCIP0Y8f82z+?=
 =?us-ascii?Q?QZ7OGw2+gEWJGOQ5CKSQdzhMM70S5EaJ2ZeMcaQpxQ7Sy8SbolsQCknu08J0?=
 =?us-ascii?Q?BtQgeqEVKTETfLiuklJBYOgAgOgkBaF/k5Bw+bcv4FPDSqnI7omX+pLERO4Q?=
 =?us-ascii?Q?dwQsGbYHRfyy4Euo6RsZLCGrwQXRiy21k3867pTH/AJYmq6YMHRY9fxRq4H9?=
 =?us-ascii?Q?4WPDo7ZYtZSyWho1PxiIt74R50pOi8PrXO0h7xVJFKASHNi2bhGtLuAOeY5G?=
 =?us-ascii?Q?xwZ0pnQoCByIsuhhkhSQJJergR9/jvzrKHQj9huw1F4UxkjG7/8eHbLJB4wl?=
 =?us-ascii?Q?witoMo9rY1G3mgsyedB+26/6crmSFoideQxeAJnyXBJIZCrbIBATreTVerqv?=
 =?us-ascii?Q?C9goAcKR3/ZFlV3HRrKK5VJecPfbk3f7iCIyv1ZTXK6upKlbSfMqYkUzAKWk?=
 =?us-ascii?Q?huQOkRRdC3omvcRG3WkwnYaLe7+3jYwO93pe/Cs1ArJ7yVB7nnGgo2/VMQX3?=
 =?us-ascii?Q?HthunCd1EhJ41SGajP9M/BlZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac75cda3-d080-47dc-f1cc-08d935199f3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2021 01:04:01.0633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C9uJYgqt78M/vkAzs2AWwcc5c2/gJLs8UoW+06GDZcLmUnTd+mqEDh/U/MRJppdM8HaN1i1o7x+ajh6EAjzGLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3125
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH V2 0/4] mailbox: imx: add i.MX8ULP MU support

Gentle ping..

Thanks,
Peng.

>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> V2:
>  Add A-b from Rob in patch 1
>  Fix RXDB for i.MX8ULP in patch 4
>=20
> i.MX8ULP generic MU is a different IP compared with previous i.MX chips.
> It has different register layout and bit position, but the register name =
and bit
> definitions are almost same with previous i.MX MU.
>=20
> So we extend the current imx-mailbox driver to support i.MX8ULP.
>=20
> Peng Fan (4):
>   dt-bindings: mailbox: imx-mu: add i.MX8ULP MU support
>   mailbox: imx: replace the xTR/xRR array with single register
>   mailbox: imx: add xSR/xCR register array
>   mailbox: imx-mailbox: support i.MX8ULP MU
>=20
>  .../devicetree/bindings/mailbox/fsl,mu.yaml   |   1 +
>  drivers/mailbox/imx-mailbox.c                 | 196
> +++++++++++-------
>  2 files changed, 123 insertions(+), 74 deletions(-)
>=20
> --
> 2.30.0

