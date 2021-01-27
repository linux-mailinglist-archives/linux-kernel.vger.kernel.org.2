Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A781330572C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 10:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235411AbhA0JmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 04:42:17 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:35879 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233593AbhA0JkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 04:40:11 -0500
X-UUID: 95a941a449a945569533e47030366fa5-20210127
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=OBxOSBPDbNRIc9EIOyaVw0/Acj/J50gJQln+TyAJ4w4=;
        b=fKTey2UsD9ZWtXMjndTDzR8flYyWadWqD3c0di7De3krd96p/88RpeIDGsiigtf1d7pZrWTZGrqqZc4zwcJMXo36VHJTaZYbMLwlt+xy3lmI28KLMntvuUG8N4iZUXh/Pmi2FoqvhFacYiYdXTKM00S3hWiLDYCUwMiJeOk2PbU=;
X-UUID: 95a941a449a945569533e47030366fa5-20210127
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 969588445; Wed, 27 Jan 2021 17:39:19 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 27 Jan
 2021 17:39:17 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 27 Jan 2021 17:39:16 +0800
Message-ID: <1611740356.5302.14.camel@mhfsdcap03>
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
Date:   Wed, 27 Jan 2021 17:39:16 +0800
In-Reply-To: <20210126222305.GB30460@willie-the-truck>
References: <20210111111914.22211-1-yong.wu@mediatek.com>
         <20210111111914.22211-8-yong.wu@mediatek.com>
         <20210126222305.GB30460@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: F36F529AFC96016349EB7092D40E98B771F9B02D82265433FE286BC98F51FFAC2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIxLTAxLTI2IGF0IDIyOjIzICswMDAwLCBXaWxsIERlYWNvbiB3cm90ZToNCj4g
T24gTW9uLCBKYW4gMTEsIDIwMjEgYXQgMDc6MTg6NDhQTSArMDgwMCwgWW9uZyBXdSB3cm90ZToN
Cj4gPiBJZiBncm91cC0+ZGVmYXVsdF9kb21haW4gZXhpc3RzLCBhdm9pZCByZWFsbG9jYXRlIGl0
Lg0KPiA+IA0KPiA+IEluIHNvbWUgaW9tbXUgZHJpdmVycywgdGhlcmUgbWF5IGJlIHNldmVyYWwg
ZGV2aWNlcyBzaGFyZSBhIGdyb3VwLiBBdm9pZA0KPiA+IHJlYWxsb2MgdGhlIGRlZmF1bHQgZG9t
YWluIGZvciB0aGlzIGNhc2UuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogWW9uZyBXdSA8eW9u
Zy53dUBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvaW9tbXUvaW9tbXUuYyB8
IDMgKystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pb21tdS5jIGIvZHJpdmVy
cy9pb21tdS9pb21tdS5jDQo+ID4gaW5kZXggM2QwOTlhMzFkZGNhLi5mNGI4N2U2YWJlODAgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9pb21tdS9pb21tdS5jDQo+ID4gKysrIGIvZHJpdmVycy9p
b21tdS9pb21tdS5jDQo+ID4gQEAgLTI2Niw3ICsyNjYsOCBAQCBpbnQgaW9tbXVfcHJvYmVfZGV2
aWNlKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gPiAgCSAqIHN1cHBvcnQgZGVmYXVsdCBkb21haW5z
LCBzbyB0aGUgcmV0dXJuIHZhbHVlIGlzIG5vdCB5ZXQNCj4gPiAgCSAqIGNoZWNrZWQuDQo+ID4g
IAkgKi8NCj4gPiAtCWlvbW11X2FsbG9jX2RlZmF1bHRfZG9tYWluKGdyb3VwLCBkZXYpOw0KPiA+
ICsJaWYgKCFncm91cC0+ZGVmYXVsdF9kb21haW4pDQo+ID4gKwkJaW9tbXVfYWxsb2NfZGVmYXVs
dF9kb21haW4oZ3JvdXAsIGRldik7DQo+IA0KPiBJIGRvbid0IHJlYWxseSBnZXQgd2hhdCB0aGlz
IGFjaGlldmVzLCBzaW5jZSBpb21tdV9hbGxvY19kZWZhdWx0X2RvbWFpbigpDQo+IGxvb2tzIGxp
a2UgdGhpczoNCj4gDQo+IHN0YXRpYyBpbnQgaW9tbXVfYWxsb2NfZGVmYXVsdF9kb21haW4oc3Ry
dWN0IGlvbW11X2dyb3VwICpncm91cCwNCj4gCQkJCSAgICAgIHN0cnVjdCBkZXZpY2UgKmRldikN
Cj4gew0KPiAJdW5zaWduZWQgaW50IHR5cGU7DQo+IA0KPiAJaWYgKGdyb3VwLT5kZWZhdWx0X2Rv
bWFpbikNCj4gCQlyZXR1cm4gMDsNCj4gDQo+IAkuLi4NCj4gDQo+IGluIHdoaWNoIGNhc2UsIGl0
IHNob3VsZCBiZSBmaW5lPw0KDQpvaC4gc29ycnksIEkgb3Zlcmxvb2tlZCB0aGlzLiB0aGUgY3Vy
cmVudCBjb2RlIGlzIGVub3VnaC4NCkkgd2lsbCByZW1vdmUgdGhpcyBwYXRjaC4gYW5kIHNlbmQg
dGhlIG5leHQgdmVyc2lvbiBpbiB0aGlzIHdlZWsuDQpUaGFua3MgdmVyeSBtdWNoLg0KDQo+IA0K
PiBXaWxsDQoNCg==

