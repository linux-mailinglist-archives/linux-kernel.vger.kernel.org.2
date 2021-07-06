Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 470943BC4B4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 04:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhGFCIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 22:08:41 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:33967 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229740AbhGFCIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 22:08:40 -0400
X-UUID: 472610ff395d4a51b35425899b9bca9f-20210706
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=rM/FDzGlB2uXisLxyE0DK9a6bsODNzTQuW4tR72IG4M=;
        b=jeCiLS2C66R2mdNDwZZYVLRHWvA/5tAbywjdK1stt9cqztSizA/Sj1hTeWZ/Yi7EtNijctvYuEceNOSjsY27eIia43tY47Y8W9QABcg2/9lMm9A+51IrMAEuoTOOQGTpc8uKByW3taiTbyX9xScsrdAykaaVAMqOUdXQVs3gV3s=;
X-UUID: 472610ff395d4a51b35425899b9bca9f-20210706
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1065779401; Tue, 06 Jul 2021 10:05:59 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 6 Jul 2021 10:05:57 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 6 Jul 2021 10:05:57 +0800
Message-ID: <50ff125023425b58ba86eb50df51c34cea5ab7d8.camel@mediatek.com>
Subject: Re: [v12 02/20] dt-bindings: ARM: Mediatek: Add mmsys document
 binding for MT8192
From:   Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Tue, 6 Jul 2021 10:05:57 +0800
In-Reply-To: <15d27282-54b2-2cfe-7f44-2df3be11dd40@gmail.com>
References: <20210705033824.1934-1-chun-jie.chen@mediatek.com>
         <20210705033824.1934-3-chun-jie.chen@mediatek.com>
         <564fa3c8-1d85-5e98-f3f9-f83cb17e905a@gmail.com>
         <15d27282-54b2-2cfe-7f44-2df3be11dd40@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTA3LTA1IGF0IDE3OjQ1ICswMjAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3Rl
Og0KPiBPbiAwNS8wNy8yMDIxIDE3OjQwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3RlOg0KPiA+IA0K
PiA+IA0KPiA+IE9uIDA1LzA3LzIwMjEgMDU6MzgsIENodW4tSmllIENoZW4gd3JvdGU6DQo+ID4g
PiBUaGlzIHBhdGNoIGFkZHMgdGhlIG1tc3lzIGRvY3VtZW50IGJpbmRpbmcgZm9yIE1UODE5MiBT
b0MuDQo+ID4gPiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6IENodW4tSmllIENoZW4gPGNodW4tamll
LmNoZW5AbWVkaWF0ZWsuY29tPg0KPiA+IA0KPiA+IFJldmlld2VkLWJ5OiBNYXR0aGlhcyBCcnVn
Z2VyIDxtYXR0aGlhcy5iZ2dAZ21haWwuY29tPg0KPiA+IA0KPiANCj4gT2YgY291cnNlLCB0aGF0
J3Mgbm90IHdoYXQgd2UgbmVlZCBoZXJlLi4uDQo+IA0KPiBOb3cgcHVzaGVkIHRvIHY1LjE0LXRt
cC9kdHM2NCB1bnRpbCB2NS4xNC1yYzEgaXMgcmVsZWFzZWQuDQo+IA0KPiBUaGFua3MhDQo+IE1h
dHRoaWFzDQo+IA0KDQpJIHNlZSBzb21lIGRpc2N1c3Npb24gaW4gWzFdIGFuZCBjaGVjayB0aGUg
aW1wbGVtZW50IG9mIGFmZQ0KZHJpdmVyKHNvYy9tZWRpYXRlay9tdDgxOTIvbXQ4MTkyLWFmZS1w
Y20uYykNClRoZSBhdWRzeXMgc2hvdWQgYmUgZG9jdW1lbnRlZCBpbiBtZWRpYXRlayxhdWRzeXMu
dHh0DQpJIHdpbGwgc2VuZCB2MTMgdG8gYXBwbHkgaXQgYW5kIHVwZGF0ZSBkdHMgWzJdLA0Kc29y
cnkgZm9yIHRoZSBpbmNvbnZlbmllbmNlLg0KDQpbMV0NCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5l
bC5vcmcvcHJvamVjdC9saW51eC1tZWRpYXRlay9wYXRjaC8yMDIxMDYzMDE4MDY1Mi4xLkk4OGE1
MjY0NGU0N2U4OGIxNWY1ZGI5ODQxY2IwODRkYzUzYzU4NzVjQGNoYW5nZWlkLw0KWzJdDQpodHRw
czovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtbWVkaWF0ZWsvY292ZXIvMjAy
MTA2MTYwMTE1NTEuMjk2NTQtMS1jaHVuLWppZS5jaGVuQG1lZGlhdGVrLmNvbS8NCg0KQmVzdCBS
ZWdhcmRzLA0KQ2h1bi1KaWUNCj4gPiA+IC0tLQ0KPiA+ID4gIC4uLi9kZXZpY2V0cmVlL2JpbmRp
bmdzL2FybS9tZWRpYXRlay9tZWRpYXRlayxtbXN5cy50eHQgICAgICAgICANCj4gPiA+ICB8IDEg
Kw0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiA+ID4gDQo+ID4gPiBk
aWZmIC0tZ2l0DQo+ID4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0v
bWVkaWF0ZWsvbWVkaWF0ZWssbW1zeXMudA0KPiA+ID4geHQNCj4gPiA+IGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tZWRpYXRlay9tZWRpYXRlayxtbXN5cy50DQo+ID4g
PiB4dA0KPiA+ID4gaW5kZXggNzhjNTA3MzM5ODVjLi45NzEyYTY4MzFmYWIgMTAwNjQ0DQo+ID4g
PiAtLS0NCj4gPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tZWRp
YXRlay9tZWRpYXRlayxtbXN5cy50DQo+ID4gPiB4dA0KPiA+ID4gKysrDQo+ID4gPiBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbWVkaWF0ZWsvbWVkaWF0ZWssbW1zeXMu
dA0KPiA+ID4geHQNCj4gPiA+IEBAIC0xNiw2ICsxNiw3IEBAIFJlcXVpcmVkIFByb3BlcnRpZXM6
DQo+ID4gPiAgCS0gIm1lZGlhdGVrLG10ODE2Ny1tbXN5cyIsICJzeXNjb24iDQo+ID4gPiAgCS0g
Im1lZGlhdGVrLG10ODE3My1tbXN5cyIsICJzeXNjb24iDQo+ID4gPiAgCS0gIm1lZGlhdGVrLG10
ODE4My1tbXN5cyIsICJzeXNjb24iDQo+ID4gPiArCS0gIm1lZGlhdGVrLG10ODE5Mi1tbXN5cyIs
ICJzeXNjb24iDQo+ID4gPiAgLSAjY2xvY2stY2VsbHM6IE11c3QgYmUgMQ0KPiA+ID4gIA0KPiA+
ID4gIEZvciB0aGUgY2xvY2sgY29udHJvbCwgdGhlIG1tc3lzIGNvbnRyb2xsZXIgdXNlcyB0aGUg
Y29tbW9uIGNsaw0KPiA+ID4gYmluZGluZyBmcm9tDQo+ID4gPiANCj4gDQo+IA0K

