Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4708330794
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 06:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbhCHFi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 00:38:26 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:31575 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234433AbhCHFiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 00:38:02 -0500
X-UUID: 6cceb98488ba4f44ae6c7e2ec8a2e1b5-20210308
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=C/+VtsC1KHbynvja1BhTvmGSx2N0wEeKmXK19/IVtZk=;
        b=esvKLgjsUIH46Z4GXFeXSNM+wBeq5ZzznCqtuPsQ/08BqNhlwy7175WE9pSwTziHGwrfBMehqAjUfXtIGzg+IcH6Qrpw3KoKuXSj2NDkWoE1FjLo4xoLYLWksVEbJ10PpSVHID0WJO2DRl4o0fXvQYl/+xINSx7Wu11AipbE0uY=;
X-UUID: 6cceb98488ba4f44ae6c7e2ec8a2e1b5-20210308
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1808187120; Mon, 08 Mar 2021 13:37:51 +0800
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
Subject: [PATCH v4 02/12] dt-bindings: phy: mediatek: dsi-phy: modify compatible dependence
Date:   Mon, 8 Mar 2021 13:37:35 +0800
Message-ID: <20210308053745.25697-2-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210308053745.25697-1-chunfeng.yun@mediatek.com>
References: <20210308053745.25697-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: FE05A25379E27531EA4035143E5C47758A7E85BFDD9DDA7A0CEA06112A180A2A2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bXQ3NjIzLW1pcGktdHggaXMgY29tcGF0aWJsZSB0byBtdDI3MDEtbWlwaS10eCwgYW5kIHVzZQ0K
Im1lZGlhdGVrLG10MjcwMS1taXBpLXR4IiBpbnN0ZWFkIG9uIE1UNzYyMywgc28gbW9kaWZ5DQp0
aGUgY29tcGF0aWJsZSBpdGVtcyB0byBtYWtlIGRlcGVuZGVuY2UgY2xlYXIuDQoNCkNjOiBDaHVu
LUt1YW5nIEh1IDxjaHVua3VhbmcuaHVAa2VybmVsLm9yZz4NCkNjOiBQaGlsaXBwIFphYmVsIDxw
LnphYmVsQHBlbmd1dHJvbml4LmRlPg0KQWNrZWQtYnk6IENodW4tS3VhbmcgSHUgPGNodW5rdWFu
Zy5odUBrZXJuZWwub3JnPg0KUmV2aWV3ZWQtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5v
cmc+DQpTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5j
b20+DQotLS0NCnY0OiBhZGQgYWNrZWQtYnkgQ0ssIGFuZCByZXZpZXdlZC1ieSBSb2INCnYzOiBt
b2RpZnkgY29tbWl0IG1lc3NhZ2Ugc3VnZ2VzdGVkIGJ5IENLDQp2Mjogc2VwYXJhdGUgdHdvIHBh
dGNoZXMgc3VnZ2VzdGVkIGJ5IENLDQotLS0NCiAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkv
bWVkaWF0ZWssZHNpLXBoeS55YW1sICAgfCAxMyArKysrKysrKy0tLS0tDQogMSBmaWxlIGNoYW5n
ZWQsIDggaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvbWVkaWF0ZWssZHNpLXBoeS55YW1sIGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9tZWRpYXRlayxkc2ktcGh5Lnlh
bWwNCmluZGV4IDcxZDRhY2VhMWY2Ni4uNmU0ZDc5NWY5YjAyIDEwMDY0NA0KLS0tIGEvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9tZWRpYXRlayxkc2ktcGh5LnlhbWwNCisr
KyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvbWVkaWF0ZWssZHNpLXBo
eS55YW1sDQpAQCAtMTksMTEgKzE5LDE0IEBAIHByb3BlcnRpZXM6DQogICAgIHBhdHRlcm46ICJe
ZHNpLXBoeUBbMC05YS1mXSskIg0KIA0KICAgY29tcGF0aWJsZToNCi0gICAgZW51bToNCi0gICAg
ICAtIG1lZGlhdGVrLG10MjcwMS1taXBpLXR4DQotICAgICAgLSBtZWRpYXRlayxtdDc2MjMtbWlw
aS10eA0KLSAgICAgIC0gbWVkaWF0ZWssbXQ4MTczLW1pcGktdHgNCi0gICAgICAtIG1lZGlhdGVr
LG10ODE4My1taXBpLXR4DQorICAgIG9uZU9mOg0KKyAgICAgIC0gaXRlbXM6DQorICAgICAgICAg
IC0gZW51bToNCisgICAgICAgICAgICAgIC0gbWVkaWF0ZWssbXQ3NjIzLW1pcGktdHgNCisgICAg
ICAgICAgLSBjb25zdDogbWVkaWF0ZWssbXQyNzAxLW1pcGktdHgNCisgICAgICAtIGNvbnN0OiBt
ZWRpYXRlayxtdDI3MDEtbWlwaS10eA0KKyAgICAgIC0gY29uc3Q6IG1lZGlhdGVrLG10ODE3My1t
aXBpLXR4DQorICAgICAgLSBjb25zdDogbWVkaWF0ZWssbXQ4MTgzLW1pcGktdHgNCiANCiAgIHJl
ZzoNCiAgICAgbWF4SXRlbXM6IDENCi0tIA0KMi4xOC4wDQo=

