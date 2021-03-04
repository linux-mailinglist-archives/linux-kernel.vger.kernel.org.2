Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F48132D82F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 17:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238718AbhCDQ55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 11:57:57 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:35820 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238515AbhCDQ5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 11:57:43 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-78-EyZsMwWTOZC7wQVEaWCYww-1; Thu, 04 Mar 2021 16:56:05 +0000
X-MC-Unique: EyZsMwWTOZC7wQVEaWCYww-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 4 Mar 2021 16:56:05 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 4 Mar 2021 16:56:05 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Geert Uytterhoeven' <geert@linux-m68k.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: A note on the 5.12-rc1 tag
Thread-Topic: A note on the 5.12-rc1 tag
Thread-Index: AQHXEQdcNEtWyD0uokOcoyrPbbFuvap0CvcA
Date:   Thu, 4 Mar 2021 16:56:05 +0000
Message-ID: <79c3603cb086435b87030227d3d39443@AcuMS.aculab.com>
References: <CAHk-=wjnzdLSP3oDxhf9eMTYo7GF-QjaNLBUH1Zk3c4A7X75YA@mail.gmail.com>
 <CAMuHMdWn7GPkLrRnTJRT=9W-PVwoWOVBTqdM-gR180c66vGfOQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWn7GPkLrRnTJRT=9W-PVwoWOVBTqdM-gR180c66vGfOQ@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBUaHUsIE1hciA0LCAyMDIxIGF0IDE6NTkgUE0gTGludXMgVG9ydmFsZHMNCj4gPHRvcnZh
bGRzQGxpbnV4LWZvdW5kYXRpb24ub3JnPiB3cm90ZToNCj4gPiBBbmQsIGFzIGZhciBhcyBJIGtu
b3csIGFsbCB0aGUgbm9ybWFsIGRpc3RyaWJ1dGlvbnMgc2V0IHRoaW5ncyB1cCB3aXRoDQo+ID4g
c3dhcCBwYXJ0aXRpb25zLCBub3QgZmlsZXMsIGJlY2F1c2UgaG9uZXN0bHksIHN3YXBmaWxlcyB0
ZW5kIHRvIGJlDQo+ID4gc2xvd2VyIGFuZCBoYXZlIHZhcmlvdXMgb3RoZXIgY29tcGxleGl0eSBp
c3N1ZXMuDQo+IA0KPiBMb29rcyBsaWtlIHRoaXMgaGFzIGNoYW5nZWQgaW4gYXQgbGVhc3QgVWJ1
bnR1OiBteSBkZXNrdG9wIG1hY2hpbmUsDQo+IHdoaWNoIGdvdCBVYnVudHUgMTguMDRMVFMgZHVy
aW5nIGluaXRpYWwgaW5zdGFsbGF0aW9uLCBpcyB1c2luZyBhIChzbWFsbCkNCj4gc3dhcGZpbGUg
aW5zdGVhZCBvZiBhIHN3YXAgcGFydGl0aW9uLg0KDQpNeSBvbGRlciB1YnVudHUgKDEzLjA0KSBk
aWRuJ3QgaGF2ZSBzd2FwIGF0IGFsbC4NCkkgaGFkIHRvIGFkZCBzb21lIHdoZW4gcnVubmluZyBt
dWx0aXBsZSBjb3BpZXMgb2YgdGhlIEFsdGVyYQ0KZnBnYSBzb2Z0d2FyZSBzdGFydGVkIGNhdXNp
bmcgZ3JpZWYuDQpUaGF0IHdpbGwgYmUgYSBmaWxlLg0KDQpBZnRlciBhbGwgb25jZSB5b3Ugc3Rh
cnQgc3dhcHBpbmcgaXQgaXMgYWxsIGhvcnJpZCBhbmQgc2xvdy4NClN3YXAgdG8gZmlsZSBtYXkg
YmUgc2xvd2VyLCBidXQgYXBhcnQgZnJvbSBkdW1waW5nIG91dCBpbmFjdGl2ZQ0KcGFnZXMgeW91
IHJlYWxseSBkb24ndCB3YW50IHRvIGJlIGRvaW5nIGl0IC0gc28gaXQgZG9lc24ndCBtYXR0ZXIu
DQoNCkhpc3RvcmljYWxseSBzd2FwIHdhcyBhIHBhcnRpdGlvbiBhbmQgbGFyZ2VyIHRoYW4gcGh5
c2ljYWwgbWVtb3J5Lg0KVGhpcyBhbGxvd3Mgc2ltcGxlICdkdW1wIHRvIHN3YXAnIG9uIHBhbmlj
IChmb3IgbWFueSBkaXNrIHR5cGVzKS4NCkJ1dCBJJ3ZlIG5vdCBzZWVuIHRoYXQgc3VwcG9ydCBp
biBsaW51eC4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJh
bWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0
cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

