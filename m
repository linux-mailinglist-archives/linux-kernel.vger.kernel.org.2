Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D5E459FEF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 11:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235407AbhKWKVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 05:21:40 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:51097 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231221AbhKWKVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 05:21:39 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-1-qLWDfLgOMIW-gPxbsDmEMw-1; Tue, 23 Nov 2021 10:18:28 +0000
X-MC-Unique: qLWDfLgOMIW-gPxbsDmEMw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.26; Tue, 23 Nov 2021 10:18:27 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.026; Tue, 23 Nov 2021 10:18:27 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Vlastimil Babka' <vbabka@suse.cz>,
        Christoph Lameter <cl@gentwo.org>
CC:     Rustam Kovhaev <rkovhaev@gmail.com>,
        "penberg@kernel.org" <penberg@kernel.org>,
        "rientjes@google.com" <rientjes@google.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "dvyukov@google.com" <dvyukov@google.com>
Subject: RE: [PATCH v4] slob: add size header to all allocations
Thread-Topic: [PATCH v4] slob: add size header to all allocations
Thread-Index: AQHX344YYrlQE8gw8k+1+rn2N9Qq+awQ435Q
Date:   Tue, 23 Nov 2021 10:18:27 +0000
Message-ID: <69fc0cead9774dfdba816a8e25f30a53@AcuMS.aculab.com>
References: <037227db-c869-7d9c-65e8-8f5f8682171d@suse.cz>
 <20211122013026.909933-1-rkovhaev@gmail.com>
 <alpine.DEB.2.22.394.2111221018070.202803@gentwo.de>
 <3c996e22-034f-1013-3978-1f786aae38fb@suse.cz>
 <alpine.DEB.2.22.394.2111221133110.204314@gentwo.de>
 <148d2774-77b9-bb25-c132-80b00e16ea06@suse.cz>
In-Reply-To: <148d2774-77b9-bb25-c132-80b00e16ea06@suse.cz>
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

RnJvbTogVmxhc3RpbWlsIEJhYmthDQo+IFNlbnQ6IDIyIE5vdmVtYmVyIDIwMjEgMTA6NDYNCj4g
DQo+IE9uIDExLzIyLzIxIDExOjM2LCBDaHJpc3RvcGggTGFtZXRlciB3cm90ZToNCj4gPiBPbiBN
b24sIDIyIE5vdiAyMDIxLCBWbGFzdGltaWwgQmFia2Egd3JvdGU6DQo+ID4NCj4gPj4gQnV0IGl0
IHNlZW1zIHRoZXJlJ3Mgbm8gcmVhc29uIHdlIGNvdWxkbid0IGRvIGJldHRlcj8gSS5lLiB1c2Ug
dGhlIHZhbHVlIG9mDQo+ID4+IFNMT0JfSERSX1NJWkUgb25seSB0byBhbGlnbiB0aGUgYmVnaW5u
aW5nIG9mIGFjdHVhbCBvYmplY3QgKGFuZCBuYW1lIHRoZQ0KPiA+PiBkZWZpbmUgZGlmZmVyZW50
IHRoYW4gU0xPQl9IRFJfU0laRSkuIEJ1dCB0aGUgc2l6ZSBvZiB0aGUgaGVhZGVyLCB3aGVyZSB3
ZQ0KPiA+PiBzdG9yZSB0aGUgb2JqZWN0IGxlbmdodCBjb3VsZCBiZSBqdXN0IGEgbmF0aXZlIHdv
cmQgLSA0IGJ5dGVzIG9uIDMyYml0LCA4IG9uDQo+ID4+IDY0Yml0LiBUaGUgYWRkcmVzcyBvZiB0
aGUgaGVhZGVyIHNob3VsZG4ndCBoYXZlIGEgcmVhc29uIHRvIGJlIGFsc28gYWxpZ25lZA0KPiA+
PiB0byBBUkNIX0tNQUxMT0NfTUlOQUxJR04gLyBBUkNIX1NMQUJfTUlOQUxJR04gYXMgb25seSBT
TE9CIGl0c2VsZiBwcm9jZXNzZXMNCj4gPj4gaXQgYW5kIG5vdCB0aGUgc2xhYiBjb25zdW1lcnMg
d2hpY2ggcmVseSBvbiB0aG9zZSBhbGlnbm1lbnRzPw0KPiA+DQo+ID4gV2VsbCB0aGUgYmVzdCB3
YXkgd291bGQgYmUgdG8gcHV0IGl0IGF0IHRoZSBlbmQgb2YgdGhlIG9iamVjdCBpbiBvcmRlciB0
bw0KPiA+IGF2b2lkIHRoZSBhbGlnbm1lbnQgcHJvYmxlbS4gVGhpcyBpcyBhIHBhcnRpY3VsYXIg
aXNzdWUgd2l0aCBTTE9CIGJlY2F1c2UNCj4gPiBpdCBhbGxvd3MgbXVsdGlwbGUgdHlwZXMgb2Yg
b2JqZWN0cyBpbiBhIHNpbmdsZSBwYWdlIGZyYW1lLg0KPiA+DQo+ID4gSWYgb25seSBvbmUgdHlw
ZSBvZiBvYmplY3Qgd291bGQgYmUgYWxsb3dlZCB0aGVuIHRoZSBvYmplY3Qgc2l6ZSBldGMgY2Fu
DQo+ID4gYmUgc3RvcmVkIGluIHRoZSBwYWdlIHN0cnVjdC4NCg0KT3IganVzdCBhIHNpbmdsZSBi
eXRlIHRoYXQgaXMgdGhlIGluZGV4IG9mIHRoZSBhc3NvY2lhdGVkIGZyZWUgbGlzdCBzdHJ1Y3R1
cmUuDQpGb3IgMzJiaXQgYW5kIGZvciB0aGUgc21hbGxlciBrbWFsbG9jKCkgYXJlYSBpdCBtYXkg
YmUgcmVhc29uYWJsZSB0byBoYXZlDQphIHNlcGFyYXRlIGFycmF5IGluZGV4ZWQgYnkgdGhlIHBh
Z2Ugb2YgdGhlIGFkZHJlc3MuDQoNCj4gPiBTbyBJIGd1ZXNzIHBsYWNlbWVudCBhdCB0aGUgYmVn
aW5uaW5nIGNhbm5vdCBiZSBhdm9pZGVkLiBUaGF0IGluIHR1cm4gcnVucw0KPiA+IGludG8gdHJv
dWJsZSB3aXRoIHRoZSBETUEgcmVxdWlyZW1lbnRzIG9uIHNvbWUgcGxhdGZvcm1zIHdoZXJlIHRo
ZQ0KPiA+IGJlZ2lubmluZyBvZiB0aGUgb2JqZWN0IGhhcyB0byBiZSBjYWNoZSBsaW5lIGFsaWdu
ZWQuDQo+IA0KPiBJdCdzIG5vIHByb2JsZW0gdG8gaGF2ZSB0aGUgcmVhbCBiZWdpbm5pbmcgb2Yg
dGhlIG9iamVjdCBhbGlnbmVkLCBhbmQgdGhlDQo+IHByZXBlbmRlZCBoZWFkZXIgbm90Lg0KDQpJ
J20gbm90IHN1cmUgdGhhdCBoZWxwcy4NClRoZSBoZWFkZXIgY2FuJ3Qgc2hhcmUgYSBjYWNoZSBs
aW5lIHdpdGggdGhlIHByZXZpb3VzIGl0ZW0gKGJlY2F1c2UgaXQNCm1pZ2h0IGJlIG1hcHBlZCBm
b3IgRE1BKSBzbyB3aWxsIGFsd2F5cyB0YWtlIGEgZnVsbCBjYWNoZSBsaW5lLg0KDQpUaGVyZSBt
aWdodCBtZSBzb21lIHN0cmFuZ2Ugc2NoZW1lIHdoZXJlIHlvdSBwdXQgdGhlIHNpemUgYXQgdGhl
IGVuZA0KYW5kIHRoZSBvZmZzZXQgb2YgdGhlICdsYXN0IGVuZCcgaW50byB0aGUgcGFnZSBzdHJ1
Y3QuDQpUaGUgRE1BIEFQSSBzaG91bGQgbGV0IHlvdSBzYWZlbHkgcmVhZCB0aGUgc2l6ZSBmcm9t
IGFuIGFsbG9jYXRlZA0KYnVmZmVyIC0gYnV0IHlvdSBjYW4ndCBtb2RpZnkgaXQuDQoNClRoZXJl
IGlzIGFsc28gYWxsIHRoZSBjb2RlIHRoYXQgYWxsb2NhdGVzICdwb3dlciBvZiAyJyBzaXplZCBi
dWZmZXJzDQp1bmRlciB0aGUgYXNzdW1wdGlvbiB0aGV5IGFyZSBlZmZpY2llbnQgLSBhcyBzb29u
IGFzIHlvdSBhZGQgYSBzaXplDQpmaWVsZCB0aGF0IGFzc3VtcHRpb24ganVzdCBjYXVzZXMgdGhl
IHNpemVzIG9mIGl0ZW0gdG8gKG9mdGVuKSBkb3VibGUuDQoNCglEYXZpZA0KDQo+IFRoZSBjb2Rl
IGFscmVhZHkgZG9lcyB0aGF0IGJlZm9yZSB0aGlzIHBhdGNoIGZvciB0aGUNCj4ga21hbGxvYyBw
b3dlci1vZi10d28gYWxpZ25tZW50cywgd2hlcmUgZS5nLiB0aGUgb2JqZWN0IGNhbiBiZSBhbGln
bmVkIHRvIDI1Ng0KPiBieXRlcywgYnV0IHRoZSBwcmVwZW5kZWQgaGVhZGVyIHRvIGEgc21hbGxl
ciBBUkNIX0tNQUxMT0NfTUlOQUxJR04gLw0KPiBBUkNIX1NMQUJfTUlOQUxJR04uDQo+IA0KPiA+
IEkgZG9udCBrbm93IGJ1dCBpdCBzZWVtcyB0aGF0IG1ha2luZyBzbG9iIHRoYXQgc29waGlzdGlj
YXRlZCBpcyBjb3VudGVyDQo+ID4gcHJvZHVjdGl2ZS4gUmVtb3ZlIFNMT0I/DQo+IA0KPiBJIHdv
dWxkbid0IG1pbmQsIGJ1dCBzb21lYm9keSBtaWdodCA6KQ0KPiANCg0KLQ0KUmVnaXN0ZXJlZCBB
ZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMs
IE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

