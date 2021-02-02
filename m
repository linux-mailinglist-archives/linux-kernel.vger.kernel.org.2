Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 330F530B50A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 03:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbhBBCFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 21:05:47 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:40647 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230009AbhBBCFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 21:05:36 -0500
X-UUID: 649bbc6614d34717b1edc781f242e4f0-20210202
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=ON8bHtwiT/h540EaCUWfU1QVeXktvhFd1tW5kcxrM6c=;
        b=IfmRYCe4Sb3L1iJaQuyByI78qz2m5MFaagoI5t4exjyBk5IGyqPKg3pu4ctua5zbKgyGgJ8oJc87teJXysMslSDAc2nn0AE1ja0BLveZq2cxpjkKXDLLxz7AX+INLvL9E8iiNnxBl1/KQeJ4v8tpQui72s3w0gTmYlLxxStGLOg=;
X-UUID: 649bbc6614d34717b1edc781f242e4f0-20210202
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1991786025; Tue, 02 Feb 2021 10:04:19 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 2 Feb
 2021 10:03:46 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 2 Feb 2021 10:03:45 +0800
Message-ID: <1612231425.2524.12.camel@mhfsdcap03>
Subject: Re: [PATCH v6 00/33] MT8192 IOMMU support
From:   Yong Wu <yong.wu@mediatek.com>
To:     Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        "Krzysztof Kozlowski" <krzk@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "Krzysztof Kozlowski" <krzk@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        "Tomasz Figa" <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <youlin.pei@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <chao.hao@mediatek.com>
Date:   Tue, 2 Feb 2021 10:03:45 +0800
In-Reply-To: <20210201145422.GA15263@willie-the-truck>
References: <20210111111914.22211-1-yong.wu@mediatek.com>
         <20210201145422.GA15263@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: A18C1C8918DEE0A0D7B50AFE8695F7167F4D310B1A3B5790C079BBD49E7336992000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTAyLTAxIGF0IDE0OjU0ICswMDAwLCBXaWxsIERlYWNvbiB3cm90ZToNCj4g
T24gTW9uLCBKYW4gMTEsIDIwMjEgYXQgMDc6MTg6NDFQTSArMDgwMCwgWW9uZyBXdSB3cm90ZToN
Cj4gPiBUaGlzIHBhdGNoIG1haW5seSBhZGRzIHN1cHBvcnQgZm9yIG10ODE5MiBNdWx0aW1lZGlh
IElPTU1VIGFuZCBTTUkuDQo+ID4gDQo+ID4gbXQ4MTkyIGFsc28gaXMgTVRLIElPTU1VIGdlbjIg
d2hpY2ggdXNlcyBBUk0gU2hvcnQtRGVzY3JpcHRvciB0cmFuc2xhdGlvbg0KPiA+IHRhYmxlIGZv
cm1hdC4gVGhlIE00VS1TTUkgSFcgZGlhZ3JhbSBpcyBhcyBiZWxvdzoNCj4gPiANCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgIEVNSQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgIE00VQ0KPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgLS0tLS0tLS0tLS0tDQo+
ID4gICAgICAgICAgICAgICAgICAgICAgICBTTUkgQ29tbW9uDQo+ID4gICAgICAgICAgICAgICAg
ICAgICAgIC0tLS0tLS0tLS0tLQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwNCj4g
PiAgICstLS0tLS0tKy0tLS0tLSstLS0tLS0rLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSstLS0tLS0t
Kw0KPiA+ICAgfCAgICAgICB8ICAgICAgfCAgICAgIHwgICAgICAgLi4uLi4uICAgICAgICAgfCAg
ICAgICB8DQo+ID4gICB8ICAgICAgIHwgICAgICB8ICAgICAgfCAgICAgICAgICAgICAgICAgICAg
ICB8ICAgICAgIHwNCj4gPiBsYXJiMCAgIGxhcmIxICBsYXJiMiAgbGFyYjQgICAgIC4uLi4uLiAg
ICAgIGxhcmIxOSAgIGxhcmIyMA0KPiA+IGRpc3AwICAgZGlzcDEgICBtZHAgICAgdmRlYyAgICAg
ICAgICAgICAgICAgICBJUEUgICAgICBJUEUNCj4gPiANCj4gPiBBbGwgdGhlIGNvbm5lY3Rpb25z
IGFyZSBIVyBmaXhlZCwgU1cgY2FuIE5PVCBhZGp1c3QgaXQuDQo+ID4gDQo+ID4gQ29tcGFyaW5n
IHdpdGggdGhlIHByZXZpZXcgU29DLCB0aGlzIHBhdGNoc2V0IG1haW5seSBhZGRzIHR3byBuZXcg
ZnVuY3Rpb25zOg0KPiA+IGEpIGFkZCBpb3ZhIDM0IGJpdHMgc3VwcG9ydC4NCj4gPiBiKSBhZGQg
bXVsdGkgZG9tYWlucyBzdXBwb3J0IHNpbmNlIHNldmVyYWwgSFcgaGFzIHRoZSBzcGVjaWFsIGlv
dmENCj4gPiByZWdpb24gcmVxdWlyZW1lbnQuDQo+ID4gDQo+ID4gY2hhbmdlIG5vdGU6DQo+ID4g
djY6YSkgYmFzZSBvbiB2NS4xMS1yYzEuIGFuZCB0bGIgdjQ6DQo+ID4gICAgICAgaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvbGludXgtbWVkaWF0ZWsvMjAyMTAxMDcxMjI5MDkuMTYzMTctMS15b25n
Lnd1QG1lZGlhdGVrLmNvbS9ULyN0IA0KPiANCj4gSSd2ZSBxdWV1ZWQgdGhpcyB1cCBhcGFydCBm
cm9tIHBhdGNoZXMgNiBhbmQgNy4NCg0KVGhhbmtzIHZlcnkgbXVjaCBmb3IgdGhlIGFwcGx5aW5n
LiBJJ2QgbGlrZSB0byBzaG93IHRoZXJlIGlzIGEgbGl0dGxlDQpjb25mbGljdCB3aXRoIGEgc21p
IGNoYW5nZVsxXSBpbiAvaW5jbHVkZS9zb2MvbWVkaWF0ZWsvc21pLmguDQoNClRoaXMgaXMgdGhl
IGRldGFpbGVkIGNvbmZsaWN0Og0KDQotLS0gYS9pbmNsdWRlL3NvYy9tZWRpYXRlay9zbWkuaA0K
KysrIGIvaW5jbHVkZS9zb2MvbWVkaWF0ZWsvc21pLmgNCkBAIC05LDcgKzksNyBAQA0KICNpbmNs
dWRlIDxsaW51eC9iaXRvcHMuaD4NCiAjaW5jbHVkZSA8bGludXgvZGV2aWNlLmg+DQogDQotI2lm
ZGVmIENPTkZJR19NVEtfU01JDQorI2lmIElTX0VOQUJMRUQoQ09ORklHX01US19TTUkpICAgPC0t
LVRoZSBzbWkgcGF0Y2ggY2hhbmdlIGhlcmUuDQogDQogI2RlZmluZSBNVEtfTEFSQl9OUl9NQVgg
ICAxNiAgPC0tLVRoaXMgaW9tbXUgcGF0Y2hzZXQgZGVsZXRlIHRoaXMgbGluZS4NCg0KDQpUaGlz
IGNvZGUgaXMgc2ltcGxlLiBQbGVhc2UgZmVlbCBmcmVlIHRvIHRlbGwgbWUgaG93IHRvIGRvIHRo
aXMgaWYgdGhpcw0KaXMgbm90IGNvbnZlbmllbnQgdG8gbWVyZ2UuDQoNClsxXQ0KaHR0cHM6Ly9n
aXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQva3J6ay9saW51eC1tZW0tY3Ry
bC5naXQvY29tbWl0Lz9oPWZvci1uZXh0JmlkPTUwZmM4ZDkyMzJjZGM2NGI5ZTlkMWI5NDg4NDUy
ZjE1M2RlNTJiNjkNCg0KPiANCj4gVGhhbmtzLA0KPiANCj4gV2lsbA0KDQo=

