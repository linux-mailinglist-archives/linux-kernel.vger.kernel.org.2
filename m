Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A11F03C336D
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 09:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbhGJHID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 03:08:03 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:51596 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232184AbhGJHID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 03:08:03 -0400
X-UUID: dc6bb35f46f546ef952f407b44f49aa7-20210710
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=eICC1osrLRCB6HLoWQS3KtrDniyt/REFGqRN9fWm7CQ=;
        b=psNgez2bIsRLeRkwSfxf2djya4uarAkmnHvEV4OkPjjYFb1SEn53vVhX5hbnTqQk7I8nsp6SVEAA8+UOa6IRSLlBr1xZxCRgDYmSRITlJegPoquBw2hZwejI1T1AeGtX9wB8/4tF1MRlh0qBxtSATzLUIZA4QJmPwwaeSmQCWGo=;
X-UUID: dc6bb35f46f546ef952f407b44f49aa7-20210710
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1103890991; Sat, 10 Jul 2021 15:05:14 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 10 Jul 2021 15:05:13 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 10 Jul 2021 15:05:13 +0800
Message-ID: <257730816d127729e18909d2c23582d0cc07d493.camel@mediatek.com>
Subject: Re: [PATCH v1 07/17] drm/mediatek: add OVL support for MT8195
From:   Jason-JH Lin <jason-jh.lin@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>
CC:     <chunkuang.hu@kernel.org>, <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <fshao@google.com>, <nancy.lin@mediatek.com>,
        <singo.chang@mediatek.com>
Date:   Sat, 10 Jul 2021 15:05:12 +0800
In-Reply-To: <1625634196.7824.13.camel@mtksdaap41>
References: <20210707041249.29816-1-jason-jh.lin@mediatek.com>
         <20210707041249.29816-8-jason-jh.lin@mediatek.com>
         <1625634196.7824.13.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIxLTA3LTA3IGF0IDEzOjAzICswODAwLCBDSyBIdSB3cm90ZToNCj4gSGksIEph
c29uOg0KPiANCj4gT24gV2VkLCAyMDIxLTA3LTA3IGF0IDEyOjEyICswODAwLCBqYXNvbi1qaC5s
aW4gd3JvdGU6DQo+ID4gQWRkIE9WTCBzdXBwb3J0IGZvciBNVDgxOTUuDQo+ID4gDQo+ID4gU2ln
bmVkLW9mZi1ieTogamFzb24tamgubGluIDxqYXNvbi1qaC5saW5AbWVkaWF0ZWsuY29tPg0KPiA+
IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMgfCA5ICsr
KysrKysrKw0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYyAgfCAy
ICsrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4gPiBi
L2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYw0KPiA+IGluZGV4IDk2MWY4
N2Y4ZDRkMS4uOTljMzk0ODcwMjZkIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZGlzcF9vdmwuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZGlzcF9vdmwuYw0KPiA+IEBAIC00NTUsNiArNDU1LDEzIEBAIHN0YXRpYyBjb25zdCBz
dHJ1Y3QgbXRrX2Rpc3Bfb3ZsX2RhdGENCj4gPiBtdDgxODNfb3ZsXzJsX2RyaXZlcl9kYXRhID0g
ew0KPiA+ICAJLmZtdF9yZ2I1NjVfaXNfMCA9IHRydWUsDQo+ID4gIH07DQo+ID4gIA0KPiA+ICtz
dGF0aWMgY29uc3Qgc3RydWN0IG10a19kaXNwX292bF9kYXRhIG10ODE5NV9vdmxfZHJpdmVyX2Rh
dGEgPSB7DQo+ID4gKwkuYWRkciA9IERJU1BfUkVHX09WTF9BRERSX01UODE3MywNCj4gPiArCS5n
bWNfYml0cyA9IDEwLA0KPiA+ICsJLmxheWVyX25yID0gNCwNCj4gPiArCS5mbXRfcmdiNTY1X2lz
XzAgPSB0cnVlLA0KPiA+ICt9Ow0KPiANCj4gbXQ4MTk1X292bF9kcml2ZXJfZGF0YSBpcyBpZGVu
dGljYWwgdG8gbXQ4MTgzX292bF9kcml2ZXJfZGF0YSwgc28NCj4gcmVtb3ZlDQo+IG10ODE5NV9v
dmxfZHJpdmVyX2RhdGEgYW5kIHVzZSBtdDgxODNfb3ZsX2RyaXZlcl9kYXRhLg0KPiANCj4gPiAr
DQo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIG10a19kaXNwX292bF9kcml2
ZXJfZHRfbWF0Y2hbXSA9DQo+ID4gew0KPiA+ICAJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxt
dDI3MDEtZGlzcC1vdmwiLA0KPiA+ICAJICAuZGF0YSA9ICZtdDI3MDFfb3ZsX2RyaXZlcl9kYXRh
fSwNCj4gPiBAQCAtNDY0LDYgKzQ3MSw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNl
X2lkDQo+ID4gbXRrX2Rpc3Bfb3ZsX2RyaXZlcl9kdF9tYXRjaFtdID0gew0KPiA+ICAJICAuZGF0
YSA9ICZtdDgxODNfb3ZsX2RyaXZlcl9kYXRhfSwNCj4gPiAgCXsgLmNvbXBhdGlibGUgPSAibWVk
aWF0ZWssbXQ4MTgzLWRpc3Atb3ZsLTJsIiwNCj4gPiAgCSAgLmRhdGEgPSAmbXQ4MTgzX292bF8y
bF9kcml2ZXJfZGF0YX0sDQo+ID4gKwl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5NS1k
aXNwLW92bCIsDQo+ID4gKwkgIC5kYXRhID0gJm10ODE5NV9vdmxfZHJpdmVyX2RhdGF9LA0KPiAN
Cj4gT25lIHF1ZXN0aW9uLCBpcyBtZWRpYXRlayxtdDgxOTUtZGlzcC1vdmwgaWRlbnRpY2FsIHRv
DQo+IG1lZGlhdGVrLG10ODE4My1kaXNwLW92bCBpbiBoYXJkd2FyZSBmdW5jdGlvbj8gSWYgc28s
IHVzZSB0aGUNCj4gY29tcGF0aWJsZQ0KPiBhcw0KPiANCj4gY29tcGF0aWJsZSA9ICJtZWRpYXRl
ayxtdDgxOTUtZGlzcC1vdmwiLCAibWVkaWF0ZWssbXQ4MTgzLWRpc3Atb3ZsIjsNCj4gDQo+IEFu
ZCBkcml2ZXIganVzdCBrZWVwICJtZWRpYXRlayxtdDgxODMtZGlzcC1vdmwiIGFuZCByZW1vdmUN
Cj4gIm1lZGlhdGVrLG10ODE5NS1kaXNwLW92bCIuDQo+IA0KPiBJZiB0aGUgaGFyZHdhcmUgZnVu
Y3Rpb24gaGFzIHNvbWUgZGlmZmVyZW50LCBqdXN0IGZvcmdldCB0aGlzLg0KPiANCj4gUmVnYXJk
cywNCj4gQ0sNCj4gDQpIaSBDSywNCg0KT0ssIEknbGwgcmVtb3ZlIHRoaXMgcGF0Y2ggYXQgdGhl
IG5leHQgdmVyc2lvbi4NCg0KUmVnYXJkLA0KSmFzb24tSkguTGluDQo+ID4gIAl7fSwNCj4gPiAg
fTsNCj4gPiAgTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgbXRrX2Rpc3Bfb3ZsX2RyaXZlcl9kdF9t
YXRjaCk7DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJt
X2Rydi5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYw0KPiA+
IGluZGV4IDViN2VhZDQ5MzQ4Ny4uNjUwMzhkNWIxOWNiIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmMNCj4gPiBAQCAtNDI0LDYgKzQyNCw4IEBAIHN0YXRp
YyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkDQo+ID4gbXRrX2RkcF9jb21wX2R0X2lkc1tdID0g
ew0KPiA+ICAJICAuZGF0YSA9ICh2b2lkICopTVRLX0RJU1BfT1ZMIH0sDQo+ID4gIAl7IC5jb21w
YXRpYmxlID0gIm1lZGlhdGVrLG10ODE4My1kaXNwLW92bCIsDQo+ID4gIAkgIC5kYXRhID0gKHZv
aWQgKilNVEtfRElTUF9PVkwgfSwNCj4gPiArCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4
MTk1LWRpc3Atb3ZsIiwNCj4gPiArCSAgLmRhdGEgPSAodm9pZCAqKU1US19ESVNQX09WTCB9LA0K
PiA+ICAJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODMtZGlzcC1vdmwtMmwiLA0KPiA+
ICAJICAuZGF0YSA9ICh2b2lkICopTVRLX0RJU1BfT1ZMXzJMIH0sDQo+ID4gIAl7IC5jb21wYXRp
YmxlID0gIm1lZGlhdGVrLG10MjcwMS1kaXNwLXJkbWEiLA0KPiANCj4gDQo=

