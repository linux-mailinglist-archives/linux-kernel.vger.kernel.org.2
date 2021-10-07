Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 377EF425232
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 13:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241071AbhJGLpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 07:45:17 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:13704 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbhJGLpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 07:45:15 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HQ8YT0PGdzWlbJ;
        Thu,  7 Oct 2021 19:41:49 +0800 (CST)
Received: from dggpemm100005.china.huawei.com (7.185.36.231) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 7 Oct 2021 19:43:18 +0800
Received: from dggpeml100016.china.huawei.com (7.185.36.216) by
 dggpemm100005.china.huawei.com (7.185.36.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 7 Oct 2021 19:43:18 +0800
Received: from dggpeml100016.china.huawei.com ([7.185.36.216]) by
 dggpeml100016.china.huawei.com ([7.185.36.216]) with mapi id 15.01.2308.008;
 Thu, 7 Oct 2021 19:43:18 +0800
From:   "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "will@kernel.org" <will@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>
CC:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: RE: [PATCH v2 1/2] iommu/vt-d: convert the return type of
 first_pte_in_page to bool
Thread-Topic: [PATCH v2 1/2] iommu/vt-d: convert the return type of
 first_pte_in_page to bool
Thread-Index: AQHXufzwnJ0IkXVZ70aRussks8pnnKvGjCOAgADf3UA=
Date:   Thu, 7 Oct 2021 11:43:18 +0000
Message-ID: <046cdaae8b204c3da442ec44fcc6c25d@huawei.com>
References: <20211005152308.1061-1-longpeng2@huawei.com>
 <20211005152308.1061-2-longpeng2@huawei.com>
 <62016e41-5d9d-2d42-e16f-59809f9f1f75@linux.intel.com>
In-Reply-To: <62016e41-5d9d-2d42-e16f-59809f9f1f75@linux.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.148.223]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTHUgQmFvbHUgW21haWx0
bzpiYW9sdS5sdUBsaW51eC5pbnRlbC5jb21dDQo+IFNlbnQ6IFRodXJzZGF5LCBPY3RvYmVyIDcs
IDIwMjEgMjoxOCBQTQ0KPiBUbzogTG9uZ3BlbmcgKE1pa2UsIENsb3VkIEluZnJhc3RydWN0dXJl
IFNlcnZpY2UgUHJvZHVjdCBEZXB0LikNCj4gPGxvbmdwZW5nMkBodWF3ZWkuY29tPjsgZHdtdzJA
aW5mcmFkZWFkLm9yZzsgd2lsbEBrZXJuZWwub3JnOw0KPiBqb3JvQDhieXRlcy5vcmcNCj4gQ2M6
IGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbTsgaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEdvbmdsZWkgKEFyZWkpIDxhcmVp
LmdvbmdsZWlAaHVhd2VpLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAxLzJdIGlvbW11
L3Z0LWQ6IGNvbnZlcnQgdGhlIHJldHVybiB0eXBlIG9mDQo+IGZpcnN0X3B0ZV9pbl9wYWdlIHRv
IGJvb2wNCj4gDQo+IE9uIDIwMjEvMTAvNSAyMzoyMywgTG9uZ3BlbmcoTWlrZSkgd3JvdGU6DQo+
ID4gZmlyc3RfcHRlX2luX3BhZ2UoKSByZXR1cm5zIGJvb2xlYW4gdmFsdWUsIHNvIGxldCdzIGNv
bnZlcnQgaXRzDQo+ID4gcmV0dXJuIHR5cGUgdG8gYm9vbC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IExvbmdwZW5nKE1pa2UpIDxsb25ncGVuZzJAaHVhd2VpLmNvbT4NCj4gPiAtLS0NCj4gPiAg
IGluY2x1ZGUvbGludXgvaW50ZWwtaW9tbXUuaCB8IDIgKy0NCj4gPiAgIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvbGludXgvaW50ZWwtaW9tbXUuaCBiL2luY2x1ZGUvbGludXgvaW50ZWwtaW9tbXUuaA0K
PiA+IGluZGV4IDA1YTY1ZWIuLmE1OTBiMDAgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9saW51
eC9pbnRlbC1pb21tdS5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9pbnRlbC1pb21tdS5oDQo+
ID4gQEAgLTcwOCw3ICs3MDgsNyBAQCBzdGF0aWMgaW5saW5lIGJvb2wgZG1hX3B0ZV9zdXBlcnBh
Z2Uoc3RydWN0IGRtYV9wdGUgKnB0ZSkNCj4gPiAgIAlyZXR1cm4gKHB0ZS0+dmFsICYgRE1BX1BU
RV9MQVJHRV9QQUdFKTsNCj4gPiAgIH0NCj4gPg0KPiA+IC1zdGF0aWMgaW5saW5lIGludCBmaXJz
dF9wdGVfaW5fcGFnZShzdHJ1Y3QgZG1hX3B0ZSAqcHRlKQ0KPiA+ICtzdGF0aWMgaW5saW5lIGJv
b2wgZmlyc3RfcHRlX2luX3BhZ2Uoc3RydWN0IGRtYV9wdGUgKnB0ZSkNCj4gPiAgIHsNCj4gPiAg
IAlyZXR1cm4gISgodW5zaWduZWQgbG9uZylwdGUgJiB+VlREX1BBR0VfTUFTSyk7DQo+ID4gICB9
DQo+ID4NCj4gDQo+IFByb2JhYmx5LA0KPiANCj4gCXJldHVybiBJU19BTElHTkVEKCh1bnNpZ25l
ZCBsb25nKXB0ZSwgVlREX1BBR0VfU0laRSk7DQo+IA0KPiBsb29rcyBuZWF0ZXI/DQo+IA0KDQpM
b29rcyBiZXR0ZXIhIEknbGwgaW5jbHVkZSB0aGlzIG9wdGltaXphdGlvbiBpbiB2My4NCg0KPiBC
ZXN0IHJlZ2FyZHMsDQo+IGJhb2x1DQo=
