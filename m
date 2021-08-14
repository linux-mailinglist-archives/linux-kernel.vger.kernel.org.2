Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E82C53EC4E5
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 22:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhHNUIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 16:08:17 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:58194 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229489AbhHNUIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 16:08:16 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-19-2ppITmkqNDG-dDY-1LwSrA-1; Sat, 14 Aug 2021 21:07:44 +0100
X-MC-Unique: 2ppITmkqNDG-dDY-1LwSrA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Sat, 14 Aug 2021 21:07:43 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Sat, 14 Aug 2021 21:07:43 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Khalid Aziz' <khalid.aziz@oracle.com>,
        "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>, Matthew Wilcox <willy@infradead.org>
CC:     Steven Sistare <steven.sistare@oracle.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: RE: [RFC PATCH 0/5] madvise MADV_DOEXEC
Thread-Topic: [RFC PATCH 0/5] madvise MADV_DOEXEC
Thread-Index: AQHXkHxypLAjl++vx02znmkvS7SQp6tzbmww
Date:   Sat, 14 Aug 2021 20:07:42 +0000
Message-ID: <6775a78fa70b4868bfd24c750ec24bdd@AcuMS.aculab.com>
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
         <cc714571-4461-c9e0-7b24-e213664caa54@huawei.com>
         <43471cbb-67c6-f189-ef12-0f8302e81b06@oracle.com>
         <a1dbf12e-9949-109e-122c-ba7ba609801b@huawei.com>
         <YOubKmDwxMIvdAed@casper.infradead.org>
         <a94973ab83ce48bd85c91397f82d7915@huawei.com>
 <55720e1b39cff0a0f882d8610e7906dc80ea0a01.camel@oracle.com>
In-Reply-To: <55720e1b39cff0a0f882d8610e7906dc80ea0a01.camel@oracle.com>
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

Li4uDQo+ID4gPiA+IExldCBtZSBkZXNjcmliZSBteSB1c2UgY2FzZSBtb3JlIGNsZWFybHkgKGp1
c3QgaWdub3JlIGlmIHlvdSdyZSBub3QNCj4gPiA+ID4gaW50ZXJlc3RlZCBpbiBpdCk6DQo+ID4g
PiA+DQo+ID4gPiA+IDEuIFByb2cgQSBtbWFwKCkgNEdCIG1lbW9yeSAoYW5vbiBvciBmaWxlLW1h
cHBpbmcpLCBzdXBwb3NlIHRoZQ0KPiA+ID4gPiBhbGxvY2F0ZWQgVkEgcmFuZ2UgaXMgWzB4NDAw
MDAwMDAsMHgxNDAwMDAwMDApDQo+ID4gPiA+DQo+ID4gPiA+IDIuIFByb2cgQSBzcGVjaWZpZXMg
WzB4NDgwMDAwMDAsMHg1MDAwMDAwMCkgYW5kDQo+ID4gPiA+IFsweDgwMDAwMDAwLDB4MTAwMDAw
MDAwKSB3aWxsIGJlIHNoYXJlZCBieSBpdHMgY2hpbGQuDQo+ID4gPiA+DQo+ID4gPiA+IDMuIFBy
b2cgQSBmb3JrKCkgUHJvZyBCIGFuZCB0aGVuIFByb2cgQiBleGVjKCkgYSBuZXcgRUxGIGJpbmFy
eS4NCj4gPiA+ID4NCj4gPiA+ID4gNC4gUHJvZyBCIG5vdGljZSB0aGUgc2hhcmVkIHJhbmdlcyAo
ZS5nLiBieSBpbnB1dCBwYXJhbWV0ZXJzIG9yDQo+ID4gPiA+IC4uLikNCj4gPiA+ID4gYW5kIHJl
bWFwIHRoZW0gdG8gYSBjb250aW51b3VzIFZBIHJhbmdlLg0KDQpSZW1hcHBpbmcgdG8gY29udGln
dW91cyBWQSBpcyBnb2luZyB0byBiZSBkaWZmaWN1bHQgaW4gdGhlDQpnZW5lcmFsIGNhc2UgZm9y
IChJSVJDKSBWSVZUIGNhY2hlcy4NClRoZSByZXF1aXJlZCBjYWNoZSBjb2hlcmVuY2UgbWF5IG9u
bHkgYmUgYXR0YWluYWJsZSBieQ0KdXNpbmcgdW5jYWNoZWQgbWFwcGluZ3MuDQoNCglEYXZpZA0K
DQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFy
bSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAo
V2FsZXMpDQo=

