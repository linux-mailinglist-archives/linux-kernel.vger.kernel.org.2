Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C8A30836D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 02:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbhA2Bxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 20:53:41 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:7826 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229866AbhA2Bxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 20:53:36 -0500
X-UUID: dc9c42d6294a48ee8dd193beffc176c0-20210129
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=fdRmt55p+MQD3S1Cu81aNjjrFDffurU5HWdEwTLBEdQ=;
        b=jvqRAwKx77mrVFAY9ifsdXuA3WEDaJy1giDwPh7i+foA2l69CMIuGplOP2nFEp2MMB+sHWv6dIo37lLmI7CfsflINWNm/SWr7TYK3ldCTKwsjuBjiCfFbmlndv8TkTGBVyWoRpmHZA156TMFaQobkyhbbLIw8Dtoa979/h0m8Og=;
X-UUID: dc9c42d6294a48ee8dd193beffc176c0-20210129
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1814884913; Fri, 29 Jan 2021 09:52:44 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 29 Jan
 2021 09:52:42 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 29 Jan 2021 09:52:41 +0800
Message-ID: <1611885162.5302.19.camel@mhfsdcap03>
Subject: Re: [PATCH v6 07/33] iommu: Avoid reallocate default domain for a
 group
From:   Yong Wu <yong.wu@mediatek.com>
To:     Will Deacon <will@kernel.org>
CC:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <youlin.pei@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <chao.hao@mediatek.com>
Date:   Fri, 29 Jan 2021 09:52:42 +0800
In-Reply-To: <20210128211442.GB3531@willie-the-truck>
References: <20210111111914.22211-1-yong.wu@mediatek.com>
         <20210111111914.22211-8-yong.wu@mediatek.com>
         <20210126222305.GB30460@willie-the-truck>
         <1611740356.5302.14.camel@mhfsdcap03>
         <20210128211020.GA3531@willie-the-truck>
         <20210128211442.GB3531@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: C7FA721F47A35587783A8CC9CE434783D2147DE2CF3728D62F7C900CF55A2C7A2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIxLTAxLTI4IGF0IDIxOjE0ICswMDAwLCBXaWxsIERlYWNvbiB3cm90ZToNCj4g
T24gVGh1LCBKYW4gMjgsIDIwMjEgYXQgMDk6MTA6MjBQTSArMDAwMCwgV2lsbCBEZWFjb24gd3Jv
dGU6DQo+ID4gT24gV2VkLCBKYW4gMjcsIDIwMjEgYXQgMDU6Mzk6MTZQTSArMDgwMCwgWW9uZyBX
dSB3cm90ZToNCj4gPiA+IE9uIFR1ZSwgMjAyMS0wMS0yNiBhdCAyMjoyMyArMDAwMCwgV2lsbCBE
ZWFjb24gd3JvdGU6DQo+ID4gPiA+IE9uIE1vbiwgSmFuIDExLCAyMDIxIGF0IDA3OjE4OjQ4UE0g
KzA4MDAsIFlvbmcgV3Ugd3JvdGU6DQo+ID4gPiA+ID4gSWYgZ3JvdXAtPmRlZmF1bHRfZG9tYWlu
IGV4aXN0cywgYXZvaWQgcmVhbGxvY2F0ZSBpdC4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBJbiBz
b21lIGlvbW11IGRyaXZlcnMsIHRoZXJlIG1heSBiZSBzZXZlcmFsIGRldmljZXMgc2hhcmUgYSBn
cm91cC4gQXZvaWQNCj4gPiA+ID4gPiByZWFsbG9jIHRoZSBkZWZhdWx0IGRvbWFpbiBmb3IgdGhp
cyBjYXNlLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFlvbmcgV3UgPHlv
bmcud3VAbWVkaWF0ZWsuY29tPg0KPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ICBkcml2ZXJzL2lv
bW11L2lvbW11LmMgfCAzICsrLQ0KPiA+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvaW9tbXUvaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvaW9tbXUuYw0KPiA+ID4gPiA+
IGluZGV4IDNkMDk5YTMxZGRjYS4uZjRiODdlNmFiZTgwIDEwMDY0NA0KPiA+ID4gPiA+IC0tLSBh
L2RyaXZlcnMvaW9tbXUvaW9tbXUuYw0KPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvaW9tbXUvaW9t
bXUuYw0KPiA+ID4gPiA+IEBAIC0yNjYsNyArMjY2LDggQEAgaW50IGlvbW11X3Byb2JlX2Rldmlj
ZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ID4gPiA+ID4gIAkgKiBzdXBwb3J0IGRlZmF1bHQgZG9t
YWlucywgc28gdGhlIHJldHVybiB2YWx1ZSBpcyBub3QgeWV0DQo+ID4gPiA+ID4gIAkgKiBjaGVj
a2VkLg0KPiA+ID4gPiA+ICAJICovDQo+ID4gPiA+ID4gLQlpb21tdV9hbGxvY19kZWZhdWx0X2Rv
bWFpbihncm91cCwgZGV2KTsNCj4gPiA+ID4gPiArCWlmICghZ3JvdXAtPmRlZmF1bHRfZG9tYWlu
KQ0KPiA+ID4gPiA+ICsJCWlvbW11X2FsbG9jX2RlZmF1bHRfZG9tYWluKGdyb3VwLCBkZXYpOw0K
PiA+ID4gPiANCj4gPiA+ID4gSSBkb24ndCByZWFsbHkgZ2V0IHdoYXQgdGhpcyBhY2hpZXZlcywg
c2luY2UgaW9tbXVfYWxsb2NfZGVmYXVsdF9kb21haW4oKQ0KPiA+ID4gPiBsb29rcyBsaWtlIHRo
aXM6DQo+ID4gPiA+IA0KPiA+ID4gPiBzdGF0aWMgaW50IGlvbW11X2FsbG9jX2RlZmF1bHRfZG9t
YWluKHN0cnVjdCBpb21tdV9ncm91cCAqZ3JvdXAsDQo+ID4gPiA+IAkJCQkgICAgICBzdHJ1Y3Qg
ZGV2aWNlICpkZXYpDQo+ID4gPiA+IHsNCj4gPiA+ID4gCXVuc2lnbmVkIGludCB0eXBlOw0KPiA+
ID4gPiANCj4gPiA+ID4gCWlmIChncm91cC0+ZGVmYXVsdF9kb21haW4pDQo+ID4gPiA+IAkJcmV0
dXJuIDA7DQo+ID4gPiA+IA0KPiA+ID4gPiAJLi4uDQo+ID4gPiA+IA0KPiA+ID4gPiBpbiB3aGlj
aCBjYXNlLCBpdCBzaG91bGQgYmUgZmluZT8NCj4gPiA+IA0KPiA+ID4gb2guIHNvcnJ5LCBJIG92
ZXJsb29rZWQgdGhpcy4gdGhlIGN1cnJlbnQgY29kZSBpcyBlbm91Z2guDQo+ID4gPiBJIHdpbGwg
cmVtb3ZlIHRoaXMgcGF0Y2guIGFuZCBzZW5kIHRoZSBuZXh0IHZlcnNpb24gaW4gdGhpcyB3ZWVr
Lg0KPiA+ID4gVGhhbmtzIHZlcnkgbXVjaC4NCj4gPiANCj4gPiBBY3R1YWxseSwgbG9va2luZyBh
dCB0aGlzIGFnYWluLCBpZiB3ZSdyZSBkcm9wcGluZyB0aGlzIHBhdGNoIGFuZCBwYXRjaCA2DQo+
ID4ganVzdCBuZWVkcyB0aGUga2ZyZWUoKSBtb3ZpbmcgYWJvdXQsIHRoZW4gdGhlcmUncyBubyBu
ZWVkIHRvIHJlcG9zdC4gVGhlDQo+ID4gaXNzdWUgdGhhdCBSb2JpbiBhbmQgUGF1bCBhcmUgZGlz
Y3Vzc2luZyBjYW4gYmUgaGFuZGxlZCBzZXBhcmF0ZWx5Lg0KPiANCj4gQXJnaCwgZXhjZXB0IHRo
YXQgdGhpcyB2ZXJzaW9uIG9mIHRoZSBwYXRjaGVzIGRvZXNuJ3QgYXBwbHkgOikNCj4gDQo+IFNv
IGFmdGVyIGFsbCB0aGF0LCBwbGVhc2UgZ28gYWhlYWQgYW5kIHBvc3QgYSB2NyBBU0FQIGJhc2Vk
IG9uIHRoaXMgYnJhbmNoOg0KPiANCj4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xp
bnV4L2tlcm5lbC9naXQvd2lsbC9saW51eC5naXQvbG9nLz9oPWZvci1qb2VyZy9tdGsNCg0KQWZ0
ZXIgY29uZmlybSB3aXRoIFRvbWFzeiwgSGUgc3RpbGwgbmVlZCBzb21lIHRpbWUgdG8gdGFrZSBh
IGxvb2sgYXQgdjYuDQoNCnRodXMgSSBuZWVkIHdhaXQgc29tZSB0aW1lIHRvIHNlbmQgdjcgYWZ0
ZXIgaGlzIGZlZWRiYWNrLg0KDQpUaGFua3MgZm9yIHlvdXIgY29tbWVudC4gYW5kIFRoYW5rcyBU
b21hc3ogZm9yIHRoZSByZXZpZXcuDQoNCj4gDQo+IFdpbGwNCg0K

