Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E376933E5FC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 02:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhCQBXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 21:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbhCQBWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 21:22:45 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116F2C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 18:22:45 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id A61CD891AE;
        Wed, 17 Mar 2021 14:22:41 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1615944161;
        bh=NDCn+m/6zQTNIcGqDPLY+JbvTvxKxMVFrdcZY3Ql06o=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=evaNuv+wczhWUNyPgtVUcx+7JvE02uOkFxFaQ05ZNtyqkwdrovhVfAJiKm9omWsBN
         7gKJs6qef+s3UFErDipxnoVTB9DUyRgfssooLwh/l/0p6QxBKjn/sf3YfwNvqpBNwL
         EZqH8jhLtZsPFZbJidOr/66K3GgTkKvpXxrKpnibLDaD1I/l4V6MehasEY0fFJSuTf
         6NOhRnBTdk2a5QhgLxaFfLP4O+esChKaOnV49EhtWjmGblRZ2YgV5mZjEeztAKAyYC
         +3p2uzGykF/BY1s/4OfcHRAAmSxKYzSfXdJUqQgdafwHjlHDzznbXhiB4VibNFasww
         10dfpZqvu2Ddg==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B605159e10001>; Wed, 17 Mar 2021 14:22:41 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 17 Mar 2021 14:22:40 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.012; Wed, 17 Mar 2021 14:22:40 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] hwmon: (pmbus): Add driver for BluTek BPA-RS600
Thread-Topic: [PATCH v2 3/3] hwmon: (pmbus): Add driver for BluTek BPA-RS600
Thread-Index: AQHXGqM9QTqCv4sNP0Wa1dh121ckK6qGiNWA
Date:   Wed, 17 Mar 2021 01:22:39 +0000
Message-ID: <df8fc719-0fa0-0ac6-ed7e-0e018f999f80@alliedtelesis.co.nz>
References: <20210316203036.17674-1-chris.packham@alliedtelesis.co.nz>
 <20210316203036.17674-3-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20210316203036.17674-3-chris.packham@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <416F9AE35D342A4C985292D9CF28366F@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=GfppYjfL c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=dESyimp9J3IA:10 a=B7YJzAzbl6ovjaQtLAcA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxNy8wMy8yMSA5OjMwIGFtLCBDaHJpcyBQYWNraGFtIHdyb3RlOg0KPiBUaGUgQlBBLVJT
NjAwIGlzIGEgY29tcGFjdCA2MDBXIEFDIHRvIERDIHJlbW92YWJsZSBwb3dlciBzdXBwbHkgbW9k
dWxlLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpcyBQYWNraGFtIDxjaHJpcy5wYWNraGFtQGFs
bGllZHRlbGVzaXMuY28ubno+DQo+IC0tLQ0KPg0KPiBOb3RlczoNCj4gICAgICBDaGFuZ2VzIGlu
IHYyOg0KPiAgICAgIC0gV2hpdGVzcGFjZSBhbmQgbGluZSBsZW5ndGggY2xlYW51cA0KPiAgICAg
IC0gQWRkIGNvbW1lbnRzIGFib3V0IGNvbW1hbmRzIHRoYXQgcmV0dXJuIGRhdGEgYnV0IHNob3Vs
ZG4ndCBiZSB1c2VkDQo+DQo+ICAgRG9jdW1lbnRhdGlvbi9od21vbi9icGEtcnM2MDAucnN0IHwg
IDc0ICsrKysrKysrKysrKysNCj4gICBkcml2ZXJzL2h3bW9uL3BtYnVzL0tjb25maWcgICAgICAg
fCAgIDkgKysNCj4gICBkcml2ZXJzL2h3bW9uL3BtYnVzL01ha2VmaWxlICAgICAgfCAgIDEgKw0K
PiAgIGRyaXZlcnMvaHdtb24vcG1idXMvYnBhLXJzNjAwLmMgICB8IDE3MiArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysNCj4gICA0IGZpbGVzIGNoYW5nZWQsIDI1NiBpbnNlcnRpb25zKCsp
DQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vaHdtb24vYnBhLXJzNjAwLnJz
dA0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2h3bW9uL3BtYnVzL2JwYS1yczYwMC5j
DQo+DQo+ICAgDQo+ICtjb25maWcgU0VOU09SU19CUEFfUlM2MDANCj4gKwl0cmlzdGF0ZSAiQmx1
VGVrIEJQRC1SUzYwMCBQb3dlciBTdXBwbGllcyINCj4gKwloZWxwDQo+ICsJICBJZiB5b3Ugc2F5
IHllcyBoZXJlIHlvdSBnZXQgaGFyZHdhcmUgbW9uaXRvcmluZyBzdXBwb3J0IGZvciBCbHVUZWsN
Cj4gKwkgIEJQRC1SUzYwMCBQb3dlciBTdXBwbGllcy4NCj4gKw0KPiArCSAgVGhpcyBkcml2ZXIg
Y2FuIGFsc28gYmUgYnVpbHQgYXMgYSBtb2R1bGUuIElmIHNvLCB0aGUgbW9kdWxlIHdpbGwNCj4g
KwkgIGJlIGNhbGxlZCBicGQtcnM2MDAuDQo+ICsNCkkndmUgdXNlZCBCUEQgaGVyZSBidXQgaXQg
c2hvdWxkIGJlIEJQQSAoQSA9PSBBQywgRCA9PSBEQykuIEknbGwgZ2V0IA0KdGhhdCByZWFkeSBm
b3IgYSB2My4=
