Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E28843ACFA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 09:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbhJZHRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 03:17:11 -0400
Received: from mail-eopbgr1410115.outbound.protection.outlook.com ([40.107.141.115]:13536
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230286AbhJZHRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 03:17:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=laoWVw8XVUqiQUhQcPaX7Q/XximFISvdEW5leEtmG0DPjBhief5+/Gu/TqeEtTS1Pp8HcR1+QTQCopxMf6JCo8wOex1gFCphLZxtgNn2yOimULXd4CEcQSE4CjrRqDThKWnsbrHRxuMBF9bs0wO2uiiNvvmb25NOWps9LASoT3bDMe4I1++EFJmcI6a6HFQkrRVS3wrBI0er3oEJdsjkeDJTvKlSeEAVIYH0lhjTjkZ0DZCAa25ltoi3pz76NMcEOYm2o47aEB2ms8JFdeHeaskJoBQFiGoxGSqhGBw471ENn/MWktqbSogSW2l5XScZlv5z8Li/bhLO+5sR0xSzcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9a2aVUKjJ3GO4a1tXU6U6Ega/zOYq03J8U5QoQg1ap0=;
 b=LCLzFWc4mcJct0omERZ6tCWN8y+UUY1PcY3zTIv0y6GvWQZyYRVuZdvrY+pM035br3dV/8iC7uZEvziD+2Mj9ghQd3L0a+YheE6LE70BxpOcKT4pGO5q2qDUKb+VcPDi6eBLvOQUebVgqArOrXAiu1n42cs25ljNwATCywBstgtIwKuYd3IVD4CGzzXZgH7Q2mZKO9LS65naxX5k2pJ5Ka2JIfWNp1nH3+/WXIspX3mC+NtCxji2mBB/2mjHIyWi1Q7RbeMMjebcMdTlxPCjS3l3PaWGQOc0n3swZB9dyRh8ZNTC3N3BSrzKp97NiatTQ8Wl9T89JBRqfw548bCVew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=connect.ust.hk; dmarc=pass action=none
 header.from=connect.ust.hk; dkim=pass header.d=connect.ust.hk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connect.ust.hk;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9a2aVUKjJ3GO4a1tXU6U6Ega/zOYq03J8U5QoQg1ap0=;
 b=APb32cO7SGh7hQ8sGtA/kqYQ/PqtlDipowHvJ5FgJSdTSSed7LORonp12pQBtH2bOq40qOpc+MfZg2M99GkLIUGASUtM6Tx/hZHwd4lk0IHRlAQGQqLCS73qylVyWUrr0FeakFOKdEKeV6dRRSdw0+PTz6LFWjSjD+OcQvReh1M=
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:b7::8) by
 TYBP286MB0078.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8020::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Tue, 26 Oct
 2021 07:14:44 +0000
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04]) by TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04%7]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 07:14:43 +0000
From:   YE Chengfeng <cyeaa@connect.ust.hk>
To:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: drivers/clk/mediatek: suspected missing null check for return pointer
 of mtk_alloc_clk_data
Thread-Topic: drivers/clk/mediatek: suspected missing null check for return
 pointer of mtk_alloc_clk_data
Thread-Index: AdfKOSM6J+UdszEsTw24M+/V25HD0Q==
Date:   Tue, 26 Oct 2021 07:14:43 +0000
Message-ID: <TYCP286MB118864E74927A579396451588A849@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=none action=none
 header.from=connect.ust.hk;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff3d5cd6-ea6f-4e86-63db-08d998504909
x-ms-traffictypediagnostic: TYBP286MB0078:
x-microsoft-antispam-prvs: <TYBP286MB007871E5224844A0B516E3918A849@TYBP286MB0078.JPNP286.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SMAwlpYV83C+wqR4MRH4r+9DgzD4kXQ+d5IFwUwsOeA2NAoeX2ekGvyrxhliemWAaFeIRLP0EP6W2P7jwrzlGF/wry2V2VqiJIZVsfn2XD0aEZBKrXAov0WVX9lGzRAru3v1EoS0OU1Py0x8uUXpX0kYdBigkIXijr+UxHyQMivNcxzUjVoGSoUc7yRKwfSFVBLTEgU25/amSBCLuV5I/Hp9i5CYRbpZ/SEUNTwmEHuDyycArN+ubYy6phcxRl44K15RM9T5LSknSAS1MsakSY3XosMJLa3vJYj7bfBvvLhQO8/Nzabj2I6wug5oh/rOw7urXjRIibB0bIKS0bbRtmlpSOm8cUJ31vGNiuVxuWM2LxCe4XhXsN1IrOGSSWoTm7oDr1ZVt9dMgW0KXbncgGvrZ0gsukPMemjgxVGdfXiWRBkvuHf1mUY1panIvPPHX0cOSAq3hLiXRQLoOU5vV2r+Kb+/vM2GMVtn32zdvm2SBGfC+8WX2zldXSZVcI8iYVA3RCxi45frZ2t0l/7x+37wxCnv5u3Kmu/ua97V1DIbhtOhNsdAWlzm+mMbjDZyNUjwmLVsA8uUbLbP1WGtSUYY9fRale32SEcyVWp79mb6dIGgd8BDCYZ9Z/hwiU2hqrMObkiH0kiKSX0T9najLWa+A5pDx5NMaOxtwD0jqRLTOgk79aFyahwaMeVDsncMistk4/HKIANEbZk8NNKbf2lGeQB1WAzGQiUW1uZTFcVhOsT6Y1vEqTME9PdjIe8f/b2FmmxBMl84rdLnkU7R5qUNtCiCKXvSujFoFVlhdE4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(66556008)(6506007)(71200400001)(66446008)(26005)(33656002)(186003)(966005)(66476007)(2906002)(76116006)(64756008)(4744005)(38070700005)(4326008)(8676002)(110136005)(122000001)(66946007)(316002)(786003)(55016002)(38100700002)(5660300002)(8936002)(508600001)(9686003)(52536014)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OzWzr/t5XVA5E186atUAV3SIN4OXKfCnQAjNP7IlJnF42q/bYMGr+kmuOcBa?=
 =?us-ascii?Q?rIe323mnHqPIJbqWCq1A1JUK4mpl7Sxa6BhAIxqDBXKO36fa7Tw2WBg+4kLR?=
 =?us-ascii?Q?YFCdl+L53Ajh9CnUX8HVm8doHysEaI1IjCzMpG3tAUPkxt3qKVv8hgAyR0oi?=
 =?us-ascii?Q?Kwjb/DMqVfQ9g1WaV290MDAoWHZ1+wAb5MMh29bkGaneNo9STKyU34/29o6F?=
 =?us-ascii?Q?16yf/PtQNBsaqdVE2Ch/1077u3XO8Y8G+Kd/KdaytQObwK5xYKXmP1DOib2g?=
 =?us-ascii?Q?jLsUvG8H8O7bL1Y3Ynn/sn0REFDuKh+Ath9u223AayXrmCmmxKt6/VuHiLhp?=
 =?us-ascii?Q?0/r6lUSxQEVVuf1N4YGx/BfrcUJCt28rsQhAg78l+yzKCKfDi5wsOHnbtx8P?=
 =?us-ascii?Q?YOiHH0hH39Kh8iIY2zRETV2D2vONT6nsRHx5Og/NGiR1TcOVAkcNtX+1W/E9?=
 =?us-ascii?Q?YzM1KiyFW+2nEpy1GXyVYRAJiP7Cfj3mrZVzT8pvJEFRU7V0yq39nsufLHjc?=
 =?us-ascii?Q?9JWSWq+pVXSZBNuROs8Uem0sGXO4uE6Zw+9JIxVeYbnXY0g3Kc/zvJEaZTzK?=
 =?us-ascii?Q?n5PcpKPFybCBun7w4hqK0fBM8P9F+kqfYnR7tsmCPNv80mxcoMTqNtEL94iN?=
 =?us-ascii?Q?U/X9S7Ei8a2/DlRhMVVovFGxI61rlUYjEvhVo6u0i2xj76FlasbpIXeXAdWQ?=
 =?us-ascii?Q?YicP5HZG0ckxwn5nMqx9VYYcMyLK8cXzynJgb1SO6o05Fqw6XOEeYxNm202X?=
 =?us-ascii?Q?FMTAt8f5S7CMbr4o+7xiP90A5xXOkyIQOg7MKR+JcOv/7hpuMfjrtTcREKtM?=
 =?us-ascii?Q?NOyWrDcedB6JR62GI+s0APIWeGWWRMe33LUEeLNypVdFg0TtRgEHcAUdK6XR?=
 =?us-ascii?Q?c/03gHjfdp2JXHvXOfiekOJVrYLFBU5i+FuxoXj++GAStt+v0bIg9P53pUZm?=
 =?us-ascii?Q?Gt/vJQE0GSZEHgkc03nCquxemjxXVF6FLhZvUYAJh/Mwzs+gqbUIO6LdPtBb?=
 =?us-ascii?Q?kau7dx4lMtw4ddzx2j+6AYM8FJZbibj50W5IE/ApSwb0z9cQ2VYX/FIQMltr?=
 =?us-ascii?Q?iGH2raBGuCU1ItrxwBhjWx+15rzQxTjzOPKxQ/E3hUjSvWZxeT3760229Sr2?=
 =?us-ascii?Q?J2ZaLvj+yIAmphOmRBGsePMOq6z62clD73Z0WofDtZhiPLypv0I1v4OR/wZM?=
 =?us-ascii?Q?u8pIgcxGRVg3nHjq6EeQ0TJqLj15AM28KLZq6kzqOfDmQbGx5elV3/c8DpzS?=
 =?us-ascii?Q?zCEriIWh+DuFX6mA02CgcNihQ66cdc5TEoSDwb6hHJrvIhPN1meW1aOybosh?=
 =?us-ascii?Q?pC+e1sfmtJdbV+ZI7t8EsiyygcnHMw0NoQZ91FrA0Y/ElRaxMAG8uPqCGNeC?=
 =?us-ascii?Q?NUupKOEkgbCGfIC7XIBsyX/9A9qI+zjuhcYAjSosX7ZAG+EFSb4nFMnAysHs?=
 =?us-ascii?Q?DVzVi5OvJ3QtQ46THoO9WROGtOzdvd+UOAVeQLKaJU99FXdmACIyfMG3hi46?=
 =?us-ascii?Q?qu1rY8loLIciVtqWFxDweEfHCvhIKzEL9e1FB9Hf1Eg0bCDpVIE3ytNzU63L?=
 =?us-ascii?Q?D/J0azsjrkdBWB+j3vecJ8+nJdZO5ClkmjOGFq9mTPfeuGb/EaudIiAs1WwS?=
 =?us-ascii?Q?iZs1/1jciiWJjR3Ifb+yGJo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: connect.ust.hk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ff3d5cd6-ea6f-4e86-63db-08d998504909
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2021 07:14:43.7045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6c1d4152-39d0-44ca-88d9-b8d6ddca0708
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iWJzQ/3j3GNnnAxcJMRd1Yw5EdGTgdiRjYirVNDsg2HJeoyG9fd7cu9JWUJ1riPIIdGpHITETdQOZUifnA1G4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBP286MB0078
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

https://github.com/torvalds/linux/blob/master/drivers/clk/mediatek/clk-mt76=
22.c#L622

The return pointer of mtk_alloc_clk_data could be null, but null check is m=
issing. It seems like there could be a potential null-pointer dereference p=
roblem at #line 639 and so on. Would you like to spare some time to have a =
look at it?

Thanks so much,
Chengfeng
