Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAA830A25B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 08:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbhBAHD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 02:03:26 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:21139 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231695AbhBAHBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 02:01:20 -0500
X-UUID: 5ca1a5ca195e4308bdf41ac4006aea52-20210201
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=4JQym9q20Zq/Qt/WiWwPKkqXOXZJ+yCgxYiwMHDT13U=;
        b=oF4EHZSaAzF/m/Q0B186Ej7u6x8OSrJVutsZcPopGCbwUQTyoeBIGRhF+BQhGQtIjXvK3vjxHWs4ql0x2LBoQo2JpHGG6jpfMmegsitdJjLAZmFcamZ+NkkxYzQ7zKIDMJAb2iAnv6yd7Z6gynTRrlEIOrDMXlK7m3AG/JbagCY=;
X-UUID: 5ca1a5ca195e4308bdf41ac4006aea52-20210201
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 784829875; Mon, 01 Feb 2021 15:00:36 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 1 Feb 2021 15:00:28 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 1 Feb 2021 15:00:28 +0800
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
Subject: [PATCH next v3 10/16] arm64: dts: mediatek: mt2712: harmonize node names
Date:   Mon, 1 Feb 2021 15:00:10 +0800
Message-ID: <20210201070016.41721-10-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210201070016.41721-1-chunfeng.yun@mediatek.com>
References: <20210201070016.41721-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: F3010B1AFF9ECA39D8CA98B57B93D677ED9BA9B0C0E9DF2D9714BE8BE332A6A52000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBpcyB1c2VkIHRvIGZpeCBkdGJzX2NoZWNrIHdhcm5pbmcuDQoNClNpZ25lZC1vZmYtYnk6
IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0KdjJ+djM6IG5v
IGNoYW5nZXMNCi0tLQ0KIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQyNzEyZS5kdHNp
IHwgOCArKysrLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRp
b25zKC0pDQoNCmRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210Mjcx
MmUuZHRzaSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQyNzEyZS5kdHNpDQppbmRl
eCBkYjE3ZDBhNGVkNTcuLmE5Y2NhOWMxNDZmZCAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtNjQvYm9v
dC9kdHMvbWVkaWF0ZWsvbXQyNzEyZS5kdHNpDQorKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21l
ZGlhdGVrL210MjcxMmUuZHRzaQ0KQEAgLTgwNSw3ICs4MDUsNyBAQA0KIAkJcmFuZ2VzOw0KIAkJ
c3RhdHVzID0gImRpc2FibGVkIjsNCiANCi0JCXVzYl9ob3N0MDogeGhjaUAxMTI3MDAwMCB7DQor
CQl1c2JfaG9zdDA6IHVzYkAxMTI3MDAwMCB7DQogCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxt
dDI3MTIteGhjaSIsDQogCQkJCSAgICAgIm1lZGlhdGVrLG10ay14aGNpIjsNCiAJCQlyZWcgPSA8
MCAweDExMjcwMDAwIDAgMHgxMDAwPjsNCkBAIC04MTgsNyArODE4LDcgQEANCiAJCX07DQogCX07
DQogDQotCXUzcGh5MDogdXNiLXBoeUAxMTI5MDAwMCB7DQorCXUzcGh5MDogdC1waHlAMTEyOTAw
MDAgew0KIAkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDI3MTItdHBoeSIsDQogCQkJICAgICAi
bWVkaWF0ZWssZ2VuZXJpYy10cGh5LXYyIjsNCiAJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KQEAg
LTg2OSw3ICs4NjksNyBAQA0KIAkJcmFuZ2VzOw0KIAkJc3RhdHVzID0gImRpc2FibGVkIjsNCiAN
Ci0JCXVzYl9ob3N0MTogeGhjaUAxMTJjMDAwMCB7DQorCQl1c2JfaG9zdDE6IHVzYkAxMTJjMDAw
MCB7DQogCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDI3MTIteGhjaSIsDQogCQkJCSAgICAg
Im1lZGlhdGVrLG10ay14aGNpIjsNCiAJCQlyZWcgPSA8MCAweDExMmMwMDAwIDAgMHgxMDAwPjsN
CkBAIC04ODIsNyArODgyLDcgQEANCiAJCX07DQogCX07DQogDQotCXUzcGh5MTogdXNiLXBoeUAx
MTJlMDAwMCB7DQorCXUzcGh5MTogdC1waHlAMTEyZTAwMDAgew0KIAkJY29tcGF0aWJsZSA9ICJt
ZWRpYXRlayxtdDI3MTItdHBoeSIsDQogCQkJICAgICAibWVkaWF0ZWssZ2VuZXJpYy10cGh5LXYy
IjsNCiAJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KLS0gDQoyLjE4LjANCg==

