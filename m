Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C48BE36B106
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 11:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbhDZJuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 05:50:20 -0400
Received: from mail-mw2nam08on2072.outbound.protection.outlook.com ([40.107.101.72]:53216
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232239AbhDZJuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 05:50:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/92G/NaPWRuXhi9Ue1KYTxyOS3WH5L3JVheOAjKF07/3LDB3WHvb4OW3/Z7XNMBstZmJH8Ava4grgyMplymQZqQOlAr8deGGDsuhBrrKuqvor2s8ciNlPIpEZWz3BPRbKjYW3R3eRRz91YV6+Y/UGlH0uWQGJvPNJzWg2f40sNllSGpSQ6DRl9TYPH4QhsZVCxx4I7vsVMtVWQja+Cti4rRg15+ArKe0bRi4mN2f3y1cnk2t2VvrqPpe9CYRocPvIIh2wDZo56mz1NuKMYaMGn6MBnKQQxD1KnHHqv8RZEJmb+Dx0AbFvRPApfe8Y0j2N1OzvxOMu55DhA2m2o7wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdLzuHtcyaF8tl4ZSWRM+QjwzJ09jPEEGB4miijfz/8=;
 b=jsTinl+5/VwSuHq6HS3UnY4qYpIxbBC1fYBrFzjea/6sihXsRskQ7ZEH4rEvGvv2AVajDQHpCGwwtmScp3oPXZ6GZKG6rc0oryt06ioP3J3QBFcWFzfi6uzKpDMPE/jYsWPYjSyP9gQfmQW4KRdybMtyJEiCtf7kDk0DIZcGCFheuX6synTc/vir7vIHXRDBmjvweVO3hY4CnRHUcuDmMv8i2VXM3uV2h1FWRxN2KlmkDvtWTce2QAWICtiliJxrFvbww/zUqu5FpwlF57h57vLSbqoK3bJ8IgkMNW74Yo/8K5odKw/J5jkGMkhSI8ABT91Kq7zQKgpkCHcfbZCHLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdLzuHtcyaF8tl4ZSWRM+QjwzJ09jPEEGB4miijfz/8=;
 b=cEtyFMGaKRpk6st1c65Op17VX6TyN4FahIPqaLsDrd3n9UhGzUvIpJ3xeCGX8hRXeKw6MQxJ0mwclCBTVmZn2zYKdLb5KA5w3fb8wfbg2BVfmIpub4EL5daKQ8wxVbLma32G7ft+XbtBWgYno5JVnYJz7j29fhuq1UnbXlkxR1E=
Received: from CO1PR11MB4882.namprd11.prod.outlook.com (2603:10b6:303:97::8)
 by MWHPR11MB1279.namprd11.prod.outlook.com (2603:10b6:300:2a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Mon, 26 Apr
 2021 09:49:37 +0000
Received: from CO1PR11MB4882.namprd11.prod.outlook.com
 ([fe80::b5f9:c24e:b517:1ebe]) by CO1PR11MB4882.namprd11.prod.outlook.com
 ([fe80::b5f9:c24e:b517:1ebe%6]) with mapi id 15.20.4065.027; Mon, 26 Apr 2021
 09:49:37 +0000
From:   Tung Pham <Tung.Pham@silabs.com>
To:     Johan Hovold <johan@kernel.org>,
        Pho Tran <photranvan0712@gmail.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hung Nguyen <Hung.Nguyen@silabs.com>,
        Pho Tran <Pho.Tran@silabs.com>
Subject: RE: [PATCH v9] USB: serial: cp210x: Add support for GPIOs on CP2108
Thread-Topic: [PATCH v9] USB: serial: cp210x: Add support for GPIOs on CP2108
Thread-Index: AQHXLGMGgD5ujxjcJE2fqPf1pL8/T6q/IwwAgAd+plA=
Date:   Mon, 26 Apr 2021 09:49:37 +0000
Message-ID: <CO1PR11MB48829DEA0747C1B19278868E81429@CO1PR11MB4882.namprd11.prod.outlook.com>
References: <20210408103607.2077-1-photranvan0712@gmail.com>
 <YIA8HD0S6C+x5ZC9@hovoldconsulting.com>
In-Reply-To: <YIA8HD0S6C+x5ZC9@hovoldconsulting.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=silabs.com;
x-originating-ip: [210.245.53.52]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c1d37f72-2e24-4591-d207-08d908989aab
x-ms-traffictypediagnostic: MWHPR11MB1279:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1279C0D505A4CA93411E14E381429@MWHPR11MB1279.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jfjars6Ab3NGFpZJ8vcPAZvSxZBHhToiDNFt1KfHpdiaWhw47w4fCtwxR87+4CO1tvic9fpUxbr4EyGG4l89U8yYRsJEj5hYLS7ecY0tImaKv8YtmhgBuY/+OdYMfY7pjz5bTHiSDQi94/cK262YOJhDPbPm6b6H2wxn2O3zPb1s7PulaO5Dxp+sIh4hkrcpxqJ1DDXAezCHOrT3lukANSfGan8a3C26qi13UOaO7yL10qoelWKeSbTec3NvpbP/o7GX/D3OhLL5UIHRfPgRQMVl/UwqBcQWPPCoPCg8XcmN+0XWeQF3eMwb3u5fvjtx0wkvxTiYmRQ8uoWjQ/fHIgQuxobiTaaeWA+Sm8ElU2nBRXGNai3w2Vh7w+TaFplC6punF6ckS2pr9h+EJAQluQXFJ4WIFx0ijP2d7Tpl1JmJ2VrHVW0o/QqKqDUIIXRvYkwEDo65jXkoy/oO5/EDqAwuTMR8vO23aK24CBdfk4by0SBPaRsCYD59o/9gUD/YlBtomCDDN6bBFHlW3dRMn04BPO2k/Msc4UbPQ+ESWg/tye+u5f6LTu/cXQ4DBWpWygDyyrHJ/mdKzTxIZW5cxZUKU1lVBYLU3JjU4d2Exo+lx8ZeV+woZm1a/ajDWjXMMINt4qdn69X7oHgrGi30wt3EMkRBaR7Mn6mtBS0bWd4tnFvga515BZze2NOLjCQf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4882.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(39850400004)(136003)(366004)(396003)(186003)(26005)(8936002)(966005)(478600001)(316002)(54906003)(33656002)(122000001)(110136005)(38100700002)(55016002)(83380400001)(2906002)(9686003)(86362001)(76116006)(66946007)(4326008)(107886003)(52536014)(6506007)(5660300002)(66476007)(8676002)(7696005)(66556008)(64756008)(66446008)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?8oyD8Xssd7e3qaKMDRC09ZwBJfrNaaC5vi2uycT6mJz07GpcHWS+NEXG0xMU?=
 =?us-ascii?Q?lQ32OwqyaShMyoITSa0zGjMUOCqMXYsmYzxvwQrXwVGUQ8ldq0FC5yZ6olo0?=
 =?us-ascii?Q?M3oSPpw9c6UkCYgQAkJxSHx7a4Ydi9/DVT8GoGbLQON3/VTYWWBgx5G7qbxP?=
 =?us-ascii?Q?qIzemK/82eHcxmhl4bOl700MvDyoMwtz7PEvi/W22+1AIAgMjSIa4BPll4/h?=
 =?us-ascii?Q?hFmWIsj53DmT6Yiy19zy9IbGmWDkllepgfrRudArB93yNMZFal4QEm7WYyG7?=
 =?us-ascii?Q?z9cm9ivQP82dWguIKmfj5dINGLpOU8c36rntTBUvbNTAwTZiGdFWTm8s+FoL?=
 =?us-ascii?Q?O8OxUScnUjIouwQWOY/alL70RIg5b55axs2cLdkU81dLd0AKnYVerpGPWjWJ?=
 =?us-ascii?Q?OlPEHTtgUncDfZPlyDu71vRUyKqCArlpGi3J0W50z6v0mIMP8MRluXKyNiHV?=
 =?us-ascii?Q?taLSuQQOd5sxJ0CT4sXR2GJ2zdJ/xcHw3Llzd8F4n8+C1U/MKI5Kzbhk9/y1?=
 =?us-ascii?Q?mcbtMgDCppRD7BOIWMnlLnuVEyuQLcnqsz10X7tY4iYT0ghS3J9lVyEaESzT?=
 =?us-ascii?Q?vdcPJC1J3aDToP7Ej6GsvYBkWEi5Z9KIomHCz1oaATmlhcs+lwxypxKoguvE?=
 =?us-ascii?Q?RdjFegmPGFHV7p6F6VzQV7P9EgzxQmqbWJpJzZ78QPS7ILvQ7zU9wEUIOKCg?=
 =?us-ascii?Q?JA3kSpmsZ1wRJkZIRI7WrFHLcTj7ZJbUw8OycAW0HEjojArw73RV9JE4Jv2X?=
 =?us-ascii?Q?YbWOtRaLPEZJ+K/XV4Ru+jxSft21ghj3bwFX/+6pnjj3nEX20BFSt1D33s86?=
 =?us-ascii?Q?j0deTtqLszJ/Huuq3wE5Tu0mXcmtPDVZi3okEhpkMrDjpxh4KtznFJr3dX1J?=
 =?us-ascii?Q?3WtUstcPipGiTKj68adiay9eMGBNIV4wWgssOMAFQkVTyGYOyIeG05ipS9LG?=
 =?us-ascii?Q?sLFJYGBsIXALgAH0NeN7lFWd4seHlOZHO9ugc2HIxsYTwt/tFs9Vhyc26EbM?=
 =?us-ascii?Q?axImtiz51HlI0DG8y6GUBzoUNSrHrPyM7TghRmS7GShJqtJovXBLnFDtnb07?=
 =?us-ascii?Q?SJUvLdGoQXcF8nsq5NijxNPme2WE9hxc79db2awpoqA145K+zSAA0UxAsuWl?=
 =?us-ascii?Q?+j7mhym9D/zDy1JeI+iSM5bPHpxkwzv74etr+50qHGb3+fk1cerwu4zzrtGz?=
 =?us-ascii?Q?SIwOTYkNg8LWbzbxGMevu4GQI+lPvqsFGhpsFzeRziHKYNNAMnqqS40lMreJ?=
 =?us-ascii?Q?PjexIUzyDRr6kE/UxdOZKrt3HQDI1zf1Q0APIvNU3+kndb4F+tAZGZfYsVdT?=
 =?us-ascii?Q?TqU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4882.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d37f72-2e24-4591-d207-08d908989aab
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2021 09:49:37.1264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XPgtaGLC90iJNxp5TkW70PyAT2kSVj3L2V/bNUdvdoyHTWErYoTdOFAC2bNx5/u8o/PD1C1ohkts2gryV6qNfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1279
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Johan Hovold.
Thanks for your review.
I read you comment and answer you as following:

On Thu, Apr 08, 2021 at 05:36:07PM +0700, Pho Tran wrote:
> From: Pho Tran <pho.tran@silabs.com>
>
> Similar to other CP210x devices, GPIO interfaces (gpiochip) should be=20
> supported for CP2108.

> +/*
> + * Quad Port Config definitions
> + * Refer to=20
> +https://www.silabs.com/documents/public/application-notes/an978-cp210
> +x-usb-to-uart-api-specification.pdf
> + * for more information.
> + * CP210X_VENDOR_SPECIFIC, CP210X_GET_PORTCONFIG call reads these=20
> +0x49 bytes
> + * on a CP2108 chip.
> + * CP2108 Quad Port State structure(used in Quad Port Config=20
> +structure)  */ struct cp210x_quad_port_state {
> +     __le16 gpio_mode_PB0;
> +     __le16 gpio_mode_PB1;
> +     __le16 gpio_mode_PB2;
> +     __le16 gpio_mode_PB3;
> +     __le16 gpio_mode_PB4;
> +
> +
> +     __le16 gpio_lowpower_PB0;
> +     __le16 gpio_lowpower_PB1;
> +     __le16 gpio_lowpower_PB2;
> +     __le16 gpio_lowpower_PB3;
> +     __le16 gpio_lowpower_PB4;
> +
> +     __le16 gpio_latch_PB0;
> +     __le16 gpio_latch_PB1;
> +     __le16 gpio_latch_PB2;
> +     __le16 gpio_latch_PB3;
> +     __le16 gpio_latch_PB4;
> +};
> +
> +// Cp2108 Quad Port Config structure
> +struct cp210x_quad_port_config {
> +     struct cp210x_quad_port_state reset_state;
> +     struct cp210x_quad_port_state suspend_state;
> +     u8 ipdelay_IFC[4];
> +     u8 enhancedfxn_IFC[4];
> +     u8 enhancedfxn_device;
> +     u8 extclkfreq[4];
> +} __packed;

One more thing; I noticed that the layout of the other port-config structur=
es do not match the ones used by your library API, which is what the above =
pdf documents (e.g. they have additional padding).

Tung Pham: the layout is correct, the document add padding bit to align dat=
a to 8 or 16 bit, we already use      __le16, so the data is aligned to 16 =
bit.

Did you verify that the above layout is actually correct? And did you try c=
hanging the pin functions in EEPROM and make sure that your code handles it=
 as expected?

Tung Pham: we have tested to toggle GPIO pin in normal case, we will test t=
he case that the gpio have alternative function in the future.

Is there any corresponding document for the actual device protocol?
Tung Pham:
You can refer to=20
https://www.silabs.com/documents/public/data-sheets/cp2108-datasheet.pdf
for understanding the functionality of cp2108.
And=20
https://www.silabs.com/documents/public/application-notes/AN721.pdf
for use simplicity software to configure the GPIO pin alternative function =
of cp2108.

Tung Pham.
