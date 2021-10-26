Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4F443B5E4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 17:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237151AbhJZPoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 11:44:20 -0400
Received: from smtpbg701.qq.com ([203.205.195.86]:59960 "EHLO
        smtpproxy21.qq.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237078AbhJZPns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 11:43:48 -0400
X-QQ-GoodBg: 1
X-QQ-SSF: B0400000000000F0
X-QQ-FEAT: Ut0pB98mtT8SKuSiSEUVnmSK2Is7AdsnLZeIFAIqwNjZnfqOEf0MYhXJwBGxa
        AWlE1UcBi/jwn8VmLbDKlSR5Zfio3O0orTz4lx0Gu5cdmh6DvnkcmekaluKyyGEpiOe+W76
        TmeDtjAAu57pmubAIcfP4k8Gl2J2LQwtCPZ+6+jhOBJmdGCLdl2cc70zCUpke1XVv8oDxvG
        TdfWBe+hyrczp9sL6NAbH5kD1cgbkuPJ5jv/m/OD75pGng4baTYG8LUVnYF7jlTTCOO58sK
        PD+30RyldnlMfSFPUo9HqEowXe0VEaADsxrA0526qkxUjON2jsHUVa7TV2yDh4n1yGzuili
        JO8XdG8EVE3H7vQzVT8eyzaoSxEjg==
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 58.19.91.105
X-QQ-STYLE: 
X-QQ-mid: logic531t1635262877t4121530
From:   "=?utf-8?B?5bi45buJ5b+X?=" <changlianzhi@uniontech.com>
To:     "=?utf-8?B?R3JlZyBLSA==?=" <gregkh@linuxfoundation.org>,
        "=?utf-8?B?QW5keSBTaGV2Y2hlbmtv?=" 
        <andriy.shevchenko@linux.intel.com>
Cc:     "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>,
        "=?utf-8?B?ZG1pdHJ5LnRvcm9raG92?=" <dmitry.torokhov@gmail.com>,
        "=?utf-8?B?amlyaXNsYWJ5?=" <jirislaby@kernel.org>,
        "=?utf-8?B?MjgyODI3OTYx?=" <282827961@qq.com>
Subject: Re: [PATCH v7] tty: Fix the keyboard led light display problem
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Date:   Tue, 26 Oct 2021 23:41:17 +0800
X-Priority: 3
Message-ID: <tencent_6F6E7845648EC1B76421AE7A@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20211026024032.15897-1-changlianzhi@uniontech.com>
        <YXgPZw3eluaaVvRc@smile.fi.intel.com>
        <YXgWbG30THLgS5zJ@kroah.com>
In-Reply-To: <YXgWbG30THLgS5zJ@kroah.com>
X-QQ-ReplyHash: 1789936889
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
        by smtp.qq.com (ESMTP) with SMTP
        id ; Tue, 26 Oct 2021 23:41:18 +0800 (CST)
Feedback-ID: logic:uniontech.com:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBPY3QgMjYsIDIwMjEgYXQgMDU6MjM6MzVQTSArMDMwMCwgQW5keSBTaGV2Y2hl
bmtvIHdyb3RlOg0KPiBPbiBUdWUsIE9jdCAyNiwgMjAyMSBhdCAxMDo0MDozMkFNICswODAw
LCBsaWFuemhpIGNoYW5nIHdyb3RlOg0KPiA+IFN3aXRjaGluZyBmcm9tIHRoZSBkZXNrdG9w
IGVudmlyb25tZW50IHRvIHRoZSB0dHkgZW52aXJvbm1lbnQsDQo+ID4gdGhlIHN0YXRlIG9m
IHRoZSBrZXlib2FyZCBsZWQgbGlnaHRzIGFuZCB0aGUgc3RhdGUgb2YgdGhlIGtleWJvYXJk
DQo+ID4gbG9jayBhcmUgaW5jb25zaXN0ZW50LiBUaGlzIGlzIGJlY2F1c2UgdGhlIGF0dHJp
YnV0ZSBrYi0+a2JkbW9kZQ0KPiA+IG9mIHRoZSB0dHkgYm91bmQgaW4gdGhlIGRlc2t0b3Ag
ZW52aXJvbm1lbnQgKHhvcmcpIGlzIHNldCB0bw0KPg0KPiBYb3JnDQo+DQo+IEkgdGhpbmsg
SSBhbHJlYWR5IHBvaW50ZWQgdGhhdCBvdXQuDQo+DQo+ID4gVkNfT0ZGLCB3aGljaCBjYXVz
ZXMgdGhlIGxlZHN0YXRlIGFuZCBrYi0+bGVkZmxhZ3N0YXRlDQo+ID4gdmFsdWVzIG9mIHRo
ZSBib3VuZCB0dHkgdG8gYWx3YXlzIGJlIDAsIHdoaWNoIGNhdXNlcyB0aGUgc3dpdGNoDQo+
ID4gZnJvbSB0aGUgZGVza3RvcCBXaGVuIHRvIHRoZSB0dHkgZW52aXJvbm1lbnQsIHRoZSBM
RUQgbGlnaHQNCj4gPiBzdGF0dXMgaXMgaW5jb25zaXN0ZW50IHdpdGggdGhlIGtleWJvYXJk
IGxvY2sgc3RhdHVzLg0KPg0KPiAuLi4NCj4NCj4gPiArc3RhdGljIHZvaWQga2JkX3VwZGF0
ZV9sZWRzdGF0ZShzdHJ1Y3QgaW5wdXRfZGV2ICpkZXYpDQo+ID4gK3sNCj4gPiArIGlmICgh
IXRlc3RfYml0KExFRF9OVU1MLCBkZXYtPmxlZCkgIT0NCj4gPiArICAgICAhIShsZWRzdGF0
ZSAmIEJJVChWQ19OVU1MT0NLKSkpDQo+ID4gKyBsZWRzdGF0ZSBePSBCSVQoVkNfTlVNTE9D
Syk7DQo+ID4gKyBpZiAoISF0ZXN0X2JpdChMRURfQ0FQU0wsIGRldi0+bGVkKSAhPQ0KPiA+
ICsgICAgICEhKGxlZHN0YXRlICYgQklUKFZDX0NBUFNMT0NLKSkpDQo+ID4gKyBsZWRzdGF0
ZSBePSBCSVQoVkNfQ0FQU0xPQ0spOw0KPiA+ICsgaWYgKCEhdGVzdF9iaXQoTEVEX1NDUk9M
TEwsIGRldi0+bGVkKSAhPQ0KPiA+ICsgICAgICEhKGxlZHN0YXRlICYgQklUKFZDX1NDUk9M
TE9DSykpKQ0KPiA+ICsgbGVkc3RhdGUgXj0gQklUKFZDX1NDUk9MTE9DSyk7DQo+DQo+IFRo
aXMgbG9va3MgdWdseS4NCg0KSSB0aGluayBpdCBjYW4gYmUgZG9uZSBsaWtlIHRoaXM6DQog
c3RhdGljIHZvaWQga2JkX3VwZGF0ZV9sZWRzdGF0ZShzdHJ1Y3QgaW5wdXRfZGV2ICpkZXYp
DQogew0KICAgIGxlZHN0YXRlID0gKHRlc3RfYml0KExFRF9TQ1JPTEwsZGV2LT5sZWQpIO+8
nzEg77yaMO+8iQ0KICAgICAgICAgfCAodGVzdF9iaXQoTEVEX05VTUwsZGV2LT5sZWQpIO+8
nzIg77yaMO+8iQ0KICAgICAgICAgfCAodGVzdF9iaXQoTEVEX0NBUFNMLGRldi0+bGVkKSDv
vJ8zIO+8mjDvvIkNCiB9DQoNCklmIHRoaXMgY2hhbmdlIGRvZXMgbm90IHdvcmssIHBsZWFz
ZSByZXBseSB0byBtZS4gSSBoYXZlIG5vdCANCnVuZGVyc3Rvb2QgdGhlIG90aGVyIGNvbnRl
bnQuIEl0IGlzIHRvbyBsYXRlIHRvZGF5LCBJIHdpbGwgY29udGludWUgdG9tb3Jyb3chDQoN
ClRoYW5rcy4NCi0tDQpsaWFuemhpIGNoYW5n



