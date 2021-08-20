Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA9B3F270E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 08:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238617AbhHTGtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 02:49:15 -0400
Received: from mail-eopbgr1310047.outbound.protection.outlook.com ([40.107.131.47]:43904
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231998AbhHTGtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 02:49:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YThGy7LteuVLbR7eMGvtHnijvEo5qK/27jv/0dEGwublLrUZH1JeY33sezDOCXm35XkyT+9/r2pBXRpAZK5FtlYW6csgPfI4codhaqV5PQ0IKALK8ZbRbbQ6dyH24oyvitve1FbSDoFkGP58STIMjuldhbdnRx9JXUWJ6ynaMqpg8ikBtrkpkEB7A+lSXXrRw6ynta67Lluo3VAigcDrtIFqXC73TZs8s4yYJwRWbGGA2d8BVfaUrQH1vK2lW7sLQeSgv0WpydUIuAXDx0BMtB5kbieQClAROEsOWIapLl4q/N+8IzH95ePEqNdv8lPjM8VYFW7ESdChbkE0DPU/OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6y5hXb+gfmbU4ZtKAYfS8D7TsjsJs2JopgUhKuIAQ0=;
 b=bdjfv23Yhd7ilLMazOp74PVzgCeDUhgE0Ltzp+mHU9AsG2pV0GUGm6JNaB1hoWALeeAOINCMfEeImLkrypjbyIjG+r71bDbHJNh7M3bqqopDFHnsDmM5lkhvsX0gPkdBos6G0L4BQ54L+4W5SlBFd37sgPXiCE8tgkyJ9qYaP8Eo5WBpm5q/wWLdi5smrIFiF9D2cvQ8rt2zdqoRQLvfZj0ZB4Bx/9uNSOGbosogzeKIjstiyxwxE1EXwEMDAr5w6PIaNxYeSv3w/DtkWyP3FgWxKrc75d/YddLtSUwoc1rFT/DO1O3NFMws5F9i7Zxw3DTOzyEPdZEDExI5BsUgfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6y5hXb+gfmbU4ZtKAYfS8D7TsjsJs2JopgUhKuIAQ0=;
 b=VRmFwUZqRJ1r62+HQyhCk6b0A1tWiYC+LZtc4EOuhJ82aqoHR7QDUN3gCSHBOj35xZcg8bMj++Of8n3zLAik/9/PCCco9ygEmNe+ZNh74CvUYO+2KVEdFxpAtxJSgTd6nvSnn5qgy3jtKbRAcjTCqQTr6fls9gq2t80rgCK9JK8=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TY2PR01MB2700.jpnprd01.prod.outlook.com (2603:1096:404:71::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.18; Fri, 20 Aug
 2021 06:48:33 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::4401:f9e:2afb:ebc0]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::4401:f9e:2afb:ebc0%7]) with mapi id 15.20.4415.024; Fri, 20 Aug 2021
 06:48:33 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     "osalvador@suse.de" <osalvador@suse.de>,
        "tdmackey@twitter.com" <tdmackey@twitter.com>,
        "david@redhat.com" <david@redhat.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [v2 PATCH 3/3] mm: hwpoison: dump page for unhandlable page
Thread-Topic: [v2 PATCH 3/3] mm: hwpoison: dump page for unhandlable page
Thread-Index: AQHXlLzdYeiiCRicSE2McTnzojcv9qt79U4A
Date:   Fri, 20 Aug 2021 06:48:33 +0000
Message-ID: <20210820064832.GA63355@hori.linux.bs1.fc.nec.co.jp>
References: <20210819054116.266126-1-shy828301@gmail.com>
 <20210819054116.266126-3-shy828301@gmail.com>
In-Reply-To: <20210819054116.266126-3-shy828301@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d7ddf732-f7f1-4641-ec44-08d963a6870a
x-ms-traffictypediagnostic: TY2PR01MB2700:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB270041820E84D8A68C3948C8E7C19@TY2PR01MB2700.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B0GXFcz49E99Arl/bJ1OihPhJQ2IwZAVkgvUZv6c/slN5i+8Ru+BOgjUeUjetw/AmGoSC+tkKENKQ57zMuAo7CWnGVrCMqZobaguhk/dXWGf1sdnb0pHy4A5hsxV8TFjb6iM7X8w/G3/aKsMm+dive2z9J6jchZuGb0/68ixbjahEOpzbVNb8HTK7SQ9tFsB0zh0IU3vVVY2s0sirncEs3IV6Hua3XgpqJoQtOezknGr0k9y/pnbr7Zu/4hDxpXKaKRRqWeHUlOG+YegGWbeqSLwwztJs72PzrBcKB3GSmPgXmie37DfkHsd5TgGdZqPrkux4dAXB/Qs1S9EoXzGyP6W2XnkAisV5hVw9udIZMefCT1KTlfjfpRIe26Nq6oqvQ4lqXv8OHNFSPJzo6EgGK2GLuE8Rlo7FFy8Dwz0nwUSanRMrqZ2ZimwIOucGqd4yuk07yndntyQNDgGGuOtcJ28r9CiLDdVroTbJv9tSHT7m7u+pBXNwxoIq01WP5v35xYU2qARhXa9cb9WbWLrx+M/zZTVyPmiDAmEh6bw76WmNCUrOSxWpjjVEOi9ohIzJzY8Z+UlFcXaBpOapf40Wzo5DScIec/+bCfMuO7LUdHeFBn6YhQhfl3vNGyhKzDYK7rl0Iujwmta8+BQzbtMX6skg1WWzneND4U2j/Cdl/zNpJHmmqKxo7vNZJ33VTEiHH9y/7vQtBkS97rb56EdjQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(66476007)(76116006)(66446008)(66556008)(38100700002)(2906002)(64756008)(86362001)(8936002)(8676002)(5660300002)(4326008)(6506007)(122000001)(85182001)(83380400001)(33656002)(9686003)(316002)(6486002)(38070700005)(26005)(1076003)(55236004)(71200400001)(6916009)(54906003)(508600001)(186003)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVpCemRKdmFUWUx2b0wvclMxQlB0bXhGNHJPTm9CWkRxMWJFTHVLWWpHQkxE?=
 =?utf-8?B?SWc3SzlOcFZLRkg5RWFuWnY3bW1KYTM1VVl6alJldG5vK3Vzb2NtdmRaWmNJ?=
 =?utf-8?B?eHdEOWRSb2cvZ2doYXMyN0NtRk96Mk9IMDE4a1oyQmlUcUV4MzJ3eTV3MS9h?=
 =?utf-8?B?NnIrY25PV2RyeFBYczhBanZONzRwWlRHNlZ0aFU1bGYrQ0lJQ3FydFowOHhU?=
 =?utf-8?B?UXVBNk9EemJYT1UrTzhsRjJSaDZBaFAweFJLVFZnK3dFV1A0bXhua3NWY0Qz?=
 =?utf-8?B?UWRwQU5CSXVpUHhweGtUOTRRTXFNMlpCK2J5MElVYThTZDZxZDMwcERqK3J2?=
 =?utf-8?B?d0xpMXpPT2ozMkpuNTY0bTlZR2lVb2F0WmpmczZ1NmNFcDN1ZmJqc2tRZ0dO?=
 =?utf-8?B?YjZwQlU3QkhvblJYd2FWVzY1Ym5wN0gxTnpkclFva2ZPZi95TUEvanJLT2hR?=
 =?utf-8?B?Q2ZmdUszbldJdHVBMkRSU2tPWEY3dHJnc3ptbjFOODJ3M3c3OTRpbU1yWDVs?=
 =?utf-8?B?Sm5YaGFBZXUzY3B3SWNnWjhWcGdHN2VuNFc1ZjBhYzBzZFRKelZ0Sk5zWGQ3?=
 =?utf-8?B?Y096SHdRSjk5OGxqcVhZK0l0cm5oaTl4K3Uxb2E5S1h1d3BwMEt0aHdsT1h0?=
 =?utf-8?B?KytVeFNwQXZ5RTFWZDI5RUNCM1lIdzduQk9SZVZNQm94eWNXQ0NzNzFRMzF3?=
 =?utf-8?B?eDVtTnp3WndReDE2UzM5OXVBWjRrRC82elBoWk5kUEMzRG1ONFNEQSs3YTNy?=
 =?utf-8?B?U2FTU0VpRTZHNXoyRU4wNm5hYmFqVUdxb2xlclFIZUF0dzYxL3kwbHM1RzQ1?=
 =?utf-8?B?d21tQmJKOXNEeWNDMUxUamxicHpXREJHdG9lM2JIeXlsa0hqM2VUK0FwdStB?=
 =?utf-8?B?eEgyV1JQMGpvUy9zaURmTUM1N3psQldBanVmTlZLVGlheXpROHErZ0QvVkUv?=
 =?utf-8?B?RmU4YU9xQ29iWGRSeHZaazlYVW5KNjZvQlErR2VyWGl5N3BTMjBkNGUyWXh1?=
 =?utf-8?B?bVQ3TDVpTFlVbDU5MWl0aFdCakRnNkZJOUx0emNRdmwzUEFhOHFaVmpkaFJX?=
 =?utf-8?B?aFpkc0wyalQxQktKdW5DYjQ1bHY4YXNMRDU2eEt2NkdyS0VUN0htQXdud3Ur?=
 =?utf-8?B?MjhSUWFXTkpBdWNlMFFVWW9nb2dzc3cwTFAyMVVMdG55TkpubEJkM3dlWDdv?=
 =?utf-8?B?aUQvQjBZV3ZkU2EwSmZKY1QrVExiaCtYcXZBQXk3WHpFUlVkT1JtMDNDK1FP?=
 =?utf-8?B?bFVTKzFzellWcyt4Q051OGRSRHFhSkxIUW1XRmpwbmd3L3BITDhMWGhxTDk5?=
 =?utf-8?B?UjJCOTJGR09Sd0k4U2dkTDdOMG81bWxUS2hwbnBaZEJPMzgrVHFxbE40bUhk?=
 =?utf-8?B?cXlUU0dYeEExTzNBaUZqRWlEZ0tCR3FBQ0RiL01MWlJoLzVubE1WVW5nTkxu?=
 =?utf-8?B?S1dEUUpFSk1xY2d1eUtyaGpDWWVNMGEvV0tmYnNIMW5LWUozNGRZdzhuU01l?=
 =?utf-8?B?UUR5bFE1VFhjZzFoVXNSOXZnMm4wQTdweFp0Qm1mSW5ZR0kxNGttSGhrS2w2?=
 =?utf-8?B?WE8raHRxS3dxYkVTYzdlK0VEQ3htSHNKaWxLb05TL215a1NUVDQwTHpYemRW?=
 =?utf-8?B?OStCUkpVL2dQamtaZk1uUXUyRFExcDR3Z3hRdGZTT0dvQWVINmhTMDlFNk1P?=
 =?utf-8?B?eVliOUNzeXEyWmVzYUM0WUNvWkdiSTlndTdxMzNFWDJueTlPVmswZ2NMVUVL?=
 =?utf-8?B?aDA4SmhCVlVwN1o2clVxNjYvcEpLS215NzJXamc2M1EyT2xlVHdBTTVENDN5?=
 =?utf-8?B?azVuU3R4RlVoM1JwUVpZQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <37F2AF385344BB44871FA85A59767982@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7ddf732-f7f1-4641-ec44-08d963a6870a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2021 06:48:33.0437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JEYeziJ4Sv9D7OdcjG5fDAN/cGdmMcQPQkOdLTriaq8zMUiMVxc72w71MAzsZFb8WtwpL1eR/8q0bDc7WkPBpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2700
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBBdWcgMTgsIDIwMjEgYXQgMTA6NDE6MTZQTSAtMDcwMCwgWWFuZyBTaGkgd3JvdGU6
DQo+IEN1cnJlbnRseSBqdXN0IHZlcnkgc2ltcGxlIG1lc3NhZ2UgaXMgc2hvd24gZm9yIHVuaGFu
ZGxhYmxlIHBhZ2UsIGUuZy4NCj4gbm9uLUxSVSBwYWdlLCBsaWtlOg0KPiBzb2Z0X29mZmxpbmU6
IDB4MTQ2OWYyOiB1bmtub3duIG5vbiBMUlUgcGFnZSB0eXBlIDVmZmZmMDAwMDAwMDAwMCAoKQ0K
PiANCj4gSXQgaXMgbm90IHZlcnkgaGVscGZ1bCBmb3IgZnVydGhlciBkZWJ1ZywgY2FsbGluZyBk
dW1wX3BhZ2UoKSBjb3VsZCBzaG93DQo+IG1vcmUgdXNlZnVsIGluZm9ybWF0aW9uLg0KPiANCj4g
Q2FsbGluZyBkdW1wX3BhZ2UoKSBpbiBnZXRfYW55X3BhZ2UoKSBpbiBvcmRlciB0byBub3QgZHVw
bGljYXRlIHRoZSBjYWxsDQo+IGluIGEgY291cGxlIG9mIGRpZmZlcmVudCBwbGFjZXMuICBJdCBt
YXkgYmUgY2FsbGVkIHdpdGggcGNwIGRpc2FibGVkIGFuZA0KPiBob2xkaW5nIG1lbW9yeSBob3Rw
bHVnIGxvY2ssIGl0IHNob3VsZCBiZSBub3QgYSBiaWcgZGVhbCBzaW5jZSBod3BvaXNvbg0KPiBo
YW5kbGVyIGlzIG5vdCBjYWxsZWQgdmVyeSBvZnRlbi4NCj4gDQo+IFN1Z2dlc3RlZC1ieTogTWF0
dGhldyBXaWxjb3ggPHdpbGx5QGluZnJhZGVhZC5vcmc+DQo+IENjOiBOYW95YSBIb3JpZ3VjaGkg
PG5hb3lhLmhvcmlndWNoaUBuZWMuY29tPg0KPiBDYzogT3NjYXIgU2FsdmFkb3IgPG9zYWx2YWRv
ckBzdXNlLmRlPg0KPiBTaWduZWQtb2ZmLWJ5OiBZYW5nIFNoaSA8c2h5ODI4MzAxQGdtYWlsLmNv
bT4NCj4gLS0tDQo+ICBtbS9tZW1vcnktZmFpbHVyZS5jIHwgMyArKysNCj4gIDEgZmlsZSBjaGFu
Z2VkLCAzIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9tbS9tZW1vcnktZmFpbHVy
ZS5jIGIvbW0vbWVtb3J5LWZhaWx1cmUuYw0KPiBpbmRleCA3Y2ZhMTM0YjEzNzAuLjYwZGY4ZmNk
MDQ0NCAxMDA2NDQNCj4gLS0tIGEvbW0vbWVtb3J5LWZhaWx1cmUuYw0KPiArKysgYi9tbS9tZW1v
cnktZmFpbHVyZS5jDQo+IEBAIC0xMjI4LDYgKzEyMjgsOSBAQCBzdGF0aWMgaW50IGdldF9hbnlf
cGFnZShzdHJ1Y3QgcGFnZSAqcCwgdW5zaWduZWQgbG9uZyBmbGFncykNCj4gIAkJcmV0ID0gLUVJ
TzsNCj4gIAl9DQo+ICBvdXQ6DQo+ICsJaWYgKHJldCA9PSAtRUlPKQ0KPiArCQlkdW1wX3BhZ2Uo
cCwgImh3cG9pc29uOiB1bmhhbmRsYWJsZSBwYWdlIik7DQo+ICsNCg0KSSBmZWVsIHRoYXQgNCBj
YWxsZXJzIG9mIGdldF9od3BvaXNvbl9wYWdlKCkgYXJlIGluIHRoZSBkaWZmZXJlbnQgY29udGV4
dCwNCnNvIGl0IG1pZ2h0IGJlIGJldHRlciB0byBjb25zaWRlciB0aGVtIHNlcGFyYXRlbHkgdG8g
YWRkIGR1bXBfcGFnZSgpIG9yIG5vdC4NCnNvZnRfb2ZmbGluZV9wYWdlKCkgc3RpbGwgcHJpbnRz
IG91dCAiJXM6ICUjbHg6IHVua25vd24gcGFnZSB0eXBlOiAlbHggKCVwR3ApIg0KbWVzc2FnZSwg
d2hpY2ggbWlnaHQgYmUgZHVwbGljYXRlIHNvIHRoaXMgcHJpbnRrKCkgbWF5IGJlIGRyb3BwZWQu
DQpJbiBtZW1vcnlfZmFpbHVyZV9odWdldGxiKCkgYW5kIG1lbW9yeV9mYWlsdXJlKCksIHdlIGNh
biBjYWxsIGR1bXBfcGFnZSgpIGFmdGVyDQphY3Rpb25fcmVzdWx0KCkuICB1bnBvaXNvbl9tZW1v
cnkoKSBkb2Vzbid0IG5lZWQgZHVtcF9wYWdlKCkgYXQgYWxsIGJlY2F1c2UNCml0J3MgcmVsYXRl
ZCB0byBhbHJlYWR5IGh3cG9pc29uZWQgcGFnZS4NCg0KVGhhbmtzLA0KTmFveWEgSG9yaWd1Y2hp
