Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFAF03A0AE0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 05:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236640AbhFIDxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 23:53:15 -0400
Received: from mg.richtek.com ([220.130.44.152]:60490 "EHLO mg.richtek.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232341AbhFIDxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 23:53:14 -0400
X-Greylist: delayed 738 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Jun 2021 23:53:14 EDT
X-MailGates: (compute_score:DELIVER,40,3)
Received: from 192.168.8.21
        by mg.richtek.com with MailGates ESMTP Server V3.0(14682:0:AUTH_RELAY)
        (envelope-from <prvs=1791FA9C47=cy_huang@richtek.com>); Wed, 09 Jun 2021 11:43:58 +0800 (CST)
X-MailGates: (compute_score:DELIVER,40,3)
Received: from 192.168.10.47
        by mg.richtek.com with MailGates ESMTP Server V5.0(1380:0:AUTH_RELAY)
        (envelope-from <cy_huang@richtek.com>); Wed, 09 Jun 2021 11:38:57 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5; Wed, 9 Jun 2021
 11:38:56 +0800
Received: from ex3.rt.l ([fe80::ede0:40a5:8f78:963e]) by ex3.rt.l
 ([fe80::ede0:40a5:8f78:963e%2]) with mapi id 15.02.0858.010; Wed, 9 Jun 2021
 11:38:56 +0800
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
Thread-Index: AQHXWFw5/k6L4YuRIk+OmEhH2dJ5iKsBjWCAgAACLwCAAAOxAIAATWcAgACVXoCAACSqAIAAEnaAgAAmmICAAALjgIAACGeAgAeqSwCAAAGPgA==
Date:   Wed, 9 Jun 2021 03:38:56 +0000
Message-ID: <1623209884.3371.2.camel@richtek.com>
References: <20210603093809.1108629-1-axel.lin@ingics.com>
         <1622715641.1034.5.camel@richtek.com>
         <CAFRkauDs6nyuboPBf9Q-=KDFkSjwQ4z9mDjzm3o95uzdu5bKCw@mail.gmail.com>
         <1622716902.1034.15.camel@richtek.com>
         <1622733524.3635.10.camel@richtek.com>
         <CAFRkauCKoipBe4-QacQbjZgWuFrMPKdAfWB00Q6Lyw7xJ=6sfQ@mail.gmail.com>
         <1622773474.9011.14.camel@richtek.com>
         <CAFRkauCdRoChK-djEi+TzC4As5JzykPF=fb1YmDukEjWJG0K_g@mail.gmail.com>
         <1622785727.9011.17.camel@richtek.com>
         <CAFRkauAFVdxHcKkNzAW3uHhADwb2G-sdiLBUoZj+eOAXEV4rfA@mail.gmail.com>
         <1622788151.9011.20.camel@richtek.com>
         <CAFRkauAOCRPKHpzEfYx9ZtsvR+7QRtPdZpw71NtKQJFNw3BVfQ@mail.gmail.com>
In-Reply-To: <CAFRkauAOCRPKHpzEfYx9ZtsvR+7QRtPdZpw71NtKQJFNw3BVfQ@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
x-originating-ip: [192.168.8.48]
Content-Type: text/plain; charset="utf-8"
Content-ID: <304FEE10B0F8D74D8F354398E4DBC03A@rt.l>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5pa8IOS4ie+8jDIwMjEtMDYtMDkg5pa8IDExOjMyICswODAw77yMQXhlbCBMaW4g5o+Q5Yiw77ya
DQo+IGN5X2h1YW5nKOm7g+WVn+WOnykgPGN5X2h1YW5nQHJpY2h0ZWsuY29tPiDmlrwgMjAyMeW5
tDbmnIg05pelIOmAseS6lCDkuIvljYgyOjI55a+r6YGT77yaDQo+ID4NCj4gPg0KPiA+DQo+ID4g
5pa8IOS6lO+8jDIwMjEtMDYtMDQg5pa8IDEzOjU5ICswODAw77yMQXhlbCBMaW4g5o+Q5Yiw77ya
DQo+ID4NCj4gPiBjeV9odWFuZyjpu4PllZ/ljp8pIDxjeV9odWFuZ0ByaWNodGVrLmNvbT4g5pa8
IDIwMjHlubQ25pyINOaXpSDpgLHkupQg5LiL5Y2IMTo0OOWvq+mBk++8mg0KPiA+DQo+ID4NCj4g
Pg0KPiA+DQo+ID4g5pa8IOS6lO+8jDIwMjEtMDYtMDQg5pa8IDExOjMwICswODAw77yMQXhlbCBM
aW4g5o+Q5Yiw77yaDQo+ID4NCj4gPiBjeV9odWFuZyjpu4PllZ/ljp8pIDxjeV9odWFuZ0ByaWNo
dGVrLmNvbT4g5pa8IDIwMjHlubQ25pyINOaXpSDpgLHkupQg5LiK5Y2IMTA6Mjblr6vpgZPvvJoN
Cj4gPg0KPiA+DQo+ID4NCj4gPg0KPiA+IGN5X2h1YW5nKOm7g+WVn+WOnykgPGN5X2h1YW5nQHJp
Y2h0ZWsuY29tPiDmlrwgMjAyMeW5tDbmnIgz5pelIOmAseWbmyDkuIvljYgxMToxOOWvq+mBk++8
mg0KPiA+DQo+ID4NCj4gPiBIaSw+ID4NCj4gPg0KPiA+DQo+ID4gY3lfaHVhbmco6buD5ZWf5Y6f
KSA8Y3lfaHVhbmdAcmljaHRlay5jb20+IOaWvCAyMDIx5bm0NuaciDPml6Ug6YCx5ZubIOS4i+WN
iDY6MjDlr6vpgZPvvJoNCj4gPg0KPiA+DQo+ID4NCj4gPg0KPiA+IEhpLCBBeGVsOj4gVXNlIHJl
Z3VsYXRvcl9zZXRfcmFtcF9kZWxheV9yZWdtYXAgaW5zdGVhZCBvZiBvcGVuLWNvZGVkLg0KPiA+
DQo+ID4NCj4gPg0KPiA+DQo+ID4NCj4gPiBUaGVyZSdzIHNvbWUgcmVhc29uLg0KPiA+IFlvdSBj
YW4gcmVmZXIgdG8gaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMjEvNi8xLzExNDUuDQo+ID4NCj4g
PiBJdCdzIGJlY2F1c2Ugb3VyIHJhbXAgdmFsdWUgb3JkZXIgaXMgZnJvbSBzbWFsbCB0byBsYXJn
ZSwgbm90IGxhcmdlIHRvDQo+ID4gc21hbGwuDQo+ID4gSXQgY29uZmxpY3RzIHdpdGggZmluZF9j
bG9zZXN0X2JpZ2dlciB2YWx1ZSBjaG9zZW4gbG9naWMuDQo+ID4NCj4gPiBJIGhhdmUgdmVyaWZp
ZWQgdGhlIHJ0NjE2MF9zZXRfcmFtcF9kZWxheSgpIGJlaGF2aW9yIGV4YWN0bHkgdGhlIHNhbWUg
YXMNCj4gPiByZWd1bGF0b3Jfc2V0X3JhbXBfZGVsYXlfcmVnbWFwLiAoYm90aCBmdW5jdGlvbnMg
Z2V0IHRoZSBzYW1lIHNlbGVjdG9yDQo+ID4gZm9yIGEgZ2l2ZW4gZGVsYXkpDQo+ID4NCj4gPiBD
b3VsZCB5b3UgY2hlY2sgaWYgdGhpcyBwYXRjaCB3b3Jrcz8NCj4gPg0KPiA+IFN1cmUuDQo+ID4N
Cj4gPiBBZnRlciBteSB0ZXN0IHNhbXBsZSBjb2RlLCBiZWxvdydzIHRoZSByZXN1bHQuDQo+ID4g
YXNjZW5kaW5nIFsxMDAwIDI1MDAgNTAwMCAxMDAwMF0NCj4gPiB0YXJnZXQgPSAgMTAwMCA9PnNl
bCA9IDANCj4gPiB0YXJnZXQgPSAgMjUwMCA9PnNlbCA9IDENCj4gPiB0YXJnZXQgPSAgNTAwMCA9
PnNlbCA9IDINCj4gPiB0YXJnZXQgPSAxMDAwMCA9PnNlbCA9IDMNCj4gPiB0YXJnZXQgPSAgMTcw
MCA9PnNlbCA9IDENCj4gPiB0YXJnZXQgPSAgMjc1MCA9PnNlbCA9IDINCj4gPiB0YXJnZXQgPSAg
NzUwMCA9PnNlbCA9IDMNCj4gPiB0YXJnZXQgPSAxNTAwMCA9PmZhaWxlZCB0byBmaW5kIGJlc3Qg
c2VsZWN0LCBzZWwgPSAzDQo+ID4gdGFyZ2V0ID0gICAgIDAgPT5zZWwgPSAwDQo+ID4gZGVzY2Vu
ZGluZyBbMTAwMDAgNTAwMCAyNTAwIDEwMDBdDQo+ID4gdGFyZ2V0ID0gIDEwMDAgPT5zZWwgPSAz
DQo+ID4gdGFyZ2V0ID0gIDI1MDAgPT5zZWwgPSAyDQo+ID4gdGFyZ2V0ID0gIDUwMDAgPT5zZWwg
PSAxDQo+ID4gdGFyZ2V0ID0gMTAwMDAgPT5zZWwgPSAwDQo+ID4gdGFyZ2V0ID0gIDE3MDAgPT5z
ZWwgPSAyDQo+ID4gdGFyZ2V0ID0gIDI3NTAgPT5zZWwgPSAxDQo+ID4gdGFyZ2V0ID0gIDc1MDAg
PT5zZWwgPSAwDQo+ID4gdGFyZ2V0ID0gMTUwMDAgPT5mYWlsZWQgdG8gZmluZCBiZXN0IHNlbGVj
dCwgc2VsID0gMA0KPiA+IHRhcmdldCA9ICAgICAwID0+c2VsID0gMw0KPiA+DQo+ID4NCj4gPiBJ
dCBtZWFucyB3aGVuIHRhcmdldCBpcyBpbiByYW5nZSBvciBldmVuIG92ZXIsIHRoZSByZXN1bHQg
YXJlIGFsbCBjb3JyZWN0Lg0KPiA+IEJ1dCBsaWtlIGFzIHRoZSByYW1wIHRhcmdldCBpcyBlcXVh
bCB0byAwLCB0aGUgc2VsZWN0aW9uIHdpbGwgb25seSBjaG9vc2UgdGhlIG1pbmltdW0gb25lLg0K
PiA+IFdoZW4gdGhlIHJhbXAgdGFyZ2V0IGlzIGVxdWFsIHRvIDAsIGl0IG1lYW5zIHRoZSB1c2Vy
IHdhbnQgdG8gZGlzYWJsZSB0aGUgcmFtbXBwaW5nIGZ1bmN0aW9uLg0KPiA+DQo+ID4gQXMgSSBr
bm93LCBpZiB0YXJnZXQgaXMgZXF1YWwgdG8gMCwgaXQgbXVzdCBmaW5kIHRoZSBmYXN0ZXN0IHJh
bXBwaW5nIHZhbHVlIGFzIHRoZSBiZXN0IHNlbGVjdGlvbi4NCj4gPg0KPiA+DQo+ID4gSWYgeW91
ciB0YWJsZSBpcyBbMTAwMCAyNTAwIDUwMDAgMTAwMDBdLCBmaW5kX2Nsb3Nlc3RfYmlnZ2VyKCkg
d2lsbA0KPiA+IGNob29zZSBzZWw9MCB3aGVuIHJhbXBfZGVsYXk9MC4NCj4gPiBJZiB5b3VyIHRh
YmxlIGlzIFsxMDAwMCA1MDAwIDI1MDAgMTAwMF0sIGZpbmRfY2xvc2VzdF9iaWdnZXIoKSB3aWxs
DQo+ID4gY2hvb3NlIHNlbD0zIHdoZW4gcmFtcF9kZWxheT0wLg0KPiA+IGkuZS4gSW4gYm90aCBj
YXNlcywgZmluZF9jbG9zZXN0X2JpZ2dlcigpIGNob29zZXMgdGhlIGZhc3Rlc3QgcmFtcGluZyB2
YWx1ZS4NCj4gPg0KPiA+IFRoaXMgbWVldHMgeW91ciBleGNlcHRpb24uDQo+ID4NCj4gPiBBY3R1
YWxseSwgZXZlbiBpZiB5b3VyIHRhYmxlIGlzIFsxMDAwMCwgMTAwMCwgNTAwMCwgMjUwMF0sDQo+
ID4gZmluZF9jbG9zZXN0X2JpZ2dlcigpIHN0aWxsIGNhbiBjaG9vc2UgdGhlIGNvcnJlY3Qgc2Vs
ZWN0b3IuDQo+ID4gaS5lLiBzZWw9MSB3aGVuIHJhbXBfZGVsYXk9MCBpbiB0aGlzIGNhc2UuDQo+
ID4NCj4gPiBUaGlzIHNlbGVjdGlvbiBtYXkgYmUgd3JvbmcuDQo+ID4gcmFtcF9kZWxheT0wIG1l
YW5zIHJhbXAgZGlzYWJsZWQsDQo+ID4gSWYgY2hpcCBub3Qgc3VwcG9ydCByYW1wcGluZyBkaXNh
YmxlLCB0aGlzIHNlbGVjdGlvbiBtdXN0IGJlIGNvbmZpZ3VyZWQgYXMgZmFzdGVzdCByYW1wcGlu
ZyB2YWx1ZSwgbm90IHRoZSBtaW5pbXVtDQo+ID4gb25lLg0KPiA+DQo+ID4NCj4gPiAwIGRvZXMg
bm90IG1lYW4gcmFtcCBkaXNhYmxlLg0KPiA+IEl0IGNvdWxkIGJlIGV4cGxpY2l0bHkgc2V0IHRv
IHplcm8gb3IgaXRzIHVuaW50aWFsaXplZCAoemVybyBieSBkZWZhdWx0KS4NCj4gPiBzZWUNCj4g
PiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxk
cy9saW51eC5naXQvY29tbWl0L2RyaXZlcnMvcmVndWxhdG9yL2NvcmUuYz9pZD0xNjUzY2NmNGM1
MmRmNg0KPiA+IGE0YWJlOGVjMmYzM2YyY2IyODk2ZDEyOWVhDQo+ID4NCj4gPiBIb3cgYWJvdXQg
J3JhbXBfZGlzYWJsZScgZmFsZyBpcyB0cnVlPw0KPiA+DQo+ID4NCj4gPiBNeSB1bmRlcnN0YW5k
aW5nIGlzOg0KPiA+IElmIHRoZSBoL3cgZG9lcyBub3Qgc3VwcG9ydCBkaXNhYmxpbmcgcmFtcF9k
ZWxheSwgdGhlIHJlZ3VsYXRvciBjb3JlDQo+ID4gd29uJ3QgY2FsbCBvcHMtPnNldF9yYW1wX2Rl
bGF5IHdoZW4gcmFtcF9kZWxheT0wLg0KPiA+IElmIHRoZSBoL3cgc3VwcG9ydHMgZGlzYWJsaW5n
IHJhbXAsIGkuZS4gcmFtcF9kaXNhYmxlIGZsYWcgaXMgdHJ1ZSwNCj4gPiB0aGUgcmVndWxhdG9y
IGNvcmUgd2lsbA0KPiA+IGNhbGwgb3BzLT5zZXRfcmFtcF9kZWxheSB3aXRoIHJhbXBfZGVsYXk9
MC4gaW4gdGhpcyBjYXNlLCBpdCBzaG91bGQNCj4gPiBoYXZlIGFuIGV4YWN0bHkgbWF0Y2ggYW5k
DQo+ID4gd3JpdGUgdGhlIHJlZ2lzdGVyIHRvIGRpc2FibGUgcmFtcF9kZWxheS4NCj4gPg0KPiA+
DQo+ID4gSWYgdGhpcyBjYW4gYmUgZ3VhcmFudGVlZCAsIHRvIHVzZSB0aGUgc2V0X3JhbXBfZGVs
YXlfcmVnbWFwIGhlbHBlciBmdW5jdGlvbiB3b3VsZCBiZSBiZXR0ZXIuDQo+IEhpIENoaVl1YW4s
DQo+IENhbiB5b3UgYWRkICBSZXZpZXdlZC1ieSBvciBBY2tlZC1ieSBpZiB0aGlzIHBhdGNoIHdv
cmtzLg0KU3VyZSwgYWxyZWFkeSB0ZXN0ZWQuDQoNClJldmlld2VkLWJ5OiBDaGlZdWFuIEh1YW5n
IDxjeV9odWFuZ0ByaWNodGVrLmNvbT4NCj4NCj4gUmVnYXJkcywNCj4gQXhlbA0KKioqKioqKioq
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
