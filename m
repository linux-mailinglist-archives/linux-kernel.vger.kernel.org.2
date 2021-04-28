Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4171936D233
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 08:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234486AbhD1Gar convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 28 Apr 2021 02:30:47 -0400
Received: from de-smtp-delivery-105.mimecast.com ([62.140.7.105]:35754 "EHLO
        de-smtp-delivery-105.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230490AbhD1Gaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 02:30:46 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com
 (mail-cwlgbr01lp2058.outbound.protection.outlook.com [104.47.20.58]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-33-vZDCqs73PEqhodFzszGmow-1; Wed, 28 Apr 2021 08:28:07 +0200
X-MC-Unique: vZDCqs73PEqhodFzszGmow-1
Received: from CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:89::10)
 by CWXP265MB3351.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:da::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Wed, 28 Apr
 2021 06:28:07 +0000
Received: from CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
 ([fe80::a91f:361d:5554:3958]) by CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
 ([fe80::a91f:361d:5554:3958%5]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 06:28:07 +0000
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Soeren Moch <smoch@web.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "jbx6244@gmail.com" <jbx6244@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: rockchip: include uhs support for rockpro64
Thread-Topic: [PATCH] arm64: dts: rockchip: include uhs support for rockpro64
Thread-Index: AQHXOyz+Y+++fPZwnUCCEHYwxF4ENKrId5wAgAEALc4=
Date:   Wed, 28 Apr 2021 06:28:06 +0000
Message-ID: <CWXP265MB2680159B5F44B014FA544E89C4409@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
References: <CWXP265MB2680938B222248792AC205F9C4419@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>,<97bcbcde-9ccf-f9cc-ef10-36cbd582825a@web.de>
In-Reply-To: <97bcbcde-9ccf-f9cc-ef10-36cbd582825a@web.de>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.80.168.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5aa04b6-d9d8-4aef-1841-08d90a0ec934
x-ms-traffictypediagnostic: CWXP265MB3351:
x-microsoft-antispam-prvs: <CWXP265MB33512C693934D91556A20136C4409@CWXP265MB3351.GBRP265.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6430
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: us2m+PTxtj16eAN+HRyylrysdFEUQVO3lfhrly2OCRYiIKW/3QdzRq7Hp0ZwFK7dMAOTVXEm+qlSNHgwPW6JmqtMlZqdk0Hm5TgmJBpoHREyssD5iQTgwiuI4WAnVJsQvWv9dLfoz0M30u+vcXVy5/NNOFVs3LlEn0VUnUd+HEjENOvfqjKI0/Izd3QPtLwqdlPSN1LLZnXEJlzXxFYjj5ve10JEyp2BHwZIrLNPGfIKZDMC4HniHPAAM99qWfKc3fO4N9kRCxHSsqdsaI/8sxI/sm5dWNwsAB5Heqw5Fb9wIuBhpHRpiSZ/XyQ78xEYQLCvaoD98RQpjfNqSR55JYM//3O7VLUwUy+A/UYT2pN+LK1E3GE9IAWwXNw24FYCNsSCkEX2v2Zon+S7qUdUhHUQV2AHVLM9jeoWtqCA4QXy79dTjDf/j5AAkF5ydjP70NSkJtjEI0BoqruFDAeqKLflYQpZdRq4s57fC+yzzvXyXVFAOlP23GvJaI5tFOECxqhEzlzroOs2SqyvwC+U/O/f52TgYlUkcz2LrS88tQfOa58ZYRBCTpPTKtP3PnJn+Fy95xU5sLzlU5VDqYo/GgZAu5fEAKu//BUoY3SeOFU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(376002)(366004)(346002)(396003)(39830400003)(91956017)(64756008)(66446008)(66476007)(66556008)(52536014)(86362001)(110136005)(76116006)(66946007)(9686003)(7696005)(33656002)(6506007)(53546011)(5660300002)(8676002)(71200400001)(8936002)(122000001)(2906002)(38100700002)(186003)(26005)(316002)(478600001)(55016002);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?DbFdr/Hs7vXrkYf0zwsHWnhptyrllLTprkUeqYl+XztseRw9b8B0V9Ny9c?=
 =?iso-8859-1?Q?ML7T0sh8I0UigXUr63csZLQiq2mD5ZBlMdeJZrSM1IJSQkIYxu4CZK540I?=
 =?iso-8859-1?Q?65C+9lpFbv/6zx2TQgL4rXyc6V3PjHWuTQuAqVTog85F6E+aFhNz2V6/n0?=
 =?iso-8859-1?Q?YyQvqucR5mRZde1Vs6ivqrpdE9fGmGcLjsOTmUhcMyxOoRSYqhcnyQPQFr?=
 =?iso-8859-1?Q?ckXA6cqPl3oxtHeZisw6hDwzmhsAJr7pGNmP5nQ9tsrYsSz6onabGnd626?=
 =?iso-8859-1?Q?m/Ve3eextqWfI7tNgB08bdme3PgGiRwqKF1UbGcL1n5EZ6CcldckNq36xb?=
 =?iso-8859-1?Q?2EcoRY5F/Q9Z6Ndv4OBA8DqE1c7UV4YRINUewyjlxG5F2kau4etGdbP6wD?=
 =?iso-8859-1?Q?QvGadKb51qj9ZUwhkyYKzeN2L75q3kVnutG7A09K4uMaFMeFRDvtWiC2GV?=
 =?iso-8859-1?Q?T8Sm582efkIsNZBuW1DFqt0q6stNNx5mg1OEjplCc7quYJKjyb6o6UTtc2?=
 =?iso-8859-1?Q?2AxCCoxjacho0WKaIPz03Da9Gb+wd6+ognPPVPpf2ASPAGI+czC6v/2P2s?=
 =?iso-8859-1?Q?CFNavEJ3aXYxC6v219lwRxgOGZvzm4yFQhPuHMOauQLR8i8pXVu1PTMZj8?=
 =?iso-8859-1?Q?me8SwGGvD1q9XZrnu9g8w4QL8cIvpGbrfRNdf1Qxtv5ktnpMNyTt3lJ1NH?=
 =?iso-8859-1?Q?PmSfH1tlGYm3t/wQNbZCsdHeNLxBPYgWMuJ5kPWRR6OWFaxl1k2I2o3Hx4?=
 =?iso-8859-1?Q?V0delTFplDaJJb5mprxYqoQ/f6+aZv989CGHV8rkJtp/yncOUkG2x1eE2v?=
 =?iso-8859-1?Q?FIO4TQsW2AN+pUjIDmmeML4rHYa8r1O4jvpsU90TC2paxAW4nupqGM8uMO?=
 =?iso-8859-1?Q?PYDWg0IOiZNvtJMk4MfLf2E5T5WDmCVB27DEwm2IA7Vdzy5hFxc3JKsqEw?=
 =?iso-8859-1?Q?w8tPRrCzu9405cadUYGjJjuq1QOn/boxRUzgsKFjk75OE5PJ+wr8hG5Rts?=
 =?iso-8859-1?Q?n+WNJ+DDVQsmctoL2pIIlSF8RGs3Sg6rpa4qYI2eaYHueNEOOKNJU/4rcv?=
 =?iso-8859-1?Q?bxP5O/t1iRlZqsxAPzL4NTdChq7TIu7Jjn+Q4Lz9Gxw0XgRmB2Thhn+PbM?=
 =?iso-8859-1?Q?zazoHw/ZAHTdmxKxtAEXouInnIZas6dREW3lIfafvB13XbjCcF9Rk4tSi9?=
 =?iso-8859-1?Q?4Sivj8nn2JGV82gCHnYa88BOCZy546oJedqqeX/ihbKvNHcqwNTatnnocF?=
 =?iso-8859-1?Q?sSY5RGwBOhE/OciHd4ficoghB3DkO2oF1ATGYD3wGTNdYt20gen8mQ3FPJ?=
 =?iso-8859-1?Q?c3oxVhKhqWpG/ZfZvKkCkrayxgbh8Q0fk9ZW6/TfMGXHMvI=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: hyperstone.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f5aa04b6-d9d8-4aef-1841-08d90a0ec934
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 06:28:07.0005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 86f203eb-e878-4188-b297-34c118c18b11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M1+MKhcQTmBhmfJtsPtUa7rTI70zbDMOGSlk83XFua3Y7g5oDmrnvNqinTQVgpCDwAQfRjcGpQ19sr6/PTqnEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB3351
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CDE5A68 smtp.mailfrom=cloehle@hyperstone.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: hyperstone.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oh okay, I was not aware of this issue
and have not encountered it yet.
But wouldn't it be more appropriate
to get u-boot to power cycle the host controller at boot?


From: Soeren Moch <smoch@web.de>
Sent: Tuesday, April 27, 2021 5:07 PM
To: Christian Löhle <CLoehle@hyperstone.com>; robh+dt@kernel.org <robh+dt@kernel.org>; heiko@sntech.de <heiko@sntech.de>; jbx6244@gmail.com <jbx6244@gmail.com>; devicetree@vger.kernel.org <devicetree@vger.kernel.org>; linux-arm-kernel@lists.infradead.org <linux-arm-kernel@lists.infradead.org>; linux-rockchip@lists.infradead.org <linux-rockchip@lists.infradead.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: rockchip: include uhs support for rockpro64 
 
On 27.04.21 08:20, Christian L?hle wrote:
> The DesignWare Host Controller has full UHS-I support, so use it.
Enabling this UHS support makes 'reboot' hang when booting the RockPro64
from SD card. It would work when booting from eMMC, or with a modified
ATF which does a power cycle on reboot.

But for general use it is not save to enable UHS support, or did I miss
some recent changes?

Regards,
Soeren
>
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
> index 6bff8db7d33e..d22a489ec214 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
> @@ -722,6 +722,7 @@ &sdmmc {
>        max-frequency = <150000000>;
>        pinctrl-names = "default";
>        pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_bus4>;
> +     sd-uhs-sdr104;
>        vmmc-supply = <&vcc3v0_sd>;
>        vqmmc-supply = <&vcc_sdio>;
>        status = "okay";

Hyperstone GmbH | Line-Eid-Strasse 3 | 78467 Konstanz
Managing Directors: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

