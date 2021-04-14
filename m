Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3065435EB35
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 05:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245731AbhDNDCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 23:02:39 -0400
Received: from mail-eopbgr20076.outbound.protection.outlook.com ([40.107.2.76]:17283
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232009AbhDNDCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 23:02:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PrJuH5gyD85s2CavjUv3E2Y9xwfZrxvDbJT0tjuHHS3NlDBoMVkcKY0A/eyBuvEkjdWda8tdRkdMjv6qj+64spF6f44rzPs9dCzoc1ORzQoD3r7Rw1AksZLg08sRqJerHktwOBt6YGfx+MBJ0uwLwmiBaNhiaqkhB9WS8w4GZej/YJjUvNwZV4t5Xpr468Po81Cz4NgyR+TcqnZ97On108h++VPc3GbtOapXbkdk8DQqZz35h/1GX50U+thaN58LC/2kRVrDwfJNUvtfoOASFS4csepzi7gDiuzIqEk5SEGKIxAgUvWiJm3sLAkUlZD7Vv5ChSzru5PkJkNgN2i4EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqU7Ri48LhfDzw9CMr5go8FJqq5pKQdEozmPLzv1MjM=;
 b=RvgCElGlRoc5j6TLU4lPd3N0CWgz53Q53ih2F8MMyEdiNlIaWPla/PZ7CdXhB+aW3urm60cUlwJGF3PjCUFoEWJikt4RjdyxTDt3nvzlISnl8XyQ3+um3LMPn16JIalJ87LpYDkVxRzlp4gMEMHUZOAXcCj67j5wdyn4q6W6Ax2gVzub94e0jR3XvrUB2CvlK+Rnfu6SRN4fsXbKhJ2aPc3gVPOs8jRQaB2zLYrAHuZIWxFgFqJdk+Y5+KElRCuaRqcAypKhpbl9K8ldI9gPuRV3u5FrMCADoXnTVeWKnrOncPyXRF7zQNdHxomEtu+z1gsudxmS9rlxkCSk4sXasg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqU7Ri48LhfDzw9CMr5go8FJqq5pKQdEozmPLzv1MjM=;
 b=dFZNsv3moMzsY/wtVviSc7w5oMo3twzmDCHp3+cYFqZok28jjefDUCSvxW7LfIOUQiLw8FsuAAPwqvKPAJmEuSYBviKq/MAsqCQpiUIcCMO2QFxN8ebo+/nmm7YHraHgfvvt9h9m+eHer0GAHfSN/j7wrwPmKRay6jRi/gkB4AM=
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com (2603:10a6:803:e3::25)
 by VI1PR04MB3200.eurprd04.prod.outlook.com (2603:10a6:802:d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Wed, 14 Apr
 2021 03:02:12 +0000
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::8116:97ef:2fd7:251f]) by VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::8116:97ef:2fd7:251f%7]) with mapi id 15.20.4042.016; Wed, 14 Apr 2021
 03:02:12 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     Richard Zhu <hongxing.zhu@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] arm64: dts: imx8mq-evk: add one regulator used to power
 up pcie phy
Thread-Topic: [PATCH] arm64: dts: imx8mq-evk: add one regulator used to power
 up pcie phy
Thread-Index: AQHXMNedcPPt4bSgyUOcAxLtmIEEW6qzUjBw
Date:   Wed, 14 Apr 2021 03:02:11 +0000
Message-ID: <VI1PR04MB5853835972CB26B529E6FF3E8C4E9@VI1PR04MB5853.eurprd04.prod.outlook.com>
References: <1618367174-30968-1-git-send-email-hongxing.zhu@nxp.com>
 <1618367174-30968-2-git-send-email-hongxing.zhu@nxp.com>
In-Reply-To: <1618367174-30968-2-git-send-email-hongxing.zhu@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 32072052-4142-43c1-c3ac-08d8fef1b33c
x-ms-traffictypediagnostic: VI1PR04MB3200:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB32006B19F8F03E923EFF3D028C4E9@VI1PR04MB3200.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UShLBgJOjOnMTfPUCy6DzMGgGEedMzTBTXQdCegFswoD+MyNt65AG+cfQrfzz9EDJxMaz4ALEEAbAVHXN+GwfdZ6KdiNWP6nKsYd/HetM07gdb120kl+FBklXu/BDrxjzkrpxCciFo/BMP1RGmU2JiD6kTVEqoczg7n7oZ4jgtkdB7c9z6b/9WN5rjVtGhjC0boE9dClclmaN8GO9NpVRJ0DqtbeOxGAwEMcjCXsiH6IfVmR47rxF5fejlnDOjauxYh3fu33oMRBS+U4To0UAyD2rXLO0JQzXij9CgULjtarDX7Grb0XBoj+7GrINP3RmrdUmThYewTsrmoHBTpOuPHJnDncWtat29dQXjb06Q23jiP5vp09JGrTbkWQDppbN1/RcYViVAGAfj6Q9m3bZtpT4HOL3CuGKFWMpoNTXGhu1JMx1gXDdYiHu1RuRcqjMIBZCKIIRQfxAwV5bFrvY7p5pHcL0qovBZiS+U0tSS3JBgjTa0fS/1CdqGZh7akywID1VSrJagH7jyD+3URCBvo1YIp7piZoKCV/+0I2J29XxY9gSYnW1x+aHL/LnchfV53wotFloWjtNqnOQugqp/mwmGJnKlIZgU21vGPTVfoNf7in1zU7xYn/CbRDDoNXTUW+U6vlCbalBXRClN7Ug8qbIA8Sj3clBLvbB9dF3uNNStSLPeRIrLzFRlpd5i+XMI3+bsL/DsrIlJz5RcYCuoibNqDjTsQ6+8pIiKM8RY8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5853.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(396003)(366004)(136003)(9686003)(4326008)(38100700002)(84040400003)(110136005)(83380400001)(478600001)(55016002)(316002)(6506007)(54906003)(52536014)(5660300002)(66446008)(966005)(76116006)(8936002)(26005)(66556008)(122000001)(7696005)(186003)(66946007)(33656002)(8676002)(2906002)(53546011)(86362001)(71200400001)(64756008)(66476007)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?GTdzFuOp6pX8gaR6YeLgOdBjdPpksQc0GCT3LD5BP57woYsrbiP//AiRTPuS?=
 =?us-ascii?Q?QbeAOo7h0kiTWzx1qc/WjAQycBuwqZ+gD5k0XuqnDMlOL2xwyboQ3zibptH1?=
 =?us-ascii?Q?yM9xy9XxmnUi0XHMQLjwDqu46IYFEsvLfMY+cNH44ItaAC6sZw2Wmd5SU7Sp?=
 =?us-ascii?Q?k32H+6wEC8A/D4pepTGRnrdjj4OVrE949lS6Q1qIe9Tq/1yQ1psXKOOyB4cc?=
 =?us-ascii?Q?Y5dqgq3EgB+HDS1QZfAups0zp2wZuuegh9uokltvOh12wZFhAQ+xEn07rA99?=
 =?us-ascii?Q?inUG9w9bZOidrKK6B5E0e3T7ijkXOu1B/dqL7wMgKlhqyGbyn2kD5WGrVA0C?=
 =?us-ascii?Q?1DjQXJHevB6b/hMuT+C5SzSa/SVzsHvonK5pfrPHzg8z7U5P9XvqKWzUsiX4?=
 =?us-ascii?Q?wKcgZeqzxPyCE8IaphVuhP1bs1cy+Km4eiYW1/W9r2Sq5Brq14TwwP3hs6jk?=
 =?us-ascii?Q?y78d3bZ8r86nVitm36mJtFqkNrTZwmmGexQhQbwOROPsv+4zuwd0tMi1S+wE?=
 =?us-ascii?Q?gfnszdU/c5bCF4grTPJmWO7DlgymzypFBXRQ3uX5lcxVOKD6AyVAMsCsD/j7?=
 =?us-ascii?Q?ywuq5EpUonWjiqogLCS15pIBwCawMhYrP4jEX47tcS1qQZws83lxkthAVAfA?=
 =?us-ascii?Q?VnaVgphvmPs9WcdpKm+uvhVqI+I1SUoQSu9BdQSMgQ+UKpyTzuEsqdOMNRcu?=
 =?us-ascii?Q?rxGy56olgFrcjFa5g+7ws6zMH6hB+F06CgwIhs2p1JSQXfZdMHbut4DPxF2N?=
 =?us-ascii?Q?xRA2+0Y2ycWLBmV38COMiU3MmsIVemv9E9V+ZMIfgPMbEAE6MgF1wReXv/fI?=
 =?us-ascii?Q?8jLwKN6iXDM1vKGF9PwIaXd0tdBHe2me6xIoq0c/NBflOr6qFLi/19kg7y+K?=
 =?us-ascii?Q?hsLL7IKwEYqBvR0k0gZ8zzQASneUpBNDPhkkf5bW2etAfg5KConeVtXEYfaf?=
 =?us-ascii?Q?3ITD3sVLB+v/3HjxKS4wktc2UMMuA4MQrm8HakBUck2ThMQ/VOH2RVhDx132?=
 =?us-ascii?Q?kSXbEMGkkYEyh28UNHBxIPyJ5fqkZ9sARfw9e//FBO9QwJIZrJlivUpxb8eo?=
 =?us-ascii?Q?u2ghSmxDXxB0pNHiwDKCbXoM5+RYpCTM4r6V6s6T8GekpFqQRZ35x7TEjzdy?=
 =?us-ascii?Q?NfkAIZ+aC6WR2hmw51DDAA70yQvliPmEP5B3M84x2N3lp6Jzxa7A/kwur3gZ?=
 =?us-ascii?Q?Qdtj0MgMHJ6Wj3MjFYGB6klCtJ0UHlGFdk/D3TunzvUBGCE+CitbcW9FlYdX?=
 =?us-ascii?Q?Mqu+Qaph10NTSxjtz63mR+BVFsq/Devmljll06tIfjHnDNiVCOTJ1T0b2Yi/?=
 =?us-ascii?Q?ic67xnrzWmH0KeFR6vVb3far?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5853.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32072052-4142-43c1-c3ac-08d8fef1b33c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2021 03:02:11.8903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jutvDhDS+0t/1SfL8UKBCVehH5P4lq+7m5L4C/ScI8+XWrViUjpZR/DCTCkEKH74VJW5oqlSXkbtlsNe+N4RFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3200
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn:
Regarding Lucas' advice, this patch should be split out and post for you to=
 pick up into DT tree.
Since the other two patches are accepted by PCIe tree now.
Can you help to pick up this patch?
Thanks in advanced.
https://patchwork.kernel.org/project/linux-pci/patch/1616661882-26487-3-git=
-send-email-hongxing.zhu@nxp.com/
https://patchwork.kernel.org/project/linux-pci/patch/1617091701-6444-2-git-=
send-email-hongxing.zhu@nxp.com/

Best Regards
Richard Zhu

> -----Original Message-----
> From: Richard Zhu <hongxing.zhu@nxp.com>
> Sent: Wednesday, April 14, 2021 10:26 AM
> To: shawnguo@kernel.org
> Cc: l.stach@pengutronix.de; dl-linux-imx <linux-imx@nxp.com>;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Richa=
rd
> Zhu <hongxing.zhu@nxp.com>
> Subject: [PATCH] arm64: dts: imx8mq-evk: add one regulator used to power
> up pcie phy
>=20
> Both 1.8v and 3.3v power supplies can be used by i.MX8MQ PCIe PHY.
> In default, the PCIE_VPH voltage is suggested to be 1.8v refer to data sh=
eet.
> When PCIE_VPH is supplied by 3.3v in the HW schematic design, the
> VREG_BYPASS bits of GPR registers should be cleared from default value 1b=
'1
> to 1b'0. Thus, the internal 3v3 to 1v8 translator would be turned on.
>=20
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> index 85b045253a0e..4d2035e3dd7c 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> @@ -318,6 +318,7 @@
>  		 <&clk IMX8MQ_CLK_PCIE1_PHY>,
>  		 <&pcie0_refclk>;
>  	clock-names =3D "pcie", "pcie_aux", "pcie_phy", "pcie_bus";
> +	vph-supply =3D <&vgen5_reg>;
>  	status =3D "okay";
>  };
>=20
> --
> 2.17.1

