Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0F2D305AC1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 13:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237537AbhA0MFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 07:05:13 -0500
Received: from mail-eopbgr80072.outbound.protection.outlook.com ([40.107.8.72]:8771
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237516AbhA0MCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 07:02:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AEQA3LKbbvu1zNZ9JwALM+GQ9N5Si1H8EWdyLkvDQ9lO0ubPuVLSBCF6c03EUVZaGF7xTzyNaGlYQs8TRA9ieMrUTwVR4pA024jGECg8UAbDwlycMpziS68QArHB+iBMaFgSVpbO0AGEI+W3hPj8yGtSfUZCKpyJTJw+DDnn1TIbYi3VLOYbN5m/RnG8qSNrm07/uKK3xLUJDTS48ONvNNiQQYm+sU31EyxMEJtTqzVBfZN/GRPCw3Sdyi3UDZOYVfpoAcNg1h38El+8dpmOgJujRJOYAd5rtB7HwNmTQsY34ZK7R/+VIxXY9yCexT292oCPZ6IhwNOhghAxKCPlMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSjIuFcVzuU5y1p/tUEz9WY17aiuHWCpYFriPnR0H3o=;
 b=JaU4XA3r7eMU8orzpW9NiBkMgVkPNRYIQ2wd+3ea2BVCeAD5x8Z0JNBGsqVV1o3T4lgy7S7nN+fDZjMhHDiahJ8SgIKKuX23NOVfMIBw2OpUt42D5rFt0eFwnzm5Uhg2MfBe8V0cbdY81/oQ7KOBLmJR/uaJeXeMs0AdUNyYuUwnRuAm2ywZY/lginGtYvX8/SH6MVSe1+9MZdk2wxMGbbZuqyo46Lr9m5mPrbOn4+dy+p/vS8Xzw4AtU1Wcu/jIvJPkuMeLVRGiWGd2sKt4zgsBXx6yKYpfbeX4eGkrKZl6rW5jvESLBqVZPlghb/YfiDTN2JThiizy2ax/gHaa8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSjIuFcVzuU5y1p/tUEz9WY17aiuHWCpYFriPnR0H3o=;
 b=ev/HNOZH7vb9S1ewkRSpUDaNjOjQT7R88LigGivVIt5xbQKmqLLldoYwhKI2rsWdesKPKjqUC/Y/Cfx2ytnHMtwiN6pjAQv509jmLovcKayQuGRKzxodbVOOcQ8KdLZrhQOWWC8yWIRg1rSmAEEsvV9yj1g3fqnPgBcoSqIq9jI=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR0301MB2315.eurprd03.prod.outlook.com (2603:10a6:3:23::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.15; Wed, 27 Jan 2021 12:01:56 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::d109:2683:5f4d:1f55]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::d109:2683:5f4d:1f55%5]) with mapi id 15.20.3784.019; Wed, 27 Jan 2021
 12:01:56 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "angelogioacchino.delregno@somainline.org" 
        <angelogioacchino.delregno@somainline.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: short-circuit and over-current IRQs
Thread-Topic: short-circuit and over-current IRQs
Thread-Index: AQHW9KQ1CReIG2nvY02SR0F15Vfw3A==
Date:   Wed, 27 Jan 2021 12:01:55 +0000
Message-ID: <6046836e22b8252983f08d5621c35ececb97820d.camel@fi.rohmeurope.com>
Reply-To: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none
 header.from=fi.rohmeurope.com;
x-originating-ip: [62.78.225.252]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1268af99-c050-4fdd-41f6-08d8c2bb57d2
x-ms-traffictypediagnostic: HE1PR0301MB2315:
x-microsoft-antispam-prvs: <HE1PR0301MB23158225FF90C1589349EFF0ADBB0@HE1PR0301MB2315.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xxJkly39zz0jl0sqtbYF/x9ePdqAvs7SoNoM/bsDGjDP43NfyhkGLtMYFrKDAa8Q7plRErxbAHn6SD+fNdptuTBh2FPmyw01ilZzvGoPx03zUyLwYhauA5zfMX9ZYfowTNhYS0stpWCr8BDn86z/ud/8zlj14rtn1c6sLdzPHMM1B5aY20H1vBPAJcEZCVintp4tprG0frIiYVLQJZ71XJyUudE1K189qcVTiSAn9Y5Ch7PTJz3yJItb2LM4K3g3u2OgIx6A4Epl4VQk+PEPK0cc4AS/O7kp3xarAHqfwkdJRW9whzYlACwQOara+qY0EEatc+hWM+vcb+zaIfIhtYm2O/5hXIuM7HQtRSL7WcU73JgGj1HrcaVGOk5q0ti3l+hivXwy2T0UO1q3kqdcDboSvrAoBbaFN9eerfFJK1bpFGuey57jT8r2bipKrHfYxofHXlftnSyAk178IQqCD1apKEebtdOfYmamB9hH+7bcHtV6byLdVv6MTOGo+oVCFEQ+cYfvTAvMvxuMh134kcZZHkXcfH8QGAQlHLK4s6/xHS1/vHxs7klvFFA/dF2JTaCVhJOe3GA1cWEvbARdXvXtJtRL4NCThfXcqM4o6Ww=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(39850400004)(136003)(366004)(478600001)(6506007)(66476007)(66556008)(64756008)(66446008)(2906002)(71200400001)(2616005)(109986005)(83380400001)(966005)(26005)(8936002)(76116006)(66946007)(3450700001)(8676002)(6512007)(54906003)(4326008)(5660300002)(3480700007)(316002)(186003)(6486002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZkRxNzhYSTRkWFRsSTZyOHNrdmJaRS9aWEVuWFdDYjVCVVdzQkdXM2tzV3Fn?=
 =?utf-8?B?aW8rSGE5bGxhcjQxakRyN0tMNTBWcXFvL2lZREVES3ZBYzducTgxbnFPWnJR?=
 =?utf-8?B?VkJ0ZDRqWFdjZGVtZnJUOHhBYnBDaFRyOXRGR2RrRTBlZGdHelg4bDRpMVJm?=
 =?utf-8?B?Mm50TEExN3hrdG01ZjYxbXpEN2ttU0JYRitkWklYSVN3ZDBGajNadlNqQkZ0?=
 =?utf-8?B?SVcvWkRuZUhVUmJxaGF0ZWlodytSc1lTNWhhMldXTWp6VGsySHVXSGtaSUZZ?=
 =?utf-8?B?ajVZNHI0WUtxNGYwVlh3OHhlWkd6R01CYkdwZEFRSjJDZ0hKaklSYUJpZk42?=
 =?utf-8?B?RFZ2MDRqMFJIYjMvc0gvWXRnZ1ROWjJtUVhVaWx4TTFlTlptaDhtZVY3ckFy?=
 =?utf-8?B?b2F5amFSTk9YU1pHbndESFpnaER5UkUyQlhlZmIvWVlyMEFpZ25odXpWMmdR?=
 =?utf-8?B?RlFoZjFoSWlvQWtpY1dUZEwzZUE3c2V1djVZc1JVUnFkY1duQ1NObjJMSm9k?=
 =?utf-8?B?S1VtR0Z3b1VFdkZlK3ZVcm95SDM4bUhBVTJodmUxZjQxSlhscHlRMlBnbVF5?=
 =?utf-8?B?ZXNVQjNOL09vblNQODdvOXFxSDFhTXcvb2ZWOEFsNzNnUXZVZEFTL0ZFRDgr?=
 =?utf-8?B?WDI0dW1IaktUTDZ5SzJjeURadEhVTHBzNkhqc2trcExpUjh5L1gwNjdPc3NT?=
 =?utf-8?B?UGpsR1Y4d1lWY3l2SkRIcmdWNTlRbHF0aUxXOWtqelVEVXVzYlNoVU1FQzFB?=
 =?utf-8?B?YlY0Q1AxNkxlUzMyVU5mL0c1K01SbGxOWEEwU21Ic3Fsb0N4YVU2MGVNb2gr?=
 =?utf-8?B?YUU2RWIxVmRlZ1R4YWxBcmxRMmF4cThvSDlVOVBlVXRoRG01ZkpxM0hWN3Vv?=
 =?utf-8?B?Ty9xeTVudnd6dStKYTI2cm4raHIrWHB0bW4wVmdTdzNTSmZxOUthQkFNVC91?=
 =?utf-8?B?YVc4di8xQ0JKaktIbDBUNkhVNFlKS2VZSGQweHZrVkN4ako5dzVwNDNNS2Fh?=
 =?utf-8?B?UHdFUlhrM2ZoN1VqRXhSZnJQd0pSQUhsamFBcjFiNklqZndFTDFrK21FNWxV?=
 =?utf-8?B?bFIvRFYyU080MGg1cWhaQlNOSUVDUmdMRjdYR29rS2t2RUJHQnplRWZpby8v?=
 =?utf-8?B?UnVJRWx3R0thRlpLNkRlaGJiWmJIVWJmNE1jZGhIdDVmaUFvbEo3NkZtOHhL?=
 =?utf-8?B?cEZrUjB6eFhlVWhnOEQrUXl3UnR3c2hNWUpuenhrbnEzeDRzUCtlZk1yS1do?=
 =?utf-8?B?SjlXSzI1QUJZQnBEK05xRmEzNS9SU2ZHYjd4UGdmeHdzRy8rK0gyOUZvMnBl?=
 =?utf-8?B?cTVVSXp0SlVOMnFQdWpmZnBodVBVQXhIRlE4MFU1RTlVd1Vrd1hScHFtOHZ1?=
 =?utf-8?B?c0d2b2kxUm1VS3AweU5JOVAxRVdQWU4xUlY3Z2d5SGNXVTZoNExEN2JmZVJD?=
 =?utf-8?B?UXpnVVd3WkIyNDBJTTFtRjBvVm81S0ljN0NhWXFnPT0=?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C0116796E3AD949857775FFAA78600C@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1268af99-c050-4fdd-41f6-08d8c2bb57d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2021 12:01:55.9536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ei1/LklPevedz1OSsMR6nkn3Ztu7mA3ul19z20bV6Wmef2N4ECBVzzNVtHR94/ALFi74qymSUfoabQLWEKeThM9FzcagQzFeqA6B7QdnfwL4+2dGkd1jaaSlpm/ACLyx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0301MB2315
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgZGVlIEhvIHBlZXBzLA0KDQpJIGp1c3Qgbm90aWNlZCB0aGUNCjM5MGFmNTNlMDQxMTRmNzkw
ZDYwYjYzODAyYTRkZTlkODE1YWRlMDMgKCJyZWd1bGF0b3I6IHFjb20tbGFiaWJiOg0KSW1wbGVt
ZW50IHNob3J0LWNpcmN1aXQgYW5kIG92ZXItY3VycmVudCBJUlFzIikNCg0KaW4gcmVndWxhdG9y
IHRyZWUuIE5vIHdvcnJpZXMgLSBJIGhhdmVuJ3QgaGl0IGFueSBwcm9ibGVtIHdpdGggaXQgOl0N
CkkndmUgYmVlbiB3b3JraW5nIHdpdGggUk9ITSBCRDk1NzZNVUYgLSB3aGljaCBpbXBsZW1lbnRz
IHdhcm5pbmcgSVJRcw0KZm9yIG92ZXIvdW5kZXItdm9sdGFnZSBhbmQgaGlnaCB0ZW1wZXJhdHVy
ZS4gKFNob3J0LWNpcmN1aXQgZGV0ZWN0aW9uDQpkb2VzIGFsc28gZ2VuZXJhdGUgSVJRIGJ1dCBp
dCBhbHNvIGF1dG9tYXRpY2FsbHkgc2h1dHMgZG93biB0aGUNCnJlZ3VsYXRvcnMgYnkgSFcpLiBC
RDk1NzZNVUYgZG9lcyBhbHNvIGtlZXAgdGhlIElSUSBhY3RpdmF0ZWQgZm9yIGFzDQpsb25nIGFz
IHRoZSAndHJvdWJsaW5nIGNvbmRpdGlvbicgc3RheXMgYWN0aXZlIGluIEhXLiBUaGlzIGlzIHdo
eQ0KQkQ5NTc2TVVGIGRyaXZlciBkb2VzIGFsc28gbmVlZCB0byBpbXBsZW1lbnQgc29tZSBsb2dp
YyB0byBkaXNhYmxlIElSUQ0KZm9yIHNvbWUgdGltZSBwZXJpb2QganVzdCB0byBrZWVwIENQVSBv
dXQgb2YgdGhlIElSUSBsb29wLg0KDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzRkNzI1
ZWE2ZTkyNjFmMjJkNGM4MDhiMzkwMTNiYWY0NzlmMjUyZGMuMTYxMTMyNDk2OC5naXQubWF0dGku
dmFpdHRpbmVuQGZpLnJvaG1ldXJvcGUuY29tLw0KDQpNeSBpbXBsZW1lbnRhdGlvbiBsYWNrcyBv
ZiB0aGUgcmV0cnkgY291bnRlciBhbmQgcmVndWxhdG9yIHNodXQtZG93bg0KKEJEOTU3NiBoYXMg
YWxzbyBPQ1AgLSAiT3ZlciBDdXJyZW50IFByb3RlY3Rpb24vT1ZQIC0gIk92ZXIgVm9sdGFnZQ0K
UHJvdGVjdGlvbiIvVFNEIC0gIlRoZXJtYWwgU2h1dGRvd24iIGZlYXR1cmVzIHNvIHRoYXQgSFcg
d2lsbCBzaHV0IGRvd24NCm91dHB1dHMgaWYgdGhpbmdzIGdldCB3b3JzZSBzbyB0aG9zZSBhcmUg
bm90IHNvIGNydWNpYWwpLg0KDQpJJ3ZlIGFsc28gaGFkIHNvbWUgaGFyZCB0aW1lIHdoZW4gdHJ5
aW5nIHRvIHRlc3QgdGhpcyAtIEkgZ3Vlc3Mgb3RoZXJzDQpoYXZlIGZhY2VkIHNpbWlsYXIgcHJv
YmxlbXMgdG9vLi4uDQoNCkFueXdheXMgLSBJIHdhcyB3b25kZXJpbmcgaWYgdGhpcyBpcyBjb21t
b24gdGhpbmcgYW1vbmdzdCBtYW55IFBNSUNzPw0KSWYgeWVzIC0gdGhlbiwgcGVyaGFwcyBzb21l
IGdlbmVyYWxseSB1c2VmdWwgcmVndWxhdG9yIGhlbHBlciBjb3VsZCBiZQ0KYWRkZWQgdG8gaGVs
cCBpbXBsZW1lbnRpbmcgdGhlIElSUSBkaXNhYmxpbmcgKyBzY2hlZHVsaW5nIHdvcmtlciB0bw0K
Y2hlY2sgc3RhdHVzIGFuZCByZS1lbmFibGUgSVJRcz8gSSB0aGluayBpdCAqbWlnaHQqIHNhdmUg
c29tZSB0aW1lIGluDQp0aGUgZnV0dXJlIC0gYW5kIGhlbHAgbWFraW5nIHNhbWUgbWlzdGFrZXMg
bWFueSB0aW1lcyA6XQ0KDQpJICptaWdodCogYmUgYWJsZSB0byBmaW5kIHNvbWUgdGltZSB0byBk
cmFmdCBvdXQgc29tZSBjb2RlIGZvciB0aGlzDQoobm90IHByb21pc2luZywgSSBhbSBjdXJyZW50
bHkgaGF2aW5nIGZldyBwYXRjaCBzZXJpZXMgcGVuZGluZyBidXQgSQ0KY291bGQgYXQgbGVhc3Qg
dHJ5KSAtIGJ1dCBJIGFtIG5vdCBhYmxlIHRvIGRvIHRob3JvdWdoIHRlc3Rpbmcgd2l0aA0KQkQ5
NTc2Li4uIEFueSBwb3NzaWJpbGl0eSB0byBjby1vcGVyYXRlPyBNYXliZSB3ZSBjb3VsZCB0cnkg
dGhpcyBhbHNvDQpvbnFjb20tbGFiaWJiPyBPciBkbyB5b3UgdGhpbmsgdGhpcyBpcyBvdmVyYWxs
IGp1c3QgYSBkZWFkIGlkZWE/DQoNCkJlc3QgUmVnYXJkcw0KCU1hdHRpIFZhaXR0aW5lbg0KDQo=
