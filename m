Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7F013BA3B6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 19:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhGBRoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 13:44:46 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:53165 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229455AbhGBRop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 13:44:45 -0400
X-UUID: 25a63eb8ebbc4918912bc611a5dc5f62-20210703
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=W3mE1N6NI3osqqcQy+E1z3volKwDBN0BeypQrroDM1M=;
        b=mNkERxTXO2mhw9YslIko/EncRE9voatsfxdSGzoDF0e9e7FqLWDOQxKjOaP16rOTvVem7cR9TCc5NQ4+xZcYG/7cr1eHCrqNcsgIy+a621wUwbbjNi1woWsOUTanANfebBlispyyMivE9jZiq2zoyWNfc6vNRT4DcosXV8IQxO8=;
X-UUID: 25a63eb8ebbc4918912bc611a5dc5f62-20210703
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1516597151; Sat, 03 Jul 2021 01:42:10 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 3 Jul 2021 01:42:01 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 3 Jul 2021 01:42:01 +0800
Message-ID: <06acd9a411edaf4dd3db4344646ca1e1875c8f0b.camel@mediatek.com>
Subject: Re: [PATCH v1 3/5] arm64: dts: mt8195: add gce node
From:   Jason-JH Lin <jason-jh.lin@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Sat, 3 Jul 2021 01:42:01 +0800
In-Reply-To: <CAAOTY_9B1L=1=LzdC_1_czFgc4smH0hTk0B=XCquH08KAjx_nA@mail.gmail.com>
References: <20210630051418.14044-1-jason-jh.lin@mediatek.com>
         <20210630051418.14044-4-jason-jh.lin@mediatek.com>
         <CAAOTY_9B1L=1=LzdC_1_czFgc4smH0hTk0B=XCquH08KAjx_nA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIxLTA3LTAxIGF0IDA3OjIxICswODAwLCBDaHVuLUt1YW5nIEh1IHdyb3RlOg0K
PiBIaSwgSmFzb246DQo+IA0KPiBqYXNvbi1qaC5saW4gPGphc29uLWpoLmxpbkBtZWRpYXRlay5j
b20+IOaWvCAyMDIx5bm0NuaciDMw5pelIOmAseS4iSDkuIvljYgxOjE45a+r6YGT77yaDQo+ID4g
DQo+ID4gYWRkIGdjZSBub2RlIG9uIGR0cyBmaWxlLg0KPiA+IA0KPiA+IENoYW5nZS1JZDogSTgw
NTQ1NWNiN2M2NDVjYjVhMjRjZTFjODdmZTg5MWE4MDcwNjkxMjMNCj4gPiBTaWduZWQtb2ZmLWJ5
OiBqYXNvbi1qaC5saW4gPGphc29uLWpoLmxpbkBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4g
VGhpcyBwYXRjaCBpcyBiYXNlZCBvbiBbMV0NCj4gPiBbMV0gQWRkIE1lZGlhdGVrIFNvQyBNVDgx
OTUgYW5kIGV2YWx1YXRpb24gYm9hcmQgZHRzIGFuZCBNYWtlZmlsZQ0KPiA+ICAgICAtIA0KPiA+
IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tZWRpYXRlay9wYXRj
aC8yMDIxMDYwMTA3NTM1MC4zMTUxNS0yLXNlaXlhLndhbmdAbWVkaWF0ZWsuY29tLw0KPiA+IC0t
LQ0KPiA+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5NS5kdHNpIHwgMjENCj4g
PiArKysrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIxIGluc2VydGlv
bnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRl
ay9tdDgxOTUuZHRzaQ0KPiA+IGIvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxOTUu
ZHRzaQ0KPiA+IGluZGV4IGMxNDZhOTFjNjI3Mi4uMzgwNTQxOTZlZWE0IDEwMDY0NA0KPiA+IC0t
LSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTk1LmR0c2kNCj4gPiArKysgYi9h
cmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5NS5kdHNpDQo+ID4gQEAgLTYsNiArNiw3
IEBADQo+ID4gDQo+ID4gIC9kdHMtdjEvOw0KPiA+ICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvY2xv
Y2svbXQ4MTk1LWNsay5oPg0KPiA+ICsjaW5jbHVkZSA8ZHQtYmluZGluZ3MvZ2NlL210ODE5NS1n
Y2UuaD4NCj4gPiAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL2Fy
bS1naWMuaD4NCj4gPiAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVy
L2lycS5oPg0KPiA+ICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvcG93ZXIvbXQ4MTk1LXBvd2VyLmg+
DQo+ID4gQEAgLTcxNyw2ICs3MTgsMjYgQEANCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAj
Y2xvY2stY2VsbHMgPSA8MT47DQo+ID4gICAgICAgICAgICAgICAgIH07DQo+ID4gDQo+ID4gKyAg
ICAgICAgICAgICAgIGdjZTA6IG1kcF9tYWlsYm94QDEwMzIwMDAwIHsNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICBjb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5NS1nY2UiOw0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgIHJlZyA9IDwwIDB4MTAzMjAwMDAgMCAweDQwMDA+Ow0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgIGludGVycnVwdHMgPSA8R0lDX1NQSSAyMjYNCj4gPiBJ
UlFfVFlQRV9MRVZFTF9ISUdIIDA+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICNtYm94
LWNlbGxzID0gPDM+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGNsb2NrcyA9IDwmaW5m
cmFjZmdfYW8gQ0xLX0lORlJBX0FPX0dDRT4sDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgPCZpbmZyYWNmZ19hbyBDTEtfSU5GUkFfQU9fR0NFMj47DQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgY2xvY2stbmFtZXMgPSAiZ2NlIiwgImdjZTEiOw0KPiA+ICsgICAgICAg
ICAgICAgICB9Ow0KPiA+ICsNCj4gPiArICAgICAgICAgICAgICAgZ2NlMTogZGlzcF9tYWlsYm94
QDEwMzMwMDAwIHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gIm1l
ZGlhdGVrLG10ODE5NS1nY2UiOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHJlZyA9IDww
IDB4MTAzMzAwMDAgMCAweDQwMDA+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGludGVy
cnVwdHMgPSA8R0lDX1NQSSAyMjgNCj4gPiBJUlFfVFlQRV9MRVZFTF9ISUdIIDA+Ow0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgICNtYm94LWNlbGxzID0gPDM+Ow0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgIGNsb2NrcyA9IDwmaW5mcmFjZmdfYW8gQ0xLX0lORlJBX0FPX0dDRT4sDQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPCZpbmZyYWNmZ19hbyBDTEtfSU5G
UkFfQU9fR0NFMj47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgY2xvY2stbmFtZXMgPSAi
Z2NlIiwgImdjZTEiOw0KPiANCj4gSSB0aGluayBlYWNoIGdjZSBjb3VsZCBiZSBicm9rZW4gaW50
byB0d28gZnVuY3Rpb24gYmxvY2ssIHRoZSBjb3JlDQo+IGZ1bmN0aW9uIGJsb2NrIGFuZCBldmVu
dCBwcm9jZXNzaW5nIGJsb2NrLg0KPiBFYWNoIGJsb2NrIGhhcyBpbmRlcGVuZGVudCBjbG9jayBz
b3VyY2UgYW5kICJnY2UiIGlzIGZvciBjb3JlDQo+IGZ1bmN0aW9uDQo+IGJsb2NrIGFuZCAiZ2Nl
MSIgaXMgZm9yIGV2ZW50IHByb2Nlc3NpbmcgYmxvY2ssIGlzIGl0Pw0KPiBJZiBzbywgdGhlIGNv
cmUgZnVuY3Rpb24gb2YgZ2NlMCBhbmQgZ2NlMSBoYXMgY29tbW9uIGNsb2NrIHNvdXJjZQ0KPiAo
PCZpbmZyYWNmZ19hbyBDTEtfSU5GUkFfQU9fR0NFPiksIHJpZ2h0Pw0KPiANCj4gUmVnYXJkcywN
Cj4gQ2h1bi1LdWFuZy4NCj4gDQo+ID4gKyAgICAgICAgICAgICAgIH07DQo+ID4gKw0KPiA+ICAg
ICAgICAgICAgICAgICB1YXJ0MDogc2VyaWFsQDExMDAxMTAwIHsNCj4gPiAgICAgICAgICAgICAg
ICAgICAgICAgICBjb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5NS11YXJ0IiwNCj4gPiAibWVk
aWF0ZWssbXQ2NTc3LXVhcnQiOw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIHJlZyA9IDww
IDB4MTEwMDExMDAgMCAweDEwMD47DQo+ID4gLS0NCj4gPiAyLjE4LjANCj4gPiANCmdjZTAgYW5k
IGdjZTEgYXJlIHR3byBkdXBsaWNhdGUgaGFyZHdhcmUgbm9kZSBlYWNoIG9mIHRoZW0gaGF2ZSB0
aGllcg0Kb3duIGNvcmUgZnVuY3Rpb24gYmxvY2sgYW5kIGV2ZW50IHByb2NjZXNzaW5nIGJsb2Nr
Lg0KVGhlIGNsb2NrczogPCZpbmZyYWNmZ19hbyBDTEtfSU5GUkFfQU9fR0NFPiBpcyBmb3IgZ2Nl
MCwNCjwmaW5mcmFjZmdfYW8gQ0xLX0lORlJBX0FPX0dDRTI+IGlzIGZvciBnY2UxLg0KDQpGb3Ig
dGhlIGRlc2lnbiBvZiBHQ0UgaGFyZHdhcmUgZXZlbnQgc2lnbmFsIHRyYW5zcG9ydGF0aW9uLCBl
YWNoIGNtZHENCm1haWxib3ggc2hvdWxkIGVuYWJsZSBvciBkaXNhYmxlIHRoZSBvdGhlciBnY2Ug
Y2xrIGF0IHRoZSBzYW1lIHRpbWUuDQoNCkkgcHV0IHR3byBjbG9jayBzb3VyY2UgaW4gb25lIGdj
ZSBub2RlIHNvIHRoYXQgSSBjYW4gZ2V0IGJvdGggb2YgdGhlbQ0KZWFzaWVyIHdoZW4gZWFjaCBj
bWRxIGRyaXZlciBwcm9iZS4NCkJ1dCBJIHRoaW5rIHRha2Ugb3V0IHRoZSBvdGhlciBnY2UgY2xr
IGZvciBlYWNoIGdjZSBub2RlIGlzIGZpbmUuDQpJIHdpbGwgbW9kaWZ5IGl0IGF0IHRoZSBuZXh0
IHBhdGNoIHZlcnNpb24uDQoNClJlZ2FyZHMsDQpKYXNvbi1KSC5MaW4uDQotLSANCkphc29uLUpI
IExpbiA8amFzb24tamgubGluQG1lZGlhdGVrLmNvbT4NCg==

