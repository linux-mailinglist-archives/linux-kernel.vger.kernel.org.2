Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A284578D2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 23:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbhKSWeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 17:34:18 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:57627 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231477AbhKSWeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 17:34:17 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-150-TLzD-UFjPSu_uxpT-Txzlg-1; Fri, 19 Nov 2021 22:31:09 +0000
X-MC-Unique: TLzD-UFjPSu_uxpT-Txzlg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.26; Fri, 19 Nov 2021 22:31:08 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.026; Fri, 19 Nov 2021 22:31:08 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Noah Goldstein' <goldstein.w.n@gmail.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4] arch/x86: Improve 'rep movs{b|q}' usage in
 memmove_64.S
Thread-Topic: [PATCH v4] arch/x86: Improve 'rep movs{b|q}' usage in
 memmove_64.S
Thread-Index: AQHX2/aBIpegHmlt3EiJPKc4pU+GYawITRxwgAAEh4CAAxnnEA==
Date:   Fri, 19 Nov 2021 22:31:08 +0000
Message-ID: <e41913010e61429bbd2980a5c5ccfb39@AcuMS.aculab.com>
References: <20211101044955.2295495-1-goldstein.w.n@gmail.com>
 <20211117210245.843374-1-goldstein.w.n@gmail.com>
 <bc0297a1b97a4b129fa3ea1b155f6062@AcuMS.aculab.com>
 <CAFUsyfJTuFjVXHMgYi0uggVNW=1WW1uVYa7avVjW5VBb2cmAkQ@mail.gmail.com>
In-Reply-To: <CAFUsyfJTuFjVXHMgYi0uggVNW=1WW1uVYa7avVjW5VBb2cmAkQ@mail.gmail.com>
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

RnJvbTogTm9haCBHb2xkc3RlaW4NCj4gU2VudDogMTcgTm92ZW1iZXIgMjAyMSAyMjo0NQ0KPiAN
Cj4gT24gV2VkLCBOb3YgMTcsIDIwMjEgYXQgNDozMSBQTSBEYXZpZCBMYWlnaHQgPERhdmlkLkxh
aWdodEBhY3VsYWIuY29tPiB3cm90ZToNCj4gPg0KPiA+IEZyb206IE5vYWggR29sZHN0ZWluDQo+
ID4gPiBTZW50OiAxNyBOb3ZlbWJlciAyMDIxIDIxOjAzDQo+ID4gPg0KPiA+ID4gQWRkIGNoZWNr
IGZvciAic2hvcnQgZGlzdGFuY2UgbW92c2IiIGZvciBmb3J3YXJkcyBGU1JNIHVzYWdlIGFuZA0K
PiA+ID4gZW50aXJlbHkgcmVtb3ZlIGJhY2t3YXJkcyAncmVwIG1vdnNxJy4gQm90aCBvZiB0aGVz
ZSB1c2FnZXMgaGl0ICJzbG93DQo+ID4gPiBtb2RlcyIgdGhhdCBhcmUgYW4gb3JkZXIgb2YgbWFn
bml0dWRlIHNsb3dlciB0aGFuIHVzdWFsLg0KPiA+ID4NCj4gPiA+ICdyZXAgbW92c2InIGhhcyBz
b21lIG5vdGljZWFibGUgVkVSWSBzbG93IG1vZGVzIHRoYXQgdGhlIGN1cnJlbnQNCj4gPiA+IGlt
cGxlbWVudGF0aW9uIGlzIGVpdGhlciAxKSBub3QgY2hlY2tpbmcgZm9yIG9yIDIpIGludGVudGlv
bmFsbHkNCj4gPiA+IHVzaW5nLg0KPiA+DQo+ID4gSG93IGRvZXMgdGhpcyByZWxhdGUgdG8gdGhl
IGRlY2lzaW9uIHRoYXQgZ2xpYmMgbWFkZSBhIGZldyB5ZWFycw0KPiA+IGFnbyB0byB1c2UgYmFj
a3dhcmRzICdyZXAgbW92cycgZm9yIG5vbi1vdmVybGFwcGluZyBjb3BpZXM/DQo+IA0KPiBHTElC
QyBkb2Vzbid0IHVzZSBiYWNrd2FyZHMgYHJlcCBtb3ZzYC4gIFNpbmNlIHRoZSByZWdpb25zIGFy
ZQ0KPiBub24tb3ZlcmxhcHBpbmcgaXQganVzdCB1c2VzIGZvcndhcmQgY29weS4gQmFja3dhcmRz
IGByZXAgbW92c2AgaXMNCj4gZnJvbSBzZXR0aW5nIHRoZSBkaXJlY3Rpb24gZmxhZyAoYHN0ZGAp
IGFuZCBpcyBhIHZlcnkgc2xvdyBieXRlDQo+IGNvcHkuIEZvciBvdmVybGFwcGluZyByZWdpb25z
IHdoZXJlIGJhY2t3YXJkcyBjb3B5IGlzIG5lY2Vzc2FyeSBHTElCQw0KPiB1c2VzIDR4IHZlYyBj
b3B5IGxvb3AuDQoNClRyeSB0byBmaW5kIHRoaXMgY29tbWl0IDZmYjhjYmNiNThhMjlmZmY3M2Vi
MjEwMWIzNGNhYTE5YTdmODhlYmENCg0KT3IgZm9sbG93IGxpbmtzIGZyb20gaHR0cHM6Ly93d3cu
d2luLnR1ZS5ubC9+YWViL2xpbnV4L21pc2MvZ2NjLXNlbWlidWcuaHRtbA0KQnV0IEkgY2FuJ3Qg
ZmluZCB0aGUgYWN0dWFsIHBhdGNoLg0KDQpUaGUgY2xhaW1zIHdlcmUgYSBtYXNzaXZlIHBlcmZv
cm1hbmNlIGluY3JlYXNlIGZvciB0aGUgcmV2ZXJzZSBjb3B5Lg0KDQpUaGUgcGRmIGZyb20gd3d3
LmFnbmVyLm9yZy9vcHRpbWl6ZSBtYXkgd2VsbCBpbmRpY2F0ZSB3aHkgc29tZQ0KY29waWVzIGFy
ZSB1bmV4cGVjdGVkbHkgc2xvdyBkdWUgdG8gY2FjaGUgYWNjZXNzIGFsaWFzaW5nLg0KDQpJJ20g
cHJldHR5IHN1cmUgdGhhdCBJbnRlbCBjcHUgKHBvc3NpYmx5IGZyb20gSXZ5IGJyaWRnZSBvbndh
cmRzKQ0KY2FuIGJlIHBlcnN1YWRlZCB0byBjb3B5IDggYnl0ZXMvY2xvY2sgZm9yIGluLWNhY2hl
IGRhdGEgd2l0aA0KYSBmYWlybHkgc2ltcGxlIGxvb3AgdGhhdCBjb250YWlucyAyIHJlYWRzICht
YXliZSBtaXNhbGlnbmVkKQ0KYW5kIHR3byB3cml0ZXMgKHNvIDE2IGJ5dGVzIHBlciBpdGVyYXRp
b24pLg0KRXh0cmEgdW5yb2xsaW5nIGp1c3QgYWRkcyBleHRyYSBjb2RlIHRvcCBhbmQgYm90dG9t
Lg0KDQpZb3UgbWlnaHQgd2FudCBhIGxvb3AgbGlrZToNCgkxOgltb3YJMCglcnNpLCAlcmN4KSwl
cmF4DQoJCW1vdgk4KCVyc2ksICVyY3gpLCVyZHgNCgkJbW92CSVyYXgsIDAoJXJkaSwgJXJjeCkN
CgkJbW92CSVyZHgsIDgoJXJkaSwgJXJjeCkNCgkJYWRkCSQxNiwgJXJjeA0KCQlqbnoJMWINCg0K
CURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBN
b3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAx
Mzk3Mzg2IChXYWxlcykNCg==

