Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC4AF3CB3BF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 10:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236704AbhGPIKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 04:10:17 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:42856 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230408AbhGPIKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 04:10:14 -0400
X-UUID: d6c236bb36fb498ba9e9484f83811c4b-20210716
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Ycgkqi41ryYYvXCErvduEcHjhMqTW1StJxcM00pk22I=;
        b=DJ/+KzwhuAVn52SXS2k0Z9zO8G03TvkPGCp+gleZC7WoYNz84DwkDs9XskI+iP85NHfaxHfhkWh5ls18duVvZz5nIcqSL4Y8LRoXv+mLZ9wVy8EYGlTMBnViit3fEhQfQoYuBhmSUuEEG01ESgSCp2gGX3+kZ5+6/Hw2zV2VlaA=;
X-UUID: d6c236bb36fb498ba9e9484f83811c4b-20210716
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1600447368; Fri, 16 Jul 2021 16:07:18 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 16 Jul 2021 16:07:16 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 16 Jul 2021 16:07:16 +0800
Message-ID: <7016862f2f35386445d68f0c3f5f35ed2b105d82.camel@mediatek.com>
Subject: Re: [PATCH v2 1/9] dt-bindings: mediatek: add definition for mt8195
 display
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
Date:   Fri, 16 Jul 2021 16:07:16 +0800
In-Reply-To: <CAAOTY_-FS_wWgyo7gZu_qPxqhNOQsp+q172Y=d=dttEi_LVT9Q@mail.gmail.com>
References: <20210710113819.5170-1-jason-jh.lin@mediatek.com>
         <20210710113819.5170-2-jason-jh.lin@mediatek.com>
         <CAAOTY_-FS_wWgyo7gZu_qPxqhNOQsp+q172Y=d=dttEi_LVT9Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDIxLTA3LTExIGF0IDA5OjIxICswODAwLCBDaHVuLUt1YW5nIEh1IHdyb3RlOg0K
PiBIaSwgSmFzb246DQo+IA0KPiBqYXNvbi1qaC5saW4gPGphc29uLWpoLmxpbkBtZWRpYXRlay5j
b20+IOaWvCAyMDIx5bm0N+aciDEw5pelIOmAseWFrSDkuIvljYg3OjM45a+r6YGT77yaDQo+ID4g
DQo+ID4gQWRkIGRlZmluaXRpb24gZm9yIG10ODE5NSBkaXNwbGF5Lg0KPiA+IA0KPiA+IFNpZ25l
ZC1vZmYtYnk6IGphc29uLWpoLmxpbiA8amFzb24tamgubGluQG1lZGlhdGVrLmNvbT4NCj4gPiAt
LS0NCj4gPiAgLi4uL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZGlzcC50eHQg
ICAgICAgICAgfCA5DQo+ID4gKysrKysrKy0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWss
ZGlzcC4NCj4gPiB0eHQNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9k
aXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGRpc3AuDQo+ID4gdHh0DQo+ID4gaW5kZXggZmJiNTlj
OWRkZGE2Li5kZTYyMjZkNGJjYTMgMTAwNjQ0DQo+ID4gLS0tDQo+ID4gYS9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxkaXNwLg0KPiA+
IHR4dA0KPiA+ICsrKw0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rp
c3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZGlzcC4NCj4gPiB0eHQNCj4gPiBAQCAtMzcsNiArMzcs
NyBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVzIChhbGwgZnVuY3Rpb24gYmxvY2tzKToNCj4gPiAgICAg
ICAgICJtZWRpYXRlayw8Y2hpcD4tZGlzcC1hYWwiICAgICAgICAgICAgICAtIGFkYXB0aXZlIGFt
YmllbnQNCj4gPiBsaWdodCBjb250cm9sbGVyDQo+ID4gICAgICAgICAibWVkaWF0ZWssPGNoaXA+
LWRpc3AtZ2FtbWEiICAgICAgICAgICAgLSBnYW1tYSBjb3JyZWN0aW9uDQo+ID4gICAgICAgICAi
bWVkaWF0ZWssPGNoaXA+LWRpc3AtbWVyZ2UiICAgICAgICAgICAgLSBtZXJnZSBzdHJlYW1zDQo+
ID4gZnJvbSB0d28gUkRNQSBzb3VyY2VzDQo+ID4gKyAgICAgICAibWVkaWF0ZWssPGNoaXA+LWRp
c3AtZHNjIiAgICAgICAgICAgICAgLSBEU0MgY29udHJvbGxlciwNCj4gPiBzZWUgbWVkaWF0ZWss
ZHNjLnlhbWwNCj4gDQo+IFlvdSBhZGQgZHNjIGJpbmRpbmcgZG9jdW1lbnQgaW4geWFtbCBmb3Jt
YXQsIHNvIEkgd291bGQgbGlrZSB5b3UgdG8NCj4gY2hhbmdlIHRoaXMgYmluZGluZyBkb2N1bWVu
dCB0byB5YW1sIGZvcm1hdC4NCj4gDQo+IFJlZ2FyZHMsDQo+IENodW4tS3VhbmcuDQo+IA0KSGkg
Q0ssDQoNCk9LLCBJIHdpbGwgY2hhbmdlIHRoaXMgYmluZGluZyBkb2N1bWVudCB0byB5YW1sIGZv
cm1hdCBhdCB0aGUgbmV4dA0KdmVyc2lvbi4NCg0KUmVnYXJkcywNCkphc29uLUpILkxpbg0KPiA+
ICAgICAgICAgIm1lZGlhdGVrLDxjaGlwPi1kaXNwLXBvc3RtYXNrIiAgICAgICAgIC0gY29udHJv
bCByb3VuZA0KPiA+IGNvcm5lciBmb3IgZGlzcGxheSBmcmFtZQ0KPiA+ICAgICAgICAgIm1lZGlh
dGVrLDxjaGlwPi1kaXNwLXNwbGl0IiAgICAgICAgICAgIC0gc3BsaXQgc3RyZWFtIHRvDQo+ID4g
dHdvIGVuY29kZXJzDQo+ID4gICAgICAgICAibWVkaWF0ZWssPGNoaXA+LWRpc3AtdWZvZSIgICAg
ICAgICAgICAgLSBkYXRhIGNvbXByZXNzaW9uDQo+ID4gZW5naW5lDQo+ID4gQEAgLTQ0LDcgKzQ1
LDcgQEAgUmVxdWlyZWQgcHJvcGVydGllcyAoYWxsIGZ1bmN0aW9uIGJsb2Nrcyk6DQo+ID4gICAg
ICAgICAibWVkaWF0ZWssPGNoaXA+LWRwaSIgICAgICAgICAgICAgICAgICAgLSBEUEkgY29udHJv
bGxlciwNCj4gPiBzZWUgbWVkaWF0ZWssZHBpLnR4dA0KPiA+ICAgICAgICAgIm1lZGlhdGVrLDxj
aGlwPi1kaXNwLW11dGV4IiAgICAgICAgICAgIC0gZGlzcGxheSBtdXRleA0KPiA+ICAgICAgICAg
Im1lZGlhdGVrLDxjaGlwPi1kaXNwLW9kIiAgICAgICAgICAgICAgIC0gb3ZlcmRyaXZlDQo+ID4g
LSAgdGhlIHN1cHBvcnRlZCBjaGlwcyBhcmUgbXQyNzAxLCBtdDc2MjMsIG10MjcxMiwgbXQ4MTY3
LCBtdDgxNzMsDQo+ID4gbXQ4MTgzIGFuZCBtdDgxOTIuDQo+ID4gKyAgdGhlIHN1cHBvcnRlZCBj
aGlwcyBhcmUgbXQyNzAxLCBtdDc2MjMsIG10MjcxMiwgbXQ4MTY3LCBtdDgxNzMsDQo+ID4gbXQ4
MTgzLCBtdDgxOTIgYW5kIG10ODE5NS4NCj4gPiAgLSByZWc6IFBoeXNpY2FsIGJhc2UgYWRkcmVz
cyBhbmQgbGVuZ3RoIG9mIHRoZSBmdW5jdGlvbiBibG9jaw0KPiA+IHJlZ2lzdGVyIHNwYWNlDQo+
ID4gIC0gaW50ZXJydXB0czogVGhlIGludGVycnVwdCBzaWduYWwgZnJvbSB0aGUgZnVuY3Rpb24g
YmxvY2sNCj4gPiAocmVxdWlyZWQsIGV4Y2VwdCBmb3INCj4gPiAgICBtZXJnZSBhbmQgc3BsaXQg
ZnVuY3Rpb24gYmxvY2tzKS4NCj4gPiBAQCAtNjAsNyArNjEsNyBAQCBSZXF1aXJlZCBwcm9wZXJ0
aWVzIChETUEgZnVuY3Rpb24gYmxvY2tzKToNCj4gPiAgICAgICAgICJtZWRpYXRlayw8Y2hpcD4t
ZGlzcC1vdmwiDQo+ID4gICAgICAgICAibWVkaWF0ZWssPGNoaXA+LWRpc3AtcmRtYSINCj4gPiAg
ICAgICAgICJtZWRpYXRlayw8Y2hpcD4tZGlzcC13ZG1hIg0KPiA+IC0gIHRoZSBzdXBwb3J0ZWQg
Y2hpcHMgYXJlIG10MjcwMSwgbXQ4MTY3IGFuZCBtdDgxNzMuDQo+ID4gKyAgdGhlIHN1cHBvcnRl
ZCBjaGlwcyBhcmUgbXQyNzAxLCBtdDgxNjcsIG10ODE3MyBhbmQgbXQ4MTk1Lg0KPiA+ICAtIGxh
cmI6IFNob3VsZCBjb250YWluIGEgcGhhbmRsZSBwb2ludGluZyB0byB0aGUgbG9jYWwgYXJiaXRl
cg0KPiA+IGRldmljZSBhcyBkZWZpbmVkDQo+ID4gICAgaW4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL21lbW9yeS0NCj4gPiBjb250cm9sbGVycy9tZWRpYXRlayxzbWktbGFyYi55
YW1sDQo+ID4gIC0gaW9tbXVzOiBTaG91bGQgcG9pbnQgdG8gdGhlIHJlc3BlY3RpdmUgSU9NTVUg
YmxvY2sgd2l0aCBtYXN0ZXINCj4gPiBwb3J0IGFzDQo+ID4gQEAgLTIxNywzICsyMTgsNyBAQCBv
ZEAxNDAyMzAwMCB7DQo+ID4gICAgICAgICBwb3dlci1kb21haW5zID0gPCZzY3BzeXMgTVQ4MTcz
X1BPV0VSX0RPTUFJTl9NTT47DQo+ID4gICAgICAgICBjbG9ja3MgPSA8Jm1tc3lzIENMS19NTV9E
SVNQX09EPjsNCj4gPiAgfTsNCj4gPiArDQo+ID4gK2RzYzA6IGRpc3BfZHNjX3dyYXBAMWMwMDkw
MDAgew0KPiA+ICsgICAgICAgLyogU2VlIG1lZGlhdGVrLGRzYy55YW1sIGZvciBkZXRhaWxzICov
DQo+ID4gK307DQo+ID4gLS0NCj4gPiAyLjE4LjANCj4gPiANCi0tIA0KSmFzb24tSkggTGluIDxq
YXNvbi1qaC5saW5AbWVkaWF0ZWsuY29tPg0K

