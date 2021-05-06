Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20485375075
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 09:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbhEFH6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 03:58:49 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:28908 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233541AbhEFH6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 03:58:47 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-157-Egn_HFQhOoSF-KNyXXlsnw-1; Thu, 06 May 2021 08:57:46 +0100
X-MC-Unique: Egn_HFQhOoSF-KNyXXlsnw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Thu, 6 May 2021 08:57:44 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.015; Thu, 6 May 2021 08:57:44 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Waiman Long" <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Borislav Petkov <bp@alien8.de>
Subject: RE: [PATCH v4 3/4] x86/uaccess: Use pointer masking to limit uaccess
 speculation
Thread-Topic: [PATCH v4 3/4] x86/uaccess: Use pointer masking to limit uaccess
 speculation
Thread-Index: AQHXQWJqu8vqbxm3x0CYXgd0hdGkc6rUkPgwgACVc4CAAPDYwA==
Date:   Thu, 6 May 2021 07:57:44 +0000
Message-ID: <ea9607e9c30e4ed0b2f0c0aa4bc98c6c@AcuMS.aculab.com>
References: <cover.1620186182.git.jpoimboe@redhat.com>
 <5ba93cdbf35ab40264a9265fc24575a9b2f813b3.1620186182.git.jpoimboe@redhat.com>
 <2f75c496ac774444b75ff808854b8e5f@AcuMS.aculab.com>
 <CAHk-=wh-a6B11tH3upLG+-P5_yFPs3PB8tiXO5JKaQjUvhOMYg@mail.gmail.com>
In-Reply-To: <CAHk-=wh-a6B11tH3upLG+-P5_yFPs3PB8tiXO5JKaQjUvhOMYg@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMDUgTWF5IDIwMjEgMTk6MzINCj4gDQo+IE9u
IFdlZCwgTWF5IDUsIDIwMjEgYXQgMTo0OCBBTSBEYXZpZCBMYWlnaHQgPERhdmlkLkxhaWdodEBh
Y3VsYWIuY29tPiB3cm90ZToNCj4gPg0KPiA+IFRoaXMgd291bGQgZXJyb3IgcmVxdWVzdHMgZm9y
IGFkZHJlc3MgMCBlYXJsaWVyIC0gYnV0IEkgZG9uJ3QNCj4gPiBiZWxpZXZlIHRoZXkgYXJlIGV2
ZXIgdmFsaWQgaW4gTGludXguDQo+ID4gKFNvbWUgaGlzdG9yaWMgeDg2IGEub3V0IGZvcm1hdHMg
ZGlkIGxvYWQgdG8gYWRkcmVzcyAwLikNCj4gDQo+IE5vdCBvbmx5IGxvYWRpbmcgYXQgYWRkcmVz
cyAwIC0gdGhlcmUgYXJlIHZhcmlvdXMgcmVhbCByZWFzb24gcyB3aHkNCj4gYWRkcmVzcyAwIG1p
Z2h0IGFjdHVhbGx5IGJlIG5lZWRlZC4NCj4gDQo+IEFueWJvZHkgd2hvIHN0aWxsIHJ1bnMgYSAz
Mi1iaXQga2VybmVsIGFuZCB3YW50cyB0byB1c2Ugdm04NiBtb2RlLCBmb3INCj4gZXhhbXBsZSwg
cmVxdWlyZXMgYWRkcmVzcyAwIGJlY2F1c2UgdGhhdCdzIHNpbXBseSBob3cgdGhlIGhhcmR3YXJl
DQo+IHdvcmtzLg0KPiANCj4gU28gbm8uICJtYXNrIHRvIHplcm8gYW5kIG1ha2UgemVybyBpbnZh
bGlkIiBpcyBub3QgYSBwcm9wZXIgbW9kZWwuDQoNCkkgaGFkIG15IGRvdWJ0cy4NCkJ1dCBsZXR0
aW5nIHVzZXJzcGFjZSBtYXAgYWRkcmVzcyB6ZXJvIGhhcyBiZWVuIGEgc2VjdXJpdHkgcHJvYmxl
bS4NCkl0IGNhbiB0dXJuIGEga2VybmVsIHBhbmljIGludG8gZXhlY3V0aW5nICd1c2VyJyBjb2Rl
IHdpdGgNCnN1cGVydmlzb3IgcGVybWlzc2lvbnMuDQoNClNvIEkgZGlkIHdvbmRlciBpZiBpdCBo
YWQgYmVlbiBiYW5uZWQgY29tcGxldGVseS4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRk
cmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBN
SzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

