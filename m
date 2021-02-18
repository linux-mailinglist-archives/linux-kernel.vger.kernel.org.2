Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E434831E41B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 02:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhBRBlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 20:41:32 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:37736 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230018AbhBRBlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 20:41:12 -0500
X-UUID: 94bbc172c9454c798e324f90ea701acf-20210218
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=nbF4wbalY0JXdc0UwJETh2U33tD0jpNmlPwbPg2Vadc=;
        b=Js8BPCGITmDWf8qF9u0GRVdtVdfmg5vEI+onqsh6ADKqcozBwtF7bzsjiIOpipN3Q6TwTWlpd3CECAQIrqeLyNmKYqzOwMmCDiO+HaH/C69luG8+zx6HyaBg7V0a1Sv97UufqMrz86uTQ7/GKaG/eyaTE8mVdO/w7lnRonhfbTE=;
X-UUID: 94bbc172c9454c798e324f90ea701acf-20210218
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 319589107; Thu, 18 Feb 2021 09:40:29 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 18 Feb 2021 09:40:27 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 18 Feb 2021 09:40:28 +0800
Message-ID: <1613612428.10714.12.camel@mtksdaap41>
Subject: Re: [PATCH v6 01/22] dt-bindings: ARM: Mediatek: Add new document
 bindings of imp i2c wrapper controller
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        "Nicolas Boichat" <drinkcat@chromium.org>,
        <srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Thu, 18 Feb 2021 09:40:28 +0800
In-Reply-To: <010e346c-961b-88bb-aa48-398b23a7fb7a@gmail.com>
References: <1608642587-15634-1-git-send-email-weiyi.lu@mediatek.com>
         <1608642587-15634-2-git-send-email-weiyi.lu@mediatek.com>
         <010e346c-961b-88bb-aa48-398b23a7fb7a@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIxLTAyLTEwIGF0IDEzOjE5ICswMTAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3Rl
Og0KPiANCj4gT24gMjIvMTIvMjAyMCAxNDowOSwgV2VpeWkgTHUgd3JvdGU6DQo+ID4gVGhpcyBw
YXRjaCBhZGRzIHRoZSBuZXcgYmluZGluZyBkb2N1bWVudGF0aW9uIG9mIGltcCBpMmMgd3JhcHBl
ciBjb250cm9sbGVyDQo+ID4gZm9yIE1lZGlhdGVrIE1UODE5Mi4NCj4gDQo+IFRoZSB3cmFwcGVy
IGNvbnRyb2xsZXIgaGFzIG9ubHkgY2xvY2sgcGFydHMsIG9yIGFyZSB0aGUgY2xvY2sgcmVnaXN0
ZXIgbWFwcGVkDQo+IGludG8gdGhlIGkyYyB3cmFwcGVyIGJsb2NrLiBJbiB0aGF0IGNhc2Ugd2Ug
bWlnaHQgd2FudCB0byBwcm9iZSB0aGUgY2xvY2sgZHJpdmVyDQo+IHRocm91Z2ggdGhlIGkyYyB3
cmFwcGVyIGRyaXZlci4NCj4gDQo+IFJlZ2FyZHMsDQo+IE1hdHRoaWFzDQo+IA0KDQpZZXMsIHRo
ZSBjbG9jayByZWdpc3RlcnMgYXJlIG1hcHBlZCBpbnRvIHBhcnRpYWwgb2YgdGhlIGkyYyB3cmFw
cGVyDQpibG9jay4NCkFGQUlLLCB0aGUgaTJjIHdyYXBwZXIgd29ya3Mgd2l0aCB0aGUgaTJjDQpk
cml2ZXIoaTJjL2J1c3Nlcy9pMmMtbXQ2NXh4LmMpIGJ1dCBub3QgYSBuZXcgZHJpdmVyLg0KU28g
ZG8geW91IHN0aWxsIHN1Z2dlc3QgdXMgdG8gcHJvYmUgdGhlIGNsb2NrIGRyaXZlciB0aHJvdWdo
IHRoZSBpMmMNCmRyaXZlcihpMmMvYnVzc2VzL2kyYy1tdDY1eHguYykganVzdCBsaWtlIHRoZSBt
dGstbW0gZHJpdmVyPw0KDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogV2VpeWkgTHUgPHdlaXlp
Lmx1QG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL2FybS9tZWRpYXRlay9tZWRpYXRl
ayxpbXBfaWljX3dyYXAueWFtbCAgICAgICAgfCA3OCArKysrKysrKysrKysrKysrKysrKysrDQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCA3OCBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEw
MDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21lZGlhdGVrL21lZGlh
dGVrLGltcF9paWNfd3JhcC55YW1sDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbWVkaWF0ZWsvbWVkaWF0ZWssaW1wX2lpY193cmFw
LnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21lZGlhdGVrL21l
ZGlhdGVrLGltcF9paWNfd3JhcC55YW1sDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBp
bmRleCAwMDAwMDAwLi41ZDBjZjM3DQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbWVkaWF0ZWsvbWVkaWF0ZWssaW1wX2lp
Y193cmFwLnlhbWwNCj4gPiBAQCAtMCwwICsxLDc4IEBADQo+ID4gKyMgU1BEWC1MaWNlbnNlLUlk
ZW50aWZpZXI6IChHUEwtMi4wIE9SIEJTRC0yLUNsYXVzZSkNCj4gPiArJVlBTUwgMS4yDQo+ID4g
Ky0tLQ0KPiA+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL2FybS9tZWRpYXRl
ay9tZWRpYXRlayxpbXBfaWljX3dyYXAueWFtbCMNCj4gPiArJHNjaGVtYTogaHR0cDovL2Rldmlj
ZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+ID4gKw0KPiA+ICt0aXRsZTogTWVk
aWFUZWsgSU1QIEkyQyBXcmFwcGVyIENvbnRyb2xsZXINCj4gPiArDQo+ID4gK21haW50YWluZXJz
Og0KPiA+ICsgIC0gV2VpeWkgTHUgPHdlaXlpLmx1QG1lZGlhdGVrLmNvbT4NCj4gPiArDQo+ID4g
K2Rlc2NyaXB0aW9uOg0KPiA+ICsgIFRoZSBNZWRpYXRlayBpbXAgaTJjIHdyYXBwZXIgY29udHJv
bGxlciBwcm92aWRlcyBmdW5jdGlvbmFsIGNvbmZpZ3VyYXRpb25zIGFuZCBjbG9ja3MgdG8gdGhl
IHN5c3RlbS4NCj4gPiArDQo+ID4gK3Byb3BlcnRpZXM6DQo+ID4gKyAgY29tcGF0aWJsZToNCj4g
PiArICAgIGl0ZW1zOg0KPiA+ICsgICAgICAtIGVudW06DQo+ID4gKyAgICAgICAgICAtIG1lZGlh
dGVrLG10ODE5Mi1pbXBfaWljX3dyYXBfYw0KPiA+ICsgICAgICAgICAgLSBtZWRpYXRlayxtdDgx
OTItaW1wX2lpY193cmFwX2UNCj4gPiArICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTkyLWltcF9p
aWNfd3JhcF9zDQo+ID4gKyAgICAgICAgICAtIG1lZGlhdGVrLG10ODE5Mi1pbXBfaWljX3dyYXBf
d3MNCj4gPiArICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTkyLWltcF9paWNfd3JhcF93DQo+ID4g
KyAgICAgICAgICAtIG1lZGlhdGVrLG10ODE5Mi1pbXBfaWljX3dyYXBfbg0KPiA+ICsgICAgICAt
IGNvbnN0OiBzeXNjb24NCj4gPiArDQo+ID4gKyAgcmVnOg0KPiA+ICsgICAgbWF4SXRlbXM6IDEN
Cj4gPiArDQo+ID4gKyAgJyNjbG9jay1jZWxscyc6DQo+ID4gKyAgICBjb25zdDogMQ0KPiA+ICsN
Cj4gPiArcmVxdWlyZWQ6DQo+ID4gKyAgLSBjb21wYXRpYmxlDQo+ID4gKyAgLSByZWcNCj4gPiAr
DQo+ID4gK2V4YW1wbGVzOg0KPiA+ICsgIC0gfA0KPiA+ICsgICAgaW1wX2lpY193cmFwX2M6IHN5
c2NvbkAxMTAwNzAwMCB7DQo+ID4gKyAgICAgICAgY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgx
OTItaW1wX2lpY193cmFwX2MiLCAic3lzY29uIjsNCj4gPiArICAgICAgICByZWcgPSA8MCAweDEx
MDA3MDAwIDAgMHgxMDAwPjsNCj4gPiArICAgICAgICAjY2xvY2stY2VsbHMgPSA8MT47DQo+ID4g
KyAgICB9Ow0KPiA+ICsNCj4gPiArICAtIHwNCj4gPiArICAgIGltcF9paWNfd3JhcF9lOiBzeXNj
b25AMTFjYjEwMDAgew0KPiA+ICsgICAgICAgIGNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTky
LWltcF9paWNfd3JhcF9lIiwgInN5c2NvbiI7DQo+ID4gKyAgICAgICAgcmVnID0gPDAgMHgxMWNi
MTAwMCAwIDB4MTAwMD47DQo+ID4gKyAgICAgICAgI2Nsb2NrLWNlbGxzID0gPDE+Ow0KPiA+ICsg
ICAgfTsNCj4gPiArDQo+ID4gKyAgLSB8DQo+ID4gKyAgICBpbXBfaWljX3dyYXBfczogc3lzY29u
QDExZDAzMDAwIHsNCj4gPiArICAgICAgICBjb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5Mi1p
bXBfaWljX3dyYXBfcyIsICJzeXNjb24iOw0KPiA+ICsgICAgICAgIHJlZyA9IDwwIDB4MTFkMDMw
MDAgMCAweDEwMDA+Ow0KPiA+ICsgICAgICAgICNjbG9jay1jZWxscyA9IDwxPjsNCj4gPiArICAg
IH07DQo+ID4gKw0KPiA+ICsgIC0gfA0KPiA+ICsgICAgaW1wX2lpY193cmFwX3dzOiBzeXNjb25A
MTFkMjMwMDAgew0KPiA+ICsgICAgICAgIGNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTkyLWlt
cF9paWNfd3JhcF93cyIsICJzeXNjb24iOw0KPiA+ICsgICAgICAgIHJlZyA9IDwwIDB4MTFkMjMw
MDAgMCAweDEwMDA+Ow0KPiA+ICsgICAgICAgICNjbG9jay1jZWxscyA9IDwxPjsNCj4gPiArICAg
IH07DQo+ID4gKw0KPiA+ICsgIC0gfA0KPiA+ICsgICAgaW1wX2lpY193cmFwX3c6IHN5c2NvbkAx
MWUwMTAwMCB7DQo+ID4gKyAgICAgICAgY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxOTItaW1w
X2lpY193cmFwX3ciLCAic3lzY29uIjsNCj4gPiArICAgICAgICByZWcgPSA8MCAweDExZTAxMDAw
IDAgMHgxMDAwPjsNCj4gPiArICAgICAgICAjY2xvY2stY2VsbHMgPSA8MT47DQo+ID4gKyAgICB9
Ow0KPiA+ICsNCj4gPiArICAtIHwNCj4gPiArICAgIGltcF9paWNfd3JhcF9uOiBzeXNjb25AMTFm
MDIwMDAgew0KPiA+ICsgICAgICAgIGNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTkyLWltcF9p
aWNfd3JhcF9uIiwgInN5c2NvbiI7DQo+ID4gKyAgICAgICAgcmVnID0gPDAgMHgxMWYwMjAwMCAw
IDB4MTAwMD47DQo+ID4gKyAgICAgICAgI2Nsb2NrLWNlbGxzID0gPDE+Ow0KPiA+ICsgICAgfTsN
Cj4gPiANCj4gDQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fDQo+IExpbnV4LW1lZGlhdGVrIG1haWxpbmcgbGlzdA0KPiBMaW51eC1tZWRpYXRla0BsaXN0
cy5pbmZyYWRlYWQub3JnDQo+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtbWVkaWF0ZWsNCg0K

