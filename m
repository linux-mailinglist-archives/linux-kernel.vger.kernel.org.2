Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 243303884E6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 04:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237334AbhESCry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 22:47:54 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:51281 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S236919AbhESCrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 22:47:52 -0400
X-UUID: 9c12430aa253475d82c9b523ee16cf0d-20210519
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=VEzORXZXTvU7eYTmk77wtpcjmjFnCZQDk56FWp8DxdI=;
        b=Odq3teru8Qo22puSd6vNUrfgLCgCWjekKUPuhAe0x2hZ5j1YqoQ8mzvTrfN9eKBE2Sc5gShzfGIhM1dKTt6Ge28pHVQSp4WuuiaH1ikyKQh9qrn8QbN8nxsB7D4pFJN3FpYh89yJzvEAR9o5UwRwyF7tqIKjqDFTotnjFUI6kS8=;
X-UUID: 9c12430aa253475d82c9b523ee16cf0d-20210519
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1246951111; Wed, 19 May 2021 10:46:30 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 19 May
 2021 10:46:18 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 19 May 2021 10:46:18 +0800
Message-ID: <1621392378.22329.5.camel@mhfsdcap03>
Subject: Re: [PATCH] phy: phy-mtk-tphy: Fix some resource leaks in
 mtk_phy_init()
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <lkp@intel.com>, Dan Carpenter <dan.carpenter@oracle.com>,
        Heiko Stuebner <heiko@sntech.de>, <kbuild@lists.01.org>
Date:   Wed, 19 May 2021 10:46:18 +0800
In-Reply-To: <1621257600-15046-1-git-send-email-yangtiezhu@loongson.cn>
References: <1621257600-15046-1-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 384A46F9F68EB2F10770BDD73B9B15BC7D398B264992835F51000680BDA137352000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTA1LTE3IGF0IDIxOjIwICswODAwLCBUaWV6aHUgWWFuZyB3cm90ZToNCj4g
VXNlIGNsa19kaXNhYmxlX3VucHJlcGFyZSgpIGluIHRoZSBlcnJvciBwYXRoIG9mIG10a19waHlf
aW5pdCgpIHRvIGZpeA0KPiBzb21lIHJlc291cmNlIGxlYWtzLg0KPiANCj4gRml4ZXM6IGNkNGVj
NGIwM2RjMSAoInBoeTogcGh5LW10NjV4eC11c2IzOiBhZGQgbWVkaWF0ZWsgZGlyZWN0b3J5IGFu
ZCByZW5hbWUgZmlsZSIpDQpObyBuZWVkIGFkZCBGaXhlcyB0YWcsIHRoZXJlIGlzIG5vIGRhX3Jl
Zl9jbGsgd2hlbiBhcHBseSB0aGlzIHBhdGNoLA0KDQo+IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVz
dCByb2JvdCA8bGtwQGludGVsLmNvbT4NCj4gUmVwb3J0ZWQtYnk6IERhbiBDYXJwZW50ZXIgPGRh
bi5jYXJwZW50ZXJAb3JhY2xlLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogVGllemh1IFlhbmcgPHlh
bmd0aWV6aHVAbG9vbmdzb24uY24+DQo+IC0tLQ0KPiAgZHJpdmVycy9waHkvbWVkaWF0ZWsvcGh5
LW10ay10cGh5LmMgfCAyICsrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9waHkvbWVkaWF0ZWsvcGh5LW10ay10cGh5LmMgYi9k
cml2ZXJzL3BoeS9tZWRpYXRlay9waHktbXRrLXRwaHkuYw0KPiBpbmRleCBjZGJjYzQ5Li43MzFj
NDgzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3BoeS9tZWRpYXRlay9waHktbXRrLXRwaHkuYw0K
PiArKysgYi9kcml2ZXJzL3BoeS9tZWRpYXRlay9waHktbXRrLXRwaHkuYw0KPiBAQCAtOTQ5LDYg
Kzk0OSw4IEBAIHN0YXRpYyBpbnQgbXRrX3BoeV9pbml0KHN0cnVjdCBwaHkgKnBoeSkNCj4gIAkJ
YnJlYWs7DQo+ICAJZGVmYXVsdDoNCj4gIAkJZGV2X2Vycih0cGh5LT5kZXYsICJpbmNvbXBhdGli
bGUgUEhZIHR5cGVcbiIpOw0KPiArCQljbGtfZGlzYWJsZV91bnByZXBhcmUoaW5zdGFuY2UtPnJl
Zl9jbGspOw0KPiArCQljbGtfZGlzYWJsZV91bnByZXBhcmUoaW5zdGFuY2UtPmRhX3JlZl9jbGsp
Ow0KPiAgCQlyZXR1cm4gLUVJTlZBTDsNCj4gIAl9DQo+ICANCmFmdGVyIHJlbW92aW5nIEZpeGVz
IHRhZywgDQpSZXZpZXdlZC1ieTogQ2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsu
Y29tPg0KDQpUaGFua3MNCg0K

