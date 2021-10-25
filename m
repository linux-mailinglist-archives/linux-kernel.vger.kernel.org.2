Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8466F439673
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 14:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbhJYMkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 08:40:09 -0400
Received: from mail-eopbgr1400103.outbound.protection.outlook.com ([40.107.140.103]:9102
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233117AbhJYMkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 08:40:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZUXpYPieXorXmvJ3QDrJSUjm7xUDvCfD2nEP2+s5EHj0QMNFBhjPbifHYg5LT+pNS+XKZl71K3/h5bqw5Iv7oQG4A9dNdwKwAVZz4HOKXtabnN/F6YXxViqcpKnFLS2kYQiURJPZ/BA/Lu6C1lrZpKDxJvAMmYFHfMG0VAQ/YqWZFSlbZ8SEMLGPGQNkXrIua/jMHS6JsF1velk0WGrl8AU4ey5xJyXGpdcb06g68tZQFZQRUGYSRU3FDRvoA0frYvX5twEgrl20VM2HDZHneMxUCifaXx5v54nRZr3bh4AUBgLBUHPQM2Y/qoAEmM/xhFES5ntzinkwUm/Kspl3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PX9Efxp2ERkrN51f8YiA0m9ScWyb1ho0bTN85YF7fGY=;
 b=gFsz08l0v4naNoTynWRSBcMFd2VZHBdw2/NK96+bCXNjyHDrsdTW5rcy6S7tje+fDrqgbxGAptgJEQ4t+5i+KLcPPVRrhp7jx2DjUfT0DSl0uW28ywpXhWApPGwgzox5TL07TY7jnXH4iVdnWlc4Q4ji4ISrwYIIf4tKkpr4a8NUYV88LkoebzZSgl4nORQF4r9xrSpKvQWXZCXGidJCkF1d6prCTlNwyY5ziYSqt/LGg+Cj+1ILaLRYTUuKxlnuIGRIO18gm+yl1UVQYw5PADhyKhvJqEq6q3RvXLnNdL/a+yvoEB2wxSgaHpZwIjgv2cTk4pPgHIggiJNkFI16Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=connect.ust.hk; dmarc=pass action=none
 header.from=connect.ust.hk; dkim=pass header.d=connect.ust.hk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connect.ust.hk;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PX9Efxp2ERkrN51f8YiA0m9ScWyb1ho0bTN85YF7fGY=;
 b=3T+nVgZifkZlVtpXvRcOhosoO9ve5pDFCjPU1z4aeyZBeFnQ3bfIiLK3edWgS3FjcxQSr2CW5KPlrubMtttlMJUF5yL/UEhypTb6WcRZ1+AfcNG9ZvIjL4NT0zzEsFAFhoONNhGgyE+5sJe3inoCXLMa30G9LCsIy1HObWtknS4=
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:b7::8) by
 TYBP286MB0287.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8026::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Mon, 25 Oct
 2021 12:37:44 +0000
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04]) by TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04%7]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 12:37:44 +0000
From:   YE Chengfeng <cyeaa@connect.ust.hk>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: 
Thread-Index: AQHXyZz+BAm8cC2cnkuRu4tQ1YSHZg==
Date:   Mon, 25 Oct 2021 12:37:44 +0000
Message-ID: <TYCP286MB118894A0130C114FB995F95C8A839@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 6a9e9603-6326-6142-e0ff-6e450c52c0e9
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=connect.ust.hk;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: abd92418-cc35-4e47-1557-08d997b43e86
x-ms-traffictypediagnostic: TYBP286MB0287:
x-microsoft-antispam-prvs: <TYBP286MB0287258687E306C9356526C58A839@TYBP286MB0287.JPNP286.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZPk3x8Yx7E94Mg5SFyR+q2J0M3D7MeVTMoPqRXKJH6iwPyI7alUn501ICD46/n234DH2h+p8bAktr0ZRhpqXkVR4JCfLyJBae7ks2UKj/zv4ThRkIFwyCghWBv7wA/g18DajAG72test7bUWsJ7197sUhwcePEv19R5sjDAXvsLvre9qEzjnL5TdJaVY3oAjt9sH59YCkZD56x78jUbCUXqU9u8SY4lHzjh19S00ZT830Z9j1zOX0tO/dwfiFY8YZraxKOxRvVWR2euhqriK5ig+XqpVHxURBj/z2xDA0eOmdQJMbdUNo1eambWZJsZhswzEMzgv8bxN2U+T/fgaErrp8kMSzJF0ZKhU746oiFTOdCNqKJyTH+aI2pAEk3xLz7Am7N8XfFBUI4V05nMecz7rJxyg3HKFuFUDzG7lwf0q/o8Qs/OpL2qE2zKm1eCl6psOXilt1thcmqBeDx2BmRDHfBLHzyQ/T8x/5GaVgQg6thM/T9YKSFvun6luahUjy7gtj00gFVxWZ6gGfOxg+qTQs/JUxqepes5Kcz/fxk010UOTKcEIlLtE6mvjotC2MrtTuxj9Y/brffp1UKCP2j1O8jOp5D7XbFwQ2NeDBAiunWWrovk6yA16rQaxAWDpQ1N92nKztdqNjJEgaiHjOB8jzr9MAD/8mYpEleJ7whsAShPLSD0gbBX/oGhaIIFiajbTncitFgBf+IUksGk9HeoD6tJgAAeFjYYqiTxhTWM0z1zbN23v5AV2S+UPUaqT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(66946007)(66476007)(66556008)(122000001)(38100700002)(508600001)(76116006)(64756008)(5406001)(26005)(38070700005)(186003)(33656002)(86362001)(52536014)(786003)(316002)(55016002)(9686003)(8936002)(7696005)(6506007)(5660300002)(2906002)(66446008)(558084003)(91956017)(71200400001)(15477505002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?ZEs1ZDhnQ2xGWVlPR1FOL0FIeTZRdHg3NktCNG1lQWVrWlpFZkhlYVdncXkz?=
 =?gb2312?B?TmxkREtHdzdkc0lQMFRsTGozanlOOS94Rk43a2tWQmVLRkxocXdJUDRBbTBT?=
 =?gb2312?B?b05rREZhSHRkVzNtUXBsZFB6WXhOTEdjUXUvVmFZdjRiUUl4QzdqWXA4MUR3?=
 =?gb2312?B?UWVieHdtVHpRYklXZ000OWwwSlZwdVhNRzIycDI0RlNXK2ViSXg2TzRYc2xR?=
 =?gb2312?B?aHprMnZzYTVLWVFUeDBUSEdxNStURWFXcE5KU3RiRzBnaG50TlBmNTFoYnBF?=
 =?gb2312?B?MlBXSEV2cU9lOXhCdDFldnJGMSt5N3NjaXFJRDZuM0cwa0pLNEZjN1U0SEhh?=
 =?gb2312?B?bytVd2h1Z3ZubzF0cEZhMTY5akJkOXJDY2RVMFFXalMvYlpIc0ZqWEJBQVVp?=
 =?gb2312?B?dGEzYmZOWmtXWFhOZVo3b0QzaXpSY0F5QkZBNjB3aFRGMndrdFpMK0hyZ080?=
 =?gb2312?B?dG9YMGZwcHdLMVFRVUYyS1VOVi82QjQvYm9IV2QvZTloR3psdHA1c1pIYjdz?=
 =?gb2312?B?YkdsMTltZk1wb1U3akU1eDNaUWZDTDNEZVh6MXl2elZ1UXZGVVNmSFkxQ2JK?=
 =?gb2312?B?cHVlZlZsR3NMdzdJZE5xVk0rQ1pyTUw0VkZ2bTJkSUlQVVBZbjJxdVRlenYx?=
 =?gb2312?B?WDRPdnVzRGJqdWhGV1NiTzlyQmppMTVvN3VKdEhQOWlnWTdvN3l0c1Z4a0Zy?=
 =?gb2312?B?UkExeUNDSVpac3Z6OEVQOGdRRDFjVlJnRXVUeENybGlsL2Vsem16Zm85Y1k4?=
 =?gb2312?B?SXMyVlgyS0xDWndWUlBuVFNFNi8wRVpKNnVyaStaR3hBdHFGOGxTT21jZkpQ?=
 =?gb2312?B?MHNuek9VbXgyOXB0M2lvdy9rQmd0NGNJUXlUZ2dYTkc3SmFPSCs5UGJqZ0Jt?=
 =?gb2312?B?ZFU5dmlRRVhHd1dKQXloc3hjNDZiU1QrZk1GdEd0N1F3d3gxc3NSSmtkeDNp?=
 =?gb2312?B?TU1HVHhMNTNCaEk2VkgyZFZjL1FGUGNyTGEyVmxrMU9DZzRxWmRtNHYxcWtz?=
 =?gb2312?B?QzBEWG5YS25kdVZ2TTdCNjlLbHBYWnQrVys4MEdJeXFza1B1dUFJYUJ1MkVD?=
 =?gb2312?B?bGU1MlZzdjVESEk5VWcyajJvUFJlSzVVWGt2M0VXZnFqZVBCMk11QWNMQkNv?=
 =?gb2312?B?S0RjMTYvMDZGR1dpb2Z2cGRNNTNOU3J4Uk9VM0E0dmdCQ0Y5dUJWLzBZR3JX?=
 =?gb2312?B?RmJqVGRxdlNTTDcwdmpvSThQTHpYUkdEUWxxaXhFZGpWZ1lYQ01pT0szK0lh?=
 =?gb2312?B?akFMOGpCY0xrWXJnVlNtVkZVYnpzc3JPMW1kN1lxbXFjajJsVmhrRnhkNUc3?=
 =?gb2312?B?NmJrWDc2OWJQVUtNci9EV0YwMzN1Zlk4TGppeEtrWEdpTGdETlUzanR0UEdL?=
 =?gb2312?B?NlI0RWFQK0F1OGF3K0ZnemVNOW4vWVVrSWE1WGdwQmhvYlFWcU40UW8rK1Rv?=
 =?gb2312?B?WWk3QVgwb08zQUwrdU5NL1lJYkVMYnRjK1JHVWFkUWh5Z09DNTBjT25pa0p2?=
 =?gb2312?B?M2JDYlp2V0lzWVBvbVJEYjlmUThFN216NjFET2lFQ2QzOTFWTk44WWsyNThQ?=
 =?gb2312?B?bWxDMDdQNDVXeVRWWTdLR1ZXeWFWQVN5QXY3SnlKVzJodzNJZkgxYUVDb3FO?=
 =?gb2312?B?WkVPQW1nN1ZuSXY1ZUl5Q2pIeFdBQS9oZnhSak5qSkplMDBRVVYwWHdLZ3g0?=
 =?gb2312?B?TVJ3TS95OXlEMWJwREtuaXZIRkdKR0d4d2RIdWhRbWQrV3B5VUNWb2dBdXlP?=
 =?gb2312?B?cHpoK2Qvay95dkZqYjArYkZ0T3lWbkNYa3B1TjhZc2JrbzFYaHp1OTFtajQ5?=
 =?gb2312?B?QzR4SkU3Qkt5MzhzZUZFMitHQTdMUW5YVWpNOHh5NGdaU3BDZDlTUEx2YVZX?=
 =?gb2312?B?RkJHK2hkQzRrbnd4eHRaSFZyblZFUEh3b255bEIrZVppMitNZ1d2TG9teG9M?=
 =?gb2312?B?R3BybEx0d2RTU3dIM2IrNXVBMkRXOWVsMXVUck1YVFBnQmFnNDBNZjUwTnll?=
 =?gb2312?B?UDAvMnJIdUovTUZES0tuY3pnZ1lwek5Td3lTNnFadnJiME5mc1ZibWozQjdG?=
 =?gb2312?B?dnJSVlZ2V2NJQTYvR3ZRakNJa0I5cHpHTUhUMWtzeXEydm5XcGc2bGRPQ1FU?=
 =?gb2312?B?RXZHa0NnbUFDNi90UTJOTUVvdWxka3NqRmVvb0xoOGdQeTVjMS9kU1FPak9T?=
 =?gb2312?Q?U/+qGoPluCqorkbVkN4zxqo=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: connect.ust.hk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: abd92418-cc35-4e47-1557-08d997b43e86
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2021 12:37:44.6188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6c1d4152-39d0-44ca-88d9-b8d6ddca0708
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9KS1Q/fdh/nC1QvJKZ6TZFpoXwJ4k+ndczGTagp5/qYGBn9fNT+idXhWg7seHexkr2h9Qc38KW9GULZ9fbOhYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBP286MB0287
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YXV0aCBlZjdhZjdmNCBzdWJzY3JpYmUgbGludXgta2VybmVsIGN5ZWFhQGNvbm5lY3QudXN0Lmhr
