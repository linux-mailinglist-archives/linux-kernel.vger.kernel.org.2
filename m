Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 604C230B4B4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 02:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbhBBBbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 20:31:47 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:5331 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229543AbhBBBbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 20:31:46 -0500
X-UUID: cda5d4d113ca42bbb099e175ef846e14-20210202
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=J3x52rLYllyw6VRGlPTtdTLgRiZI9s1w8kgapGIcpuo=;
        b=b2t9H/HD7MO/64tenkUKzflw/fYrhq6naszlpBRPwLHbySkw4sGKW71GiLwn6YH0hnUi/y4+LhYe+iF2cpfp918y6G1LVvwVUF0Kl7zfEJFocU0KCzgel0gbTIn+7ZBUTkMb/HLiH/UW4gd9jTZl3/zbPMlQSNalDPx6gB94Y+Y=;
X-UUID: cda5d4d113ca42bbb099e175ef846e14-20210202
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 410525093; Tue, 02 Feb 2021 09:30:57 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS32N1.mediatek.inc
 (172.27.4.71) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 2 Feb
 2021 09:30:50 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 2 Feb 2021 09:30:49 +0800
Message-ID: <1612229449.2524.2.camel@mhfsdcap03>
Subject: Re: [PATCH] iommu: Properly pass gfp_t in _iommu_map() to avoid
 atomic sleeping
From:   Yong Wu <yong.wu@mediatek.com>
To:     Douglas Anderson <dianders@chromium.org>
CC:     Will Deacon <will@kernel.org>, <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Tue, 2 Feb 2021 09:30:49 +0800
In-Reply-To: <20210201170611.1.I64a7b62579287d668d7c89e105dcedf45d641063@changeid>
References: <20210201170611.1.I64a7b62579287d668d7c89e105dcedf45d641063@changeid>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: D4D6B793B12B73E0D43EA4A0C2B613719A984C7639A6230D7A507072D26ECEAC2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTAyLTAxIGF0IDE3OjA2IC0wODAwLCBEb3VnbGFzIEFuZGVyc29uIHdyb3Rl
Og0KPiBTbGVlcGluZyB3aGlsZSBhdG9taWMgPSBiYWQuICBMZXQncyBmaXggYW4gb2J2aW91cyB0
eXBvIHRvIHRyeSB0byBhdm9pZCBpdC4NCj4gDQo+IFRoZSB3YXJuaW5nIHRoYXQgd2FzIHNlZW4g
KG9uIGEgZG93bnN0cmVhbSBrZXJuZWwgd2l0aCB0aGUgcHJvYmxlbWF0aWMNCj4gcGF0Y2ggYmFj
a3BvcnRlZCk6DQo+IA0KPiAgQlVHOiBzbGVlcGluZyBmdW5jdGlvbiBjYWxsZWQgZnJvbSBpbnZh
bGlkIGNvbnRleHQgYXQgbW0vcGFnZV9hbGxvYy5jOjQ3MjYNCj4gIGluX2F0b21pYygpOiAxLCBp
cnFzX2Rpc2FibGVkKCk6IDAsIG5vbl9ibG9jazogMCwgcGlkOiA5LCBuYW1lOiBrc29mdGlycWQv
MA0KPiAgQ1BVOiAwIFBJRDogOSBDb21tOiBrc29mdGlycWQvMCBOb3QgdGFpbnRlZCA1LjQuOTMt
MTI1MDgtZ2MxMGM5M2UyOGUzOSAjMQ0KPiAgQ2FsbCB0cmFjZToNCj4gICBkdW1wX2JhY2t0cmFj
ZSsweDAvMHgxNTQNCj4gICBzaG93X3N0YWNrKzB4MjAvMHgyYw0KPiAgIGR1bXBfc3RhY2srMHhh
MC8weGZjDQo+ICAgX19fbWlnaHRfc2xlZXArMHgxMWMvMHgxMmMNCj4gICBfX21pZ2h0X3NsZWVw
KzB4NTAvMHg4NA0KPiAgIF9fYWxsb2NfcGFnZXNfbm9kZW1hc2srMHhmOC8weDJiYw0KPiAgIF9f
YXJtX2xwYWVfYWxsb2NfcGFnZXMrMHg0OC8weDFiNA0KPiAgIF9fYXJtX2xwYWVfbWFwKzB4MTI0
LzB4Mjc0DQo+ICAgX19hcm1fbHBhZV9tYXArMHgxY2MvMHgyNzQNCj4gICBhcm1fbHBhZV9tYXAr
MHgxNDAvMHgxNzANCj4gICBhcm1fc21tdV9tYXArMHg3OC8weGJjDQo+ICAgX19pb21tdV9tYXAr
MHhkNC8weDIxMA0KPiAgIF9pb21tdV9tYXArMHg0Yy8weDg0DQo+ICAgaW9tbXVfbWFwX2F0b21p
YysweDQ0LzB4NTgNCj4gICBfX2lvbW11X2RtYV9tYXArMHg4Yy8weGM0DQo+ICAgaW9tbXVfZG1h
X21hcF9wYWdlKzB4YWMvMHhmMA0KPiANCj4gRml4ZXM6IGQ4YzFkZjAyYWM3ZiAoImlvbW11OiBN
b3ZlIGlvdGxiX3N5bmNfbWFwIG91dCBmcm9tIF9faW9tbXVfbWFwIikNCj4gU2lnbmVkLW9mZi1i
eTogRG91Z2xhcyBBbmRlcnNvbiA8ZGlhbmRlcnNAY2hyb21pdW0ub3JnPg0KDQpvaC4gVGhpcyBp
cyBteSBmYXVsdC4gVGhhbmtzIGZvciB0aGUgZml4Lg0KDQpSZXZpZXdlZC1ieTogWW9uZyBXdSA8
eW9uZy53dUBtZWRpYXRlay5jb20+DQoNCj4gLS0tDQo+IEkgaGF2ZW4ndCBkb25lIGFueSBzZXJp
b3VzIHRlc3Rpbmcgb24gdGhpcy4gIEkgc2F3IGEgcmVwb3J0IG9mIHRoZQ0KPiB3YXJuaW5nIGFu
ZCB0aGUgZml4IHNlZW1lZCBvYnZpb3VzIHNvIEknbSBzaG9vdGluZyBpdCBvdXQuDQo+IA0KPiAg
ZHJpdmVycy9pb21tdS9pb21tdS5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9p
b21tdS5jIGIvZHJpdmVycy9pb21tdS9pb21tdS5jDQo+IGluZGV4IDNkMDk5YTMxZGRjYS4uMmIw
NmIwMTg1MGQ1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lvbW11L2lvbW11LmMNCj4gKysrIGIv
ZHJpdmVycy9pb21tdS9pb21tdS5jDQo+IEBAIC0yNDQxLDcgKzI0NDEsNyBAQCBzdGF0aWMgaW50
IF9pb21tdV9tYXAoc3RydWN0IGlvbW11X2RvbWFpbiAqZG9tYWluLCB1bnNpZ25lZCBsb25nIGlv
dmEsDQo+ICAJY29uc3Qgc3RydWN0IGlvbW11X29wcyAqb3BzID0gZG9tYWluLT5vcHM7DQo+ICAJ
aW50IHJldDsNCj4gIA0KPiAtCXJldCA9IF9faW9tbXVfbWFwKGRvbWFpbiwgaW92YSwgcGFkZHIs
IHNpemUsIHByb3QsIEdGUF9LRVJORUwpOw0KPiArCXJldCA9IF9faW9tbXVfbWFwKGRvbWFpbiwg
aW92YSwgcGFkZHIsIHNpemUsIHByb3QsIGdmcCk7DQo+ICAJaWYgKHJldCA9PSAwICYmIG9wcy0+
aW90bGJfc3luY19tYXApDQo+ICAJCW9wcy0+aW90bGJfc3luY19tYXAoZG9tYWluLCBpb3ZhLCBz
aXplKTsNCj4gIA0KDQo=

