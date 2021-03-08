Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00E503305C2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 03:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbhCHCDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 21:03:53 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:58981 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233603AbhCHCDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 21:03:30 -0500
X-UUID: 8bd91272d3124da98a3d0da25188a2dd-20210308
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=h9EFUsdAxVRzuiXK7xWjWP87blcUdQUpQQm0u2fICNw=;
        b=n491iP+jrdJnh4XyGzeRmrVX+IfLITLtfny/ydVs9HrILSLBFDWlqCK7A23M0cEleivwuUud5MMgbgmYfU5Cz5HxUTJlOA24qdIVw7kNeoifj9KbOICD5nFq2RsCWa/bBOF2Qc6fHx45czldN8cra/pgj1ildZXcSZdmNwjwbLo=;
X-UUID: 8bd91272d3124da98a3d0da25188a2dd-20210308
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 264082348; Mon, 08 Mar 2021 10:03:25 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs06n1.mediatek.inc
 (172.21.101.129) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 8 Mar
 2021 10:02:23 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 8 Mar 2021 10:02:23 +0800
Message-ID: <1615168943.32109.8.camel@mhfsdcap03>
Subject: Re: [PATCH 16/17] usb: common: add function to get interval
 expressed in us unit
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Alan Stern <stern@rowland.harvard.edu>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Date:   Mon, 8 Mar 2021 10:02:23 +0800
In-Reply-To: <YEJSjJnjXl7f/BP9@kroah.com>
References: <1614934975-15188-1-git-send-email-chunfeng.yun@mediatek.com>
         <1614934975-15188-16-git-send-email-chunfeng.yun@mediatek.com>
         <20210305153312.GA38200@rowland.harvard.edu> <YEJSjJnjXl7f/BP9@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIxLTAzLTA1IGF0IDE2OjQ3ICswMTAwLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3Jv
dGU6DQo+IE9uIEZyaSwgTWFyIDA1LCAyMDIxIGF0IDEwOjMzOjEyQU0gLTA1MDAsIEFsYW4gU3Rl
cm4gd3JvdGU6DQo+ID4gT24gRnJpLCBNYXIgMDUsIDIwMjEgYXQgMDU6MDI6NTRQTSArMDgwMCwg
Q2h1bmZlbmcgWXVuIHdyb3RlOg0KPiA+ID4gQWRkIGEgbmV3IGZ1bmN0aW9uIHRvIGNvbnZlcnQg
YkludGVydmFsIGludG8gdGhlIHRpbWUgZXhwcmVzc2VkDQo+ID4gPiBpbiAxdXMgdW5pdC4NCj4g
PiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVk
aWF0ZWsuY29tPg0KPiA+ID4gLS0tDQo+ID4gDQo+ID4gPiAtLS0gYS9kcml2ZXJzL3VzYi9jb21t
b24vY29tbW9uLmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvdXNiL2NvbW1vbi9jb21tb24uYw0KPiA+
ID4gQEAgLTE2NSw2ICsxNjUsMzkgQEAgZW51bSB1c2JfZHJfbW9kZSB1c2JfZ2V0X2RyX21vZGUo
c3RydWN0IGRldmljZSAqZGV2KQ0KPiA+ID4gIH0NCj4gPiA+ICBFWFBPUlRfU1lNQk9MX0dQTCh1
c2JfZ2V0X2RyX21vZGUpOw0KPiA+ID4gIA0KPiA+ID4gK3Vuc2lnbmVkIGludCB1c2JfZGVjb2Rl
X2ludGVydmFsKGNvbnN0IHN0cnVjdCB1c2JfZW5kcG9pbnRfZGVzY3JpcHRvciAqZXBkLA0KPiA+
ID4gKwkJCQkgZW51bSB1c2JfZGV2aWNlX3NwZWVkIHNwZWVkKQ0KPiA+ID4gK3sNCj4gPiA+ICsJ
dW5zaWduZWQgaW50IGludGVydmFsID0gMDsNCj4gPiA+ICsNCj4gPiA+ICsJc3dpdGNoICh1c2Jf
ZW5kcG9pbnRfdHlwZShlcGQpKSB7DQo+ID4gPiArCWNhc2UgVVNCX0VORFBPSU5UX1hGRVJfQ09O
VFJPTDoNCj4gPiA+ICsJCS8qIHVmcmFtZXMgcGVyIE5BSyAqLw0KPiA+ID4gKwkJaWYgKHNwZWVk
ID09IFVTQl9TUEVFRF9ISUdIKQ0KPiA+ID4gKwkJCWludGVydmFsID0gZXBkLT5iSW50ZXJ2YWw7
DQo+ID4gPiArCQlicmVhazsNCj4gPiA+ICsJY2FzZSBVU0JfRU5EUE9JTlRfWEZFUl9JU09DOg0K
PiA+ID4gKwkJaW50ZXJ2YWwgPSAxIDw8IChlcGQtPmJJbnRlcnZhbCAtIDEpOw0KPiA+ID4gKwkJ
YnJlYWs7DQo+ID4gPiArCWNhc2UgVVNCX0VORFBPSU5UX1hGRVJfQlVMSzoNCj4gPiA+ICsJCS8q
IHVmcmFtZXMgcGVyIE5BSyAqLw0KPiA+ID4gKwkJaWYgKHNwZWVkID09IFVTQl9TUEVFRF9ISUdI
ICYmIHVzYl9lbmRwb2ludF9kaXJfb3V0KGVwZCkpDQo+ID4gPiArCQkJaW50ZXJ2YWwgPSBlcGQt
PmJJbnRlcnZhbDsNCj4gPiA+ICsJCWJyZWFrOw0KPiA+ID4gKwljYXNlIFVTQl9FTkRQT0lOVF9Y
RkVSX0lOVDoNCj4gPiA+ICsJCWlmIChzcGVlZCA+PSBVU0JfU1BFRURfSElHSCkNCj4gPiA+ICsJ
CQlpbnRlcnZhbCA9IDEgPDwgKGVwZC0+YkludGVydmFsIC0gMSk7DQo+ID4gPiArCQllbHNlDQo+
ID4gPiArCQkJaW50ZXJ2YWwgPSBlcGQtPmJJbnRlcnZhbDsNCj4gPiA+ICsJCWJyZWFrOw0KPiA+
ID4gKwl9DQo+ID4gPiArDQo+ID4gPiArCWludGVydmFsICo9IChzcGVlZCA+PSBVU0JfU1BFRURf
SElHSCkgPyAxMjUgOiAxMDAwOw0KPiA+ID4gKw0KPiA+ID4gKwlyZXR1cm4gaW50ZXJ2YWw7DQo+
ID4gPiArfQ0KPiA+ID4gK0VYUE9SVF9TWU1CT0xfR1BMKHVzYl9kZWNvZGVfaW50ZXJ2YWwpOw0K
PiA+IA0KPiA+ID4gLS0tIGEvaW5jbHVkZS9saW51eC91c2IvY2g5LmgNCj4gPiA+ICsrKyBiL2lu
Y2x1ZGUvbGludXgvdXNiL2NoOS5oDQo+ID4gPiBAQCAtOTAsNiArOTAsMTcgQEAgZXh0ZXJuIGVu
dW0gdXNiX3NzcF9yYXRlIHVzYl9nZXRfbWF4aW11bV9zc3BfcmF0ZShzdHJ1Y3QgZGV2aWNlICpk
ZXYpOw0KPiA+ID4gICAqLw0KPiA+ID4gIGV4dGVybiBjb25zdCBjaGFyICp1c2Jfc3RhdGVfc3Ry
aW5nKGVudW0gdXNiX2RldmljZV9zdGF0ZSBzdGF0ZSk7DQo+ID4gPiAgDQo+ID4gPiArLyoqDQo+
ID4gPiArICogdXNiX2RlY29kZV9pbnRlcnZhbCAtIERlY29kZSBiSW50ZXJ2YWwgaW50byB0aGUg
dGltZSBleHByZXNzZWQgaW4gMXVzIHVuaXQNCj4gPiA+ICsgKiBAZXBkOiBUaGUgZGVzY3JpcHRv
ciBvZiB0aGUgZW5kcG9pbnQNCj4gPiA+ICsgKiBAc3BlZWQ6IFRoZSBzcGVlZCB0aGF0IHRoZSBl
bmRwb2ludCB3b3JrcyBhcw0KPiA+ID4gKyAqDQo+ID4gPiArICogRnVuY3Rpb24gcmV0dXJucyB0
aGUgaW50ZXJ2YWwgZXhwcmVzc2VkIGluIDF1cyB1bml0IGZvciBzZXJ2aWNpbmcNCj4gPiA+ICsg
KiBlbmRwb2ludCBmb3IgZGF0YSB0cmFuc2ZlcnMuDQo+ID4gPiArICovDQo+ID4gPiArdW5zaWdu
ZWQgaW50IHVzYl9kZWNvZGVfaW50ZXJ2YWwoY29uc3Qgc3RydWN0IHVzYl9lbmRwb2ludF9kZXNj
cmlwdG9yICplcGQsDQo+ID4gPiArCQkJCSBlbnVtIHVzYl9kZXZpY2Vfc3BlZWQgc3BlZWQpOw0K
PiA+IA0KPiA+IEFzIGEgZ2VuZXJhbCBydWxlLCBJIGJlbGlldmUgcGVvcGxlIGV4cGVjdCB0byBm
aW5kIHRoZSBrZXJuZWxkb2MgZm9yIGEgDQo+ID4gZnVuY3Rpb24gbmV4dCB0byB0aGUgZnVuY3Rp
b24ncyBkZWZpbml0aW9uLCBub3QgbmV4dCB0byB0aGUgZGVjbGFyYXRpb24gDQo+ID4gaW4gYSBo
ZWFkZXIgZmlsZS4NCj4gDQo+IEkgd2FzIGdvaW5nIHRvIG1ha2UgdGhlIHNhbWUgcmV2aWV3IGNv
bW1lbnQsIGJ1dCBpZiB5b3UgbG9vayBhYm92ZSB0aGlzDQo+IGluIHRoYXQgZmlsZSwgdGhlcmUn
cyBvdGhlciBrZXJuZWwgZG9jIGluZm9ybWF0aW9uIGluIHRoZSAuaCBmaWxlLCBzbw0KPiB0aGlz
IGRvZXMgbWF0Y2ggd2l0aCB0aGUgc3R5bGUgb2YgdGhlIGZpbGUgOigNCj4gDQo+IFdlIGNhbiBm
aXggdGhhdCBhbGwgdXAgbGF0ZXIuDQpJJ2xsIHByZXBhcmUgYSBwYXRjaA0KDQpUaGFuayB5b3UN
Cj4gDQo+IHRoYW5rcywNCj4gDQo+IGdyZWcgay1oDQoNCg==

