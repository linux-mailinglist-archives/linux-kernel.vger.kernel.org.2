Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B01DE375C40
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 22:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbhEFUcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 16:32:16 -0400
Received: from mail02.rohde-schwarz.com ([80.246.32.97]:32024 "EHLO
        mail02.rohde-schwarz.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbhEFUcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 16:32:13 -0400
Received: from amu316.rsint.net (10.0.26.65) by mail-emea.rohde-schwarz.com
 (172.21.64.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.858.5; Thu, 6 May 2021
 22:31:11 +0200
Received: from GMU418.rsint.net ([10.0.230.144])
          by amu316.rsint.net (Totemo SMTP Server) with SMTP ID 766;
          Thu, 6 May 2021 22:31:11 +0200 (CEST)
Received: from GMU007.rsint.net (10.0.2.65) by GMU418.rsint.net (10.0.230.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2242.4; Thu, 6 May 2021
 22:31:11 +0200
Received: from GMU006.rsint.net (10.0.2.28) by GMU007.rsint.net (10.0.2.65)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2242.4; Thu, 6 May
 2021 22:31:07 +0200
Received: from GMU006.rsint.net ([fe80::81e7:6ea1:2437:698b]) by
 GMU006.rsint.net ([fe80::81e7:6ea1:2437:698b%12]) with mapi id
 15.01.2242.008; Thu, 6 May 2021 22:31:07 +0200
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
Subject: RE: Re: Re: Re: Re: [syzbot] INFO: rcu detected stall in tx
Thread-Topic: Re: Re: Re: Re: [syzbot] INFO: rcu detected stall in tx /ur/
Thread-Index: AddCtpO0ozxKZHsqQAOt1wUmlxSnDA==
Date:   Thu, 6 May 2021 20:31:07 +0000
Message-ID: <6cffd7eebba54ed8acd043d51d212ec1@rohde-schwarz.com>
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
X-GBS-PROC: LpEUGid9s/TL7dxKEotNHLoCghJ3ARiuQByidMlffaNV4vbnvlXeerAMYRDKpGHBuf2WJyAuUODwx6H0bfXk6wEpscP9Xg4EEgqEF2fdCMvkQ7qtVrLYivDsyVg+z+Od
X-GBS-PROCJOB: ZIguoV1bA0+lPvlM2Rp42PFPPcSZ8xXk1Jkij/NaWe5kV2ndBmC8ffTOxhd2EGtK
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGFuIFN0ZXJuDQo+IFNlbnQ6
IFRodXJzZGF5LCBNYXkgNiwgMjAyMSA4OjMyIFBNDQo+IFRvOiBLaWVuZXIgR3VpZG8gMTREUzEN
Cj4gDQo+IE9uIFRodSwgTWF5IDA2LCAyMDIxIGF0IDA1OjQ0OjU1UE0gKzAwMDAsIEd1aWRvIEtp
ZW5lciB3cm90ZToNCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9t
OiBBbGFuIFN0ZXJuDQo+ID4gPiBTZW50OiBUaHVyc2RheSwgTWF5IDYsIDIwMjEgMzo0OSBQTQ0K
PiA+ID4gVG86IEtpZW5lciBHdWlkbyAxNERTMSA8R3VpZG8uS2llbmVyQHJvaGRlLXNjaHdhcnou
Y29tPg0KPiA+ID4gPg0KPiA+ID4gPiBUaGFua3MgZm9yIHlvdXIgYXNzZXNzbWVudC4gSSBhZ3Jl
ZSB3aXRoIHRoZSBnZW5lcmFsIGZlZWxpbmcuIEkNCj4gPiA+ID4gY291bnRlZCBhYm91dCBodW5k
cmVkIHNwZWNpZmljIHVzYiBkcml2ZXJzLCBzbyB3b3VsZG4ndCBpdCBiZQ0KPiA+ID4gPiBiZXR0
ZXIgdG8gZml4IHRoZQ0KPiA+ID4gcHJvYmxlbSBpbiBzb21lIG9mIHRoZSBob3N0IGRyaXZlcnMg
KGUuZy4gdXJiLmMpPw0KPiA+ID4gPiBXZSBjb3VsZCByZXR1cm4gYW4gZXJyb3Igd2hlbiBjYWxs
aW5nIHVzYl9zdWJtaXRfdXJiKCkgb24gYW4gZXJyb25lb3VzDQo+IHBpcGUuDQo+ID4gPiA+IEkg
Y2Fubm90IGVzdGltYXRlIHRoZSBzaWRlIGVmZmVjdHMgYW5kIHdlIG5lZWQgdG8gY2hlY2sgYWxs
DQo+ID4gPiA+IGRyaXZlcnMgYWdhaW4gaG93IHRoZXkgZGVhbCB3aXRoIHRoZSBlcnJvciBzaXR1
YXRpb24uIE1heWJlIHRoZXJlDQo+ID4gPiA+IGFyZSBzb21lIHNwZWNpYWwgZHJpdmVyDQo+ID4g
PiB0aGF0IG5lZWQgYSBzcGVjaWFsaXplZCBlcnJvciBoYW5kbGluZy4NCj4gPiA+ID4gSW4gdGhp
cyBjYXNlIHRoZXNlIGRyaXZlcnMgY291bGQgcmVzZXQgdGhlIChuZXc/KSBlcnJvciBmbGFnIHRv
DQo+ID4gPiA+IGFsbG93IGNhbGxpbmcgdXNiX3N1Ym1pdF91cmIoKSBhZ2FpbiB3aXRob3V0IGVy
cm9yLiBUaGlzIGNvdWxkIHdvcmssIGlzbid0IGl0Pw0KPiA+ID4NCj4gPiA+IFRoYXQgaXMgZmVh
c2libGUsIGFsdGhvdWdoIGl0IHdvdWxkIGJlIGFuIGF3a3dhcmQgYXBwcm9hY2guICBBcyB5b3UN
Cj4gPiA+IHNhaWQsIHRoZSBzaWRlIGVmZmVjdHMgYXJlbid0IGNsZWFyLiAgQnV0IGl0IG1pZ2h0
IHdvcmsuDQo+ID4NCj4gPiBPdGhlcndpc2UgSSBzZWUgb25seSB0aGUgb3RoZXIgYXBwcm9hY2gg
dG8gY2hhbmdlIGh1bmRyZWQgZHJpdmVycyBhbmQNCj4gPiBhZGQgdGhlIGNhc2VzIEVQUk9UTywg
RUlMU0VRIGFuZCBFVElNRSBpbiBlYWNoIGNhbGxiYWNrIGhhbmRsZXIuIFRoZQ0KPiA+IHVzYnRt
YyBkcml2ZXIgYWxyZWFkeSByZXNwZWN0cyB0aGUgRUlMU0VRIGFuZCBFVElNRSwgYW5kIG9ubHkg
RVBST1RPIGlzDQo+IG1pc3NpbmcuDQo+ID4gVGhlIHJlc3Qgc2hvdWxkIGJlIG1vcmUgYSBtYW5h
Z2VtZW50IHRhc2suDQo+ID4gQlRXIGRvIHlvdSBhc3N1bWUgaXQgaXMgb25seSBhIHByb2JsZW0g
Zm9yIElOVCBwaXBlcyBvciBpcyBpdCBhbHNvIGENCj4gPiBwcm9ibGVtIGZvciBpc29jaHJvbm91
cyBhbmQgYnVsayB0cmFuc2ZlcnM/DQo+IA0KPiBBbGwgb2YgdGhlbS4gIENvbnRyb2wgdG9vLg0K
PiANCj4gPiA+IFdpbGwgeW91IGJlIGFibGUgdG8gdGVzdCBwYXRjaGVzPw0KPiA+DQo+ID4gSSBv
bmx5IGNhbiB0ZXN0IHRoZSBVU0JUTUMgZnVuY3Rpb24gaW4gc29tZSBkaWZmZXJlbnQgUENzLiBJ
IGRvIG5vdA0KPiA+IGhhdmUgYXV0b21hdGVkIHJlZ3Jlc3Npb24gdGVzdHMgZm9yIFVTQiBkcml2
ZXJzIG9yIExpbnV4IGtlcm5lbHMuDQo+ID4gTWF5YmUgdGhlcmUgaXMgY29tcGFueSB3aG8gY291
bGQgZG8gdGhhdC4NCj4gDQo+IFdlbGwgdGhlbiwgaWYgSSBkbyBmaW5kIHRpbWUgdG8gd3JpdGUg
YSBwYXRjaCwgSSdsbCBhc2sgeW91IHRvIHRyeSBpdCBvdXQgd2l0aCB0aGUgdXNidG1jDQo+IGRy
aXZlci4NCg0KWW91IG1lYW4gdGhhdCB5b3Ugd2lsbCBkbyBhIHBhdGNoIGluIHVyYi5jIG9yIGEg
aG9zdCBkcml2ZXI/IE9yIGp1c3QgYWRkIGEgbGluZSBpbiB1c2J0bWMuYz8NCkFueWhvdyB0aGVy
ZSBpcyBubyBodXJyeS4gT24gTWF5IDIwIEkgd2lsbCBzZW5kIHlvdSBhIG1haWwgaWYgSSdtIGFi
bGUgdG8NCnByb3Zva2Ugb25lIG9mIHRoZXNlIGhhcmR3YXJlIGVycm9ycyBFUFJPVE8sIEVJTFNR
LCBvciBFVElNRS4gT3RoZXJ3aXNlDQppdCBkb2Vzbid0IG1ha2Ugc2Vuc2UgdG8gdGVzdCBpdC4N
Cg0KLUd1aWRvDQo=
