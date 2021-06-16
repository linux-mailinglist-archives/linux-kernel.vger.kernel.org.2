Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF7A3A8EA1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 03:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbhFPCAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 22:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbhFPCAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 22:00:01 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FAFC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 18:57:55 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id E811783640;
        Wed, 16 Jun 2021 13:57:51 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1623808671;
        bh=oATkGleJYKULgeNdEKQYt2ChdLBZ4Gx6pk2z2M5uxKE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=q5jTA2e6M/J3dN9ThUFR16MxxhaZS13VUmjyTCiIQxqeZdybl3c6ngpNYDJyGrrjx
         tXA/b9/sZrOy96ocqbbtjNwtpiqkT8mnRl3pYtQt1uH+m8p9xlFlESdKYPrSjboUlb
         gA4bJzaessbEloTMjj4tmzDMucRexJbpmhvgsLUPokfnk0mPIn3ZQgRS4n0lddZfHO
         V28A2hhOuaOC+Btcr5PqewgP6JVULXlTZkf6aXKnDF8DAIUDDtea7rCX1U4fd6GbRu
         ec3lBAx5NFOS4u8D8GccrumitMto4acfGUlecFPz3n/kV24RJH4+AtOGi58KfBjTtx
         /OCy44tE0vu3w==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B60c95a9f0001>; Wed, 16 Jun 2021 13:57:51 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 16 Jun 2021 13:57:51 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.018; Wed, 16 Jun 2021 13:57:51 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Jean Delvare <jdelvare@suse.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: pmbus: dealing with unsigned mantissa in linear reading
Thread-Topic: pmbus: dealing with unsigned mantissa in linear reading
Thread-Index: AQHXYj8KPszxT0us6UK8aq+XcguhFqsVFSOAgAADOgA=
Date:   Wed, 16 Jun 2021 01:57:50 +0000
Message-ID: <2119fc12-1d93-d7b3-7072-904bb312dca8@alliedtelesis.co.nz>
References: <67dd830c-c40f-b555-2b4e-3b7d383ef2c9@alliedtelesis.co.nz>
 <20210616014617.GB969448@roeck-us.net>
In-Reply-To: <20210616014617.GB969448@roeck-us.net>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <1087DDCFAD0A054881FCE52FAA965511@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=IOh89TnG c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=r6YtysWOX24A:10 a=pXRZlCoDf72HypaKHQ4A:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxNi8wNi8yMSAxOjQ2IHBtLCBHdWVudGVyIFJvZWNrIHdyb3RlOg0KPiBPbiBUdWUsIEp1
biAxNSwgMjAyMSBhdCAxMTozNDo1M1BNICswMDAwLCBDaHJpcyBQYWNraGFtIHdyb3RlOg0KPj4g
SGkgR3VlbnRlciwNCj4+DQo+PiBJJ3ZlIGhhZCBhIHJlcG9ydCBmcm9tIHNvbWVvbmUgdGVzdGlu
ZyB0aGUgQlBBLVJTNjAwLg0KPj4NCj4+IFdoZW4gdGhleSBoYXZlIHRoZSBpbnB1dCB2b2x0YWdl
IHNldCB0byA+PSAyNTZWIChhcHBhcmVudGx5IHRoZSBQU1UgY2FuDQo+PiBoYW5kbGUgaW5wdXQg
dXAgdG8gMjY0VikuIFRoZSBWaW4gcmVhZGluZyBnb2VzIG5lZ2F0aXZlLg0KPj4NCj4+IENNRCAw
eDg4LCBWQUw9MHhmM2Y4LCBWaW49MjU0DQo+PiBDTUQgMHg4OCwgVkFMPTB4ZjNmYywgVmluPTI1
NQ0KPj4gQ01EIDB4ODgsIFZBTD0weGY0MDAsIFZpbj0tMjU2DQo+Pg0KPj4gTG9va2luZyBhdCBw
bWJ1c19yZWcyZGF0YV9saW5lYXIoKSB0aGUgbWFudGlzc2EgaXMgY2FzdCB0byBzMTYgd2hpY2gg
aXMNCj4+IGNvcnJlY3QgYWNjb3JkaW5nIHRvIHNlY3Rpb24gNy4xIG9mIHRoZSBQTUJVUyBzcGVj
IHdoaWNoIHNheXMgdGhhdCB0aGUNCj4+IG1hbnRpc3NhIGlzIGFuIDExLWJpdCB0d28ncyBjb21w
bGVtZW50IHZhbHVlLg0KPj4NCj4+IEl0IHNlZW1zIHRoYXQgdGhlIEJQQS1SUzYwMCBpcyB1c2lu
ZyBhIG5vbi1zdGFuZGFyZCBmb3JtYXQgZm9yIHRoZQ0KPj4gbWFudGlzc2EgKHByb2JhYmx5IGJl
Y2F1c2UgdGhlIHJhbmdlIG9mIHRoZSBzdGFuZGFyZCBsaW5lYXIgZW5jb2RpbmcNCj4+IGNhbid0
IHN1cHBvcnQgdmFsdWVzID4yNTVWKS4gRG9lcyB0aGUgcG1idXMgaW5mcmFzdHJ1Y3R1cmUgcHJv
dmlkZSBhIHdheQ0KPj4gZm9yIG1lIHRvIGRlZmluZSBhIGN1c3RvbSBmb3JtYXQvY29udmVyc2lv
biBmb3IgYSBnaXZlbiBzZW5zb3I/DQo+IEVzc2VudGlhbGx5IHlvdSdsbCBoYXZlIHRvIGltcGxl
bWVudCBhIGN1c3RvbSByZWFkIHdvcmQgZnVuY3Rpb24gYW5kDQo+IGNvbnZlcnQgdGhlIHZhbHVl
IHJlcG9ydGVkIGJ5IHRoZSBwb3dlciBzdXBwbHkgdG8gYSB2YWxpZCBsaW5lYXIxMQ0KPiB2YWx1
ZS4gSW4gdGhpcyBjYXNlLCB5b3UgbWF5IGhhdmUgdG8gc2hpZnQgdGhlIHJlcG9ydGVkIHZhbHVl
IGJ5IDEgYml0DQo+IGFuZCBpbmNyZWFzZSB0aGUgZXhwb25lbnQgYnkgb25lLg0KDQpPSyBJJ2xs
IGxvb2sgYXQgZG9pbmcgdGhhdC4gSSBhbHJlYWR5IGhhdmUgYnBhX3JzNjAwX3JlYWRfd29yZF9k
YXRhKCkgc28gDQpJIGNhbiBob29rIGluIHRoZXJlLg0KDQo+IE5vdCBzdXJlIHdoYXQgeW91IG1l
YW4gd2l0aCAic3RhbmRhcmQgbGluZWFyIGVuY29kaW5nIGNhbid0IHN1cHBvcnQgdmFsdWVzDQpZ
ZWFoIEkgZmlndXJlZCB0aGF0IG91dCBhZnRlciBJIHNlbnQgdGhlIGVtYWlsLiBUaGVyZSBhcmUg
YSBmZXcgd2F5cyBvZiANCnJlcHJlc2VudGluZyA+MjU2ViBpbiBhIHN0YW5kYXJkIGNvbmZvcm1p
bmcgd2F5Lg0KPj4gMjU1ViIuIFdoeSBub3QgPyBUaGF0IGlzIHdoYXQgdGhlIGV4cG9uZW50IGlz
IGZvciwgYWZ0ZXIgYWxsLiBJdCByYXRoZXINCj4gc2VlbXMgdG8gbWUgdGhhdCB0aGUgUFMgdmVu
ZG9yIGRlY2lkZWQgdG8gdmlvbGF0ZSB0aGUgc3RhbmRhcmQgdG8gZ2V0DQo+IGFub3RoZXIgYml0
IG9mIGFjY3VyYWN5Lg0KDQpJbmRlZWQgdGhhdCBzZWVtcyB0byBiZSB0aGUgY2FzZS4NCg0KPiBH
dWVudGVy
