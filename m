Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01CC639581C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 11:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbhEaJeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 05:34:16 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:50139 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230423AbhEaJeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 05:34:10 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-120-eMdBWz8ZMTKSSNe4gcd_wQ-1; Mon, 31 May 2021 10:32:26 +0100
X-MC-Unique: eMdBWz8ZMTKSSNe4gcd_wQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Mon, 31 May 2021 10:32:22 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.015; Mon, 31 May 2021 10:32:22 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'H. Peter Anvin'" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        "Mike Rapoport" <rppt@kernel.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "untaintableangel@hotmail.co.uk" <untaintableangel@hotmail.co.uk>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86/Kconfig: decrease maximum of X86_RESERVE_LOW to 512K
Thread-Topic: [PATCH] x86/Kconfig: decrease maximum of X86_RESERVE_LOW to 512K
Thread-Index: AQHXU2cJZ9nEZAqrwkWConM5pQYlL6r9VvTg
Date:   Mon, 31 May 2021 09:32:22 +0000
Message-ID: <8f74d4bd0d97445c8a976eab44fc9372@AcuMS.aculab.com>
References: <20210526081100.12239-1-rppt@kernel.org>
 <YK4LGUDWXJWOp7IR@zn.tnic> <YK53kWHb4cPeeHsd@kernel.org>
 <YK6QFLUoPZ7btQfH@zn.tnic> <f7525409-3987-f79d-9f52-71f6c0231491@zytor.com>
In-Reply-To: <f7525409-3987-f79d-9f52-71f6c0231491@zytor.com>
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

RnJvbTogSC4gUGV0ZXIgQW52aW4NCj4gU2VudDogMjggTWF5IDIwMjEgMDM6MTMNCi4uLi4NCj4g
QklPU2VzIGhhdmUgYmVlbiBrbm93biB0byBjbG9iYmVyIG1vcmUgdGhhbiA2NEsuIFRoZXkgYXJl
bid0IHN1cHBvc2VkIHRvDQo+IGNsb2JiZXIgYW55Lg0KDQpUaGV5IHByb2JhYmx5IHNob3VsZG4n
dCBuZWVkIGFueXRoaW5nIGFib3ZlIHRoZSBiYXNlIG9mIHRoZSBET1MNCnRyYW5zaWVudCBwcm9n
cmFtIGFyZWEgcHJlc2VydmVkLg0KQ2FuJ3QgcmVtZW1iZXIgd2hlcmUgdGhhdCBpcyB0aG91Z2gg
Oi0oDQoNCkl0IGlzIGhhcmQgZW5vdWdoIGZpbmRpbmcgYSBzYWZlIG1lbW9yeSBhcmVhIGZvciB0
aGUgTUJSDQpjb2RlIHRvIHJlbG9jYXRlIGl0c2VsZiB0byBiZWZvcmUgbG9hZGluZyB0aGUgUEJS
Lg0KQm90aCB0aGUgTUJSIGFuZCBQQlIgbG9hZCBhdCB0aGUgc2FtZSBhZGRyZXNzIC0gMHhjMDAu
DQoNCj4gNjQwSyBpcyB0aGUgbGltaXQgYmVjYXVzZSB0aGF0IGlzIHRoZSBhZGRyZXNzIG9mIHRo
ZSBFR0EvVkdBIGZyYW1lDQo+IGJ1ZmZlci4gSW4gdGhlIHdvcmRzIG9mIEJpbGwgR2F0ZXMgIjY0
MEsgb3VnaHQgdG8gYmUgZW5vdWdoIGZvciBhbnlvbmUuIg0KDQpJIHRob3VnaHQgdGhlIG9yaWdp
bmFsIG1lbW9yeSBtYXAgYWxsb2NhdGVkIDUxMksgZm9yIG1lbW9yeQ0KYW5kIDUxMmsgZm9yIG1l
bW9yeSBtYXBwZWQgSS9PLg0KTm8gb25lIGNvdWxkIGFmZm9yZCBtb3JlIHRoZW4gNTEySyBEUkFN
IDotKQ0KDQpUaGUgNjQwSyBsaW1pdCBhcHBlYXJzIGJlY2F1c2Ugbm90aGluZyB3YXMgYWN0dWFs
bHkgbWFwcGVkDQphcyB0aGUgYm90dG9tIG9mIHRoZSAnSS9PIGFyZWEnIHNvIG1lbW9yeSBjb3Vs
ZCBleHBhbmQgdXANCnRoYXQgZmFyLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNz
IExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAx
UFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

