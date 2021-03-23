Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80695345A74
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 10:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhCWJKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 05:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhCWJKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 05:10:41 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DB1B0C061574;
        Tue, 23 Mar 2021 02:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        In-Reply-To:References:Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID; bh=SxpT8+r6VhSmoaP5YXjxLlmFt78njlhiwRf1
        vPTZgU0=; b=R2ziuB+aPNmtwjILQqOI1oaZFgSJq6CR5lj5R80I+6n5ZlJ0jB04
        LUlf+sYvccmFrJw9K4emLJRJlfKVgJX+B+JTJNkfDzcvfXPlUliIRyPlGZBjVKW6
        /1jHBAemC4qUqbmYbspIuIGZNFOq0+ozXfgXbZJ9pIyc7WwjPQJhEk4=
Received: by ajax-webmail-newmailweb.ustc.edu.cn (Coremail) ; Tue, 23 Mar
 2021 17:10:33 +0800 (GMT+08:00)
X-Originating-IP: [154.17.2.230]
Date:   Tue, 23 Mar 2021 17:10:33 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   lyl2019@mail.ustc.edu.cn
To:     "Greg KH" <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] usb: Add data checks in usbtmc_disconnect
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT3.0.8 dev build
 20190610(cb3344cf) Copyright (c) 2002-2021 www.mailtech.cn ustc-xl
In-Reply-To: <YFmV51MPhKu/Kq6p@kroah.com>
References: <20210323034717.12818-1-lyl2019@mail.ustc.edu.cn>
 <YFmV51MPhKu/Kq6p@kroah.com>
X-SendMailWithSms: false
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <6ef4586e.d9aa.1785e599942.Coremail.lyl2019@mail.ustc.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: LkAmygDn7k6KsFlgdT8gAA--.3W
X-CM-SenderInfo: ho1ojiyrz6zt1loo32lwfovvfxof0/1tbiAQoJBlQhn5V26wACsk
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCg0KPiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tDQo+IOWPkeS7tuS6ujogIkdyZWcgS0giIDxn
cmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4g5Y+R6YCB5pe26Ze0OiAyMDIxLTAzLTIzIDE1
OjE2OjU1ICjmmJ/mnJ/kuowpDQo+IOaUtuS7tuS6ujogIkx2IFl1bmxvbmciIDxseWwyMDE5QG1h
aWwudXN0Yy5lZHUuY24+DQo+IOaKhOmAgTogbGludXgtdXNiQHZnZXIua2VybmVsLm9yZywgbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiDkuLvpopg6IFJlOiBbUEFUQ0hdIHVzYjogQWRk
IGRhdGEgY2hlY2tzIGluIHVzYnRtY19kaXNjb25uZWN0DQo+IA0KPiBPbiBNb24sIE1hciAyMiwg
MjAyMSBhdCAwODo0NzoxN1BNIC0wNzAwLCBMdiBZdW5sb25nIHdyb3RlOg0KPiA+IEluIHVzYnRt
Y19kaXNjb25uZWN0LCBkYXRhIGlzIGdvdCBmcm9tIGludGYgd2l0aCB0aGUNCj4gPiBpbml0aWFs
IHJlZmVyZW5jZS4gVGhlcmUgaXMgbm8gcmVmY291bnQgaW5jIG9wZXJhdGlvbg0KPiA+IGJlZm9y
ZSB1c2JtY19mcmVlX2ludChkYXRhKS4gSW4gdXNibWNfZnJlZV9pbnQoZGF0YSksDQo+ID4gdGhl
IGRhdGEgbWF5IGJlIGZyZWVkLg0KPiA+IA0KPiA+IEJ1dCBsYXRlciBpbiB1c2J0bWNfZGlzY29u
bmVjdCwgdGhlcmUgaXMgYW5vdGhlciBwdXQNCj4gPiBmdW5jdGlvbiBvZiBkYXRhLiBJIHRoaW5r
IGl0IGlzIGJldHRlciB0byBhZGQgbmVjZXNzYXJ5DQo+ID4gY2hlY2tzIHRvIGF2b2lkIHRoZSBk
YXRhIGJlaW5nIHB1dCB0d2ljZS4gSXQgY291bGQgY2F1c2UNCj4gPiBlcnJvcnMgaW4gcmFjZS4N
Cj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBMdiBZdW5sb25nIDxseWwyMDE5QG1haWwudXN0Yy5l
ZHUuY24+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvdXNiL2NsYXNzL3VzYnRtYy5jIHwgNCArKyst
DQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4g
PiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvY2xhc3MvdXNidG1jLmMgYi9kcml2ZXJz
L3VzYi9jbGFzcy91c2J0bWMuYw0KPiA+IGluZGV4IDc0ZDVhOWM1MjM4YS4uZTA0MzhjYjQ2Mzg2
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvdXNiL2NsYXNzL3VzYnRtYy5jDQo+ID4gKysrIGIv
ZHJpdmVycy91c2IvY2xhc3MvdXNidG1jLmMNCj4gPiBAQCAtMjQ5NCw3ICsyNDk0LDkgQEAgc3Rh
dGljIHZvaWQgdXNidG1jX2Rpc2Nvbm5lY3Qoc3RydWN0IHVzYl9pbnRlcmZhY2UgKmludGYpDQo+
ID4gIAl9DQo+ID4gIAltdXRleF91bmxvY2soJmRhdGEtPmlvX211dGV4KTsNCj4gPiAgCXVzYnRt
Y19mcmVlX2ludChkYXRhKTsNCj4gPiAtCWtyZWZfcHV0KCZkYXRhLT5rcmVmLCB1c2J0bWNfZGVs
ZXRlKTsNCj4gPiArDQo+ID4gKwlpZiAoZGF0YS0+aWluX2VwX3ByZXNlbnQgJiYgZGF0YS0+aWlu
X3VyYikNCj4gPiArCQlrcmVmX3B1dCgmZGF0YS0+a3JlZiwgdXNidG1jX2RlbGV0ZSk7DQo+IA0K
PiBXaGF0IHByb3RlY3RzIHRoZSBkYXRhIGZyb20gY2hhbmdpbmcgcmlnaHQgYWZ0ZXIgdGhlIGNo
ZWNrIGFuZCByaWdodA0KPiBiZWZvcmUgdGhlIGtyZWZfcHV0KCkgY2FsbD8NCj4gDQo+IGtyZWZz
IG5lZWQgYSBsb2NrIHNvbWV3aGVyZSB0byBwcm90ZWN0IGZyb20gcmFjZXMgbGlrZSB0aGlzLCBw
bGVhc2UgZml4DQo+IHRoYXQgbG9naWMgaW5zdGVhZC4NCj4gDQo+IHRoYW5rcywNCj4gDQo+IGdy
ZWcgay1oDQoNClRoYW5rcyBmb3IgeW91ciByZW1pbmRlci4gSSB0aGluayB0aGVyZSBpcyBzb21l
dGhpbmcgd3Jvbmcgd2l0aCBteSBwYXRjaC4NCg0KVGhlIGNoZWNrIGNvbmRpdGlvbiBiZWZvcmUg
a3JlZl9wdXQoKSBhZGRlZCBpcyBiZWNhdXNlIHRoZSBkYXRhIHdpbGwgbm90IGJlDQpmcmVlZCAg
b25seSB3aGVuIChkYXRhLT5paW5fZXBfcHJlc2VudCAmJiBkYXRhLT5paW5fdXJiKSBpcyB0cnVl
IGluIA0KdXNidG1jX2ZyZWVfaW50KGRhdGEpLiBCdXQgaSBpZ25vcmVkIHRoYXQgdGhlIGRhdGEg
bWF5IGJlIGFscmVhZHkgYmUgZnJlZWQNCmluIHVzYnRtY19mcmVlX2ludCgpLg0KDQpJIHdpbGwg
c3VibWl0IGEgUEFUQ0ggdjIgbGF0ZXIuIFRoYW5rcy4NCg==
