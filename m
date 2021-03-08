Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAAC5330792
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 06:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234507AbhCHFiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 00:38:24 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:41111 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234411AbhCHFiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 00:38:02 -0500
X-UUID: fe2b2a7dd8c04237bec13d37aae6f2a4-20210308
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=duibJY2YTv+C41rmyl3rhe2lKcaSBNkOYAKx83YZv+M=;
        b=aJ9dmLX1UykK6/w+S62E3XTlPt1xP+nutCAQwb30TNw4ESbsByH1kreDR2F82pE2YnBuutBHk5RYQcwUZsTB+TXbA9r3PGisce6jxr1tm+ybAuA2m2yq6BJ5gcfDGRBkuf6rfzYsJDZneAjnCek3M/3v+tw752Fdx5ag0zAkYMs=;
X-UUID: fe2b2a7dd8c04237bec13d37aae6f2a4-20210308
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1318335507; Mon, 08 Mar 2021 13:37:49 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 8 Mar 2021 13:37:47 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 8 Mar 2021 13:37:46 +0800
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
Subject: [PATCH v4 01/12] dt-bindings: usb: fix yamllint check warning
Date:   Mon, 8 Mar 2021 13:37:34 +0800
Message-ID: <20210308053745.25697-1-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: B6070E33E0F9755F98E1E00DDE465C3EE16D1F23FB292A9A27C75017C074CF8A2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rml4IHdhcm5pbmc6ICJtaXNzaW5nIHN0YXJ0aW5nIHNwYWNlIGluIGNvbW1lbnQiDQoNClNpZ25l
ZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0K
djJ+djQ6IG5vIGNoYW5nZXMNCi0tLQ0KIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy91c2IvdXNiLWRldmljZS55YW1sIHwgNiArKystLS0NCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNl
cnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi91c2ItZGV2aWNlLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvdXNiL3VzYi1kZXZpY2UueWFtbA0KaW5kZXggZDRjOTk4MDllZTlh
Li5iNzc5NjBhN2EzN2IgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvdXNiL3VzYi1kZXZpY2UueWFtbA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3VzYi91c2ItZGV2aWNlLnlhbWwNCkBAIC04Miw5ICs4Miw5IEBAIHJlcXVpcmVk
Og0KIGFkZGl0aW9uYWxQcm9wZXJ0aWVzOiB0cnVlDQogDQogZXhhbXBsZXM6DQotICAjaHViIGNv
bm5lY3RlZCB0byBwb3J0IDENCi0gICNkZXZpY2UgY29ubmVjdGVkIHRvIHBvcnQgMg0KLSAgI2Rl
dmljZSBjb25uZWN0ZWQgdG8gcG9ydCAzDQorICAjIGh1YiBjb25uZWN0ZWQgdG8gcG9ydCAxDQor
ICAjIGRldmljZSBjb25uZWN0ZWQgdG8gcG9ydCAyDQorICAjIGRldmljZSBjb25uZWN0ZWQgdG8g
cG9ydCAzDQogICAjICAgIGludGVyZmFjZSAwIG9mIGNvbmZpZ3VyYXRpb24gMQ0KICAgIyAgICBp
bnRlcmZhY2UgMCBvZiBjb25maWd1cmF0aW9uIDINCiAgIC0gfA0KLS0gDQoyLjE4LjANCg==

