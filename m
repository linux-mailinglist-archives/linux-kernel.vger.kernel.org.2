Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD68445DBC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 03:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbhKECEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 22:04:53 -0400
Received: from mail-eopbgr1320117.outbound.protection.outlook.com ([40.107.132.117]:20701
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229596AbhKECEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 22:04:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APUMqWOnIWObrtLpk1r18YlAJPc8f+loG/Blr/hCeHFxM69GiZ/TUhurMRgUOajxHzi5ba2If1gS7WwcGtG7OHdH8zoGDNN7W48X2TwE3qS+ADmLeWyRBNKEt5/fLfxmXz45uRIAQa4B6Zr/ENUMVfwL3cYfOEDzONJUakUaT5j4RGPnTWiHBFxQpjqqoh4M1i75kB3hBAKV3ZlrvIkkt2TeKBbZiOZhJdv/g9YQmiEhMNcHQDX/pwjbrYtLSRFD8yGxWXtkeUyDp+ivL5COqRWDNt/FsSL7uKOpzWYL3haKeQlNIsobr8OZZSO+mGWiY1b1J1y4grIvmJKSdB/xEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BCBh/Tz6JmeH+I0li8NxU6OFow2r+l4fIWXelbPNgWE=;
 b=XSuLeyWFC75gr9vcceuMHtCskTnNg9RIRdz3+yJYhozUzoWu03DEat8EDvzdjAAfPDgCbKRDouv45h1CO8Mf7iKRZAKW2+N7Ub6C8re17QnOwmx/a89SV7kcJPNCjVCeUxGHgdzpL7fprSDuq41JstYYgXx7+HhI9wkMiN0QabpjJcEHwQPGfh9bzorhE/WL3pp4e6YFJ6GtZoSowRrzftDlyUVAPNm0bmTGtbO9EHh0Eb+MjMaJfVhNbdqgbPSlzPWJ4mpvdVhqRhdXylpJ+LnXVfRjx+dykOC1g8XEUQrZfb1aJzSogTXnazlWdGWwnn6mygpmUgWyjTUbVjW/wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantatw.com; dmarc=pass action=none header.from=quantatw.com;
 dkim=pass header.d=quantatw.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BCBh/Tz6JmeH+I0li8NxU6OFow2r+l4fIWXelbPNgWE=;
 b=tyqgMSkIzrZZtRH+xMvlY4Vgh0xMKPvLM6l7vRThWS9nPIKEbS15NRxO55Lxv9cwtpDRthwtNMDdRkjgwR40M2QepbMHT6m/gMEppNcvEnJ/c7+TSGfIEIn1GbkAarKcPi0Z+JExYeqQZ+bTSMTdRrnNJesdzOQnypHVgYgDuwQ=
Received: from HKAPR04MB4003.apcprd04.prod.outlook.com (2603:1096:203:df::11)
 by HK0PR04MB2996.apcprd04.prod.outlook.com (2603:1096:203:3f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Fri, 5 Nov
 2021 02:02:07 +0000
Received: from HKAPR04MB4003.apcprd04.prod.outlook.com
 ([fe80::bc14:ea40:ec:43af]) by HKAPR04MB4003.apcprd04.prod.outlook.com
 ([fe80::bc14:ea40:ec:43af%3]) with mapi id 15.20.4669.013; Fri, 5 Nov 2021
 02:02:07 +0000
From:   =?utf-8?B?SG93YXJkIENoaXUgKOmCseWGoOedvyk=?= 
        <Howard.Chiu@quantatw.com>
To:     Patrick Williams <patrick@stwcx.xyz>
CC:     Howard Chiu <howard10703049@gmail.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "olof@lixom.net" <olof@lixom.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "soc@kernel.org" <soc@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>
Subject: RE: [PATCH v1] ARM: dts: aspeed: Adding Facebook Bletchley BMC
Thread-Topic: [PATCH v1] ARM: dts: aspeed: Adding Facebook Bletchley BMC
Thread-Index: AQHX0L4GVObJRPhBBkedf8m4Kd5flKvyqs2wgABw2wCAAPUvsA==
Date:   Fri, 5 Nov 2021 02:02:07 +0000
Message-ID: <HKAPR04MB400375B79EE5BBF400BCAA35968E9@HKAPR04MB4003.apcprd04.prod.outlook.com>
References: <20211103071417.388388-1-howard.chiu@quantatw.com>
 <YYKatBCCroiYxLew@heinlein>
 <HKAPR04MB40039608E14195D859DE7EC5968D9@HKAPR04MB4003.apcprd04.prod.outlook.com>
 <YYOoJgXyOdgNmI6B@heinlein>
In-Reply-To: <YYOoJgXyOdgNmI6B@heinlein>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: stwcx.xyz; dkim=none (message not signed)
 header.d=none;stwcx.xyz; dmarc=none action=none header.from=quantatw.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0bba95ff-020b-4f08-7596-08d9a000455f
x-ms-traffictypediagnostic: HK0PR04MB2996:
x-microsoft-antispam-prvs: <HK0PR04MB2996F7C6137465CDBF99393B968E9@HK0PR04MB2996.apcprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nihmKpizEhRpa41q2CyCBMTPcQpmw19+nz96v0Lrx0PrYkzlR/7nek1s1v+pjzPIYHPW9TzbEFEhE7+CcZ0lNZdddzTs/kvg9bfcBiuQBpqnT8O8BC0lvwVkq9IFmmFkqVPVRfjm4awL1jskLh1yS+2tkJV7V0rH9uL5DI3DoDq7PUAvxjHFtgeRPj5fZY+uFnvuHsMBDW7bxmGflEQ2Ke4G58rvCvhkQBoY8nWo7BsFaag89PMx89QEb+PiWmHanWk9z/uLi1jzsC2kEd9av0596uXvoSdsvX4Z+RIeOYvEsMekylxI61tGmsl3pn5Su5hRVU/dL2khGaO7ibpfG5wznPeB2Gjg7TIGHf7wSQijxAbM+cXZe1/YJoBcJnGGSknW6UhZNV1C1qiNfgSinw3kH3hNeiqRDbm98sAlZBDNJ9hs3Aw6E9pMZ9AK4ePOd5MzxtODUQUJLRviL2fL7WK8C0VFt0nP+IWbSMOx1RmOcgWFF5DL0clu35WvQVL/bUuMLDW3XFCbNNygXASAQ2ZJVc2njWZm8OAnBVeLXSKMQHkuOInOKbI0HcPN30yTY910iXTikqICb9kY8DFlhbM4EfTSMlhf9WXwFEt5PYqfgh7lTa75cg9lwIi0dxIULI7Ujj9dvU9XaiW7aKWs24c7UMaY2gtr1bdoQ9VkjKgbiWe4xktFddeHzgRLe8F7c+Q8SIUVCtmVr0GPp7FfHoGI4y9S9/9/T7WWsPOt4JIPLMQKuo3OkImIWXxFwog8dvHFxY7iMxHi6T7zd9nv9fptQC1113kIxEIr0DaZjK8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HKAPR04MB4003.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(47680400002)(86362001)(66946007)(76116006)(316002)(71200400001)(54906003)(7416002)(966005)(508600001)(85182001)(6506007)(7696005)(55016002)(6916009)(186003)(9686003)(26005)(38100700002)(122000001)(38070700005)(33656002)(66446008)(64756008)(66556008)(66476007)(52536014)(8676002)(4326008)(2906002)(83380400001)(5660300002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGp4S2RBanJhZU9qTGI1N1Z1bzJabG9EVVNqaW5SeG9rV3FZOGNRY2ZBQmJn?=
 =?utf-8?B?YjdNd2tkMTE0ZGhESytBSVExRkhIU20weUFwQmlGK1JicXY1b0RNQitZbWZ4?=
 =?utf-8?B?dW8wNmp0SUVYN3FXaU54NTRsdzIzTkZMNUkvMjF1VGhsZ1BGNHVuYnhHUkw3?=
 =?utf-8?B?VjlHM0FaUlNVeDQ1YlkxdWdGSkRMdVdhV3JDVk1hOEVQYm1jTnhGWnpNU0du?=
 =?utf-8?B?ZVN4WEIzclFtRzZOWTU3VWMvRlQ1aDlhT0FnVVBCQVJvejNyMmxOb1ZRcFpw?=
 =?utf-8?B?Q3RMdzNEVWIzOGMvRHVjQW8ySVhSdHpPZzdrbEJnMkRUNHlmTVpyRldjUXZa?=
 =?utf-8?B?VmR1bjg4TE54R1hKV3lGL0YzWXp1eFBzMmx6em5rYkVwcG02dlVHRmN3RTJ0?=
 =?utf-8?B?S0VXb3krQWpIUHlMM3JuZHozdjdhZ1hQYlpweUpJMzNmR2pLMWt2OEJuNDNP?=
 =?utf-8?B?KytDU2IwYmVRcDVBaG90L1JuSUZLc09ic3NrTUVQUnpURjRkYTQ3MGxhVEgz?=
 =?utf-8?B?SnBPYTc3UC80SG5DK085SmgzM3p0SUJ1WWpyUldNamQ2Ykw2SkJJemlWVVBy?=
 =?utf-8?B?Y3dIVkxhTzJ3NlpkRDJ4TFN3RWRmS29SbXlOby9IY1dVakhPSGpkbGJweUox?=
 =?utf-8?B?U05mU0lId2pCeWs5VDVUY0lYYVcrcDIxYWNpcmFrd0taYm82bnZPVzRHaTUy?=
 =?utf-8?B?NXFYRlRESzJRUGVCTU1reS91OERPQW8yd2NaSGo3dTFNaXVsK0NWbmp3eDhH?=
 =?utf-8?B?V0NjZnVya0hKRmNPSzVGSEJ6ZU5IV0FVTUM2a2FSbWRYYW5XUUZXb3pLSTkw?=
 =?utf-8?B?aEI4WWpjY0RQU3N3RHNUdVBYZGxDdS9QbjZpM0Y2YWNLaStSYVo1cTNwT2tL?=
 =?utf-8?B?MS9Ic1lBdzdyc0hOZXFJbzlsQjEybHo3amJGaGlENnRMUnRzZXBzd3h5ZElU?=
 =?utf-8?B?MmhQcGVxcmNTWGNqQ2tRb3VQZGhsemRHN3FranhBd05KQ3A1eHZDUkNOMHZh?=
 =?utf-8?B?U0pIK3B0M2MyOE1MazBQTitYZXQwQnpXRVlmZG1DaVpDQVNLc2Voams2aThU?=
 =?utf-8?B?VUJySEh2V2s3WEZvOWJhenZrOXF1VDhmZzl6QVRLZmJHSTlJYzlGL2xjYUJx?=
 =?utf-8?B?QzREbUxXSVA1SGhmSnlVZGNsM3ZZdWRYc2JpSFNsZUZhMXNhWVJ2T2YyTkg4?=
 =?utf-8?B?SzN5UlY5M2NWRFNnTU82UVQxLzVTa2ZIdzI0Nmo5ZlNqTUdFK3VWNWNpTlJr?=
 =?utf-8?B?RUtkRm56WXhpYm1ObHAwNm9GbmdCaEdORFNEWk9WamQ1WE9vb1BWK255amoy?=
 =?utf-8?B?MVYyNEN4Z1BDTllWS1VTSWlFWXhTN0QzS0lnYkwxSTR4RWRtTGxBWCtZNGlR?=
 =?utf-8?B?VDhzQXJyTmJ1K0pHbG44OUlEU1B5eGhYb2tQbWxESm9pQUxEQUVhVUh1UWZO?=
 =?utf-8?B?aFRKd21XQjBrcW0rRld3dTVCSy9PVTNhOE15NHZuRHZJWVp1Nnl6cU0zZ0V2?=
 =?utf-8?B?eDBRcFNvcFR4SVgrK3p6dnloOW9ZY01NSEpKUmxBamNmQnUyTCtPZE1QUmR2?=
 =?utf-8?B?ZThXUlovMWxnMmNrR3NTYU5iOWhVeGFMaHN3NXNtWUhaeld2Y3lqQkJCQ0Fv?=
 =?utf-8?B?akhXNzNJaDZmaWxZQVg0RlROOGQ1RE1KYTJEd1dQNTFmMjRyVFhoQ2k2VG43?=
 =?utf-8?B?K1dPakl1MFcyV1hmU1ZZU1l1ckYrNzhKaDg4V3dFQVo4QU5wZ3NpMkFkZFRa?=
 =?utf-8?B?SnhINDVUanlRQXdtL0RBa3lQRWpyUENGRGZRWE9aSE5iWTh0WHB0NHQ1Y05H?=
 =?utf-8?B?UXFEWS9TTXU3L1h0T0k3RUZNSy9Vb0N0RlVtZzUydDRlVU9vRHlQQ3hIRjlT?=
 =?utf-8?B?SFlZWjlGOTVQTllYOHVvRENNOXFhdzdSakhUZTZsb3Q2aUlQWHBRZTgyT0s5?=
 =?utf-8?B?OENHQnJnTmlqamwzR2JNWE1UbEFCYWVOeXVJeFRrQWFseEMwSUdYM1RUQ3hR?=
 =?utf-8?B?NDBNNFp1T2dlMkhYQmhFQXl1RUJRVCtnZjVqdUQ5V2hNM0ExNlh3enNoeHZ4?=
 =?utf-8?B?bmh2WkFwY2Nab1NCOFk1a0V6RFF2RzhKVWF0eWVWNmVHZFJMTXlsNGtqMXh6?=
 =?utf-8?B?UUlJZk9qVFlRWDRjR2pwa2pxckFCelV1c3V4cmkwaXhtS3ZOYnp0UndEVjdv?=
 =?utf-8?B?Y2pUT3MyaVpleU8rUVlHY1hHcmxYZ3U2cFlXbGZtT1Z1Z2VhUUNwSUpWeTRF?=
 =?utf-8?B?QzJUV2hkWWNSZWFaT1p5MWI2ekR3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HKAPR04MB4003.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bba95ff-020b-4f08-7596-08d9a000455f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2021 02:02:07.2072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iCOQhaWDkLtgHP2h7aaer3IhNueZeK9T7lmG+jAjqxYOT6ncNZnHYOPucpiQut1FNf/7gEzv83xoNwiXa+YedckF66A0bOJYJGayWT178rg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR04MB2996
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+ID4gPiBJcyB0aGlzIGJvYXJkIHVzaW5nIDY0TUIgb3IgMTI4TUIgbW9kdWxlcz8gIE1hbnkg
b2YgdGhlIG5ld2VyIHN5c3RlbXMNCj4gPiA+IGhhdmUgYmVlbg0KPiA+ID4gc3RhcnRpbmcgdG8g
dXNlIDEyOE1CLiAgSSBqdXN0IHdhbnQgdG8gY29uZmlybSB0aGlzIGlzIGNvcnJlY3QuDQo+ID4g
MUdiIFNQSSBmbGFzaCwgTVg2NkwxRzQ1R01JLTA4Rw0KPiANCj4gMUdiID0gMTAyNE1iIC8gOCA9
IDEyOE1CLCByaWdodD8gIFNob3VsZG4ndCB3ZSB1c2UgdGhlIDEyOE1CIGxheW91dD8NCldpbGwg
YmUgZml4ZWQgaW4gdGhlIG5leHQgcGF0Y2gNCj4gDQo+ID4gPiA+ICsJc2xlZDBfaW9leHA6IHBj
YTk1MzlANzYgew0KPiA+ID4gPiArCQljb21wYXRpYmxlID0gIm54cCxwY2E5NTM5IjsNCj4gPiA+
ID4gKwkJcmVnID0gPDB4NzY+Ow0KPiA+ID4gPiArCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4g
PiA+ID4gKwkJI3NpemUtY2VsbHMgPSA8MD47DQo+ID4gPiA+ICsJCWdwaW8tY29udHJvbGxlcjsN
Cj4gPiA+ID4gKwkJI2dwaW8tY2VsbHMgPSA8Mj47DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwkJZ3Bp
by1saW5lLW5hbWVzID0NCj4gPiA+ID4gKw0KPiA+ID4gCSIiLCJTTEVEMF9CTUNfQ0NHNV9JTlQi
LCJTTEVEMF9JTkEyMzBfQUxFUlQiLCJTTEVEMF9QMTJWX1NUQllfDQo+ID4gPiBBTEVSVCIsDQo+
ID4gPiA+ICsNCj4gPiA+IAkiU0xFRDBfU1NEX0FMRVJUIiwiU0xFRDBfTVNfREVURUNUIiwiU0xF
RDBfTURfUkVGX1BXTSIsIiIsDQo+ID4gPiA+ICsNCj4gPiA+IAkiU0xFRDBfTURfU1RCWV9SRVNF
VCIsIlNMRUQwX01EX0lPRVhQX0VOX0ZBVUxUIiwiU0xFRDBfTURfRA0KPiA+ID4gSVIiLCJTTEVE
MF9NRF9ERUNBWSIsDQo+ID4gPiA+ICsNCj4gPiA+IAkiU0xFRDBfTURfTU9ERTEiLCJTTEVEMF9N
RF9NT0RFMiIsIlNMRUQwX01EX01PREUzIiwiU0xFRA0KPiA+ID4gMF9BQ19QV1JfRU4iOw0KPiA+
ID4NCj4gPiA+IEluIGdlbmVyYWwsIGluIE9wZW5CTUMsIHdlIGhhdmUgYSBwcmVmZXJlbmNlIGZv
ciB0aGUgR1BJT3MgdG8gbm90IGJlDQo+ID4gPiBzY2hlbWF0aWMNCj4gPiA+IG5hbWVzIGJ1dCB0
byBiZSBuYW1lZCBiYXNlZCBvbiB0aGVpciBbc29mdHdhcmUtb3JpZW50ZWRdIGZ1bmN0aW9uLg0K
PiBQbGVhc2UNCj4gPiA+IHRha2UNCj4gPiA+IGEgbG9vayBhdDoNCj4gPiA+DQo+ID4gPg0KPiA+
ID4NCj4gaHR0cHM6Ly9naXRodWIuY29tL29wZW5ibWMvZG9jcy9ibG9iL21hc3Rlci9kZXNpZ25z
L2RldmljZS10cmVlLWdwaW8tbmENCj4gPiA+IG1pbmcubWQNCj4gPiA+DQo+ID4gPiBBbnkgZnVu
Y3Rpb24geW91IHNlZSB0aGF0IGlzbid0IGRvY3VtZW50ZWQgdGhlcmUgd2Ugc2hvdWxkIHRyeSB0
byBnZXQNCj4gPiA+IGRvY3VtZW50ZWQNCj4gPiA+IGJlZm9yZSBmaXhpbmcgdGhlIEdQSU8gbmFt
ZSB0byBtYXRjaCBpdC4NCj4gPiA+DQo+ID4gSSBpbnRlbmQgdG8gZGVsZXRlIHRoZW0gZm9yIG5v
dyBpZiBJIGhhdmUgdG8gZG9jdW1lbnQgdGhlbSBmaXJzdCwgYmVjYXVzZQ0KPiA+IG1vc3Qgb2Yg
dGhlbSBhcmUgcGxhdGZvcm0tc3BlY2lmaWMgR1BJTywgbm90IGZvciBnZW5lcmFsIHB1cnBvc2Ug
YW5kIGFsc28NCj4gbm90DQo+ID4gc3VpdGFibGUgdG8gY3VycmVudCBPcGVuQk1DLg0KPiA+IEZv
ciBleGFtcGxlLCBPcGVuQk1DIGJlbGlldmVzIHRoZXJlIGlzIG9ubHkgb25lIEdQSU8gdG8gYmUg
dXNlZCB0byBwb3dlcg0KPiBvbg0KPiA+IHRoZSBjaGFzc2lzLCBidXQgQmxldGNobGV5IGhhcyBz
aXguDQo+ID4gSSBkZWZpbmUgZ3Bpby1saW5lLW5hbWVzIGZvciBncGlvc2V0L2dlaW9nZXQvcGhv
c3Bob3ItbXVsdGktZ3Bpby1tb25pdG9yDQo+ID4gdXNhZ2UsIGFuZCB0aGV5IGNhbiBiZSByZXBs
YWNlZCB3aXRoIGdwaW9jaGlwIG51bWJlciBhbmQgb2Zmc2V0IGluc3RlYWQuDQo+ID4gVGhlIGRp
c2FkdmFudGFnZSBpcyB0aGF0IHRoZXkgd29uJ3QgYmUgaHVtYW4tZnJpZW5kbHkgd2hlbiBURXMg
ZGV2ZWxvcA0KPiB0aGVpciB0b29sIHRvIHRlc3QgdGhlc2UgR1BJT3MuDQo+ID4gPiA+ICsJCWdw
aW8tbGluZS1uYW1lcyA9DQo+ID4gPiA+ICsNCj4gCSJTTEVEMF9FTUJFUl9MRUQiLCJTTEVEMF9C
TFVFX0xFRCIsIlNMRUQwX1JTVF9JT0VYUCIsIiIsDQo+IA0KPiBEZWxldGluZyB0aGVtIGVudGly
ZWx5IHNvdW5kcyBldmVuIGxlc3MgZGVzaXJhYmxlLiAgSWYgdGhlc2Ugd2VyZSBqdXN0IGZvcg0K
PiBodW1hbnMsIHRoZW4gaGF2aW5nIGEgc2NoZW1hdGljIG5hbWUgaXMgYmV0dGVyIHRoYW4gbm90
aGluZy4gIEJ1dCB3aGVuIHlvdQ0KPiBzdWdnZXN0IHRoZWlyIHVzYWdlIHRvIGJlICJURXMgZGV2
ZWxvcCB0aGVpciB0b29sIHRvIHRlc3QgdGhlc2UgR1BJT3MiIHRoYXQNCj4gc2VlbXMgdG8gaW5k
aWNhdGUgdGhpcyBiZWNvbWVzIEFCSSBhbmQgd2Ugd2FudCBzdGFibGUsIGRvY3VtZW50ZWQgbmFt
ZXMsDQo+IHRvDQo+IGxpbWl0IHRoZSBjaHVybiBvbiB1c2Vycy4NCj4gDQo+IEkgZG9uJ3QgYmVs
aWV2ZSB0aGUgZ3Bpb2NoaXAvcGluIG51bWJlcnMgYXJlIGNvbnNpZGVyZWQgc3RhYmxlIEFCSS4g
IE91cg0KPiB0ZWFtDQo+IGhhcyBwcmV2aW91c2x5IGhhZCB0byBkbyBhbiBhYnN0cmFjdGlvbiBi
ZXR3ZWVuIDQueCBhbmQgNS54IGtlcm5lbCBiZWNhdXNlIG9mDQo+IGNoYW5nZXMgaW4gdGhhdCBz
cGFjZS4NCj4gDQo+IE15IGluaXRpYWwgcHJlZmVyZW5jZSB3b3VsZCBiZSB0aGF0IHlvdSBsZWF2
ZSB0aGVtIGluIGFzIHNjaGVtYXRpYyBuYW1lcywgZm9yDQo+IGh1bWFuIHB1cnBvc2VzLCB1bnRp
bCB5b3Ugc3RhcnQgdXNpbmcgdGhlbSBpbiBjb2RlIGF0IHdoaWNoIHBvaW50IHRoZXkgc2hvdWxk
DQo+IGJlDQo+IHdlbGwtZG9jdW1lbnRlZCBhbmQgdXNpbmcgdGhlIHN0eWxlIHdlJ3ZlIHNldCBv
dXQgaW4gdGhlIGRvY3VtZW50IGFib3ZlLg0KPiANCj4gUmU6ICJPcGVuQk1DIGJlbGlldmVzIHRo
ZXJlIGlzIG9ubHkgb25lIEdQSU8gdG8gYmUgdXNlZCB0byBwb3dlciBvbiB0aGUNCj4gY2hhc3Np
cywNCj4gYnV0IEJsZXRjaGxleSBoYXMgc2l4LiIuLi4gVGhpcyBkb2VzIG5vdCBtYWtlIGl0IHN5
c3RlbS1zcGVjaWZpYy4gIFlvc2VtaXRlLXYyDQo+IGhhcyA0IGluZGVwZW5kZW50bHkgbWFuYWdl
ZCBzeXN0ZW1zLCB3aXRoIHRoZWlyIG93biBwb3dlciBzZXF1ZW5jaW5nLg0KPiBUaGVyZQ0KPiBz
aG91bGQgYmUgd29yayBnb2luZyBvbiBieSB0aGF0IHRlYW0gdG8gZXhwYW5kIHRoZSBHUElPIGRv
Y3VtZW50YXRpb24gdG8NCj4gY292ZXIgTg0KPiBzdWItY2hhc3NpcyBhcyB3ZWxsOyBpdCBqdXN0
IG1pZ2h0IGJlIHRoYXQgeW91IGFyZSBhaGVhZCBvZiB0aGVtIGluIGRvY3VtZW50aW5nDQo+IGl0
Lg0KPiANCj4gSXQgc2hvdWxkIGJlIHRyaXZpYWwgdG8gZXhwYW5kIHRoZSBgcG93ZXItY2hhc3Np
cy1jb250cm9sYCBhbmQNCj4gYHBvd2VyLWNoYXNzaXMtZ29vZGAgZG9jdW1lbnRhdGlvbiB0byBz
dXBwb3J0IHN1Yi1jaGFzc2lzLiAgSSBjYW4gZG8gdGhpcyBmb3INCj4geW91IGlmIHlvdSBuZWVk
LiAgTWFueSBvZiB5b3VyIEdQSU9zIHdlcmUgcmVsYXRlZCB0byBMRURzIHdoaWNoIGFyZSBhbHNv
DQo+IGFscmVhZHkNCj4gY292ZXJlZCBieSB0aGlzIGRvYyAoZXhjZXB0IG1pZ2h0IG5lZWQgbWlu
b3Igd29yZGluZyBmb3Igc3ViLWNoYXNzaXMgYXMgd2VsbCkuDQo+IENhbiB5b3UgbGV0IG1lIGtu
b3cgd2hpY2ggb3RoZXIgR1BJTyBmdW5jdGlvbnMgeW91IHRoaW5rIHlvdSdsbCBuZWVkIHRoYXQN
Cj4gYXJlbid0DQo+IGFscmVhZHkgaW4gdGhhdCBkb2N1bWVudCBhbmQgd2UgY2FuIHdvcmsgdG8g
Z2V0IHRoZW0gYWRkZWQ/DQpJIGRvbid0IGhhdmUgZW5vdWdoIGV4cGVyaWVuY2Ugd2l0aCBMRi1P
cGVuQk1DIHNvIHRoYXQgSSB0cmllZCBub3QgdG8gbW9kaWZ5IGFueSBwcmVzZW50IGRvY3VtZW50
YXRpb24gc2luY2UgSSBkb24ndCBrbm93IGhvdyB0byBtYWtlIHRoZW0gcmVsaWFibGUgdG8gTEYt
T3BlbkJNQyBjb21tdW5pdHkgZm9yIGNvbW1vbiB1c2FnZSANCklmIHlvdSBoYXZlIGlkZWEgdG8g
ZXhwYW5kIHRoZSBuYW1pbmcgcnVsZSwgSSB3aWxsIGZvbGxvdyBpdC4NCg0KRm9yIExFRHMsIHRo
ZXkgYXJlIG5vdCByZWFsbHkgbmVjZXNzYXJ5IGJlY2F1c2UgbGVkLW1hbmFnZXIgb25seSB1c2Vk
IHRoZSBub2RlIG5hbWUuIGdwaW8tbGluZXMtbmFtZSBpcyBvbmx5IGh1bWFuLWZyaWVuZGx5IGZv
ciBkZWJ1ZyBwdXJwb3NlIHdoZW4gdXNlciB1c2VzIEdQSU8gdG9vbCwgd2hpY2ggbWFrZSB0aGVt
IGVhc2llciB0byBjb250cm9sIEdQSU8gZGlyZWN0bHkuDQpJbiBnZW5lcmFsIHB1cnBvc2UsIGNv
bnRyb2xsaW5nIExFRCB2aWEgRC1CdXMgaXMgYmV0dGVyLiANCj4gDQo+ID4gPiA+ICsmaTJjMTMg
ew0KPiA+ID4gPiArCW11bHRpLW1hc3RlcjsNCj4gPiA+ID4gKwlhc3BlZWQsaHctdGltZW91dC1t
cyA9IDwxMDAwPjsNCj4gPiA+ID4gKwlzdGF0dXMgPSAib2theSI7DQo+ID4gPiA+ICt9Ow0KPiA+
ID4NCj4gPiA+IFdhcyB0aGlzIGludGVudGlvbmFsIHRvIGhhdmUgZGVmaW5lZCBhIG11bHRpLW1h
c3RlciBidXMgd2l0aCBub3RoaW5nIG9uIGl0Pw0KPiA+IFRoZXJlIGlzIGEgT0NQIGRlYnVnIGNh
cmQgd2hpY2ggaXMgYSBob3QgcGx1Z2dpbmcgZGV2aWNlLg0KPiA+IFdlIG9ubHkgbmVlZCB0byBz
cGVjaWZ5IHRoaXMgYnVzIHdpdGggIm11bHRpLW1hdGVyIiBwcm9wZXJ0eSBmb3IgSVBNQg0KPiBz
dXBwb3J0Lg0KPiANCj4gR290IGl0Lg0KPiANCj4gLS0NCj4gUGF0cmljayBXaWxsaWFtcw0K
