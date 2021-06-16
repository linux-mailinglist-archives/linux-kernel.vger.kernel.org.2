Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A161D3A8EB2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 04:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbhFPCIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 22:08:38 -0400
Received: from mg.richtek.com ([220.130.44.152]:52640 "EHLO mg.richtek.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230195AbhFPCIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 22:08:36 -0400
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 192.168.10.47
        by mg.richtek.com with MailGates ESMTP Server V5.0(7286:0:AUTH_RELAY)
        (envelope-from <cy_huang@richtek.com>); Wed, 16 Jun 2021 10:06:22 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5; Wed, 16 Jun 2021
 10:06:22 +0800
Received: from ex3.rt.l ([fe80::ede0:40a5:8f78:963e]) by ex3.rt.l
 ([fe80::ede0:40a5:8f78:963e%2]) with mapi id 15.02.0858.010; Wed, 16 Jun 2021
 10:06:22 +0800
From:   =?utf-8?B?Y3lfaHVhbmco6buD5ZWf5Y6fKQ==?= <cy_huang@richtek.com>
To:     "axel.lin@ingics.com" <axel.lin@ingics.com>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "u0084500@gmail.com" <u0084500@gmail.com>
Subject: Re: [PATCH] regulator: rt6160: Fix setting suspend voltage
Thread-Topic: [PATCH] regulator: rt6160: Fix setting suspend voltage
Thread-Index: AQHXYk2Hz5pULeIqLUG4S8LZg2FxQKsVXbAA
Date:   Wed, 16 Jun 2021 02:06:22 +0000
Message-ID: <1623809182.3584.5.camel@richtek.com>
References: <20210616011816.3479406-1-axel.lin@ingics.com>
In-Reply-To: <20210616011816.3479406-1-axel.lin@ingics.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
x-originating-ip: [192.168.8.48]
Content-Type: text/plain; charset="utf-8"
Content-ID: <486A1A49EB487645B932D048450C5812@rt.l>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBUaGUgdnNlbCBhY3RpdmUgbGV2ZWwgaXMgZm9yIHRoZSBub3JtYWwgdm9sdGFnZSwgdGhlIG9w
cG9zaXRlIGxldmVsIGlzDQo+IHRoZSBzdXNwZW5kIHZvbHRhZ2UuDQo+DQo+IFNpZ25lZC1vZmYt
Ynk6IEF4ZWwgTGluIDxheGVsLmxpbkBpbmdpY3MuY29tPg0KPiAtLS0NCj4gSGkgQ2hpWXVhbiwN
Cj4gSSB0aGluayBmaXggaXQgdGhpcyB3YXkgbWFrZSB0aGUgaW50ZW50aW9uIG1vcmUgY2xlYXIu
DQo+DQo+ICBkcml2ZXJzL3JlZ3VsYXRvci9ydDYxNjAtcmVndWxhdG9yLmMgfCA4ICsrKysrKyst
DQo+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+DQpU
aHguIEl0J3MgbW9yZSBpbnR1aXRpdmUuDQoNClJldmlld2VkLWJ5OiBDaGlZdWFuIEh1YW5nIDxj
eV9odWFuZ0ByaWNodGVrLmNvbT4NCg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9yZWd1bGF0b3Iv
cnQ2MTYwLXJlZ3VsYXRvci5jIGIvZHJpdmVycy9yZWd1bGF0b3IvcnQ2MTYwLQ0KPiByZWd1bGF0
b3IuYw0KPiBpbmRleCBjY2QwMjNkYTQzMTguLjVkN2IwZTdhZDY5YSAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9yZWd1bGF0b3IvcnQ2MTYwLXJlZ3VsYXRvci5jDQo+ICsrKyBiL2RyaXZlcnMvcmVn
dWxhdG9yL3J0NjE2MC1yZWd1bGF0b3IuYw0KPiBAQCAtMTI4LDEzICsxMjgsMTkgQEAgc3RhdGlj
IHVuc2lnbmVkIGludCBydDYxNjBfZ2V0X21vZGUoc3RydWN0IHJlZ3VsYXRvcl9kZXYNCj4gKnJk
ZXYpDQo+ICBzdGF0aWMgaW50IHJ0NjE2MF9zZXRfc3VzcGVuZF92b2x0YWdlKHN0cnVjdCByZWd1
bGF0b3JfZGV2ICpyZGV2LCBpbnQgdVYpDQo+ICB7DQo+ICBzdHJ1Y3QgcmVnbWFwICpyZWdtYXAg
PSByZGV2X2dldF9yZWdtYXAocmRldik7DQo+ICt1bnNpZ25lZCBpbnQgc3VzcGVuZF92c2VsX3Jl
ZzsNCj4gIGludCB2c2VsOw0KPg0KPiAgdnNlbCA9IHJlZ3VsYXRvcl9tYXBfdm9sdGFnZV9saW5l
YXIocmRldiwgdVYsIHVWKTsNCj4gIGlmICh2c2VsIDwgMCkNCj4gIHJldHVybiB2c2VsOw0KPg0K
PiAtcmV0dXJuIHJlZ21hcF91cGRhdGVfYml0cyhyZWdtYXAsIHJkZXYtPmRlc2MtPnZzZWxfcmVn
LA0KPiAraWYgKHJkZXYtPmRlc2MtPnZzZWxfcmVnID09IFJUNjE2MF9SRUdfVlNFTEwpDQo+ICtz
dXNwZW5kX3ZzZWxfcmVnID0gUlQ2MTYwX1JFR19WU0VMSDsNCj4gK2Vsc2UNCj4gK3N1c3BlbmRf
dnNlbF9yZWcgPSBSVDYxNjBfUkVHX1ZTRUxMOw0KPiArDQo+ICtyZXR1cm4gcmVnbWFwX3VwZGF0
ZV9iaXRzKHJlZ21hcCwgc3VzcGVuZF92c2VsX3JlZywNCj4gICAgUlQ2MTYwX1ZTRUxfTUFTSywg
dnNlbCk7DQo+ICB9DQo+DQoqKioqKioqKioqKioqIEVtYWlsIENvbmZpZGVudGlhbGl0eSBOb3Rp
Y2UgKioqKioqKioqKioqKioqKioqKioNCg0KVGhlIGluZm9ybWF0aW9uIGNvbnRhaW5lZCBpbiB0
aGlzIGUtbWFpbCBtZXNzYWdlIChpbmNsdWRpbmcgYW55IGF0dGFjaG1lbnRzKSBtYXkgYmUgY29u
ZmlkZW50aWFsLCBwcm9wcmlldGFyeSwgcHJpdmlsZWdlZCwgb3Igb3RoZXJ3aXNlIGV4ZW1wdCBm
cm9tIGRpc2Nsb3N1cmUgdW5kZXIgYXBwbGljYWJsZSBsYXdzLiBJdCBpcyBpbnRlbmRlZCB0byBi
ZSBjb252ZXllZCBvbmx5IHRvIHRoZSBkZXNpZ25hdGVkIHJlY2lwaWVudChzKS4gQW55IHVzZSwg
ZGlzc2VtaW5hdGlvbiwgZGlzdHJpYnV0aW9uLCBwcmludGluZywgcmV0YWluaW5nIG9yIGNvcHlp
bmcgb2YgdGhpcyBlLW1haWwgKGluY2x1ZGluZyBpdHMgYXR0YWNobWVudHMpIGJ5IHVuaW50ZW5k
ZWQgcmVjaXBpZW50KHMpIGlzIHN0cmljdGx5IHByb2hpYml0ZWQgYW5kIG1heSBiZSB1bmxhd2Z1
bC4gSWYgeW91IGFyZSBub3QgYW4gaW50ZW5kZWQgcmVjaXBpZW50IG9mIHRoaXMgZS1tYWlsLCBv
ciBiZWxpZXZlIHRoYXQgeW91IGhhdmUgcmVjZWl2ZWQgdGhpcyBlLW1haWwgaW4gZXJyb3IsIHBs
ZWFzZSBub3RpZnkgdGhlIHNlbmRlciBpbW1lZGlhdGVseSAoYnkgcmVwbHlpbmcgdG8gdGhpcyBl
LW1haWwpLCBkZWxldGUgYW55IGFuZCBhbGwgY29waWVzIG9mIHRoaXMgZS1tYWlsIChpbmNsdWRp
bmcgYW55IGF0dGFjaG1lbnRzKSBmcm9tIHlvdXIgc3lzdGVtLCBhbmQgZG8gbm90IGRpc2Nsb3Nl
IHRoZSBjb250ZW50IG9mIHRoaXMgZS1tYWlsIHRvIGFueSBvdGhlciBwZXJzb24uIFRoYW5rIHlv
dSENCg==
