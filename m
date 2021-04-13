Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 302B235E240
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 17:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346456AbhDMPG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 11:06:26 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:21628 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242462AbhDMPGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 11:06:25 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-228-VDU7HPf7PQSHs4NDsnQDhw-1; Tue, 13 Apr 2021 16:06:01 +0100
X-MC-Unique: VDU7HPf7PQSHs4NDsnQDhw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Tue, 13 Apr 2021 16:06:00 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.012; Tue, 13 Apr 2021 16:06:00 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Mathieu Desnoyers' <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Eric Dumazet <eric.dumazet@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, paulmck <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Arjun Roy <arjunroy@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Eric Dumazet" <edumazet@google.com>
Subject: RE: [PATCH 3/3] rseq: optimise for 64bit arches
Thread-Topic: [PATCH 3/3] rseq: optimise for 64bit arches
Thread-Index: AQHXMETc4NN4/ddyHEK6qBKOxo8eAaqyQOlAaWt3qjT8tO0Y8A==
Date:   Tue, 13 Apr 2021 15:06:00 +0000
Message-ID: <56c227c1defe4b9ca9c6a75537234e20@AcuMS.aculab.com>
References: <20210413073657.2308450-1-eric.dumazet@gmail.com>
 <20210413073657.2308450-4-eric.dumazet@gmail.com>
 <YHVf+F3sKlWyZags@hirez.programming.kicks-ass.net>
 <fbf1a4449b0148b5b9c3baa32088c32a@AcuMS.aculab.com>
 <644332839.71291.1618323708305.JavaMail.zimbra@efficios.com>
In-Reply-To: <644332839.71291.1618323708305.JavaMail.zimbra@efficios.com>
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

RnJvbTogTWF0aGlldSBEZXNub3llcnMgPG1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbT4N
Cj4gU2VudDogMTMgQXByaWwgMjAyMSAxNToyMg0KLi4uDQo+ID4JRGF2aWQNCj4gPg0KPiA+PiBT
byBJIHN1cHBvc2UgdGhhdCBpZiB3ZSdyZSBnb2luZyB0byAjaWZkZWYgdGhpcywgd2UgbWlnaHQg
YXMgd2VsbCBkbyB0aGUNCj4gPj4gd2hvbGUgdGhpbmcuDQo+ID4+DQo+ID4+IE1hdGhpZXU7IGRp
ZCBJIGZvcmdldCBhIHJlYXNvbiB3aHkgdGhpcyBjYW5ub3Qgd29yaz8NCj4gDQo+IFRoZSBvbmx5
IGRpZmZlcmVuY2UgaXQgYnJpbmdzIG9uIDMyLWJpdCBpcyB0aGF0IHRoZSB0cnVuY2F0aW9uIG9m
IGhpZ2ggYml0cw0KPiB3aWxsIGJlIGRvbmUgYmVmb3JlIHRoZSBmb2xsb3dpbmcgdmFsaWRhdGlv
bjoNCj4gDQo+ICAgICAgICAgaWYgKCFwdHIpIHsNCj4gICAgICAgICAgICAgICAgIG1lbXNldChy
c2VxX2NzLCAwLCBzaXplb2YoKnJzZXFfY3MpKTsNCj4gICAgICAgICAgICAgICAgIHJldHVybiAw
Ow0KPiAgICAgICAgIH0NCj4gICAgICAgICBpZiAocHRyID49IFRBU0tfU0laRSkNCj4gICAgICAg
ICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiANCj4gVGhlIHF1ZXN0aW9uIGlzIHdoZXRoZXIg
d2UgcmVhbGx5IHdhbnQgdG8gaXNzdWUgYSBzZWdtZW50YXRpb24gZmF1bHQgaWYgMzItYml0DQo+
IHVzZXItc3BhY2UgaGFzIHNldCBub24temVybyBoaWdoIGJpdHMsIG9yIGlmIHNpbGVudGx5IGln
bm9yaW5nIHRob3NlIGhpZ2gNCj4gYml0cyBpcyBhY2NlcHRhYmxlLg0KDQpXZWxsLCAzMmJpdCBw
cm9ncmFtcyBydW5uaW5nIG9uIDY0Yml0IGtlcm5lbHMgYmV0dGVyIHplcm8gdGhlICdwYWRkaW5n
Jy4NCg0KSXQgaXMgYSBzaGFtZSB0aGF0IHRoZSAzMmJpdCBjb21waWxlcnMgZG9uJ3QgaGF2ZSBh
biBhdHRyaWJ1dGUoNjRiaXQpDQpmb3IgcG9pbnRlcnMuDQoNCj4gLi4uDQo+IEkgYW0gYWx3YXlz
IHJlbHVjdGFudCB0byB1c2UgbG9uZy91bnNpZ25lZCBsb25nIHR5cGUgYXMgdHlwZSBmb3IgdGhl
IGdldC9wdXRfdXNlcg0KPiAoeCkgYXJndW1lbnQsIGJlY2F1c2UgaXQgaGlkZXMgdGhlIGNhc3Qg
ZGVlcCB3aXRoaW4gYXJjaGl0ZWN0dXJlLXNwZWNpZmljIG1hY3Jvcy4NCj4gSSB1bmRlcnN0YW5k
IHRoYXQgaW4gdGhpcyBzcGVjaWZpYyBjYXNlIGl0IGhhcHBlbnMgdGhhdCBvbiA2NC1iaXQgYXJj
aHMgd2UgZW5kIHVwDQo+IGNhc3RpbmcgYSB1NjQgdG8gdW5zaWduZWQgbG9uZyAoc2FtZSBzaXpl
KSwgYW5kIG9uIDMyLWJpdCBhcmNocyB3ZSBlbmQgdXAgY2FzdGluZyBhDQo+IHUzMiB0byB1bnNp
Z25lZCBsb25nIChhbHNvIHNhbWUgc2l6ZSksIHNvIHRoZXJlIGlzIG5vIHByYWN0aWNhbCBjb25j
ZXJuIGFib3V0IHR5cGUNCj4gcHJvbW90aW9uIGFuZCBzaWduLWV4dGVuc2lvbiwgYnV0IEkgdGhp
bmsgaXQgd291bGQgYmUgYmV0dGVyIHRvIGhhdmUgc29tZXRoaW5nDQo+IGV4cGxpY2l0LCBlLmcu
Og0KDQpJZiB0aGUgQUJJIHBhc3NlcyBzbWFsbCBzdHJ1Y3R1cmVzIGluIHJlZ2lzdGVycyAobW9z
dCBtb2Rlcm4gb25lcykNCnRoZW4gdXNlciBwb2ludGVycyBwcm9iYWJseSBvdWdodCB0byBiZSBl
bmNhcHN1bGF0ZWQgaW4gYSBzdHJ1Y3R1cmUuDQpQb3NzaWJseSBhcyBhIHBvaW50ZXIgdG8gYW4g
dW5rbm93biBzdHJ1Y3R1cmUuDQpUaGF0IHdvdWxkIGZvcmNlIGFsbCB0aGUgcmVxdWlyZWQgdHlw
ZSBjaGVja2luZy4NClVuZm9ydHVuYXRlbHkgdGhlIGZhbGxvdXQvY2h1cm4gd291bGQgYmUgbWFz
c2l2ZS4NCg0KPiAjaWZkZWYgQ09ORklHXzY0QklUDQo+IHN0YXRpYyBpbnQgcnNlcV9nZXRfY3Nf
cHRyKHN0cnVjdCByc2VxX2NzIF9fdXNlciAqKnVwdHJwLCBzdHJ1Y3QgcnNlcV9jcyAqcnNlcV9j
cykNCj4gew0KPiAgICAgdTY0IHB0cjsNCj4gDQo+ICAgICBpZiAoZ2V0X3VzZXIocHRyLCAmcnNl
cV9jcy0+cHRyNjQpKQ0KPiAgICAgICAgIHJldHVybiAtRUZBVUxUOw0KPiAgICAgKnB0cnAgPSAo
c3RydWN0IHJzZXFfY3MgX191c2VyICopcHRyOw0KPiAgICAgcmV0dXJuIDA7DQo+IH0NCj4gI2Vs
c2UNCj4gc3RhdGljIGludCByc2VxX2dldF9jc19wdHIoc3RydWN0IHJzZXFfY3MgX191c2VyICoq
dXB0cnAsIHN0cnVjdCByc2VxX2NzICpyc2VxX2NzKQ0KPiB7DQo+ICAgICB1MzIgcHRyOw0KPiAN
Cj4gICAgIGlmIChnZXRfdXNlcihwdHIsICZyc2VxX2NzLT5wdHIucHRyMzIpKQ0KPiAgICAgICAg
IHJldHVybiAtRUZBVUxUOw0KPiAgICAgKnB0cnAgPSAoc3RydWN0IHJzZXFfY3MgX191c2VyICop
cHRyOw0KPiAgICAgcmV0dXJuIDA7DQo+IH0NCj4gI2VuZGlmDQoNCkhtbW0uLi4gdG9vIG11Y2gg
cmVwbGljYXRpb24uDQpZb3UgY291bGQgZG86DQojaWZkZWYgQ09ORklHXzY0QklUDQojZGVmaW5l
IFBUUl9UWVBFIHU2NA0KI2RlZmluZSBQVFJfRkxEIHB0cjY0DQojZWxzZQ0KI2RlZmluZSBQVFJf
VFlQRSB1MzINCiNkZWZpbmUgUFRSX0ZMRCBwdHIzMg0KI2VuZGlmDQoNClRoZW4gaGF2ZSBvbmUg
Y29weSBvZiB0aGUgY29kZSBhbmQgdGhlICN1bmRlZnMuDQouLi4NCg0KCURhdmlkDQoNCi0NClJl
Z2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0
b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykN
Cg==

