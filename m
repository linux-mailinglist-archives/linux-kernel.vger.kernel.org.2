Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAFB37599D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 19:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236291AbhEFRp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 13:45:59 -0400
Received: from mail02.rohde-schwarz.com ([80.246.32.97]:29310 "EHLO
        mail02.rohde-schwarz.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236224AbhEFRp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 13:45:57 -0400
Received: from amu316.rsint.net (10.0.26.65) by mail-emea.rohde-schwarz.com
 (172.21.64.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.858.5; Thu, 6 May 2021
 19:44:57 +0200
Received: from GMU418.rsint.net ([10.0.230.144])
          by amu316.rsint.net (Totemo SMTP Server) with SMTP ID 855;
          Thu, 6 May 2021 19:44:57 +0200 (CEST)
Received: from GMU003.rsint.net (10.0.2.61) by GMU418.rsint.net (10.0.230.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2242.4; Thu, 6 May 2021
 19:44:56 +0200
Received: from GMU006.rsint.net (10.0.2.28) by GMU003.rsint.net (10.0.2.61)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2242.4; Thu, 6 May
 2021 19:44:55 +0200
Received: from GMU006.rsint.net ([fe80::81e7:6ea1:2437:698b]) by
 GMU006.rsint.net ([fe80::81e7:6ea1:2437:698b%12]) with mapi id
 15.01.2242.008; Thu, 6 May 2021 19:44:55 +0200
From:   Guido Kiener <Guido.Kiener@rohde-schwarz.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+e2eae5639e7203360018@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "dpenkler@gmail.com" <dpenkler@gmail.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        USB list <linux-usb@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: Re: Re: Re: [syzbot] INFO: rcu detected stall in tx
Thread-Topic: Re: Re: Re: [syzbot] INFO: rcu detected stall in tx /ur/
Thread-Index: AddCn1vLnT1ptH8pTMyqkmF/h3+ebg==
Date:   Thu, 6 May 2021 17:44:55 +0000
Message-ID: <be62c93e1e384f49865915b9bda1f12e@rohde-schwarz.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-rus_sensitivity: 10
hvs-classificationid: 8485d17c-1b45-47c0-b496-903334a11e28
hvs-prefix: R_S
x-originating-ip: [10.0.9.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-IQAV: YES
X-GBS-PROC: ijJGnd7ryUNXAjn+Z3XHJ9HQeEa439o4WKV7Y1dJIJAjoOyTSXAGzK3Zo66c0eppkH3W5oTj8TxA196QoGtlRBjZ9be3PgBZrEa46NjcPpKm+KDOtLeLZcQI7hPaGAfA
X-GBS-PROCJOB: aqr7T7RqA7eNWKJjW5jzc+1N2Z/nRA0uUVvTaaxWqT5CVGjAAq3DISDvpoEpIWMn
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGFuIFN0ZXJuDQo+IFNlbnQ6
IFRodXJzZGF5LCBNYXkgNiwgMjAyMSAzOjQ5IFBNDQo+IFRvOiBLaWVuZXIgR3VpZG8gMTREUzEg
PEd1aWRvLktpZW5lckByb2hkZS1zY2h3YXJ6LmNvbT4NCj4gDQo+IE9uIFdlZCwgTWF5IDA1LCAy
MDIxIGF0IDEwOjIyOjI0UE0gKzAwMDAsIEd1aWRvIEtpZW5lciB3cm90ZToNCj4gPiA+IERyaXZl
cnMgYXJlIG5vdCBjb25zaXN0ZW50IGluIHRoZSB3YXkgdGhleSBoYW5kbGUgdGhlc2UgZXJyb3Jz
LCBhcw0KPiA+ID4geW91IGhhdmUgc2Vlbi4gIEEgZmV3IHRyeSB0byB0YWtlIGFjdGl2ZSBtZWFz
dXJlcywgc3VjaCBhcyByZXRyeXMNCj4gPiA+IHdpdGggaW5jcmVhc2luZyB0aW1lb3V0cy4gIE1h
bnkgZHJpdmVycyBqdXN0IGlnbm9yZSB0aGVtLCB3aGljaCBpcyBub3QgYSB2ZXJ5DQo+IGdvb2Qg
aWRlYS4NCj4gPiA+DQo+ID4gPiBUaGUgZ2VuZXJhbCBmZWVsaW5nIGFtb25nIGtlcm5lbCBVU0Ig
ZGV2ZWxvcGVycyBpcyB0aGF0IGEgLUVQUk9UTywNCj4gPiA+IC1FSUxTRVEsIG9yIC1FVElNRSBl
cnJvciBzaG91bGQgYmUgcmVnYXJkZWQgYXMgZmF0YWwsIG11Y2ggdGhlIHNhbWUNCj4gPiA+IGFz
IGFuIHVucGx1ZyBldmVudC4gIFRoZSBkcml2ZXIgc2hvdWxkIGF2b2lkIHJlc3VibWl0dGluZyBV
UkJzIGFuZCBqdXN0IHdhaXQgdG8NCj4gYmUgdW5ib3VuZCBmcm9tIHRoZSBkZXZpY2UuDQo+ID4N
Cj4gPiBUaGFua3MgZm9yIHlvdXIgYXNzZXNzbWVudC4gSSBhZ3JlZSB3aXRoIHRoZSBnZW5lcmFs
IGZlZWxpbmcuIEkNCj4gPiBjb3VudGVkIGFib3V0IGh1bmRyZWQgc3BlY2lmaWMgdXNiIGRyaXZl
cnMsIHNvIHdvdWxkbid0IGl0IGJlIGJldHRlciB0byBmaXggdGhlDQo+IHByb2JsZW0gaW4gc29t
ZSBvZiB0aGUgaG9zdCBkcml2ZXJzIChlLmcuIHVyYi5jKT8NCj4gPiBXZSBjb3VsZCByZXR1cm4g
YW4gZXJyb3Igd2hlbiBjYWxsaW5nIHVzYl9zdWJtaXRfdXJiKCkgb24gYW4gZXJyb25lb3VzIHBp
cGUuDQo+ID4gSSBjYW5ub3QgZXN0aW1hdGUgdGhlIHNpZGUgZWZmZWN0cyBhbmQgd2UgbmVlZCB0
byBjaGVjayBhbGwgZHJpdmVycw0KPiA+IGFnYWluIGhvdyB0aGV5IGRlYWwgd2l0aCB0aGUgZXJy
b3Igc2l0dWF0aW9uLiBNYXliZSB0aGVyZSBhcmUgc29tZSBzcGVjaWFsIGRyaXZlcg0KPiB0aGF0
IG5lZWQgYSBzcGVjaWFsaXplZCBlcnJvciBoYW5kbGluZy4NCj4gPiBJbiB0aGlzIGNhc2UgdGhl
c2UgZHJpdmVycyBjb3VsZCByZXNldCB0aGUgKG5ldz8pIGVycm9yIGZsYWcgdG8gYWxsb3cNCj4g
PiBjYWxsaW5nIHVzYl9zdWJtaXRfdXJiKCkgYWdhaW4gd2l0aG91dCBlcnJvci4gVGhpcyBjb3Vs
ZCB3b3JrLCBpc24ndCBpdD8NCj4gDQo+IFRoYXQgaXMgZmVhc2libGUsIGFsdGhvdWdoIGl0IHdv
dWxkIGJlIGFuIGF3a3dhcmQgYXBwcm9hY2guICBBcyB5b3Ugc2FpZCwgdGhlIHNpZGUNCj4gZWZm
ZWN0cyBhcmVuJ3QgY2xlYXIuICBCdXQgaXQgbWlnaHQgd29yay4NCg0KT3RoZXJ3aXNlIEkgc2Vl
IG9ubHkgdGhlIG90aGVyIGFwcHJvYWNoIHRvIGNoYW5nZSBodW5kcmVkIGRyaXZlcnMgYW5kIGFk
ZCB0aGUNCmNhc2VzIEVQUk9UTywgRUlMU0VRIGFuZCBFVElNRSBpbiBlYWNoIGNhbGxiYWNrIGhh
bmRsZXIuIFRoZSB1c2J0bWMgZHJpdmVyDQphbHJlYWR5IHJlc3BlY3RzIHRoZSBFSUxTRVEgYW5k
IEVUSU1FLCBhbmQgb25seSBFUFJPVE8gaXMgbWlzc2luZy4NClRoZSByZXN0IHNob3VsZCBiZSBt
b3JlIGEgbWFuYWdlbWVudCB0YXNrLg0KQlRXIGRvIHlvdSBhc3N1bWUgaXQgaXMgb25seSBhIHBy
b2JsZW0gZm9yIElOVCBwaXBlcyBvciBpcyBpdCBhbHNvIGEgcHJvYmxlbQ0KZm9yIGlzb2Nocm9u
b3VzIGFuZCBidWxrIHRyYW5zZmVycz8NCg0KPiA+ID4gSWYgeW91IHdvdWxkIGxpa2UgdG8gYXVk
aXQgZHJpdmVycyBhbmQgZml4IHRoZW0gdXAgdG8gYmVoYXZlIHRoaXMNCj4gPiA+IHdheSwgdGhh
dCB3b3VsZCBiZSBncmVhdC4NCj4gPg0KPiA+IEN1cnJlbnRseSBub3QuIEkgY2Fubm90IHB1bGwg
dGhlIFVTQiBjYWJsZSBpbiBob21lIG9mZmljZSA6LSksIGJ1dCBJIHdpbGwga2VlcCBhbiBleWUN
Cj4gb24gaXQuDQo+ID4gV2hlbiBJJ20gbW9yZSBpbnZvbHZlZCBpbiB0aGUgbmV4dCBVU0IgZHJp
dmVyIGlzc3VlIHRoYW4gSSB3aWxsIHRlc3QNCj4gPiBiYWQgY2FibGVzIGFuZCBtYXliZSBnZXQg
bW9yZSBpZGVhcyBob3cgd2UgY291bGQgdGVzdCBhbmQgZml4IHRoaXMgcmFyZSBlcnJvci4NCj4g
DQo+IFdpbGwgeW91IGJlIGFibGUgdG8gdGVzdCBwYXRjaGVzPw0KDQpJIG9ubHkgY2FuIHRlc3Qg
dGhlIFVTQlRNQyBmdW5jdGlvbiBpbiBzb21lIGRpZmZlcmVudCBQQ3MuIEkgZG8gbm90IGhhdmUg
YXV0b21hdGVkDQpyZWdyZXNzaW9uIHRlc3RzIGZvciBVU0IgZHJpdmVycyBvciBMaW51eCBrZXJu
ZWxzLg0KTWF5YmUgdGhlcmUgaXMgY29tcGFueSB3aG8gY291bGQgZG8gdGhhdC4NCg0KLUd1aWRv
DQo=
