Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E67A444F201
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 08:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235579AbhKMHar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 02:30:47 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:50496 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229487AbhKMHap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 02:30:45 -0500
X-UUID: 664ce49ed7ce428b9d1e858b73644acb-20211113
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=3CcmwmG9wnA+1Z3HaoflW55pO15Lyi+1HRNgCZzfSno=;
        b=BkpEq3RQi0clhC/VK0HY5AxGgYBbPtuKKeHx5qcx07kG9v+PjH5hRp22F3IfnQmmaEY//PqQs2dO1KAO62NTOE7yaZ2eHyu2BELGHHXBtzYxj8mbayo9wfCAbA0OLLJ0uqij1CpMoFgkJC1lgBWKYG/q6G02bvZIdko8KtXbHio=;
X-UUID: 664ce49ed7ce428b9d1e858b73644acb-20211113
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1011733850; Sat, 13 Nov 2021 15:27:48 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Sat, 13 Nov 2021 15:27:46 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 13 Nov 2021 15:27:46 +0800
Message-ID: <24035c4a5cd6f33fded4fb30e2f153013663c403.camel@mediatek.com>
Subject: Re: [PATCH 1/3] dt-bindings: usb: mtk-xhci: add support ip-sleep
 for mt8195
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Date:   Sat, 13 Nov 2021 15:27:46 +0800
In-Reply-To: <YY6dAT3OHbu0CO/J@robh.at.kernel.org>
References: <20211102060049.1843-1-chunfeng.yun@mediatek.com>
         <YY6dAT3OHbu0CO/J@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIxLTExLTEyIGF0IDEwOjU3IC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gVHVlLCBOb3YgMDIsIDIwMjEgYXQgMDI6MDA6NDdQTSArMDgwMCwgQ2h1bmZlbmcgWXVuIHdy
b3RlOg0KPiA+IFRoZXJlIGFyZSA0IFVTQiBjb250cm9sbGVycyBvbiBNVDgxOTUsIGVhY2ggY29u
dHJvbGxlcidzIHdha2V1cA0KPiA+IGNvbnRyb2wgaXMNCj4gPiBkaWZmZXJlbnQsIGFkZCBzb21l
IHNwaWNpZmljIHZlcnNpb25zIGZvciB0aGVtLg0KPiANCj4gc3BlY2lmaWMNCldpbGwgZml4IGl0
LCB0aGFua3MNCg0KPiANCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNo
dW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3VzYi9tZWRpYXRlayxtdGsteGhjaS55YW1sICAgICAgICAgIHwgNg0KPiA+ICsrKysr
LQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+
ID4gDQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91
c2IvbWVkaWF0ZWssbXRrLQ0KPiA+IHhoY2kueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWssbXRrLQ0KPiA+IHhoY2kueWFtbA0KPiA+IGluZGV4IDEx
ZjdiYWNkNGUyYi4uNDFlZmI1MTYzOGQxIDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWssbXRrLXhoY2kueWFtbA0KPiA+ICsrKyBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWssbXRrLXhoY2ku
eWFtbA0KPiA+IEBAIC0xNDYsNyArMTQ2LDExIEBAIHByb3BlcnRpZXM6DQo+ID4gICAgICAgICAg
ICAgIDIgLSB1c2VkIGJ5IG10MjcxMiBldGMsIHJldmlzaW9uIDIgZm9sbG93aW5nIElQTSBydWxl
Ow0KPiA+ICAgICAgICAgICAgICAxMDEgLSB1c2VkIGJ5IG10ODE4Mywgc3BlY2lmaWMgMS4wMTsN
Cj4gPiAgICAgICAgICAgICAgMTAyIC0gdXNlZCBieSBtdDgxOTIsIHNwZWNpZmljIDEuMDI7DQo+
ID4gLSAgICAgICAgICBlbnVtOiBbMSwgMiwgMTAxLCAxMDJdDQo+ID4gKyAgICAgICAgICAgIDEw
MyAtIHVzZWQgYnkgbXQ4MTk1LCBJUDAsIHNwZWNpZmljIDEuMDM7DQo+ID4gKyAgICAgICAgICAg
IDEwNCAtIHVzZWQgYnkgbXQ4MTk1LCBJUDEsIHNwZWNpZmljIDEuMDQ7DQo+ID4gKyAgICAgICAg
ICAgIDEwNSAtIHVzZWQgYnkgbXQ4MTk1LCBJUDIsIHNwZWNpZmljIDEuMDU7DQo+ID4gKyAgICAg
ICAgICAgIDEwNiAtIHVzZWQgYnkgbXQ4MTk1LCBJUDMsIHNwZWNpZmljIDEuMDY7DQo+ID4gKyAg
ICAgICAgICBlbnVtOiBbMSwgMiwgMTAxLCAxMDIsIDEwMywgMTA0LCAxMDUsIDEwNl0NCj4gPiAg
DQo+ID4gICAgbWVkaWF0ZWssdTNwLWRpcy1tc2s6DQo+ID4gICAgICAkcmVmOiAvc2NoZW1hcy90
eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50MzINCj4gPiAtLSANCj4gPiAyLjE4LjANCj4gPiAN
Cj4gPiANCg==

