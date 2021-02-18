Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6CA431E3D7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 02:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbhBRB0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 20:26:22 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:56358 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229774AbhBRB0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 20:26:20 -0500
X-UUID: ea305bbacc9b440d9935d0c8ca95f706-20210218
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=zUPZ2aJmFI9QcMLgtweqxZvlkzc1wFncpS87E7I4qH8=;
        b=j19ZM6ErzZTSuwarDLGKz9UjVZutgqS6WLrfzhoJBdGt/LeJIZ0kdW/QC0t6O6zqZvl8UsiJdCwWCn7HXn4HfpcAbpYZdQzMKCQPusONBFOcg216NOvKhENSN8aQOBFg1O8xX9qHdBOw4iaKMMCJwTeyMX+X26t21tkwAqmtkU8=;
X-UUID: ea305bbacc9b440d9935d0c8ca95f706-20210218
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1114011714; Thu, 18 Feb 2021 09:25:35 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 18 Feb 2021 09:25:34 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 18 Feb 2021 09:25:34 +0800
Message-ID: <1613611534.10714.1.camel@mtksdaap41>
Subject: Re: [PATCH v6 00/22] Mediatek MT8192 clock support
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>, <srv_heupstream@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Thu, 18 Feb 2021 09:25:34 +0800
In-Reply-To: <161283242250.76967.15026468818750276885@swboyd.mtv.corp.google.com>
References: <1608642587-15634-1-git-send-email-weiyi.lu@mediatek.com>
         <161283242250.76967.15026468818750276885@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTAyLTA4IGF0IDE3OjAwIC0wODAwLCBTdGVwaGVuIEJveWQgd3JvdGU6DQo+
IFF1b3RpbmcgV2VpeWkgTHUgKDIwMjAtMTItMjIgMDU6MDk6MjUpDQo+ID4gVGhpcyBzZXJpZXMg
aXMgYmFzZWQgb24gdjUuMTAtcmMxLg0KPiA+IA0KPiANCj4gVGhlIERUIGJpbmRpbmdzIGZhaWws
IGNhbiB5b3UgZml4IGFuZCByZXNlbmQ/DQo+IA0KDQpPSywgSSdsbCBmaXggYW5kIHJlc2VuZC4g
VGhhbmsgeW91IGZvciByZXZpZXdpbmcuDQoNCj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2FybS9tZWRpYXRlay9tZWRpYXRlayxtc2RjLnlhbWw6ICdhZGRpdGlvbmFsUHJvcGVy
dGllcycgaXMgYSByZXF1aXJlZCBwcm9wZXJ0eQ0KPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvYXJtL21lZGlhdGVrL21lZGlhdGVrLGltcF9paWNfd3JhcC55YW1sOiAnYWRkaXRp
b25hbFByb3BlcnRpZXMnIGlzIGEgcmVxdWlyZWQgcHJvcGVydHkNCj4gRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tZWRpYXRlay9tZWRpYXRlayxtZHBzeXMueWFtbDogJ2Fk
ZGl0aW9uYWxQcm9wZXJ0aWVzJyBpcyBhIHJlcXVpcmVkIHByb3BlcnR5DQo+IERvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbWVkaWF0ZWsvbWVkaWF0ZWssc2NwLWFkc3AueWFt
bDogJ2FkZGl0aW9uYWxQcm9wZXJ0aWVzJyBpcyBhIHJlcXVpcmVkIHByb3BlcnR5DQo+IERvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbWVkaWF0ZWsvbWVkaWF0ZWssbXNkYy55
YW1sOiBpZ25vcmluZywgZXJyb3IgaW4gc2NoZW1hOg0KPiB3YXJuaW5nOiBubyBzY2hlbWEgZm91
bmQgaW4gZmlsZTogRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tZWRpYXRl
ay9tZWRpYXRlayxtc2RjLnlhbWwNCj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2FybS9tZWRpYXRlay9tZWRpYXRlayxpbXBfaWljX3dyYXAueWFtbDogaWdub3JpbmcsIGVycm9y
IGluIHNjaGVtYToNCj4gd2FybmluZzogbm8gc2NoZW1hIGZvdW5kIGluIGZpbGU6IERvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbWVkaWF0ZWsvbWVkaWF0ZWssaW1wX2lpY193
cmFwLnlhbWwNCj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tZWRpYXRl
ay9tZWRpYXRlayxtZHBzeXMueWFtbDogaWdub3JpbmcsIGVycm9yIGluIHNjaGVtYToNCj4gd2Fy
bmluZzogbm8gc2NoZW1hIGZvdW5kIGluIGZpbGU6IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9hcm0vbWVkaWF0ZWsvbWVkaWF0ZWssbWRwc3lzLnlhbWwNCj4gRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tZWRpYXRlay9tZWRpYXRlayxzY3AtYWRzcC55YW1s
OiBpZ25vcmluZywgZXJyb3IgaW4gc2NoZW1hOg0KPiB3YXJuaW5nOiBubyBzY2hlbWEgZm91bmQg
aW4gZmlsZTogRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tZWRpYXRlay9t
ZWRpYXRlayxzY3AtYWRzcC55YW1sDQo+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9hcm0vbWVkaWF0ZWsvbWVkaWF0ZWssbXNkYy5leGFtcGxlLmR0LnlhbWw6IGV4YW1wbGUtMDog
c3lzY29uQDExZjYwMDAwOnJlZzowOiBbMCwgMzAxMzM0NTI4LCAwLCA0MDk2XSBpcyB0b28gbG9u
Zw0KPiAgICAgICAgIEZyb20gc2NoZW1hOiB+Ly5sb2NhbC9saWIvcHl0aG9uMy44L3NpdGUtcGFj
a2FnZXMvZHRzY2hlbWEvc2NoZW1hcy9yZWcueWFtbA0KPiBEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvYXJtL21lZGlhdGVrL21lZGlhdGVrLG1zZGMuZXhhbXBsZS5kdC55YW1sOiBl
eGFtcGxlLTE6IHN5c2NvbkAxMWYxMDAwMDpyZWc6MDogWzAsIDMwMTAwNjg0OCwgMCwgNDA5Nl0g
aXMgdG9vIGxvbmcNCj4gICAgICAgICBGcm9tIHNjaGVtYTogfi8ubG9jYWwvbGliL3B5dGhvbjMu
OC9zaXRlLXBhY2thZ2VzL2R0c2NoZW1hL3NjaGVtYXMvcmVnLnlhbWwNCj4gRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tZWRpYXRlay9tZWRpYXRlayxtZHBzeXMuZXhhbXBs
ZS5kdC55YW1sOiBleGFtcGxlLTA6IHN5c2NvbkAxZjAwMDAwMDpyZWc6MDogWzAsIDUyMDA5MzY5
NiwgMCwgNDA5Nl0gaXMgdG9vIGxvbmcNCj4gICAgICAgICBGcm9tIHNjaGVtYTogfi8ubG9jYWwv
bGliL3B5dGhvbjMuOC9zaXRlLXBhY2thZ2VzL2R0c2NoZW1hL3NjaGVtYXMvcmVnLnlhbWwNCj4g
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tZWRpYXRlay9tZWRpYXRlayxp
bXBfaWljX3dyYXAuZXhhbXBsZS5kdC55YW1sOiBleGFtcGxlLTA6IHN5c2NvbkAxMTAwNzAwMDpy
ZWc6MDogWzAsIDI4NTI0MTM0NCwgMCwgNDA5Nl0gaXMgdG9vIGxvbmcNCj4gICAgICAgICBGcm9t
IHNjaGVtYTogfi8ubG9jYWwvbGliL3B5dGhvbjMuOC9zaXRlLXBhY2thZ2VzL2R0c2NoZW1hL3Nj
aGVtYXMvcmVnLnlhbWwNCj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9t
ZWRpYXRlay9tZWRpYXRlayxpbXBfaWljX3dyYXAuZXhhbXBsZS5kdC55YW1sOiBleGFtcGxlLTE6
IHN5c2NvbkAxMWNiMTAwMDpyZWc6MDogWzAsIDI5ODUyMDU3NiwgMCwgNDA5Nl0gaXMgdG9vIGxv
bmcNCj4gICAgICAgICBGcm9tIHNjaGVtYTogfi8ubG9jYWwvbGliL3B5dGhvbjMuOC9zaXRlLXBh
Y2thZ2VzL2R0c2NoZW1hL3NjaGVtYXMvcmVnLnlhbWwNCj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2FybS9tZWRpYXRlay9tZWRpYXRlayxpbXBfaWljX3dyYXAuZXhhbXBsZS5k
dC55YW1sOiBleGFtcGxlLTI6IHN5c2NvbkAxMWQwMzAwMDpyZWc6MDogWzAsIDI5ODg1NjQ0OCwg
MCwgNDA5Nl0gaXMgdG9vIGxvbmcNCj4gICAgICAgICBGcm9tIHNjaGVtYTogfi8ubG9jYWwvbGli
L3B5dGhvbjMuOC9zaXRlLXBhY2thZ2VzL2R0c2NoZW1hL3NjaGVtYXMvcmVnLnlhbWwNCj4gRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tZWRpYXRlay9tZWRpYXRlayxpbXBf
aWljX3dyYXAuZXhhbXBsZS5kdC55YW1sOiBleGFtcGxlLTM6IHN5c2NvbkAxMWQyMzAwMDpyZWc6
MDogWzAsIDI5ODk4NzUyMCwgMCwgNDA5Nl0gaXMgdG9vIGxvbmcNCj4gICAgICAgICBGcm9tIHNj
aGVtYTogfi8ubG9jYWwvbGliL3B5dGhvbjMuOC9zaXRlLXBhY2thZ2VzL2R0c2NoZW1hL3NjaGVt
YXMvcmVnLnlhbWwNCj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tZWRp
YXRlay9tZWRpYXRlayxpbXBfaWljX3dyYXAuZXhhbXBsZS5kdC55YW1sOiBleGFtcGxlLTQ6IHN5
c2NvbkAxMWUwMTAwMDpyZWc6MDogWzAsIDI5OTg5NjgzMiwgMCwgNDA5Nl0gaXMgdG9vIGxvbmcN
Cj4gICAgICAgICBGcm9tIHNjaGVtYTogfi8ubG9jYWwvbGliL3B5dGhvbjMuOC9zaXRlLXBhY2th
Z2VzL2R0c2NoZW1hL3NjaGVtYXMvcmVnLnlhbWwNCj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2FybS9tZWRpYXRlay9tZWRpYXRlayxpbXBfaWljX3dyYXAuZXhhbXBsZS5kdC55
YW1sOiBleGFtcGxlLTU6IHN5c2NvbkAxMWYwMjAwMDpyZWc6MDogWzAsIDMwMDk0OTUwNCwgMCwg
NDA5Nl0gaXMgdG9vIGxvbmcNCj4gICAgICAgICBGcm9tIHNjaGVtYTogfi8ubG9jYWwvbGliL3B5
dGhvbjMuOC9zaXRlLXBhY2thZ2VzL2R0c2NoZW1hL3NjaGVtYXMvcmVnLnlhbWwNCj4gDQo+IF9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+IExpbnV4LW1l
ZGlhdGVrIG1haWxpbmcgbGlzdA0KPiBMaW51eC1tZWRpYXRla0BsaXN0cy5pbmZyYWRlYWQub3Jn
DQo+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbWVk
aWF0ZWsNCg0K

