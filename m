Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 402913375EC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 15:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbhCKOlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 09:41:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233696AbhCKOky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 09:40:54 -0500
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 52604C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 06:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        In-Reply-To:References:Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID; bh=BQUZr1NNc3aZQCH3ayXAKXSiocMLJfplwoFX
        DEUJk7U=; b=Ao7CRMZPa5Gre+ipcM1iAtVI6L6w+rD0yxb1RAzbkbBaUiXeqfKz
        A6cCSJxCEwEJzTHXJtk1+8K8lJYfB1V1tu5zhLFJF7XJ9xU0R5AThtbj4h7mE8DM
        Ge5rbcMbDSJqAyP/m2C04RqARpvhWDXeOO0rT4zYc/0SnsbBd+DTS4Y=
Received: by ajax-webmail-newmailweb.ustc.edu.cn (Coremail) ; Thu, 11 Mar
 2021 22:40:33 +0800 (GMT+08:00)
X-Originating-IP: [202.79.170.108]
Date:   Thu, 11 Mar 2021 22:40:33 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   lyl2019@mail.ustc.edu.cn
To:     "Luis Chamberlain" <mcgrof@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Re: Re: [PATCH] lib/test_kmod: Fix a use after free in
 register_test_dev_kmod
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT3.0.8 dev build
 20190610(cb3344cf) Copyright (c) 2002-2021 www.mailtech.cn ustc-xl
In-Reply-To: <20210311135833.GT4332@42.do-not-panic.com>
References: <20210311080246.11635-1-lyl2019@mail.ustc.edu.cn>
 <20210311130108.GS4332@42.do-not-panic.com>
 <17bb31cd.cc46.178217c9344.Coremail.lyl2019@mail.ustc.edu.cn>
 <20210311135833.GT4332@42.do-not-panic.com>
X-SendMailWithSms: false
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <7c27e8b5.cf02.17821bb6891.Coremail.lyl2019@mail.ustc.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: LkAmygC3uhrhK0pg5wQNAA--.2W
X-CM-SenderInfo: ho1ojiyrz6zt1loo32lwfovvfxof0/1tbiAQsRBlQhn5AamQAAsk
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCg0KPiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tDQo+IOWPkeS7tuS6ujogIkx1aXMgQ2hhbWJl
cmxhaW4iIDxtY2dyb2ZAa2VybmVsLm9yZz4NCj4g5Y+R6YCB5pe26Ze0OiAyMDIxLTAzLTExIDIx
OjU4OjMzICjmmJ/mnJ/lm5spDQo+IOaUtuS7tuS6ujogbHlsMjAxOUBtYWlsLnVzdGMuZWR1LmNu
DQo+IOaKhOmAgTogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiDkuLvpopg6IFJlOiBS
ZTogW1BBVENIXSBsaWIvdGVzdF9rbW9kOiBGaXggYSB1c2UgYWZ0ZXIgZnJlZSBpbiByZWdpc3Rl
cl90ZXN0X2Rldl9rbW9kDQo+IA0KPiBPbiBUaHUsIE1hciAxMSwgMjAyMSBhdCAwOTozMTo1NVBN
ICswODAwLCBseWwyMDE5QG1haWwudXN0Yy5lZHUuY24gd3JvdGU6DQo+ID4gDQo+ID4gDQo+ID4g
DQo+ID4gPiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tDQo+ID4gPiDlj5Hku7bkuro6ICJMdWlzIENo
YW1iZXJsYWluIiA8bWNncm9mQGtlcm5lbC5vcmc+DQo+ID4gPiDlj5HpgIHml7bpl7Q6IDIwMjEt
MDMtMTEgMjE6MDE6MDggKOaYn+acn+WbmykNCj4gPiA+IOaUtuS7tuS6ujogIkx2IFl1bmxvbmci
IDxseWwyMDE5QG1haWwudXN0Yy5lZHUuY24+DQo+ID4gPiDmioTpgIE6IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmcNCj4gPiA+IOS4u+mimDogUmU6IFtQQVRDSF0gbGliL3Rlc3Rfa21vZDog
Rml4IGEgdXNlIGFmdGVyIGZyZWUgaW4gcmVnaXN0ZXJfdGVzdF9kZXZfa21vZA0KPiA+ID4gDQo+
ID4gPiBPbiBUaHUsIE1hciAxMSwgMjAyMSBhdCAxMjowMjo0NkFNIC0wODAwLCBMdiBZdW5sb25n
IHdyb3RlOg0KPiA+ID4gPiBJbiByZWdpc3Rlcl90ZXN0X2Rldl9rbW9kLCBpdCBjYWxscyBmcmVl
X3Rlc3RfZGV2X2ttb2QoKSB0byBmcmVlDQo+ID4gPiA+IHRlc3RfZGV2LiBCdXQgZnJlZV90ZXN0
X2Rldl9rbW9kKCkgY2FuJ3Qgc2V0IHRoZSBvcmlnaW5hbCBwb2ludGVyDQo+ID4gPiA+IHRlc3Rf
ZGV2IHRvIE5VTEwsIGJlY2F1c2UgdGhlIHRlc3RfZGV2IHdhcyBwYXNzZWQgYnkgaXQncyB2YWx1
ZQ0KPiA+ID4gPiBub3QgcmVmZXJlbmNlLg0KPiA+ID4gDQo+ID4gPiBEaWQgeW91IGFjdHVhbGx5
IGdldCBhIGNyYXNoIG9yIHNvbWV0aGluZz8gSWYgc28gY2FuIHlvdSBzdXBwbHkgdGhlDQo+ID4g
PiBhY3R1YWwgbG9nPyBJZiB0aGlzIGlzIGp1c3QgYW4gb2JzZXJ2YXRpb24gYW5kIHlvdSB0aGlu
ayB0aGlzIGlzIGFuDQo+ID4gPiBpc3N1ZSwgc3BlY2lmeWluZyB0aGF0IHdvdWxkIGhlbHAgZHVy
aW5nIHBhdGNoIHJldmlldy4NCj4gPiA+IA0KPiA+ID4gICBMdWlzDQo+ID4gPiANCj4gPiA+ID4g
U2lnbmVkLW9mZi1ieTogTHYgWXVubG9uZyA8bHlsMjAxOUBtYWlsLnVzdGMuZWR1LmNuPg0KPiA+
ID4gPiAtLS0NCj4gPiA+ID4gIGxpYi90ZXN0X2ttb2QuYyB8IDIgKy0NCj4gPiA+ID4gIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+ID4gPiANCj4gPiA+
ID4gZGlmZiAtLWdpdCBhL2xpYi90ZXN0X2ttb2QuYyBiL2xpYi90ZXN0X2ttb2QuYw0KPiA+ID4g
PiBpbmRleCAzOGMyNTBmYmFjZTMuLmFhOGEyYTU2M2Q3ZSAxMDA2NDQNCj4gPiA+ID4gLS0tIGEv
bGliL3Rlc3Rfa21vZC5jDQo+ID4gPiA+ICsrKyBiL2xpYi90ZXN0X2ttb2QuYw0KPiA+ID4gPiBA
QCAtMTEyNCw3ICsxMTI0LDYgQEAgc3RhdGljIHZvaWQgZnJlZV90ZXN0X2Rldl9rbW9kKHN0cnVj
dCBrbW9kX3Rlc3RfZGV2aWNlICp0ZXN0X2RldikNCj4gPiA+ID4gIAkJZnJlZV90ZXN0X2Rldl9p
bmZvKHRlc3RfZGV2KTsNCj4gPiA+ID4gIAkJa21vZF9jb25maWdfZnJlZSh0ZXN0X2Rldik7DQo+
ID4gPiA+ICAJCXZmcmVlKHRlc3RfZGV2KTsNCj4gPiA+ID4gLQkJdGVzdF9kZXYgPSBOVUxMOw0K
PiA+ID4gPiAgCX0NCj4gPiA+ID4gIH0NCj4gPiA+ID4gIA0KPiA+ID4gPiBAQCAtMTE0OSw2ICsx
MTQ4LDcgQEAgc3RhdGljIHN0cnVjdCBrbW9kX3Rlc3RfZGV2aWNlICpyZWdpc3Rlcl90ZXN0X2Rl
dl9rbW9kKHZvaWQpDQo+ID4gPiA+ICAJaWYgKHJldCkgew0KPiA+ID4gPiAgCQlwcl9lcnIoImNv
dWxkIG5vdCByZWdpc3RlciBtaXNjIGRldmljZTogJWRcbiIsIHJldCk7DQo+ID4gPiA+ICAJCWZy
ZWVfdGVzdF9kZXZfa21vZCh0ZXN0X2Rldik7DQo+ID4gPiA+ICsJCXRlc3RfZGV2ID0gTlVMTDsN
Cj4gPiA+ID4gIAkJZ290byBvdXQ7DQo+ID4gPiA+ICAJfQ0KPiA+ID4gPiAgDQo+ID4gPiA+IC0t
IA0KPiA+ID4gPiAyLjI1LjENCj4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+IA0KPiA+IFRoaXMgcHJv
YmxlbSB3YXMgcmVwb3J0ZWQgYnkgc291cmNlIGNvZGUgYW5hbHl6ZXJzIGRldmVsb3BlZCBieSBv
dXIgU2VjdXJpdHkgTGFiKExvY2NzKS4NCj4gDQo+IFRoaXMgc2hvdWxkIGJlIGluY2x1ZGVkIGlu
IHRoZSBjb21taXQgbG9nLCBwbGVhc2UuDQo+IA0KPiA+IFdlIGhhdmUgY29uZmlybWVkIHRoaXMg
aXNzdWUgYmVmb3JlIHN1Ym1pdGluZyB0aGUgcGF0Y2guDQo+IA0KPiBIb3cgd2FzIHRoaXMgY29u
ZmlybWVkIGV4YWN0bHkuDQo+IA0KPiAgIEx1aXMNCg0KVGhhbmtzIGZvciB5b3VyIGFkdmljZS4N
Cg0KT2ssIGxldCdzIHNlZSB0aGUgZGV0YWlscy4gSW4gdGhlIGZ1bmN0aW9uIHRlc3Rfa21vZF9p
bml0KCksIGl0IGNhbGxzIHJlZ2lzdGVyX3Rlc3RfZGV2X2ttb2QoKQ0KdG8gcmV0dXJuIGEgdGVz
dF9kZXYuIEluc2lkZSB0aGUgY2FsbGVlIGZ1bmN0aW9uIHJlZ2lzdGVyX3Rlc3RfZGV2X2ttb2Qo
KSwgdGhlIHRlc3RfZGV2IGlzIA0KYWxsb2NhdGVkIGJ5IGFsbG9jX3Rlc3RfZGV2X2ttb2QoKSBh
bmQgZnJlZWQgYnkgZnJlZV90ZXN0X2Rldl9rbW9kKCkuIA0KDQpOb3RpY2UgdGhlIGltcGxlbWVu
dGF0aW9uIG9mIGZyZWVfdGVzdF9kZXZfa21vZCwgdGhlICd0ZXN0X2RldicgaW4gdGhpcyBmdW5j
dGlvbiBhY3R1YWxseSBpcw0KYSBuZXcgdmFyaWFibGUgaW4gdGhlIHBhcmFtZXRlcidzIHN0YWNr
IHNwYWNlLiBTZXQgdGhlIHZhbHVlIG9mICd0ZXN0X2RldicgaW5zaWRlIHRoaXMgZnVuY3Rpb24g
DQp3aWxsIG5vdCBhZmZlY3QgdGhlIG91dHNpZGUgJ3Rlc3RfZGV2Jy4NCiIiIg0Kc3RhdGljIHZv
aWQgZnJlZV90ZXN0X2Rldl9rbW9kKHN0cnVjdCBrbW9kX3Rlc3RfZGV2aWNlICp0ZXN0X2RldikN
CnsNCglpZiAodGVzdF9kZXYpIHsNCgkJa2ZyZWVfY29uc3QodGVzdF9kZXYtPm1pc2NfZGV2Lm5h
bWUpOw0KCQl0ZXN0X2Rldi0+bWlzY19kZXYubmFtZSA9IE5VTEw7DQoJCWZyZWVfdGVzdF9kZXZf
aW5mbyh0ZXN0X2Rldik7DQoJCWttb2RfY29uZmlnX2ZyZWUodGVzdF9kZXYpOw0KCQl2ZnJlZSh0
ZXN0X2Rldik7DQoJCXRlc3RfZGV2ID0gTlVMTDsNCgl9DQp9DQoiIiINCg0KU28sIHJlZ2lzdGVy
X3Rlc3RfZGV2X2ttb2QoKSB3aWxsIHJldHVybiBhIHZhbGlkIGFuZCBmcmVlZCB0ZXN0X2Rldiwg
YW5kIGNhdXNlIHVzZSBhZnRlciBmcmVlDQppbiBmdW5jdGlvbiB0ZXN0X2ttb2RfaW5pdCgpLg0K
IiIiDQpzdGF0aWMgaW50IF9faW5pdCB0ZXN0X2ttb2RfaW5pdCh2b2lkKQ0Kew0KCXRlc3RfZGV2
ID0gcmVnaXN0ZXJfdGVzdF9kZXZfa21vZCgpOw0KCWlmICghdGVzdF9kZXYpIHsgICAgICAgICAg
ICAgICAgICAgICAvLyBmcmVlZCBhbmQgdmFsaWQuDQoJCXByX2VycigiQ2Fubm90IGFkZCBmaXJz
dCB0ZXN0IGttb2QgZGV2aWNlXG4iKTsNCgkJcmV0dXJuIC1FTk9ERVY7DQoJfQ0KDQoJcmV0ID0g
dHJpZ2dlcl9jb25maWdfcnVuX3R5cGUodGVzdF9kZXYsICAvLyBjYXVzZSB1c2UgYWZ0ZXIgZnJl
ZSBoZXJlIQ0KCQkJCQkgICAgICBURVNUX0tNT0RfRFJJVkVSLCAidHVuIik7DQoiIiINCg0KSSB0
aGluayBpIHNob3VsZCB3cml0ZSBtb3JlIGRldGFpbHMgaW4gdGhlIGZpcnN0IGNvbW1pdCwgaSdt
IHNvcnJ5IGZvciB3YXN0aW5nIHlvdXIgdGltZS4NCg0KVGhhbmtzLg0KDQoNCg0KDQoNCg0K
