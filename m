Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A12430A257
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 08:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbhBAHC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 02:02:58 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:56801 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231487AbhBAHBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 02:01:18 -0500
X-UUID: d5af97d4bfb84ed4b9ac9e1a3dd8863e-20210201
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=K8iBKh2qnkYP9IbeOkqQReHnR3NnrwC6se3UMPBGN4w=;
        b=PFJxzBejwQjkURP+HWq6gaoHA9Ydnljz67RwQ7oVYPlLB/UF3bTDDiT1HeY3tXDLpmu+lq2rIcrAqswo39F6tJBbtvUk7ABD02OcyqCgNXH9hlxw8pXF1klVXu15G9ixYW5ax0UWVFw0bbpVFHqMci4VYixed4WBVEZbyESN6WY=;
X-UUID: d5af97d4bfb84ed4b9ac9e1a3dd8863e-20210201
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1798083366; Mon, 01 Feb 2021 15:00:32 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 1 Feb 2021 15:00:27 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 1 Feb 2021 15:00:27 +0800
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
Subject: [PATCH next v3 07/16] dt-bindings: usb: mtk-xhci: add compatible for mt2701 and mt7623
Date:   Mon, 1 Feb 2021 15:00:07 +0800
Message-ID: <20210201070016.41721-7-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210201070016.41721-1-chunfeng.yun@mediatek.com>
References: <20210201070016.41721-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 9CF50BF406F81D2B73CB864D7C136A162DC16D4C0FF7AE923B708A720C414FFC2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIHR3byBjb21wYXRpYmxlIGZvciBtdDI3MDEgYW5kIG10NzYyMzsNCg0KU2lnbmVkLW9mZi1i
eTogQ2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KLS0tDQp2Mzogbm8g
Y2hhbmdlcw0KdjI6IG5ldyBwYXRjaCBzZXBhcmF0ZWQgZnJvbSBbNi8xNV0NCi0tLQ0KIERvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWssbXRrLXhoY2kueWFtbCB8
IDIgKysNCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL21lZGlhdGVrLG10ay14aGNpLnlh
bWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL21lZGlhdGVrLG10ay14
aGNpLnlhbWwNCmluZGV4IDVlYjhkN2NkODE1NS4uNDZmZTNhMTg5MzU5IDEwMDY0NA0KLS0tIGEv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9tZWRpYXRlayxtdGsteGhjaS55
YW1sDQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL21lZGlhdGVr
LG10ay14aGNpLnlhbWwNCkBAIC0yMyw4ICsyMywxMCBAQCBwcm9wZXJ0aWVzOg0KICAgY29tcGF0
aWJsZToNCiAgICAgaXRlbXM6DQogICAgICAgLSBlbnVtOg0KKyAgICAgICAgICAtIG1lZGlhdGVr
LG10MjcwMS14aGNpDQogICAgICAgICAgIC0gbWVkaWF0ZWssbXQyNzEyLXhoY2kNCiAgICAgICAg
ICAgLSBtZWRpYXRlayxtdDc2MjIteGhjaQ0KKyAgICAgICAgICAtIG1lZGlhdGVrLG10NzYyMy14
aGNpDQogICAgICAgICAgIC0gbWVkaWF0ZWssbXQ3NjI5LXhoY2kNCiAgICAgICAgICAgLSBtZWRp
YXRlayxtdDgxNzMteGhjaQ0KICAgICAgICAgICAtIG1lZGlhdGVrLG10ODE4My14aGNpDQotLSAN
CjIuMTguMA0K

