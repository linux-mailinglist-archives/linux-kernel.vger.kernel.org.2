Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD2030A24D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 08:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbhBAHCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 02:02:12 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:33597 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231670AbhBAHBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 02:01:14 -0500
X-UUID: 54592bc8c0a241c1be59f998444c7013-20210201
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=eYK624hKYzP1+9o6nTUm21Bltz59rEsfLsMvs3ZxtgU=;
        b=iuqP0nwzTSJpzT/p+vG4+buCXF6BsXd8LgEfkz5ZHwkR0nzcN+IeBNLmsAOm3F/7MYM9cm3v4oiFpVEEByBKCTyTK7+a9D6w7pU/Ph13ogrVeWtcKdDsOoDr0uCuYt3+7Quuu5zel46o5QM9nCqONlygnm6VxFj/FLJbR0Dr+qc=;
X-UUID: 54592bc8c0a241c1be59f998444c7013-20210201
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 410876249; Mon, 01 Feb 2021 15:00:28 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 1 Feb 2021 15:00:25 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 1 Feb 2021 15:00:25 +0800
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
Subject: [PATCH next v3 04/16] dt-bindings: phy: mediatek: hdmi-phy: modify compatible items
Date:   Mon, 1 Feb 2021 15:00:04 +0800
Message-ID: <20210201070016.41721-4-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210201070016.41721-1-chunfeng.yun@mediatek.com>
References: <20210201070016.41721-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 165C1A7FD15B0E9A9FA74935E53F5F751508C62CEC0D1C611E3264E2EEC8DBAB2000:8
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
Pg0KQ2M6IFBoaWxpcHAgWmFiZWwgPHAuemFiZWxAcGVuZ3V0cm9uaXguZGU+DQpTaWduZWQtb2Zm
LWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQotLS0NCnYzOiBt
b2RpZnkgY29tbWl0IG1lc3NhZ2UNCnYyOiBubyBjaGFuZ2VzDQotLS0NCiAuLi4vZGV2aWNldHJl
ZS9iaW5kaW5ncy9waHkvbWVkaWF0ZWssaGRtaS1waHkueWFtbCAgICB8IDExICsrKysrKystLS0t
DQogMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCg0KZGlm
ZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvbWVkaWF0ZWss
aGRtaS1waHkueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvbWVk
aWF0ZWssaGRtaS1waHkueWFtbA0KaW5kZXggNDc1MjUxN2ExNDQ2Li4wZDk0OTUwYjg0Y2EgMTAw
NjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5L21lZGlhdGVr
LGhkbWktcGh5LnlhbWwNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9w
aHkvbWVkaWF0ZWssaGRtaS1waHkueWFtbA0KQEAgLTIxLDEwICsyMSwxMyBAQCBwcm9wZXJ0aWVz
Og0KICAgICBwYXR0ZXJuOiAiXmhkbWktcGh5QFswLTlhLWZdKyQiDQogDQogICBjb21wYXRpYmxl
Og0KLSAgICBlbnVtOg0KLSAgICAgIC0gbWVkaWF0ZWssbXQyNzAxLWhkbWktcGh5DQotICAgICAg
LSBtZWRpYXRlayxtdDc2MjMtaGRtaS1waHkNCi0gICAgICAtIG1lZGlhdGVrLG10ODE3My1oZG1p
LXBoeQ0KKyAgICBvbmVPZjoNCisgICAgICAtIGl0ZW1zOg0KKyAgICAgICAgICAtIGVudW06DQor
ICAgICAgICAgICAgICAtIG1lZGlhdGVrLG10NzYyMy1oZG1pLXBoeQ0KKyAgICAgICAgICAtIGNv
bnN0OiBtZWRpYXRlayxtdDI3MDEtaGRtaS1waHkNCisgICAgICAtIGNvbnN0OiBtZWRpYXRlayxt
dDI3MDEtaGRtaS1waHkNCisgICAgICAtIGNvbnN0OiBtZWRpYXRlayxtdDgxNzMtaGRtaS1waHkN
CiANCiAgIHJlZzoNCiAgICAgbWF4SXRlbXM6IDENCi0tIA0KMi4xOC4wDQo=

