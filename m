Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C11513668DA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 12:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238903AbhDUKIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 06:08:34 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:44784 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234167AbhDUKId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 06:08:33 -0400
X-UUID: 5791917c1764404ba71a70ac66fbaa1e-20210421
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Vn/ic3Au+/MFZkrpkPv53uQSDSyk0G7+n+ZUcV848Ek=;
        b=GLl4prc/0BrfuBa+7d235BMsSfxQkNY1DWKHu1HMy6lQ8WKvrLSjQGC1nQnsFZq03e8w9uhG88ILZGgXmqpT7BTkba5WnYqnlNfWSkKf7BMGPboo41yDgfDf5m0YHSTgDBmv7jodPdP7Ifg4iDGolncnUWRyyfwIvbQRXdmvtRk=;
X-UUID: 5791917c1764404ba71a70ac66fbaa1e-20210421
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <fengquan.chen@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1849440413; Wed, 21 Apr 2021 18:07:57 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 21 Apr
 2021 18:07:53 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 21 Apr 2021 18:07:52 +0800
Message-ID: <1618999672.25707.13.camel@mhfsdcap03>
Subject: Re: [PATCH] clocksource/drivers/timer-mediatek: optimize systimer
 irq clear flow on Mediatek Socs
From:   Fengquan Chen <fengquan.chen@mediatek.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dehui.sun@mediatek.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Wed, 21 Apr 2021 18:07:52 +0800
In-Reply-To: <c91e9afc-8b04-f35b-bcf9-1fcf9a6f425f@linaro.org>
References: <1614670085-26229-1-git-send-email-Fengquan.Chen@mediatek.com>
         <1614670085-26229-2-git-send-email-Fengquan.Chen@mediatek.com>
         <c91e9afc-8b04-f35b-bcf9-1fcf9a6f425f@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 7FCA932D73FF3B2DC81C4B0FD3A5E49DA968D3CAE9ACD0F98B07D7C70245117B2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTAzLTIyIGF0IDExOjEwICswMTAwLCBEYW5pZWwgTGV6Y2FubyB3cm90ZToN
Cj4gT24gMDIvMDMvMjAyMSAwODoyOCwgRmVuZ3F1YW4gQ2hlbiB3cm90ZToNCj4gPiAxKWVuc3Vy
ZSBzeXN0aW1lciBpcyBlbmFibGVkIGJlZm9yZSBjbGVhciBhbmQgZGlzYWJsZSBpbnRlcnJ1cHQs
IHdoaWNoIG9ubHkNCj4gPiBmb3Igc3lzdGltZXIgaW4gTWVkaWF0ZWsgU29jcy4NCj4gPg0KPiA+
IDIpY2xlYXIgYW55IHBlbmRpbmcgdGltZXItaXJxIHdoZW4gc2h1dGRvd24gdG8ga2VlcCBzdXNw
ZW5kIGZsb3cgY2xlYW4sDQo+ID4gd2hlbiB1c2Ugc3lzdGltZXIgYXMgdGljay1icm9hZGNhc3Qg
dGltZXINCj4gPiANCj4gPiBDaGFuZ2UtSWQ6IElhM2VkYTgzMzI0YWYyZmRhZjVjYmIzNTY5YTli
ZjAyMGExMWY4MDA5DQo+IA0KPiBSZW1vdmUgdGhlIGFib3ZlLg0KPiANCj4gQWRkIGEgRml4ZXMg
dGFnLg0KDQpUaGFua3MgZm9yIHJldmlldywgaGFzIGJlZW4gZml4ZWQgaW4gVjQ6DQpodHRwczov
L3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtbWVkaWF0ZWsvcGF0Y2gvMTYxNzk2
MDE2Mi0xOTg4LTItZ2l0LXNlbmQtZW1haWwtRmVuZ3F1YW4uQ2hlbkBtZWRpYXRlay5jb20vDQoN
Cj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogRmVuZ3F1YW4gQ2hlbiA8ZmVuZ3F1YW4uY2hlbkBtZWRp
YXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvY2xvY2tzb3VyY2UvdGltZXItbWVkaWF0
ZWsuYyB8IDQgKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQo+ID4g
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xvY2tzb3VyY2UvdGltZXItbWVkaWF0ZWsuYyBi
L2RyaXZlcnMvY2xvY2tzb3VyY2UvdGltZXItbWVkaWF0ZWsuYw0KPiA+IGluZGV4IDkzMThlZGMu
LjlmMWYwOTVkYyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2Nsb2Nrc291cmNlL3RpbWVyLW1l
ZGlhdGVrLmMNCj4gPiArKysgYi9kcml2ZXJzL2Nsb2Nrc291cmNlL3RpbWVyLW1lZGlhdGVrLmMN
Cj4gPiBAQCAtNzUsNiArNzUsNyBAQA0KPiA+ICBzdGF0aWMgdm9pZCBtdGtfc3lzdF9hY2tfaXJx
KHN0cnVjdCB0aW1lcl9vZiAqdG8pDQo+ID4gIHsNCj4gPiAgCS8qIENsZWFyIGFuZCBkaXNhYmxl
IGludGVycnVwdCAqLw0KPiA+ICsJd3JpdGVsKFNZU1RfQ09OX0VOLCBTWVNUX0NPTl9SRUcodG8p
KTsNCj4gDQo+IAlTWVNUX0NPTl9FTiBpcyBzZXQgYmVsb3csIHdoeSBkbyB5b3UgaGF2ZSB0byBk
byBpdCBiZWZvcmU/DQo+IA0KPiBJcyB0aGF0IGEgaHcgYnVnID8NCj4gDQo+IEl0IGlzIGNvbmZ1
c2luZyB3aGF0IHRoZSBkZXNjcmlwdGlvbiBvZiB0aGUgU1lTVF9DT05fRU4gc2F5czoNCj4gDQo+
IC8qDQo+ICAqIFNZU1RfQ09OX0VOOiBDbG9jayBlbmFibGUuIFNoYWxsIGJlIHNldCB0bw0KPiAg
KiAgIC0gU3RhcnQgdGltZXIgY291bnRkb3duLg0KPiAgKiAgIC0gQWxsb3cgdGltZW91dCB0aWNr
cyBiZWluZyB1cGRhdGVkLg0KPiAgKiAgIC0gQWxsb3cgY2hhbmdpbmcgaW50ZXJydXB0IGZ1bmN0
aW9ucy4NCj4gDQo+IFdoYXQgbWVhbnMgImludGVycnVwdCBmdW5jdGlvbnMiID8NCj4gDQo+IERv
ZXMgd3JpdGluZyB3cml0ZWwoU1lTVF9DT05fRU4sIFNZU1RfQ09OX1JFRyh0bykpIGJlZm9yZQ0K
PiBTWVNUX0NPTl9JUlFfQ0xSIGFsbG93cyB0byBjbGVhciB0aGUgaW50ZXJydXB0IGZsYWc/DQo+
IA0KPiBDYW4geW91IGV4cGxhaW4gaG93IHRoZSB0aW1lciB3b3JrcyByZWdhcmRpbmcgdGhpcyBw
YXJ0Pw0KPiANCj4gSXQgc291bmRzIHRvIG1lIGEgYml0IHN0cmFuZ2UuDQo+IA0KPiAgKg0KPiAg
KiBTWVNUX0NPTl9JUlFfRU46IFNldCB0byBhbGxvdyBpbnRlcnJ1cHQuDQo+ICAqDQo+ICAqIFNZ
U1RfQ09OX0lSUV9DTFI6IFNldCB0byBjbGVhciBpbnRlcnJ1cHQuDQo+ICAqLw0KPiANCg0KVGhh
bmtzIGZvciByZXZpZXcsIGRlc2NyaXB0aW9ucyBhYm91dA0KU1lTVF9DT05fSVJRX0NMUi9TWVNU
X0NPTl9FTi9TWVNUX0NPTl9JUlFfRU4gaGF2ZSBiZWVuIHVwZGF0ZWQgaW4gdjQuDQoNCkFuZCBm
b3Igc3lzdGltZXIsIHRoZXJlJ3MgYSBodyBsaW1pdGF0aW9uIHRoYXQgYmVmb3JlIGNsZWFyaW5n
IHBlbmRpbmcNCmlycXMsIHdlIG11c3QgZW5hYmxlIHRpbWVyIGZpcnN0LiBzbyB3ZSBhZGRlZCBh
IFNZU1RfQ09OX0VOIHdyaXRlIGJlZm9yZQ0KU1lTVF9DT05fSVJRX0NMUiB3cml0ZSB0byBlbnN1
cmUgaXJxIGNsZWFyIHN1Y2Nlc3NmdWxseS4NCg0KQWxzbywgd2UgY2Fubm90IG9ubHkgd3JpdGUg
U1lTVF9DT05fSVJRX0NMUiB3aXRob3V0IFNZU1RfQ09OX0VOIGJpdCwNCmJlY2F1c2UgRU4gYml0
IGlzIGFsc28gdGltZXIgY2xvY2sgZW5hYmxlIGJpdC4gDQoNCnRoaXMgaXMgYSBoYXJkd2FyZCBk
ZXNpZ24gbGltaXRhdGlvbiBidXQgbm90IGEgYnVnLg0KDQo+IA0KPiA+ICAJd3JpdGVsKFNZU1Rf
Q09OX0lSUV9DTFIgfCBTWVNUX0NPTl9FTiwgU1lTVF9DT05fUkVHKHRvKSk7DQo+ID4gIH0NCj4g
PiAgDQo+ID4gQEAgLTExMSw2ICsxMTIsOSBAQCBzdGF0aWMgaW50IG10a19zeXN0X2Nsa2V2dF9u
ZXh0X2V2ZW50KHVuc2lnbmVkIGxvbmcgdGlja3MsDQo+ID4gIA0KPiA+ICBzdGF0aWMgaW50IG10
a19zeXN0X2Nsa2V2dF9zaHV0ZG93bihzdHJ1Y3QgY2xvY2tfZXZlbnRfZGV2aWNlICpjbGtldnQp
DQo+ID4gIHsNCj4gPiArCS8qIENsZWFyIGFueSBpcnEgKi8NCj4gPiArCW10a19zeXN0X2Fja19p
cnEodG9fdGltZXJfb2YoY2xrZXZ0KSk7DQo+ID4gKw0KPiA+ICAJLyogRGlzYWJsZSB0aW1lciAq
Lw0KPiA+ICAJd3JpdGVsKDAsIFNZU1RfQ09OX1JFRyh0b190aW1lcl9vZihjbGtldnQpKSk7DQo+
ID4gIA0KPiA+IA0KPiANCj4gDQoNCg==

