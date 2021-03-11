Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8926033740A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 14:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbhCKNcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 08:32:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbhCKNcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 08:32:10 -0500
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9EAB1C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 05:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        In-Reply-To:References:Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID; bh=l9tj9qGsiMmmkFd1eD0rb4YwuG4J6BUiapS/
        nxU4++c=; b=m2nLunmU3TYvkLrfEqSnB7K25uf4fRBpBnFSmGg3KHUq2rXWcHcg
        jZvOFHgiOrtICiO8+K9esAMn9+KJ88UDUcgi08oUgyI3q1SSSW64WymdKl2TF1tt
        Q47yrUOZ9G9+lWYBbD0S4p+FmrNW6pn0g6Sq+1XuJluN/cX+sK2ebp4=
Received: by ajax-webmail-newmailweb.ustc.edu.cn (Coremail) ; Thu, 11 Mar
 2021 21:31:55 +0800 (GMT+08:00)
X-Originating-IP: [202.79.170.108]
Date:   Thu, 11 Mar 2021 21:31:55 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   lyl2019@mail.ustc.edu.cn
To:     "Luis Chamberlain" <mcgrof@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] lib/test_kmod: Fix a use after free in
 register_test_dev_kmod
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT3.0.8 dev build
 20190610(cb3344cf) Copyright (c) 2002-2021 www.mailtech.cn ustc-xl
In-Reply-To: <20210311130108.GS4332@42.do-not-panic.com>
References: <20210311080246.11635-1-lyl2019@mail.ustc.edu.cn>
 <20210311130108.GS4332@42.do-not-panic.com>
X-SendMailWithSms: false
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <17bb31cd.cc46.178217c9344.Coremail.lyl2019@mail.ustc.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: LkAmygBnbj7LG0pg0aIMAA--.2W
X-CM-SenderInfo: ho1ojiyrz6zt1loo32lwfovvfxof0/1tbiAQoRBlQhn5AUNQABsG
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCg0KPiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tDQo+IOWPkeS7tuS6ujogIkx1aXMgQ2hhbWJl
cmxhaW4iIDxtY2dyb2ZAa2VybmVsLm9yZz4NCj4g5Y+R6YCB5pe26Ze0OiAyMDIxLTAzLTExIDIx
OjAxOjA4ICjmmJ/mnJ/lm5spDQo+IOaUtuS7tuS6ujogIkx2IFl1bmxvbmciIDxseWwyMDE5QG1h
aWwudXN0Yy5lZHUuY24+DQo+IOaKhOmAgTogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0K
PiDkuLvpopg6IFJlOiBbUEFUQ0hdIGxpYi90ZXN0X2ttb2Q6IEZpeCBhIHVzZSBhZnRlciBmcmVl
IGluIHJlZ2lzdGVyX3Rlc3RfZGV2X2ttb2QNCj4gDQo+IE9uIFRodSwgTWFyIDExLCAyMDIxIGF0
IDEyOjAyOjQ2QU0gLTA4MDAsIEx2IFl1bmxvbmcgd3JvdGU6DQo+ID4gSW4gcmVnaXN0ZXJfdGVz
dF9kZXZfa21vZCwgaXQgY2FsbHMgZnJlZV90ZXN0X2Rldl9rbW9kKCkgdG8gZnJlZQ0KPiA+IHRl
c3RfZGV2LiBCdXQgZnJlZV90ZXN0X2Rldl9rbW9kKCkgY2FuJ3Qgc2V0IHRoZSBvcmlnaW5hbCBw
b2ludGVyDQo+ID4gdGVzdF9kZXYgdG8gTlVMTCwgYmVjYXVzZSB0aGUgdGVzdF9kZXYgd2FzIHBh
c3NlZCBieSBpdCdzIHZhbHVlDQo+ID4gbm90IHJlZmVyZW5jZS4NCj4gDQo+IERpZCB5b3UgYWN0
dWFsbHkgZ2V0IGEgY3Jhc2ggb3Igc29tZXRoaW5nPyBJZiBzbyBjYW4geW91IHN1cHBseSB0aGUN
Cj4gYWN0dWFsIGxvZz8gSWYgdGhpcyBpcyBqdXN0IGFuIG9ic2VydmF0aW9uIGFuZCB5b3UgdGhp
bmsgdGhpcyBpcyBhbg0KPiBpc3N1ZSwgc3BlY2lmeWluZyB0aGF0IHdvdWxkIGhlbHAgZHVyaW5n
IHBhdGNoIHJldmlldy4NCj4gDQo+ICAgTHVpcw0KPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBMdiBZ
dW5sb25nIDxseWwyMDE5QG1haWwudXN0Yy5lZHUuY24+DQo+ID4gLS0tDQo+ID4gIGxpYi90ZXN0
X2ttb2QuYyB8IDIgKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2xpYi90ZXN0X2ttb2QuYyBiL2xpYi90
ZXN0X2ttb2QuYw0KPiA+IGluZGV4IDM4YzI1MGZiYWNlMy4uYWE4YTJhNTYzZDdlIDEwMDY0NA0K
PiA+IC0tLSBhL2xpYi90ZXN0X2ttb2QuYw0KPiA+ICsrKyBiL2xpYi90ZXN0X2ttb2QuYw0KPiA+
IEBAIC0xMTI0LDcgKzExMjQsNiBAQCBzdGF0aWMgdm9pZCBmcmVlX3Rlc3RfZGV2X2ttb2Qoc3Ry
dWN0IGttb2RfdGVzdF9kZXZpY2UgKnRlc3RfZGV2KQ0KPiA+ICAJCWZyZWVfdGVzdF9kZXZfaW5m
byh0ZXN0X2Rldik7DQo+ID4gIAkJa21vZF9jb25maWdfZnJlZSh0ZXN0X2Rldik7DQo+ID4gIAkJ
dmZyZWUodGVzdF9kZXYpOw0KPiA+IC0JCXRlc3RfZGV2ID0gTlVMTDsNCj4gPiAgCX0NCj4gPiAg
fQ0KPiA+ICANCj4gPiBAQCAtMTE0OSw2ICsxMTQ4LDcgQEAgc3RhdGljIHN0cnVjdCBrbW9kX3Rl
c3RfZGV2aWNlICpyZWdpc3Rlcl90ZXN0X2Rldl9rbW9kKHZvaWQpDQo+ID4gIAlpZiAocmV0KSB7
DQo+ID4gIAkJcHJfZXJyKCJjb3VsZCBub3QgcmVnaXN0ZXIgbWlzYyBkZXZpY2U6ICVkXG4iLCBy
ZXQpOw0KPiA+ICAJCWZyZWVfdGVzdF9kZXZfa21vZCh0ZXN0X2Rldik7DQo+ID4gKwkJdGVzdF9k
ZXYgPSBOVUxMOw0KPiA+ICAJCWdvdG8gb3V0Ow0KPiA+ICAJfQ0KPiA+ICANCj4gPiAtLSANCj4g
PiAyLjI1LjENCj4gPiANCj4gPiANCg0KVGhpcyBwcm9ibGVtIHdhcyByZXBvcnRlZCBieSBzb3Vy
Y2UgY29kZSBhbmFseXplcnMgZGV2ZWxvcGVkIGJ5IG91ciBTZWN1cml0eSBMYWIoTG9jY3MpLg0K
V2UgaGF2ZSBjb25maXJtZWQgdGhpcyBpc3N1ZSBiZWZvcmUgc3VibWl0aW5nIHRoZSBwYXRjaC4N
Cg0KSWYgeW91IHN0aWxsIGhhdmUgYW55IHF1ZXN0aW9ucyBhYm91dCB0aGlzIHBhdGNoLCBpIHdp
bGwgcmVwbHkgdG8geW91IGFzIHNvb24gYXMgcG9zc2libGUuDQoNClRoYW5rcyBmb3IgeW91ciB0
aW1lLg==
