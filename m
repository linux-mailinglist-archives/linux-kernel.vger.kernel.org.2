Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1AF944798D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 05:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237559AbhKHEwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 23:52:33 -0500
Received: from mail-bn1nam07on2045.outbound.protection.outlook.com ([40.107.212.45]:6969
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234532AbhKHEwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 23:52:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VzmBOogVVA//gxD4kA1YyQ9vTjUrDssNTnapWv+/I2lVNW+WxZQCYY4lmf/qkaMbeS84VG48jyUMY9dmEO7wEojlllHIwYdgPnq3tIKuOHVW/vt0+fCNQ2fph86AZdR+PjZXuIOzS1G5Az+JLykHOu/IfOVr6y7jP0lfxKndVzNA29mTqpiTelFjZjK1SAwjJzxiDXRzdIaveCV2vF0R4KuntHpRNiCYJSIy7wJAtMUu6RFcf1WEivPzbIYAbCqnip3JO74Pcn76LwtlljUZEO5d8tXKRqnO47gMuF2voyWR9L+fprxQVMuNM/y+cKk7LTTgjgZ4/ONu7cKbwR+Brw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pqf0ySaHSamHoxqy+OLBmiV997WMvwaKSK6aBVsQnmI=;
 b=ef2KTUluw1cWGNs84iO3x5pZM5VKJW2SGG2mXn8RDSa9UlURFUfAZAq0RihRVwAPVTiRYDAhNCMds2ldXGw7r4O8B2FqH7+gMc/HZYgTj14rudhskRDoGElX6Yc4iZekJWR9HP+is/TZE36hoDrCBwrlHk47na4JzYi0co6z/EhhFpSd9+Q+VfilTRWdMxbiR+Jk/jxI9X9Oxg+PBcGzuiHYkaTNFAbqbk/tQfh+TK/ZuDK4TiHpMkGnPPn4h/q2v2LwRpUHI3HAFxtvE14h3L+ZbJoRZvIHX/CgGBDeQW3ve9uki/sGboCNOd/qF8YzyUek6aoj88KlIM09qEdO0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pqf0ySaHSamHoxqy+OLBmiV997WMvwaKSK6aBVsQnmI=;
 b=SpIlumkv882rJ6zJ/XEjiz/uLA1htydhy4rps9XV+BKnUPG9+tRIh1Emj3XXgTNSNyAYpOuDG5joY/XuOtYBLqRj5sFQJSg0b6UxjcJGUlZ5p1VhvzZVr+hX2HfIIxYxPhy8bH4P5d8WDVIN/3VE+U5Or8mQZpJYV5WZ+HpUB4s=
Received: from DM6PR02MB6635.namprd02.prod.outlook.com (2603:10b6:5:221::18)
 by DM5PR02MB2812.namprd02.prod.outlook.com (2603:10b6:3:106::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Mon, 8 Nov
 2021 04:49:45 +0000
Received: from DM6PR02MB6635.namprd02.prod.outlook.com
 ([fe80::987b:184a:b206:565e]) by DM6PR02MB6635.namprd02.prod.outlook.com
 ([fe80::987b:184a:b206:565e%5]) with mapi id 15.20.4669.016; Mon, 8 Nov 2021
 04:49:45 +0000
From:   Shubhrajyoti Datta <shubhraj@xilinx.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Michal Simek <michals@xilinx.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "jiapeng.chong@linux.alibaba.com" <jiapeng.chong@linux.alibaba.com>,
        "abaci-bugfix@linux.alibaba.com" <abaci-bugfix@linux.alibaba.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] usb: gadget: udc-xilinx: Fix an error handling path in
 'xudc_probe()'
Thread-Topic: [PATCH] usb: gadget: udc-xilinx: Fix an error handling path in
 'xudc_probe()'
Thread-Index: AQHX0/QlLXhITjbMkEebP7nksPsLdqv5D9cA
Date:   Mon, 8 Nov 2021 04:49:45 +0000
Message-ID: <DM6PR02MB66351AD97EC3191A7DF6E456AA919@DM6PR02MB6635.namprd02.prod.outlook.com>
References: <ec61a89b83ce34b53a3bdaacfd1413a9869cc608.1636302246.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <ec61a89b83ce34b53a3bdaacfd1413a9869cc608.1636302246.git.christophe.jaillet@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: wanadoo.fr; dkim=none (message not signed)
 header.d=none;wanadoo.fr; dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 97a58484-becb-47b7-6ef0-08d9a2732fba
x-ms-traffictypediagnostic: DM5PR02MB2812:
x-microsoft-antispam-prvs: <DM5PR02MB28121BD5E929B908AFF3908DAA919@DM5PR02MB2812.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LsZg2pONiJOfCcQRhXI/odnFy/Yjt/+2n/xD8J9jNubf1NTIVyV3IwZFr8Qy4nrkARjs2u1ddkpT6XT7JjercgIcZjH0pM423mwO7NRu1kpB30xWaAFczubNBJAUii1wx/WeMRW03bhdzCqpJZxyCjmv6Du9EX+MeVwpRnYy6hPjcx5NvEk9N1WvuvwzZ8BCYKIbVEULt0bwYq9chn9RfyFg87+Ia+GJmSYgOHkjWOc9fT8D6iGtXIVp3eWNsl/L6s3Iw/e7prCxjvZw0+zjjCtRnV4WdZxseqHoZ1qNOsICnOtkwJQ+dDl+oZ15CAmzBETsf+7g3OD956UWXTkLEQaCWThyXd9qK7hBdty+uv1xxrIL45+Qn+0QGHrqsNdCkEV7W5WAtUL3+5h4MpyFLtmH9epzI/JXiNmOP2lMc333CcGlK3tNvSGQQyWDZE9dGcgRzJRG60UyUKN5V1NN/IZYi368Qz590gAXxs7KcVxZTRwx9ulFLaT8hZuAclok4GrDucifamHVtcVCzQmtcH8sMVrq+3ncMTqh4q/2b8c6mj9SB3RzkZ+CK0OkhBl21dj/YlF6GoHs2SZQubg37eNH9W4mFo0+GVFxuKMpibq2Lm3QUMc6s8XcpmgAdM5PUX+RXvVCZHJVmfq0KcN6pJGb5qXDKKo5Z5aZr9hEY+up8wBDvTodqmCvQ5+h7XweXNGbEV5ke9c0iNpDcMBlUw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB6635.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(7696005)(52536014)(38100700002)(8936002)(71200400001)(66946007)(33656002)(83380400001)(122000001)(186003)(53546011)(55016002)(55236004)(38070700005)(316002)(66476007)(5660300002)(54906003)(6506007)(8676002)(110136005)(76116006)(508600001)(2906002)(26005)(86362001)(66446008)(9686003)(66556008)(7416002)(64756008)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?r0LMvt/tCGbyheqsxfdX2aVoS6Eg82c+n1ViKH4upRe0z6CZ0q1cv5zVc453?=
 =?us-ascii?Q?vwC2370ocaPHVhrrTWzVjc2xHq6hMydgNx+a+FG4uFjBNSGqEVB62/H46vfR?=
 =?us-ascii?Q?978RuX/YH00BtqxHIDjQRIdUCjnQnlPdYncAiCYqZKJJqZ4YNqX3RVqS9HDu?=
 =?us-ascii?Q?33bXPNJJlbuRbHeBz4nICpkjvh6n02/Ja17Na2PWzEFGcQWSDpRM8Pt5ZLa4?=
 =?us-ascii?Q?MFYGA/WESiAbw+A+G3SlvXqLyNjf4uTe+JgMo5bNNN8R8mqSYNLgjPk7yKzf?=
 =?us-ascii?Q?eRjvFtSOpiP0xFv5m+lL5LwcvVoqV2bAj/qjXMksoEE2Gvm8iZ+QeYoyHS5A?=
 =?us-ascii?Q?ViAMrc9TShckJLU4hBOF+vxpvpxT7V9dhtDdwC7FQEZ660JhltT0UOH//L7Q?=
 =?us-ascii?Q?M/WTvjoGf/XfDBnQV1+GjVtboAXe8MctF3hY36ayNJGfz2kuqbpPwu9RGTuX?=
 =?us-ascii?Q?BhyNFL5QWgZmsykoPEqEH6hgZee2FysdZrCxRqxDJsDMDOq9hYo66y4mvHL+?=
 =?us-ascii?Q?DK3jLMyCbruVXW/Y3xo9bMr/lFfJp8M79H9egP1sRhjPA7cSqVz/zsYPTVa9?=
 =?us-ascii?Q?ztGxP1NNEnjWLFcsfNiGLKF8n2Ar21yX4JtSN1KbjS9fSMy3b8g+IXiexBrX?=
 =?us-ascii?Q?85X68JxOc66m3evFtQP4C9fD94xkNTRHPibqGGu7my9cGNAL38lPXC1EgeeY?=
 =?us-ascii?Q?fULucatvKwzLvQkjG6rx5MA8gk57N/OkOUA/IvwyvvBtyVwOG0SlPE915B+a?=
 =?us-ascii?Q?ZKjmRtirQspfU3Sjoom876CmyfyhmBUW/FA+yLBiCdX4a/N69irQ1F8tZTGS?=
 =?us-ascii?Q?cLZNeFKaoD3gh1HkE8fSHOnfEcATVpfHc52tCovKnlt4pJYC+A/usPQptdub?=
 =?us-ascii?Q?4kFcRRg/QJo8wBn6Mt4PGq9/kPLgHbjRKvQ/R1wqJ7ivpIu1dBWZuCD69g61?=
 =?us-ascii?Q?QlS9xcxuTS2O2py7HpKL6cR6e2EdxmOWcrM/7KiixMsqgcvhUZztlj+SuIDb?=
 =?us-ascii?Q?5IRSdxuMkjQxinaPfMl26c8ETl5yKjzjRxnjKYszIQ6gusP+BeMRrWz0WnOw?=
 =?us-ascii?Q?w9568LyUOvCuuXQyHj96EOrCn2NofPlx0AU5lIO22wvth2o2e3bzIAIjzQLR?=
 =?us-ascii?Q?gJj/QlyV2hzYSBPT9ZKK4bK9KTFioiHFo25BAo/qZWGwH8nEgdyTyO7XMm+2?=
 =?us-ascii?Q?9HMkYyYJp7xHoewdPpwedZGXD6uVEc/ZizFC+k6tvyf1YZnoPW8TOzbMwXDg?=
 =?us-ascii?Q?w4xIz+BWSrIi6tV8/yQMTtfCFsUKbwzY8CQyBhV/MUWQn+Wc3uKeXIgdpLMh?=
 =?us-ascii?Q?3kRR8CCy4MsiP9kb7ZcV65dr9pRUe5B7eY6uaSE5bC/9KFRYiEuTdb3dNGWA?=
 =?us-ascii?Q?AOVERyh82JubmUjoe7SR6x8Mz2PKTlpr+OFS+f/rvrO0LgkoZEHwO3aaVL6l?=
 =?us-ascii?Q?VmtPWzDhi05NAPom03tSZK/KG75KVLxKNssd85PDFxgC0Ft2JJTMGmNKUcOj?=
 =?us-ascii?Q?3ZKrIMQf25n438nogzLlZ8daC9LuDey+Fp8UBu2W6S7SMedB3qvjW3tVMpl5?=
 =?us-ascii?Q?6TJD3IzSgsT74+xWV9YJGhuvS0FdCHvdHhUIMktciv4L69HRigvQeh5Q7h1g?=
 =?us-ascii?Q?wg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB6635.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97a58484-becb-47b7-6ef0-08d9a2732fba
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2021 04:49:45.4903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7CfLz9iOtOyMRT4/pVlGdmZJsjc1eiOrp9lgZNfq39M++4zar2SyEl9F+8NUaCARvwE9dxFdh+OlVgOg84MLYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2812
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Sent: Sunday, November 7, 2021 9:56 PM
> To: balbi@kernel.org; gregkh@linuxfoundation.org; Michal Simek
> <michals@xilinx.com>; lee.jones@linaro.org; jiapeng.chong@linux.alibaba.c=
om;
> abaci-bugfix@linux.alibaba.com; Shubhrajyoti Datta <shubhraj@xilinx.com>
> Cc: linux-usb@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linu=
x-
> kernel@vger.kernel.org; kernel-janitors@vger.kernel.org; Christophe JAILL=
ET
> <christophe.jaillet@wanadoo.fr>
> Subject: [PATCH] usb: gadget: udc-xilinx: Fix an error handling path in
> 'xudc_probe()'
>=20
> A successful 'clk_prepare_enable()' call should be balanced by a correspo=
nding
> 'clk_disable_unprepare()' call in the error handling path of the probe, a=
s already
> done in the remove function.
>=20
Reviewed-by: Shubhrajyoti Datta <shubhraj@xilinx.com>

> Fixes: 24749229211c ("usb: gadget: udc-xilinx: Add clock support")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/usb/gadget/udc/udc-xilinx.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/usb/gadget/udc/udc-xilinx.c b/drivers/usb/gadget/udc=
/udc-
> xilinx.c
> index f5ca670776a3..857159dd5ae0 100644
> --- a/drivers/usb/gadget/udc/udc-xilinx.c
> +++ b/drivers/usb/gadget/udc/udc-xilinx.c
> @@ -2136,7 +2136,7 @@ static int xudc_probe(struct platform_device *pdev)
>=20
>  	ret =3D usb_add_gadget_udc(&pdev->dev, &udc->gadget);
>  	if (ret)
> -		goto fail;
> +		goto err_disable_unprepare_clk;
>=20
>  	udc->dev =3D &udc->gadget.dev;
>=20
> @@ -2155,6 +2155,9 @@ static int xudc_probe(struct platform_device *pdev)
>  		 udc->dma_enabled ? "with DMA" : "without DMA");
>=20
>  	return 0;
> +
> +err_disable_unprepare_clk:
> +	clk_disable_unprepare(udc->clk);
>  fail:
>  	dev_err(&pdev->dev, "probe failed, %d\n", ret);
>  	return ret;
> --
> 2.30.2

