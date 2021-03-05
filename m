Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 064EF32E47E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 10:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbhCEJPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 04:15:22 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:23779 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229723AbhCEJO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 04:14:58 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mtapsc-5-ZJ-SLQfWPCWWltRDC7XWWg-1; Fri, 05 Mar 2021 09:14:53 +0000
X-MC-Unique: ZJ-SLQfWPCWWltRDC7XWWg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 5 Mar 2021 09:14:51 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 5 Mar 2021 09:14:51 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Geert Uytterhoeven' <geert@linux-m68k.org>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: A note on the 5.12-rc1 tag
Thread-Topic: A note on the 5.12-rc1 tag
Thread-Index: AQHXEQdcNEtWyD0uokOcoyrPbbFuvap0CvcAgAAjn4CAAOxVEA==
Date:   Fri, 5 Mar 2021 09:14:51 +0000
Message-ID: <54603ccec53b486480081d938e7ccb49@AcuMS.aculab.com>
References: <CAHk-=wjnzdLSP3oDxhf9eMTYo7GF-QjaNLBUH1Zk3c4A7X75YA@mail.gmail.com>
 <CAMuHMdWn7GPkLrRnTJRT=9W-PVwoWOVBTqdM-gR180c66vGfOQ@mail.gmail.com>
 <79c3603cb086435b87030227d3d39443@AcuMS.aculab.com>
 <CAMuHMdXv8P-wiNVRv6VLX2OFuy5AxgP3Gk49eLFBGGaQLf46bg@mail.gmail.com>
In-Reply-To: <CAMuHMdXv8P-wiNVRv6VLX2OFuy5AxgP3Gk49eLFBGGaQLf46bg@mail.gmail.com>
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

Li4uDQo+ID4gSGlzdG9yaWNhbGx5IHN3YXAgd2FzIGEgcGFydGl0aW9uIGFuZCBsYXJnZXIgdGhh
biBwaHlzaWNhbCBtZW1vcnkuDQo+ID4gVGhpcyBhbGxvd3Mgc2ltcGxlICdkdW1wIHRvIHN3YXAn
IG9uIHBhbmljIChmb3IgbWFueSBkaXNrIHR5cGVzKS4NCj4gPiBCdXQgSSd2ZSBub3Qgc2VlbiB0
aGF0IHN1cHBvcnQgaW4gbGludXguDQo+IA0KPiBJIGtub3cuICBXZSBzdGFydGVkIHdpdGggbG90
cyBvZiBzbWFsbCBwYXJ0aXRpb25zLCBidXQgbm93YWRheXMgdGhlDQo+IGRpc3Ryb3Mgd2FuJ3Qg
dG8gaW5zdGFsbCBldmVyeXRoaW5nIGluIGEgc2luZ2xlWypdIHBhcnRpdGlvbiwgZXZlbiBzd2Fw
Lg0KDQpNdWx0aXBsZSBwYXJ0aXRpb25zIGlzIHBhcnRpYWxseSBkbyB0byB0aGUgc2l6ZSBvZiBk
aXNrcy4NCg0KQnV0IEkgcHJlZmVyIHRvIGluc3RhbGwgdGhlICdzeXN0ZW0nIGluIG9uZSBwYXJ0
aXRpb24gYW5kIHB1dCBhbGwNCm15IG93biBmaWxlcyBpbiBhIGRpZmZlcmVudCBvbmUuDQpUaGVu
IEkgY2FuIGluc3RhbGwgYSBkaWZmZXJlbnQgdmVyc2lvbiBvZiB0aGUgT1MgaW50byBhIDNyZA0K
cGFydGl0aW9uIGFuZCBiZSBhYmxlIHRvIGJvb3QgZGlmZmVyZW50IHZlcnNpb25zLg0KDQpNYW55
IHllYXJzIGFnbyBJIHVwZGF0ZWQgTmV0QlNEJ3MgeDg2IG1iciBjb2RlIHRvIHJlYWQgdGhlDQpl
eHRlbmRlZCBwYXJ0aXRpb24gdGFibGUgc28geW91IGNvdWxkIGNob29zZSB0byByZWFkIHRoZQ0K
bmV4dCBsZXZlbCBib290IGZyb20gc2VjdG9yIHplcm8gb2YgYW55IHBhcnRpdGlvbi4NClNxdWVl
emluZyB0aGF0IGludG8gdGhlIH40MDAgYnl0ZXMgYXZhaWxhYmxlIGlzIGEgbWFzdGVycGllY2Uu
DQoNClsqXSBUaGUgJ3NpbmdsZSBwYXJ0aXRpb24nIGlzIGEgc2ltcGxpY2l0eSBjb3Atb3V0Lg0K
DQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQs
IE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86
IDEzOTczODYgKFdhbGVzKQ0K

