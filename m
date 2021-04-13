Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5AE035E81F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 23:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348336AbhDMVTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 17:19:36 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:31547 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231719AbhDMVTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 17:19:34 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-165-N8V1FVlIOV6ADD7YZPXsJw-1; Tue, 13 Apr 2021 22:19:11 +0100
X-MC-Unique: N8V1FVlIOV6ADD7YZPXsJw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Tue, 13 Apr 2021 22:19:10 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.012; Tue, 13 Apr 2021 22:19:10 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arjun Roy' <arjunroy@google.com>,
        Eric Dumazet <edumazet@google.com>
CC:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/3] rseq: optimise rseq_get_rseq_cs() and
 clear_rseq_cs()
Thread-Topic: [PATCH v2 3/3] rseq: optimise rseq_get_rseq_cs() and
 clear_rseq_cs()
Thread-Index: AQHXMJPVg104is/mZUKAIt7DMH9hRKqy8Q+g
Date:   Tue, 13 Apr 2021 21:19:10 +0000
Message-ID: <feed2c13dbe34279a03929a588c46c67@AcuMS.aculab.com>
References: <20210413162240.3131033-1-eric.dumazet@gmail.com>
 <20210413162240.3131033-4-eric.dumazet@gmail.com>
 <567941475.72456.1618332885342.JavaMail.zimbra@efficios.com>
 <CANn89iJi=RY5HE6+TDvNv0HPEuedtsYHkEZSoEb45EO=tQM2tw@mail.gmail.com>
 <CANn89iKChc2Xf7fnJN0A7OfA7v=S0f6KruB91dKmEPVRhxQyPg@mail.gmail.com>
 <CANn89iKnQ7KeCo0os0c67GMgEkmrRqhmGhug-xL-Mx5BhR+BkQ@mail.gmail.com>
 <989543379.72506.1618334454075.JavaMail.zimbra@efficios.com>
 <CANn89iLXE6V2gpbJeE6KVU+YiNkmYZKjpRxKv8b69k1ECsyE9g@mail.gmail.com>
 <1347243835.72576.1618336812739.JavaMail.zimbra@efficios.com>
 <CANn89iKhKrHgTduwUtZ6QhxE6xFcK=ijadwACg9aSEJ7QQx4Mg@mail.gmail.com>
 <CAOFY-A1=2MzHvmqBEo=WBT6gWc=KnmtCWogjLdwZVDTp-zDjBQ@mail.gmail.com>
In-Reply-To: <CAOFY-A1=2MzHvmqBEo=WBT6gWc=KnmtCWogjLdwZVDTp-zDjBQ@mail.gmail.com>
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

PiBJZiB3ZSdyZSBzcGVjaWFsLWNhc2luZyA2NC1iaXQgYXJjaGl0ZWN0dXJlcyBhbnl3YXlzIC0g
dW5yb2xsaW5nIHRoZQ0KPiAzMkIgY29weV9mcm9tX3VzZXIoKSBmb3Igc3RydWN0IHJzZXFfY3Mg
YXBwZWFycyB0byBiZSByb3VnaGx5IDUtMTAlDQo+IHNhdmluZ3Mgb24geDg2LTY0IHdoZW4gSSBt
ZWFzdXJlZCBpdCAod2VsbCwgaW4gYSBtaWNyb2JlbmNobWFyaywgbm90DQo+IGluIHJzZXFfZ2V0
X3JzZXFfY3MoKSBkaXJlY3RseSkuIFBlcmhhcHMgdGhhdCBjb3VsZCBiZSBhbiBhZGRpdGlvbmFs
DQo+IGF2ZW51ZSBmb3IgaW1wcm92ZW1lbnQgaGVyZS4NCg0KVGhlIGtpbGxlciBpcyB1c3VhbGx5
ICd1c2VyIGNvcHkgaGFyZGVuaW5nJy4NCkl0IHNpZ25pZmljYW50bHkgc2xvd3MgZG93biBzZW5k
bXNnKCkgYW5kIHJlY3Ztc2coKS4NCkkndmUgZ290IG1lYXN1cmFibGUgcGVyZm9ybWFuY2UgaW1w
cm92ZW1lbnRzIGJ5DQp1c2luZyBfX2NvcHlfZnJvbV91c2VyKCkgd2hlbiB0aGUgYnVmZmVyIHNp
bmNlIGhhcw0KYWxyZWFkeSBiZWVuIGNoZWNrZWQgLSBidXQgaXNuJ3QgYSBjb21waWxlLXRpbWUg
Y29uc3RhbnQuDQoNClRoZXJlIGlzIGFsc28gc2NvcGUgZm9yIHVzaW5nIF9nZXRfdXNlcigpIHdo
ZW4gcmVhZGluZw0KaW92ZWNbXSAoaW5zdGVhZCBvZiBjb3B5X2Zyb21fdXNlcigpKSBhbmQgZG9p
bmcgYWxsIHRoZQ0KYm91bmQgY2hlY2tzIChldGMpIGluIHRoZSBsb29wLg0KVGhhdCBnaXZlcyBh
IG1lYXN1cmFibGUgaW1wcm92ZW1lbnQgZm9yIHdyaXRldigiL2Rldi9udWxsIikuDQpJIG11c3Qg
c29ydCB0aG9zZSBwYXRjaGVzIG91dCBhZ2Fpbi4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQg
QWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVz
LCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

