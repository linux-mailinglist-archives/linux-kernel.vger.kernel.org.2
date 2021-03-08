Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 584513305B9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 02:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233585AbhCHB64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 20:58:56 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:55443 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232256AbhCHB6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 20:58:23 -0500
X-UUID: d60b31b2753342e0b1392b49f9dfce48-20210308
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=cAEtYNvirduPPDmsHCYYxu63PGqbUKC1f0wMKO0QDrs=;
        b=REl9V3YbBf/A4lRXnkgcZqm+QVDdesTHipweNyXp2EXxBxQmM6R0PEqwA2apt66PAJLfST7iSUURsBdJDEjgH5NVFej8gwkHYLOkOnfv50fVDMRlf2UNuRceWY//zmlEQmSzRVsoHAfllrBuDKkvuSO2uWAtkScsBL85+9Es7P0=;
X-UUID: d60b31b2753342e0b1392b49f9dfce48-20210308
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1846003065; Mon, 08 Mar 2021 09:58:04 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs06n1.mediatek.inc
 (172.21.101.129) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 8 Mar
 2021 09:57:46 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 8 Mar 2021 09:57:43 +0800
Message-ID: <1615168663.32109.5.camel@mhfsdcap03>
Subject: Re: [PATCH 03/17] usb: xhci-mtk: get the microframe boundary for
 ESIT
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ikjoon Jang <ikjn@chromium.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Date:   Mon, 8 Mar 2021 09:57:43 +0800
In-Reply-To: <cfa6dccb-d784-06fd-e5bc-0b53d105b7f6@gmail.com>
References: <1614934975-15188-1-git-send-email-chunfeng.yun@mediatek.com>
         <1614934975-15188-3-git-send-email-chunfeng.yun@mediatek.com>
         <cfa6dccb-d784-06fd-e5bc-0b53d105b7f6@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIxLTAzLTA1IGF0IDEyOjEzICswMzAwLCBTZXJnZWkgU2h0eWx5b3Ygd3JvdGU6
DQo+IEhlbGxvIQ0KPiANCj4gT24gMDUuMDMuMjAyMSAxMjowMiwgQ2h1bmZlbmcgWXVuIHdyb3Rl
Og0KPiANCj4gPiBUdW5lIHRoZSBib3VuZGFyeSBmb3IgRlMvTFMgRVNJVCBkdWUgdG8gQ1M6DQo+
ID4gRm9yIElTT0Mgb3V0LWVwLCB0aGUgY29udHJvbGxlciBzdGFydHMgdHJhbnNmZXIgZGF0YSBh
ZnRlcg0KPiA+IHRoZSBmaXJzdCBTUzsgZm9yIG90aGVycywgdGhlIGRhdGEgaXMgYWxyZWFkeSB0
cmFuc2ZlcmVkDQo+IA0KPiAgICAgVHJhbnNmZXJyZWQuDQpPaw0KPiANCj4gPiBiZWZvcmUgdGhl
IGxhc3QgQ1MuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcgWXVuIDxjaHVuZmVu
Zy55dW5AbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy91c2IvaG9zdC94aGNp
LW10ay1zY2guYyB8IDI0ICsrKysrKysrKysrKysrKysrKystLS0tLQ0KPiA+ICAgMSBmaWxlIGNo
YW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdXNiL2hvc3QveGhjaS1tdGstc2NoLmMgYi9kcml2ZXJzL3VzYi9ob3N0
L3hoY2ktbXRrLXNjaC5jDQo+ID4gaW5kZXggODk1MGQxZjEwYTdmLi5lM2IxOGRmY2E4NzQgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy91c2IvaG9zdC94aGNpLW10ay1zY2guYw0KPiA+ICsrKyBi
L2RyaXZlcnMvdXNiL2hvc3QveGhjaS1tdGstc2NoLmMNCj4gPiBAQCAtNTEzLDIyICs1MTMsMzUg
QEAgc3RhdGljIHZvaWQgdXBkYXRlX3NjaF90dChzdHJ1Y3QgdXNiX2RldmljZSAqdWRldiwNCj4g
PiAgIAkJbGlzdF9kZWwoJnNjaF9lcC0+dHRfZW5kcG9pbnQpOw0KPiA+ICAgfQ0KPiA+ICAgDQo+
ID4gK3N0YXRpYyB1MzIgZ2V0X2VzaXRfYm91bmRhcnkoc3RydWN0IG11M2hfc2NoX2VwX2luZm8g
KnNjaF9lcCkNCj4gPiArew0KPiA+ICsJdTMyIGJvdW5kYXJ5ID0gc2NoX2VwLT5lc2l0Ow0KPiA+
ICsNCj4gPiArCWlmIChzY2hfZXAtPnNjaF90dCkgeyAvKiBMUy9GUyB3aXRoIFRUICovDQo+ID4g
KwkJLyogdHVuZSBmb3IgQ1MgKi8NCj4gPiArCQlpZiAoc2NoX2VwLT5lcF90eXBlICE9IElTT0Nf
T1VUX0VQKQ0KPiA+ICsJCQlib3VuZGFyeSArPSAxOw0KPiANCj4gICAgIFdoeSBub3Q6DQo+IA0K
PiAJCQlib3VuZGFyeSsrOw0KRm9yZ290IGl0LCBpdCdzIG1vZGlmaWVkIGZyb20gImJvdW5kYXJ5
ID0gc2NoX2VwLT5lc2l0ICsgMTsiDQoNClRoYW5rcw0KPiANCj4gPiArCQllbHNlIGlmIChib3Vu
ZGFyeSA+IDEpIC8qIG5vcm1hbGx5IGVzaXQgPj0gOCBmb3IgRlMvTFMgKi8NCj4gPiArCQkJYm91
bmRhcnkgLT0gMTsNCj4gDQo+IAkJCWJvdW5kYXJ5LS07DQo+IA0KPiBbLi4uXQ0KPiANCj4gTUJS
LCBTZXJnZWkNCg0K

