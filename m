Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B2A414A78
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 15:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbhIVNZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 09:25:01 -0400
Received: from mga05.intel.com ([192.55.52.43]:53085 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231919AbhIVNZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 09:25:00 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10114"; a="309143215"
X-IronPort-AV: E=Sophos;i="5.85,314,1624345200"; 
   d="scan'208";a="309143215"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 06:23:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,314,1624345200"; 
   d="scan'208";a="484570010"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga008.jf.intel.com with ESMTP; 22 Sep 2021 06:23:29 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 22 Sep 2021 06:23:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 22 Sep 2021 06:23:28 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2242.012;
 Wed, 22 Sep 2021 06:23:28 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Yazen Ghannam <yazen.ghannam@amd.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] x86/mce: Get rid of msr_ops
Thread-Topic: [PATCH 3/4] x86/mce: Get rid of msr_ops
Thread-Index: AQHXq7JaRGlGvEV5GEmaz9UoRNBQZqusXfOAgAC0BICAA2NsgIAAEp8A
Date:   Wed, 22 Sep 2021 13:23:28 +0000
Message-ID: <2B1FFC77-A740-41AE-BF8C-FB238B9DF7F5@intel.com>
References: <YUsesVeZ8PPC5iV5@zn.tnic>
In-Reply-To: <YUsesVeZ8PPC5iV5@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
Content-Type: text/plain; charset="utf-8"
Content-ID: <E272DB04D6085B48BA39057EA111156F@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TG9va3MgbmljZS4gSSBkb27igJl0IHRoaW5rIHlvdSBuZWVkIHRob3NlIOKAnGJyZWFrO+KAnSBh
ZnRlciBlYWNoIOKAnHJldHVybiDigKY74oCdDQoNClNlbnQgZnJvbSBteSBpUGhvbmUNCg0KPiBP
biBTZXAgMjIsIDIwMjEsIGF0IDA1OjE4LCBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFsaWVuOC5kZT4g
d3JvdGU6DQo+IA0KPiDvu79PbiBNb24sIFNlcCAyMCwgMjAyMSBhdCAxMDozMjoxMUFNICswMjAw
LCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6DQo+PiBidXQgcGxlYXNlIGRvbid0IG1ha2UgbWUgYWRk
IG1vcmUgaGVscGVyIGZ1bmN0aW9ucy4gVGhvc2UgTVNSIGRlZmluZXMNCj4+IGFscmVhZHkgaGF2
ZSAiU01DQSIgYW5kICJJQTMyIiBpbiB0aGVpciBuYW1lcyBzbyB0aGF0IHNob3VsZCBiZSBhIGdv
b2QNCj4+IGVub3VnaCBkaWZmZXJlbnRpYXRpb24sIEknZCBzYXkuDQo+IA0KPiBJIGp1c3QgaGFk
IGEgYmV0dGVyIGlkZWEgLSBpdCBpcyBjb21wYWN0IGJ1dCByZWd1bGFyIGFuZCBvbmUgY2FuIHNl
ZSBhdA0KPiBhIHF1aWNrIGdsYW5jZSB3aGljaCBibG9jayBpcyBmb3Igd2hpY2ggc2V0IG9mIE1T
UnM6DQo+IA0KPiB1MzIgbWNhX21zcl9yZWcoaW50IGJhbmssIGVudW0gbWNhX21zciByZWcpDQo+
IHsNCj4gICAgICAgIGlmIChtY2VfZmxhZ3Muc21jYSkgew0KPiAgICAgICAgICAgICAgICBzd2l0
Y2ggKHJlZykgew0KPiAgICAgICAgICAgICAgICBjYXNlIE1DQV9DVEw6ICAgIHJldHVybiBNU1Jf
QU1ENjRfU01DQV9NQ3hfQ1RMKGJhbmspOyAgICBicmVhazsNCj4gICAgICAgICAgICAgICAgY2Fz
ZSBNQ0FfQUREUjogICByZXR1cm4gTVNSX0FNRDY0X1NNQ0FfTUN4X0FERFIoYmFuayk7ICAgYnJl
YWs7DQo+ICAgICAgICAgICAgICAgIGNhc2UgTUNBX01JU0M6ICAgcmV0dXJuIE1TUl9BTUQ2NF9T
TUNBX01DeF9NSVNDKGJhbmspOyAgIGJyZWFrOw0KPiAgICAgICAgICAgICAgICBjYXNlIE1DQV9T
VEFUVVM6IHJldHVybiBNU1JfQU1ENjRfU01DQV9NQ3hfU1RBVFVTKGJhbmspOyBicmVhazsNCj4g
ICAgICAgICAgICAgICAgZGVmYXVsdDogZ290byBvdXQ7IGJyZWFrOw0KPiAgICAgICAgICAgICAg
ICB9DQo+ICAgICAgICB9DQo+IA0KPiAgICAgICAgc3dpdGNoIChyZWcpIHsNCj4gICAgICAgIGNh
c2UgTUNBX0NUTDogICAgcmV0dXJuIE1TUl9JQTMyX01DeF9DVEwoYmFuayk7ICAgIGJyZWFrOw0K
PiAgICAgICAgY2FzZSBNQ0FfQUREUjogICByZXR1cm4gTVNSX0lBMzJfTUN4X0FERFIoYmFuayk7
ICAgYnJlYWs7DQo+ICAgICAgICBjYXNlIE1DQV9NSVNDOiAgIHJldHVybiBNU1JfSUEzMl9NQ3hf
TUlTQyhiYW5rKTsgICBicmVhazsNCj4gICAgICAgIGNhc2UgTUNBX1NUQVRVUzogcmV0dXJuIE1T
Ul9JQTMyX01DeF9TVEFUVVMoYmFuayk7IGJyZWFrOw0KPiAgICAgICAgZGVmYXVsdDogZ290byBv
dXQ7IGJyZWFrOw0KPiAgICAgICAgfQ0KPiANCj4gb3V0Og0KPiAgICAgICAgV0FSTl9PTl9PTkNF
KDEpOw0KPiAgICAgICAgcmV0dXJuIDA7DQo+IH0NCj4gDQo+IC0tIA0KPiBSZWdhcmRzL0dydXNz
LA0KPiAgICBCb3Jpcy4NCj4gDQo+IGh0dHBzOi8vcGVvcGxlLmtlcm5lbC5vcmcvdGdseC9ub3Rl
cy1hYm91dC1uZXRpcXVldHRlDQo=
