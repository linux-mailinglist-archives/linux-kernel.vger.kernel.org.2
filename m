Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE8F0353B77
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 07:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbhDEFOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 01:14:22 -0400
Received: from mail-eopbgr40046.outbound.protection.outlook.com ([40.107.4.46]:52805
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229540AbhDEFOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 01:14:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7EqW6dIHi5OlehPh4oaG2oNZkaoAyJovLeBRHhFu3VAwkCCREA1VYK+L0YBZwkAytZ6ULSo67967SCb8zyThSquvez42sr78vmuOkIsJYgvhMTjueoYjKaWCPoqBtTZl6jWH4ti7yrM0yfceoZK4/F/Rp1k9fVxN02Ysh4pLhA3RifP1HetEFhu2bNM1dmSwbWi0/513Zx+QVbdGdUMIjPDD8KD5D+jjAskxT+kPP2VPUGSVlv/ysUs7StuPhi17s47LpY6+NCke+cCcKifrEgUAU5/xuwp7twzbJ4+FNALNxraXux3R+aht4uP3DQaI8qKupkH4zol7NEt7xqeNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drC8Mnd9fhTWiHP3O9ncBBesquqrzSOt1dHTKiShJdA=;
 b=LYonYi9mpnSqJD+lrmXVgl6oEapPEV3/MsUgpHn9317hm+X9pU7XJNkzX/SJB4eZZT7UPp6Ft0yNFRVpfC/52hvM+NMtgDeFhKcn8ZTg+zbeZUjyZXZlKbEtyxpbH85HEheNHbLrElQLdgZr8p82t69Z7F4837J33pO0V49YkoZYDT/28pEGD2M86Iesnv/DTrsJB2ZzwHeeXVCldI8slpBZxD/d01Amhfd02D/tyXenccf5nnYLj4p6d1l2I/zOV0emRdtKsORMYbrkxFGODnFPb+Jh9ihtD3os4+2mFLZowFlVROfvoJmqu70d1vPKViFWauHi5fK+/zY1R9bvkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drC8Mnd9fhTWiHP3O9ncBBesquqrzSOt1dHTKiShJdA=;
 b=t0DhYmwSVd4YhTL5BYidDGXeNPam5OwtnkLVAbdtlV+9LBuzhwoXhCKP01nOcZyCARqe1osU9PjV3i7lGoUwuaxuVlWVsRpgHebt9qiida+IoYBu4ts37kevaoI3dFBFCo9JBZD9EB9psUl0Z40jTxh5B9v6lBK5ZhJlf9ghb20=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR0302MB2587.eurprd03.prod.outlook.com (2603:10a6:3:f1::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.28; Mon, 5 Apr 2021 05:14:09 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::f4d0:ee66:d5fb:9cdd]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::f4d0:ee66:d5fb:9cdd%3]) with mapi id 15.20.3999.032; Mon, 5 Apr 2021
 05:14:09 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        linux-power <linux-power@fi.rohmeurope.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH v5 15/19] regulator: Support ROHM BD71815 regulators
Thread-Topic: [PATCH v5 15/19] regulator: Support ROHM BD71815 regulators
Thread-Index: AQHXJJt1XmMiZln9KkGiE9saW20FG6qhhdKAgAMOFQCAANfkAA==
Date:   Mon, 5 Apr 2021 05:14:09 +0000
Message-ID: <969e9b15a7f8da9d49950a0f78323e48467229c4.camel@fi.rohmeurope.com>
References: <cover.1617020713.git.matti.vaittinen@fi.rohmeurope.com>
         <eb20a8f466a9ccbc26d261f0102d203718a32fa0.1617020713.git.matti.vaittinen@fi.rohmeurope.com>
         <20210402174215.GI5402@sirena.org.uk>
         <a387f856d3a5d4b01124eb54c5b9476bbd61c86e.camel@fi.rohmeurope.com>
In-Reply-To: <a387f856d3a5d4b01124eb54c5b9476bbd61c86e.camel@fi.rohmeurope.com>
Reply-To: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=fi.rohmeurope.com;
x-originating-ip: [2001:14ba:16e2:8300::6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 00e096d7-5dd3-4691-04f4-08d8f7f1a4d5
x-ms-traffictypediagnostic: HE1PR0302MB2587:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HE1PR0302MB2587E4CE80DAE66720E636B0AD779@HE1PR0302MB2587.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qRKJ1ITmJr2cnlQw50JPyDCjF4gr1Bt407mrC2IzMztky2voCqbeBmoIZQ3Gujc85xZfb4vqXDeMv8kqQuHWiai5a6fcV+QOYe90Hboo7qEEeZsvH+7DkAm69Dehe/dp2Ki8+MweM6MyMFyABP+yA+zxVudmZijrlgkgtG0SJ5iPHRwXRMyH7xJOYWs4ma2YBhBvLtYyPSwZHyzgch2u9oz5/mJAy9BdzNZ1SO/ckA/icmigNYDqpNOP898E/Tpl5x4Jh/nzdyDxYp61dNac6ZuJPMPSaoXPs62zR7/m/hgNWjXqfmKN4+zMyAz+O/bqGINTY6t3IsjlHZIC92fvyvph4IeLuVxzRfanXcI5IySBygajfuAC6coIOnIz6ok7ViM5qO4odzDbTv69OiB3OZhxXAJd0sPoyMYq3BdW/UOw73Rk1BMpJkWxIKs7VZbdw2pRSN8NEPLgy8GzTjde6UoY/TYUrUTaivBGfWQhczHuN4UQW1shdxP+UyWfkb7WxOiALQdXnwKUTni59kdRmhIbUd2KPBsFgLXXejBI5NUICUWaTDrj66nTk/BTdbBjBgHhE31M3qwWmq+/fl72mqrUWHobgXNwH1SO7Y4ygd3NYo69zc41y3S/grkrJk+bD7gy4xkNPcc6eBh1RHBx6WPq1aoh+3Kl8ySuqoN5esk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(396003)(39840400004)(366004)(6486002)(6512007)(3450700001)(478600001)(86362001)(4326008)(316002)(186003)(6916009)(71200400001)(6506007)(38100700001)(64756008)(54906003)(66476007)(66946007)(66556008)(4744005)(66446008)(76116006)(2616005)(8936002)(5660300002)(2906002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?T21JbVZOY3VWdzlUMVhYRm1adjlxeGJHR1Bkek91S2Z4cGpONC9USkVwRzhu?=
 =?utf-8?B?Ymd0NlJVZ2kwZkFXRWlpMUhJbjY1LzJ5cnI0ZWJRdllyRk1tdGZKU2x5aTAy?=
 =?utf-8?B?UWxuc2dxZlVudFR3RndRMkxaUXVnV3NLemVJWk9GdDF4aG80aFdSYTgxbHYv?=
 =?utf-8?B?VnMvSTdOTHgydE1JV05mZk5BTklCczFpUkkvSmgwUU00OVU2U3BSR1B0dFVj?=
 =?utf-8?B?bU9HSnE3UDY0QzArRXhDczlqVTY5SUs2M3VLN2hPelVuQzZQUjd4Ri9YNkt3?=
 =?utf-8?B?M0F5Mm1kcXhPTUlSWVdMTlJSMURWZ1hQcFRNdHdMZG5sRzhueXFaY0FhKzVQ?=
 =?utf-8?B?d2dJVzUxNHJ6NWNhcnB0K1dXVDhwRHVEbk5SNEZacjkydy91K011NEs0UnRy?=
 =?utf-8?B?cm9aTDFOWHU2Z2Z4U1A1QzFwVXcrVkpVTmo5bU5ES0grTjFwU2NMNUZZbGpK?=
 =?utf-8?B?R2Vza1NLbzlHNHd0eFVuaTUzT2JOUmxhWEh3c1BFWHZrOGdaMlMyelhlaExo?=
 =?utf-8?B?QzR6NEttSTVpVG1pVVFoZ0VNSDlPRkdDNWdTc1UxcWE3NFFWL2RBNTYzV1k0?=
 =?utf-8?B?V0RJV3dNQk9jWlZ0cWYwTm9TbitCOElOVUtNZENnb1lOQkkwUXlXMzY1akY3?=
 =?utf-8?B?TzlGaTZhRmNudll4MHdFRkpRQ2dqRzlJSzN2TFNMRlNnZXBhNjY2UDBQaldN?=
 =?utf-8?B?UGN0K0Z1eVk1UzRMSkZlRVFtajZJQlFBRzdTajNCblRQYW9iTlVXUGdBSFJm?=
 =?utf-8?B?Q2pSTTZzVG1tTE9PWDlab1lYSzBLcEhCNmtMaUFHQkl2RWFmaHV6YzlzL2Vt?=
 =?utf-8?B?T3Y5OThPT2RiYWYyOXVnUXBFOXluaERyOGZDQWhmWU1abVIvdWhpTERFWFJi?=
 =?utf-8?B?aERRY044NFRDYWhyR0w3djFjTUhWSE5UMmpNUVp0MDJkL2k5YW10Y3ZyKzY1?=
 =?utf-8?B?bkJhOWdQMFR5ek41VlIvd1RwUDhBY0I2b1MxMkx4eU44N1doalVhVE1PZlNr?=
 =?utf-8?B?ZG5kRjJSYzRNdVJLOExNeHFkelNPSTMvbG5DUG0xdmVHR0VTS0NHOWVJQm4v?=
 =?utf-8?B?K0NpVHpXVWg0S01Day9iTE9BbThQYmRrTVJ5MGxjUTBHbmc3OTBPQXpudzRV?=
 =?utf-8?B?T1I1RnBtTXhZQW9OQ3FLdGZ4bzhVR0JKaitFUHdoOGxST0ZpcjI4S2x2TFht?=
 =?utf-8?B?NmVabkQ2alNxeXVCRk9oTnV3OXF0elIxUDNDU0oyL1N3SXJSb1I2TExxM1du?=
 =?utf-8?B?OHUxeS9RVUM5Z3l4MnBlQXJzWFZ0WjduOEdURHVybFVuRmdIbnNtQ2VKaGNk?=
 =?utf-8?B?ektqY01JUjRvcFR2WmNxR3lEOUdYL1FGVVQ2eDJnT1BCaWJMOXdNUFhyMEt2?=
 =?utf-8?B?OTY4MGF4S1lLWjlxV3daMGpqVlRMYnltTzVYZGNVSVVxbEtOUmZzaU5nQWlj?=
 =?utf-8?B?STdEY0xBRDB1TkNXbDVORTNoaWg5ZGRZMzNBdjJNUmtXMTEyTVEzVC9ZMWVl?=
 =?utf-8?B?TlNkdkFSajdYbUd0QU54NVZqa0RMa2RKc0tvRURGSEtGcnJYOXRWSW9yazBI?=
 =?utf-8?B?cUZWMVhTbDhQalZJdDNmTktFMEcrRHBOTjg0aUY4REEvMHB5ZHI2bzgyYzZK?=
 =?utf-8?B?V2tsNU5WVWJ0K0JxWjByOTZHS25OUXdvMGg1ZDBIdjZVZDFONEwvVDErZFZE?=
 =?utf-8?B?eDU3d3NoV202aUpsbWJBajdyak51czlKZnoxNkkzVTVPSGNldjlhRzBITEsr?=
 =?utf-8?B?THRkaWhnOHkxNUxaREgrRGg3UlRJaStGYjV4aEo1M0s3MWRadzNZbThrNDF4?=
 =?utf-8?Q?BVOwAbnpbhxte1Ob1sYVilLgeGF8c6DKT7PgQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <19B867084CBE0842BFD944234CABAE80@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00e096d7-5dd3-4691-04f4-08d8f7f1a4d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2021 05:14:09.5179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tLoGUTZXaPtfiTvSJxF8Yfr2lXJEdnfJ4w54ScNzTm71oqWTnKzI3+ZhpXFSuKeTFWjd2fOhCIZypUccgukC3O96YIWFDcbJMiaUt1KQwvQQZbJMOEqEqpiJ9qMBJo4r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0302MB2587
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBTdW4sIDIwMjEtMDQtMDQgYXQgMTk6MjEgKzAzMDAsIE1hdHRpIFZhaXR0aW5lbiB3cm90
ZToNCj4gT24gRnJpLCAyMDIxLTA0LTAyIGF0IDE4OjQyICswMTAwLCBNYXJrIEJyb3duIHdyb3Rl
Og0KPiA+IE9uIE1vbiwgTWFyIDI5LCAyMDIxIGF0IDAzOjU5OjUxUE0gKzAzMDAsIE1hdHRpIFZh
aXR0aW5lbiB3cm90ZToNCj4gPiANCj4gPiBBY2tlZC1ieTogTWFyayBCcm93biA8YnJvb25pZUBr
ZXJuZWwub3JnPg0KPiA+IA0KPiA+IGJ1dC4uLg0KPiANCj4gRG8geW91IHdhbnQgbWUgdG8gcmVz
cGluIHRoZSBzZXJpZXMgb3IgZG8geW91IHRoaW5rIHRoaXMgY2FuIGJlDQo+IGFwcGxpZWQNCj4g
YXMtaXMgYW5kIGZpeGVkIGJ5IGEgZm9sbG93LXVwPw0KDQpBY3R1YWxseSwgdGhpcyB3YXMgYSBi
aXQgc3R1cGlkIHF1ZXN0aW9uLiBJIHdpbGwgcmVzZW5kIHRoZSBzZXJpZXMgYXMgSQ0KaGF2ZSBh
bHNvIHNvbWUgc21hbGwgZml4ZXMgdG8gdGhlIEdQSU8uIA0KDQpCZXN0IFJlZ2FyZHMNCglNYXR0
aSBWYWl0dGluZW4NCg0K
