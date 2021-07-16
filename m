Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D78783CB0AE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 04:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbhGPCIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 22:08:38 -0400
Received: from mail-eopbgr140072.outbound.protection.outlook.com ([40.107.14.72]:35260
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230417AbhGPCIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 22:08:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OID1rMtRb2aCPmtsxqUMZzZHWqGKvZMdHDayupWYTk5XTZpJqHL5ecSnIyJzy2wBH7rQ8/K52h+N9fnUAyn4WXPjQBzDrLdL9Qsa8TW84SYf1xuGiUHPhbjlCis+WGysb0FIPdV4kq8OubcaJpAxUZDK6zefT5TtFYMmHBdbbG4k+RTRxmIfklw/jZYRCyfM61coo+mUYv92U1kxBI/RIC3Nu5vUYvVIceWu+0R24gXSdM3LRBKMq9/5tJw11/lFz7aH+aX7sCeA1Os8auIF9TxhrB7N1hGJ2uJAjZ8uuSZ+qtkodFgzxDRJUNd+fAc0GBPs+WkJhc9YYyUrzYD9IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JoBO+XXNIHQGlLca4AU4kUluPJxeO3W4ZqbbMDkEl4=;
 b=Pp4mnUg8OzvZkyDA+GjyGk3rZ8Zs+Gr/65Z9gYhQlnqP3IqoY40jVGJ6IYiO67UAKRf+cpMqXsc2uKoUvVXTb55WYNpDEW8lDLFFRdV/V6yLzKJ7rBZuR1UPqBhmVwmk2rLNCLYNQwbhmkn5PIXx0JS7ETAU4YT+g1MaelywWuGjHGPfjuEz4P2KnEjZSAyqtbYBgqPeNLvp2kEq6YU+XnQndaDsGUtxfBABzT/65x3Nez7p/eMg9N3c4I4WRaHmoHqyBn9hpn4Pww4uSv+1osyvvvSJryOV88Ck8aHTWYFY3ckUk7nNc10U1Fo7eDls7+IW3JH8xjRdAztA+575Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JoBO+XXNIHQGlLca4AU4kUluPJxeO3W4ZqbbMDkEl4=;
 b=FCXwGRJBsG0dG99PpFCdBF+TKhDdaJAsws937ra5h8jFDsru1nAeJ4cjreZA3buUUyg+ECLRp9twBGs4G+dPe1SRNRgjxvG2FKF8vCZpwX2z9CICO2Mds7oLtZzRZgGBqbDYDCQ8IL8nhvLjqvgZCMOrcuUJ2O0loPIjNBU88S8=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR04MB3016.eurprd04.prod.outlook.com (2603:10a6:6:a::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21; Fri, 16 Jul 2021 02:05:40 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c445:d742:eb76:86dd]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c445:d742:eb76:86dd%9]) with mapi id 15.20.4308.027; Fri, 16 Jul 2021
 02:05:40 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "Daniel Baluta (OSS)" <daniel.baluta@oss.nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Alice Guo <alice.guo@nxp.com>, Robin Gong <yibin.gong@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "daniel.baluta@gmail.com" <daniel.baluta@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: RE: [PATCH] arm64: dts: imx8mp: Add dsp node
Thread-Topic: [PATCH] arm64: dts: imx8mp: Add dsp node
Thread-Index: AQHXeXDTbMleKUuYN0eRaFQ/sPkRQqtE2urA
Date:   Fri, 16 Jul 2021 02:05:40 +0000
Message-ID: <DB6PR0402MB27600097731DB19975A2C4DC88119@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <20210715115853.749025-1-daniel.baluta@oss.nxp.com>
In-Reply-To: <20210715115853.749025-1-daniel.baluta@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oss.nxp.com; dkim=none (message not signed)
 header.d=none;oss.nxp.com; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d65c7901-954b-4f7b-7946-08d947fe35f8
x-ms-traffictypediagnostic: DB6PR04MB3016:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR04MB30168ED3FAAA00C9D96A7C5988119@DB6PR04MB3016.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eutSdEMU7iqFeln1DOZyDN5j32gaQSp9o1zrgyc+o+/9qqDyUJZIidrBKofJKyhDS4vd1Kp0nfMXNqZ5NF2wkDEfpFNlUMblTERAOFKE36aAu+QKtYFnpmhZhqk7j1N0MAVS1E/crq68Zh9X2J/XJMYgRtX4myWbxdGVtxOF2wtk5jA7iA1K9eYesCFExiVgaucxiRBWm7Li8Yj5Up/VoAuN9jNfO8s/CbUU5woz2ZmbD6kKRAKOxq6lnRsSvvR5TJjwYCybpqdu9AdsQfCjf+aPM+pEw4XFHK3TBx/EmnEquHcYfccDP3cokaayC9okbi1auX4DkOPbxkFHwIpuNFMoFw50cIKiKGi7EwMb18j45OXSTK/I4nrpiH/mCBVA6v31IjnW7LIjlxpmcQ+av8xymQ2Oce8KY3MHxT7AmtOtSEHzGk7z1XngSD5S1EQb0dG60boGEvH2eB/SH4nLZk/EIPXqyUYHBs7GGNHcUSJjlphfZHakXzljViPW2T2EFp9c0rUgh358iGpJNQqyTPxyeD4T9PuePbu/frKxjir9yF9fTiz9vmDl51NL7UAWG0Lx0Je0jTCBupk4YfOa+U47ywUflUQcBonUylKzgCAXqK41fHsag0X5ynbxvQ7aCevUo4og3jLm72qs1NghH/DZ4GC+17fr5woHa2SUIgRb4znTZEhx/4/wt6ceK/deTwhgg1PantOOd2hKBrVnkK9pDtqFtsB4EgrXpfpQX768OZvmJ2NjI5Rc8GHdUrZRWPXm7sqHjGsWoiTE0okYDNkNMleqBQQcF0EV+MLHKtsKAHE5kF0JaN5gWWqAkV5B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39850400004)(376002)(346002)(366004)(396003)(122000001)(8676002)(66476007)(9686003)(66946007)(33656002)(66446008)(55016002)(64756008)(316002)(2906002)(66556008)(54906003)(38100700002)(110136005)(76116006)(52536014)(6506007)(4326008)(186003)(8936002)(26005)(5660300002)(44832011)(83380400001)(478600001)(7696005)(966005)(71200400001)(86362001)(32563001)(38070700004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qBqUmP+rrGG7Yc4Febzgdrqw4ypFS0QFkPMBNCXzCsudfUfyv5kWpcOag8Q7?=
 =?us-ascii?Q?iiMap09f4uvCbRgzpdyHqb49tT+3r/z9cB1zTwSvRrxnRWGw0VTKGRueQGFZ?=
 =?us-ascii?Q?3EDbfii4/PgvxtmnMOuB+7SgnyLqhH3TqaamN7Dkc1KBg5ZCsRnUI8KUAifi?=
 =?us-ascii?Q?CELJFTsdok2EGAMS+nhb5TXLnK+UUyddeUs6TqEv4l8jCJoBhNJ+lF+t8nDw?=
 =?us-ascii?Q?mEw9ltxhuFAVEJjuM15PKN/YaQa4tAYdDCU++PT8GnrXr9GzbFch8FdbddkU?=
 =?us-ascii?Q?2Sh35V+Z51slsY18z4P0/AZyk+6rvCBeEy06221RlkP4QUQvXxkqZ8sppxHj?=
 =?us-ascii?Q?OcuxwMmplyLfnxRTctyT9e7Ao3QgbnXEkdX1FyuKHGIU7+y1J5O8pteHvQEc?=
 =?us-ascii?Q?nDjPwk9LNa/DieRf4dR369tCAEh5zPRasT1imS8raa1aHq3PAsbZAL3fatBk?=
 =?us-ascii?Q?JXPXEpYXlXd2LCEaRhOMT/gLA9BEACwPf1QqP1ZZI3UauiEIBpl1uumoyJ7X?=
 =?us-ascii?Q?xCT7ImUM7gU07YKa8hSVQuwHFAoJmff92QbxYI1e/Oqwhihx9L6tSB9fKg1s?=
 =?us-ascii?Q?S3GOTsPA+BVZjNZkNNxb4zThsY2clTnQjb/kcdSoSBdxgpp0JAFyEb3P8QSo?=
 =?us-ascii?Q?d0k04tZmrqRNZEDAfDKBY7weyMlxzCkNgIb8kWPKDxMBbycfetYlBKCnQNlV?=
 =?us-ascii?Q?UmSH0bU60noaEG7Ji+FNH7iSn+hzMLTjfeZHZ9g29jlvO0Mn2icMJKzB6du4?=
 =?us-ascii?Q?FCi8Gaor4hRPF7TeTVXJRRMX1PLPzf1zd5eDi14dD4AsAt5x8rCrk4gVy6Rq?=
 =?us-ascii?Q?KrcgftxdLhJXjIRqjHHIdIic3oc6zYWP2R+wG4MFuIDY9/o1SAD/+U1qs3VM?=
 =?us-ascii?Q?z6SoImD5KC0L87ZSguRJbpl6sDnUy1QsyAwH5b0eJpgVkO4oYRG5OuoQRjwU?=
 =?us-ascii?Q?xq6kmDvvcVWjei8c7C4u/XHHKXlOc27yA8FP6bIafCZocvFFet3t7ZOvVsA1?=
 =?us-ascii?Q?Agase2dawPcL/DpMioqm9+so4tVxhwaKVaz0bZURCbA/yBmbI2dqyGJJDH11?=
 =?us-ascii?Q?L24NFrHvXoEw1w+Ivu6xHSr0FG3fAn+NAJuGG/DjY0xDbOpTrDiCZBVVqYqs?=
 =?us-ascii?Q?L+DZrXS43dn5YqRdpozQ0GVfLB4cUStyyvk5C49y6aUYREdEWCsCJvduyPvv?=
 =?us-ascii?Q?F9kFwIAkOyrXX9pBgYMXGzHril93ltrFK1bmmaw/m+3dnVnQfi1Q+ugnuw/0?=
 =?us-ascii?Q?i5kIKmneAFuK4v4016nz5LzEtV4FbR9DAJWEOwu91/4RSGuzbjpsGfbdeTBl?=
 =?us-ascii?Q?Ikiux9uO57FVRlgqIwEQLsuI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d65c7901-954b-4f7b-7946-08d947fe35f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2021 02:05:40.1138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CR8WYrd4lFK3o5v7h46YdR3y7eiXjm3EXVxoOCIwu/XMpZIBkvIFi2bqg3QpyBw1r/NKtHi+8ubFI8spHW0jcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3016
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel

> Subject: [PATCH] arm64: dts: imx8mp: Add dsp node
>=20
> From: Daniel Baluta <daniel.baluta@nxp.com>
>=20
> i.MX8 MPlus SoC integrates Cadence HIFI4 DSP. This core runs either a cus=
tom
> firmware or the open source SOF firmware [1]
>=20
> DSP device is handled by SOF OF driver found in sound/soc/sof/sof-of-dev.=
c
>=20
> Notice that the DSP node makes use of:
> 	- dsp_reserved, a reserved memory region for various Audio
> 	  resources (e.g firmware loading, audio buffers, etc).
> 	- Messaging Unit (mu2) for passing notifications betweem ARM
> 	  core and DSP.
>=20
> [1] https://thesofproject.github.io/latest/platforms/index.html
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 28
> +++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> index 9f7c7f587d38..264ba540f363 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -135,6 +135,17 @@ clk_ext4: clock-ext4 {
>  		clock-output-names =3D "clk_ext4";
>  	};
>=20
> +	reserved-memory {
> +		#address-cells =3D <2>;
> +		#size-cells =3D <2>;
> +		ranges;
> +
> +		dsp_reserved: dsp@92400000 {
> +			reg =3D <0 0x92400000 0 0x2000000>;
> +			no-map;
> +		};
> +	};
> +
>  	pmu {
>  		compatible =3D "arm,cortex-a53-pmu";
>  		interrupts =3D <GIC_PPI 7
> @@ -698,6 +709,13 @@ mu: mailbox@30aa0000 {
>  				#mbox-cells =3D <2>;
>  			};
>=20
> +			mu2: mailbox@30e60000 {
> +				compatible =3D "fsl,imx8mp-mu", "fsl,imx6sx-mu";
> +				reg =3D <0x30e60000 0x10000>;
> +				interrupts =3D <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
> +				#mbox-cells =3D <2>;

I think better mark this node as disabled. If its clock not enabled,
kernel may hang.

Regards,
Peng.

> +			};
> +
>  			i2c5: i2c@30ad0000 {
>  				compatible =3D "fsl,imx8mp-i2c", "fsl,imx21-i2c";
>  				#address-cells =3D <1>;
> @@ -938,5 +956,15 @@ usb_dwc3_1: usb@38200000 {
>  				snps,dis-u2-freeclk-exists-quirk;
>  			};
>  		};
> +		dsp: dsp@3b6e8000 {
> +			compatible =3D "fsl,imx8mp-dsp";
> +			reg =3D <0x3b6e8000 0x88000>;
> +			mbox-names =3D "txdb0", "txdb1",
> +				"rxdb0", "rxdb1";
> +			mboxes =3D <&mu2 2 0>, <&mu2 2 1>,
> +				<&mu2 3 0>, <&mu2 3 1>;
> +			memory-region =3D <&dsp_reserved>;
> +			status =3D "disabled";
> +		};
>  	};
>  };
> --
> 2.27.0

