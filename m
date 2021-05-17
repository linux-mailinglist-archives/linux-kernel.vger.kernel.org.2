Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E46738228F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 03:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbhEQBgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 21:36:43 -0400
Received: from mail-eopbgr00088.outbound.protection.outlook.com ([40.107.0.88]:31054
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229479AbhEQBgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 21:36:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fygq2i3fJJ8WDdgywD+WLbVBL8e37K1hNRm0XEkEMEIXNnYTPDLrMyd57+1z9SYVRaEi7NUC3FIc+mqCQygtDGGnPkcJWH2sqYjcAdUQEqjm8a5zCb2QWdPXo3pwBz/SnTvTSZNsrujP/btFpa2PijRYjM+8He+vtiNfgpr25kxY3sxNoQFPsh6wIVCctfz8dshD+gBfmeIU1oJDtcBWsibq5h++fC0o11Imjk+HWxx+/IfVJ22FDSR7qC9ja30FYzPtLRG4ZZSFSMYHsRdqtr+KwVFr+NQqx3H99rP01NXqS/tdOcAoNAOygAni20j2yCv+F2GXBw7ILa1AN0Q7ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFzJPHRZKph0Om/sTK564iicMtswyECu9bccQ9Aec8g=;
 b=T0HcXus2DoOf/uJ/6F+RckynqcmO30cId8IX7iWpt1ZfJFmZ/E8kvQxLYStp2wu721/tMKlJIckAYY1fBfkRBBb98kmlLvQWgAbp/Fy+LaKPCUZV3P9QGM0ftmcnuXVOv4Por5l6822PmNxkJ8ACbfQ57tVwzV8xiVDR2qMpMyvAFdHYlQavFsXVx4xr22HvYCkRDXzm/Y1yjMtQE0Pejyh7tXjDS2USTkVy00Cxqj0wRk/K9l/0lBybZ5lKPn+CZ2NAmqG3o3IaMuWNFa0VASyP7TuoX8Kgjwkqg21D4Duc4npLwy84wtFnEevWt9A0+nHjvkiy37lSM47DBELaeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFzJPHRZKph0Om/sTK564iicMtswyECu9bccQ9Aec8g=;
 b=eYihPa8AxBerCcMDQGaJzgeEUYDdTJRSmBrhaZY2Bqekyh1Z0QDQOk6UBB63NMxvrTTOIRRUF4Wy3iGb/HQbQX+GizdUV3Ihq3qQxuge2X0icI0mts2t6lGbjHVJu8gcs//nQr0SijqlQi/oc9JmkcxD9CoCnB0hxedfvvb1lZg=
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com (2603:10a6:803:127::25)
 by VI1PR04MB7022.eurprd04.prod.outlook.com (2603:10a6:800:126::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Mon, 17 May
 2021 01:35:22 +0000
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::bcfe:215c:1b66:6011]) by VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::bcfe:215c:1b66:6011%4]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 01:35:22 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Adam Ford <aford173@gmail.com>
CC:     Shawn Guo <shawnguo@kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] arm64: dts: imx8mn: Add spba1 bus
Thread-Topic: [PATCH 1/2] arm64: dts: imx8mn: Add spba1 bus
Thread-Index: AQHXKoTrm+1dEO4gCEi87d5cyZOFDqrdyocAgACF5YCAABIPoIAAMe4AgASmRGCAABuHgIADyZ8w
Date:   Mon, 17 May 2021 01:35:22 +0000
Message-ID: <VE1PR04MB66880A52479E192514239D94892D9@VE1PR04MB6688.eurprd04.prod.outlook.com>
References: <20210406013344.124255-1-aford173@gmail.com>
 <20210511024604.GE3425@dragon>
 <CAHCN7xLFpL=9BF9M5gUA6sMhc2ZZMNz+GP0OLmLfpJAWdD7W-w@mail.gmail.com>
 <VE1PR04MB6688CD4AA4826EEEBBA2651689539@VE1PR04MB6688.eurprd04.prod.outlook.com>
 <CAHCN7xJ5Hq6bRpEgE8Pi9VbQ_Kejy-sgKQsJ93pQEG3U_Wsu=Q@mail.gmail.com>
 <VE1PR04MB668860A19062925162C40F3C89509@VE1PR04MB6688.eurprd04.prod.outlook.com>
 <CAHCN7xJ0xPJJaxMrzpZSGKjgh46bSEGgtsECd9ZqnpHKSCH9EA@mail.gmail.com>
In-Reply-To: <CAHCN7xJ0xPJJaxMrzpZSGKjgh46bSEGgtsECd9ZqnpHKSCH9EA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 05f7c1b0-41b2-424a-204d-08d918d409ac
x-ms-traffictypediagnostic: VI1PR04MB7022:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB7022D6EFF410CCD1F0810ABB892D9@VI1PR04MB7022.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +o0N0m0Jns5mWI23geZ4PsbHGGl5UDYdaqT3GK4tpem0wwQtDAsx7+jbBcygx9lM0lFYADf088sdnjxpbpTK6O7Q6Cemfu3pShtl2GoIh9aQE/8LC6Ko1CWq/V01nXaZiIZdMUhZErOCRXmZMZqyC3vWqp9kJRm+7QtF8ioyINUNiKlA18O9JfA2in29QHA98qXjCkeIC8ssRIwGQnppp2/0sHgF9i05EUKXAJgk3QJLdoWIGrtfRW6USh06nja6Zs04enFKNbZ2TgoJ98Q9cTCLBn/r3KmnCOZlSJoLfB0M67qvOTV6XmpiZPF8RpckK4PPSC4LbwWvODH5iSSIRjNK5ees9njFl2Os8blg/Hroaq7lGq435qd0aFKc/6doByS0mSB/xzVJde1R/Q1u7p0N9KJPKsDC09XbpVgjx4SsdhMYdIN4A6H9M6pW1bh8N1DpWCsByNgZsVtbqExBja9dwQM+4N0GQ7Z3EjvNRCnbe/g1xTpqN7Nb+GNbv90hRlsRgttJcWa7oh8YQrcKR8Skds0ZJqS6ptW1ioAbBsCuSS5c2I1kmV3ety1r3wamUrEQgFX6CGiKEHpXWDbSgXv0TZR3Ahegr+HWVlClEDem3aK/E9JjT8j77wTSArbGWhHUG5e9JuO0E4XSSY/YcQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(366004)(66946007)(66476007)(66556008)(64756008)(66446008)(71200400001)(316002)(6506007)(26005)(478600001)(76116006)(54906003)(7696005)(8676002)(4326008)(52536014)(6916009)(38100700002)(9686003)(2906002)(55016002)(8936002)(5660300002)(33656002)(86362001)(83380400001)(122000001)(186003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?q+i7FMBLtWfw5U/zKC1JO1c+etHOYpHuV1pkdSFva5649os1Vw1xwpNJ8kKE?=
 =?us-ascii?Q?I8QrpFuZFwyMcmZs9Kg9QNCUPcr6yfdCXLxYNC1B57O8URxIfSWpO6i99Cqx?=
 =?us-ascii?Q?NP5YhOyJs092MXXIoMoXOl2G8KeBsLcCsJdSCw3o2tTVg9Mt74NEYC3mc7Xy?=
 =?us-ascii?Q?//6nGs6DUTle2tTJeQsQYjNQeeJYy0SyGtEv4wxMqSZ1DazSAadWne6wzLBU?=
 =?us-ascii?Q?uBAszTSIyQD/aTdLWvaXtKto+9cG4lCZOCIQY87JEB/LFz/H2sZ+WFvvHmbI?=
 =?us-ascii?Q?HbM2KvOhENGWB8hNTt7rmnpOTdbOPzQ1UM01N4XDdR2kmaBnYUAL2NlwDI52?=
 =?us-ascii?Q?GA4jO0gUcZX9pk3RjSue805NhYIQIuB04YsG7yytPPx0c0+Wg+HvTLMEXreB?=
 =?us-ascii?Q?kQkUk/qCWqdXm/bqj43egtdEOxXAet/6neOEZSalU//VZt8qV4qEBe619Utf?=
 =?us-ascii?Q?sPCT2hTSTXTyjPeDEFGnZ3Di5IX6JgtyXAL7ZtW8aXc5bMyqHQNU+4a2N1oz?=
 =?us-ascii?Q?FZHSZusjwQavL8vd2N8+UA1bFPcl5a4fakT1dYeVfQJLTETci35AKDwzRm6P?=
 =?us-ascii?Q?QPIGjIZgKarR/gOKYt9KQ51hI0p1HI1zdbUh8VWHO9z35SVcpJ9hfutX8k0P?=
 =?us-ascii?Q?Jotzl6Enu+J1UF2gHOoGxG5SznYyfCuB8N39E34POU2zmeT9umDYJdJ6G8ge?=
 =?us-ascii?Q?h7ZhGin7vyrC+8BrxiQkoT+ptkwI7ByUgMl9wTE6JPEke8g1PQswjyaDRbIn?=
 =?us-ascii?Q?+jWB8wAdaHW7pW8m5tf7koE0R1ESoGU/h3wrcMP1T8DPn+fhRYZeJIe1o5qq?=
 =?us-ascii?Q?t6l8s9e6WgmUrNcwZ90k9tdihdf8n5KYUguX5NCqhbJ0yODfU0Xecfnu5cM2?=
 =?us-ascii?Q?ocAi4xXgtQTnA5q1ZSa91j9iVCDV6Ou5obh37phzpGctjR+cgdTHsVXlUVFv?=
 =?us-ascii?Q?NuOlVNJaProvAjGmZB41KHtXjASeeXTLKKgZleWAm33H7hN3mD7QHXfQeEYn?=
 =?us-ascii?Q?0d1Tt4DFBYX+d21UAkjlnmJALzuiwg6reeFzXj77KQb7gnyyBrQzjhb7fxxd?=
 =?us-ascii?Q?vDehBE3dhwvoqau6y6mTw5hbZPZtYd5CT3lQFa193lTKJGpcYWEN6+LV+6uY?=
 =?us-ascii?Q?iFcdC28/4f/nDTfp3A025V2jkJzS1mre8WW0LIhR4PZ5LukAMk/EcQETVXGt?=
 =?us-ascii?Q?HGly1Yey5jDdOobvVj6OoQLQIgOz0FkrsHODP7TnpSLMajrTBGpYOEJmr3h/?=
 =?us-ascii?Q?nuUywdvMhrm8feAPdYjUU4oURTl8sOSZAdhyIjhaYKQtNaeXeN7vX8hLcvFp?=
 =?us-ascii?Q?iSwND2MQSwLR2FlWIcjq14Bs?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f7c1b0-41b2-424a-204d-08d918d409ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2021 01:35:22.3694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XSS9cUvWoL5rd59tR5fiEa5m5AQA1W/PEPF06NEozr1BP4aS9NvkoYNt6+BOnDHdaJ69pmOd7511VlP2K5hlPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7022
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/14/21 Adam Ford <aford173@gmail.com> wrote: =20
> I did this on the 5.13-rc1 which appears to have this series applied.

Sorry, I didn't see it on 5.13-rc2 even....

> > where 'sdma firmware not ready' added?

> >
> > > [   10.594548] Bluetooth: HCI UART protocol Broadcom registered
> > > [   10.600108] imx-uart 30860000.serial: We cannot prepare for the RX
> slave
> > > dma!
> > Why not use ROM script for UART as mailine linux-next did (even the abo=
ve
> patch set)?
>=20
>=20
>=20
> > If so, I don't think you could such issue on your board. What
> > script(peripheral types) you set in uart dts such as below is 4-- MCU d=
omain
> UART-> IMX_DMATYPE_UART->app_2_mcu:
> >
> > dmas =3D <&sdma1 22 4 0>, <&sdma1 23 4 0>;
>=20
> I didn't change the DMA references from the default, and I didn't check t=
o
> verify whether they are right or not.
If so, I don't think you could see the above firmware load error since UART
use ROM firmware by default instead.

>=20
> >
> > >
> > > When I get the above message, the bluetooth chip I have throws
> > > timeouts and does not function.
> > >
> > > [   10.615090] imx-sdma 302c0000.dma-controller: loaded firmware 4.5
> > >
> > > Once the firmware is loaded, I can unload the HCI Uart driver and
> > > re-load Bluetooth works again.
> > >
> > > Based on that, I've been having my system delay the loading of the
> > > Bluetooth modules until after the firmware is loaded, but this tells
> > > me there is a relationship between the DMA and UART.
> > If you use ram script, of course you should use it after firmware
> > loaded. Actually Spba bus in dts is only used for per_2_per script
> > judging if the peripheral address could be accessed directly by SDMA
> > over SPBA, if yes, set SDMA_WATERMARK_LEVEL_SP to let per_2_per script
> > access peripheral over SPBA, otherwise, access peripheral by AIPS inste=
ad
> like ARM side did. Please check with below commit for more.
> > Besides, per_2_per script is used for audio data sample rate convert
> > between ASRC and various audio input. So audio peripherals include
> > ASRC should be in register scope of 'spba-bus' . But with your patch,
> > there are two 'spba-bus' device node in dts, so the first Spba-bus
> > should contain audio peripheral, otherwise, 'of_find_compatible_node
> > (NULL, NULL, "fsl,spba-bus")' may find the wrong one so that
> SDMA_WATERMARK_LEVEL_SP Never be set.
>=20
> I don't pretend to understand the details of the dma driver, but I attemp=
ted to
> make the patch match the address range of both spba busses from the
> technical reference manual,so there should be an spba bus for the audio
> peripherals and an spba bus for the serial peripherals like UART and SPI.=
  I
> only named them spba1 and spba2 based on the memory ranges defined in
> the ref manual. Table 2-5 shows
> SBPA1 is 3080_0000 and table 2-3 shows SPBA2 starts at 3000_0000 which is
> what I believe I did in this patch.
Okay, I'm not saying your patch is not wrong, just curious about your UART =
issue
you mentioned :)

