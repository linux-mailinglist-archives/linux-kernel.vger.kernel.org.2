Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEE53F189E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 13:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238656AbhHSL4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 07:56:09 -0400
Received: from mail-eopbgr30066.outbound.protection.outlook.com ([40.107.3.66]:46724
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238256AbhHSL4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 07:56:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GPuoEJBOsw/LEEXH8+6IffoXCdEXo9X74acMN2+XsTe/TagzK0PWRyojLt7B8Wg57u/1/Z+BI2JvILNBPbaxGnVruYefnyy+YKBlB2Oy6FePNrXhmAjGVAUhzldloiVFyH3U/7YYNDCI3yCo2Yolw2O6g0Bxfhik2ckDKTPJ6XqjZNeOiqoUSLxZiaoUqLlclphp2b5xJO1FKjBYmI+abfZPi0UoD67VZ3MzR0orpq0BgLSVRH2113jtJXrx/ZGMXWFa4iGO1gqwdbYs2U+TNhbTLARsdcVFFAqHHAzrtsPqi2v978ivbK7Z7kJhxveFJN87SOA2nnjEcyhE2DZnLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6xs+oDcwkLu//azCbd3Fh+OQ9p+n/WqOTYXIU0gcCHk=;
 b=l9Eb95jXl8CRuNeZeHoDQudArro21zaCO5KhzEJ8GoIectrjxHDHo5bseFA4ZJ1srbUo3zelz0doV29YIejWc7rQ5buRcACRLZf6KewREKz1nIpBvDXjYVCrHe7wQHCqF8C43TsN/o/n9hAqmp3ksj8pJuj3PeFs7C/w/jgv1L4Wekzu1++/8HJz8ovAOq1SsRAWYQZXWjFYbvnTm8yy3gBimlg8iDA493uHFchVK8OmmmK0mUxCka37JjxtWUVjrYoosHP6nMoefcYAfCXZmiX0eHf3UQS/8vJMWInH5KK5EkxI/3UCu4EGfE+O0ByeEQbZsQeRDtl5vUfej+LE2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6xs+oDcwkLu//azCbd3Fh+OQ9p+n/WqOTYXIU0gcCHk=;
 b=K6ZcrRxRn44qR9ouSB1WsRTVq5kwSHkETuSgUKlCQQHAeW44YDZk1WQCg3l6QA6/JxbtZ1KfERWEC5jONpFTu7iH2ttk2EfwrFuf1VTeZHzTBJGRCWPsd43ai4A/boOCjC4OWLZDNYR5qXzcZ34Bkv7DGoYdg35irhlWUgUF1aI=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR03MB2986.eurprd03.prod.outlook.com (2603:10a6:7:60::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.18; Thu, 19 Aug 2021 11:55:27 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::fc50:7f7a:87b:f38]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::fc50:7f7a:87b:f38%7]) with mapi id 15.20.4415.024; Thu, 19 Aug 2021
 11:55:27 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] regulator: Minor regulator documentation fixes.
Thread-Topic: [PATCH] regulator: Minor regulator documentation fixes.
Thread-Index: AQHXk+gZpe2IEEKwekO1MUyub0ubIKt5Lh6AgAGJLTGAAAMXAA==
Date:   Thu, 19 Aug 2021 11:55:27 +0000
Message-ID: <6f7e03d21850bd28d7b8195113e25f8c42cc79e6.camel@fi.rohmeurope.com>
References: <20210818041513.GA2408290@dc7vkhyh15000m40t6jht-3.rev.dnainternet.fi>
         <20210818121709.GD4177@sirena.org.uk>
         <67f6596f54fd2ea168d71d0747ea4a521dda5384.camel@fi.rohmeurope.com>
         <20210819114354.GL4177@sirena.org.uk>
In-Reply-To: <20210819114354.GL4177@sirena.org.uk>
Reply-To: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 22e651da-897e-4707-262b-08d963083c4b
x-ms-traffictypediagnostic: HE1PR03MB2986:
x-microsoft-antispam-prvs: <HE1PR03MB2986FA3CF4B960C456DB6B9AADC09@HE1PR03MB2986.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n1DErtg3Ui/pC8hfwRizBXdCOB5o6mjhESLZJqOW0s05scm08O0pgpZ23ZnfvccPbUFqDlkeGdaMW9HPXvlrcb9FEMK+GEOpiR1pgMZ95QMkx0cJTJxMBp/h0fO1vYsQ9PDUrxemrhLKIUMXC6dV7PMjMLkxaLsaK8NyTO4CZwEZSP53m13sRNLJF+7JaOTkP9jMhRi+mxvt7M/R4Xkmfnbpz6+CLqCgDu3tHmLKrmyDTGPnGVgMiXS+zbj1BdQ4SxAqAEb/Cp6eTy7esYGFT/WTCstMV2CgB4fg8n8Rrij+uM8obsBODYL0bEUXcZJNK6+T9OhgXV5lPjPqmQluh8Wy9P0vlfvkVfhokS+O5t/n7OAZigqaFOrcn7ww6ktMHNll8/gG3OMBEz/uBbneC7EwemvZj3+OxEbFzlN0vtrU7B/xNEgM2W73mHVLuNXaYbCAU6AvcJklW3w+fSEgM9ZdAWyzNBZTgG2YdoDHhSu7GIQORaN3iZYNlAI0HvYbjaYbZh8OOE3YCd522dHZUu4Q+8SWHV8MnBuzr8pALuosQtGhA04nSvDdkaKlHcx2ZpjI6AjnRCG+P0jIasdMmsMYP8kFmXNowj4lmmHb/qs85+Ct3BuGZCsEJXrdqOrwydw5DQC2f6jaU0Mmehld+bs1zlHBY2QS/2ktPC6lcue6VJJVBtjMJPlKT5uk64LkfKN8PYhujJp85Yyxx1r+xQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(396003)(39850400004)(376002)(186003)(38070700005)(5660300002)(316002)(122000001)(54906003)(3450700001)(6512007)(71200400001)(2906002)(2616005)(8936002)(38100700002)(6486002)(66556008)(4326008)(66446008)(6916009)(6506007)(66476007)(76116006)(64756008)(83380400001)(4744005)(478600001)(8676002)(86362001)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WFBBVkdtb2t4YU91MEdqVkVMQXNBUzlhb2lNUENhUnVvQjFSWldDZ0tCUVZt?=
 =?utf-8?B?MTFmWnVvbkRaMGhIdXR0a3c2RUlndGgxcVN6V2t0Sks0TndNbWRITm1VdzJL?=
 =?utf-8?B?c0wvbDM1cDdvZWFQblVuMDVKV3VvT05CQ0FsUFVjWUc5cUVPSW9ScnNwNUE5?=
 =?utf-8?B?Nmk3MjNLcTZaK3dSSG56VzJhTUQ4cENRVjJjZ1hKUlhNT2pmdm9UUEJzTUtB?=
 =?utf-8?B?RmQ1YWphajhQWW1FM3dnNTJGWmUvbXBWdmR3Mk0xMzc2QWREdXhyZU51Mk4r?=
 =?utf-8?B?SDZGcXFGVWoyeHVwV0o3MEk4aEVrNzZqTm9ZT2dveUViUloxbEh5ME45b01s?=
 =?utf-8?B?WUZWdmFncjVtMGI5cGF6OHpUOTkxTGhyMW05Tk43TTlSOWYvdGIweXl2OUZ3?=
 =?utf-8?B?cjJhRHNKWDJ4OWVOQ3NMUHJpOXlQOVZNMTdVZDQ4WmNJaExsZW9BUStjTWR0?=
 =?utf-8?B?UTRkMVdFUzluM01JU0Zqd1ppY29OZmR1c0tZSUZmN0JKS2YxcEhjOUZHR1l2?=
 =?utf-8?B?NitMUSttV0t3SlhUTHNkQnYyTUE1Ukh2d09IdW9WQ29GR3RMZjQzaW5XOURj?=
 =?utf-8?B?R3diREVma0E0SFRuMFA4d2NVeGNHTlZNa1hqVTE1dS9QVGRoZ3JpUllva2M5?=
 =?utf-8?B?RjB3elRYQXBaTHhya0txYWd3Mi85bkJNQjJSYTFMc05LNFdlT1lBRDNZNGVt?=
 =?utf-8?B?QldsN1pqMnZwWHpmNlljb29FamF1ZFVyZE45SU90SlpuTTQweERXZ25xTXFs?=
 =?utf-8?B?b2tKL29zcHNyK05RekRFTDRHNEZzU2lXK29BcFlVNERhcHZDcnlHQW5HbGg3?=
 =?utf-8?B?ZXFhR252VlYxRHJyVitqcWVlQUJESzNXVVpGcDMvNFE4eVFib09KcVVHU3ZL?=
 =?utf-8?B?WHVscS9WVjUzdzFVNjgwUExOdGlmRE9TTjM4bm5ydjQ5aTdhOTFvZHVkQUlw?=
 =?utf-8?B?dzFRRnlpWCtJbEE3MHZlTXNHV3M0M3JJb21nT2gvS2R5MHluelBqbno5aXVS?=
 =?utf-8?B?N0daa0NtZ0JqaDhrdDl0T1JlVDVSQk43UWhLVk5mOTM2NS82Q3hIRkRuR1Yv?=
 =?utf-8?B?T1VzUHk2eGw2cE5peW0yckpMVFFQZ3QvamFZOS80K2U0bWpFTGhmWGhobFdN?=
 =?utf-8?B?VEVrOGlmajQ1VzJEWkUwUGdHTE5GdjZUUm5FZEs3Y0lVbC82SDY0bEZoQTBs?=
 =?utf-8?B?ZU1UcW90MnYrOGxqQ3pPeU5IYzIzZ3d1QzJDTFdQUTJkUlovOXVKTHZNWitT?=
 =?utf-8?B?Tk53SE4yY1VLdGRjdWNpRzgvV29pUmMxaGF0TVhhOWpIY2RWdzNSNEhnZmFB?=
 =?utf-8?B?MC9pK3NHeEozYkN1OThCNXVvOFE1UEZSbDNSQ0JORkhMeGdGbVBBSGJFK3pL?=
 =?utf-8?B?c0FoWkZqT0FtN2UxOExGcnF6eVU3bVZkTWNiRjhsRzg5ZVlsSzVJM0hXQk81?=
 =?utf-8?B?UnE5ZjBxdW9HeW1QcFYwQ2pZS1M4RERBdFNoeEZCS2JnTDZiNng0aU5halE4?=
 =?utf-8?B?U2JyUEtWdU10ZVpxdTVTcU05amVuSWVwZFVVWllhU3BwU2RqTUtwUVVEY1Ew?=
 =?utf-8?B?YW9tOXgxcURvYzRjYXhCNFlOMjNIS2tyRm9aaUlDYzAwTVVSY1JoemsxVUs4?=
 =?utf-8?B?RVExWU9BMFhiaFdDVExEV3FQL3cvNHlQYVJVb3F1czN5cTNncm9udXFBR2Jk?=
 =?utf-8?B?MUUyZ2Q4QmRCMi9QWnByV2ZEUjFFVzRBendNdDI5eU1TMEJDOHRqbWx3K3J6?=
 =?utf-8?B?SndHSm9Vejc1R0d2R04wVGFKMUVZalhVR0tIV1ZYV1BYdVR6QVU3cXRJdmZX?=
 =?utf-8?Q?74D58x+bsHOWfWVoqzNzKJMViWyBPbQJUCUKQ=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <CBB9EE6A7EE57049B796DC7EA7F4E95F@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22e651da-897e-4707-262b-08d963083c4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2021 11:55:27.0722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xhOx0gmksa4pAI1w9pmH1jWyXM0U8lO+W1iFJ9Xp2pg8TxpkBEXdiM8r0Iz4VK1ftl4+U9+4vTP08DprUtkNLF50Gqz5h9KkfnCSBddJ9Nrk2xxW5kDx413JNSA09M0i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR03MB2986
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBUaHUsIDIwMjEtMDgtMTkgYXQgMTI6NDMgKzAxMDAsIE1hcmsgQnJvd24gd3JvdGU6DQo+
IE9uIFRodSwgQXVnIDE5LCAyMDIxIGF0IDA4OjA2OjQ4QU0gKzAzMDAsIE1hdHRpIFZhaXR0aW5l
biB3cm90ZToNCj4gDQo+ID4gSSB3YXMgdGhpbmtpbmcgb2YgdGhhdC4gSSB0aG91Z2h0IHRoYXQg
aXQgbWFkZSBsZXNzIG9mIGEgaGFzc2xlDQo+ID4gd2l0aA0KPiA+IHNpbmdsZSBwYXRjaC4gQWZ0
ZXIgYWxsLCBib3RoIGNoYW5nZXMgd2VyZSBkb2MgdXBkYXRlcyAtIGFuZCBJDQo+ID4gZGlkbid0
DQo+ID4gdGhpbmsgdGhlIHR5cG9maXggd2FycmFudGVkIGJhY2twb3J0IG9yIGEgRml4ZWQgdGFn
Lg0KPiA+IENvdWxkIHlvdSBwbGVhc2UgZWR1Y2F0ZSBtZSAmIGV4cGxhaW4gd2h5IHdvdWxkIHlv
dSBoYXZlIHByZWZlcnJlZA0KPiA+IHR3bw0KPiA+IHBhdGNoZXM/IChJIHNlZSB5b3UgYW55IHdh
eXMgYXBwbGllZCB0aGlzIHNvIEkgZ3Vlc3MgdGhlcmUncyBubw0KPiA+IG5lZWQgdG8NCj4gPiBz
cGxpdCAmIHJlc2VuZCAtIHRoYW5rcykuDQo+IA0KPiBJdCdzIHR3byBjaGFuZ2VzIHRoYXQgZG9u
J3Qgb3ZlcmxhcCBpbiBhbnkgd2F5LiAgUGFydCBvZiB0aGUgcmVhc29uDQo+IGZvcg0KPiBzcGxp
dHRpbmcgcGF0Y2hlcyB1cCBpcyB0aGF0IGl0IHJlZHVjZXMgdGhlIGNvZ2FudGl2ZSBsb2FkIGNo
ZWNraW5nDQo+IHRoYXQNCj4gdGhlIHBhdGNoIGFjdHVhbGx5IGRvZXMgdGhlIHRoaW5nIGRlc2Ny
aWJlZCBpbiB0aGUgY2hhbmdlbG9nLCB3aXRoDQo+IHR3bw0KPiBjaGFuZ2VzIGluIG9uZSBwYXRj
aCB5b3UgbmVlZCB0byBob2xkIHR3byB0aGluZ3MgaW4geW91ciBoZWFkIGF0DQo+IG9uY2UuDQo+
IFRoZSBtb3JlIHRyaXZpYWwgdGhlIHBhdGNoIHRoZSBiaWdnZXIgdGhlIGV4dHJhIGVmZm9ydCBy
ZWxhdGl2ZSB0bw0KPiB3aGF0DQo+IHRoZXknZCBoYXZlIHRha2VuIG90aGVyd2lzZS4NCg0KRmFp
ciBlbm91Z2guIFRoYW5rcyBmb3IgZXhwbGFuYXRpb24uDQoNCi0tTWF0dGkNCg0K
