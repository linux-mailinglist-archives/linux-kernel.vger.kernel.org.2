Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB50365126
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 05:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbhDTD5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 23:57:06 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:12168 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229467AbhDTD5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 23:57:04 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13K3tE5t031796;
        Mon, 19 Apr 2021 20:56:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=TVhK3D8RwwLOzRQZ3i8C/SGVv+s1s0+iO7qi93eF8XM=;
 b=mBsfSGOFwH4rKRVAl22l3I6zjmm7A1bmLbZo/ZaUKZoUlstH/1FvBRjKMVd4+GUVSzj2
 W4zUwYWXCJIkXqawhCLVJVOQEws41QdMze5Gt9zis5490jMWKxSG/3p1s8zxTLJg7dBK
 VztmRL972sdKDI7oEGPvmdwZWmzZf8GLAy8UTO1zXkl2srXsEqS/MlCvdv1gilR4lT8P
 ltit5VwQ9BS4t1CbV71Wyvh21OVIUs6OixfTY6g8Pkk7FOjrlehYU2HF3ASb67f4p3zG
 zwg8tDVqUiIPEgp9SxLeKfWY+2ItfHd1GkXfz0Sk8LB8JkPju9Bxtw4gfHToyu83KUF8 Uw== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by mx0b-0014ca01.pphosted.com with ESMTP id 381f2sham1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Apr 2021 20:56:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mzX/sGUaJWLyOb23+mYbhsE+ND8LcEw+RbdPwVY8VaCvKncTboFHJ9cSkVfw35cnFZNpNvOAhUh7h1THpBs/mPLyo6Mv7N8UFHNvtbSWGmW4FMiU+d31fEQGOq1rHiMUHJfr8yXvIW9gQfGO+I8bPqz4cHK8dCKM//di5UzgWUnMQY8WjV/WEPvI60i3uoCWiCNvlYycYma/cNcfHK2ebvlo4IZVM8i0SxfIYrpRCkGGqXjO3ZZgfrVHGy0qtAH2pkIiQgCPQMe0JxMGP4Zn3oca6cIAzEij8qTunA+E34oaI+SPzTOiVjWSCnDx3eR2GXYhhUleBGzFHOB1WUfy4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVhK3D8RwwLOzRQZ3i8C/SGVv+s1s0+iO7qi93eF8XM=;
 b=VhMvv2RBLrRRwDpPKmFDAPWlDmSIynZbPv9VuZbky0IgnuObhyf5hE/7fzltyJMGYV7Uq3ZQVBUBv30cXddsdK6oW4qzqQDIqSnaQZM0REYA7S0BxU/4/Ouvu8zPNI88sfbLsQW4B2lteIIHVGfOJ3tEm7nXNq3IhKHgMPlY/Qmi6zGOu9o5tFTEIkl9Gw8thenztL01dxTd1lFOohHQCGy+8+Q6ViI+80Spfj9ogS1XDAZIoJw+uwHWWTuEC/SxBz1snhUl5xp7QUntqlSIhS7lyRWBipEDP8XfJ/S6nw6nG0cDAgKKaSegaWqEFSLi5CPMklV3fkHP05ma5PoRWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVhK3D8RwwLOzRQZ3i8C/SGVv+s1s0+iO7qi93eF8XM=;
 b=0Oq+ZufaIpySX781mH+oHyKnGgG6btWAasLmyEkrxGwZOH1u2zbxkz6kOH9hsMHerTOdspHGfKaHuVveCI1p2KwSoUJgUWj+//NaHDCfSFVEGEO5fmo1jyM6yAoE4/W4QzqxcyZAWiWcSps84IpMkmpNV1sihJ7Om6LlsD8pjnE=
Received: from BYAPR07MB5381.namprd07.prod.outlook.com (2603:10b6:a03:6d::24)
 by BYAPR07MB4152.namprd07.prod.outlook.com (2603:10b6:a02:c8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.20; Tue, 20 Apr
 2021 03:56:25 +0000
Received: from BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::5a:c16d:31b1:bcd0]) by BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::5a:c16d:31b1:bcd0%7]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 03:56:25 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Peter Chen <peter.chen@kernel.org>
CC:     "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "ruslan.bilovol@gmail.com" <ruslan.bilovol@gmail.com>,
        "jbrunet@baylibre.com" <jbrunet@baylibre.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH 1/2] usb: gadget: f_uac2: Stop endpoint before enabling
 it.
Thread-Topic: [PATCH 1/2] usb: gadget: f_uac2: Stop endpoint before enabling
 it.
Thread-Index: AQHXNPDk4IS+DQ4fDUKw1PIKLUko/Kq8mYyAgAAuUMA=
Date:   Tue, 20 Apr 2021 03:56:25 +0000
Message-ID: <BYAPR07MB5381F9748155F73732090E87DD489@BYAPR07MB5381.namprd07.prod.outlook.com>
References: <20210419075053.28467-1-pawell@gli-login.cadence.com>
 <20210420010846.GA6408@nchen>
In-Reply-To: <20210420010846.GA6408@nchen>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNWUzZDkyMTktYTE4Yy0xMWViLTg3OGEtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDVlM2Q5MjFiLWExOGMtMTFlYi04NzhhLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMTg4OCIgdD0iMTMyNjMzNjQ1ODIzNzI4MzEyIiBoPSI0N0lZWXlKZGk3ajRaZE9IcU5VbHN5MDl4dEk9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 02b9a3ff-3da0-4f6d-7fb8-08d903b044fb
x-ms-traffictypediagnostic: BYAPR07MB4152:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR07MB4152F3A0641537001BC367B0DD489@BYAPR07MB4152.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FQKUSSdAlNGfSYL4zR0z0We8Keq1sNe+RWdA2NmcsuXzw7bueF4PfdsEDRL5Eqhz/7IGhVUe9CfaZIKrsmE3qx2KZoBfYJkXLlkppmMyFQ0h9+ghLbCfG6/FjUbSzY0BYIXQjMKuYu9YEWjcTQW9IuOIGnmc+8v4xZyyp4p8tBa/KfApr+H8KI4Pvmk2MyVSqnA9UjOF3X0FpKAqkciKvE4YiHmGgo+h0Oke0S6b92Omcy7XLXlc8FeUZs2WqiabYALMbPfzAt/bUaMqokEOnENdkvzv071BJcexke2qt+VeJdkKg7OIl9p/gD5LJXYfxUNzeduFhZ3Twc7GBCsAU7cYJtYATdb2SqZBsaQBGuuh2gASHA5/unJWSItVJDlBbvSa4KNalTMtPLbXFR/Mln2T8GXfVPFrvXNI86GDZa5j2A76MpR9G5zDQgDaZQ1u/vM4H7p4pYzeTKQHcSQnpInamIg86Kmxj0t5SO83AQtl+6/zhEBBg66AK2riY1GfP5jPds88GySypbgC4p8n+ChV34Iyk2Ywyoy5GMLE6gDZ95bBPIUrx381V8zdk3T+7+e6LWA4Zcssv2P2bJ918xZyiRgor/KoBiiy8poW7WvjrbV1/sXYcOvpNS29N6oEJCiAP0uX0Bw12ij+lXjN5XtqXaDdu+fcYAEj+q11yk8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR07MB5381.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(36092001)(76116006)(66476007)(55016002)(6506007)(6916009)(9686003)(122000001)(71200400001)(66556008)(2906002)(64756008)(54906003)(478600001)(316002)(52536014)(5660300002)(26005)(38100700002)(66446008)(66946007)(107886003)(8676002)(7696005)(86362001)(33656002)(8936002)(4326008)(186003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?rMs8pzsi9YIJKk02Eq4sqZdiLyfxIiPgg2FKPBKrxLZlpmSSsYinFWuNFNMw?=
 =?us-ascii?Q?4vK4N5C6KbyeuriN4EXuRFFcXfUXS6i8aWhhtwfneWBq8bRdCAM4pczLF7xo?=
 =?us-ascii?Q?+rThmjhBceNOr7e7PkYhDFNLFcX3sxsu+qaCWN+MDw5Dcy2oo/Rc5hnEAE5u?=
 =?us-ascii?Q?ZnZHcXpX+7yuEMrwAO9ose3K+i07rdQoA1LCwxFgKFPj64VLGvHB1YDyM5N3?=
 =?us-ascii?Q?gWJCx4X6EuGONf4dek9ucI8sAtOHod7SQ4m/huHU6Mudm7Iy0dZIkSMNt/gJ?=
 =?us-ascii?Q?HeTToyV3QwuRVZOMwps/gb5NXZ7QUE/2x3PveWrCu9kzw5zXmL5bd1PKRlEI?=
 =?us-ascii?Q?Fl6tf3bQYE5v5MMQo37PHx/YpOAHPdLQuXlsOy70g5o7mehGENRxUwtAIgAM?=
 =?us-ascii?Q?s28igxdCDGERQ/xdO7pGutKZPuxO003lYYEQOmg2WcO/FHxSH6jPZ04hA6xa?=
 =?us-ascii?Q?GdwemnwoUcRm9U78qXAtsEpUAkf69QOIs2YiTK8Pi+E/wk5GPuKfZTQIEZKm?=
 =?us-ascii?Q?VBdV4WoReiCHQ71oFTCy7KbLQcp+YOTSiL4a4rfY4KvpBInLUSxnbNi7Azhr?=
 =?us-ascii?Q?CQpP7wTt8U+3EPib1wwN9bHEdp3DHYOHJjyPkZMtHP3ZnAz3Pd+94wusIi4/?=
 =?us-ascii?Q?SOYEBhSN3KwpyVscADR663IhQgIDR8mX80C+2zd5tdolNQKk/8oun9ScLvXO?=
 =?us-ascii?Q?1lcsgVtRV4qTh5NAfNenRwTs87hGgOrA7aLPuW6nWT1KNjbsUC+Qk3ZzKLId?=
 =?us-ascii?Q?cbPTnVgwGNGu+ycsuWiejQ25iUJ2Zph/dv2baK0xudaotbQV41N+ph29n6kh?=
 =?us-ascii?Q?2Uh81ta29i1FYBgLpGxTW2AkgT6sixF8jIc/dWvKhJ3v/+OxH72PYchmtYxs?=
 =?us-ascii?Q?3aC+is9Q3Ep280nn4z3UqlpBUedDFJgm4qoI7zEKH5zUCH7hhA/luoZ0DuJ6?=
 =?us-ascii?Q?AkajDZHmY1V3qFhpUHZz7aTSzg7Ubv3F+9M7Rmd9I0LdSlTI4wxYV9RO8Yfq?=
 =?us-ascii?Q?fWaTX7kNObAl/Xqd47F33pxWef9hio27RZtdEL28ttav8DQgHK/m7SY+/B3g?=
 =?us-ascii?Q?JFIRytN+lm55BkE5ghkxex//+JBfaRDsMvbVeUcLZVNDJDU2BVqa0R6u6B06?=
 =?us-ascii?Q?gO5ON8Q6U0nvPbaXr4xuKnTUyaZg/3SEz9qwfpji8lxaK7IFH675UzBvHUyc?=
 =?us-ascii?Q?Cl26Mb/u0I0ABclFPy3xF2WGIkNvIZRPSunhreGwD0y20Qfrq9eljc+JKUNV?=
 =?us-ascii?Q?RH6EGo5XcKI+7JGrF2zG8mnOLtQ6Y1CPOZjddnkYHEE7vHpyNxCoC56EvZxA?=
 =?us-ascii?Q?HcCrBHfuxsdf4iQ/pjXTWcgk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR07MB5381.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02b9a3ff-3da0-4f6d-7fb8-08d903b044fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2021 03:56:25.4607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nkkMxsD7VZndVg/PvlapnZKUcAjbmI4VqiryT/UifQx1bu+SZVyjeQ2x6AGQB0VTyLwQO6fBGyD8iepvJaZdqRawZTFyK2qNrtk3QtVo28I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4152
X-Proofpoint-GUID: 3rxadWuglk301Lf13eAYqVD0tvEHKgta
X-Proofpoint-ORIG-GUID: 3rxadWuglk301Lf13eAYqVD0tvEHKgta
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-20_01:2021-04-19,2021-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 mlxlogscore=751 impostorscore=0 clxscore=1015 adultscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104200027
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On 21-04-19 09:50:53, Pawel Laszczak wrote:
>> From: Pawel Laszczak <pawell@cadence.com>
>>
>> Patch adds disabling endpoint before enabling it during changing
>> alternate setting. Lack of this functionality causes that in some
>> cases uac2 queue the same request multiple time.
>> Such situation can occur when host send set interface with
>> alternate setting 1 twice.
>>
>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>> ---
>>  drivers/usb/gadget/function/f_uac2.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/usb/gadget/function/f_uac2.c b/drivers/usb/gadget/f=
unction/f_uac2.c
>> index 9cc5c512a5cd..7d20a9d8a1b4 100644
>> --- a/drivers/usb/gadget/function/f_uac2.c
>> +++ b/drivers/usb/gadget/function/f_uac2.c
>> @@ -890,17 +890,17 @@ afunc_set_alt(struct usb_function *fn, unsigned in=
tf, unsigned alt)
>>  	if (intf =3D=3D uac2->as_out_intf) {
>>  		uac2->as_out_alt =3D alt;
>>
>> +		u_audio_stop_capture(&uac2->g_audio);
>> +
>>  		if (alt)
>>  			ret =3D u_audio_start_capture(&uac2->g_audio);
>> -		else
>> -			u_audio_stop_capture(&uac2->g_audio);
>>  	} else if (intf =3D=3D uac2->as_in_intf) {
>>  		uac2->as_in_alt =3D alt;
>>
>> +		u_audio_stop_playback(&uac2->g_audio);
>> +
>>  		if (alt)
>>  			ret =3D u_audio_start_playback(&uac2->g_audio);
>> -		else
>> -			u_audio_stop_playback(&uac2->g_audio);
>>  	} else {
>>  		dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
>>  		return -EINVAL;
>
>To avoid this, you may use prm->ep_enabled to judge if the endpoint has
>already enabled.

Such condition is as first instruction inside u_audio_stop_playback->free_e=
p  function,
so we don't need duplicate it here.

>
>--
>
>Thanks,
>Peter Chen

--

Regards,
Pawe Laszczak
