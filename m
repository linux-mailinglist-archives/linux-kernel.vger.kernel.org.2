Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B383139AC3A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 23:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhFCVFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 17:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFCVFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 17:05:44 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD88C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 14:03:59 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id AD8CC83646;
        Fri,  4 Jun 2021 09:03:55 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1622754235;
        bh=DTgmrcj44GBsFDngEO4SAErNloCKp7TYXzx52+YrQHI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=L/Zc9k8GhkM/js0kjxrOAFgDdwbgtFMvo1QJl4xC5mHWUvJEOCTCopKt+7m4w9IFl
         FwBGsNSzaSOTL1C/66SEj/8PvAPmLhN5bHTm/QT75sjB2QKy9/Zr7IKkd2Ro7Ke17Q
         +DPP/vMjs5jm3dsHszYpoEJtP6p/VHmZP6epBS0V1+7F0icSmUdR4wZIrbygfB7uQO
         RIeMpEMpDl1H+hC0kJbvAZMHakpTYA+85rE3eir/AJvNVN7R4a6n5jPWNGULbkzUV0
         zcdidWe2j8viUGct19r/FQ7XVkTDDPmcpRKLdarJ+RyBdLnvYfEMQbRt8ShIW4TOkx
         z88g3mLOIRIrg==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B60b943bb0001>; Fri, 04 Jun 2021 09:03:55 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.18; Fri, 4 Jun 2021 09:03:55 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.018; Fri, 4 Jun 2021 09:03:55 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     =?utf-8?B?UGFsaSBSb2jDoXI=?= <pali@kernel.org>
CC:     "jason@lakedaemon.net" <jason@lakedaemon.net>,
        Joshua Scott <Joshua.Scott@alliedtelesis.co.nz>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: mvebu: Enable MBUS error propagation
Thread-Topic: [PATCH] ARM: mvebu: Enable MBUS error propagation
Thread-Index: AQHVoqqJx9twrZNTn0+9dczHY+j8Sqff+80AgyWuXKf//79EgA==
Date:   Thu, 3 Jun 2021 21:03:55 +0000
Message-ID: <e75b74fa-b393-fede-1a19-fd43dbb7aba4@alliedtelesis.co.nz>
References: <20191124093529.32399-1-chris.packham@alliedtelesis.co.nz>
 <8736cqb63d.fsf@FE-laptop>
 <0285a09b2b1b7ae2ccc268a37e4357c95d270ac9.camel@alliedtelesis.co.nz>
 <20210603125525.nkswvixbabkgq5or@pali>
In-Reply-To: <20210603125525.nkswvixbabkgq5or@pali>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <02D7D979FB9FC84CB021F874BB1F6AA1@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=WOcBoUkR c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=r6YtysWOX24A:10 a=YfCOm-DyAAAA:8 a=62ntRvTiAAAA:8 a=5jizGDlvGD8ohoheODsA:9 a=QEXdDO2ut3YA:10 a=N53muDpBR4cA:10 a=DbIGPHfHo5QA:10 a=zQLMK8awuJ6_Hvp-_9Ux:22 a=pToNdpNmrtiFLRE6bQ9Z:22
X-SEG-SpamProfiler-Score: 0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiA0LzA2LzIxIDEyOjU1IGFtLCBQYWxpIFJvaMOhciB3cm90ZToNCj4gT24gV2VkbmVzZGF5
IDA4IEphbnVhcnkgMjAyMCAxOTo0MjoxMiBDaHJpcyBQYWNraGFtIHdyb3RlOg0KPj4gSGkgR3Jl
Z29yeSwNCj4+DQo+PiBPbiBXZWQsIDIwMjAtMDEtMDggYXQgMTE6MjIgKzAxMDAsIEdyZWdvcnkg
Q0xFTUVOVCB3cm90ZToNCj4+PiBIZWxsbyBDaHJpcywNCj4+Pg0KPj4+PiBVLWJvb3QgZGlzYWJs
ZXMgTUJVUyBlcnJvciBwcm9wYWdhdGlvbiBmb3IgQXJtYWRhLTM4NS4gVGhlIGVmZmVjdCBvZg0K
Pj4+PiB0aGlzIG9uIHRoZSBrZXJuZWwgaXMgdGhhdCBhbnkgYWNjZXNzIHRvIGEgbWFwcGVkIGJ1
dCBpbmFjY2Vzc2libGUNCj4+Pj4gYWRkcmVzcyBjYXVzZXMgdGhlIHN5c3RlbSB0byBoYW5nLg0K
Pj4+Pg0KPj4+PiBCeSBlbmFibGluZyBNQlVTIGVycm9yIHByb3BhZ2F0aW9uIHRoZSBrZXJuZWwg
Y2FuIHJhaXNlIGEgQnVzIEVycm9yIGFuZA0KPj4+PiBwYW5pYyB0byByZXN0YXJ0IHRoZSBzeXN0
ZW0uDQo+Pj4gVW5sZXNzIEkgbWlzcyBpdCwgaXQgc2VlbXMgdGhhdCBub2JvZHkgY29tbWVudCB0
aGlzIHBhdGNoOiBzb3JyeSBmb3IgdGhlDQo+Pj4gZGVsYXkuDQo+Pj4NCj4+IFRoYW5rcyBmb3Ig
dGhlIHJlc3BvbnNlLg0KPj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogQ2hyaXMgUGFja2hhbSA8Y2hy
aXMucGFja2hhbUBhbGxpZWR0ZWxlc2lzLmNvLm56Pg0KPj4+PiAtLS0NCj4+Pj4NCj4+Pj4gTm90
ZXM6DQo+Pj4+ICAgICAgV2UndmUgZW5jb3VudGVyZWQgYW4gaXNzdWUgd2hlcmUgcm9ndWUgYWNj
ZXNzZXMgdG8gUENJLWUgc3BhY2UgY2F1c2UgYW4NCj4+Pj4gICAgICBBcm1hZGEtMzg1IHN5c3Rl
bSB0byBsb2NrdXAuIFdlJ3ZlIGZvdW5kIHRoYXQgZW5hYmxpbmcgTUJVUyBlcnJvcg0KPj4+PiAg
ICAgIHByb3BhZ2F0aW9uIGxldHMgdXMgZ2V0IGEgYnVzIGVycm9yIHdoaWNoIGF0IGxlYXN0IGdp
dmVzIHVzIGEgcGFuaWMgdG8NCj4+Pj4gICAgICBoZWxwIGlkZW50aWZ5IHdoYXQgd2FzIGFjY2Vz
c2VkLg0KPj4+PiAgICAgIA0KPj4+PiAgICAgIFUtYm9vdCBjbGVhcnMgdGhlIElPIEVyciBQcm9w
IEVuYWJsZSBCaXRbMV0gYnV0IHNvIGZhciBuby1vbmUgc2VlbXMgdG8NCj4+Pj4gICAgICBrbm93
IHdoeS4NCj4+Pj4gICAgICANCj4+Pj4gICAgICBJIHdhc24ndCBzdXJlIHdoZXJlIHRvIHB1dCB0
aGlzIGNvZGUuIFRoZXJlIGlzIHNpbWlsYXIgY29kZSBmb3Iga2lyd29vZA0KPj4+PiAgICAgIGlu
IHRoZSBlcXVpdmFsZW50IGR0X2luaXQgZnVuY3Rpb24uIE9uIEFybWFkYS1YUCB0aGUgcmVnaXN0
ZXIgaXMgcGFydCBvZg0KPj4+PiAgICAgIHRoZSBDb3JlIENvaGVyZW5jeSBGYWJyaWMgYmxvY2sg
KGZvciBBMzg1IGl0J3MgZG9jdW1lbnRlZCBhcyBwYXJ0IG9mIHRoZQ0KPj4+PiAgICAgIENDRiBi
bG9jaykuDQo+Pj4gV2hhdCBhYm91dCBhZGRpbmcgYSBuZXcgc2V0IG9mIHJlZ2lzdGVyIHRvIHRo
ZSBtdmVidSBtYnVzIGRyaXZlcj8NCj4+Pg0KPj4gQWZ0ZXIgbW9yZSB0ZXN0aW5nIHdlIGZvdW5k
IHRoYXQgc29tZSBwcmV2aW91c2x5ICJnb29kIiBib2FyZHMgc3RhcnRlZA0KPj4gdGhyb3dpbmcg
dXAgcGFuaWNzIHdpdGggdGhpcyBjaGFuZ2UuIEkgdGhpbmsgdGhhdCB0aGlzIG1pZ2h0IHJlcXVp
cmUNCj4+IGhhbmRsaW5nIHNvbWUgb2YgdGhlIFBDSS1lIGludGVycnVwdHMgKGZvciBjb3JyZWN0
YWJsZSBlcnJvcnMpIHZpYSB0aGUNCj4+IEVEQUMgc3Vic3lzdGVtLg0KPj4NCj4+IFdlJ3JlIHN0
aWxsIHdvcmtpbmcgd2l0aCBNYXJ2ZWxsIHRvIHRyYWNrIGRvd24gZXhhY3RseSB3aHkgdGhpcyBp
cw0KPj4gaGFwcGVuaW5nIG9uIG91ciBzeXN0ZW0uDQo+IEhlbGxvIENocmlzISBIYXZlIHlvdSBz
b21laG93IHNvbHZlZCB0aGlzIGlzc3VlPyBPciBkbyB5b3UgaGF2ZSBzb21lDQo+IGNvbnRhY3Rz
IGluIE1hcnZlbGwgZm9yIEEzODUgUENJZSBzdWJzeXN0ZW0/DQoNClRoZSBwcm9ibGVtIHNlZW1l
ZCB0byBiZSBhIHNwZWNpZmljIENQVSBFcnJhdHVtIGZvciB0aGUgQTM4NSB3aGljaCBJIA0KYnJv
dWdodCBpbnRvIHVwc3RyZWFtIHUtYm9vdFsxXS4gQnV0IGV2ZW4gdGhlbiB3ZSBoYWQgdG8gdXBk
YXRlIG91ciBiYXNlIA0KdS1ib290IHZlcnNpb24gZnJvbSAyMDE2LjExIHRvIDIwMTkuMTAgc28g
dGhlcmUgbWF5IGhhdmUgYmVlbiBtb3JlIGdvaW5nIA0Kb24gdGhhbiBqdXN0IHRoYXQgb25lIGNo
YW5nZS4NCg0KWzFdIC0gDQpodHRwczovL3NvdXJjZS5kZW54LmRlL3UtYm9vdC91LWJvb3QvLS9j
b21taXQvYWQ5MWZkZmZmMGJkNmVhNDcxYWZlODM4ZTBmNmQ1OGVkODk4Njk0ZQ0KDQo+Pj4gSW4g
dGhpcyBjYXNlIGl0IHdpbGwgYmUgY2FsbGVkIGV2ZW4gZWFybGllciBhbGxvd2luZyB0byBzZWUg
YnVzIGVycm9yDQo+Pj4gZWFybGllci4NCj4+Pg0KPj4+IEluIGFueSBjYXNlLCB5b3Ugc2hvdWxk
IHNlcGFyYXRlIHRoZSBkZXZpY2UgdHJlZSBjaGFuZ2UgZnJvbSB0aGUgY29kZQ0KPj4+IGNoYW5n
ZSBhbmQgYXQgbGVhc3QgcHJvdmlkZSAyIHBhdGNoZXMuDQo+PiBBZ3JlZWQuIElmL3doZW4gc29t
ZXRoaW5nIHNvbGlkIGV2ZW50dWF0ZXMgd2UnbGwgZG8gaXQgYXMgYSBwcm9wZXINCj4+IHNlcmll
cy4NCj4+DQo+Pj4gR3JlZ29yeQ0KPj4+DQo+Pj4+ICAgICAgDQo+Pj4+ICAgICAgLS0NCj4+Pj4g
ICAgICBbMV0gLSBodHRwczovL3NjYW5tYWlsLnRydXN0d2F2ZS5jb20vP2M9MjA5ODgmZD15Tkc0
NEVNUVItUGZBUFI5OXppZzFMenB0bXF6SG8xMWk3dUFqNEFHdVEmdT1odHRwcyUzYSUyZiUyZmdp
dGxhYiUyZWRlbnglMmVkZSUyZnUtYm9vdCUyZnUtYm9vdCUyZmJsb2IlMmZtYXN0ZXIlMmZhcmNo
JTJmYXJtJTJmbWFjaC1tdmVidSUyZmNwdSUyZWMlMjNMNDg5DQpeXl4gc29ycnksIGFzIGEgcmVz
dWx0IG9mIGEgcmVhc29uYWJseSBoaWdoIHByb2ZpbGUgY3liZXIgYXR0YWNrIG9uIGEgDQpsb2Nh
bCBpbnN0aXR1dGlvbiBVUkxzIGluIG91ciBpbmNvbWluZyBtYWlsIGFyZSBpbnRlcmNlcHRlZC4N
Cj4+Pj4NCj4+Pj4gICBhcmNoL2FybS9ib290L2R0cy9hcm1hZGEtMzh4LmR0c2kgfCAgNSArKysr
Kw0KPj4+PiAgIGFyY2gvYXJtL21hY2gtbXZlYnUvYm9hcmQtdjcuYyAgICB8IDI3ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKw0KPj4+PiAgIDIgZmlsZXMgY2hhbmdlZCwgMzIgaW5zZXJ0aW9u
cygrKQ0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvYXJtYWRhLTM4
eC5kdHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvYXJtYWRhLTM4eC5kdHNpDQo+Pj4+IGluZGV4IDNm
NGJiNDRkODVmMC4uMzIxNGM2NzQzM2ViIDEwMDY0NA0KPj4+PiAtLS0gYS9hcmNoL2FybS9ib290
L2R0cy9hcm1hZGEtMzh4LmR0c2kNCj4+Pj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvYXJtYWRh
LTM4eC5kdHNpDQo+Pj4+IEBAIC0zODYsNiArMzg2LDExIEBADQo+Pj4+ICAgCQkJCSAgICAgIDww
eDIwMjUwIDB4OD47DQo+Pj4+ICAgCQkJfTsNCj4+Pj4gICANCj4+Pj4gKwkJCWlvZXJyYzogaW8t
ZXJyLWNvbnRyb2xAMjAyMDAgew0KPj4+PiArCQkJCWNvbXBhdGlibGUgPSAibWFydmVsbCxpby1l
cnItY29udHJvbCI7DQo+Pj4+ICsJCQkJcmVnID0gPDB4MjAyMDAgMHg0PjsNCj4+Pj4gKwkJCX07
DQo+Pj4+ICsNCj4+Pj4gICAJCQltcGljOiBpbnRlcnJ1cHQtY29udHJvbGxlckAyMGEwMCB7DQo+
Pj4+ICAgCQkJCWNvbXBhdGlibGUgPSAibWFydmVsbCxtcGljIjsNCj4+Pj4gICAJCQkJcmVnID0g
PDB4MjBhMDAgMHgyZDA+LCA8MHgyMTA3MCAweDU4PjsNCj4+Pj4gZGlmZiAtLWdpdCBhL2FyY2gv
YXJtL21hY2gtbXZlYnUvYm9hcmQtdjcuYyBiL2FyY2gvYXJtL21hY2gtbXZlYnUvYm9hcmQtdjcu
Yw0KPj4+PiBpbmRleCBkMmRmNWVmOTM4MmIuLmZiNzcxODM4NmVmOSAxMDA2NDQNCj4+Pj4gLS0t
IGEvYXJjaC9hcm0vbWFjaC1tdmVidS9ib2FyZC12Ny5jDQo+Pj4+ICsrKyBiL2FyY2gvYXJtL21h
Y2gtbXZlYnUvYm9hcmQtdjcuYw0KPj4+PiBAQCAtMTM4LDEwICsxMzgsMzYgQEAgc3RhdGljIHZv
aWQgX19pbml0IGkyY19xdWlyayh2b2lkKQ0KPj4+PiAgIAl9DQo+Pj4+ICAgfQ0KPj4+PiAgIA0K
Pj4+PiArI2RlZmluZSBNQlVTX0VSUl9QUk9QX0VOIEJJVCg4KQ0KPj4+PiArDQo+Pj4+ICsvKg0K
Pj4+PiArICogVS1ib290IGRpc2FibGVzIE1CVVMgZXJyb3IgcHJvcGFnYXRpb24uIFJlLWVuYWJs
ZSBpdCBzbyB3ZQ0KPj4+PiArICogY2FuIGhhbmRsZSB0aGVtIGFzIEJ1cyBFcnJvcnMuDQo+Pj4+
ICsgKi8NCj4+Pj4gK3N0YXRpYyB2b2lkIF9faW5pdCBlbmFibGVfbWJ1c19lcnJvcl9wcm9wYWdh
dGlvbih2b2lkKQ0KPj4+PiArew0KPj4+PiArCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAgPQ0KPj4+
PiArCQlvZl9maW5kX2NvbXBhdGlibGVfbm9kZShOVUxMLCBOVUxMLCAibWFydmVsbCxpby1lcnIt
Y29udHJvbCIpOw0KPj4+PiArDQo+Pj4+ICsJaWYgKG5wKSB7DQo+Pj4+ICsJCXZvaWQgX19pb21l
bSAqcmVnOw0KPj4+PiArDQo+Pj4+ICsJCXJlZyA9IG9mX2lvbWFwKG5wLCAwKTsNCj4+Pj4gKwkJ
aWYgKHJlZykgew0KPj4+PiArCQkJdTMyIHZhbDsNCj4+Pj4gKw0KPj4+PiArCQkJdmFsID0gcmVh
ZGxfcmVsYXhlZChyZWcpOw0KPj4+PiArCQkJd3JpdGVsX3JlbGF4ZWQodmFsIHwgTUJVU19FUlJf
UFJPUF9FTiwgcmVnKTsNCj4+Pj4gKwkJfQ0KPj4+PiArCQlvZl9ub2RlX3B1dChucCk7DQo+Pj4+
ICsJfQ0KPj4+PiArfQ0KPj4+PiArDQo+Pj4+ICAgc3RhdGljIHZvaWQgX19pbml0IG12ZWJ1X2R0
X2luaXQodm9pZCkNCj4+Pj4gICB7DQo+Pj4+ICAgCWlmIChvZl9tYWNoaW5lX2lzX2NvbXBhdGli
bGUoIm1hcnZlbGwsYXJtYWRheHAiKSkNCj4+Pj4gICAJCWkyY19xdWlyaygpOw0KPj4+PiArCWVu
YWJsZV9tYnVzX2Vycm9yX3Byb3BhZ2F0aW9uKCk7DQo+Pj4+ICAgfQ0KPj4+PiAgIA0KPj4+PiAg
IHN0YXRpYyB2b2lkIF9faW5pdCBhcm1hZGFfMzcwX3hwX2R0X2ZpeHVwKHZvaWQpDQo+Pj4+IEBA
IC0xOTEsNiArMjE3LDcgQEAgRFRfTUFDSElORV9TVEFSVChBUk1BREFfMzhYX0RULCAiTWFydmVs
bCBBcm1hZGEgMzgwLzM4NSAoRGV2aWNlIFRyZWUpIikNCj4+Pj4gICAJLmwyY19hdXhfdmFsCT0g
MCwNCj4+Pj4gICAJLmwyY19hdXhfbWFzawk9IH4wLA0KPj4+PiAgIAkuaW5pdF9pcnEgICAgICAg
PSBtdmVidV9pbml0X2lycSwNCj4+Pj4gKwkuaW5pdF9tYWNoaW5lCT0gbXZlYnVfZHRfaW5pdCwN
Cj4+Pj4gICAJLnJlc3RhcnQJPSBtdmVidV9yZXN0YXJ0LA0KPj4+PiAgIAkuZHRfY29tcGF0CT0g
YXJtYWRhXzM4eF9kdF9jb21wYXQsDQo+Pj4+ICAgTUFDSElORV9FTkQNCj4+Pj4gLS0gDQo+Pj4+
IDIuMjQuMA0KPj4+Pg0KPj4+
