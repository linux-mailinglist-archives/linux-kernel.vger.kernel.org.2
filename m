Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C00C3B0FF9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 00:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhFVWUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 18:20:50 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:35229 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229625AbhFVWUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 18:20:50 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-194-sbq5e5cyMZiA4JD1sz9phA-1; Tue, 22 Jun 2021 23:18:30 +0100
X-MC-Unique: sbq5e5cyMZiA4JD1sz9phA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 22 Jun
 2021 23:18:29 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.018; Tue, 22 Jun 2021 23:18:29 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Hans-Gert Dahmen' <hans-gert.dahmen@immu.ne>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "philipp.deppenwiese@immu.ne" <philipp.deppenwiese@immu.ne>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] firmware: export x86_64 platform flash bios region via
 sysfs
Thread-Topic: [PATCH] firmware: export x86_64 platform flash bios region via
 sysfs
Thread-Index: AQHXZ3I2QVY8Y0IZxk6JOQtZcZz8kKsgmXGQ
Date:   Tue, 22 Jun 2021 22:18:29 +0000
Message-ID: <5ee9e467bfbf49d29cb54679d2dce1c3@AcuMS.aculab.com>
References: <20210622142334.14883-1-hans-gert.dahmen@immu.ne>
In-Reply-To: <20210622142334.14883-1-hans-gert.dahmen@immu.ne>
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

RnJvbTogSGFucy1HZXJ0IERhaG1lbg0KPiBTZW50OiAyMiBKdW5lIDIwMjEgMTU6MjQNCj4gDQo+
IE1ha2UgdGhlIDE2TWlCIGxvbmcgbWVtb3J5LW1hcHBlZCBCSU9TIHJlZ2lvbiBvZiB0aGUgcGxh
dGZvcm0gU1BJIGZsYXNoDQo+IG9uIFg4Nl82NCBzeXN0ZW0gYXZhaWxhYmxlIHZpYSAvc3lzL2tl
cm5lbC9maXJtd2FyZS9mbGFzaF9tbWFwL2Jpb3NfcmVnaW9uDQo+IGZvciBwZW4tdGVzdGluZywg
c2VjdXJpdHkgYW5hbHlzaXMgYW5kIG1hbHdhcmUgZGV0ZWN0aW9uIG9uIGtlcm5lbHMNCj4gd2hp
Y2ggcmVzdHJpY3QgbW9kdWxlIGxvYWRpbmcgYW5kL29yIGFjY2VzcyB0byAvZGV2L21lbS4NCg0K
QXJlIHlvdSBzYXlpbmcgdGhhdCBteSAxNSB5ZWFyIG9sZCA2NGJpdCBBdGhsb24gY3B1IGFuZCBi
aW9zDQpoYXZlIHRoaXMgbGFyZ2UgU1BJIGZsYXNoIGFuZCB0aGUgcmVxdWlyZWQgaGFyZHdhcmUg
dG8NCmNvbnZlcnQgYnVzIGN5Y2xlcyB0byBzZXJpYWwgc3BpIHJlYWRzPw0KDQpJIHZlcnkgbXVj
aCBkb3VidCBpdC4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwg
QnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVn
aXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

