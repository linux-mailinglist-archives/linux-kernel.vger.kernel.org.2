Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0676130557B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 09:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234224AbhA0ISb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 03:18:31 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:53086 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232628AbhA0ICB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 03:02:01 -0500
X-UUID: 52a4e70d5748430381fedbca85d729d3-20210127
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=1rHN6XFoiNjbEZ4gE5YNnM87NBquj4VfEM0/8Mtk/+Q=;
        b=kg3G0nWN2pDgYhhIpcwKEcQRSaBxO44pO3zvRIOa+Dm2g4NOt1mVXqiblCdF81+f56YCovos8uXJJivkYhDpaTUyQ9TJdKXQNfS0WlyS4n/zT2mZ+qe0orCX8mrEanSDfwCQv1qso7qvPx3dZKkbCX5pgui5qqHQyJwuwdZDpL8=;
X-UUID: 52a4e70d5748430381fedbca85d729d3-20210127
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1457988215; Wed, 27 Jan 2021 15:59:29 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 27 Jan 2021 15:59:27 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 27 Jan 2021 15:59:27 +0800
Message-ID: <1611734366.29432.1.camel@mtksdaap41>
Subject: Re: [PATCH v10 3/9] drm/mediatek: add RDMA fifo size error handle
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
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Date:   Wed, 27 Jan 2021 15:59:26 +0800
In-Reply-To: <20210127045422.2418917-4-hsinyi@chromium.org>
References: <20210127045422.2418917-1-hsinyi@chromium.org>
         <20210127045422.2418917-4-hsinyi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: B5DCDF8D63F7A26FDFCD987D2C12B5798BBF49DA80FC41CA24B08212AB3D6CBA2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEhzaW4tWWk6DQoNCk9uIFdlZCwgMjAyMS0wMS0yNyBhdCAxMjo1NCArMDgwMCwgSHNpbi1Z
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
aWZvX3NpemUpDQo+ICsJCXRocmVzaG9sZCA9IHJkbWFfZmlmb19zaXplOw0KDQpQbGVhc2Ugc2Vl
IHRoZSBkaXNjdXNzaW9uIGluIFsxXS4NCg0KWzFdDQpodHRwczovL3BhdGNod29yay5rZXJuZWwu
b3JnL3Byb2plY3QvbGludXgtbWVkaWF0ZWsvcGF0Y2gvMTYwNzU5MTI2Mi0yMTczNi02LWdpdC1z
ZW5kLWVtYWlsLXlvbmdxaWFuZy5uaXVAbWVkaWF0ZWsuY29tLw0KDQpSZWdhcmRzLA0KQ0sNCg0K
PiArDQo+ICAJcmVnID0gUkRNQV9GSUZPX1VOREVSRkxPV19FTiB8DQo+ICAJICAgICAgUkRNQV9G
SUZPX1BTRVVET19TSVpFKHJkbWFfZmlmb19zaXplKSB8DQo+ICAJICAgICAgUkRNQV9PVVRQVVRf
VkFMSURfRklGT19USFJFU0hPTEQodGhyZXNob2xkKTsNCg0K

