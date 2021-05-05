Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC6D373CAE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 15:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbhEENwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 09:52:10 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:53194 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231265AbhEENwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 09:52:08 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-177-z7GzCxiKMCmwap03myQkMA-1; Wed, 05 May 2021 14:51:08 +0100
X-MC-Unique: z7GzCxiKMCmwap03myQkMA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Wed, 5 May 2021 14:51:07 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.015; Wed, 5 May 2021 14:51:07 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Josh Poimboeuf' <jpoimboe@redhat.com>
CC:     Al Viro <viro@zeniv.linux.org.uk>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
Thread-Index: AQHXQWJqu8vqbxm3x0CYXgd0hdGkc6rUkPgwgAA+HoCAABP/4A==
Date:   Wed, 5 May 2021 13:51:06 +0000
Message-ID: <f7b0cdca14684c32868bc84df348ac9e@AcuMS.aculab.com>
References: <cover.1620186182.git.jpoimboe@redhat.com>
 <5ba93cdbf35ab40264a9265fc24575a9b2f813b3.1620186182.git.jpoimboe@redhat.com>
 <2f75c496ac774444b75ff808854b8e5f@AcuMS.aculab.com>
 <20210505131943.ci2svd6fmb22y7ac@treble>
In-Reply-To: <20210505131943.ci2svd6fmb22y7ac@treble>
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

RnJvbTogSm9zaCBQb2ltYm9ldWYNCj4gU2VudDogMDUgTWF5IDIwMjEgMTQ6MjANCi4uLg0KPiA+
IGFjY2Vzc19vaygpIGFuZCBtYXNrX3VzZXJfcHRyKCkgYXJlIGRvaW5nIG11Y2ggdGhlIHNhbWUg
Y2hlY2suDQo+ID4gSXMgdGhlcmUgc2NvcGUgZm9yIG1ha2luZyBhY2Nlc3Nfb2soKSByZXR1cm4g
dGhlIG1hc2tlZCBwb2ludGVyPw0KPiA+DQo+ID4gU28gdGhlIGNhbm9uaWNhbCBjYWxsaW5nIGNv
ZGUgd291bGQgYmU6DQo+ID4gCXVwdHIgPSBhY2Nlc3Nfb2sodXB0ciwgc2l6ZSk7DQo+ID4gCWlm
ICghdXB0cikNCj4gPiAJCXJldHVybiAtRUZBVUxUOw0KPiA+DQo+ID4gVGhpcyB3b3VsZCBlcnJv
ciByZXF1ZXN0cyBmb3IgYWRkcmVzcyAwIGVhcmxpZXIgLSBidXQgSSBkb24ndA0KPiA+IGJlbGll
dmUgdGhleSBhcmUgZXZlciB2YWxpZCBpbiBMaW51eC4NCj4gPiAoU29tZSBoaXN0b3JpYyB4ODYg
YS5vdXQgZm9ybWF0cyBkaWQgbG9hZCB0byBhZGRyZXNzIDAuKQ0KPiA+DQo+ID4gQ2xlYXJseSBm
b3IgYSBmb2xsb3cgdXAgcGF0Y2guDQo+IA0KPiBZZWFoLiAgSSBtZW50aW9uZWQgYSBzaW1pbGFy
IGlkZWEgaW4gdGhlIGNvdmVyIGxldHRlci4NCj4gDQo+IEJ1dCBJJ20gdGhpbmtpbmcgd2Ugc2hv
dWxkIHN0aWxsIHJlbmFtZSBpdCB0byBhY2Nlc3Nfb2tfbWFzaygpLCBvcg0KPiBvdGhlcndpc2Ug
Y2hhbmdlIHRoZSBBUEkgdG8gYXZvaWQgdGhlIG1hc2tlZCB2YWx1ZSBnZXR0aW5nIGlnbm9yZWQu
DQoNClNvbWV0aGluZyBsaWtlOg0KCWlmIChhY2Nlc3Nfb2tfbWFzaygmdWFkZHIsIHNpemUpKQ0K
CQlyZXR1cm4gLUVGQVVMVDsNCm1pZ2h0IHdvcmsuDQoNCj4gQnV0IHRoYXQnbGwgYmUgYSBtdWNo
IGJpZ2dlciBwYXRjaC4NCg0KVHJ1ZSAtIGFuZCB3b3VsZCBuZWVkIHRvIGJlIGRvbmUgaXMgc3Rh
Z2VzLg0KDQpUaGUgb3RoZXIgb3B0aW1pc2F0aW9uIGlzIGZvciBzaG9ydC9zZXF1ZW50aWFsIGFj
Y2Vzc2VzLg0KSW4gcGFydGljdWxhciBnZXRfdXNlcigpIGFuZCBjb3B5X2Zyb21fdXNlcigpLg0K
SGVyZSB0aGUgJ3NpemUnIGFyZ3VtZW50IGNhbiBvZnRlbiBiZSBhdm9pZGVkLg0KRWl0aGVyIGJl
Y2F1c2Ugb25seSB0aGUgYmFzZSBhZGRyZXNzIGlzIGV2ZXIgYWNjZXNzZWQsIG9yIHRoZQ0Ka2Vy
bmVsIGd1YXJhbnRlZXMgYW4gdW5tYXBwZWQgcGFnZSBiZXR3ZWVuIHVzZXIgYW5kIGtlcm5lbCBh
ZGRyZXNzZXMuDQoNCklJUkMgeDg2IGhhcyB0byBoYXZlIGFuIHVubWFwcGVkIHBhZ2UgYmVjYXVz
ZSBvZiAnaXNzdWVzJyB3aXRoDQpwcmVmZXRjaCBhY3Jvc3MgdGhlIGJvdW5kYXJ5Lg0KSSBkb24n
dCBrbm93IGlmIGl0IGlzIG9uIHRoZSB1c2VyIG9yIGtlcm5lbCBzaWRlIC0gZG9lc24ndCByZWFs
bHkgbWF0dGVyLg0KDQpBbHNvIGZvciB0eXBpY2FsIDY0Yml0IGFyY2hpdGVjdHVyZXMgd2hlcmUg
dGhlcmUgaXMgYSBiaWcgYWRkcmVzcyBob2xlDQphcm91bmQgMXVsIDw8IDYzLCBhY2Nlc3Nfb2so
KSBjYW4ganVzdCBjaGVjayAoZm9yIGV4YW1wbGUpOg0KCWlmICgoKGxvbmcpdWFkZHIgfCBzaXpl
KSAmIH4wdWwgPDwgNTYpDQoJCXJldHVybiAtRUZBVUxULg0KKGNoYW5nZSB0aGUgNTYgdG8gbWF0
Y2ggdGhlIFRBU0tfU0laRV9NQVgpLg0KVGhlIGNvbXBpbGVyIHdpbGwgdGhlbiBvcHRpbWlzZSBh
d2F5IGFueSBjb25zdGFudCBzaXplLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNz
IExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAx
UFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

