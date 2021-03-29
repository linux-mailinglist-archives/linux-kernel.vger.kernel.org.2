Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A9934C201
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 04:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhC2Cn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 22:43:58 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:47707 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229645AbhC2Cnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 22:43:45 -0400
X-UUID: ba8d9d0072f64f21b8b94c1e2b2571df-20210329
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=kj2IZXnFWq11xR83R2MHUqWLzvGkxFI7jPQHlaf8NJw=;
        b=Ho0zEKcUO6GGEiLtE4doTklZlF1mgK7T6Nq2jUiPgeWAu5FzIjwX8qY/Ase99HVqhFInCSepHZJDegbq0OtR0+Jf0Wi/t3GbdSlR7SkKzMvP+kc52f/1LKZoFCFmfKFr8qrRKfxbqA3kKEJM/c3KOXgrfq/GyiJAjSeiQCjcgdg=;
X-UUID: ba8d9d0072f64f21b8b94c1e2b2571df-20210329
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <nina-cm.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1356876876; Mon, 29 Mar 2021 10:43:39 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 29 Mar 2021 10:43:38 +0800
Received: from [172.21.84.99] (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 29 Mar 2021 10:43:38 +0800
Message-ID: <1616985818.26412.9.camel@mtksdccf07>
Subject: Re: [PATCH 1/2] dt-bindings: devapc: Update bindings
From:   Nina Wu <nina-cm.wu@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Neal Liu <neal.liu@mediatek.com>,
        DTML <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        <Jackson-kt.Chang@mediatek.com>
Date:   Mon, 29 Mar 2021 10:43:38 +0800
In-Reply-To: <CAAOTY_-8W57Pid9N9kJO0iBNkmRh_sSf_E3hzewxojZ3GAnG2w@mail.gmail.com>
References: <1616743871-8087-1-git-send-email-nina-cm.wu@mediatek.com>
         <CAAOTY_-8W57Pid9N9kJO0iBNkmRh_sSf_E3hzewxojZ3GAnG2w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIENodW4tS3VhbmcNCg0KT24gU2F0LCAyMDIxLTAzLTI3IGF0IDAwOjE4ICswODAwLCBDaHVu
LUt1YW5nIEh1IHdyb3RlOg0KPiBIaSwgTmluYToNCj4gDQo+IE5pbmEgV3UgPG5pbmEtY20ud3VA
bWVkaWF0ZWsuY29tPiDmlrwgMjAyMeW5tDPmnIgyNuaXpSDpgLHkupQg5LiL5Y2IMzozNOWvq+mB
k++8mg0KPiA+DQo+ID4gRnJvbTogTmluYSBXdSA8TmluYS1DTS5XdUBtZWRpYXRlay5jb20+DQo+
ID4NCj4gPiBUbyBzdXBwb3J0IG5ld2VyIGhhcmR3YXJlIGFyY2hpdGVjdHVyZSBvZiBkZXZhcGMs
DQo+ID4gdXBkYXRlIGRldmljZSB0cmVlIGJpbmRpbmdzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1i
eTogTmluYSBXdSA8TmluYS1DTS5XdUBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9tZWRpYXRlay9kZXZhcGMueWFtbCAgIHwgNDEgKysrKysr
KysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNDEgaW5zZXJ0aW9ucygrKQ0K
PiA+DQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9z
b2MvbWVkaWF0ZWsvZGV2YXBjLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3Mvc29jL21lZGlhdGVrL2RldmFwYy55YW1sDQo+ID4gaW5kZXggMzFlNGQzYy4uNDg5ZjZhOSAx
MDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc29jL21l
ZGlhdGVrL2RldmFwYy55YW1sDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3NvYy9tZWRpYXRlay9kZXZhcGMueWFtbA0KPiA+IEBAIC0yMCw5ICsyMCwyNyBAQCBw
cm9wZXJ0aWVzOg0KPiA+ICAgIGNvbXBhdGlibGU6DQo+ID4gICAgICBlbnVtOg0KPiA+ICAgICAg
ICAtIG1lZGlhdGVrLG10Njc3OS1kZXZhcGMNCj4gPiArICAgICAgLSBtZWRpYXRlayxtdDgxOTIt
ZGV2YXBjDQo+ID4gKw0KPiA+ICsgIHZlcnNpb246DQo+ID4gKyAgICBkZXNjcmlwdGlvbjogVGhl
IHZlcnNpb24gb2YgdGhlIGhhcmR3YXJlIGFyY2hpdGVjdHVyZQ0KPiA+ICsgICAgJHJlZjogL3Nj
aGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyDQo+ID4gKyAgICBlbnVtOiBbMSwg
Ml0NCj4gPiArICAgIG1heEl0ZW1zOiAxDQo+ID4gKw0KPiA+ICsgIHNsYXZlX3R5cGVfbnVtOg0K
PiA+ICsgICAgZGVzY3JpcHRpb246IFRoZSBudW1iZXIgb2YgdGhlIGRldmFwYyBzZXQNCj4gPiAr
ICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMg0KPiA+ICsg
ICAgZW51bTogWzEsIDRdDQo+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+DQo+ID4gICAgcmVnOg0K
PiA+ICAgICAgZGVzY3JpcHRpb246IFRoZSBiYXNlIGFkZHJlc3Mgb2YgZGV2YXBjIHJlZ2lzdGVy
IGJhbmsNCj4gPiArICAgIG1heEl0ZW1zOiA0DQo+ID4gKw0KPiA+ICsgIHZpb19pZHhfbnVtOg0K
PiA+ICsgICAgZGVzY3JpcHRpb246IFRoZSBudW1iZXIgb2YgdGhlIGRldmljZXMgY29udHJvbGxl
ZCBieSBkZXZhcGMNCj4gPiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRp
b25zL3VpbnQzMi1hcnJheQ0KPiA+ICAgICAgbWF4SXRlbXM6IDENCj4gPg0KPiA+ICAgIGludGVy
cnVwdHM6DQo+ID4gQEAgLTM5LDcgKzU3LDEwIEBAIHByb3BlcnRpZXM6DQo+ID4NCj4gPiAgcmVx
dWlyZWQ6DQo+ID4gICAgLSBjb21wYXRpYmxlDQo+ID4gKyAgLSB2ZXJzaW9uDQo+ID4gKyAgLSBz
bGF2ZV90eXBlX251bQ0KPiA+ICAgIC0gcmVnDQo+ID4gKyAgLSB2aW9faWR4X251bQ0KPiA+ICAg
IC0gaW50ZXJydXB0cw0KPiA+ICAgIC0gY2xvY2tzDQo+ID4gICAgLSBjbG9jay1uYW1lcw0KPiA+
IEBAIC01Myw4ICs3NCwyOCBAQCBleGFtcGxlczoNCj4gPg0KPiA+ICAgICAgZGV2YXBjOiBkZXZh
cGNAMTAyMDcwMDAgew0KPiA+ICAgICAgICBjb21wYXRpYmxlID0gIm1lZGlhdGVrLG10Njc3OS1k
ZXZhcGMiOw0KPiA+ICsgICAgICB2ZXJzaW9uID0gPDE+Ow0KPiANCj4gSSB0aGluayB2ZXJzaW9u
IGlzIHJlZHVuZGFudC4gRm9yIGV4YW1wbGUsIGlmIG10MDAwMS1kZXZhcGMgaXMNCj4gaWRlbnRp
Y2FsIHRvIG10Njc3OS1kZXZhcGMsIGl0cyBjb21wYXRpYmxlIHNob3VsZCBiZQ0KPiANCj4gY29t
cGF0aWJsZSA9ICJtZWRpYXRlayxtdDAwMDEtZGV2YXBjIiwgIm1lZGlhdGVrLG10Njc3OS1kZXZh
cGMiOw0KPiANCj4gSW4gZHJpdmVyLCBvbmx5IGtlZXAgY29tcGF0aWJsZSBmb3IgbXQ2Nzc5IGFu
ZCBubyBtdDAwMDEgYmVjYXVzZQ0KPiBtdDAwMDEgaXMgaWRlbnRpY2FsIHRvIG10Njc3OS4NCj4g
SW4gcHJvYmUgc2VxdWVuY2UsIHRyeSBmaXJzdCBjb21wYXRpYmxlIHN0cmluZw0KPiAibWVkaWF0
ZWssbXQwMDAxLWRldmFwYyIsIGJ1dCBpdCBkb2VzIG5vdCBleGlzdCBpbiBkcml2ZXIsIHNvIHRy
eSBuZXh0DQo+IGNvbXBhdGlibGUgc3RyaW5nICJtZWRpYXRlayxtdDY3NzktZGV2YXBjIiBhbmQg
bWF0Y2guDQo+IFNvIG10MDAwMS1kZXZhcGMgd291bGQgd29yayBhcyBtdDY3NzktZGV2YXBjLg0K
PiANCg0KSSB0aGluayB0aGUgdmVyc2lvbiBpcyBzdGlsbCBuZWVkZWQuDQpCZWNhdXNlIHRoZXJl
IGlzIGxpdHRsZSBkaWZmZXJlbmNlIGluIHRoZSByZWdpc3RlcnMgd2hpY2ggc2F2ZSBkZWJ1Zw0K
aW5mby4NCg0KDQo+ID4gKyAgICAgIHNsYXZlX3R5cGVfbnVtID0gPDE+Ow0KPiA+ICAgICAgICBy
ZWcgPSA8MHgxMDIwNzAwMCAweDEwMDA+Ow0KPiA+ICsgICAgICB2aW9faWR4X251bSA9IDw1MTE+
Ow0KPiA+ICAgICAgICBpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMTY4IElSUV9UWVBFX0xFVkVMX0xP
Vz47DQo+ID4gICAgICAgIGNsb2NrcyA9IDwmaW5mcmFjZmdfYW8gQ0xLX0lORlJBX0RFVklDRV9B
UEM+Ow0KPiA+ICAgICAgICBjbG9jay1uYW1lcyA9ICJkZXZhcGMtaW5mcmEtY2xvY2siOw0KPiA+
ICAgICAgfTsNCj4gPiArICAtIHwNCj4gPiArICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9pbnRl
cnJ1cHQtY29udHJvbGxlci9hcm0tZ2ljLmg+DQo+ID4gKyAgICAjaW5jbHVkZSA8ZHQtYmluZGlu
Z3MvY2xvY2svbXQ4MTkyLWNsay5oPg0KPiA+ICsNCj4gPiArICAgIGRldmFwYzogZGV2YXBjQDEw
MjA3MDAwIHsNCj4gPiArICAgICAgICBjb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5Mi1kZXZh
cGMiOw0KPiA+ICsgICAgICAgIHZlcnNpb24gPSA8Mj47DQo+ID4gKyAgICAgICAgc2xhdmVfdHlw
ZV9udW0gPSA8ND47DQo+ID4gKyAgICAgICAgcmVnID0gPDAgMHgxMDIwNzAwMCAwIDB4MTAwMD4s
DQo+ID4gKyAgICAgICAgICAgIDwwIDB4MTAyNzQwMDAgMCAweDEwMDA+LA0KPiA+ICsgICAgICAg
ICAgICA8MCAweDEwMjc1MDAwIDAgMHgxMDAwPiwNCj4gPiArICAgICAgICAgICAgPDAgMHgxMTAy
MDAwMCAwIDB4MTAwMD47DQo+ID4gKyAgICAgICAgdmlvX2lkeF9udW0gPSA8MzY3IDI5MiAyNDIg
NTg+Ow0KPiA+ICsgICAgICAgIGludGVycnVwdHMgPSA8R0lDX1NQSSAxODcgSVJRX1RZUEVfTEVW
RUxfSElHSD47DQo+ID4gKyAgICAgICAgY2xvY2tzID0gPCZpbmZyYWNmZ19hbyBDTEtfSU5GUkFf
REVWSUNFX0FQQz47DQo+ID4gKyAgICAgICAgY2xvY2stbmFtZXMgPSAiZGV2YXBjLWluZnJhLWNs
b2NrIjsNCj4gPiArICAgIH07DQo+IA0KPiBJdCBsb29rcyBsaWtlIHRoYXQgdGhlcmUgYXJlIDQg
ZGV2YXBjIGRldmljZSBpbiBtdDgxOTIuDQo+IFRoZXNlIDQgZGV2aWNlIHdvcmsgaW5kZXBlbmRl
bnRseSwgc28gSSB3b3VsZCBsaWtlIHRvIGRlY291cGxlIHRoZW0NCj4gcmF0aGVyIHRoYW4gY291
cGxlIHRoZW0uDQo+IA0KPiBkZXZhcGMwOiBkZXZhcGNAMTAyMDcwMDAgew0KPiAgICAgY29tcGF0
aWJsZSA9ICJtZWRpYXRlayxtdDgxOTItZGV2YXBjIjsNCj4gICAgIHJlZyA9IDwwIDB4MTAyMDcw
MDAgMCAweDEwMDA+Ow0KPiAgICAgdmlvX2lkeF9udW0gPSA8MzY3PjsNCj4gICAgIC4uLg0KPiB9
Ow0KPiANCj4gZGV2YXBjMTogZGV2YXBjQDEwMjc0MDAwIHsNCj4gICAgIGNvbXBhdGlibGUgPSAi
bWVkaWF0ZWssbXQ4MTkyLWRldmFwYyI7DQo+ICAgICByZWcgPSA8MCAweDEwMjc0MDAwIDAgMHgx
MDAwPjsNCj4gICAgIHZpb19pZHhfbnVtID0gPDI5Mj47DQo+ICAgICAuLi4NCj4gfTsNCj4gDQo+
IGRldmFwYzI6IGRldmFwY0AxMDI3NTAwMCB7DQo+ICAgICBjb21wYXRpYmxlID0gIm1lZGlhdGVr
LG10ODE5Mi1kZXZhcGMiOw0KPiAgICAgcmVnID0gPDAgMHgxMDI3NTAwMCAwIDB4MTAwMD47DQo+
ICAgICB2aW9faWR4X251bSA9IDwyNDI+Ow0KPiAgICAgLi4uDQo+IH07DQo+IA0KPiBkZXZhcGMz
OiBkZXZhcGNAMTEwMjAwMDAgew0KPiAgICAgY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxOTIt
ZGV2YXBjIjsNCj4gICAgIHJlZyA9IDwwIDB4MTEwMjAwMDAgMCAweDEwMDA+Ow0KPiAgICAgdmlv
X2lkeF9udW0gPSA8NTg+Ow0KPiAgICAgLi4uDQo+IH07DQo+IA0KDQpJIHdpbGwgdHJ5IHRoaXMg
d2l0aCBzaGFyZWQgSVJRIGFuZCByZS1zdWJtaXQgYW5vdGhlciB2ZXJzaW9uLg0KDQoNCj4gUmVn
YXJkcywNCj4gQ2h1bi1LdWFuZy4NCj4gDQo+ID4gLS0NCj4gPiAyLjYuNA0KPiA+IF9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+ID4gTGludXgtbWVkaWF0
ZWsgbWFpbGluZyBsaXN0DQo+ID4gTGludXgtbWVkaWF0ZWtAbGlzdHMuaW5mcmFkZWFkLm9yZw0K
PiA+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW1lZGlhdGVrX187ISFDVFJOS0E5d01nMEFSYnchMDJq
dEhFU2RYaWtuZlFLRkMtSXFrVUpPdVdFamVFLUdNcXdrM1JtUE1tM19ULVh2OXBtVWs5Wm9pMmUy
a3ZYam9LYyQgDQoNCg==

