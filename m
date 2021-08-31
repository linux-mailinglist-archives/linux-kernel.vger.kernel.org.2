Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E34383FC95C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 16:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234135AbhHaOIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 10:08:07 -0400
Received: from mail-eopbgr80070.outbound.protection.outlook.com ([40.107.8.70]:39589
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229926AbhHaOIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 10:08:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lqDgGkKmKo7PTHBwhMPhuCbKz3Zhdo2R+Vh0gZmlZsNjupo4k4cUKnCJzHzXRZhv741NJpcuswD1fFJLJurE4AZ86BoccgF3r58L9bhmvaGWejwPYSxotXh323whNJpdokxx4nOXDk2F/+O0c8SVDnyys8Y8woYkLJdoZemF39YLRp7bcGLxdXX3MgpBY8CGUlNbXA+3n5bRRNjMkHZyeXeyce70VJIVwtkEiFisl4t6NSf1vplt5s5RDVjEBhxZD3qdtEog18buzArasgrUpnLVa5uM19s6uHeIo+49AMr3iHmDSXFyKirDPWixV9wB1EiMeg91MNjOc5n9QUb9uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVDsv/IODvRR+CfR/KFIE7x9kVEUVxHtC1zzf0Mdlhw=;
 b=VicU/9c4E3WhrkY0rEOg+AzcFkl6EPjoWaHvu5B/uqQIJQGxeUSrHwwREuvz3R2WVM7Xuxi6GML9BAFHKIQ+5JS4zI1g0nnYrR3vKMta4p0+6OxdgWfk1lk282LCmK1iRmcfSDGdQxxNMnDurTHr+wlXRZfxRcIWATM7db92kptHS0oWr/fNttBdSNXsTjDOZ59xFtsZ8rROGLSIxlSvhjdqMwnrArd0/yuYHe11fnQ4HueRremPPN+kFX+TzacXff3t+VwYpUnE8ndMZA5ePjrcO4VseHvR0w8l83jrbP5xV37xLlJIFyPynuqX9hSUaKGCKVOJqnVrnw5Mkuq9sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVDsv/IODvRR+CfR/KFIE7x9kVEUVxHtC1zzf0Mdlhw=;
 b=V9eMa4ihZlQAiWk3N7lFmhSMi0knBjnOJbP8qFeHnH/s9sCxRG9wt181C9Pyxape4U4X5u67JUeRuRr30vHxN4S+dfZBUdc9R0CnI45cB5cVvNMqan86YVPuqHgixFZVJRhtkS4jb7mB8gnQTOg2Q7sdnA4OcIrH6TMOTOmqgtc=
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by VI1PR04MB4685.eurprd04.prod.outlook.com (2603:10a6:803:70::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.24; Tue, 31 Aug
 2021 14:07:08 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::109:1995:3e6b:5bd0]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::109:1995:3e6b:5bd0%2]) with mapi id 15.20.4457.024; Tue, 31 Aug 2021
 14:07:08 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Michael Walle <michael@walle.cc>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 6/7] arm64: dts: ls1028a: move PHY nodes to MDIO
 controller
Thread-Topic: [PATCH 6/7] arm64: dts: ls1028a: move PHY nodes to MDIO
 controller
Thread-Index: AQHXnm3DN/MFezOf3kSioG5b8sgI36uNphuA
Date:   Tue, 31 Aug 2021 14:07:08 +0000
Message-ID: <20210831140707.d2zdt4cxa7yllxzh@skbuf>
References: <20210831134013.1625527-1-michael@walle.cc>
 <20210831134013.1625527-7-michael@walle.cc>
In-Reply-To: <20210831134013.1625527-7-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: walle.cc; dkim=none (message not signed)
 header.d=none;walle.cc; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: df322ccf-4c78-418d-5531-08d96c889eef
x-ms-traffictypediagnostic: VI1PR04MB4685:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB4685D6CD0D4670A3827862B9E0CC9@VI1PR04MB4685.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5n0ahdCmb329h3zRyXfVjjE9qlyWHk6LQiBMda4arHzRiQdmBw5jovMWDUlXgxe7iF3ZxlKcJr4j3Vq28SY5JULac0pIDq+aOWZso/QHVERQRdNg7flLmgkDrWkNoNiIi+qC50oxy95KEfSb/QkPUXTc4G3M9+4sFR6ehDwDEFiGJX5Kadp6QeRf3WJOxiJ1V6U+SU/hn4tM2h7eLIjMQ+jWh7aSDdMy2aSKrDN+gXF0Nq2bFnz9Lqt4U8blrqGXD3pfQanQVuV70SniUi8OAosNZKfaBilLQuM10JwOMNShFMHIJdvC2Bcz8dtzao8+d+MhVEyZvR8rF2e25otj2Yil/dvRTPcAvoPjT3FnUCTikmzvhNZ0geUWAMvzcgOqT9gO00in8f+sKQwMzqID4oO5zh/KqYYzs7YRiyerl7o5G/LQk+vjnByCbBD48hcxrwbAhhsxceyYQKb3jae9qB74i8HVsRQdYiigeu/k5aA/4/BtYUD11h7u2gvSIQFMPYeq8KK4BznDBTJda45G7KfLv/UVQwycEqwKtkADX4i7pDUCV738eS+CQJRof84fkhg7zLPKOOxtn0lr8XVXROnaAH/UO6zq8po6q9Mg24Ricb6J0kllHnolajAFw/80cdabG7uUomhL54PkcjcmebUB3Wp/95TQjAx5xWo6qvvpSrCp+3VjhgiWdst/3afxIDnBFluOn/IL/djbuIFmpQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(396003)(136003)(39860400002)(346002)(376002)(366004)(9686003)(26005)(66476007)(4744005)(4326008)(6512007)(478600001)(186003)(91956017)(66946007)(33716001)(6916009)(83380400001)(66446008)(64756008)(6506007)(66556008)(86362001)(71200400001)(38070700005)(44832011)(1076003)(316002)(5660300002)(122000001)(8676002)(2906002)(38100700002)(54906003)(76116006)(8936002)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YPr7yADIREbcl8NhyCMm5nokCApkPbz4M67RqrSqIWQv4fGUxc4nFVe2zBXy?=
 =?us-ascii?Q?kRckk5TYOsVy9itscNybGkngCdDvC/v6UlAo8WnJXvtUJgs4hfmAUAq8qKav?=
 =?us-ascii?Q?SYbeAsKj9/J+deM6xM8eLldEJiGZUanlsBXWOyHaQ3e1IivPVe5jhjfJ0f6e?=
 =?us-ascii?Q?aRGD0xOTBmmxqZBLxAdUjEcBGWyYf0CaBO0XTbOGXDSczGOQb/kA1ca2E5Or?=
 =?us-ascii?Q?NhqMafFf8hTqiJ20SLNuhCrIxE1Q/GyIOS1WGO41ot99QiE5Hjy2jfr3ndkB?=
 =?us-ascii?Q?gm/stYS4LD4QLyeE9Z3KWlYDf7mPGfbIL2rNS7NRKo4ZDTioDr1L816RUPQx?=
 =?us-ascii?Q?v5vCulLhQW5g977AUa5KSSx55UjBlzCf9CW5GtkYZ83fVXmOAUDgcwgNtee0?=
 =?us-ascii?Q?zHWE5oT0M2fnV2B63cjlB4qE1ASrKGe9NNEqni92w0Bg3L0/QGV7StAXk0EJ?=
 =?us-ascii?Q?AAt4gGudQXpa31hrexhXklVz9Nlaf0f4q/iIXdcsx28GHIyx2oYxHlhB0f44?=
 =?us-ascii?Q?ndJH8UW/IE5nV9ZM64qIb27waPJpf47pYNIqCn74Q7h1OiPCMN0K0vEt26IE?=
 =?us-ascii?Q?5sCe7PFsuRnj3wQ6mF2PDtRn0BzGxseYgHe+kNpgiQJIgRA4KavHTK82CaRj?=
 =?us-ascii?Q?j0Twq5W50SUM6zmSKy0+D+ODWGZJTrkdN8u6BEGlwo2VB1BiDCliIiPou83/?=
 =?us-ascii?Q?FAINDMzthqFHMkNLRKF2/VguVP0CrgWkqyd+8Gn8zYzvNPRuTTIicnXO2K99?=
 =?us-ascii?Q?ieX7Hlws+zT0f43Ofse7scJa3OQtp93ZL+JpqPcM4G4YunV4E/jpxrzyozHG?=
 =?us-ascii?Q?k1fhVusfFMfXC+FRhPmOjY6gQ0aW3Be6wJEz4p1FVqFYf0KAbAyfMrhMM9bZ?=
 =?us-ascii?Q?2A2UtZnqTLD2Hdmv6ueubAZi6j2AL9JPRO8DyqqElqPedKouRHuJODN0pXrP?=
 =?us-ascii?Q?daOucSKLuozWcV2d9wnpkf50lJcEtiaHrDeznB8DWgN8NbfTeN5So9Kp6VMo?=
 =?us-ascii?Q?j/IeijypclvMJGNbM5Vngaav+dNkBc9zdqg6i/HXyA1uI1nybmENf0/fSbao?=
 =?us-ascii?Q?leWmt+e83+E/OYIqUtIo1p5MLX6ri69PC4xBQI75p6pxW0rSi0q9tQVqEuuo?=
 =?us-ascii?Q?pahk3AztwsGRm/LwhWzceIys7lDcyHrJ1KKvfzOx8qHnWOWldR7rjnoOvXnp?=
 =?us-ascii?Q?hruIfVOE7i5ki54QD2b26o8d5gIbAcNRT5LSO9iFosCJdhsp+y2LzmPdlf4Y?=
 =?us-ascii?Q?avBGyBoFdoVF/cmx9CQZel7e+XebfHNETtZP9PgRlPP3QPjBKxMKTMPh8knA?=
 =?us-ascii?Q?DrJQnCqW3BwApQ0CwLyu7xbAdv+NiEk4593o/dqo5nPnJg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <473919262D65014B9B5019579B760D62@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df322ccf-4c78-418d-5531-08d96c889eef
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2021 14:07:08.6383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gUp129xZE7kysab+64/EMphcSYvNrN9SgYyjTRA+76syzx3mW7p5wDZKcI3PA9e8NUNNF142T0OJkimL8BT4Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4685
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 03:40:12PM +0200, Michael Walle wrote:
> Move the PHY nodes from the network controller to the dedicated MDIO
> controller. According to Vladimir Oltean direct MDIO access via the PF,
> that is when the PHY is put under the "mdio" subnode, is defeatured and
> in fact the latest reference manual isn't mentioning it anymore.
>=20
> Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>=
