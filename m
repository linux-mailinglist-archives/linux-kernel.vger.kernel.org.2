Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADBE3AC2D0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 07:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbhFRFR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 01:17:59 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:42384 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232387AbhFRFR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 01:17:56 -0400
X-UUID: d957f58b6a7145f6a2f95807e6a8d164-20210618
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=MCAYgtrEWwxFrtj93jLlwwnS1NNN9pXyMmhqwZFtpXc=;
        b=uzXBXqEeRwmyIVNTNny111qTwSVSqpa5D0CEY5qFopsvhs8laQhRu4LDH7fLoNCXalpdsG2QjXtlw9vauejGlLmThXwIP5fe/SzAAjVHABOvNBg23TCOcKRfU4R3LMmGBMn6tbI/hfsZGUdLuTGeV2arT00dwf5sNsW2676J7p4=;
X-UUID: d957f58b6a7145f6a2f95807e6a8d164-20210618
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1070384292; Fri, 18 Jun 2021 13:15:35 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 18 Jun
 2021 13:15:26 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 18 Jun 2021 13:15:25 +0800
Message-ID: <1623993325.25153.0.camel@mhfsdcap03>
Subject: Re: [PATCH] usb: xhci-mtk: allow multiple Start-Split in a
 microframe
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Ikjoon Jang <ikjn@chromium.org>,
        "Tianping Fang" <tianping.fang@mediatek.com>
Date:   Fri, 18 Jun 2021 13:15:25 +0800
In-Reply-To: <YMtOtC1j2DouJ9Is@kroah.com>
References: <1623895911-29259-1-git-send-email-chunfeng.yun@mediatek.com>
         <YMtOtC1j2DouJ9Is@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: A4CED631902C6185AC2A9B0E844E6065C8B55134D3565F89B98FEFA91885E8D82000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIxLTA2LTE3IGF0IDE1OjMxICswMjAwLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3Jv
dGU6DQo+IE9uIFRodSwgSnVuIDE3LCAyMDIxIGF0IDEwOjExOjUxQU0gKzA4MDAsIENodW5mZW5n
IFl1biB3cm90ZToNCj4gPiBUaGlzIHBhdGNoIGlzIHVzZWQgdG8gcmVsYXggYmFuZHdpZHRoIHNj
aGVkdWxlIGJ5IGFsbG93aW5nIG11bHRpcGxlDQo+ID4gU3RhcnQtU3BsaXQgaW4gdGhlIHNhbWUg
bWljcm9mcmFtZS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5m
ZW5nLnl1bkBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvdXNiL2hvc3QveGhj
aS1tdGstc2NoLmMgfCAxNiAtLS0tLS0tLS0tLS0tLS0tDQo+ID4gIGRyaXZlcnMvdXNiL2hvc3Qv
eGhjaS1tdGsuaCAgICAgfCAgMiAtLQ0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDE4IGRlbGV0aW9u
cygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktbXRrLXNj
aC5jIGIvZHJpdmVycy91c2IvaG9zdC94aGNpLW10ay1zY2guYw0KPiA+IGluZGV4IGMwNzQxMWQ5
YjE2Zi4uMTQ5YTBmNGE2ZWM0IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvdXNiL2hvc3QveGhj
aS1tdGstc2NoLmMNCj4gPiArKysgYi9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktbXRrLXNjaC5jDQo+
ID4gQEAgLTQ3MCwxMSArNDcwLDkgQEAgc3RhdGljIGludCBjaGVja19mc19idXNfYncoc3RydWN0
IG11M2hfc2NoX2VwX2luZm8gKnNjaF9lcCwgaW50IG9mZnNldCkNCj4gPiAgDQo+ID4gIHN0YXRp
YyBpbnQgY2hlY2tfc2NoX3R0KHN0cnVjdCBtdTNoX3NjaF9lcF9pbmZvICpzY2hfZXAsIHUzMiBv
ZmZzZXQpDQo+ID4gIHsNCj4gPiAtCXN0cnVjdCBtdTNoX3NjaF90dCAqdHQgPSBzY2hfZXAtPnNj
aF90dDsNCj4gPiAgCXUzMiBleHRyYV9jc19jb3VudDsNCj4gPiAgCXUzMiBzdGFydF9zcywgbGFz
dF9zczsNCj4gPiAgCXUzMiBzdGFydF9jcywgbGFzdF9jczsNCj4gPiAtCWludCBpOw0KPiA+ICAN
Cj4gPiAgCWlmICghc2NoX2VwLT5zY2hfdHQpDQo+ID4gIAkJcmV0dXJuIDA7DQo+ID4gQEAgLTQ5
MSwxMCArNDg5LDYgQEAgc3RhdGljIGludCBjaGVja19zY2hfdHQoc3RydWN0IG11M2hfc2NoX2Vw
X2luZm8gKnNjaF9lcCwgdTMyIG9mZnNldCkNCj4gPiAgCQlpZiAoIShzdGFydF9zcyA9PSA3IHx8
IGxhc3Rfc3MgPCA2KSkNCj4gPiAgCQkJcmV0dXJuIC1FU0NIX1NTX1k2Ow0KPiA+ICANCj4gPiAt
CQlmb3IgKGkgPSAwOyBpIDwgc2NoX2VwLT5jc19jb3VudDsgaSsrKQ0KPiA+IC0JCQlpZiAodGVz
dF9iaXQob2Zmc2V0ICsgaSwgdHQtPnNzX2JpdF9tYXApKQ0KPiA+IC0JCQkJcmV0dXJuIC1FU0NI
X1NTX09WRVJMQVA7DQo+ID4gLQ0KPiA+ICAJfSBlbHNlIHsNCj4gPiAgCQl1MzIgY3NfY291bnQg
PSBESVZfUk9VTkRfVVAoc2NoX2VwLT5tYXhwa3QsIEZTX1BBWUxPQURfTUFYKTsNCj4gPiAgDQo+
ID4gQEAgLTUyMSw5ICs1MTUsNiBAQCBzdGF0aWMgaW50IGNoZWNrX3NjaF90dChzdHJ1Y3QgbXUz
aF9zY2hfZXBfaW5mbyAqc2NoX2VwLCB1MzIgb2Zmc2V0KQ0KPiA+ICAJCWlmIChjc19jb3VudCA+
IDcpDQo+ID4gIAkJCWNzX2NvdW50ID0gNzsgLyogSFcgbGltaXQgKi8NCj4gPiAgDQo+ID4gLQkJ
aWYgKHRlc3RfYml0KG9mZnNldCwgdHQtPnNzX2JpdF9tYXApKQ0KPiA+IC0JCQlyZXR1cm4gLUVT
Q0hfU1NfT1ZFUkxBUDsNCj4gPiAtDQo+ID4gIAkJc2NoX2VwLT5jc19jb3VudCA9IGNzX2NvdW50
Ow0KPiA+ICAJCS8qIG9uZSBmb3Igc3MsIHRoZSBvdGhlciBmb3IgaWRsZSAqLw0KPiA+ICAJCXNj
aF9lcC0+bnVtX2J1ZGdldF9taWNyb2ZyYW1lcyA9IGNzX2NvdW50ICsgMjsNCj4gPiBAQCAtNTU4
LDEzICs1NDksNiBAQCBzdGF0aWMgdm9pZCB1cGRhdGVfc2NoX3R0KHN0cnVjdCBtdTNoX3NjaF9l
cF9pbmZvICpzY2hfZXAsIGJvb2wgdXNlZCkNCj4gPiAgCWZvciAoaSA9IDA7IGkgPCBudW1fZXNp
dDsgaSsrKSB7DQo+ID4gIAkJYmFzZSA9IHNjaF9lcC0+b2Zmc2V0ICsgaSAqIHNjaF9lcC0+ZXNp
dDsNCj4gPiAgDQo+ID4gLQkJZm9yIChqID0gMDsgaiA8IGJpdHM7IGorKykgew0KPiANCj4gTm93
IHRoYXQgYml0cyBpcyBubyBsb25nZXIgdXNlZCwgd2UgZ2V0IGEgYnVpbGQgd2FybmluZy4NCj4g
DQo+IENhbiB5b3UgZml4IHRoaXMgcGF0Y2ggYW5kIHJlc2VuZCBpdD8NCk9rLCB0aGFua3MNCg0K
PiANCj4gdGhhbmtzLA0KPiANCj4gZ3JlZyBrLWgNCg0K

