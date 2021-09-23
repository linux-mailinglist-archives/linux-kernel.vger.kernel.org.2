Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF68441559D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 04:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239023AbhIWCw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 22:52:56 -0400
Received: from mail-eopbgr20047.outbound.protection.outlook.com ([40.107.2.47]:10469
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239019AbhIWCwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 22:52:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLpRQ/7C/2HuW9ueqRFesmWXLAvVxmL67vYtVa/68j/6LSVfuj3XLrTf5qKmoRhBv0OsV4uRuqtF5j2jKrqNXmkGPFpM7+OFwUwLubi7c69eUGu8DFy8H8nk9sIh9/yDYizUOjqfOa4+tL+79WCOiw4fbi05FJt+70E9STqS8Uo10TMLc5WFjSPwL28rBnF/q2wBOx22Od4LN+uV2DBYOVbK/D7rWvdUGJd5ZFRbA3yWGDPN4HeIBdpS+5VNAmTY2RQ8g26MQ1r7dKZj/S2B7t+1DCiy7AaL7Y3AzGNF4WNEaybjZfHIMiQHEqnPsqDkhfi7KTWAuqYAlwe4GHX8RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=rcOBJWBiu4v7Y1JUHA6FzCMF6TcmF8Dm9CpfpMx/xbI=;
 b=UfTijc1TeJUrpXBr6aLljPUu3jlbQkVz/YYUJZHuqOdZutWBKxfqIUe8nTXoLsuLGZFov1F11HWum6Lu84aicgQIeXGM5wmnLd3mjMySZ4KdcI+RUjBCh0Wu24GxwkOyeUlt5ml5viJJjQe6kEKMAzgBLdDDqLD30CqwmHfSrhxNOlsNZuZG42Q3UlYvatgPhnGG7vTnOz6cxeennNTEzh037jK2VYXRoVqXNnH/f0yr5AcMtEoT8NuR7g1qB0bHOmutPlaELSywB36/UyU//m18grc6bo9WTCzxxlEfZtzcEnZcyDa//+Y+quVQtrPGz/FUn2yRAOkramelIxS0Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rcOBJWBiu4v7Y1JUHA6FzCMF6TcmF8Dm9CpfpMx/xbI=;
 b=rDVBr3XWzGZOp3Ijo1vVJJ501CwqvOOm+YF9RhK+8fElMcnfhrBlEZIQ5zvcqm7rq5CpZogtlFI8WJ14JIVxHrtMGiXNre6P6wY5ui2NuTFTrk4InGuv/Hv02FCl4v1xYGoPnwnmXLxt8NEQcMjw4i8GYLEWLGDIYhMrPBo/0nc=
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB6PR0401MB2325.eurprd04.prod.outlook.com (2603:10a6:4:49::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Thu, 23 Sep
 2021 02:51:15 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::5d5a:30b0:2bc2:312f]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::5d5a:30b0:2bc2:312f%9]) with mapi id 15.20.4544.013; Thu, 23 Sep 2021
 02:51:15 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        =?gb2312?B?SmFuIEyouWJiZQ==?= <jlu@pengutronix.de>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/6] dt-bindings: nvmem: add cell-type to nvmem cells
Thread-Topic: [PATCH 1/6] dt-bindings: nvmem: add cell-type to nvmem cells
Thread-Index: AQHXpJi6sCDnWRUWYkm3IZxLeeZimKuwAl0AgAD6OeA=
Date:   Thu, 23 Sep 2021 02:51:15 +0000
Message-ID: <DB8PR04MB679575581BE2FE2D6BE6F98BE6A39@DB8PR04MB6795.eurprd04.prod.outlook.com>
References: <20210908100257.17833-1-qiangqing.zhang@nxp.com>
 <20210908100257.17833-2-qiangqing.zhang@nxp.com>
 <6d91d833-08cc-7ce2-4fe5-3d843a8b31ae@pengutronix.de>
In-Reply-To: <6d91d833-08cc-7ce2-4fe5-3d843a8b31ae@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd2a409b-be3a-43e0-17ef-08d97e3d029f
x-ms-traffictypediagnostic: DB6PR0401MB2325:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0401MB2325FEAEC737AB95952053D4E6A39@DB6PR0401MB2325.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tDM1ziVrxh9S6hYMV7G97aOSdmDXHhsNTvkVlO82idGQurnppe5EuMU15gZdQfpYxBzlWN4+regDNllUwqiTf3El8jfTpB5hTpM1NygeAl6h6C8QCmXYewvatclw+Jm0eho4zZB8xvYrYDVkJSkz5BZlJuS020GpT0s6YuC/yOzTzPj8npSfqTNiojhKWN866i5xvlQrA9YZ6YHu4BZEnunj/n3UzhL9fNcg1mvegMieDp+mMZmGpwlaq2kF4X4eF2/t+mmobyCUx9cFAfJ7Ag9RiTJOtu9VzfaMig/rDvMWLsBqxmueXa2gxgort7ys7juN+N804KQHb39bkP/vMwcKc3BHx1vSztDw0zKZSVrPGZdDYI6JpgWcNy5xwUtSVVeUg6nRmTCqzvNTrv59qIp/jn/4sYsNAyG/CqGLRFMMpRnLWmB/p/vym+04VwhHP4AAfh3pCm8KSQF/MWNm8kw9Yt5dUiXnfLdlTmR7rb+qkzb7IyvYZ9QG0zSkz6erZOkcDlGk36CnckVBPg7OHJmtqwqZTSjkaTUSlnUhnGgr09uu+cOBE8ozziBddPYd7Mw6IwcEQaU6NziLYF0mNVOkn5ZySVAXm/7i6gwwYc4BhpVchiwAM6KOQitSg3jKTEBupxcP0+eZizOu6VU3WnWtOnEnGV6LILWBY6DZuY/Ah7Gx69EF+KwC/C60r2JufNTIv+STpy4kl1/d0m5pqw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(55016002)(52536014)(53546011)(86362001)(8676002)(4326008)(6506007)(9686003)(76116006)(38070700005)(26005)(2906002)(64756008)(5660300002)(66446008)(71200400001)(7696005)(54906003)(66476007)(66556008)(122000001)(33656002)(83380400001)(8936002)(66574015)(186003)(38100700002)(508600001)(316002)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?NVpEaGxXaXJMcWVrb3c2aGRtcWRSNCtoVU9hVXliM1g0ZkpueEJiK0RyME03?=
 =?gb2312?B?S0VHTkRnQUZodGhJN1ozZXY1blZtbG5CZ3cwd2xWQVJSU3VFLzV1YzFITElQ?=
 =?gb2312?B?Vi9neGhIU01oT05yQkxaVTJpeUt3VWNVYzgwMFhMcDhnV0dHT0JxTVBURnI2?=
 =?gb2312?B?Y0hpTldIY0RZWDZERFlsMkdEelMzdENvMjhMMjIzWVQ2R2taZkFReldQUElP?=
 =?gb2312?B?NjB3NFlQNWdLWm9UcFpIWW1pL2kvQVBOTHJBODJlaTQ5Y3h4bVdUekYxaENq?=
 =?gb2312?B?UXVyL3RQNTRGMkg3ejVET3doS2FZYnFGWE8rRFBDQ2VHSHR5cUpJVzJoU2xs?=
 =?gb2312?B?TU9rbU5oMlZ3NVZYaWtEZWlZTWh4Q1RJK0VTaDIra0FOYU1Ta0drRzlpaXcx?=
 =?gb2312?B?cXlxSlBBY2xkcmdwNzFMaW5KWkxvaGhFR0xBVnhKcEJUeUR1cWQ5TUdIRERT?=
 =?gb2312?B?QmhONVpaZVZwRzEvU3Z1SEhNaGE3TDZDVm8zMk9pdlNyOTFoTW9FcTY2UzRn?=
 =?gb2312?B?M1h4YzlkOW5kTnA1WThJS09EUW9sZ1h5OGJaMmdFOWhUOXMvRTlNcUc3eXha?=
 =?gb2312?B?cUxhcG9nRGx6ZFZlOW1HTStMTk9ZZi9QY002WDhuZ3JpUVVGWUlwNEIzc053?=
 =?gb2312?B?a3dQZ0kwQjFISXcxZTZSNmwxQUI5YUdEQ0lEUlMzU3k3SDRzamQvODlaK0hn?=
 =?gb2312?B?TjRZbWFaQ3krUlpvRkpBSnZ4ZkdoTitqemx2NDAwSG9rSS9NQXdFOHdyTy9Y?=
 =?gb2312?B?MnFPUnRudkk2ZmtadGxGWnc1VzJiVjVvVTFqL01aVEFiT0ZiV3dnMkE5Ym1Z?=
 =?gb2312?B?WnljejZOT1JmbzFJYWRabU5mNU1mRkc2MWM3NzA3NWtoNUdDZjN1RHhQQ0h0?=
 =?gb2312?B?NUdHRDZrOVU5bEQ5WWJjTndIRXFiMmNMeDNkYVVYZ3FrdFhJZkw4R1hqWWM2?=
 =?gb2312?B?MUx6SzYzVjIzTVJJc0M3MFIxeWw2dUFDZ0h0RnpzblF3eWFwRjBmaXBBZ1dG?=
 =?gb2312?B?M0ZaOTNqKytwOVQ5OGxHQnhXblhCd01PL28xek9pL1BJemRWdURNUGYveGNZ?=
 =?gb2312?B?NFpkT01hN3Fla3N3NHNiMnBuTTlVOXJ5U0hraW1weXJsNlVDUThSTDd4Qlpo?=
 =?gb2312?B?SFhCVWtVMTlBSlg5SksrcmdEMkhVcnJKenZLNklaTG94dElZTnc0Qjc0bjgz?=
 =?gb2312?B?QVUzMmpyNjQyYzlYZVdqTjIwanlsMHVKbnBYZDMvbFJWNHF5Nk51aFlUTjMz?=
 =?gb2312?B?N0NoSzVlcHRoelMzbWpVZHdGVzRwSStRMmcwRm5LUklrUGIrRHdOeUxIcU96?=
 =?gb2312?B?b1E3NnlVSnJVVlExa0pMNnpZWlpZdHl4WGtNVVFZSURQaXJ0clljLzdDZGgz?=
 =?gb2312?B?L1h5ekRuakh0R1dVVWF1TFVKZFNPRzJqZjh2bG4zMTdya29BZUFnUVR4V05S?=
 =?gb2312?B?R2JScmYxcFNEbjU3SE1qTlRyOTJSVHVWdjNiMVE5N2hrbXc3V0M3dlc5WUh5?=
 =?gb2312?B?MGh1cWZMcXBSdWtlV09JNFUwQmh5U0hlZEs0T1daMm9xZmRBRWxxcG9QVW1C?=
 =?gb2312?B?TzNwZFA3T09wOG1OOURaL2t2SVg0NzlVUzNOb2N1UW00aVlpbWsxb25pLy9w?=
 =?gb2312?B?cGdzYXY1U01ha0l4bFlJUUVCL1ZZUm1Gd25KazVQT0trR1orc1hlb2ltUkpC?=
 =?gb2312?B?YzMwOVJBSkRWUjJsS29TU3R5eVNQbHpsT01TL2lxMGNrMktTdkxudW95SFhQ?=
 =?gb2312?Q?QkP2gKLEGJtcW3P2ar5QhpDmdGUwWnpvMaJCFCq?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd2a409b-be3a-43e0-17ef-08d97e3d029f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2021 02:51:15.0865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bICDramM0mfwFok3CjJPAOcpgkPlw4zWjL//9gcLRkEOkeekXqoqs2DP4y9lzrOma7/x2TsA2VwvKfBMVpKM9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2325
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpIaSBBaG1hZCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBaG1h
ZCBGYXRvdW0gPGEuZmF0b3VtQHBlbmd1dHJvbml4LmRlPg0KPiBTZW50OiAyMDIxxOo51MIyMsjV
IDE5OjM0DQo+IFRvOiBKb2FraW0gWmhhbmcgPHFpYW5ncWluZy56aGFuZ0BueHAuY29tPjsNCj4g
c3Jpbml2YXMua2FuZGFnYXRsYUBsaW5hcm8ub3JnOyByb2JoK2R0QGtlcm5lbC5vcmc7IHNoYXdu
Z3VvQGtlcm5lbC5vcmc7DQo+IEphbiBMqLliYmUgPGpsdUBwZW5ndXRyb25peC5kZT4NCj4gQ2M6
IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAu
Y29tPjsNCj4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS82XSBkdC1iaW5kaW5nczogbnZtZW06IGFkZCBj
ZWxsLXR5cGUgdG8gbnZtZW0gY2VsbHMNCj4gDQo+IEhpLA0KPiANCj4gT24gMDguMDkuMjEgMTI6
MDIsIEpvYWtpbSBaaGFuZyB3cm90ZToNCj4gPiBGcm9tOiBTcmluaXZhcyBLYW5kYWdhdGxhIDxz
cmluaXZhcy5rYW5kYWdhdGxhQGxpbmFyby5vcmc+DQo+ID4NCj4gPiBTb21lIG9mIHRoZSBudm1l
bSBwcm92aWRlcnMgZW5jb2RlIGRhdGEgZm9yIGNlcnRhaW4gdHlwZSBvZiBudm1lbQ0KPiA+IGNl
bGwsIGV4YW1wbGUgbWFjLWFkZHJlc3MgaXMgc3RvcmVkIGluIGFzY2lpIG9yIHdpdGggZGVsaW1p
dGVyIG9yIGluIHJldmVyc2UNCj4gb3JkZXIuDQo+ID4NCj4gPiBUaGlzIGlzIG11Y2ggc3BlY2lm
aWMgdG8gdmVuZG9yLCBzbyBoYXZpbmcgYSBjZWxsLXR5cGUgd291bGQgYWxsb3cNCj4gPiBudm1l
bSBwcm92aWRlciBkcml2ZXJzIHRvIHBvc3QtcHJvY2VzcyB0aGlzIGJlZm9yZSB1c2luZyBpdC4N
Cj4gDQo+IEkgZG9uJ3QgYWdyZWUgd2l0aCB0aGlzIGFzc2Vzc21lbnQuIFVzZXJzIG9mIHRoZSBP
Q09UUCBzbyBmYXIgdXNlZCB0aGlzIHNwZWNpZmljDQo+IGVuY29kaW5nLiBCb290bG9hZGVycyBk
ZWNvZGUgdGhlIE9DT1RQIHRoaXMgd2F5LCBidXQgdGhpcyBlbmNvZGluZyBpc24ndA0KPiByZWFs
bHkgYW4gaW5oZXJlbnQgYXR0cmlidXRlIG9mIHRoZSBPQ09UUC4gQSBuZXcgTlhQIFNvQyB3aXRo
IGEgZGlmZmVyZW50IE9UUA0KPiBJUCB3aWxsIGxpa2VseSB1c2UgdGhlIHNhbWUgZm9ybWF0LiBV
c2VycyBtYXkgZXZlbiB1c2UgdGhlIHNhbWUgZm9ybWF0IG9uIGFuDQo+IEVFUFJPTSB0byBwb3B1
bGF0ZSBhIHNlY29uZCBvZmYtU29DIGludGVyZmFjZSwgLi4gZXRjLg0KPiANCj4gSSdkIHRodXMg
cHJlZmVyIHRvIG5vdCBtYWtlIHRoaXMgc3BlY2lmaWMgdG8gdGhlIE9DT1RQIGFzIGFsbDoNCj4g
DQo+ICAgKiAjZGVmaW5lIE5WTUVNX0NFTExfRU5DT0RJTkdfTUFDX0FERFJFU1NfSU1YCS8qIC4u
LiAqLw0KPiANCj4gICAqIGNlbGwtdHlwZSA9IDxOVk1FTV9DRUxMX0VOQ09ESU5HX01BQ19BRERS
RVNTX0lNWD47DQo+IA0KPiAgICogYW5kIHRoZW4gdGhlIGRlY29kZXIgaXMgcGxhY2VkIGludG8g
c29tZSBnZW5lcmljIGxvY2F0aW9uLCBlLmcuDQo+ICAgIGRyaXZlcnMvbnZtZW0vZW5jb2Rpbmdz
LmMgZm9yIExpbnV4DQo+IA0KPiBUaGF0IHdheSwgd2UgY2FuIHJldXNlIHRoaXMgYW5kIGZ1dHVy
ZSBlbmNvZGluZ3MgYWNyb3NzIG52bWVtIHByb3ZpZGVycy4NCj4gSXQncyBhbHNvIG1vcmUgZXh0
ZW5kYWJsZTogZS5nLiBiaWcgZW5kaWFuIGZpZWxkcyBvbiBFRVBST01zLiBKdXN0IHN0aWNrIHRo
ZQ0KPiBjZWxsLXR5cGUgaW4sIGRvY3VtZW50IGl0IGluIHRoZSBiaW5kaW5nIGFuZCBkcml2ZXJz
IHN1cHBvcnRpbmcgaXQgd2lsbCBpbnRlcnByZXQNCj4gYnl0ZXMgYXBwcm9wcmlhdGVseS4NCj4g
DQo+IEl0J3Mgc3RpbGwgYSBnb29kIGlkZWEgdG8gcmVjb3JkIHRoZSB0eXBlIGFzIHdlbGwgYXMg
dGhlIGVuY29kaW5nLCBlLmcuIHNwbGl0IHRoZSAzMg0KPiBiaXQgZW5jb2RpbmcgY29uc3RhbnQg
aW50byB0d28gMTYtYml0IHZhbHVlcy4NCj4gT25lIGlzIGFuIGVudW0gb2YgcG9zc2libGUgdHlw
ZXMgKHVua25vd24sIG1hY19hZGRyZXNzLCBJUCBhZGRyZXNzIC4uLiBldGMuKQ0KPiBhbmQgb25l
IGlzIGFuIGVudW0gb2YgdGhlIGF2YWlsYWJsZSBlbmNvZGluZ3MuDQo+IA0KPiBXaGF0IGRvIHlv
dSB0aGluaz8NCg0KR28gdGhyb3VnaCB0aGUgdGhyZWFkIHlvdSBkaXNjdXNzZWQgd2l0aCBTcmlu
aXZhcywgYXMgd2UgZGlzY3Vzc2VkIGJlZm9yZSwgd2UgcHJlZmVyIHRvIG9mZmxvYWQgdGhpcyBk
ZWNvZGluZyB0bw0Kc3BlY2lmaWMgbnZtZW0gcHJvdmlkZXIgZHJpdmVyLCBpbnN0ZWFkIG9mIG52
bWVtIGNvcmUuIA0KDQpCZXN0IFJlZ2FyZHMsDQpKb2FraW0gWmhhbmcNCg==
