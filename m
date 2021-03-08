Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008B133079A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 06:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbhCHFii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 00:38:38 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:47249 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234438AbhCHFiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 00:38:02 -0500
X-UUID: 0b679bdaab3e4be1b775043991864001-20210308
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=cRq6b9/QH+9GY00EafZDgqPQQFwtYxTb+NPbULDbX6U=;
        b=Igxq77//VJBFELuEXYTDInWDPK+VUnQcUqRekgIFLT5LYBTi5ee+zj0gQGQGq81zdyOvefAR/UxX+3xeuleIaPx7QI9MNgnrhGM+WXA2cqU7um3tpn4Lial7qCzIaKSfxQu0xl7suEwlB882z9gTXpRPyRFFQe1OBdy3pf+kyE8=;
X-UUID: 0b679bdaab3e4be1b775043991864001-20210308
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2031571062; Mon, 08 Mar 2021 13:37:54 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 8 Mar 2021 13:37:52 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 8 Mar 2021 13:37:52 +0800
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
Subject: [PATCH v4 12/12] arm: dts: mt2701: harmonize node names and compatibles
Date:   Mon, 8 Mar 2021 13:37:45 +0800
Message-ID: <20210308053745.25697-12-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210308053745.25697-1-chunfeng.yun@mediatek.com>
References: <20210308053745.25697-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: EA48B1B556F6A878D5000ACF45A5E81DB0DFFAA1844CF996271E6BF92307BFB52000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBpcyB1c2VkIHRvIGZpeCBkdGJzX2NoZWNrIHdhcm5pbmcNCg0KU2lnbmVkLW9mZi1ieTog
Q2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KLS0tDQp2Mn52NDogbm8g
Y2hhbmdlcw0KLS0tDQogYXJjaC9hcm0vYm9vdC9kdHMvbXQyNzAxLmR0c2kgfCAxOSArKysrKysr
KysrKy0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDggZGVsZXRp
b25zKC0pDQoNCmRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9tdDI3MDEuZHRzaSBiL2Fy
Y2gvYXJtL2Jvb3QvZHRzL210MjcwMS5kdHNpDQppbmRleCBmYWRlMTQyODQwMTcuLjQ3NzZmODVk
NmQ1YiAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL210MjcwMS5kdHNpDQorKysgYi9h
cmNoL2FybS9ib290L2R0cy9tdDI3MDEuZHRzaQ0KQEAgLTYwNyw3ICs2MDcsNyBAQA0KIAl9Ow0K
IA0KIAl1c2IwOiB1c2JAMWExYzAwMDAgew0KLQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgx
NzMteGhjaSI7DQorCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10MjcwMS14aGNpIiwgIm1lZGlh
dGVrLG10ay14aGNpIjsNCiAJCXJlZyA9IDwwIDB4MWExYzAwMDAgMCAweDEwMDA+LA0KIAkJICAg
ICAgPDAgMHgxYTFjNDcwMCAwIDB4MDEwMD47DQogCQlyZWctbmFtZXMgPSAibWFjIiwgImlwcGMi
Ow0KQEAgLTYyMCw4ICs2MjAsOSBAQA0KIAkJc3RhdHVzID0gImRpc2FibGVkIjsNCiAJfTsNCiAN
Ci0JdTNwaHkwOiB1c2ItcGh5QDFhMWM0MDAwIHsNCi0JCWNvbXBhdGlibGUgPSAibWVkaWF0ZWss
bXQyNzAxLXUzcGh5IjsNCisJdTNwaHkwOiB0LXBoeUAxYTFjNDAwMCB7DQorCQljb21wYXRpYmxl
ID0gIm1lZGlhdGVrLG10MjcwMS10cGh5IiwNCisJCQkgICAgICJtZWRpYXRlayxnZW5lcmljLXRw
aHktdjEiOw0KIAkJcmVnID0gPDAgMHgxYTFjNDAwMCAwIDB4MDcwMD47DQogCQkjYWRkcmVzcy1j
ZWxscyA9IDwyPjsNCiAJCSNzaXplLWNlbGxzID0gPDI+Ow0KQEAgLTY0Niw3ICs2NDcsNyBAQA0K
IAl9Ow0KIA0KIAl1c2IxOiB1c2JAMWEyNDAwMDAgew0KLQkJY29tcGF0aWJsZSA9ICJtZWRpYXRl
ayxtdDgxNzMteGhjaSI7DQorCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10MjcwMS14aGNpIiwg
Im1lZGlhdGVrLG10ay14aGNpIjsNCiAJCXJlZyA9IDwwIDB4MWEyNDAwMDAgMCAweDEwMDA+LA0K
IAkJICAgICAgPDAgMHgxYTI0NDcwMCAwIDB4MDEwMD47DQogCQlyZWctbmFtZXMgPSAibWFjIiwg
ImlwcGMiOw0KQEAgLTY1OSw4ICs2NjAsOSBAQA0KIAkJc3RhdHVzID0gImRpc2FibGVkIjsNCiAJ
fTsNCiANCi0JdTNwaHkxOiB1c2ItcGh5QDFhMjQ0MDAwIHsNCi0JCWNvbXBhdGlibGUgPSAibWVk
aWF0ZWssbXQyNzAxLXUzcGh5IjsNCisJdTNwaHkxOiB0LXBoeUAxYTI0NDAwMCB7DQorCQljb21w
YXRpYmxlID0gIm1lZGlhdGVrLG10MjcwMS10cGh5IiwNCisJCQkgICAgICJtZWRpYXRlayxnZW5l
cmljLXRwaHktdjEiOw0KIAkJcmVnID0gPDAgMHgxYTI0NDAwMCAwIDB4MDcwMD47DQogCQkjYWRk
cmVzcy1jZWxscyA9IDwyPjsNCiAJCSNzaXplLWNlbGxzID0gPDI+Ow0KQEAgLTcwMCw4ICs3MDIs
OSBAQA0KIAkJc3RhdHVzID0gImRpc2FibGVkIjsNCiAJfTsNCiANCi0JdTJwaHkwOiB1c2ItcGh5
QDExMjEwMDAwIHsNCi0JCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssZ2VuZXJpYy10cGh5LXYxIjsN
CisJdTJwaHkwOiB0LXBoeUAxMTIxMDAwMCB7DQorCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10
MjcwMS10cGh5IiwNCisJCQkgICAgICJtZWRpYXRlayxnZW5lcmljLXRwaHktdjEiOw0KIAkJcmVn
ID0gPDAgMHgxMTIxMDAwMCAwIDB4MDgwMD47DQogCQkjYWRkcmVzcy1jZWxscyA9IDwyPjsNCiAJ
CSNzaXplLWNlbGxzID0gPDI+Ow0KLS0gDQoyLjE4LjANCg==

