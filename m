Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36EDC30A258
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 08:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbhBAHDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 02:03:18 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:58592 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231671AbhBAHBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 02:01:19 -0500
X-UUID: 9e79d484985c483dabf9b80650152c92-20210201
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=s9ywuzePh4ZaZwelQSe4W+2ae7xBqYx7pADQv79ICf4=;
        b=QE6rSyEAwAFMGFQ+itImFNhEYGjNu1wuNQvXsSgbO1ic6sHUAHqdtN7kD/A6MQ8FvIn6AhOiJsFQNC50hTXziJQmMP6icmtt286pUvUtpb5mrl4qNb0fCpw8YHaW//gOPHd6OWt1TO6rEl2HG3ocWV61VlH3CvVS0eGD0CH0CGc=;
X-UUID: 9e79d484985c483dabf9b80650152c92-20210201
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1200115717; Mon, 01 Feb 2021 15:00:30 +0800
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
Subject: [PATCH next v3 05/16] dt-bindings: phy: mediatek: tphy: change patternProperties
Date:   Mon, 1 Feb 2021 15:00:05 +0800
Message-ID: <20210201070016.41721-5-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210201070016.41721-1-chunfeng.yun@mediatek.com>
References: <20210201070016.41721-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 54906B7F564A1F3B4718B10A1E167ECE13F769630EAF91095C2A3F6422E88CBD2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIHBoeSBtYXkgYmUgbmFtZWQgYXMgcGNpZS1waHkgd2hlbiB0aGUgVC1QSFkgb25seSBzdXBw
b3J0cw0KUENJZSBtb2RlLCBpdCdzIGFsc28gdGhlIHNpbWlsYXIgY2FzZSBmb3IgU0FUQSwgbmFt
ZWQgYXMNCnNhdGEtcGh5Lg0KDQpTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5n
Lnl1bkBtZWRpYXRlay5jb20+DQotLS0NCnYyfnYzOiBubyBjaGFuZ2VzDQotLS0NCiBEb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5L21lZGlhdGVrLHRwaHkueWFtbCB8IDIgKy0N
CiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAt
LWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvbWVkaWF0ZWssdHBo
eS55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9tZWRpYXRlayx0
cGh5LnlhbWwNCmluZGV4IDYwMmU2ZmY0NTc4NS4uNGYxNzMzZmQ5YTU1IDEwMDY0NA0KLS0tIGEv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9tZWRpYXRlayx0cGh5LnlhbWwN
CisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvbWVkaWF0ZWssdHBo
eS55YW1sDQpAQCAtMTE3LDcgKzExNyw3IEBAIHByb3BlcnRpZXM6DQogDQogIyBSZXF1aXJlZCBj
aGlsZCBub2RlOg0KIHBhdHRlcm5Qcm9wZXJ0aWVzOg0KLSAgIl51c2ItcGh5QFswLTlhLWZdKyQi
Og0KKyAgIl4odXNifHBjaWV8c2F0YSktcGh5QFswLTlhLWZdKyQiOg0KICAgICB0eXBlOiBvYmpl
Y3QNCiAgICAgZGVzY3JpcHRpb246DQogICAgICAgQSBzdWItbm9kZSBpcyByZXF1aXJlZCBmb3Ig
ZWFjaCBwb3J0IHRoZSBjb250cm9sbGVyIHByb3ZpZGVzLg0KLS0gDQoyLjE4LjANCg==

