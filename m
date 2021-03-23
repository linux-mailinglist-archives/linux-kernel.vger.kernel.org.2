Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE3934617D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 15:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbhCWOam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 10:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbhCWOai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 10:30:38 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 21F63C061574;
        Tue, 23 Mar 2021 07:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        In-Reply-To:References:Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID; bh=A52GuFfu0aRb7bwt2gs64lBUWIX8xQdUPz2j
        3nqWAYU=; b=R8Rjf95iM2VRVbX9UjpXks/86lCwiY1LTlYCz9R1ogQMin6Cpfmq
        DO+/X11HnJpvhnaBZNQTKa3MFpwDg0xsrLblXgBCRy/AH63zGDEhq0m5uJXUGSKB
        MzgD4rXoQC0FHcWUUlP8bBGc+Z26LEOFuxoJJzZKttrP7j2NyYKoCHU=
Received: by ajax-webmail-newmailweb.ustc.edu.cn (Coremail) ; Tue, 23 Mar
 2021 22:30:16 +0800 (GMT+08:00)
X-Originating-IP: [202.38.69.14]
Date:   Tue, 23 Mar 2021 22:30:16 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   lyl2019@mail.ustc.edu.cn
To:     "Mika Westerberg" <mika.westerberg@linux.intel.com>
Cc:     andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] thunderbolt: Fix a double put in tb_cfg_read_raw
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT3.0.8 dev build
 20190610(cb3344cf) Copyright (c) 2002-2021 www.mailtech.cn ustc-xl
In-Reply-To: <20210323140647.GV2542@lahna.fi.intel.com>
References: <20210323031512.12234-1-lyl2019@mail.ustc.edu.cn>
 <20210323140647.GV2542@lahna.fi.intel.com>
X-SendMailWithSms: false
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <4ff4aeb5.e6c7.1785f7e4edc.Coremail.lyl2019@mail.ustc.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: LkAmygAHTZx4+1lgt0ElAA--.0W
X-CM-SenderInfo: ho1ojiyrz6zt1loo32lwfovvfxof0/1tbiAQsJBlQhn5WXXgACsx
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCg0KPiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tDQo+IOWPkeS7tuS6ujogIk1pa2EgV2VzdGVy
YmVyZyIgPG1pa2Eud2VzdGVyYmVyZ0BsaW51eC5pbnRlbC5jb20+DQo+IOWPkemAgeaXtumXtDog
MjAyMS0wMy0yMyAyMjowNjo0NyAo5pif5pyf5LqMKQ0KPiDmlLbku7bkuro6ICJMdiBZdW5sb25n
IiA8bHlsMjAxOUBtYWlsLnVzdGMuZWR1LmNuPg0KPiDmioTpgIE6IGFuZHJlYXMubm9ldmVyQGdt
YWlsLmNvbSwgbWljaGFlbC5qYW1ldEBpbnRlbC5jb20sIFllaGV6a2VsU2hCQGdtYWlsLmNvbSwg
bGludXgtdXNiQHZnZXIua2VybmVsLm9yZywgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0K
PiDkuLvpopg6IFJlOiBbUEFUQ0hdIHRodW5kZXJib2x0OiBGaXggYSBkb3VibGUgcHV0IGluIHRi
X2NmZ19yZWFkX3Jhdw0KPiANCj4gSGksDQo+IA0KPiBPbiBNb24sIE1hciAyMiwgMjAyMSBhdCAw
ODoxNToxMlBNIC0wNzAwLCBMdiBZdW5sb25nIHdyb3RlOg0KPiA+IEluIHRiX2NmZ19yZWFkX3Jh
dywgcmVxIGlzIGFsbG9jYXRlZCBieSB0Yl9jZmdfcmVxdWVzdF9hbGxvYygpDQo+ID4gd2l0aCBh
biBpbml0aWFsIHJlZmVyZW5jZS4gQmVmb3JlIGNhbGxpbmcgdGJfY2ZnX3JlcXVlc3Rfc3luYygp
LA0KPiA+IHRoZXJlIGlzIG5vIHJlZmNvdW50IGluYyBvcGVyYXRpb24uIHRiX2NmZ19yZXF1ZXN0
X3N5bmMoKQ0KPiA+IGNhbGxzIHRiX2NmZ19yZXF1ZXN0KC4uLHJlcSwuLikgYW5kIGlmIHRoZSBj
YWxsZWUgZmFpbGVkLA0KPiA+IHRoZSBpbml0aWFsIHJlZmVyZW5jZSBvZiByZXEgaXMgZHJvcHBl
ZCBhbmQgcmVxIGlzIGZyZWVkLg0KPiA+IA0KPiA+IExhdGVyIGluIHRiX2NmZ19yZWFkX3JhdyBi
ZWZvcmUgdGhlIGVyciBjaGVjaywNCj4gPiB0Yl9jZmdfcmVxdWVzdF9wdXQocmVxKSBpcyBjYWxs
ZWQgYWdhaW4uIEl0IG1heSBjYXVzZSBlcnJvcg0KPiA+IGluIHJhY2UuDQo+IA0KPiBIbW0sIHRi
X2NmZ19yZXF1ZXN0KCkgZG9lcyB0Yl9jZmdfcmVxdWVzdF9nZXQoKSB0b28gYW5kIGluIGNhc2Ug
b2YgZXJyb3INCj4gaXQgZG9lcyB0Yl9jZmdfcmVxdWVzdF9wdXQoKS4gU28gdGhlIHJlZmNvdW50
IHNob3VsZCBiZSBmaW5lLiBXaGF0IGFtIEkNCj4gbWlzc2luZz8NCj4gDQo+ID4gDQo+ID4gTXkg
cGF0Y2ggcHV0cyB0Yl9jZmdfcmVxdWVzdF9wdXQocmVxKSBhZnRlciB0aGUgZXJyIGNoZWNrDQo+
ID4gZmluaXNoZWQgdG8gYXZvaWQgdW5leHBlY3RlZCByZXN1bHQuDQo+ID4gDQo+ID4gU2lnbmVk
LW9mZi1ieTogTHYgWXVubG9uZyA8bHlsMjAxOUBtYWlsLnVzdGMuZWR1LmNuPg0KPiA+IC0tLQ0K
PiA+ICBkcml2ZXJzL3RodW5kZXJib2x0L2N0bC5jIHwgNCArKy0tDQo+ID4gIDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdGh1bmRlcmJvbHQvY3RsLmMgYi9kcml2ZXJzL3RodW5kZXJib2x0L2N0bC5j
DQo+ID4gaW5kZXggZjFhZWFmZjlmMzY4Li5iYjYwMjY5Yzg5YWIgMTAwNjQ0DQo+ID4gLS0tIGEv
ZHJpdmVycy90aHVuZGVyYm9sdC9jdGwuYw0KPiA+ICsrKyBiL2RyaXZlcnMvdGh1bmRlcmJvbHQv
Y3RsLmMNCj4gPiBAQCAtODkwLDExICs4OTAsMTEgQEAgc3RydWN0IHRiX2NmZ19yZXN1bHQgdGJf
Y2ZnX3JlYWRfcmF3KHN0cnVjdCB0Yl9jdGwgKmN0bCwgdm9pZCAqYnVmZmVyLA0KPiA+ICANCj4g
PiAgCQlyZXMgPSB0Yl9jZmdfcmVxdWVzdF9zeW5jKGN0bCwgcmVxLCB0aW1lb3V0X21zZWMpOw0K
PiA+ICANCj4gPiAtCQl0Yl9jZmdfcmVxdWVzdF9wdXQocmVxKTsNCj4gPiAtDQo+ID4gIAkJaWYg
KHJlcy5lcnIgIT0gLUVUSU1FRE9VVCkNCj4gPiAgCQkJYnJlYWs7DQo+ID4gIA0KPiA+ICsJCXRi
X2NmZ19yZXF1ZXN0X3B1dChyZXEpOw0KPiA+ICsNCj4gPiAgCQkvKiBXYWl0IGEgYml0IChhcmJp
dHJhcnkgdGltZSkgdW50aWwgd2Ugc2VuZCBhIHJldHJ5ICovDQo+ID4gIAkJdXNsZWVwX3Jhbmdl
KDEwLCAxMDApOw0KPiA+ICAJfQ0KPiA+IC0tIA0KPiA+IDIuMjUuMQ0KPiA+IA0KDQpJJ20gdmVy
eSBzb3JyeSwgaSB3YXMgYXNoYW1lZCB0aGF0IGkgaGFkIG1pc3NlZCB0aGUgdGJfY2ZnX3JlcXVl
c3RfZ2V0KCkgaW4gdGJfY2ZnX3JlcXVlc3QoKS4NCg0KVGhhbmtzLg0K
