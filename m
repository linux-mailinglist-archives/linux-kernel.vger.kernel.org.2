Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABF0C3B5A23
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 09:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbhF1H4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 03:56:44 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:32146 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229953AbhF1H4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 03:56:43 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-77-PzuFHX-HOjWWoBtth293dg-1; Mon, 28 Jun 2021 08:54:14 +0100
X-MC-Unique: PzuFHX-HOjWWoBtth293dg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 28 Jun
 2021 08:54:13 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.018; Mon, 28 Jun 2021 08:54:13 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Marcos Del Sol Vives' <marcos@orca.pet>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] x86: add NOPL and CMOV emulation
Thread-Topic: [PATCH v3] x86: add NOPL and CMOV emulation
Thread-Index: AQHXaozP8c4yxHibnUSLg8MhMaAkx6snr31wgADaRICAAIXt0A==
Date:   Mon, 28 Jun 2021 07:54:13 +0000
Message-ID: <d605005dd40142a4b581b535e4830845@AcuMS.aculab.com>
References: <YNWAwVfzSdML/WhO@hirez.programming.kicks-ass.net>
 <20210626130313.1283485-1-marcos@orca.pet>
 <4b8e1393929b47d29a996f07cd332c65@AcuMS.aculab.com>
 <a7442c3e-02c2-b78b-cf3c-0343bbfa9b85@orca.pet>
In-Reply-To: <a7442c3e-02c2-b78b-cf3c-0343bbfa9b85@orca.pet>
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

Li4uDQo+IEkndmUgc2VlbiBzdWNoIGRldmljZXMgdXNlZCBieSBzbWFsbCBjb21wYW5pZXMgdG8g
ZGV2ZWxvcCBwb2ludCBvZiBzYWxlDQo+IG1hY2hpbmVzLCBpbmZvcm1hdGlvbiBzY3JlZW4sIGtp
b3NrcywgZXRjLi4uIHdoZXJlIHRoZXkgYmVuZWZpdCBmcm9tDQo+IGJlaW5nIGVhc3kgdG8gc2V0
IHVwIGFuZCwgYmVpbmcgYSBzdGFuZGFyZCBvcGVyYXRpbmcgc3lzdGVtLCBhbGxvdw0KPiBlYXNp
bHkgdHdlYWtpbmcgdG8gdGhlIGN1c3RvbWVyJ3MgbmVlZHMuDQoNCkFuZCBzeXN0ZW1zIHdoZXJl
IHlvdSByZWFsbHkgZG9uJ3Qgd2FudCB0byBiZSBydW5uaW5nIGEgbWFqb3INCmRpc3RyaWJ1dGlv
biBzaW5jZSB5b3UgYWxtb3N0IGNlcnRhaW5seSBkb24ndCB3YW50IHRvIHdyaXRlDQp0aGUgaW5m
cmFzdHJ1Y3R1cmUgdG8gZG8gc2VjdXJpdHkgdXBkYXRlcyBldmVyeSBmZXcgd2Vla3MuDQoNCglE
YXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91
bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5
NzM4NiAoV2FsZXMpDQo=

