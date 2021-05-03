Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F13E3722B8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 23:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbhECV5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 17:57:13 -0400
Received: from mail02.rohde-schwarz.com ([80.246.32.97]:11228 "EHLO
        mail02.rohde-schwarz.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhECV5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 17:57:09 -0400
Received: from amu316.rsint.net (10.0.26.65) by mail-emea.rohde-schwarz.com
 (172.21.64.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.858.5; Mon, 3 May 2021
 23:56:13 +0200
Received: from GMU419.rsint.net ([10.0.230.184])
          by amu316.rsint.net (Totemo SMTP Server) with SMTP ID 303;
          Mon, 3 May 2021 23:56:13 +0200 (CEST)
Received: from GMU003.rsint.net (10.0.2.61) by GMU419.rsint.net (10.0.230.184)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2242.4; Mon, 3 May 2021
 23:56:12 +0200
Received: from GMU006.rsint.net (10.0.2.28) by GMU003.rsint.net (10.0.2.61)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2242.4; Mon, 3 May
 2021 23:56:06 +0200
Received: from GMU006.rsint.net ([fe80::81e7:6ea1:2437:698b]) by
 GMU006.rsint.net ([fe80::81e7:6ea1:2437:698b%12]) with mapi id
 15.01.2242.008; Mon, 3 May 2021 23:56:05 +0200
From:   Guido Kiener <Guido.Kiener@rohde-schwarz.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+e2eae5639e7203360018@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "dpenkler@gmail.com" <dpenkler@gmail.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        USB list <linux-usb@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>
CC:     "bp@alien8.de" <bp@alien8.de>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: Re: [syzbot] INFO: rcu detected stall in tx
Thread-Topic: Re: [syzbot] INFO: rcu detected stall in tx /ur/
Thread-Index: AddAZvL8XVXa6H4GRuuKdM/NghtgBQ==
Date:   Mon, 3 May 2021 21:56:05 +0000
Message-ID: <a4f1b9d202c5445e8c714b3181b84830@rohde-schwarz.com>
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
X-GBS-PROC: ijJGnd7ryUNXAjn+Z3XHJ8sewSqpduzPp+Itxx4Mshpzo3Vq62oWRJkC3PJVwUCqXdgMQawdv3fdeY0yXhOtXBkJmpO4nQ55Rahp7qu6hUinosUCSugSy3ZzUTz2Wvnu
X-GBS-PROCJOB: CypXhZSot4PYE85CrKrN3at/G3nnChScUpl0D/x64XRJwhi3EBW10JaJb83FgISU
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgYWxsLA0KDQpEYXZlIGFuZCBJIGRpc2N1c3NlZCB0aGUgInNlbGYtZGV0ZWN0ZWQgc3RhbGwg
b24gQ1BVIiBjYXVzZWQgYnkgdGhlIHVzYnRtYyBkcml2ZXIuDQoNCldoYXQgaGFwcGVuZWQ/DQpU
aGUgY2FsbGJhY2sgaGFuZGxlciB1c2J0bWNfaW50ZXJydXB0KHN0cnVjdCB1cmIgKnVyYikgZm9y
IHRoZSBJTlQgcGlwZSByZWNlaXZlcyBhbiBlcnJvbmVvdXMgdXJiIHdpdGggc3RhdHVzIC1FUFJP
VE8gKC03MSkuDQpTZWUgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5l
bC9naXQvdG9ydmFsZHMvbGludXguZ2l0L3RyZWUvZHJpdmVycy91c2IvY2xhc3MvdXNidG1jLmM/
aD12NS4xMiNuMjM0MA0KLUVQUk9UTyBkb2VzIG5vdCBhYm9ydC9zaHV0ZG93biB0aGUgcGlwZSBh
bmQgdGhlIHVyYiBpcyByZXN1Ym1pdHRlZCB0byByZWNlaXZlIHRoZSBuZXh0IHBhY2tldC4gSG93
ZXZlciB0aGUgY2FsbGJhY2sgaGFuZGxlciB1c2J0bWNfaW50ZXJydXB0IGlzIGNhbGxlZCBhZ2Fp
biB3aXRoIHRoZSBzYW1lIGVycm9uZW91cyBzdGF0dXMgLUVQUk9UTyBhbmQgdGhpcyBzZWVtcyB0
byByZXN1bHQgaW4gYW4gZW5kbGVzcyBsb29wLg0KQWNjb3JkaW5nIHRvIGh0dHBzOi8vZ2l0Lmtl
cm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90cmVl
L0RvY3VtZW50YXRpb24vZHJpdmVyLWFwaS91c2IvZXJyb3ItY29kZXMucnN0P2g9djUuMTIjbjE3
Nw0KdGhlIGVycm9yIC1FUFJPVE8gaW5kaWNhdGVzIGEgaGFyZHdhcmUgcHJvYmxlbSBvciBhIGJh
ZCBjYWJsZS4NCg0KTW9zdCB1c2IgZHJpdmVycyBkbyBub3QgcmVhY3QgaW4gYSBzcGVjaWZpYyB3
YXkgb24gdGhpcyBoYXJkd2FyZSBwcm9ibGVtcyBhbmQgcmVzdWJtaXQgdGhlIHVyYi4gV2UgYXNz
dW1lIHRoZXNlIGRyaXZlcnMgd2lsbCBydW4gaW50byB0aGUgc2FtZSBlbmRsZXNzIGxvb3AuIFNv
bWUgb3RoZXIgZHJpdmVyIHNhbXBsZXMgYXJlOg0KaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIv
c2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L3RyZWUvZHJpdmVycy91c2Iv
Y2xhc3MvY2RjLWFjbS5jP2g9djUuMTIjbjM3OQ0KaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIv
c2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L3RyZWUvZHJpdmVycy9oaWQv
dXNiaGlkL3VzYm1vdXNlLmM/aD12NS4xMiNuNjUNCg0KUG9zc2libGUgc29sdXRpb25zOg0KSGFy
ZHdhcmUgZGVmZWN0cyBvciBiYWQgY2FibGVzIHNlZW1zIHRvIGJlIGEgY29tbW9uIHByb2JsZW0g
Zm9yIG1vc3QgdXNiIGRyaXZlcnMgYW5kIEkgYXNzdW1lIHdlIGRvIG5vdCB3YW50IHRvIGZpeCB0
aGlzIHByb2JsZW0gaW4gYWxsIGNsYXNzIHNwZWNpZmljIGRyaXZlcnMsIGJ1dCBpbiBsb3dlciBs
ZXZlbCBob3N0IGRyaXZlcnMsIGUuZzoNCjEuIFVzaW5nIGEgY291bnRlciBhbmQgY2xvc2UgdGhl
IHBpcGUgYWZ0ZXIgc29tZSBkZXRlY3RlZCBlcnJvcnMNCjIuIERlbGF5IHRoZSByZXN1Ym1pc3Np
b24gb2YgdGhlIHVyYiB0byBhdm9pZCBoaWdoIGNwdSB1c2FnZQ0KMy4gRG8gbm90aGluZywgc2lu
Y2UgaXQgaXMganVzdCBhIHJhcmUgcHJvYmxlbS4NCg0KV2UndmUgbmV2ZXIgc2VlbiB0aGlzIHBy
b2JsZW0gaW4gb3VyIHByb2R1Y3RzIGFuZCB3ZSBkbyBub3QgZGFyZSB0byBjaGFuZ2UgYW55dGhp
bmcuDQoNCi0gR3VpZG8NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IERtaXRy
eQ0KU2VudDogTW9uZGF5LCBBcHJpbCAxOSwgMjAyMSA5OjI3IEFNDQpTdWJqZWN0OiBSZTogW3N5
emJvdF0gSU5GTzogcmN1IGRldGVjdGVkIHN0YWxsIGluIHR4DQoNCk9uIE1vbiwgQXByIDE5LCAy
MDIxIGF0IDk6MTkgQU0gc3l6Ym90DQo8c3l6Ym90K2UyZWFlNTYzOWU3MjAzMzYwMDE4QHN5emth
bGxlci5hcHBzcG90bWFpbC5jb20+IHdyb3RlOg0KPg0KPiBIZWxsbywNCj4NCj4gc3l6Ym90IGZv
dW5kIHRoZSBmb2xsb3dpbmcgaXNzdWUgb246DQo+DQo+IEhFQUQgY29tbWl0OiAgICA1MDk4N2Jl
YyBNZXJnZSB0YWcgJ3RyYWNlLXY1LjEyLXJjNycgb2YgZ2l0Oi8vZ2l0Lmtlcm5lbC5vLi4NCj4g
Z2l0IHRyZWU6ICAgICAgIHVwc3RyZWFtDQo+IGNvbnNvbGUgb3V0cHV0OiANCj4gaHR0cHM6Ly9z
eXprYWxsZXIuYXBwc3BvdC5jb20veC9sb2cudHh0P3g9MTA2NWM1ZmNkMDAwMDANCj4ga2VybmVs
IGNvbmZpZzogIA0KPiBodHRwczovL3N5emthbGxlci5hcHBzcG90LmNvbS94Ly5jb25maWc/eD0z
OThjNGQwZmU2ZjY2ZTY4DQo+IGRhc2hib2FyZCBsaW5rOiANCj4gaHR0cHM6Ly9zeXprYWxsZXIu
YXBwc3BvdC5jb20vYnVnP2V4dGlkPWUyZWFlNTYzOWU3MjAzMzYwMDE4DQo+DQo+IFVuZm9ydHVu
YXRlbHksIEkgZG9uJ3QgaGF2ZSBhbnkgcmVwcm9kdWNlciBmb3IgdGhpcyBpc3N1ZSB5ZXQuDQo+
DQo+IElNUE9SVEFOVDogaWYgeW91IGZpeCB0aGUgaXNzdWUsIHBsZWFzZSBhZGQgdGhlIGZvbGxv
d2luZyB0YWcgdG8gdGhlIGNvbW1pdDoNCj4gUmVwb3J0ZWQtYnk6IHN5emJvdCtlMmVhZTU2Mzll
NzIwMzM2MDAxOEBzeXprYWxsZXIuYXBwc3BvdG1haWwuY29tDQo+DQo+IHVzYnRtYyA1LTE6MC4w
OiB1bmtub3duIHN0YXR1cyByZWNlaXZlZDogLTcxIHVzYnRtYyAzLTE6MC4wOiB1bmtub3duIA0K
PiBzdGF0dXMgcmVjZWl2ZWQ6IC03MSB1c2J0bWMgNS0xOjAuMDogdW5rbm93biBzdGF0dXMgcmVj
ZWl2ZWQ6IC03MQ0KDQpUaGUgbG9nIHNob3dzIGFuIGluZmluaXRlIHN0cmVhbSBvZiB0aGVzZSBi
ZWZvcmUgdGhlIHN0YWxsLCBzbyBJIGFzc3VtZSBpdCdzIGFuIGluZmluaXRlIGxvb3AgaW4gdXNi
dG1jLg0KK3VzYnRtYyBtYWludGFpbmVycw0KDQpbICAzNzAuMTcxNjM0XVsgICAgQzBdIHVzYnRt
YyA2LTE6MC4wOiB1bmtub3duIHN0YXR1cyByZWNlaXZlZDogLTcxDQpbICAzNzAuMTc3Nzk5XVsg
ICAgQzFdIHVzYnRtYyAzLTE6MC4wOiB1bmtub3duIHN0YXR1cyByZWNlaXZlZDogLTcxDQpbICAz
NzAuMTgzOTEyXVsgICAgQzBdIHVzYnRtYyA0LTE6MC4wOiB1bmtub3duIHN0YXR1cyByZWNlaXZl
ZDogLTcxDQpbICAzNzAuMTkwMDc2XVsgICAgQzFdIHVzYnRtYyA1LTE6MC4wOiB1bmtub3duIHN0
YXR1cyByZWNlaXZlZDogLTcxDQpbICAzNzAuMTk2MTk0XVsgICAgQzBdIHVzYnRtYyAyLTE6MC4w
OiB1bmtub3duIHN0YXR1cyByZWNlaXZlZDogLTcxDQpbICAzNzAuMjAyMzg3XVsgICAgQzFdIHVz
YnRtYyAzLTE6MC4wOiB1bmtub3duIHN0YXR1cyByZWNlaXZlZDogLTcxDQpbICAzNzAuMjA4NDYw
XVsgICAgQzBdIHVzYnRtYyA2LTE6MC4wOiB1bmtub3duIHN0YXR1cyByZWNlaXZlZDogLTcxDQpb
ICAzNzAuMjE0NjE1XVsgICAgQzFdIHVzYnRtYyA1LTE6MC4wOiB1bmtub3duIHN0YXR1cyByZWNl
aXZlZDogLTcxDQpbICAzNzAuMjIwNzM2XVsgICAgQzBdIHVzYnRtYyA0LTE6MC4wOiB1bmtub3du
IHN0YXR1cyByZWNlaXZlZDogLTcxDQpbICAzNzAuMjI2OTAyXVsgICAgQzFdIHVzYnRtYyAzLTE6
MC4wOiB1bmtub3duIHN0YXR1cyByZWNlaXZlZDogLTcxDQpbICAzNzAuMjMzMDA1XVsgICAgQzBd
IHVzYnRtYyAyLTE6MC4wOiB1bmtub3duIHN0YXR1cyByZWNlaXZlZDogLTcxDQpbICAzNzAuMjM5
MTY4XVsgICAgQzFdIHVzYnRtYyA1LTE6MC4wOiB1bmtub3duIHN0YXR1cyByZWNlaXZlZDogLTcx
DQpbICAzNzAuMjQ1MjcxXVsgICAgQzBdIHVzYnRtYyA2LTE6MC4wOiB1bmtub3duIHN0YXR1cyBy
ZWNlaXZlZDogLTcxDQpbICAzNzAuMjUxNDI2XVsgICAgQzFdIHVzYnRtYyAzLTE6MC4wOiB1bmtu
b3duIHN0YXR1cyByZWNlaXZlZDogLTcxDQpbICAzNzAuMjU3NTUyXVsgICAgQzBdIHVzYnRtYyA0
LTE6MC4wOiB1bmtub3duIHN0YXR1cyByZWNlaXZlZDogLTcxDQpbICAzNzAuMjYzNzE1XVsgICAg
QzFdIHVzYnRtYyA1LTE6MC4wOiB1bmtub3duIHN0YXR1cyByZWNlaXZlZDogLTcxDQpbICAzNzAu
MjY5ODE5XVsgICAgQzBdIHVzYnRtYyAyLTE6MC4wOiB1bmtub3duIHN0YXR1cyByZWNlaXZlZDog
LTcxDQpbICAzNzAuMjc1OTc0XVsgICAgQzFdIHVzYnRtYyAzLTE6MC4wOiB1bmtub3duIHN0YXR1
cyByZWNlaXZlZDogLTcxDQpbICAzNzAuMjgyMTAwXVsgICAgQzBdIHVzYnRtYyA2LTE6MC4wOiB1
bmtub3duIHN0YXR1cyByZWNlaXZlZDogLTcxDQpbICAzNzAuMjg4MjYyXVsgICAgQzFdIHVzYnRt
YyA1LTE6MC4wOiB1bmtub3duIHN0YXR1cyByZWNlaXZlZDogLTcxDQpbICAzNzAuMjk0Mzk5XVsg
ICAgQzBdIHVzYnRtYyA0LTE6MC4wOiB1bmtub3duIHN0YXR1cyByZWNlaXZlZDogLTcx
