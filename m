Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04B1236C837
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 17:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238000AbhD0PD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 11:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236710AbhD0PDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 11:03:23 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B343C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 08:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        In-Reply-To:References:Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID; bh=Gkvpw9k4C4R5WqtmSRQWaLtw2u/7sFE8mz9z
        xjVU/wU=; b=IKZ5BF2uZRMwJ5b/Cs3zoPS77fvlQdPpLcVPJNG4b+xkRKMmMZcD
        5dKAKuTx3CBMnHBg9dM3Mt+uxpgKSHtQbiRhJ50UbEQ/uSYeM2izcSwg3X5kv9ds
        SVM2MxXMUzyQhzO40iegM9ywpP/lM/IZ73vWrgOiwj0uOP5DhrLuZ5s=
Received: by ajax-webmail-newmailweb.ustc.edu.cn (Coremail) ; Tue, 27 Apr
 2021 23:02:24 +0800 (GMT+08:00)
X-Originating-IP: [202.38.69.14]
Date:   Tue, 27 Apr 2021 23:02:24 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   lyl2019@mail.ustc.edu.cn
To:     "Fabio Aiuto" <fabioaiuto83@gmail.com>
Cc:     rspringer@google.com, toddpoynor@google.com, benchan@chromium.org,
        rcy@google.com, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] Staging:gasket:core: Fix a double free in
 gasket_enable_device
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT3.0.8 dev build
 20190610(cb3344cf) Copyright (c) 2002-2021 www.mailtech.cn ustc-xl
In-Reply-To: <20210427142559.GD1399@agape.jhs>
References: <20210427141129.6207-1-lyl2019@mail.ustc.edu.cn>
 <20210427142559.GD1399@agape.jhs>
X-SendMailWithSms: false
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <36b65d1b.64610.17913da4e10.Coremail.lyl2019@mail.ustc.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: LkAmygCnrpaAJ4hgKgxUAA--.4W
X-CM-SenderInfo: ho1ojiyrz6zt1loo32lwfovvfxof0/1tbiAQsEBlQhn6cqjwAMss
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCg0KPiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tDQo+IOWPkeS7tuS6ujogIkZhYmlvIEFpdXRv
IiA8ZmFiaW9haXV0bzgzQGdtYWlsLmNvbT4NCj4g5Y+R6YCB5pe26Ze0OiAyMDIxLTA0LTI3IDIy
OjI2OjAwICjmmJ/mnJ/kuowpDQo+IOaUtuS7tuS6ujogIkx2IFl1bmxvbmciIDxseWwyMDE5QG1h
aWwudXN0Yy5lZHUuY24+DQo+IOaKhOmAgTogcnNwcmluZ2VyQGdvb2dsZS5jb20sIHRvZGRwb3lu
b3JAZ29vZ2xlLmNvbSwgYmVuY2hhbkBjaHJvbWl1bS5vcmcsIHJjeUBnb29nbGUuY29tLCBncmVn
a2hAbGludXhmb3VuZGF0aW9uLm9yZywgbGludXgtc3RhZ2luZ0BsaXN0cy5saW51eC5kZXYsIGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4g5Li76aKYOiBSZTogW1BBVENIXSBTdGFnaW5n
Omdhc2tldDpjb3JlOiBGaXggYSBkb3VibGUgZnJlZSBpbiBnYXNrZXRfZW5hYmxlX2RldmljZQ0K
PiANCj4gSGkgTHYsDQo+IA0KPiBJIGZlYXIgZ2Fza2V0IGlzIG5vIG1vcmUgb24gc3RhZ2luZyB0
cmVlLCBJIHRoaW5rIGl0J3Mgbm8gbW9yZSBvbg0KPiBrZXJuZWwuIFRyeSBmZXRjaCBhZ2FpbiBm
cm9tIHJlbW90ZS4NCj4gDQo+IE9uIFR1ZSwgQXByIDI3LCAyMDIxIGF0IDA3OjExOjI5QU0gLTA3
MDAsIEx2IFl1bmxvbmcgd3JvdGU6DQo+ID4gSW4gZ2Fza2V0X2VuYWJsZV9kZXZpY2UsIGl0IGNh
bGxzIGdhc2tldF9pbnRlcnJ1cHRfaW5pdCgpLg0KPiA+IEluc2lkZSBnYXNrZXRfaW50ZXJydXB0
X2luaXQsIGludGVycnVwdF9kYXRhIGlzIGFsbG9jYXRlZCB2aWENCj4gPiBremFsbG9jKCkgYW5k
IHRoZW4gaXMgYXNzaWduZWQgdG8gZ2Fza2V0X2Rldi0+aW50ZXJydXB0X2RhdGEuDQo+ID4gSWYg
dGhlIGxhdGVyIHR3byBremFsbG9jKCkgZmFpbGVkLCBpbnRlcnJ1cHRfZGF0YSB3aWxsIGJlIGZy
ZWVkDQo+ID4gYW5kIGdhc2tldF9kZXYtPmludGVycnVwdF9kYXRhIHdpbGwgcG9pbnQgdG8gYSBm
cmVlZCBtZW1vcnkuDQo+ID4gDQo+ID4gQWZ0ZXIgZ2Fza2V0X2VuYWJsZV9kZXZpY2UgcmVjZWl2
ZWQgdGhlIGVycm9yLCB0aGUgZnJlZWQNCj4gPiBnYXNrZXRfZGV2LT5pbnRlcnJ1cHRfZGF0YSBp
cyBmcmVlZCBhZ2FpbiBpbg0KPiA+IGdhc2tldF9pbnRlcnJ1cHRfY2xlYW51cChnYXNrZXRfZGV2
KS4NCj4gPiANCj4gPiBNeSBwYXRjaCBtb3ZlcyB0aGUgImdhc2tldF9kZXYtPmludGVycnVwdF9k
YXRhID0gaW50ZXJydXB0X2RhdGEiDQo+ID4gYXNzaWdubWVudCBiZWhpbmQgdGhlIGxhdGVyIGt6
YWxsb2MoKSBhbGwgc3VjY2Vzc2QsIHRvIGF2b2lkDQo+ID4gZ2Fza2V0X2Rldi0+aW50ZXJydXB0
X2RhdGEgcG9pbnRpbmcgdG8gYSBmcmVlZCBtZW1vcnkNCj4gPiANCj4gPiBGaXhlczogODA2NjYw
OTZlYjc4ZiAoInN0YWdpbmc6IGdhc2tldDogY29yZTogcmVtb3ZlIHN0YXRpYyBmdW5jdGlvbiBm
b3J3YXJkIGRlY2xhcmF0aW9ucyIpDQo+ID4gU2lnbmVkLW9mZi1ieTogTHYgWXVubG9uZyA8bHls
MjAxOUBtYWlsLnVzdGMuZWR1LmNuPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3N0YWdpbmcvZ2Fz
a2V0L2dhc2tldF9pbnRlcnJ1cHQuYyB8IDMgKystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9zdGFnaW5nL2dhc2tldC9nYXNrZXRfaW50ZXJydXB0LmMgYi9kcml2ZXJzL3N0YWdpbmcvZ2Fz
a2V0L2dhc2tldF9pbnRlcnJ1cHQuYw0KPiA+IGluZGV4IDg2NDM0MmFjZmQ4Ni4uZDQ5OTNkN2Fi
Yjg3IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvc3RhZ2luZy9nYXNrZXQvZ2Fza2V0X2ludGVy
cnVwdC5jDQo+ID4gKysrIGIvZHJpdmVycy9zdGFnaW5nL2dhc2tldC9nYXNrZXRfaW50ZXJydXB0
LmMNCj4gPiBAQCAtMzIyLDcgKzMyMiw2IEBAIGludCBnYXNrZXRfaW50ZXJydXB0X2luaXQoc3Ry
dWN0IGdhc2tldF9kZXYgKmdhc2tldF9kZXYpDQo+ID4gIAlpbnRlcnJ1cHRfZGF0YSA9IGt6YWxs
b2Moc2l6ZW9mKCppbnRlcnJ1cHRfZGF0YSksIEdGUF9LRVJORUwpOw0KPiA+ICAJaWYgKCFpbnRl
cnJ1cHRfZGF0YSkNCj4gPiAgCQlyZXR1cm4gLUVOT01FTTsNCj4gPiAtCWdhc2tldF9kZXYtPmlu
dGVycnVwdF9kYXRhID0gaW50ZXJydXB0X2RhdGE7DQo+ID4gIAlpbnRlcnJ1cHRfZGF0YS0+bmFt
ZSA9IGRyaXZlcl9kZXNjLT5uYW1lOw0KPiA+ICAJaW50ZXJydXB0X2RhdGEtPnR5cGUgPSBkcml2
ZXJfZGVzYy0+aW50ZXJydXB0X3R5cGU7DQo+ID4gIAlpbnRlcnJ1cHRfZGF0YS0+cGNpX2RldiA9
IGdhc2tldF9kZXYtPnBjaV9kZXY7DQo+ID4gQEAgLTM0OSw2ICszNDgsOCBAQCBpbnQgZ2Fza2V0
X2ludGVycnVwdF9pbml0KHN0cnVjdCBnYXNrZXRfZGV2ICpnYXNrZXRfZGV2KQ0KPiA+ICAJCXJl
dHVybiAtRU5PTUVNOw0KPiA+ICAJfQ0KPiA+ICANCj4gPiArCWdhc2tldF9kZXYtPmludGVycnVw
dF9kYXRhID0gaW50ZXJydXB0X2RhdGE7DQo+ID4gKw0KPiA+ICAJc3dpdGNoIChpbnRlcnJ1cHRf
ZGF0YS0+dHlwZSkgew0KPiA+ICAJY2FzZSBQQ0lfTVNJWDoNCj4gPiAgCQlyZXQgPSBnYXNrZXRf
aW50ZXJydXB0X21zaXhfaW5pdChpbnRlcnJ1cHRfZGF0YSk7DQo+ID4gLS0gDQo+ID4gMi4yNS4x
DQo+ID4gDQo+ID4gDQo+ID4gDQo+IA0KPiB0aGFuayB5b3UsDQo+IA0KPiBmYWJpbw0KDQoNClRo
YW5rcyBmb3IgeW91ciByZW1pbmRlci4NCg==
