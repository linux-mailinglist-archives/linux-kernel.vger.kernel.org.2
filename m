Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9A0E30A261
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 08:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbhBAHET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 02:04:19 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:48161 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231710AbhBAHBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 02:01:25 -0500
X-UUID: f4922b33294341b98ff7cf56e02a431e-20210201
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=C3ATWN1+oY0xGAGinwc0R+3+ArJ0j5lmgz03y3lyQHo=;
        b=E5FgA+m+flYAt0+xpM2Cbxfy61oPuB/g9DExAure8NDLOkZEdcAmXvhzZkZv0y2NjGeGiH3FHtGMpiWOaDomEjuL+bTU/F6ug4S0cLLJMZCkbnqI/u1MWVrKBnq+Wi1lI7KOY2utl4CodUlfZUDz3jXk5LOOuBviBDUpz5rOpE0=;
X-UUID: f4922b33294341b98ff7cf56e02a431e-20210201
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1125101751; Mon, 01 Feb 2021 15:00:38 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 1 Feb 2021 15:00:30 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 1 Feb 2021 15:00:30 +0800
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
Subject: [PATCH next v3 14/16] arm: dts: mt7629: harmonize node names and compatibles
Date:   Mon, 1 Feb 2021 15:00:14 +0800
Message-ID: <20210201070016.41721-14-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210201070016.41721-1-chunfeng.yun@mediatek.com>
References: <20210201070016.41721-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 48AA4ECAD272AC694A4EDE2BA7F3A7458B1DA5C31968D581750C53D7B115D6102000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBpcyB1c2VkIHRvIGZpeCBkdGJzX2NoZWNrIHdhcm5pbmcNCg0KU2lnbmVkLW9mZi1ieTog
Q2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KLS0tDQp2Mn52Mzogbm8g
Y2hhbmdlcw0KLS0tDQogYXJjaC9hcm0vYm9vdC9kdHMvbXQ3NjI5LmR0c2kgfCAxMiArKysrKysr
LS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0K
DQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvbXQ3NjI5LmR0c2kgYi9hcmNoL2FybS9i
b290L2R0cy9tdDc2MjkuZHRzaQ0KaW5kZXggNWNiYjNkMjQ0Yzc1Li44NzQwNDNmMDQ5MGQgMTAw
NjQ0DQotLS0gYS9hcmNoL2FybS9ib290L2R0cy9tdDc2MjkuZHRzaQ0KKysrIGIvYXJjaC9hcm0v
Ym9vdC9kdHMvbXQ3NjI5LmR0c2kNCkBAIC0zMjksOCArMzI5LDkgQEANCiAJCQlzdGF0dXMgPSAi
ZGlzYWJsZWQiOw0KIAkJfTsNCiANCi0JCXUzcGh5MDogdXNiLXBoeUAxYTBjNDAwMCB7DQotCQkJ
Y29tcGF0aWJsZSA9ICJtZWRpYXRlayxnZW5lcmljLXRwaHktdjIiOw0KKwkJdTNwaHkwOiB0LXBo
eUAxYTBjNDAwMCB7DQorCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDc2MjktdHBoeSIsDQor
CQkJCSAgICAgIm1lZGlhdGVrLGdlbmVyaWMtdHBoeS12MiI7DQogCQkJI2FkZHJlc3MtY2VsbHMg
PSA8MT47DQogCQkJI3NpemUtY2VsbHMgPSA8MT47DQogCQkJcmFuZ2VzID0gPDAgMHgxYTBjNDAw
MCAweGUwMD47DQpAQCAtNDEzLDE0ICs0MTQsMTUgQEANCiAJCQl9Ow0KIAkJfTsNCiANCi0JCXBj
aWVwaHkxOiBwY2llLXBoeUAxYTE0YTAwMCB7DQotCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxn
ZW5lcmljLXRwaHktdjIiOw0KKwkJcGNpZXBoeTE6IHQtcGh5QDFhMTRhMDAwIHsNCisJCQljb21w
YXRpYmxlID0gIm1lZGlhdGVrLG10NzYyOS10cGh5IiwNCisJCQkJICAgICAibWVkaWF0ZWssZ2Vu
ZXJpYy10cGh5LXYyIjsNCiAJCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsNCiAJCQkjc2l6ZS1jZWxs
cyA9IDwxPjsNCiAJCQlyYW5nZXMgPSA8MCAweDFhMTRhMDAwIDB4MTAwMD47DQogCQkJc3RhdHVz
ID0gImRpc2FibGVkIjsNCiANCi0JCQlwY2llcG9ydDE6IHBvcnQxcGh5QDAgew0KKwkJCXBjaWVw
b3J0MTogcGNpZS1waHlAMCB7DQogCQkJCXJlZyA9IDwwIDB4MTAwMD47DQogCQkJCWNsb2NrcyA9
IDwmY2xrMjBtPjsNCiAJCQkJY2xvY2stbmFtZXMgPSAicmVmIjsNCi0tIA0KMi4xOC4wDQo=

