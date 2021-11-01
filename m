Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99CA8441FEE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 19:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbhKASYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 14:24:34 -0400
Received: from mail-bo1ind01olkn0151.outbound.protection.outlook.com ([104.47.101.151]:46304
        "EHLO IND01-BO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231803AbhKASY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 14:24:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJROra+3o2JzAcYnIuVutQYXEBsAojsJSaMeBOuJigRhZe3lS6FaPhgDcf9x1LYjKCz4w6B0ltqTLCu8asl5x9SQLdYvB2tc/b4KL/50Uwy3Kg/FlkCD08pNiAhWGrGBZclTomIaeasn5sLo41VXnYDuvr2TvDuje3q0cWhQ3d2bb8rK8shEZwtsbdt+wH4Hz8O6JvPSANAQFKcDLK/NdmZlWLPjT4Eie2SsmXH3/mpwzGK384ssBCtlH/Y+GM5EWLZesF5VbN7bEz+mpjsOqiDvpcavdnUyC72QlzrUiOY6WdbaejnmJSz1Ylyag3HvEXpY/RRQrZxmcVAaCrYkzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5El5MtqHOfK/ckHZNc4r4q9cB1iJ6iOSEXeaxcQb6TY=;
 b=LNv90JpIPtn1C4vMZE9oqzsruaDkkyzJ/cDZeqn7SmuPDxr081i1nkbpwhF1Yc9vbFrNYOaHpRAIbvH+siqgmffw9DilGsybVpgbItaflu9++j3wkpGP4SkJlvsqvpGPZ4OcZ4q0xYJ7HR58TgE/5nrElgqV64gQxneX8ILuRDd8ih2TwmVQcOWoUb1tufQA7RX8KLOi4HlVSsLjX1gywkwY7i0Uu+g72Rism9t/HTnRYLQHy3W3oYZkz5ZSItXmEcjEUIZdZw1JInmdvpNw/MR/Pb5pFLpqeuSZD1m5gbEbmxqZdRdFQg7zhgO5wQ8NsQGWyc6fSU3TOppmcA275A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5El5MtqHOfK/ckHZNc4r4q9cB1iJ6iOSEXeaxcQb6TY=;
 b=A9RNSfnvQJbrLrx4zqVJ1BIXpzxwQQolRzAOysMiWXJtyGUkvmJpzDhWCdI14JZM0coD0WrojPn/KyVOtXzc4NK7XE+6i7OKqszzC2TOnzn+RyVtXllC2bSndEhvMXug5NMAOtvRhbJb0ot0o7PtNg7Z4RLfobRJM+R/lNGd2n6Pkk434m3xjC7hUk2syD5p1ncJz/+u4tCWXNoaTnoaJlVbBCzP+2shh5t+SuCJA54D6bRuWGE9kUbUp8EfZDSuBBsjtT+3uz3t5HhEB0lHTOPW7rfpu+T3YgJxQQDpngkY9hiAVbuL0qlfkXvtLeQ5Ue58mGpqcGp5pnBW1IT4hQ==
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1b::13)
 by PN2PR01MB4619.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.19; Mon, 1 Nov
 2021 18:21:51 +0000
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::cdc4:def5:dc73:28f7]) by PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::cdc4:def5:dc73:28f7%6]) with mapi id 15.20.4649.019; Mon, 1 Nov 2021
 18:21:51 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Lee Jones <lee.jones@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Orlando Chamberlain <redecorating@protonmail.com>
Subject: Re: [PATCH v1 1/1] mfd: intel-lpss: Fix too early PM enablement in
 the ACPI ->probe()
Thread-Topic: [PATCH v1 1/1] mfd: intel-lpss: Fix too early PM enablement in
 the ACPI ->probe()
Thread-Index: AQHXzze5+8zaA4lX8kqvqw6Y5J3lYqvu/DyA
Date:   Mon, 1 Nov 2021 18:21:51 +0000
Message-ID: <E051196A-C49B-4528-B72D-0BBC907AABFD@live.com>
References: <20211101151036.33598-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20211101151036.33598-1-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [YbPIFUgBvr/4NYaWazBGE7IbI3nwIBvCNeu5MTTxfAjZGsVElN9RsZ8dAErhHM3Z]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae52711d-d30f-4d54-2c91-08d99d6479f8
x-ms-traffictypediagnostic: PN2PR01MB4619:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M5ynaGQC6NAsIScohFav1X1pCuMpk1m5ZVDtFozJ750cgSDjtGea9fvmZZc5g19KUT8yJ6ofcHsMWNwGE5wejJOesiH/JDEjn/KXyM76zRLmXAn7CpzdVQkBPhFB3SR2QzvIMvJOlZNMYbrupC+3b8axspwZsYcj4GO9MhlsTnwhXgjABtwSll0tptpw08syCvGdCTN3KL5/lTnY/chwTnTedF4ZO2679+b21eXtYgUOqd15asFrgeyJnfUiZDlyQXIACzKagYdU4k5jWvblom1Ia7Vxu+kHSuc3f2OpbyuI9aFnXlnxvJKQ+CxKYsrpe3sNmaoLLvBBTTZPpFEf2C9WirsBfaCIIGWty/08sQr32yRuuNCkkIGgTJJRD3FhRp41guZL4ZaorMRSdZ5ee3P3+HKr7eSlI3ROiiBaPL/67qCPckBFV2227dnLIy52PVFyVOtjak+ArklL9RH0xvYiJXitFTJLYtPho6T1iF9aN2JfCiiyfgiVuKAyVKH8qVBcmQt0NLhBjBz905soUwFNqy8e644jh1vzxbHqkxA=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 96Drcu/NbvE7Os/29F7U6K5IjKeD0GRHgPme6XLQ3Rg8tqMy2BQgaXUTD72MDw9XnpIRjONzW33Qly9HTc5qAq3cc4M6ZmHLPpqdVXmAMQyBf00CW7ZVmCitm4IVK4+KKUpJrS4C1IFPYaU2009v6fl9PaJXNEzH7kKE8nblwdnNYUK5M+HL8+iUf+Wbk6XJym28O9AwmyXG03fXakTuwmNdTEFM+B+o9jNAjqSHR8uyrDRZf/xiXa6RoGMrZoaZdfA+VbRvUD13y/GOYekCiq/KxICrX/stBQhL4inTpWGG0nPQk+c4Oyg7gidKlU7g4XhWD/qXD5Yk9XQ+N/R99QRBE+zkebRTM6o4o3xcAPO1ye7cRJZXBnUsoCArWZaxyHO61+Oz6vR8unhTYGBVgAI8GUZx2zZHdS7GTmXLL7Q1l/a+bFX96Mtg5KsQCRMxi4MZpBrQhbesV0LwI79t1vsBt4r7pfYkBeduxp6/JYfDry+Weginye/GG3b9gKKUtkR/wuffjIJsDUd2EAVJs0jquhXCqS4tlK46pwPjcSFfYyacEQxfPfzafpyLjVF9YxCFd4MXqCsO0QrDOZ1Yjt9fF4EHGaZvJvkwkFxXpQgJvX5EMuQiMAc9ZiBuPHF3oJSH9CoVNh4naDTml3b0Crr82WqQ5RLuVW9aXyeuuOI29+mtrO8dpEXWM0g8XxwzKRc/YglTY8HGysv5IKnYlMaeaQ2/I50aSJep5h2ZCHGm/+HQCtqDG/pDcRG5P1L9FNY5B2bySVMtKkJX4LRbiQ==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <957B7D2395EAD247801264B81A288637@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-3174-20-msonline-outlook-a1a1a.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: ae52711d-d30f-4d54-2c91-08d99d6479f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2021 18:21:51.7327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB4619
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 01-Nov-2021, at 8:40 PM, Andy Shevchenko <andriy.shevchenko@linux.inte=
l.com> wrote:
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
Following patch fixed the issue for me.
Tested-by: Aditya Garg <gargaditya08@live.com>
> ---
> drivers/mfd/intel-lpss-acpi.c | 7 ++++++-
> 1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mfd/intel-lpss-acpi.c b/drivers/mfd/intel-lpss-acpi.=
c
> index 3f1d976eb67c..be81507afb5e 100644
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
> +	return ret;
> }
>=20
> static int intel_lpss_acpi_remove(struct platform_device *pdev)
> --=20
> 2.33.0
>=20

