Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE6230BAE3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 10:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbhBBJZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 04:25:40 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:45173 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229975AbhBBJZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 04:25:32 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-138-ZgGVazRuO0urN_jQBu4yZw-1; Tue, 02 Feb 2021 09:23:53 +0000
X-MC-Unique: ZgGVazRuO0urN_jQBu4yZw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 2 Feb 2021 09:23:54 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 2 Feb 2021 09:23:54 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andy Lutomirski' <luto@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
CC:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        LKML <linux-kernel@vger.kernel.org>, Jann Horn <jann@thejh.net>,
        Christian Brauner <christian.brauner@canonical.com>
Subject: RE: forkat(int pidfd), execveat(int pidfd), other awful things?
Thread-Topic: forkat(int pidfd), execveat(int pidfd), other awful things?
Thread-Index: AQHW+MjRGTZ+ypDOi0yJVnTMuiyGI6pElfgg
Date:   Tue, 2 Feb 2021 09:23:54 +0000
Message-ID: <cf07f0732eb94dbfa67c9d56ceba738e@AcuMS.aculab.com>
References: <CAHmME9oHBtR4fBBUY8E_Oi7av-=OjOGkSNhQuMJMHhafCjazBw@mail.gmail.com>
 <CALCETrVGLx5yeHo7ExAmJZmPjVjcJiV7p1JOa4iUaW5DRoEvLQ@mail.gmail.com>
In-Reply-To: <CALCETrVGLx5yeHo7ExAmJZmPjVjcJiV7p1JOa4iUaW5DRoEvLQ@mail.gmail.com>
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

RnJvbTogQW5keSBMdXRvbWlyc2tpDQo+IFNlbnQ6IDAxIEZlYnJ1YXJ5IDIwMjEgMTg6MzANCi4u
Lg0KPiAyLiBBIHNhbmUgcHJvY2VzcyBjcmVhdGlvbiBBUEkuICBJdCB3b3VsZCBiZSBkZWxpZ2h0
ZnVsIHRvIGJlIGFibGUgdG8NCj4gY3JlYXRlIGEgZnVsbHktc3BlY2lmaWVkIHByb2Nlc3Mgd2l0
aG91dCBmb3JraW5nLiAgVGhpcyBtaWdodCBlbmQgdXANCj4gYmVpbmcgYSBmYWlybHkgY29tcGxp
Y2F0ZWQgcHJvamVjdCwgdGhvdWdoIC0tIHRoZXJlIGFyZSBhIGxvdCBvZg0KPiBpbmhlcml0ZWQg
cHJvY2VzcyBwcm9wZXJ0aWVzIHRvIGJlIGVudW1lcmF0ZWQuDQoNClNpbmNlIHlvdSBhcmUgZ29p
bmcgdG8gKGV2ZW50dWFsbHkpIGxvYWQgaW4gYSBwcm9ncmFtIGltYWdlDQpoYXZlIHRvIGRvIHNl
dmVyYWwgc3lzdGVtIGNhbGxzIHRvIGNyZWF0ZSB0aGUgcHJvY2VzcyBpc24ndA0KbGlrZWx5IHRv
IGJlIGEgcHJvYmxlbS4NClNvIHVzaW5nIHNlcGFyYXRlIGNhbGxzIGZvciBlYWNoIHByb3BlcnR5
IGlzbid0IHJlYWxseSBhbiBpc3N1ZQ0KYW5kIHNvbHZlcyB0aGUgaG9ycmlkIHByb2JsZW0gb2Yg
dGhlIEFQSSBzdHJ1Y3R1cmUuDQoNClNvIHlvdSBjb3VsZCBjcmVhdGUgYW4gZW1icnlvbmljIHBy
b2Nlc3MgdGhhdCBpbmhlcml0cyBhIGxvdA0Kb2Ygc3R1ZmYgZnJvbSB0aGUgY3VycmVudCBwcm9j
ZXNzLCB0aGUgZG8gYWN0aW9ucyB0aGF0DQpzb3J0IG91dCB0aGUgZmRzLCBhcmd2LCBuYW1lc3Bh
Y2UgZXRjLg0KRmluYWxseSBydW5uaW5nIHRoZSBuZXcgcHJvZ3JhbS4NCg0KSXQgd291bGQgcHJv
YmFibHkgbWFrZSBpbXBsZW1lbnQgcG9zaXhfc3Bhd24oKSBlYXNpZXIuDQoNCglEYXZpZA0KDQot
DQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwg
TWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2Fs
ZXMpDQo=

