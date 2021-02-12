Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4BD5319C9E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 11:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbhBLK0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 05:26:30 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:4628 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhBLK00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 05:26:26 -0500
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4DcV3Y01ryzY7vm;
        Fri, 12 Feb 2021 18:24:25 +0800 (CST)
Received: from dggemi759-chm.china.huawei.com (10.1.198.145) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Fri, 12 Feb 2021 18:25:42 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi759-chm.china.huawei.com (10.1.198.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Fri, 12 Feb 2021 18:25:42 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.006;
 Fri, 12 Feb 2021 18:25:42 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Arnd Bergmann <arnd@kernel.org>
CC:     Grygorii Strashko <grygorii.strashko@ti.com>,
        luojiaxing <luojiaxing@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Andy Shevchenko" <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        "open list:GPIO SUBSYSTEM <linux-gpio@vger.kernel.org>,
        linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: RE: [Linuxarm] Re: [PATCH for next v1 1/2] gpio: omap: Replace
 raw_spin_lock_irqsave with raw_spin_lock in omap_gpio_irq_handler()
Thread-Topic: [Linuxarm] Re: [PATCH for next v1 1/2] gpio: omap: Replace
 raw_spin_lock_irqsave with raw_spin_lock in omap_gpio_irq_handler()
Thread-Index: AQHXASPSlQt84o9SE0i+o14ylEf4e6pUTNzA
Date:   Fri, 12 Feb 2021 10:25:42 +0000
Message-ID: <76fcbf8fb4f74d39b68e7cdb52636db1@hisilicon.com>
References: <1612774577-55943-1-git-send-email-luojiaxing@huawei.com>
 <1612774577-55943-2-git-send-email-luojiaxing@huawei.com>
 <fab1e871-08e4-fc71-9dbf-9bcacf18e2e1@ti.com>
 <CAK8P3a0m4ocfLyJZ5wMxyKESYUJ5um5sb5MyAzC8ckCb6qAH5g@mail.gmail.com>
 <d5465b81-bb53-49ee-a556-40d208deb765@ti.com>
 <a61ef337fd1c4538a47fe855920f95d3@hisilicon.com>
 <CAK8P3a3SHQNjF5ZpqHQweG7BQ52Xi1hQKDiMVKq4aNK_7VDw6w@mail.gmail.com>
In-Reply-To: <CAK8P3a3SHQNjF5ZpqHQweG7BQ52Xi1hQKDiMVKq4aNK_7VDw6w@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.201.31]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQXJuZCBCZXJnbWFubiBb
bWFpbHRvOmFybmRAa2VybmVsLm9yZ10NCj4gU2VudDogRnJpZGF5LCBGZWJydWFyeSAxMiwgMjAy
MSAxMDo0NSBQTQ0KPiBUbzogU29uZyBCYW8gSHVhIChCYXJyeSBTb25nKSA8c29uZy5iYW8uaHVh
QGhpc2lsaWNvbi5jb20+DQo+IENjOiBHcnlnb3JpaSBTdHJhc2hrbyA8Z3J5Z29yaWkuc3RyYXNo
a29AdGkuY29tPjsgbHVvamlheGluZw0KPiA8bHVvamlheGluZ0BodWF3ZWkuY29tPjsgTGludXMg
V2FsbGVpaiA8bGludXMud2FsbGVpakBsaW5hcm8ub3JnPjsgQW5keQ0KPiBTaGV2Y2hlbmtvIDxh
bmR5LnNoZXZjaGVua29AZ21haWwuY29tPjsgQW5keSBTaGV2Y2hlbmtvDQo+IDxhbmRyaXkuc2hl
dmNoZW5rb0BsaW51eC5pbnRlbC5jb20+OyBTYW50b3NoIFNoaWxpbWthciA8c3NhbnRvc2hAa2Vy
bmVsLm9yZz47DQo+IEtldmluIEhpbG1hbiA8a2hpbG1hbkBrZXJuZWwub3JnPjsgb3BlbiBsaXN0
OkdQSU8gU1VCU1lTVEVNDQo+IDxsaW51eC1ncGlvQHZnZXIua2VybmVsLm9yZz4sIGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBs
aW51eGFybUBvcGVuZXVsZXIub3JnDQo+IFN1YmplY3Q6IFJlOiBbTGludXhhcm1dIFJlOiBbUEFU
Q0ggZm9yIG5leHQgdjEgMS8yXSBncGlvOiBvbWFwOiBSZXBsYWNlDQo+IHJhd19zcGluX2xvY2tf
aXJxc2F2ZSB3aXRoIHJhd19zcGluX2xvY2sgaW4gb21hcF9ncGlvX2lycV9oYW5kbGVyKCkNCj4g
DQo+IE9uIEZyaSwgRmViIDEyLCAyMDIxIGF0IDY6MDUgQU0gU29uZyBCYW8gSHVhIChCYXJyeSBT
b25nKQ0KPiA8c29uZy5iYW8uaHVhQGhpc2lsaWNvbi5jb20+IHdyb3RlOg0KPiA+ID4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gDQo+ID4gPg0KPiA+ID4gTm90ZS4gdGhlcmUgaXMgYWxz
byBnZW5lcmljX2hhbmRsZV9pcnEoKSBjYWxsIGluc2lkZS4NCj4gPg0KPiA+IFNvIGdlbmVyaWNf
aGFuZGxlX2lycSgpIGlzIG5vdCBzYWZlIHRvIHJ1biBpbiB0aHJlYWQgdGh1cyByZXF1aXJlcw0K
PiA+IGFuIGludGVycnVwdC1kaXNhYmxlZCBlbnZpcm9ubWVudCB0byBydW4/IElmIHNvLCBJJ2Qg
cmF0aGVyIHRoaXMNCj4gPiBpcnFzYXZlIG1vdmVkIGludG8gZ2VuZXJpY19oYW5kbGVfaXJxKCkg
cmF0aGVyIHRoYW4gYXNraW5nIGV2ZXJ5b25lDQo+ID4gY2FsbGluZyBpdCB0byBkbyBpcnFzYXZl
Lg0KPiANCj4gSW4gYSBwcmVlbXB0LXJ0IGtlcm5lbCwgaW50ZXJydXB0cyBhcmUgcnVuIGluIHRh
c2sgY29udGV4dCwgc28gdGhleSBjbGVhcmx5DQo+IHNob3VsZCBub3QgYmUgY2FsbGVkIHdpdGgg
aW50ZXJydXB0cyBkaXNhYmxlZCwgdGhhdCB3b3VsZCBkZWZlYXQgdGhlDQo+IHB1cnBvc2Ugb2Yg
bWFraW5nIHRoZW0gcHJlZW1wdGlibGUuDQoNClllcy4gU291bmRzIHNlbnNpYmxlLiBJcnFzYXZl
IGluIGdlbmVyaWNfaGFuZGxlX2lycSgpIHdpbGwgZGVmZWF0DQp0aGUgcHVycG9zZSBvZiBSVC4N
Cg0KPiANCj4gZ2VuZXJpY19oYW5kbGVfaXJxKCkgZG9lcyBuZWVkIHRvIHJ1biB3aXRoIGluX2ly
cSgpPT10cnVlIHRob3VnaCwNCj4gYnV0IHRoaXMgc2hvdWxkIGJlIHNldCBieSB0aGUgY2FsbGVy
IG9mIHRoZSBncGlvY2hpcCdzIGhhbmRsZXIsIGFuZA0KPiBpdCBpcyBub3Qgc2V0IGJ5IHJhd19z
cGluX2xvY2tfaXJxc2F2ZSgpLg0KPiANCg0KU28gc291bmRzIGxpa2UgdGhpcyBpc3N1ZSBvZiBp
bl9pcnEoKT10cnVlIGlzIHN0aWxsIGlycmVsZXZhbnQgd2l0aA0KdGhpcyBwYXRjaC4NCg0KSSBn
dWVzcyB0aGlzIHNob3VsZCBoYXZlIGJlZW4gc2V0IGJ5IHRoZSBjYWxsZXIgb2YgdGhlIGdwaW9j
aGlwJ3MNCmhhbmRsZXIgc29tZXdoZXJlLCBvdGhlcndpc2UsIGdwaW9jaGlwJ3MgaXJxIGhhbmRs
ZXIgd29uJ3QgYmUgYWJsZQ0KdG8gYmUgdGhyZWFkZWQuIEhhcyBpdCBiZWVuIHNldCBzb21ld2hl
cmU/DQoNCj4gICAgICAgIEFybmQNCg0KVGhhbmtzDQpCYXJyeQ0K
