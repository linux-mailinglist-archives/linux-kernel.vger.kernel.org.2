Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5222C3B7E2A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 09:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbhF3Hdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 03:33:50 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:43058 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233036AbhF3Hdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 03:33:46 -0400
X-UUID: d8c28328ba0341c8a7351691847667c5-20210630
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=62IYE54IdDULAKwoKbHVM6/DHaOQllqFJgwJn2lFs3o=;
        b=Js6kweoZOvtGLYzNFo9t8a6+U0vW5lmffG+YczPcM8ZIJNp9LAJ2Ldjy9xqh81eVmBJJgc1hfG1FBIJtP0VJKWyMSewHqH4K4tuJEWDOGUgjyn6wIks8PM/I3ocSQxFLg/JMQFk+ft45X+EgAYPvsMJpjQugEuHmV8xvZqKMIHY=;
X-UUID: d8c28328ba0341c8a7351691847667c5-20210630
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1737304554; Wed, 30 Jun 2021 15:31:08 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 30 Jun
 2021 15:30:58 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 30 Jun 2021 15:30:57 +0800
Message-ID: <1625038257.25647.5.camel@mhfsdcap03>
Subject: Re: [PATCH 01/24] dt-bindings: mediatek: mt8195: Add binding for MM
 IOMMU
From:   Yong Wu <yong.wu@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
CC:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        Tomasz Figa <tfiga@chromium.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <youlin.pei@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <chao.hao@mediatek.com>
Date:   Wed, 30 Jun 2021 15:30:57 +0800
In-Reply-To: <41809d87-0f1b-13fd-b565-26a17626aad9@canonical.com>
References: <20210630023504.18177-1-yong.wu@mediatek.com>
         <20210630023504.18177-2-yong.wu@mediatek.com>
         <41809d87-0f1b-13fd-b565-26a17626aad9@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 1963F5674633076AEF957F6E442E2D1D0BE305E0B7F438FD146FEE00D7D59E362000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIxLTA2LTMwIGF0IDA4OjI2ICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiAzMC8wNi8yMDIxIDA0OjM0LCBZb25nIFd1IHdyb3RlOg0KPiA+IFRoaXMgcGF0
Y2ggYWRkcyBkZXNjcmlwdGlvbnMgZm9yIG10ODE5NSBJT01NVSB3aGljaCBhbHNvIHVzZSBBUk0N
Cj4gPiBTaG9ydC1EZXNjcmlwdG9yIHRyYW5zbGF0aW9uIHRhYmxlIGZvcm1hdC4NCj4gPiANCj4g
PiBJbiBtdDgxOTUsIHRoZXJlIGFyZSB0d28gc21pLWNvbW1vbiBIVyBhbmQgSU9NTVUsIG9uZSBp
cyBmb3IgdmRvKHZpZGVvDQo+ID4gb3V0cHV0KSwgdGhlIG90aGVyIGlzIGZvciB2cHAodmlkZW8g
cHJvY2Vzc2luZyBwaXBlKS4gVGhleSBjb25uZWN0cw0KPiA+IHdpdGggZGlmZmVyZW50IHNtaS1s
YXJicywgdGhlbiBzb21lIHNldHRpbmcobGFyYmlkX3JlbWFwKSBpcyBkaWZmZXJlbnQuDQo+ID4g
RGlmZmVyZW50aWF0ZSB0aGVtIHdpdGggdGhlIGNvbXBhdGlibGUgc3RyaW5nLg0KPiA+IA0KPiA+
IFNvbWV0aGluZyBsaWtlIHRoaXM6DQo+ID4gDQo+ID4gICAgIElPTU1VKFZETykgICAgICAgICAg
SU9NTVUoVlBQKQ0KPiA+ICAgICAgICB8ICAgICAgICAgICAgICAgICAgIHwNCj4gPiAgIFNNSV9D
T01NT05fVkRPICAgICAgU01JX0NPTU1PTl9WUFANCj4gPiAgIC0tLS0tLS0tLS0tLS0tLSAgICAg
LS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICAgfCAgICAgIHwgICAuLi4gICAgICB8ICAgICAgfCAgICAg
Li4uDQo+ID4gbGFyYjAgbGFyYjIgIC4uLiAgICBsYXJiMSBsYXJiMyAgICAuLi4NCj4gPiANCj4g
PiBBbm90aGVyIGNoYW5nZSBpcyB0aGF0IHdlIGhhdmUgYSBuZXcgSU9NTVUgdGhhdCBpcyBmb3Ig
aW5mcmEgbWFzdGVyIGxpa2UNCj4gPiBQQ0llIGFuZCBVU0IuIFRoZSBpbmZyYSBtYXN0ZXIgZG9u
J3QgaGF2ZSB0aGUgbGFyYiBhbmQgcG9ydHMsIHRodXMgd2UNCj4gPiByZW5hbWUgdGhlIHBvcnQg
aGVhZGVyIGZpbGUgdG8gbXQ4MTk1LW1lbW9yeS1wb3J0LmggcmF0aGVyIHRoYW4NCj4gPiBtdDgx
OTUtbGFyYi1wb3J0LmguDQo+ID4gDQo+ID4gQWxzbywgdGhlIElPTU1VIGlzIG5vdCBvbmx5IGZv
ciBNTSwgdGh1cywgd2UgZG9uJ3QgY2FsbCBpdCAibTR1IiB3aGljaA0KPiA+IG1lYW5zICJNdWx0
aU1lZGlhIE1lbW9yeSBNYW5hZ2VtZW50IFVOSVQiLiB0aHVzLCB1c2UgdGhlICJpb21tdSIgYXMg
dGhlDQo+ID4gY29tcGF0aWFibGUgc3RyaW5nLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFlv
bmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vYmluZGluZ3Mv
aW9tbXUvbWVkaWF0ZWssaW9tbXUueWFtbCAgICAgICAgfCAgIDcgKw0KPiA+ICAuLi4vZHQtYmlu
ZGluZ3MvbWVtb3J5L210ODE5NS1tZW1vcnktcG9ydC5oICAgfCAzOTAgKysrKysrKysrKysrKysr
KysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMzk3IGluc2VydGlvbnMoKykNCj4gPiAgY3JlYXRl
IG1vZGUgMTAwNjQ0IGluY2x1ZGUvZHQtYmluZGluZ3MvbWVtb3J5L210ODE5NS1tZW1vcnktcG9y
dC5oDQo+ID4gDQo+IA0KPiBJIHVuZGVyc3RhbmQgdGhpcyB3aWxsIGdvIHRocm91Z2ggSU9NTVUg
dHJlZS4gRG8geW91IGtub3cgYWJvdXQgYW55DQo+IGZ1cnRoZXIgcGF0Y2hlcyBmb3IgbWVtb3J5
IGNvbnRyb2xsZXJzIHdoaWNoIHdpbGwgbmVlZCB0aGUgaGVhZGVyPw0KDQpUaGlzIGhlYWRlciBm
aWxlIHdpbGwgb25seSBiZSB1c2VkIGluIGR0c2kgZmlsZS4gdGhlIGlvbW11IG1hc3RlcnMgd2ls
bA0KdXNlIHRoZXNlIHBvcnQgZGVmaW5pdGlvbnMgaW4gdGhlIGR0c2kuDQoNClRoZSBTTUkgZHJp
dmVyIG5vIG5lZWQgaW5jbHVkZSB0aGlzIGhlYWRlciBmaWxlLg0KDQpCeSB0aGUgd2F5LCB0aGUg
bXQ4MTk1IFNNSSBwYXRjaGVzIGlzIGF0Og0KDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51
eC1tZWRpYXRlay8yMDIxMDYxNjExNDM0Ni4xODgxMi0xLXlvbmcud3VAbWVkaWF0ZWsuY29tLyAN
Cg0KPiANCj4gQWNrZWQtYnk6IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dz
a2lAY2Fub25pY2FsLmNvbT4NCg0KVGhhbmtzIHZlcnkgbXVjaCBmb3IgeW91ciBxdWljayByZXZp
ZXcuDQoNCj4gDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KPiANCj4gX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gTGludXgtbWVkaWF0
ZWsgbWFpbGluZyBsaXN0DQo+IExpbnV4LW1lZGlhdGVrQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4g
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1tZWRpYXRl
aw0KDQo=

