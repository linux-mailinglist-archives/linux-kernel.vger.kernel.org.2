Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1BF938936B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 18:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240493AbhESQP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 12:15:58 -0400
Received: from mail02.rohde-schwarz.com ([80.246.32.97]:4883 "EHLO
        mail02.rohde-schwarz.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240333AbhESQP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 12:15:56 -0400
Received: from amu316.rsint.net (10.0.26.65) by mail-emea.rohde-schwarz.com
 (172.21.64.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.858.5; Wed, 19 May 2021
 18:14:23 +0200
Received: from GMU418.rsint.net ([10.0.230.144])
          by amu316.rsint.net (Totemo SMTP Server) with SMTP ID 192;
          Wed, 19 May 2021 18:14:22 +0200 (CEST)
Received: from GMU001.rsint.net (10.0.2.59) by GMU418.rsint.net (10.0.230.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2242.4; Wed, 19 May
 2021 18:14:22 +0200
Received: from GMU006.rsint.net (10.0.2.28) by GMU001.rsint.net (10.0.2.59)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2242.4; Wed, 19
 May 2021 18:14:20 +0200
Received: from GMU006.rsint.net ([fe80::81e7:6ea1:2437:698b]) by
 GMU006.rsint.net ([fe80::81e7:6ea1:2437:698b%12]) with mapi id
 15.01.2242.010; Wed, 19 May 2021 18:14:20 +0200
From:   Guido Kiener <Guido.Kiener@rohde-schwarz.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        dave penkler <dpenkler@gmail.com>
CC:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+e2eae5639e7203360018@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Subject: RE: Re: Re: Re: Re: Re: [syzbot] INFO: rcu detected stall in tx
Thread-Topic: Re: Re: Re: Re: Re: [syzbot] INFO: rcu detected stall in tx /ur/
Thread-Index: AddMydQnpf+UY0qAQvO+sGdBieUd+Q==
Date:   Wed, 19 May 2021 16:14:20 +0000
Message-ID: <d673611ca53f42a3a629eb051cabc6eb@rohde-schwarz.com>
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
X-GBS-PROC: KF5gH9ulGnv8abbfqGb4GPdB7csXqGJIJgSlDrbLuYoTJfkM0p+NxXaFwTtnAzYxAlc1TIVIPQm7qPURuUExXf+/J1VB5RzfMdXcQRGd2JnaGfc/E7m8OsoVMaIY0Z+m
X-GBS-PROCJOB: SBChRPJW6y3U+esSqSfPEbGTio5ezKPGjfXBfNkxmX7jpBbHiaQfG4Xm73Ut51dc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBXZWQsIE1heSAxOSwgMjAyMSBhdCAxMDo0ODoyOUFNICswMjAwLCBkYXZlIHBlbmtsZXIg
d3JvdGU6DQo+ID4gT24gU2F0LCA4IE1heSAyMDIxIGF0IDE2OjI5LCBBbGFuIFN0ZXJuIDxzdGVy
bkByb3dsYW5kLmhhcnZhcmQuZWR1PiB3cm90ZToNCj4gPiA+DQo+ID4gPiBPbiBTYXQsIE1heSAw
OCwgMjAyMSBhdCAxMDoxNDo0MUFNICswMjAwLCBkYXZlIHBlbmtsZXIgd3JvdGU6DQo+ID4gPiA+
IFdoZW4gdGhlIGhvc3QgZHJpdmVyIGRldGVjdHMgYSBwcm90b2NvbCBlcnJvciB3aGlsZSBwcm9j
ZXNzaW5nIGFuDQo+ID4gPiA+IFVSQiBpdCBjb21wbGV0ZXMgdGhlIFVSQiB3aXRoIEVQUk9UTyBz
dGF0dXMgYW5kIG1hcmtzIHRoZSBlbmRwb2ludA0KPiA+ID4gPiBhcyBoYWx0ZWQuDQo+ID4gPg0K
PiA+ID4gTm90IHRydWUuICBJdCBkb2VzIG5vdCBtYXJrIHRoZSBlbmRwb2ludCBhcyBoYWx0ZWQs
IG5vdCB1bmxlc3MgaXQNCj4gPiA+IHJlY2VpdmVzIGEgU1RBTEwgaGFuZHNoYWtlIGZyb20gdGhl
IGRldmljZS4gIEEgU1RBTEwgaXMgbm90IGENCj4gPiA+IHByb3RvY29sIGVycm9yLg0KPiA+ID4N
Cj4gPiA+ID4gV2hlbiB0aGUgY2xhc3MgZHJpdmVyIHJlc3VibWl0cyB0aGUgVVJCIGFuZCB0aGUg
aWYgdGhlIGhvc3QgZHJpdmVyDQo+ID4gPiA+IGZpbmRzIHRoZSBlbmRwb2ludCBzdGlsbCBtYXJr
ZWQgYXMgaGFsdGVkIGl0IHNob3VsZCByZXR1cm4gRVBJUEUNCj4gPiA+ID4gc3RhdHVzIG9uIHRo
ZSByZXN1Ym1pdHRlZCBVUkINCj4gPiA+DQo+ID4gPiBJcnJlbGV2YW50Lg0KPiA+IE5vdCBhdCBh
bGwuIFRoZSBwb2ludCBpcyB0aGF0IHdoZW4gYW4gYXBwbGljYXRpb24gaXMgdGFsa2luZyB0byBh
bg0KPiA+IGluc3RydW1lbnQgb3ZlciB0aGUgdXNidG1jIGRyaXZlciwgdGhlIHVuZGVybHlpbmcg
aG9zdCBjb250cm9sbGVyIGFuZA0KPiA+IGl0cyBkcml2ZXIgd2lsbCBkZXRlY3QgYW5kIHNpbGVu
Y2UgYSBiYWJibGluZyBlbmRwb2ludC4NCj4gDQo+IE5vLCB0aGV5IHdvbid0LiAgVGhhdCBpcywg
dGhleSB3aWxsIGRldGVjdCBhIGJhYmJsZSBlcnJvciBhbmQgcmV0dXJuIGFuIGVycm9yIHN0YXR1
cywgYnV0DQo+IHRoZXkgd29uJ3Qgc2lsZW5jZSB0aGUgZW5kcG9pbnQuICBXaGF0IG1ha2VzIHlv
dSB0aGluayB0aGV5IHdpbGw/DQoNCk1heWJlIHRoZXJlIGlzIGEgbWlzdW5kZXJzdGFuZGluZy4g
SSBndWVzcyB0aGF0IERhdmUgd2FudGVkIHRvIHByb3Bvc2U6DQoiRVBST1RPIGlzIGEgbGluayBs
ZXZlbCBpc3N1ZSBhbmQgbmVlZHMgdG8gYmUgaGFuZGxlZCBieSB0aGUgaG9zdCBkcml2ZXIuDQpX
aGVuIHRoZSBob3N0IGRyaXZlciBkZXRlY3RzIGEgcHJvdG9jb2wgZXJyb3Igd2hpbGUgcHJvY2Vz
c2luZyBhbg0KVVJCIGl0IFNIT1VMRCBjb21wbGV0ZSB0aGUgVVJCIHdpdGggRVBST1RPIHN0YXR1
cyBhbmQgU0hPVUxEIG1hcmsgdGhlIGVuZHBvaW50DQphcyBoYWx0ZWQuIg0KSXMgdGhpcyBhIHJl
YWxpc3RpYyBmaXggZm9yIGFsbCBob3N0IGRyaXZlcnM/DQoNCi1HdWlkbw0K
