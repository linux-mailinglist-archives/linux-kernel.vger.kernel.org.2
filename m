Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E98F3EA43A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 14:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237213AbhHLMCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 08:02:47 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:30862 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234110AbhHLMCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 08:02:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1628769742; x=1660305742;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:mime-version:content-transfer-encoding:subject;
  bh=ORzTm8jq97PwIjMpp8YDkacjBMA3fJWfWZ7VPexNmNc=;
  b=Zlw5li0opd6ReaubCSSsIlRvlPuBh8qsp9Tv+/u8CqUwi6ELLxjzEv9k
   +qKT/hSdK3MxvUAFrD/akLFwXn8Z7Vpib73UVftlvl7gFfvCb6BuAY3Kw
   vXvM0LrtlQHXlViZc+nyys+eMhnE+5UOfFb24wBcc+lD1XKvr8Uve4yZQ
   o=;
X-IronPort-AV: E=Sophos;i="5.84,315,1620691200"; 
   d="scan'208";a="152066052"
Subject: Re: [PATCH] xen/events: Fix race in set_evtchn_to_irq
Thread-Topic: [PATCH] xen/events: Fix race in set_evtchn_to_irq
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-2a-538b0bfb.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP; 12 Aug 2021 12:02:15 +0000
Received: from EX13D18EUC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2a-538b0bfb.us-west-2.amazon.com (Postfix) with ESMTPS id DF4CCA0624;
        Thu, 12 Aug 2021 12:02:13 +0000 (UTC)
Received: from EX13D08EUC004.ant.amazon.com (10.43.164.176) by
 EX13D18EUC001.ant.amazon.com (10.43.164.108) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Thu, 12 Aug 2021 12:02:12 +0000
Received: from EX13D08EUC004.ant.amazon.com ([10.43.164.176]) by
 EX13D08EUC004.ant.amazon.com ([10.43.164.176]) with mapi id 15.00.1497.023;
 Thu, 12 Aug 2021 12:02:12 +0000
From:   "Heyne, Maximilian" <mheyne@amazon.de>
To:     "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>
CC:     "jbeulich@suse.com" <jbeulich@suse.com>,
        "jgross@suse.com" <jgross@suse.com>,
        "sstabellini@kernel.org" <sstabellini@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Shah, Amit" <aams@amazon.de>,
        "david.vrabel@citrix.com" <david.vrabel@citrix.com>,
        "malcolm.crossley@citrix.com" <malcolm.crossley@citrix.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Thread-Index: AQHXjrpZaLuu4Oit+USMDY60w1pC6qtuZzWAgAFfGYA=
Date:   Thu, 12 Aug 2021 12:02:12 +0000
Message-ID: <361b90c3ec8dc89fa67fb7795d20400f45b53f85.camel@amazon.de>
References: <20210811140806.75710-1-mheyne@amazon.de>
         <482af7c4-ad9e-6054-db45-ec05249a2517@oracle.com>
In-Reply-To: <482af7c4-ad9e-6054-db45-ec05249a2517@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.164.211]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B2862D234C8694D8F78BFF297FB2AEC@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIxLTA4LTExIGF0IDExOjA1IC0wNDAwLCBCb3JpcyBPc3Ryb3Zza3kgd3JvdGU6
DQo+IE9uIDgvMTEvMjEgMTA6MDggQU0sIE1heGltaWxpYW4gSGV5bmUgd3JvdGU6DQo+ID4gVGhp
cyBwYXRjaCBzZXRzIGV2dGNobl90b19pcnEgcm93cyB2aWEgYSBjbXB4Y2hnIG9wZXJhdGlvbiBz
byB0aGF0DQo+ID4gdGhleQ0KPiA+IHdpbGwgYmUgc2V0IG9ubHkgb25jZS4gQ2xlYXJpbmcgdGhl
IHJvdyB3YXMgbW92ZWQgdXAgYmVmb3JlIHdyaXRpbmcNCj4gPiB0aGUNCj4gPiByb3cgdG8gZXZ0
Y2huX3RvX2lycSBpbiBvcmRlciB0byBub3QgY3JlYXRlIGEgcmFjZSBvbmNlIHRoZSByb3cgaXMN
Cj4gPiB2aXNpYmxlIGZvciBvdGhlciB0aHJlYWRzLiBBY2Nlc3NlcyB0byB0aGUgcm93cyBhcmUg
bm93IGd1YXJkZWQgYnkNCj4gPiBSRUFEX09OQ0UgYW5kIFdSSVRFX09OQ0UganVzdCBhcyBmb3Ig
dGhlIGNvbHVtbnMgaW4gdGhlIGRhdGENCj4gPiBzdHJ1Y3R1cmUuDQo+IA0KPiBJcyB0aGlzIGxh
c3QgcGFydCByZWFsbHkgbmVlZGVkPyBXZSBuZWVkZWQgdG8gZG8gdGhhdCBmb3IgYXJyYXkNCj4g
ZWxlbWVudHMgdG8gYXZvaWQgYW4gaW50ZXJydXB0IGhhbmRsZXIgZnJvbSBzZWVpbmcgYSBwYXJ0
aWFsbHkNCj4gdXBkYXRlZCBlbnRyeSBidXQgSSBhbSBub3Qgc3VyZSBJIHNlZSBob3cgdGhpcyBj
YW4gaGFwcGVuIHRvIHRoZSByb3cNCj4gcG9pbnRlci4gVGhlIG9ubHkgcGxhY2Ugd2hlcmUgaXQg
bWlnaHQgYmUgaW1wb3J0YW50IGlzIHdoZW4gd2UgdXBkYXRlDQo+IHRoZSBwb2ludGVyIHRvIHRo
ZSBuZXcgcGFnZSBidXQgeW91IGFyZSB1c2luZyBjbXB4Y2hnIHRoZXJlIGFscmVhZHkuDQoNCkkg
dGhpbmsgeW91IGFyZSByaWdodC4gSSB3aWxsIHJlbW92ZSB0aGUgY2hhbmdlcyByZWxhdGVkIHRv
IHRoZQ0KUkVBRF9PTkNFLg0KDQo+IA0KPiANCj4gPiAtICAgICAgICAgICAgIGV2dGNobl90b19p
cnFbcm93XSA9IChpbnQNCj4gPiAqKWdldF96ZXJvZWRfcGFnZShHRlBfS0VSTkVMKTsNCj4gPiAt
ICAgICAgICAgICAgIGlmIChldnRjaG5fdG9faXJxW3Jvd10gPT0gTlVMTCkNCj4gPiArICAgICAg
ICAgICAgIGV2dGNobl9yb3cgPSAoaW50ICopIGdldF96ZXJvZWRfcGFnZShHRlBfS0VSTkVMKTsN
Cj4gDQo+IE5vdCBkaXJlY3RseSByZWxhdGVkIHRvIHRoaXMgcGF0Y2ggYnV0IEkgZG9uJ3QgdGhp
bmsgd2UgbmVlZCB0byBnZXQgYQ0KPiB6ZXJvZWQgcGFnZSAtLS0gd2Ugd2lsbCBpbml0aWFsaXpl
IGl0IHRvIC0xIGltbWVkaWF0ZWx5IGJlbG93Lg0KDQpUaGF0IGlzIGNvcnJlY3QuIEkgd2lsbCBq
dXN0IGZpeCB0aGlzIGluIHRoZSBuZXh0IHZlcnNpb24gb2YgdGhlIHBhdGNoLg0KDQpNYXgNCgoK
CkFtYXpvbiBEZXZlbG9wbWVudCBDZW50ZXIgR2VybWFueSBHbWJICktyYXVzZW5zdHIuIDM4CjEw
MTE3IEJlcmxpbgpHZXNjaGFlZnRzZnVlaHJ1bmc6IENocmlzdGlhbiBTY2hsYWVnZXIsIEpvbmF0
aGFuIFdlaXNzCkVpbmdldHJhZ2VuIGFtIEFtdHNnZXJpY2h0IENoYXJsb3R0ZW5idXJnIHVudGVy
IEhSQiAxNDkxNzMgQgpTaXR6OiBCZXJsaW4KVXN0LUlEOiBERSAyODkgMjM3IDg3OQoKCg==

