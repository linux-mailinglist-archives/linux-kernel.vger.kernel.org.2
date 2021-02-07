Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A08703120C1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 02:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhBGBqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 20:46:17 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:13392 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229522AbhBGBqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 20:46:15 -0500
X-UUID: 827f1e2f1488468593be5b168193d73c-20210207
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=UOcodyhE36vNMhq5b0qi4z7RJDMmPhWYZvVA5+EV+68=;
        b=I1A0/qzk9afNaXia6AWsmFc5zD8zmrMHswca9erF1+Sj5WtfKR/9iqusGc7NFkajs2Krl+ghGOMG5JyYzXG04md0fMR2yKfqxzp2uS2MdsZYHdoFVEFPdbfMMIst9RlOzPT+tFrFN76+HGMqo248uGyQrAlXyzpcx4wA4KGzdTc=;
X-UUID: 827f1e2f1488468593be5b168193d73c-20210207
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 591288906; Sun, 07 Feb 2021 09:45:27 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 7 Feb
 2021 09:45:23 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 7 Feb 2021 09:45:19 +0800
Message-ID: <1612662319.2524.16.camel@mhfsdcap03>
Subject: Re: [PATCH] iommu/mediatek: Fix error code in probe()
From:   Yong Wu <yong.wu@mediatek.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Joerg Roedel <joro@8bytes.org>, <kernel-janitors@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Tomasz Figa <tfiga@chromium.org>,
        <iommu@lists.linux-foundation.org>,
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Sun, 7 Feb 2021 09:45:19 +0800
In-Reply-To: <YB0+GU5akSdu29Vu@mwanda>
References: <YB0+GU5akSdu29Vu@mwanda>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: A90FA4188E79EC868A03301EA33900D9514BD2F174ABA508AF7335354372B47E2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIxLTAyLTA1IGF0IDE1OjQ2ICswMzAwLCBEYW4gQ2FycGVudGVyIHdyb3RlOg0K
PiBUaGlzIGVycm9yIHBhdGggaXMgc3VwcG9zZWQgdG8gcmV0dXJuIC1FSU5WQUwuICBJdCB1c2Vk
IHRvIHJldHVybg0KPiBkaXJlY3RseSBidXQgd2UgYWRkZWQgc29tZSBjbGVhbiB1cCBhbmQgYWNj
aWRlbnRhbGx5IHJlbW92ZWQgdGhlDQo+IGVycm9yIGNvZGUuICBBbHNvIEkgZml4ZWQgYSB0eXBv
IGluIHRoZSBlcnJvciBtZXNzYWdlLg0KPiANCj4gRml4ZXM6IGMwYjU3NTgxYjczYiAoImlvbW11
L21lZGlhdGVrOiBBZGQgcG93ZXItZG9tYWluIG9wZXJhdGlvbiIpDQo+IFNpZ25lZC1vZmYtYnk6
IERhbiBDYXJwZW50ZXIgPGRhbi5jYXJwZW50ZXJAb3JhY2xlLmNvbT4NCg0KUmV2aWV3ZWQtYnk6
IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPg0KDQo+IC0tLQ0KPiAgZHJpdmVycy9pb21t
dS9tdGtfaW9tbXUuYyB8IDMgKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9tdGtfaW9t
bXUuYyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCj4gaW5kZXggMGFkMTRhNzYwNGIxLi41
Zjc4YWMwZGMzMGUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCj4g
KysrIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KPiBAQCAtODg2LDcgKzg4Niw4IEBAIHN0
YXRpYyBpbnQgbXRrX2lvbW11X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+
ICAJbGluayA9IGRldmljZV9saW5rX2FkZChkYXRhLT5zbWljb21tX2RldiwgZGV2LA0KPiAgCQkJ
RExfRkxBR19TVEFURUxFU1MgfCBETF9GTEFHX1BNX1JVTlRJTUUpOw0KPiAgCWlmICghbGluaykg
ew0KPiAtCQlkZXZfZXJyKGRldiwgIlVuYWJsZSBsaW5rICVzLlxuIiwgZGV2X25hbWUoZGF0YS0+
c21pY29tbV9kZXYpKTsNCj4gKwkJZGV2X2VycihkZXYsICJVbmFibGUgdG8gbGluayAlcy5cbiIs
IGRldl9uYW1lKGRhdGEtPnNtaWNvbW1fZGV2KSk7DQo+ICsJCXJldCA9IC1FSU5WQUw7DQo+ICAJ
CWdvdG8gb3V0X3J1bnRpbWVfZGlzYWJsZTsNCj4gIAl9DQo+ICANCg0K

