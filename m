Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D84B35D7B5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 08:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344850AbhDMGFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 02:05:06 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:36471 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S242332AbhDMGFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 02:05:04 -0400
X-UUID: 11a7d939441747d888f3524e17bbc3b4-20210413
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=qyFHjsBvTgUhsiff+Yj5ihfZwRWIm8QTGcXQbNJZ5Ao=;
        b=KLJ7mXJnSOaPZnfKoukKeewDtrCvwArI757yevMcZVbM4Kl7dBP9ZAWbQUwaIHdIw4+NHrSbPIWzoNH/A5GqA3mPvMWmqNQvWJg/FOXp5Max8TG5r54tT54SmK813gy7qX/cARacShZ5RZc0WFHzCEi9jKRQDK4x6bkj3wfp09U=;
X-UUID: 11a7d939441747d888f3524e17bbc3b4-20210413
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1451572964; Tue, 13 Apr 2021 14:04:41 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 13 Apr
 2021 14:04:37 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 13 Apr 2021 14:04:36 +0800
Message-ID: <1618293876.20053.19.camel@mhfsdcap03>
Subject: Re: [PATCH v5 04/16] memory: mtk-smi: Add device-link between
 smi-larb and smi-common
From:   Yong Wu <yong.wu@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <youlin.pei@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        "Matthias Kaehlcke" <mka@chromium.org>, <anan.sun@mediatek.com>,
        <chao.hao@mediatek.com>, <ming-fan.chen@mediatek.com>,
        <yi.kuo@mediatek.com>, <eizan@chromium.org>,
        <acourbot@chromium.org>
Date:   Tue, 13 Apr 2021 14:04:36 +0800
In-Reply-To: <ea7ed30f-050d-2d38-7c61-1e0c192f6ded@canonical.com>
References: <20210410091128.31823-1-yong.wu@mediatek.com>
         <20210410091128.31823-5-yong.wu@mediatek.com>
         <ea7ed30f-050d-2d38-7c61-1e0c192f6ded@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 8B8658583EC320938B6F639F945357FBB1223F0F73CE1216BBDAB02EA2DDC8D52000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIxLTA0LTEwIGF0IDE0OjQwICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiAxMC8wNC8yMDIxIDExOjExLCBZb25nIFd1IHdyb3RlOg0KPiA+IE5vcm1hbGx5
LCBJZiB0aGUgc21pLWxhcmIgSFcgbmVlZCB3b3JrLCB3ZSBzaG91bGQgZW5hYmxlIHRoZSBzbWkt
Y29tbW9uDQo+ID4gSFcgcG93ZXIgYW5kIGNsb2NrIGZpcnN0bHkuDQo+ID4gVGhpcyBwYXRjaCBh
ZGRzIGRldmljZS1saW5rIGJldHdlZW4gdGhlIHNtaS1sYXJiIGRldiBhbmQgdGhlIHNtaS1jb21t
b24NCj4gPiBkZXYuIHRoZW4gSWYgcG1fcnVudGltZV9nZXRfc3luYyhzbWktbGFyYi1kZXYpLCB0
aGUgcG1fcnVudGltZV9nZXRfc3luYw0KPiA+IChzbWktY29tbW9uLWRldikgd2lsbCBiZSBjYWxs
ZWQgYXV0b21hdGljYWxseS4NCj4gPiANCj4gPiBBbHNvLCBBZGQgRExfRkxBR19TVEFURUxFU1Mg
dG8gYXZvaWQgdGhlIHNtaS1jb21tb24gY2xvY2tzIGJlIGdhdGVkIHdoZW4NCj4gPiBwcm9iZS4N
Cj4gPiANCj4gPiBDQzogTWF0dGhpYXMgQnJ1Z2dlciA8bWF0dGhpYXMuYmdnQGdtYWlsLmNvbT4N
Cj4gPiBTdWdnZXN0ZWQtYnk6IFRvbWFzeiBGaWdhIDx0ZmlnYUBjaHJvbWl1bS5vcmc+DQo+ID4g
U2lnbmVkLW9mZi1ieTogWW9uZyBXdSA8eW9uZy53dUBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+
ID4gIGRyaXZlcnMvbWVtb3J5L210ay1zbWkuYyB8IDE5ICsrKysrKysrKystLS0tLS0tLS0NCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQo+IA0K
PiBJIHVuZGVyc3Rvb2QgdGhpcyBpcyBhIGRlcGVuZGVuY3kgZm9yIG90aGVyIHBhdGNoZXMsIHNv
Og0KPiBBY2tlZC1ieTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBj
YW5vbmljYWwuY29tPg0KPiANCj4gSWYgSSBhbSB3cm9uZyBhbmQgSSBjYW4gdGFrZSBpdCB2aWEg
bWVtb3J5IHRyZWUsIGxldCBtZSBrbm93Lg0KDQpIaSBLcnp5c3p0b2YsDQoNClRoYW5rcyB2ZXJ5
IG11Y2ggZm9yIHlvdXIgcXVpY2tseSByZXZpZXcuDQoNCkkgdGhpbmsgaXQgaXMgb2sgaWYgaXQg
Z28gdGhyb3VnaCBtZW1vcnkgdHJlZS4gSW4gdGhlIG9yaWdpbmFsIHBhdGNoLCB3ZQ0KcG1fcnVu
dGltZV9nZXQoc21pLWNvbW1vbi1kZXYpIGluIHRoZSBzbWktbGFyYidzIHBtIHJlc3VtZSBjYWxs
YmFjay4NClRoaXMgcGF0Y2ggb25seSB1c2UgZGV2aWNlLWxpbmsgZG8gdGhpcy4gdGh1cywgdGhp
cyBwYXRjaCBoYXZlIG5vDQpmdW5jdGlvbiBjaGFuZ2UuIGl0IG9ubHkgYWRqdXN0cyB0aGUgU01J
IGludGVybmFsIGNvZGUgZmxvdy4NCg0KSW4gYWRkaXRpb24sIFsxNC8xNl0gZXhwZWN0cyB5b3Vy
IEFja2VkLWJ5LiBhbmQgdGhhdCBvbmUgc2hvdWxkIGJlDQptZXJnZWQgd2l0aCB0aGUgb3RoZXJz
Lg0KDQpBYm91dCB0aGUgb3RoZXJzIHBhdGNoZXMsIEknbSBub3Qgc3VyZSB3aGljaCB0cmVlIHRo
ZXkgc2hvdWxkIGdvDQp0aHJvdWdoLiB0aGV5IGNyb3NzIHNldmVyYWwgdHJlZXMsIGR0LWJpbmRp
bmcvaW9tbXUvbWVkaWEvZHJtL2R0cy4NCg0KTm90IHN1cmUgaWYgTWF0dGhpYXMgY291bGQgaGF2
ZSB0aW1lIHRvIHJldmlldyBhbmQgZ2l2ZSBzb21lIHN1Z2dlc3Rpb24uDQoNCj4gDQo+IEJlc3Qg
cmVnYXJkcywNCj4gS3J6eXN6dG9mDQo+IA0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXw0KPiBMaW51eC1tZWRpYXRlayBtYWlsaW5nIGxpc3QNCj4gTGlu
dXgtbWVkaWF0ZWtAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW1lZGlhdGVrDQoNCg==

