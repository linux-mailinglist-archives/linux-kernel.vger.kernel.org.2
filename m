Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F021D330795
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 06:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234522AbhCHFi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 00:38:28 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:44691 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234436AbhCHFiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 00:38:02 -0500
X-UUID: c7be6d2a4abc4aa294397148eb910e48-20210308
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=u3VE+kUgCgnXOQ6xrTo8ccF5dBa/h3UTVZ0nd8WVGvY=;
        b=V8L3ElTly1d8qWW4v47IdGYDExAe1JvocUnUi16UGTfQWltV2b6LVAr5QO34dMCaK9cMNDDsLmQEezuE9uZ5BVxmiohYSmkV6Iwt97pQeIm7IV/DTZ4etnej9BVFBOZk0rIJkeDjw9nFKamP7wRK1vTCs4rGmcUJoJx0i9NLtOE=;
X-UUID: c7be6d2a4abc4aa294397148eb910e48-20210308
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1703879310; Mon, 08 Mar 2021 13:37:55 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 8 Mar 2021 13:37:51 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 8 Mar 2021 13:37:51 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
Subject: [PATCH v4 10/12] arm: dts: mt7629: harmonize node names and compatibles
Date:   Mon, 8 Mar 2021 13:37:43 +0800
Message-ID: <20210308053745.25697-10-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210308053745.25697-1-chunfeng.yun@mediatek.com>
References: <20210308053745.25697-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 382FEC62F9FEE381406AE72691B2087CDB8F557D2AB755F1BE2B8CB43B451F6B2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBpcyB1c2VkIHRvIGZpeCBkdGJzX2NoZWNrIHdhcm5pbmcNCg0KU2lnbmVkLW9mZi1ieTog
Q2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KLS0tDQp2Mn52NDogbm8g
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

