Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEE273D1E5E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 08:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbhGVF56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 01:57:58 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:40904 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229931AbhGVF5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 01:57:53 -0400
X-UUID: ea3b0ad1d7ae491e9e3dbd38de65456e-20210722
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=E0/21i/rjqYJSvlRFf3hf7vSNWScyQPpeAG8uBlbP3o=;
        b=AzDdA2JmY3JXcQjf4KRlTgeOVef8J0NRQ3sCNkds955AhMpRPyKxdWAhlLsv2RR1Soao421TCNDa6m/3HxVde2JN8NhwO/j2H6bjU8xgSbLame2sHJLVCQlfJ90zMzYmDqDsl4y9RRKw383zRBumVdSWM6JEaeqUSsvGykRM+To=;
X-UUID: ea3b0ad1d7ae491e9e3dbd38de65456e-20210722
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 715036884; Thu, 22 Jul 2021 14:38:25 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs07n1.mediatek.inc
 (172.21.101.16) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 22 Jul
 2021 14:38:24 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 22 Jul 2021 14:38:22 +0800
Message-ID: <1626935902.27875.7.camel@mhfsdcap03>
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
Date:   Thu, 22 Jul 2021 14:38:22 +0800
In-Reply-To: <CAATdQgAfo9oNR5=ogEottHajODngi1ahvKUnEOUczzjreYpPcQ@mail.gmail.com>
References: <20210715121209.31024-1-yong.wu@mediatek.com>
         <20210715121209.31024-12-yong.wu@mediatek.com>
         <CAATdQgAfo9oNR5=ogEottHajODngi1ahvKUnEOUczzjreYpPcQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIxLTA3LTIxIGF0IDIxOjQwICswODAwLCBJa2pvb24gSmFuZyB3cm90ZToNCj4g
T24gVGh1LCBKdWwgMTUsIDIwMjEgYXQgODoyMyBQTSBZb25nIFd1IDx5b25nLnd1QG1lZGlhdGVr
LmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBUbyBpbXByb3ZlIHRoZSBwZXJmb3JtYW5jZSwgV2UgYWRk
IHNvbWUgaW5pdGlhbCBzZXR0aW5nIGZvciBzbWkgbGFyYnMuDQo+ID4gdGhlcmUgYXJlIHR3byBw
YXJ0Og0KPiA+IDEpLCBFYWNoIHBvcnQgaGFzIHRoZSBzcGVjaWFsIG9zdGQob3V0c3RhbmRpbmcp
IHZhbHVlIGluIGVhY2ggbGFyYi4NCj4gPiAyKSwgVHdvIGdlbmVyYWwgc2V0dGluZyBmb3IgZWFj
aCBsYXJiLg0KPiA+DQo+ID4gSW4gc29tZSBTb0MsIHRoaXMgc2V0dGluZyBtYXliZSBjaGFuZ2Vk
IGR5bmFtaWNhbGx5IGZvciBzb21lIHNwZWNpYWwgY2FzZQ0KPiA+IGxpa2UgNEssIGFuZCB0aGlz
IGluaXRpYWwgc2V0dGluZyBpcyBlbm91Z2ggaW4gbXQ4MTk1Lg0KPiA+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogWW9uZyBXdSA8eW9uZy53dUBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQpbLi4uXQ0KPiA+
ICBzdHJ1Y3QgbXRrX3NtaSB7DQo+ID4gQEAgLTIxMywxMiArMjI4LDIyIEBAIHN0YXRpYyB2b2lk
IG10a19zbWlfbGFyYl9jb25maWdfcG9ydF9tdDgxNzMoc3RydWN0IGRldmljZSAqZGV2KQ0KPiA+
ICBzdGF0aWMgdm9pZCBtdGtfc21pX2xhcmJfY29uZmlnX3BvcnRfZ2VuMl9nZW5lcmFsKHN0cnVj
dCBkZXZpY2UgKmRldikNCj4gPiAgew0KPiA+ICAgICAgICAgc3RydWN0IG10a19zbWlfbGFyYiAq
bGFyYiA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiA+IC0gICAgICAgdTMyIHJlZzsNCj4gPiAr
ICAgICAgIHUzMiByZWcsIGZsYWdzX2dlbmVyYWwgPSBsYXJiLT5sYXJiX2dlbi0+ZmxhZ3NfZ2Vu
ZXJhbDsNCj4gPiArICAgICAgIGNvbnN0IHU4ICpsYXJib3N0ZCA9IGxhcmItPmxhcmJfZ2VuLT5v
c3RkW2xhcmItPmxhcmJpZF07DQo+ID4gICAgICAgICBpbnQgaTsNCj4gPg0KPiA+ICAgICAgICAg
aWYgKEJJVChsYXJiLT5sYXJiaWQpICYgbGFyYi0+bGFyYl9nZW4tPmxhcmJfZGlyZWN0X3RvX2Nv
bW1vbl9tYXNrKQ0KPiA+ICAgICAgICAgICAgICAgICByZXR1cm47DQo+ID4NCj4gPiArICAgICAg
IGlmIChNVEtfU01JX0NBUFMoZmxhZ3NfZ2VuZXJhbCwgTVRLX1NNSV9GTEFHX0xBUkJfVEhSVF9F
TikpDQo+ID4gKyAgICAgICAgICAgICAgIHdyaXRlbF9yZWxheGVkKFNNSV9MQVJCX1RIUlRfRU4s
IGxhcmItPmJhc2UgKyBTTUlfTEFSQl9DTURfVEhSVF9DT04pOw0KPiA+ICsNCj4gPiArICAgICAg
IGlmIChNVEtfU01JX0NBUFMoZmxhZ3NfZ2VuZXJhbCwgTVRLX1NNSV9GTEFHX0xBUkJfU1dfRkxB
RykpDQo+ID4gKyAgICAgICAgICAgICAgIHdyaXRlbF9yZWxheGVkKFNNSV9MQVJCX1NXX0ZMQUdf
MSwgbGFyYi0+YmFzZSArIFNNSV9MQVJCX1NXX0ZMQUcpOw0KPiA+ICsNCj4gPiArICAgICAgIGZv
ciAoaSA9IDA7IGkgPCBTTUlfTEFSQl9QT1JUX05SX01BWCAmJiBsYXJib3N0ZCAmJiAhIWxhcmJv
c3RkW2ldOyBpKyspDQo+ID4gKyAgICAgICAgICAgICAgIHdyaXRlbF9yZWxheGVkKGxhcmJvc3Rk
W2ldLCBsYXJiLT5iYXNlICsgU01JX0xBUkJfT1NURExfUE9SVHgoaSkpOw0KPiANCj4gQWxsIG90
aGVyIG10ayBwbGF0Zm9ybSdzIGxhcmJzIGhhdmUgdGhlIHNhbWUgZm9ybWF0IGZvciBTTUlfTEFS
Ql9PU1RETF9QT1JUeCgpDQo+IHJlZ2lzdGVycyBhdCB0aGUgc2FtZSBvZmZzZXQ/IG9yIGlzIHRo
aXMgdW5pcXVlIGZlYXR1cmUgZm9yIG10ODE5NT8NCg0KQWxsIHRoZSBvdGhlciBQbGF0Zm9ybSdz
IGxhcmJzIGhhdmUgdGhlIHNhbWUgZm9ybWF0IGF0IHRoZSBzYW1lIG9mZnNldC4NCg0KPiANCj4g
PiArDQo+ID4gICAgICAgICBmb3JfZWFjaF9zZXRfYml0KGksICh1bnNpZ25lZCBsb25nICopbGFy
Yi0+bW11LCAzMikgew0KPiA+ICAgICAgICAgICAgICAgICByZWcgPSByZWFkbF9yZWxheGVkKGxh
cmItPmJhc2UgKyBTTUlfTEFSQl9OT05TRUNfQ09OKGkpKTsNCj4gPiAgICAgICAgICAgICAgICAg
cmVnIHw9IEZfTU1VX0VOOw0KPiA+IEBAIC0yMjcsNiArMjUyLDUxIEBAIHN0YXRpYyB2b2lkIG10
a19zbWlfbGFyYl9jb25maWdfcG9ydF9nZW4yX2dlbmVyYWwoc3RydWN0IGRldmljZSAqZGV2KQ0K
PiA+ICAgICAgICAgfQ0KPiA+ICB9DQo+ID4NCg0KWy4uLl0NCg0K

