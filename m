Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97FBA3F7184
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 11:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239570AbhHYJOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 05:14:37 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:21325 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232454AbhHYJOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 05:14:34 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-251-eNLeqziOMbmB_zlX0-oBfA-1; Wed, 25 Aug 2021 10:13:46 +0100
X-MC-Unique: eNLeqziOMbmB_zlX0-oBfA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Wed, 25 Aug 2021 10:13:44 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Wed, 25 Aug 2021 10:13:44 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Larry Finger' <Larry.Finger@lwfinger.net>,
        Aakash Hemadri <aakashhemadri123@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Phillip Potter <phil@philpotter.co.uk>
CC:     "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/5] staging: r8188eu: cast to restricted __be32
Thread-Topic: [PATCH v3 2/5] staging: r8188eu: cast to restricted __be32
Thread-Index: AQHXmCqSnSVpiVCtaEyxz8Go65B0FauD8RPg
Date:   Wed, 25 Aug 2021 09:13:44 +0000
Message-ID: <ba4668725f944d12843529f0b0d4a8a2@AcuMS.aculab.com>
References: <cover.1629562355.git.aakashhemadri123@gmail.com>
 <50439a81aca7ce8c3c97ec1c7247f4cd03f645a5.1629562355.git.aakashhemadri123@gmail.com>
 <20210823084426.yo2mhgbyehkwwz3h@xps.yggdrasil>
 <25d336b5-8008-9b3b-7efe-a82afaea0e98@lwfinger.net>
In-Reply-To: <25d336b5-8008-9b3b-7efe-a82afaea0e98@lwfinger.net>
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

RnJvbTogTGFycnkgRmluZ2VyDQo+IFNlbnQ6IDIzIEF1Z3VzdCAyMDIxIDE1OjI0DQo+IA0KPiBP
biA4LzIzLzIxIDM6NDQgQU0sIEFha2FzaCBIZW1hZHJpIHdyb3RlOg0KPiA+IE9uIDIxLzA4LzIx
IDA5OjQ4UE0sIEFha2FzaCBIZW1hZHJpIHdyb3RlOg0KPiA+PiBGaXggc3BhcnNlIHdhcm5pbmc6
DQo+ID4+PiBydHdfYnJfZXh0LmM6ODM2OjU0OiB3YXJuaW5nOiBjYXN0IHRvIHJlc3RyaWN0ZWQg
X19iZTMyDQo+ID4+DQo+ID4+IGRocGNoLT5jb29raWUgaXMgYmUzMiwgY2hhbmdlIGl0J3MgdHlw
ZS4NCi4uLg0KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL3I4MTg4ZXUvY29yZS9y
dHdfYnJfZXh0LmMgYi9kcml2ZXJzL3N0YWdpbmcvcjgxODhldS9jb3JlL3J0d19icl9leHQuYw0K
PiA+PiBpbmRleCBmNmQxZjYwMjllYzMuLmY2NWQ5NGJmYTI4NiAxMDA2NDQNCj4gPj4gLS0tIGEv
ZHJpdmVycy9zdGFnaW5nL3I4MTg4ZXUvY29yZS9ydHdfYnJfZXh0LmMNCj4gPj4gKysrIGIvZHJp
dmVycy9zdGFnaW5nL3I4MTg4ZXUvY29yZS9ydHdfYnJfZXh0LmMNCi4uLg0KPiA+PiBAQCAtNjcx
LDcgKzY3MSw3IEBAIHZvaWQgZGhjcF9mbGFnX2JjYXN0KHN0cnVjdCBhZGFwdGVyICpwcml2LCBz
dHJ1Y3Qgc2tfYnVmZiAqc2tiKQ0KPiA+PiAgIAkJCQkgICAgKHVkcGgtPmRlc3QgPT0gX19jb25z
dGFudF9odG9ucyhTRVJWRVJfUE9SVCkpKSB7IC8qICBESENQIHJlcXVlc3QgKi8NCj4gPj4gICAJ
CQkJCXN0cnVjdCBkaGNwTWVzc2FnZSAqZGhjcGggPQ0KPiA+PiAgIAkJCQkJCShzdHJ1Y3QgZGhj
cE1lc3NhZ2UgKikoKHNpemVfdCl1ZHBoICsgc2l6ZW9mKHN0cnVjdCB1ZHBoZHIpKTsNCg0KVGhp
cyBhc3NpZ25tZW50IGxvb2tzIGR1YmlvdXMgYXQgYmVzdCAtIFdURiBpcyAoc2l6ZV90KSBmb3I/
DQpJIGRvbid0IHNlZW0gdG8gaGF2ZSBhIHNvdXJjZSB0cmVlIHdpdGggdGhpcyBkcml2ZXIgaW4g
aXQgKHByb2JhYmx5IG9ubHkgaW4gJ25leHQnPykuDQpJIHN1c3BlY3QgaXQgc2hvdWxkIGJlOg0K
CXN0cnVjdCBkaGNwX21lc3NhZ2UgKmRoY3BoID0gKHZvaWQgKikodWRwaCArIDEpOw0KDQo+ID4+
IC0JCQkJCXUzMiBjb29raWUgPSBiZTMyX3RvX2NwdSgoX19iZTMyKWRoY3BoLT5jb29raWUpOw0K
PiA+PiArCQkJCQl1MzIgY29va2llID0gYmUzMl90b19jcHUoZGhjcGgtPmNvb2tpZSk7DQo+ID4+
DQo+ID4+ICAgCQkJCQlpZiAoY29va2llID09IERIQ1BfTUFHSUMpIHsgLyogIG1hdGNoIG1hZ2lj
IHdvcmQgKi8NCj4gPj4gICAJCQkJCQlpZiAoIShkaGNwaC0+ZmxhZ3MgJiBodG9ucyhCUk9BRENB
U1RfRkxBRykpKSB7DQo+ID4+IC0tDQo+ID4+IDIuMzIuMA0KPiA+Pg0KPiA+DQo+ID4gRGF2aWQg
TGFpZ2h0IHN1Z2dlc3RlZCB0byB1c2UgZ2V0X3VuYWxpZ25lZF9iZTMyLCBJIGFtIG5vdCBzdXJl
IGlmIGl0J3MNCj4gPiB0aGUgcmlnaHQgdGhpbmcgdG8gZG8gYmVjYXVzZSBhcyBmYXIgYXMgSSB1
bmRlcnN0YW5kIGdldF91bmFsaWduZWRfYmUzMg0KPiA+IGJ5dGVzaGlmdHMgdGhlIGFyZ3VtZW50
Lg0KPiA+DQo+ID4gQ2FuIHNvbWVvbmUgcGxlYXNlIGNvbmZpcm0gaWYgdGhpcyBjaGFuZ2UgaXMg
b2theT8NCj4gPg0KPiANCj4gSXQgaXMgbm90IG5lZWRlZC4gdmFyaWFibGUgZGhjcGgtPmNvb2tp
ZSBpcyA0LWJ5dGUgYWxpZ25lZC4gVXNpbmQgdGhlIHVuYWxpZ25lZA0KPiB2ZXJzaW9uIHdvdWxk
IGp1c3QgYWRkIGNwdSBjeWNsZXMgYW5kIGFycml2dyBhdCB0aGUgc2FtZSBwb2ludCENCg0KSXQg
cmF0aGVyIGRlcGVuZHMgb24gd2hldGhlciB0aGUgaW5wdXQgYnVmZmVyIGlzIGFsaWduZWQuDQpB
bHRob3VnaCBpZiBpdCBtaWdodCBub3QgYmUgdGhlbiB0aGVuIHRoZSBzdHJ1Y3R1cmUocykgdGhh
dCBtYXANCml0IG5lZWQgdG8gYmUgbWFya2VkICdwYWNrZWQnLg0KV2hpY2ggd291bGQgYWxzbyBt
ZWFuIHRoZSBnZXRfdW5hbGlnbmVkX2JlMzIoKSBpc24ndCB0aGUgY29ycmVjdA0Kd2F5IHRvIGhh
bmRsZSBhIG1pc2FsaWduZWQgYnVmZmVyLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRy
ZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1L
MSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

