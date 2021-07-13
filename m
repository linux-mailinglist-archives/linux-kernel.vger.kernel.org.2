Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE713C6CCA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 11:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234841AbhGMJDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 05:03:37 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:59226 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234121AbhGMJDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 05:03:36 -0400
X-UUID: f648231f35e343cd92fe1bac49f99370-20210713
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=/SkvQQ3+rtq2S0/tdyj0Z0yx4+LQp8I/gV8vayHB1eA=;
        b=eJeCnaVA92IGHPSnF4fRU+uuPIXGaxtF5vFMGURAcc/jXq0+2SDrAZP4SGsRcPmL8NZBqrS/GDtLMoFSFLv7q/NXzkM/mqHx4nvYKq94h1faSNM3SIOQkzjjk2tji5eH4S1LVq3RGdRgvk/Af0xx7D2zVDCI89YxU4uzn3J+GVc=;
X-UUID: f648231f35e343cd92fe1bac49f99370-20210713
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 777364225; Tue, 13 Jul 2021 17:00:41 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 13 Jul
 2021 17:00:39 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 13 Jul 2021 17:00:38 +0800
Message-ID: <1626166838.29490.4.camel@mhfsdcap03>
Subject: Re: [PATCH v2 02/13] dt-bindings: usb: mtu3: add optional property
 to disable usb2 ports
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Date:   Tue, 13 Jul 2021 17:00:38 +0800
In-Reply-To: <20210712190809.GA2310371@robh.at.kernel.org>
References: <1624008558-16949-1-git-send-email-chunfeng.yun@mediatek.com>
         <1624008558-16949-3-git-send-email-chunfeng.yun@mediatek.com>
         <20210712190809.GA2310371@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 1F30D6F3E0CBFBFE6BBF7E6E74BA7C17CB540E6A07D0FFC39EB0D4C6EC885D8A2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTA3LTEyIGF0IDEzOjA4IC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gRnJpLCBKdW4gMTgsIDIwMjEgYXQgMDU6Mjk6MDdQTSArMDgwMCwgQ2h1bmZlbmcgWXVuIHdy
b3RlOg0KPiA+IEFkZCBzdXBwb3J0IHRvIGRpc2FibGUgc3BlY2lmaWMgdXNiMiBob3N0IHBvcnRz
LCBpdCdzIHVzZWZ1bCB3aGVuDQo+ID4gYSB1c2IyIHBvcnQgaXMgZGlzYWJsZWQgb24gc29tZSBw
bGF0Zm9ybXMsIGJ1dCBlbmFibGVkIG9uIG90aGVycyBmb3INCj4gPiB0aGUgc2FtZSBTb0MsIGFu
b3RoZXIgY2FzZSBpcyB0aGF0IHRoZSBkaWZmZXJlbnQgcGFja2FnZSBtYXkgc3VwcG9ydA0KPiA+
IGRpZmZlcmVudCBudW1iZXIgb2YgcG9ydHMuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQ2h1
bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+IHYyOiBu
byBjaGFuZ2VzDQo+ID4gLS0tDQo+ID4gIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy91c2IvbWVkaWF0ZWssbXR1My55YW1sIHwgNiArKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDYgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvdXNiL21lZGlhdGVrLG10dTMueWFtbCBiL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWssbXR1My55YW1sDQo+ID4gaW5kZXggMmNh
YzdhODdjZTM2Li4zZTZmMjc1MGY0OGQgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9tZWRpYXRlayxtdHUzLnlhbWwNCj4gPiArKysgYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL21lZGlhdGVrLG10dTMueWFtbA0KPiA+
IEBAIC0xNjYsNiArMTY2LDEyIEBAIHByb3BlcnRpZXM6DQo+ID4gICAgICBkZXNjcmlwdGlvbjog
VGhlIG1hc2sgdG8gZGlzYWJsZSB1M3BvcnRzLCBiaXQwIGZvciB1M3BvcnQwLA0KPiA+ICAgICAg
ICBiaXQxIGZvciB1M3BvcnQxLCAuLi4gZXRjDQo+ID4gIA0KPiA+ICsgIG1lZGlhdGVrLHUycC1k
aXMtbXNrOg0KPiANCj4gSnVzdCBzcGVsbCBvdXQgJ21hc2snLg0KVGhlcmUgaXMgYWxyZWFkeSBh
IHByb3BlcnR5ICJtZWRpYXRlayx1M3AtZGlzLW1zayIsIHByZWZlciB0byB1c2UgdGhlDQpzYW1l
IGZvcm1hdCwgdGhhbmtzDQoNCj4gDQo+ID4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1s
Iy9kZWZpbml0aW9ucy91aW50MzINCj4gPiArICAgIGRlc2NyaXB0aW9uOiBUaGUgbWFzayB0byBk
aXNhYmxlIHUycG9ydHMsIGJpdDAgZm9yIHUycG9ydDAsDQo+ID4gKyAgICAgIGJpdDEgZm9yIHUy
cG9ydDEsIC4uLiBldGM7IGJ1dCBjYW4ndCBkaXNhYmxlIHUycG9ydDAgaWYgZHVhbCByb2xlIG1v
ZGUNCj4gPiArICAgICAgaXMgZW5hYmxlZCwgc28gd2lsbCBiZSBza2lwcGVkIGluIHRoaXMgY2Fz
ZS4NCj4gPiArDQo+ID4gICMgUmVxdWlyZWQgY2hpbGQgbm9kZSB3aGVuIHN1cHBvcnQgZHVhbC1y
b2xlDQo+ID4gIHBhdHRlcm5Qcm9wZXJ0aWVzOg0KPiA+ICAgICJedXNiQFswLTlhLWZdKyQiOg0K
PiA+IC0tIA0KPiA+IDIuMTguMA0KPiA+IA0KPiA+IA0KDQo=

