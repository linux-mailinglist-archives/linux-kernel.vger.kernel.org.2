Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27769455F23
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 16:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbhKRPRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 10:17:09 -0500
Received: from mail-eopbgr00058.outbound.protection.outlook.com ([40.107.0.58]:6210
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229583AbhKRPRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 10:17:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l49sI9aUxs7W208JjF6uvDWsgo3FNLAYFiXL0XwDo2OZ0bKYZP4LXI1YhF8yHk6OLNLvhLPxoe+HrlnkXpAaoL76hdgSyLQrCFkEXVyOiUXQsWkc6jHbNgRNE7MugJmRt5kkPw+VaY4Bj1yRsBCoMSmZ5mwMJuXTMcNxgMPD+vk0UZ4lHzlH1ncovjz1xY6vRgNp242MIydx7DTqIv8+c+Zig+Yo7EgQnm7qm9XH03tBxt4NQdTSy2cttcfO8ieg+DsnTvbbSWquPbO+XMw6yarpZOMduAkj8RiD9qsdEjs0gFKTfc54+QJf1lI8OttR6S9vAhsC66rI8fqTvD1kXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5l2ByWdXlQDfJJPYO6s+blrYqDphxpT+W7K9fTL6NeE=;
 b=c3TgLVUz7m2ykptf6mbD6UBER6AxTrutiJ9gHWef3V8DR0Eda3G/9E3Cm5iQqnrrUUlRm18Q0VOcycjkuteDXx6xynwtwQDy9N838nAGO3rEycyPl/lxzIeTFzwbI0qN9H8xM5bUgVBS44rCwmcl4/zbELgdFS3EYRaQCK8k6ghIECnmCidP1ox1J7RVpHJhyMlJEhysKUL5dyf/j+5BTMLWMimZewU0QfCMqutTuFVHOUno14QI8blx53H7teF85GZVOIy/a8PlANggP+cod2RTjHuyijG3dxRBCy9l5O4OUKlNsRetESOc89lXxXmFBHfIUrKutD3hN3EGkrh63w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5l2ByWdXlQDfJJPYO6s+blrYqDphxpT+W7K9fTL6NeE=;
 b=TJwQ08qRtUhl6UC1X+FEYdhl4FCwaNhhKqCKuwO+uhdE+ElhJMaiGT5R6iAIHbPayd036HG0nY81mx9/Qu4kfFqPNHad7F5EZrSDgLJwLXLs9wN8qA9flxSjaNCIKamVKN+Ug3LOAK0OeIVVLZNptXbRZqNlU4bjD3zcTr2oykc=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR0301MB2393.eurprd03.prod.outlook.com (2603:10a6:3:68::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.27; Thu, 18 Nov 2021 15:14:02 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::d535:e3e:baf4:2d60]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::d535:e3e:baf4:2d60%5]) with mapi id 15.20.4690.029; Thu, 18 Nov 2021
 15:14:02 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-power <linux-power@fi.rohmeurope.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] regulator: irq_helpers: Allow omitting map_event for
 simple IRQs
Thread-Topic: [PATCH 1/5] regulator: irq_helpers: Allow omitting map_event for
 simple IRQs
Thread-Index: AQHX3HI6MytkM7P/n0u2D9VuZauhBqwJSUqAgAAbpwA=
Date:   Thu, 18 Nov 2021 15:14:02 +0000
Message-ID: <f5a5cd1c-763b-4dc1-e40a-dafbc47a1eaf@fi.rohmeurope.com>
References: <cover.1637233864.git.matti.vaittinen@fi.rohmeurope.com>
 <2a5d9589c1c76ce537f795ee0aa6d3a7a6093283.1637233864.git.matti.vaittinen@fi.rohmeurope.com>
 <YZZWh1aIg7TAdOUX@sirena.org.uk>
In-Reply-To: <YZZWh1aIg7TAdOUX@sirena.org.uk>
Accept-Language: fi-FI, en-US
Content-Language: fi-FI
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a892ccf-ecee-46d8-caf5-08d9aaa60dff
x-ms-traffictypediagnostic: HE1PR0301MB2393:
x-microsoft-antispam-prvs: <HE1PR0301MB2393D46BA8D2BE31A7588848AD9B9@HE1PR0301MB2393.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8WaMJzVpvnJIhv/FtYOnIjGC1jXoCM9V3Q4X4XTtTQP+EGpa7bQGJiuCq0CTIgTHchf/Y2hkGMWYxYuAaYx10HWY/nQhfO+npPFgF7qe5Wdh32lkn6x6oRAGTjtnXo90jrzTVBPEjQ9xZ6iKwXU2aDGFApHw6SCZYoiQJNmKE05HJm9E+pkra8QS8rc75vLdXqro8wvW5pLnGgxQJDOQui0WILalYaR5TZDLiP6oEyJ+aJmZMvOSwr6TdMH+YPBxAaIVbOtTb2mWqQ4iANPtMTQnKRPPIUFVjxUCknacfcDu0DnwXXSwS3kWqhUvgtn02xPZgNK8ALArU1j30WG9W0foScsYrH7bSqhW3CSEityjrmYAFnnvcNMZMxZdd9u+M6jysvMxSPVWPD61AP3Io3GjghB3YbyAqm3xyEmhRHFhIeSxFxOj5ARqE8xkCCT6xLg2iUaClgED06oQYAjvLYv0WciiAl7K8FyBH+unLr6BrNq7Kfk/oYcI2Nur5V4v1HdKpZOz42PguTN18UvF6yoAa7yPqm3aZspt0Cg37Wakz0RZ5b0z47+WwM8JzppHIL/Cq0cRWhWKza4F6tG87ABs0uhXASm2H9n0FTM4p11NIgt+v6uPOI6lcYNu5CkMeX9E3AnGq4OoZuIiRyPCJJgDDt2ZHWaoRBNWkkB8hoJIc5HjeTTZdvqSZK9TqQxGJSK/YDZz1B0hvFKGWba1GsB7pQJ2GyGBb1N1ykV0zg6H9RQ6TAAoF85H8lnZ5B5eLw43gzbfbFZ1c77zXk2wIg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(54906003)(31696002)(86362001)(4326008)(122000001)(6916009)(83380400001)(316002)(2906002)(5660300002)(8936002)(71200400001)(38070700005)(2616005)(64756008)(76116006)(508600001)(38100700002)(66476007)(66556008)(31686004)(186003)(8676002)(66446008)(6486002)(53546011)(66946007)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUxJYm9qanlCSzJMNE5DcjZOb3lKTHdqcW5IdjBuMXdnMVJ6N2c1Rjh4WGcx?=
 =?utf-8?B?eG90bkhQTDcwRnFTK3ptZEEzR3ByRFRFaHcxTWdLQThORWhES25MSkxNYW5E?=
 =?utf-8?B?ZXVjUXdJc3lGTDl1OWZZNmNSRURacysyYWhEUDNPQzNUY3IxOUc0NWsrMlpP?=
 =?utf-8?B?c1gzRjlMRFlpV3gxOU9kTEYrcDh3ejd3T09nZXhKTHNEeVQwZFZSRFpmOUh6?=
 =?utf-8?B?N2U4dFNueUgxaVlkdHg2dDBTZlNnN01WZXp1cUhRaitaWXlEUEtjNFQvWVpy?=
 =?utf-8?B?SWp0di8xK1FPamJPTlJVMWhrVE9Pb3dvN3BqRHJUaHJzS2R2UGJnOG1uVzM0?=
 =?utf-8?B?dktOYiszQlJqOG9qRnJFbUM4NVUrdDlib3NHMy9TRkpOeEZIczBPSTEzcXRp?=
 =?utf-8?B?ME42OFZ1T2FSSWRGZjlTTXNYM0pxKzE3eVE2NEhiY0czL1FjVVlubG81Ni9O?=
 =?utf-8?B?alc5QktCSGJUUlFaNGlNaGplTVI1dVFPNWpvMnR4bVdmTTVPeVJVa3VibDZw?=
 =?utf-8?B?QnJ0Y0VuTkJna1AxZUx6Q0J1UFJVblA3YnkzMXJqN0N1ajZuMHNRMWlLUUxZ?=
 =?utf-8?B?ZEpzUFZNZE1PQmdSZ1haOWttb25sTzkrVmdpWDUybG5heGQ1enN0OUdVQkkz?=
 =?utf-8?B?ZFR5SlJzMnh2MmpNQ2kzempyenpCbFZxeWtkaHpvY0NCMW9oTzB1cU5uNk8w?=
 =?utf-8?B?SER2UVdJNWkyNlV3ZGt4NU55d2VIZkQ0bzR0enV5aG1FT2Qza253V3hyazRY?=
 =?utf-8?B?SWJZNEpVemFtZFQreTFnSnB6Y2lQQW1LZk5JbjZNQmdLZnpWTFh6Lzl6dHJw?=
 =?utf-8?B?TGVaN3ZsYWxCcTFNbDM5UHpnMks1c1k4TnU5aXBrTGVjb3hxUHB0ZUlJUElu?=
 =?utf-8?B?Z3FEOUFvL0FVTUtrUXhMNXkvTFpwd3Q0U25OVXdYNGdxRncvNTNiVWxzcGJh?=
 =?utf-8?B?RnpKZFVQQmVtbFBFRXllMFd2VXU5TFkyclNjRU5CWWxTOFluTmV2bUNud0lO?=
 =?utf-8?B?dmhJSUlRS250ZjY2UUNFcHRTRWxWakMyeVdiQ2pieHhwU2p2MnhzQzJhbWpz?=
 =?utf-8?B?WFJXOXE5cW9ia2xSQTB4NjJKdkxTRzVQRjFhNGFrMURpVUQvdEg1S0FOTUVr?=
 =?utf-8?B?NDU3Vi81UGJYR0JtWVhtTTArcFVycDhTeFpxOHN6RW9xT1B6UlRQbGc2cG5t?=
 =?utf-8?B?TE1zWlBpWnM1M05ZQVZ6NlhvR2ZKK1RodVowOHJoc0RZTDd4bGV5QXI5VEZh?=
 =?utf-8?B?cjNNRDdWTmhiZXU3UC85dGxoWG4wYnpaNThqNXNjQnQ3NmtlTFFLbVNiQWYv?=
 =?utf-8?B?R3J5YkFTT2Z5M1hPbHA4QU9Jcnh2NFliSDJrY0xGZEgyZkRuTkVOMGUvOGJN?=
 =?utf-8?B?Zm11K0pJRUlPcjVUdUVYdWNuZS9tMnE3YUxtNFFzV0RFR29MdS90eUY1T2pK?=
 =?utf-8?B?c3h4bHBpdGFET3M4VnM5clJDZ2xMYnhnK2pzeU9QQ2ZwV2thelAzK2g5V1Fa?=
 =?utf-8?B?OEFkOXY5KzJ1WlNsQ2hsazJ6Y0RIdzF5Yjdtd1QxMTJsUnd4YkdqcG56Qkd6?=
 =?utf-8?B?QjlWM2Fka2hvdTZjaGszVG44dWlROHRnTHN6cnVRS2FrQjZDYlhBUDR6Ym5S?=
 =?utf-8?B?QytNbjhaZFE0ODA1MlFRVnRRMzFmaFI2UWdLYUF3SDBMU1pNc1VNektSeXdv?=
 =?utf-8?B?UXpOY2VocHNVd0dOa0VJU0hReWcyYURCM0Z1MWN1Nm5wVW4yVmZjb09SU3lD?=
 =?utf-8?B?YkFqTUJMcFlLcEg4RXllNkJaeEpETUxuWWZ2ck13am5JZG5DbnFPU3dqb3Y1?=
 =?utf-8?B?Ynl6RWU1MU5jRWlvZWhTNHhOK1ZMS1VVTUt6d0ZjcjBRM25YVVVSTEFuZVQw?=
 =?utf-8?B?cFRhbVNtSG5FLytoTWVnNmN4aElnM2NERWFaSjVTeFBvM0tETjkrT2U1R0Ri?=
 =?utf-8?B?dVo4RUpYRjU3S29sNTYxMC82ZTlLSnBCQ3U0V1V3d2RLaUh4eGFaKzgxc3Jt?=
 =?utf-8?B?RUpsUTZHRmVoQ2hWSUlkL0pQUWtTWEFiT3AwbkhWUDl4NFBXVkdYQkZtZUtw?=
 =?utf-8?B?NHRmOGluTnc1RzdHcU1haDJPZzZBSkxPb1B5WHNGUm5PNjJPZzZ4T0VJNGY1?=
 =?utf-8?B?ZUE0TTNmRFNVeW1QY2ttM3crbzgveHBwRENsb25kdkJ6OC84aTUvVG5zMWVI?=
 =?utf-8?B?eC9EMnppbFBqNzVJSDJZODhETHZtZkRwam1wQ1hhWXZVL3NERElzdjZlOWp1?=
 =?utf-8?B?RnkzaUMrUmRQSDhlbDhHTHhnUEFVOHhMM0djZnhjQy8xRkVmU3hzNkVyNEJ6?=
 =?utf-8?B?Z3ZjSTRQOUt1blJEdDNnN2xjM2N1Q3FZM1owZjc0cHkzUzgrVnEwUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE0C9E31836AF042BB206A23A9459817@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a892ccf-ecee-46d8-caf5-08d9aaa60dff
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2021 15:14:02.3027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cKw/3nRHeLkzpv3rbECYdPe3+oqHUGUM78SH8SiQtAxPrwoAJC0IdV1xE/0LMSghaKx4uVnRKAbR5Tg+f4Ie46RgqqW2FHgY1d15LTRMNvAB+4TW7nyZHK8BVI1LDxOy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0301MB2393
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFyaywNCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3IDopDQoNCk9uIDExLzE4LzIxIDE1OjM1
LCBNYXJrIEJyb3duIHdyb3RlOg0KPiBPbiBUaHUsIE5vdiAxOCwgMjAyMSBhdCAwMTo0ODoyNlBN
ICswMjAwLCBNYXR0aSBWYWl0dGluZW4gd3JvdGU6DQo+IA0KPj4gK3N0YXRpYyBib29sIHNpbmds
ZV9iaXRfc2V0KGludCB2YWwsIGludCBiaXRzX3RvX2NoZWNrKQ0KPj4gK3sNCj4+ICsJaW50IGJp
dDsNCj4+ICsJY29uc3QgdW5zaWduZWQgbG9uZyBiaXRzID0gdmFsOw0KPj4gKw0KPj4gKwliaXQg
PSBmaW5kX2ZpcnN0X2JpdCgmYml0cywgYml0c190b19jaGVjayk7DQo+PiArCWlmIChiaXQgPT0g
Yml0c190b19jaGVjaykNCj4+ICsJCXJldHVybiBmYWxzZTsNCj4+ICsNCj4+ICsJYml0ID0gZmlu
ZF9uZXh0X2JpdCgmYml0cywgYml0c190b19jaGVjaywgYml0ICsgMSk7DQo+PiArDQo+PiArCXJl
dHVybiAoYml0ID09IGJpdHNfdG9fY2hlY2spOw0KPj4gK30NCj4gDQo+IFRoZSBuYW1lc3BhY2lu
ZyBoZXJlIGZlZWxzIGxpa2UgaXQgc2hvdWxkIGJlIHdpdGggdGhlIG90aGVyIF9iaXQoKQ0KPiBo
ZWxwZXJzIHJhdGhlciB0aGFuIHByaXZhdGUgdG8gdGhlIHJlZ3VsYXRvciBjb2RlLCBJIGNhbiBj
ZXJ0YWlubHkgc2VlDQo+IG90aGVyIHRoaW5ncyB3YW50aW5nIHRvIHVzZSBpdC4NCg0KSG1tLiBS
aWdodCwgdGhhbmtzLiBJIGNhbiBwdXQgdGhhdCBpbiB0aGUgc2FtZSBwbGFjZSB3aGVyZSBvdGhl
ciBiaXQoKSANCm9wZXJhdGlvbnMgYXJlIC0gbGV0J3Mgc2VlIHdoYXQgdGhlIHJlY2VwdGlvbiBp
cyA6KQ0KDQo+IA0KPj4gKwlpZiAoIWgtPmRlc2MubWFwX2V2ZW50KSB7DQo+PiArCQlpZiAocmRl
dl9hbW91bnQgIT0gMSB8fA0KPj4gKwkJICAgICFzaW5nbGVfYml0X3NldChjb21tb25fZXJycywg
c2l6ZW9mKGNvbW1vbl9lcnJzKSAqIDgpIHx8DQo+PiArCQkgICAgcGVyX3JkZXZfZXJycykNCj4+
ICsJCQlyZXR1cm4gRVJSX1BUUigtRUlOVkFMKTsNCj4+ICsNCj4+ICsJCWgtPmRlc2MubWFwX2V2
ZW50ID0gbWFwX2V2ZW50X3NpbXBsZTsNCj4+ICsJfQ0KPiANCj4gVGhpcyBpc24ndCB0aGUgdXN1
YWwgcGF0dGVybiwgbm9ybWFsbHkgd2Ugd291bGQgaGF2ZSB0aGUgZHJpdmVyIGFzc2lnbg0KPiB0
aGUgaGVscGVyIG9wZXJhdGlvbi4gIFdlIGNhbiBhbHdheXMgc3RpbGwgZG8gdGhlIGNoZWNrIGJh
c2VkIG9uIGZpbmRpbmcNCj4gdGhlIGV4cGVjdGVkIG1hcF9ldmVudCBzZXQgdXAuDQoNClNvLCBk
byB5b3Ugc3VnZ2VzdCB0aGF0IHdlIGV4cG9ydCB0aGUgbWFwX2V2ZW50X3NpbXBsZSgpIGFzIGEg
aGVscGVyIA0Kd2hpY2ggZHJpdmVycyBjYW4gcHJvdmlkZSB0byBpcnFfaGVscGVycz8gSWYgeWVz
LCBkbyB5b3UgdGhpbmsgd2Ugc2hvdWxkIA0KbGVhdmUgb3V0IHRoZSBzYW5pdHkgY2hlY2sgcmVn
YXJkaW5nIHRoZSBjb25kaXRpb25zIChvbmx5IG9uZSBjb21tb24gDQplcnJvciBhbmQgb25seSBv
bmUgcmRldik/IE9yIHNob3VsZCB3ZSBjb21wYXJlIHRoZSBnaXZlbiBtYXAgZnVuY3Rpb24gdG8g
DQp0aGUgYWRyZXNzIG9mIHRoZSBtYXBfZXZlbnRfc2ltcGxlKCkgYW5kIHBlcmZvcm0gY2hlY2tz
IGlmIGl0IG1hdGNoZXM/IA0KSXQgbG9va3MgYSBiaXQgc3RyYW5nZSB0byBtZS4gT3IgZGlkIHlv
dSBoYXZlIHNvbWUgb3RoZXIgdmlzaW9uPw0KDQpCZXN0IFJlZ2FyZHMNCiAgICAgTWF0dGkgVmFp
dHRpbmVuDQoNCg0KLS0gDQpUaGUgTGludXggS2VybmVsIGd1eSBhdCBST0hNIFNlbWljb25kdWN0
b3JzDQoNCk1hdHRpIFZhaXR0aW5lbiwgTGludXggZGV2aWNlIGRyaXZlcnMNClJPSE0gU2VtaWNv
bmR1Y3RvcnMsIEZpbmxhbmQgU1dEQw0KS2l2aWhhcmp1bmxlbmtraSAxRQ0KOTAyMjAgT1VMVQ0K
RklOTEFORA0KDQp+fiB0aGlzIHllYXIgaXMgdGhlIHllYXIgb2YgYSBzaWduYXR1cmUgd3JpdGVy
cyBibG9jayB+fg0K
