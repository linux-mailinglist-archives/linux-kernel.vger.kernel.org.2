Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEEDC3617F0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 05:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235250AbhDPDBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 23:01:42 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:58561 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234548AbhDPDBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 23:01:40 -0400
X-UUID: 1bdd5d1b344c4fc6b909347dc6b1f5c4-20210416
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=MTAy3dK7ZeeTqAFn6CDQfuUe2LUsEJXiuvm05pj0FSo=;
        b=KRDqCfuCAN6kvJxmqjtLn83qxuYVTBV73wN+hQvJ1XYN5LqOOoEAAqan8vhDhjUutIHtyhD9x4/nf/+aDSwMY3gspbcx6XqVn0iuCm/rBJvLIeUhPJNX4pSf8dq0mieRUMtOJ7KBdA6WAsC8flmh1UPN3JvDWzMA9YEtnvKNrVw=;
X-UUID: 1bdd5d1b344c4fc6b909347dc6b1f5c4-20210416
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <flora.fu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 24531458; Fri, 16 Apr 2021 11:01:13 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 16 Apr 2021 11:01:10 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 16 Apr 2021 11:01:10 +0800
Message-ID: <1618542070.27491.15.camel@mtksdccf07>
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
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>
Date:   Fri, 16 Apr 2021 11:01:10 +0800
In-Reply-To: <CAL_JsqLKaYY=NHm1hD=YaQgvDOBTtraoUqcycA7tu7n-f2GVDw@mail.gmail.com>
References: <1617766086-5502-1-git-send-email-flora.fu@mediatek.com>
         <1617766086-5502-5-git-send-email-flora.fu@mediatek.com>
         <20210409182538.GA3913794@robh.at.kernel.org>
         <1618209895.25062.11.camel@mtksdccf07>
         <CAL_JsqLKaYY=NHm1hD=YaQgvDOBTtraoUqcycA7tu7n-f2GVDw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 9F4E1F87D3F9E72542DAD2DF050407D939B7DB684CFA915AFE9C5AC433219D722000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIxLTA0LTE1IGF0IDE2OjI0IC0wNTAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gTW9uLCBBcHIgMTIsIDIwMjEgYXQgMTo0NSBBTSBGbG9yYSBGdSA8ZmxvcmEuZnVAbWVkaWF0
ZWsuY29tPiB3cm90ZToNCj4gPg0KPiA+IE9uIEZyaSwgMjAyMS0wNC0wOSBhdCAxMzoyNSAtMDUw
MCwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+ID4gPiBPbiBXZWQsIEFwciAwNywgMjAyMSBhdCAxMToy
ODowMkFNICswODAwLCBGbG9yYSBGdSB3cm90ZToNCj4gPiA+ID4gRG9jdW1lbnQgdGhlIGFwdXN5
cyBiaW5kaW5ncy4NCj4gPiA+ID4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogRmxvcmEgRnUgPGZs
b3JhLmZ1QG1lZGlhdGVrLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICAuLi4vYXJtL21lZGlh
dGVrL21lZGlhdGVrLGFwdXN5cy55YW1sICAgICAgICAgfCA1NiArKysrKysrKysrKysrKysrKysr
DQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgNTYgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gPiAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbWVk
aWF0ZWsvbWVkaWF0ZWssYXB1c3lzLnlhbWwNCj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdpdCBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbWVkaWF0ZWsvbWVkaWF0ZWss
YXB1c3lzLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21lZGlh
dGVrL21lZGlhdGVrLGFwdXN5cy55YW1sDQo+ID4gPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+
ID4gPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uZGMwNGE0NmYxYmFkDQo+ID4gPiA+IC0tLSAvZGV2
L251bGwNCj4gPiA+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Fy
bS9tZWRpYXRlay9tZWRpYXRlayxhcHVzeXMueWFtbA0KPiA+ID4gPiBAQCAtMCwwICsxLDU2IEBA
DQo+ID4gPiA+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMCBPUiBCU0QtMi1D
bGF1c2UpDQo+ID4gPiA+ICslWUFNTCAxLjINCj4gPiA+ID4gKy0tLQ0KPiA+ID4gPiArJGlkOiBo
dHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMv
YXJtL21lZGlhdGVrL21lZGlhdGVrLGFwdXN5cy55YW1sKl9fO0l3ISFDVFJOS0E5d01nMEFSYnch
M3J5S0ZUQTJDdnNWc3M0UHQyWk9HN3d2NGpnUi0yTFB4dUduMzBJeEZtcHhveFNSZHpOZGY4RnJB
WVl2WldjdyQNCj4gPiA+ID4gKyRzY2hlbWE6IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19o
dHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCpfXztJdyEhQ1RSTktB
OXdNZzBBUmJ3ITNyeUtGVEEyQ3ZzVnNzNFB0MlpPRzd3djRqZ1ItMkxQeHVHbjMwSXhGbXB4b3hT
UmR6TmRmOEZyQVJsaENRMHckDQo+ID4gPiA+ICsNCj4gPiA+ID4gK3RpdGxlOiBNZWRpYVRlayBB
UFVTWVMgQ29udHJvbGxlcg0KPiA+ID4gPiArDQo+ID4gPiA+ICttYWludGFpbmVyczoNCj4gPiA+
ID4gKyAgLSBGbG9yYSBGdSA8ZmxvcmEuZnVAbWVkaWF0ZWsuY29tPg0KPiA+ID4gPiArDQo+ID4g
PiA+ICtkZXNjcmlwdGlvbjoNCj4gPiA+ID4gKyAgVGhlIE1lZGlhdGVrIGFwdXN5cyBjb250cm9s
bGVyIHByb3ZpZGVzIGZ1bmN0aW9uYWwgY29uZmlndXJhdGlvbnMgYW5kIGNsb2Nrcw0KPiA+ID4g
PiArICB0byB0aGUgc3lzdGVtLg0KPiA+ID4gPiArDQo+ID4gPiA+ICtwcm9wZXJ0aWVzOg0KPiA+
ID4gPiArICBjb21wYXRpYmxlOg0KPiA+ID4gPiArICAgIGl0ZW1zOg0KPiA+ID4gPiArICAgICAg
LSBlbnVtOg0KPiA+ID4gPiArICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTkyLWFwdV9tYm94DQo+
ID4gPiA+ICsgICAgICAgICAgLSBtZWRpYXRlayxtdDgxOTItYXB1X2Nvbm4NCj4gPiA+ID4gKyAg
ICAgICAgICAtIG1lZGlhdGVrLG10ODE5Mi1hcHVfdmNvcmUNCj4gPiA+DQo+ID4gPiBzL18vLS8N
Cj4gPiA+DQo+ID4NCj4gPiBPSy4gSSB3aWxsIHVwZGF0ZSBleHByZXNzaW9uIHN0cmluZ3MgaW4g
dGhlIG5leHQgdmVyc2lvbi4NCj4gPg0KPiA+ID4gPiArICAgICAgLSBjb25zdDogc3lzY29uDQo+
ID4gPiA+ICsNCj4gPiA+ID4gKyAgcmVnOg0KPiA+ID4gPiArICAgIG1heEl0ZW1zOiAxDQo+ID4g
PiA+ICsNCj4gPiA+ID4gKyAgJyNjbG9jay1jZWxscyc6DQo+ID4gPiA+ICsgICAgY29uc3Q6IDEN
Cj4gPiA+ID4gKw0KPiA+ID4gPiArcmVxdWlyZWQ6DQo+ID4gPiA+ICsgIC0gY29tcGF0aWJsZQ0K
PiA+ID4gPiArICAtIHJlZw0KPiA+ID4gPiArDQo+ID4gPiA+ICthZGRpdGlvbmFsUHJvcGVydGll
czogZmFsc2UNCj4gPiA+ID4gKw0KPiA+ID4gPiArZXhhbXBsZXM6DQo+ID4gPiA+ICsgIC0gfA0K
PiA+ID4gPiArICAgIGFwdV9tYm94OiBhcHVfbWJveEAxOTAwMDAwMCB7DQo+ID4gPg0KPiA+ID4g
bWFpbGJveEAuLi4/IElzIHRoaXMgYSBtYWlsYm94IHByb3ZpZGVyPw0KPiA+ID4NCj4gPg0KPiA+
IFllcywgdGhlIGFwdV9tYm94IGlzIHRoZSBmb3Igc2V0dXAgbWFpbGJveCBpbiB0aGUgQVBVIGhh
cmR3YXJlLg0KPiANCj4gVGhlbiB5b3UgbmVlZCAjbWJveC1jZWxscyBoZXJlLg0KPiANCj4gQW5k
IGluIHRoYXQgY2FzZSwgd2hhdCBtYWtlcyBpdCBhIHN5c2Nvbj8NCj4gDQpUaGUgYXB1X21ib3gg
YXJlIHJlZ2lzdGVycyBmb3Igc2V0dXAgbWFpbCBib3ggY29tbXVuaWNhdGlvbnMgYmV0d2VlbiBh
cHUNCnByb2Nlc3NvciBhbmQgdGhlIEFQIHNpZGUga2VybmVsIGRyaXZlcnMuIEl0IGFsc28gaGFz
IHNwYXJlIHJlZ2lzdGVycw0KdGhhdCByZXNlcnZlZCBmb3Iga2VlcCBzcGVjaWZpYyBpbmZvcm1h
dGlvbiBiZXR3ZWVuIGFwdSBhbmQgQVAgc2lkZS4NClRoYXQncyB3aHkgSSBzZXQgaXQgYXMgc3lz
Y29uIHRvIGF2b2lkIGlvcmVtYXAgZnJvbSB1c2Vycy4gRG8geW91IHRoaW5rDQppdCBpcyByZWFz
b25hYmxlIG9yIGl0IGlzIGJldHRlciB0byBiZSBrZXB0IGluc2lkZSB0aGUgdXNlciBub2RlcyB3
aGVuDQp1c2luZyBpdD8NCg0KPiA+DQo+ID4gPiA+ICsgICAgICAgIGNvbXBhdGlibGUgPSAibWVk
aWF0ZWssbXQ4MTkyLWFwdV9tYm94IiwgInN5c2NvbiI7DQo+ID4gPiA+ICsgICAgICAgIHJlZyA9
IDwweDE5MDAwMDAwIDB4MTAwMD47DQo+ID4gPiA+ICsgICAgfTsNCg0K

