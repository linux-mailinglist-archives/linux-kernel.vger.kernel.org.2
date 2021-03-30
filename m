Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D05234DF86
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 05:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhC3Dnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 23:43:43 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:20180 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229950AbhC3DnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 23:43:17 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12U3g678000972;
        Mon, 29 Mar 2021 20:43:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=aGTa920AOoodhnSiAGmtBlEFPTVnXsW0U9RRM43nWYs=;
 b=TNfmV6NTyvYh614jd4vvVrPYuIeUCpB43CL8HuAaZSLAkgKAy+UYyeLquXkQwbaK8DOd
 WnjiE6qo+FFgXwLgi0y8QJEBUasNi+fv8UxgQeWjAl/Ou746A56LucnqkfBc6Tj5Uknj
 74tlnOclYHDYGuU+7s6+I0n7V6pXMdknQsbIMM6m7OJuv6M2yHpJaxb3OAnhBqGObscQ
 O7+sAIUtrwBc10Obe+hmKzMMbZGyU/GdlKypLAN0NpGWE5lv52K2abTUpu8JsAFQOTL7
 WlrYn7ue2sQJeTHTck2z0ozureNtoknpeXXSAm4btkMzDFlPbf3W4JYAeSDHrSLXJy8d Ng== 
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2053.outbound.protection.outlook.com [104.47.37.53])
        by mx0a-0014ca01.pphosted.com with ESMTP id 37khww1q62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Mar 2021 20:43:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PvP3eBRS90+qAaUTcyPqey9tKoS+66kE1d2aPKf17YhdJfsweh5EKZPtLKBMTXAI2rkw/1Fqi/hkrTOC+yfn7ZBVOF0i4K65uCMWUCtvRd8GV/KZwalU76mTV0pKPQTx3ZCbspWyV3Akk+t8//orFkj52Ww3bniBMxlo7ImedBiRQDYFQLB6WoRcZmOYt2WoZn5NfuZPuC6MIRDvvP98hfpvPWWOlSa5KBmKw4bxDtaVD+RpUI0k5HjHo/h/V9BJkD9Fi7o2Yrbe5ZL8pp9IcuLyt86pFAAGrbVkBYi1LedGJha2a2MgV2K5mR7aCITWc2XPgos13YvZnEbUgo/46w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGTa920AOoodhnSiAGmtBlEFPTVnXsW0U9RRM43nWYs=;
 b=SxS6cks8exjUUG/L5Lw+lPiT+3nN6zoVMQQoPxhtheK5CD9D51prZzGK8yzxzNV4lAcPWF8Ng0Ko2KIeQqFzWmxHSZNHZDRghmL7kl/vGAFemAcIf3Pj97gVXxfmuWqfN0tkGY03uIj5ZtoRhO0HEnCeMtr/gA56zwfD2clQlee1nOAW7nowWNx93AoeEtFXH338reDxOZoUPyEbgyg/qFM7NF8LKb5WZ5wujk603rsojUrHztWNCphsJfOMt1ruyKEqNSldGVHfvbVN5nrNnSFO/UrmeZ1dFAH/VZh/6yYMHcMZ4zD2R0N9dzNPNaw7BCaDu0Ohpw3+nYnmwVa/mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGTa920AOoodhnSiAGmtBlEFPTVnXsW0U9RRM43nWYs=;
 b=VapdiDJYJRL0PkE259duFVI3iJcb/wHeVxVock7aQTZ71NF1ef+w53QAiC2cVWDpYcHeIzYQ6+x20ZEnLJNa3FCn1IrB3Vb0yn+UaeTR4iGwNFstH1zxPhI9f9Lk6B1b7hPb3KCiRplRphSa70+kvloJWCwBThgULF0wZzgtXc8=
Received: from BYAPR07MB5381.namprd07.prod.outlook.com (2603:10b6:a03:6d::24)
 by BYAPR07MB4421.namprd07.prod.outlook.com (2603:10b6:a02:cd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.32; Tue, 30 Mar
 2021 03:43:13 +0000
Received: from BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::5a:c16d:31b1:bcd0]) by BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::5a:c16d:31b1:bcd0%7]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 03:43:13 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Peter Chen <peter.chen@kernel.org>
CC:     Wang Qing <wangqing@vivo.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: cdns3: delete repeated clear operations
Thread-Topic: [PATCH] usb: cdns3: delete repeated clear operations
Thread-Index: AQHXF7JuMXLfB7vBtEWzzBA5XVJ5+KqPpe5AgAdyfICABOU2EA==
Date:   Tue, 30 Mar 2021 03:43:13 +0000
Message-ID: <BYAPR07MB5381B69A36E6523A9EF02703DD7D9@BYAPR07MB5381.namprd07.prod.outlook.com>
References: <1615603303-14518-1-git-send-email-wangqing@vivo.com>
 <BYAPR07MB5381E439E54E87C91086BA07DD659@BYAPR07MB5381.namprd07.prod.outlook.com>
 <20210327005539.GC28870@b29397-desktop>
In-Reply-To: <20210327005539.GC28870@b29397-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMGI5YThjODYtOTEwYS0xMWViLTg3ODctMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDBiOWE4Yzg4LTkxMGEtMTFlYi04Nzg3LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMTIxNiIgdD0iMTMyNjE1NDkzOTA1NDY2NjYzIiBoPSIvTjN6NVVLWnh5K2FqY0dSYXBGb1hTeEh6NEk9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65538aa8-44fb-402d-170f-08d8f32df25e
x-ms-traffictypediagnostic: BYAPR07MB4421:
x-microsoft-antispam-prvs: <BYAPR07MB4421DC82F55A53B43F53BA0ADD7D9@BYAPR07MB4421.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zkf7uJTSTsTCArbl9gpn/Y81kYkNwjPevmHIbsjU9kboMxR0Fy5RxbO/rqAPCIz5mHxJ358T2rplSY8wn/1c2HTdXoeM2R2rLGp9BEZILxpXNjWTThaqzmyGg125l9Q9FOfaZGdVdWyzIN9Cwdify17gvluvAMZ/KGj9LZp9z0Cdb5KoUjvZA7ttxJQ5qHm9IC0k6iEB3XKeMSSbmRtah2TnK+KpENpeeWXbz2LfWy+l1cn7I/aHGxvBKd0djsL5I9McQD95C/Yz3nYyLoO3SeUqn2XKGHR7sGyuTuzbdlX5c4rrAcVw4k8UTtcbqEmJeHqiJKlHhzNyTtgkSgSLDZ9XgFODPJnmbJr8wXDYAbm22GbUpswNSmmTsQOA2ERG2qv6m0YRnnbmMZafjKNTa3+Qyk2l4vN3ECLdLHnlMAER+E7V+YpmgvclrRioTeiUHw1s+Mdt/jYlj5sRI5Du+qALXzjmNdwooAsZhhC/Nix2QTdSry/gix+fN4SJjrWzdLqgd+ATlVEBGOBHPAwaV/2xpE2KfMgaMjXN9bOGr0Ym7QxEN64ySKPs8X4ePgEsr1DzHw6CMGnIDQK7fNEPDJibKI/OC22G6ngMpnhHsOWKyIu7fwOD6M+Nvt/jn80dd8U/6m04FNt7coCjhPGRIbFRWXDaEknWwve0F679vvw9exf51k71J+vdnofOJ7d1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR07MB5381.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(39860400002)(396003)(376002)(36092001)(4326008)(5660300002)(52536014)(66446008)(7696005)(55016002)(33656002)(9686003)(186003)(71200400001)(478600001)(83380400001)(6916009)(8676002)(66556008)(8936002)(76116006)(316002)(54906003)(66946007)(6506007)(2906002)(38100700001)(66476007)(86362001)(26005)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?vGQo/hC7pBjDn5WXVvqLW2vwhcafpIxqpLf8WVeDYyWHt0aS0lQfr10gW6lg?=
 =?us-ascii?Q?bE8MpLJBxFa7gU7e7VOsFG47KoDVLs9vuoAXBZ/SiVtZcjzuo1i5uX0mV4s5?=
 =?us-ascii?Q?77G90Ob1hemjjLHr4YzF51U7s/bY1Ow/h0FzPvIOLBseDKUjGLup+BteBexM?=
 =?us-ascii?Q?jly6TAKzHXurhtQiGFYVD32qyADFybTwZPA7GgB5qQdB1Tg4QBZ5U5+32pmS?=
 =?us-ascii?Q?FFjxV8F4w6DYWo6SoHJ11y93snLDWh54V1Vi1eqvpTVXISM+IaMKMNrjJ9VM?=
 =?us-ascii?Q?js+rm57TuNBt3SmbIwkxG/SImSpoO5V3SsiM/s4qgZ9X2uwE4om2rAespk/4?=
 =?us-ascii?Q?FOb3ndW3RWReg+OBntPyQ28q9OjeocytnCyN11EUQH38A3uD4YCMwlvvx4Nm?=
 =?us-ascii?Q?5+/1zFbIYcBPD+tKTrKa+UzATw7JXiMpYO2j78i8ynfLJ/GZ9XEwt8lDQlO2?=
 =?us-ascii?Q?LcXE1FZgVrP4kxcvdrFBSNhCkVttVc8qiPXu3ZAqzkK18+JPcdinH5z9Qutc?=
 =?us-ascii?Q?io7x5DPj9jp6+dkdRTivvXHyUpo8PZrN/HqG7YRvET1Lpd0zWc5fdRlEdHqc?=
 =?us-ascii?Q?O7gZmihwUCUFZTFpcD8BSUl/aL423IWgmXSs3yhVx8Ss+vv5k3WrKoyBkqRE?=
 =?us-ascii?Q?n9ttp3K6YsXXaJ/kOx84SyQh6J4u79XA94qBcPqIrSpYVgVi+fAN5iR9c67b?=
 =?us-ascii?Q?eBnOcnx/pFXO25PIQerzu0Kv539L0H1Xo/7DSDPSDLUhORBMFdXhMw/GNF5R?=
 =?us-ascii?Q?IdpRx/KNV2QYIiwstWi/MGLldYI7YqEpVcJL/97qgnRApwUn4v9YEmdl+rE1?=
 =?us-ascii?Q?/YNEuAel/+ZCLqNhfRkfuBkOZ2CaqEX2d0S2HoSXK1Hetv7IxPlefR8TUdxD?=
 =?us-ascii?Q?DWQrvSNWtxRmTH8yXg6V9tlUJv8Yh9Ie15KTqcIxbIPrDkwiVbKC4GMfDuuy?=
 =?us-ascii?Q?+Ekj7oDgLfV8fUcplGUmlOuYBzLiLsVVutHRsgWqqh5cr49LCr9ZaftVknaD?=
 =?us-ascii?Q?CLiDts5JAD5gWCaFkkB4xINlXA1loQkAPziS5tttpE+jtKlU11X7NeyMdWT3?=
 =?us-ascii?Q?1fAFs1ADZRQmVlXHEBBIzWX5ClYX8DZSiykca5HV1fChffMnxAXhr8IIm1X6?=
 =?us-ascii?Q?Sle3GE24Vp+mtjQbgtJZ96tXXijmdPcKW1tzZON1nVOBxa6zxanpjgWWCuY+?=
 =?us-ascii?Q?GNMUG+38acFhWFpNFUhwATk5O+aGWO2tL1Afdl4QBYqpvOFPMMW8XN16tid9?=
 =?us-ascii?Q?BrsVg7jXTmuAD/mpab4m0MEEDLGJG6UFfIf+ZUfDq3GQZbZ7xl5pfCN2YtYX?=
 =?us-ascii?Q?9Vi8X1ebZLf8z1t+JjqaxSVy?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR07MB5381.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65538aa8-44fb-402d-170f-08d8f32df25e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2021 03:43:13.7586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +JLgMj/GnYY28yGTRHz+VJDfJOw3xvVr5q0VIYwxh9mMoUj5zdOHRTpqc0HQdIKuMWT+2Dmx1HzilwEpZINLHW6LaG1zT2at/uAd0ObAf1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4421
X-Proofpoint-ORIG-GUID: xDTnoFUCk1Yp5ahBzsIxIonwNvbbAuHD
X-Proofpoint-GUID: xDTnoFUCk1Yp5ahBzsIxIonwNvbbAuHD
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-30_01:2021-03-26,2021-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 suspectscore=0
 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=816 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103300023
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>On 21-03-22 07:19:46, Pawel Laszczak wrote:
>> Hi Peter,
>>
>> Can you add this patch to for-usb-next branch.
>>
>
>Feel free add your ACK base on this patch.
>
>Peter
>> Thanks.
>>
>> >
>> >
>> >dma_alloc_coherent already zeroes out memory, so memset is not needed.
>> >
>> >Signed-off-by: Wang Qing <wangqing@vivo.com>
>>
>> Reviewed-by: Pawel Laszczak <pawell@cadence.com>


Acked-by: Pawel Laszczak <pawell@cadence.com>

>>
>> >---
>> > drivers/usb/cdns3/cdnsp-mem.c | 1 -
>> > 1 file changed, 1 deletion(-)
>> >
>> >diff --git a/drivers/usb/cdns3/cdnsp-mem.c b/drivers/usb/cdns3/cdnsp-me=
m.c
>> >index 7a84e92..1d1b9a4
>> >--- a/drivers/usb/cdns3/cdnsp-mem.c
>> >+++ b/drivers/usb/cdns3/cdnsp-mem.c
>> >@@ -1231,7 +1231,6 @@ int cdnsp_mem_init(struct cdnsp_device *pdev)
>> > 	if (!pdev->dcbaa)
>> > 		return -ENOMEM;
>> >
>> >-	memset(pdev->dcbaa, 0, sizeof(*pdev->dcbaa));
>> > 	pdev->dcbaa->dma =3D dma;
>> >
>> > 	cdnsp_write_64(dma, &pdev->op_regs->dcbaa_ptr);
>> >--
>> >2.7.4
>>
>> Regards,
>> Pawel Laszczak
>
>--
>
>Thanks,
>Peter Chen

Regards,
Pawel Laszczak

