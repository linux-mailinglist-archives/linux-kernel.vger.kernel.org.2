Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B83C6458E8F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 13:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239609AbhKVMpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 07:45:35 -0500
Received: from mail-eopbgr00066.outbound.protection.outlook.com ([40.107.0.66]:6815
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231258AbhKVMpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 07:45:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dhWUY9rDWbTRMwGExax8qymAo5EHrSDMgCnA+Th1AZeKPJiDBZtoDhiV1fdlsp3oXPhCsIEav0qwMn5W2Qq1kAO1egGFSFT6HmSxlvHExD6DfHoWRIj/MfXZwVTGdujQ1apvqLO28eKpPaC7yZb/JYWodA6VaWjDGUzRzpBTr7m2bzO4UEEgPWJqf2Ni2RLzIotf+FAvbOcEvPDVbmjXR6yc/zkPDbE9zwMYDulOPWxeN0BgXXtXuO2VQCIfB+RHFsFUwiUqpxNHmu6auNfG5qQAisWwFoRhAg1zFbMzDP0Ol5OrYRH+ppb8Kt3HoqooOo8YJ7JY4aEs8W3B0bub1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m88XKD/MGFkI187cr6FOX6JdyOsY0sKWZW5ZQR/JNqc=;
 b=FAhCsGl8n4Ywib/LL5pWCU+Shht0BQQtiz99O4SX/HGZgvYFhhJmW5ae6/dgwV8X+BAXwyX+qhf21oJwn7cN2n5C0UVYfPBFmmJGSKbmVpLty56P9AA96QlGN3ax7jfucGQ02MUIiL7t2lwCbmsYnGubCp6ZY/xaPmhzcjL7PKTQYDAcVqBByo03p5L6Q6YGURs6x8UDvTzrehz1OytgtoYsg/XNFuca0Q0rXM3aNxmI3eBKi5URM6T+bRU3ZNCmn2n0xZn9Be/8HI9MKFl+Da1dCrw2SFc+O3QgaxDYe0QokTjWVr/+MrKQQ8y6d3pcKxxikzLsafmzD9C2nnDepw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m88XKD/MGFkI187cr6FOX6JdyOsY0sKWZW5ZQR/JNqc=;
 b=PFFiyV9EXc0q/onHNW5SJdGqodS/J49opj8pzKIQE7kKbDgHS4FbYkaDUmsnvdukw7WKkLakwGKzkne8yOUZVgmisU0tSp6eubcL1f1G9kuyNpWCuuiJXPokG4nRuxr8mkSNWx3uozdt/4FDNPIgiMEPZ9QjN1mXMiB6clUtHYY=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR03MB3066.eurprd03.prod.outlook.com (2603:10a6:7:62::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.24; Mon, 22 Nov 2021 12:42:22 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::544e:754:6241:aa7f]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::544e:754:6241:aa7f%6]) with mapi id 15.20.4713.024; Mon, 22 Nov 2021
 12:42:21 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <yury.norov@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] bitops: Add single_bit_set()
Thread-Topic: [PATCH 1/4] bitops: Add single_bit_set()
Thread-Index: AQHX35CZ2t64bA8wLE2j/heX74SAnqwPaOmAgAAUvoA=
Date:   Mon, 22 Nov 2021 12:42:21 +0000
Message-ID: <2c22b52f-9a1f-06f5-f008-d568096f5c4d@fi.rohmeurope.com>
References: <cover.1637330431.git.matti.vaittinen@fi.rohmeurope.com>
 <73d5e4286282a47b614d1cc5631eb9ff2a7e2b44.1637330431.git.matti.vaittinen@fi.rohmeurope.com>
 <YZt+x2moR632x///@smile.fi.intel.com>
In-Reply-To: <YZt+x2moR632x///@smile.fi.intel.com>
Accept-Language: fi-FI, en-US
Content-Language: fi-FI
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1677b559-d47e-4c9c-5cae-08d9adb5874c
x-ms-traffictypediagnostic: HE1PR03MB3066:
x-microsoft-antispam-prvs: <HE1PR03MB3066A0914ADCFC07E50C88BDAD9F9@HE1PR03MB3066.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ird2M3ociUQM8SZdANubaG33YkkJjGbNwJtIMsOtXqrpnlgYjBBkKz7KY2ly15T9MOWFJJsBSUFpLeLJXHNA5vk/uGpWDYrm/eREYP2JLjxMbBppRc89HSDp/EP8J0BBkE6ZRysTqQaWMlZ8KkNfceA+RQBqK4RiKVmKoeWxi0L4RYN5N0dIWyTvWRBecsw97o6tATyS5lYwReS7o4GFW+5WVhD+1ndwy9QxPfT3pRUIm1wXCvZuEBYLwyKTwF/8Kef7GTzJ3KYefTwkCkE3sOHdSV/ISBGVznoCC7IlIxZHgNP3ytJ65e1C2ut7Qb5fc/6MK9ChMOfaCNQcHW7BA45gOws8Uarw4F52zT9F7jfIMX+/VN7yIv4hHa96GgG3rarZFPg9YPNAnGoElZJJubObnitISF2euZoGRfSVWcb+SOc1GGxnXq9P976h1JXwwdllDVFs8TLnX4C8QtU39y7j07S02VRHOtEUtghmEM6Vc/a/tMC+8pkeV9YetRqJfPfygDDPQucpBr/YJfKkku/nLmsJg0B+RktZWd8kPJVC63tWpIkW4tkEUfdZGdpSg74HTWLyAaNbk8rDYqpg3ztCZpZNM1wwAsyyUV4oMe+iBUUQiII3O2Z1EjmkwvndRbSXp8bubYhzr4UZLGNbTrobr7dJDJCloB+nrp20s63+M6dE0fYpnEHK8RC0IKeCKsVAnPQpObO7LmbVR4eHIr0Rnq4VRX8bJrdwAYldzXO9zY1MD4picfOQG+n3kQ1SpEPrmmz9fgh/cD6779Vodw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(7416002)(5660300002)(316002)(6486002)(83380400001)(66946007)(54906003)(66446008)(53546011)(6506007)(26005)(66556008)(66476007)(64756008)(4326008)(71200400001)(6916009)(86362001)(6512007)(186003)(31696002)(76116006)(31686004)(38070700005)(8676002)(8936002)(2906002)(38100700002)(508600001)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2t1ZWtnaCtLb2ZFTkRacE1lRlp6MHJBMnNIYVd3Y1BUYzI3VlBSWEdLSmtB?=
 =?utf-8?B?elRTQVErTTVZS3ROV3dBOFlkT0Z1bWJyTHpFemxqUEIzQ1pJbVpOYXVseFR3?=
 =?utf-8?B?NzFSdkNyVXgzcS9BZFFxZHE1WXZoNGpyRDh0V01jN0lUZ3V1TTNyOENTbUE0?=
 =?utf-8?B?VmVtbC9TV0k5dnByblVnaVhBM1JYRWFVdEJmenF5NnZxU0lsSW9nN2J4NDZ6?=
 =?utf-8?B?LzB6T0Rsa1RRYlNWTHE2bnJiSitnc29yRVJnNnZlNFhwb01QQ0JLVWJZMjhj?=
 =?utf-8?B?cXRHS3dsQVZtTVBLKzhaaCtTM1JHMXg3dU9CcWxkWUEycERueGYrVDQwcEVl?=
 =?utf-8?B?dmpiQTY2OVhqZVI4SDA4NjRrRnRzUU9HOEFWRlorUFBBYi9xaHRtblR3UUFs?=
 =?utf-8?B?Lzkza084RVdqOXRIdzFlZ01mbG1iOHdSMTRTT2plY0Q1NXZjL3VNV2VBb1ov?=
 =?utf-8?B?UjJlRU9uWUlzOUs5MkRJWXBHSUtOUnhiaExDSU03V0FRelpDeGFjMTdnVFJJ?=
 =?utf-8?B?WWVuZytTU3V0RnRkV3AxajhFajNCWnN4UG16QU40Sit6MlJtODNaQllWV0xs?=
 =?utf-8?B?S0R6UXNUZTlKem90c3QwMXV2bThTK2RPMmk1U0lsMENvT2hzSG8wQzFRUDVa?=
 =?utf-8?B?MXIvT1NNeTh1VEVXb1ZvWHIyeTFSUXNyZ3o1N1l4YjJCTnN6SUxjM0pOaGho?=
 =?utf-8?B?NTlsWHU0UUF2OUR3RjdvVHpTaGNETkU3OHZVdHc4RklSUjlnbXhZa0QwWnNr?=
 =?utf-8?B?d1l5T0o2cnBPUjlCRWMwelhHY3NXSlIwdmRNUTA1bHB3ZkFwT1JENDM5eW9i?=
 =?utf-8?B?bUdKRkxkbHlFTzVyOUJVYzdkbHJyWkt0cXFiYkw2WVVaM1pHdy9Tc0liell5?=
 =?utf-8?B?eTJsTUtpbXp4MGlycTg2NjhOSGhscklsUklSNm5HWjV4SXRTdVBKKy9OK1lL?=
 =?utf-8?B?SWovZnViNGhGc1cwWHpuSHFhM1J6c3RBNllUMlFtMERNUHowakxNUWZIQ0RC?=
 =?utf-8?B?bnpLUlMxT3VQU0NicHhPTGl0T2g1ZWdwdUNMUGlTZUs5R1dZZ1l5cUR0OFRn?=
 =?utf-8?B?MW9LTnNOTXRQamhzeEFpb0pFSTB1RkZLYjNaWnlzK3A4QnBEVVBLOUJPaXJW?=
 =?utf-8?B?L1Y0ajNhWlk1NTFmM2VHdGxxdEo2Zm03Wm95TExDeXZiNVpaS09nc2psSU5m?=
 =?utf-8?B?R2tScHRRRjBaZHNCR28vaWNEalZrSiswYkxTTzhQVTFuTUd1djA0NFFZaGVQ?=
 =?utf-8?B?UytIemd4a1hia1R3TW95bmhYMlB1VStjdFFmVWRlQnJyTVBxMk9UWnlMSi9r?=
 =?utf-8?B?dkJKMTI0SHhEMnU1QXFSeTZPY05aaHR1Q1k4b2hjd0xKaVFCZnhkUHlYV2Q3?=
 =?utf-8?B?b1ljWU5oNWYwUDN1SnhoRWlFTEh6VXBqUEUvdTRlaVpYZUZ4SUFvY0FDeSto?=
 =?utf-8?B?SzlSa1JoN1ZHN3dKWDR6Z3VZMHdnSFpxQVBUSmJmZUdnbGx4bDBIN3NpR21C?=
 =?utf-8?B?M0tjQnhvSVlmMU1DOGc0UC9uWkJ1SXJ4NGJmc3ZSREwzODV2QnFxY01kSXVH?=
 =?utf-8?B?cUthVVc2NkttdG5kQVh5RllvVGZHYjVyTXpKT0t6c0MzQW43VTB2dGNpNUVs?=
 =?utf-8?B?c285OGllSTViU3prNTMwc3NxSzBzSXllbDNqbTZvYU1CTUlPR3Q2WHNqTlBI?=
 =?utf-8?B?RW51SW41cTBnRzVERi9YOEpJOEUwZm80ektoYjBVSnFxWVVmSGFXYkkzRzZK?=
 =?utf-8?B?UFovK3hFOGNqVk5HeWoyMTZUUi9DYWk2aXhuU0ZFdGxtemswMmlYOXhSREd3?=
 =?utf-8?B?YXd3WU9NVTNyNUhpc2doZXpLRlA0STJEOElTc1JMTmRUNnRMKzRCdCtBZU0y?=
 =?utf-8?B?TkhtcXNVVTdQRlpZVDZFN01nWGdTc0tLYjFqbE9lMkJBOTdZN2hldXZPZG1M?=
 =?utf-8?B?ZkRYKzVsaUxaYVFKSTdPOVQ0K2FPbWdxNG03SnZ2YUp0WWRjenU1a0IrNU9t?=
 =?utf-8?B?blhhb0VJVVBCMkRsU3pwQWNlQ3dROUlmVXhKYy9YaVlyWlNlSThCY0FwZEFz?=
 =?utf-8?B?UmJWSlBaYVdVS3lZbDYrTDJmWkNlRVNEQjFwTVZTRGFhOERRaDdTV1NjdFRC?=
 =?utf-8?B?YmJkbGV3VFd1WDVpZjU4dmRRc2piQ29NYThwRUZUOTVXcExyL2dJTXN3VDA2?=
 =?utf-8?B?cG83anFyY01WeEJwS1ZQQktPeldXWml5dmtJSmRVQk9jbkIvVnAya3F6a0F5?=
 =?utf-8?B?SytJZU53RWVKbTAwVnZJd2RwaXM4cys5ZG5oQkswQmlZTXZ1bThhdmJwYUVt?=
 =?utf-8?Q?co3qkoiQMbhDpBMLPA?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <15457509AD94C943BC9BF60C503C5EB6@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1677b559-d47e-4c9c-5cae-08d9adb5874c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2021 12:42:21.7971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FucnnjF8Kxp1qlKyDHzLHbL+5IeOtyzpJQ678g+7PEX/h3Crh8kaLJLhhxVE4/bfnOdIDs+o3cj1GHUlWzy752l0NIZ3eZFkuwJ6GF2WHA90V2pkeWMnX42BKDv05/dM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR03MB3066
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMjIvMjEgMTM6MjgsIEFuZHkgU2hldmNoZW5rbyB3cm90ZToNCj4gT24gTW9uLCBOb3Yg
MjIsIDIwMjEgYXQgMDE6MDM6MjVQTSArMDIwMCwgTWF0dGkgVmFpdHRpbmVuIHdyb3RlOg0KPj4g
VGhlcmUgYXJlIGNhc2VzIHdoZW4gaXQgaXMgdXNlZnVsIHRvIGNoZWNrIGEgYml0LW1hc2sgaGFz
IG9ubHkgb25lIGJpdA0KPj4gc2V0LiBBZGQgYSBnZW5lcmljIGhlbHBlciBmb3IgaXQgaW5zdGVh
ZCBvZiBiYWtpbmcgb3duIG9uZSBmb3IgZWFjaA0KPj4gdXNlci4NCj4+DQo+PiBTaWduZWQtb2Zm
LWJ5OiBNYXR0aSBWYWl0dGluZW4gPG1hdHRpLnZhaXR0aW5lbkBmaS5yb2htZXVyb3BlLmNvbT4N
Cj4+IC0tLQ0KPj4gSSBhbSBub3QgYXQgYWxsIHN1cmUgd2hhdCB3b3VsZCBiZSB0aGUgYmVzdCBw
bGFjZSBmb3IgdGhpcy4gUGxlYXNlIGxldA0KPj4gbWUga25vdyBpZiB5b3UgdGhpbmsgc29tZSBv
dGhlciBmaWxlIHdvdWxkIGJlIG1vcmUgYXBwcm9wcmlhdGUuDQo+IA0KPiBTbywgeW91IGRlY2lk
ZWQgdG8gcmVpbnZlbnQgaGFtbWluZyB3ZWlnaHQuLi4NCj4gUGxlYXNlLCBkcm9wIHRoaXMgcGF0
Y2ggYW5kIHVzZSBjb3JyZXNwb25kaW5nIGh3ZWlnaHQoKSBjYWxsLg0KPiANCg0KVGhhbmtzIEFu
ZHkuDQoNClRoZXJlIGFyZSBmZXcgZGlmZmVyZW5jZXMgdG8gaGFtbWluZyB3ZWlnaHQgaGVyZS4g
V2Ugc2NhbiBvbmx5IGdpdmVuIA0KYW1vdW50IG9mIGJpdHMgLSBhbmQgd2Ugd2lsbCBlbmQgc2Nh
bm5pbmcgaW1tZWRpYXRlbHkgd2hlbiB3ZSBoaXQgc2Vjb25kIA0Kc2V0IGJpdC4gT2gsIGFuZCBv
YnZpb3VzbHkgd2Ugb25seSByZXR1cm4gaW5mb3JtYXRpb24gd2hldGhlciB0aGVyZSBpcyANCmV4
YWN0bHkgb25lIGJpdCBzZXQuIFNvIG5vLCB0aGlzIGlzIG5vdCBoYW1taW5nIHdlaWdodCgpLg0K
DQpZZXQsIEkgdGhpbmsgeW91IGFyZSBjb3JyZWN0LiBNeSB1c2UtY2FzZSBkb2VzIG5vdCB3YXJy
YW50IGFkZGluZyB0aGlzLiANCkkgaGF2ZSBubyBuZWVkIGZvciBzY2FubmluZyBvbmx5IGNlcnRh
aW4gYW1vdW50IG9mIGJpdHMuDQoNCkkgdGhpbmsgSSBhY3R1YWxseSB0cmllZCB1c2luZyBod2Vp
Z2h0KCkgYXQgc29tZSBwb2ludCBidXQgZG9uJ3QgcmVhbGx5IA0KcmVtZW1iZXIgd2h5IEkgcm9s
bGVkIHRoZSBzaW5nbGVfYml0X3NldC4gKEkgcmVtZW1iZXIgdGhlIGh3ZWlnaHQoKSANCnVzYWdl
IGJlY2F1c2UgSSBoYWQgdG8gZG8gc29tZSBnb29nbGluZyBhcyBJIGhhZCBuZXZlciBoZWFyZCB0
ZXJtIA0KaGFtbWluZyB3ZWlnaHQgYmVmb3JlKS4NCg0KSSdsbCBzZWUgaG93IGl0IHdvcmtzIG91
dCBhbmQgaWYgKHdoZW4pIGl0IGRvZXMgSSdsbCByZXNwaW4gdGhlIHNlcmllcyANCncvbyB0aGlz
IGFzIHlvdSBzdWdnZXN0ZWQuIFNvIHRoYW5rcy4NCg0KLS1NYXR0aQ0KDQotLSANClRoZSBMaW51
eCBLZXJuZWwgZ3V5IGF0IFJPSE0gU2VtaWNvbmR1Y3RvcnMNCg0KTWF0dGkgVmFpdHRpbmVuLCBM
aW51eCBkZXZpY2UgZHJpdmVycw0KUk9ITSBTZW1pY29uZHVjdG9ycywgRmlubGFuZCBTV0RDDQpL
aXZpaGFyanVubGVua2tpIDFFDQo5MDIyMCBPVUxVDQpGSU5MQU5EDQoNCn5+IHRoaXMgeWVhciBp
cyB0aGUgeWVhciBvZiBhIHNpZ25hdHVyZSB3cml0ZXJzIGJsb2NrIH5+DQo=
