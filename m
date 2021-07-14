Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A17ED3C7F98
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 09:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238349AbhGNHwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 03:52:42 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:6865 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S238139AbhGNHwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 03:52:42 -0400
X-UUID: 0f1004db9e8a48768ff45d7776ca9fe5-20210714
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=2/O2pQ4HOC6eVJtd8Q1VhIMzPQ0HWNoStIpcHrk56vk=;
        b=i+4WAhn3U+4xtlazIPxo5WsoE8uIfn8ka8+MK/d3EUf958blfDVZht7t+4FyJguNc0JdsLXnKOfXQYLlgI8my12oLD1lF4hOQwXOhaKYkGllWUW1F0zA7HvIHrJYrs4bgya2g0naPHqI+uSSfjU7bEMz9H78jqXac5tiGvceXoA=;
X-UUID: 0f1004db9e8a48768ff45d7776ca9fe5-20210714
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <kewei.xu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2130778656; Wed, 14 Jul 2021 15:49:45 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 14 Jul
 2021 15:49:39 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 14 Jul 2021 15:49:39 +0800
Message-ID: <1626248978.8985.4.camel@mhfsdcap03>
Subject: Re: [PATCH V3 2/3] dt-bindings: i2c: add attribute
 default-timing-adjust
From:   Kewei Xu <kewei.xu@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     <wsa@the-dreams.de>, <bbrezillon@kernel.org>,
        <matthias.bgg@gmail.com>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <leilk.liu@mediatek.com>,
        <qii.wang@mediatek.com>, <liguo.zhang@mediatek.com>,
        <xinping.qian@mediatek.com>, <ot_daolong.zhu@mediatek.com>
Date:   Wed, 14 Jul 2021 15:49:38 +0800
In-Reply-To: <20210712205342.GA2469648@robh.at.kernel.org>
References: <1624271985-23591-1-git-send-email-kewei.xu@mediatek.com>
         <1624271985-23591-3-git-send-email-kewei.xu@mediatek.com>
         <20210712205342.GA2469648@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: F8EAEF2BEC1C758AA1F1F56F12303E5B8C124DDF5593E1195846295ACC508F7A2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTA3LTEyIGF0IDE0OjUzIC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gTW9uLCBKdW4gMjEsIDIwMjEgYXQgMDY6Mzk6NDRQTSArMDgwMCwga2V3ZWkueHVAbWVkaWF0
ZWsuY29tIHdyb3RlOg0KPiA+IEZyb206IEtld2VpIFh1IDxrZXdlaS54dUBtZWRpYXRlay5jb20+
DQo+ID4gDQo+ID4gQWRkIGF0dHJpYnV0ZSBkZWZhdWx0LXRpbWluZy1hZGp1c3QgZm9yIERULWJp
bmRpbmcgZG9jdW1lbnQuDQo+ID4gDQo+ID4gRml4ZXM6IGJlNWNlMGU5N2NjNyAoImkyYzogbWVk
aWF0ZWs6IEFkZCBpMmMgYWMtdGltaW5nIGFkanVzdCBzdXBwb3J0IikNCj4gDQo+IFlvdSB3YW50
IHRvIGZpeCBhIGtlcm5lbCBjaGFuZ2Ugd2l0aCBhIERUIGNoYW5nZT8gVGhhdCdzIG5vdCBhIA0K
PiBjb21wYXRpYmxlIGNoYW5nZSAoYW5kIEkgZ3Vlc3MgbmVpdGhlciB3YXMgdGhlIGtlcm5lbCBj
aGFuZ2UpLiBTb3VuZHMgDQo+IGxpa2UgdGhlIGFib3ZlIGNvbW1pdCBzaG91bGQgYmUgcmV2ZXJ0
ZWQgYW5kIHJldGhpbmsgaG93IHRvIGFkZCBhIG5ldyANCj4gZmVhdHVyZS4uLg0KPiANCj4gPiBT
aWduZWQtb2ZmLWJ5OiBLZXdlaSBYdSA8a2V3ZWkueHVAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0K
PiA+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaTJjL2kyYy1tdDY1eHgudHh0
IHwgMiArKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4g
ZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pMmMvaTJjLW10
NjV4eC50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaTJjL2kyYy1tdDY1
eHgudHh0DQo+ID4gaW5kZXggN2M0OTE1YmMuLjdiODBhMTEgMTAwNjQ0DQo+ID4gLS0tIGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2kyYy9pMmMtbXQ2NXh4LnR4dA0KPiA+ICsr
KyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pMmMvaTJjLW10NjV4eC50eHQN
Cj4gPiBAQCAtMzMsNiArMzMsOCBAQCBPcHRpb25hbCBwcm9wZXJ0aWVzOg0KPiA+ICAgIC0gbWVk
aWF0ZWssaGF2ZS1wbWljOiBwbGF0Zm9ybSBjYW4gY29udHJvbCBpMmMgZm9ybSBzcGVjaWFsIHBt
aWMgc2lkZS4NCj4gPiAgICAgIE9ubHkgbXQ2NTg5IGFuZCBtdDgxMzUgc3VwcG9ydCB0aGlzIGZl
YXR1cmUuDQo+ID4gICAgLSBtZWRpYXRlayx1c2UtcHVzaC1wdWxsOiBJTyBjb25maWcgdXNlIHB1
c2gtcHVsbCBtb2RlLg0KPiA+ICsgIC0gbWVkaWF0ZWssZGVmYXVsdC10aW1pbmctYWRqdXN0OiB1
c2UgZGVmYXVsdCB0aW1pbmcgY2FsY3VsYXRpb24sIG5vIHRpbWluZw0KPiA+ICsgICAgYWRqdXN0
bWVudC4NCj4gPiAgDQo+ID4gIEV4YW1wbGU6DQo+ID4gIA0KPiA+IC0tIA0KPiA+IDEuOS4xDQo+
ID4gDQo+ID4gDQoNCkhpIFJvYiwNCg0KSW4gdGhlIGNvbW1pdCBiZTVjZTBlOTdjYzcgKCJpMmM6
IG1lZGlhdGVrOiBBZGQgaTJjIGFjLXRpbWluZyBhZGp1c3QNCnN1cHBvcnQiKSwgdGhlIEkyQyB0
aW1pbmcgY2FsY3VsYXRpb24gaGFzIGJlZW4gcmV2aXNlZCB0byBzdXBwb3J0DQphYy10aW1pbmcg
YWRqdXN0bWVudC5CdXQgaW4gb3VyIGRlc2lnbiwgaXQgd2lsbCBtYWtlDQp0U1UsU1RBL3RIRCxT
VEEvdFNVLFNUTyBzaG9ydGVyIHdoZW4gdGhlIHNsYXZlIGRldmljZSBoYXZlDQpjbG9jay1zdHJl
dGNoaW5nIGZlYXR1cmUuDQpUaGVuIHdlIHVwbG9hZCB0aGUgY29tbWl0IGE4MGYyNDk0NWZjZiAo
ImkyYzogbWVkaWF0ZWs6IFVzZQ0Kc2NsX2ludF9kZWxheV9ucyB0byBjb21wZW5zYXRlIGNsb2Nr
LXN0cmV0Y2hpbmciKSB0byBzdXBwb3J0IGFkanVzdGluZw0KdFNVLFNUQS90SEQsU1RBL3RTVSxT
VE8gd2hlbiB0aGUgc2xhdmUgZGV2aWNlIGNsb2NrLXN0cmV0Y2hpbmcuIEJ1dCBpZg0KdGhlIHNs
YXZlIGRldmljZSBzdHJldGNoIHRoZSBTQ0wgbGluZSBmb3IgdG9vIGxvbmcgdGltZSwgb3VyIGRl
c2lnbg0Kc3RpbGwgY2Fubm90IG1ha2UgdFNVLFNUQS90SEQsU1RBL3RTVSxTVE8gbWVldCBzcGVj
Lg0KSG93ZXZlciBpbiB0aGUgb2xkIChkZWZhdWx0KSB0aW1pbmcgYWxnb3JpdGhtIGJlZm9yZSB0
aGUgY29tbWl0DQpiZTVjZTBlOTdjYzcgKCJpMmM6IG1lZGlhdGVrOiBBZGQgaTJjIGFjLXRpbWlu
ZyBhZGp1c3Qgc3VwcG9ydCIpLA0KdFNVLFNUQS90SEQsU1RBL3RTVSxTVE8gY2FuIG1lZXQgc3Bl
Yy4gU28gd2Ugd2FudCB0byBkZWZpbmUgYSBuZXcNCnNldHRpbmcgImRlZmF1bHQtYWRqdXN0LXRp
bWluZyIgZm9yIHVzaW5nIHRoZSBvbGQgKGRlZmF1bHQpIHRpbWluZw0KYWxnb3JpdGhtLg0KDQp0
aGFua3MNCmtld2VpDQo=

