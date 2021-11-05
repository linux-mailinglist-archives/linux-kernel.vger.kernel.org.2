Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1DD446440
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 14:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbhKENlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 09:41:02 -0400
Received: from smtpbguseast3.qq.com ([54.243.244.52]:40014 "EHLO
        smtpbguseast3.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbhKENlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 09:41:00 -0400
X-QQ-GoodBg: 1
X-QQ-SSF: B0400000000000F0
X-QQ-FEAT: veLmM2oPw1kmQ8gJxIWMvO/ako+8zG7bY9s7C3iFVXzjItoSk8v76+Kl/SEOG
        gSPihiQtvSHDIPzWnkhSM+IfuZz5vCKpFSGhluoZ+hO8lYntqoNIc20q1elIN6kEj4xmSWZ
        fcyf4110u/3oEyMTtdqZBHdMIOiXo3GJ7ACLEWLB8lSztLYkaUy+zPikpJQL2MvC6i5tMDw
        3Ql1tedtqEzbG709X8XN5YWUmUnTuG6YGQVWHUNeKWY2hWt9FUXO8qaKEGVrIxn13M5yLhG
        X8sYhbCwr13L0y4t/u1HKoYZXKD77YGdGHGhUHWFyQ+rcZYxqXM5TEyMZ+WqD3/FFs/9d/4
        5TH+7GaMNGOe+jQQ3ugR69fveNwcgTEoot3opQp
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 113.57.13.187
X-QQ-STYLE: 
X-QQ-mid: logic531t1636119493t9484519
From:   "=?utf-8?B?bGlhbnpoaSBjaGFuZw==?=" <changlianzhi@uniontech.com>
To:     "=?utf-8?B?QW5keSBTaGV2Y2hlbmtv?=" 
        <andriy.shevchenko@linux.intel.com>
Cc:     "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>,
        "=?utf-8?B?ZG1pdHJ5LnRvcm9raG92?=" <dmitry.torokhov@gmail.com>,
        "=?utf-8?B?R3JlZyBLSA==?=" <gregkh@linuxfoundation.org>,
        "=?utf-8?B?amlyaXNsYWJ5?=" <jirislaby@kernel.org>,
        "=?utf-8?B?MjgyODI3OTYx?=" <282827961@qq.com>
Subject: Re: [PATCH v10] tty: Fix the keyboard led light display problem
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Date:   Fri, 5 Nov 2021 21:38:13 +0800
X-Priority: 3
Message-ID: <tencent_0E22777E5505E7C27FF412EB@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20211105122443.23897-1-changlianzhi@uniontech.com>
        <YYUoWJWbPpK079/d@smile.fi.intel.com>
In-Reply-To: <YYUoWJWbPpK079/d@smile.fi.intel.com>
X-QQ-ReplyHash: 4003995281
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
        by smtp.qq.com (ESMTP) with SMTP
        id ; Fri, 05 Nov 2021 21:38:14 +0800 (CST)
Feedback-ID: logic:uniontech.com:qybgforeign:qybgforeign7
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBOb3YgMDUsIDIwMjEgYXQgMDg6MjQ6NDNQTSArMDgwMCwgbGlhbnpoaSBjaGFu
ZyB3cm90ZToNCj4gPiBTd2l0Y2hpbmcgZnJvbSB0aGUgZGVza3RvcCBlbnZpcm9ubWVudCB0
byB0aGUgdHR5IGVudmlyb25tZW50LA0KPiA+IHRoZSBzdGF0ZSBvZiB0aGUga2V5Ym9hcmQg
bGVkIGxpZ2h0cyBhbmQgdGhlIHN0YXRlIG9mIHRoZSBrZXlib2FyZA0KPiA+IGxvY2sgYXJl
IGluY29uc2lzdGVudC4gVGhpcyBpcyBiZWNhdXNlIHRoZSBhdHRyaWJ1dGUga2ItPmtiZG1v
ZGUNCj4gPiBvZiB0aGUgdHR5IGJvdW5kIGluIHRoZSBkZXNrdG9wIGVudmlyb25tZW50IChY
b3JnKSBpcyBzZXQgdG8NCj4gPiBWQ19PRkYsIHdoaWNoIGNhdXNlcyB0aGUgbGVkc3RhdGUg
YW5kIGtiLT5sZWRmbGFnc3RhdGUNCj4gPiB2YWx1ZXMgb2YgdGhlIGJvdW5kIHR0eSB0byBh
bHdheXMgYmUgMCwgd2hpY2ggY2F1c2VzIHRoZSBzd2l0Y2gNCj4gPiBmcm9tIHRoZSBkZXNr
dG9wIFdoZW4gdG8gdGhlIHR0eSBlbnZpcm9ubWVudCwgdGhlIExFRCBsaWdodA0KPiA+IHN0
YXR1cyBpcyBpbmNvbnNpc3RlbnQgd2l0aCB0aGUga2V5Ym9hcmQgbG9jayBzdGF0dXMuDQo+
ID4gSW4gb3JkZXIgdG8gZW5zdXJlIHRoYXQgdGhlIGtleWJvYXJkIExFRCBsaWdodHMgYXJl
IGRpc3BsYXllZA0KPiA+IG5vcm1hbGx5IGR1cmluZyB0aGUgVlQgc3dpdGNoaW5nIHByb2Nl
c3MsIHdoZW4gdGhlIFZUIGlzDQo+ID4gc3dpdGNoZWQsIHRoZSBjdXJyZW50IFZUIExFRCBj
b25maWd1cmF0aW9uIGlzIGZvcmNlZCB0byBiZSBpc3N1ZWQuDQo+ID4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBsaWFuemhpIGNoYW5nIDxjaGFuZ2xpYW56aGlAdW5pb250ZWNoLmNvbT4NCj4g
PiAtLS0NCj4gPiAgdjEwOg0KPiA+ICBUaGUgbGVkIHN0YXRlIG9mIHRoZSBpbnB1dCBkZXZp
Y2UgaXMgbm8gbG9uZ2VyIHN5bmNocm9uaXplZCB0bw0KPiA+ICBsZWRzdGF0ZSwgYW5kIHRo
ZSByZWxhdGVkIGNvZGUgaXMgZGVsZXRlZC4gVGhlIGN1cnJlbnQgcGxhbiBpcw0KPiA+ICBj
aGFuZ2VkIHRvOiB3aGVuIHRoZSBWVCBpcyBzd2l0Y2hlZCwgdGhlIExFRCBzdGF0ZSBzYXZl
ZCBieSB0aGUNCj4gPiAgY3VycmVudCBWVCBpcyBmb3JjZWQgdG8gYmUgaXNzdWVkLg0KPiA+
IA0KPiBTaG91bGRuJ3QgeW91IGFkZCBhIFN1Z2dlc3RlZC1ieSB0YWc/DQoNCk9oLCBzb3Jy
eSwgSSB3YXMgbmVnbGlnZW50LCBJIHdpbGwgYWRkIGl0IHJpZ2h0IGF3YXkuDQoNClRoYW5r
cy4NCi0tDQpsaWFuemhpIGNoYW5n



