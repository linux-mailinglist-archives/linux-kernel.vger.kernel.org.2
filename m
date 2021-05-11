Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF14A37A675
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 14:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbhEKMVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 08:21:54 -0400
Received: from mail-db8eur05on2054.outbound.protection.outlook.com ([40.107.20.54]:1363
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231429AbhEKMVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 08:21:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LvUncDvyHHUJx22Uvxb7RVQJJAT1czWxjLNn8O27jueqGxR49xg3ct6Us7XsS+D9iadsJJiMj39o4lUV0TzXswGRc1h/Wj9xlxR8G/agcYW2Y76O78epTlkxZi28HYyTwFtgSQud4WjqfAwwAurbq5PfcIPrpdbyQ1dMtwz9H2qR3MVpSPdPJMmo5+4cGAyAwZfvoqWRUS0AfJFKBiJJ10CA3F8ymLnHotzj2nqNAVHkksznhyI64gjQGgwNTsmXvFqZd2MGsal5DrpBR8OVvVYP9GV3iN+Z+718unAOI9tzWH334L9OslN9o8v8HDPKLuEoil9jpLNok5GI0sAsUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0dhuSRsOhrBCB2dl9rbxmNfz+XUu/OWwIB9A9KZ1Q0=;
 b=miXiahicfFc6MUNeSfFp7QC2bkS0/Egc4F2hKP0F24QmB7OoMdwQeZsQGzOUANNYREDOmSEFbcxzt5QRJDMRVe4Jan2TraKWmQAfCOA7NZCOIXhOP9t+Kb2AFp2dNCrkP0mnXzrfclTeXNkkjgq4JFG31NtnNE/nPcaO9vM8UPpFpW/7q7pByjASwfsU41OoueVFyInRfcjxFURfbs9wUKg89fRfux3nvqUXoJ0p8BYAMD5mAkBFy1QaIuJCenAVb91/orSBCMx3H+e3wGj6m981kLCbCVc9ggLL0Vm6rReq+DrUkqEeaMOX/ES1qFkTFCgEZlheIhQNxol5QHq9HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0dhuSRsOhrBCB2dl9rbxmNfz+XUu/OWwIB9A9KZ1Q0=;
 b=RzcX+OntEhPxNmyPpCOdwRVv3Jrp+9mVsHmUFqTvvz4dC6BzP1Lcufy3wjgpKjIkw717Vz+zhgn6fmwITyzIzgcUCgJElHaRqxmjoL3pKlEbIVA1b/6qdcYEkDB83MF8eDds0luDeB8Ot/rMlVPMz5WkQ1n7ZlWQ3GoZb5qEjRs=
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com (2603:10a6:803:127::25)
 by VI1PR04MB4062.eurprd04.prod.outlook.com (2603:10a6:803:40::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.30; Tue, 11 May
 2021 12:20:43 +0000
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::de2:8b2:852b:6eca]) by VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::de2:8b2:852b:6eca%7]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 12:20:43 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Adam Ford <aford173@gmail.com>, Shawn Guo <shawnguo@kernel.org>
CC:     arm-soc <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] arm64: dts: imx8mn: Add spba1 bus
Thread-Topic: [PATCH 1/2] arm64: dts: imx8mn: Add spba1 bus
Thread-Index: AQHXKoTrm+1dEO4gCEi87d5cyZOFDqrdyocAgACF5YCAABIPoA==
Date:   Tue, 11 May 2021 12:20:42 +0000
Message-ID: <VE1PR04MB6688CD4AA4826EEEBBA2651689539@VE1PR04MB6688.eurprd04.prod.outlook.com>
References: <20210406013344.124255-1-aford173@gmail.com>
 <20210511024604.GE3425@dragon>
 <CAHCN7xLFpL=9BF9M5gUA6sMhc2ZZMNz+GP0OLmLfpJAWdD7W-w@mail.gmail.com>
In-Reply-To: <CAHCN7xLFpL=9BF9M5gUA6sMhc2ZZMNz+GP0OLmLfpJAWdD7W-w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [183.192.232.236]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d2b78ae8-fcc7-4b04-efa5-08d91477327b
x-ms-traffictypediagnostic: VI1PR04MB4062:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB40626A25C43F5246F692101F89539@VI1PR04MB4062.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8q3H//w8awkKbiZp8Jf5zQYXlLRb56y9KczOuWPU2s1B91A2B9JqsLdw7OvBjGyroRH1hucnAzhjQtRaBiG7gaMvjQNTPtDQ0Hvf8B+OgnxuVKtOStu6/2uJ4i8qAKhsCIo9YKGqGl3jtNoRdlWJCU5Qvc88kNSADqjm/SM8IBkVs3A6cIRewfOWWkJBT5QTCBEU48DN5BWXSZjU6hJaSSkoFqhznFIFKStLfckclrEhwm/c7653K+DfZMjglZxqMVbWFCXgj4RrpsR5xfxbS7OQQh5cdQoL3TZkxhnCSSrl5gw/0N0XQeYjazCVEQ8cFcMDumRvthfxCwTPY2jVLE76KJtKM1LN5mYc6rRgpYdlKgxYu0n0zkS1FFF60/KZmz/zezeCriNEWssMAvspxKUJT7paeTv1mG3Mai5Smf6PWvi34SyIRcDUrwGessyZ0bshpDc4jzq6Bk8i+4iWyM7jolAsPwjMW+qCxsjOE8F+XMRgPCABg4sY/UZcjbLSnPSQQRVSM8rvmmIqJwXzaPM80YrvFCxek6BB0pkNOqZJAIAlxCzqVaoLZpBpT+fVoR6lpgCmB5/gzQQytQisJox2lD5RWZj/5FKXS1cRiZFbUq+mZ9fDovHivB+hChZfb4Vw51FcxgxTx7V+Ow51xA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(33656002)(110136005)(4744005)(5660300002)(478600001)(76116006)(55016002)(86362001)(54906003)(66556008)(66946007)(71200400001)(66446008)(64756008)(66476007)(7696005)(9686003)(2906002)(186003)(53546011)(38100700002)(6506007)(8676002)(122000001)(316002)(52536014)(83380400001)(8936002)(26005)(4326008)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?vzWI1qv8fBo47U428PG7Y0Xc4SfP0E+gzRXBOE5huE7oDQVxP1GZ5XeIfpeh?=
 =?us-ascii?Q?fA9daOWmxzH66wFauuePc2L3DybOf6UK3eT0y+xAFw4NbyhyWoz8BeZIhtHr?=
 =?us-ascii?Q?Mt+/vbWfMiA6KFntrj5P1MyCAcLNooN9VkmFccGxxjd1gNboG9CXV6Z5eRYv?=
 =?us-ascii?Q?INhdRWwYhb2aDIkBrDYaFjvXHEpBRLKxcdFk5Uj5O567jTjBIy3A1O7gyjBR?=
 =?us-ascii?Q?oyBQoMN8Iz3iJDC9RNFTe5hoYf4N2rC2S83shsHvQ/dnSKOy6wmzJRRVyzTE?=
 =?us-ascii?Q?5e6pjkyPMfshvyYWvRgWpfi9EaetB3WhTUKVuMY4WHmnK1uksVIOv+bCl3/x?=
 =?us-ascii?Q?xpti90YJd2/Xl9G+NWxeqN0MqwJojdqXL12MwGw+3Aby0Srnn8bziOHkClrN?=
 =?us-ascii?Q?AlsXW7xw23vCSsbfJYmPKZjeSiJLdoTDCAJs8uW8m6RdLxOh/i+XEYOCfraP?=
 =?us-ascii?Q?nxQZyvSOkIzal6nTUIDoDCD8SB1aMPmqmygcN3UWYs5yDss6sj/2gTgE9MQ7?=
 =?us-ascii?Q?QD1IXwwc2wvOX6azeLEfqRNIvCYH/fw0FbtaD/LS/pqRD84uMDU0kCf0sWb5?=
 =?us-ascii?Q?njv0wJRITH0GitTw6llzSyEOfIoxZvtz/7agzC5sEcAzpyGE2skEqLnE593/?=
 =?us-ascii?Q?RtCTHPcOjW2FfQY3XDGdwjT8RK1ZAdHg1FRPh1t//AONS/av/CIfNW1LfsEO?=
 =?us-ascii?Q?lQQ88yzPX1uqH3j7eLThyBXFOjefur5sZ1bVm4ryOwTfCMbkhdPLCp8Ay5bZ?=
 =?us-ascii?Q?NDht0DH4BtN4rJNaORx7RKGgcx1TRgpAX9zykb11Nrq/9s+X4RS5axGFyfI5?=
 =?us-ascii?Q?JxJlL7o6yS/ZYbQ9qVXVPH0Tp5cwsLJ/pt1qVx4MCbU6Fy4b3Qjvk4sLNYax?=
 =?us-ascii?Q?NIDBPyyudmw0YWfgPxpt0930JBPKpd9pZgiFGXYYxI4TyEPpRbgR2Uxv1AAe?=
 =?us-ascii?Q?CO84fVuAexDD3xSByww0NeQ1hUIxW+VF6MLfvWiohcZz42/mcMDH33xKJJzQ?=
 =?us-ascii?Q?/3spp4TticvcRv6BpMT43moBmCn5vRnOp4ZJnD+C0UTEgQlWPvri80Y1C+0d?=
 =?us-ascii?Q?mKJlreVwbFcfbfMBqv+YihNlj2ncfQRG7Fs1vgPe6NN8b6NtZGV5A2/PAmgv?=
 =?us-ascii?Q?LuR/LduKHn47T4NL7BVC1RApnc6Y634awIbCcKbFGgCobuLDAgR492YwxkKB?=
 =?us-ascii?Q?6ARiEtIPQN3nOX8dGXv4PMWfnm+T9lI2mQoua01dcvH7DU9kojleJolSs82o?=
 =?us-ascii?Q?E8c3OZZcRQI2a9JTBVnkHagikmGmQyJwSVFNEAEAs41LRHDld0Zg6RV+OEkw?=
 =?us-ascii?Q?7fj7OLtJlAEkiGhxBRt9txkn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2b78ae8-fcc7-4b04-efa5-08d91477327b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2021 12:20:42.9343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h12iimvlxOzSSz3otYUDzifZnFBu70L84bV48DhpmMddl0jYpwrAJn/+ZwZo3gKyZqSwGONOTXzM1HyEmhNrIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4062
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/05/11 18:45 Adam Ford <aford173@gmail.com> wrote:
> > Also may I ask if you have a real use case for this bus node?
>=20
> The reference manual shows the SPBA bus tells the DMA controller which
> peripherals are associated with it.  Nearly all the i.MX boards use this.=
  The
> boards I support have Bluetooth devices connected to a UART running high
> speeds, and if the DMA driver isn't loaded, I can see a performance chang=
e.
Compare PIO with DMA on UART, but not w/o this  'spba bus node ' patch?=20

> In fact, if the DMA firmware isn't loaded, I often get transfer errors.
UART use SDMA ROM firmware instead of RAM firmware, so it should work
even without sdma RAM firmware loaded.  Still curious what really happen in
your board without this patch.=20


=20

