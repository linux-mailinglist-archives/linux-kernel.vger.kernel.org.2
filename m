Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55EBD31996B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 06:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhBLFGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 00:06:38 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:2836 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbhBLFGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 00:06:35 -0500
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4DcLxK6fbCz13svH;
        Fri, 12 Feb 2021 13:03:33 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Fri, 12 Feb 2021 13:05:52 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi761-chm.china.huawei.com (10.1.198.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Fri, 12 Feb 2021 13:05:51 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.006;
 Fri, 12 Feb 2021 13:05:51 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Arnd Bergmann <arnd@kernel.org>
CC:     luojiaxing <luojiaxing@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        "open list:GPIO SUBSYSTEM <linux-gpio@vger.kernel.org>,
        linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: RE: [Linuxarm]  Re: [PATCH for next v1 1/2] gpio: omap: Replace
 raw_spin_lock_irqsave with raw_spin_lock in omap_gpio_irq_handler()
Thread-Topic: [Linuxarm]  Re: [PATCH for next v1 1/2] gpio: omap: Replace
 raw_spin_lock_irqsave with raw_spin_lock in omap_gpio_irq_handler()
Thread-Index: AQHXAKHhsnGPZbS2Vke5X41yG/e2eapS08GAgAAKhoCAARbAkA==
Date:   Fri, 12 Feb 2021 05:05:51 +0000
Message-ID: <a61ef337fd1c4538a47fe855920f95d3@hisilicon.com>
References: <1612774577-55943-1-git-send-email-luojiaxing@huawei.com>
 <1612774577-55943-2-git-send-email-luojiaxing@huawei.com>
 <fab1e871-08e4-fc71-9dbf-9bcacf18e2e1@ti.com>
 <CAK8P3a0m4ocfLyJZ5wMxyKESYUJ5um5sb5MyAzC8ckCb6qAH5g@mail.gmail.com>
 <d5465b81-bb53-49ee-a556-40d208deb765@ti.com>
In-Reply-To: <d5465b81-bb53-49ee-a556-40d208deb765@ti.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.201.224]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3J5Z29yaWkgU3RyYXNo
a28gW21haWx0bzpncnlnb3JpaS5zdHJhc2hrb0B0aS5jb21dDQo+IFNlbnQ6IEZyaWRheSwgRmVi
cnVhcnkgMTIsIDIwMjEgOToxNyBBTQ0KPiBUbzogQXJuZCBCZXJnbWFubiA8YXJuZEBrZXJuZWwu
b3JnPg0KPiBDYzogbHVvamlheGluZyA8bHVvamlheGluZ0BodWF3ZWkuY29tPjsgTGludXMgV2Fs
bGVpag0KPiA8bGludXMud2FsbGVpakBsaW5hcm8ub3JnPjsgQW5keSBTaGV2Y2hlbmtvIDxhbmR5
LnNoZXZjaGVua29AZ21haWwuY29tPjsgQW5keQ0KPiBTaGV2Y2hlbmtvIDxhbmRyaXkuc2hldmNo
ZW5rb0BsaW51eC5pbnRlbC5jb20+OyBTYW50b3NoIFNoaWxpbWthcg0KPiA8c3NhbnRvc2hAa2Vy
bmVsLm9yZz47IEtldmluIEhpbG1hbiA8a2hpbG1hbkBrZXJuZWwub3JnPjsgb3BlbiBsaXN0OkdQ
SU8NCj4gU1VCU1lTVEVNIDxsaW51eC1ncGlvQHZnZXIua2VybmVsLm9yZz4sIGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmcNCj4gPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBsaW51
eGFybUBvcGVuZXVsZXIub3JnDQo+IFN1YmplY3Q6IFtMaW51eGFybV0gUmU6IFtQQVRDSCBmb3Ig
bmV4dCB2MSAxLzJdIGdwaW86IG9tYXA6IFJlcGxhY2UNCj4gcmF3X3NwaW5fbG9ja19pcnFzYXZl
IHdpdGggcmF3X3NwaW5fbG9jayBpbiBvbWFwX2dwaW9faXJxX2hhbmRsZXIoKQ0KPiANCj4gDQo+
IA0KPiBPbiAxMS8wMi8yMDIxIDIxOjM5LCBBcm5kIEJlcmdtYW5uIHdyb3RlOg0KPiA+IE9uIFRo
dSwgRmViIDExLCAyMDIxIGF0IDc6MjUgUE0gR3J5Z29yaWkgU3RyYXNoa28NCj4gPiA8Z3J5Z29y
aWkuc3RyYXNoa29AdGkuY29tPiB3cm90ZToNCj4gPj4gT24gMDgvMDIvMjAyMSAxMDo1NiwgTHVv
IEppYXhpbmcgd3JvdGU6DQo+ID4+PiBUaGVyZSBpcyBubyBuZWVkIHRvIHVzZSBBUEkgd2l0aCBf
aXJxc2F2ZSBpbiBvbWFwX2dwaW9faXJxX2hhbmRsZXIoKSwNCj4gPj4+IGJlY2F1c2UgaXQgYWxy
ZWFkeSBiZSBpbiBhIGlycS1kaXNhYmxlZCBjb250ZXh0Lg0KPiA+Pg0KPiA+PiBOQUNLLg0KPiA+
PiBXaG8gc2FpZCB0aGF0IHRoaXMgaXMgYWx3YXlzIGhhcmQgSVJRIGhhbmRsZXI/DQo+ID4+IFdo
YXQgYWJvdXQgUlQta2VybmVsIG9yIGJvb3Qgd2l0aCAidGhyZWFkaXJxcyI/DQo+ID4NCj4gPiBJ
biB0aG9zZSBjYXNlcywgdGhlIGludGVycnVwdCBoYW5kbGVyIGlzIGp1c3QgYSBub3JtYWwgdGhy
ZWFkLCBzbyB0aGUNCj4gPiBwcmVlbXB0X2Rpc2FibGUoKSB0aGF0IGlzIGltcGxpZWQgYnkgcmF3
X3NwaW5fbG9jaygpIGlzIHN1ZmZpY2llbnQuDQo+ID4NCj4gPiBEaXNhYmxpbmcgaW50ZXJydXB0
cyBpbnNpZGUgb2YgYW4gaW50ZXJydXB0IGhhbmRsZXIgaXMgYWx3YXlzIGluY29ycmVjdCwNCj4g
PiB0aGUgcGF0Y2ggbG9va3MgbGlrZSBhIHVzZWZ1bCBjbGVhbnVwIHRvIG1lLCBpZiBvbmx5IGZv
ciByZWFkYWJpbGl0eS4NCj4gDQo+IE5vdGUuIHRoZXJlIGlzIGFsc28gZ2VuZXJpY19oYW5kbGVf
aXJxKCkgY2FsbCBpbnNpZGUuDQoNClNvIGdlbmVyaWNfaGFuZGxlX2lycSgpIGlzIG5vdCBzYWZl
IHRvIHJ1biBpbiB0aHJlYWQgdGh1cyByZXF1aXJlcw0KYW4gaW50ZXJydXB0LWRpc2FibGVkIGVu
dmlyb25tZW50IHRvIHJ1bj8gSWYgc28sIEknZCByYXRoZXIgdGhpcw0KaXJxc2F2ZSBtb3ZlZCBp
bnRvIGdlbmVyaWNfaGFuZGxlX2lycSgpIHJhdGhlciB0aGFuIGFza2luZyBldmVyeW9uZQ0KY2Fs
bGluZyBpdCB0byBkbyBpcnFzYXZlLg0KDQpPbiB0aGUgb3RoZXIgaGFuZCwgdGhlIGF1dGhvciBj
aGFuZ2VkIGEgY291cGxlIG9mIHNwaW5fbG9ja19pcnFzYXZlDQp0byBzcGluX2xvY2ssIGlmIG9u
bHkgdGhpcyBvbmUgaXMgaW5jb3JyZWN0LCBpdCBzZWVtcyBpdCBpcyB3b3J0aCBhDQpuZXcgdmVy
c2lvbiB0byBmaXggdGhpcy4NCg0KPiANCj4gLS0NCj4gQmVzdCByZWdhcmRzLA0KPiBncnlnb3Jp
aQ0KDQpUaGFua3MNCkJhcnJ5DQoNCg==
