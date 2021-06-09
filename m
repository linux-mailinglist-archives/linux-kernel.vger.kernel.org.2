Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 300033A1719
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 16:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237908AbhFIOZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 10:25:12 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3815 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237850AbhFIOYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 10:24:54 -0400
Received: from nkgeml705-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G0Tj80MPxzWsTw;
        Wed,  9 Jun 2021 22:18:04 +0800 (CST)
Received: from nkgeml706-chm.china.huawei.com (10.98.57.153) by
 nkgeml705-chm.china.huawei.com (10.98.57.154) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 22:22:56 +0800
Received: from nkgeml706-chm.china.huawei.com ([10.98.57.153]) by
 nkgeml706-chm.china.huawei.com ([10.98.57.153]) with mapi id 15.01.2176.012;
 Wed, 9 Jun 2021 22:22:56 +0800
From:   "Zhangjiantao (Kirin, nanjing)" <water.zhangjiantao@huawei.com>
To:     "Xuetao (kirin)" <xuetao09@huawei.com>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "chenyu (U)" <chenyu56@huawei.com>,
        Caiyadong <caiyadong@huawei.com>,
        xuhaiyang <xuhaiyang5@hisilicon.com>
Subject: [PATCH] xhci: solve a double free problem while doing s4
Thread-Topic: [PATCH] xhci: solve a double free problem while doing s4
Thread-Index: AQHXXTD5CgkqbtPEIEyqX6Nz35qOtasLuySA
Date:   Wed, 9 Jun 2021 14:22:55 +0000
Message-ID: <1428e2d7b7b74fccb3493384f96c521a@huawei.com>
References: <1623244292-108534-1-git-send-email-xuetao09@huawei.com>
In-Reply-To: <1623244292-108534-1-git-send-email-xuetao09@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.136.108.160]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

d2hlbiBzeXN0ZW0gaXMgZG9pbmcgczQsIHRoZSBwcm9jZXNzIG9mIHhoY2lfcmVzdW1lIG1heSBi
ZSBhcyBiZWxvdzoNCjHjgIF4aGNpX21lbV9jbGVhbnVwDQoy44CBeGhjaV9pbml0LT54aGNpX21l
bV9pbml0LT54aGNpX21lbV9jbGVhbnVwKHdoZW4gbWVtb3J5IGlzIG5vdCBlbm91Z2gpLg0KeGhj
aV9tZW1fY2xlYW51cCB3aWxsIGJlIGV4ZWN1dGVkIHR3aWNlIHdoZW4gc3lzdGVtIGlzIG91dCBv
ZiBtZW1vcnkuDQp4aGNpLT5wb3J0X2NhcHMgaXMgZnJlZWQgaW4geGhjaV9tZW1fY2xlYW51cCxi
dXQgaXQgaXNuJ3Qgc2V0IHRvIE5VTEwuDQpJdCB3aWxsIGJlIGZyZWVkIHR3aWNlIHdoZW4geGhj
aV9tZW1fY2xlYW51cCBpcyBjYWxsZWQgdGhlIHNlY29uZCB0aW1lLg0KDQpXZSBnb3QgZm9sbG93
aW5nIGJ1ZyB3aGVuIHN5c3RlbSByZXN1bWVzIGZyb20gczQ6DQoNCmtlcm5lbCBCVUcgYXQgbW0v
c2x1Yi5jOjMwOSENCkludGVybmFsIGVycm9yOiBPb3BzIC0gQlVHOiAwIFsjMV0gUFJFRU1QVCBT
TVANCkNQVTogMCBQSUQ6IDU5MjkgVGFpbnRlZDogRyBTICAgVyAgIDUuNC45Ni1hcm02NC1kZXNr
dG9wICMxDQpwYyA6IF9fc2xhYl9mcmVlKzB4NWMvMHg0MjQNCmxyIDoga2ZyZWUrMHgzMGMvMHgz
MmMNCg0KQ2FsbCB0cmFjZToNCiBfX3NsYWJfZnJlZSsweDVjLzB4NDI0DQoga2ZyZWUrMHgzMGMv
MHgzMmMNCiB4aGNpX21lbV9jbGVhbnVwKzB4Mzk0LzB4M2NjDQogeGhjaV9tZW1faW5pdCsweDlh
Yy8weDEwNzANCiB4aGNpX2luaXQrMHg4Yy8weDFkMA0KIHhoY2lfcmVzdW1lKzB4MWNjLzB4NWZj
DQogeGhjaV9wbGF0X3Jlc3VtZSsweDY0LzB4NzANCiBwbGF0Zm9ybV9wbV90aGF3KzB4MjgvMHg2
MA0KIGRwbV9ydW5fY2FsbGJhY2srMHg1NC8weDI0Yw0KIGRldmljZV9yZXN1bWUrMHhkMC8weDIw
MA0KIGFzeW5jX3Jlc3VtZSsweDI0LzB4NjANCiBhc3luY19ydW5fZW50cnlfZm4rMHg0NC8weDEx
MA0KIHByb2Nlc3Nfb25lX3dvcmsrMHgxZjAvMHg0OTANCiB3b3JrZXJfdGhyZWFkKzB4NWMvMHg0
NTANCiBrdGhyZWFkKzB4MTU4LzB4MTYwDQogcmV0X2Zyb21fZm9yaysweDEwLzB4MjQNCg0KU2ln
bmVkLW9mZi1ieTogVGFvIFh1ZSA8eHVldGFvMDlAaHVhd2VpLmNvbT4NCi0tLQ0KIGRyaXZlcnMv
dXNiL2hvc3QveGhjaS1tZW0uYyB8IDEgKw0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvaG9zdC94aGNpLW1lbS5jIGIvZHJpdmVycy91
c2IvaG9zdC94aGNpLW1lbS5jIGluZGV4IGY2NjgxNWYuLmU0YjBjMDQgMTAwNjQ0DQotLS0gYS9k
cml2ZXJzL3VzYi9ob3N0L3hoY2ktbWVtLmMNCisrKyBiL2RyaXZlcnMvdXNiL2hvc3QveGhjaS1t
ZW0uYw0KQEAgLTE5MjQsNiArMTkyNCw3IEBAIHZvaWQgeGhjaV9tZW1fY2xlYW51cChzdHJ1Y3Qg
eGhjaV9oY2QgKnhoY2kpDQogCXhoY2ktPmh3X3BvcnRzID0gTlVMTDsNCiAJeGhjaS0+cmhfYncg
PSBOVUxMOw0KIAl4aGNpLT5leHRfY2FwcyA9IE5VTEw7DQorCXhoY2ktPnBvcnRfY2FwcyA9IE5V
TEw7DQogDQogCXhoY2ktPnBhZ2Vfc2l6ZSA9IDA7DQogCXhoY2ktPnBhZ2Vfc2hpZnQgPSAwOw0K
LS0NCjIuNy40DQoNCg==
