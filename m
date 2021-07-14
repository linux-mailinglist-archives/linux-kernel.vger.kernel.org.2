Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E793C3C91E3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 22:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235762AbhGNURp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 16:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbhGNURl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 16:17:41 -0400
Received: from mx2.securetransport.de (mx2.securetransport.de [IPv6:2a03:4000:13:6c7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFA4C06175F;
        Wed, 14 Jul 2021 13:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1626293633;
        bh=u62i/JJ2Q5UmQ3ZJBwRVwxZWz6ZFbq47acPIhISaOXo=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=gJndAW0ATYOgVEHCjqrhgUgd0wcOXImfnb4/g6vtdW4yX4QvMvFeHeV4lleNqcmzR
         gLfYzbpNvCTDlbkxoY6nGpHPS1vZsMWEcGBQ8Gcboux6q7LGdPbJ338aAmnP9jd29O
         ufkLbZxctLAC4Ldu+3h0NCVCfwzU9Umgx5aSBT4bcujo/X5kCBfMm17jTsE/V6VfCJ
         97ZJ2GV343/QJZjyBc249SY4rKWXvP0BOXtPaZClzXHQ7xxvXWnSt5hg0NF85B1VDa
         5vO1zXjqGuv8Y1o5/D9oiKugVDdSYqRKuQ0r9nRgwmvaF5aWUjsS/+wDeC40JJdC7s
         zI1NuJTbpSgWw==
X-secureTransport-forwarded: yes
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@dh-electronics.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "Marek MV. Vasut" <marex@denx.de>
Subject: RE: [PATCH V2] dt-bindings: arm: fsl: Add DHCOM PicoITX and DHCOM
 DRC02 boards
Thread-Topic: [PATCH V2] dt-bindings: arm: fsl: Add DHCOM PicoITX and DHCOM
 DRC02 boards
Thread-Index: AQHXUXKxVloH3v/6CkGMRLXBETQyyKsBDI+AgBWQzrD//+TigIAicn3wgAj1bYCAAUtcoA==
Date:   Wed, 14 Jul 2021 20:13:41 +0000
Message-ID: <ef31532700834256b6adad98a8ec5442@dh-electronics.com>
References: <20210525143001.9298-1-cniedermaier@dh-electronics.com>
 <20210602195009.GA3870858@robh.at.kernel.org>
 <b765351a7c3542d2a66ab1168f1ff222@dh-electronics.com>
 <bfbd70ca-b5a6-f7a7-4c7d-72ac86874227@denx.de>
 <76d6cc846f4f473083e597303956ff11@dh-electronics.com>
 <20210714022354.GA31370@dragon>
In-Reply-To: <20210714022354.GA31370@dragon>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogU2hhd24gR3VvIFttYWlsdG86c2hhd25ndW9Aa2VybmVsLm9yZ10NClNlbnQ6IFdlZG5l
c2RheSwgSnVseSAxNCwgMjAyMSA0OjI0IEFNDQo+IE9uIFRodSwgSnVsIDA4LCAyMDIxIGF0IDA3
OjM4OjQ0QU0gKzAwMDAsIENocmlzdG9waCBOaWVkZXJtYWllciB3cm90ZToNCj4+IEZyb206IE1h
cmVrIFZhc3V0IFttYWlsdG86bWFyZXhAZGVueC5kZV0NCj4+IFNlbnQ6IFdlZG5lc2RheSwgSnVu
ZSAxNiwgMjAyMSAxOjMzIFBNDQo+Pg0KPj4NCj4+PiBPbiA2LzE2LzIxIDE6MTkgUE0sIENocmlz
dG9waCBOaWVkZXJtYWllciB3cm90ZToNCj4+Pj4gU2VuZCByZXBseSBhbHNvIHRvIFJvYiBIZXJy
aW5ncyArZHQgZW1haWwgYWRkcmVzczoNCj4+Pj4NCj4+Pj4gRnJvbTogUm9iIEhlcnJpbmcgPHJv
YmhAa2VybmVsLm9yZz4NCj4+Pj4gU2VudDogV2VkbmVzZGF5LCBKdW5lIDIsIDIwMjEgOTo1MCBQ
TQ0KPj4+Pg0KPj4+Pj4gT24gVHVlLCBNYXkgMjUsIDIwMjEgYXQgMDQ6MzA6MDFQTSArMDIwMCwg
Q2hyaXN0b3BoIE5pZWRlcm1haWVyIHdyb3RlOg0KPj4+Pj4+IEFkZCBESCBlbGVjdHJvbmljcyBE
SENPTSBQaWNvSVRYIGFuZCBESENPTSBEUkMwMiBib2FyZHMuDQo+Pj4+Pj4NCj4+Pj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBDaHJpc3RvcGggTmllZGVybWFpZXIgPGNuaWVkZXJtYWllckBkaC1lbGVjdHJv
bmljcy5jb20+DQo+Pj4+Pj4gQ2M6IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
Zw0KPj4+Pj4+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+Pj4+Pj4gQ2M6IHJv
YmgrZHRAa2VybmVsLm9yZw0KPj4+Pj4+IENjOiBTaGF3biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5v
cmc+DQo+Pj4+Pj4gQ2M6IGtlcm5lbEBkaC1lbGVjdHJvbmljcy5jb20NCj4+Pj4+PiBUbzogZGV2
aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcNCj4+Pj4+PiAtLS0NCj4+Pj4+PiBWMjogUmVtb3ZlIGxp
bmUgd2l0aCBmc2wsaW14NnMgb24gdGhlIERSQzAyIEJvYXJkDQo+Pj4+Pj4gLS0tDQo+Pj4+Pj4g
ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZzbC55YW1sIHwgMTIgKysr
KysrKysrKysrDQo+Pj4+Pj4gICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKQ0KPj4+
Pj4+DQo+Pj4+Pj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9hcm0vZnNsLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2Zz
bC55YW1sDQo+Pj4+Pj4gaW5kZXggZmNlMmE4NjcwYjQ5Li4zYzRmZjc5YTNiZTcgMTAwNjQ0DQo+
Pj4+Pj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mc2wueWFt
bA0KPj4+Pj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnNs
LnlhbWwNCj4+Pj4+PiBAQCAtNDA3LDYgKzQwNywxMiBAQCBwcm9wZXJ0aWVzOg0KPj4+Pj4+ICAg
ICAgICAgICAgIC0gY29uc3Q6IGRmaSxmczcwMGUtbTYwDQo+Pj4+Pj4gICAgICAgICAgICAgLSBj
b25zdDogZnNsLGlteDZkbA0KPj4+Pj4+DQo+Pj4+Pj4gKyAgICAgIC0gZGVzY3JpcHRpb246IGku
TVg2REwgREhDT00gUGljb0lUWCBCb2FyZA0KPj4+Pj4+ICsgICAgICAgIGl0ZW1zOg0KPj4+Pj4+
ICsgICAgICAgICAgLSBjb25zdDogZGgsaW14NmRsLWRoY29tLXBpY29pdHgNCj4+Pj4+PiArICAg
ICAgICAgIC0gY29uc3Q6IGRoLGlteDZkbC1kaGNvbS1zb20NCj4+Pj4+PiArICAgICAgICAgIC0g
Y29uc3Q6IGZzbCxpbXg2ZGwNCj4+Pj4+PiArDQo+Pj4+Pj4gICAgICAgICAtIGRlc2NyaXB0aW9u
OiBpLk1YNkRMIEdhdGV3b3JrcyBWZW50YW5hIEJvYXJkcw0KPj4+Pj4+ICAgICAgICAgICBpdGVt
czoNCj4+Pj4+PiAgICAgICAgICAgICAtIGVudW06DQo+Pj4+Pj4gQEAgLTQ1OCw2ICs0NjQsMTIg
QEAgcHJvcGVydGllczoNCj4+Pj4+PiAgICAgICAgICAgICAtIGNvbnN0OiB0b3JhZGV4LGNvbGli
cmlfaW14NmRsICAgICAgICAgICMgQ29saWJyaSBpTVg2IE1vZHVsZQ0KPj4+Pj4+ICAgICAgICAg
ICAgIC0gY29uc3Q6IGZzbCxpbXg2ZGwNCj4+Pj4+Pg0KPj4+Pj4+ICsgICAgICAtIGRlc2NyaXB0
aW9uOiBpLk1YNlMgREhDT00gRFJDMDIgQm9hcmQNCj4+Pj4+PiArICAgICAgICBpdGVtczoNCj4+
Pj4+PiArICAgICAgICAgIC0gY29uc3Q6IGRoLGlteDZzLWRoY29tLWRyYzAyDQo+Pj4+Pj4gKyAg
ICAgICAgICAtIGNvbnN0OiBkaCxpbXg2cy1kaGNvbS1zb20NCj4+Pj4+PiArICAgICAgICAgIC0g
Y29uc3Q6IGZzbCxpbXg2ZGwNCj4+Pj4+DQo+Pj4+PiBmc2wsaW14NnM/DQo+Pj4+DQo+Pj4+IElu
IHRoZSBmaXJzdCB2ZXJzaW9uIEkgaGFkIGhlcmUgYW4gYWRkaXRpb25hbCBsaW5lIHdpdGggImZz
bCxpbXg2cyIsDQo+Pj4+IGJ1dCBjdXJyZW50bHkgdGhlIGtlcm5lbCBpc24ndCBzdXBwb3J0aW5n
IHRoYXQgY29tcGF0aWJsZS4gVGhlIGkuTVg2DQo+Pj4+IFNvbG8gaXMgY3VycmVudGx5IHN1cHBv
cnRlZCBieSAiZnNsLGlteDZkbCIuIFNvIG15IGlkZWEgd2FzIHRvIGFkZA0KPj4+PiBib3RoICJm
c2wsaW14NmRsIiBhbmQgImZzbCxpbXg2cyIgdG8gbWF0Y2ggaXQgbWF5YmUgb24gYSBsYXRlciBr
ZXJuZWwNCj4+Pj4gdmVyc2lvbi4gSWYgdGhlcmUgaXMgbm8gbWF0Y2ggd2l0aCB0aGUgU29sbyBu
b3csIGl0IHdpbGwgZmFsbCBiYWNrIHRvDQo+Pj4+IHRoZSBpLk1YNiBEdWFsTGl0ZS4gVGhhdCBp
cyB3aHkgSSBoYWQgYm90aCBmc2wsaW14NnMgYW5kIGZzbCxpbXg2ZGwNCj4+Pj4gaW4gdGhhdCBv
cmRlci4gT24gRmFiaW8ncyBhZHZpY2UsIEkgcmVtb3ZlZCB0aGUgbGluZSB3aXRoICJmc2wsaW14
NnMiDQo+Pj4+IGluIHZlcnNpb24gMi4NCj4+Pj4gSXMgdGhpcyB3aGF0IHlvdSBtZWFudCBieSB5
b3VyIGNvbW1lbnQ/DQo+Pj4NCj4+PiBJIGRpZG4ndCBub3RpY2UgdGhhdCBhdCBmaXJzdCBteXNl
bGYsIGJ1dCBJIHRoaW5rIHdoYXQgUm9iIG1lYW5zIGlzDQo+Pj4NCj4+PiAtIGNvbnN0OiBkaCxp
bXg2cy1kaGNvbS1kcmMwMg0KPj4+IC0gY29uc3Q6IGRoLGlteDZzLWRoY29tLXNvbQ0KPj4+IC0g
Y29uc3Q6IGZzbCxpbXg2ZGwgPC0tLS0tLSB0aGlzIHNob3VsZCBiZSBjb25zaXN0ZW50IHdpdGgg
dGhlIHR3byBhYm92ZQ0KPj4+DQo+Pj4gdGhhdCBpcw0KPj4+DQo+Pj4gICAtIGNvbnN0OiBkaCxp
bXg2cy1kaGNvbS1kcmMwMg0KPj4+ICAgLSBjb25zdDogZGgsaW14NnMtZGhjb20tc29tDQo+Pj4g
LS0gY29uc3Q6IGZzbCxpbXg2ZGwNCj4+PiArLSBjb25zdDogZnNsLGlteDZzDQo+Pj4gICAgICAg
ICAgICAgICAgXl5eXl4NCj4+Pg0KPj4+IEJ1dCB0aGF0IGlzIGEgYml0IG9kZCBoZXJlOg0KPj4+
IC0gVGhlIE1YNlMgaXMgTVg2REwgd2l0aCBvbmUgQ1BVIGNvcmUgZGlzYWJsZWQuDQo+Pj4gLSBU
aGUgRFJDMDIgZGV2aWNlIGNhbiBvbmx5IGhvdXNlIGEgU09NIHdpdGggTVg2UyBhbmQgTk9UIHdp
dGggTVg2REwNCj4+PiAoZHVlIHRvIHNvbWUgdGhlcm1hbCBkZXNpZ24gY29uc2lkZXJhdGlvbiBv
ciBzb21ldGhpbmcpLg0KPj4+IC0gVGhlIGtlcm5lbCBkaXNjZXJucyB0aGUgTVg2Uy9NWDZETCBh
dXRvbWF0aWNhbGx5IGJhc2VkIG9uIHRoZSBudW1iZXINCj4+PiBvZiBjb3JlcyBpdCByZWFkcyBm
cm9tIHNvbWUgcmVnaXN0ZXIsIHRoZXJlZm9yZSBpdCBvbmx5IGhhcyB0aGUNCj4+PiBmc2wsbXg2
ZGwgY29tcGF0aWJsZSB0byBjb3ZlciBib3RoIE1YNlMgYW5kIE1YNkRMLg0KPj4+IFNvLCB0aGUg
Y2xvc2VzdCBmYWxsYmFjayBjb21wYXRpYmxlIGZvciB0aGlzIGRldmljZSByZWFsbHkgaXMgdGhl
IE1YNkRMLA0KPj4+IGkuZS4gZnNsLGlteDZkbC4NCj4+Pg0KPj4+IFNvIEkgdGhpbmsgdGhpcyBw
YXRjaCBpcyBjb3JyZWN0IGFzLWlzLCBubyA/DQo+Pg0KPj4gSXMgdGhpcyBQYXRjaCBPSz8NCj4g
DQo+IENhbiB3ZSBleHBsYWluIHRoYXQgZnNsLGlteDZzIHRoaW5nIGEgYml0IHdpdGggc29tZSBj
b21tZW50cyBvciBjb21taXQNCj4gbG9nPw0KPiANCj4gU2hhd24NCg0KSSB3aWxsIHNlbmQgYSB2
ZXJzaW9uIDMuDQoNClJlZ2FyZHMNCkNocmlzdG9waA0K
