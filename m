Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 589CB30A264
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 08:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbhBAHFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 02:05:04 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:8659 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230224AbhBAHBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 02:01:34 -0500
X-UUID: 497ac2b233684a50a66ef42c861a9b53-20210201
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=UhlhXIXKE5s64298tbHlRuE71NSbu0o8CWqRTu2Bzhc=;
        b=aBX66KsqfJZpwOh3ZCf5jnWAgNFXHzBvAe62DqdklEjuwf4el0xZpo7Edi2IIfrpnEDAO5narEf+QpXxah8ybWw7OIky3yPCgNwoXmFu6sUkkh1Lgn7/CSBbn6D1dTDw/BgRVMiX+6zjJMiS7oa3GYteL4HIE+K7tfn7EsKRq5g=;
X-UUID: 497ac2b233684a50a66ef42c861a9b53-20210201
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1536463021; Mon, 01 Feb 2021 15:00:26 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 1 Feb 2021 15:00:24 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 1 Feb 2021 15:00:24 +0800
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
Subject: [PATCH next v3 02/16] dt-bindings: usb: mediatek: fix yamllint check warning
Date:   Mon, 1 Feb 2021 15:00:02 +0800
Message-ID: <20210201070016.41721-2-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210201070016.41721-1-chunfeng.yun@mediatek.com>
References: <20210201070016.41721-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 1337AA850911A56D2596727B7AEE040A8D22A95BD71EB5C3EA060D0DE231915F2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rml4IHdhcm5pbmc6ICJ0b28gbWFueSBzcGFjZXMgaW5zaWRlIGJyYWNrZXRzIg0KDQpTaWduZWQt
b2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQotLS0NCnYy
fnYzOiBubyBjaGFuZ2VzDQotLS0NCiAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0
ZWssbXRrLXhoY2kueWFtbCAgICAgICAgICB8IDIgKy0NCiBEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvdXNiL21lZGlhdGVrLG10dTMueWFtbCAgICB8IDYgKysrLS0tDQogRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9tZWRpYXRlayxtdXNiLnlhbWwgICAgfCA0
ICsrLS0NCiAzIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkN
Cg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvbWVk
aWF0ZWssbXRrLXhoY2kueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91
c2IvbWVkaWF0ZWssbXRrLXhoY2kueWFtbA0KaW5kZXggMzhiMWZlMThhYTc5Li5hMzgxN2YzYWY1
OWQgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL21l
ZGlhdGVrLG10ay14aGNpLnlhbWwNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy91c2IvbWVkaWF0ZWssbXRrLXhoY2kueWFtbA0KQEAgLTEzOSw3ICsxMzksNyBAQCBwYXR0
ZXJuUHJvcGVydGllczoNCiAgICAgZGVzY3JpcHRpb246IFRoZSBoYXJkIHdpcmVkIFVTQiBkZXZp
Y2VzLg0KIA0KIGRlcGVuZGVuY2llczoNCi0gIHdha2V1cC1zb3VyY2U6IFsgJ21lZGlhdGVrLHN5
c2Nvbi13YWtldXAnIF0NCisgIHdha2V1cC1zb3VyY2U6IFsnbWVkaWF0ZWssc3lzY29uLXdha2V1
cCddDQogDQogcmVxdWlyZWQ6DQogICAtIGNvbXBhdGlibGUNCmRpZmYgLS1naXQgYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL21lZGlhdGVrLG10dTMueWFtbCBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWssbXR1My55YW1sDQppbmRl
eCBmNWMwNGI5ZDJkZTkuLjY2ZDc4ZjUzNDcyMiAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWssbXR1My55YW1sDQorKysgYi9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL21lZGlhdGVrLG10dTMueWFtbA0KQEAgLTE3
Miw5ICsxNzIsOSBAQCBwYXR0ZXJuUHJvcGVydGllczoNCiAgICAgICBleGFtcGxlIGlmIHRoZSBo
b3N0IG1vZGUgaXMgZW5hYmxlZC4NCiANCiBkZXBlbmRlbmNpZXM6DQotICBjb25uZWN0b3I6IFsg
J3VzYi1yb2xlLXN3aXRjaCcgXQ0KLSAgcG9ydDogWyAndXNiLXJvbGUtc3dpdGNoJyBdDQotICB3
YWtldXAtc291cmNlOiBbICdtZWRpYXRlayxzeXNjb24td2FrZXVwJyBdDQorICBjb25uZWN0b3I6
IFsndXNiLXJvbGUtc3dpdGNoJ10NCisgIHBvcnQ6IFsndXNiLXJvbGUtc3dpdGNoJ10NCisgIHdh
a2V1cC1zb3VyY2U6IFsnbWVkaWF0ZWssc3lzY29uLXdha2V1cCddDQogDQogcmVxdWlyZWQ6DQog
ICAtIGNvbXBhdGlibGUNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvdXNiL21lZGlhdGVrLG11c2IueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy91c2IvbWVkaWF0ZWssbXVzYi55YW1sDQppbmRleCA3OTBlZmU4YjYyNzQuLmE1MTVj
OWYzMGI5NiAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91
c2IvbWVkaWF0ZWssbXVzYi55YW1sDQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvdXNiL21lZGlhdGVrLG11c2IueWFtbA0KQEAgLTY2LDggKzY2LDggQEAgcHJvcGVydGll
czoNCiAgICAgdHlwZTogb2JqZWN0DQogDQogZGVwZW5kZW5jaWVzOg0KLSAgdXNiLXJvbGUtc3dp
dGNoOiBbICdjb25uZWN0b3InIF0NCi0gIGNvbm5lY3RvcjogWyAndXNiLXJvbGUtc3dpdGNoJyBd
DQorICB1c2Itcm9sZS1zd2l0Y2g6IFsnY29ubmVjdG9yJ10NCisgIGNvbm5lY3RvcjogWyd1c2It
cm9sZS1zd2l0Y2gnXQ0KIA0KIHJlcXVpcmVkOg0KICAgLSBjb21wYXRpYmxlDQotLSANCjIuMTgu
MA0K

