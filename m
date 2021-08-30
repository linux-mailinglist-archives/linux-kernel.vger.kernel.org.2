Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2CE3FBDC0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 22:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236664AbhH3VAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 17:00:25 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:42707 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236036AbhH3VAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 17:00:23 -0400
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id EC747806A8;
        Tue, 31 Aug 2021 08:59:24 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1630357164;
        bh=Cj1HC74r2MPnEw4CyvStNz4uRXJHeNzHPBcHLUfpNZE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=T8Xc44Z//GszkNCuXlwN0Irp4bnzGh2E2ndOw5cmbn9wFZANJdRz2WzBYPiFJerbQ
         cug2FKJA6j7vaQzflpPZR9nXQG7BvTJC3t2cqikyKBGlClR3ZFAYC6PdyV9yZO6xza
         BLhAi1jmw22NL7of+OXjn/Ak1E8NyBEFVX4ZTugDS0Esg9YfaOkbvZGT7H0vc3UxdC
         V4w1u2RVngFwS1gyHOcDfj7BuZVY/t5qPIUucvPf34aDS8SXWjmBrs2gGhUcXWJSjI
         CFOvRwL+T06HY+7xK6GRSO1qI+5qnXPURie7Gglhd5h8d+64rC06HkIDqquuHMnpgo
         tnm3mMDt9HUTQ==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B612d46ac0001>; Tue, 31 Aug 2021 08:59:24 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 31 Aug 2021 08:59:24 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.023; Tue, 31 Aug 2021 08:59:24 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] hwmon: (adt7470) Use standard update_interval
 property
Thread-Topic: [PATCH v2 4/4] hwmon: (adt7470) Use standard update_interval
 property
Thread-Index: AQHXmiPcXguJzdIxPU+IRgUO+WiCqKuHF9kAgAMe8gCAATVTgIAAWkGA
Date:   Mon, 30 Aug 2021 20:59:24 +0000
Message-ID: <dace3f40-8038-2867-dc20-596f8bc0ebe2@alliedtelesis.co.nz>
References: <20210826024121.15665-1-chris.packham@alliedtelesis.co.nz>
 <20210826024121.15665-5-chris.packham@alliedtelesis.co.nz>
 <20210827212942.GA716764@roeck-us.net>
 <fe6cf9f3-f15e-065c-aaf8-cc018edf12e8@alliedtelesis.co.nz>
 <e467a3b2-d7c7-0920-9287-fb3e7abd5fae@roeck-us.net>
In-Reply-To: <e467a3b2-d7c7-0920-9287-fb3e7abd5fae@roeck-us.net>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <CAE07E19B1FDC048B04C68A1D8B96635@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=aqTM9hRV c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=MhDmnRu9jo8A:10 a=IuYHxPiwz1Cm0btsGcYA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAzMS8wOC8yMSAzOjM2IGFtLCBHdWVudGVyIFJvZWNrIHdyb3RlOg0KPiBPbiA4LzI5LzIx
IDI6MDkgUE0sIENocmlzIFBhY2toYW0gd3JvdGU6DQo+Pg0KPj4gT24gMjgvMDgvMjEgOToyOSBh
bSwgR3VlbnRlciBSb2VjayB3cm90ZToNCj4+PiBPbiBUaHUsIEF1ZyAyNiwgMjAyMSBhdCAwMjo0
MToyMVBNICsxMjAwLCBDaHJpcyBQYWNraGFtIHdyb3RlOg0KPj4+PiBJbnN0ZWFkIG9mIHRoZSBu
b24tc3RhbmRhcmQgYXV0b191cGRhdGVfaW50ZXJ2YWwgbWFrZSB1c2Ugb2YgdGhlDQo+Pj4+IHVw
ZGF0ZV9pbnRlcnZhbCBwcm9wZXJ0eSB0aGF0IGlzIHN1cHBvcnRlZCBieSB0aGUgaHdtb24gY29y
ZS4NCj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogQ2hyaXMgUGFja2hhbSA8Y2hyaXMucGFja2hh
bUBhbGxpZWR0ZWxlc2lzLmNvLm56Pg0KPj4+PiAtLS0NCj4+Pj4NCj4+Pj4gTm90ZXM6DQo+Pj4+
IMKgwqDCoMKgwqAgSSBraW5kIG9mIGFudGljaXBhdGUgYSBOQUsgb24gdGhpcyBiZWNhdXNlIGl0
IGFmZmVjdHMgdGhlIA0KPj4+PiBBQkkuIEJ1dCBJIGZpZ3VyZWQNCj4+Pj4gwqDCoMKgwqDCoCBJ
J2QgcnVuIGl0IHBhc3QgdGhlIE1MIHRvIHNlZSBpZiBtb3ZpbmcgdG93YXJkcyB0aGUgaHdtb24g
DQo+Pj4+IGNvcmUgaXMgd29ydGggdGhlIGhpdA0KPj4+PiDCoMKgwqDCoMKgIGluIEFCSSBjb21w
YXRpYmlsaXR5Lg0KPj4+IEkgcGVyc29uYWxseSBkb24ndCBtaW5kIChtb3N0IGxpa2VseSBubyBv
bmUgaXMgdXNpbmcgaXQgYW55d2F5KSwgYnV0IA0KPj4+IGxldCdzDQo+Pj4gd2FpdCB1bnRpbCBh
ZnRlciB0aGUgdXBjb21pbmcgY29tbWl0IHdpbmRvdyBjbG9zZXMgdG8gZ2l2ZSBwZW9wbGUgDQo+
Pj4gdGltZSB0bw0KPj4+IGNvbXBsYWluLg0KPj4NCj4+IEkga25vdyBvZiBvbmUgYXBwbGljYXRp
b24gdXNpbmcgdGhpcyBzeXNmcyBlbnRyeS4gQnV0IGl0J3Mgb3VyIGluLWhvdXNlDQo+PiBlbnZp
cm9ubWVudGFsIG1vbml0b3JpbmcgY29kZSBzbyBpZiB0aGlzIGdldHMgbWVyZ2VkIEknbGwganVz
dCB1cGRhdGUgaXQNCj4+IHRvIHVzZSB0aGUgbmV3IHBhdGguDQo+Pg0KPj4gT25lIHRob3VnaHQg
SSBoYWQgd2FzIHdlIGNvdWxkIGRvIGJvdGguIGkuZS4gaGF2ZSBhbiBlbnRyeSB0aGF0IGNvbmZv
cm1zDQo+PiB0byB0aGUgaHdtb24gY29yZSBhbmQgYSBiYWNrd2FyZHMgY29tcGF0aWJsZSBlbnRy
eSB0aGF0IGp1c3QgYWxpYXNlcyB0aGUNCj4+IG5ldyBwYXRoLg0KPj4NCj4gTm93IHlvdSBhbG1v
c3QgY29udmluY2VkIG1lIHRvIGluZGVlZCByZWplY3QgdGhpcyBwYXRjaC4gVGhlIGlkZWEgb2Yg
DQo+IHRoZSBuZXcgQVBJDQo+IGlzIHRvIHNpbXBsaWZ5IGRyaXZlciBjb2RlLCBub3QgdG8gbWFr
ZSBpdCBtb3JlIGNvbXBsaWNhdGVkLiBJZiB3ZSANCj4gY2FuJ3Qgc2ltcGxpZnkNCj4gdGhlIGNv
ZGUsIGl0IGlzIGJldHRlciB0byBsZWF2ZSBpdCBhbG9uZS4NClNvbGQuIEkgYWdyZWUgd2hhdCBJ
J3ZlIGp1c3Qgc3VnZ2VzdGVkIGlzIGFkZGluZyBtb3JlIGNvbXBsZXhpdHkgd2l0aG91dCANCm11
Y2ggZ2Fpbi4gSWYgc29tZXRoaW5nIGRvZXMgc3RhcnQgdG8gY2FyZSBhYm91dCBoYXZpbmcgYSBz
dGFuZGFyZCANCnVwZGF0ZV9pbnRlcnZhbCBwcm9wZXJ0eSB3ZSBjb3VsZCByZXN1cnJlY3QgdGhp
cy4NCj4NCj4gR3VlbnRlcg==
