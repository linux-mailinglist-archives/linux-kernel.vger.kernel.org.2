Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED9F53A81DE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 16:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbhFOOKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 10:10:37 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:50504 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230120AbhFOOKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 10:10:35 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-10-0BSCW0PNMeiUs_3ZDkVtBw-1; Tue, 15 Jun 2021 15:08:28 +0100
X-MC-Unique: 0BSCW0PNMeiUs_3ZDkVtBw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 15 Jun
 2021 15:08:27 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.018; Tue, 15 Jun 2021 15:08:27 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Bin Meng' <bmeng.cn@gmail.com>, Gary Guo <gary@garyguo.net>
CC:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "nickhu@andestech.com" <nickhu@andestech.com>,
        "nylon7@andestech.com" <nylon7@andestech.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] riscv: fix memmove and optimise memcpy when misalign
Thread-Topic: [PATCH] riscv: fix memmove and optimise memcpy when misalign
Thread-Index: AQHXT3WL0lTofUR6TU66MVYMSFr0J6rxS6gAgCPtaRCAAANAsA==
Date:   Tue, 15 Jun 2021 14:08:27 +0000
Message-ID: <44e4e70491164ef5b777d06f48b6684f@AcuMS.aculab.com>
References: <20210522232256.00003f08@garyguo.net>
 <mhng-fdda10f7-fc83-4654-a0b2-e9c86b92c37e@palmerdabbelt-glaptop>
 <17637b10e71b41b89126cbb1b2fa61cf@AcuMS.aculab.com>
 <20210525153431.0000508d@garyguo.net>
 <CAEUhbmXvYdVSsY3oH=XdyT2fOC1X9=-Rh0P1Q5TP1DcmzFfRrQ@mail.gmail.com>
In-Reply-To: <CAEUhbmXvYdVSsY3oH=XdyT2fOC1X9=-Rh0P1Q5TP1DcmzFfRrQ@mail.gmail.com>
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

RnJvbTogQmluIE1lbmcNCj4gU2VudDogMTUgSnVuZSAyMDIxIDE0OjQwDQouLi4NCj4gPiBJIHBy
ZWZlciBDIHZlcnNpb25zIGFzIHdlbGwsIGFuZCBhY3R1YWxseSBiZWZvcmUgY29tbWl0IDA0MDkx
ZDYgd2UgYXJlDQo+ID4gaW5kZWVkIHVzaW5nIHRoZSBnZW5lcmljIEMgdmVyc2lvbi4gVGhlIGlz
c3VlIGlzIHRoYXQgMDQwOTFkNg0KPiA+IGludHJvZHVjZXMgYW4gYXNzZW1ibHkgdmVyc2lvbiB0
aGF0J3MgdmVyeSBicm9rZW4uIEl0IGRvZXMgbm90IG9mZmVyDQo+ID4gYW5kIHBlcmZvcm1hbmNl
IGltcHJvdmVtZW50IHRvIHRoZSBDIHZlcnNpb24sIGFuZCBicmVha3MgYWxsIHByb2Nlc3NvcnMN
Cj4gPiB3aXRob3V0IGhhcmR3YXJlIG1pc2FsaWdubWVudCBzdXBwb3J0DQoNClRoZXJlIG1heSBu
ZWVkIHRvIGJlIGEgZmV3IEMgaW1wbGVtZW50YXRpb25zIGZvciBkaWZmZXJlbnQgY3B1DQppbnN0
cnVjdGlvbiBzZXRzLg0KV2hpbGUgdGhlIGNvbXBpbGVyIG1pZ2h0IG1hbmFnZSB0byBEVFJUIChv
ciB0aGUgd3JvbmcgdGhpbmcgZ2l2ZW4NCnRoZSByaWdodCBzb3VyY2UpIHVzaW5nIGEgbG9vcCB0
aGF0IG1hdGNoZXMgdGhlIGluc3RydWN0aW9uIHNldA0KaXMgYSBnb29kIGlkZWEuDQoNCkZvciBp
bnN0YW5jZSwgeDg2IGNhbiBkbyAqKHJlZ18xICsgcmVnXzIgKiAoMXwyfDR8OCkgKyBjb25zdGFu
dCkNCnNvIHlvdSBjYW4gaW5jcmVtZW50IHJlZ18yIGFuZCB1c2UgaXQgZm9yIGJvdGggYnVmZmVy
cyB3aGlsZQ0Kc3RpbGwgdW5yb2xsaW5nIGVub3VnaCB0byBoaXQgbWVtb3J5IGJhbmR3aWR0aC4N
Cg0KV2l0aCBvbmx5ICoocmVnXzEgKyBjb25zdGFudCkgeW91IG5lZWQgdG8gaW5jcmVtZW50IGJv
dGggdGhlDQpzb3VyY2UgYW5kIGRlc3RpbmF0aW9uIGFkZHJlc3Nlcy4NCg0KT1RPSCB5b3UgY2Fu
IHNhdmUgYW4gaW5zdHJ1Y3Rpb24gb24geDg2IGJ5IGFkZGluZyB0byAncmVnXzInDQp1bnRpbCBp
dCBiZWNvbWVzIHplcm8gKHNvIHlvdSBkb24ndCBuZWVkIGFkZCwgY21wIGFuZCBqbXApLg0KDQpC
dXQgYSBtaXBzLWxpa2UgaW5zdHJ1Y3Rpb24gc2V0IChpbmNsdWRlcyByaXNjdiBhbmQgbmlvczIp
DQpoYXMgJ2NvbXBhcmUgYW5kIGJyYW5jaCcgc28geW91IG9ubHkgZXZlciBuZWVkIG9uZSBpbnN0
cnVjdGlvbg0KYXQgdGhlIGVuZCBvZiB0aGUgbG9vcC4NCg0KSGF2aW5nIHRvIGhhbmRsZSBtaXNh
bGlnbmVkIGNvcGllcyBpcyBhbm90aGVyIGRpc3RpbmN0IGlzc3VlLg0KRm9yIHNvbWUgMzJiaXQg
Y3B1IGJ5dGUgY29waWVzIG1heSBiZSBhcyBmYXN0IGFzIGFueSBzaGlmdA0KYW5kIG1hc2sgY29k
ZS4NCg0KPiA+ICh5ZXMsIGZpcm13YXJlIGlzIGV4cGVjdGVkIHRvDQo+ID4gdHJhcCBhbmQgaGFu
ZGxlIHRoZXNlLCBidXQgdGhleSBhcmUgcGFpbmZ1bGx5IHNsb3cpLg0KDQpZZXMsIHRvIHRoZSBw
b2ludCB3aGVyZSB0aGUgc3lzdGVtIHNob3VsZCBqdXN0IHBhbmljIGFuZA0KZm9yY2UgeW91IHRv
IGZpeCB0aGUgY29kZS4NCg0KV2hlbiBJIHdlcmUgYSBsYWQgd2UgZm9yY2VkIGV2ZXJ5b25lIHRv
IGZpeCB0aGVyZSBjb2RlDQpzbyBpdCB3b3VsZCBydW4gb24gc3BhcmMuDQoNCglEYXZpZA0KDQot
DQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwg
TWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2Fs
ZXMpDQo=

