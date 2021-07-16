Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A023CB4B2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 10:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238519AbhGPIt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 04:49:56 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:54640 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229895AbhGPItz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 04:49:55 -0400
X-UUID: 310cb61fa2d3420e97f8e7ed8a7f5dce-20210716
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=HAtMITVfO6Me2ipLnloxqV38ZLex0RwEgEL/1zH8yT8=;
        b=GPGu/dSWML8QttdpZPgnW99Xx3HiZkwKA9DiA0qAIDisyWQuD5vv3zaOXaH/8n8CgSUQjoDd1AAUfNqJSpstypP1eYZ/hpd/6nRADAgJF63iJLlSVDYpeB0xSauFrzNea/c8nj9oTgrX37otpkBvfE+awVLHMUjC4j7+zVFWuvA=;
X-UUID: 310cb61fa2d3420e97f8e7ed8a7f5dce-20210716
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1129479090; Fri, 16 Jul 2021 16:46:59 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 16 Jul 2021 16:46:58 +0800
Received: from mtksdccf07 (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 16 Jul 2021 16:46:58 +0800
Message-ID: <2f2cf6aa5bbf3052e5cc78fdebf32844677b5063.camel@mediatek.com>
Subject: Re: [PATCH v2 0/9] Add MediaTek SoC DRM (vdosys0) support for mt8195
From:   Jason-JH Lin <jason-jh.lin@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <fshao@google.com>, "Nancy Lin" <nancy.lin@mediatek.com>,
        <singo.chang@mediatek.com>
Date:   Fri, 16 Jul 2021 16:46:57 +0800
In-Reply-To: <CAAOTY_9wvVJ6zZDmOt-8zJK2BkLtEO-h6QQRVkbc8q5QXtns3g@mail.gmail.com>
References: <20210710113819.5170-1-jason-jh.lin@mediatek.com>
         <CAAOTY_9wvVJ6zZDmOt-8zJK2BkLtEO-h6QQRVkbc8q5QXtns3g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDIxLTA3LTExIGF0IDA5OjI0ICswODAwLCBDaHVuLUt1YW5nIEh1IHdyb3RlOg0K
PiBIaSwgSmFzb246DQo+IA0KPiBqYXNvbi1qaC5saW4gPGphc29uLWpoLmxpbkBtZWRpYXRlay5j
b20+IOaWvCAyMDIx5bm0N+aciDEw5pelIOmAseWFrSDkuIvljYg3OjM45a+r6YGT77yaDQo+ID4g
DQo+ID4gVGhlIGhhcmR3YXJlIHBhdGggb2YgdmRvc3lzMCB3aXRoIGVEUCBwYW5lbCBvdXRwdXQg
bmVlZCB0byBnbw0KPiA+IHRocm91Z2gNCj4gPiBieSBzZXZlcmFsIG1vZHVsZXMsIHN1Y2ggYXMs
IE9WTCwgUkRNQSwgQ09MT1IsIENDT1JSLCBBQUwsIEdBTU1BLA0KPiA+IERJVEhFUiwgRFNDIGFu
ZCBNRVJHRS4NCj4gDQo+IFlvdSBzaG91bGQgYWRkIHRoZSBkaWZmZXJlbmNlIGluIGVhY2ggdmVy
c2lvbi4gWzFdIGlzIGFuIGV4YW1wbGUgZm9yDQo+IHRoaXMuDQo+IA0KPiBbMV0gDQo+IGh0dHBz
Oi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2pl
Y3QvbGludXgtbWVkaWF0ZWsvY292ZXIvMjAyMTA3MDkwMjIzMjQuMTYwNzg4NC0xLWVpemFuQGNo
cm9taXVtLm9yZy9fXzshIUNUUk5LQTl3TWcwQVJidyExRXdqd3JOQml4SFZad21nVTR3SVJ5VlVZ
aUw0MHhQYzY0b1VSZjZtVmVpSjVqX19zTy1rTU5MeWFMQmZSYzUzdTlxWCQNCj4gIA0KPiANCj4g
UmVnYXJkcywNCj4gQ2h1bi1LdWFuZy4NCj4gDQpIaSBDSywNCg0KSSdsbCBhZGQgdGhpcyBhdCB0
aGUgbmV4dCB2ZXJzaW9uLg0KDQpSZWdhcmRzLA0KSmFzb24tSkguTGluDQo+ID4gDQo+ID4gQWRk
IERSTSBhbmQgdGhlc2UgbW9kdWxlcyBzdXBwb3J0IGJ5IHRoZSBwYXRjaGVzIGJlbG93Og0KPiA+
IA0KPiA+IGphc29uLWpoLmxpbiAoOSk6DQo+ID4gICBkdC1iaW5kaW5nczogbWVkaWF0ZWs6IGFk
ZCBkZWZpbml0aW9uIGZvciBtdDgxOTUgZGlzcGxheQ0KPiA+ICAgZHQtYmluZGluZ3M6IG1lZGlh
dGVrOiBhZGQgRFNDIGRlZmluaXRpb24gZm9yIG10ODE5NQ0KPiA+ICAgZHQtYmluZGluZ3M6IGFy
bTogbWVkaWF0ZWs6IGFkZCBkZWZpbml0aW9uIGZvciBtdDgxOTUgbW1zeXMNCj4gPiAgIGFybTY0
OiBkdHM6IG10ODE5NTogYWRkIGRpc3BsYXkgbm9kZSBmb3IgdmRvc3lzMA0KPiA+ICAgc29jOiBt
ZWRpYXRlazogYWRkIG10ay1tbXN5cyBzdXBwb3J0IGZvciBtdDgxOTUgdmRvc3lzMA0KPiA+ICAg
c29jOiBtZWRpYXRlazogYWRkIG10ay1tdXRleCBzdXBwb3J0IGZvciBtdDgxOTUgdmRvc3lzMA0K
PiA+ICAgZHJtL21lZGlhdGVrOiBhZGQgbWVkaWF0ZWstZHJtIG9mIHZkb3N5czAgc3VwcG9ydCBm
b3IgTVQ4MTk1DQo+ID4gICBkcm0vbWVkaWF0ZWs6IGFkZCBEU0Mgc3VwcG9ydCBmb3IgTVQ4MTk1
DQo+ID4gICBkcm0vbWVkaWF0ZWs6IGFkZCBNRVJHRSBzdXBwb3J0IGZvciBNVDgxOTUNCj4gPiAN
Cj4gPiAgLi4uL2JpbmRpbmdzL2FybS9tZWRpYXRlay9tZWRpYXRlayxtbXN5cy50eHQgIHwgIDE1
ICsNCj4gPiAgLi4uL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZGlzcC50eHQgICAgICAgIHwg
ICA5ICstDQo+ID4gIC4uLi9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGRzYy55YW1sICAgICAg
ICB8ICA1NyArKw0KPiA+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5NS5kdHNp
ICAgICAgfCAxMTEgKysrKw0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvTWFrZWZpbGUg
ICAgICAgICAgICAgfCAgIDIgKw0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rp
c3BfZHJ2LmggICAgICAgfCAgMTYgKw0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2Rpc3BfZHNjLmMgICAgICAgfCAyMDUgKysrKysrKw0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2Rpc3BfbWVyZ2UuYyAgICAgfCA1MjUNCj4gPiArKysrKysrKysrKysrKysrKysN
Cj4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX3JkbWEuYyAgICAgIHwgICA2
ICsNCj4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5oICAgICAgIHwg
IDE0ICsNCj4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYyAg
IHwgIDI5ICsNCj4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAu
aCAgIHwgICAyICsNCj4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmMg
ICAgICAgIHwgIDMyICsrDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Ry
di5oICAgICAgICB8ICAgMiArDQo+ID4gIGRyaXZlcnMvc29jL21lZGlhdGVrL210ODE5NS1tbXN5
cy5oICAgICAgICAgICB8IDE5MSArKysrKysrDQo+ID4gIGRyaXZlcnMvc29jL21lZGlhdGVrL210
ay1tbXN5cy5jICAgICAgICAgICAgICB8ICAxMSArDQo+ID4gIGRyaXZlcnMvc29jL21lZGlhdGVr
L210ay1tdXRleC5jICAgICAgICAgICAgICB8IDEwNyArKystDQo+ID4gIGluY2x1ZGUvbGludXgv
c29jL21lZGlhdGVrL210ay1tbXN5cy5oICAgICAgICB8ICAxMCArDQo+ID4gIDE4IGZpbGVzIGNo
YW5nZWQsIDEzMzcgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4gPiAgY3JlYXRlIG1v
ZGUgMTAwNjQ0DQo+ID4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkv
bWVkaWF0ZWsvbWVkaWF0ZWssZHNjLnlhbQ0KPiA+IGwNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0
IGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9kc2MuYw0KPiA+ICBjcmVhdGUgbW9k
ZSAxMDA2NDQgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX21lcmdlLmMNCj4gPiAg
Y3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvc29jL21lZGlhdGVrL210ODE5NS1tbXN5cy5oDQo+
ID4gDQo+ID4gLS0NCj4gPiAyLjE4LjANCj4gPiANCi0tIA0KSmFzb24tSkggTGluIDxqYXNvbi1q
aC5saW5AbWVkaWF0ZWsuY29tPg0K

