Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A675399EF5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 12:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbhFCKdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 06:33:06 -0400
Received: from mg.richtek.com ([220.130.44.152]:48640 "EHLO mg.richtek.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229685AbhFCKdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 06:33:05 -0400
X-Greylist: delayed 630 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Jun 2021 06:33:04 EDT
X-MailGates: (compute_score:DELIVER,40,3)
Received: from 192.168.8.21
        by mg.richtek.com with MailGates ESMTP Server V3.0(14681:0:AUTH_RELAY)
        (envelope-from <prvs=1784CEC101=cy_huang@richtek.com>); Thu, 03 Jun 2021 18:23:56 +0800 (CST)
X-MailGates: (compute_score:DELIVER,40,3)
Received: from 192.168.10.47
        by mg.richtek.com with MailGates ESMTP Server V5.0(4328:0:AUTH_RELAY)
        (envelope-from <cy_huang@richtek.com>); Thu, 03 Jun 2021 18:20:42 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5; Thu, 3 Jun 2021
 18:20:41 +0800
Received: from ex3.rt.l ([fe80::ede0:40a5:8f78:963e]) by ex3.rt.l
 ([fe80::ede0:40a5:8f78:963e%2]) with mapi id 15.02.0858.010; Thu, 3 Jun 2021
 18:20:41 +0800
From:   =?utf-8?B?Y3lfaHVhbmco6buD5ZWf5Y6fKQ==?= <cy_huang@richtek.com>
To:     "axel.lin@ingics.com" <axel.lin@ingics.com>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] regulator: rt6160: Convert to use
 regulator_set_ramp_delay_regmap
Thread-Topic: [PATCH] regulator: rt6160: Convert to use
 regulator_set_ramp_delay_regmap
Thread-Index: AQHXWFw5/k6L4YuRIk+OmEhH2dJ5iKsBjWCA
Date:   Thu, 3 Jun 2021 10:20:41 +0000
Message-ID: <1622715641.1034.5.camel@richtek.com>
References: <20210603093809.1108629-1-axel.lin@ingics.com>
In-Reply-To: <20210603093809.1108629-1-axel.lin@ingics.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
x-originating-ip: [192.168.8.47]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C4D20C7624CB474190185C2FBBA64DEA@rt.l>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEF4ZWw6PiBVc2UgcmVndWxhdG9yX3NldF9yYW1wX2RlbGF5X3JlZ21hcCBpbnN0ZWFkIG9m
IG9wZW4tY29kZWQuDQo+DQpUaGVyZSdzIHNvbWUgcmVhc29uLg0KWW91IGNhbiByZWZlciB0byBo
dHRwczovL2xrbWwub3JnL2xrbWwvMjAyMS82LzEvMTE0NS4NCg0KSXQncyBiZWNhdXNlIG91ciBy
YW1wIHZhbHVlIG9yZGVyIGlzIGZyb20gc21hbGwgdG8gbGFyZ2UsIG5vdCBsYXJnZSB0byBzbWFs
bC4NCkl0IGNvbmZsaWN0cyB3aXRoIGZpbmRfY2xvc2VzdF9iaWdnZXIgdmFsdWUgY2hvc2VuIGxv
Z2ljLg0KDQpUaGF0J3Mgd2h5IEkgbmVlZCBoYXJkLWNvZGVkIGZvciBteSByYW1wIHZhbHVlIHNl
bGVjdGlvbi4NCj4gU2lnbmVkLW9mZi1ieTogQXhlbCBMaW4gPGF4ZWwubGluQGluZ2ljcy5jb20+
DQo+IC0tLQ0KPiAgZHJpdmVycy9yZWd1bGF0b3IvcnQ2MTYwLXJlZ3VsYXRvci5jIHwgMzUgKysr
KysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9u
cygrKSwgMjYgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3JlZ3VsYXRv
ci9ydDYxNjAtcmVndWxhdG9yLmMgYi9kcml2ZXJzL3JlZ3VsYXRvci9ydDYxNjAtDQo+IHJlZ3Vs
YXRvci5jDQo+IGluZGV4IDQ1ODhhZTA3NDhhNS4uNjk1NTAyODQwODNkIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL3JlZ3VsYXRvci9ydDYxNjAtcmVndWxhdG9yLmMNCj4gKysrIGIvZHJpdmVycy9y
ZWd1bGF0b3IvcnQ2MTYwLXJlZ3VsYXRvci5jDQo+IEBAIC00Niw2ICs0NiwxMCBAQCBzdHJ1Y3Qg
cnQ2MTYwX3ByaXYgew0KPiAgYm9vbCBlbmFibGVfc3RhdGU7DQo+ICB9Ow0KPg0KPiArc3RhdGlj
IGNvbnN0IHVuc2lnbmVkIGludCBydDYxNjBfcmFtcF90YWJsZXNbXSA9IHsNCj4gKzEwMDAsIDI1
MDAsIDUwMDAsIDEwMDAwDQo+ICt9Ow0KPiArDQo+ICBzdGF0aWMgaW50IHJ0NjE2MF9lbmFibGUo
c3RydWN0IHJlZ3VsYXRvcl9kZXYgKnJkZXYpDQo+ICB7DQo+ICBzdHJ1Y3QgcnQ2MTYwX3ByaXYg
KnByaXYgPSByZGV2X2dldF9kcnZkYXRhKHJkZXYpOw0KPiBAQCAtMTQwLDMxICsxNDQsNiBAQCBz
dGF0aWMgaW50IHJ0NjE2MF9zZXRfc3VzcGVuZF92b2x0YWdlKHN0cnVjdA0KPiByZWd1bGF0b3Jf
ZGV2ICpyZGV2LCBpbnQgdVYpDQo+ICByZXR1cm4gcmVnbWFwX3VwZGF0ZV9iaXRzKHJlZ21hcCwg
cmVnLCBSVDYxNjBfVlNFTF9NQVNLLCB2c2VsKTsNCj4gIH0NCj4NCj4gLXN0YXRpYyBpbnQgcnQ2
MTYwX3NldF9yYW1wX2RlbGF5KHN0cnVjdCByZWd1bGF0b3JfZGV2ICpyZGV2LCBpbnQgdGFyZ2V0
KQ0KPiAtew0KPiAtc3RydWN0IHJlZ21hcCAqcmVnbWFwID0gcmRldl9nZXRfcmVnbWFwKHJkZXYp
Ow0KPiAtY29uc3QgaW50IHJhbXBfdGFibGVzW10gPSB7IDEwMDAsIDI1MDAsIDUwMDAsIDEwMDAw
IH07DQo+IC11bnNpZ25lZCBpbnQgaSwgc2VsOw0KPiAtDQo+IC0vKiBGaW5kIGNsb3Nlc3QgbGFy
Z2VyIG9yIGVxdWFsICovDQo+IC1mb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRShyYW1wX3RhYmxl
cyk7IGkrKykgew0KPiAtc2VsID0gaTsNCj4gLQ0KPiAtLyogSWYgcmFtcCBkZWxheSBpcyBlcXVh
bCB0byAwLCBkaXJlY3RseSBzZXQgcmFtcCBzcGVlZCB0bw0KPiBmYXN0ZXN0ICovDQo+IC1pZiAo
dGFyZ2V0ID09IDApIHsNCj4gLXNlbCA9IEFSUkFZX1NJWkUocmFtcF90YWJsZXMpIC0gMTsNCj4g
LWJyZWFrOw0KPiAtfQ0KPiAtDQo+IC1pZiAodGFyZ2V0IDw9IHJhbXBfdGFibGVzW2ldKQ0KPiAt
YnJlYWs7DQo+IC19DQo+IC0NCj4gLXNlbCA8PD0gZmZzKFJUNjE2MF9SQU1QUkFURV9NQVNLKSAt
IDE7DQo+IC0NCj4gLXJldHVybiByZWdtYXBfdXBkYXRlX2JpdHMocmVnbWFwLCBSVDYxNjBfUkVH
X0NOVEwsDQo+IFJUNjE2MF9SQU1QUkFURV9NQVNLLCBzZWwpOw0KPiAtfQ0KPiAtDQo+ICBzdGF0
aWMgaW50IHJ0NjE2MF9nZXRfZXJyb3JfZmxhZ3Moc3RydWN0IHJlZ3VsYXRvcl9kZXYgKnJkZXYs
IHVuc2lnbmVkIGludA0KPiAqZmxhZ3MpDQo+ICB7DQo+ICBzdHJ1Y3QgcmVnbWFwICpyZWdtYXAg
PSByZGV2X2dldF9yZWdtYXAocmRldik7DQo+IEBAIC0yMDMsNyArMTgyLDcgQEAgc3RhdGljIGNv
bnN0IHN0cnVjdCByZWd1bGF0b3Jfb3BzIHJ0NjE2MF9yZWd1bGF0b3Jfb3BzID0gew0KPiAgLnNl
dF9tb2RlID0gcnQ2MTYwX3NldF9tb2RlLA0KPiAgLmdldF9tb2RlID0gcnQ2MTYwX2dldF9tb2Rl
LA0KPiAgLnNldF9zdXNwZW5kX3ZvbHRhZ2UgPSBydDYxNjBfc2V0X3N1c3BlbmRfdm9sdGFnZSwN
Cj4gLS5zZXRfcmFtcF9kZWxheSA9IHJ0NjE2MF9zZXRfcmFtcF9kZWxheSwNCj4gKy5zZXRfcmFt
cF9kZWxheSA9IHJlZ3VsYXRvcl9zZXRfcmFtcF9kZWxheV9yZWdtYXAsDQo+ICAuZ2V0X2Vycm9y
X2ZsYWdzID0gcnQ2MTYwX2dldF9lcnJvcl9mbGFncywNCj4gIH07DQo+DQo+IEBAIC0yOTIsNiAr
MjcxLDEwIEBAIHN0YXRpYyBpbnQgcnQ2MTYwX3Byb2JlKHN0cnVjdCBpMmNfY2xpZW50ICppMmMp
DQo+ICBwcml2LT5kZXNjLnZzZWxfcmVnID0gUlQ2MTYwX1JFR19WU0VMSDsNCj4gIHByaXYtPmRl
c2MudnNlbF9tYXNrID0gUlQ2MTYwX1ZTRUxfTUFTSzsNCj4gIHByaXYtPmRlc2Mubl92b2x0YWdl
cyA9IFJUNjE2MF9OX1ZPVVRTOw0KPiArcHJpdi0+ZGVzYy5yYW1wX3JlZyA9IFJUNjE2MF9SRUdf
Q05UTDsNCj4gK3ByaXYtPmRlc2MucmFtcF9tYXNrID0gUlQ2MTYwX1JBTVBSQVRFX01BU0s7DQo+
ICtwcml2LT5kZXNjLnJhbXBfZGVsYXlfdGFibGUgPSBydDYxNjBfcmFtcF90YWJsZXM7DQo+ICtw
cml2LT5kZXNjLm5fcmFtcF92YWx1ZXMgPSBBUlJBWV9TSVpFKHJ0NjE2MF9yYW1wX3RhYmxlcyk7
DQo+ICBwcml2LT5kZXNjLm9mX21hcF9tb2RlID0gcnQ2MTYwX29mX21hcF9tb2RlOw0KPiAgcHJp
di0+ZGVzYy5vcHMgPSAmcnQ2MTYwX3JlZ3VsYXRvcl9vcHM7DQo+ICBpZiAocHJpdi0+dnNlbF9h
Y3RpdmVfbG93KQ0KKioqKioqKioqKioqKiBFbWFpbCBDb25maWRlbnRpYWxpdHkgTm90aWNlICoq
KioqKioqKioqKioqKioqKioqDQoNClRoZSBpbmZvcm1hdGlvbiBjb250YWluZWQgaW4gdGhpcyBl
LW1haWwgbWVzc2FnZSAoaW5jbHVkaW5nIGFueSBhdHRhY2htZW50cykgbWF5IGJlIGNvbmZpZGVu
dGlhbCwgcHJvcHJpZXRhcnksIHByaXZpbGVnZWQsIG9yIG90aGVyd2lzZSBleGVtcHQgZnJvbSBk
aXNjbG9zdXJlIHVuZGVyIGFwcGxpY2FibGUgbGF3cy4gSXQgaXMgaW50ZW5kZWQgdG8gYmUgY29u
dmV5ZWQgb25seSB0byB0aGUgZGVzaWduYXRlZCByZWNpcGllbnQocykuIEFueSB1c2UsIGRpc3Nl
bWluYXRpb24sIGRpc3RyaWJ1dGlvbiwgcHJpbnRpbmcsIHJldGFpbmluZyBvciBjb3B5aW5nIG9m
IHRoaXMgZS1tYWlsIChpbmNsdWRpbmcgaXRzIGF0dGFjaG1lbnRzKSBieSB1bmludGVuZGVkIHJl
Y2lwaWVudChzKSBpcyBzdHJpY3RseSBwcm9oaWJpdGVkIGFuZCBtYXkgYmUgdW5sYXdmdWwuIElm
IHlvdSBhcmUgbm90IGFuIGludGVuZGVkIHJlY2lwaWVudCBvZiB0aGlzIGUtbWFpbCwgb3IgYmVs
aWV2ZSB0aGF0IHlvdSBoYXZlIHJlY2VpdmVkIHRoaXMgZS1tYWlsIGluIGVycm9yLCBwbGVhc2Ug
bm90aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRlbHkgKGJ5IHJlcGx5aW5nIHRvIHRoaXMgZS1tYWls
KSwgZGVsZXRlIGFueSBhbmQgYWxsIGNvcGllcyBvZiB0aGlzIGUtbWFpbCAoaW5jbHVkaW5nIGFu
eSBhdHRhY2htZW50cykgZnJvbSB5b3VyIHN5c3RlbSwgYW5kIGRvIG5vdCBkaXNjbG9zZSB0aGUg
Y29udGVudCBvZiB0aGlzIGUtbWFpbCB0byBhbnkgb3RoZXIgcGVyc29uLiBUaGFuayB5b3UhDQo=
