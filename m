Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 542AE30A25E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 08:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbhBAHDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 02:03:48 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:22167 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231397AbhBAHBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 02:01:21 -0500
X-UUID: a57ac4a50aa04cc8a8b4522cc5af59d3-20210201
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=z5r70+9rgwU6y6E7E3plcjbeSmnNuCUMkSNEU5M6n4E=;
        b=htMQUBCDCqb6gprDjp3r0ShhPHp+80gzUO92AsLhx78cHEvr2zRKg8lpdnodJZTjxCO6k/h9nYAUjacwL68Qk6lcWc97Eeb5p5NgkZse94A21gW0Qm1Z58hsuHEhN2Pr73Xkjtcj8MWVQbI329YsQzUVkFS1VUa737waRIKGVD0=;
X-UUID: a57ac4a50aa04cc8a8b4522cc5af59d3-20210201
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1507167184; Mon, 01 Feb 2021 15:00:33 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 1 Feb 2021 15:00:23 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 1 Feb 2021 15:00:23 +0800
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
Subject: [PATCH next v3 01/16] dt-bindings: usb: fix yamllint check warning
Date:   Mon, 1 Feb 2021 15:00:01 +0800
Message-ID: <20210201070016.41721-1-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 4468B2AEFC27B0EAEC6BAE2D8FB2451B2DF0B819B20A79B05B278FE9CBEE39DF2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rml4IHdhcm5pbmc6ICJtaXNzaW5nIHN0YXJ0aW5nIHNwYWNlIGluIGNvbW1lbnQiDQoNClNpZ25l
ZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0K
djJ+djM6IG5vIGNoYW5nZXMNCi0tLQ0KIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy91c2IvdXNiLWRldmljZS55YW1sIHwgNiArKystLS0NCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNl
cnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi91c2ItZGV2aWNlLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvdXNiL3VzYi1kZXZpY2UueWFtbA0KaW5kZXggN2JiMjVhNDU0Mjdk
Li4yM2U3NmNmYjIwNjYgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvdXNiL3VzYi1kZXZpY2UueWFtbA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3VzYi91c2ItZGV2aWNlLnlhbWwNCkBAIC04Miw5ICs4Miw5IEBAIHJlcXVpcmVk
Og0KIGFkZGl0aW9uYWxQcm9wZXJ0aWVzOiB0cnVlDQogDQogZXhhbXBsZXM6DQotICAjaHViIGNv
bm5lY3RlZCB0byBwb3J0IDENCi0gICNkZXZpY2UgY29ubmVjdGVkIHRvIHBvcnQgMg0KLSAgI2Rl
dmljZSBjb25uZWN0ZWQgdG8gcG9ydCAzDQorICAjIGh1YiBjb25uZWN0ZWQgdG8gcG9ydCAxDQor
ICAjIGRldmljZSBjb25uZWN0ZWQgdG8gcG9ydCAyDQorICAjIGRldmljZSBjb25uZWN0ZWQgdG8g
cG9ydCAzDQogICAjICAgIGludGVyZmFjZSAwIG9mIGNvbmZpZ3VyYXRpb24gMQ0KICAgIyAgICBp
bnRlcmZhY2UgMCBvZiBjb25maWd1cmF0aW9uIDINCiAgIC0gfA0KLS0gDQoyLjE4LjANCg==

