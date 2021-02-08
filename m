Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44836312AD1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 07:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbhBHGhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 01:37:46 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:20372 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229626AbhBHGgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 01:36:48 -0500
X-UUID: 9b9ccf36a8f8412a87f8fd34127b7a8d-20210208
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=3N9rRASFzxmeOt/wKztN0VIoYEGnGsamx+GlAqJh9+4=;
        b=GUGSnm/9H8jEaAidO3sdb9qdvwlFwyjmwO+0edSlA1nQh7eH+Q/ntAg0t/zf675jEsMG42KldyEJaThQlZIz5IyMSzvLFTgRXQFlpx+4PZcq+a/SUl69oQoDMoMDaI8mCnVoh6sFLgSXwJVnLQZE00sCDge0I/X72nCWe0EWSgo=;
X-UUID: 9b9ccf36a8f8412a87f8fd34127b7a8d-20210208
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 452771816; Mon, 08 Feb 2021 14:35:27 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32N2.mediatek.inc
 (172.27.4.72) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 8 Feb
 2021 14:35:25 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 8 Feb 2021 14:35:24 +0800
Message-ID: <1612766125.19482.3.camel@mhfsdcap03>
Subject: Re: [PATCH] MAINTAINERS: repair file pattern in MEDIATEK IOMMU
 DRIVER
From:   Yong Wu <yong.wu@mediatek.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Joerg Roedel <joro@8bytes.org>
CC:     <linux-mediatek@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, Will Deacon <will@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Pia Eichinger <pia.eichinger@st.oth-regensburg.de>,
        Joe Perches <joe@perches.com>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Date:   Mon, 8 Feb 2021 14:35:25 +0800
In-Reply-To: <20210208061025.29198-1-lukas.bulwahn@gmail.com>
References: <20210208061025.29198-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: A293A2F4DB79585306E07C30A2048CADF97377D97F56478078E0BA17EB9CA5692000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTAyLTA4IGF0IDA3OjEwICswMTAwLCBMdWthcyBCdWx3YWhuIHdyb3RlOg0K
PiBDb21taXQgNmFmNDg3Mzg1MmM0ICgiTUFJTlRBSU5FUlM6IEFkZCBlbnRyeSBmb3IgTWVkaWFU
ZWsgSU9NTVUiKSBtZW50aW9ucw0KPiB0aGUgcGF0dGVybiAnZHJpdmVycy9pb21tdS9tdGstaW9t
bXUqJywgYnV0IHRoZSBmaWxlcyBhcmUgYWN0dWFsbHkgbmFtZWQNCj4gd2l0aCBhbiB1bmRlcnNj
b3JlLCBub3Qgd2l0aCBhIGh5cGhlbi4NCj4gDQo+IEhlbmNlLCAuL3NjcmlwdHMvZ2V0X21haW50
YWluZXIucGwgLS1zZWxmLXRlc3Q9cGF0dGVybnMgY29tcGxhaW5zOg0KPiANCj4gICB3YXJuaW5n
OiBubyBmaWxlIG1hdGNoZXMgIEY6ICAgIGRyaXZlcnMvaW9tbXUvbXRrLWlvbW11Kg0KPiANCj4g
UmVwYWlyIHRoaXMgbWlub3IgdHlwbyBpbiB0aGUgZmlsZSBwYXR0ZXJuLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogTHVrYXMgQnVsd2FobiA8bHVrYXMuYnVsd2FobkBnbWFpbC5jb20+DQo+IC0tLQ0K
PiBhcHBsaWVzIGNsZWFubHkgb24gbmV4dC0yMDIxMDIwNQ0KPiANCj4gWW9uZywgcGxlYXNlIGFj
ay4NCg0KK0pvZXJnLg0KDQpzb3JyeSBmb3IgdGhlIHR5cG8uDQoNCkFja2VkLWJ5OiBZb25nIFd1
IDx5b25nLnd1QG1lZGlhdGVrLmNvbT4NCg0KPiBXaWxsLCBwbGVhc2UgcGljayB0aGlzIG1pbm9y
IGZpeHVwIGZvciB5b3VyIGlvbW11LW5leHQgdHJlZS4NCj4gDQo+ICBNQUlOVEFJTkVSUyB8IDIg
Ky0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMNCj4gaW5kZXggNjc0ZjQy
Mzc1YWNmLi42YjUwN2U4ZDc4MjggMTAwNjQ0DQo+IC0tLSBhL01BSU5UQUlORVJTDQo+ICsrKyBi
L01BSU5UQUlORVJTDQo+IEBAIC0xMTIwMCw3ICsxMTIwMCw3IEBAIEw6CWlvbW11QGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnDQo+ICBMOglsaW51eC1tZWRpYXRla0BsaXN0cy5pbmZyYWRlYWQu
b3JnIChtb2RlcmF0ZWQgZm9yIG5vbi1zdWJzY3JpYmVycykNCj4gIFM6CVN1cHBvcnRlZA0KPiAg
RjoJRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lvbW11L21lZGlhdGVrKg0KPiAt
RjoJZHJpdmVycy9pb21tdS9tdGstaW9tbXUqDQo+ICtGOglkcml2ZXJzL2lvbW11L210a19pb21t
dSoNCj4gIEY6CWluY2x1ZGUvZHQtYmluZGluZ3MvbWVtb3J5L210Ki1wb3J0LmgNCj4gIA0KPiAg
TUVESUFURUsgSlBFRyBEUklWRVINCg0K

