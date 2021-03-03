Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4703A32BEB3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575057AbhCCRec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:34:32 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:29321 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241741AbhCCOIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 09:08:14 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-137-8m7MO7eUN4WPYDQe3WOerw-1; Wed, 03 Mar 2021 14:06:01 +0000
X-MC-Unique: 8m7MO7eUN4WPYDQe3WOerw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 3 Mar 2021 14:06:03 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 3 Mar 2021 14:06:03 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Josh Poimboeuf' <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Artem Savkov <asavkov@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: RE: Upper bound mode for kernel timers
Thread-Topic: Upper bound mode for kernel timers
Thread-Index: AQHXDzpnJdxnFeR40EihNWY2PsQIHKpyR8OA
Date:   Wed, 3 Mar 2021 14:06:03 +0000
Message-ID: <5efd5c6a00dc46529767c428a81ec9e0@AcuMS.aculab.com>
References: <20210302001054.4qgrvnkltvkgikzr@treble>
In-Reply-To: <20210302001054.4qgrvnkltvkgikzr@treble>
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

RnJvbTogSm9zaCBQb2ltYm9ldWYNCj4gU2VudDogMDIgTWFyY2ggMjAyMSAwMDoxMQ0KPiANCj4g
V2UgaGFkIGEgcmVwb3J0IG9mIGEgcmVncmVzc2lvbiBpbiB0aGUgVENQIGtlZXBhbGl2ZSB0aW1l
ci4gIFRoZSB1c2VyDQo+IGhhZCBhIDM2MDBzIGtlZXBhbGl2ZSB0aW1lciBmb3IgcHJldmVudGlu
ZyBmaXJld2FsbCBkaXNjb25uZWN0cyAob24gYQ0KPiAzNjUwcyBpbnRlcnZhbCkuICBUaGV5IG9i
c2VydmVkIGtlZXBhbGl2ZSB0aW1lcnMgY29taW5nIGluIHVwIHRvIGZvdXINCj4gbWludXRlcyBs
YXRlLCBjYXVzaW5nIHVuZXhwZWN0ZWQgZGlzY29ubmVjdHMuDQo+IA0KPiBUaGUgcmVncmVzc2lv
biB3YXMgb2JzZXJ2ZWQgdG8gaGF2ZSBjb21lIGZyb20gdGhlIHRpbWVyIHdoZWVsIHJld3JpdGUN
Cj4gZnJvbSBhbG1vc3QgZml2ZSB5ZWFycyBhZ286DQo+IA0KPiAgIDUwMDQ2MmE5ZGU2NSAoInRp
bWVyczogU3dpdGNoIHRvIGEgbm9uLWNhc2NhZGluZyB3aGVlbCIpDQo+IA0KPiBBcyB5b3UgbWVu
dGlvbmVkLCB3aXRoIGEgSFogb2YgMTAwMCwgdGhlIGdyYW51bGFyaXR5IGZvciBhIG9uZS1ob3Vy
DQo+IHRpbWVyIGlzIGZvdXIgbWludXRlcywgd2hpY2ggbWF0Y2hlcyB0aGUgc2VlbiBiZWhhdmlv
ci4NCg0KVGhhdCBzZWVtcyBob3JyaWJseSBicm9rZW4gLSBpZiB0ZWNobmljYWxseSB2YWxpZC4N
Cg0KUmVhZGluZyB0aGUgYmlnIGNvbW1lbnQgZXZlbiB0aGUgMzJzZWMgZm9yIHRoZSBuZXh0IGZp
bmVyICd3aGVlbCcNCnNlZW1zIGEgbGl0dGxlIGNvYXJzZSBmb3IgYSAxaCB0aW1lci4NClRoZSBz
ZWNvbmQgZmluZXIgd2hlZWwgaGFzIDRzZWMgcmVzb2x1dGlvbiAtIHdoaWNoIGlzIHByb2JhYmx5
IHJlYXNvbmFibGUuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUs
IEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJl
Z2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

