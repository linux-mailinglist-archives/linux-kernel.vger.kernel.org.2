Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC8E375EC9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 04:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbhEGCVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 22:21:42 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:26138 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229909AbhEGCVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 22:21:40 -0400
X-UUID: 0a79a3a97875496b8c0d78c39d727961-20210507
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=vf2dHNq2QpYWmKlMM1biVyh+zvhtSl8VMnhZIpqXEOk=;
        b=Tbh3ewNTW3pZTgTi18go2CqY4+0OW8VQ8tBHgTH3kJwDYIgU/GFC4a3lbu8xz97bEeOO/CYMp417NaPC4OhRAAGTf5SfTbqYRRSyAzqAzwmxZ7MJWwtjohHUhZbDHegZOUZcoHDDZWnF0DcXAYdPL5HKg87hPVE/Fbiz/2jlWFQ=;
X-UUID: 0a79a3a97875496b8c0d78c39d727961-20210507
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 286317022; Fri, 07 May 2021 10:20:39 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32N2.mediatek.inc
 (172.27.4.72) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 7 May
 2021 10:20:31 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 7 May 2021 10:20:30 +0800
Message-ID: <1620354030.10796.6.camel@mhfsdcap03>
Subject: Re: [PATCH] usb: fotg210-hcd: Fix an error message
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     <gregkh@linuxfoundation.org>, <shubhankarvk@gmail.com>,
        <lee.jones@linaro.org>, <gustavoars@kernel.org>,
        <vulab@iscas.ac.cn>, <john453@faraday-tech.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Date:   Fri, 7 May 2021 10:20:30 +0800
In-Reply-To: <94531bcff98e46d4f9c20183a90b7f47f699126c.1620333419.git.christophe.jaillet@wanadoo.fr>
References: <94531bcff98e46d4f9c20183a90b7f47f699126c.1620333419.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: BFA33764F29650E7F3F7B92C3AB705902216267BFAAC029DB2B872DB20E008D02000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIxLTA1LTA2IGF0IDIyOjM5ICswMjAwLCBDaHJpc3RvcGhlIEpBSUxMRVQgd3Jv
dGU6DQo+ICdyZXR2YWwnIGlzIGtub3duIHRvIGJlIC1FTk9ERVYgaGVyZS4NCj4gVGhpcyBpcyBh
IGhhcmQtY29kZWQgZGVmYXVsdCBlcnJvciBjb2RlIHdoaWNoIGlzIG5vdCB1c2VmdWwgaW4gdGhl
IGVycm9yDQo+IG1lc3NhZ2UuIE1vcmVvdmVyLCBhbm90aGVyIGVycm9yIG1lc3NhZ2UgaXMgcHJp
bnRlZCBhdCB0aGUgZW5kIG9mIHRoZQ0KPiBlcnJvciBoYW5kbGluZyBwYXRoLiBUaGUgY29ycmVz
cG9uZGluZyBlcnJvciBjb2RlICgtRU5PTUVNKSBpcyBtb3JlDQo+IGluZm9ybWF0aXZlLg0KPiAN
Cj4gU28gcmVtb3ZlIHNpbXBsaWZ5IHRoZSBmaXJzdCBlcnJvciBtZXNzYWdlLg0KPiANCj4gV2hp
bGUgYXQgaXQsIGFsc28gcmVtb3ZlIHRoZSB1c2VsZXNzIGluaXRpYWxpemF0aW9uIG9mICdyZXR2
YWwnLg0KPiANCj4gRml4ZXM6IDdkNTAxOTVmNmM1MCAoInVzYjogaG9zdDogRmFyYWRheSBmb3Rn
MjEwLWhjZCBkcml2ZXIiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGhlIEpBSUxMRVQgPGNo
cmlzdG9waGUuamFpbGxldEB3YW5hZG9vLmZyPg0KPiAtLS0NCj4gIGRyaXZlcnMvdXNiL2hvc3Qv
Zm90ZzIxMC1oY2QuYyB8IDQgKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9ob3N0L2Zv
dGcyMTAtaGNkLmMgYi9kcml2ZXJzL3VzYi9ob3N0L2ZvdGcyMTAtaGNkLmMNCj4gaW5kZXggNmNh
YzY0MjUyMGZjLi45YzJlZGEwOTE4ZTEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2hvc3Qv
Zm90ZzIxMC1oY2QuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9ob3N0L2ZvdGcyMTAtaGNkLmMNCj4g
QEAgLTU1NjgsNyArNTU2OCw3IEBAIHN0YXRpYyBpbnQgZm90ZzIxMF9oY2RfcHJvYmUoc3RydWN0
IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIAlzdHJ1Y3QgdXNiX2hjZCAqaGNkOw0KPiAgCXN0
cnVjdCByZXNvdXJjZSAqcmVzOw0KPiAgCWludCBpcnE7DQo+IC0JaW50IHJldHZhbCA9IC1FTk9E
RVY7DQo+ICsJaW50IHJldHZhbDsNCj4gIAlzdHJ1Y3QgZm90ZzIxMF9oY2QgKmZvdGcyMTA7DQo+
ICANCj4gIAlpZiAodXNiX2Rpc2FibGVkKCkpDQo+IEBAIC01NTg4LDcgKzU1ODgsNyBAQCBzdGF0
aWMgaW50IGZvdGcyMTBfaGNkX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+
ICAJaGNkID0gdXNiX2NyZWF0ZV9oY2QoJmZvdGcyMTBfZm90ZzIxMF9oY19kcml2ZXIsIGRldiwN
Cj4gIAkJCWRldl9uYW1lKGRldikpOw0KPiAgCWlmICghaGNkKSB7DQo+IC0JCWRldl9lcnIoZGV2
LCAiZmFpbGVkIHRvIGNyZWF0ZSBoY2Qgd2l0aCBlcnIgJWRcbiIsIHJldHZhbCk7DQo+ICsJCWRl
dl9lcnIoZGV2LCAiZmFpbGVkIHRvIGNyZWF0ZSBoY2RcbiIpOw0KPiAgCQlyZXR2YWwgPSAtRU5P
TUVNOw0KSG93IGFib3V0IG1vdmluZyB0aGlzIGxpbmUgYmVmb3JlIGRldl9lcnIoKT8gdGhlbiBj
b3VsZCBrZWVwIGVycm9yIGxvZw0KdW5jaGFuZ2VkLg0KDQo+ICAJCWdvdG8gZmFpbF9jcmVhdGVf
aGNkOw0KPiAgCX0NCg0K

