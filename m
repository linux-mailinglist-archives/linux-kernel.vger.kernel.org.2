Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1AE343A74
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 08:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbhCVHUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 03:20:05 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:47686 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230027AbhCVHTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 03:19:53 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12M7GtEp016779;
        Mon, 22 Mar 2021 00:19:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=SxhQECk9YMaOwv5RFDBIqI8AsNVouZS4N/V4cK+wSi0=;
 b=f9t0Qr92ydw8gIFW7r1EWSQKXNk+q6TVfYv5uanOdciRX4nUJkIxaqmV8C+0ELWmqggG
 KWABN5UoQ8/qsSWjUOsCEwnnF4LM3x3C4w0nrzx4ZOTKnRpBuya4SDmdMpljfJZEOUay
 PyQEp2H2SkoB5OKjO3i1HW6l88euYAWFwFm2ptO7MsbzX14SPnwFmvn/qiMQgO/44R9z
 aklGniBUZS/INlKeOTnPs2J8sNkv+Vg+zy4EEG4XdIci8ToA+SXI0PkULID2VXsTWrKL
 kj3TKH/A/qN3ztD46CoRbJRJ9yMNwC73Q9QLjicg7padsEZKKSBCwH9AoC0eN55Blu66 vQ== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2045.outbound.protection.outlook.com [104.47.56.45])
        by mx0a-0014ca01.pphosted.com with ESMTP id 37ddkxca17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Mar 2021 00:19:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UCMVvbNu4IgrZsDE+vsugHE5BqT9Tow4JCFPt+Dbyb24ulKJeZNTHJAvzVS3+70ReGMNgWI8tIDOi1rJ66ObuWb9MrNJWPWG9DOtNfwWtfOY6QzU/rtOYYTaXfN15myn3sVTfEYjy76yk0ickceLzWDJgOvpur/qJqV+j+HA+m9QSAAEmSWoSv1dyihxXBjQszxH3THUvsP9Rp6Hi/ulqJl6CcWHgmwyV2as38ynsQ/dJwzmWtkHBlgUKxycCjgkDWJkxcCyp51K4t5bSbRwQ5A58fgfjMG+xxae9du+/mHUob7UlLOgr9ddObLaOVAtqbq3BfspGHg7//o34KlLWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxhQECk9YMaOwv5RFDBIqI8AsNVouZS4N/V4cK+wSi0=;
 b=A00Xo725WYvLqLc/ALHlDgyK29aLCYLRCs9z2IlTE3m3CDtysUSvoUyH+eWpPweirsTZZOciyNdhbwpY5O425Y1YpI9zWiMB7NsiGNfPeMUmpsqNjptbSf+p8McGjpVDit+37FtK6Q5zXY3cRB0BVTuKYBvAK1RFRQRDlsqrJ+5sBRL2TkobUi3JDtjwNoEu1rHxT96H6mdPJKM8rsUX9/KeNJAYAmTz9v8sIOgbTenKYbavG+mKCF9BOiQBFWj+Ean0f9lmm/R6w7jkT49CmTlKoBerplv+RiGudo3NGIBvtjbuiq+Oc2OmXmf5eIT29lye7VfkhMmLm5nLN9xNyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxhQECk9YMaOwv5RFDBIqI8AsNVouZS4N/V4cK+wSi0=;
 b=GMESB4dhtucDjjshHci+VC5vXUDDcxjV8deCRzuUQHsLI0AgXqiL+IarHS7K/6mYa2/gkUix2HEv1qwlizZZuTESPT5GQQ0NVeGYmpQD4SnC3fRTONBqWZQLwfpD9opa7nkUoq5mXaoQMElFWZSHgqCtPi/Vq1jZ6yMj5rq0KqQ=
Received: from BYAPR07MB5381.namprd07.prod.outlook.com (2603:10b6:a03:6d::24)
 by BY5PR07MB8151.namprd07.prod.outlook.com (2603:10b6:a03:1d8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 07:19:46 +0000
Received: from BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::5a:c16d:31b1:bcd0]) by BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::5a:c16d:31b1:bcd0%7]) with mapi id 15.20.3933.032; Mon, 22 Mar 2021
 07:19:46 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     "peter.chen@kernel.org" <peter.chen@kernel.org>,
        Wang Qing <wangqing@vivo.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: cdns3: delete repeated clear operations
Thread-Topic: [PATCH] usb: cdns3: delete repeated clear operations
Thread-Index: AQHXF7JuMXLfB7vBtEWzzBA5XVJ5+KqPpe5A
Date:   Mon, 22 Mar 2021 07:19:46 +0000
Message-ID: <BYAPR07MB5381E439E54E87C91086BA07DD659@BYAPR07MB5381.namprd07.prod.outlook.com>
References: <1615603303-14518-1-git-send-email-wangqing@vivo.com>
In-Reply-To: <1615603303-14518-1-git-send-email-wangqing@vivo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctZjhhN2VkN2QtOGFkZS0xMWViLTg3ODctMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XGY4YTdlZDdlLThhZGUtMTFlYi04Nzg3LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iODkyIiB0PSIxMzI2MDg3MTE4MzQ1NTk1MDkiIGg9InZQd0NyeHJvRVZRa2FzbmMyVS9yNTN4a3JyST0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 353c8538-f66d-4924-a895-08d8ed02df2f
x-ms-traffictypediagnostic: BY5PR07MB8151:
x-microsoft-antispam-prvs: <BY5PR07MB8151BF1E2FF00ECC6DC61C79DD659@BY5PR07MB8151.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S3vdvYZGun8x1nGG6+EIIEhZ6easoSkcC2o8wO2hkh5Ov5qgt/VCBAdelzbPf8aRpiBl6hmX1fptOBa1JmiwXtB0Ffj9NkHXjIChI6AhqeaXC+urXBWSVUDGpypcHpuUFpO8zEZV/+fn2BhfaEZm5m5/XoaFta+weGM6W6vNgjbdsJzEf1NpVxEy8HgMQ6ODFAeaJh7mdrVUl+klO4UVMnqD+TeGsWt0gDi0PnrJrBC+DBPWDxeTDmfM+/VO/g1LjaRpDC69X5R3t3UthX/DuUc6mRk7NWyrfCTLdHBGV6V0hfItjeEl/834ZJKlknwGpkuVfHXs/JuLReuFz4yUXZH3DacoBBocSLb9Tvd8sYxoq8PkXr3uCb6GAKNjxpTsguwStBMny6fv/CwyB8vsHYgxrWRb7bJnyg/6aQJtIv7Ksl4mOSR4ZruilfJvRWLf+SMdiYy7YdAtbH26FBtqYhi2eAsuW7xcqDvRSmv2laevDmWXxpR3VVe2DF9vSZyDnWFsGyvuT4CCM4bp8boJzRgRCB6x0Vurfzl36F2R6tWcqoQ3PyqrUBjhLE8fXZwj+uDOq5kV3NmLsnz48oINPQbNMZtmq1WrREESE8WF6DmDySBzCD2WMtPBB8wpUuVd8a2k8cK5iFVSSIy3+dKxPVVBSm3a1unCaQg+My6h9BUcW+yald+1m5DBIQhpiI9a
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR07MB5381.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(36092001)(110136005)(54906003)(7696005)(316002)(4744005)(5660300002)(26005)(186003)(55016002)(9686003)(6506007)(33656002)(71200400001)(4326008)(86362001)(478600001)(83380400001)(8676002)(8936002)(38100700001)(64756008)(66476007)(66556008)(66446008)(76116006)(2906002)(66946007)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?rEIwQ/1fqzaZ8dQ7orRg4/YAY58POOVxr82trSjYf+Ypa6KEZ7aKNj0HnEI8?=
 =?us-ascii?Q?Zz/xaXWOGjKwdjDcjs55Cjvlmp/OI5daHZvHW6r1Dfa4vqyTrpiH7TeIMm18?=
 =?us-ascii?Q?n6kyghqSZfB5KfPAYCM7GQq5QRkitBQ510q9sf2tmsdtyTWxdcFqc1orRWXy?=
 =?us-ascii?Q?thVNniZtVLRt1tkrnS/Hhk3VmKD1mHheSOheMxjk6P7G1hH0h2F5xiQktSY9?=
 =?us-ascii?Q?xlkR7T+WA/wTkrV8lPmAGkDV/pB9mAqdVYaIwXbK3exHpKBHB5uK01K1gyDK?=
 =?us-ascii?Q?oE26c5qVtgfbMvFSmLiiqsZjx44MRYd/Rz0I0duFYbP18Io3PoYVaPr7/Znl?=
 =?us-ascii?Q?9w9rBNFbFh0jY+AuGiaR6ZwHDiG2ezQqEeiPCmRCGxtSFxiOlpf+qfGI8Fua?=
 =?us-ascii?Q?RZw6CJ5yZ6/ZT4FL8W5yd21IW078ScaDV0+62ooiu1h2tS4j2E1A6jkrY/CL?=
 =?us-ascii?Q?fsTToFkFeKvnteNdon+vGknT6qtiKFho9RjgzDvoi6Ji/cigBwvjdqDrqw3l?=
 =?us-ascii?Q?G9upLo+QVKx809sZ32rxO9rdKNjADNOj72QeugWmmR8VtPgvT+ybqN3qSKq2?=
 =?us-ascii?Q?Wuc8mhaa5PxzTmvh4U53+65uqD7XNLyQeWzr4zl8deraNNIjPolWY9yuT/g5?=
 =?us-ascii?Q?cIrIe7q3yUbNLMNX63aI4mYqk3hXB+E8KjpI00AsQSkxLFUfaVG0ly4mKus7?=
 =?us-ascii?Q?o6kuHNeaOSIno45I2kRqX1E5e33q+XuanCSUGno+dCJImdp7WRvcqEutBgdX?=
 =?us-ascii?Q?UxpivaX7p0MywPc91ODtj3tunj6FTeBbzbvtVLfok5Dx752p8bTc77YHB3oy?=
 =?us-ascii?Q?UUmn8vzDRi0Yiuu7VN/w8lKO+Leiqeuu6zgG1Vg4FRtvryF6OjhWLximnPTf?=
 =?us-ascii?Q?TNQAbFUcgSfh0Fo+GPmc52FHKcoGkajl8otzrDVnAyDqdOtX5JQVVv4emRQt?=
 =?us-ascii?Q?fNFhkrRhyN/EgZcti8OwcYh0FGl9n/ofAdeDeqwKNtVBjMzKhAfOI79G/OVf?=
 =?us-ascii?Q?e0J6QrVf5AOdAZcNGtGXxhO1bZr+SbcJY1tlEHvtaPhRK2ibW0cCGzf0GEp0?=
 =?us-ascii?Q?DkuEcqPQnrKv26s91Dv0hV39clRSJzMaVjblQpp7JrfRP4FtJoylRraGyvh+?=
 =?us-ascii?Q?vU8bW3na+Qwm9rndoHhA8uTnCiHjP7eA/UcYKPpHVC688mpL3cIlv8lQiXU+?=
 =?us-ascii?Q?jWSNIdXfRSo4f0/rgK//iJwnjLJcuSVz9Sh8v7jnylnbL7fgtddOkwiFbg7s?=
 =?us-ascii?Q?p+Rzkn6/f/Lagjg/OFdI6Q7gIIBB34GQyQlN6t4fg70Ep+jKcD8/+3R6ZPTK?=
 =?us-ascii?Q?pTt4cj4nFjrq+922yLaMF1YM?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR07MB5381.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 353c8538-f66d-4924-a895-08d8ed02df2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2021 07:19:46.1556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MbWgThF3NpdZrfB7oON9eX1gZFJP+CY2LbNV5V/KN2NO56JFg1b4azLQfuz6hC2grFPWbAmeSgyv8I7lk6q4xxgY3h4wwaARwvlE5hbqwRU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR07MB8151
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-22_02:2021-03-22,2021-03-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 adultscore=0
 phishscore=0 mlxlogscore=652 clxscore=1011 impostorscore=0 suspectscore=0
 mlxscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103220055
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Can you add this patch to for-usb-next branch.

Thanks.

>
>
>dma_alloc_coherent already zeroes out memory, so memset is not needed.
>
>Signed-off-by: Wang Qing <wangqing@vivo.com>

Reviewed-by: Pawel Laszczak <pawell@cadence.com>

>---
> drivers/usb/cdns3/cdnsp-mem.c | 1 -
> 1 file changed, 1 deletion(-)
>
>diff --git a/drivers/usb/cdns3/cdnsp-mem.c b/drivers/usb/cdns3/cdnsp-mem.c
>index 7a84e92..1d1b9a4
>--- a/drivers/usb/cdns3/cdnsp-mem.c
>+++ b/drivers/usb/cdns3/cdnsp-mem.c
>@@ -1231,7 +1231,6 @@ int cdnsp_mem_init(struct cdnsp_device *pdev)
> 	if (!pdev->dcbaa)
> 		return -ENOMEM;
>
>-	memset(pdev->dcbaa, 0, sizeof(*pdev->dcbaa));
> 	pdev->dcbaa->dma =3D dma;
>
> 	cdnsp_write_64(dma, &pdev->op_regs->dcbaa_ptr);
>--
>2.7.4

Regards,
Pawel Laszczak
