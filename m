Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38BC4307049
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 08:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbhA1Hxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 02:53:54 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:59417 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232117AbhA1Hww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:52:52 -0500
X-UUID: da41bc8928254adc8fa28c9ad673101a-20210128
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=a0Hgwxh0U2dNx+VXIaMoTg0BoqJmUmGXjqMHEveUMYI=;
        b=k7G1Do1mkH8worFAUJwK9gCf4xthpbVWgKX1XSAMwyTsqXOSp38WvQYa+84dsbDQEH9QRESVFprkwbqZsgcMSXzLlfYlf6cgLetu3a73ps4G92bxneHtuw5NCrqXPUnFRkwOnt/tlKwc9D1EqTy4YMU7tuJcK7mZUTecBhaQq9c=;
X-UUID: da41bc8928254adc8fa28c9ad673101a-20210128
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 451889016; Thu, 28 Jan 2021 15:50:57 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 28 Jan 2021 15:50:51 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 28 Jan 2021 15:50:51 +0800
Message-ID: <1611820251.16091.7.camel@mtksdaap41>
Subject: Re: [PATCH v11 3/9] drm/mediatek: add RDMA fifo size error handle
From:   CK Hu <ck.hu@mediatek.com>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Date:   Thu, 28 Jan 2021 15:50:51 +0800
In-Reply-To: <20210128072802.830971-4-hsinyi@chromium.org>
References: <20210128072802.830971-1-hsinyi@chromium.org>
         <20210128072802.830971-4-hsinyi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 61BF84BE02DCD629C3988D9D0702E6990B22EBCDA46936C4F590F0B3D1E4579F2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEhzaW4tWWk6DQoNCk9uIFRodSwgMjAyMS0wMS0yOCBhdCAxNToyNyArMDgwMCwgSHNpbi1Z
aSBXYW5nIHdyb3RlOg0KPiBGcm9tOiBZb25ncWlhbmcgTml1IDx5b25ncWlhbmcubml1QG1lZGlh
dGVrLmNvbT4NCj4gDQo+IFRoaXMgcGF0Y2ggYWRkIFJETUEgZmlmbyBzaXplIGVycm9yIGhhbmRs
ZQ0KPiByZG1hIGZpZm8gc2l6ZSB3aWxsIG5vdCBhbHdheXMgYmlnZ2VyIHRoYW4gdGhlIGNhbGN1
bGF0ZWQgdGhyZXNob2xkDQo+IGlmIHRoYXQgY2FzZSBoYXBwZW5lZCwgd2UgbmVlZCBzZXQgZmlm
byBzaXplIGFzIHRoZSB0aHJlc2hvbGQNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFlvbmdxaWFuZyBO
aXUgPHlvbmdxaWFuZy5uaXVAbWVkaWF0ZWsuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBIc2luLVlp
IFdhbmcgPGhzaW55aUBjaHJvbWl1bS5vcmc+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kaXNwX3JkbWEuYyB8IDQgKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5z
ZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZGlzcF9yZG1hLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfcmRtYS5j
DQo+IGluZGV4IGI4NDAwNDM5NDk3MGYuLjA0Yjk1NDIwMTBiMDAgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9yZG1hLmMNCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kaXNwX3JkbWEuYw0KPiBAQCAtMTY4LDYgKzE2OCwxMCBAQCB2
b2lkIG10a19yZG1hX2NvbmZpZyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHVuc2lnbmVkIGludCB3aWR0
aCwNCj4gIAkgKiBhY2NvdW50IGZvciBibGFua2luZywgYW5kIHdpdGggYSBwaXhlbCBkZXB0aCBv
ZiA0IGJ5dGVzOg0KPiAgCSAqLw0KPiAgCXRocmVzaG9sZCA9IHdpZHRoICogaGVpZ2h0ICogdnJl
ZnJlc2ggKiA0ICogNyAvIDEwMDAwMDA7DQo+ICsNCj4gKwlpZiAodGhyZXNob2xkID4gcmRtYV9m
aWZvX3NpemUpDQo+ICsJCXRocmVzaG9sZCA9IHJkbWFfZmlmb19zaXplOw0KPiArDQoNClBsZWFz
ZSBzZWUgdGhlIGRpc2N1c3Npb24gaW4gWzFdLg0KDQpbMV0NCmh0dHBzOi8vcGF0Y2h3b3JrLmtl
cm5lbC5vcmcvcHJvamVjdC9saW51eC1tZWRpYXRlay9wYXRjaC8xNjA3NTkxMjYyLTIxNzM2LTYt
Z2l0LXNlbmQtZW1haWwteW9uZ3FpYW5nLm5pdUBtZWRpYXRlay5jb20vDQoNClJlZ2FyZHMsDQpD
Sw0KDQo+ICAJcmVnID0gUkRNQV9GSUZPX1VOREVSRkxPV19FTiB8DQo+ICAJICAgICAgUkRNQV9G
SUZPX1BTRVVET19TSVpFKHJkbWFfZmlmb19zaXplKSB8DQo+ICAJICAgICAgUkRNQV9PVVRQVVRf
VkFMSURfRklGT19USFJFU0hPTEQodGhyZXNob2xkKTsNCg0K

