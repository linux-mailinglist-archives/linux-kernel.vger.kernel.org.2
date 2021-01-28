Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA6F307664
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 13:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbhA1Muf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 07:50:35 -0500
Received: from mail-eopbgr130072.outbound.protection.outlook.com ([40.107.13.72]:31365
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229852AbhA1Mub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 07:50:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvkeEyJ97QT16Vqle61FAkFtWLKMUEju+9c1fZWVsQ9wHXg6YKUFmR+DjDs9bJDotvHziJi/RBJp7SSV9tY1CppDyt4xeO1M7XmZBm+KGb7kyhHoWkbc7DCadRhPYyipkfclLQwrqxhS3l8D8LUenfY98zbEoFufkHncp2kKu4MWb8YpIBxvI5JfkpaUXBMc+5cuq8cNjYDMtHKtl3VCMffC0v9PCvhWiOiUN/1vNjyrhzYALYQWYSYnNuGKVXpKIfCOonrp/e1U5AiZwpyGy8l953tzhYOK2YHIeQMtzSopIlIwJiInUSXOa9rz/okYjlJ8foxviX61CcRwfQ2HSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCuMX2qWn64+aYs0jv/SAXMxATxvmz5N9RtWLaWzyf4=;
 b=ZcKlGSiUDbcHjXhCxQmVx3H6Wwwad66KSQlD9TSrEKM0cjwi8uJomjDaPbBY+QBaF0Vn6AVD47pJQlrKQHoHX7z7vMAAwPY6SR4Or9nSPOyXdcuDhWSImSd9bzniGndd9N1BkNvd8jRQtE3lyyu2ozJzvh/4Do2VLTZ48J2MwINBtyGI2wFixy8aniX6YVgDv+5UcShZwD4HA1Q7BDS+NMcusIpmP+raHjHF0dPuH5jGkEQpkZ7f6ydBFqELNOEnMBCoM3eKPg89TFoWB6MQ7axQhcbKSwKnV3heXXzP3ur1gBWC0oLwZEYBFXAvNZf3HSTPQjNI65fiIQiW1MC8eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCuMX2qWn64+aYs0jv/SAXMxATxvmz5N9RtWLaWzyf4=;
 b=e0z3VlfR7AM7Md21OHjz0YDoIRTLpoX+d62JmxWdDdTGrX1mJYhEEqZKMA5a2f6s1hH0C68mSbi2gl6OYRtVj0SMA+ocRfIE+XB8toexyGydX2QUbqiRbBJ/5Q5TEZJmbi8bWcWbE5ddUseVIwiUoll4RoYNjU0HOMFYCwJ57tQ=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR0302MB2762.eurprd03.prod.outlook.com (2603:10a6:3:ef::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.13; Thu, 28 Jan 2021 12:49:40 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::d109:2683:5f4d:1f55]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::d109:2683:5f4d:1f55%5]) with mapi id 15.20.3784.019; Thu, 28 Jan 2021
 12:49:39 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "angelogioacchino.delregno@somainline.org" 
        <angelogioacchino.delregno@somainline.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: short-circuit and over-current IRQs
Thread-Topic: short-circuit and over-current IRQs
Thread-Index: AQHW9KQ1CReIG2nvY02SR0F15Vfw3Ko7ZkqAgAAjj72AACDTAIABGmaAgAAuvICAAAr8AA==
Date:   Thu, 28 Jan 2021 12:49:39 +0000
Message-ID: <a399137345cebc850e5d38886a33f42af4a9c434.camel@fi.rohmeurope.com>
References: <6046836e22b8252983f08d5621c35ececb97820d.camel@fi.rohmeurope.com>
         <20210127122733.GC4387@sirena.org.uk>
         <6d60af3516161bd04332cd60b50aa4becf92e17a.camel@fi.rohmeurope.com>
         <c10cf8d6-f36a-60f4-93cc-807e11a7cec9@somainline.org>
         <20210127163218.GD4387@sirena.org.uk>
         <5bf8b75f3a2f9db5fc200a9418ece5dfa2f91ab5.camel@fi.rohmeurope.com>
         <20210128121019.GB4537@sirena.org.uk>
In-Reply-To: <20210128121019.GB4537@sirena.org.uk>
Reply-To: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=fi.rohmeurope.com;
x-originating-ip: [213.255.186.46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b841ff7a-a4e3-42c2-0681-08d8c38b2d49
x-ms-traffictypediagnostic: HE1PR0302MB2762:
x-microsoft-antispam-prvs: <HE1PR0302MB2762CB34D78CBBC2D42868C6ADBA9@HE1PR0302MB2762.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Aun8lSE2eroDIu8vlN1v2VwptN3jbNx06BQRgSt2L2T93qkwpv88+YiYf+59Hr5BfibkWgIl7mFmLkYDXbM/zfhDx+cSuvg/nImgaoqjRuDyvwedhL+CFmV+c4mVKvyYMa5XRVfVx1cMt413dCxw/lzunjAALDJB1Jto7vRCWskG/pKqP4GMHGRGS8YDmEHqqVIg+7i6rk8ei31SeCuwQypmcGY7f9r3oyV5gVlo9g8WD+O4YRXkPxd0s/PTm4adtRkEU+AQhzswCBdDnt7NWf6u/r27zA0dcnwbm+HeUQFWMll0CqVDFOvkxj6Xy4+NGhEDoTS2z+ynxg23yVT/KCqCtm7TA8X7nf0opRzz0MJLVKeRKZgIYSg2uYAR7839zHT+AJDExZ4fTa/HCSJ8PImFEcvzXYYIo146v6cq9SkNCwNXu2i/NoiRVS7HZQ/zobUrTyHlsvY1rRUJ4BvCYYubVEZ7rsxLY1vPR1J49nADEDkU7pKVQDZ1qy2z/KGnZ+YODzH1HfYwDUlV96Jumw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(376002)(39840400004)(136003)(8936002)(71200400001)(8676002)(5660300002)(3480700007)(478600001)(2906002)(316002)(6916009)(83380400001)(66446008)(86362001)(2616005)(4326008)(186003)(26005)(3450700001)(76116006)(66946007)(6486002)(6506007)(66476007)(66556008)(6512007)(54906003)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UElPYXdNY0xReGpNTGZjOWl4M0VaVTUxbEROdmY3OWtXRVpHdzdVMzM3Rmtl?=
 =?utf-8?B?TGlqK2EweHVxejVwZXZqNEdrTndaUS9lQzhBMWJJMmVkR25UTjVaSjlYN2Q5?=
 =?utf-8?B?R2lveTQ1aEJwSzdtOU5hY1lHd3pQUTF1S0RVbDJOamt3YjJnemt4UXg5OTNO?=
 =?utf-8?B?VFFHL3Q3NWhrUm1hb0VmdlM2M29pY2JaRE4vM3BTYmFxd0Jxakc5MkdsYTVK?=
 =?utf-8?B?OU5kSXQrNVJkNmVTTFp1Z1FleTltNHo0WWhXRGx1UGFudllBRE1LZGlBOWJR?=
 =?utf-8?B?V1BlMlNUU3krMUxESWxlcitQWjNKNzhEY2Z3ZU1JT1hDWWVHaS82ZlJmMklx?=
 =?utf-8?B?OU4yL1NHZDd6QkNnNnhQY1UvUjYyd3h0NVlORjFnNmUxZ0pPSnRSVU1KZzAv?=
 =?utf-8?B?SzZUdDNVVTVDazNHU0UwYktkQmUxNjNYWkdoc25JRm1hZC9PUTA0OVZVOHNX?=
 =?utf-8?B?MHB4N2dJTVJnWGRDcUlaa2VEU0NCQWNob2NleFBESUdWK3lyellOK2hWUE1u?=
 =?utf-8?B?Y2NQLzBYSkJGd1k1TVQzd2RjdkxQM0lYK2RFZnRVTVpwMCtJSjZSMG84c0Zi?=
 =?utf-8?B?dGdQb05OckY4bDF2akE4bEdnMkVZUytNNGFydjhiaDhwTnFwdkYvcmdkUHU2?=
 =?utf-8?B?a25WUTJqTjNuL3VSUzdiNGh0bUpWczFIQUVEOG9xWTRXMnVzVElVV2VMTWZ3?=
 =?utf-8?B?YXNlOTV6V2t4TmdkM1NVdkpDUU1mZ05ORnhudTJqdCtDcVpjK2FZTE5VSWI0?=
 =?utf-8?B?MWIySGUwMzFQK2VaekFyeE85eDNlRTVYU0dYakNRazkrSXU1ZE5NY0dMeCtm?=
 =?utf-8?B?Y1dpakhieVpPT3QxTFZTcmFpdDVONXBrQzZtQm5QMGlJNkxaeDU3c25sUEFw?=
 =?utf-8?B?U21JbjZLY1c2Q0loNEZPRHJVeWlHRi9tZnd6YjNMaWliSm1tWFZIMzR6cnVp?=
 =?utf-8?B?WjM5OFpmNGlCSDRQSUxnSksyN3g0ajU2YlRUM0oxakFKdVoya2oxL1lGRWlH?=
 =?utf-8?B?SlB2eWRSS2FqK2VlbVNZekNhWHEyZENJNXg2UG94L3lWNHRpcFFLWFpOc0gy?=
 =?utf-8?B?MllIZjlaS2VVdkM3NmF4NWpxR0JxQlV4aDJxU25aV1BDbzZHRFVzTHlvSmFS?=
 =?utf-8?B?ZW9CT2srZENrUEI4MXlpa1JianFqL2YxaktsNmlOV0lHL0FVTjhmWFg2YWZJ?=
 =?utf-8?B?NzZFS204NnpneER0MklHOXQ1L2hEQmlEMCsrT1doVVU5MWNOWVE2UFY0OUtt?=
 =?utf-8?B?UUlWRGlFMlp4VkR3cmpWazFhR0E2NE15UXoyQ01Ldm9EMDhiczJObFY4UFdU?=
 =?utf-8?B?UUhWaVNzTkViTGlyNVJSTytsaERqbUNCYU03a2xkZjkzcW4yTWNUaWF0UmJP?=
 =?utf-8?B?RVZCR09ZaTVUSjRJeHYyK29PRzRhdDRoclZNcndoVWQwMzJLdjE0MENWWk1L?=
 =?utf-8?B?d3Nod1B5ek9uV3hLUXl6b2h3aXUvN1R0TXg5MjF3PT0=?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C9335EFDD163141A442E9F4E8D7B903@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b841ff7a-a4e3-42c2-0681-08d8c38b2d49
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2021 12:49:39.7707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HfSFd4H/WfcxI1z073a8TZJIiLfpjawueL2wXmocdYGFOcXm4xMAKLjCsTtqiEx1y7L1OUW+H8h624uudvmO1aZ8F+aeN9ILsOX88stpP9U2daho4qae2OmM9cMxHjYt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0302MB2762
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBUaHUsIDIwMjEtMDEtMjggYXQgMTI6MTAgKzAwMDAsIE1hcmsgQnJvd24gd3JvdGU6DQo+
IE9uIFRodSwgSmFuIDI4LCAyMDIxIGF0IDA5OjIzOjA4QU0gKzAwMDAsIFZhaXR0aW5lbiwgTWF0
dGkgd3JvdGU6DQo+ID4gT24gV2VkLCAyMDIxLTAxLTI3IGF0IDE2OjMyICswMDAwLCBNYXJrIEJy
b3duIHdyb3RlOg0KPiA+ID4gTm90ZSB0aGF0IHRoZSBldmVudHMgdGhlIEFQSSBjdXJyZW50bHkg
aGFzIGFyZSBleHBlY3RlZCB0byBiZSBmb3INCj4gPiA+IHRoZQ0KPiA+ID4gYWN0dWFsIGVycm9y
IGNvbmRpdGlvbnMsIG5vdCBmb3IgdGhlIHdhcm5pbmcgb25lcyAtIGluZGljYXRpbmcNCj4gPiA+
IHRoYXQNCj4gPiA+IHRoZQ0KPiA+ID4gdm9sdGFnZSBpcyBvdXQgb2YgcmVndWxhdGlvbiBmb3Ig
ZXhhbXBsZS4NCj4gPiBJIGFtIHVuc3VyZSBob3cgdG8gaW50ZXJwcmV0IHRoaXMuIFdoYXQgaXMg
dGhlIGNyaXRlcmlhIG9mIGlzc3VlDQo+ID4gYmVpbmcNCj4gPiBhbiBlcnJvci93YXJuaW5nLiBX
aGVuIEkgd2FzIHRhbGtpbmcgYWJvdXQgd2FybmluZyBJIG1lYW50IHRoYXQgdGhlDQo+ID4gaXNz
dWUgd2hpY2ggaXMgZGV0ZWN0ZWQgaXMgdW5leHBlY3RlZCBhbmQgYWJub3JtYWwgKGVycm9yPykg
LSBidXQNCj4gPiBtaWdodA0KPiA+IHN0aWxsIGJlIHJlY292ZXJhYmxlICh3YXJuaW5nPykuIEkg
dW5kZXJzdGFuZCB0aGUgcmVndWxhdG9yDQo+ID4gZnJhbWV3b3JrDQo+ID4gbXVzdCBub3Qgc2ln
bmFsIHNhbWUgZXZlbnRzIGZvciBkaWZmZXJlbnQgcHVycG9zZXMgLSBidXQgSSBkb24ndA0KPiA+
IHJlYWxseQ0KPiA+IGtub3cgd2hhdCB0aGUgY3VycmVudCBldmVudHMgYXJlIHVzZWQgZm9yIC0g
SSBhbSBncmF0ZWZ1bCBmb3IgYW55DQo+ID4gZ3VpZGFuY2UhDQo+IA0KPiBXaGF0IHRoZSBtYWpv
cml0eSBvZiBoYXJkd2FyZSBpbnRlcnJ1cHRzIG9uIGlzIHNpdHVhdGlvbnMgd2hlcmUNCj4gdGhp
bmdzDQo+IGhhdmUgYWxyZWFkeSBnb25lIG91dCBvZiBzcGVjIGFuZCB0aGVyZSBhcmUgYWN0dWFs
IHByb2JsZW1zIHdpdGggdGhlDQo+IG91dHB1dCAtIGZvciBleGFtcGxlIHdpdGggY3VycmVudCBs
aW1pdGluZyB0aGVyZSdzIG9mdGVuIGFuIGFjdHVhbA0KPiBsaW1pdGVyIGluIHRoZXJlIHNvIHRo
ZSByZWd1bGF0b3Igc2ltcGx5IHdvbid0IHN1cHBseSBhbnkgbW9yZQ0KPiBjdXJyZW50DQo+IHRo
YW4gaXMgY29uZmlndXJlZC4gIFdpdGggYSB3YXJuaW5nIGV2ZXJ5dGhpbmcgaXMgc3RpbGwgd29y
a2luZyBmaW5lDQo+IGJ1dA0KPiBnZXR0aW5nIGNsb3NlIHRvIG5vdCBkb2luZyBzby4NCg0KU291
bmRzIHJlYXNvbmFibGUuIFdhcm5pbmcgd2hpbGUgdGhpbmdzIGFyZSBzdGlsbCB3b3JraW5nIC0g
YnV0IGFyZQ0KZ2V0dGluZyB0byB0aGUgYm91bmRhcnkuIEVycm9yIHdoZW4gdGhpbmdzIGFyZSBh
bHJlYWR5IHByZXR0eSB3cm9uZy4NClRoYW5rcy4NCg0KPiA+ID4gV2VsbCwgaWYgdGhlc2UgdGhp
bmdzIGFyZSBraWNraW5nIGluIHRoZSBoYXJkd2FyZSBpcyBpbiBzZXJpb3VzDQo+ID4gPiB0cm91
YmxlDQo+ID4gPiBhbnl3YXkgc28gaXQncyB1bmNsZWFyIHdoYXQgdGhlIHN5c3RlbSB3b3VsZCBi
ZSBsaWtlbHkgdG8gZG8gaW4NCj4gPiA+IHNvZnR3YXJlLCBhbmQgYWxzbyB1bmNsZWFyIGhvdyBz
YWZlIGl0IGlzIHRvIHJlbHkgb24gc29mdHdhcmUgdG8NCj4gPiA+IGJlDQo+ID4gPiBhYmxlDQo+
ID4gPiB0byB0YWtlIHRoYXQgYWN0aW9uIGdpdmVuIHRoYXQgaXQgbGV0IHRoaW5ncyBnZXQgaW50
byBzdWNoIGEgYmFkDQo+ID4gPiBzdGF0ZQ0KPiA+ID4gaW4gdGhlIGZpcnN0IHBsYWNlLg0KPiA+
IEFjdHVhbGx5LCBiZWFyIHdpdGggbWUgYnV0IEkgYW0gdW5zdXJlIHdoeSB3ZSBoYXZlIHRoZXNl
DQo+ID4gbm90aWZpY2F0aW9ucw0KPiA+IGlmIHdlIGRvbid0IGV4cGVjdCBTVyB0byBiZSBhYmxl
IHRvIGRvIGFueXRoaW5nPyBXb3VsZG4ndCB0aGUgcGFuaWMNCj4gPiBwcmludCBiZSBhbGwgdGhh
dCBpcyBuZWVkZWQgdGhlbj8gSSB0aGluayB0aGF0IHNldHVwcyB3aGljaCBoYXZlDQo+ID4gZHVh
bA0KPiANCj4gWW91J2xsIG5vdGljZSB0aGF0IHRoZXJlIGFyZW4ndCBhbnkgYWN0dWFsIHVzZXJz
IG9mIHRoaXMgc3R1ZmYgaW4NCj4gdHJlZQ0KPiBhdCB0aGUgbWludXRlIC0gcGVvcGxlIGRvbid0
IGdlbmVyYWxseSBwdXQgbXVjaCBlZmZvcnQgaW50byBzb2Z0d2FyZQ0KPiByZWNvdmVyeSBhcyB0
aGV5J3JlIG5vdCBleHBlY3RpbmcgdG8gYmUgYW55d2hlcmUgbmVhciBsaW1pdGluZyBpbg0KPiBu
b3JtYWwNCj4gb3BlcmF0aW9uLiAgV2hhdCBJJ2QgZXhwZWN0IHBlb3BsZSB0byBkbyB3aGVyZSB0
aGV5IGRvIGltcGxlbWVudA0KPiBoYW5kbGluZyBpcyBzb21ldGhpbmcgbGlrZSBzaHV0dGluZyBk
b3duIGFsbCBvdGhlciBzdXBwbGllcyBvbiB0aGUNCj4gZGV2aWNlLCBwb3NzaWJseSBhbHNvIHRy
eWluZyB0byBzaHV0IGRvd24gdGhlIHN5c3RlbSBhcyBhDQo+IHdob2xlLiAgVGhpbmdzDQo+IG1v
cmUgYWJvdXQgcHJldmVudGluZyBwaHlzaWNhbCBkYW1hZ2UgcmF0aGVyIHRoYW4gYmVpbmcgcGFy
dCBvZiB0aGUNCj4gbm9ybWFsIG9wZXJhdGlvbiBvZiB0aGUgc3lzdGVtLg0KDQpBZ2FpbiB0aGlz
IG1ha2VzIHNlbnNlLiBJIHdpbGwgdHJ5IHRvIGFzayBmb3JtIEhXIGNvbGxlYWd1ZXMgd2hhdCB0
aGV5DQp0aG91Z2h0IHRvIGJlIHRoZSBhY3Rpb24gU1cgdGFrZSAoSSBob3BlIHRoZXkgaGF2ZSBz
b21lIHNjZW5hcmlvIG9uDQptaW5kIC0gbGV0J3Mgc2VlKS4gSWYgdGhleSB0ZWxsIG1lIHRoYXQg
dGhleSBleHBlY3QgU1cgdG8gc2h1dCBkb3duDQpzeXN0ZW0gZ3JhY2VmdWxseSAtIHRoZW4gSSBr
ZWVwIGVycm9ycywgaWYgdGhleSB0ZWxsIG1lIHRoZXkgdGhpbmsgU1cNCndpbGwgdGVtcG9yYXJp
bHkgZGlzYWJsZSBzb21lIEhXIGJsb2NrcyBvciBkbyBvdGhlciAidHJpY2tzIiBhbmQgbGF0ZXIN
CnJlc3VtZSBub3JtYWwgb3BlcmF0aW9uIC0gdGhlbiBJIHdpbGwgc2VlIGlmIEkgY2FuIGFkZCBz
b21lIG5ldw0KJ3dhcm5pbmcnIGluZGljYXRvcnMuDQoNCj4gRm9yIHRoZXJtYWwgaXNzdWVzIHN5
c3RlbXMgZ2VuZXJhbGx5IHRyeSB0byBhcHBseSBzb2Z0d2FyZSBsaW1pdHMNCj4gd2VsbA0KPiBi
ZWZvcmUgYW4gaW5kaXZpZHVhbCBjb21wb25lbnQgc3RhcnRzIGZsYWdnaW5nIHRoaW5ncyB1cCB3
aXRoIGFuDQo+IGludGVycnVwdCwgdGhlIGxpbWl0cyB0aGF0IGRldmljZXMgaGF2ZSBhcmUgZ2Vu
ZXJhbGx5IHN1cGVyIGhpZ2ggYW5kDQo+IG9mdGVuIHRoZXJlJ2xsIGJlIGlzc3VlcyBhdCBhIHN5
c3RlbSBsZXZlbCAoZWcsIGEgY2FzZSBnZXR0aW5nDQo+IHVudXNhYmx5DQo+IGhvdCkgZWFybGll
ciBhbmQgaXQgY2FuIHRha2UgYSB3aGlsZSBmb3IgcmVzcG9uc2VzIHRvIGhhdmUgYW4gaW1wYWN0
Lg0KDQpJIHRoaW5rIHRoaXMgaXMgYWxzbyBjYXNlIHdpdGggdGhlIEJEOTU3NiAtIDE0MCBDIHNv
dW5kcyBwcmV0dHkgaG90IHRvDQptZSAtIGFuZCBJIGV4cGVjdCB0aGlzIGlzIHJlYWxseSB3aGVy
ZSB0aGluZ3MgYXJlIGFscmVhZHkgYmFkbHkgd3JvbmcuDQpTbyBJIGd1ZXNzIEkgY2FuIGtlZXAg
dGhlICdlcnJvcicgaGVyZS4NCg0KPiANCj4gPiBsaW1pdHMgKG9uZSBmb3IgaW5pdGlhdGluZyBw
b3RlbnRpYWwgU1cgcmVjb3ZlcnkgLSBvdGhlciBmb3IgSFcgdG8NCj4gPiBmb3JjaW5nIHByb3Rl
Y3Rpb24pIGFjdHVhbGx5IG1ha2Ugc2Vuc2UuIFNvIGRvZXMgaW1wbGVtZW50aW5nDQo+ID4gbm90
aWZpZXJzDQo+ID4gLyBlcnJvciBzdGF0dXNlcyBmb3IgZXZlbnRzIHdoZXJlIFNXIHJlY292ZXJ5
IGlzIHBvdGVudGlhbGx5DQo+ID4gaGVscGZ1bC4NCj4gPiBCdXQgd2hldGhlciB0aGUgZXhpc3Rp
bmcgZXZlbnQgbm90aWZpY2F0aW9ucyAvIGVycm9yIGZsYWdzIGFyZQ0KPiA+IGNvcnJlY3QNCj4g
PiBmb3IgdGhlc2UgaXMgc29tZXRoaW5nIEkgY2FuJ3QgZGVjaWRlIDopIEhlcmUgSSBhc2sgZ3Vp
ZGFuY2UgZm9yDQo+ID4gTWFyayAmDQo+ID4gb3RoZXJzIHdobyBrbm93IHdoYXQgaXMgdGhlIGlk
ZWEgYmVoaW5kIGV4aXN0aW5nIGVycm9yLQ0KPiA+IGZsYWdzL2V2ZW50cy4NCj4gDQo+IEl0J3Mg
bm90IHRoYXQgd2Ugc2hvdWxkbid0IGltcGxlbWVudCBzdXBwb3J0IGZvciB3YXJuaW5ncywgaXQn
cyB0aGF0DQo+IHRoZXkncmUgbm90IHRoZSBjb21tb24gY2FzZSBmb3IgaGFyZHdhcmUgYW5kIHNv
IHdvbid0IGxpbmUgdXAgd2l0aA0KPiBiZWhhdmlvdXIgZm9yIG90aGVyIHVzZXJzLg0KDQoNCkFn
cmVlZC4gQXMgSSBzYWlkLCBJIHVuZGVyc3RhbmQgd2Ugc2hvdWxkbid0IHNlbmQgc2FtZSBldmVu
dHMgdG8NCmRpZmZlcmVudCBzaXR1YXRpb25zLiBJZiBjdXJyZW50IGVycm9ycyBhcmUgdXNlZCB0
byBpbmRpY2F0ZSB0aGluZ3MgYXJlDQpyZWFsbHkgIndyb25nIiB0byB0aGUgcG9pbnQgd2hlcmUg
c2FmZXN0IHRoaW5nIGlzIHRvIHNodXQgZG93biBzeXN0ZW0gLQ0KdGhlbiB3ZSdkIGJldHRlciBh
ZGQgdGhlc2UgIndhcm5pbmdzIiB0byBpbmRpY2F0ZSB0aGF0IHRoZXJlIHdvdWxkDQpwb3RlbnRp
YWxseSBzdGlsbCBiZSB0aW1lIHRvIGNoYW5nZSBzb21ldGhpbmcgLSBiZWZvcmUgdGhpbmdzIGFy
ZSBzaHV0DQpvZmYuDQoNClRoYW5rcyBhZ2FpbiENCg0KQmVzdCByZWdhcmRzDQoJTWF0dGkgVmFp
dHRpbmVuDQo=
