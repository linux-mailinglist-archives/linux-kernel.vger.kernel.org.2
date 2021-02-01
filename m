Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEFE230A27D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 08:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhBAHHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 02:07:19 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:49105 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231508AbhBAHBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 02:01:19 -0500
X-UUID: ef0a49aeaa4441238560bcf622506f3a-20210201
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=bGjHJF6RZKKemR27qW1pqZryA/7HPE2P9xKrjpMmo0Y=;
        b=BDEBco63DWaSbPB7uZaJjo6Ud/H5NzTkBLZLmCuGfvTQV7oeSXDc8xjd01RyJ2E0HZq15GmIhaW3NPnN4T0/b8DHl2ywPO2HRjhgbt1/1RjG6dX+itLJnyP6HmNe7hv6CHJqDxOGh30acyNxVquKPJNKvhHf1o2bYAhA43tPQlU=;
X-UUID: ef0a49aeaa4441238560bcf622506f3a-20210201
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 862012202; Mon, 01 Feb 2021 15:00:33 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
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
Subject: [PATCH next v3 13/16] arm64: dts: mediatek: mt8183: fix dtbs_check warning
Date:   Mon, 1 Feb 2021 15:00:13 +0800
Message-ID: <20210201070016.41721-13-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210201070016.41721-1-chunfeng.yun@mediatek.com>
References: <20210201070016.41721-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: F35C95C5F653576E0C7267B963AB40C92DF40E2A3A3BC513DF55976A89FB3E582000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGFybW9uaXplIG5vZGUgbmFtZXMsIGNvbXBhdGlibGVzIGFuZCBwcm9wZXJ0aWVzLg0KDQpTaWdu
ZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQotLS0N
CnYzOiByZW1vdmUgcHJvcGVydHkgY2xvY2stbmFtZXMgc3VnZ2VzdGVkIGJ5IENLDQp2Mjogbm8g
Y2hhbmdlcw0KLS0tDQogYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODMuZHRzaSB8
IDggKysrLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9u
cygtKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODMu
ZHRzaSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTgzLmR0c2kNCmluZGV4IDVi
NzgyYTQ3NjllNy4uMTJhM2M3ZjAzZTFhIDEwMDY0NA0KLS0tIGEvYXJjaC9hcm02NC9ib290L2R0
cy9tZWRpYXRlay9tdDgxODMuZHRzaQ0KKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRl
ay9tdDgxODMuZHRzaQ0KQEAgLTg2NSw3ICs4NjUsNyBAQA0KIAkJCXJhbmdlczsNCiAJCQlzdGF0
dXMgPSAiZGlzYWJsZWQiOw0KIA0KLQkJCXVzYl9ob3N0OiB4aGNpQDExMjAwMDAwIHsNCisJCQl1
c2JfaG9zdDogdXNiQDExMjAwMDAwIHsNCiAJCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgx
ODMteGhjaSIsDQogCQkJCQkgICAgICJtZWRpYXRlayxtdGsteGhjaSI7DQogCQkJCXJlZyA9IDww
IDB4MTEyMDAwMDAgMCAweDEwMDA+Ow0KQEAgLTkwOCwxMSArOTA4LDEwIEBADQogCQkJc3RhdHVz
ID0gImRpc2FibGVkIjsNCiAJCX07DQogDQotCQltaXBpX3R4MDogbWlwaS1kcGh5QDExZTUwMDAw
IHsNCisJCW1pcGlfdHgwOiBkc2ktcGh5QDExZTUwMDAwIHsNCiAJCQljb21wYXRpYmxlID0gIm1l
ZGlhdGVrLG10ODE4My1taXBpLXR4IjsNCiAJCQlyZWcgPSA8MCAweDExZTUwMDAwIDAgMHgxMDAw
PjsNCiAJCQljbG9ja3MgPSA8JmFwbWl4ZWRzeXMgQ0xLX0FQTUlYRURfTUlQSUQwXzI2TT47DQot
CQkJY2xvY2stbmFtZXMgPSAicmVmX2NsayI7DQogCQkJI2Nsb2NrLWNlbGxzID0gPDA+Ow0KIAkJ
CSNwaHktY2VsbHMgPSA8MD47DQogCQkJY2xvY2stb3V0cHV0LW5hbWVzID0gIm1pcGlfdHgwX3Bs
bCI7DQpAQCAtOTMxLDExICs5MzAsMTAgQEANCiAJCQl9Ow0KIAkJfTsNCiANCi0JCXUzcGh5OiB1
c2ItcGh5QDExZjQwMDAwIHsNCisJCXUzcGh5OiB0LXBoeUAxMWY0MDAwMCB7DQogCQkJY29tcGF0
aWJsZSA9ICJtZWRpYXRlayxtdDgxODMtdHBoeSIsDQogCQkJCSAgICAgIm1lZGlhdGVrLGdlbmVy
aWMtdHBoeS12MiI7DQogCQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQotCQkJI3BoeS1jZWxscyA9
IDwxPjsNCiAJCQkjc2l6ZS1jZWxscyA9IDwxPjsNCiAJCQlyYW5nZXMgPSA8MCAwIDB4MTFmNDAw
MDAgMHgxMDAwPjsNCiAJCQlzdGF0dXMgPSAib2theSI7DQotLSANCjIuMTguMA0K

