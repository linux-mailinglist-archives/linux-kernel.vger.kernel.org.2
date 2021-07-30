Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C993DB14B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 04:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236273AbhG3Cnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 22:43:33 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:33446 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235692AbhG3Cnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 22:43:32 -0400
X-UUID: 179bba23a14a47bcaa44ccb0c7f09b58-20210730
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=MhJjzMJaCLiOt7zZ1oxqTMuNoTCEa6P7XqQdm1VKRgY=;
        b=HByxBdsrKL93WmMu1OctRxGSmIK64pUkldii6iD0JWUVP5w6714xwV6/7x4q7AmBy9sk/0pop9QL30bhHVCRMe4iiOmze7MuUpuVr1kRMm7ukytuirbSWT4IerTK0raDDHiHhl+YMJtyXHhXfZwFwaDlmdqYegulEi1QnzYGF8g=;
X-UUID: 179bba23a14a47bcaa44ccb0c7f09b58-20210730
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1010988491; Fri, 30 Jul 2021 10:43:25 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 30 Jul 2021 10:43:23 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 30 Jul 2021 10:43:23 +0800
Message-ID: <a48525422d4c953a2dac2a907895c20b9fd6d232.camel@mediatek.com>
Subject: Re: [v6 2/2] arm64: dts: mediatek: Correct UART0 bus clock of MT8192
From:   Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Ikjoon Jang <ikjn@chromium.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
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
Date:   Fri, 30 Jul 2021 10:43:23 +0800
In-Reply-To: <CAATdQgC-X6pijkgTBsWJJKp__J6N=7JNKHQJmOMvTAjivwPM5w@mail.gmail.com>
References: <20210727023205.20319-1-chun-jie.chen@mediatek.com>
         <20210727023205.20319-3-chun-jie.chen@mediatek.com>
         <CAATdQgC-X6pijkgTBsWJJKp__J6N=7JNKHQJmOMvTAjivwPM5w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIxLTA3LTI4IGF0IDE0OjE0ICswODAwLCBJa2pvb24gSmFuZyB3cm90ZToNCj4g
SGksDQo+IA0KPiBPbiBUdWUsIEp1bCAyNywgMjAyMSBhdCAxMDo0MyBBTSBDaHVuLUppZSBDaGVu
DQo+IDxjaHVuLWppZS5jaGVuQG1lZGlhdGVrLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gaW5mcmFf
dWFydDAgY2xvY2sgaXMgdGhlIHJlYWwgb25lIHdoYXQgdWFydDAgdXNlcyBhcyBidXMgY2xvY2su
DQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogV2VpeWkgTHUgPHdlaXlpLmx1QG1lZGlhdGVrLmNv
bT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaHVuLUppZSBDaGVuIDxjaHVuLWppZS5jaGVuQG1lZGlh
dGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgx
OTIuZHRzaSB8IDIgKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVk
aWF0ZWsvbXQ4MTkyLmR0c2kNCj4gPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4
MTkyLmR0c2kNCj4gPiBpbmRleCBjN2M3ZDRlMDE3YWUuLjk4MTBmMWQ0NDFkYSAxMDA2NDQNCj4g
PiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5Mi5kdHNpDQo+ID4gKysr
IGIvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxOTIuZHRzaQ0KPiA+IEBAIC0zMjcs
NyArMzI3LDcgQEANCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIm1l
ZGlhdGVrLG10NjU3Ny11YXJ0IjsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICByZWcgPSA8
MCAweDExMDAyMDAwIDAgMHgxMDAwPjsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBpbnRl
cnJ1cHRzID0gPEdJQ19TUEkgMTA5DQo+ID4gSVJRX1RZUEVfTEVWRUxfSElHSCAwPjsNCj4gPiAt
ICAgICAgICAgICAgICAgICAgICAgICBjbG9ja3MgPSA8JmNsazI2bT4sIDwmY2xrMjZtPjsNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICBjbG9ja3MgPSA8JmNsazI2bT4sIDwmaW5mcmFjZmcN
Cj4gPiBDTEtfSU5GUkFfVUFSVDA+Ow0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIGNsb2Nr
LW5hbWVzID0gImJhdWQiLCAiYnVzIjsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBzdGF0
dXMgPSAiZGlzYWJsZWQiOw0KPiA+ICAgICAgICAgICAgICAgICB9Ow0KPiANCj4gVGhlcmUncmUg
bWFueSBvdGhlciBub2RlcyBzdGlsbCBoYXZpbmcgb25seSBjbGsyNm0uIFdpbGwgeW91IHVwZGF0
ZQ0KPiB0aGVtIHRvbz8NCj4gDQoNCk90aGVycyB3aWxsIGJlIHVwZGF0ZWQgYnkgSVAgb3duZXIu
DQoNCkJlc3QgUmVnYXJkcywNCkNodW4tSmllDQoNCj4gPiAtLQ0KPiA+IDIuMTguMA0KPiA+IF9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+ID4gTGludXgt
bWVkaWF0ZWsgbWFpbGluZyBsaXN0DQo+ID4gTGludXgtbWVkaWF0ZWtAbGlzdHMuaW5mcmFkZWFk
Lm9yZw0KPiA+IA0KaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbWVkaWF0ZWtfXzshIUNUUk5LQTl3TWcw
QVJidyExYkl6NlgyRWlGYmlnQ0ltelFtYnF0ZXpJRmZsMUxSQnVQT1lUcUJkbDV3Zng4Yi16cDB6
UVA2OFI3UmhhSWNBQVhYRiQNCj4gPiAgDQo=

