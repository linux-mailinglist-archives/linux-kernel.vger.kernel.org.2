Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B67A408FB5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 15:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240298AbhIMNpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 09:45:53 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:44671 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241330AbhIMNkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 09:40:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631540335; x=1663076335;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qBLfXE6FY6iUQX0QRlM834GhxdSoEQ1nwnBM/ACBO7g=;
  b=KIZcaiI98FIi3Jnq3ETlfwXZmhlsMmjgJNiA0Op/Pip1hjxuypsmYbXH
   VmKp/A3WTiMHOF+pX13NF1wxTGX73cKHi3WythEppGhu/pr0XXOjVI+Qg
   luA0GBDizZVXz4f1peFc7PKQhotITGUrSsh4oUUlMVIzce72vXiv2CbQ8
   wx4skR7W/HnwQ+i6nCtjE/Xb4p+6NY6tzdlknzfMQbp60wAmzzrdzym25
   jkE7nahl9G42WVlh8yKAE9Y5ES9EVgKLQJU2U/Ho3y3VSFeLbx8y0cyoV
   FbHlSDrgxWgJ6QML1aIFUddUQ6EhH5urKilgpAaLnPjRqDl5+C2mco854
   g==;
IronPort-SDR: iWKYeXRXUMM0YE4s/Mw0ZZARj2D3QWFjhfr7f6G40WUt/HA9+wBkp6egXa/04P9Ip/nxaYm9Jv
 4Qi7nIua2AVQLhpaymSL4fU5TxHYFq5XRvQgWRlEe/wL0Q3cA1s4/tVDEAEkg1sSHtIe+x8vvY
 HpFlzOxeZLltKcalSxHQod3hcyo93zMyLh1X5tGB6AStbDPtZLrozzRaxq3jYQty/Y4o6dkGTf
 TeJP3JnaocWQIJDYQF3GOK0v98za9t/AP/5nG3i5GBGY4/wzKy9/62Yz3zlJDGxJ8HlJ+FXdVy
 JKL0ExJGeNFsKC5REtGyJIZM
X-IronPort-AV: E=Sophos;i="5.85,290,1624345200"; 
   d="scan'208";a="131620260"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Sep 2021 06:38:53 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 13 Sep 2021 06:38:52 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14 via Frontend
 Transport; Mon, 13 Sep 2021 06:38:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oz70/RGfEsMzQEGzXX5Z9g9W6bvlvJKDIl+tn1T05vWb0X99bDcK8aPlYOQfo+8+6HLO597H+a7h/xG2U1+LeAduItJYQbv98uVXxqiTZEUNeubluOO//F5Cbl0pW8gN+yOjExZosQMXZ4PPjuETfi2bn2MhsvxioQ+v2D8wrqxh6L4lR8w1QsNCTQ2OSx8/F3NWmInOf48FMC2VS20LajWqoSPlOEMwO5deGyzKdPzxL7Fsm7LDhZW3U2/JtWeweGjng6DXZhQhO/Nj9LWkamBML+q7l2n+gQKfr7c2b1X0uPkGuvReLP/aWL8sSXlX/Dpjn9SUv/sAY3qFFp2eUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=qBLfXE6FY6iUQX0QRlM834GhxdSoEQ1nwnBM/ACBO7g=;
 b=e9bHniRAFjeSkgI28mADcy0b1bpqIg1WFpqwxDnRhguxnot9kJKMKEnPP08Wrk5CAwg4ObOtOiaRW24AjFcxT3H348QR2nqXf3W3PfTI97ehW5DSXAYF1Ymd4yy62f8GacwGxv43YmGwzzHZyc3wIxOE5G99feevg5rmgV0FJp3r9Cn3eOug28ueETBe8Vgz+53tTAQhb3XHzVxk5CO77kkXU1rPW2iEtGnxqE+iyO1bmUgwmo9SeHx6fOu4mSNWxN1caDGNSSDUdfeD4vykI83utqR2TQ9x4FQ4S1RlWvP5TzZLhDU0dz8vHghxvAyg978hF3OqZxBoxmVrE+pe+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBLfXE6FY6iUQX0QRlM834GhxdSoEQ1nwnBM/ACBO7g=;
 b=UGEh++oKvpdR3l1rN5zEM7N0zopM2Hh09hyNkU0rSICbgbbcP1E4AU40Dmr3JDIilrVRiSzAIgNxRgNiwpldAiG6T75KOaxEnpS0tybyAqY3CuIgJI3TSYC2vvoXUOcJ//b/+tFu+aPQG85tzvUSO8w0xDaGgrQjm6hbsfKoUuo=
Received: from DM6PR11MB3420.namprd11.prod.outlook.com (2603:10b6:5:69::31) by
 DM5PR11MB1964.namprd11.prod.outlook.com (2603:10b6:3:111::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.17; Mon, 13 Sep 2021 13:38:51 +0000
Received: from DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::acfc:87df:5588:8a78]) by DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::acfc:87df:5588:8a78%3]) with mapi id 15.20.4500.018; Mon, 13 Sep 2021
 13:38:50 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <clement.leger@bootlin.com>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clk: at91: check pmc node status before registering
 syscore ops
Thread-Topic: [PATCH] clk: at91: check pmc node status before registering
 syscore ops
Thread-Index: AQHXqKSvlffFSGj6r0KR1y2YZ6TqeQ==
Date:   Mon, 13 Sep 2021 13:38:50 +0000
Message-ID: <eab2960b-a7b2-ac85-3b11-d94902eba035@microchip.com>
References: <20210913082633.110168-1-clement.leger@bootlin.com>
In-Reply-To: <20210913082633.110168-1-clement.leger@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
authentication-results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb11624d-09e7-4591-c4d4-08d976bbd24a
x-ms-traffictypediagnostic: DM5PR11MB1964:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB1964AD274EFA8B119DCE575687D99@DM5PR11MB1964.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IejIE8gWf/RYg/nC9uQeQBPSG9mNl9JoLRCC95sgDlXQzgdTGwz/V/eOF2ZQwna5csfEGY7512EvjIgd0xGk+znvYXDYZ2y3dxRqmz12CSWrWFDfWiZSorDoaW6ZD7y0vPPgX70abSDvH2FhkVKnjBQ/alBJT1PioNBVkcUnwLMe6BqFwQAitAVefZy+59f5VYM1DqwiIswFPtxCIZ48g/1ob3OV/GhgR8worv/h3FVVZKdtsu/xR3AVXfIi/DrEVZMPZbbctbRX41c/Ni+oTGmQWBUfZNCA2j2yqD+vD1g0n3oFxV4AdqW1T/n7zgiq4vDk6jZigJtbPKV3D6MgJ9rSFcBEX+RqIxjSr9g5j+GEy9L6ASou0qdmCWOAg9lR/VzCXC5sTTLmQBoYL38JnVB7TjRAy31ue5OK2N+Pfbp9rVY5vLoS3+Kq0IGAyTmMVrY/oU2gx4cWafXzluvlQ++7gINZ7cp7jQVJHLNTwDNJkhOT0j6gOze7tz5E5dPqTwYMtFRYbr2aqnfM1KVVh03NSdOg4AWlWaqahAssDBpwzWA2nBMOu6OlXbd96vSYScU4ZaV9q/J9lG5PkcwOwvoOP47smav/rTboWo1MTaCekL76YXdPm7nrJfr4BjV5bJ53MRkCBKwxy+O10OUozHKr3BA4oQCMyMlzOCA/QOo0GvJD6ZqqZFVikmLHub7MlKFYoj4paM2p0ps6j5NvizooIwW2whCjxinRUGNwPBU/UFQyStGwZ5b6Qhoeelah76TWhPNrXCeL95YQ7WMHnA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(5660300002)(31696002)(66574015)(6512007)(86362001)(2906002)(83380400001)(110136005)(6506007)(54906003)(71200400001)(2616005)(36756003)(66446008)(26005)(38100700002)(66556008)(122000001)(31686004)(66476007)(66946007)(64756008)(38070700005)(6486002)(8936002)(53546011)(508600001)(76116006)(91956017)(186003)(8676002)(4326008)(6636002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mm5OWW9FMXg1MVNKemt6Y2ZnZGk1M2dOeDh3ZmFlQXhuVnhmNmEyWGtpelpa?=
 =?utf-8?B?dWFkZXg5WmJKblNkM3J0TEZONmVheVluYU15S3M4QXlwWFFSa1F1UHhNc0JQ?=
 =?utf-8?B?dVdTY0o5R3hmOG5jTkF2SXUxR1Jza2dvM2U5c0VyMGFiOUJkOTc3dXFBSkhk?=
 =?utf-8?B?d2Jwd0FRdms0TFZLMDlzV2pOeEFaMjc4a2ZtekFrb05vNU1oemhrci9iR1Y4?=
 =?utf-8?B?VHlxc1RzY1BPeGtRS3lZRERxVlJaVm5mN2IvaFFkRXNjcjlaSmlMdGpuclBi?=
 =?utf-8?B?TUY1S0wwbFd5enViVXA0Qys2VDAzZHdWR0ZKUkFDdDduUExqZHV5RTB4KzVl?=
 =?utf-8?B?RkFrazBCM2hzU2ViZ2RUcm90emZtcTNWY0M1WUV1QWlvMkxRbWRXa1pESVpm?=
 =?utf-8?B?OUh3TWpVNy9aRUNtK0RCS1FpdVloTnhvTDA3Z2RQU29oOEEvQ1NhQlZRV3Er?=
 =?utf-8?B?cEJ6Z0N6VUhPVlZtTzB4MEtjMXQ0RVA0eERkbmV6ZUVPb1JYV3NmTlBjQ3hY?=
 =?utf-8?B?Mk9Hak1mR25rZVdzOXFmTitPQXgzWkpSTFFrUmQ0SDFYckFjNHhEeFR5Q09O?=
 =?utf-8?B?VlZRZXpsK0ppVFZMV1hHWVVqZHNUQXBkVVZUY0t1WFllZXFoMjVrZmVLSUxG?=
 =?utf-8?B?THBhSmVDL1FvZVpNTCtrSWpmK1hrR3MzR0V4L24zdnRISnBFNkZSdmpXMDhB?=
 =?utf-8?B?OTZXbjRlRjltNUxaRzZWYWpCTUhXa0thNTFNUTAyaE9Pd3ZsUVhxMzN4Qzc5?=
 =?utf-8?B?NmQ3TVlPK3lKZzlYMG5BdVd3WTNQdmtKYTN0eW9rU0E5ZVI1b3JRUGM0anhx?=
 =?utf-8?B?R1NTUU82Yk5sM2ZTSGlGcjhaMnl3YzdQQVI2WjdaU3M5QStFTEtaajRwQnU4?=
 =?utf-8?B?RFZPdFpMdWFadGNVYU9mdXZNc2cyMmxkcDBTWEEwR0RCZHlWV3lkTFcyWlVH?=
 =?utf-8?B?NmJoZXVEWFRFM2k0d0JuSXpnSjBUL3pWNnFZL01wL1hmSWdYRU5LODZFeXVy?=
 =?utf-8?B?OUxQQXlrWERUaU5EV3dsY0FRWFZvOXhOZ3dGL3hYT0FuOW5vZ2g3MFp3L0d4?=
 =?utf-8?B?N2k5UE5ncWhHWWhtdHEyLzlaZFY3ZHlpWTF4UmlJS0tsbXluNUhXZXhHTEZI?=
 =?utf-8?B?bThWOVVEeVBFUVVYbXcyOXNEcEN4RTNwdHI1aWI2Nnphd3dnRzAyMjNMZ2la?=
 =?utf-8?B?SE40MXZpWlFLVE1LbmdyNU9lVThrYlY5NERoRUczZHNxZzRvZm8wS2ZVKzI4?=
 =?utf-8?B?OHJvc2FWZzdZR2NLWXludW5IOWx4c0orWWtyQUtNc0dvVXpjKy8xbm9tMk15?=
 =?utf-8?B?UnZVK2lUOW9kUDI3dGtKb0RBMncwdzdPTStIZTN5dXY5bWZGQW01N1AyU3JF?=
 =?utf-8?B?UGRZM09TcnBmWG5rSnE5OEhqTDY0TFIzYmdweGpldVU2WGRQQ09xNGdOZ1Rp?=
 =?utf-8?B?UHE5d0thbXZDZWJNai9uWmpMTU9meGplWURCbjZDaGRvRFlobk40VjVka29T?=
 =?utf-8?B?K1hvMDdpS0tETEx3T1hRRzczQk9aS1N2anE2WkVLOHVSUmxxWlJLZGQ3aUZF?=
 =?utf-8?B?VHRnMXFOWGpJYUZlaU9wc1ZYR2RwMmlpVkhJb3lvTy9mcTEyNThOUWFkWEpx?=
 =?utf-8?B?eE9PUmlQMXlHTHIyMHJ1eWh1NkNxM0dINndtVEY0eEdPVGxnQktIUjZHL1Vv?=
 =?utf-8?B?aGZRSnBsV2VPa3JuT0pUTHBTT2IvQnhYd01GUGdDOW5pZXpNQ0k0SjJMVFY0?=
 =?utf-8?Q?Nx4Uzpe2A1I8lHj9gI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1CDA0AC58CC3104AA792E76250484E9E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb11624d-09e7-4591-c4d4-08d976bbd24a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2021 13:38:50.7553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GZJA2MivBT5NR1dPl6fL870UHlwwKZbV2NI4u4MxUMGEujIXe/QmupfYXEfkI5K/ppax2+vxh2ZaANbYB0/UtzP60CCV0cnf1w97li28wDE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1964
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTMuMDkuMjAyMSAxMToyNiwgQ2zDqW1lbnQgTMOpZ2VyIHdyb3RlOg0KPiBFWFRFUk5BTCBF
TUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBr
bm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEN1cnJlbnRseSwgYXQ5MSBwbWMgZHJpdmVy
IGFsd2F5cyByZWdpc3RlciB0aGUgc3lzY29yZV9vcHMgd2hhdGV2ZXINCj4gdGhlIHN0YXR1cyBv
ZiB0aGUgcG1jIG5vZGUgdGhhdCBoYXMgYmVlbiBmb3VuZC4gV2hlbiBzZXQgYXMgc2VjdXJlDQo+
IGFuZCBkaXNhYmxlZCwgdGhlIHBtYyBzaG91bGQgbm90IGJlIGFjY2Vzc2VkIG9yIHRoaXMgd2ls
bCBnZW5lcmF0ZQ0KPiBhYm9ydCBleGNlcHRpb25zLg0KPiBUbyBhdm9pZCB0aGlzLCBhZGQgYSBj
aGVjayBvbiBub2RlIGF2YWlsYWJpbGl0eSBiZWZvcmUgcmVnaXN0ZXJpbmcNCj4gdGhlIHN5c2Nv
cmUgb3BlcmF0aW9ucy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENsw6ltZW50IEzDqWdlciA8Y2xl
bWVudC5sZWdlckBib290bGluLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IENsYXVkaXUgQmV6bmVhIDxj
bGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KDQo+IC0tLQ0KPiAgZHJpdmVycy9jbGsvYXQ5
MS9wbWMuYyB8IDUgKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9hdDkxL3BtYy5jIGIvZHJpdmVycy9jbGsvYXQ5
MS9wbWMuYw0KPiBpbmRleCAyMGVlOWRjY2VlNzguLmI0MDAzNWIwMTFkMCAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9jbGsvYXQ5MS9wbWMuYw0KPiArKysgYi9kcml2ZXJzL2Nsay9hdDkxL3BtYy5j
DQo+IEBAIC0yNjcsNiArMjY3LDExIEBAIHN0YXRpYyBpbnQgX19pbml0IHBtY19yZWdpc3Rlcl9v
cHModm9pZCkNCj4gICAgICAgICBpZiAoIW5wKQ0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIC1F
Tk9ERVY7DQo+IA0KPiArICAgICAgIGlmICghb2ZfZGV2aWNlX2lzX2F2YWlsYWJsZShucCkpIHsN
Cj4gKyAgICAgICAgICAgICAgIG9mX25vZGVfcHV0KG5wKTsNCj4gKyAgICAgICAgICAgICAgIHJl
dHVybiAtRU5PREVWOw0KPiArICAgICAgIH0NCj4gKw0KPiAgICAgICAgIHBtY3JlZyA9IGRldmlj
ZV9ub2RlX3RvX3JlZ21hcChucCk7DQo+ICAgICAgICAgb2Zfbm9kZV9wdXQobnApOw0KPiAgICAg
ICAgIGlmIChJU19FUlIocG1jcmVnKSkNCj4gLS0NCj4gMi4zMy4wDQo+IA0KDQo=
