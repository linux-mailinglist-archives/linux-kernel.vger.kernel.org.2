Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49CAD30A26F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 08:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbhBAHGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 02:06:20 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:20258 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231678AbhBAHBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 02:01:24 -0500
X-UUID: cbb10edf0c3a409ea53f0c382a89ad66-20210201
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=nVXFngx1EZ+wtcRv2PEXe84jIw4ecWbVxMnu8O3Qsow=;
        b=Dj0XCn/N3Mn4lv4IZQsJzc+uXgP5S1kIiAozSDzpgTwoBaWGgvF6CK25eZ9bFBGcaQwDWfGQNUozRaEnY/5XtVhJy7P9bQTsnL2fgVCZP9QpRbat+VrfuY/H/1G3ObfWBam24Pzgb5GQFpDi8/aeF4B6y1RthhtVOVOd7cj0vbU=;
X-UUID: cbb10edf0c3a409ea53f0c382a89ad66-20210201
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1721323205; Mon, 01 Feb 2021 15:00:34 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 1 Feb 2021 15:00:31 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 1 Feb 2021 15:00:31 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Min Guo <min.guo@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
Subject: [PATCH next v3 15/16] arm: dts: mt7623: harmonize node names and compatibles
Date:   Mon, 1 Feb 2021 15:00:15 +0800
Message-ID: <20210201070016.41721-15-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210201070016.41721-1-chunfeng.yun@mediatek.com>
References: <20210201070016.41721-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: C08A795E6079C9CC0D9BA11D0AB7C1A17DFC1A09E34F215A3E5D3FBEEDBB811A2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBpcyB1c2VkIHRvIGZpeCBkdGJzX2NoZWNrIHdhcm5pbmcNCg0KU2lnbmVkLW9mZi1ieTog
Q2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KLS0tDQp2Mn52Mzogbm8g
Y2hhbmdlcw0KLS0tDQogYXJjaC9hcm0vYm9vdC9kdHMvbXQ3NjIzLmR0c2kgIHwgMjYgKysrKysr
KysrKysrKystLS0tLS0tLS0tLS0NCiBhcmNoL2FybS9ib290L2R0cy9tdDc2MjNuLmR0c2kgfCAg
NCArKy0tDQogMiBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMo
LSkNCg0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL210NzYyMy5kdHNpIGIvYXJjaC9h
cm0vYm9vdC9kdHMvbXQ3NjIzLmR0c2kNCmluZGV4IGFlYTY4MDk1MDBkNy4uM2MxMWY3Y2ZjYzQw
IDEwMDY0NA0KLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvbXQ3NjIzLmR0c2kNCisrKyBiL2FyY2gv
YXJtL2Jvb3QvZHRzL210NzYyMy5kdHNpDQpAQCAtNzg3LDggKzc4Nyw5IEBADQogCQl9Ow0KIAl9
Ow0KIA0KLQlwY2llMF9waHk6IHBjaWUtcGh5QDFhMTQ5MDAwIHsNCi0JCWNvbXBhdGlibGUgPSAi
bWVkaWF0ZWssZ2VuZXJpYy10cGh5LXYxIjsNCisJcGNpZTBfcGh5OiB0LXBoeUAxYTE0OTAwMCB7
DQorCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10NzYyMy10cGh5IiwNCisJCQkgICAgICJtZWRp
YXRlayxnZW5lcmljLXRwaHktdjEiOw0KIAkJcmVnID0gPDAgMHgxYTE0OTAwMCAwIDB4MDcwMD47
DQogCQkjYWRkcmVzcy1jZWxscyA9IDwyPjsNCiAJCSNzaXplLWNlbGxzID0gPDI+Ow0KQEAgLTgw
NCw4ICs4MDUsOSBAQA0KIAkJfTsNCiAJfTsNCiANCi0JcGNpZTFfcGh5OiBwY2llLXBoeUAxYTE0
YTAwMCB7DQotCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLGdlbmVyaWMtdHBoeS12MSI7DQorCXBj
aWUxX3BoeTogdC1waHlAMWExNGEwMDAgew0KKwkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDc2
MjMtdHBoeSIsDQorCQkJICAgICAibWVkaWF0ZWssZ2VuZXJpYy10cGh5LXYxIjsNCiAJCXJlZyA9
IDwwIDB4MWExNGEwMDAgMCAweDA3MDA+Ow0KIAkJI2FkZHJlc3MtY2VsbHMgPSA8Mj47DQogCQkj
c2l6ZS1jZWxscyA9IDwyPjsNCkBAIC04MjMsNyArODI1LDcgQEANCiANCiAJdXNiMTogdXNiQDFh
MWMwMDAwIHsNCiAJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ3NjIzLXhoY2kiLA0KLQkJCSAg
ICAgIm1lZGlhdGVrLG10ODE3My14aGNpIjsNCisJCQkgICAgICJtZWRpYXRlayxtdGsteGhjaSI7
DQogCQlyZWcgPSA8MCAweDFhMWMwMDAwIDAgMHgxMDAwPiwNCiAJCSAgICAgIDwwIDB4MWExYzQ3
MDAgMCAweDAxMDA+Ow0KIAkJcmVnLW5hbWVzID0gIm1hYyIsICJpcHBjIjsNCkBAIC04MzYsOSAr
ODM4LDkgQEANCiAJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQogCX07DQogDQotCXUzcGh5MTogdXNi
LXBoeUAxYTFjNDAwMCB7DQotCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10NzYyMy11M3BoeSIs
DQotCQkJICAgICAibWVkaWF0ZWssbXQyNzAxLXUzcGh5IjsNCisJdTNwaHkxOiB0LXBoeUAxYTFj
NDAwMCB7DQorCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10NzYyMy10cGh5IiwNCisJCQkgICAg
ICJtZWRpYXRlayxnZW5lcmljLXRwaHktdjEiOw0KIAkJcmVnID0gPDAgMHgxYTFjNDAwMCAwIDB4
MDcwMD47DQogCQkjYWRkcmVzcy1jZWxscyA9IDwyPjsNCiAJCSNzaXplLWNlbGxzID0gPDI+Ow0K
QEAgLTg2NCw3ICs4NjYsNyBAQA0KIA0KIAl1c2IyOiB1c2JAMWEyNDAwMDAgew0KIAkJY29tcGF0
aWJsZSA9ICJtZWRpYXRlayxtdDc2MjMteGhjaSIsDQotCQkJICAgICAibWVkaWF0ZWssbXQ4MTcz
LXhoY2kiOw0KKwkJCSAgICAgIm1lZGlhdGVrLG10ay14aGNpIjsNCiAJCXJlZyA9IDwwIDB4MWEy
NDAwMDAgMCAweDEwMDA+LA0KIAkJICAgICAgPDAgMHgxYTI0NDcwMCAwIDB4MDEwMD47DQogCQly
ZWctbmFtZXMgPSAibWFjIiwgImlwcGMiOw0KQEAgLTg3Nyw5ICs4NzksOSBAQA0KIAkJc3RhdHVz
ID0gImRpc2FibGVkIjsNCiAJfTsNCiANCi0JdTNwaHkyOiB1c2ItcGh5QDFhMjQ0MDAwIHsNCi0J
CWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ3NjIzLXUzcGh5IiwNCi0JCQkgICAgICJtZWRpYXRl
ayxtdDI3MDEtdTNwaHkiOw0KKwl1M3BoeTI6IHQtcGh5QDFhMjQ0MDAwIHsNCisJCWNvbXBhdGli
bGUgPSAibWVkaWF0ZWssbXQ3NjIzLXRwaHkiLA0KKwkJCSAgICAgIm1lZGlhdGVrLGdlbmVyaWMt
dHBoeS12MSI7DQogCQlyZWcgPSA8MCAweDFhMjQ0MDAwIDAgMHgwNzAwPjsNCiAJCSNhZGRyZXNz
LWNlbGxzID0gPDI+Ow0KIAkJI3NpemUtY2VsbHMgPSA8Mj47DQpkaWZmIC0tZ2l0IGEvYXJjaC9h
cm0vYm9vdC9kdHMvbXQ3NjIzbi5kdHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvbXQ3NjIzbi5kdHNp
DQppbmRleCAxODgwYWM5ZTMyY2YuLmJjYjA4NDZlMjlmZCAxMDA2NDQNCi0tLSBhL2FyY2gvYXJt
L2Jvb3QvZHRzL210NzYyM24uZHRzaQ0KKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvbXQ3NjIzbi5k
dHNpDQpAQCAtMjQ2LDcgKzI0Niw3IEBADQogCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KIAl9Ow0K
IA0KLQltaXBpX3R4MDogbWlwaS1kcGh5QDEwMDEwMDAwIHsNCisJbWlwaV90eDA6IGRzaS1waHlA
MTAwMTAwMDAgew0KIAkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDc2MjMtbWlwaS10eCIsDQog
CQkJICAgICAibWVkaWF0ZWssbXQyNzAxLW1pcGktdHgiOw0KIAkJcmVnID0gPDAgMHgxMDAxMDAw
MCAwIDB4OTA+Ow0KQEAgLTI2NSw3ICsyNjUsNyBAQA0KIAkJc3RhdHVzID0gImRpc2FibGVkIjsN
CiAJfTsNCiANCi0JaGRtaV9waHk6IHBoeUAxMDIwOTEwMCB7DQorCWhkbWlfcGh5OiBoZG1pLXBo
eUAxMDIwOTEwMCB7DQogCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10NzYyMy1oZG1pLXBoeSIs
DQogCQkJICAgICAibWVkaWF0ZWssbXQyNzAxLWhkbWktcGh5IjsNCiAJCXJlZyA9IDwwIDB4MTAy
MDkxMDAgMCAweDI0PjsNCi0tIA0KMi4xOC4wDQo=

