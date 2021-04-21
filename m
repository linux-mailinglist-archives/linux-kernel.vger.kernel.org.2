Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD48366932
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 12:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239479AbhDUK2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 06:28:20 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:26704 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S239451AbhDUK2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 06:28:06 -0400
X-UUID: 8c7f4532811b4e10ade2fdeb59f0b28e-20210421
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=zFw8yAnZqHqrgrCE9zr6oWDMCQRp7B4opFO4tAmUvF0=;
        b=qNJSCDvJpYcmQM/1DEKCY2ZFSy91aoFCeKiXFkt7ULStjxUkv+DnkGyHlQjEhVjSOWtPXpUI1HUzS7GQNnoeWyYOtW1RcngAu+5TURso3Pfn/vTa20b7jMRlU3f4s8HJSRTICyQcHeRCYv1Ew1tzl6LXusvwOIctZrVsLfFZOPY=;
X-UUID: 8c7f4532811b4e10ade2fdeb59f0b28e-20210421
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <fengquan.chen@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 967913368; Wed, 21 Apr 2021 18:27:30 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 21 Apr
 2021 18:27:28 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 21 Apr 2021 18:27:27 +0800
Message-ID: <1619000848.25707.27.camel@mhfsdcap03>
Subject: Re: [PATCH] [v4, 1/1] clocksource/drivers/timer-mediatek: optimize
 systimer irq clear flow on shutdown
From:   Fengquan Chen <fengquan.chen@mediatek.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dehui.sun@mediatek.com>, Evan Benn <evanbenn@chromium.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Wed, 21 Apr 2021 18:27:28 +0800
In-Reply-To: <4d3b342c-a14f-f4ac-6860-9f6a88a24501@linaro.org>
References: <1617960162-1988-1-git-send-email-Fengquan.Chen@mediatek.com>
         <1617960162-1988-2-git-send-email-Fengquan.Chen@mediatek.com>
         <4d3b342c-a14f-f4ac-6860-9f6a88a24501@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 77D99EEB134BE632C746AE0F8EF0FE504702C5572C2084D0759BF152633710EB2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTA0LTE5IGF0IDEwOjQ0ICswMjAwLCBEYW5pZWwgTGV6Y2FubyB3cm90ZToN
Cj4gT24gMDkvMDQvMjAyMSAxMToyMiwgRmVuZ3F1YW4gQ2hlbiB3cm90ZToNCj4gPiBtdGtfc3lz
dF9jbGtldnRfc2h1dGRvd24gaXMgY2FsbGVkIGFmdGVyIGlycSBkaXNhYmxlZCBpbiBzdXNwZW5k
IGZsb3csDQo+ID4gY2xlYXIgYW55IHBlbmRpbmcgc3lzdGltZXIgaXJxIHdoZW4gc2h1dGRvd24g
dG8gYXZvaWQgc3VzcGVuZCBhYm9ydGVkDQo+ID4gZHVlIHRvIHRpbWVyIGlycSBwZW5kaW5nDQo+
ID4gDQo+ID4gQWxzbyBhcyBmb3Igc3lzdGltZXIgaW4gbWVkaWF0ZWsgc29jcywgdGhlcmUgbXVz
dCBiZSBmaXJzdGx5IGVuYWJsZQ0KPiA+IHRpbWVyIGJlZm9yZSBjbGVhciBzeXN0aW1lciBpcnEN
Cj4gPiANCj4gPiBGaXhlczogZTNhZjY3NzYwN2Q5KCJjbG9ja3NvdXJjZS9kcml2ZXJzL3RpbWVy
LW1lZGlhdGVrOiBBZGQgc3VwcG9ydCBmb3Igc3lzdGVtIHRpbWVyIikNCj4gPiBTaWduZWQtb2Zm
LWJ5OiBGZW5ncXVhbiBDaGVuIDxmZW5ncXVhbi5jaGVuQG1lZGlhdGVrLmNvbT4NCj4gPiANCj4g
PiAtLS0NCj4gPiAgZHJpdmVycy9jbG9ja3NvdXJjZS90aW1lci1tZWRpYXRlay5jIHwgOCArKysr
KystLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsb2Nrc291cmNlL3RpbWVyLW1lZGlh
dGVrLmMgYi9kcml2ZXJzL2Nsb2Nrc291cmNlL3RpbWVyLW1lZGlhdGVrLmMNCj4gPiBpbmRleCA5
MzE4ZWRjLi42NDYxZmQzIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvY2xvY2tzb3VyY2UvdGlt
ZXItbWVkaWF0ZWsuYw0KPiA+ICsrKyBiL2RyaXZlcnMvY2xvY2tzb3VyY2UvdGltZXItbWVkaWF0
ZWsuYw0KPiA+IEBAIC02MCw5ICs2MCw5IEBADQo+ID4gICAqIFNZU1RfQ09OX0VOOiBDbG9jayBl
bmFibGUuIFNoYWxsIGJlIHNldCB0bw0KPiA+ICAgKiAgIC0gU3RhcnQgdGltZXIgY291bnRkb3du
Lg0KPiA+ICAgKiAgIC0gQWxsb3cgdGltZW91dCB0aWNrcyBiZWluZyB1cGRhdGVkLg0KPiA+IC0g
KiAgIC0gQWxsb3cgY2hhbmdpbmcgaW50ZXJydXB0IGZ1bmN0aW9ucy4NCj4gPiArICogICAtIEFs
bG93IGNoYW5naW5nIGludGVycnVwdCBzdGF0dXMsbGlrZSBjbGVhciBpcnEgcGVuZGluZy4NCj4g
PiAgICoNCj4gPiAtICogU1lTVF9DT05fSVJRX0VOOiBTZXQgdG8gYWxsb3cgaW50ZXJydXB0Lg0K
PiA+ICsgKiBTWVNUX0NPTl9JUlFfRU46IFNldCB0byBlbmFibGUgaW50ZXJydXB0Lg0KPiA+ICAg
Kg0KPiA+ICAgKiBTWVNUX0NPTl9JUlFfQ0xSOiBTZXQgdG8gY2xlYXIgaW50ZXJydXB0Lg0KPiA+
ICAgKi8NCj4gPiBAQCAtNzUsNiArNzUsNyBAQA0KPiA+ICBzdGF0aWMgdm9pZCBtdGtfc3lzdF9h
Y2tfaXJxKHN0cnVjdCB0aW1lcl9vZiAqdG8pDQo+ID4gIHsNCj4gPiAgCS8qIENsZWFyIGFuZCBk
aXNhYmxlIGludGVycnVwdCAqLw0KPiA+ICsJd3JpdGVsKFNZU1RfQ09OX0VOLCBTWVNUX0NPTl9S
RUcodG8pKTsNCj4gPiAgCXdyaXRlbChTWVNUX0NPTl9JUlFfQ0xSIHwgU1lTVF9DT05fRU4sIFNZ
U1RfQ09OX1JFRyh0bykpOw0KPiA+ICB9DQo+IA0KPiBJSVJDLCB0aGVyZSBpcyBhIGhhcmR3YXJl
IGlzc3VlIGhlcmUuIElmIGl0IGlzIHRoZSBjYXNlLCBwbGVhc2UgZGVzY3JpYmUNCj4gaXQgYW5k
IHJlZmVyIHRvIGFuIGVycmF0YSBpZiBhbnkuDQoNClRoYW5rcyBmb3IgcmV2aWV3Lg0KaGVyZSBp
cyBqdXN0IGEgaHcgY29uZmlnIGZsb3cgbGltaXRhdGlvbiwgbm90IGEgYnVnLg0KDQo+IA0KPiBB
bHNvIEV2YW4gQmVubiBjb21tZW50ZWQgeW91ciBjb2RlIGFuZCBhc2tlZCBhIGNvdXBsZSBvZiBx
dWVzdGlvbnMgWzFdLA0KPiBwbGVhc2UgYW5zd2VyIGJlZm9yZSByZXBvc3RpbmcgYSBuZXcgdmVy
c2lvbi4NCj4gDQo+IENvbW1lbnRzIGlnbm9yZWQgPT0gcGF0Y2ggaWdub3JlZA0KDQpUaGFua3Mu
IGkgaGF2ZSBhbnN3ZXJlZCBieSBtYWlsIGJlZm9yZSwgYnV0IGl0IGRpZG4ndCB1cGxvYWRlZCB0
byB0aGUNCmxpc3QuIGhhcyBiZWVuIHVwbG9hZGVkIG9rIG5vdy4NCg0KPiANCj4gPiBAQCAtMTEx
LDYgKzExMiw5IEBAIHN0YXRpYyBpbnQgbXRrX3N5c3RfY2xrZXZ0X25leHRfZXZlbnQodW5zaWdu
ZWQgbG9uZyB0aWNrcywNCj4gPiAgDQo+ID4gIHN0YXRpYyBpbnQgbXRrX3N5c3RfY2xrZXZ0X3No
dXRkb3duKHN0cnVjdCBjbG9ja19ldmVudF9kZXZpY2UgKmNsa2V2dCkNCj4gPiAgew0KPiA+ICsJ
LyogQ2xlYXIgYW55IGlycSAqLw0KPiA+ICsJbXRrX3N5c3RfYWNrX2lycSh0b190aW1lcl9vZihj
bGtldnQpKTsNCj4gPiArDQo+ID4gIAkvKiBEaXNhYmxlIHRpbWVyICovDQo+ID4gIAl3cml0ZWwo
MCwgU1lTVF9DT05fUkVHKHRvX3RpbWVyX29mKGNsa2V2dCkpKTsNCj4gDQo+IFBsZWFzZSBjaGVj
ayBvdXQgdGhlIHBhdGNoIHNlbnQgYnkgRXZhbiBCZW5uIFsyXSwgaWYgeW91IGFncmVlLCBhY2sg
aXQuDQo+IA0KDQpUaGFua3MNCg0KYWdyZWUNCg0KPiBUaGFua3MNCj4gDQo+ICAgLS0gRGFuaWVs
DQo+IA0KPiBbMV0gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9jb21tZW50LzI0MDU5Mjc3
Lw0KPiBbMl0NCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtYXJtLWtlcm5lbC8yMDIx
MDQxMjEzMjIwMC52My4xLkkxZDk5MTcwNDdkZTA2NzE1ZGExNmUxNjIwNzU5ZjcwM2ZjZmRjYmNi
QGNoYW5nZWlkLw0KPiANCg0K

