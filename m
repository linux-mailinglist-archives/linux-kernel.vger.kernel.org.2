Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55BB433CC88
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 05:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbhCPEWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 00:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbhCPEWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 00:22:00 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7ACC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 21:21:59 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 16170891AE;
        Tue, 16 Mar 2021 17:21:58 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1615868518;
        bh=TT0EhtSrRCuCPo99Tf5CmraeqPT2f9p/23xnyCoCNZ4=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=sXARCpmANcI/iPwDYvytx5SLd8ZO//pg1A4VXrD3udnede1jDbr1lf7SjJu6ML7+7
         KrprhkQO/5P5oImULx+At42wjZ/gzMJT4bWDBrVDmsihzIqHy+rixEPtKzNf9IT8bC
         k/3Jl+1dZG0ao7ETBKtnd7/Gro85xMEukTE58gY6WE89AzB5fy4UJ9rDyxNiHFMamr
         Bp6cGjyKzcj8xRXdCOd/iSbsVQZoaOEc/mdmMepkbfdifcXJpebvzsZ/lEnlUm4diK
         xUdxUZYo3Y6KoGOPIskUO7uLOqK2chQDiGclVsQX9WVIUub7axmv0jlhGM2OjEyguN
         NVa3VxvSxsDSA==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B605032660000>; Tue, 16 Mar 2021 17:21:58 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 16 Mar 2021 17:21:57 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.012; Tue, 16 Mar 2021 17:21:57 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Guenter Roeck <linux@roeck-us.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] hwmon: (pmbus): Add driver for BluTek BPA-RS600
Thread-Topic: [PATCH 2/2] hwmon: (pmbus): Add driver for BluTek BPA-RS600
Thread-Index: AQHXGg0JQkIPU0GURU+Z4hUV3SNYs6qFHxwAgAAKqAA=
Date:   Tue, 16 Mar 2021 04:21:56 +0000
Message-ID: <ea648b3d-f6ac-d7ec-fc5b-2b15c827c3dc@alliedtelesis.co.nz>
References: <20210316023524.12574-1-chris.packham@alliedtelesis.co.nz>
 <20210316023524.12574-2-chris.packham@alliedtelesis.co.nz>
 <46a69700-ae1f-a441-2399-0e8c8e2a588d@roeck-us.net>
In-Reply-To: <46a69700-ae1f-a441-2399-0e8c8e2a588d@roeck-us.net>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <3EAC71656026364FBDBCE7B8FE0DBF71@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=GfppYjfL c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=dESyimp9J3IA:10 a=G3IL0jre2ez7scXUKXwA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxNi8wMy8yMSA0OjQzIHBtLCBHdWVudGVyIFJvZWNrIHdyb3RlOg0KPiBPbiAzLzE1LzIx
IDc6MzUgUE0sIENocmlzIFBhY2toYW0gd3JvdGU6DQo+PiBUaGUgQlBBLVJTNjAwIGlzIGEgY29t
cGFjdCA2MDBXIEFDIHRvIERDIHJlbW92YWJsZSBwb3dlciBzdXBwbHkgbW9kdWxlLg0KPj4NCj4+
IFNpZ25lZC1vZmYtYnk6IENocmlzIFBhY2toYW0gPGNocmlzLnBhY2toYW1AYWxsaWVkdGVsZXNp
cy5jby5uej4NCj4+IC0tLQ0KPHNuaXA+DQo+PiArDQo+PiArc3RhdGljIGludCBicGFfcnM2MDBf
cmVhZF93b3JkX2RhdGEoc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCwgaW50IHBhZ2UsDQo+PiAr
CQlpbnQgcGhhc2UsIGludCByZWcpK3sNCj4+ICsJaW50IHJldDsNCj4+ICsNCj4+ICsJaWYgKHBh
Z2UgPiAwKQ0KPj4gKwkJcmV0dXJuIC1FTlhJTzsNCj4+ICsNCj4+ICsJc3dpdGNoIChyZWcpIHsN
Cj4+ICsJY2FzZSBQTUJVU19WSU5fVVZfRkFVTFRfTElNSVQ6DQo+PiArCWNhc2UgUE1CVVNfVklO
X09WX0ZBVUxUX0xJTUlUOg0KPj4gKwljYXNlIFBNQlVTX1ZPVVRfVVZfRkFVTFRfTElNSVQ6DQo+
PiArCWNhc2UgUE1CVVNfVk9VVF9PVl9GQVVMVF9MSU1JVDoNCj4+ICsJCXJldCA9IC1FTlhJTzsN
Cj4gSXMgdGhhdCBuZWVkZWQgPyBXaHkgbm90IC1FTk9EQVRBID8NCg0KQmFzaWNhbGx5IHRoZXNl
IGNvbW1hbmRzIGdldCByZXNwb25zZXMgb24gdGhlIGJ1cyBidXQgdGhleSBkb24ndCBoYXZlIA0K
dmFsaWQgZGF0YSAobm9yIGFyZSB0aGV5IGRvY3VtZW50ZWQgaW4gdGhlIGRhdGFzaGVldCkuIEkn
bGwgYWRkIGEgDQpjb21tZW50IHRvIHRoYXQgZWZmZWN0Lg0KDQpJZiBJJ20gcmVhZGluZyB0aGlu
Z3MgY29ycmVjdGx5IC1FTk9EQVRBIGlzIGEgc2lnbmFsIHRvIA0KX3BtYnVzX3JlYWRfd29yZF9k
YXRhIHVzZSB0aGUgIm5vcm1hbCIgcmVhZCBvcGVyYXRpb24uIFNvIEkgbmVlZCB0byANCnJldHVy
biBzb21ldGhpbmcgb3RoZXIgdGhhbiB0aGF0LiBJIGZvdW5kIGFub3RoZXIgZHJpdmVyIChtcDI5
NzUuYykgDQpkb2luZyB0aGUgc2FtZSB0aGluZyBmb3Igd2hhdCBJIGFzc3VtZSBhcmUgc2ltaWxh
ciByZWFzb25zIHNvIEkgd2VudCANCndpdGggLUVOWElPLg0KDQo+DQo+PiArCQlicmVhazsNCjxz
bmlwPg0KPiArDQo+PiArc3RhdGljIGNvbnN0IHN0cnVjdCBpMmNfZGV2aWNlX2lkIGJwYV9yczYw
MF9pZFtdID0gew0KPj4gKwl7ICJicGFfcnM2MDAiLCAwIH0sDQo+IEhtbSwgbm8sIHRoaXMgaGFz
IGFuIHVuZGVyc2NvcmUuIEd1ZXNzIHlvdSdsbCBoYXZlIHRvIHVzZSB0aGUgdHJpY2sgZnJvbQ0K
PiBpaW9faHdtb24uYyBvciBzaW1pbGFyIHRvIGdlbmVyYXRlIGEgdmFsaWQgbmFtZS4NCj4NCj4g
T2gsIHdhaXQsIHRoaXMgaXMgYSBwbWJ1cyBkcml2ZXIsIGFuZCB0aGUgcG1idXMgY29yZSB1c2Vz
IGNsaWVudC0+bmFtZS4NCj4gTWF5YmUgd2UgbmVlZCB0byBhZGQgYW4gb3B0aW9uYWwgc3RycmVw
bGFjZSgpIHRvIHRoZSBwbWJ1cyBjb3JlLg0KTG9va2luZyBpbnRvIHRoaXMgbm93Lg==
