Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0073951C2
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 17:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbhE3Pzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 11:55:41 -0400
Received: from mg.richtek.com ([220.130.44.152]:45670 "EHLO mg.richtek.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229671AbhE3Pzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 11:55:39 -0400
X-Greylist: delayed 331 seconds by postgrey-1.27 at vger.kernel.org; Sun, 30 May 2021 11:55:39 EDT
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 192.168.8.21
        by mg.richtek.com with MailGates ESMTP Server V3.0(14675:0:AUTH_RELAY)
        (envelope-from <prvs=1777C70AD1=cy_huang@richtek.com>); Sun, 30 May 2021 23:53:57 +0800 (CST)
X-MailGates: (compute_score:DELIVER,40,3)
Received: from 192.168.10.46
        by mg.richtek.com with MailGates ESMTP Server V5.0(4329:0:AUTH_RELAY)
        (envelope-from <cy_huang@richtek.com>); Sun, 30 May 2021 23:48:21 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5; Sun, 30 May 2021
 23:48:20 +0800
Received: from ex3.rt.l ([fe80::ede0:40a5:8f78:963e]) by ex3.rt.l
 ([fe80::ede0:40a5:8f78:963e%2]) with mapi id 15.02.0858.010; Sun, 30 May 2021
 23:48:20 +0800
From:   =?utf-8?B?Y3lfaHVhbmco6buD5ZWf5Y6fKQ==?= <cy_huang@richtek.com>
To:     "axel.lin@ingics.com" <axel.lin@ingics.com>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "u0084500@gmail.com" <u0084500@gmail.com>
Subject: Re: [PATCH RFT 1/2] regulator: rtmv20: Fix
 .set_current_limit/.get_current_limit callbacks
Thread-Topic: [PATCH RFT 1/2] regulator: rtmv20: Fix
 .set_current_limit/.get_current_limit callbacks
Thread-Index: AQHXVVEW/Kq7COUIdUywUWfa9WDfUqr7pa8A
Date:   Sun, 30 May 2021 15:48:20 +0000
Message-ID: <1622389700.3462.10.camel@richtek.com>
References: <20210530124101.477727-1-axel.lin@ingics.com>
In-Reply-To: <20210530124101.477727-1-axel.lin@ingics.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
x-originating-ip: [192.168.8.47]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C811A9DE0F74A443904468E5B402FB46@rt.l>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pg0KPiBDdXJyZW50IGNvZGUgZG9lcyBub3Qgc2V0IC5jdXJyX3RhYmxlIGFuZCAubl9saW5lYXJf
cmFuZ2VzIHNldHRpbmdzLA0KPiBzbyBpdCBjYW5ub3QgdXNlIHRoZSByZWd1bGF0b3JfZ2V0L3Nl
dF9jdXJyZW50X2xpbWl0X3JlZ21hcCBoZWxwZXJzLg0KPiBJZiB3ZSBzZXR1cCB0aGUgY3Vycl90
YWJsZSwgaXQgd2lsbCBoYXMgMjAwIGVudHJpZXMuDQo+IEltcGxlbWVudCBjdXN0b21pemVkIC5z
ZXRfY3VycmVudF9saW1pdC8uZ2V0X2N1cnJlbnRfbGltaXQgY2FsbGJhY2tzDQo+IGluc3RlYWQu
DQo+DQo+IEZpeGVzOiBiOGMwNTRhNWVhZjAgKCJyZWd1bGF0b3I6IHJ0bXYyMDogQWRkcyBzdXBw
b3J0IGZvciBSaWNodGVrIFJUTVYyMCBsb2FkDQo+IHN3aXRjaCByZWd1bGF0b3IiKQ0KPiBTaWdu
ZWQtb2ZmLWJ5OiBBeGVsIExpbiA8YXhlbC5saW5AaW5naWNzLmNvbT4NCj4gLS0tDQo+IEhpIENo
aVl1YW4sDQo+IEkgZG9uJ3QgaGF2ZSB0aGlzIGgvdyB0byB0ZXN0Lg0KPiBQbGVhc2UgaGVscCB0
byByZXZpZXcgYW5kIHRlc3QgdGhpcyBwYXRjaC4NCj4NCj4gVGhhbmtzLA0KPiBBeGVsDQpUaGFu
a3MgZm9yIHRoZSBmaXguIEkgcmVhbGx5IGRpZG4ndCBub3RpY2UgdGhhdC4NCg0KUmV2aWV3ZWQt
Ynk6IENoaVl1YW4gSHVhbmcgPGN5X2h1YW5nQHJpY2h0ZWsuY29tPg0KPg0KPg0KPiAgZHJpdmVy
cy9yZWd1bGF0b3IvcnRtdjIwLXJlZ3VsYXRvci5jIHwgNDIgKysrKysrKysrKysrKysrKysrKysr
KysrKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDQwIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3JlZ3VsYXRvci9ydG12MjAtcmVndWxhdG9y
LmMgYi9kcml2ZXJzL3JlZ3VsYXRvci9ydG12MjAtDQo+IHJlZ3VsYXRvci5jDQo+IGluZGV4IDg1
MmZiMjU5NmZmZC4uNWFkYzU1MmRmZmQ1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3JlZ3VsYXRv
ci9ydG12MjAtcmVndWxhdG9yLmMNCj4gKysrIGIvZHJpdmVycy9yZWd1bGF0b3IvcnRtdjIwLXJl
Z3VsYXRvci5jDQo+IEBAIC0xMDMsOSArMTAzLDQ3IEBAIHN0YXRpYyBpbnQgcnRtdjIwX2xzd19k
aXNhYmxlKHN0cnVjdCByZWd1bGF0b3JfZGV2ICpyZGV2KQ0KPiAgcmV0dXJuIDA7DQo+ICB9DQo+
DQo+ICtzdGF0aWMgaW50IHJ0bXYyMF9sc3dfc2V0X2N1cnJlbnRfbGltaXQoc3RydWN0IHJlZ3Vs
YXRvcl9kZXYgKnJkZXYsIGludA0KPiBtaW5fdUEsDQo+ICtpbnQgbWF4X3VBKQ0KPiArew0KPiAr
aW50IHNlbDsNCj4gKw0KPiAraWYgKG1pbl91QSA+IFJUTVYyMF9MU1dfTUFYVUEgfHwgbWF4X3VB
IDwgUlRNVjIwX0xTV19NSU5VQSkNCj4gK3JldHVybiAtRUlOVkFMOw0KPiArDQo+ICtpZiAobWF4
X3VBID4gUlRNVjIwX0xTV19NQVhVQSkNCj4gK21heF91QSA9IFJUTVYyMF9MU1dfTUFYVUE7DQo+
ICsNCj4gK3NlbCA9IChtYXhfdUEgLSBSVE1WMjBfTFNXX01JTlVBKSAvIFJUTVYyMF9MU1dfU1RF
UFVBOw0KPiArDQo+ICsvKiBFbnN1cmUgdGhlIHNlbGVjdGVkIHNldHRpbmcgaXMgc3RpbGwgaW4g
cmFuZ2UgKi8NCj4gK2lmICgoc2VsICogUlRNVjIwX0xTV19TVEVQVUEgKyBSVE1WMjBfTFNXX01J
TlVBKSA8IG1pbl91QSkNCj4gK3JldHVybiAtRUlOVkFMOw0KPiArDQo+ICtzZWwgPDw9IGZmcyhy
ZGV2LT5kZXNjLT5jc2VsX21hc2spIC0gMTsNCj4gKw0KPiArcmV0dXJuIHJlZ21hcF91cGRhdGVf
Yml0cyhyZGV2LT5yZWdtYXAsIHJkZXYtPmRlc2MtPmNzZWxfcmVnLA0KPiArICByZGV2LT5kZXNj
LT5jc2VsX21hc2ssIHNlbCk7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBpbnQgcnRtdjIwX2xzd19n
ZXRfY3VycmVudF9saW1pdChzdHJ1Y3QgcmVndWxhdG9yX2RldiAqcmRldikNCj4gK3sNCj4gK3Vu
c2lnbmVkIGludCB2YWw7DQo+ICtpbnQgcmV0Ow0KPiArDQo+ICtyZXQgPSByZWdtYXBfcmVhZChy
ZGV2LT5yZWdtYXAsIHJkZXYtPmRlc2MtPmNzZWxfcmVnLCAmdmFsKTsNCj4gK2lmIChyZXQpDQo+
ICtyZXR1cm4gcmV0Ow0KPiArDQo+ICt2YWwgJj0gcmRldi0+ZGVzYy0+Y3NlbF9tYXNrOw0KPiAr
dmFsID4+PSBmZnMocmRldi0+ZGVzYy0+Y3NlbF9tYXNrKSAtIDE7DQo+ICsNCj4gK3JldHVybiB2
YWwgKiBSVE1WMjBfTFNXX1NURVBVQSArIFJUTVYyMF9MU1dfTUlOVUE7DQo+ICt9DQo+ICsNCj4g
IHN0YXRpYyBjb25zdCBzdHJ1Y3QgcmVndWxhdG9yX29wcyBydG12MjBfcmVndWxhdG9yX29wcyA9
IHsNCj4gLS5zZXRfY3VycmVudF9saW1pdCA9IHJlZ3VsYXRvcl9zZXRfY3VycmVudF9saW1pdF9y
ZWdtYXAsDQo+IC0uZ2V0X2N1cnJlbnRfbGltaXQgPSByZWd1bGF0b3JfZ2V0X2N1cnJlbnRfbGlt
aXRfcmVnbWFwLA0KPiArLnNldF9jdXJyZW50X2xpbWl0ID0gcnRtdjIwX2xzd19zZXRfY3VycmVu
dF9saW1pdCwNCj4gKy5nZXRfY3VycmVudF9saW1pdCA9IHJ0bXYyMF9sc3dfZ2V0X2N1cnJlbnRf
bGltaXQsDQo+ICAuZW5hYmxlID0gcnRtdjIwX2xzd19lbmFibGUsDQo+ICAuZGlzYWJsZSA9IHJ0
bXYyMF9sc3dfZGlzYWJsZSwNCj4gIC5pc19lbmFibGVkID0gcmVndWxhdG9yX2lzX2VuYWJsZWRf
cmVnbWFwLA0KKioqKioqKioqKioqKiBFbWFpbCBDb25maWRlbnRpYWxpdHkgTm90aWNlICoqKioq
KioqKioqKioqKioqKioqDQoNClRoZSBpbmZvcm1hdGlvbiBjb250YWluZWQgaW4gdGhpcyBlLW1h
aWwgbWVzc2FnZSAoaW5jbHVkaW5nIGFueSBhdHRhY2htZW50cykgbWF5IGJlIGNvbmZpZGVudGlh
bCwgcHJvcHJpZXRhcnksIHByaXZpbGVnZWQsIG9yIG90aGVyd2lzZSBleGVtcHQgZnJvbSBkaXNj
bG9zdXJlIHVuZGVyIGFwcGxpY2FibGUgbGF3cy4gSXQgaXMgaW50ZW5kZWQgdG8gYmUgY29udmV5
ZWQgb25seSB0byB0aGUgZGVzaWduYXRlZCByZWNpcGllbnQocykuIEFueSB1c2UsIGRpc3NlbWlu
YXRpb24sIGRpc3RyaWJ1dGlvbiwgcHJpbnRpbmcsIHJldGFpbmluZyBvciBjb3B5aW5nIG9mIHRo
aXMgZS1tYWlsIChpbmNsdWRpbmcgaXRzIGF0dGFjaG1lbnRzKSBieSB1bmludGVuZGVkIHJlY2lw
aWVudChzKSBpcyBzdHJpY3RseSBwcm9oaWJpdGVkIGFuZCBtYXkgYmUgdW5sYXdmdWwuIElmIHlv
dSBhcmUgbm90IGFuIGludGVuZGVkIHJlY2lwaWVudCBvZiB0aGlzIGUtbWFpbCwgb3IgYmVsaWV2
ZSB0aGF0IHlvdSBoYXZlIHJlY2VpdmVkIHRoaXMgZS1tYWlsIGluIGVycm9yLCBwbGVhc2Ugbm90
aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRlbHkgKGJ5IHJlcGx5aW5nIHRvIHRoaXMgZS1tYWlsKSwg
ZGVsZXRlIGFueSBhbmQgYWxsIGNvcGllcyBvZiB0aGlzIGUtbWFpbCAoaW5jbHVkaW5nIGFueSBh
dHRhY2htZW50cykgZnJvbSB5b3VyIHN5c3RlbSwgYW5kIGRvIG5vdCBkaXNjbG9zZSB0aGUgY29u
dGVudCBvZiB0aGlzIGUtbWFpbCB0byBhbnkgb3RoZXIgcGVyc29uLiBUaGFuayB5b3UhDQo=
