Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 117A03C3375
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 09:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhGJHYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 03:24:36 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:44160 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229754AbhGJHYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 03:24:35 -0400
X-UUID: 46c8ab3fe2914bbc831c8e8dbc9cafd4-20210710
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=xjRV8hrFDJRVVWuHy6a8LhwWoM4suBYQ/gE6TT4NFis=;
        b=iam/WQD2a3EqzPonXKq1jPOXlrOriv82fccv3qTvku60erX/0SsxHLhwhnvJsMbc5XQ4FjTXsdTg7eso2O5oHL6cdkXmnpY8xM5SmHJM+4V2k3TpkFZXKZpTxpMkRGxka6zBvLEluBi++ML30CV7dv6F3y9n/Dl7Tg+J5mDP+go=;
X-UUID: 46c8ab3fe2914bbc831c8e8dbc9cafd4-20210710
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2072932161; Sat, 10 Jul 2021 15:21:48 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 10 Jul 2021 15:21:46 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 10 Jul 2021 15:21:46 +0800
Message-ID: <e38f1718d3dbdccb973effe637cabc7bb744a011.camel@mediatek.com>
Subject: Re: [PATCH v1 11/17] drm/mediatek: add COLOR support for MT8195
From:   Jason-JH Lin <jason-jh.lin@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>
CC:     <chunkuang.hu@kernel.org>, <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <fshao@google.com>, <nancy.lin@mediatek.com>,
        <singo.chang@mediatek.com>
Date:   Sat, 10 Jul 2021 15:21:46 +0800
In-Reply-To: <1625637697.7824.22.camel@mtksdaap41>
References: <20210707041249.29816-1-jason-jh.lin@mediatek.com>
         <20210707041249.29816-12-jason-jh.lin@mediatek.com>
         <1625637697.7824.22.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIxLTA3LTA3IGF0IDE0OjAxICswODAwLCBDSyBIdSB3cm90ZToNCj4gSGksIEph
c29uOg0KPiANCj4gT24gV2VkLCAyMDIxLTA3LTA3IGF0IDEyOjEyICswODAwLCBqYXNvbi1qaC5s
aW4gd3JvdGU6DQo+ID4gQWRkIENPTE9SIHN1cHBvcnQgZm9yIE1UODE5NS4NCj4gPiANCj4gPiBT
aWduZWQtb2ZmLWJ5OiBqYXNvbi1qaC5saW4gPGphc29uLWpoLmxpbkBtZWRpYXRlay5jb20+DQo+
ID4gLS0tDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9jb2xvci5jIHwg
NiArKysrKysNCj4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmMgICAg
fCAyICsrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9jb2xvci5jDQo+
ID4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfY29sb3IuYw0KPiA+IGluZGV4
IDYzZjQxMWFiMzkzYi4uY2UyY2Y5ZjUwNGNjIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZGlzcF9jb2xvci5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kaXNwX2NvbG9yLmMNCj4gPiBAQCAtMTQ5LDYgKzE0OSwxMCBAQCBzdGF0
aWMgY29uc3Qgc3RydWN0IG10a19kaXNwX2NvbG9yX2RhdGENCj4gPiBtdDgxNzNfY29sb3JfZHJp
dmVyX2RhdGEgPSB7DQo+ID4gIAkuY29sb3Jfb2Zmc2V0ID0gRElTUF9DT0xPUl9TVEFSVF9NVDgx
NzMsDQo+ID4gIH07DQo+ID4gIA0KPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG10a19kaXNwX2Nv
bG9yX2RhdGEgbXQ4MTk1X2NvbG9yX2RyaXZlcl9kYXRhID0NCj4gPiB7DQo+ID4gKwkuY29sb3Jf
b2Zmc2V0ID0gRElTUF9DT0xPUl9TVEFSVF9NVDgxNzMsDQo+ID4gK307DQo+IA0KPiBtdDgxOTVf
Y29sb3JfZHJpdmVyX2RhdGEgaXMgaWRlbnRpY2FsIHRvIG10ODE3M19jb2xvcl9kcml2ZXJfZGF0
YSwgc28NCj4gdXNlIG10ODE3M19jb2xvcl9kcml2ZXJfZGF0YSBhbmQgcmVtb3ZlIG10ODE5NV9j
b2xvcl9kcml2ZXJfZGF0YS4NCj4gDQo+ID4gKw0KPiA+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG9m
X2RldmljZV9pZCBtdGtfZGlzcF9jb2xvcl9kcml2ZXJfZHRfbWF0Y2hbXQ0KPiA+ID0gew0KPiA+
ICAJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDI3MDEtZGlzcC1jb2xvciIsDQo+ID4gIAkg
IC5kYXRhID0gJm10MjcwMV9jb2xvcl9kcml2ZXJfZGF0YX0sDQo+ID4gQEAgLTE1Niw2ICsxNjAs
OCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZA0KPiA+IG10a19kaXNwX2NvbG9y
X2RyaXZlcl9kdF9tYXRjaFtdID0gew0KPiA+ICAJICAuZGF0YSA9ICZtdDgxNjdfY29sb3JfZHJp
dmVyX2RhdGF9LA0KPiA+ICAJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxNzMtZGlzcC1j
b2xvciIsDQo+ID4gIAkgIC5kYXRhID0gJm10ODE3M19jb2xvcl9kcml2ZXJfZGF0YX0sDQo+ID4g
Kwl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5NS1kaXNwLWNvbG9yIiwNCj4gPiArCSAg
LmRhdGEgPSAmbXQ4MTk1X2NvbG9yX2RyaXZlcl9kYXRhfSwNCj4gPiAgCXt9LA0KPiA+ICB9Ow0K
PiA+ICBNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCBtdGtfZGlzcF9jb2xvcl9kcml2ZXJfZHRfbWF0
Y2gpOw0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9k
cnYuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmMNCj4gPiBp
bmRleCA4YjI0NjIzZGNkOTEuLjI4YmY0YTExZWZiMCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jDQo+ID4gQEAgLTQ0NCw2ICs0NDQsOCBAQCBzdGF0aWMg
Y29uc3Qgc3RydWN0IG9mX2RldmljZV9pZA0KPiA+IG10a19kZHBfY29tcF9kdF9pZHNbXSA9IHsN
Cj4gPiAgCSAgLmRhdGEgPSAodm9pZCAqKU1US19ESVNQX0NPTE9SIH0sDQo+ID4gIAl7IC5jb21w
YXRpYmxlID0gIm1lZGlhdGVrLG10ODE3My1kaXNwLWNvbG9yIiwNCj4gPiAgCSAgLmRhdGEgPSAo
dm9pZCAqKU1US19ESVNQX0NPTE9SIH0sDQo+ID4gKwl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVr
LG10ODE5NS1kaXNwLWNvbG9yIiwNCj4gPiArCSAgLmRhdGEgPSAodm9pZCAqKU1US19ESVNQX0NP
TE9SIH0sDQo+IA0KPiBJcyBtZWRpYXRlayxtdDgxOTUtZGlzcC1jb2xvciBpZGVudGljYWwgdG8N
Cj4gbWVkaWF0ZWssbXQ4MTczLWRpc3AtY29sb3IgaW4gaGFyZHdhcmUgZnVuY3Rpb24/IElmIHNv
LCB1c2UgdGhlDQo+IGNvbXBhdGlibGUNCj4gYXMNCj4gDQo+IGNvbXBhdGlibGUgPSAibWVkaWF0
ZWssbXQ4MTk1LWRpc3AtY29sb3IiLCAibWVkaWF0ZWssbXQ4MTczLWRpc3AtDQo+IGNvbG9yIjsN
Cj4gDQo+IEFuZCBkcml2ZXIganVzdCBrZWVwICJtZWRpYXRlayxtdDgxNzMtZGlzcC1jb2xvciIg
YW5kIHJlbW92ZQ0KPiAibWVkaWF0ZWssbXQ4MTk1LWRpc3AtY29sb3IiLg0KPiANCj4gSWYgdGhl
IGhhcmR3YXJlIGZ1bmN0aW9uIGhhcyBzb21lIGRpZmZlcmVudCwganVzdCBmb3JnZXQgdGhpcy4N
Cj4gDQo+IFJlZ2FyZHMsDQo+IENLDQo+IA0KSGkgQ0ssDQoNCk9LLCBJJ2xsIHJlbW92ZSB0aGlz
IHBhdGNoIGF0IHRoZSBuZXh0IHZlcnNpb24uDQoNClJlZ2FyZCwNCkphc29uLUpILkxpbg0KPiA+
ICAJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxNzMtZGlzcC1hYWwiLA0KPiA+ICAJICAu
ZGF0YSA9ICh2b2lkICopTVRLX0RJU1BfQUFMfSwNCj4gPiAgCXsgLmNvbXBhdGlibGUgPSAibWVk
aWF0ZWssbXQ4MTczLWRpc3AtZ2FtbWEiLA0KPiANCj4gDQo=

