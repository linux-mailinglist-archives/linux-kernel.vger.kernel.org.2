Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B82A830A252
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 08:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbhBAHCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 02:02:41 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:54256 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230370AbhBAHBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 02:01:16 -0500
X-UUID: b2f6422f227e43cd86d15f20426e9095-20210201
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ksWDjdJ48Btfk8ddOv3fAwt5z0f3FlnUo8s+iKrtJGk=;
        b=ER6sv75y4sxH0ddu1H4Xr56vRdTB8ZUoyZNSVQOhoB39J429omyvbTvq8F9JPZwWehVKjfTWzdXEnca4Z3Nq6dbVE2h4Ft4EHYKTx9j1Ninh0SFNhik0RB/efXyuxCi57fBhrgNzalMSNqmOb80cc+R5zG60LQ6+tyyaFnwdsQU=;
X-UUID: b2f6422f227e43cd86d15f20426e9095-20210201
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1950401544; Mon, 01 Feb 2021 15:00:28 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 1 Feb 2021 15:00:26 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 1 Feb 2021 15:00:26 +0800
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
Subject: [PATCH next v3 06/16] dt-bindings: usb: mtk-xhci: add optional assigned clock properties
Date:   Mon, 1 Feb 2021 15:00:06 +0800
Message-ID: <20210201070016.41721-6-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210201070016.41721-1-chunfeng.yun@mediatek.com>
References: <20210201070016.41721-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 90453647E3F7F6ACB7CF83D112EDEDFBD61840F07330ADBCDC51CC288D4D823A2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIG9wdGlvbmFsIHByb3BlcnR5ICJhc3NpZ25lZC1jbG9jayIgYW5kICJhc3NpZ25lZC1jbG9j
ay1wYXJlbnRzIg0KdXNlZCBieSBtdDc2MjkuDQoNClNpZ25lZC1vZmYtYnk6IENodW5mZW5nIFl1
biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0KdjM6IG5vIGNoYW5nZXMNCnYyOiBz
ZXBhcmF0ZSBjb21wYXRpYmxlIG91dCBvZiB0aGUgcGF0Y2gNCi0tLQ0KIC4uLi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3VzYi9tZWRpYXRlayxtdGsteGhjaS55YW1sICAgICAgICB8IDggKysrKysrKysN
CiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL21lZGlhdGVrLG10ay14aGNpLnlhbWwgYi9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL21lZGlhdGVrLG10ay14aGNpLnlh
bWwNCmluZGV4IGEzODE3ZjNhZjU5ZC4uNWViOGQ3Y2Q4MTU1IDEwMDY0NA0KLS0tIGEvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9tZWRpYXRlayxtdGsteGhjaS55YW1sDQor
KysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL21lZGlhdGVrLG10ay14
aGNpLnlhbWwNCkBAIC02Nyw2ICs2NywxNCBAQCBwcm9wZXJ0aWVzOg0KICAgICAgIC0gY29uc3Q6
IGRtYV9jaw0KICAgICAgIC0gY29uc3Q6IHhoY2lfY2sNCiANCisgIGFzc2lnbmVkLWNsb2NrczoN
CisgICAgbWluSXRlbXM6IDENCisgICAgbWF4SXRlbXM6IDUNCisNCisgIGFzc2lnbmVkLWNsb2Nr
LXBhcmVudHM6DQorICAgIG1pbkl0ZW1zOiAxDQorICAgIG1heEl0ZW1zOiA1DQorDQogICBwaHlz
Og0KICAgICBkZXNjcmlwdGlvbjoNCiAgICAgICBMaXN0IG9mIGFsbCBQSFlzIHVzZWQgb24gdGhp
cyBIQ0QsIGl0J3MgYmV0dGVyIHRvIGtlZXAgUEhZcyBpbiBvcmRlcg0KLS0gDQoyLjE4LjANCg==

