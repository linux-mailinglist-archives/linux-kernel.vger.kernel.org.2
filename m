Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B716A3D9DC3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 08:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234303AbhG2Glv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 02:41:51 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:50178 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234079AbhG2Glu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 02:41:50 -0400
X-UUID: 13cdff71a09946a58e23e32ab7b71af5-20210729
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=OVLK3H5y5iwA63PL1InnEGJOkT0m5xgZgp18ut59SDc=;
        b=YvmL2EEDeBsnxfEGzPpgElS3DnAmPGxXUfZI+SajdwDwRufewozPnohsltjt2ur8a6ZwvLIgUrMTt5k753cjdqLT/0NWCKBkTgIKosKyImbv0860S6Fnve6QVbopskyGzxtDa++EiNRfefvgZIE7B0YaEUnMKQRSNWuOCN9c7R0=;
X-UUID: 13cdff71a09946a58e23e32ab7b71af5-20210729
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1376133388; Thu, 29 Jul 2021 14:41:44 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 29 Jul 2021 14:41:43 +0800
Received: from [10.17.3.153] (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 29 Jul 2021 14:41:42 +0800
Message-ID: <1627540902.13818.3.camel@mhfsdcap03>
Subject: Re: [PATCH v2 11/11] memory: mtk-smi: mt8195: Add initial setting
 for smi-larb
From:   Yong Wu <yong.wu@mediatek.com>
To:     Ikjoon Jang <ikjn@chromium.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Krzysztof Kozlowski" <krzk@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>
Date:   Thu, 29 Jul 2021 14:41:42 +0800
In-Reply-To: <1626935902.27875.7.camel@mhfsdcap03>
References: <20210715121209.31024-1-yong.wu@mediatek.com>
         <20210715121209.31024-12-yong.wu@mediatek.com>
         <CAATdQgAfo9oNR5=ogEottHajODngi1ahvKUnEOUczzjreYpPcQ@mail.gmail.com>
         <1626935902.27875.7.camel@mhfsdcap03>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSWtqb29uLA0KDQpKdXN0IGEgcGluZy4NCg0KT24gVGh1LCAyMDIxLTA3LTIyIGF0IDE0OjM4
ICswODAwLCBZb25nIFd1IHdyb3RlOg0KPiBPbiBXZWQsIDIwMjEtMDctMjEgYXQgMjE6NDAgKzA4
MDAsIElram9vbiBKYW5nIHdyb3RlOg0KPiA+IE9uIFRodSwgSnVsIDE1LCAyMDIxIGF0IDg6MjMg
UE0gWW9uZyBXdSA8eW9uZy53dUBtZWRpYXRlay5jb20+IHdyb3RlOg0KPiA+ID4NCj4gPiA+IFRv
IGltcHJvdmUgdGhlIHBlcmZvcm1hbmNlLCBXZSBhZGQgc29tZSBpbml0aWFsIHNldHRpbmcgZm9y
IHNtaSBsYXJicy4NCj4gPiA+IHRoZXJlIGFyZSB0d28gcGFydDoNCj4gPiA+IDEpLCBFYWNoIHBv
cnQgaGFzIHRoZSBzcGVjaWFsIG9zdGQob3V0c3RhbmRpbmcpIHZhbHVlIGluIGVhY2ggbGFyYi4N
Cj4gPiA+IDIpLCBUd28gZ2VuZXJhbCBzZXR0aW5nIGZvciBlYWNoIGxhcmIuDQo+ID4gPg0KPiA+
ID4gSW4gc29tZSBTb0MsIHRoaXMgc2V0dGluZyBtYXliZSBjaGFuZ2VkIGR5bmFtaWNhbGx5IGZv
ciBzb21lIHNwZWNpYWwgY2FzZQ0KPiA+ID4gbGlrZSA0SywgYW5kIHRoaXMgaW5pdGlhbCBzZXR0
aW5nIGlzIGVub3VnaCBpbiBtdDgxOTUuDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogWW9u
ZyBXdSA8eW9uZy53dUBtZWRpYXRlay5jb20+DQo+ID4gPiAtLS0NCj4gWy4uLl0NCj4gPiA+ICBz
dHJ1Y3QgbXRrX3NtaSB7DQo+ID4gPiBAQCAtMjEzLDEyICsyMjgsMjIgQEAgc3RhdGljIHZvaWQg
bXRrX3NtaV9sYXJiX2NvbmZpZ19wb3J0X210ODE3MyhzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ID4g
PiAgc3RhdGljIHZvaWQgbXRrX3NtaV9sYXJiX2NvbmZpZ19wb3J0X2dlbjJfZ2VuZXJhbChzdHJ1
Y3QgZGV2aWNlICpkZXYpDQo+ID4gPiAgew0KPiA+ID4gICAgICAgICBzdHJ1Y3QgbXRrX3NtaV9s
YXJiICpsYXJiID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ID4gPiAtICAgICAgIHUzMiByZWc7
DQo+ID4gPiArICAgICAgIHUzMiByZWcsIGZsYWdzX2dlbmVyYWwgPSBsYXJiLT5sYXJiX2dlbi0+
ZmxhZ3NfZ2VuZXJhbDsNCj4gPiA+ICsgICAgICAgY29uc3QgdTggKmxhcmJvc3RkID0gbGFyYi0+
bGFyYl9nZW4tPm9zdGRbbGFyYi0+bGFyYmlkXTsNCj4gPiA+ICAgICAgICAgaW50IGk7DQo+ID4g
Pg0KPiA+ID4gICAgICAgICBpZiAoQklUKGxhcmItPmxhcmJpZCkgJiBsYXJiLT5sYXJiX2dlbi0+
bGFyYl9kaXJlY3RfdG9fY29tbW9uX21hc2spDQo+ID4gPiAgICAgICAgICAgICAgICAgcmV0dXJu
Ow0KPiA+ID4NCj4gPiA+ICsgICAgICAgaWYgKE1US19TTUlfQ0FQUyhmbGFnc19nZW5lcmFsLCBN
VEtfU01JX0ZMQUdfTEFSQl9USFJUX0VOKSkNCj4gPiA+ICsgICAgICAgICAgICAgICB3cml0ZWxf
cmVsYXhlZChTTUlfTEFSQl9USFJUX0VOLCBsYXJiLT5iYXNlICsgU01JX0xBUkJfQ01EX1RIUlRf
Q09OKTsNCj4gPiA+ICsNCj4gPiA+ICsgICAgICAgaWYgKE1US19TTUlfQ0FQUyhmbGFnc19nZW5l
cmFsLCBNVEtfU01JX0ZMQUdfTEFSQl9TV19GTEFHKSkNCj4gPiA+ICsgICAgICAgICAgICAgICB3
cml0ZWxfcmVsYXhlZChTTUlfTEFSQl9TV19GTEFHXzEsIGxhcmItPmJhc2UgKyBTTUlfTEFSQl9T
V19GTEFHKTsNCj4gPiA+ICsNCj4gPiA+ICsgICAgICAgZm9yIChpID0gMDsgaSA8IFNNSV9MQVJC
X1BPUlRfTlJfTUFYICYmIGxhcmJvc3RkICYmICEhbGFyYm9zdGRbaV07IGkrKykNCj4gPiA+ICsg
ICAgICAgICAgICAgICB3cml0ZWxfcmVsYXhlZChsYXJib3N0ZFtpXSwgbGFyYi0+YmFzZSArIFNN
SV9MQVJCX09TVERMX1BPUlR4KGkpKTsNCj4gPiANCj4gPiBBbGwgb3RoZXIgbXRrIHBsYXRmb3Jt
J3MgbGFyYnMgaGF2ZSB0aGUgc2FtZSBmb3JtYXQgZm9yIFNNSV9MQVJCX09TVERMX1BPUlR4KCkN
Cj4gPiByZWdpc3RlcnMgYXQgdGhlIHNhbWUgb2Zmc2V0PyBvciBpcyB0aGlzIHVuaXF1ZSBmZWF0
dXJlIGZvciBtdDgxOTU/DQo+IA0KPiBBbGwgdGhlIG90aGVyIFBsYXRmb3JtJ3MgbGFyYnMgaGF2
ZSB0aGUgc2FtZSBmb3JtYXQgYXQgdGhlIHNhbWUgb2Zmc2V0Lg0KDQpJbiB0aGlzIGNhc2UsIERv
IHlvdSBoYXZlIHNvbWUgb3RoZXIgZnVydGhlciBjb21tZW50PyBJZiBubywgSSB3aWxsIGtlZXAN
CnRoZSBjdXJyZW50IHNvbHV0aW9uIGZvciB0aGlzLg0KDQpUaGFua3MuDQoNCj4gDQo+ID4gDQo+
ID4gPiArDQo+ID4gPiAgICAgICAgIGZvcl9lYWNoX3NldF9iaXQoaSwgKHVuc2lnbmVkIGxvbmcg
KilsYXJiLT5tbXUsIDMyKSB7DQo+ID4gPiAgICAgICAgICAgICAgICAgcmVnID0gcmVhZGxfcmVs
YXhlZChsYXJiLT5iYXNlICsgU01JX0xBUkJfTk9OU0VDX0NPTihpKSk7DQo+ID4gPiAgICAgICAg
ICAgICAgICAgcmVnIHw9IEZfTU1VX0VOOw0KPiA+ID4gQEAgLTIyNyw2ICsyNTIsNTEgQEAgc3Rh
dGljIHZvaWQgbXRrX3NtaV9sYXJiX2NvbmZpZ19wb3J0X2dlbjJfZ2VuZXJhbChzdHJ1Y3QgZGV2
aWNlICpkZXYpDQo+ID4gPiAgICAgICAgIH0NCj4gPiA+ICB9DQo+ID4gPg0KPiANCj4gWy4uLl0N
Cj4gDQoNCg==

