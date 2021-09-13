Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 471604083D0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 07:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbhIMFdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 01:33:07 -0400
Received: from mail-eopbgr1310097.outbound.protection.outlook.com ([40.107.131.97]:63264
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229563AbhIMFdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 01:33:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CTWU32DIje7Gm/aYaCOgll3r/n2whkz8SVgf5jf6l6nw8rriZVdRqMFNdB8Adh/7tXRQOL6uP51Zw0n81M4FtCIeiwzUeWKjFzUUiSmazhr3G3jsDPY41ZCakqihcOm9ZmOUXDzNiN6SQ0GreoVrZ7lOj0wIYTDqUXismlmW4DPjnSKh8u8YNESjMCkdVg7QZqJ2TBc8RGQJ/GHH20kyzuTruX8i23HSJwPsuLM7iG3IiQA8Sz2e00cAQbDnsuzPeCxOhW7lWQUdcX2sjXThs5hsnzcSQ9TvoLrA/NprxhGVdHzYmHISfAoBZzqzDHGowubRDTpQNYhj2Py5sPl4DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=CXicEieTN2vduieaLtrMOicPqmFp7xIpd0cfQVanOBU=;
 b=h5YidjIDqMnSRsUYBlAse6Pv53BNoyec/tosy4ecyok9dr4l42Ha/12uOW3FAepMF/ybQdMKBjsfj4Yqh0LTF9/GVm3pRr3CO3tHgy4MbmBmsEfXBbq3QuyTh6/WTfo2QlF6tzhvuoY9lIa/zniNNRaw9xKrA33mXuDP5tooCymKRfmUbiM/zuQX30bQe7o8QYtnnuc0fmD1dcUQPLw4QsmwiQq6DQr82BLRZjSnDLNIe5ydYH1PljX+rC2YYVdbQOUMxB2MzoUJqCopfsx5w07OgbyxuhVL5Piwbjr0DdA828Infjvngnz0nn8VQ4JpMs4zlS9TByfgcIoPDwWH4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CXicEieTN2vduieaLtrMOicPqmFp7xIpd0cfQVanOBU=;
 b=P52rTAIH13so+fDvuUazwu20wApalIwTis2FdIOvtKWyvAMWW1CxmE1kzbIFOXqdqQ8K6vmfKLFtAzxj/NzpcPZ0PE2VgfM9aGtcaj4WDXiPc5Qka+KYSbnUPtRBPQemUUB9TwmepmHaxsnzN0bJ1bLCdAbm0ZQ7wBji1NqIhO6PJmWVMfN4ImNMTF+nVuioritZ63HcAUJgK3+9HNtUM7EPnW6oRwWmGoh7LR/qMLJmTXf0+4NfJiU61th91UhiGe6+qo5LEkjI1kHyZviyRNpd6Sd3RLodgqgnL7BMz3+9alJJJaWwEJG3Pjf8QTr/pXViyf126AlOBHGxzVd2rw==
Received: from HK0PR06MB3380.apcprd06.prod.outlook.com (2603:1096:203:82::18)
 by HK0PR06MB3377.apcprd06.prod.outlook.com (2603:1096:203:8b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Mon, 13 Sep
 2021 05:31:46 +0000
Received: from HK0PR06MB3380.apcprd06.prod.outlook.com
 ([fe80::df9:c3a4:7589:e812]) by HK0PR06MB3380.apcprd06.prod.outlook.com
 ([fe80::df9:c3a4:7589:e812%3]) with mapi id 15.20.4500.018; Mon, 13 Sep 2021
 05:31:46 +0000
From:   Ryan Chen <ryan_chen@aspeedtech.com>
To:     "Claudiu.Beznea@microchip.com" <Claudiu.Beznea@microchip.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCHv2] clk:aspeed:Fix AST2600 hpll calculate formula
Thread-Topic: [PATCHv2] clk:aspeed:Fix AST2600 hpll calculate formula
Thread-Index: AQHXpJKMhkZfnItOBUy/UXzlogoQrauhdqeAgAAAnqA=
Date:   Mon, 13 Sep 2021 05:31:46 +0000
Message-ID: <HK0PR06MB33806C10EB8B3F87FE144F8DF2D99@HK0PR06MB3380.apcprd06.prod.outlook.com>
References: <20210908091845.4230-1-ryan_chen@aspeedtech.com>
 <4571c9ae-0287-4f70-2adb-9c227e706736@microchip.com>
In-Reply-To: <4571c9ae-0287-4f70-2adb-9c227e706736@microchip.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: microchip.com; dkim=none (message not signed)
 header.d=none;microchip.com; dmarc=none action=none
 header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 19d9feb8-00e9-4de9-c5ed-08d97677c750
x-ms-traffictypediagnostic: HK0PR06MB3377:
x-microsoft-antispam-prvs: <HK0PR06MB33773D92B4B8D8CF0EC7A708F2D99@HK0PR06MB3377.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:293;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2BkEr59aT+0z549h+81ljE4UiIr/Kl9Kp22IM9h+FuoieXVATlV8K6GGQOZAsE6MmlVGyMPV7Fnsm8gep59zw1iqBjTv/aXXDNdn3jvk7Jbm++tBd3B19uINU0v14m7LCAVyzn+Hgl+rH4yiQKEzh90pPTTdRLRutXWGyDIjt7zmiLfyvJqJmFnq9qjMmcwYI/OmypewBRESrJJ3U5VaE6Enyp8aAUhhowfbXIBvRpZ/agS/TanaCocx/GstP+ekd5HLg36hCOlLrqdeCsTIo0qXTbWBhnKMX2IjMcGHJbpMMNdb72/nWkhttDHXI9JI3ZpNFEQ2InY6T/di8lEf/E0CTZzaY0I28gV7EAbDM/X9NxhssFmNlepKA4jgiXVRquYZRg2KiZC5Z55RVcnEAh140RlD37a65G6IQfANfvEsBfkrlk1bdRRcNbVmduyD21+LIvh6e/mEJEYVpWSlmpEwCN2RgKyeQiz78tAnfuM6px2mQ8Du5SfINHnQTgTTznBM1kybPdwdO5jGubXntHb67nwndDNdTXD1eaJnYYvwZIf4eLKiwIFKMrmgXLsFIz38wuE74gl8NhXlWoyBhrmzn4vUoIa4AJd/D+/LN4rFfeRedTtCkoxNk+fu3bx4c5eQhFyVze0jbhEPl+1idyoAYVGPWenybv3JVvy+hanEbXTplgDod2aL8Kj/ooVMslZcrgQ4CJktSvBTYH4KkA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3380.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39840400004)(366004)(376002)(346002)(396003)(9686003)(316002)(26005)(64756008)(110136005)(6506007)(66946007)(52536014)(7696005)(8936002)(66556008)(76116006)(71200400001)(66476007)(478600001)(5660300002)(2906002)(122000001)(86362001)(8676002)(66446008)(53546011)(38100700002)(55016002)(83380400001)(33656002)(38070700005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MlZPNmJnUGpmUWdiMDJ2RE93R0UzazB6WHNSNWlUQ0VKY0FZYzZsMzVHK25j?=
 =?utf-8?B?QTc4cDVlbjRybTB3aFp0dWh0eG1ZQTJwQkNKNTk0SmFqbXZlWDhnYm5FMTVx?=
 =?utf-8?B?M1lQT1BXbFRGNHJwTDQ3NUdvVTZtTHc2bDhBeHUvaHpKS0dkZDFxM1hMNHdu?=
 =?utf-8?B?UUF3R1JSZm5UeG5ZT08vazJWTG40REZ6KzhKWUZtT3F2S2lmb3hWblVrRUdI?=
 =?utf-8?B?T1MwWjQ5M2tNREFkRnB2WkNrRmxwQlZiRUVzd2tsdVV3dVA5ZWU2aVRrdDF5?=
 =?utf-8?B?WVNvNzhDREcvUVJvb0Job1NkQnNYWUN0d0ZsQlZEZmNHZW5VK1lvSktDSXkz?=
 =?utf-8?B?WkxmK0x3bWtuTWpnZHpuRFpCU1ZrK2JldVlZRnhlTXgzMXVXSU9wUnM3RmIx?=
 =?utf-8?B?cklmVkFaMTBXNjF5dU9iK044NDIybS9wSFFhMFljK0dvc3RRdUtwUVY5RVFq?=
 =?utf-8?B?TjdlUW1JZURqc1pScFIrSzY3YlJGNVE5UzRkWHBpOHMxV1FidFJoTythcTdI?=
 =?utf-8?B?UzVSaXZzaTlKakx6N09xNUxaY1dONDlQTUp3NkhYd1JVQUgvUFZPbmVXK0hD?=
 =?utf-8?B?TzI5UUEvNzhGYlgxUS9WVWxwbS9YZjRyM2I3a0gzMXloSVc5eUwrYThKejlw?=
 =?utf-8?B?bzBLZGN1QjQ1L21IdGtTZkg4ZUUyaFdrb25jUGZ4dElHNnJxdkRhbG5vc21B?=
 =?utf-8?B?Q2c5M3Y1S2c1R3hwbUM0OG9nZGUyWjFPVHJacThROE1DREVZeTRaTmRHM3NJ?=
 =?utf-8?B?UUJCeGYwUGF1cHhVR1BXRC9GUE1KYzNlUVlad3RxZkFpRXFXQ2M5RnRiNzkz?=
 =?utf-8?B?djVYUm5NaGI4Zmd4L1FjdWFXRGVrM1JkZEQ3aXJQNm80K2RTWStRVWRGVTlU?=
 =?utf-8?B?R1pyNjZpTWxnNTlxNENzUEZGMGVjNkMxZXJwTytDR1F4ZUE5UFlDZEdlOUdM?=
 =?utf-8?B?QUxycHp1K0pBbzc3aXNhakc0NElzL2ZtT3JrTTRYVGdtRVVsNXJJTGttbkxU?=
 =?utf-8?B?Q0Q2OWtXb3AxL1BnR05sL2U5UjhOMWVkYTVUSzVkd1RQNkVxQjdxdCs0QVVq?=
 =?utf-8?B?QXVHcDFMc09EQUl2bjZzbTdTU0srTFhjSG9Sa0c4SW4vRzBHdUFKL0dJMDMx?=
 =?utf-8?B?T0hMWGlsZDFwYmJDeGxBTDcyVFpramR0Q0laZXpKUCtsL2RtRjNOL3kyYVI3?=
 =?utf-8?B?VzRrMk5DMUNYV1p1RGUrV2lyWFMyTTFDb0dpV0lHMU9OUURMeHhST0dkd0N4?=
 =?utf-8?B?cm84ZW56VWFUMnRYNDlGUVBwREdmOGFkNUFXUUQyM1N2SmRoaUFxVDdXbWJO?=
 =?utf-8?B?eUFJV2gvSVNhMjlaMnVYS2lmZzNSNW1VN1JKQis2NGxlK1dOeXZMM1JCaERH?=
 =?utf-8?B?L3RSazRUSGRmU0s2SmpvNWhrMXk5V202N3dhYTY4YVBGUWZtQWhEcnEwOVNk?=
 =?utf-8?B?Y01Rd1UwZ0RJSlcwYXdHZnJlSlNsZXRRSXRQamxtV2Y0WlBmcy85cmcreW5n?=
 =?utf-8?B?SXJTMDVjWkp2d0w2VHpBTDdKdVVGeE14aDY1czh1S1dncFpJVzVFZzlKUVMx?=
 =?utf-8?B?WkVOMkFwaUxubWdCOHdRS2EzRGpBalFpSThMS1FxOWpXR0pieHdHOE96V3JY?=
 =?utf-8?B?TmY5NTA0Z2FoNEJVNXc2dG9PY0Y2TjZsRWZGM01KV1BKS2RTblhtL0xLNmZ0?=
 =?utf-8?B?MGRaOTVPSDlWcVB3ZUljZ2RtYmYydXZ6MUQxNFpVMER1K3lYdjFYSnhXMFVO?=
 =?utf-8?Q?59Tcsy5I87yNLFVbQ34xL2ThwPQ9BjYUusGfYp4?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3380.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19d9feb8-00e9-4de9-c5ed-08d97677c750
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2021 05:31:46.4642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uvZi2bmynDB8B25ukhyHBQBJ3T7p3ByNF0XZbXDjimnkBcj0hVjYi02SaRciVAls7Wov+jYGBhpbPwfVO22/LEXDC2eF/EVhfleRtCKZ+6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB3377
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDbGF1ZGl1LkJlem5lYUBtaWNy
b2NoaXAuY29tIDxDbGF1ZGl1LkJlem5lYUBtaWNyb2NoaXAuY29tPg0KPiBTZW50OiBNb25kYXks
IFNlcHRlbWJlciAxMywgMjAyMSAxOjI2IFBNDQo+IFRvOiBSeWFuIENoZW4gPHJ5YW5fY2hlbkBh
c3BlZWR0ZWNoLmNvbT47IG10dXJxdWV0dGVAYmF5bGlicmUuY29tOw0KPiBzYm95ZEBrZXJuZWwu
b3JnOyBqb2VsQGptcy5pZC5hdTsgYW5kcmV3QGFqLmlkLmF1OyBsaW51eC1jbGtAdmdlci5rZXJu
ZWwub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0h2Ml0gY2xrOmFzcGVlZDpGaXggQVNUMjYwMCBocGxsIGNhbGN1bGF0ZSBmb3JtdWxhDQo+
IA0KPiBPbiAwOC4wOS4yMDIxIDEyOjE4LCBSeWFuIENoZW4gd3JvdGU6DQo+ID4gRVhURVJOQUwg
RU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Ug
a25vdw0KPiA+IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gPg0KPiA+IEFTVDI2MDAgSFBMTCBjYWxj
dWxhdGUgZm9ybXVsYSBbU0NVMjAwXSBIUExMIE51bWVyYXRvcihNKTogaGF2ZSBmaXhlZA0KPiA+
IHZhbHVlIGRlcGVuZCBvbiBTQ1Ugc3RyYXAuDQo+ID4gTSA9IFNDVTUwMFsxMF0gPyAweDVGIDog
U0NVNTAwWzhdID8gMHhCRiA6IFNDVTIwMFsxMjowXQ0KPiA+DQo+ID4gaWYgU0NVNTAwWzEwXSA9
IDEsIE09MHg1Ri4NCj4gPiBlbHNlIGlmIFNDVTUwMFsxMF09MCAmIFNDVTUwMFs4XT0xLCBNPTB4
QkYuDQo+ID4gb3RoZXJzIChTQ1U1MTBbMTBdPTAgYW5kIFNDVTUxMFs4XT0wKQ0KPiA+IGRlcGVu
ZCBvbiBTQ1UyMDBbMTI6MF0gKGRlZmF1bHQgMHg4RikgcmVnaXN0ZXIgc2V0dGluZy4NCj4gPg0K
PiA+IEhQTEwgRGVudW1lcmF0b3IgKE4pID0gIFNDVTIwMFsxODoxM10gKGRlZmF1bHQgMHgyKQ0K
PiA+IEhQTEwgRGl2aWRlciAoUCkgICAgICAgICA9ICAgICAgU0NVMjAwWzIyOjE5XSAoZGVmYXVs
dCAweDApDQo+ID4NCj4gPiBGaXhlczogZDNkMDRmNmMzMzBhICgiY2xrOiBBZGQgc3VwcG9ydCBm
b3IgQVNUMjYwMCBTb0MiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IFJ5YW4gQ2hlbiA8cnlhbl9jaGVu
QGFzcGVlZHRlY2guY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2Nsay9jbGstYXN0MjYwMC5j
IHwgMjkgKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDI4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2Nsay9jbGstYXN0MjYwMC5jIGIvZHJpdmVycy9jbGsvY2xrLWFzdDI2MDAuYw0KPiA+
IGluZGV4IDA4NWQwYTE4YjJiNi4uNWQ4YzQ2YmNmMjM3IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZl
cnMvY2xrL2Nsay1hc3QyNjAwLmMNCj4gPiArKysgYi9kcml2ZXJzL2Nsay9jbGstYXN0MjYwMC5j
DQo+ID4gQEAgLTE2OSw2ICsxNjksMzMgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBjbGtfZGl2X3Rh
YmxlDQo+ID4gYXN0MjYwMF9kaXZfdGFibGVbXSA9IHsgIH07DQo+ID4NCj4gPiAgLyogRm9yIGhw
bGwvZHBsbC9lcGxsL21wbGwgKi8NCj4gPiArc3RhdGljIHN0cnVjdCBjbGtfaHcgKmFzdDI2MDBf
Y2FsY19ocGxsKGNvbnN0IGNoYXIgKm5hbWUsIHUzMiB2YWwpIHsNCj4gPiArICAgICAgIHVuc2ln
bmVkIGludCBtdWx0LCBkaXY7DQo+ID4gKyAgICAgICB1MzIgaHdzdHJhcCA9IHJlYWRsKHNjdV9n
Nl9iYXNlICsgQVNQRUVEX0c2X1NUUkFQMSk7DQo+ID4gKw0KPiA+ICsgICAgICAgaWYgKHZhbCAm
IEJJVCgyNCkpIHsNCj4gPiArICAgICAgICAgICAgICAgLyogUGFzcyB0aHJvdWdoIG1vZGUgKi8N
Cj4gPiArICAgICAgICAgICAgICAgbXVsdCA9IGRpdiA9IDE7DQo+ID4gKyAgICAgICB9IGVsc2Ug
ew0KPiA+ICsgICAgICAgICAgICAgICAvKiBGID0gMjVNaHogKiBbKE0gKyAyKSAvIChuICsgMSld
IC8gKHAgKyAxKSAqLw0KPiA+ICsgICAgICAgICAgICAgICB1MzIgbSA9IHZhbCAgJiAweDFmZmY7
DQo+ID4gKyAgICAgICAgICAgICAgIHUzMiBuID0gKHZhbCA+PiAxMykgJiAweDNmOw0KPiA+ICsg
ICAgICAgICAgICAgICB1MzIgcCA9ICh2YWwgPj4gMTkpICYgMHhmOw0KPiA+ICsNCj4gPiArICAg
ICAgICAgICAgICAgaWYgKGh3c3RyYXAgJiBCSVQoMTApKQ0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgIG0gPSAweDVGOw0KPiA+ICsgICAgICAgICAgICAgICBlbHNlIHsNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICBpZiAoaHdzdHJhcCAmIEJJVCg4KSkNCj4gDQo+IFlvdSBtYXkgd3Jp
dGUgaXQgZGlyZWN0bHk6DQo+IAkJICBlbHNlIGlmIChod3N0cmFwICYgQklUKDgpKQ0KPiANCkhl
bGxvLA0KCUxpa2UgSSBjb21taXQgbWVzc2FnZSBNID0gU0NVNTAwWzEwXSA/IDB4NUYgOiBTQ1U1
MDBbOF0gPyAweEJGIDogU0NVMjAwWzEyOjBdDQoJaXQgbmVlZCBrZWVwIGZyb20gcmVnaXN0ZXIg
cmVhZCwgaWYgQklUKDgpL0JJVCgxMCkgbm90IDEuDQoJDQoNCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIG0gPSAweEJGOw0KPiA+ICsgICAgICAgICAgICAgICB9DQo+ID4gKyAg
ICAgICAgICAgICAgIG11bHQgPSAobSArIDEpIC8gKG4gKyAxKTsNCj4gPiArICAgICAgICAgICAg
ICAgZGl2ID0gKHAgKyAxKTsNCj4gPiArICAgICAgIH0NCj4gPiArICAgICAgIHJldHVybiBjbGtf
aHdfcmVnaXN0ZXJfZml4ZWRfZmFjdG9yKE5VTEwsIG5hbWUsICJjbGtpbiIsIDAsDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgbXVsdCwgZGl2KTsNCj4gPiArfTsNCj4gPiArDQo+ID4gIHN0
YXRpYyBzdHJ1Y3QgY2xrX2h3ICphc3QyNjAwX2NhbGNfcGxsKGNvbnN0IGNoYXIgKm5hbWUsIHUz
MiB2YWwpICB7DQo+ID4gICAgICAgICB1bnNpZ25lZCBpbnQgbXVsdCwgZGl2Ow0KPiA+IEBAIC03
MTYsNyArNzQzLDcgQEAgc3RhdGljIHZvaWQgX19pbml0IGFzcGVlZF9nNl9jYyhzdHJ1Y3QgcmVn
bWFwDQo+ICptYXApDQo+ID4gICAgICAgICAgKiBhbmQgd2UgYXNzdW1lIHRoYXQgaXQgaXMgZW5h
YmxlZA0KPiA+ICAgICAgICAgICovDQo+ID4gICAgICAgICByZWdtYXBfcmVhZChtYXAsIEFTUEVF
RF9IUExMX1BBUkFNLCAmdmFsKTsNCj4gPiAtICAgICAgIGFzcGVlZF9nNl9jbGtfZGF0YS0+aHdz
W0FTUEVFRF9DTEtfSFBMTF0gPQ0KPiBhc3QyNjAwX2NhbGNfcGxsKCJocGxsIiwgdmFsKTsNCj4g
PiArICAgICAgIGFzcGVlZF9nNl9jbGtfZGF0YS0+aHdzW0FTUEVFRF9DTEtfSFBMTF0gPQ0KPiA+
ICsgYXN0MjYwMF9jYWxjX2hwbGwoImhwbGwiLCB2YWwpOw0KPiA+DQo+ID4gICAgICAgICByZWdt
YXBfcmVhZChtYXAsIEFTUEVFRF9NUExMX1BBUkFNLCAmdmFsKTsNCj4gPiAgICAgICAgIGFzcGVl
ZF9nNl9jbGtfZGF0YS0+aHdzW0FTUEVFRF9DTEtfTVBMTF0gPQ0KPiA+IGFzdDI2MDBfY2FsY19w
bGwoIm1wbGwiLCB2YWwpOw0KPiA+IC0tDQo+ID4gMi4xNy4xDQo+ID4NCg0K
