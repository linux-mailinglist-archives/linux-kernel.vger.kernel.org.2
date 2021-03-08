Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D645633078C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 06:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbhCHFiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 00:38:22 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:24402 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234434AbhCHFiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 00:38:01 -0500
X-UUID: d89e5ad5326740eabc76353445696eb9-20210308
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=llqE24sKgL7zQWwLPHyxmkgspiX47OBKlGabmsB32os=;
        b=Y2Y2AGisxytqUtf078/F69nQsHwpopOKBna9an948xq/mRiW/sWLH258eaUtuXVI3nnYyUU97/HG1peSz1stGg+/+kze7yGtBVsRkQ3+LfmhF6K3MX205YZXWGHxKOoZSUUjSKUTvTMqT2xYEBy6cf/Zdnxx2CRydPcOX084KCU=;
X-UUID: d89e5ad5326740eabc76353445696eb9-20210308
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 10139396; Mon, 08 Mar 2021 13:37:51 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 8 Mar 2021 13:37:47 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 8 Mar 2021 13:37:47 +0800
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
Subject: [PATCH v4 03/12] dt-bindings: phy: mediatek: hdmi-phy: modify compatible items
Date:   Mon, 8 Mar 2021 13:37:36 +0800
Message-ID: <20210308053745.25697-3-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210308053745.25697-1-chunfeng.yun@mediatek.com>
References: <20210308053745.25697-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: E076E466938FDB67E9AA4C34D6820DCF2CFEFFED297F42A4D7C886FDDC223BAF2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bXQ3NjIzLWhkbWktdHggaXMgY29tcGF0aWJsZSB0byBtdDI3MDEtaGRtaS10eCwgYW5kIHRoZSBj
b21wYXRpYmxlDQoibWVkaWF0ZWssbXQ3NjIzLWhkbWktdHgiIGlzIG5vdCBzdXBwb3J0ZWQgaW4g
ZHJpdmVyLCBpbiBmYWN0IHVzZXMNCiJtZWRpYXRlayxtdDI3MDEtaGRtaS10eCIgaW5zdGVhZCBv
biBNVDc2MjMsIHNvIGNoYW5nZXMgdGhlDQpjb21wYXRpYmxlIGl0ZW1zIHRvIG1ha2UgZGVwZW5k
ZW5jZSBjbGVhci4NCg0KQ2M6IENodW4tS3VhbmcgSHUgPGNodW5rdWFuZy5odUBrZXJuZWwub3Jn
Pg0KQ2M6IFBoaWxpcHAgWmFiZWwgPHAuemFiZWxAcGVuZ3V0cm9uaXguZGU+DQpBY2tlZC1ieTog
Q2h1bi1LdWFuZyBIdSA8Y2h1bmt1YW5nLmh1QGtlcm5lbC5vcmc+DQpSZXZpZXdlZC1ieTogUm9i
IEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NClNpZ25lZC1vZmYtYnk6IENodW5mZW5nIFl1biA8
Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0KdjQ6IGFkZCBhY2tlZC1ieSBDSyBhbmQg
UmV2aWV3ZWQtYnkgUm9iDQp2MzogbW9kaWZ5IGNvbW1pdCBtZXNzYWdlDQp2Mjogbm8gY2hhbmdl
cw0KLS0tDQogLi4uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5L21lZGlhdGVrLGhkbWktcGh5Lnlh
bWwgICAgfCAxMSArKysrKysrLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyks
IDQgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvcGh5L21lZGlhdGVrLGhkbWktcGh5LnlhbWwgYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvcGh5L21lZGlhdGVrLGhkbWktcGh5LnlhbWwNCmluZGV4IDQ3NTI1MTdh
MTQ0Ni4uMGQ5NDk1MGI4NGNhIDEwMDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3BoeS9tZWRpYXRlayxoZG1pLXBoeS55YW1sDQorKysgYi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvcGh5L21lZGlhdGVrLGhkbWktcGh5LnlhbWwNCkBAIC0yMSwx
MCArMjEsMTMgQEAgcHJvcGVydGllczoNCiAgICAgcGF0dGVybjogIl5oZG1pLXBoeUBbMC05YS1m
XSskIg0KIA0KICAgY29tcGF0aWJsZToNCi0gICAgZW51bToNCi0gICAgICAtIG1lZGlhdGVrLG10
MjcwMS1oZG1pLXBoeQ0KLSAgICAgIC0gbWVkaWF0ZWssbXQ3NjIzLWhkbWktcGh5DQotICAgICAg
LSBtZWRpYXRlayxtdDgxNzMtaGRtaS1waHkNCisgICAgb25lT2Y6DQorICAgICAgLSBpdGVtczoN
CisgICAgICAgICAgLSBlbnVtOg0KKyAgICAgICAgICAgICAgLSBtZWRpYXRlayxtdDc2MjMtaGRt
aS1waHkNCisgICAgICAgICAgLSBjb25zdDogbWVkaWF0ZWssbXQyNzAxLWhkbWktcGh5DQorICAg
ICAgLSBjb25zdDogbWVkaWF0ZWssbXQyNzAxLWhkbWktcGh5DQorICAgICAgLSBjb25zdDogbWVk
aWF0ZWssbXQ4MTczLWhkbWktcGh5DQogDQogICByZWc6DQogICAgIG1heEl0ZW1zOiAxDQotLSAN
CjIuMTguMA0K

