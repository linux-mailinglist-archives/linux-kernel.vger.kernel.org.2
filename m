Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9AC40DCEC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 16:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236050AbhIPOhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 10:37:45 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:60534 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235963AbhIPOhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 10:37:43 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-193-dVD6ImAeMK2-qIm8CP215g-1; Thu, 16 Sep 2021 15:36:19 +0100
X-MC-Unique: dVD6ImAeMK2-qIm8CP215g-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Thu, 16 Sep 2021 15:36:18 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Thu, 16 Sep 2021 15:36:18 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Christophe Leroy' <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "Michael Ellerman" <mpe@ellerman.id.au>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Stan Johnson <userm57@yahoo.com>,
        Finn Thain <fthain@linux-m68k.org>
Subject: RE: [PATCH] powerpc: warn on emulation of dcbz instruction
Thread-Topic: [PATCH] powerpc: warn on emulation of dcbz instruction
Thread-Index: AQHXqsvW0MbU+d6BYEihwJs0XlFOVqumujNA
Date:   Thu, 16 Sep 2021 14:36:18 +0000
Message-ID: <2fc6953808854149965e60f340eca94b@AcuMS.aculab.com>
References: <62b33ca839f3d1d7d4b64b6f56af0bbe4d2c9057.1631716292.git.christophe.leroy@csgroup.eu>
 <2c0fd775625c76c4dd09b3e923da4405a003f3bd.camel@kernel.crashing.org>
 <eb1a39368401bf46e805ca64256604cc649f771e.camel@kernel.crashing.org>
 <43f736d4-8625-2848-786f-79b902d5c753@csgroup.eu>
In-Reply-To: <43f736d4-8625-2848-786f-79b902d5c753@csgroup.eu>
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

RnJvbTogQ2hyaXN0b3BoZSBMZXJveQ0KPiBTZW50OiAxNiBTZXB0ZW1iZXIgMjAyMSAwODoyNA0K
PiANCj4gTGUgMTYvMDkvMjAyMSDDoCAwOToxNiwgQmVuamFtaW4gSGVycmVuc2NobWlkdCBhIMOp
Y3JpdMKgOg0KPiA+IE9uIFRodSwgMjAyMS0wOS0xNiBhdCAxNzoxNSArMTAwMCwgQmVuamFtaW4g
SGVycmVuc2NobWlkdCB3cm90ZToNCj4gPj4gT24gV2VkLCAyMDIxLTA5LTE1IGF0IDE2OjMxICsw
MjAwLCBDaHJpc3RvcGhlIExlcm95IHdyb3RlOg0KPiA+Pj4gZGNieiBpbnN0cnVjdGlvbiBzaG91
bGRuJ3QgYmUgdXNlZCBvbiBub24tY2FjaGVkIG1lbW9yeS4gVXNpbmcNCj4gPj4+IGl0IG9uIG5v
bi1jYWNoZWQgbWVtb3J5IGNhbiByZXN1bHQgaW4gYWxpZ25tZW50IGV4Y2VwdGlvbiBhbmQNCj4g
Pj4+IGltcGxpZXMgYSBoZWF2eSBoYW5kbGluZy4NCj4gPj4+DQo+ID4+PiBJbnN0ZWFkIG9mIHNp
bGVudGVseSBlbXVsYXRpbmcgdGhlIGluc3RydWN0aW9uIGFuZCByZXN1bHRpbmcgaW4NCj4gPj4+
IGhpZ2gNCj4gPj4+IHBlcmZvcm1hbmNlIGRlZ3JhZGF0aW9uLCB3YXJuIHdoZW5ldmVyIGFuIGFs
aWdubWVudCBleGNlcHRpb24gaXMNCj4gPj4+IHRha2VuIGR1ZSB0byBkY2J6LCBzbyB0aGF0IHRo
ZSB1c2VyIGlzIG1hZGUgYXdhcmUgdGhhdCBkY2J6DQo+ID4+PiBpbnN0cnVjdGlvbiBoYXMgYmVl
biB1c2VkIHVuZXhwZWN0ZWRseS4NCj4gPj4+DQo+ID4+PiBSZXBvcnRlZC1ieTogU3RhbiBKb2hu
c29uIDx1c2VybTU3QHlhaG9vLmNvbT4NCj4gPj4+IENjOiBGaW5uIFRoYWluIDxmdGhhaW5AbGlu
dXgtbTY4ay5vcmc+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGhlIExlcm95IDxjaHJp
c3RvcGhlLmxlcm95QGNzZ3JvdXAuZXU+DQo+ID4+PiAtLS0NCj4gPj4+ICAgYXJjaC9wb3dlcnBj
L2tlcm5lbC9hbGlnbi5jIHwgMSArDQo+ID4+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKQ0KPiA+Pj4NCj4gPj4+IGRpZmYgLS1naXQgYS9hcmNoL3Bvd2VycGMva2VybmVsL2FsaWdu
LmMNCj4gPj4+IGIvYXJjaC9wb3dlcnBjL2tlcm5lbC9hbGlnbi5jDQo+ID4+PiBpbmRleCBiYmI0
MTgxNjIxZGQuLmFkYzNhNGE5YzZlNCAxMDA2NDQNCj4gPj4+IC0tLSBhL2FyY2gvcG93ZXJwYy9r
ZXJuZWwvYWxpZ24uYw0KPiA+Pj4gKysrIGIvYXJjaC9wb3dlcnBjL2tlcm5lbC9hbGlnbi5jDQo+
ID4+PiBAQCAtMzQ5LDYgKzM0OSw3IEBAIGludCBmaXhfYWxpZ25tZW50KHN0cnVjdCBwdF9yZWdz
ICpyZWdzKQ0KPiA+Pj4gICAJCWlmIChvcC50eXBlICE9IENBQ0hFT1AgKyBEQ0JaKQ0KPiA+Pj4g
ICAJCQlyZXR1cm4gLUVJTlZBTDsNCj4gPj4+ICAgCQlQUENfV0FSTl9BTElHTk1FTlQoZGNieiwg
cmVncyk7DQo+ID4+PiArCQlXQVJOX09OX09OQ0UoMSk7DQo+ID4+DQo+ID4+IFRoaXMgaXMgaGVh
dnkgaGFuZGVkIC4uLiBJdCB3aWxsIGJlIHRyZWF0ZWQgYXMgYW4gb29wcyBieSB2YXJpb3VzDQo+
ID4+IHRoaW5ncyB1c2VsZXNzbHkgc3BpdCBvdXQgYSBrZXJuZWwgYmFja3RyYWNlLiBJc24ndA0K
PiA+PiBQUENfV0FSTl9BTElHTk1FTlQNCj4gPj4gZW5vdWdoID8NCj4gDQo+IA0KPiBQUENfV0FS
Tl9BTElHTk1FTlQoKSBvbmx5IHdhcm5zIGlmIGV4cGxpY2l0ZWx5IGFjdGl2YXRlZCwgSSB3YW50
IHRvDQo+IGNhdGNoIHVzZXMgb24gJ2RjYnonIG9uIG5vbi1jYWNoZWQgbWVtb3J5IGFsbCB0aGUg
dGltZSBhcyB0aGV5IGFyZSBtb3N0DQo+IG9mdGVuIHRoZSByZXN1bHQgb2YgdXNpbmcgbWVtc2V0
KCkgaW5zdGVhZCBvZiBtZW1zZXRfaW8oKS4NCj4gDQo+ID4NCj4gPiBBaCBJIHNhdyB5b3VyIG90
aGVyIG9uZSBhYm91dCBmYmRldi4uLiAgT2sgd2hhdCBhYm91dCB5b3UgZG8gdGhhdCBpbiBhDQo+
ID4gaWYgKCF1c2VyX21vZGUocmVncykpID8NCj4gDQo+IFllcyBJIGNhbiBkbyBXQVJOX09OX09O
Q0UoIXVzZXJfbW9kZShyZWdzKSk7IGluc3RlYWQuDQo+IA0KPiA+IEluZGVlZCB0aGUga2VybmVs
IHNob3VsZCBub3QgZG8gdGhhdC4NCj4gDQo+IERvZXMgdXNlcnNwYWNlIGFjY2Vzc2VzIG5vbi1j
YWNoZWQgbWVtb3J5IGRpcmVjdGx5ID8NCg0KSXQgcHJvYmFibHkgY2FuIGlmIGEgZHJpdmVyIG1t
YXBzIFBDSSBzcGFjZSBkaXJlY3RseSBpbnRvIHVzZXIgc3BhY2UuDQpUaGF0IGNlcnRhaW5seSB3
b3JrcyBvbiB4ODYtNjQuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNp
ZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsN
ClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

