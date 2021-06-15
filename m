Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 848CD3A7E31
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 14:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhFOMbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 08:31:44 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:29808 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229520AbhFOMbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 08:31:43 -0400
X-UUID: 2caa48c5f2f4426095a7d3a514d19c4a-20210615
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=hy2ulTOYtTz6fWJfoMGqCOL0cJY7Tmx70wHn6d0aIag=;
        b=KgyZsXtf1OcG8DAwz2BuLG8DJuwufQrmOzmvtPNmpochpW39dfI3+XMaOpzQp8cZJcpnBCu6GgrZBD8ybQ6ReJf7AM2ZvUl88RFRTcNn8E84gCCmaSEq1Ik70zhfOKdvsWF+qPhtRIbJwUjIR2alMlnYBLxxgu7tTS0TyvpcAas=;
X-UUID: 2caa48c5f2f4426095a7d3a514d19c4a-20210615
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 69459193; Tue, 15 Jun 2021 20:29:35 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 15 Jun
 2021 20:29:26 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Jun 2021 20:29:26 +0800
Message-ID: <1623760166.24285.1.camel@mhfsdcap03>
Subject: Re: [PATCH v3 3/6] iommu: Improve iommu_iotlb_gather helpers
From:   Yong Wu <yong.wu@mediatek.com>
To:     Nadav Amit <nadav.amit@gmail.com>
CC:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        Jiajun Cao <caojiajun@vmware.com>,
        Will Deacon <will@kernel.org>
Date:   Tue, 15 Jun 2021 20:29:26 +0800
In-Reply-To: <20210607182541.119756-4-namit@vmware.com>
References: <20210607182541.119756-1-namit@vmware.com>
         <20210607182541.119756-4-namit@vmware.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 619EC6FAECE4DB4BFD5D7B0E99DD46A5676E4A97FF55DE65E1407293A0E41BBB2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTA2LTA3IGF0IDExOjI1IC0wNzAwLCBOYWRhdiBBbWl0IHdyb3RlOg0KPiBG
cm9tOiBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29tPg0KPiANCj4gVGhlIE1lZGlh
dGVrIGRyaXZlciBpcyBub3QgdGhlIG9ubHkgb25lIHdoaWNoIG1pZ2h0IHdhbnQgYSBiYXNpYw0K
PiBhZGRyZXNzLWJhc2VkIGdhdGhlcmluZyBiZWhhdmlvdXIsIHNvIGFsdGhvdWdoIGl0J3MgYXJn
dWFibHkgc2ltcGxlDQo+IGVub3VnaCB0byBvcGVuLWNvZGUsIGxldCdzIGZhY3RvciBpdCBvdXQg
Zm9yIHRoZSBzYWtlIG9mIGNsZWFubGluZXNzLg0KPiBMZXQncyBhbHNvIHRha2UgdGhpcyBvcHBv
cnR1bml0eSB0byBkb2N1bWVudCB0aGUgaW50ZW50IG9mIHRoZXNlDQo+IGhlbHBlcnMgZm9yIGNs
YXJpdHkuDQo+IA0KPiBDYzogSm9lcmcgUm9lZGVsIDxqb3JvQDhieXRlcy5vcmc+DQo+IENjOiBX
aWxsIERlYWNvbiA8d2lsbEBrZXJuZWwub3JnPg0KPiBDYzogSmlhanVuIENhbyA8Y2FvamlhanVu
QHZtd2FyZS5jb20+DQo+IENjOiBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29tPg0K
PiBDYzogTHUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4NCj4gQ2M6IGlvbW11QGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnDQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnDQo+IFNpZ25lZC1vZmYtYnk6IFJvYmluIE11cnBoeSA8cm9iaW4ubXVycGh5QGFybS5jb20+
DQo+IA0KPiAtLS0NCj4gDQo+IENoYW5nZXMgZnJvbSBSb2JpbidzIHZlcnNpb246DQo+ICogQWRk
ZWQgaW9tbXVfaW90bGJfZ2F0aGVyX2FkZF9yYW5nZSgpIHN0dWIgIUNPTkZJR19JT01NVV9BUEkN
Cj4gKiBVc2UgaW9tbXVfaW90bGJfZ2F0aGVyX2FkZF9yYW5nZSgpIGluIGlvbW11X2lvdGxiX2dh
dGhlcl9hZGRfcGFnZSgpDQo+IC0tLQ0KPiAgZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyB8ICA1
ICstLS0tDQo+ICBpbmNsdWRlL2xpbnV4L2lvbW11LmggICAgIHwgNDMgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKy0tLS0tDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDM5IGluc2VydGlv
bnMoKyksIDkgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9t
dGtfaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCj4gaW5kZXggZTA2YjhhMGUy
YjU2Li4wYWY0YTkxYWM3ZGEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11
LmMNCj4gKysrIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KPiBAQCAtNTIzLDEwICs1MjMs
NyBAQCBzdGF0aWMgc2l6ZV90IG10a19pb21tdV91bm1hcChzdHJ1Y3QgaW9tbXVfZG9tYWluICpk
b21haW4sDQo+ICAJc3RydWN0IG10a19pb21tdV9kb21haW4gKmRvbSA9IHRvX210a19kb21haW4o
ZG9tYWluKTsNCj4gIAl1bnNpZ25lZCBsb25nIGVuZCA9IGlvdmEgKyBzaXplIC0gMTsNCg0KUGxl
YXNlIGFsc28gaGVscCBkZWxldGUgdGhpcyAiZW5kIi4NCg0KPiAgDQo+IC0JaWYgKGdhdGhlci0+
c3RhcnQgPiBpb3ZhKQ0KPiAtCQlnYXRoZXItPnN0YXJ0ID0gaW92YTsNCj4gLQlpZiAoZ2F0aGVy
LT5lbmQgPCBlbmQpDQo+IC0JCWdhdGhlci0+ZW5kID0gZW5kOw0KPiArCWlvbW11X2lvdGxiX2dh
dGhlcl9hZGRfcmFuZ2UoZ2F0aGVyLCBpb3ZhLCBzaXplKTsNCj4gIAlyZXR1cm4gZG9tLT5pb3At
PnVubWFwKGRvbS0+aW9wLCBpb3ZhLCBzaXplLCBnYXRoZXIpOw0KPiAgfQ0KDQpbc25pcF0gDQoN
Cg0K

