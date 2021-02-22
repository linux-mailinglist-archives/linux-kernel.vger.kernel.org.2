Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF41A321BDB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 16:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbhBVPvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 10:51:18 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:2847 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbhBVPvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 10:51:16 -0500
Received: from DGGEML401-HUB.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4DkmmF6YVjz13x88;
        Mon, 22 Feb 2021 23:47:57 +0800 (CST)
Received: from DGGEML509-MBX.china.huawei.com ([169.254.1.252]) by
 DGGEML401-HUB.china.huawei.com ([fe80::89ed:853e:30a9:2a79%31]) with mapi id
 14.03.0509.000; Mon, 22 Feb 2021 23:50:19 +0800
From:   "chenjun (AM)" <chenjun102@huawei.com>
To:     "chenjun (AM)" <chenjun102@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "gregory.herrero@oracle.com" <gregory.herrero@oracle.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Xiangrui (Euler)" <rui.xiang@huawei.com>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXSByZWNvcmRtY291bnQ6IHVzZSB3OCB0byByZWFkIHJl?=
 =?gb2312?B?bHAtPnJfaW5mbyBpbiBhcm02NF9pc19mYWtlX21jb3VudA==?=
Thread-Topic: [PATCH] recordmcount: use w8 to read relp->r_info in
 arm64_is_fake_mcount
Thread-Index: AQHXCSa61U/7Tvwg9UGsa9lKYMYb/qpkUVCw
Date:   Mon, 22 Feb 2021 15:50:19 +0000
Message-ID: <CE1E7D7EFA066443B6454A6A5063B50220C5B320@dggeml509-mbx.china.huawei.com>
References: <20210222135840.56250-1-chenjun102@huawei.com>
In-Reply-To: <20210222135840.56250-1-chenjun102@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.178.53]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkNCg0KVGhlcmUgaXMgbm8gcHJvYmxlbSB3aGVuIEkgdXNlIGFhcmNoNjRfYmUoZ2NjIHYxMC4y
KS4gQmVjYXVzZSBnY2MgdjEwLjIgdXNlIF9fcGF0Y2hhYmxlX2Z1bmN0aW9uX2VudHJpZXMNCmlu
c3RlYWQgb2YgX19tY291bnQuIEkgYW0gbm90IHN1cmUgd2hlbiB0aGUgY2hhbmdlIGhhcHBlbmVk
Lg0KDQpSZWdhcmRzLA0KQ2hlbiBKdW4NCg0KLS0tLS3Tyrz+1K28/i0tLS0tDQq3orz+yMs6IENo
ZW4gSnVuIFttYWlsdG86Y2hlbmp1bjEwMkBodWF3ZWkuY29tXSANCreiy83KsbzkOiAyMDIxxOoy
1MIyMsjVIDIxOjU5DQrK1bz+yMs6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCrOty806
IGdyZWdvcnkuaGVycmVyb0BvcmFjbGUuY29tOyBjYXRhbGluLm1hcmluYXNAYXJtLmNvbTsgcm9z
dGVkdEBnb29kbWlzLm9yZzsgWGlhbmdydWkgKEV1bGVyKSA8cnVpLnhpYW5nQGh1YXdlaS5jb20+
DQrW98ziOiBbUEFUQ0hdIHJlY29yZG1jb3VudDogdXNlIHc4IHRvIHJlYWQgcmVscC0+cl9pbmZv
IGluIGFybTY0X2lzX2Zha2VfbWNvdW50DQoNCk9uIGxpdHRsZSBlbmRpYW4gc3lzdGVtLCBVc2Ug
YWFyY2g2NF9iZShnY2MgdjcuMykgZG93bmxvYWRlZCBmcm9tIGxpbmFyby5vcmcgdG8gYnVpbGQg
aW1hZ2Ugd2l0aCBDT05GSUdfQ1BVX0JJR19FTkRJQU4gPSB5LCBDT05GSUdfRlRSQUNFID0geSwg
Q09ORklHX0RZTkFNSUNfRlRSQUNFID0geS4NCg0KZ2NjIHdpbGwgY3JlYXRlIHN5bWJvbHMgb2Yg
X21jb3VudCBidXQgcmVjb3JkbWNvdW50IGNhbiBub3QgY3JlYXRlIG1jb3VudF9sb2MgZm9yICou
by4NCmFhcmNoNjRfYmUtbGludXgtZ251LW9iamR1bXAgLXIgZnMvbmFtZWkubyB8IGdyZXAgbWNv
dW50DQowMDAwMDAwMDAwMDAwMGQwIFJfQUFSQ0g2NF9DQUxMMjYgIF9tY291bnQgLi4uDQowMDAw
MDAwMDAwMDA3MTkwIFJfQUFSQ0g2NF9DQUxMMjYgIF9tY291bnQNCg0KVGhlIHJlYXNvbiBpcyB0
aGFuIGZ1bmNpdG9uIGFybTY0X2lzX2Zha2VfbWNvdW50IGNhbiBub3Qgd29yayBjb3JyZWN0bHku
DQpBIHN5bWJvbCBvZiBfbWNvdW50IGluICoubyBjb21waWxlZCB3aXRoIGJpZyBlbmRpYW4gY29t
cGlsZXIgbGlrZXM6DQowMCAwMCAwMCAyZCAwMCAwMCAwMSAxYg0KdyhycC0+cl9pbmZvKSB3aWxs
IHJldHVybiAweDJkIGluc3RlYWQgb2YgMHgwMTFiLiBCZWNhdXNlIHcoKSB0YWtlcyB1aW50MzJf
dCBhcyBwYXJhbWV0ZXIsIHdoaWNoIHRydW5jYXRlcyBycC0+cl9pbmZvLg0KDQpVc2UgdzgoKSBp
bnN0ZWFkIHcoKSB0byByZWFkIHJlbHAtPnJfaW5mbw0KDQpGaXhlczogZWEwZWFkYTQ1NjMyICgi
cmVjb3JkbWNvdW50OiBvbmx5IHJlY29yZCByZWxvY2F0aW9uIG9mIHR5cGUgUl9BQVJDSDY0X0NB
TEwyNiBvbiBhcm02NC4iKQ0KU2lnbmVkLW9mZi1ieTogQ2hlbiBKdW4gPGNoZW5qdW4xMDJAaHVh
d2VpLmNvbT4NCi0tLQ0KIHNjcmlwdHMvcmVjb3JkbWNvdW50LmMgfCAyICstDQogMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9zY3Jp
cHRzL3JlY29yZG1jb3VudC5jIGIvc2NyaXB0cy9yZWNvcmRtY291bnQuYyBpbmRleCBiOWMyZWU3
YWI0M2YuLmNjZTEyZTE5NzFkOCAxMDA2NDQNCi0tLSBhL3NjcmlwdHMvcmVjb3JkbWNvdW50LmMN
CisrKyBiL3NjcmlwdHMvcmVjb3JkbWNvdW50LmMNCkBAIC00MzgsNyArNDM4LDcgQEAgc3RhdGlj
IGludCBhcm1faXNfZmFrZV9tY291bnQoRWxmMzJfUmVsIGNvbnN0ICpycCkNCiANCiBzdGF0aWMg
aW50IGFybTY0X2lzX2Zha2VfbWNvdW50KEVsZjY0X1JlbCBjb25zdCAqcnApICB7DQotCXJldHVy
biBFTEY2NF9SX1RZUEUodyhycC0+cl9pbmZvKSkgIT0gUl9BQVJDSDY0X0NBTEwyNjsNCisJcmV0
dXJuIEVMRjY0X1JfVFlQRSh3OChycC0+cl9pbmZvKSkgIT0gUl9BQVJDSDY0X0NBTEwyNjsNCiB9
DQogDQogLyogNjQtYml0IEVNX01JUFMgaGFzIHdlaXJkIEVMRjY0X1JlbGEucl9pbmZvLg0KLS0N
CjIuMjUuMA0KDQo=
