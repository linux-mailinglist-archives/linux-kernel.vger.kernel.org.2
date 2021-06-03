Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C06F39A45A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 17:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbhFCPUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 11:20:37 -0400
Received: from mg.richtek.com ([220.130.44.152]:47188 "EHLO mg.richtek.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231213AbhFCPUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 11:20:37 -0400
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 192.168.10.47
        by mg.richtek.com with MailGates ESMTP Server V5.0(4323:0:AUTH_RELAY)
        (envelope-from <cy_huang@richtek.com>); Thu, 03 Jun 2021 23:18:45 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5; Thu, 3 Jun 2021
 23:18:44 +0800
Received: from ex3.rt.l ([fe80::ede0:40a5:8f78:963e]) by ex3.rt.l
 ([fe80::ede0:40a5:8f78:963e%2]) with mapi id 15.02.0858.010; Thu, 3 Jun 2021
 23:18:44 +0800
From:   =?utf-8?B?Y3lfaHVhbmco6buD5ZWf5Y6fKQ==?= <cy_huang@richtek.com>
To:     "axel.lin@ingics.com" <axel.lin@ingics.com>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "u0084500@gmail.com" <u0084500@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>
Subject: Re: [PATCH] regulator: rt6160: Convert to use
 regulator_set_ramp_delay_regmap
Thread-Topic: [PATCH] regulator: rt6160: Convert to use
 regulator_set_ramp_delay_regmap
Thread-Index: AQHXWFw5/k6L4YuRIk+OmEhH2dJ5iKsBjWCAgAACLwCAAAOxAIAATWcA
Date:   Thu, 3 Jun 2021 15:18:44 +0000
Message-ID: <1622733524.3635.10.camel@richtek.com>
References: <20210603093809.1108629-1-axel.lin@ingics.com>
         <1622715641.1034.5.camel@richtek.com>
         <CAFRkauDs6nyuboPBf9Q-=KDFkSjwQ4z9mDjzm3o95uzdu5bKCw@mail.gmail.com>
         <1622716902.1034.15.camel@richtek.com>
In-Reply-To: <1622716902.1034.15.camel@richtek.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
x-originating-ip: [192.168.8.47]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8BF7CFB6D14DC24AA7D037F1B8046158@rt.l>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksPiA+DQo+ID4gY3lfaHVhbmco6buD5ZWf5Y6fKSA8Y3lfaHVhbmdAcmljaHRlay5jb20+IOaW
vCAyMDIx5bm0NuaciDPml6Ug6YCx5ZubIOS4i+WNiDY6MjDlr6vpgZPvvJoNCj4gPiA+DQo+ID4g
Pg0KPiA+ID4NCj4gPiA+IEhpLCBBeGVsOj4gVXNlIHJlZ3VsYXRvcl9zZXRfcmFtcF9kZWxheV9y
ZWdtYXAgaW5zdGVhZCBvZiBvcGVuLWNvZGVkLg0KPiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPg0K
PiA+ID4gVGhlcmUncyBzb21lIHJlYXNvbi4NCj4gPiA+IFlvdSBjYW4gcmVmZXIgdG8gaHR0cHM6
Ly9sa21sLm9yZy9sa21sLzIwMjEvNi8xLzExNDUuDQo+ID4gPg0KPiA+ID4gSXQncyBiZWNhdXNl
IG91ciByYW1wIHZhbHVlIG9yZGVyIGlzIGZyb20gc21hbGwgdG8gbGFyZ2UsIG5vdCBsYXJnZSB0
bw0KPiA+ID4gc21hbGwuDQo+ID4gPiBJdCBjb25mbGljdHMgd2l0aCBmaW5kX2Nsb3Nlc3RfYmln
Z2VyIHZhbHVlIGNob3NlbiBsb2dpYy4NCj4gPiBJIGhhdmUgdmVyaWZpZWQgdGhlIHJ0NjE2MF9z
ZXRfcmFtcF9kZWxheSgpIGJlaGF2aW9yIGV4YWN0bHkgdGhlIHNhbWUgYXMNCj4gPiByZWd1bGF0
b3Jfc2V0X3JhbXBfZGVsYXlfcmVnbWFwLiAoYm90aCBmdW5jdGlvbnMgZ2V0IHRoZSBzYW1lIHNl
bGVjdG9yDQo+ID4gZm9yIGEgZ2l2ZW4gZGVsYXkpDQo+ID4NCj4gPiBDb3VsZCB5b3UgY2hlY2sg
aWYgdGhpcyBwYXRjaCB3b3Jrcz8NCj4gU3VyZS4NCkFmdGVyIG15IHRlc3Qgc2FtcGxlIGNvZGUs
IGJlbG93J3MgdGhlIHJlc3VsdC4NCmFzY2VuZGluZyBbMTAwMCAyNTAwIDUwMDAgMTAwMDBdDQp0
YXJnZXQgPSAgMTAwMCA9PnNlbCA9IDANCnRhcmdldCA9ICAyNTAwID0+c2VsID0gMQ0KdGFyZ2V0
ID0gIDUwMDAgPT5zZWwgPSAyDQp0YXJnZXQgPSAxMDAwMCA9PnNlbCA9IDMNCnRhcmdldCA9ICAx
NzAwID0+c2VsID0gMQ0KdGFyZ2V0ID0gIDI3NTAgPT5zZWwgPSAyDQp0YXJnZXQgPSAgNzUwMCA9
PnNlbCA9IDMNCnRhcmdldCA9IDE1MDAwID0+ZmFpbGVkIHRvIGZpbmQgYmVzdCBzZWxlY3QsIHNl
bCA9IDMNCnRhcmdldCA9ICAgICAwID0+c2VsID0gMA0KZGVzY2VuZGluZyBbMTAwMDAgNTAwMCAy
NTAwIDEwMDBdDQp0YXJnZXQgPSAgMTAwMCA9PnNlbCA9IDMNCnRhcmdldCA9ICAyNTAwID0+c2Vs
ID0gMg0KdGFyZ2V0ID0gIDUwMDAgPT5zZWwgPSAxDQp0YXJnZXQgPSAxMDAwMCA9PnNlbCA9IDAN
CnRhcmdldCA9ICAxNzAwID0+c2VsID0gMg0KdGFyZ2V0ID0gIDI3NTAgPT5zZWwgPSAxDQp0YXJn
ZXQgPSAgNzUwMCA9PnNlbCA9IDANCnRhcmdldCA9IDE1MDAwID0+ZmFpbGVkIHRvIGZpbmQgYmVz
dCBzZWxlY3QsIHNlbCA9IDANCnRhcmdldCA9ICAgICAwID0+c2VsID0gMw0KDQoNCkl0IG1lYW5z
IHdoZW4gdGFyZ2V0IGlzIGluIHJhbmdlIG9yIGV2ZW4gb3ZlciwgdGhlIHJlc3VsdCBhcmUgYWxs
IGNvcnJlY3QuDQpCdXQgbGlrZSBhcyB0aGUgcmFtcCB0YXJnZXQgaXMgZXF1YWwgdG8gMCwgdGhl
IHNlbGVjdGlvbiB3aWxsIG9ubHkgY2hvb3NlIHRoZSBtaW5pbXVtIG9uZS4NCldoZW4gdGhlIHJh
bXAgdGFyZ2V0IGlzIGVxdWFsIHRvIDAsIGl0IG1lYW5zIHRoZSB1c2VyIHdhbnQgdG8gZGlzYWJs
ZSB0aGUgcmFtbXBwaW5nIGZ1bmN0aW9uLg0KDQpBcyBJIGtub3csIGlmIHRhcmdldCBpcyBlcXVh
bCB0byAwLCBpdCBtdXN0IGZpbmQgdGhlIGZhc3Rlc3QgcmFtcHBpbmcgdmFsdWUgYXMgdGhlIGJl
c3Qgc2VsZWN0aW9uLg0KPiA+DQo+ID4NCj4gPiBUaGFua3MsDQo+ID4gQXhlbA0KKioqKioqKioq
KioqKiBFbWFpbCBDb25maWRlbnRpYWxpdHkgTm90aWNlICoqKioqKioqKioqKioqKioqKioqDQoN
ClRoZSBpbmZvcm1hdGlvbiBjb250YWluZWQgaW4gdGhpcyBlLW1haWwgbWVzc2FnZSAoaW5jbHVk
aW5nIGFueSBhdHRhY2htZW50cykgbWF5IGJlIGNvbmZpZGVudGlhbCwgcHJvcHJpZXRhcnksIHBy
aXZpbGVnZWQsIG9yIG90aGVyd2lzZSBleGVtcHQgZnJvbSBkaXNjbG9zdXJlIHVuZGVyIGFwcGxp
Y2FibGUgbGF3cy4gSXQgaXMgaW50ZW5kZWQgdG8gYmUgY29udmV5ZWQgb25seSB0byB0aGUgZGVz
aWduYXRlZCByZWNpcGllbnQocykuIEFueSB1c2UsIGRpc3NlbWluYXRpb24sIGRpc3RyaWJ1dGlv
biwgcHJpbnRpbmcsIHJldGFpbmluZyBvciBjb3B5aW5nIG9mIHRoaXMgZS1tYWlsIChpbmNsdWRp
bmcgaXRzIGF0dGFjaG1lbnRzKSBieSB1bmludGVuZGVkIHJlY2lwaWVudChzKSBpcyBzdHJpY3Rs
eSBwcm9oaWJpdGVkIGFuZCBtYXkgYmUgdW5sYXdmdWwuIElmIHlvdSBhcmUgbm90IGFuIGludGVu
ZGVkIHJlY2lwaWVudCBvZiB0aGlzIGUtbWFpbCwgb3IgYmVsaWV2ZSB0aGF0IHlvdSBoYXZlIHJl
Y2VpdmVkIHRoaXMgZS1tYWlsIGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgaW1t
ZWRpYXRlbHkgKGJ5IHJlcGx5aW5nIHRvIHRoaXMgZS1tYWlsKSwgZGVsZXRlIGFueSBhbmQgYWxs
IGNvcGllcyBvZiB0aGlzIGUtbWFpbCAoaW5jbHVkaW5nIGFueSBhdHRhY2htZW50cykgZnJvbSB5
b3VyIHN5c3RlbSwgYW5kIGRvIG5vdCBkaXNjbG9zZSB0aGUgY29udGVudCBvZiB0aGlzIGUtbWFp
bCB0byBhbnkgb3RoZXIgcGVyc29uLiBUaGFuayB5b3UhDQo=
