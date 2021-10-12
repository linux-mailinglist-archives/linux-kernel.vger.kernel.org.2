Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E99429B30
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 03:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhJLBzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 21:55:01 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:61793 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230331AbhJLBzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 21:55:00 -0400
X-UUID: 81e02e0e5e284b3ea8e6c931329358d0-20211012
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=uNQhKUvX6znaQDjpBxvpN1tm6No5kIlEywKVEAQ11v4=;
        b=N2sDzpN4FSxItgFkjFiL8w+RVbG+Wc/tn8HhWOWcSsszJq/fzguDVtqfFgfGHx/UQUYUc2I2OROVm1sIZml8aUD0LbtkpIj2Ze4VeVHVJ7yD9Yg5LCfnJcs8ZOqvmsMBflb+TQ4tS9V0zAhzgzDUaRURDX5uJcuJLKcpbWezdo4=;
X-UUID: 81e02e0e5e284b3ea8e6c931329358d0-20211012
Received: from mtkcas34.mediatek.inc [(172.27.6.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1240200781; Tue, 12 Oct 2021 09:52:56 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 12 Oct
 2021 09:52:49 +0800
Received: from mhfsdcap04 (10.17.3.154) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 12 Oct 2021 09:52:49 +0800
Message-ID: <0f620925d20a14c8f5f198241e4a136f9d48e206.camel@mediatek.com>
Subject: Re: [PATCH v1 1/4] dt-bindings: phy: Add binding for Mediatek
 MT8195 HDMI PHY
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Guillaume Ranquet <granquet@baylibre.com>,
        <chunkuang.hu@kernel.org>, <p.zabel@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Date:   Tue, 12 Oct 2021 09:52:52 +0800
In-Reply-To: <20210929094425.745-2-granquet@baylibre.com>
References: <20210929094425.745-1-granquet@baylibre.com>
         <20210929094425.745-2-granquet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: B45878DFBBAE411D00B78F558FF34CA1F8FC152D9CF13DAD6C17EDE2272C44542000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIxLTA5LTI5IGF0IDExOjQ0ICswMjAwLCBHdWlsbGF1bWUgUmFucXVldCB3cm90
ZToNCj4gQWRkIGJpbmRpbmdzIHRvIGRlc2NyaWJlIE1lZGlhdGVrIE1UODE5NSBIRE1JIFBIWQ0K
PiANCj4gU2lnbmVkLW9mZi1ieTogR3VpbGxhdW1lIFJhbnF1ZXQgPGdyYW5xdWV0QGJheWxpYnJl
LmNvbT4NCj4gLS0tDQo+ICAuLi4vcGh5L21lZGlhdGVrLG10azgxOTUtaGRtaS1waHkueWFtbCAg
ICAgICAgfCA3MA0KPiArKysrKysrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgNzAg
aW5zZXJ0aW9ucygrKQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+IERvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9waHkvbWVkaWF0ZWssbXRrODE5NS1oZG1pLXBoeS55YW1sDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9tZWRp
YXRlayxtdGs4MTk1LQ0KPiBoZG1pLXBoeS55YW1sDQo+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3BoeS9tZWRpYXRlayxtdGs4MTk1LWhkbWktDQo+IHBoeS55YW1sDQo+IG5l
dyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAwMDAwMDAuLjZiMzliYjhjOWRmZTcN
Cj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvcGh5L21lZGlhdGVrLG10azgxOTUtaGRtaS0NCj4gcGh5LnlhbWwNCj4gQEAgLTAsMCArMSw3
MCBAQA0KPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAtb25seSBPUiBCU0Qt
Mi1DbGF1c2UpDQo+ICsjIENvcHlyaWdodCAoYykgMjAyMCBNZWRpYVRlaw0KPiArJVlBTUwgMS4y
DQo+ICstLS0NCj4gKyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvcGh5L21lZGlh
dGVrLGhkbWktcGh5LnlhbWwjDQo+ICskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0
YS1zY2hlbWFzL2NvcmUueWFtbCMNCj4gKw0KPiArdGl0bGU6IE1lZGlhVGVrIEhpZ2ggRGVmaW5p
dGlvbiBNdWx0aW1lZGlhIEludGVyZmFjZSAoSERNSSkgUEhZDQo+IGJpbmRpbmcgZm9yIG10ODE5
NQ0KPiArDQo+ICttYWludGFpbmVyczoNCj4gKyAgLSBDaHVuLUt1YW5nIEh1IDxjaHVua3Vhbmcu
aHVAa2VybmVsLm9yZz4NCj4gKyAgLSBQaGlsaXBwIFphYmVsIDxwLnphYmVsQHBlbmd1dHJvbml4
LmRlPg0KPiArICAtIENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCj4g
Kw0KPiArZGVzY3JpcHRpb246IHwNCj4gKyAgVGhlIEhETUkgUEhZIHNlcmlhbGl6ZXMgdGhlIEhE
TUkgZW5jb2RlcidzIHRocmVlIGNoYW5uZWwgMTAtYml0DQo+IHBhcmFsbGVsDQo+ICsgIG91dHB1
dCBhbmQgZHJpdmVzIHRoZSBIRE1JIHBhZHMuDQo+ICsNCj4gK3Byb3BlcnRpZXM6DQo+ICsgICRu
b2RlbmFtZToNCj4gKyAgICBwYXR0ZXJuOiAiXmhkbWktcGh5QFswLTlhLWZdKyQiDQo+ICsNCj4g
KyAgY29tcGF0aWJsZToNCj4gKyAgICAtIGNvbnN0OiBtZWRpYXRlayxtdDgxOTUtaGRtaS1waHkN
Cj4gKw0KPiArICByZWc6DQo+ICsgICAgbWF4SXRlbXM6IDENCj4gKw0KPiArICBjbG9ja3M6DQo+
ICsgICAgaXRlbXM6DQo+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBQTEwgcmVmZXJlbmNlIGNsb2Nr
DQo+ICsNCj4gKyAgY2xvY2stbmFtZXM6DQo+ICsgICAgaXRlbXM6DQo+ICsgICAgICAtIGNvbnN0
OiBoZG1pX3h0YWxfc2VsDQpObyBuZWVkIHByZWZpeCAiaGRtaV8iLA0KQWZ0ZXIgeW91IG1lcmdl
IG10ODE5NS1oZG1pLXBoeSBkcml2ZXIgaW50byBwaHktbXRrLWhkbWkuYywgdGhpcw0KYmluZGlu
ZyB3aWxsIGFsc28gYmUgbWVyZ2VkIGludG8gbWVkaWF0ZWssaGRtaS1waHkueWFtbCBhcyBzdWdn
ZXN0ZWQgYnkNCkNodW4tS3VhbmcuDQoNClRoYW5rcyBhIGxvdA0KIA0KPiArDQo+ICsgIGNsb2Nr
LW91dHB1dC1uYW1lczoNCj4gKyAgICBpdGVtczoNCj4gKyAgICAgIC0gY29uc3Q6IGhkbWlfdHhw
bGwNCj4gKw0KPiArICAiI3BoeS1jZWxscyI6DQo+ICsgICAgY29uc3Q6IDANCj4gKw0KPiArICAi
I2Nsb2NrLWNlbGxzIjoNCj4gKyAgICBjb25zdDogMA0KPiArDQo+ICtyZXF1aXJlZDoNCj4gKyAg
LSBjb21wYXRpYmxlDQo+ICsgIC0gcmVnDQo+ICsgIC0gY2xvY2tzDQo+ICsgIC0gY2xvY2stbmFt
ZXMNCj4gKyAgLSBjbG9jay1vdXRwdXQtbmFtZXMNCj4gKyAgLSAiI3BoeS1jZWxscyINCj4gKyAg
LSAiI2Nsb2NrLWNlbGxzIg0KPiArDQo+ICthZGRpdGlvbmFsUHJvcGVydGllczogZmFsc2UNCj4g
Kw0KPiArZXhhbXBsZXM6DQo+ICsgIC0gfA0KPiArICAgIGhkbWlfcGh5OiBoZG1pLXBoeUAxMWQ1
ZjAwMCB7DQo+ICsgICAgICAgIGNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTk1LWhkbWktcGh5
IjsNCj4gKyAgICAgICAgcmVnID0gPDAgMHgxMWQ1ZjAwMCAwIDB4MTAwPjsNCj4gKyAgICAgICAg
Y2xvY2tzID0gPCZ0b3Bja2dlbiA3Nz47DQo+ICsgICAgICAgIGNsb2NrLW5hbWVzID0gImhkbWlf
eHRhbF9zZWwiOw0KPiArICAgICAgICBjbG9jay1vdXRwdXQtbmFtZXMgPSAiaGRtaV90eHBsbCI7
DQo+ICsgICAgICAgICNjbG9jay1jZWxscyA9IDwwPjsNCj4gKyAgICAgICAgI3BoeS1jZWxscyA9
IDwwPjsNCj4gKyAgICB9Ow0KPiArDQo+ICsuLi4NCg==

