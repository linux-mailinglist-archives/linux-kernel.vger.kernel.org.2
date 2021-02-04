Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4DFD30E927
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 02:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233917AbhBDBMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 20:12:05 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:34579 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232184AbhBDBMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 20:12:03 -0500
X-UUID: 5d784d263b7043e084225b404753ac45-20210204
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Mn/ebbC9LsmEJbQuuUcinkZOL/S9ftYROo8U9Oj+0Po=;
        b=tHb7ekMh+g+dP+Jk60pyz+yKaHk3fCc56qBeBQK9Da1JyPSbOzrjhqg3Ti7O/7tSdxnOEMgN5T1p6/JKGJikRsLYaEEc/Zw010MdHidryOcfdXdyroDscCemy3gPxzd0MKx2wrFinRxCtvbW1ZY8LNagR46skC519oC4OS2keUw=;
X-UUID: 5d784d263b7043e084225b404753ac45-20210204
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1030138190; Thu, 04 Feb 2021 09:11:20 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 4 Feb
 2021 09:11:10 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 4 Feb 2021 09:11:09 +0800
Message-ID: <1612401069.2524.14.camel@mhfsdcap03>
Subject: Re: [PATCH][next] iommu/mediatek: Fix unsigned domid comparison
 with less than zero
From:   Yong Wu <yong.wu@mediatek.com>
To:     Colin King <colin.king@canonical.com>
CC:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Anan sun <anan.sun@mediatek.com>,
        "Chao Hao" <chao.hao@mediatek.com>,
        Tomasz Figa <tfiga@chromium.org>,
        <iommu@lists.linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Date:   Thu, 4 Feb 2021 09:11:09 +0800
In-Reply-To: <20210203135936.23016-1-colin.king@canonical.com>
References: <20210203135936.23016-1-colin.king@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 9BDBFE8346E958A37D1A2EE99CA3980372E31BF52999FC51717954E6E3C6FFB92000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIxLTAyLTAzIGF0IDEzOjU5ICswMDAwLCBDb2xpbiBLaW5nIHdyb3RlOg0KPiBG
cm9tOiBDb2xpbiBJYW4gS2luZyA8Y29saW4ua2luZ0BjYW5vbmljYWwuY29tPg0KPiANCj4gQ3Vy
cmVudGx5IHRoZSBjaGVjayBmb3IgZG9taWQgPCAwIGlzIGFsd2F5cyBmYWxzZSBiZWNhdXNlIGRv
bWlkDQo+IGlzIHVuc2lnbmVkLiAgRml4IHRoaXMgYnkgbWFraW5nIGl0IHNpZ25lZC4NCj4gDQo+
IEFkZHJlc3Nlcy1Db3Zlcml0eUwgKCJVbnNpZ25lZCBjb21wYXJpc29uIGFnYWluc3QgMCIpDQo+
IEZpeGVzOiBhYjFkNTI4MWE2MmIgKCJpb21tdS9tZWRpYXRlazogQWRkIGlvdmEgcmVzZXJ2ZWQg
ZnVuY3Rpb24iKQ0KPiBTaWduZWQtb2ZmLWJ5OiBDb2xpbiBJYW4gS2luZyA8Y29saW4ua2luZ0Bj
YW5vbmljYWwuY29tPg0KDQpUaGFua3MgZm9yIHRoZSBmaXguDQoNClJldmlld2VkLWJ5OiBZb25n
IFd1IDx5b25nLnd1QG1lZGlhdGVrLmNvbT4NCg0KPiAtLS0NCj4gIGRyaXZlcnMvaW9tbXUvbXRr
X2lvbW11LmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVs
ZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jIGIv
ZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KPiBpbmRleCAwYWQxNGE3NjA0YjEuLjgyM2Q3MTk5
NDViMiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KPiArKysgYi9k
cml2ZXJzL2lvbW11L210a19pb21tdS5jDQo+IEBAIC02NDAsNyArNjQwLDcgQEAgc3RhdGljIHZv
aWQgbXRrX2lvbW11X2dldF9yZXN2X3JlZ2lvbnMoc3RydWN0IGRldmljZSAqZGV2LA0KPiAgCQkJ
CSAgICAgICBzdHJ1Y3QgbGlzdF9oZWFkICpoZWFkKQ0KPiAgew0KPiAgCXN0cnVjdCBtdGtfaW9t
bXVfZGF0YSAqZGF0YSA9IGRldl9pb21tdV9wcml2X2dldChkZXYpOw0KPiAtCXVuc2lnbmVkIGlu
dCBkb21pZCA9IG10a19pb21tdV9nZXRfZG9tYWluX2lkKGRldiwgZGF0YS0+cGxhdF9kYXRhKSwg
aTsNCj4gKwlpbnQgZG9taWQgPSBtdGtfaW9tbXVfZ2V0X2RvbWFpbl9pZChkZXYsIGRhdGEtPnBs
YXRfZGF0YSksIGk7DQo+ICAJY29uc3Qgc3RydWN0IG10a19pb21tdV9pb3ZhX3JlZ2lvbiAqcmVz
diwgKmN1cmRvbTsNCj4gIAlzdHJ1Y3QgaW9tbXVfcmVzdl9yZWdpb24gKnJlZ2lvbjsNCj4gIAlp
bnQgcHJvdCA9IElPTU1VX1dSSVRFIHwgSU9NTVVfUkVBRDsNCg0K

