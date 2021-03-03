Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 144CE32BA8F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 21:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357881AbhCCLg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 06:36:59 -0500
Received: from mail-eopbgr1320103.outbound.protection.outlook.com ([40.107.132.103]:29331
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233914AbhCCDKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 22:10:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SpmDkUPGWazhYYnqHtuuZNcPUlOt+pWVI93/OrXaMVLxiQxk4xlGNBiBbKOY1Sw6Af/mR7532fnN/8T2eqa9qe1cj6u/vDkL527WbfH+JG6Hb3WBqnM+w1JmZJPKIuR0H2KE49YyZU5j5L6YXfL3hOTdnKtT7TVPz2YzU+RrxTLD5vimH14JS1XqSEH8VFhMkncpy5vsfoGR/uWZgmQf+9cMZgWZvhDGxCyijb7EIIGUD77UgN95ncdJE+/CzUUa6QXomMWpWcYFuB6GcU7Il6LaQzwtL2hIfXQdw0minWfyUyO7idoS0rt1+fTW8r0h8XlSPCbf0axgdYXK2E9iOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nx+IC5yZxUpy6ogOsxnAZmyWM6QBSXtgTSUV6UaWDUo=;
 b=Qhldrf0SIgIUij6S25xnUG6+xy3Gb7Z3jQeTqzs+dGiG9nb1AnRNVC7XsX3XmjzGOZty80rNNJX26aHe7vkkeFelfrZajnxiiClPHklGSgQ3alkGlb1bS4/+DaXBJRDgifCV1cF7d/1lYrVG3rk447VwnaZJ5C92QHLwYUNeAoxMKd9utA3sDiGzgD+gwuaArB9fxtQjuFrZ/iTkTI64Tq/vtGB+PIppIE9h97Xhy9589zysit+eryTtsqJOaQTK//PmK5JHHeHgeULs+snBnKLjKj6dZBmNm4Wg1KhzvthFRNx/3Otby6/zuD/8eYvFcsHnoKi4P2zw6dU5dy6A6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenovo.com; dmarc=pass action=none header.from=lenovo.com;
 dkim=pass header.d=lenovo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=LenovoBeijing.onmicrosoft.com; s=selector2-LenovoBeijing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nx+IC5yZxUpy6ogOsxnAZmyWM6QBSXtgTSUV6UaWDUo=;
 b=q89tn4Mhjp+0Kf1QSyV/OkZuDfsakgdc6PjxnauDFK8tvoacWO43xj/1/eSmZ99a7ncBIF7Hh7f7B734SOvwkFgX9qLpjj71+ZbMB1FAssrwr/75dJB7KzJ0RxoWc/VMq26JSqDYpO/S8fNj2bc1+yDJ2Q1FaqNt3LZhia6nnyQ=
Received: from HK0PR03MB3700.apcprd03.prod.outlook.com (2603:1096:203:74::13)
 by HK0PR03MB3009.apcprd03.prod.outlook.com (2603:1096:203:4d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.9; Wed, 3 Mar
 2021 03:09:01 +0000
Received: from HK0PR03MB3700.apcprd03.prod.outlook.com
 ([fe80::d923:be7c:16c6:b9f8]) by HK0PR03MB3700.apcprd03.prod.outlook.com
 ([fe80::d923:be7c:16c6:b9f8%2]) with mapi id 15.20.3912.017; Wed, 3 Mar 2021
 03:09:01 +0000
From:   Jiqi JQ9 Li <lijq9@lenovo.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mark RH Pearson <markpearson@lenovo.com>
Subject: =?gb2312?B?u9i4tDogW0V4dGVybmFsXSAgUmU6ILvYuLQ6IFtQQVRDSF0gaHdtb246IChu?=
 =?gb2312?Q?ct6883)_Support_NCT6886d?=
Thread-Topic: =?gb2312?B?W0V4dGVybmFsXSAgUmU6ILvYuLQ6IFtQQVRDSF0gaHdtb246IChuY3Q2ODgz?=
 =?gb2312?Q?)_Support_NCT6886d?=
Thread-Index: AQHXDyr31rtjFAcEvE6noeRX8jYlw6pwOa8wgADQcgCAAIx0cA==
Date:   Wed, 3 Mar 2021 03:09:01 +0000
Message-ID: <HK0PR03MB370019694C384BBAB939FA9583989@HK0PR03MB3700.apcprd03.prod.outlook.com>
References: <lijq9@lenovo.com> <20210302061205.1825664-1-lijq9@lenovo.com>
 <HK0PR03MB370088B1CE476C57A14D439783999@HK0PR03MB3700.apcprd03.prod.outlook.com>
 <5e09ae3c-f4c0-796c-345c-ec70a24c0644@roeck-us.net>
In-Reply-To: <5e09ae3c-f4c0-796c-345c-ec70a24c0644@roeck-us.net>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: roeck-us.net; dkim=none (message not signed)
 header.d=none;roeck-us.net; dmarc=none action=none header.from=lenovo.com;
x-originating-ip: [57.197.58.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3bb0e49a-b2ef-401f-931f-08d8ddf1b236
x-ms-traffictypediagnostic: HK0PR03MB3009:
x-ld-processed: 5c7d0b28-bdf8-410c-aa93-4df372b16203,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0PR03MB300914BC123178A76030B24283989@HK0PR03MB3009.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j7raVVJDqsjEqhJDF57WLmELSnGTLQGGAKEYc2inrZtfIyQkTsRAOSiNBNdrCHCE1HnbIbq3s/8ZswILW7rY72s6OACd+88UB/NXK5q2UHcBH5sBw0v4y4DW+UEZJ78SEopJGE4fzwU1olf6AxdziEHjhA/okeyebw4ABmOhUTEEuaqQosC8UOvVttsQAUJ8iNsocDZDtR+KuBH4GRN/Vmc33u9ONkdH02Tofz0fpDyr/PxoYl3PLUPl2yCQD15OsD8sL85peYsAKpINemGiyl6CnFCgGvnztGt2l4BTAlkYWtL5l6jaJdsnA2zlqVzJLaL8f9mStqs4DoE4lV5JGhHZWT780pWHp6AbgKXHLiGT0OkH/o1o8rZxcahNQHb0Q/HuhJHqiBemqjdXSe8p/fIE/RHYeP9FRL2zSTu2QYwRFGrTcZJ7PGX1Rfe3dy240XrOTf/pUFsV5/F84GEQR3t/3oHI1Lja9m95AHw5diwhmhy1quqBPLqIvwtaZAE5Jed+7WGF4POZ2PbtKwjHwA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR03MB3700.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39830400003)(396003)(376002)(366004)(66476007)(66446008)(66946007)(86362001)(186003)(4326008)(224303003)(5660300002)(52536014)(76116006)(66556008)(64756008)(2906002)(55016002)(33656002)(26005)(107886003)(6506007)(508600001)(110136005)(7696005)(83380400001)(9686003)(71200400001)(53546011)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?gb2312?B?Q1phaXdDZW5rK1kwMVA5TktyZVl1ODVoMDU4RmVjbWJmc1BobkZXQ3lOc3Qx?=
 =?gb2312?B?N3JDNFVTWS9od2c1T3dEUzNkRGdYaFEybFZwRkw1UW52UDZPV3NTaHBNdnli?=
 =?gb2312?B?OUxyUEdyT2ZQRmcxdVdDNklTVUJmZzk1cFlXaFVIMGF6RUU4UnlVVTV5ZGFQ?=
 =?gb2312?B?VG5DTWsrMlB3TjhiWVpPWEtlaVAwZkRnRkk3VVY4ZmMyVW5ockVtZzRTTGZl?=
 =?gb2312?B?Nm5pakhsNU42dXRLazFMY0FVTWJDWktxcUtyaHYwTkQvczZyZlRBd3Z4YzBp?=
 =?gb2312?B?SGNvRG1TTDdyRitldENhT3IxVkxyeVBLbzQ4dzZldGRwWW1wengwVTF3bVFB?=
 =?gb2312?B?YVhXQUtQZG44Vm56d0txZW5tT21zOXNqN0E0TmozOXNVRVFiai9ROTVUUXV6?=
 =?gb2312?B?QS93eWY5UStTbUxNTHZyc2lPUEk3ZlZRZGYwaGpyczEydHhxUWFBSzF4VDlj?=
 =?gb2312?B?eGJCWE9kUXlCZ2JqRUgwRTZqRE9OcldUWnNWRGZsMTd0VVlBV25XL0ZSNEVB?=
 =?gb2312?B?SkdCNHh1ZTFCeHRHajdSc09LMnZtU0l3M2tRL3hKTXFjbGk1MzFsNVlXMmc3?=
 =?gb2312?B?UTlmc05iVHZiWGtZbU5rRVpOVHc0QytEY1dtN29lamppOTZDQWtkRFhHUHZu?=
 =?gb2312?B?cXhNVEdJd3JPaThuK29oVW5yUWdTSW1uSWdrTmRCcWJSaCtWdUhaMVhCMnVm?=
 =?gb2312?B?aVVaZEQ2R3hGTWxFNnB6ZzZJd3FyOUYydHJ6d3RzeE1EVFFNWXJPdDZNV09y?=
 =?gb2312?B?d1dBVmxhdzFsNTVVYVl2SkVzTnpHQ2M3bnZnYTR6R1F6QklzdjcxRlA3SzlD?=
 =?gb2312?B?TG1aeTFHN3ljU0RYaE5VbzNVYU9hQS9vK0x0NmI1VFVaeEVxSWYyWjVxdE9r?=
 =?gb2312?B?ZXVZTENmSERRczJHZVdKTkZldU5UN1RoVFhNS2JvWGN0WUNLbk01QjdJZnJB?=
 =?gb2312?B?cW96djVWQ2Fxc3FCTGhtWFNvSEZ4YTdZTEsyQnVMNzh5YXdDNDFDMStMamhS?=
 =?gb2312?B?Uzh1cmlCcHBCV2Q1T1ZzUUE1ZFRRTGsrZ3NEQy9DN2s1MmYyclNlNWVYTWVO?=
 =?gb2312?B?dms1NzQyeVUvcFVNRkZmeUREd2Q2VFQ1RnIxaEQ4RzdXMzk4MGx4QkxRUTJC?=
 =?gb2312?B?L0RqOVlzY3dLaXJ4enRYWEk0U2pPUVc5eVVGUUwwRTZ4V053cENZckxWeXR6?=
 =?gb2312?B?YmxLQ3VPN2R4cE91WHdMZ2xKWnl2WW5JWnBXKzBWQThyRk9kWjRacUgyVFFr?=
 =?gb2312?B?VmFrWWJPM0taMzdYdHdHN2tjK0I2Z1RNWVlLeDdKR2Z0bmF6elF4WjRuMnY5?=
 =?gb2312?B?Z3R6TXJOdWZYOTRsaHdkbnMrMlFlblZpTVZ6UGRtQU94NDRTbWhjZWJyakds?=
 =?gb2312?B?T2EzUEN5a2dJQlFxZmtyWWpzOEY5Q29zYXdBaVhkeFRnZEVZbnZ0R3kwdW95?=
 =?gb2312?B?UFdGbkhuZE5TdzZXVGZHbldTVko2MWh4T21DWVpaajBRajhGUUQzT0xScU8v?=
 =?gb2312?B?UVNFaUUzTHlTaEVGTS9QQm1BTU0wT0NvUzUra3RjRzZnN1E2MDlsM2ZrL0t5?=
 =?gb2312?B?c1IxMEhnZHU3Z1ZDZkUza2F2S0hGTWNkZ2NxUHdTekxxL0hIY2N4TDc1cGpJ?=
 =?gb2312?B?UlpHaHFBY1JvRVlHRFN1eGVRdWZha3JtRzJlZllDR0Qwb0svVnRiVDZYTWd1?=
 =?gb2312?B?ZlNsemx6amhzaXNoQzRuTE9pY2Q0d2pVSXVLZkg2YjB2L1lXUWRab1IwZHov?=
 =?gb2312?Q?7qajex2BhQEDacbCpJs4i3DulXNPEBiHKfoPIgH?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: lenovo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR03MB3700.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bb0e49a-b2ef-401f-931f-08d8ddf1b236
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2021 03:09:01.8353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AoriWuBwH8AtFde3mPQDhTdNCwi4Uyap5BTRY0G2SFHC1dTSuKAglcQHFamSUiVfC9vAkQWSnSt7qOpTveca7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR03MB3009
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzLCBJIHdpbGwgcmUtc2VuZCBhbm90aGVyIGVtYWlsIGFib3V0IHRoaXMgcGF0Y2guIFBs
ZWFzZSBjaGVjayBpdC4NCg0KUmVnYXJkcywNCkppcWkNCg0KLS0tLS3Tyrz+1K28/i0tLS0tDQq3
orz+yMs6IEd1ZW50ZXIgUm9lY2sgPGdyb2VjazdAZ21haWwuY29tPiC0+rHtIEd1ZW50ZXIgUm9l
Y2sNCreiy83KsbzkOiAyMDIxxOoz1MIzyNUgMjo0Ng0KytW8/sjLOiBKaXFpIEpROSBMaSA8bGlq
cTlAbGVub3ZvLmNvbT47IGpkZWx2YXJlQHN1c2UuY29tOyBsaW51eC1od21vbkB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCrOty806IE1hcmsgUkggUGVhcnNv
biA8bWFya3BlYXJzb25AbGVub3ZvLmNvbT4NCtb3zOI6IFtFeHRlcm5hbF0gUmU6ILvYuLQ6IFtQ
QVRDSF0gaHdtb246IChuY3Q2ODgzKSBTdXBwb3J0IE5DVDY4ODZkDQoNCk9uIDMvMS8yMSAxMDoy
MSBQTSwgSmlxaSBKUTkgTGkgd3JvdGU6DQo+IFNvcnJ5LCBQbGVhc2UgaWdub3JlIHRoaXMgZW1h
aWwgYXMgc29tZSB0eXBvcy4gDQo+IA0KDQpObyBwcm9ibGVtLiBJIHNlZW0gdG8gYmUgbWlzc2lu
ZyB0aGUgdHlwb3MsIHRob3VnaC4NCg0KVGhhbmtzLA0KR3VlbnRlcg0KDQo+IC0tLS0t08q8/tSt
vP4tLS0tLQ0KPiC3orz+yMs6IEppcWkgSlE5IExpIDxsaWpxOUBsZW5vdm8uY29tPiANCj4gt6LL
zcqxvOQ6IDIwMjHE6jPUwjLI1SAxNDoxMg0KPiDK1bz+yMs6IGpkZWx2YXJlQHN1c2UuY29tOyBs
aW51eEByb2Vjay11cy5uZXQ7IGxpbnV4LWh3bW9uQHZnZXIua2VybmVsLm9yZzsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZw0KPiCzrcvNOiBNYXJrIFJIIFBlYXJzb24gPG1hcmtwZWFyc29u
QGxlbm92by5jb20+OyBKaXFpIEpROSBMaSA8bGlqcTlAbGVub3ZvLmNvbT4NCj4g1vfM4jogW1BB
VENIXSBod21vbjogKG5jdDY4ODMpIFN1cHBvcnQgTkNUNjg4NmQNCj4gDQo+IEFkZCBzdXBwb3J0
IGZvciBOQ1Q2ODg2ZCBjaGlwIHVzZWQgaW4gdGhlIExlbm92byBQNjIwLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogSmlxaSBMaSA8bGlqcTlAbGVub3ZvLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IE1hcmsg
UGVhcnNvbiA8bWFya3BlYXJzb25AbGVub3ZvLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2h3bW9u
L25jdDY2ODMuYyB8IDkgKysrKysrKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9od21vbi9uY3Q2
NjgzLmMgYi9kcml2ZXJzL2h3bW9uL25jdDY2ODMuYyBpbmRleCBhMjMwNDdhM2JmZTIuLjNkZTdi
ZDE0Njk2NSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9od21vbi9uY3Q2NjgzLmMNCj4gKysrIGIv
ZHJpdmVycy9od21vbi9uY3Q2NjgzLmMNCj4gQEAgLTEyLDYgKzEyLDcgQEANCj4gICAqDQo+ICAg
KiBDaGlwICAgICAgICAjdmluICAgICNmYW4gICAgI3B3bSAgICAjdGVtcCAgY2hpcCBJRA0KPiAg
ICogbmN0NjY4M2QgICAgIDIxKDEpICAgMTYgICAgICA4ICAgICAgIDMyKDEpIDB4YzczMA0KPiAr
ICogbmN0NjY4NmQgICAgIDIxKDEpICAgMTYgICAgICA4ICAgICAgIDMyKDEpIDB4ZDQ0MA0KPiAg
ICogbmN0NjY4N2QgICAgIDIxKDEpICAgMTYgICAgICA4ICAgICAgIDMyKDEpIDB4ZDU5MA0KPiAg
ICoNCj4gICAqIE5vdGVzOg0KPiBAQCAtMzMsNyArMzQsNyBAQA0KPiAgI2luY2x1ZGUgPGxpbnV4
L3BsYXRmb3JtX2RldmljZS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4NCj4gIA0KPiAt
ZW51bSBraW5kcyB7IG5jdDY2ODMsIG5jdDY2ODcgfTsNCj4gK2VudW0ga2luZHMgeyBuY3Q2Njgz
LCBuY3Q2Njg2LCBuY3Q2Njg3IH07DQo+ICANCj4gIHN0YXRpYyBib29sIGZvcmNlOw0KPiAgbW9k
dWxlX3BhcmFtKGZvcmNlLCBib29sLCAwKTsNCj4gQEAgLTQxLDExICs0MiwxMyBAQCBNT0RVTEVf
UEFSTV9ERVNDKGZvcmNlLCAiU2V0IHRvIG9uZSB0byBlbmFibGUgc3VwcG9ydCBmb3IgdW5rbm93
biB2ZW5kb3JzIik7DQo+ICANCj4gIHN0YXRpYyBjb25zdCBjaGFyICogY29uc3QgbmN0NjY4M19k
ZXZpY2VfbmFtZXNbXSA9IHsNCj4gIAkibmN0NjY4MyIsDQo+ICsJIm5jdDY2ODYiLA0KPiAgCSJu
Y3Q2Njg3IiwNCj4gIH07DQo+ICANCj4gIHN0YXRpYyBjb25zdCBjaGFyICogY29uc3QgbmN0NjY4
M19jaGlwX25hbWVzW10gPSB7DQo+ICAJIk5DVDY2ODNEIiwNCj4gKwkiTkNUNjY4NkQiLA0KPiAg
CSJOQ1Q2Njg3RCIsDQo+ICB9Ow0KPiAgDQo+IEBAIC02Niw2ICs2OSw3IEBAIHN0YXRpYyBjb25z
dCBjaGFyICogY29uc3QgbmN0NjY4M19jaGlwX25hbWVzW10gPSB7DQo+ICANCj4gICNkZWZpbmUg
U0lPX05DVDY2ODFfSUQJCTB4YjI3MAkvKiBmb3IgbGF0ZXIgKi8NCj4gICNkZWZpbmUgU0lPX05D
VDY2ODNfSUQJCTB4YzczMA0KPiArI2RlZmluZSBTSU9fTkNUNjY4Nl9JRAkJMHhkNDQwDQo+ICAj
ZGVmaW5lIFNJT19OQ1Q2Njg3X0lECQkweGQ1OTANCj4gICNkZWZpbmUgU0lPX0lEX01BU0sJCTB4
RkZGMA0KPiAgDQo+IEBAIC0xMzYyLDYgKzEzNjYsOSBAQCBzdGF0aWMgaW50IF9faW5pdCBuY3Q2
NjgzX2ZpbmQoaW50IHNpb2FkZHIsIHN0cnVjdCBuY3Q2NjgzX3Npb19kYXRhICpzaW9fZGF0YSkN
Cj4gIAljYXNlIFNJT19OQ1Q2NjgzX0lEOg0KPiAgCQlzaW9fZGF0YS0+a2luZCA9IG5jdDY2ODM7
DQo+ICAJCWJyZWFrOw0KPiArCWNhc2UgU0lPX05DVDY2ODZfSUQ6DQo+ICsJCXNpb19kYXRhLT5r
aW5kID0gbmN0NjY4NjsNCj4gKwkJYnJlYWs7DQo+ICAJY2FzZSBTSU9fTkNUNjY4N19JRDoNCj4g
IAkJc2lvX2RhdGEtPmtpbmQgPSBuY3Q2Njg3Ow0KPiAgCQlicmVhazsNCj4gLS0NCj4gMi4xOC4y
DQo+IA0KDQo=
