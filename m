Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A992D345593
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 03:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhCWCjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 22:39:25 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:36652 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229764AbhCWCjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 22:39:14 -0400
X-UUID: f7529942c90840d4b07a93ef76a036e4-20210323
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=ec0Xu7ws9yc4yFZEfVrLx9sGsUsQO2Y5F69pZNql94w=;
        b=pXJbd067FziMQaTKbvYVerI+m05jIPvtm/33i4t9PnmrbZOdHWenwUvFnNr7fOtDUhZYDfyDhQ0otgPIePnHhaT73wQSxb3I+noyYVcOa4DdUBxypDTFAPVYL9OS+yFfeCaLS4jWF4fBM0Yhttjxe+oZ4NJrsS6XvqK57sS2OOQ=;
X-UUID: f7529942c90840d4b07a93ef76a036e4-20210323
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1158060922; Tue, 23 Mar 2021 10:39:10 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs06n2.mediatek.inc
 (172.21.101.130) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 23 Mar
 2021 10:39:08 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 23 Mar 2021 10:39:07 +0800
Message-ID: <1616467147.11286.1.camel@mhfsdcap03>
Subject: Re: [PATCH 06/13] usb: xhci-mtk: support ip-sleep wakeup for MT8183
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>
Date:   Tue, 23 Mar 2021 10:39:07 +0800
In-Reply-To: <0e660a28-d66f-a23e-3fad-8fa37b6df1b1@gmail.com>
References: <1616382832-28450-1-git-send-email-chunfeng.yun@mediatek.com>
         <1616382832-28450-6-git-send-email-chunfeng.yun@mediatek.com>
         <0e660a28-d66f-a23e-3fad-8fa37b6df1b1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 1521B1B4E95B0792845FBE36193B2F66E31839D23892065DCC5F210519F582DC2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTAzLTIyIGF0IDExOjU0ICswMzAwLCBTZXJnZWkgU2h0eWx5b3Ygd3JvdGU6
DQo+IEhlbGxvIQ0KPiANCj4gT24gMjIuMDMuMjAyMSA2OjEzLCBDaHVuZmVuZyBZdW4gd3JvdGU6
DQo+IA0KPiA+IEFkZCBzdXBwb3J0IGlwLXNsZWVwIHdha2V1cCBmb3IgTVQ4MTgzLCBpdCdzIHNp
bWlsYXIgdG8gTVQ4MTczLA0KPiAgICAgICAgICAgICAgIF4gZm9yDQo+IA0KPiA+IGFuZCBpdCdz
IGFsc28gYSBzcGVjaWZpYyBvbmUsIGJ1dCBub3QgZm9sbG93IElQTSBydWxlLg0KPiANCj4gICAg
IEZvbGxvd2luZz8NCkFjaw0KPiANCj4gPiBEdWUgdG8gdGhlIGluZGV4IDIgYWxyZWFkeSB1c2Vk
IGJ5IG1hbnkgRFRTLCBpdCdzIGJldHRlciB0byBrZWVwDQo+ID4gaXQgdW5jaGFuZ2VkIGZvciBi
YWNrd2FyZCBjb21wYXRpYmxlLCB0cmVhdCBzcGVjaWZpYyBvbmVzIHdpdGhvdXQNCj4gDQo+ICAg
ICBDb21wYXRpYmlsaXR5Lg0KQWNrDQo+IA0KPiA+IGZvbGxvd2luZyBJUE0gcnVsZSBhcyByZXZp
c2lvbiAxLngsIG1lYW53aGlsZSByZXNlcnZlIDN+MTAgZm9yDQo+ID4gbGF0ZXIgcmV2aXNpb24g
dGhhdCBmb2xsb3dzIHRoZSBJUE0gcnVsZS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaHVu
ZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2
ZXJzL3VzYi9ob3N0L3hoY2ktbXRrLmMgfCAxMyArKysrKysrKysrKysrDQo+ID4gICAxIGZpbGUg
Y2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3VzYi9ob3N0L3hoY2ktbXRrLmMgYi9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktbXRrLmMNCj4gPiBp
bmRleCAwOWYyZGRiZmU4YjkuLjhiYTFmOTE0Y2I3NSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJz
L3VzYi9ob3N0L3hoY2ktbXRrLmMNCj4gPiArKysgYi9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktbXRr
LmMNCj4gPiBAQCAtNTcsMTIgKzU3LDE5IEBADQo+ID4gICAjZGVmaW5lIENUUkxfVTJfRk9SQ0Vf
UExMX1NUQglCSVQoMjgpDQo+ID4gICANCj4gPiAgIC8qIHVzYiByZW1vdGUgd2FrZXVwIHJlZ2lz
dGVycyBpbiBzeXNjb24gKi8NCj4gPiArDQo+ID4gICAvKiBtdDgxNzMgZXRjICovDQo+ID4gICAj
ZGVmaW5lIFBFUklfV0tfQ1RSTDEJMHg0DQo+ID4gICAjZGVmaW5lIFdDMV9JU19DKHgpCSgoKHgp
ICYgMHhmKSA8PCAyNikgIC8qIGN5Y2xlIGRlYm91bmNlICovDQo+ID4gICAjZGVmaW5lIFdDMV9J
U19FTglCSVQoMjUpDQo+ID4gICAjZGVmaW5lIFdDMV9JU19QCUJJVCg2KSAgLyogcG9sYXJpdHkg
Zm9yIGlwIHNsZWVwICovDQo+ID4gICANCj4gPiArLyogbXQ4MTgzICovDQo+ID4gKyNkZWZpbmUg
UEVSSV9XS19DVFJMMAkweDANCj4gPiArI2RlZmluZSBXQzBfSVNfQyh4KQkoKCh4KSAmIDB4Zikg
PDwgMjgpICAvKiBjeWNsZSBkZWJvdW5jZSAqLw0KPiA+ICsjZGVmaW5lIFdDMF9JU19QCUJJVCgx
MikJLyogcG9sYXJpdHkgKi8NCj4gPiArI2RlZmluZSBXQzBfSVNfRU4JQklUKDYpDQo+ID4gKw0K
PiA+ICAgLyogbXQyNzEyIGV0YyAqLw0KPiA+ICAgI2RlZmluZSBQRVJJX1NTVVNCX1NQTV9DVFJM
CTB4MA0KPiA+ICAgI2RlZmluZSBTU0NfSVBfU0xFRVBfRU4JQklUKDQpDQo+ID4gQEAgLTcxLDYg
Kzc4LDcgQEANCj4gPiAgIGVudW0gc3N1c2JfdXdrX3ZlcnMgew0KPiA+ICAgCVNTVVNCX1VXS19W
MSA9IDEsDQo+ID4gICAJU1NVU0JfVVdLX1YyLA0KPiA+ICsJU1NVU0JfVVdLX1YxMSA9IDExLAkv
KiBzcGVjaWZpYyByZXZpc2lvbiAxLjEgKi8NCj4gDQo+ICAgICBTU1VTQl9VV0tfVjFfMSwgbWF5
YmU/DQpHb29kIHBvaW50LCB3aWxsIG1vZGlmeSBpdC4NCg0KVGhhbmtzIGEgbG90DQoNCj4gDQo+
IFsuLi5dDQo+IA0KPiBNQlIsIFNlcmdlaQ0KDQo=

