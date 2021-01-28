Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E854A306D00
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 06:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbhA1Ffv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 00:35:51 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:64787 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229446AbhA1Ffr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 00:35:47 -0500
X-UUID: a3577d1d7c8f48b4af7fe2e225f717d2-20210128
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=XxO6FR8xvA123ZiF/PL7oeET5mcxrQ+uDd5Kof3HnYk=;
        b=Ie1P9uZwXh8+lYMLj0x7CUUyWRunYZy+TESyg342tpr2RhB/dwlAomiEuKz81hr9qyXJKN+866q9ZjDkJSgFWK8YX1p2MFPPKbAhTxSdr1Er5ZTJGtVSlbYk8ioPt0ConaJ5MaO0G36Oa+32ABtdpYRFuzvpigauxZzpzyoCcYQ=;
X-UUID: a3577d1d7c8f48b4af7fe2e225f717d2-20210128
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1382939228; Thu, 28 Jan 2021 13:35:03 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 28 Jan 2021 13:34:53 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 28 Jan 2021 13:34:53 +0800
Message-ID: <1611812093.28312.1.camel@mtksdaap41>
Subject: Re: [PATCH v10 6/9] drm/mediatek: add has_dither private data for
 gamma
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
Date:   Thu, 28 Jan 2021 13:34:53 +0800
In-Reply-To: <20210127045422.2418917-7-hsinyi@chromium.org>
References: <20210127045422.2418917-1-hsinyi@chromium.org>
         <20210127045422.2418917-7-hsinyi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 47C7AAB9C7C5D61CCA99EDA13880D171FB27A2778886A43D53DF0D0E9A7BDD962000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEhzaW4tWWk6DQoNCk9uIFdlZCwgMjAyMS0wMS0yNyBhdCAxMjo1NCArMDgwMCwgSHNpbi1Z
aSBXYW5nIHdyb3RlOg0KPiBGcm9tOiBZb25ncWlhbmcgTml1IDx5b25ncWlhbmcubml1QG1lZGlh
dGVrLmNvbT4NCj4gDQo+IE5vdCBhbGwgU29DIGhhcyBkaXRoZXIgZnVuY3Rpb24gaW4gZ2FtbWEg
bW9kdWxlLg0KPiBBZGQgcHJpdmF0ZSBkYXRhIHRvIGNvbnRyb2wgdGhpcyBmdW5jdGlvbiBzZXR0
aW5nLg0KDQpSZXZpZXdlZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNvbT4NCg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogWW9uZ3FpYW5nIE5pdSA8eW9uZ3FpYW5nLm5pdUBtZWRpYXRlay5jb20+
DQo+IFNpZ25lZC1vZmYtYnk6IEhzaW4tWWkgV2FuZyA8aHNpbnlpQGNocm9taXVtLm9yZz4NCj4g
LS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZ2FtbWEuYyB8IDEyICsr
KysrKysrKy0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rp
c3BfZ2FtbWEuYyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9nYW1tYS5jDQo+
IGluZGV4IGI1YTQ5OWQ3ZTQ3MmMuLmM5OGZlMjg0MjY1ZDAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9nYW1tYS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZGlzcF9nYW1tYS5jDQo+IEBAIC0yNSw3ICsyNSw3IEBADQo+ICAj
ZGVmaW5lIExVVF8xMEJJVF9NQVNLCQkJCTB4MDNmZg0KPiAgDQo+ICBzdHJ1Y3QgbXRrX2Rpc3Bf
Z2FtbWFfZGF0YSB7DQo+IC0JdTMyIHJlc2VydmVkOw0KPiArCWJvb2wgaGFzX2RpdGhlcjsNCj4g
IH07DQo+ICANCj4gIC8qKg0KPiBAQCAtOTEsNyArOTEsOCBAQCB2b2lkIG10a19nYW1tYV9jb25m
aWcoc3RydWN0IGRldmljZSAqZGV2LCB1bnNpZ25lZCBpbnQgdywNCj4gIA0KPiAgCW10a19kZHBf
d3JpdGUoY21kcV9wa3QsIGggPDwgMTYgfCB3LCAmZ2FtbWEtPmNtZHFfcmVnLCBnYW1tYS0+cmVn
cywNCj4gIAkJICAgICAgRElTUF9HQU1NQV9TSVpFKTsNCj4gLQltdGtfZGl0aGVyX3NldF9jb21t
b24oZ2FtbWEtPnJlZ3MsICZnYW1tYS0+Y21kcV9yZWcsIGJwYywgRElTUF9HQU1NQV9DRkcsIGNt
ZHFfcGt0KTsNCj4gKwlpZiAoZ2FtbWEtPmRhdGEgJiYgZ2FtbWEtPmRhdGEtPmhhc19kaXRoZXIp
DQo+ICsJCW10a19kaXRoZXJfc2V0X2NvbW1vbihnYW1tYS0+cmVncywgJmdhbW1hLT5jbWRxX3Jl
ZywgYnBjLCBESVNQX0dBTU1BX0NGRywgY21kcV9wa3QpOw0KPiAgfQ0KPiAgDQo+ICB2b2lkIG10
a19nYW1tYV9zdGFydChzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+IEBAIC0xNzEsOCArMTcyLDEzIEBA
IHN0YXRpYyBpbnQgbXRrX2Rpc3BfZ2FtbWFfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYpDQo+ICAJcmV0dXJuIDA7DQo+ICB9DQo+ICANCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qg
bXRrX2Rpc3BfZ2FtbWFfZGF0YSBtdDgxNzNfZ2FtbWFfZHJpdmVyX2RhdGEgPSB7DQo+ICsJLmhh
c19kaXRoZXIgPSB0cnVlLA0KPiArfTsNCj4gKw0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9k
ZXZpY2VfaWQgbXRrX2Rpc3BfZ2FtbWFfZHJpdmVyX2R0X21hdGNoW10gPSB7DQo+IC0JeyAuY29t
cGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxNzMtZGlzcC1nYW1tYSJ9LA0KPiArCXsgLmNvbXBhdGli
bGUgPSAibWVkaWF0ZWssbXQ4MTczLWRpc3AtZ2FtbWEiLA0KPiArCSAgLmRhdGEgPSAmbXQ4MTcz
X2dhbW1hX2RyaXZlcl9kYXRhfSwNCj4gIAl7fSwNCj4gIH07DQo+ICBNT0RVTEVfREVWSUNFX1RB
QkxFKG9mLCBtdGtfZGlzcF9nYW1tYV9kcml2ZXJfZHRfbWF0Y2gpOw0KDQo=

