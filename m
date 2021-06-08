Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0432939EC6F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 04:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbhFHC64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 22:58:56 -0400
Received: from sci-ig2.spreadtrum.com ([222.66.158.135]:38711 "EHLO
        SHSQR01.spreadtrum.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S230514AbhFHC6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 22:58:55 -0400
Received: from ig2.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
        by SHSQR01.spreadtrum.com with ESMTPS id 1582uFwu011898
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 8 Jun 2021 10:56:15 +0800 (CST)
        (envelope-from nianfu.bai@unisoc.com)
Received: from BJMBX01.spreadtrum.com (10.0.64.7) by BJMBX02.spreadtrum.com
 (10.0.64.8) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 8 Jun 2021
 10:55:23 +0800
Received: from BJMBX01.spreadtrum.com ([fe80::54e:9a:129d:fac7]) by
 BJMBX01.spreadtrum.com ([fe80::54e:9a:129d:fac7%16]) with mapi id
 15.00.1497.018; Tue, 8 Jun 2021 10:55:23 +0800
From:   =?gb2312?B?sNjE6rijIChOaWFuZnUgQmFpKQ==?= <nianfu.bai@unisoc.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Nianfu Bai <bnf20061983@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?gb2312?B?1cXI8LflIChSdWlmZW5nIFpoYW5nLzEwMDQwKQ==?= 
        <Ruifeng.Zhang1@unisoc.com>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXSBjbG9ja3NvdXJjZS9kcml2ZXJzL3NwcmQ6IFJlbW92?=
 =?gb2312?B?ZSB0aGUgZGVwZW5kZW5jeSBiZXR3ZWVuIHNwcmQgdGltZXIgYW5kIFNQUkQg?=
 =?gb2312?Q?arch?=
Thread-Topic: [PATCH] clocksource/drivers/sprd: Remove the dependency between
 sprd timer and SPRD arch
Thread-Index: AQHXRjScSYlT3oAfGkyqurgtH5RD26sDI6sAgAZyabw=
Date:   Tue, 8 Jun 2021 02:55:23 +0000
Message-ID: <1623120924545.61863@unisoc.com>
References: <1620716925-4329-1-git-send-email-bnf20061983@gmail.com>,<aac6c6a3-6666-075a-6901-7e3c3b2ae01d@linaro.org>
In-Reply-To: <aac6c6a3-6666-075a-6901-7e3c3b2ae01d@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.93.65]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MAIL: SHSQR01.spreadtrum.com 1582uFwu011898
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMDUvMjAyMSAwOTowOCwgTmlhbmZ1IEJhaSB3cm90ZToNCj4gRnJvbTogTmlhbmZ1IEJh
aSA8bmlhbmZ1LmJhaUB1bmlzb2MuY29tPg0KPg0KPiBUaWNrIGJyb2FkY2FzdCBpbnN0YWxsZWQg
YnkgaW5zbW9kIGNhbm5vdCBzd2l0Y2ggdG8gb25lc2hvdCBtb2RlIGNvcnJlY3RseQ0KPiBjYXVz
ZWQgYnkgbGludXggdGltZXIgZnJhbWV3b3JrLCBuZWVkIHRvIGJ1aWxkIGluIGtlcm5lbCBpbWFn
ZS4NCg0KV2hhdCB0aW1lciBpcyBjb21waWxlZCBhcyBhIG1vZHVsZT8NCj5XZSB3YW50IHRvIGNv
bXBpbGUgc3ByZCB0aW1lciAgYXMgYSBtb2R1bGUuDQoNCldoeSB0aGUgdGltZXIgZnJhbWV3b3Jr
IGRvZXMgbm90IGFsbG93IHRvIHN3aXRjaCB0byBpdCA/DQo+UGxzIHJlZmVyIHRvIHRoZSBwYXRj
aCBkZXNjcmlwdGlvbiBkZWJsb3c6DQpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzE2MTg2
MDAwNzU4Ny4yOTc5Ni43MTAwMjYyMDIxMTE4Njg1NTYzLnRpcC1ib3QyQHRpcC1ib3QyLw0KDQoN
Cg0KPiBTUFJEX1RJTUVSDQo+IGhhcyBiZWVuIHNlbGVjdGVkIGJ5IFNQUkQgYXJjaCwgd2UgaGF2
ZSB0byBlbmFibGUgU1BSRCBhcmNoIHdoZW4gd2UgYnVpbGQNCj4gc3ByZCB0aW1lciBpbiBrZXJu
ZWwgaW1hZ2UsIHRoaXMgYWN0aW9uIGNvbmZsaWN0cyB3aXRoIGdlbmVyYWwga2VybmVsIGltYWdl
LA0KDQpXaHkgdGhpcyBpcyBjb25mbGljdGluZyB3aXRoIGdlbmVyYWwga2VybmVsIGltYWdlPw0K
DQo+IHNvIHdlIG5lZWQgdG8gcmVtb3ZlIHRoZSBkZXBlbmRlbmN5IGJldHdlZW4gc3ByZCB0aW1l
ciBhbmQgU1BSRCBhcmNoLg0KDQpDYW4geW91IHJlcGhyYXNlIHRoZSBjaGFuZ2Vsb2csIEknbSBu
b3QgZ2V0dGluZyB0aGUgcG9pbnQuDQoNCj4gU2lnbmVkLW9mZi1ieTogTmlhbmZ1IEJhaSA8bmlh
bmZ1LmJhaUB1bmlzb2MuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBSdWlmZW5nIFpoYW5nIDxydWlm
ZW5nLnpoYW5nMUB1bmlzb2MuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvY2xvY2tzb3VyY2UvS2Nv
bmZpZyB8IDQgKy0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAzIGRlbGV0
aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbG9ja3NvdXJjZS9LY29uZmlnIGIv
ZHJpdmVycy9jbG9ja3NvdXJjZS9LY29uZmlnDQo+IGluZGV4IDM5YWEyMWQuLjA0YjMzM2MgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvY2xvY2tzb3VyY2UvS2NvbmZpZw0KPiArKysgYi9kcml2ZXJz
L2Nsb2Nrc291cmNlL0tjb25maWcNCj4gQEAgLTQ0NywxMCArNDQ3LDggQEAgY29uZmlnIE1US19U
SU1FUg0KPiAgICAgICAgIFN1cHBvcnQgZm9yIE1lZGlhdGVrIHRpbWVyIGRyaXZlci4NCj4NCj4g
IGNvbmZpZyBTUFJEX1RJTUVSDQo+IC0gICAgIGJvb2wgIlNwcmVhZHRydW0gdGltZXIgZHJpdmVy
IiBpZiBFWFBFUlQNCj4gKyAgICAgYm9vbCAiU3ByZWFkdHJ1bSB0aW1lciBkcml2ZXIiIGlmIENP
TVBJTEVfVEVTVA0KPiAgICAgICBkZXBlbmRzIG9uIEhBU19JT01FTQ0KPiAtICAgICBkZXBlbmRz
IG9uIChBUkNIX1NQUkQgfHwgQ09NUElMRV9URVNUKQ0KPiAtICAgICBkZWZhdWx0IEFSQ0hfU1BS
RA0KPiAgICAgICBzZWxlY3QgVElNRVJfT0YNCj4gICAgICAgaGVscA0KPiAgICAgICAgIEVuYWJs
ZXMgc3VwcG9ydCBmb3IgdGhlIFNwcmVhZHRydW0gdGltZXIgZHJpdmVyLg0KPg0KDQoNCi0tDQo8
aHR0cDovL3d3dy5saW5hcm8ub3JnLz4gTGluYXJvLm9yZyCppiBPcGVuIHNvdXJjZSBzb2Z0d2Fy
ZSBmb3IgQVJNIFNvQ3MNCg0KRm9sbG93IExpbmFybzogIDxodHRwOi8vd3d3LmZhY2Vib29rLmNv
bS9wYWdlcy9MaW5hcm8+IEZhY2Vib29rIHwNCjxodHRwOi8vdHdpdHRlci5jb20vIyEvbGluYXJv
b3JnPiBUd2l0dGVyIHwNCjxodHRwOi8vd3d3LmxpbmFyby5vcmcvbGluYXJvLWJsb2cvPiBCbG9n
DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KIFRoaXMgZW1haWwgKGluY2x1ZGlu
ZyBpdHMgYXR0YWNobWVudHMpIGlzIGludGVuZGVkIG9ubHkgZm9yIHRoZSBwZXJzb24gb3IgZW50
aXR5IHRvIHdoaWNoIGl0IGlzIGFkZHJlc3NlZCBhbmQgbWF5IGNvbnRhaW4gaW5mb3JtYXRpb24g
dGhhdCBpcyBwcml2aWxlZ2VkLCBjb25maWRlbnRpYWwgb3Igb3RoZXJ3aXNlIHByb3RlY3RlZCBm
cm9tIGRpc2Nsb3N1cmUuIFVuYXV0aG9yaXplZCB1c2UsIGRpc3NlbWluYXRpb24sIGRpc3RyaWJ1
dGlvbiBvciBjb3B5aW5nIG9mIHRoaXMgZW1haWwgb3IgdGhlIGluZm9ybWF0aW9uIGhlcmVpbiBv
ciB0YWtpbmcgYW55IGFjdGlvbiBpbiByZWxpYW5jZSBvbiB0aGUgY29udGVudHMgb2YgdGhpcyBl
bWFpbCBvciB0aGUgaW5mb3JtYXRpb24gaGVyZWluLCBieSBhbnlvbmUgb3RoZXIgdGhhbiB0aGUg
aW50ZW5kZWQgcmVjaXBpZW50LCBvciBhbiBlbXBsb3llZSBvciBhZ2VudCByZXNwb25zaWJsZSBm
b3IgZGVsaXZlcmluZyB0aGUgbWVzc2FnZSB0byB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBpcyBz
dHJpY3RseSBwcm9oaWJpdGVkLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50
LCBwbGVhc2UgZG8gbm90IHJlYWQsIGNvcHksIHVzZSBvciBkaXNjbG9zZSBhbnkgcGFydCBvZiB0
aGlzIGUtbWFpbCB0byBvdGhlcnMuIFBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBpbW1lZGlhdGVs
eSBhbmQgcGVybWFuZW50bHkgZGVsZXRlIHRoaXMgZS1tYWlsIGFuZCBhbnkgYXR0YWNobWVudHMg
aWYgeW91IHJlY2VpdmVkIGl0IGluIGVycm9yLiBJbnRlcm5ldCBjb21tdW5pY2F0aW9ucyBjYW5u
b3QgYmUgZ3VhcmFudGVlZCB0byBiZSB0aW1lbHksIHNlY3VyZSwgZXJyb3ItZnJlZSBvciB2aXJ1
cy1mcmVlLiBUaGUgc2VuZGVyIGRvZXMgbm90IGFjY2VwdCBsaWFiaWxpdHkgZm9yIGFueSBlcnJv
cnMgb3Igb21pc3Npb25zLg0Ksb7Tyrz+vLDG5Li9vP6+39PQsaPD3NDU1sqjrMrct6jCybGju6Sy
u7XD0LnCtqOsvfa3osvNuPixvtPKvP7L+da4zNi2qMrVvP7Iy6Gj0c+9+7fHvq3K2sioyrnTw6Gi
0Pu0q6Git6KyvLvyuLTWxrG+08q8/rvyxuTE2sjdoaPI9LfHuMPM2LaoytW8/sjLo6zH687w1MS2
waGiuLTWxqGiIMq508O78sX7wraxvtPKvP61xMjOus7E2sjdoaPI9M7zytWxvtPKvP6jrMfrtNPP
tc2z1tDTwL7D0NTJvrP9sb7Tyrz+vLDL+dPQuL28/qOssqLS1LvYuLTTyrz+tcS3vcq9vLS/zLjm
1qq3orz+yMuho87et6ixo9aku6XBqs34zajQxbywyrGhorCyyKuhos7ezvO78rfAtr6ho7eivP7I
y7bUyM66zrTtwqm++bK7s9C1o9TwyM6how0K
