Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C0F33FD56
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 03:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhCRCni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 22:43:38 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:34549 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229702AbhCRCnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 22:43:12 -0400
X-UUID: e05bc8db7fb242bcaa4a1a3e348a9b96-20210318
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=fQv6Dgwb3ZUIHKCcqqmaWUSPNkvouPy+QtwObI48/bE=;
        b=UV5+P3PHZPuPxUnxdD4aERMjnEYLanODjoEBKaoeXt6MHVdhdYJ2PvLQCeKRfz7ziFJGToeXW5GDE25UPxKL2ga424pOhtqgVa1sTVHRRjkO+RRkTqWr+7fkoH67ECEBmg6cXgQwb2cvtrWE4CWbqm5jUOXZEe/m8tRmu6hcJkc=;
X-UUID: e05bc8db7fb242bcaa4a1a3e348a9b96-20210318
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1657917886; Thu, 18 Mar 2021 10:43:06 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs05n1.mediatek.inc
 (172.21.101.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 18 Mar
 2021 10:43:04 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 18 Mar 2021 10:43:03 +0800
Message-ID: <1616035383.25733.20.camel@mhfsdcap03>
Subject: Re: [PATCH v5 02/13] dt-bindings: phy: mediatek: dsi-phy: modify
 compatible dependence
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jie Qiu <jie.qiu@mediatek.com>, CK Hu <ck.hu@mediatek.com>,
        Cawa Cheng <cawa.cheng@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
Date:   Thu, 18 Mar 2021 10:43:03 +0800
In-Reply-To: <20210316092232.9806-2-chunfeng.yun@mediatek.com>
References: <20210316092232.9806-1-chunfeng.yun@mediatek.com>
         <20210316092232.9806-2-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVmlub2QsDQoNCiAgQ291bGQgeW91IHBsZWFzZSBoZWxwIHRvIGFwcGx5IHBhdGNoZXMgWzAy
LzEzXSBbMDMvMTNdIFswNC8xM10gb2YgdGhlDQpzZXJpZXM/DQoNCiAgIFRoYW5rcyBhIGxvdA0K
DQpPbiBUdWUsIDIwMjEtMDMtMTYgYXQgMTc6MjIgKzA4MDAsIENodW5mZW5nIFl1biB3cm90ZToN
Cj4gbXQ3NjIzLW1pcGktdHggaXMgY29tcGF0aWJsZSB0byBtdDI3MDEtbWlwaS10eCwgYW5kIHVz
ZQ0KPiAibWVkaWF0ZWssbXQyNzAxLW1pcGktdHgiIGluc3RlYWQgb24gTVQ3NjIzLCBzbyBtb2Rp
ZnkNCj4gdGhlIGNvbXBhdGlibGUgaXRlbXMgdG8gbWFrZSBkZXBlbmRlbmNlIGNsZWFyLg0KPiAN
Cj4gQ2M6IENodW4tS3VhbmcgSHUgPGNodW5rdWFuZy5odUBrZXJuZWwub3JnPg0KPiBDYzogUGhp
bGlwcCBaYWJlbCA8cC56YWJlbEBwZW5ndXRyb25peC5kZT4NCj4gQWNrZWQtYnk6IENodW4tS3Vh
bmcgSHUgPGNodW5rdWFuZy5odUBrZXJuZWwub3JnPg0KPiBSZXZpZXdlZC1ieTogUm9iIEhlcnJp
bmcgPHJvYmhAa2VybmVsLm9yZz4NCj4gU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcgWXVuIDxjaHVu
ZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gdjU6IG5vIGNoYW5nZXMNCj4gdjQ6IGFk
ZCBhY2tlZC1ieSBDSywgYW5kIHJldmlld2VkLWJ5IFJvYg0KPiB2MzogbW9kaWZ5IGNvbW1pdCBt
ZXNzYWdlIHN1Z2dlc3RlZCBieSBDSw0KPiB2Mjogc2VwYXJhdGUgdHdvIHBhdGNoZXMgc3VnZ2Vz
dGVkIGJ5IENLDQo+IC0tLQ0KPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5L21lZGlhdGVr
LGRzaS1waHkueWFtbCAgIHwgMTMgKysrKysrKystLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDgg
aW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5L21lZGlhdGVrLGRzaS1waHkueWFtbCBiL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvbWVkaWF0ZWssZHNpLXBoeS55YW1s
DQo+IGluZGV4IDcxZDRhY2VhMWY2Ni4uNmU0ZDc5NWY5YjAyIDEwMDY0NA0KPiAtLS0gYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5L21lZGlhdGVrLGRzaS1waHkueWFtbA0K
PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5L21lZGlhdGVrLGRz
aS1waHkueWFtbA0KPiBAQCAtMTksMTEgKzE5LDE0IEBAIHByb3BlcnRpZXM6DQo+ICAgICAgcGF0
dGVybjogIl5kc2ktcGh5QFswLTlhLWZdKyQiDQo+ICANCj4gICAgY29tcGF0aWJsZToNCj4gLSAg
ICBlbnVtOg0KPiAtICAgICAgLSBtZWRpYXRlayxtdDI3MDEtbWlwaS10eA0KPiAtICAgICAgLSBt
ZWRpYXRlayxtdDc2MjMtbWlwaS10eA0KPiAtICAgICAgLSBtZWRpYXRlayxtdDgxNzMtbWlwaS10
eA0KPiAtICAgICAgLSBtZWRpYXRlayxtdDgxODMtbWlwaS10eA0KPiArICAgIG9uZU9mOg0KPiAr
ICAgICAgLSBpdGVtczoNCj4gKyAgICAgICAgICAtIGVudW06DQo+ICsgICAgICAgICAgICAgIC0g
bWVkaWF0ZWssbXQ3NjIzLW1pcGktdHgNCj4gKyAgICAgICAgICAtIGNvbnN0OiBtZWRpYXRlayxt
dDI3MDEtbWlwaS10eA0KPiArICAgICAgLSBjb25zdDogbWVkaWF0ZWssbXQyNzAxLW1pcGktdHgN
Cj4gKyAgICAgIC0gY29uc3Q6IG1lZGlhdGVrLG10ODE3My1taXBpLXR4DQo+ICsgICAgICAtIGNv
bnN0OiBtZWRpYXRlayxtdDgxODMtbWlwaS10eA0KPiAgDQo+ICAgIHJlZzoNCj4gICAgICBtYXhJ
dGVtczogMQ0KDQo=

