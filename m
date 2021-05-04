Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52173372AA4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 15:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbhEDNHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 09:07:07 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:27905 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230430AbhEDNHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 09:07:05 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-254-S47yBnNyPoWWbbm-WTLYvw-1; Tue, 04 May 2021 14:06:08 +0100
X-MC-Unique: S47yBnNyPoWWbbm-WTLYvw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Tue, 4 May 2021 14:06:07 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.015; Tue, 4 May 2021 14:06:06 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Josh Poimboeuf' <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>
CC:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        David Kaplan <David.Kaplan@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        "David Woodhouse" <dwmw2@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        "Jann Horn" <jannh@google.com>
Subject: =?utf-8?B?UkU6IERvIHdlIG5lZWQgdG8gZG8gYW55dGhpbmcgYWJvdXQgImRlYWQgwrVv?=
 =?utf-8?Q?ps=3F"?=
Thread-Topic: =?utf-8?B?RG8gd2UgbmVlZCB0byBkbyBhbnl0aGluZyBhYm91dCAiZGVhZCDCtW9wcz8i?=
Thread-Index: AQHXQJPfT/BF58foiEK8tzGQU0UglarTSoNQ
Date:   Tue, 4 May 2021 13:06:06 +0000
Message-ID: <5937e5a2f1014e2da4a07e249745ceb1@AcuMS.aculab.com>
References: <CALCETrXRvhqw0fibE6qom3sDJ+nOa_aEJQeuAjPofh=8h1Cujg@mail.gmail.com>
 <20210503233010.x5lzpw4dq3gueg47@treble>
 <CALCETrVwFrpZU-6C=AVurVPk4ahV2yjqyhFeYbL_0OtBNJnZ=w@mail.gmail.com>
 <20210504031616.covixup7rhdil3yq@treble>
In-Reply-To: <20210504031616.covixup7rhdil3yq@treble>
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

RnJvbTogSm9zaCBQb2ltYm9ldWYNCj4gU2VudDogMDQgTWF5IDIwMjEgMDQ6MTYNCi4uLg0KPiBJ
IHdhcyBhY3R1YWxseSB0aGlua2luZyBtb3JlIGFsb25nIHRoZSBsaW5lcyBvZg0KPiANCj4gCXZh
bCA9IDA7DQo+IA0KPiAJaWYgKHVzZXJfc3VwcGxpZWRfaWR4IDwgQVJSQVlfU0laRSkgLy8gdHJh
aW5lZCB0byBzcGVjdWxhdGl2ZWx5IGJlICd0cnVlJw0KPiAJCXZhbCA9IGJvcmluZ19ub25fc2Vj
cmV0X2FycmF5W3VzZXJfc3VwcGxpZWRfaWR4XTsNCj4gDQo+IAlpZiAodmFsICYgMSkNCj4gCQlk
b19zb21ldGhpbmcoKTsNCj4gDQo+IEluIG90aGVyIHdvcmRzLCB0aGUgdmljdGltIGNvZGUgd291
bGRuJ3QgYmUgYWNjZXNzaW5nIHRoZSBzZWNyZXQNCj4gaW50ZW50aW9uYWxseS4gIFNvIHRoZXJl
J3Mgbm8gcmVhc29uIGZvciBpdCB0byBhdm9pZCBkb2luZw0KPiBkYXRhLWRlcGVuZGVudCBicmFu
Y2hlcy4NCg0KSXNuJ3QgdGhhdCBvbmUgb2YgdGhlIHZlcnkgYm9yaW5nIHN0YW5kYXJkIHNwZWN0
cmUgY2FzZXM/DQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJy
YW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lz
dHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

