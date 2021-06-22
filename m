Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5CBE3AFA70
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 03:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbhFVBJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 21:09:32 -0400
Received: from mail-eopbgr10064.outbound.protection.outlook.com ([40.107.1.64]:62791
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229663AbhFVBJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 21:09:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QdWS7ebPZY4DHWljH+29R1uBZomSlJplq3ZiMKspRp+65K8H0FpPzylOHaP7JqqV69MKGo8f5AOGEKA29IeW5z229SwFlypTAxoT0s1SuXa5Qpb/gdhrkmCRzJ4tTAXIwY/nuU9448e3AOWkHfBL4Z3YTdj+i9Eh8nLmPKxIl3ACnZRiKLSpeGCbVpWjTjH0bMV/LF674CaGuXkRChq96LY18Z7BuXNVSWshWS1zlb0Dyh8BB+ak6VP5gRxpxoMhK6MPrbNupFSs2aTcmY5on2vONSI7eDJzeNPC6ie0fNXVCZJRsSf+Xxg77rw5NrBR/8NBfba4BXNh1Dt0ZD/1ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4AWF4yxwZ83hqIGM+km4qPGvLBq49+KJhMAEg8g9Jg=;
 b=hUesmh8hoVKzxJR2gONUM6jXmV5afeD44SRNEDEanACrC8CZAZy9c6DPlMqKZSDlOQ3YexPxAE4X1NduyYmdQk/3+IkWMzZwot0doc7CbrVRJ6widT5UrKApdgXwH/0ZCKQTjaeKZ5ILpnKsAJyrNTm3DSnF1YM0IzvXJXM2+EmyATGOxRH5rqUaeJ7ITt3a1CH0QP98pr5aSMzTkNh542/kpZ8dYpwr2R7iCCx/lPA0+D9rxI/YEGSIshWI1WaYcJjDLX/CnsciAY12MlfurH3yTxArHbnsJIM53lt2d3WwHeNv+PM0QYYTmuKdHWH1lvJSLZMtEdarKknQ9e/qbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4AWF4yxwZ83hqIGM+km4qPGvLBq49+KJhMAEg8g9Jg=;
 b=UVNpqPwWaQDJOhdAqfVkZU32qbxu/w7sIVQ7F+iAQ97AxR4VadZGn6uEVH/W7H0Tqq7Pz2znum2TrTJjl17DbHFrWN7KpYnA6gJcEfO+zrGD6w7Qy6wvac/bbs4dCrn7yNB4/6m0mSx6I3kCMpnuq2HNAgSMChetFVY8ZxLxgdc=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (10.172.251.142) by
 DB6PR04MB3125.eurprd04.prod.outlook.com (10.170.216.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.23; Tue, 22 Jun 2021 01:07:12 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c445:d742:eb76:86dd]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c445:d742:eb76:86dd%9]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 01:07:12 +0000
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
Thread-Index: AQHXU6R6K6QSx37q5k+p0a7yiEn/XqsfXa6QgAAAxIA=
Date:   Tue, 22 Jun 2021 01:07:12 +0000
Message-ID: <DB6PR0402MB2760CAFF4025B9E4A69CC1B088099@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <20210528100603.21759-1-peng.fan@oss.nxp.com>
 <DB6PR0402MB27600C3D228997E89D1DFA2688099@DB6PR0402MB2760.eurprd04.prod.outlook.com>
In-Reply-To: <DB6PR0402MB27600C3D228997E89D1DFA2688099@DB6PR0402MB2760.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oss.nxp.com; dkim=none (message not signed)
 header.d=none;oss.nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 39216d5c-8568-4434-e590-08d9351a117f
x-ms-traffictypediagnostic: DB6PR04MB3125:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR04MB3125BE5BFCCCE2EB19AAB48088099@DB6PR04MB3125.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3qeKsTCKEOAgZu1aNHSqWqzP/xV8pf1ko8Gaw4AlrevknMPO4QArykhGceGgdAvDFkGMaSZfYm6pwzygYawlWj7ha//JjBKZKqtQoBkw6Cwkhh/9ZluQWDQ6WrxKErd9geK6ssW3xucUoVGV49ghF7Vbr3LoDeMuYQp1xH9pSL8UqgI/eGP5WKPdqDiYZI0DyKKc6gCfyc7vpLMx7faTf3XM/OIPpgz/dOHMskc2LtnDl+UioLGPrH5cWf7U94xn+cZYoHHtMBmjmk0O3BTVVpUGywKVTtC2BVYJIEItoE/5sJ2LftJsTOKiD0T3WVtV6eVf9TPvVXLt1h7MMvMnZlPcuburLnfqa0WeS7LxJyEGwUhNJ3d136jYWbEkVqct4QEgO540H7CpNi+5rfhVAPaEabl69SKGyy7IuPiGvdeUxBPREPsCMzbfcC4uaeLaQBnOqQtlQ2IL0fsEoooOR9HEvc55/0mZtFdqTmfSV4xrRSmmFR+1vKIkU59yaJX2kKK8l8Y/RvTU1S1LQfP9XU2sLDVcVIheMR7eGQmTCBFTPrKWtSihZmW6hqugQ8jotr+SHZHBaSeG5hwYGq2YKQNZgiq6Gr0Bpz48MmsdiSg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(376002)(39860400002)(396003)(316002)(26005)(186003)(54906003)(110136005)(86362001)(478600001)(5660300002)(33656002)(7416002)(71200400001)(8936002)(6506007)(8676002)(7696005)(2906002)(2940100002)(52536014)(38100700002)(4326008)(55016002)(9686003)(15650500001)(66446008)(122000001)(66476007)(64756008)(66556008)(66946007)(76116006)(83380400001)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Y+Q07rtDhS9P8ljVX+/RNcCKL20b+yQved3JAqCAx+lIru1see4g2Pm16OhH?=
 =?us-ascii?Q?2IWrktctEbRNJjC7HUumENweVTiDj9owlaq4VACGWhd5idbmZzBTJa8+mxbo?=
 =?us-ascii?Q?sDcIk/nKBavXX+x/hGdmqx/NGEsEfjxWMwwcFIYEjha7Br2xNm/vYz0AX5Pv?=
 =?us-ascii?Q?eCj/UrZSTAAVr84vuNfPIg4KeW739lX3gSkISb9U6juv0zSmAZNwwtT/4PAl?=
 =?us-ascii?Q?wX75xM1REia/VxlN3tLOPxv5AMnxXb0GC9mHT2cfsl+jJqBwgTLdxnTfeOFU?=
 =?us-ascii?Q?dRhBdGTWyKiJKnldPDj+I3tujQvR8xtOcED90cnDestSeldtn3+iNlNsUbYP?=
 =?us-ascii?Q?KhGIGem4E9jgln3b33fb9Br4JkNlZCnLTnbO3dblJohoY+ZdcGgAga14ZVs/?=
 =?us-ascii?Q?JuyU/TaZVKojBnB9Cowoj55ToUbDabKFLGI+93jv06oZztwn4XjQWyNmzATJ?=
 =?us-ascii?Q?mcGwUbJ7ZQjQl5s9iMwKKDNdlx2SNuSWLL5V9gkDTxbUhnYvyMNMoVVlie5O?=
 =?us-ascii?Q?kzFb1TmBlZaoys5dWD2Qw1FhxaPzbAFJrf2+svk1GsxW5W0IYYzm7aMCXeRr?=
 =?us-ascii?Q?KELQQcEgOsxaXAIEOCCMLw+GFdAA2Pjvk0cjpUnom2bto5rEBEiLh3bFP87D?=
 =?us-ascii?Q?DAnEaZ2DiV6akMJXLm04DmgCK657boc3LsLE7DfZkFBDnnP8IRWclHgFhuGq?=
 =?us-ascii?Q?+sluNbFmSVl0qLFYKh+RzWWX/InqPXjRaJT8zC5H7+oqw2mPIIKMXvP0onCw?=
 =?us-ascii?Q?mITKkk6+zBIAdn5lf+76pkmk0Yq/jNTLTm87OSvKti0L4ZbB6PHqZSOc83hE?=
 =?us-ascii?Q?fFAGSN/M47vit4Eq5vPbGJHXqY1/Vf7odAD+3haVA/Kv5T+YdoMqlBZN+eWF?=
 =?us-ascii?Q?HnBUf2edVD0nGBvyfv66nvO2z663mvQuzpZZ/WG/iRYfJX6XmyxI3H33B8wt?=
 =?us-ascii?Q?U3r30Iqlw19iNCdxwt33zFycRwKZCOC322dqxvYvIHODA5FnPKfmnFPz+qjO?=
 =?us-ascii?Q?oqCIHciLMM0tPk8zgX9GZ7Mdvi+UMG0YDelCbP+b3N/HS7W0E3s01/MrqaIn?=
 =?us-ascii?Q?17+PQQXA6ugAOvgfIee0v58azWVSpRvI5XRBkmsG/NUlIt47KY/kA9jNBxxQ?=
 =?us-ascii?Q?453+6lgwGZiqqEVuS82KAgOmiZkD9Ke0i+PlHxrvsXCg6d8L2O8rY4L3I8xg?=
 =?us-ascii?Q?QKZ9Wi18ucKgsB23bW8qqkg7QVRErHyHV7nr4HDBZRWiDqAO7jdillox20WH?=
 =?us-ascii?Q?m2XEIFhoKdwtuoOai8xxBnefA5vEcctCbLAWbCBAnc4/c6QKlbRelK+Nnq4N?=
 =?us-ascii?Q?6wSWnuJI8ahxtbfd8qcmdKUK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39216d5c-8568-4434-e590-08d9351a117f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2021 01:07:12.8072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EY2MBZvv+C/pbZ771Y8Vva311GE5381U3nT/kC3clu2cH6rbqJoo67kre4z9O/DtSi6NRgcs9ZrDC2Ni84QUOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3125
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: RE: [PATCH V2 0/4] mailbox: imx: add i.MX8ULP MU support
>=20
> > Subject: [PATCH V2 0/4] mailbox: imx: add i.MX8ULP MU support
>=20
> Gentle ping..

Ignore, I see it in next branch.

Thanks,
Peng.

>=20
> Thanks,
> Peng.
>=20
> >
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > V2:
> >  Add A-b from Rob in patch 1
> >  Fix RXDB for i.MX8ULP in patch 4
> >
> > i.MX8ULP generic MU is a different IP compared with previous i.MX chips=
.
> > It has different register layout and bit position, but the register
> > name and bit definitions are almost same with previous i.MX MU.
> >
> > So we extend the current imx-mailbox driver to support i.MX8ULP.
> >
> > Peng Fan (4):
> >   dt-bindings: mailbox: imx-mu: add i.MX8ULP MU support
> >   mailbox: imx: replace the xTR/xRR array with single register
> >   mailbox: imx: add xSR/xCR register array
> >   mailbox: imx-mailbox: support i.MX8ULP MU
> >
> >  .../devicetree/bindings/mailbox/fsl,mu.yaml   |   1 +
> >  drivers/mailbox/imx-mailbox.c                 | 196
> > +++++++++++-------
> >  2 files changed, 123 insertions(+), 74 deletions(-)
> >
> > --
> > 2.30.0

