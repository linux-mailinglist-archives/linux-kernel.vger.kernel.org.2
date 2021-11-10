Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F4444BC19
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 08:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbhKJH3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 02:29:11 -0500
Received: from smtpbg703.qq.com ([203.205.195.89]:57982 "EHLO
        smtpproxy21.qq.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229581AbhKJH3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 02:29:05 -0500
X-QQ-GoodBg: 1
X-QQ-SSF: B0400000000000F0
X-QQ-FEAT: ssdqv2V8ieL0uIQKcI5GFmJJISz2UytYgcAmwDH2+T1Vo1q85+SmHWGVsgnjT
        wOI5punlX0M5eoJ92CenP13tC3EoDGh/2GM3bGuUE3lTGzZ/UTUDe6BaochABjTRwOwETrT
        vLzth+2LB8zTCVaDApZU3WI2a/v4Dpk/EbHbbb7nQduX7UAVWdkifLJ5vDDKyvKfZy5J6Ms
        n0Us6+83k0KpaA5yiso8ZShPMRF0Y7QfygxZOC7Ex6XqwizxI+Rb1C7zmvc1EePdfdQVRuB
        DXrMU+XJZTS3PiB8s47oqwORszvRJbyFhSMrlVjNkape8QLlKF5Dt2kzVrU7LpNPtQj7Nhn
        qzKGQ7Kwk8olWmIsuBqM+010qNYny17Bpud67uh
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 113.57.13.187
X-QQ-STYLE: 
X-QQ-mid: logic531t1636529172t6619750
From:   "=?utf-8?B?bGlhbnpoaSBjaGFuZw==?=" <changlianzhi@uniontech.com>
To:     "=?utf-8?B?ZG1pdHJ5LnRvcm9raG92?=" <dmitry.torokhov@gmail.com>
Cc:     "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>,
        "=?utf-8?B?R3JlZyBLSA==?=" <gregkh@linuxfoundation.org>,
        "=?utf-8?B?amlyaXNsYWJ5?=" <jirislaby@kernel.org>,
        "=?utf-8?B?QW5keSBTaGV2Y2hlbmtv?=" 
        <andriy.shevchenko@linux.intel.com>,
        "=?utf-8?B?MjgyODI3OTYx?=" <282827961@qq.com>
Subject: Re: [PATCH v14] tty: Fix the keyboard led light display problem
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Date:   Wed, 10 Nov 2021 15:26:12 +0800
X-Priority: 3
Message-ID: <tencent_032E4FE80FDB8EA164AE0644@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20211108055139.7202-1-changlianzhi@uniontech.com>
        <YYtpr/bP0HqBsmbW@google.com>
In-Reply-To: <YYtpr/bP0HqBsmbW@google.com>
X-QQ-ReplyHash: 577884404
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
        by smtp.qq.com (ESMTP) with SMTP
        id ; Wed, 10 Nov 2021 15:26:13 +0800 (CST)
Feedback-ID: logic:uniontech.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBNb24sIE5vdiAwOCwgMjAyMSBhdCAwMTo1MTozOVBNICswODAwLCBsaWFuemhpIGNo
YW5nIHdyb3RlOg0KPiA+IFN3aXRjaGluZyBmcm9tIHRoZSBkZXNrdG9wIGVudmlyb25tZW50
IHRvIHRoZSB0dHkgZW52aXJvbm1lbnQsDQo+ID4gdGhlIHN0YXRlIG9mIHRoZSBrZXlib2Fy
ZCBsZWQgbGlnaHRzIGFuZCB0aGUgc3RhdGUgb2YgdGhlIGtleWJvYXJkDQo+ID4gbG9jayBh
cmUgaW5jb25zaXN0ZW50LiBUaGlzIGlzIGJlY2F1c2UgdGhlIGF0dHJpYnV0ZSBrYi0+a2Jk
bW9kZQ0KPiA+IG9mIHRoZSB0dHkgYm91bmQgaW4gdGhlIGRlc2t0b3AgZW52aXJvbm1lbnQg
KFhvcmcpIGlzIHNldCB0bw0KPiA+IFZDX09GRiwgd2hpY2ggY2F1c2VzIHRoZSBsZWRzdGF0
ZSBhbmQga2ItPmxlZGZsYWdzdGF0ZQ0KDQo+IFdlIGtub3cgdGhhdCBYb3JnIHNldHMga2Jk
bW9kZSBtb2RlIHRvIFZDX09GRiwgYnV0IGl0IGRvZXMgbm90IG1lYW4gdGhhdA0KPiB5b3Ug
Y2FuIHNheSBmb3Igc3VyZSB0aGF0IGl0IGlzIFhvcmcgaW5zdGFuY2UgdGhhdCBjb250cm9s
cyBhIFZUIHNpbXBseQ0KPiBieSBvYnNlcnZpbmcga2ItPmtiZG1vZGUuIFRoZXJlIG1heSBi
ZSBzb21ldGhpbmcgZWxzZSBlbnRpcmVseS4gVGhhdCBpcw0KPiB3aHkgeW91IHdhbnQgZHJp
dmVycy90dHkvdnQva2V5Ym9hcmQuYyB0byByZXNldCBMRURzIGFuZCBsZWF2ZSBpdCB0bw0K
PiB3aG9ldmVyIGlzIGNvbnRyb2xsaW5nIFZUIHRvIHNldCB0aGVtIHRvIHNvbWV0aGluZyBl
bHNlIGlmIGl0IGlzDQo+IGRlc2lyZWQuDQoNCkRvZXMgdGhpcyBtZWFuIGxldCBtZSBjaGFu
Z2UgdGhlIGRlc2NyaXB0aW9uIGluZm9ybWF0aW9uPyBPciBpcyB0aGUNCmp1ZGdtZW50IG9m
IFZDX09GRiBpbiBwYXRjaCBpbmNvcnJlY3Q/DQpUaGUgc2V0dXAgbWV0aG9kIG9mIFhvcmcg
bWVudGlvbmVkIGhlcmUgaXMganVzdCB0byBkZXNjcmliZSBhIHByb2Nlc3MNCmluIHdoaWNo
IEkgZm91bmQgdGhlIHByb2JsZW07DQpNeSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgd2hlbiB0
aGUgbW9kZSBvZiBrYmRtb2RlIGlzIHNldCB0byBWQ19PRkYsDQpWVCBzaG91bGRuJ3QgaW50
ZXJmZXJlIHdpdGggdGhlIHN0YXRlIG9mIHRoZSBrZXlib2FyZCBsaWdodCwgcmlnaHQ/IFRo
aXMgaXMgDQpob3cgZnVuY3Rpb25zIHN1Y2ggYXMga2JkX2tleWNvZGUoKSBhcmUgaW1wbGVt
ZW50ZWQuDQpXaGVuIFZUIGlzIHN3aXRjaGVkLCBpZiB0aGUgVlQgbW9kZSBpcyBWQ19PRkYs
IHRoZXJlIGlzIGFsc28gbm8gbmVlZA0KdG8gc2V0IHRoZSBzdGF0ZSBvZiB0aGUga2V5Ym9h
cmQgbGlnaHQuIEkgdGhpbmsgdGhpcyBpcyByZWFzb25hYmxlLg0KDQo+ID4gdmFsdWVzIG9m
IHRoZSBib3VuZCB0dHkgdG8gYWx3YXlzIGJlIDAsIHdoaWNoIGNhdXNlcyB0aGUgc3dpdGNo
DQo+ID4gZnJvbSB0aGUgZGVza3RvcCBXaGVuIHRvIHRoZSB0dHkgZW52aXJvbm1lbnQsIHRo
ZSBMRUQgbGlnaHQNCj4gPiBzdGF0dXMgaXMgaW5jb25zaXN0ZW50IHdpdGggdGhlIGtleWJv
YXJkIGxvY2sgc3RhdHVzLg0KPiA+IEluIG9yZGVyIHRvIGVuc3VyZSB0aGF0IHRoZSBrZXli
b2FyZCBMRUQgbGlnaHRzIGFyZSBkaXNwbGF5ZWQNCj4gPiBub3JtYWxseSBkdXJpbmcgdGhl
IFZUIHN3aXRjaGluZyBwcm9jZXNzLCB3aGVuIHRoZSBWVCBpcw0KPiA+IHN3aXRjaGVkLCB0
aGUgY3VycmVudCBWVCBMRUQgY29uZmlndXJhdGlvbiBpcyBmb3JjZWQgdG8gYmUgaXNzdWVk
Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogbGlhbnpoaSBjaGFuZyA8Y2hhbmdsaWFuemhp
QHVuaW9udGVjaC5jb20+DQo+ID4gU3VnZ2VzdGVkLWJ5OiBkbWl0cnkudG9yb2tob3YgPGRt
aXRyeS50b3Jva2hvdkBnbWFpbC5jb20+DQo+ID4gU3VnZ2VzdGVkLWJ5OiBBbmR5IFNoZXZj
aGVua28gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT4NCj4gPiAtLS0NCj4g
PiAgdjEzOg0KPiA+ICBUaGUga2JkX2JoIGZ1bmN0aW9uIG5vIGxvbmdlciBoYW5kbGVzIHRo
ZSAia2ItPmtiZG1vZGUgPT0gVkNfT0ZGIg0KPiA+ICBzY2VuZSwgYnV0IHB1dHMgdGhpcyBw
cm9jZXNzIGluIHZ0X3NldF9sZWRzX2NvbXB1dGVfc2hpZnRzdGF0ZQ0KPiA+ICB0b2dldGhl
ci4gQmVjYXVzZSB0aGUgY3VycmVudCBjaXJjdW12ZW50aW9uIGlzIHRoYXQgb3RoZXIgdHR5
cw0KPiA+ICBzd2l0Y2ggdG8gdGhlIFhvcmctYm91bmQgdHR5IHNjZW5lLCBzbyB0aGlzIEJl
dHRlci4NCj4gPiAgdjE0Og0KPiA+ICBTb3JyeSwgSSBmb3Jnb3QgdG8gdmVyaWZ5IHRoZSBm
b3JtYXQsIGl0IGlzIGdvb2Qgbm93Lg0KPiA+IA0KPiA+ICBkcml2ZXJzL3R0eS92dC9rZXli
b2FyZC5jIHwgMTkgKysrKysrKysrKysrKysrKysrLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwg
MTggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdHR5L3Z0L2tleWJvYXJkLmMgYi9kcml2ZXJzL3R0eS92dC9rZXlib2FyZC5j
DQo+ID4gaW5kZXggYzdmYmJjZGNjMzQ2Li45MWUxYzVkOTIwMjkgMTAwNjQ0DQo+ID4gLS0t
IGEvZHJpdmVycy90dHkvdnQva2V5Ym9hcmQuYw0KPiA+ICsrKyBiL2RyaXZlcnMvdHR5L3Z0
L2tleWJvYXJkLmMNCj4gPiBAQCAtMTUzLDYgKzE1Myw3IEBAIHN0YXRpYyBpbnQgc2hpZnRf
c3RhdGUgPSAwOw0KPiA+IA0KPiA+ICBzdGF0aWMgdW5zaWduZWQgaW50IGxlZHN0YXRlID0g
LTFVOyAvKiB1bmRlZmluZWQgKi8NCj4gPiAgc3RhdGljIHVuc2lnbmVkIGNoYXIgbGVkaW9j
dGw7DQo+ID4gK3N0YXRpYyBib29sIHZ0X3N3aXRjaDsNCj4gPiANCj4gPiAgLyoNCj4gPiAg
ICogTm90aWZpZXIgbGlzdCBmb3IgY29uc29sZSBrZXlib2FyZCBldmVudHMNCj4gPiBAQCAt
NDEyLDkgKzQxMywyMCBAQCBzdGF0aWMgdm9pZCBkb19jb21wdXRlX3NoaWZ0c3RhdGUodm9p
ZCkNCj4gPiAgLyogV2Ugc3RpbGwgaGF2ZSB0byBleHBvcnQgdGhpcyBtZXRob2QgdG8gdnQu
YyAqLw0KPiA+ICB2b2lkIHZ0X3NldF9sZWRzX2NvbXB1dGVfc2hpZnRzdGF0ZSh2b2lkKQ0K
PiA+ICB7DQo+ID4gKyBzdHJ1Y3Qga2JkX3N0cnVjdCAqa2I7DQo+ID4gIHVuc2lnbmVkIGxv
bmcgZmxhZ3M7DQo+ID4gDQo+ID4gLSBzZXRfbGVkcygpOw0KPiA+ICsgLyogWG9yZyB3aWxs
IGJpbmQgYSB0dHksIHRoZSBrYi0+a2JkbW9kZSBvZiB0aGlzIHR0eSB3aWxsIGJlIHNldCB0
bw0KPiA+ICsgKiBWQ19PRkYsIGFuZCB0aGlzIHR0eSB3aWxsIG5vIGxvbmdlciBzZXQgdGhl
IGtleWJvYXJkIGxpZ2h0LiBJZg0KPiA+ICsgKiB0aGVyZSBpcyBubyBzdWNoIHJlc3RyaWN0
aW9uLCB3aGVuIHN3aXRjaGluZyBmcm9tIG90aGVyIHR0eSB0bw0KPiA+ICsgKiBYb3JnLWJv
dW5kIHR0eSwgdGhlIHR0eSB3aWxsIHNldCB0aGUga2V5Ym9hcmQgbGlnaHQsIHdoaWNoIGlz
DQo+ID4gKyAqIHVucmVhc29uYWJsZQ0KPiA+ICsgKi8NCj4gPiArIGtiID0ga2JkX3RhYmxl
ICsgZmdfY29uc29sZTsNCj4gPiArIGlmIChrYi0+a2JkbW9kZSAhPSBWQ19PRkYpIHsNCj4g
PiArIHZ0X3N3aXRjaCA9IHRydWU7DQo+ID4gKyBzZXRfbGVkcygpOw0KPiA+ICsgfQ0KPiA+
IA0KPiA+ICBzcGluX2xvY2tfaXJxc2F2ZSgma2JkX2V2ZW50X2xvY2ssIGZsYWdzKTsNCj4g
PiAgZG9fY29tcHV0ZV9zaGlmdHN0YXRlKCk7DQo+ID4gQEAgLTEyNTUsNiArMTI2NywxMSBA
QCBzdGF0aWMgdm9pZCBrYmRfYmgoc3RydWN0IHRhc2tsZXRfc3RydWN0ICp1bnVzZWQpDQo+
ID4gIGxlZHMgfD0gKHVuc2lnbmVkIGludClrYmQtPmxvY2tzdGF0ZSA8PCA4Ow0KPiA+ICBz
cGluX3VubG9ja19pcnFyZXN0b3JlKCZsZWRfbG9jaywgZmxhZ3MpOw0KPiA+IA0KPiA+ICsg
aWYgKHZ0X3N3aXRjaCkgew0KPiA+ICsgbGVkc3RhdGUgPSB+bGVkczsNCj4gPiArIHZ0X3N3
aXRjaCA9IGZhbHNlOw0KPiA+ICsgfQ0KPiA+ICsNCj4gPiAgaWYgKGxlZHMgIT0gbGVkc3Rh
dGUpIHsNCj4gPiAga2JkX3Byb3BhZ2F0ZV9sZWRfc3RhdGUobGVkc3RhdGUsIGxlZHMpOw0K
PiA+ICBsZWRzdGF0ZSA9IGxlZHM7DQo+ID4gLS0NCj4gPiAyLjIwLjENCg0KVGhhbmtzLg0K
LS0NCmxpYW56aGkgY2hhbmc=



