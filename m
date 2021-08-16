Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC7C3ECFF6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 10:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234525AbhHPIIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 04:08:21 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:46565 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234527AbhHPIIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 04:08:20 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-144-JmIe111pPXKgQwB05GAvjg-1; Mon, 16 Aug 2021 09:07:43 +0100
X-MC-Unique: JmIe111pPXKgQwB05GAvjg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Mon, 16 Aug 2021 09:07:42 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Mon, 16 Aug 2021 09:07:42 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Longpeng (Mike, Cloud Infrastructure Service Product Dept.)'" 
        <longpeng2@huawei.com>, 'Khalid Aziz' <khalid.aziz@oracle.com>,
        "Matthew Wilcox" <willy@infradead.org>
CC:     Steven Sistare <steven.sistare@oracle.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: RE: [RFC PATCH 0/5] madvise MADV_DOEXEC
Thread-Topic: [RFC PATCH 0/5] madvise MADV_DOEXEC
Thread-Index: AQHXkHxypLAjl++vx02znmkvS7SQp6tzbmwwgAHKcgCAAJBXgA==
Date:   Mon, 16 Aug 2021 08:07:42 +0000
Message-ID: <5f898e84d66a46b891e75e7c861e03a1@AcuMS.aculab.com>
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
 <cc714571-4461-c9e0-7b24-e213664caa54@huawei.com>
 <43471cbb-67c6-f189-ef12-0f8302e81b06@oracle.com>
 <a1dbf12e-9949-109e-122c-ba7ba609801b@huawei.com>
 <YOubKmDwxMIvdAed@casper.infradead.org>
 <a94973ab83ce48bd85c91397f82d7915@huawei.com>
 <55720e1b39cff0a0f882d8610e7906dc80ea0a01.camel@oracle.com>
 <6775a78fa70b4868bfd24c750ec24bdd@AcuMS.aculab.com>
 <0591d6d4-5844-13ac-9e22-722e22c911f4@huawei.com>
In-Reply-To: <0591d6d4-5844-13ac-9e22-722e22c911f4@huawei.com>
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

RnJvbTogTG9uZ3BlbmcNCj4gU2VudDogMTYgQXVndXN0IDIwMjEgMDE6MjYNCj4gSGkgRGF2aWQs
DQo+IA0KPiDlnKggMjAyMS84LzE1IDQ6MDcsIERhdmlkIExhaWdodCDlhpnpgZM6DQo+ID4gLi4u
DQo+ID4+Pj4+IExldCBtZSBkZXNjcmliZSBteSB1c2UgY2FzZSBtb3JlIGNsZWFybHkgKGp1c3Qg
aWdub3JlIGlmIHlvdSdyZSBub3QNCj4gPj4+Pj4gaW50ZXJlc3RlZCBpbiBpdCk6DQo+ID4+Pj4+
DQo+ID4+Pj4+IDEuIFByb2cgQSBtbWFwKCkgNEdCIG1lbW9yeSAoYW5vbiBvciBmaWxlLW1hcHBp
bmcpLCBzdXBwb3NlIHRoZQ0KPiA+Pj4+PiBhbGxvY2F0ZWQgVkEgcmFuZ2UgaXMgWzB4NDAwMDAw
MDAsMHgxNDAwMDAwMDApDQo+ID4+Pj4+DQo+ID4+Pj4+IDIuIFByb2cgQSBzcGVjaWZpZXMgWzB4
NDgwMDAwMDAsMHg1MDAwMDAwMCkgYW5kDQo+ID4+Pj4+IFsweDgwMDAwMDAwLDB4MTAwMDAwMDAw
KSB3aWxsIGJlIHNoYXJlZCBieSBpdHMgY2hpbGQuDQo+ID4+Pj4+DQo+ID4+Pj4+IDMuIFByb2cg
QSBmb3JrKCkgUHJvZyBCIGFuZCB0aGVuIFByb2cgQiBleGVjKCkgYSBuZXcgRUxGIGJpbmFyeS4N
Cj4gPj4+Pj4NCj4gPj4+Pj4gNC4gUHJvZyBCIG5vdGljZSB0aGUgc2hhcmVkIHJhbmdlcyAoZS5n
LiBieSBpbnB1dCBwYXJhbWV0ZXJzIG9yDQo+ID4+Pj4+IC4uLikNCj4gPj4+Pj4gYW5kIHJlbWFw
IHRoZW0gdG8gYSBjb250aW51b3VzIFZBIHJhbmdlLg0KPiA+DQo+ID4gUmVtYXBwaW5nIHRvIGNv
bnRpZ3VvdXMgVkEgaXMgZ29pbmcgdG8gYmUgZGlmZmljdWx0IGluIHRoZQ0KPiA+IGdlbmVyYWwg
Y2FzZSBmb3IgKElJUkMpIFZJVlQgY2FjaGVzLg0KPiA+IFRoZSByZXF1aXJlZCBjYWNoZSBjb2hl
cmVuY2UgbWF5IG9ubHkgYmUgYXR0YWluYWJsZSBieQ0KPiA+IHVzaW5nIHVuY2FjaGVkIG1hcHBp
bmdzLg0KPiA+DQo+IA0KPiBUaGUgUHJvZyBCIHVzZXMgbXJlbWFwKCkgc3lzY2FsbCB0byByZW1h
cHBpbmcgdGhlIHNoYXJlZCByYW5nZXMgdG8gb3RoZXIgcGxhY2VzLA0KPiB0aGlzIGlzIGEgY29t
bW9uIGNhc2UgZm9yIG1yZW1hcCBpbiB1c2Vyc3BhY2UuDQo+IFRoZSBjYWNoZSBjb2hlcmVuY2Ug
c2hvdWxkIGFscmVhZHkgYmUgcHJvY2Vzc2VkIGluIG1yZW1hcCBjb3JlIGxvZ2ljLCBvdGhlcndp
c2UNCj4gdGhlcmUncyBtYXliZSBzb21ldGhpbmcgd3JvbmcgaW4gbXJlbWFwKCkuDQoNCk1heWJl
IGl0IGRvZXMsIGFuZCBwcm9iYWJseSBtcmVtYXAoKSBtYWtlcyBpdCB3b3JrLg0KQnV0IHdpdGgg
VklWVCBjYWNoZXMgaWYgYSBwYWdlcyBnZXRzIG1hcHBlZCBpbiB0d28gcHJvY2Vzc2VzDQphdCB0
aGUgc2FtZSB0aW1lIGF0IGRpZmZlcmVudCBvZmZzZXRzIGludG8gdGhlIGNhY2hlIHRoZW4NCnRo
ZW4gYm90aCBtYXBwaW5ncyBlbmQgdXAgYmVpbmcgdW5jYWNoZWQuDQpUaGlzIHdhcyBhbHdheXMg
YSBwcm9ibGVtIHdpdGggbm9ybWFsIGZpbGUgbW1hcC4NCkkgZG9uJ3Qga25vdyBpZiBMaW51eCBt
YW5hZ2VzIHRvIHBpY2sgdGhlIFZBIGFmdGVyIGZpbmRpbmcgdGhlDQpwYWdlIGhhcyBhbm90aGVy
IG1hcHBpbmcgLSBTVlI0IGRpZG4ndC4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVz
cyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEg
MVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

