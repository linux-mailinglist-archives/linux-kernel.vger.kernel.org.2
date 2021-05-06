Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1DAC3750F8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 10:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbhEFIhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 04:37:21 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:44976 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231880AbhEFIhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 04:37:10 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-183-nFQkFbjaPiGNu3LYzjjy0A-1; Thu, 06 May 2021 09:36:09 +0100
X-MC-Unique: nFQkFbjaPiGNu3LYzjjy0A-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Thu, 6 May 2021 09:36:08 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.015; Thu, 6 May 2021 09:36:08 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andy Lutomirski' <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
CC:     Al Viro <viro@zeniv.linux.org.uk>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Waiman Long" <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Christoph Hellwig <hch@lst.de>,
        Mark Rutland <mark.rutland@arm.com>,
        "Borislav Petkov" <bp@alien8.de>
Subject: RE: [PATCH v4 3/4] x86/uaccess: Use pointer masking to limit uaccess
 speculation
Thread-Topic: [PATCH v4 3/4] x86/uaccess: Use pointer masking to limit uaccess
 speculation
Thread-Index: AQHXQc9pu8vqbxm3x0CYXgd0hdGkc6rWGNww
Date:   Thu, 6 May 2021 08:36:08 +0000
Message-ID: <986301bcdc7c488d86dd5f11c988bf87@AcuMS.aculab.com>
References: <cover.1620186182.git.jpoimboe@redhat.com>
 <5ba93cdbf35ab40264a9265fc24575a9b2f813b3.1620186182.git.jpoimboe@redhat.com>
 <CALCETrWQrMkeP+=pkNVNvSs9q3ZhhLq_ceHJ-N72Urp2KBrUfQ@mail.gmail.com>
In-Reply-To: <CALCETrWQrMkeP+=pkNVNvSs9q3ZhhLq_ceHJ-N72Urp2KBrUfQ@mail.gmail.com>
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

RnJvbTogQW5keSBMdXRvbWlyc2tpDQo+IFNlbnQ6IDA1IE1heSAyMDIxIDE3OjU1DQouLi4NCj4g
SXMgdGhlcmUgYW4gZXF1YWxseSBlZmZpY2llbnQgc2VxdWVuY2UgdGhhdCBzcXVpc2hlcyB0aGUg
cG9pbnRlciB2YWx1ZQ0KPiB0byBzb21ldGhpbmcgbm9uY2Fub25pY2FsIG9yIHNvbWV0aGluZyBs
aWtlIC0xIGluc3RlYWQgb2YgMD8gIEknbSBub3QNCj4gc3VyZSB0aGlzIG1hdHRlcnMsIGJ1dCBp
dCBvcGVucyB1cCB0aGUgcG9zc2liaWxpdHkgb2YgY29tYmluaW5nIHRoZQ0KPiBhY2Nlc3Nfb2sg
Y2hlY2sgd2l0aCB0aGUgbWFza2luZyB3aXRob3V0IGFueSBicmFuY2hlcyBhdCBhbGwuDQoNCkFy
ZSB5b3UgdGhpbmtpbmcgb2YgdXNpbmc6DQoJdWFkZHIgPSBhY2Nlc3Nfb2sodWFkZHIsIHNpemUp
DQphbmQgaGF2aW5nIHRoZSBvdXRwdXQgdmFsdWUgYmVpbmcgb25lIHRoYXQgaXMgZ3VhcmFudGVl
ZA0KdG8gZmF1bHQgd2hlbiAoYSBsaXR0bGUgbGF0ZXIgb24pIHVzZWQgdG8gYWNjZXNzIHVzZXIg
bWVtb3J5Pw0KDQpBcyB3ZWxsIGFzIHRoZSBwcm9ibGVtIG9mIGZpbmRpbmcgYSBzdWl0YWJsZSBp
bnZhbGlkIGFkZHJlc3MNCmluIDMyYml0IGFyY2hpdGVjdHVyZXMgdGhlcmUgY2FuIGJlIGlzc3Vl
cyBpZiB0aGUgY29kZSBhY2Nlc3Nlcw0KKHVhZGRyICsgYmlnX29mZnNldCkgc2luY2UgdGhhdCBj
b3VsZCBiZSBvdXRzaWRlIHRoZSBpbnZhbGlkDQphZGRyZXNzIHdpbmRvdy4NCg0KV2UgYXJlIGJh
Y2sgdG8gdGhlIGZhY3QgdGhhdCBpZiB3ZSBrbm93IHRoZSBhY2Nlc3NlcyBhcmUNCnNlcXVlbnRp
YWwgKG9yIGEgc2luZ2xlIGFjY2VzcykgdGhlbiBpdCBjYW4gdXN1YWxseSBiZQ0KYXJyYW5nZWQg
Zm9yIHRoZW0gdG8gZmF1bHQgd2l0aG91dCBhbiBleHBsaWNpdCBzaXplIGNoZWNrLg0KDQpUaGlz
IGNvdWxkIG1lYW4geW91IGhhdmU6DQoJaWYgKGFjY2Vzc19va19tYXNrKCZ1YWRkciwgc2l6ZSkp
DQoJCXJldHVybiAtRUZBVUxUOw0KdGhhdCBuZXZlciBhY3R1YWxseSByZXR1cm5zIEVGQVVMVCBv
biBzb21lIGFyY2hpdGVjdHVyZXMNCndoZW4gc2l6ZSBpcyBhIHNtYWxsIGNvbXBpbGUtdGltZSBj
b25zdGFudC4NCg0KSWYgeW91IGRvbid0IG5lZWQgdG8gY2hlY2sgdGhlIHNpemUgdGhlbiB5b3Un
ZCBuZWVkDQpzb21ldGhpbmcgbGlrZToNCgltb3YgdWFkZHIsIHJlZw0KCWFkZCAjLVRBU0tfU0la
RV9NQVgsIHJlZwkvLyBzZXRzIGNhcnJ5IGZvciBiYWQgYWRkcmVzc2VzDQoJc2JiIHJlZywgcmVn
CQkJLy8gLTEgZm9yIGJhZCBhZGRyZXNzZXMNCglvciAgcmVnLCB1YWRkcg0KVGhhdCBjb252ZXJ0
cyBhZGRyZXNzZXMgYWJvdmUgVEFTS19TSVpFX01BU0sgdG8gLTEuDQpOb24tYnl0ZSBhY2Nlc3Nl
cyB3aWxsIGZhdWx0IG9uIGFsbCB4ODYgY3B1Lg0KRm9yIHg2NCAoYW5kIHNvbWUgb3RoZXIgNjRi
aXQpIHlvdSBjYW4gY2xlYXIgdGhlIHRvcCBmZXcNCmJpdHMgdG8gZ2V0IGFuIGludmFsaWQgYWRk
cmVzcy4NCg0KU28gcHJvYmFibHkgb2sgZm9yIGdldF91c2VyKCkgYW5kIGNvcHlfZnJvbV91c2Vy
KCkgKGV0YykNCmJ1dCBub3QgYXMgYSBtb3JlIGdlbmVyYWwgY2hlY2suDQoNCglEYXZpZC4NCg0K
LQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0s
IE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdh
bGVzKQ0K

