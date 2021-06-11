Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 752223A40CC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 13:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbhFKLKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 07:10:36 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:5507 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhFKLKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 07:10:32 -0400
Received: from nkgeml707-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G1dLC3dmlzZg9n;
        Fri, 11 Jun 2021 19:05:39 +0800 (CST)
Received: from nkgeml706-chm.china.huawei.com (10.98.57.153) by
 nkgeml707-chm.china.huawei.com (10.98.57.157) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 11 Jun 2021 19:08:30 +0800
Received: from nkgeml706-chm.china.huawei.com ([10.98.57.153]) by
 nkgeml706-chm.china.huawei.com ([10.98.57.153]) with mapi id 15.01.2176.012;
 Fri, 11 Jun 2021 19:08:30 +0800
From:   "Zhangjiantao (Kirin, nanjing)" <water.zhangjiantao@huawei.com>
To:     "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Xuetao (kirin)" <xuetao09@huawei.com>,
        "chenyu (U)" <chenyu56@huawei.com>,
        Caiyadong <caiyadong@huawei.com>,
        xuhaiyang <xuhaiyang5@hisilicon.com>,
        "Zhangjiantao (Kirin, nanjing)" <water.zhangjiantao@huawei.com>
Subject: [PATCH v2] xhci: solve a double free problem while doing s4
Thread-Topic: [PATCH v2] xhci: solve a double free problem while doing s4
Thread-Index: AQHXXqK7hImcHidT6ESyBJu1wIWDJKsOppkQ
Date:   Fri, 11 Jun 2021 11:08:30 +0000
Message-ID: <3f5f7a1a46a847ca8bb793050cf30b98@huawei.com>
References: <1623403104-121391-1-git-send-email-xuetao09@huawei.com>
In-Reply-To: <1623403104-121391-1-git-send-email-xuetao09@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.137.38.30]
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
bmVkLW9mZi1ieTogSmlhbnRhbyBaaGFuZyA8d2F0ZXIuemhhbmdqaWFudGFvQGh1YXdlaS5jb20+
DQpTaWduZWQtb2ZmLWJ5OiBUYW8gWHVlIDx4dWV0YW8wOUBodWF3ZWkuY29tPg0KLS0tDQogZHJp
dmVycy91c2IvaG9zdC94aGNpLW1lbS5jIHwgMSArDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktbWVtLmMgYi9kcml2
ZXJzL3VzYi9ob3N0L3hoY2ktbWVtLmMgaW5kZXggZjY2ODE1Zi4uZTRiMGMwNCAxMDA2NDQNCi0t
LSBhL2RyaXZlcnMvdXNiL2hvc3QveGhjaS1tZW0uYw0KKysrIGIvZHJpdmVycy91c2IvaG9zdC94
aGNpLW1lbS5jDQpAQCAtMTkyNCw2ICsxOTI0LDcgQEAgdm9pZCB4aGNpX21lbV9jbGVhbnVwKHN0
cnVjdCB4aGNpX2hjZCAqeGhjaSkNCiAJeGhjaS0+aHdfcG9ydHMgPSBOVUxMOw0KIAl4aGNpLT5y
aF9idyA9IE5VTEw7DQogCXhoY2ktPmV4dF9jYXBzID0gTlVMTDsNCisJeGhjaS0+cG9ydF9jYXBz
ID0gTlVMTDsNCiANCiAJeGhjaS0+cGFnZV9zaXplID0gMDsNCiAJeGhjaS0+cGFnZV9zaGlmdCA9
IDA7DQotLQ0KMi43LjQNCg0K
