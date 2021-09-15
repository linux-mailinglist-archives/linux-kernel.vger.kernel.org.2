Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3919A40BE09
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 05:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235946AbhIODMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 23:12:54 -0400
Received: from mail-eopbgr1320121.outbound.protection.outlook.com ([40.107.132.121]:47456
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229888AbhIODMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 23:12:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pyhrfq+CdgDB5T/za4YeQEQoxZXMrvmjGWnbqeZ8Megs/ffLs/Byf7qTt7kYv1OERFAcn7vOFrRDQrqqcsrB1m9MJglMFxQ2SrNaxeyDJSuhAUlslMvNDmkbyz63T82RAeKVn3XuoS5qFapZ6dNlf9EoCFC3VuearojbD89gEIgLRzUOAoa/6lZ+pqbCW/QsMHsN5221U6yrjqn2dtwF7l0wJ7Lgmnme5Q98qKDcOQtUJPt2+8gsHHdNVIVY5WpyvwXjv/KQSx/18fFlCGCMLA86L/E5WX2dNRWRO68Hrip6JUIAAaHpi8Qa+1GCiSfLeEyBNLDklVB9SQjOt/rPBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=M0rmp+T0Kon11C5RPIVLimcqchBQSBUNykqClicOEgI=;
 b=hf2LlYkjeLw9wot5/l++Wys3/yKnhVe0tRWaIWlu1UaOb5F8ysboaD2CmjJNF+/QD1HSmX2TU5FMygin+retK8EyRFvMcWCGIHF0yd8V1Z4gTRCPZDI8tywcpW/oxakw0oUew/uTHtUPyRaCAvhtofkWzcuSwqFcFC2qzJHRJ9oimI6q0EtQ5wUBJWHUdwL/MWfJZgYBEFGBOCeea7Bi5BN9N0ZlgjR/lPADXjVndBFiDStJPI0Zr6s6n0gO5cPdZ2YliSVMlxEXhyYBLVG01PsfoJOA4Nh+WZKwPfHOf5DELEfKVZIFk5U0lRC+3ZIFvOWsEc2J0GWNwmw6NT8mDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0rmp+T0Kon11C5RPIVLimcqchBQSBUNykqClicOEgI=;
 b=oeyqWSfbtAKljyUkIjGxmt1CHLLwmNusBTRNU5d0fNEyQImW/yWWwkMPEx5TnJj6uAjh9AuxNk9GenTO9xHXT2eRVL4DDwaYasFwenZq6LvsxrLjo/0LIYVZsCdrwo/OOiSIfg6vy0OW3v7unh8218PmqtDtD6GpUnzHGi15CS2Y9ibMjFLA2RsIsMNF/VI4LOAVhECkmAXp+h+wgyB0lC24+zjZdCxyRN8/cKAUQgUSSRRY0xCD/4xbVDcKHDVQwQj3pq96m5EhO8LW/Izqt/Vrwif6ahcp46tubxuErPTndSfvZotmcx1f7tHoCJZxXPmvBEaeSp4oQSvbjbk0qQ==
Received: from HK0PR06MB3380.apcprd06.prod.outlook.com (2603:1096:203:82::18)
 by HK0PR06MB2243.apcprd06.prod.outlook.com (2603:1096:203:48::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Wed, 15 Sep
 2021 03:11:31 +0000
Received: from HK0PR06MB3380.apcprd06.prod.outlook.com
 ([fe80::df9:c3a4:7589:e812]) by HK0PR06MB3380.apcprd06.prod.outlook.com
 ([fe80::df9:c3a4:7589:e812%3]) with mapi id 15.20.4500.019; Wed, 15 Sep 2021
 03:11:30 +0000
From:   Ryan Chen <ryan_chen@aspeedtech.com>
To:     Joel Stanley <joel@jms.id.au>
CC:     Stephen Boyd <sboyd@kernel.org>,
        "Claudiu.Beznea@microchip.com" <Claudiu.Beznea@microchip.com>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>
Subject: RE: [PATCHv2] clk:aspeed:Fix AST2600 hpll calculate formula
Thread-Topic: [PATCHv2] clk:aspeed:Fix AST2600 hpll calculate formula
Thread-Index: AQHXpJKMhkZfnItOBUy/UXzlogoQrauhdqeAgAAAnqCAAt58gIAAGF9AgAAGUACAAAER4A==
Date:   Wed, 15 Sep 2021 03:11:30 +0000
Message-ID: <HK0PR06MB338054B6C48B751A9E5FE5D0F2DB9@HK0PR06MB3380.apcprd06.prod.outlook.com>
References: <20210908091845.4230-1-ryan_chen@aspeedtech.com>
 <4571c9ae-0287-4f70-2adb-9c227e706736@microchip.com>
 <HK0PR06MB33806C10EB8B3F87FE144F8DF2D99@HK0PR06MB3380.apcprd06.prod.outlook.com>
 <163166864956.763609.8140689140101809508@swboyd.mtv.corp.google.com>
 <HK0PR06MB33801C3DADFD87363C09BFAFF2DB9@HK0PR06MB3380.apcprd06.prod.outlook.com>
 <CACPK8XfN9YxTveoOVUFoJjq1_R_8mdvDQnF+DOVvkNaosnKN0g@mail.gmail.com>
In-Reply-To: <CACPK8XfN9YxTveoOVUFoJjq1_R_8mdvDQnF+DOVvkNaosnKN0g@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: jms.id.au; dkim=none (message not signed)
 header.d=none;jms.id.au; dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e64c4eb-ce9e-4acc-06d5-08d977f683fe
x-ms-traffictypediagnostic: HK0PR06MB2243:
x-microsoft-antispam-prvs: <HK0PR06MB22432DA314527C9B17A79A8DF2DB9@HK0PR06MB2243.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:534;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UzYsX9CQZRElNwwnAHxzD5bRNIBRFkjx8DUUU5AXW5zq1BoG+6MTuqnuBfZMJCQ09JK6/oEFT5Uk5JWmEFeXmefMMNjH+Hswh4phfAHa8Pld/P9FD8+Kpc2aSsHsV4E8UCK0JVrEoWxJCs+eMC4SRCXQ12tM+Xf42W9Cj2Hvv1OUbOqKh1Tfdn4CQmOjYCW8zlI/CBHOUX5KW2wp5HOWDq+ScZZUN3995y0BTTEcKrA1kDikrceRqhD6bLgmIJEDyY1+vh17DlhXJLbcSgCbUzSE+nLPneN/Uin4NWUWMiK7i9TTjYwwSlymR4PdLFy6sa62oIqeEBgjD6wPyltrMq6zHUEgvtk5o3oAbcN/Ch5puq7Quywn+IFlCJiF0ODiNAm3hZYMp5sw147INPrM6z/+XgEUV2ayDR65lL05VbT93e9gCHfLaJg0qh/TiEJhEfTJGL/2tyFVhJdracrSJxCN6EFp5GXpM3p5GGoj6LEhCnirrFE8M6HHvxmjpYm8gVWgud2AATvTcmEoWUhfw0QNqxkO38mGWKNoqMba2Z28Pn5nLa0lMm9jJwRLVYqnZdnpMCaMKU0EzgK1C/JmKFrhNgjP2RJ/0oyj2y4dngONOmTbxc6tJeL/fKe+m+HpDwG2JgOBl8QfeXDZR7qC5pjdvIMfqUbVo0blfL/wyvVCGsk7bU1VnRNZEdsdwyWxIfG1Y5p7Y6M3gZ1wYgUz0A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3380.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(39840400004)(396003)(136003)(366004)(8676002)(4326008)(76116006)(66946007)(26005)(5660300002)(316002)(83380400001)(86362001)(55016002)(478600001)(71200400001)(9686003)(38100700002)(186003)(8936002)(122000001)(6916009)(38070700005)(54906003)(64756008)(6506007)(53546011)(33656002)(52536014)(66556008)(7696005)(2906002)(66476007)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SG9Xb3dsSjFXb0pCZ3hlclI5MkYzNDVjUHdDa2VncGVkVXo3L0cvZzQwUVo0?=
 =?utf-8?B?amFrT3VuN25PQS94NVRzRG9oRnE2NUpPRWxKQW9uK0g4RElvWS9WNGRXUzRa?=
 =?utf-8?B?Snh5bTZycXRyZElEbzM2MWVTT0Vid0FjaFNVYVFudHc1bGRDYUhrOFR1M3Q3?=
 =?utf-8?B?OUp3aGtrUTJhbDBYQVhPaExNQ0ZHekhiMTNTVmwzN0lvMnlSVnFtTlhZdlln?=
 =?utf-8?B?cHdwRTN4TzU3U2t1T3lDWEdKVzJCY24vaUlld1BMNzN1UjN2NUlWdS9JenYv?=
 =?utf-8?B?Sm41QkNyRGRkUVRuZzlRNmlUMlY4Y3FHbW9lZjBxcmFHcGp3ZzR2QTU5bE1Q?=
 =?utf-8?B?VEd2QzNPbHZmVCt6alRTUEZOUHk1L2tKL01BQm1hTHdFOWhmdUJtSTVNbk1w?=
 =?utf-8?B?cjRmUWc0SjRuV0xCcWthNFI3NkRmVXB0c3RWQTgzMll1dmNmcWF5QXA0STF6?=
 =?utf-8?B?cFJzMG4ydktTUHVOOEVlQ3F6ZlU0QWcrRS8yS1hPcjI2dWcvTy8wSEtKYWlv?=
 =?utf-8?B?dVNiRjFQM1BnaStkak15OUQ3ZTZqTTBTNldIRjA5TTJnMHphSG5CVjREY0JF?=
 =?utf-8?B?eEFrUjVHbTR0R3JHdDFLY2c2QjZFSnNEVDJza1pqbk1qblJzQ0pid2JxV3BP?=
 =?utf-8?B?T3VadGZybTVCV1Z1eGd1SnNUamwrdFZSRlhLSXYwcHpJbmQ4MlFCWnkrSlNN?=
 =?utf-8?B?eXhJMERRTW1kUmxrRnQveFBtblRmYlRDb2VwTTVKejF2dk9VRlJHNGZsdUZt?=
 =?utf-8?B?ajRzZDBrRWx3L0tuTnRrZGg0MWU3dUpkSjJiRDMwNW9mWXZqcHpzcGFhcnVG?=
 =?utf-8?B?SVZoUm8xUTlDS3VrVUc1c0dCaEVlMkJQd2RkSVd5eDRtN0Vhd3NSL0F2NGd0?=
 =?utf-8?B?ZzVlTXdFeHl6cUhiTGFMaVVpTDBUR1FIU0lRVDBDbTV4TWFxdjVJMHhtcFJm?=
 =?utf-8?B?R05pWDNNTTVPNTkwUllGOHBrY2U0WElKY05FenZud2JacXI2ODZ4OUpaUE52?=
 =?utf-8?B?bURUZ3o4eDNZM3p1Zzk0YlYzbTlOTjhXeFJURFJXM2U3aTBXNmdsczVhWG9q?=
 =?utf-8?B?ZXZaYkE5Q2ZUZ0FXcG9BYUF2cWdCU2xRN0k5OUJrcHRLS1QxWTVTd2x2STdR?=
 =?utf-8?B?ejFqb3JDaGVuVVFJeFZCZnlraXpZMzFHc1djOXFzbFJQOFVmcU43WmZFdW43?=
 =?utf-8?B?THBDUU9xOWx6a21IWDJia3AweEtZVHZiREpBTTVOeCs2eEVPZzVBZzRCQkZW?=
 =?utf-8?B?eFZCeFFaaGh4SEtaKzFwVk92K0lPMVNvdnhaS1NDRWNsNDJzazExNlFVV0x2?=
 =?utf-8?B?TnkvMzNPRitwVjZsZjN5R2pubVhnWndwTU9ENnNqckVDVGs0aWI4bk1HV1Zl?=
 =?utf-8?B?VExnbFloVFF2dzlrUXI0Zzk3OE9vVFJFSmpudXhVMVVva2x6WnpoK3hMbzlr?=
 =?utf-8?B?OGVHYmdWSTh0YytFTVo0anRjWTEvWTc2Q1U0TFVpVUxHSEVwL2tvcDlvdGx5?=
 =?utf-8?B?STBpdi82bGlYZDBOL3U0MWhwc3I3TlNWTmJDcFNOOEdtMGI2d08wQWEvMFVH?=
 =?utf-8?B?Y0pZalNuTXduVW11ZHV2T3dvT3hGTzNNTTNFeU8xMkl4dmw1Y2FHMlRMOHVw?=
 =?utf-8?B?bWhBbTBMeng5SzRFdFVrc1lQeUUzaG1Za3ROVUNhTlBlMlREdWpWTHEzQkxs?=
 =?utf-8?B?UURtU091VUhmRUtMaTRhbm9iN0JtTWlXeUpVZnZFVmdxYzVlNFREM1dHMXcy?=
 =?utf-8?Q?f1LwYdHpjtrxSbhs0mpr3UhD8Wmb0NHO91JoLJn?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3380.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e64c4eb-ce9e-4acc-06d5-08d977f683fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2021 03:11:30.8210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VtRe+GVBZa6YrMF/yEHHu3bEU6rgI+JBYZSrPssXQPxPlgkzbGPSXQb9q1fTf7k40xv6okSiFr1EHJEpM7rInIF010gL3QE9APaPPKslLZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2243
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb2VsIFN0YW5sZXkgPGpvZWxA
am1zLmlkLmF1Pg0KPiBTZW50OiBXZWRuZXNkYXksIFNlcHRlbWJlciAxNSwgMjAyMSAxMTowNyBB
TQ0KPiBUbzogUnlhbiBDaGVuIDxyeWFuX2NoZW5AYXNwZWVkdGVjaC5jb20+DQo+IENjOiBTdGVw
aGVuIEJveWQgPHNib3lkQGtlcm5lbC5vcmc+OyBDbGF1ZGl1LkJlem5lYUBtaWNyb2NoaXAuY29t
Ow0KPiBhbmRyZXdAYWouaWQuYXU7IGxpbnV4LWNsa0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IG10dXJxdWV0dGVAYmF5bGlicmUuY29tDQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0h2Ml0gY2xrOmFzcGVlZDpGaXggQVNUMjYwMCBocGxsIGNhbGN1bGF0ZSBm
b3JtdWxhDQo+IA0KPiBPbiBXZWQsIDE1IFNlcHQgMjAyMSBhdCAwMjo1MiwgUnlhbiBDaGVuIDxy
eWFuX2NoZW5AYXNwZWVkdGVjaC5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogU3RlcGhlbiBCb3lkIDxzYm95ZEBrZXJuZWwu
b3JnPg0KPiA+ID4gU2VudDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIgMTUsIDIwMjEgOToxNyBBTQ0K
PiA+ID4gVG86IENsYXVkaXUuQmV6bmVhQG1pY3JvY2hpcC5jb207IFJ5YW4gQ2hlbg0KPiA+ID4g
PHJ5YW5fY2hlbkBhc3BlZWR0ZWNoLmNvbT47IGFuZHJld0Bhai5pZC5hdTsgam9lbEBqbXMuaWQu
YXU7DQo+ID4gPiBsaW51eC1jbGtAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOw0KPiA+ID4gbXR1cnF1ZXR0ZUBiYXlsaWJyZS5jb20NCj4gPiA+IFN1YmplY3Q6
IFJFOiBbUEFUQ0h2Ml0gY2xrOmFzcGVlZDpGaXggQVNUMjYwMCBocGxsIGNhbGN1bGF0ZSBmb3Jt
dWxhDQo+ID4gPg0KPiA+ID4gUXVvdGluZyBSeWFuIENoZW4gKDIwMjEtMDktMTIgMjI6MzE6NDYp
DQo+ID4gPiA+ID4gPiArICAgICAgICAgICAgICAgaWYgKGh3c3RyYXAgJiBCSVQoMTApKQ0KPiA+
ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgbSA9IDB4NUY7DQo+ID4gPiA+ID4gPiAr
ICAgICAgICAgICAgICAgZWxzZSB7DQo+ID4gPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAg
ICBpZiAoaHdzdHJhcCAmIEJJVCg4KSkNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFlvdSBtYXkgd3Jp
dGUgaXQgZGlyZWN0bHk6DQo+ID4gPiA+ID4gICAgICAgICAgICAgICAgIGVsc2UgaWYgKGh3c3Ry
YXAgJiBCSVQoOCkpDQo+ID4gPiA+ID4NCj4gPiA+ID4gSGVsbG8sDQo+ID4gPiA+ICAgICAgICAg
TGlrZSBJIGNvbW1pdCBtZXNzYWdlIE0gPSBTQ1U1MDBbMTBdID8gMHg1RiA6IFNDVTUwMFs4XSA/
DQo+IDB4QkYgOg0KPiA+ID4gU0NVMjAwWzEyOjBdDQo+ID4gPiA+ICAgICAgICAgaXQgbmVlZCBr
ZWVwIGZyb20gcmVnaXN0ZXIgcmVhZCwgaWYgQklUKDgpL0JJVCgxMCkgbm90IDEuDQo+ID4gPiA+
DQo+ID4gPg0KPiA+ID4gSSBkb24ndCBnZXQgaXQuIFRoZSByZXZpZXcgY29tbWVudCB3YXMgdGhh
dCB0aGUgZWxzZSB7IGlmICguLi4pIGNhbg0KPiA+ID4gYmUgY29sbGFwc2VkIGludG8gYW4gZWxz
ZSBpZiAoLi4pIFdoYXQgZG9lcyBjb21taXQgbWVzc2FnZSBoYXZlIHRvIGRvIHdpdGgNCj4gaXQ/
DQo+ID4gU29ycnkgZm9yIGNvbmZ1c2UuDQo+ID4gT3IgZG8geW91IG1lYW4gbGlrZSBmb2xsb3dp
bmcgbW9kaWZpY2F0aW9uPw0KPiA+DQo+ID4gICAgICAgICAgICAgICAgaWYgKGh3c3RyYXAgJiBC
SVQoMTApKQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgbSA9IDB4NUY7DQo+ID4gICAgICAg
ICAgICAgICAgZWxzZSBpZiAoaHdzdHJhcCAmIEJJVCg4KSkNCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgIG0gPSAweEJGOw0KPiANCj4gWWVwIQ0KPiANCj4gVGFrZSBhIGxvb2sgYXQgbXkgcmV2
aWV3IG9mIHYxLiBJIHdyb3RlIGl0IG91dCB0aGVyZS4NCkdvdCBpdCB3aWxsIG1vZGlmeSBieSB0
aGlzLg0K
