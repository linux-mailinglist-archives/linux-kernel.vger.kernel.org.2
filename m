Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD97735BA40
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 08:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235860AbhDLGpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 02:45:21 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:41293 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229461AbhDLGpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 02:45:19 -0400
X-UUID: 2c3f69fdd8204c7797f7b2c4841b6c45-20210412
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=6irlN+d9Mb2+ba18MKnOG1SxUR8FvHNgzGMB81pMeE0=;
        b=USQkW+zVIb1Jn2MRjQsE4w46Qvh0jLI4jpdRxirtAC/v5POt3Cj/5YwJv7kxHdKk/6WM+wmZ8tIENDbIDGE+ABjbzimvESgLPol0Svv4dD/P9mkAEfDTda4FoaV3G2k3eSOhFj1Iq7oLNXg9PmftnF0AYLmJ5DNdSXVttugc4GM=;
X-UUID: 2c3f69fdd8204c7797f7b2c4841b6c45-20210412
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <flora.fu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 889678458; Mon, 12 Apr 2021 14:44:58 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 12 Apr 2021 14:44:55 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 12 Apr 2021 14:44:55 +0800
Message-ID: <1618209895.25062.11.camel@mtksdccf07>
Subject: Re: [PATCH 4/8] dt-bindings: arm: mediatek: Add new document
 bindings for APU
From:   Flora Fu <flora.fu@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Pi-Cheng Chen <pi-cheng.chen@mediatek.com>,
        Chiawen Lee <chiawen.lee@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        Flora Fu <flora.fu@mediatek.com>
Date:   Mon, 12 Apr 2021 14:44:55 +0800
In-Reply-To: <20210409182538.GA3913794@robh.at.kernel.org>
References: <1617766086-5502-1-git-send-email-flora.fu@mediatek.com>
         <1617766086-5502-5-git-send-email-flora.fu@mediatek.com>
         <20210409182538.GA3913794@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: FAF44DDF206968B3B76899833A08D826296786249D61A9BED1B4F7C2A51F30DE2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIxLTA0LTA5IGF0IDEzOjI1IC0wNTAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gV2VkLCBBcHIgMDcsIDIwMjEgYXQgMTE6Mjg6MDJBTSArMDgwMCwgRmxvcmEgRnUgd3JvdGU6
DQo+ID4gRG9jdW1lbnQgdGhlIGFwdXN5cyBiaW5kaW5ncy4NCj4gPiANCj4gPiBTaWduZWQtb2Zm
LWJ5OiBGbG9yYSBGdSA8ZmxvcmEuZnVAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4v
YXJtL21lZGlhdGVrL21lZGlhdGVrLGFwdXN5cy55YW1sICAgICAgICAgfCA1NiArKysrKysrKysr
KysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1NiBpbnNlcnRpb25zKCspDQo+ID4gIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21l
ZGlhdGVrL21lZGlhdGVrLGFwdXN5cy55YW1sDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbWVkaWF0ZWsvbWVkaWF0ZWssYXB1c3lz
LnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21lZGlhdGVrL21l
ZGlhdGVrLGFwdXN5cy55YW1sDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAw
MDAwMDAwMDAwMDAuLmRjMDRhNDZmMWJhZA0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21lZGlhdGVrL21lZGlhdGVrLGFw
dXN5cy55YW1sDQo+ID4gQEAgLTAsMCArMSw1NiBAQA0KPiA+ICsjIFNQRFgtTGljZW5zZS1JZGVu
dGlmaWVyOiAoR1BMLTIuMCBPUiBCU0QtMi1DbGF1c2UpDQo+ID4gKyVZQU1MIDEuMg0KPiA+ICst
LS0NCj4gPiArJGlkOiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cDovL2RldmljZXRy
ZWUub3JnL3NjaGVtYXMvYXJtL21lZGlhdGVrL21lZGlhdGVrLGFwdXN5cy55YW1sKl9fO0l3ISFD
VFJOS0E5d01nMEFSYnchM3J5S0ZUQTJDdnNWc3M0UHQyWk9HN3d2NGpnUi0yTFB4dUduMzBJeEZt
cHhveFNSZHpOZGY4RnJBWVl2WldjdyQgDQo+ID4gKyRzY2hlbWE6IGh0dHBzOi8vdXJsZGVmZW5z
ZS5jb20vdjMvX19odHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCpf
XztJdyEhQ1RSTktBOXdNZzBBUmJ3ITNyeUtGVEEyQ3ZzVnNzNFB0MlpPRzd3djRqZ1ItMkxQeHVH
bjMwSXhGbXB4b3hTUmR6TmRmOEZyQVJsaENRMHckIA0KPiA+ICsNCj4gPiArdGl0bGU6IE1lZGlh
VGVrIEFQVVNZUyBDb250cm9sbGVyDQo+ID4gKw0KPiA+ICttYWludGFpbmVyczoNCj4gPiArICAt
IEZsb3JhIEZ1IDxmbG9yYS5mdUBtZWRpYXRlay5jb20+DQo+ID4gKw0KPiA+ICtkZXNjcmlwdGlv
bjoNCj4gPiArICBUaGUgTWVkaWF0ZWsgYXB1c3lzIGNvbnRyb2xsZXIgcHJvdmlkZXMgZnVuY3Rp
b25hbCBjb25maWd1cmF0aW9ucyBhbmQgY2xvY2tzDQo+ID4gKyAgdG8gdGhlIHN5c3RlbS4NCj4g
PiArDQo+ID4gK3Byb3BlcnRpZXM6DQo+ID4gKyAgY29tcGF0aWJsZToNCj4gPiArICAgIGl0ZW1z
Og0KPiA+ICsgICAgICAtIGVudW06DQo+ID4gKyAgICAgICAgICAtIG1lZGlhdGVrLG10ODE5Mi1h
cHVfbWJveA0KPiA+ICsgICAgICAgICAgLSBtZWRpYXRlayxtdDgxOTItYXB1X2Nvbm4NCj4gPiAr
ICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTkyLWFwdV92Y29yZQ0KPiANCj4gcy9fLy0vDQo+IA0K
DQpPSy4gSSB3aWxsIHVwZGF0ZSBleHByZXNzaW9uIHN0cmluZ3MgaW4gdGhlIG5leHQgdmVyc2lv
bi4NCg0KPiA+ICsgICAgICAtIGNvbnN0OiBzeXNjb24NCj4gPiArDQo+ID4gKyAgcmVnOg0KPiA+
ICsgICAgbWF4SXRlbXM6IDENCj4gPiArDQo+ID4gKyAgJyNjbG9jay1jZWxscyc6DQo+ID4gKyAg
ICBjb25zdDogMQ0KPiA+ICsNCj4gPiArcmVxdWlyZWQ6DQo+ID4gKyAgLSBjb21wYXRpYmxlDQo+
ID4gKyAgLSByZWcNCj4gPiArDQo+ID4gK2FkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0KPiA+
ICsNCj4gPiArZXhhbXBsZXM6DQo+ID4gKyAgLSB8DQo+ID4gKyAgICBhcHVfbWJveDogYXB1X21i
b3hAMTkwMDAwMDAgew0KPiANCj4gbWFpbGJveEAuLi4/IElzIHRoaXMgYSBtYWlsYm94IHByb3Zp
ZGVyPw0KPiANCg0KWWVzLCB0aGUgYXB1X21ib3ggaXMgdGhlIGZvciBzZXR1cCBtYWlsYm94IGlu
IHRoZSBBUFUgaGFyZHdhcmUuDQoNCj4gPiArICAgICAgICBjb21wYXRpYmxlID0gIm1lZGlhdGVr
LG10ODE5Mi1hcHVfbWJveCIsICJzeXNjb24iOw0KPiA+ICsgICAgICAgIHJlZyA9IDwweDE5MDAw
MDAwIDB4MTAwMD47DQo+ID4gKyAgICB9Ow0KPiA+ICsNCj4gPiArICAtIHwNCj4gPiArICAgIGFw
dV9jb25uOiBhcHVfY29ubkAxOTAyMDAwMCB7DQo+ID4gKyAgICAgICAgY29tcGF0aWJsZSA9ICJt
ZWRpYXRlayxtdDgxOTItYXB1X2Nvbm4iLCAic3lzY29uIjsNCj4gPiArICAgICAgICByZWcgPSA8
MHgxOTAyMDAwMCAweDEwMDA+Ow0KPiA+ICsgICAgICAgICNjbG9jay1jZWxscyA9IDwxPjsNCj4g
PiArICAgIH07DQo+ID4gKw0KPiA+ICsgIC0gfA0KPiA+ICsgICAgYXB1X3Zjb3JlOiBhcHVfdmNv
cmVAMTkwMjkwMDAgew0KPiA+ICsgICAgICAgIGNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTky
LWFwdV92Y29yZSIsICJzeXNjb24iOw0KPiA+ICsgICAgICAgIHJlZyA9IDwweDE5MDI5MDAwIDB4
MTAwMD47DQo+ID4gKyAgICAgICAgI2Nsb2NrLWNlbGxzID0gPDE+Ow0KPiA+ICsgICAgfTsNCj4g
PiAtLSANCj4gPiAyLjE4LjANCj4gPiANCg0K

