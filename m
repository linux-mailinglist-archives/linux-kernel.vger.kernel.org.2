Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE4C39DEDF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 16:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbhFGOhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 10:37:03 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:28836 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230203AbhFGOhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 10:37:00 -0400
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 157ESwBl000989;
        Mon, 7 Jun 2021 14:35:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=Q2O7/TfY0OqNDOd+bnoqhAJVH1829AKc34ztAHQgMOE=;
 b=VE3b9VjZkz26GLbsVAnjl3QYu0lyXiItqcYjNtkGwIh4itThFuxOlJE7eYlX6NeLONAC
 ZGwHtN0F3axjC6MrzEhTf16qf5a4sIJeZhS8WRSI566tAEamdAbTcR8LJE0Nxkc1UrMT
 1ytDSKmjEYcnGjdymGWY2Lkit6jwBqlKMVNAGpQXANGTqTZxzPfvrWlqfbSM30+nnl6I
 HkffvfO9alO6Bgi54G/yHc9EgsYKBAxD5SfRAZoqgnwLuQR5BuSaI9W7L0xPDjVHgXCk
 ArBbx7ahbyk/dBx7/tKipkpk+Gdsj2tSapfF2IAqZF9Q89zyJysSREDN7GOZkBJ92hy0 iA== 
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0a-002e3701.pphosted.com with ESMTP id 390k17jm2y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Jun 2021 14:35:01 +0000
Received: from G2W6310.americas.hpqcorp.net (g2w6310.austin.hp.com [16.197.64.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3426.houston.hpe.com (Postfix) with ESMTPS id 709C567;
        Mon,  7 Jun 2021 14:35:00 +0000 (UTC)
Received: from G1W8108.americas.hpqcorp.net (2002:10c1:483c::10c1:483c) by
 G2W6310.americas.hpqcorp.net (2002:10c5:4034::10c5:4034) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Mon, 7 Jun 2021 14:35:00 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (15.241.52.11) by
 G1W8108.americas.hpqcorp.net (16.193.72.60) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Mon, 7 Jun 2021 14:35:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SjZDZXp/eMD9Zz1e7EepyS8z28IMfz+dIbHwqgxXXIwiCbUd5g/ODNN6bDVrB0vXyKEYKCmZ+3kjAQvzbJlTzpClMExZ3fk3sjy1rD5D0mqHb2WLeOtEj0h0qSCA0YFiq1m0NmYQ0Jwx2QZC20jlCGujRHlFt3mn6U9qHUOVteZQi+yBAHwjs5QIGpIEqbedFv2lMYQ9nWdtKor5IA+SLNdG0WoglwdF7/qX3SfUbHL3MpZVVctkd8rQkva30lkcE6bXL2CvkLoL1ree+cOdBUN2j7lgnQaB6kuKUQTmq8Fs4iaVAUhqJ703sIqPIP/LQKBjXu/yzUsBweBrFyfyyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2O7/TfY0OqNDOd+bnoqhAJVH1829AKc34ztAHQgMOE=;
 b=fgV4jgFBWyfm9czHbsxTpubXG6E5UYAdJ0oekzsd1lQcexS2CQXeNk1awPibtiAsp+vdreOHImpEnbqzgHq9W5wUbPoDBKgJgU0xwYfMXIdm1GCuDULyPuO+4Fn/IM7C2baSqwyVpRaPVLBQar9g4N7gs/2uFADIwP5T1mAaATUtZfJpMQj9inpp2SY7vjbh7Mn9O8ANDD8BVRt5ohjm67q3zc95c9l+5hUBXsc68AgiNdYrea7cFifCOr90pkZG3ALx0uQKfsaQZE/kntnensxVc8OsEacQJjScf5eO3MYoZo8LXJym6bH3N+o4HjB/mTzsq27YfyZ6pgWMhZ3QuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from AT5PR8401MB1300.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:742b::18) by AT5PR8401MB0369.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:741e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.25; Mon, 7 Jun
 2021 14:34:58 +0000
Received: from AT5PR8401MB1300.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::81c8:1ea2:ae1f:2676]) by AT5PR8401MB1300.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::81c8:1ea2:ae1f:2676%12]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 14:34:58 +0000
From:   "Ernst, Justin" <justin.ernst@hpe.com>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Frank Seidel <frank@f-seidel.de>,
        "David E. Box" <david.e.box@linux.intel.com>
CC:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Travis, Mike" <mike.travis@hpe.com>
Subject: RE: [PATCH 4/4] x86/platform/uv: Constify static attribute_group
 struct
Thread-Topic: [PATCH 4/4] x86/platform/uv: Constify static attribute_group
 struct
Thread-Index: AQHXWkrCbbcm8vXqoEqP+CNK2D209KsInr4w
Date:   Mon, 7 Jun 2021 14:34:58 +0000
Message-ID: <AT5PR8401MB1300493C7B3FF4533549019587389@AT5PR8401MB1300.NAMPRD84.PROD.OUTLOOK.COM>
References: <20210605203807.60547-1-rikard.falkeborn@gmail.com>
 <20210605203807.60547-5-rikard.falkeborn@gmail.com>
In-Reply-To: <20210605203807.60547-5-rikard.falkeborn@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=hpe.com;
x-originating-ip: [165.225.60.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5732867-06b5-44a3-755f-08d929c16d2a
x-ms-traffictypediagnostic: AT5PR8401MB0369:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AT5PR8401MB036906240CB33A2833B4BBBF87389@AT5PR8401MB0369.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vhrpF8NCPbb7L6muB48ZeI8OJW/vDn/eVLlAdBoDf6w4/xqu2aunSqlsFdZFpZ5Sp1yKxK2SkUZuqVT4D9xmjG8X86IMyUoyZYCAS73qrOpRq6HvP/gL8tE0lEIgwTEVhn0gWSKznF5etO4qBXwv1ujTnFSN86YHj5FNGldNd9vLPexd2Ylbv43QNF5q2zwSBl0ieCLw5GdpsSdD/xiZhDahJu69/szqR/a/zclzSWFOEveYkOf/yr4onQpMxe2Bal18Ql3p37IfX4eqrf0kmmNjIxN25qvykgtgWVG543t7PhG0HhoyXeZjRImZj/zl7yRJzcctPIckztw7DyuNnF8ybjtdZARB0EPpQjR78wewtj7fEY2YaKEZRq/TlC5GqSK8Hl0Ff1pdtK9pCINlxu5W0kLdOWz6KCS6nTfkN+Snx44Pz/3RI2qQp4fNs/SIT25/H3uduRlxVqELgjrULOowmUcor6qgTtZzbeLQAUlxshE/NizbFVsFC3Lv1iXmtPvb6ld+Zn5NmVfu2x1i24MReNyG/K7Iz5CUk1+bTJdI8n/Xr6MNsL+9AxM7PbcOzbBiQx0NgYca0pPimGq7M9aYHp5rFXLjb29cWHtOqeQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AT5PR8401MB1300.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(39860400002)(366004)(346002)(136003)(376002)(83380400001)(38100700002)(8936002)(316002)(33656002)(478600001)(6506007)(55236004)(8676002)(71200400001)(186003)(86362001)(4326008)(26005)(76116006)(66946007)(66446008)(66556008)(2906002)(7696005)(5660300002)(55016002)(9686003)(66476007)(52536014)(64756008)(110136005)(54906003)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?cP1ulKeaRcAY8Z6Rri9XHzD4Z8LFPC2Rg49ugQLdopBBuhivCVBOXV03wW+F?=
 =?us-ascii?Q?S+hwoVJk/mt15JYy55c5kRSIsfB3w48iNLWJO7vp7v9VoM32iRid6L/C1Gv8?=
 =?us-ascii?Q?Jl2tAm8y5XC2E7m9sdL9eDRm0mPzPwjKG1UxmJkbZjVnrqa9Lerc8WmKLzgd?=
 =?us-ascii?Q?vELzRH6vo9jyCthMiY3/ld7gS1PaszrfkWCSf2jwHV+Whf7l6mOSz0liQ2z/?=
 =?us-ascii?Q?vh+yGc2qskPkqigdqzME5TNDuZI7RNU5StNRLbP067RWcSActAoKdQt0rigs?=
 =?us-ascii?Q?VRCAEaaFc4YIRwOkF9xKyw91T3aydfCW3IIG1eU8YQArMfQ96/Yh+1hbta5L?=
 =?us-ascii?Q?/VVtNn6oGinp2AbY/A7LvnU9XoxI2tanxy9hPdbVNGss0yaGsJPZGL9gkU3B?=
 =?us-ascii?Q?/QiS4hJ/2Hai3Ar8c3SNInNEVTHd8prro3Gl2KT/ilnbIOZgSK7H1fw0YLDC?=
 =?us-ascii?Q?D26i8+9YlQo8iuy07DcT5RIVittuTDjX8FZ8GieIzuWSsR+ZbMkqo1yl3HXC?=
 =?us-ascii?Q?PxuWYII3c/fogkg8nKDpF1D47N/bLo1kcI//Dk9JYVN/QORSaNH5W3mSaxtq?=
 =?us-ascii?Q?8Z4qsupP0VowM8aXGdvccnDsCfeJr8ToQHu96o+WA2zovpvwfE+F9TF4vcHe?=
 =?us-ascii?Q?pP/Vx6lSHGLCz5iJD80qEMELMjPzCNo/e8RiQfOvZJkc2RfE/OFHgpGxf8o1?=
 =?us-ascii?Q?CtZnExVWmuaKvhOiE8wAYFWHcG8pz6tNFQC5ur+QQPZdhMUt4K1l5MZ6EkHz?=
 =?us-ascii?Q?CXml+PxTbZkVUe7Nj8mywzBSSoVBSljJDmlpG7l8T+9xjqmk8T6zH4xUaxyF?=
 =?us-ascii?Q?OahRQtr1vw0K0vykYGyodRDwpyAL9wHA6dsohh1ZzqzBC6aubyKxn+AhT2Fc?=
 =?us-ascii?Q?2RZOciy6+1PjaZ5SWEqRYg8Z0FfNbC0dzqu8o0BcN9GUdHGExnUy0exjt0kV?=
 =?us-ascii?Q?nEP4ypWHhJQUX3dkRUSQjp/OH2Cul4T7MyaZ6OcPZD8HzpafB/B6p9jCcCII?=
 =?us-ascii?Q?OMqtLb4OurP5kNrQoLZ1e143VuIOkFjm+NZoCLnInHaRgbogWsX04W0fhGqf?=
 =?us-ascii?Q?ZoxqyIR7+XuqdzgMGwg11Sms2bnPpnWGOrvtyC/cUWNcd78kUMeKIw2lIR/i?=
 =?us-ascii?Q?oiPH4cFptIHw68wWGtjb+Y6XexItSQmWO4I6qnSDqtKSRD47nGp4j/juHiPx?=
 =?us-ascii?Q?pW4SplbFRpXv16FbJyZEIrkpv4lUX4xfLSQSml4Ni/Wi2pTvJXAmyKurWrE+?=
 =?us-ascii?Q?azGeBi2Nwngo9KTPzg+BBhyrbiVuZSeQuUq37z0D1jwzAM6eHAGkYSyKNnLn?=
 =?us-ascii?Q?9qU1MQ1BucotonjBRsX41MVu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AT5PR8401MB1300.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f5732867-06b5-44a3-755f-08d929c16d2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2021 14:34:58.5112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ds+vf5U2qb1EZbn9IuHOkwU72XbkmTfp7/OOnbICKOUSCXDueQIFYwMb7Zz0fWFtLQBERFl9Fj43pyKB+09Miw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB0369
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: cg3EFwZhjvQAd3AuEdH49FOww_liQxik
X-Proofpoint-ORIG-GUID: cg3EFwZhjvQAd3AuEdH49FOww_liQxik
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-07_11:2021-06-04,2021-06-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 clxscore=1011 bulkscore=0
 phishscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2106070106
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The only use of base_attr_group and hubless_base_attr_group is to pass
> their addresses to sysfs_create_group() and sysfs_remove_group(), both
> which takes pointers to const attribute_group structs. Make them const
> to allow the compiler to put them in read-only memory.
>=20
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>

Thank you for the patch.=20

Reviewed-by: Justin Ernst <justin.ernst@hpe.com>

> ---
>  drivers/platform/x86/uv_sysfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/platform/x86/uv_sysfs.c b/drivers/platform/x86/uv_sy=
sfs.c
> index 7badcfa3f384..956a354b57c1 100644
> --- a/drivers/platform/x86/uv_sysfs.c
> +++ b/drivers/platform/x86/uv_sysfs.c
> @@ -778,7 +778,7 @@ static struct attribute *base_attrs[] =3D {
>  	NULL,
>  };
>=20
> -static struct attribute_group base_attr_group =3D {
> +static const struct attribute_group base_attr_group =3D {
>  	.attrs =3D base_attrs
>  };
>=20
> @@ -823,7 +823,7 @@ static struct attribute *hubless_base_attrs[] =3D {
>  	NULL,
>  };
>=20
> -static struct attribute_group hubless_base_attr_group =3D {
> +static const struct attribute_group hubless_base_attr_group =3D {
>  	.attrs =3D hubless_base_attrs
>  };
>=20
> --
> 2.31.1

