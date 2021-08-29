Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91CC13FAEA2
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 23:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235976AbhH2VKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 17:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbhH2VKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 17:10:13 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0CAC061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 14:09:20 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 7CD62891B0;
        Mon, 30 Aug 2021 09:09:15 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1630271355;
        bh=VnkWPQhyyug5hprqm7LsbCGfQjYHuLuVhJZOwze0AbU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=bUsYM3qLl285Kj3f0WaHCze0Vd+SG+euOfCbvFppmDNRhzdevPElc8K8+dwrVXM8a
         xUOUCKNCMduekg+cDTbGmvIzaXpNvHyWkfyYStZWmCr012zgShSb8Wi72ALVRVYgpE
         jDvqLWs0XOTkCWLOhRSP0XTKOnpWmz4KBPv2J1oWEwt0QyF1bxWTFyFBGHfg19Kelg
         3wU+h6BaRzNGJjgssbATXlZMECvuYlZB2G1HCDqgXeSb2yDe3xlmW9nNHRHseAWDVY
         MHzx+DxJG8ZOxbeYBX17UlDIZ7bh6/VKbYtRe4LwYFqYIWMTiE1oXMkLPby/JrgAgY
         PInpTKwjqwMxA==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B612bf77b0001>; Mon, 30 Aug 2021 09:09:15 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Mon, 30 Aug 2021 09:09:15 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.023; Mon, 30 Aug 2021 09:09:15 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] hwmon: (adt7470) Use standard update_interval
 property
Thread-Topic: [PATCH v2 4/4] hwmon: (adt7470) Use standard update_interval
 property
Thread-Index: AQHXmiPcXguJzdIxPU+IRgUO+WiCqKuHF9kAgAMe8gA=
Date:   Sun, 29 Aug 2021 21:09:14 +0000
Message-ID: <fe6cf9f3-f15e-065c-aaf8-cc018edf12e8@alliedtelesis.co.nz>
References: <20210826024121.15665-1-chris.packham@alliedtelesis.co.nz>
 <20210826024121.15665-5-chris.packham@alliedtelesis.co.nz>
 <20210827212942.GA716764@roeck-us.net>
In-Reply-To: <20210827212942.GA716764@roeck-us.net>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <84619D75A83A574B88ADE9A8B8C07CFD@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=aqTM9hRV c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=MhDmnRu9jo8A:10 a=FA2AwYT2YXNTt5OFVpQA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAyOC8wOC8yMSA5OjI5IGFtLCBHdWVudGVyIFJvZWNrIHdyb3RlOg0KPiBPbiBUaHUsIEF1
ZyAyNiwgMjAyMSBhdCAwMjo0MToyMVBNICsxMjAwLCBDaHJpcyBQYWNraGFtIHdyb3RlOg0KPj4g
SW5zdGVhZCBvZiB0aGUgbm9uLXN0YW5kYXJkIGF1dG9fdXBkYXRlX2ludGVydmFsIG1ha2UgdXNl
IG9mIHRoZQ0KPj4gdXBkYXRlX2ludGVydmFsIHByb3BlcnR5IHRoYXQgaXMgc3VwcG9ydGVkIGJ5
IHRoZSBod21vbiBjb3JlLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IENocmlzIFBhY2toYW0gPGNo
cmlzLnBhY2toYW1AYWxsaWVkdGVsZXNpcy5jby5uej4NCj4+IC0tLQ0KPj4NCj4+IE5vdGVzOg0K
Pj4gICAgICBJIGtpbmQgb2YgYW50aWNpcGF0ZSBhIE5BSyBvbiB0aGlzIGJlY2F1c2UgaXQgYWZm
ZWN0cyB0aGUgQUJJLiBCdXQgSSBmaWd1cmVkDQo+PiAgICAgIEknZCBydW4gaXQgcGFzdCB0aGUg
TUwgdG8gc2VlIGlmIG1vdmluZyB0b3dhcmRzIHRoZSBod21vbiBjb3JlIGlzIHdvcnRoIHRoZSBo
aXQNCj4+ICAgICAgaW4gQUJJIGNvbXBhdGliaWxpdHkuDQo+PiAgICAgIA0KPiBJIHBlcnNvbmFs
bHkgZG9uJ3QgbWluZCAobW9zdCBsaWtlbHkgbm8gb25lIGlzIHVzaW5nIGl0IGFueXdheSksIGJ1
dCBsZXQncw0KPiB3YWl0IHVudGlsIGFmdGVyIHRoZSB1cGNvbWluZyBjb21taXQgd2luZG93IGNs
b3NlcyB0byBnaXZlIHBlb3BsZSB0aW1lIHRvDQo+IGNvbXBsYWluLg0KDQpJIGtub3cgb2Ygb25l
IGFwcGxpY2F0aW9uIHVzaW5nIHRoaXMgc3lzZnMgZW50cnkuIEJ1dCBpdCdzIG91ciBpbi1ob3Vz
ZSANCmVudmlyb25tZW50YWwgbW9uaXRvcmluZyBjb2RlIHNvIGlmIHRoaXMgZ2V0cyBtZXJnZWQg
SSdsbCBqdXN0IHVwZGF0ZSBpdCANCnRvIHVzZSB0aGUgbmV3IHBhdGguDQoNCk9uZSB0aG91Z2h0
IEkgaGFkIHdhcyB3ZSBjb3VsZCBkbyBib3RoLiBpLmUuIGhhdmUgYW4gZW50cnkgdGhhdCBjb25m
b3JtcyANCnRvIHRoZSBod21vbiBjb3JlIGFuZCBhIGJhY2t3YXJkcyBjb21wYXRpYmxlIGVudHJ5
IHRoYXQganVzdCBhbGlhc2VzIHRoZSANCm5ldyBwYXRoLg0KDQo+DQo+IEd1ZW50ZXINCj4NCj4+
ICAgICAgQ2hhbmdlcyBpbiB2MjoNCj4+ICAgICAgLSBub25lDQo+Pg0KPj4gICBkcml2ZXJzL2h3
bW9uL2FkdDc0NzAuYyB8IDY0ICsrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0t
LS0tDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAzOSBpbnNlcnRpb25zKCspLCAyNSBkZWxldGlvbnMo
LSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9od21vbi9hZHQ3NDcwLmMgYi9kcml2ZXJz
L2h3bW9uL2FkdDc0NzAuYw0KPj4gaW5kZXggZGIxOWE1MmIxM2RlLi43YWZiZDFlNDcyMWUgMTAw
NjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2h3bW9uL2FkdDc0NzAuYw0KPj4gKysrIGIvZHJpdmVycy9o
d21vbi9hZHQ3NDcwLmMNCj4+IEBAIC00NjksMzUgKzQ2OSwzNyBAQCBzdGF0aWMgc3RydWN0IGFk
dDc0NzBfZGF0YSAqYWR0NzQ3MF91cGRhdGVfZGV2aWNlKHN0cnVjdCBkZXZpY2UgKmRldikNCj4+
ICAgCXJldHVybiBlcnIgPCAwID8gRVJSX1BUUihlcnIpIDogZGF0YTsNCj4+ICAgfQ0KPj4gICAN
Cj4+IC1zdGF0aWMgc3NpemVfdCBhdXRvX3VwZGF0ZV9pbnRlcnZhbF9zaG93KHN0cnVjdCBkZXZp
Y2UgKmRldiwNCj4+IC0JCQkJCSBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqZGV2YXR0ciwNCj4+
IC0JCQkJCSBjaGFyICpidWYpDQo+PiAtew0KPj4gLQlzdHJ1Y3QgYWR0NzQ3MF9kYXRhICpkYXRh
ID0gYWR0NzQ3MF91cGRhdGVfZGV2aWNlKGRldik7DQo+PiAtDQo+PiAtCWlmIChJU19FUlIoZGF0
YSkpDQo+PiAtCQlyZXR1cm4gUFRSX0VSUihkYXRhKTsNCj4+IC0NCj4+IC0JcmV0dXJuIHNwcmlu
dGYoYnVmLCAiJWRcbiIsIGRhdGEtPmF1dG9fdXBkYXRlX2ludGVydmFsKTsNCj4+IC19DQo+PiAt
DQo+PiAtc3RhdGljIHNzaXplX3QgYXV0b191cGRhdGVfaW50ZXJ2YWxfc3RvcmUoc3RydWN0IGRl
dmljZSAqZGV2LA0KPj4gLQkJCQkJICBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqZGV2YXR0ciwN
Cj4+IC0JCQkJCSAgY29uc3QgY2hhciAqYnVmLCBzaXplX3QgY291bnQpDQo+PiArc3RhdGljIGlu
dCBhZHQ3NDcwX2NoaXBfcmVhZChzdHJ1Y3QgZGV2aWNlICpkZXYsIHUzMiBhdHRyLCBsb25nICp2
YWwpDQo+PiAgIHsNCj4+ICAgCXN0cnVjdCBhZHQ3NDcwX2RhdGEgKmRhdGEgPSBkZXZfZ2V0X2Ry
dmRhdGEoZGV2KTsNCj4+IC0JbG9uZyB0ZW1wOw0KPj4gICANCj4+IC0JaWYgKGtzdHJ0b2woYnVm
LCAxMCwgJnRlbXApKQ0KPj4gLQkJcmV0dXJuIC1FSU5WQUw7DQo+PiArCXN3aXRjaCAoYXR0cikg
ew0KPj4gKwljYXNlIGh3bW9uX2NoaXBfdXBkYXRlX2ludGVydmFsOg0KPj4gKwkJKnZhbCA9IGRh
dGEtPmF1dG9fdXBkYXRlX2ludGVydmFsOw0KPj4gKwkJYnJlYWs7DQo+PiArCWRlZmF1bHQ6DQo+
PiArCQlyZXR1cm4gLUVPUE5PVFNVUFA7DQo+PiArCX0NCj4+ICAgDQo+PiAtCXRlbXAgPSBjbGFt
cF92YWwodGVtcCwgMCwgNjAwMDApOw0KPj4gKwlyZXR1cm4gMDsNCj4+ICt9DQo+PiAgIA0KPj4g
LQltdXRleF9sb2NrKCZkYXRhLT5sb2NrKTsNCj4+IC0JZGF0YS0+YXV0b191cGRhdGVfaW50ZXJ2
YWwgPSB0ZW1wOw0KPj4gLQltdXRleF91bmxvY2soJmRhdGEtPmxvY2spOw0KPj4gK3N0YXRpYyBp
bnQgYWR0NzQ3MF9jaGlwX3dyaXRlKHN0cnVjdCBkZXZpY2UgKmRldiwgdTMyIGF0dHIsIGxvbmcg
dmFsKQ0KPj4gK3sNCj4+ICsJc3RydWN0IGFkdDc0NzBfZGF0YSAqZGF0YSA9IGRldl9nZXRfZHJ2
ZGF0YShkZXYpOw0KPj4gICANCj4+IC0JcmV0dXJuIGNvdW50Ow0KPj4gKwlzd2l0Y2ggKGF0dHIp
IHsNCj4+ICsJY2FzZSBod21vbl9jaGlwX3VwZGF0ZV9pbnRlcnZhbDoNCj4+ICsJCXZhbCA9IGNs
YW1wX3ZhbCh2YWwsIDAsIDYwMDAwKTsNCj4+ICsJCW11dGV4X2xvY2soJmRhdGEtPmxvY2spOw0K
Pj4gKwkJZGF0YS0+YXV0b191cGRhdGVfaW50ZXJ2YWwgPSB2YWw7DQo+PiArCQltdXRleF91bmxv
Y2soJmRhdGEtPmxvY2spOw0KPj4gKwkJYnJlYWs7DQo+PiArCWRlZmF1bHQ6DQo+PiArCQlyZXR1
cm4gLUVPUE5PVFNVUFA7DQo+PiArCX0NCj4+ICsNCj4+ICsJcmV0dXJuIDA7DQo+PiAgIH0NCj4+
ICAgDQo+PiAgIHN0YXRpYyBzc2l6ZV90IG51bV90ZW1wX3NlbnNvcnNfc2hvdyhzdHJ1Y3QgZGV2
aWNlICpkZXYsDQo+PiBAQCAtMTAzNCw3ICsxMDM2LDYgQEAgc3RhdGljIHNzaXplX3QgcHdtX2F1
dG9fdGVtcF9zdG9yZShzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+PiAgIA0KPj4gICBzdGF0aWMgREVW
SUNFX0FUVFJfUlcoYWxhcm1fbWFzayk7DQo+PiAgIHN0YXRpYyBERVZJQ0VfQVRUUl9SVyhudW1f
dGVtcF9zZW5zb3JzKTsNCj4+IC1zdGF0aWMgREVWSUNFX0FUVFJfUlcoYXV0b191cGRhdGVfaW50
ZXJ2YWwpOw0KPj4gICANCj4+ICAgc3RhdGljIFNFTlNPUl9ERVZJQ0VfQVRUUl9SVyhmb3JjZV9w
d21fbWF4LCBmb3JjZV9wd21fbWF4LCAwKTsNCj4+ICAgDQo+PiBAQCAtMTA2Niw3ICsxMDY3LDYg
QEAgc3RhdGljIFNFTlNPUl9ERVZJQ0VfQVRUUl9SVyhwd200X2F1dG9fY2hhbm5lbHNfdGVtcCwg
cHdtX2F1dG9fdGVtcCwgMyk7DQo+PiAgIHN0YXRpYyBzdHJ1Y3QgYXR0cmlidXRlICphZHQ3NDcw
X2F0dHJzW10gPSB7DQo+PiAgIAkmZGV2X2F0dHJfYWxhcm1fbWFzay5hdHRyLA0KPj4gICAJJmRl
dl9hdHRyX251bV90ZW1wX3NlbnNvcnMuYXR0ciwNCj4+IC0JJmRldl9hdHRyX2F1dG9fdXBkYXRl
X2ludGVydmFsLmF0dHIsDQo+PiAgIAkmc2Vuc29yX2Rldl9hdHRyX2ZvcmNlX3B3bV9tYXguZGV2
X2F0dHIuYXR0ciwNCj4+ICAgCSZzZW5zb3JfZGV2X2F0dHJfcHdtMV9hdXRvX3BvaW50MV9wd20u
ZGV2X2F0dHIuYXR0ciwNCj4+ICAgCSZzZW5zb3JfZGV2X2F0dHJfcHdtMl9hdXRvX3BvaW50MV9w
d20uZGV2X2F0dHIuYXR0ciwNCj4+IEBAIC0xMDk3LDYgKzEwOTcsOCBAQCBzdGF0aWMgaW50IGFk
dDc0NzBfcmVhZChzdHJ1Y3QgZGV2aWNlICpkZXYsIGVudW0gaHdtb25fc2Vuc29yX3R5cGVzIHR5
cGUsIHUzMiBhdA0KPj4gICAJCQlpbnQgY2hhbm5lbCwgbG9uZyAqdmFsKQ0KPj4gICB7DQo+PiAg
IAlzd2l0Y2ggKHR5cGUpIHsNCj4+ICsJY2FzZSBod21vbl9jaGlwOg0KPj4gKwkJcmV0dXJuIGFk
dDc0NzBfY2hpcF9yZWFkKGRldiwgYXR0ciwgdmFsKTsNCj4+ICAgCWNhc2UgaHdtb25fdGVtcDoN
Cj4+ICAgCQlyZXR1cm4gYWR0NzQ3MF90ZW1wX3JlYWQoZGV2LCBhdHRyLCBjaGFubmVsLCB2YWwp
Ow0KPj4gICAJY2FzZSBod21vbl9mYW46DQo+PiBAQCAtMTExMiw2ICsxMTE0LDggQEAgc3RhdGlj
IGludCBhZHQ3NDcwX3dyaXRlKHN0cnVjdCBkZXZpY2UgKmRldiwgZW51bSBod21vbl9zZW5zb3Jf
dHlwZXMgdHlwZSwgdTMyIGENCj4+ICAgCQkJaW50IGNoYW5uZWwsIGxvbmcgdmFsKQ0KPj4gICB7
DQo+PiAgIAlzd2l0Y2ggKHR5cGUpIHsNCj4+ICsJY2FzZSBod21vbl9jaGlwOg0KPj4gKwkJcmV0
dXJuIGFkdDc0NzBfY2hpcF93cml0ZShkZXYsIGF0dHIsIHZhbCk7DQo+PiAgIAljYXNlIGh3bW9u
X3RlbXA6DQo+PiAgIAkJcmV0dXJuIGFkdDc0NzBfdGVtcF93cml0ZShkZXYsIGF0dHIsIGNoYW5u
ZWwsIHZhbCk7DQo+PiAgIAljYXNlIGh3bW9uX2ZhbjoNCj4+IEBAIC0xMTI5LDYgKzExMzMsMTUg
QEAgc3RhdGljIHVtb2RlX3QgYWR0NzQ3MF9pc192aXNpYmxlKGNvbnN0IHZvaWQgKl9kYXRhLCBl
bnVtIGh3bW9uX3NlbnNvcl90eXBlcyB0eXANCj4+ICAgCXVtb2RlX3QgbW9kZSA9IDA7DQo+PiAg
IA0KPj4gICAJc3dpdGNoICh0eXBlKSB7DQo+PiArCWNhc2UgaHdtb25fY2hpcDoNCj4+ICsJCXN3
aXRjaCAoYXR0cikgew0KPj4gKwkJY2FzZSBod21vbl9jaGlwX3VwZGF0ZV9pbnRlcnZhbDoNCj4+
ICsJCQltb2RlID0gMDY0NDsNCj4+ICsJCQlicmVhazsNCj4+ICsJCWRlZmF1bHQ6DQo+PiArCQkJ
YnJlYWs7DQo+PiArCQl9DQo+PiArCQlicmVhazsNCj4+ICAgCWNhc2UgaHdtb25fdGVtcDoNCj4+
ICAgCQlzd2l0Y2ggKGF0dHIpIHsNCj4+ICAgCQljYXNlIGh3bW9uX3RlbXA6DQo+PiBAQCAtMTE4
Nyw2ICsxMjAwLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBod21vbl9vcHMgYWR0NzQ3MF9od21v
bl9vcHMgPSB7DQo+PiAgIH07DQo+PiAgIA0KPj4gICBzdGF0aWMgY29uc3Qgc3RydWN0IGh3bW9u
X2NoYW5uZWxfaW5mbyAqYWR0NzQ3MF9pbmZvW10gPSB7DQo+PiArCUhXTU9OX0NIQU5ORUxfSU5G
TyhjaGlwLCBIV01PTl9DX1VQREFURV9JTlRFUlZBTCksDQo+PiAgIAlIV01PTl9DSEFOTkVMX0lO
Rk8odGVtcCwNCj4+ICAgCQkJSFdNT05fVF9JTlBVVCB8IEhXTU9OX1RfTUlOIHwgSFdNT05fVF9N
QVggfCBIV01PTl9UX0FMQVJNLA0KPj4gICAJCQlIV01PTl9UX0lOUFVUIHwgSFdNT05fVF9NSU4g
fCBIV01PTl9UX01BWCB8IEhXTU9OX1RfQUxBUk0s
