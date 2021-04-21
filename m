Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31E5C366903
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 12:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238777AbhDUKRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 06:17:55 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:29683 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234038AbhDUKRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 06:17:54 -0400
X-UUID: 49718aed876c4f74b64e9a3795e53fbb-20210421
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=9IoeKBla8pN9WE4+y5GJhke4Dy+p0ylLEjnf88v7Uqk=;
        b=fQNY8k1jcr1ai4RxVlKGqy4Sh6iY16HRZ+oA0gEszTI+/RS/kDRdk0rscojYm9Xgs2GFggVQqxEKSGUkzPDGhZOdSQnUPQrk/jNJQ1YywVuZ/U6S5V8mhh1k+tV14lM83t2bo5TjaDiApMlM60cbUG9cd515Uk6JBtNtBz0naIo=;
X-UUID: 49718aed876c4f74b64e9a3795e53fbb-20210421
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <fengquan.chen@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 366369709; Wed, 21 Apr 2021 18:17:15 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 21 Apr
 2021 18:17:07 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 21 Apr 2021 18:17:07 +0800
Message-ID: <1619000227.25707.20.camel@mhfsdcap03>
Subject: Re: [PATCH] clocksource/drivers/timer-mediatek: optimize systimer
 irq clear flow on Mediatek Socs
From:   Fengquan Chen <fengquan.chen@mediatek.com>
To:     Evan Benn <evanbenn@chromium.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        <dehui.sun@mediatek.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Date:   Wed, 21 Apr 2021 18:17:07 +0800
In-Reply-To: <CAKz_xw2abQyS9Vvx7DUppGGd-AaDQAfdAOwi46fB9yLPJWJeUA@mail.gmail.com>
References: <1614670085-26229-1-git-send-email-Fengquan.Chen@mediatek.com>
         <1614670085-26229-2-git-send-email-Fengquan.Chen@mediatek.com>
         <CAKz_xw2abQyS9Vvx7DUppGGd-AaDQAfdAOwi46fB9yLPJWJeUA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: BDB2F9AC03454462D38628DCDC4993140A01337F80411D53696602FA182485272000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIxLTAzLTIzIGF0IDExOjQ4ICsxMTAwLCBFdmFuIEJlbm4gd3JvdGU6DQo+IE9u
IFRodSwgTWFyIDQsIDIwMjEgYXQgMTE6MDcgQU0gRmVuZ3F1YW4gQ2hlbg0KPiA8RmVuZ3F1YW4u
Q2hlbkBtZWRpYXRlay5jb20+IHdyb3RlOg0KPiA+DQo+ID4gMSllbnN1cmUgc3lzdGltZXIgaXMg
ZW5hYmxlZCBiZWZvcmUgY2xlYXIgYW5kIGRpc2FibGUgaW50ZXJydXB0LCB3aGljaCBvbmx5DQo+
ID4gZm9yIHN5c3RpbWVyIGluIE1lZGlhdGVrIFNvY3MuDQo+IA0KPiBXaHkgZG9lcyB0aGUgdGlt
ZXIgbmVlZCB0byBiZSBlbmFibGVkIGJlZm9yZSB0aGUgaW50ZXJydXB0IGNhbiBiZQ0KPiBkaXNh
YmxlZD8gVGhlIGRhdGFzaGVldCBJIGhhdmUgZG9lcyBub3Qgc3VnZ2VzdCB0aGF0IHRoaXMgaXMg
cmVxdWlyZWQuDQo+IA0KDQpUaGFua3MgZm9yIHJldmlldy4gRm9yIHN5c3RpbWVyLCB5b3UgbXVz
dCBlbmFibGUgdGltZXIgYmVmb3JlIGNsZWFyDQppcnEsaXQncyBhIGh3IGxpbWl0YXRpb24gdGhh
dCB3b3VsZCBiZSBlYXNpbHkgbmVnbGVjdGVkLg0KDQo+ID4NCj4gPiAyKWNsZWFyIGFueSBwZW5k
aW5nIHRpbWVyLWlycSB3aGVuIHNodXRkb3duIHRvIGtlZXAgc3VzcGVuZCBmbG93IGNsZWFuLA0K
PiA+IHdoZW4gdXNlIHN5c3RpbWVyIGFzIHRpY2stYnJvYWRjYXN0IHRpbWVyDQo+ID4NCj4gPiBD
aGFuZ2UtSWQ6IElhM2VkYTgzMzI0YWYyZmRhZjVjYmIzNTY5YTliZjAyMGExMWY4MDA5DQo+ID4g
U2lnbmVkLW9mZi1ieTogRmVuZ3F1YW4gQ2hlbiA8ZmVuZ3F1YW4uY2hlbkBtZWRpYXRlay5jb20+
DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvY2xvY2tzb3VyY2UvdGltZXItbWVkaWF0ZWsuYyB8IDQg
KysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9jbG9ja3NvdXJjZS90aW1lci1tZWRpYXRlay5jIGIvZHJpdmVycy9j
bG9ja3NvdXJjZS90aW1lci1tZWRpYXRlay5jDQo+ID4gaW5kZXggOTMxOGVkYy4uOWYxZjA5NWRj
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvY2xvY2tzb3VyY2UvdGltZXItbWVkaWF0ZWsuYw0K
PiA+ICsrKyBiL2RyaXZlcnMvY2xvY2tzb3VyY2UvdGltZXItbWVkaWF0ZWsuYw0KPiA+IEBAIC03
NSw2ICs3NSw3IEBADQo+ID4gIHN0YXRpYyB2b2lkIG10a19zeXN0X2Fja19pcnEoc3RydWN0IHRp
bWVyX29mICp0bykNCj4gDQo+IFRoaXMgZnVuY3Rpb24gc2VlbXMgdG8gYmUgbWlzLW5hbWVkLiBJ
dCBkb2VzIG1vcmUgdGhhbiBqdXN0IGFjayB0aGUgaXJxLg0KPiANCj4gPiAgew0KPiA+ICAgICAg
ICAgLyogQ2xlYXIgYW5kIGRpc2FibGUgaW50ZXJydXB0ICovDQo+ID4gKyAgICAgICB3cml0ZWwo
U1lTVF9DT05fRU4sIFNZU1RfQ09OX1JFRyh0bykpOw0KPiANCj4gVGhpcyBsaW5lIHNlZW1zIHRv
IGVuYWJsZSB0aGUgdGltZXIgYW5kIGRpc2FibGUgdGhlIGludGVycnVwdC4NCj4gDQo+ID4gICAg
ICAgICB3cml0ZWwoU1lTVF9DT05fSVJRX0NMUiB8IFNZU1RfQ09OX0VOLCBTWVNUX0NPTl9SRUco
dG8pKTsNCj4gDQo+IFRoaXMgbGluZSBhY2tzIHRoZSBpbnRlcnJ1cHQgYW5kIGVuYWJsZXMgdGhl
IHRpbWVyIGFuZCBkaXNhYmxlcyB0aGUgaW50ZXJydXB0Lg0KPiBBcmUgdGhlc2UgbGluZXMgYm90
aCBuZWNlc3Nhcnk/DQo+IE1heWJlIHRoaXMgZnVuY3Rpb24gc2hvdWxkIGp1c3QgYWNrIHRoZSBp
bnRlcnJ1cHQgd2l0aG91dCBjaGFuZ2luZyB0aGUNCj4gb3RoZXIgYml0cy4NCg0KVGhhbmtzIGZv
ciByZXZpZXcuIA0KDQppdCdzIG5lY2Vzc2FyeS4NCg0KQXMgZGVzY3JpYmVkIGFib3ZlLHdlIG11
c3QgZW5hYmxlIHRpbWVyIGJlZm9yZSBjbGVhcg0KaXJxLCBzbyBoZXJlIGlzIGp1c3Qgd2FudCB0
byBlbnN1cmUgaXJxIGNsZWFyIHN1Y2Nlc3NmdWxseS4NCg0KV2UgYWx3YXlzIGRpc2FibGUgaXJx
IGhlcmUsIGFuZCB3aWxsIGJlIHJlLWVuYWJsZSBpbg0KbXRrX3N5c3RfY2xrZXZ0X25leHRfZXZl
bnQuDQoNCj4gDQo+ID4gIH0NCj4gPg0KPiA+IEBAIC0xMTEsNiArMTEyLDkgQEAgc3RhdGljIGlu
dCBtdGtfc3lzdF9jbGtldnRfbmV4dF9ldmVudCh1bnNpZ25lZCBsb25nIHRpY2tzLA0KPiA+DQo+
ID4gIHN0YXRpYyBpbnQgbXRrX3N5c3RfY2xrZXZ0X3NodXRkb3duKHN0cnVjdCBjbG9ja19ldmVu
dF9kZXZpY2UgKmNsa2V2dCkNCj4gPiAgew0KPiA+ICsgICAgICAgLyogQ2xlYXIgYW55IGlycSAq
Lw0KPiA+ICsgICAgICAgbXRrX3N5c3RfYWNrX2lycSh0b190aW1lcl9vZihjbGtldnQpKTsNCj4g
PiArDQo+ID4gICAgICAgICAvKiBEaXNhYmxlIHRpbWVyICovDQo+ID4gICAgICAgICB3cml0ZWwo
MCwgU1lTVF9DT05fUkVHKHRvX3RpbWVyX29mKGNsa2V2dCkpKTsNCj4gDQo+IFRoaXMgaXMgYSB0
aGlyZCB3cml0ZSB0byB0aGUgc2FtZSByZWdpc3RlciwgSSBiZWxpZXZlIGFsbCAzIHdyaXRlcyBj
YW4NCj4gYmUgY29tYmluZWQgaW50byAxLiBJcyB0aGF0IHBvc3NpYmxlPw0KDQpUaGFua3MgZm9y
IHJldmlldy4gDQoNCnRoZXJlJ3MgYSBodyBsaW1pdGF0aW9uIGhlcmUsIHdlIGNhbiBub3QgY2xl
YXIgaXJxIHdoaWxlIHRpbWVyIGlzDQpkaXNhYmxlZCwgYW5kIFNZU1RfQ09OX0VOJlNZU1RfQ09O
X0lSUV9DTFIgYml0IG11c3QgYmUgd3JpdGUgYXQgdGhlIHNhbWUNCnRpbWUgb3IgY2FuIG5vdCAg
d3JpdGUgU1lTVF9DT05fSVJRX0NMUiBiaXQgc2VwZXJhdGVseS4NCg0KDQo+IA0KPiA+DQo+ID4g
LS0NCj4gPiAxLjguMS4xLmRpcnR5DQo+ID4NCg0K

