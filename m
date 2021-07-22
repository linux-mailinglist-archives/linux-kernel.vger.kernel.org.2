Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3235C3D1E61
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 08:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbhGVF6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 01:58:13 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:58029 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229931AbhGVF6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 01:58:08 -0400
X-UUID: 9c7c97a1869a4b10bdc9567cbf05ab5a-20210722
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=W5iu4yn7qNOz8O4L5niY76z7dUrVPoTbT38cQYHyaGE=;
        b=BsWI1Hd7SbxRaMAXdov9QsxTyPV6BzFs5VDH04IK0r9b4xYMEQpeb/vN2AmR5j7uxy9TYCKZ9jPCOSnt9uOhcZ98l2E/7n7c5YdAC7OU6A02CyIePAqWmBIbSwimgy3uay0fgp8cINwZA91z3s2kul1rkciS2RWIi7VYlkcitB8=;
X-UUID: 9c7c97a1869a4b10bdc9567cbf05ab5a-20210722
Received: from mtkmrs31.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1951434667; Thu, 22 Jul 2021 14:38:40 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 22 Jul
 2021 14:38:34 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 22 Jul 2021 14:38:33 +0800
Message-ID: <1626935913.27875.8.camel@mhfsdcap03>
Subject: Re: [PATCH v2 10/11] memory: mtk-smi: mt8195: Add initial setting
 for smi-common
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
        <iommu@lists.linux-foundation.org>, <youlin.pei@mediatek.com>,
        <anan.sun@mediatek.com>, <ming-fan.chen@mediatek.com>,
        <yi.kuo@mediatek.com>, <anthony.huang@mediatek.com>
Date:   Thu, 22 Jul 2021 14:38:33 +0800
In-Reply-To: <CAATdQgDOGW7nudDoR5UPbax+d3e9omhPstrNd_FCPLd+96ZC9w@mail.gmail.com>
References: <20210715121209.31024-1-yong.wu@mediatek.com>
         <20210715121209.31024-11-yong.wu@mediatek.com>
         <CAATdQgDOGW7nudDoR5UPbax+d3e9omhPstrNd_FCPLd+96ZC9w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 09C7E65E6584ADFA42B61DD670F9B1049F10F210E285069CFBA433B0E7C4F5862000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIxLTA3LTIxIGF0IDIwOjU0ICswODAwLCBJa2pvb24gSmFuZyB3cm90ZToNCj4g
T24gVGh1LCBKdWwgMTUsIDIwMjEgYXQgODoyNSBQTSBZb25nIFd1IDx5b25nLnd1QG1lZGlhdGVr
LmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBUbyBpbXByb3ZlIHRoZSBwZXJmb3JtYW5jZSwgYWRkIGlu
aXRpYWwgc2V0dGluZyBmb3Igc21pLWNvbW1vbi4NCj4gPiBzb21lIHJlZ2lzdGVyIHVzZSBzb21l
IGZpeCBzZXR0aW5nKHN1Z2dlc3RlZCBmcm9tIERFKS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL21l
bW9yeS9tdGstc21pLmMgfCA0MiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKyst
LS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzOCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygt
KQ0KDQpbLi4uXQ0KDQo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX3NtaV9jb21tb25fcGxh
dCBtdGtfc21pX3N1Yl9jb21tb25fbXQ4MTk1ID0gew0KPiA+IEBAIC01MzAsMTUgKzU1OCwyMSBA
QCBzdGF0aWMgaW50IG10a19zbWlfY29tbW9uX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
ICpwZGV2KQ0KPiA+ICBzdGF0aWMgaW50IF9fbWF5YmVfdW51c2VkIG10a19zbWlfY29tbW9uX3Jl
c3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ID4gIHsNCj4gPiAgICAgICAgIHN0cnVjdCBtdGtf
c21pICpjb21tb24gPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gPiAtICAgICAgIHUzMiBidXNf
c2VsID0gY29tbW9uLT5wbGF0LT5idXNfc2VsOw0KPiA+IC0gICAgICAgaW50IHJldDsNCj4gPiAr
ICAgICAgIGNvbnN0IHN0cnVjdCBtdGtfc21pX3JlZ19wYWlyICppbml0ID0gY29tbW9uLT5wbGF0
LT5pbml0Ow0KPiA+ICsgICAgICAgdTMyIGJ1c19zZWwgPSBjb21tb24tPnBsYXQtPmJ1c19zZWw7
IC8qIGRlZmF1bHQgaXMgMCAqLw0KPiA+ICsgICAgICAgaW50IHJldCwgaTsNCj4gPg0KPiA+ICAg
ICAgICAgcmV0ID0gY2xrX2J1bGtfcHJlcGFyZV9lbmFibGUoY29tbW9uLT5jbGtfbnVtLCBjb21t
b24tPmNsa3MpOw0KPiA+ICAgICAgICAgaWYgKHJldCkNCj4gPiAgICAgICAgICAgICAgICAgcmV0
dXJuIHJldDsNCj4gPg0KPiA+IC0gICAgICAgaWYgKGNvbW1vbi0+cGxhdC0+dHlwZSA9PSBNVEtf
U01JX0dFTjIgJiYgYnVzX3NlbCkNCj4gPiAtICAgICAgICAgICAgICAgd3JpdGVsKGJ1c19zZWws
IGNvbW1vbi0+YmFzZSArIFNNSV9CVVNfU0VMKTsNCj4gPiArICAgICAgIGlmIChjb21tb24tPnBs
YXQtPnR5cGUgIT0gTVRLX1NNSV9HRU4yKQ0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gMDsN
Cj4gPiArDQo+ID4gKyAgICAgICBmb3IgKGkgPSAwOyBpIDwgU01JX0NPTU1PTl9JTklUX1JFR1Nf
TlIgJiYgaW5pdCAmJiBpbml0W2ldLm9mZnNldDsgaSsrKQ0KPiA+ICsgICAgICAgICAgICAgICB3
cml0ZWxfcmVsYXhlZChpbml0W2ldLnZhbHVlLCBjb21tb24tPmJhc2UgKyBpbml0W2ldLm9mZnNl
dCk7DQo+IA0KPiBJJ20gbm90IHN1cmUgdGhpcyBhcnJheSBmb3IgcmVnaXN0ZXIgc2V0dGluZ3Mg
Y291bGQgYmUgYXBwbGllZCB0byBvdGhlcg0KPiBwbGF0Zm9ybXMgaW4gZnV0dXJlIG9yIG9ubHkg
YXBwbGllZCB0byBtdDgxOTUuIElmIGl0J3Mgb25seSBmb3IgbXQ4MTk1LA0KDQpUaGUgb3RoZXIg
cGxhdGZvcm1zIGhhdmUgdGhlIG5lYXJseSBzYW1lIHNldHRpbmcuDQoNCj4gSSB0aGluayB0YWtp
bmcgY2FsbGJhY2sgZnVuY3Rpb24gaW5zdGVhZCBvZiBtdGtfc21pX3JlZ19wYWlyW10gYXMgaW5p
dCBtZW1iZXINCj4gd291bGQgYmUgYmV0dGVyOg0KPiANCj4gaWYgKGNvbW1vbi0+cGxhdC0+aW5p
dCkNCj4gICAgIGNvbW1vbi0+cGxhdC0+aW5pdCguLi4pOw0KPiANCj4gPiArDQo+ID4gKyAgICAg
ICB3cml0ZWwoYnVzX3NlbCwgY29tbW9uLT5iYXNlICsgU01JX0JVU19TRUwpOw0KPiA+ICAgICAg
ICAgcmV0dXJuIDA7DQo+ID4gIH0NCj4gPg0KPiA+IC0tDQo+ID4gMi4xOC4wDQo+ID4gX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gPiBMaW51eC1tZWRp
YXRlayBtYWlsaW5nIGxpc3QNCj4gPiBMaW51eC1tZWRpYXRla0BsaXN0cy5pbmZyYWRlYWQub3Jn
DQo+ID4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1t
ZWRpYXRlaw0KPiANCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18NCj4gTGludXgtbWVkaWF0ZWsgbWFpbGluZyBsaXN0DQo+IExpbnV4LW1lZGlhdGVrQGxp
c3RzLmluZnJhZGVhZC5vcmcNCj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC1tZWRpYXRlaw0KDQo=

