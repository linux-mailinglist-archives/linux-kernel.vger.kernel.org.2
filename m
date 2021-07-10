Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78EA93C3377
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 09:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbhGJHZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 03:25:19 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:44714 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229754AbhGJHZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 03:25:15 -0400
X-UUID: f635367113e34859af3624ef951ce161-20210710
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Vg7kkK3ymZSbjBH6a6slF/p57CVU3Geh15a8IH3+LaE=;
        b=JqHit2EqUSUG6yOXk3Ol1AXuWrSJdhaiq9T61TPSiNc8Rk34zlRTckvxLyFOoK9ZzVvJpLKfneOPZ6hNklwhWzq8bsLYmHKf5Qm4TLIlHtaWAGx3FuJ79J5r8e/ectwaNz/Dm78ld66qZQl91zlPDMPIb8SjIXm/7ewf57AxLUU=;
X-UUID: f635367113e34859af3624ef951ce161-20210710
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2007800678; Sat, 10 Jul 2021 15:22:26 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 10 Jul 2021 15:22:25 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 10 Jul 2021 15:22:25 +0800
Message-ID: <ffb03cb6a7f473791731df60641bedb45bcdd85c.camel@mediatek.com>
Subject: Re: [PATCH v1 12/17] drm/mediatek: add CCORR support for MT8195
From:   Jason-JH Lin <jason-jh.lin@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>
CC:     <chunkuang.hu@kernel.org>, <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <fshao@google.com>, <nancy.lin@mediatek.com>,
        <singo.chang@mediatek.com>
Date:   Sat, 10 Jul 2021 15:22:25 +0800
In-Reply-To: <1625637767.7824.23.camel@mtksdaap41>
References: <20210707041249.29816-1-jason-jh.lin@mediatek.com>
         <20210707041249.29816-13-jason-jh.lin@mediatek.com>
         <1625637767.7824.23.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIxLTA3LTA3IGF0IDE0OjAyICswODAwLCBDSyBIdSB3cm90ZToNCj4gSGksIEph
c29uOg0KPiANCj4gT24gV2VkLCAyMDIxLTA3LTA3IGF0IDEyOjEyICswODAwLCBqYXNvbi1qaC5s
aW4gd3JvdGU6DQo+ID4gQWRkIENDT1JSIHN1cHBvcnQgZm9yIE1UODE5NS4NCj4gPiANCj4gPiBT
aWduZWQtb2ZmLWJ5OiBqYXNvbi1qaC5saW4gPGphc29uLWpoLmxpbkBtZWRpYXRlay5jb20+DQo+
ID4gLS0tDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9jY29yci5jIHwg
MiArKw0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYyAgICB8IDIg
KysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Njb3JyLmMNCj4gPiBi
L2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9jY29yci5jDQo+ID4gaW5kZXggMTQx
Y2IzNmI5YzA3Li44MTg4YjIyMGNjNmQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kaXNwX2Njb3JyLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2Rpc3BfY2NvcnIuYw0KPiA+IEBAIC0yMDgsNiArMjA4LDggQEAgc3RhdGljIGNv
bnN0IHN0cnVjdCBtdGtfZGlzcF9jY29ycl9kYXRhDQo+ID4gbXQ4MTgzX2Njb3JyX2RyaXZlcl9k
YXRhID0gew0KPiA+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBtdGtfZGlzcF9j
Y29ycl9kcml2ZXJfZHRfbWF0Y2hbXQ0KPiA+ID0gew0KPiA+ICAJeyAuY29tcGF0aWJsZSA9ICJt
ZWRpYXRlayxtdDgxODMtZGlzcC1jY29yciIsDQo+ID4gIAkgIC5kYXRhID0gJm10ODE4M19jY29y
cl9kcml2ZXJfZGF0YX0sDQo+ID4gKwl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5NS1k
aXNwLWNjb3JyIiwNCj4gPiArCSAgLmRhdGEgPSAmbXQ4MTgzX2Njb3JyX2RyaXZlcl9kYXRhfSwN
Cj4gPiAgCXt9LA0KPiA+ICB9Ow0KPiA+ICBNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCBtdGtfZGlz
cF9jY29ycl9kcml2ZXJfZHRfbWF0Y2gpOw0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kcm1fZHJ2LmMNCj4gPiBpbmRleCAyOGJmNGExMWVmYjAuLjA1OGI1MGQwZTY0YiAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYw0KPiA+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jDQo+ID4gQEAgLTQ0
MCw2ICs0NDAsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZA0KPiA+IG10a19k
ZHBfY29tcF9kdF9pZHNbXSA9IHsNCj4gPiAgCSAgLmRhdGEgPSAodm9pZCAqKU1US19ESVNQX1dE
TUEgfSwNCj4gPiAgCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTgzLWRpc3AtY2NvcnIi
LA0KPiA+ICAJICAuZGF0YSA9ICh2b2lkICopTVRLX0RJU1BfQ0NPUlIgfSwNCj4gPiArCXsgLmNv
bXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTk1LWRpc3AtY2NvcnIiLA0KPiA+ICsJICAuZGF0YSA9
ICh2b2lkICopTVRLX0RJU1BfQ0NPUlIgfSwNCj4gDQo+IFRoZSBzYW1lIHF1ZXN0aW9uIGFzIE9W
TCBhbmQgQ09MT1IuDQo+IA0KPiBSZWdhcmRzLA0KPiBDSw0KPiANCkhpIENLLA0KDQpPSywgSSds
bCByZW1vdmUgdGhpcyBwYXRjaCBhdCB0aGUgbmV4dCB2ZXJzaW9uLg0KDQpSZWdhcmQsDQpKYXNv
bi1KSC5MaW4NCj4gPiAgCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQyNzAxLWRpc3AtY29s
b3IiLA0KPiA+ICAJICAuZGF0YSA9ICh2b2lkICopTVRLX0RJU1BfQ09MT1IgfSwNCj4gPiAgCXsg
LmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTczLWRpc3AtY29sb3IiLA0KPiANCj4gDQo=

