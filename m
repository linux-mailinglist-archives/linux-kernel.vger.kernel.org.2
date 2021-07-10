Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A9C3C335A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 09:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbhGJHCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 03:02:43 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:46310 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229690AbhGJHCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 03:02:42 -0400
X-UUID: a758cc349d7f42d6bfea7f873e789395-20210710
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=5AIx17dgaf9J9sK4Zh/t7h7NIr3pG6feU3yAreOp5as=;
        b=YIa+4DpuAHAhBNZaj0cRYIowXlbxVys8fS2YLoLJ5OULX6fWsKw7dSd9RyyMMTPKxcrYoXrAIZFd4nsWVTgd73a0uzvIIAVq2xL4CFmVADwzqbEo2dk7WqrBbAqCZKXhqkpJjB3C11rRx1hvanKWD5CSnviChMSxZii5cjtUKJw=;
X-UUID: a758cc349d7f42d6bfea7f873e789395-20210710
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1747223156; Sat, 10 Jul 2021 14:59:54 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 10 Jul 2021 14:59:46 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 10 Jul 2021 14:59:46 +0800
Message-ID: <ec19c5e28d0ba70cd8b53fdc082506c4eeab672f.camel@mediatek.com>
Subject: Re: [PATCH v1 05/17] drm/mediatek: add mediatek-drm of vdosys0
 support for MT8195
From:   Jason-JH Lin <jason-jh.lin@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>
CC:     <chunkuang.hu@kernel.org>, <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <fshao@google.com>, <nancy.lin@mediatek.com>,
        <singo.chang@mediatek.com>
Date:   Sat, 10 Jul 2021 14:59:46 +0800
In-Reply-To: <1625633339.7824.6.camel@mtksdaap41>
References: <20210707041249.29816-1-jason-jh.lin@mediatek.com>
         <20210707041249.29816-6-jason-jh.lin@mediatek.com>
         <1625633339.7824.6.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIxLTA3LTA3IGF0IDEyOjQ4ICswODAwLCBDSyBIdSB3cm90ZToNCj4gSGksIEph
c29uOg0KPiANCj4gT24gV2VkLCAyMDIxLTA3LTA3IGF0IDEyOjEyICswODAwLCBqYXNvbi1qaC5s
aW4gd3JvdGU6DQo+ID4gQWRkIG1lZGlhdGVrLWRybSBvZiB2ZG9zeXMwIHN1cHBvcnQgZm9yIE1U
ODE5NS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBqYXNvbi1qaC5saW4gPGphc29uLWpoLmxp
bkBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZHJtX2Rydi5jIHwgMjQNCj4gPiArKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBm
aWxlIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jDQo+ID4gaW5kZXggYjQ2YmRiODk4NWRhLi45MDc0Y2Uz
MjkxMmMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1f
ZHJ2LmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYw0K
PiA+IEBAIC0xNDcsNiArMTQ3LDIzIEBAIHN0YXRpYyBjb25zdCBlbnVtIG10a19kZHBfY29tcF9p
ZA0KPiA+IG10ODE4M19tdGtfZGRwX2V4dFtdID0gew0KPiA+ICAJRERQX0NPTVBPTkVOVF9EUEkw
LA0KPiA+ICB9Ow0KPiA+ICANCj4gPiArc3RhdGljIGNvbnN0IGVudW0gbXRrX2RkcF9jb21wX2lk
IG10ODE5NV9tdGtfZGRwX21haW5bXSA9IHsNCj4gPiArCUREUF9DT01QT05FTlRfT1ZMMCwNCj4g
PiArCUREUF9DT01QT05FTlRfUkRNQTAsDQo+ID4gKwlERFBfQ09NUE9ORU5UX0NPTE9SMCwNCj4g
PiArCUREUF9DT01QT05FTlRfQ0NPUlIsDQo+ID4gKwlERFBfQ09NUE9ORU5UX0FBTDAsDQo+ID4g
KwlERFBfQ09NUE9ORU5UX0dBTU1BLA0KPiA+ICsJRERQX0NPTVBPTkVOVF9ESVRIRVIsDQo+ID4g
KyNpZmRlZiBDT05GSUdfTVRLX0RQVFhfU1VQUE9SVA0KPiA+ICsJRERQX0NPTVBPTkVOVF9EU0Mw
LA0KPiA+ICsJRERQX0NPTVBPTkVOVF9NRVJHRTAsDQo+ID4gKwlERFBfQ09NUE9ORU5UX0RQX0lO
VEYwLA0KPiA+ICsjZWxzZQ0KPiANCj4gQ09ORklHX01US19EUFRYX1NVUFBPUlQgaXMgbm90IGRl
ZmluZWQsIHNvIHJlbW92ZSB0aGlzIHBhcnQuDQo+IA0KPiBSZWdhcmRzLA0KPiBDSw0KPiANCg0K
SGkgQ0ssDQoNCk9LLCBJJ2xsIHJlbW92ZSB0aGlzIHBhcnQgYXQgdGhlIG5leHQgdmVyc2lvbi4N
Cg0KUmVnYXJkLA0KSmFzb24tSkguTGluDQoNCj4gPiArCUREUF9DT01QT05FTlRfRFNJMCwNCj4g
PiArI2VuZGlmDQo+ID4gK307DQo+ID4gKw0KPiA+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19t
bXN5c19kcml2ZXJfZGF0YSBtdDI3MDFfbW1zeXNfZHJpdmVyX2RhdGENCj4gPiA9IHsNCj4gPiAg
CS5tYWluX3BhdGggPSBtdDI3MDFfbXRrX2RkcF9tYWluLA0KPiA+ICAJLm1haW5fbGVuID0gQVJS
QVlfU0laRShtdDI3MDFfbXRrX2RkcF9tYWluKSwNCj4gPiBAQCAtMTg2LDYgKzIwMywxMSBAQCBz
dGF0aWMgY29uc3Qgc3RydWN0IG10a19tbXN5c19kcml2ZXJfZGF0YQ0KPiA+IG10ODE4M19tbXN5
c19kcml2ZXJfZGF0YSA9IHsNCj4gPiAgCS5leHRfbGVuID0gQVJSQVlfU0laRShtdDgxODNfbXRr
X2RkcF9leHQpLA0KPiA+ICB9Ow0KPiA+ICANCj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtf
bW1zeXNfZHJpdmVyX2RhdGENCj4gPiBtdDgxOTVfdmRvc3lzMF9kcml2ZXJfZGF0YSA9IHsNCj4g
PiArCS5tYWluX3BhdGggPSBtdDgxOTVfbXRrX2RkcF9tYWluLA0KPiA+ICsJLm1haW5fbGVuID0g
QVJSQVlfU0laRShtdDgxOTVfbXRrX2RkcF9tYWluKSwNCj4gPiArfTsNCj4gPiArDQo+ID4gIHN0
YXRpYyBpbnQgbXRrX2RybV9rbXNfaW5pdChzdHJ1Y3QgZHJtX2RldmljZSAqZHJtKQ0KPiA+ICB7
DQo+ID4gIAlzdHJ1Y3QgbXRrX2RybV9wcml2YXRlICpwcml2YXRlID0gZHJtLT5kZXZfcHJpdmF0
ZTsNCj4gPiBAQCAtNDY4LDYgKzQ5MCw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNl
X2lkDQo+ID4gbXRrX2RybV9vZl9pZHNbXSA9IHsNCj4gPiAgCSAgLmRhdGEgPSAmbXQ4MTczX21t
c3lzX2RyaXZlcl9kYXRhfSwNCj4gPiAgCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTgz
LW1tc3lzIiwNCj4gPiAgCSAgLmRhdGEgPSAmbXQ4MTgzX21tc3lzX2RyaXZlcl9kYXRhfSwNCj4g
PiArCXsuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxOTUtdmRvc3lzMCIsDQo+ID4gKwkgIC5k
YXRhID0gJm10ODE5NV92ZG9zeXMwX2RyaXZlcl9kYXRhfSwNCj4gPiAgCXsgfQ0KPiA+ICB9Ow0K
PiA+ICBNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCBtdGtfZHJtX29mX2lkcyk7DQo+IA0KPiANCg==

