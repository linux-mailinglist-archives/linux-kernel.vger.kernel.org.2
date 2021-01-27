Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D967305E8B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 15:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234340AbhA0Ooa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 09:44:30 -0500
Received: from mail-am6eur05on2059.outbound.protection.outlook.com ([40.107.22.59]:17700
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234372AbhA0Onk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 09:43:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ES9bh2GKEGpBCqXnxhbUW4WrlEDshIKsakSBCF8yQcNnaQ816t7YtIcP56yzRoSIwjVh3AALNqu1Ej9zEUXii3XiybyRfNdJy05cqS2lZ4iNB164DphLeZoUH9kY5sRJr9U6LvxJ8tNj+mqww4dXPOsWpoNTwizBo3hCj69tonvUqSDJyL0kv7KBHAxU80SxrGWM4wG8ONtq0x6PkORcVBjq0CzDhTIW4p6rR7sCPpl9I3tWHMtR4qj9xlbJYqt45RGi/lRpwTiMZoY0knLng/CwAfaBp7PAzTSQDKnvIKMEdt5EGmZ9oEjhjsuttiYgHxZLqfs552F+ToLasrMY0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b88Pce85gMXoi3gcwq4f4Rq/kRgpYTLKASQM5WBQ/QA=;
 b=L1MoG+yf0tWfszELNhHTGaSHXidZQSfsdvH7+Q9PSO0396LPsncw0LOYeWsu9225uSjEI3TzRSGsQRYwBGaGqvYzutCj+YMeUO1ZQfsWwOoYnEQwfLnNMmKeO0JwLXv4gG6YWcduhNg1ygK7ckFMmH4eHZqxhqdRYTV6GBh87KM1hAnXpGXomADKckJCZXmP1R+9V6YQWVpPUYhMCcA/V8kpmljW1k52EmzRi52vsgx8M2CZsndPl1tih7GqJQPSR9t90oot8HEkA7i5+572YLSHUeMhhH0Q6jYgJ8iJTWpNc75jAxdiBRF7U7CdrGNYLMkEh1F46Ri/3inuDG+l+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b88Pce85gMXoi3gcwq4f4Rq/kRgpYTLKASQM5WBQ/QA=;
 b=gQKp5kPVAxJ1hWakbNbRV1ofbdvXKSgH2gPS/MF4hk4s4ks9rBi7zeEOib2ukWZZRPIAeiETuJJl9lkG9h/rdKBtHg036ewTAgZYcvtirT1G5/qZQFwBrgcO77R+EAfbPOisOiab24Jj3mtZsKQW/VNq+pdQ5qgJrJvuhvbn3NQ=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR03MB3067.eurprd03.prod.outlook.com (2603:10a6:7:5e::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.11; Wed, 27 Jan 2021 14:42:48 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::d109:2683:5f4d:1f55]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::d109:2683:5f4d:1f55%5]) with mapi id 15.20.3784.019; Wed, 27 Jan 2021
 14:42:48 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "angelogioacchino.delregno@somainline.org" 
        <angelogioacchino.delregno@somainline.org>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: short-circuit and over-current IRQs
Thread-Topic: short-circuit and over-current IRQs
Thread-Index: AQHW9KQ1CReIG2nvY02SR0F15Vfw3Ko7ZkqAgAAjj72AAAI6gA==
Date:   Wed, 27 Jan 2021 14:42:48 +0000
Message-ID: <522c616910922f209bb245f298578e31d1f8824e.camel@fi.rohmeurope.com>
References: <6046836e22b8252983f08d5621c35ececb97820d.camel@fi.rohmeurope.com>
         <20210127122733.GC4387@sirena.org.uk>
         <6d60af3516161bd04332cd60b50aa4becf92e17a.camel@fi.rohmeurope.com>
         <c10cf8d6-f36a-60f4-93cc-807e11a7cec9@somainline.org>
In-Reply-To: <c10cf8d6-f36a-60f4-93cc-807e11a7cec9@somainline.org>
Reply-To: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: somainline.org; dkim=none (message not signed)
 header.d=none;somainline.org; dmarc=none action=none
 header.from=fi.rohmeurope.com;
x-originating-ip: [62.78.225.252]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 15e33d04-e619-4963-5073-08d8c2d1d0f1
x-ms-traffictypediagnostic: HE1PR03MB3067:
x-microsoft-antispam-prvs: <HE1PR03MB306779C86B0966C165C4C8A4ADBB0@HE1PR03MB3067.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Pn780VrT+xpRSGxsYpL0TwixKadhq5OqutG1wV7K5uLFKPtYWHdu+tp5CYCzivLsPnhHNEU4xPfmsW0cjW+RkZKITELKPb5T/VXvQ0yPETdI5K3bGp9pJxb/IUidahFwMPqi8/vkBljxxDkci5G6yP2uU6mYlcH6Csha9ayuDZYJEcrSdQ/HQrO4JMxXsv0EMXmXk4nKlEjxLdzLeub28NOtMmHKeOUmN09sRybbzjHhfMT0qDadbpR1Kma7NVC2zT7wQgh0P/GP/x2JxryblnCitV/kpc63+R7evIrb7h99hh7xOWd7i/JYDJHcCp2peJS5elJRFy6O70xFsA5lN1S50GBVQGSMNdtqKatShTkSzgKDQqmc5u2APwoUawoRWVnfgBa1CdypdsMRIZ3MgV3OFVBSCxkQvD72AehfSpXjv0Vu+g3Cmq3mJJGJE3rgFFoDo8CAZKh9clXcdQ6gSnWOUW7Gh+jfgOwW8fU9UCSbGdsNdvYXUxAGrYfi4Yo8FL9DRPZJ3VXS1YcK+SHiLQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(39850400004)(396003)(366004)(86362001)(110136005)(2906002)(54906003)(6506007)(26005)(478600001)(186003)(4326008)(2616005)(316002)(66476007)(66556008)(64756008)(66446008)(66946007)(6512007)(4744005)(5660300002)(3480700007)(76116006)(8936002)(3450700001)(8676002)(71200400001)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?aFhNcnlUQU9TbmEydUQzMlgzbW0yV01tRkZwSDh2cjFhWGh2UHhnU1VnN29j?=
 =?utf-8?B?ajBSTEVRYXlJK0k5R2tuY0lkd0VBV0gybGlRNzVXSVZTOURVMmErWFpiYVFJ?=
 =?utf-8?B?RjlhODl4VU9FZCtsb2sxMllaQzNpdU8xeWRndS9jVWliazJwQmwvbElGMyta?=
 =?utf-8?B?WWZzZVlXUkdmVmxLZUxXOE9YeW1PN3VTcnZKbG9FNjh0QUdNR2crUjlSZWpa?=
 =?utf-8?B?OUd3MTRRd3JvYWdFTXdJOVBoeU94UmJiUjA1ZWExZDRXQWFDdk8rWkNZR2g5?=
 =?utf-8?B?d3FiUHhReWx1Y1V5YXNLbUsxTnVkOXVNT0ovQWNabHVSbkhGN21FNmlzbnYv?=
 =?utf-8?B?N1NPY0tpNkZ5UldNYzlSa2ZkYnY0K2FBZmE0alNHZWtuTUMveXF4eTNtWEow?=
 =?utf-8?B?S045eTBOZlhDRGVaMXk1aUV5MHp2Tm9KUFNmOHRiRVBOdVgvSmdwRnlCZlRD?=
 =?utf-8?B?bEdUemhKMjRtU3QxcEdjSWNtcFl2NjFEU3BIVkpBcjZZNGpIRVA0bUV2MnJK?=
 =?utf-8?B?aWNZaks5M2dkSWc0TGFMNC9SdzJ4c1AvbGo4Zm85V0NaTE92Z2dzM29vVFZU?=
 =?utf-8?B?QUQvT25LR2xDSThBYW5XT2N1Y3hmVlJDS2pIYjR0cjQ2Q09RU2dZVlBtUmVk?=
 =?utf-8?B?bUZIUThFd3dsZVRNaGZYbmJlNzlNVGJOMEVDaTNNNHZIS2RIRkZBNlZWVUk4?=
 =?utf-8?B?dnBWN01GN1UwQjhiYXFUdXlMWjliNGdmR0wrZVJwVEV5NkVXUGs2N21xaitQ?=
 =?utf-8?B?ajMvR0hranY1d0UxdHFjdDhNY24vNldBdEUrSDVYQ2RGeENHRjFSSERsc21R?=
 =?utf-8?B?Zy9KZi9MUnFBVmIwOEZWSklxalhrekhrUyswSU8wYkxGdkNTb0dnTVVma2F6?=
 =?utf-8?B?WmZ5aWg4TDFKZ2hVNENYTDlaY3RSTnh2eFBMcXRKOXdGTmIvUnBqckxxMWdw?=
 =?utf-8?B?L0R5TTNmTkVVTGFQcUtqazFWYk1UNVJ6OUJhQVFuSG92OUc4eHowYi96Z1Z5?=
 =?utf-8?B?aG9kZzdWcWhHOXhsRnFLcEhwTDRRb3lGTCtFOHBvVWhNbDc5Wlh2MWRDVXF3?=
 =?utf-8?B?SkFmM25mZ3JmVmQ5TWxhTG9OVzg2WXN6dWlJWlBWT3FXNk5jem5takNwR2dl?=
 =?utf-8?B?Z1VnTFA1Mko2NmRJN2JsWkpScGhCWFN5SWxxMGVnaHQwTC90UTQ3Q0w2c1VV?=
 =?utf-8?B?M1JnUklYQUl5b0h0TXdTU2JFKzFRSjQwaUVQUjR4cmU1Q1lpZTFFaU5FTVcr?=
 =?utf-8?B?b2k3WVljQXFGMzZMYTVGemxqMDFHMVM4ZEcxV09CTnhiWUxkR3g4dXkwdFRr?=
 =?utf-8?B?YWgzS2NOQUhCZlFzTnJmMUxVbkxTOTIwTGg3MmMxSW5IRlhjMjFiK1YzcXRG?=
 =?utf-8?B?dWxyWXVWQW5VR1RWWFp2NlRXdVQ2aHYxRjFaUTFRL2tUSjBHLzVQTXlpTjdv?=
 =?utf-8?B?RXJXTUtJNmM1MWF3VUU4ZFpUM0RXYnBSSnJpTExBPT0=?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A546C1166A40347BC8D403B5C4C4217@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15e33d04-e619-4963-5073-08d8c2d1d0f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2021 14:42:48.1674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 06xjp8jd7nkKQbv0XCAsP4QW/EPohT8xidX2NRaGo70OyojM5DhE1QSgPlyVTLvW52eTVdZbHItcczFJHuvjkdA8JzOdtZywKiEJz9jul8Cl5jZ7NkwnFwOBYE+WBCj1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR03MB3067
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIxLTAxLTI3IGF0IDE1OjM0ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMjcvMDEvMjEgMTM6NTYsIE1hdHRpIFZhaXR0aW5lbiBoYSBzY3Jp
dHRvOg0KPiA+IEhlbGxvIE1hcmssDQo+ID4gDQo+IA0KPiBIZXkgTWF0dGksIGhleSBNYXJrIQ0K
PiANCj4gPiBOaWNlIHRvIGhlYXIgZnJvbSB5b3UuIDopDQo+ID4gDQo+ID4gT24gV2VkLCAyMDIx
LTAxLTI3IGF0IDEyOjI3ICswMDAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiA+ID4gT24gV2VkLCBK
YW4gMjcsIDIwMjEgYXQgMTI6MDE6NTVQTSArMDAwMCwgVmFpdHRpbmVuLCBNYXR0aSB3cm90ZToN
Cj4gDQo+ID4gSSB3aWxsIHNlZSBpZiBJIGNhbiBjb29rLXVwIHNvbWV0aGluZyBkZWNlbnQgLSBi
dXQgYXMgSSBzYWlkLCBJDQo+ID4gd291bGQNCj4gPiBhcHByZWNpYXRlIGFueS9hbGwgdGVzdGlu
ZyBpZiBJIGdldCBwYXRjaCBjcmFmdGVkIDopDQo+IA0KPiBJIGRldmVsb3AgdGhpcyBzdHVmZiBp
biBteSBzcGFyZSB0aW1lOiBJIGNhbid0IG1ha2UgYmlnIHByb21pc2VzLCBidXQNCj4gSSBjYW4g
dGVsbCB5b3UgdGhhdCBJIHdpbGwgdHJ5IHRvIHRlc3QgeW91ciBwcm9wb3NhbCBvbiBxY29tLWxh
YmliYg0KPiBhcw0KPiBzb29uIGFzIEkgd2lsbCBiZSBhYmxlIHRvLg0KDQpUaGFua3MgYSBMb3Qh
IFRoaXMgaXMgbW9yZSB0aGFuIGZhaXIgOikgSSdsbCBDQyB5b3Ugd2hlbiAoaWYpIEkgaGF2ZQ0K
dGhpcyBkcmFmdGVkIQ0KDQpCZXN0IFJlZ2FyZHMNCi0tTWF0dGkNCg==
