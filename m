Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D100E40BDE4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 04:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhIOCyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 22:54:04 -0400
Received: from mail-eopbgr1320095.outbound.protection.outlook.com ([40.107.132.95]:3569
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229758AbhIOCyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 22:54:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N38zL2lPryz7Gu9Dg+Ull37BGrLRC9PEwfKzab1SKeHnnQE3oy2v8kitwyONOp657YtzrABMty75p8AzXAnulirx3NSgy8SA/+j/90i7QDys399PJ39y/n76yrYwlc0aibcQ0Dtao+VZjDfKSXOp0YG5QGwQuacRZR+7I3WDXfVvbvhB9fbVq8n8qI4zp/qN6cYAye5AJ3tbKJtj6PzGhwehUR6DguFAF7DKis5g/4MuEsCWHvXmhUf0kdflu89MTsE5yd8MtccJKQylCdbW6miQoQM4sHb5BeOmTSM3CYre6fHMUUcbs/k7am3IP+irOUgiavhGV9oGHgiu4ZX/Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=U3wF+PNaGo8uqoxj+amUIr5PgXc9tf074s5Uywg6O0M=;
 b=NPYJtX/Ak9xfsnrVYsEzjcU9Vx5JWa38QqY4QryJoLycOXm6vPI5Q1xkO4NcrR0gQdw/TP0HgJps+XkUVttsBuP3C5D/H/9FLCGWsN6eN8aODeYr0XoJuRKHKi5tdKR7Lih7sJnpRFk84qYcmmmOYLGVst6hXOa1pPIXqkI276CeFfOeonqlfSXHr63l+AbCFifRihGFbNTJBEIIqBZkXmMeaJeGKZBkAzXQoPDZb6fDU4nj4J47mguUmA7Wa/h8dOoeZfgM+5+EVF97ewqr31/vYelNXLE3yzA4GUQ+bB+pbwsceQ9O8y1rT/ThxA/VdPcxBj461soe82Z+nX5RGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3wF+PNaGo8uqoxj+amUIr5PgXc9tf074s5Uywg6O0M=;
 b=yt1vLCtzJN01iyaqbl1rXeBR1WO36RlbU3RrdVCqjl/keKkwJnIscm0h66hdQeanMFFrhilQI/APwJaNnMEytV8bzG51ZQX+VIDrBGqKdyjqFFXCxz+tdltb2pezQyY703yPGsRniEgo1pC9Ul05oEnsSC9qOIh/rgipG6p9L2d5/jL/NwFVjR9aDHncCOZddVGMMA8+NTP+b7jVgCFOEcsfNVr3uivWskfbu5fdhBPwEWk92B+rL1D4lqux/L4l+XDg7SbJkLaHlwKGYYH/dw6QtMgGfsln8n9O8re2ufECEJD8ddkgZc117zi4Oysi/xren31f8zQvnFgZsriOiw==
Received: from HK0PR06MB3380.apcprd06.prod.outlook.com (2603:1096:203:82::18)
 by HK0PR06MB2835.apcprd06.prod.outlook.com (2603:1096:203:5e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Wed, 15 Sep
 2021 02:52:39 +0000
Received: from HK0PR06MB3380.apcprd06.prod.outlook.com
 ([fe80::df9:c3a4:7589:e812]) by HK0PR06MB3380.apcprd06.prod.outlook.com
 ([fe80::df9:c3a4:7589:e812%3]) with mapi id 15.20.4500.019; Wed, 15 Sep 2021
 02:52:39 +0000
From:   Ryan Chen <ryan_chen@aspeedtech.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        "Claudiu.Beznea@microchip.com" <Claudiu.Beznea@microchip.com>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>
Subject: RE: [PATCHv2] clk:aspeed:Fix AST2600 hpll calculate formula
Thread-Topic: [PATCHv2] clk:aspeed:Fix AST2600 hpll calculate formula
Thread-Index: AQHXpJKMhkZfnItOBUy/UXzlogoQrauhdqeAgAAAnqCAAt58gIAAGF9A
Date:   Wed, 15 Sep 2021 02:52:38 +0000
Message-ID: <HK0PR06MB33801C3DADFD87363C09BFAFF2DB9@HK0PR06MB3380.apcprd06.prod.outlook.com>
References: <20210908091845.4230-1-ryan_chen@aspeedtech.com>
 <4571c9ae-0287-4f70-2adb-9c227e706736@microchip.com>
 <HK0PR06MB33806C10EB8B3F87FE144F8DF2D99@HK0PR06MB3380.apcprd06.prod.outlook.com>
 <163166864956.763609.8140689140101809508@swboyd.mtv.corp.google.com>
In-Reply-To: <163166864956.763609.8140689140101809508@swboyd.mtv.corp.google.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d04bd97f-c9d9-4fa9-c517-08d977f3e15b
x-ms-traffictypediagnostic: HK0PR06MB2835:
x-microsoft-antispam-prvs: <HK0PR06MB2835F2BA5FF1CA058AC32847F2DB9@HK0PR06MB2835.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:327;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D3gZV6TdS5rNFwvUWkt+43GEs8iA/KEUJCCtox9PdTRBaT/CKhwfROuJkEtSwrNJdJkokFCt1MDQPnlQgqOo4mQrmKdwWg79S1N2qJfL61QwsMAbVJbfHEn6pIxV7jbuyAtuk92oT712bBV5BzoAU1/r/PhLPgsocZf7KqsmNU5LwAmzC+b0WRheGKJ4qmwXlpZd2lRvk9Egemm+BpOK5PmT0GSqiLePo0t4FEs+7efVFn1wK+tp0Q8VZYOkeBDczWq5xLqz2s5DTUs3F9fKyjcnjGVKssr66lD9eThVR11JI5cuUgUGYxVP1xdfxqhr+cPfFfooRlRrSGar9LJgP3UkxMUnneC+iJL69cbdUlDsw7WppQVD0D8gAWnFDknLhBYj0YDUH0moU0mzsvLyWqDg2ZV2BEA6atR5XklfHaEZvG8G8TLBaZyaHcEPYE6roTD6O8zUeKT7zQGWbCDCY32sjzKtYhIYHpxv5iu4qbxq8wJx38e/sjMZ+HZ8rA2XD/oyA/Kv8K8SFTFla0ea64ygAMuwaO+hTfWIZZ7pwZVNcHaWNgNzbjnYs5Ud8OLaigla8w6uwDCzP32Ad5i5703yl0bXxYKzL29IRXe/0EGMeYvDZAFxRpSuwFYKwMAEk/o/0YGvwtdtQ7V11QbKSFfc1hYf0J8dxaxS/kVnEDTwiRAtzwJMILeDMJJrZn31ZTMHmkGzg+xMDb/2BWoh9w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3380.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(366004)(376002)(39840400004)(396003)(110136005)(33656002)(86362001)(8936002)(76116006)(52536014)(122000001)(66946007)(64756008)(66556008)(5660300002)(66476007)(66446008)(316002)(9686003)(53546011)(55016002)(83380400001)(478600001)(26005)(71200400001)(186003)(6506007)(38100700002)(38070700005)(7696005)(8676002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eERtbnhuSkl2dzdKUGY5WVBuOFl2czBVNy82MGQzbjJoMmZoSmNOVG1CNHZi?=
 =?utf-8?B?eVg2Z1oxL29DVEI4TktONGtpNlV4Qlh2bkhEZUlmMWY2Ry9zUnZBTmZGRGRS?=
 =?utf-8?B?eTdzNlNWcjB1WXNNbzNvZ0VaZVJmUjJjaGxOT2dET2lmaUwzZXVCYWc3SnMw?=
 =?utf-8?B?RXYrZmgxYmRZYVMyRzkrSEx2UWVRaWVQK2UrV0dacHVObTRETHltSWp3bXFv?=
 =?utf-8?B?MWp6N3JEQlRxaTM4U2RVd01xdG9MMGNmODhIY2dUMjBZTXpmWVJhYXZWd2k2?=
 =?utf-8?B?SnVVV2lyeXRNQjBZMkxzVVBYcEtQSVZQSHlWMTZOT0dYY0hiMHJzbi9DWUto?=
 =?utf-8?B?Z2JvcFRuTit6dGxPMmpxWjgwRXNRRmtPcld3VVVxMnUydGQvMkZ3RC9wd1VE?=
 =?utf-8?B?eDZrNWlPZGVJa2dYZmZuMGwyZEYvWEVhYUhxdVZMYm5CWGJ6azFKZ0dhV0Uv?=
 =?utf-8?B?clZFcFpWbXFJWHZCZjlaenJCWHM2WXJnOUZvK3lIWEUrRHdNaDRuTGJ5bzE5?=
 =?utf-8?B?VmpDWjl4VENpOXlWaTJkc2lkUGkwK25idFJhUTN1Ui9ZWWI4VlQ1d0RlMENR?=
 =?utf-8?B?TVNOV1IzUlRDT01FcnBRWEZTYWRBT0wxSW9Ua2JBNmdFSDZzemtuU2loRzVs?=
 =?utf-8?B?K0Z5R2ZkajRVcnZveldRQzZNVWJpUFNsdytzUUVTRGd4cURINVh3d1FhZzg5?=
 =?utf-8?B?MThQYnBUTE1MTk96ZCthdWdyYWZvN3ZwNDdJWXQwV0dxakxHN2pnSENSU2c2?=
 =?utf-8?B?Nk9QblZjN1NWSHdMWS9mOVN0ODlpL3poNHp4SW10UFhrTEFKdXk3VmZyTVoz?=
 =?utf-8?B?bDVZWGkyL2RMakg0aUJIZmhwTFpZVnhXWnA0Tks2WUxRL3JvUWQwRWd6K0tJ?=
 =?utf-8?B?bC9lNktzRUpCanV3aGloYVZVMHQzdHYyS2t6Tkd6b0dvb1k2TWgyVmYrbWFw?=
 =?utf-8?B?NU5tUTZOR2taaEh4SnpUNm1Rdm04enRlYXIyL1lsM1I2ZnpuUWp1ZGtqcEF5?=
 =?utf-8?B?WVk3bUVSZkozaml5OFNiTWxBYlhvN1hYODJqeXphd3IvYjliOXVtcVBjZVVZ?=
 =?utf-8?B?WXowWHVpUzdZN1l0WkFEM2tMMlcyVEdtRXR5NGhiOWJabmNZcTFORm1uWEZ4?=
 =?utf-8?B?eC92L0Fib1hkRFduVndOWEVKcVZ0NTcxQnl3TURsYTM1NDNpQ00zSnlEYjFX?=
 =?utf-8?B?am1GeHFkZmJ1bWtGbFlxTlNiS3RMZ212QlNCUjNLcHlIWjI4VGFHQ0hCUTNP?=
 =?utf-8?B?bDE3UElDNGxVcDFtVjNNUEoyTDJCL2JUNWlockZuNGdYVzh6M1NBdDdPRkRE?=
 =?utf-8?B?RjUxSFdmN0F3WTVJZUV6Tk10c215U3cwaFp5Mzk0V3hlKzYzL1RPYnlocUM2?=
 =?utf-8?B?UVdDai9MQTBVb0lndEVZQkVqbEJRWWpkRm9sU3hydnczYW0zM2RuY1VqcGtz?=
 =?utf-8?B?NXBycGgxM0Fyc0MraGU4RmxsRDQ1MThEZnk2b3JsWEJheU00cklsVlVtdjQw?=
 =?utf-8?B?SENHM3Nvd3I5NmQ4Znp0dTV6MXpVQkR0Y1JjQk1wQjhlZ0hLVjdCVHhWTWNa?=
 =?utf-8?B?dlhveWg2MHE0NS9EMzdQZHYvOFloZ3dNcWlSNEpDNS9ReEhjSzhUVXlldm1n?=
 =?utf-8?B?MmpQbEExQmt1S2d1T3FPdFFqcXlpT1hDSWpKdVkycVUvWU5yUkw4MnVaREtv?=
 =?utf-8?B?SWxrNVZjMFYxRzFZcDlnUTFEQUwzNG1IeFJ5MmN4bkkxUUEzZnc1ZDUzZW1Y?=
 =?utf-8?Q?yakBVCQph0FtD4nr3/XjfYwMgMSDFE5fbB12brE?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3380.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d04bd97f-c9d9-4fa9-c517-08d977f3e15b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2021 02:52:38.9912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: byrUh2ognd50p31TgxtDEfV3aeRPB8KfDk7WOefHnOZuKBIw7tzTvhAOPJWbA4Qa1TUhCAlgew7x/HUmrkIiBzO+JmyQV+I8VHqCVslpnrA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2835
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdGVwaGVuIEJveWQgPHNib3lk
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFdlZG5lc2RheSwgU2VwdGVtYmVyIDE1LCAyMDIxIDk6MTcg
QU0NCj4gVG86IENsYXVkaXUuQmV6bmVhQG1pY3JvY2hpcC5jb207IFJ5YW4gQ2hlbg0KPiA8cnlh
bl9jaGVuQGFzcGVlZHRlY2guY29tPjsgYW5kcmV3QGFqLmlkLmF1OyBqb2VsQGptcy5pZC5hdTsN
Cj4gbGludXgtY2xrQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZzsNCj4gbXR1cnF1ZXR0ZUBiYXlsaWJyZS5jb20NCj4gU3ViamVjdDogUkU6IFtQQVRDSHYyXSBj
bGs6YXNwZWVkOkZpeCBBU1QyNjAwIGhwbGwgY2FsY3VsYXRlIGZvcm11bGENCj4gDQo+IFF1b3Rp
bmcgUnlhbiBDaGVuICgyMDIxLTA5LTEyIDIyOjMxOjQ2KQ0KPiA+ID4gPiArICAgICAgICAgICAg
ICAgaWYgKGh3c3RyYXAgJiBCSVQoMTApKQ0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAg
ICBtID0gMHg1RjsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIGVsc2Ugew0KPiA+ID4gPiArICAg
ICAgICAgICAgICAgICAgICAgICBpZiAoaHdzdHJhcCAmIEJJVCg4KSkNCj4gPiA+DQo+ID4gPiBZ
b3UgbWF5IHdyaXRlIGl0IGRpcmVjdGx5Og0KPiA+ID4gICAgICAgICAgICAgICAgIGVsc2UgaWYg
KGh3c3RyYXAgJiBCSVQoOCkpDQo+ID4gPg0KPiA+IEhlbGxvLA0KPiA+ICAgICAgICAgTGlrZSBJ
IGNvbW1pdCBtZXNzYWdlIE0gPSBTQ1U1MDBbMTBdID8gMHg1RiA6IFNDVTUwMFs4XSA/IDB4QkYg
Og0KPiBTQ1UyMDBbMTI6MF0NCj4gPiAgICAgICAgIGl0IG5lZWQga2VlcCBmcm9tIHJlZ2lzdGVy
IHJlYWQsIGlmIEJJVCg4KS9CSVQoMTApIG5vdCAxLg0KPiA+DQo+IA0KPiBJIGRvbid0IGdldCBp
dC4gVGhlIHJldmlldyBjb21tZW50IHdhcyB0aGF0IHRoZSBlbHNlIHsgaWYgKC4uLikgY2FuIGJl
IGNvbGxhcHNlZA0KPiBpbnRvIGFuIGVsc2UgaWYgKC4uKSBXaGF0IGRvZXMgY29tbWl0IG1lc3Nh
Z2UgaGF2ZSB0byBkbyB3aXRoIGl0Pw0KU29ycnkgZm9yIGNvbmZ1c2UuDQpPciBkbyB5b3UgbWVh
biBsaWtlIGZvbGxvd2luZyBtb2RpZmljYXRpb24/DQoNCiAgICAgICAgICAgICAgIGlmIChod3N0
cmFwICYgQklUKDEwKSkNCiAgICAgICAgICAgICAgICAgICAgICAgbSA9IDB4NUY7DQogICAgICAg
ICAgICAgICBlbHNlIGlmIChod3N0cmFwICYgQklUKDgpKQ0KICAgICAgICAgICAgICAgICAgICAg
ICBtID0gMHhCRjsNCg==
