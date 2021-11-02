Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7EA44426DA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 06:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhKBFpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 01:45:16 -0400
Received: from mail-ma1ind01olkn0162.outbound.protection.outlook.com ([104.47.100.162]:20457
        "EHLO IND01-MA1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229486AbhKBFpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 01:45:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJjPJaIqiHL0BqGS9VTydV0y0B0LvUiltFSiJZoTE/t/Hz+sJV1DU2kGnxjdIr/Gv9DI+w72kYE6zO6dJEoIQ2CkK++RhxBm7W8cDnj6J7NXk62ot91u8A7oNhfwHebyAvNTA2sOCtfFb9S50i9Xav1WRkgAq1WG3eNdLdacXvAPphLfxbiI/z5dw7HdFF2vD1GEhhViTwyCqXTT+cUGB5pT+O2ih1hzCXsh3jqbQssQiyPOpntFOqluItzX4JNDyEQxPqvxycXRdIr2fFNJzYDgIpAwCDqRE7uNjKfCETqNfTRdLXOLTz1Bz8AyYM2QIOgKNtIizuL42lSnXNfVcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cv92y2GBdwrajEU440Pu9C+M+HxSJw2CK1zbHhyvKko=;
 b=e1XiELvbFF/PvjE6kJ5ljui4WQH0f8I99Z0LMBn+Uu9NJOohvvzZqglN7t6VZTeMMM8F7o0R8HOgZGQNNXzQvzkDq/nbdzjpivhMvYqXrINdt2fdGaO3ezW2nFWtuV8yuSSopJZriJXUH8eMbvKlLDGBAOjkgrQx1IU/eqxryozVpQ+RM0RLY01lVDACbrPoX9of74hcm7d5mqTN3Iqw05tfP37o4cKtmbs76y0MLjXANkYyGqmLcuTu+3iFnuE8bgwOGqLKd+/CZ7kETdmGFTMf3qDQO2+4vhzDvZk0turTJNL7islElFcOsoW2xuMwKm4RzbmXPJS6gWiQG7fszg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cv92y2GBdwrajEU440Pu9C+M+HxSJw2CK1zbHhyvKko=;
 b=G7rO6wkH64SJG6JrikwXsstYVx2k1qgOdbY5zEipvnhLt0AYjs3WrSrA/XGsI1Mm0YV//fGAEZAP5dy3/r2XvEfeqkD/E04zbMjSShCiiZnaD/Vm1xWSE6Z3Yxvu9bdg25sI0qsWFra0Uebn11WcnQlOqMrVTDsRhecZLjW56VfSdbJ3295PGGa/m0YZmDUcQ2UZZKD5cVtBfL4jQpGvuG4Ch/36l3DRsb8we/wRhXlCW+6GSOkmw67h3TuSHtQLYARwYfdP0oOZUDOkQ/+xAwrKSngmebCwqmcf0DUTFRrK81roT1NikIgiq4DFiqvbAUHC4hkCtmafr5IzU5rHrg==
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1b::13)
 by PN2PR01MB4155.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:16::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.17; Tue, 2 Nov
 2021 05:42:35 +0000
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::cdc4:def5:dc73:28f7]) by PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::cdc4:def5:dc73:28f7%6]) with mapi id 15.20.4649.019; Tue, 2 Nov 2021
 05:42:36 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Lee Jones <lee.jones@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Orlando Chamberlain <redecorating@protonmail.com>
Subject: Re: [PATCH v2 1/1] mfd: intel-lpss: Fix too early PM enablement in
 the ACPI ->probe()
Thread-Topic: [PATCH v2 1/1] mfd: intel-lpss: Fix too early PM enablement in
 the ACPI ->probe()
Thread-Index: AQHXz1K0+zuu1geZMU+SN/8K9KOqdqvvujiA
Date:   Tue, 2 Nov 2021 05:42:35 +0000
Message-ID: <54F23B0A-9DB9-439A-B3BA-E1141703E91D@live.com>
References: <20211101190008.86473-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20211101190008.86473-1-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [zPWoWU4DwEqrltBZfdqdOe2zGQ+MQsLmbbxu6agobyxNzrTxIA8587bqhxkgynoC]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d905568e-64ad-47aa-1bae-08d99dc39305
x-ms-traffictypediagnostic: PN2PR01MB4155:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YzaDhxnXxeK+oKOO3bNjijB6MF9sQyMpUDiQ0Edj9TeiWw4GP9UtXnX02JQV+rWXdxjGppVyYni1ub0uKxOK610kK9/yycGMTfPR09HkY1kFdehS1ESJj7BQq0sJTg9ZysKYbH/JNd0/0VDH9dIN117M19799QG0bvOhMibIjheFxhnTEn6ZeUjD9284ICjq1dglIQR91lylrgS62VT7lPXUi0mTKcFHiYJYXyIWFAm60aYT0ySDsXFoKkxTVgfKi+s2Nwn1uSzJP+bg39HwTY7iFbE7u8k7tpU/ViowasI1aH14Q7qhdOFBCdmWP8/4piXhORGCHlXOkDAPn+LcUrQGZEhm0pyTBbXiMyINXkRAPBQH/a+aJpbgo193f/z9WgRy6kKfGugxNTLh1O0Zl6TrzVTx6asWHbA8rfC/iOXG/GXnBBs2O01Hcz2RnovuyDGrU+AsUf+2WRvw+o2nRhVRi4Zh/uUZdozeh+1+/Dwll3nbn4MASuMbvb7fN6/Y3SNohYs0YCagSudiG2Gzwtyon+P2vXe+4X3Hb6lLCG8=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: I2GO7OCEg0LugnPyhlEl7J0sncEPvqI3gb4OpqKYVTx6h3lfUa32ZnBRbCYgxQOohauJA2uy1wcPJMPOK77bdA1+p0pQJnMXx4Wt9nP4D4m9nccvP0yBPtmFT7w+rWDfYoPr5TsvZW5TAYvQYLQDbXWpow2IXLm9Vz06GKNv78dqEBV067+pTPq76lPdQxx+XQxK5LbYzXOISJSAdvAYjmMYwDkx1WXPX2Tz8ehZzEEIiO6ZwNKlFiuumlnDoFzZxw/eKect3+5R3dMqROjWWG2NlDGFUvA+g9syZfLyzE9xlcpnYPOISXnVG1oOnFvrWUHKGuaGsPJY7LgWmU0aXF+3mBXzfp/kqwijKFvAnOyzYxIeU9TFaNN9Hg4sY+TJ3fGjTVTsQXSErnvG6MqKVPikfBCcHuau+iuQwwSmamPMqVUFETkYL2395XTBAawOFTK6WdPZj4wTHZsSOyTFMR1YtkYysKGJ3JYs7AJcyXJoR/s9VTxoPFgmPkXpNfCeJCc9170qWXPBIglBi2CzOmWkVxVKBY3GDyqt1w+YgJfx6qpyTEDx/Z9UXLG7oZy0vLx11Aik7wiz+RnJrqSYxQUEZ4A/ugOH8sc+NEh2SSUPihR71/QM+OwOg0cJ23yPyeu5b5hP6nZChSJGFJKdJXmbDKAzoa4EbhpHVuTv6y11toTaJ2Sx0/kDM+n3udl/K+rBS1f7cdBwFAwfAWT+HKh9gRr8EOAutFCgHQxEFtWK8IC5YsTgttlAAvY8vG5Z8YO3EvbDXz5WR6ASQzCujw==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7592E5B0BF99654DB2C5CAD35A483FAD@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-3174-20-msonline-outlook-a1a1a.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: d905568e-64ad-47aa-1bae-08d99dc39305
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2021 05:42:35.9688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB4155
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 02-Nov-2021, at 12:30 AM, Andy Shevchenko <andriy.shevchenko@linux.int=
el.com> wrote:
>=20
> The runtime PM callback may be called as soon as the runtime PM facility
> is enabled and activated. It means that ->suspend() may be called before
> we finish probing the device in the ACPI case. Hence, NULL pointer
> dereference:
>=20
>  intel-lpss INT34BA:00: IRQ index 0 not found
>  BUG: kernel NULL pointer dereference, address: 0000000000000030
>  ...
>  Workqueue: pm pm_runtime_work
>  RIP: 0010:intel_lpss_suspend+0xb/0x40 [intel_lpss]
>=20
> To fix this, first try to register the device and only after that enable
> runtime PM facility.
>=20
> Fixes: 4b45efe85263 ("mfd: Add support for Intel Sunrisepoint LPSS device=
s")
> Reported-by: Orlando Chamberlain <redecorating@protonmail.com>
> Reported-by: Aditya Garg <gargaditya08@live.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Tested-by: Aditya Garg <gargaditya08@live.com>
> ---
> v2: added tag (Aditya), returned 0 explicitly at the end of ->probe()
It works
> drivers/mfd/intel-lpss-acpi.c | 7 ++++++-
> 1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mfd/intel-lpss-acpi.c b/drivers/mfd/intel-lpss-acpi.=
c
> index 3f1d976eb67c..f2ea6540a01e 100644
> --- a/drivers/mfd/intel-lpss-acpi.c
> +++ b/drivers/mfd/intel-lpss-acpi.c
> @@ -136,6 +136,7 @@ static int intel_lpss_acpi_probe(struct platform_devi=
ce *pdev)
> {
> 	struct intel_lpss_platform_info *info;
> 	const struct acpi_device_id *id;
> +	int ret;
>=20
> 	id =3D acpi_match_device(intel_lpss_acpi_ids, &pdev->dev);
> 	if (!id)
> @@ -149,10 +150,14 @@ static int intel_lpss_acpi_probe(struct platform_de=
vice *pdev)
> 	info->mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> 	info->irq =3D platform_get_irq(pdev, 0);
>=20
> +	ret =3D intel_lpss_probe(&pdev->dev, info);
> +	if (ret)
> +		return ret;
> +
> 	pm_runtime_set_active(&pdev->dev);
> 	pm_runtime_enable(&pdev->dev);
>=20
> -	return intel_lpss_probe(&pdev->dev, info);
> +	return 0;
> }
>=20
> static int intel_lpss_acpi_remove(struct platform_device *pdev)
> --=20
> 2.33.0
>=20

