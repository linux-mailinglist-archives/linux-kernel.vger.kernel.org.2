Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 026253E9039
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237506AbhHKMNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:13:08 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:58260 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S237410AbhHKMNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:13:07 -0400
X-UUID: e67f6b01412b48e989e03dc7bc688cc2-20210811
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=wozoe7kFjE8qPjz1M4fr5WJfU/E/RA/En/zjFHWQWkw=;
        b=Sejl83A0OmWHSJ1DtKCGwFt7Wfc2mJ41D/kz8HlxOU0fproBCcFihfCuS0pxIvRCYVHBhWZ4bWpeXTo6V5MPVrR1upSEp2LwfQG/gZD+gQKz9mogO9NxUGFQpUwZflbRpHhSd46EdNsLVrd/G5ZdFyRpvSe22FCc98iOhbnNCJM=;
X-UUID: e67f6b01412b48e989e03dc7bc688cc2-20210811
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 204538102; Wed, 11 Aug 2021 20:12:40 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 11 Aug 2021 20:12:38 +0800
Received: from mtksdccf07 (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 11 Aug 2021 20:12:38 +0800
Message-ID: <ba4174599b40b5cc2f6397bb9b8772f75b945365.camel@mediatek.com>
Subject: Re: [v6 2/2] arm64: dts: mediatek: Correct UART0 bus clock of MT8192
From:   Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Ikjoon Jang <ikjn@chromium.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Wed, 11 Aug 2021 20:12:38 +0800
In-Reply-To: <913973ef-e3ee-5015-a010-b436fe620e1c@gmail.com>
References: <20210727023205.20319-1-chun-jie.chen@mediatek.com>
         <20210727023205.20319-3-chun-jie.chen@mediatek.com>
         <CAATdQgC-X6pijkgTBsWJJKp__J6N=7JNKHQJmOMvTAjivwPM5w@mail.gmail.com>
         <a48525422d4c953a2dac2a907895c20b9fd6d232.camel@mediatek.com>
         <913973ef-e3ee-5015-a010-b436fe620e1c@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIxLTA4LTA1IGF0IDE3OjQ0ICswMjAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3Rl
Og0KPiANCj4gT24gMzAvMDcvMjAyMSAwNDo0MywgQ2h1bi1KaWUgQ2hlbiB3cm90ZToNCj4gPiBP
biBXZWQsIDIwMjEtMDctMjggYXQgMTQ6MTQgKzA4MDAsIElram9vbiBKYW5nIHdyb3RlOg0KPiA+
ID4gSGksDQo+ID4gPiANCj4gPiA+IE9uIFR1ZSwgSnVsIDI3LCAyMDIxIGF0IDEwOjQzIEFNIENo
dW4tSmllIENoZW4NCj4gPiA+IDxjaHVuLWppZS5jaGVuQG1lZGlhdGVrLmNvbT4gd3JvdGU6DQo+
ID4gPiA+IA0KPiA+ID4gPiBpbmZyYV91YXJ0MCBjbG9jayBpcyB0aGUgcmVhbCBvbmUgd2hhdCB1
YXJ0MCB1c2VzIGFzIGJ1cyBjbG9jay4NCj4gPiA+ID4gDQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6
IFdlaXlpIEx1IDx3ZWl5aS5sdUBtZWRpYXRlay5jb20+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6
IENodW4tSmllIENoZW4gPGNodW4tamllLmNoZW5AbWVkaWF0ZWsuY29tPg0KPiA+ID4gPiAtLS0N
Cj4gPiA+ID4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTkyLmR0c2kgfCAyICst
DQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkN
Cj4gPiA+ID4gDQo+ID4gPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlh
dGVrL210ODE5Mi5kdHNpDQo+ID4gPiA+IGIvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9t
dDgxOTIuZHRzaQ0KPiA+ID4gPiBpbmRleCBjN2M3ZDRlMDE3YWUuLjk4MTBmMWQ0NDFkYSAxMDA2
NDQNCj4gPiA+ID4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxOTIuZHRz
aQ0KPiA+ID4gPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5Mi5kdHNp
DQo+ID4gPiA+IEBAIC0zMjcsNyArMzI3LDcgQEANCj4gPiA+ID4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICJtZWRpYXRlayxtdDY1NzctdWFydCI7DQo+ID4gPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgIHJlZyA9IDwwIDB4MTEwMDIwMDAgMCAweDEwMDA+Ow0KPiA+ID4g
PiAgICAgICAgICAgICAgICAgICAgICAgICBpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMTA5DQo+ID4g
PiA+IElSUV9UWVBFX0xFVkVMX0hJR0ggMD47DQo+ID4gPiA+IC0gICAgICAgICAgICAgICAgICAg
ICAgIGNsb2NrcyA9IDwmY2xrMjZtPiwgPCZjbGsyNm0+Ow0KPiA+ID4gPiArICAgICAgICAgICAg
ICAgICAgICAgICBjbG9ja3MgPSA8JmNsazI2bT4sIDwmaW5mcmFjZmcNCj4gPiA+ID4gQ0xLX0lO
RlJBX1VBUlQwPjsNCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgY2xvY2stbmFtZXMg
PSAiYmF1ZCIsICJidXMiOw0KPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICBzdGF0dXMg
PSAiZGlzYWJsZWQiOw0KPiA+ID4gPiAgICAgICAgICAgICAgICAgfTsNCj4gPiA+IA0KPiA+ID4g
VGhlcmUncmUgbWFueSBvdGhlciBub2RlcyBzdGlsbCBoYXZpbmcgb25seSBjbGsyNm0uIFdpbGwg
eW91DQo+ID4gPiB1cGRhdGUNCj4gPiA+IHRoZW0gdG9vPw0KPiA+ID4gDQo+ID4gDQo+ID4gT3Ro
ZXJzIHdpbGwgYmUgdXBkYXRlZCBieSBJUCBvd25lci4NCj4gPiANCj4gDQo+IEFzIGl0IHNlZW1z
IHdlIHdpbGwgaGF2ZSBzb21lIHRpbWUgYmVmb3JlIHRoaXMgY2FuIGJlIG1lcmdlZCwgY291bGQN
Cj4geW91IGhlbHANCj4gd29yayB3aXRoIHRoZSBvdGhlciBJUCBvd25lcnMgdG8gZ2V0IG9uZSBi
aWcgcGF0Y2ggdGhhdCB1cGRhdGVzIGFsbA0KPiBjbG9ja3M/DQo+IA0KPiBUaGFua3MgYSBsb3Qs
DQo+IE1hdHRoaWFzDQo+IA0KDQpPaywgSSB3aWxsIHVwZGF0ZSBhbGwgY2xvY2sgc2V0dGluZyAo
dWFydC9ub3JfZmxhc2gvaTJjL3NwaSkgaW4NCm10ODE5Mi5kdHNpIGF0IHRoZSBsYXRlc3Qga2Vy
bmVsIHZlcnNpb24uIERpZCB5b3Ugc3VnZ2VzdCB0byBtZXJnZSBhbGwNCnRvIG9uZSBwYXRjaCBv
ciBzZXBhcmF0ZSB0byBkaWZmZXJlbnQgcGF0Y2hlcyBidXQgcHV0IGluIHNhbWUNCnNlcmllcz8N
Cg0KQmVzdCBSZWdhcmRzLA0KQ2h1bi1KaWUNCg0KPiA+IEJlc3QgUmVnYXJkcywNCj4gPiBDaHVu
LUppZQ0KPiA+IA0KPiA+ID4gPiAtLQ0KPiA+ID4gPiAyLjE4LjANCj4gPiA+ID4gX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gPiA+ID4gTGludXgtbWVk
aWF0ZWsgbWFpbGluZyBsaXN0DQo+ID4gPiA+IExpbnV4LW1lZGlhdGVrQGxpc3RzLmluZnJhZGVh
ZC5vcmcNCj4gPiA+ID4gDQo+ID4gDQo+ID4gDQpodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19f
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1tZWRpYXRl
a19fOyEhQ1RSTktBOXdNZzBBUmJ3ITFiSXo2WDJFaUZiaWdDSW16UW1icXRleklGZmwxTFJCdVBP
WVRxQmRsNXdmeDhiLXpwMHpRUDY4UjdSaGFJY0FBWFhGJA0KPiA+ID4gPiAgDQo=

