Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB8063C336E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 09:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbhGJHJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 03:09:24 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:52736 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232331AbhGJHJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 03:09:22 -0400
X-UUID: e9004791e0bc43a3a7e43f760635d3e5-20210710
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=8dsRT+CtBAF8IManycrdROXqXDtH6eBTTgK4DAfMq2Y=;
        b=Mij4zjC13V0npJDdhfDnBcfDiVFuCu50V0/pSXgySSuOdG7F5NHDGdeVyFYmpnVHU9QvtAHXeSy1u4G4JUAvmUUscF3SlbQk3A5iopu+B6p1X143DajuH27lFSvyDYsTZX7LGyXoaMh7NqpbW0+oMhJnnBCjD/1Z8GtDC0wRxJU=;
X-UUID: e9004791e0bc43a3a7e43f760635d3e5-20210710
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1662909607; Sat, 10 Jul 2021 15:06:33 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 10 Jul 2021 15:06:32 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 10 Jul 2021 15:06:32 +0800
Message-ID: <5d3266c07bcde1b32d21d69445696126e7476b9d.camel@mediatek.com>
Subject: Re: [PATCH v1 08/17] drm/mediatek: Add component_del in OVL remove
 function
From:   Jason-JH Lin <jason-jh.lin@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>
CC:     <chunkuang.hu@kernel.org>, <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <fshao@google.com>, <nancy.lin@mediatek.com>,
        <singo.chang@mediatek.com>
Date:   Sat, 10 Jul 2021 15:06:32 +0800
In-Reply-To: <1625634728.7824.17.camel@mtksdaap41>
References: <20210707041249.29816-1-jason-jh.lin@mediatek.com>
         <20210707041249.29816-9-jason-jh.lin@mediatek.com>
         <1625634728.7824.17.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIxLTA3LTA3IGF0IDEzOjEyICswODAwLCBDSyBIdSB3cm90ZToNCj4gSGksIEph
c29uOg0KPiANCj4gT24gV2VkLCAyMDIxLTA3LTA3IGF0IDEyOjEyICswODAwLCBqYXNvbi1qaC5s
aW4gd3JvdGU6DQo+ID4gQWRkIGNvbXBvbmVudF9kZWwgaW4gT1ZMIHJlbW92ZSBmdW5jdGlvbi4N
Cj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBqYXNvbi1qaC5saW4gPGphc29uLWpoLmxpbkBtZWRp
YXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlz
cF9vdmwuYyB8IDMgKystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kaXNwX292bC5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rp
c3Bfb3ZsLmMNCj4gPiBpbmRleCA5OWMzOTQ4NzAyNmQuLjc1MDRlODZiMTY3YSAxMDA2NDQNCj4g
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4gPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4gPiBAQCAtMTU4LDcg
KzE1OCw2IEBAIHZvaWQgbXRrX292bF9zdG9wKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gPiAgCQly
ZWcgPSByZWcgJiB+T1ZMX0xBWUVSX1NNSV9JRF9FTjsNCj4gPiAgCQl3cml0ZWxfcmVsYXhlZChy
ZWcsIG92bC0+cmVncyArDQo+ID4gRElTUF9SRUdfT1ZMX0RBVEFQQVRIX0NPTik7DQo+ID4gIAl9
DQo+ID4gLQ0KPiANCj4gVGhpcyBtb2RpZmljYXRpb24gaXMgbm90IHJlbGF0ZWQgdG8gdGhpcyBw
YXRjaCwgc28gbW92ZSBvdXQgb2YgdGhpcw0KPiBwYXRjaC4NCj4gDQpIaSBDSywNCg0KT0ssIEkn
bGwgcmVtb3ZlIHRoaXMgcGF0Y2ggYXQgdGhlIG5leHQgdmVyc2lvbi4NCg0KUmVnYXJkLA0KSmFz
b24tSkguTGluDQo+ID4gIH0NCj4gPiAgDQo+ID4gIHZvaWQgbXRrX292bF9jb25maWcoc3RydWN0
IGRldmljZSAqZGV2LCB1bnNpZ25lZCBpbnQgdywNCj4gPiBAQCAtNDI0LDYgKzQyMyw4IEBAIHN0
YXRpYyBpbnQgbXRrX2Rpc3Bfb3ZsX3Byb2JlKHN0cnVjdA0KPiA+IHBsYXRmb3JtX2RldmljZSAq
cGRldikNCj4gPiAgDQo+ID4gIHN0YXRpYyBpbnQgbXRrX2Rpc3Bfb3ZsX3JlbW92ZShzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICB7DQo+ID4gKwljb21wb25lbnRfZGVsKCZwZGV2
LT5kZXYsICZtdGtfZGlzcF9vdmxfY29tcG9uZW50X29wcyk7DQo+ID4gKw0KPiANCj4gVGhpcyBp
cyBhIGZpeC11cCBvZiBwYXRjaCBbMV0uIENoYW5nZSB0aGlzIHBhdGNoIHRvIGZpeCBhbGwgc3Vi
DQo+IGRyaXZlcnMsDQo+IGFkZCBGaXhlcyB0YWcsIGFuZCBtb3ZlIHRoaXMgcGF0Y2ggb3V0IG9m
IHRoaXMgc2VyaWVzLiAoVGhpcyBmaXgtdXANCj4gaXMNCj4gbm90IHJlbGF0ZWQgdG8gbXQ4MTk1
LCBzbyBzZW5kIHRoaXMgcGF0Y2ggaW5kZXBlbmRlbnRseSkuDQo+IA0KPiBbMV0NCj4gDQpodHRw
czovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51
eC5naXQvY29tbWl0Lz9oPXY1LjEzJmlkPWZmMTM5NTYwOWUyMGMxY2Q5OGIzZWM2NWQxNmRjMThm
MDQ3MWRjYTMNCj4gDQo+IFJlZ2FyZHMsDQo+IENLDQo+IA0KPiA+ICAJcmV0dXJuIDA7DQo+ID4g
IH0NCj4gPiAgDQo+IA0KPiANCg==

