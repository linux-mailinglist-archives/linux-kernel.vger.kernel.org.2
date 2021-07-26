Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62EF33D56F5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 12:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbhGZJVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 05:21:32 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:27795 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232617AbhGZJVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 05:21:31 -0400
X-UUID: 63e045e5755e4809964ca0b3535bd33f-20210726
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID; bh=rv/DOWyX88A+TeQfnHqh9Nw3aWoA1q2sNpe/dznTr2U=;
        b=AOJLJ8ozcTMyPtvPRPC+NSPrpIpaygdbhYaq0QAtGd+WmuhauCu5yvrjrSOrt7kZzmLBj78OgRcrvwzQiILUn1tGPCy2sWhrGAKoaNPEHdZECfTLsaOyhP4xmIsPGBfS5FlOYajEWxLJA2hOwkKs1c5L+iZHXpJ1CjJMko3j9hs=;
X-UUID: 63e045e5755e4809964ca0b3535bd33f-20210726
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <fengquan.chen@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1456341162; Mon, 26 Jul 2021 18:01:54 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 26 Jul
 2021 18:01:48 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 26 Jul 2021 18:01:48 +0800
Message-ID: <1627293708.10231.3.camel@mhfsdcap03>
Subject: Re: [PATCH] [v4, 1/1] clocksource/drivers/timer-mediatek: optimize
 systimer irq clear flow on shutdown
From:   Fengquan Chen <fengquan.chen@mediatek.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dehui.sun@mediatek.com>, Evan Benn <evanbenn@chromium.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Mon, 26 Jul 2021 18:01:48 +0800
In-Reply-To: <1619000848.25707.27.camel@mhfsdcap03>
References: <1617960162-1988-1-git-send-email-Fengquan.Chen@mediatek.com>
         <1617960162-1988-2-git-send-email-Fengquan.Chen@mediatek.com>
         <4d3b342c-a14f-f4ac-6860-9f6a88a24501@linaro.org>
         <1619000848.25707.27.camel@mhfsdcap03>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 28765AAEE42228EE297569FACD9DAB7DBF080DFBB6BF177F00CB4D1BDB38CD5B2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

aGkgRGFuaWVsLA0KDQpHZW50bGUgcGluIGZvciB0aGlzIHBhdGNoLg0KDQpUaGFua3MNCkJlc3Qg
UmVnYXJkcw0KRmVuZ3F1YW4NCg0KDQpPbiBXZWQsIDIwMjEtMDQtMjEgYXQgMTg6MjcgKzA4MDAs
IEZlbmdxdWFuIENoZW4gd3JvdGU6DQo+IE9uIE1vbiwgMjAyMS0wNC0xOSBhdCAxMDo0NCArMDIw
MCwgRGFuaWVsIExlemNhbm8gd3JvdGU6DQo+ID4gT24gMDkvMDQvMjAyMSAxMToyMiwgRmVuZ3F1
YW4gQ2hlbiB3cm90ZToNCj4gPiA+IG10a19zeXN0X2Nsa2V2dF9zaHV0ZG93biBpcyBjYWxsZWQg
YWZ0ZXIgaXJxIGRpc2FibGVkIGluIHN1c3BlbmQgZmxvdywNCj4gPiA+IGNsZWFyIGFueSBwZW5k
aW5nIHN5c3RpbWVyIGlycSB3aGVuIHNodXRkb3duIHRvIGF2b2lkIHN1c3BlbmQgYWJvcnRlZA0K
PiA+ID4gZHVlIHRvIHRpbWVyIGlycSBwZW5kaW5nDQo+ID4gPiANCj4gPiA+IEFsc28gYXMgZm9y
IHN5c3RpbWVyIGluIG1lZGlhdGVrIHNvY3MsIHRoZXJlIG11c3QgYmUgZmlyc3RseSBlbmFibGUN
Cj4gPiA+IHRpbWVyIGJlZm9yZSBjbGVhciBzeXN0aW1lciBpcnENCj4gPiA+IA0KPiA+ID4gRml4
ZXM6IGUzYWY2Nzc2MDdkOSgiY2xvY2tzb3VyY2UvZHJpdmVycy90aW1lci1tZWRpYXRlazogQWRk
IHN1cHBvcnQgZm9yIHN5c3RlbSB0aW1lciIpDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBGZW5ncXVh
biBDaGVuIDxmZW5ncXVhbi5jaGVuQG1lZGlhdGVrLmNvbT4NCj4gPiA+IA0KPiA+ID4gLS0tDQo+
ID4gPiAgZHJpdmVycy9jbG9ja3NvdXJjZS90aW1lci1tZWRpYXRlay5jIHwgOCArKysrKystLQ0K
PiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+
ID4gPiANCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsb2Nrc291cmNlL3RpbWVyLW1lZGlh
dGVrLmMgYi9kcml2ZXJzL2Nsb2Nrc291cmNlL3RpbWVyLW1lZGlhdGVrLmMNCj4gPiA+IGluZGV4
IDkzMThlZGMuLjY0NjFmZDMgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL2Nsb2Nrc291cmNl
L3RpbWVyLW1lZGlhdGVrLmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvY2xvY2tzb3VyY2UvdGltZXIt
bWVkaWF0ZWsuYw0KPiA+ID4gQEAgLTYwLDkgKzYwLDkgQEANCj4gPiA+ICAgKiBTWVNUX0NPTl9F
TjogQ2xvY2sgZW5hYmxlLiBTaGFsbCBiZSBzZXQgdG8NCj4gPiA+ICAgKiAgIC0gU3RhcnQgdGlt
ZXIgY291bnRkb3duLg0KPiA+ID4gICAqICAgLSBBbGxvdyB0aW1lb3V0IHRpY2tzIGJlaW5nIHVw
ZGF0ZWQuDQo+ID4gPiAtICogICAtIEFsbG93IGNoYW5naW5nIGludGVycnVwdCBmdW5jdGlvbnMu
DQo+ID4gPiArICogICAtIEFsbG93IGNoYW5naW5nIGludGVycnVwdCBzdGF0dXMsbGlrZSBjbGVh
ciBpcnEgcGVuZGluZy4NCj4gPiA+ICAgKg0KPiA+ID4gLSAqIFNZU1RfQ09OX0lSUV9FTjogU2V0
IHRvIGFsbG93IGludGVycnVwdC4NCj4gPiA+ICsgKiBTWVNUX0NPTl9JUlFfRU46IFNldCB0byBl
bmFibGUgaW50ZXJydXB0Lg0KPiA+ID4gICAqDQo+ID4gPiAgICogU1lTVF9DT05fSVJRX0NMUjog
U2V0IHRvIGNsZWFyIGludGVycnVwdC4NCj4gPiA+ICAgKi8NCj4gPiA+IEBAIC03NSw2ICs3NSw3
IEBADQo+ID4gPiAgc3RhdGljIHZvaWQgbXRrX3N5c3RfYWNrX2lycShzdHJ1Y3QgdGltZXJfb2Yg
KnRvKQ0KPiA+ID4gIHsNCj4gPiA+ICAJLyogQ2xlYXIgYW5kIGRpc2FibGUgaW50ZXJydXB0ICov
DQo+ID4gPiArCXdyaXRlbChTWVNUX0NPTl9FTiwgU1lTVF9DT05fUkVHKHRvKSk7DQo+ID4gPiAg
CXdyaXRlbChTWVNUX0NPTl9JUlFfQ0xSIHwgU1lTVF9DT05fRU4sIFNZU1RfQ09OX1JFRyh0bykp
Ow0KPiA+ID4gIH0NCj4gPiANCj4gPiBJSVJDLCB0aGVyZSBpcyBhIGhhcmR3YXJlIGlzc3VlIGhl
cmUuIElmIGl0IGlzIHRoZSBjYXNlLCBwbGVhc2UgZGVzY3JpYmUNCj4gPiBpdCBhbmQgcmVmZXIg
dG8gYW4gZXJyYXRhIGlmIGFueS4NCj4gDQo+IFRoYW5rcyBmb3IgcmV2aWV3Lg0KPiBoZXJlIGlz
IGp1c3QgYSBodyBjb25maWcgZmxvdyBsaW1pdGF0aW9uLCBub3QgYSBidWcuDQo+IA0KPiA+IA0K
PiA+IEFsc28gRXZhbiBCZW5uIGNvbW1lbnRlZCB5b3VyIGNvZGUgYW5kIGFza2VkIGEgY291cGxl
IG9mIHF1ZXN0aW9ucyBbMV0sDQo+ID4gcGxlYXNlIGFuc3dlciBiZWZvcmUgcmVwb3N0aW5nIGEg
bmV3IHZlcnNpb24uDQo+ID4gDQo+ID4gQ29tbWVudHMgaWdub3JlZCA9PSBwYXRjaCBpZ25vcmVk
DQo+IA0KPiBUaGFua3MuIGkgaGF2ZSBhbnN3ZXJlZCBieSBtYWlsIGJlZm9yZSwgYnV0IGl0IGRp
ZG4ndCB1cGxvYWRlZCB0byB0aGUNCj4gbGlzdC4gaGFzIGJlZW4gdXBsb2FkZWQgb2sgbm93Lg0K
PiANCj4gPiANCj4gPiA+IEBAIC0xMTEsNiArMTEyLDkgQEAgc3RhdGljIGludCBtdGtfc3lzdF9j
bGtldnRfbmV4dF9ldmVudCh1bnNpZ25lZCBsb25nIHRpY2tzLA0KPiA+ID4gIA0KPiA+ID4gIHN0
YXRpYyBpbnQgbXRrX3N5c3RfY2xrZXZ0X3NodXRkb3duKHN0cnVjdCBjbG9ja19ldmVudF9kZXZp
Y2UgKmNsa2V2dCkNCj4gPiA+ICB7DQo+ID4gPiArCS8qIENsZWFyIGFueSBpcnEgKi8NCj4gPiA+
ICsJbXRrX3N5c3RfYWNrX2lycSh0b190aW1lcl9vZihjbGtldnQpKTsNCj4gPiA+ICsNCj4gPiA+
ICAJLyogRGlzYWJsZSB0aW1lciAqLw0KPiA+ID4gIAl3cml0ZWwoMCwgU1lTVF9DT05fUkVHKHRv
X3RpbWVyX29mKGNsa2V2dCkpKTsNCj4gPiANCj4gPiBQbGVhc2UgY2hlY2sgb3V0IHRoZSBwYXRj
aCBzZW50IGJ5IEV2YW4gQmVubiBbMl0sIGlmIHlvdSBhZ3JlZSwgYWNrIGl0Lg0KPiA+IA0KPiAN
Cj4gVGhhbmtzDQo+IA0KPiBhZ3JlZQ0KPiANCj4gPiBUaGFua3MNCj4gPiANCj4gPiAgIC0tIERh
bmllbA0KPiA+IA0KPiA+IFsxXSBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL2NvbW1lbnQv
MjQwNTkyNzcvDQo+ID4gWzJdDQo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtYXJt
LWtlcm5lbC8yMDIxMDQxMjEzMjIwMC52My4xLkkxZDk5MTcwNDdkZTA2NzE1ZGExNmUxNjIwNzU5
ZjcwM2ZjZmRjYmNiQGNoYW5nZWlkLw0KPiA+IA0KPiANCg0K

