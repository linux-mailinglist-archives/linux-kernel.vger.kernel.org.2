Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81F9436B6DF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 18:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234315AbhDZQdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 12:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233923AbhDZQdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 12:33:31 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F766C061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 09:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        In-Reply-To:References:Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID; bh=ZnKKNkG0oL5dEwDyIPEqRG6U0N8v7ecXgYJg
        96Izn3s=; b=gNfOzZz+f390YDWZGOZPC/MpIlOcWT1B7Eq38Kxe1oUBezxLS+oR
        DBleY6Utk7LhDGFXS0NXyb1S9hPbXDN7TGipP1Mldc/lEEsxrIKJOXdcZXO/2df8
        wD+70+F2wuX7oCxQl/8y5Fv3o1ixFbxqCASBIX6Y/RevemE8gTtlG2M=
Received: by ajax-webmail-newmailweb.ustc.edu.cn (Coremail) ; Tue, 27 Apr
 2021 00:32:13 +0800 (GMT+08:00)
X-Originating-IP: [104.245.96.151]
Date:   Tue, 27 Apr 2021 00:32:13 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   lyl2019@mail.ustc.edu.cn
To:     "Greg KH" <gregkh@linuxfoundation.org>
Cc:     siglesias@igalia.com, jens.taprogge@taprogge.org,
        industrypack-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] Staging:ipack/carriers/tpci200: Fix a double free
 in tpci200_pci_probe
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT3.0.8 dev build
 20190610(cb3344cf) Copyright (c) 2002-2021 www.mailtech.cn ustc-xl
In-Reply-To: <YIbocgzOz+rAcuit@kroah.com>
References: <20210426153547.9058-1-lyl2019@mail.ustc.edu.cn>
 <YIbocgzOz+rAcuit@kroah.com>
X-SendMailWithSms: false
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <3f833e21.61c9b.1790f062e01.Coremail.lyl2019@mail.ustc.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: LkAmygB3f58O64ZgABFMAA--.1W
X-CM-SenderInfo: ho1ojiyrz6zt1loo32lwfovvfxof0/1tbiAQoDBlQhn6bxAwAAsw
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCg0KPiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tDQo+IOWPkeS7tuS6ujogIkdyZWcgS0giIDxn
cmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4g5Y+R6YCB5pe26Ze0OiAyMDIxLTA0LTI3IDAw
OjIxOjA2ICjmmJ/mnJ/kuowpDQo+IOaUtuS7tuS6ujogIkx2IFl1bmxvbmciIDxseWwyMDE5QG1h
aWwudXN0Yy5lZHUuY24+DQo+IOaKhOmAgTogc2lnbGVzaWFzQGlnYWxpYS5jb20sIGplbnMudGFw
cm9nZ2VAdGFwcm9nZ2Uub3JnLCBpbmR1c3RyeXBhY2stZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2Uu
bmV0LCBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IOS4u+mimDogUmU6IFtQQVRDSF0g
U3RhZ2luZzppcGFjay9jYXJyaWVycy90cGNpMjAwOiBGaXggYSBkb3VibGUgZnJlZSBpbiB0cGNp
MjAwX3BjaV9wcm9iZQ0KPiANCj4gT24gTW9uLCBBcHIgMjYsIDIwMjEgYXQgMDg6MzU6NDdBTSAt
MDcwMCwgTHYgWXVubG9uZyB3cm90ZToNCj4gPiBJbiB0aGUgb3V0X2Vycl9idXNfcmVnaXN0ZXIg
ZXJyb3IgYnJhbmNoIG9mIHRwY2kyMDBfcGNpX3Byb2JlLA0KPiA+IHRwY2kyMDAtPmluZm8tPmNm
Z19yZWdzIGlzIGZyZWVkIGJ5IHRwY2kyMDBfdW5pbnN0YWxsKCktPg0KPiA+IHRwY2kyMDBfdW5y
ZWdpc3RlcigpLT5wY2lfaW91bm1hcCguLix0cGNpMjAwLT5pbmZvLT5jZmdfcmVncykNCj4gPiBp
biB0aGUgZmlyc3QgdGltZS4NCj4gPiANCj4gPiBCdXQgbGF0ZXIsIGlvdW5tYXAoKSBpcyBjYWxs
ZWQgdG8gZnJlZSB0cGNpMjAwLT5pbmZvLT5jZmdfcmVncw0KPiA+IGFnYWluLg0KPiA+IA0KPiA+
IE15IHBhdGNoIHNldHMgdHBjaTIwMC0+aW5mby0+Y2ZnX3JlZ3MgdG8gTlVMTCBhZnRlciB0cGNp
MjAwX3VuaW5zdGFsbCgpDQo+ID4gdG8gYXZvaWQgdGhlIGRvdWJsZSBmcmVlLg0KPiA+IA0KPiA+
IEZpeGVzOiBjZWEyZjdjZGZmMmFmICgiU3RhZ2luZzogaXBhY2svYnJpZGdlcy90cGNpMjAwOiBV
c2UgdGhlIFRQQ0kyMDAgaW4gYmlnIGVuZGlhbiBtb2RlIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBM
diBZdW5sb25nIDxseWwyMDE5QG1haWwudXN0Yy5lZHUuY24+DQo+ID4gLS0tDQo+ID4gIGRyaXZl
cnMvaXBhY2svY2FycmllcnMvdHBjaTIwMC5jIHwgNSArKysrLQ0KPiANCj4gVGhpcyBpcyBub3Qg
YSBzdGFnaW5nIGRyaXZlciwgd2h5IGRvZXMgeW91ciBzdWJqZWN0IGxpbmUgc2F5IHRoYXQ/DQo+
IA0KPiB0aGFua3MsDQo+IA0KPiBncmVnIGstaA0KDQpJIHNlZSB0aGUgZml4ZXMgY2VhMmY3Y2Rm
ZjJhZiBoYXMgYWRkZWQgdGhlIHN1YnN5c3RlbSBuYW1lIGluIHN1YmplY3QsIHNvIGkgZ3Vlc3MN
CnRoYXQgdGhlICJTdGFnaW5nIiBtYXkgYmUgYW4gYWxpYXMgb2YgdGhpcyBtb2R1bGUuIFNvcnJ5
LCBpIHdpbGwgbmFtZSB0aGUgc3ViamVjdA0KbGluZSBtb3JlIGNhcmVmdWxseSBpbiBmdXR1cmUu
DQo=
