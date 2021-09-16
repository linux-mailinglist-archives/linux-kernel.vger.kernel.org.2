Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE7140DE61
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 17:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239183AbhIPPql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 11:46:41 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:56746 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239386AbhIPPqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 11:46:40 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-73-hC-drbRkMRy1ELWZmsZWpA-1; Thu, 16 Sep 2021 16:45:17 +0100
X-MC-Unique: hC-drbRkMRy1ELWZmsZWpA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Thu, 16 Sep 2021 16:45:16 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Thu, 16 Sep 2021 16:45:16 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Kefeng Wang' <wangkefeng.wang@huawei.com>,
        Marco Elver <elver@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "glider@google.com" <glider@google.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "jannh@google.com" <jannh@google.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "hdanton@sina.com" <hdanton@sina.com>
Subject: RE: [PATCH v2 2/3] kfence: maximize allocation wait timeout duration
Thread-Topic: [PATCH v2 2/3] kfence: maximize allocation wait timeout duration
Thread-Index: AQHXqpka6XGQNXcc7UiTXkG8ZB1Ri6umzYQg
Date:   Thu, 16 Sep 2021 15:45:16 +0000
Message-ID: <858909f98f33478891056a840ad68b9f@AcuMS.aculab.com>
References: <20210421105132.3965998-1-elver@google.com>
 <20210421105132.3965998-3-elver@google.com>
 <6c0d5f40-5067-3a59-65fa-6977b6f70219@huawei.com>
 <abd74d5a-1236-4f0e-c123-a41e56e22391@huawei.com>
In-Reply-To: <abd74d5a-1236-4f0e-c123-a41e56e22391@huawei.com>
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

RnJvbTogS2VmZW5nIFdhbmcNCj4gU2VudDogMTYgU2VwdGVtYmVyIDIwMjEgMDI6MjENCj4gDQo+
IFdlIGZvdW5kIGtmZW5jZV90ZXN0IHdpbGwgZmFpbHPCoCBvbiBBUk02NCB3aXRoIHRoaXMgcGF0
Y2ggd2l0aC93aXRob3V0DQo+IENPTkZJR19ERVRFQ1RfSFVOR19UQVNLLA0KPiANCj4gQW55IHRo
b3VnaHQgPw0KPiANCi4uLg0KPiA+PiDCoMKgwqDCoMKgIC8qIEVuYWJsZSBzdGF0aWMga2V5LCBh
bmQgYXdhaXQgYWxsb2NhdGlvbiB0byBoYXBwZW4uICovDQo+ID4+IMKgwqDCoMKgwqAgc3RhdGlj
X2JyYW5jaF9lbmFibGUoJmtmZW5jZV9hbGxvY2F0aW9uX2tleSk7DQo+ID4+IMKgIC3CoMKgwqAg
d2FpdF9ldmVudF90aW1lb3V0KGFsbG9jYXRpb25fd2FpdCwgYXRvbWljX3JlYWQoJmtmZW5jZV9h
bGxvY2F0aW9uX2dhdGUpLCBIWik7DQo+ID4+ICvCoMKgwqAgaWYgKHN5c2N0bF9odW5nX3Rhc2tf
dGltZW91dF9zZWNzKSB7DQo+ID4+ICvCoMKgwqDCoMKgwqDCoCAvKg0KPiA+PiArwqDCoMKgwqDC
oMKgwqDCoCAqIER1cmluZyBsb3cgYWN0aXZpdHkgd2l0aCBubyBhbGxvY2F0aW9ucyB3ZSBtaWdo
dCB3YWl0IGENCj4gPj4gK8KgwqDCoMKgwqDCoMKgwqAgKiB3aGlsZTsgbGV0J3MgYXZvaWQgdGhl
IGh1bmcgdGFzayB3YXJuaW5nLg0KPiA+PiArwqDCoMKgwqDCoMKgwqDCoCAqLw0KPiA+PiArwqDC
oMKgwqDCoMKgwqAgd2FpdF9ldmVudF90aW1lb3V0KGFsbG9jYXRpb25fd2FpdCwgYXRvbWljX3Jl
YWQoJmtmZW5jZV9hbGxvY2F0aW9uX2dhdGUpLA0KPiA+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHN5c2N0bF9odW5nX3Rhc2tfdGltZW91dF9zZWNzICogSFogLyAyKTsN
Cj4gPj4gK8KgwqDCoCB9IGVsc2Ugew0KPiA+PiArwqDCoMKgwqDCoMKgwqAgd2FpdF9ldmVudChh
bGxvY2F0aW9uX3dhaXQsIGF0b21pY19yZWFkKCZrZmVuY2VfYWxsb2NhdGlvbl9nYXRlKSk7DQo+
ID4+ICvCoMKgwqAgfQ0KPiA+PiDCoCDCoMKgwqDCoMKgIC8qIERpc2FibGUgc3RhdGljIGtleSBh
bmQgcmVzZXQgdGltZXIuICovDQo+ID4+IMKgwqDCoMKgwqAgc3RhdGljX2JyYW5jaF9kaXNhYmxl
KCZrZmVuY2VfYWxsb2NhdGlvbl9rZXkpOw0KDQpJdCBoYXMgcmVwbGFjZWQgYSB3YWl0X2V2ZW50
X3RpbWVvdXQoKSB3aXRoIGEgd2FpdF9ldmVudCgpLg0KDQpUaGF0IHByb2JhYmx5IGlzbid0IGlu
dGVuZGVkLg0KQWx0aG91Z2ggSSdkIGV4cGVjdCB0aGVpciB0byBiZSBzb21lIHRlc3QgZm9yIHRo
ZSB3YWl0IGJlaW5nDQpzaWduYWxsZWQgb3IgdGltaW5nIG91dC4NCg0KCURhdmlkDQoNCi0NClJl
Z2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0
b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykN
Cg==

