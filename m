Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2C97387427
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 10:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242581AbhERIf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 04:35:27 -0400
Received: from sci-ig2.spreadtrum.com ([222.66.158.135]:30680 "EHLO
        SHSQR01.unisoc.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234924AbhERIf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 04:35:27 -0400
X-Greylist: delayed 4349 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 May 2021 04:35:26 EDT
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
        by SHSQR01.unisoc.com with ESMTP id 14I7LeTP065558
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 15:21:40 +0800 (CST)
        (envelope-from nianfu.bai@unisoc.com)
Received: from ig2.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id 14I7JBos053764
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NO);
        Tue, 18 May 2021 15:19:11 +0800 (CST)
        (envelope-from nianfu.bai@unisoc.com)
Received: from BJMBX01.spreadtrum.com (10.0.64.7) by BJMBX01.spreadtrum.com
 (10.0.64.7) with Microsoft SMTP Server (TLS) id 15.0.847.32; Tue, 18 May 2021
 15:18:32 +0800
Received: from BJMBX01.spreadtrum.com ([fe80::54e:9a:129d:fac7]) by
 BJMBX01.spreadtrum.com ([fe80::54e:9a:129d:fac7%16]) with mapi id
 15.00.0847.030; Tue, 18 May 2021 15:18:31 +0800
From:   =?gb2312?B?sNjE6rijIChOaWFuZnUgQmFpKQ==?= <nianfu.bai@unisoc.com>
To:     Nianfu Bai <bnf20061983@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?gb2312?B?1cXI8LflIChSdWlmZW5nIFpoYW5nLzEwMDQwKQ==?= 
        <Ruifeng.Zhang1@unisoc.com>,
        =?gb2312?B?tdS+qSAoT3Jzb24gWmhhaSk=?= <Orson.Zhai@unisoc.com>,
        =?gb2312?B?1cW0utHeIChDaHVueWFuIFpoYW5nKQ==?= 
        <Chunyan.Zhang@unisoc.com>, "gregkh@google.com" <gregkh@google.com>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXSBjbG9ja3NvdXJjZS9kcml2ZXJzL3NwcmQ6IFJlbW92?=
 =?gb2312?B?ZSB0aGUgZGVwZW5kZW5jeSBiZXR3ZWVuIHNwcmQgdGltZXIgYW5kIFNQUkQg?=
 =?gb2312?Q?arch?=
Thread-Topic: [PATCH] clocksource/drivers/sprd: Remove the dependency
 between sprd timer and SPRD arch
Thread-Index: AQHXRjScSYlT3oAfGkyqurgtH5RD26ro3Aky
Date:   Tue, 18 May 2021 07:18:31 +0000
Message-ID: <48327b8bb2dc4006bb943a3bbb7d99ad@BJMBX01.spreadtrum.com>
References: <1620716925-4329-1-git-send-email-bnf20061983@gmail.com>
In-Reply-To: <1620716925-4329-1-git-send-email-bnf20061983@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.0.93.65]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MAIL: SHSQR01.spreadtrum.com 14I7JBos053764
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBHcmVna2gsDQoNClBscyBoZWxwIHRvIHJldmlldyB0aGlzIHBhdGNoIGFzIEFuZHJvaWQg
MTIgazUuNCBHS0kgcmVxdWlyZW1lbnQuDQoNClRoYW5rcy4NCg0KDQoNCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18NCreivP7IyzogTmlhbmZ1IEJhaSA8Ym5mMjAwNjE5
ODNAZ21haWwuY29tPg0Kt6LLzcqxvOQ6IDIwMjHE6jXUwjExyNUgMTU6MDgNCsrVvP7IyzogZGFu
aWVsLmxlemNhbm9AbGluYXJvLm9yZzsgdGdseEBsaW51dHJvbml4LmRlDQqzrcvNOiBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnOyCw2MTquKMgKE5pYW5mdSBCYWkpOyDVxcjwt+UgKFJ1aWZl
bmcgWmhhbmcvMTAwNDApDQrW98ziOiBbUEFUQ0hdIGNsb2Nrc291cmNlL2RyaXZlcnMvc3ByZDog
UmVtb3ZlIHRoZSBkZXBlbmRlbmN5IGJldHdlZW4gc3ByZCB0aW1lciBhbmQgU1BSRCBhcmNoDQoN
CkZyb206IE5pYW5mdSBCYWkgPG5pYW5mdS5iYWlAdW5pc29jLmNvbT4NCg0KVGljayBicm9hZGNh
c3QgaW5zdGFsbGVkIGJ5IGluc21vZCBjYW5ub3Qgc3dpdGNoIHRvIG9uZXNob3QgbW9kZSBjb3Jy
ZWN0bHkNCmNhdXNlZCBieSBsaW51eCB0aW1lciBmcmFtZXdvcmssIG5lZWQgdG8gYnVpbGQgaW4g
a2VybmVsIGltYWdlLiBTUFJEX1RJTUVSDQpoYXMgYmVlbiBzZWxlY3RlZCBieSBTUFJEIGFyY2gs
IHdlIGhhdmUgdG8gZW5hYmxlIFNQUkQgYXJjaCB3aGVuIHdlIGJ1aWxkDQpzcHJkIHRpbWVyIGlu
IGtlcm5lbCBpbWFnZSwgdGhpcyBhY3Rpb24gY29uZmxpY3RzIHdpdGggZ2VuZXJhbCBrZXJuZWwg
aW1hZ2UsDQpzbyB3ZSBuZWVkIHRvIHJlbW92ZSB0aGUgZGVwZW5kZW5jeSBiZXR3ZWVuIHNwcmQg
dGltZXIgYW5kIFNQUkQgYXJjaC4NCg0KU2lnbmVkLW9mZi1ieTogTmlhbmZ1IEJhaSA8bmlhbmZ1
LmJhaUB1bmlzb2MuY29tPg0KU2lnbmVkLW9mZi1ieTogUnVpZmVuZyBaaGFuZyA8cnVpZmVuZy56
aGFuZzFAdW5pc29jLmNvbT4NCi0tLQ0KIGRyaXZlcnMvY2xvY2tzb3VyY2UvS2NvbmZpZyB8IDQg
Ky0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMyBkZWxldGlvbnMoLSkNCg0K
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xvY2tzb3VyY2UvS2NvbmZpZyBiL2RyaXZlcnMvY2xvY2tz
b3VyY2UvS2NvbmZpZw0KaW5kZXggMzlhYTIxZC4uMDRiMzMzYyAxMDA2NDQNCi0tLSBhL2RyaXZl
cnMvY2xvY2tzb3VyY2UvS2NvbmZpZw0KKysrIGIvZHJpdmVycy9jbG9ja3NvdXJjZS9LY29uZmln
DQpAQCAtNDQ3LDEwICs0NDcsOCBAQCBjb25maWcgTVRLX1RJTUVSDQogICAgICAgICAgU3VwcG9y
dCBmb3IgTWVkaWF0ZWsgdGltZXIgZHJpdmVyLg0KDQogY29uZmlnIFNQUkRfVElNRVINCi0gICAg
ICAgYm9vbCAiU3ByZWFkdHJ1bSB0aW1lciBkcml2ZXIiIGlmIEVYUEVSVA0KKyAgICAgICBib29s
ICJTcHJlYWR0cnVtIHRpbWVyIGRyaXZlciIgaWYgQ09NUElMRV9URVNUDQogICAgICAgIGRlcGVu
ZHMgb24gSEFTX0lPTUVNDQotICAgICAgIGRlcGVuZHMgb24gKEFSQ0hfU1BSRCB8fCBDT01QSUxF
X1RFU1QpDQotICAgICAgIGRlZmF1bHQgQVJDSF9TUFJEDQogICAgICAgIHNlbGVjdCBUSU1FUl9P
Rg0KICAgICAgICBoZWxwDQogICAgICAgICAgRW5hYmxlcyBzdXBwb3J0IGZvciB0aGUgU3ByZWFk
dHJ1bSB0aW1lciBkcml2ZXIuDQotLQ0KMS45LjENCg0KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18NCiBUaGlzIGVtYWlsIChpbmNsdWRpbmcgaXRzIGF0dGFjaG1lbnRzKSBpcyBpbnRl
bmRlZCBvbmx5IGZvciB0aGUgcGVyc29uIG9yIGVudGl0eSB0byB3aGljaCBpdCBpcyBhZGRyZXNz
ZWQgYW5kIG1heSBjb250YWluIGluZm9ybWF0aW9uIHRoYXQgaXMgcHJpdmlsZWdlZCwgY29uZmlk
ZW50aWFsIG9yIG90aGVyd2lzZSBwcm90ZWN0ZWQgZnJvbSBkaXNjbG9zdXJlLiBVbmF1dGhvcml6
ZWQgdXNlLCBkaXNzZW1pbmF0aW9uLCBkaXN0cmlidXRpb24gb3IgY29weWluZyBvZiB0aGlzIGVt
YWlsIG9yIHRoZSBpbmZvcm1hdGlvbiBoZXJlaW4gb3IgdGFraW5nIGFueSBhY3Rpb24gaW4gcmVs
aWFuY2Ugb24gdGhlIGNvbnRlbnRzIG9mIHRoaXMgZW1haWwgb3IgdGhlIGluZm9ybWF0aW9uIGhl
cmVpbiwgYnkgYW55b25lIG90aGVyIHRoYW4gdGhlIGludGVuZGVkIHJlY2lwaWVudCwgb3IgYW4g
ZW1wbG95ZWUgb3IgYWdlbnQgcmVzcG9uc2libGUgZm9yIGRlbGl2ZXJpbmcgdGhlIG1lc3NhZ2Ug
dG8gdGhlIGludGVuZGVkIHJlY2lwaWVudCwgaXMgc3RyaWN0bHkgcHJvaGliaXRlZC4gSWYgeW91
IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIGRvIG5vdCByZWFkLCBjb3B5
LCB1c2Ugb3IgZGlzY2xvc2UgYW55IHBhcnQgb2YgdGhpcyBlLW1haWwgdG8gb3RoZXJzLiBQbGVh
c2Ugbm90aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRlbHkgYW5kIHBlcm1hbmVudGx5IGRlbGV0ZSB0
aGlzIGUtbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRzIGlmIHlvdSByZWNlaXZlZCBpdCBpbiBlcnJv
ci4gSW50ZXJuZXQgY29tbXVuaWNhdGlvbnMgY2Fubm90IGJlIGd1YXJhbnRlZWQgdG8gYmUgdGlt
ZWx5LCBzZWN1cmUsIGVycm9yLWZyZWUgb3IgdmlydXMtZnJlZS4gVGhlIHNlbmRlciBkb2VzIG5v
dCBhY2NlcHQgbGlhYmlsaXR5IGZvciBhbnkgZXJyb3JzIG9yIG9taXNzaW9ucy4NCrG+08q8/ryw
xuS4vbz+vt/T0LGjw9zQ1NbKo6zK3Leowsmxo7uksru1w9C5wrajrL32t6LLzbj4sb7Tyrz+y/nW
uMzYtqjK1bz+yMuho9HPvfu3x76tytrIqMq508OhotD7tKuhoreisry78ri01saxvtPKvP678sbk
xNrI3aGjyPS3x7jDzNi2qMrVvP7Iy6Osx+vO8NTEtsGhori01sahoiDKudPDu/LF+8K2sb7Tyrz+
tcTIzrrOxNrI3aGjyPTO88rVsb7Tyrz+o6zH67TTz7XNs9bQ08C+w9DUyb6z/bG+08q8/rywy/nT
0Li9vP6jrLKi0tS72Li008q8/rXEt73Kvby0v8y45taqt6K8/sjLoaPO3reosaPWpLulwarN+M2o
0MW8sMqxoaKwssiroaLO3s7zu/K3wLa+oaO3orz+yMu21MjOus607cKpvvmyu7PQtaPU8MjOoaMN
Cg==
