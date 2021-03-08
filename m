Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81897330786
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 06:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234473AbhCHFiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 00:38:18 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:47249 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234321AbhCHFiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 00:38:00 -0500
X-UUID: d80e444412604f59b28fcac5afcd22ec-20210308
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=EniOu1tncIIHDsjssZt3Q2bbxSbEfPA8v2iNQBfydeA=;
        b=YGm63sTyQO4vNTW4WSuFG4Wm1IXzD3AIq2Fs2PfpiWxK3FvyuwHcuv8GogrzmR9FTgl2X4u49f+TFhpCr2zRO1Tk1lKJepGz+LAiQrttlMHZiuNGdlNao5d9q1wTIGtCa/YQy/4FiS62XWJqj9fuoMAU0AIq94NnbXyZgnEigGo=;
X-UUID: d80e444412604f59b28fcac5afcd22ec-20210308
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1350565446; Mon, 08 Mar 2021 13:37:50 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 8 Mar 2021 13:37:48 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 8 Mar 2021 13:37:48 +0800
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
Subject: [PATCH v4 04/12] dt-bindings: phy: mediatek: tphy: change patternProperties
Date:   Mon, 8 Mar 2021 13:37:37 +0800
Message-ID: <20210308053745.25697-4-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210308053745.25697-1-chunfeng.yun@mediatek.com>
References: <20210308053745.25697-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 20CC00FA3B30109FA6AA89CBE3EDAACC801278D43731D98883F658138FE97FD52000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIHBoeSBtYXkgYmUgbmFtZWQgYXMgcGNpZS1waHkgd2hlbiB0aGUgVC1QSFkgb25seSBzdXBw
b3J0cw0KUENJZSBtb2RlLCBpdCdzIGFsc28gdGhlIHNpbWlsYXIgY2FzZSBmb3IgU0FUQSwgbmFt
ZWQgYXMNCnNhdGEtcGh5Lg0KDQpSZXZpZXdlZC1ieTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVs
Lm9yZz4NClNpZ25lZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVr
LmNvbT4NCi0tLQ0KdjQ6IGFkZCByZXZpZXdlZC1ieSBSb2INCnYyfnYzOiBubyBjaGFuZ2VzDQot
LS0NCiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5L21lZGlhdGVrLHRwaHku
eWFtbCB8IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24o
LSkNCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkv
bWVkaWF0ZWssdHBoeS55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Bo
eS9tZWRpYXRlayx0cGh5LnlhbWwNCmluZGV4IDYwMmU2ZmY0NTc4NS4uNGYxNzMzZmQ5YTU1IDEw
MDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9tZWRpYXRl
ayx0cGh5LnlhbWwNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkv
bWVkaWF0ZWssdHBoeS55YW1sDQpAQCAtMTE3LDcgKzExNyw3IEBAIHByb3BlcnRpZXM6DQogDQog
IyBSZXF1aXJlZCBjaGlsZCBub2RlOg0KIHBhdHRlcm5Qcm9wZXJ0aWVzOg0KLSAgIl51c2ItcGh5
QFswLTlhLWZdKyQiOg0KKyAgIl4odXNifHBjaWV8c2F0YSktcGh5QFswLTlhLWZdKyQiOg0KICAg
ICB0eXBlOiBvYmplY3QNCiAgICAgZGVzY3JpcHRpb246DQogICAgICAgQSBzdWItbm9kZSBpcyBy
ZXF1aXJlZCBmb3IgZWFjaCBwb3J0IHRoZSBjb250cm9sbGVyIHByb3ZpZGVzLg0KLS0gDQoyLjE4
LjANCg==

