Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3CA539D44B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 07:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbhFGFWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 01:22:40 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:50523 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229436AbhFGFWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 01:22:39 -0400
X-UUID: ddb6eafa474e4f78994749b7a036ff31-20210607
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=DmcodQK5B9rdSagRlyQ6T+J2oEgd2at//Gi+EqIPmDM=;
        b=TBxMYrJGqW3JOYq0EOhj8hZED0AvDJH+Dbzea1IKq79PHjdkJzT9k+XzWxZD2mXrKmhPRj/KAs9SZr1kMHFANNoLcg0hvivpRavTKQJGrtuohKFhFPwy8A71OwGoB64jCmlq7UmKhQ7X87D5Hy4zOXi2SOw28gFqIt3id3mVGPE=;
X-UUID: ddb6eafa474e4f78994749b7a036ff31-20210607
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1468748950; Mon, 07 Jun 2021 13:20:45 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 7 Jun 2021 13:20:43 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 7 Jun 2021 13:20:44 +0800
Message-ID: <66e017401ab93aa02c5d2bbf11be9589b36649ac.camel@mediatek.com>
Subject: Re: [PATCH v9 01/22] dt-bindings: ARM: Mediatek: Add new document
 bindings of imp i2c wrapper controller
From:   Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Date:   Mon, 7 Jun 2021 13:20:43 +0800
In-Reply-To: <20210602171201.GA3566462@robh.at.kernel.org>
References: <20210524122053.17155-1-chun-jie.chen@mediatek.com>
         <20210524122053.17155-2-chun-jie.chen@mediatek.com>
         <20210602171201.GA3566462@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIxLTA2LTAyIGF0IDEyOjEyIC0wNTAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gTW9uLCBNYXkgMjQsIDIwMjEgYXQgMDg6MjA6MzJQTSArMDgwMCwgQ2h1bi1KaWUgQ2hlbiB3
cm90ZToNCj4gPiBUaGlzIHBhdGNoIGFkZHMgdGhlIG5ldyBiaW5kaW5nIGRvY3VtZW50YXRpb24g
b2YgaW1wIGkyYyB3cmFwcGVyDQo+ID4gY29udHJvbGxlcg0KPiA+IGZvciBNZWRpYXRlayBNVDgx
OTIuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogV2VpeWkgTHUgPHdlaXlpLmx1QG1lZGlhdGVr
LmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBjaHVuLWppZS5jaGVuIDxjaHVuLWppZS5jaGVuQG1l
ZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL2FybS9tZWRpYXRlay9tZWRpYXRlayxpbXBf
aWljX3dyYXAueWFtbCAgIHwgODANCj4gPiArKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmls
ZSBjaGFuZ2VkLCA4MCBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+
IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbWVkaWF0ZWsvbWVkaWF0ZWss
aW1wX2lpY193cmENCj4gPiBwLnlhbWwNCj4gPiANCj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21lZGlhdGVrL21lZGlhdGVrLGltcF9p
aWNfdw0KPiA+IHJhcC55YW1sDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvYXJtL21lZGlhdGVrL21lZGlhdGVrLGltcF9paWNfdw0KPiA+IHJhcC55YW1sDQo+ID4gbmV3
IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLmZiNmNiOWU2MGVlMg0K
PiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9hcm0vbWVkaWF0ZWsvbWVkaWF0ZWssaW1wX2lpY193DQo+ID4gcmFwLnlhbWwN
Cj4gPiBAQCAtMCwwICsxLDgwIEBADQo+ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChH
UEwtMi4wIE9SIEJTRC0yLUNsYXVzZSkNCj4gPiArJVlBTUwgMS4yDQo+ID4gKy0tLQ0KPiA+ICsk
aWQ6IA0KPiA+IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL2FybS9tZWRpYXRlay9tZWRp
YXRlayxpbXBfaWljX3dyYXAueWFtbCMNCj4gPiArJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUu
b3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+ID4gKw0KPiA+ICt0aXRsZTogTWVkaWFUZWsg
SU1QIEkyQyBXcmFwcGVyIENvbnRyb2xsZXINCj4gPiArDQo+ID4gK21haW50YWluZXJzOg0KPiA+
ICsgIC0gQ2h1bi1KaWUgQ2hlbiA8Y2h1bi1qaWUuY2hlbkBtZWRpYXRlay5jb20+DQo+ID4gKw0K
PiA+ICtkZXNjcmlwdGlvbjoNCj4gPiArICBUaGUgTWVkaWF0ZWsgaW1wIGkyYyB3cmFwcGVyIGNv
bnRyb2xsZXIgcHJvdmlkZXMgZnVuY3Rpb25hbA0KPiA+IGNvbmZpZ3VyYXRpb25zIGFuZCBjbG9j
a3MgdG8gdGhlIHN5c3RlbS4NCj4gPiArDQo+ID4gK3Byb3BlcnRpZXM6DQo+ID4gKyAgY29tcGF0
aWJsZToNCj4gPiArICAgIGl0ZW1zOg0KPiA+ICsgICAgICAtIGVudW06DQo+ID4gKyAgICAgICAg
ICAtIG1lZGlhdGVrLG10ODE5Mi1pbXBfaWljX3dyYXBfYw0KPiA+ICsgICAgICAgICAgLSBtZWRp
YXRlayxtdDgxOTItaW1wX2lpY193cmFwX2UNCj4gPiArICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4
MTkyLWltcF9paWNfd3JhcF9zDQo+ID4gKyAgICAgICAgICAtIG1lZGlhdGVrLG10ODE5Mi1pbXBf
aWljX3dyYXBfd3MNCj4gPiArICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTkyLWltcF9paWNfd3Jh
cF93DQo+ID4gKyAgICAgICAgICAtIG1lZGlhdGVrLG10ODE5Mi1pbXBfaWljX3dyYXBfbg0KPiAN
Cj4gTG9va3MgdG8gbWUgbGlrZSB0aGVzZSBhcmUgYWxsIHRoZSBzYW1lIGgvdywgYnV0IGp1c3Qg
aGF2ZSBkaWZmZXJpbmcgDQo+IHNldHMgb2YgY2xvY2tzLiBUaGF0J3Mgbm90IHJlYWxseSBhIHJl
YXNvbiB0byBoYXZlIGRpZmZlcmVudCANCj4gY29tcGF0aWJsZXMuIA0KPiANCj4gSWYgeW91IG5l
ZWQgdG8ga25vdyB3aGF0IGNsb2NrcyBhcmUgcHJlc2VudCwgeW91IGNhbiB3YWxrIHRoZSBEVCBm
b3IgDQo+IGFsbCAnY2xvY2tzJyBwcm9wZXJ0aWVzIG1hdGNoaW5nIHRoaXMgY2xvY2sgY29udHJv
bGxlciBpbnN0YW5jZS4gT3INCj4gdXNlIA0KPiAnY2xvY2staW5kaWNlcycgdG8gZGVmaW5lIHdo
aWNoIG9uZXMgYXJlIHByZXNlbnQuDQo+IA0KPiBSb2INCg0KU29tZSBtb2R1bGUgaXMgZGl2aWRl
ZCB0byBzdWItbW9kdWxlcyB3aGljaCBhcmUgZGVzaWduZWQgaW4gZGlmZmVyZW50DQpoL3cgYmxv
Y2tzIGZvciBkaWZmZXJlbnQgdXNhZ2UsIGFuZCBpZiB3ZSB3YW50IHRvIHVzZSB0aGUgc2FtZQ0K
Y29tcGF0aWJsZSB0byBwcmVzZW50IHRoZXNlIGgvdyBibG9ja3MsIHdlIG5lZWQgdG8gbW92ZSB0
aGUgY2xvY2sgZGF0YQ0KcHJvdmlkZWQgYnkgdGhlc2UgaC93IGJsb2NrcyB0byBkdHMsIGJ1dCB3
ZSB1c3VhbGx5IHVzZSBkaWZmZXJlbnQNCmNvbXBhdGlibGUgdG8gZ2V0IHRoZSBoL3cgYmxvY2tz
IGRhdGEgaW4NCk1lZGlhdGVrJ3MgY2xvY2sgZHJpdmVyLCBzbyBkbyB5b3Ugc3VnZ2VzdCB0byBy
ZWdpc3RlciBjbG9jayBwcm92aWRlZA0KYnkgZGlmZmVyZW50IGgvdyBibG9ja3MgdXNpbmcgc2Ft
ZSBjb21wYXRpYmxlPw0KDQpCZXN0IFJlZ2FyZHMsDQpDaHVuLUppZQ0K

