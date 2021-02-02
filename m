Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D982530BA39
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 09:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbhBBIsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 03:48:05 -0500
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net ([206.189.21.223]:47814
        "HELO zg8tmja2lje4os4yms4ymjma.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S229975AbhBBIsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 03:48:03 -0500
Received: from daizhiyuan$phytium.com.cn ( [202.43.158.76] ) by
 ajax-webmail-c1app2 (Coremail) ; Tue, 2 Feb 2021 16:46:47 +0800 (GMT+08:00)
X-Originating-IP: [202.43.158.76]
Date:   Tue, 2 Feb 2021 16:46:47 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?5oi05b+X6L+c?= <daizhiyuan@phytium.com.cn>
To:     "Miaohe Lin" <linmiaohe@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mike.kravetz@oracle.com, akpm@linux-foundation.org
Subject: Re: Re: mm/hugetlb.c: Fix typos in comments
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20201102(b8f77813)
 Copyright (c) 2002-2021 www.mailtech.cn icmhosting
In-Reply-To: <e6d087ef-53c4-a38f-9664-3dd16b573c02@huawei.com>
References: <1612254842-6894-1-git-send-email-daizhiyuan@phytium.com.cn>
 <e6d087ef-53c4-a38f-9664-3dd16b573c02@huawei.com>
Content-Transfer-Encoding: base64
X-CM-CTRLDATA: jOE12WZvb3Rlcl90eHQ9MTEyODoxMA==
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <b6febbe.164f5.17761ec3cb5.Coremail.daizhiyuan@phytium.com.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AgINCgA3jip4ERlg+BOsAQ--.1266W
X-CM-SenderInfo: hgdl6xpl1xt0o6sk53xlxphulrpou0/1tbiDAEtaF7uIfjy5gABs0
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29ycnkuCgoKPiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tCj4g5Y+R5Lu25Lq6OiAiTWlhb2hlIExp
biIgPGxpbm1pYW9oZUBodWF3ZWkuY29tPgo+IOWPkemAgeaXtumXtDogMjAyMS0wMi0wMiAxNjoz
NzoyMCAo5pif5pyf5LqMKQo+IOaUtuS7tuS6ujogIlpoaXl1YW4gRGFpIiA8ZGFpemhpeXVhbkBw
aHl0aXVtLmNvbS5jbj4KPiDmioTpgIE6IGxpbnV4LW1tQGt2YWNrLm9yZywgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZywgbWlrZS5rcmF2ZXR6QG9yYWNsZS5jb20sIGFrcG1AbGludXgtZm91
bmRhdGlvbi5vcmcKPiDkuLvpopg6IFJlOiBtbS9odWdldGxiLmM6IEZpeCB0eXBvcyBpbiBjb21t
ZW50cwo+IAo+IE9uIDIwMjEvMi8yIDE2OjM0LCBaaGl5dWFuIERhaSB3cm90ZToKPiA+IFNpZ25l
ZC1vZmYtYnk6IFpoaXl1YW4gRGFpIDxkYWl6aGl5dWFuQHBoeXRpdW0uY29tLmNuPgo+IAo+IE5v
IHBhdGNoIGRlc2NyaXB0aW9uID8KPiAKPiA+IC0tLQo+ID4gIG1tL2h1Z2V0bGIuYyB8IDIgKy0K
PiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPiA+IAo+
ID4gZGlmZiAtLWdpdCBhL21tL2h1Z2V0bGIuYyBiL21tL2h1Z2V0bGIuYwo+ID4gaW5kZXggMThm
NmVlMy4uMzVkYjM4NiAxMDA2NDQKPiA+IC0tLSBhL21tL2h1Z2V0bGIuYwo+ID4gKysrIGIvbW0v
aHVnZXRsYi5jCj4gPiBAQCAtMzk5MCw3ICszOTkwLDcgQEAgdm9pZCB1bm1hcF9odWdlcGFnZV9y
YW5nZShzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSwgdW5zaWduZWQgbG9uZyBzdGFydCwKPiA+
ICAKPiA+ICAvKgo+ID4gICAqIFRoaXMgaXMgY2FsbGVkIHdoZW4gdGhlIG9yaWdpbmFsIG1hcHBl
ciBpcyBmYWlsaW5nIHRvIENPVyBhIE1BUF9QUklWQVRFCj4gPiAtICogbWFwcHBpbmcgaXQgb3du
cyB0aGUgcmVzZXJ2ZSBwYWdlIGZvci4gVGhlIGludGVudGlvbiBpcyB0byB1bm1hcCB0aGUgcGFn
ZQo+ID4gKyAqIG1hcHBpbmcgaXQgb3ducyB0aGUgcmVzZXJ2ZSBwYWdlIGZvci4gVGhlIGludGVu
dGlvbiBpcyB0byB1bm1hcCB0aGUgcGFnZQo+ID4gICAqIGZyb20gb3RoZXIgVk1BcyBhbmQgbGV0
IHRoZSBjaGlsZHJlbiBiZSBTSUdLSUxMZWQgaWYgdGhleSBhcmUgZmF1bHRpbmcgdGhlCj4gPiAg
ICogc2FtZSByZWdpb24uCj4gPiAgICovCj4gPiAKDQoNCg0KDQoNCg==
