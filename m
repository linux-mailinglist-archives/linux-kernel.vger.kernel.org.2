Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF9D30F3A6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 14:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236231AbhBDNG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 08:06:27 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:56359 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235605AbhBDNGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 08:06:20 -0500
X-UUID: 6ef6fe6e6c0a402a91e9207d653967c9-20210204
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=xjPlZsUgJ8zWKx32syTlMFFWZeRIUmfEgX2pBjQv40w=;
        b=afrLmZvNlDKffq4yrhcTZuJ9N84I3H93yxx8Vsj1JwuOAZ0KXVuiskN0QoyHRmf4Ov5t/J32K/Txy67eaZgZ7xy9UhGOOni/zP7IB9+TE/LiY8d2DncqN0oxqRDE69VpjEH5NjeWtiyW1c5vIbqoicp4vvi7t8g8M68GxnaQKsw=;
X-UUID: 6ef6fe6e6c0a402a91e9207d653967c9-20210204
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 648410008; Thu, 04 Feb 2021 21:05:34 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 4 Feb 2021 21:05:22 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 4 Feb 2021 21:05:22 +0800
Message-ID: <1612443922.32298.3.camel@mtksdaap41>
Subject: Re: [PATCH v4 4/5] soc: mediatek: pwrap: add pwrap driver for
 MT6873/8192 SoCs
From:   Hsin-hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Fei Shao <fshao@chromium.org>,
        Argus Lin <argus.lin@mediatek.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Date:   Thu, 4 Feb 2021 21:05:22 +0800
In-Reply-To: <CANMq1KBXKQOj=qUMULeJsqy8bvsJLgRniuF2kqzhxpKTWCVq1w@mail.gmail.com>
References: <1605700894-32699-1-git-send-email-hsin-hsiung.wang@mediatek.com>
         <1605700894-32699-5-git-send-email-hsin-hsiung.wang@mediatek.com>
         <CANMq1KBXKQOj=qUMULeJsqy8bvsJLgRniuF2kqzhxpKTWCVq1w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIE1vbiwgMjAyMC0xMi0yMSBhdCAxMDo0MiArMDgwMCwgTmljb2xhcyBCb2ljaGF0
IHdyb3RlOg0KPiBPbiBXZWQsIE5vdiAxOCwgMjAyMCBhdCA4OjA4IFBNIEhzaW4tSHNpdW5nIFdh
bmcNCj4gPGhzaW4taHNpdW5nLndhbmdAbWVkaWF0ZWsuY29tPiB3cm90ZToNCj4gPg0KPiA+IE1U
Njg3My84MTkyIGFyZSBoaWdobHkgaW50ZWdyYXRlZCBTb0NzIGFuZCB1c2UgUE1JQ19NVDYzNTkg
Zm9yDQo+ID4gcG93ZXIgbWFuYWdlbWVudC4gVGhpcyBwYXRjaCBhZGRzIHB3cmFwIG1hc3RlciBk
cml2ZXIgdG8NCj4gPiBhY2Nlc3MgUE1JQ19NVDYzNTkuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBIc2luLUhzaXVuZyBXYW5nIDxoc2luLWhzaXVuZy53YW5nQG1lZGlhdGVrLmNvbT4NCj4gPiAt
LS0NCj4gPiAgZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLXBtaWMtd3JhcC5jIHwgMjkgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDI5IGluc2VydGlv
bnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstcG1p
Yy13cmFwLmMgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstcG1pYy13cmFwLmMNCj4gPiBpbmRl
eCA1Njc4ZjQ2Li5kMWNkMDUwIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvc29jL21lZGlhdGVr
L210ay1wbWljLXdyYXAuYw0KPiA+ICsrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1wbWlj
LXdyYXAuYw0KPiA+IEBAIC02MzIsNiArNjMyLDE3IEBAIHN0YXRpYyBpbnQgbXQ2Nzk3X3JlZ3Nb
XSA9IHsNCj4gPiAgICAgICAgIFtQV1JBUF9EQ01fREJDX1BSRF0gPSAgICAgICAgICAgMHgxRDQs
DQo+ID4gIH07DQo+ID4NCj4gPiArc3RhdGljIGludCBtdDY4NzNfcmVnc1tdID0gew0KPiA+ICsg
ICAgICAgW1BXUkFQX0lOSVRfRE9ORTJdID0gICAgICAgICAgICAweDAsDQo+IA0KPiBJIGRvbid0
IGhhdmUgdGhlIGRhdGFzaGVldCBmb3IgdGhlIFBXUkFQIGludGVyZmFjZSwgaXMgdGhpcyByZWdp
c3Rlcg0KPiBhdCBvZmZzZXQgMHgwIHJlYWw/DQo+IA0KPiBJZiBzbywgSSdtIGNvbmNlcm5lZCB0
aGF0IG10Njg3M19yZWdzIG9ubHkgZGVmaW5lcyB2ZXJ5IGZldyByZWdpc3RlcnMNCj4gb2Zmc2V0
cywgc28gdGhlIGluaXQgY29kZSB3aWxsIGRvIGEgX2xvdF8gd3JpdGVzIGF0IHJlZ2lzdGVyIGFk
ZHJlc3MNCj4gMHgwIChlLmcuIGZvciBhbGwgdGhlIHVuZGVmaW5lZCB2YWx1ZXMgaW4gdGhpcyBh
cnJheTogUFdSQVBfV0FDUzBfRU4sDQo+IFBXUkFQX1dBQ1MxX0VOLCBQV1JBUF9XQUNTMl9FTiwg
ZXRjLCBldGMuKQ0KPiANCg0KVGhlIHJlZ2lzdGVyIGZvciB0aGUgaW5pdF9kb25lIGlzIDB4MC4N
Ckhvd2V2ZXIsIHRoZSBwd3JhcCBkcml2ZXIgb2YgbXQ2ODczIG9ubHkgY2hlY2tzIHRoaXMgcmVn
aXN0ZXIgaW4gdGhlDQpiZWdpbm5pbmcgYW5kIHdvdWxkbid0IGNoZWNrIGl0IGFnYWluLg0KSW4g
b3RoZXIgd29yZHMsIHRoZSAgcmVnaXN0ZXIgaXMgdGhlIGZpcnN0IHJlZ2lzdGVyIHdlIGNoZWNr
LCBzbyBJIHRoaW5rDQp0aGVyZSBpcyBubyBwcm9ibGVtIGZvciBpdC4NCg0KPiA+ICsgICAgICAg
W1BXUkFQX1RJTUVSX0VOXSA9ICAgICAgICAgICAgICAweDNFMCwNCj4gPiArICAgICAgIFtQV1JB
UF9JTlRfRU5dID0gICAgICAgICAgICAgICAgMHg0NDgsDQo+ID4gKyAgICAgICBbUFdSQVBfV0FD
UzJfQ01EXSA9ICAgICAgICAgICAgIDB4QzgwLA0KPiA+ICsgICAgICAgW1BXUkFQX1NXSU5GXzJf
V0RBVEFfMzFfMF0gPSAgICAweEM4NCwNCj4gPiArICAgICAgIFtQV1JBUF9TV0lORl8yX1JEQVRB
XzMxXzBdID0gICAgMHhDOTQsDQo+ID4gKyAgICAgICBbUFdSQVBfV0FDUzJfVkxEQ0xSXSA9ICAg
ICAgICAgIDB4Q0E0LA0KPiA+ICsgICAgICAgW1BXUkFQX1dBQ1MyX1JEQVRBXSA9ICAgICAgICAg
ICAweENBOCwNCj4gPiArfTsNCj4gPiArDQo+ID4gIHN0YXRpYyBpbnQgbXQ3NjIyX3JlZ3NbXSA9
IHsNCj4gPiAgICAgICAgIFtQV1JBUF9NVVhfU0VMXSA9ICAgICAgICAgICAgICAgMHgwLA0KPiA+
ICAgICAgICAgW1BXUkFQX1dSQVBfRU5dID0gICAgICAgICAgICAgICAweDQsDQo+ID4gQEAgLTEw
NTAsNiArMTA2MSw3IEBAIGVudW0gcHdyYXBfdHlwZSB7DQo+ID4gICAgICAgICBQV1JBUF9NVDY3
NjUsDQo+ID4gICAgICAgICBQV1JBUF9NVDY3NzksDQo+ID4gICAgICAgICBQV1JBUF9NVDY3OTcs
DQo+ID4gKyAgICAgICBQV1JBUF9NVDY4NzMsDQo+ID4gICAgICAgICBQV1JBUF9NVDc2MjIsDQo+
ID4gICAgICAgICBQV1JBUF9NVDgxMzUsDQo+ID4gICAgICAgICBQV1JBUF9NVDgxNzMsDQo+ID4g
QEAgLTE1MTIsNiArMTUyNCw3IEBAIHN0YXRpYyBpbnQgcHdyYXBfaW5pdF9jaXBoZXIoc3RydWN0
IHBtaWNfd3JhcHBlciAqd3JwKQ0KPiA+ICAgICAgICAgY2FzZSBQV1JBUF9NVDc2MjI6DQo+ID4g
ICAgICAgICAgICAgICAgIHB3cmFwX3dyaXRlbCh3cnAsIDAsIFBXUkFQX0NJUEhFUl9FTik7DQo+
ID4gICAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+ICsgICAgICAgY2FzZSBQV1JBUF9NVDY4NzM6
DQo+ID4gICAgICAgICBjYXNlIFBXUkFQX01UODE4MzoNCj4gPiAgICAgICAgICAgICAgICAgYnJl
YWs7DQo+ID4gICAgICAgICB9DQo+ID4gQEAgLTE5NDgsNiArMTk2MSwxOSBAQCBzdGF0aWMgY29u
c3Qgc3RydWN0IHBtaWNfd3JhcHBlcl90eXBlIHB3cmFwX210Njc5NyA9IHsNCj4gPiAgICAgICAg
IC5pbml0X3NvY19zcGVjaWZpYyA9IE5VTEwsDQo+ID4gIH07DQo+ID4NCj4gPiArc3RhdGljIGNv
bnN0IHN0cnVjdCBwbWljX3dyYXBwZXJfdHlwZSBwd3JhcF9tdDY4NzMgPSB7DQo+ID4gKyAgICAg
ICAucmVncyA9IG10Njg3M19yZWdzLA0KPiA+ICsgICAgICAgLnR5cGUgPSBQV1JBUF9NVDY4NzMs
DQo+ID4gKyAgICAgICAuYXJiX2VuX2FsbCA9IDB4Nzc3ZiwNCj4gPiArICAgICAgIC5pbnRfZW5f
YWxsID0gQklUKDQpIHwgQklUKDUpLA0KPiA+ICsgICAgICAgLmludDFfZW5fYWxsID0gMCwNCj4g
PiArICAgICAgIC5zcGlfdyA9IFBXUkFQX01BTl9DTURfU1BJX1dSSVRFLA0KPiA+ICsgICAgICAg
LndkdF9zcmMgPSBQV1JBUF9XRFRfU1JDX01BU0tfQUxMLA0KPiA+ICsgICAgICAgLmNhcHMgPSBQ
V1JBUF9DQVBfQVJCLA0KPiA+ICsgICAgICAgLmluaXRfcmVnX2Nsb2NrID0gcHdyYXBfY29tbW9u
X2luaXRfcmVnX2Nsb2NrLA0KPiA+ICsgICAgICAgLmluaXRfc29jX3NwZWNpZmljID0gTlVMTCwN
Cj4gPiArfTsNCj4gPiArDQo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcG1pY193cmFwcGVyX3R5
cGUgcHdyYXBfbXQ3NjIyID0gew0KPiA+ICAgICAgICAgLnJlZ3MgPSBtdDc2MjJfcmVncywNCj4g
PiAgICAgICAgIC50eXBlID0gUFdSQVBfTVQ3NjIyLA0KPiA+IEBAIC0yMDI2LDYgKzIwNTIsOSBA
QCBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBvZl9wd3JhcF9tYXRjaF90YmxbXSA9
IHsNCj4gPiAgICAgICAgICAgICAgICAgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ2Nzk3LXB3
cmFwIiwNCj4gPiAgICAgICAgICAgICAgICAgLmRhdGEgPSAmcHdyYXBfbXQ2Nzk3LA0KPiA+ICAg
ICAgICAgfSwgew0KPiA+ICsgICAgICAgICAgICAgICAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxt
dDY4NzMtcHdyYXAiLA0KPiA+ICsgICAgICAgICAgICAgICAuZGF0YSA9ICZwd3JhcF9tdDY4NzMs
DQo+ID4gKyAgICAgICB9LCB7DQo+ID4gICAgICAgICAgICAgICAgIC5jb21wYXRpYmxlID0gIm1l
ZGlhdGVrLG10NzYyMi1wd3JhcCIsDQo+ID4gICAgICAgICAgICAgICAgIC5kYXRhID0gJnB3cmFw
X210NzYyMiwNCj4gPiAgICAgICAgIH0sIHsNCj4gPiAtLQ0KPiA+IDIuNi40DQo+ID4gX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gPiBMaW51eC1tZWRp
YXRlayBtYWlsaW5nIGxpc3QNCj4gPiBMaW51eC1tZWRpYXRla0BsaXN0cy5pbmZyYWRlYWQub3Jn
DQo+ID4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1t
ZWRpYXRlaw0KDQo=

