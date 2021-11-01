Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D021441B41
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 13:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbhKAMib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 08:38:31 -0400
Received: from smtpbgsg1.qq.com ([54.254.200.92]:57130 "EHLO smtpbgsg1.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232241AbhKAMia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 08:38:30 -0400
X-QQ-GoodBg: 1
X-QQ-SSF: B0400000000000F0
X-QQ-FEAT: 3VHFGWe+x7HaR9Nqg2dOJFQauBpP6Fwmq3kD2nKxVbpZY3gIzHs+YvsC2PRf4
        OfbpA1t6FSu4Wu//FzUBIlhIHn+/Odb667gM1yuJy/deGF/nJOXBnIbtCFIYtjXm4Vz2IVl
        CY0c7wV1zGvB+HEdtCBzmlyfGQb0LPkhIMOK2t4Ay9Q6EYdz/HjsKYdfDatkKX8jPpTDtBP
        wVe5Jt1FLJO7sjzqD7zMURft846YNDuyDelJibsVrydbMU7Fir8d/1kE8UZ9gJW6zRqv3u2
        +MFUrwNFtP4NQsXe6AVn8pNO62MPaCwUn4l2WC/B3Ugp2KCU4YtFLuoGSnrzpv+mpUTEzdn
        qXaUoeVcKoaPSD03Tk=
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 113.57.13.187
X-QQ-STYLE: 
X-QQ-mid: logic531t1635770147t9056710
From:   "=?utf-8?B?5bi45buJ5b+X?=" <changlianzhi@uniontech.com>
To:     "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>
Cc:     "=?utf-8?B?ZG1pdHJ5LnRvcm9raG92?=" <dmitry.torokhov@gmail.com>,
        "=?utf-8?B?R3JlZyBLSA==?=" <gregkh@linuxfoundation.org>,
        "=?utf-8?B?amlyaXNsYWJ5?=" <jirislaby@kernel.org>,
        "=?utf-8?B?QW5keSBTaGV2Y2hlbmtv?=" 
        <andriy.shevchenko@linux.intel.com>,
        "=?utf-8?B?MjgyODI3OTYx?=" <282827961@qq.com>
Subject: Re:[PATCH v9] tty: Fix the keyboard led light display problem
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Date:   Mon, 1 Nov 2021 20:35:47 +0800
X-Priority: 3
Message-ID: <tencent_10C69A8D3BC51F781F21A754@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
        by smtp.qq.com (ESMTP) with SMTP
        id ; Mon, 01 Nov 2021 20:35:48 +0800 (CST)
Feedback-ID: logic:uniontech.com:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTd2l0Y2hpbmcgZnJvbSB0aGUgZGVza3RvcCBlbnZpcm9ubWVudCB0byB0aGUgdHR5IGVu
dmlyb25tZW50LA0KPiB0aGUgc3RhdGUgb2YgdGhlIGtleWJvYXJkIGxlZCBsaWdodHMgYW5k
IHRoZSBzdGF0ZSBvZiB0aGUga2V5Ym9hcmQNCj4gbG9jayBhcmUgaW5jb25zaXN0ZW50LiBU
aGlzIGlzIGJlY2F1c2UgdGhlIGF0dHJpYnV0ZSBrYi0+a2JkbW9kZQ0KPiBvZiB0aGUgdHR5
IGJvdW5kIGluIHRoZSBkZXNrdG9wIGVudmlyb25tZW50IChYb3JnKSBpcyBzZXQgdG8NCj4g
VkNfT0ZGLCB3aGljaCBjYXVzZXMgdGhlIGxlZHN0YXRlIGFuZCBrYi0+bGVkZmxhZ3N0YXRl
DQo+IHZhbHVlcyBvZiB0aGUgYm91bmQgdHR5IHRvIGFsd2F5cyBiZSAwLCB3aGljaCBjYXVz
ZXMgdGhlIHN3aXRjaA0KPiBmcm9tIHRoZSBkZXNrdG9wIFdoZW4gdG8gdGhlIHR0eSBlbnZp
cm9ubWVudCwgdGhlIExFRCBsaWdodA0KPiBzdGF0dXMgaXMgaW5jb25zaXN0ZW50IHdpdGgg
dGhlIGtleWJvYXJkIGxvY2sgc3RhdHVzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogbGlhbnpo
aSBjaGFuZyA8Y2hhbmdsaWFuemhpQHVuaW9udGVjaC5jb20+DQo+IC0tLQ0KPiAgdjctLT52
ODoNCj4gIE9wdGltaXplIHRoZSBpbXBsZW1lbnRhdGlvbiBvZiBrYmRfdXBkYXRlX2xlZHN0
YXRlIGZ1bmN0aW9uDQogPiANCj4gIFdoeSBub3QgYWRvcHQgdGhlIG9waW5pb25zIG9mIEdy
ZWcgS0ggYW5kIEFuZHkgU2hldmNoZW5rbzoNCj4gICgxKSBJbiB0aGUgc3RydWN0dXJlIHN0
cnVjdCBpbnB1dF9kZXYsIHRoZSBkZWZpbml0aW9uIG9mIGxlZCBpcw0KPiAgbGlrZSB0aGlz
OiB1bnNpZ25lZCBsb25nIGxlZFtCSVRTX1RPX0xPTkdTKExFRF9DTlQpXTsgSWYgeW91DQo+
ICBkZWZpbmUgaXQgbGlrZSB0aGlzOiB1bnNpZ25lZCBsb25nIG5ld3N0YXRlID0gKmRldi0+
bGVkOyBJDQo+ICBhbHdheXMgZmVlbCB0aGF0IHRoZXJlIGlzIHN0aWxsIGJpZyBlbmQgYW5k
IExpdHRsZSBlbmRpYW4gcHJvYmxlbS4NCj4gICgyKSBUaGUgdGVzdF9iaXQgZnVuY3Rpb24g
aXMgdXNlZCB0byBhdm9pZCB0aGUgcHJvYmxlbSBvZiBsYXJnZQ0KPiAgYW5kIHNtYWxsIGVu
ZHMsIGFuZCB0aGUgY3VycmVudCBhbGdvcml0aG0gKHY4KSBhbHNvIGV4aXN0cw0KPiAgZWxz
ZXdoZXJlIGluIHRoZSBrZXJuZWw6IHRoZSBhdGtiZF9zZXRfbGVkcyBmdW5jdGlvbiAoZHJp
dmVycy8NCj4gIGlucHV0L2tleWJvYXJkL2F0a2JkLmMpLg0KPiAgKDMpIEluIHRoZSBjdXJy
ZW50IGtleWJvYXJkLmMgY29kZSwgdGhlIGNvZGUgaXMgYWxyZWFkeSB2ZXJ5IGdvb2QsDQo+
ICBhbmQgaXQgaXMgYWxyZWFkeSByZWxhdGl2ZWx5IGluZGVwZW5kZW50LiBJZiB5b3UgbW9k
aWZ5IHRoZSB0eXBlDQo+ICBvZiBsZWRzdGF0ZSB0byB1NjQgb3IgbW9kaWZ5IHRoZSBtYWNy
byBkZWZpbml0aW9ucyBzdWNoIGFzDQo+ICBWQ19OVU1MT0NLLCBpdCBmZWVscyB0aGF0IGl0
IGlzIG5vdCB2ZXJ5IG1lYW5pbmdmdWwsIGFuZCB0aGlzIEl0DQo+ICB3aWxsIGFsc28gY2F1
c2Ugb3RoZXIgcmVsYXRlZCBtb2RpZmljYXRpb25zLiBPZiBjb3Vyc2UsIHRoaXMgaXMNCj4g
IG9ubHkgbXkgY3VycmVudCBvcGluaW9uLiBJZiBldmVyeW9uZSBzdGlsbCBmZWVscyB0aGF0
IGl0IGlzDQo+ICBuZWNlc3NhcnkgdG8gbW9kaWZ5LCBJIHdpbGwgZG8gaXQgdGhpcyB3YXku
IE9mIGNvdXJzZSwgdGhpcw0KPiAgcHJvY2VzcyBtYXkgYmUgYSBiaXQgbG9uZ2VyLCBhbmQg
SSB0aGluayBpdCBpcyBuZWNlc3NhcnkgdG8NCj4gIGNvbmR1Y3QgbW9yZSB0ZXN0cy4NCj4g
IA0KPiAgdjk6IENoYW5nZSBkZXNjcmlwdGlvbiBpbmZvcm1hdGlvbjogeG9yZy0tPlhvcmcN
Cj4g4oCm4oCmDQoNCkhpLCBmcmllbmRzLCBJIHdvdWxkIGxpa2UgdG8gYXNrIHdoZXRoZXIg
dGhpcyB2ZXJzaW9uIG9mIHBhdGNoIGlzIHBvc3NpYmxlLCBpZiBub3QsDQpJIHdpbGwgdHJ5
IG15IGJlc3QgdG8gZmluZCBhIHdheSB0byBjb21wbGV0ZSB0aGUgbmV4dCB2ZXJzaW9uIQ0K
VGhhbmtzLg0KLS0NCmxpYW56aGkgY2hhbmc=



