Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E2D3D1E5A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 08:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbhGVF5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 01:57:50 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:64003 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229931AbhGVF5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 01:57:47 -0400
X-UUID: a1ef19bdfe614e53811cdbc983ebc4ad-20210722
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=oaxYxn3IILWuJbREf8SCmDPb7cFpjJSu+Lb7BiUbx7g=;
        b=XysRMbWJ8wjQ0Y3UXTNNFa/3mPg/H/hhOL1RrKpA3cZspA0ZB1jUfflXXqC2ToTCCZBkCoqqieXJFH7o0jkRBYdv14RQpeYSXiknWg1xTAHWWgwESewWoIVZKBADmI8S2Z4jUgVgsOpEeO9rW81EdFw5UbdE0AXRHYcEE37HDnY=;
X-UUID: a1ef19bdfe614e53811cdbc983ebc4ad-20210722
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 407174073; Thu, 22 Jul 2021 14:38:21 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 22 Jul
 2021 14:38:15 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 22 Jul 2021 14:38:14 +0800
Message-ID: <1626935894.27875.6.camel@mhfsdcap03>
Subject: Re: [PATCH v2 07/11] memory: mtk-smi: Add smi sub common support
From:   Yong Wu <yong.wu@mediatek.com>
To:     Ikjoon Jang <ikjn@chromium.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Krzysztof Kozlowski" <krzk@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <youlin.pei@mediatek.com>,
        <anan.sun@mediatek.com>, <ming-fan.chen@mediatek.com>,
        <yi.kuo@mediatek.com>, <anthony.huang@mediatek.com>
Date:   Thu, 22 Jul 2021 14:38:14 +0800
In-Reply-To: <CAATdQgBDsPHcuPYd=a+fjjTuqwXdJ-1GuSkj47cH1Ju5geqSLg@mail.gmail.com>
References: <20210715121209.31024-1-yong.wu@mediatek.com>
         <20210715121209.31024-8-yong.wu@mediatek.com>
         <CAATdQgBDsPHcuPYd=a+fjjTuqwXdJ-1GuSkj47cH1Ju5geqSLg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 8C9462D89BEED59F465508FE8E285B0DAFEB43CE951A7B5CDA310B4B06BC23302000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSWtqb29uLA0KDQpUaGFua3MgdmVyeSBtdWNoIGZvciB5b3VyIGhlbHAgcmV2aWV3aW5nLi4N
Cg0KT24gV2VkLCAyMDIxLTA3LTIxIGF0IDE5OjQzICswODAwLCBJa2pvb24gSmFuZyB3cm90ZToN
Cj4gT24gVGh1LCBKdWwgMTUsIDIwMjEgYXQgODoyNSBQTSBZb25nIFd1IDx5b25nLnd1QG1lZGlh
dGVrLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBJbiBtdDgxOTUsIHRoZXJlIGFyZSBzb21lIGxhcmJz
IGNvbm5lY3Qgd2l0aCB0aGUgc21pLXN1Yi1jb21tb24sIHRoZW4NCj4gPiBjb25uZWN0IHdpdGgg
c21pLWNvbW1vbi4NCj4gDQo+IE5vdCBjcml0aWNhbCBidXQgSSBzdWdnZXN0IHRvIGRlc2NyaWJl
IHdoYXQgaXMgc21pLXN1Yi1jb21tb24uDQo+IGUuZy4gInNvbWUgbGFyYnMgYXJlIG5vdCBkaXJl
Y3RseSBjb25uZWN0ZWQgdG8gc21pLWNvbW1vbiwNCj4gdGhleSBhcmUgY29ubmVjdGVkIHRvIHNt
aS1zdWItY29tbW9uIHdoaWNoIGlzIGEgYnJpZGdlKD8pIGludGVyZmFjZSB0by4uLiINCg0KT0su
IEkgd2lsbCBhZGQgc29tZSBicmllZiBkZXNjcmlwdGlvbiBhYm91dCB0aGlzIHN1Yi1jb21tb24g
aW4gbmV4dA0KdmVyc2lvbi4NCg0KPiANCj4gPg0KPiA+IEJlZm9yZSB3ZSBjcmVhdGUgZGV2aWNl
IGxpbmsgYmV0d2VlbiBzbWktbGFyYiB3aXRoIHNtaS1jb21tb24uIElmIHdlIGhhdmUNCj4gPiBz
dWItY29tbW9uLCB3ZSBzaG91bGQgdXNlIGRldmljZSBsaW5rIHRoZSBzbWktbGFyYiBhbmQgc21p
LXN1Yi1jb21tb24sDQo+ID4gdGhlbiB1c2UgZGV2aWNlIGxpbmsgYmV0d2VlbiB0aGUgc21pLXN1
Yi1jb21tb24gd2l0aCBzbWktY29tbW9uLiBUaGlzIGlzDQo+ID4gZm9yIGVuYWJsaW5nIGNsb2Nr
L3Bvd2VyIGF1dG9tYXRpY2FsbHkuDQo+ID4NCj4gPiBNb3ZlIHRoZSBkZXZpY2UgbGluayBjb2Rl
IHRvIGEgbmV3IGludGVyZmFjZSBmb3IgcmV1c2luZy4NCj4gPg0KPiA+IFRoZXJlIGlzIG5vIFNX
IGV4dHJhIHNldHRpbmcgZm9yIHNtaS1zdWItY29tbW9uLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1i
eTogWW9uZyBXdSA8eW9uZy53dUBtZWRpYXRlay5jb20+DQo+IA0KPiBSZXZpZXdlZC1ieTogSWtq
b29uIEphbmcgPGlram5AY2hyb21pdW0ub3JnPg0KDQpUaGFua3MuDQoNCj4gDQo+ID4gLS0tDQo+
ID4gIGRyaXZlcnMvbWVtb3J5L210ay1zbWkuYyB8IDc1ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKy0tLS0tLS0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDUxIGluc2VydGlvbnMoKyks
IDI0IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWVtb3J5L210
ay1zbWkuYyBiL2RyaXZlcnMvbWVtb3J5L210ay1zbWkuYw0KPiA+IGluZGV4IGU2OGNiYjUxZGQx
Mi4uZWU0OWJiNTBmNWY1IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbWVtb3J5L210ay1zbWku
Yw0KPiA+ICsrKyBiL2RyaXZlcnMvbWVtb3J5L210ay1zbWkuYw0KPiA+IEBAIC02MCw3ICs2MCw4
IEBADQoNCltzbmlwLi5dDQoNCg==

