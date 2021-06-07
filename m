Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F328239E6B7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 20:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbhFGSgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 14:36:15 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:9883 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbhFGSgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 14:36:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1623090864; x=1654626864;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:mime-version:content-transfer-encoding:subject;
  bh=OJanA81p8iB5+EQ7j2nBT+85bqesutVGnyJQTOtFoQY=;
  b=C2D+PWoBA83XcxSMBr4Aon1ELjEnGEUoeHGc5J0ZXENaeQcX2rVaZ7xm
   JRz4XMP34oPJ6oPXqkYQSmrNd6VZUCI0oC8xikYgZ8hIYrxX2k0w6p+GW
   SQa4KnHhn1AGDIsOXGzPdT1dFc0149DaKWvw3iRMefkA0mTe3XFAR7OYQ
   o=;
X-IronPort-AV: E=Sophos;i="5.83,255,1616457600"; 
   d="scan'208";a="117139398"
Subject: Re: [PATCH] KVM: arm64: Properly restore PMU state during live-migration
Thread-Topic: [PATCH] KVM: arm64: Properly restore PMU state during live-migration
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-67b371d8.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP; 07 Jun 2021 18:34:16 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-67b371d8.us-east-1.amazon.com (Postfix) with ESMTPS id EBCC5A212F;
        Mon,  7 Jun 2021 18:34:11 +0000 (UTC)
Received: from EX13D20UWC004.ant.amazon.com (10.43.162.41) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.18; Mon, 7 Jun 2021 18:34:11 +0000
Received: from EX13D19EUA001.ant.amazon.com (10.43.165.74) by
 EX13D20UWC004.ant.amazon.com (10.43.162.41) with Microsoft SMTP Server (TLS)
 id 15.0.1497.18; Mon, 7 Jun 2021 18:34:10 +0000
Received: from EX13D19EUA001.ant.amazon.com ([10.43.165.74]) by
 EX13D19EUA001.ant.amazon.com ([10.43.165.74]) with mapi id 15.00.1497.018;
 Mon, 7 Jun 2021 18:34:09 +0000
From:   "Jain, Jinank" <jinankj@amazon.de>
To:     "maz@kernel.org" <maz@kernel.org>
CC:     "james.morse@arm.com" <james.morse@arm.com>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alexandru.elisei@arm.com" <alexandru.elisei@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "will@kernel.org" <will@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "Graf (AWS), Alexander" <graf@amazon.de>
Thread-Index: AQHXWGiDwgcuw84aU0uAgEUSGDYWHasCc0sAgAZJnQCAAAh2gIAAITgA
Date:   Mon, 7 Jun 2021 18:34:08 +0000
Message-ID: <b4392eae86311425a0c1f2b2072e41dbb437a4e2.camel@amazon.de>
References: <20210603110554.13643-1-jinankj@amazon.de>
         <87wnrbylxv.wl-maz@kernel.org>
         <0a694ea93303bfa04530cd940f692244e1ccd1e7.camel@amazon.de>
         <87lf7lzl8c.wl-maz@kernel.org>
In-Reply-To: <87lf7lzl8c.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.165.82]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B575D37266815C429D0BF2542EC58286@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFyYy4NCg0KT24gTW9uLCAyMDIxLTA2LTA3IGF0IDE3OjM1ICswMTAwLCBNYXJjIFp5bmdp
ZXIgd3JvdGU6DQo+IENBVVRJT046IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUg
b2YgdGhlIG9yZ2FuaXphdGlvbi4gRG8NCj4gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNo
bWVudHMgdW5sZXNzIHlvdSBjYW4gY29uZmlybSB0aGUgc2VuZGVyDQo+IGFuZCBrbm93IHRoZSBj
b250ZW50IGlzIHNhZmUuDQo+IA0KPiANCj4gDQo+IE9uIE1vbiwgMDcgSnVuIDIwMjEgMTc6MDU6
MDEgKzAxMDAsDQo+ICJKYWluLCBKaW5hbmsiIDxqaW5hbmtqQGFtYXpvbi5kZT4gd3JvdGU6DQo+
ID4gT24gVGh1LCAyMDIxLTA2LTAzIGF0IDE3OjAzICswMTAwLCBNYXJjIFp5bmdpZXIgd3JvdGU6
DQo+ID4gPiBIaSBKaW5hbmssDQo+ID4gPiANCj4gPiA+IE9uIFRodSwgMDMgSnVuIDIwMjEgMTI6
MDU6NTQgKzAxMDAsDQo+ID4gPiBKaW5hbmsgSmFpbiA8amluYW5rakBhbWF6b24uZGU+IHdyb3Rl
Og0KPiA+ID4gPiBDdXJyZW50bHkgaWYgYSBndWVzdCBpcyBsaXZlLW1pZ3JhdGVkIHdoaWxlIGl0
IGlzIGFjdGl2ZWx5DQo+ID4gPiA+IHVzaW5nDQo+ID4gPiA+IHBlcmYNCj4gPiA+ID4gY291bnRl
cnMsIHRoZW4gYWZ0ZXIgbGl2ZS1taWdyYXRlIGl0IHdpbGwgbm90aWNlIHRoYXQgYWxsDQo+ID4g
PiA+IGNvdW50ZXJzDQo+ID4gPiA+IHdvdWxkDQo+ID4gPiA+IHN1ZGRlbmx5IHN0YXJ0IHJlcG9y
dGluZyAwcy4gVGhpcyBpcyBkdWUgdG8gdGhlIGZhY3Qgd2UgYXJlIG5vdA0KPiA+ID4gPiByZS1j
cmVhdGluZyB0aGUgcmVsZXZhbnQgcGVyZiBldmVudHMgaW5zaWRlIHRoZSBrZXJuZWwuDQo+ID4g
PiA+IA0KPiA+ID4gPiBVc3VhbGx5IG9uIGxpdmUtbWlncmF0aW9uIGd1ZXN0IHN0YXRlIGlzIHJl
c3RvcmVkIHVzaW5nDQo+ID4gPiA+IEtWTV9TRVRfT05FX1JFRw0KPiA+ID4gPiBpb2N0bCBpbnRl
cmZhY2UsIHdoaWNoIHNpbXBseSByZXN0b3JlcyB0aGUgdmFsdWUgb2YgUE1VDQo+ID4gPiA+IHJl
Z2lzdGVycw0KPiA+ID4gPiB2YWx1ZXMgYnV0IGRvZXMgbm90IHJlLXByb2dyYW0gdGhlIHBlcmYg
ZXZlbnRzIHNvIHRoYXQgdGhlDQo+ID4gPiA+IGd1ZXN0DQo+ID4gPiA+IGNhbiBzZWFtbGVzc2x5
DQo+ID4gPiA+IHVzZSB0aGVzZSBjb3VudGVycyBldmVuIGFmdGVyIGxpdmUtbWlncmF0aW9uIGxp
a2UgaXQgd2FzIGRvaW5nDQo+ID4gPiA+IGJlZm9yZQ0KPiA+ID4gPiBsaXZlLW1pZ3JhdGlvbi4N
Cj4gPiA+ID4gDQo+ID4gPiA+IEluc3RlYWQgdGhlcmUgYXJlIHR3byBjb21wbGV0ZWx5IGRpZmZl
cmVudCBjb2RlIHBhdGggYmV0d2Vlbg0KPiA+ID4gPiBndWVzdA0KPiA+ID4gPiBhY2Nlc3Npbmcg
UE1VIHJlZ2lzdGVycyBhbmQgVk1NIHJlc3RvcmluZyBjb3VudGVycyBvbg0KPiA+ID4gPiBsaXZl
LW1pZ3JhdGlvbi4NCj4gPiA+ID4gDQo+ID4gPiA+IEluIGNhc2Ugb2YgS1ZNX1NFVF9PTkVfUkVH
Og0KPiA+ID4gPiANCj4gPiA+ID4ga3ZtX2FybV9zZXRfcmVnKCkNCj4gPiA+ID4gLi4uLi4uIGt2
bV9hcm1fc3lzX3JlZ19zZXRfcmVnKCkNCj4gPiA+ID4gLi4uLi4uLi4uLi4gcmVnX2Zyb21fdXNl
cigpDQo+ID4gPiA+IA0KPiA+ID4gPiBidXQgaW4gY2FzZSB3aGVuIGd1ZXN0IHRyaWVzIHRvIGFj
Y2VzcyB0aGVzZSBjb3VudGVyczoNCj4gPiA+ID4gDQo+ID4gPiA+IGhhbmRsZV9leGl0KCkNCj4g
PiA+ID4gLi4uLi4ga3ZtX2hhbmRsZV9zeXNfcmVnKCkNCj4gPiA+ID4gLi4uLi4uLi4uLnBlcmZv
cm1fYWNjZXNzKCkNCj4gPiA+ID4gLi4uLi4uLi4uLi4uLi4uYWNjZXNzX3BtdV9ldmNudHIoKQ0K
PiA+ID4gPiAuLi4uLi4uLi4uLi4uLi4uLi4ua3ZtX3BtdV9zZXRfY291bnRlcl92YWx1ZSgpDQo+
ID4gPiA+IC4uLi4uLi4uLi4uLi4uLi4uLi4uLi4ua3ZtX3BtdV9jcmVhdGVfcGVyZl9ldmVudCgp
DQo+ID4gPiA+IA0KPiA+ID4gPiBUaGUgZHJhd2JhY2sgb2YgdXNpbmcgdGhlIEtWTV9TRVRfT05F
X1JFRyBpbnRlcmZhY2UgaXMgdGhhdCB0aGUNCj4gPiA+ID4gaG9zdCBwbXUNCj4gPiA+ID4gZXZl
bnRzIHdoaWNoIHdlcmUgcmVnaXN0ZXJlZCBmb3IgdGhlIHNvdXJjZSBpbnN0YW5jZSBhbmQgbm90
DQo+ID4gPiA+IHByZXNlbnQgZm9yDQo+ID4gPiA+IHRoZSBkZXN0aW5hdGlvbiBpbnN0YW5jZS4N
Cj4gPiA+IA0KPiA+ID4gSSBjYW4ndCBwYXJzZSB0aGlzIHNlbnRlbmNlLiBEbyB5b3UgbWVhbiAi
YXJlIG5vdCBwcmVzZW50Ij8NCj4gPiA+IA0KPiA+ID4gPiBUaHVzIHBhc3NpdmVseSByZXN0b3Jp
bmcgUE1DUl9FTDAgdXNpbmcNCj4gPiA+ID4gS1ZNX1NFVF9PTkVfUkVHIGludGVyZmFjZSB3b3Vs
ZCBub3QgY3JlYXRlIHRoZSBuZWNlc3NhcnkgaG9zdA0KPiA+ID4gPiBwbXUNCj4gPiA+ID4gZXZl
bnRzDQo+ID4gPiA+IHdoaWNoIGFyZSBjcnVjaWFsIGZvciBzZWFtbGVzcyBndWVzdCBleHBlcmll
bmNlIGFjcm9zcyBsaXZlDQo+ID4gPiA+IG1pZ3JhdGlvbi4NCj4gPiA+ID4gDQo+ID4gPiA+IElu
IG9yZGV0IHRvIGZpeCB0aGUgc2l0dWF0aW9uLCBvbiBmaXJzdCB2Y3B1IGxvYWQgd2Ugc2hvdWxk
DQo+ID4gPiA+IHJlc3RvcmUNCj4gPiA+ID4gUE1DUl9FTDAgaW4gdGhlIHNhbWUgZXhhY3Qgd2F5
IGxpa2UgdGhlIGd1ZXN0IHdhcyB0cnlpbmcgdG8NCj4gPiA+ID4gYWNjZXNzDQo+ID4gPiA+IHRo
ZXNlIGNvdW50ZXJzLiBBbmQgdGhlbiB3ZSB3aWxsIGFsc28gcmVjcmVhdGUgdGhlIHJlbGV2YW50
DQo+ID4gPiA+IGhvc3QNCj4gPiA+ID4gcG11DQo+ID4gPiA+IGV2ZW50cy4NCj4gPiA+ID4gDQo+
ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEppbmFuayBKYWluIDxqaW5hbmtqQGFtYXpvbi5kZT4NCj4g
PiA+ID4gQ2M6IEFsZXhhbmRlciBHcmFmIChBV1MpIDxncmFmQGFtYXpvbi5kZT4NCj4gPiA+ID4g
Q2M6IE1hcmMgWnluZ2llciA8bWF6QGtlcm5lbC5vcmc+DQo+ID4gPiA+IENjOiBKYW1lcyBNb3Jz
ZSA8amFtZXMubW9yc2VAYXJtLmNvbT4NCj4gPiA+ID4gQ2M6IEFsZXhhbmRydSBFbGlzZWkgPGFs
ZXhhbmRydS5lbGlzZWlAYXJtLmNvbT4NCj4gPiA+ID4gQ2M6IFN1enVraSBLIFBvdWxvc2UgPHN1
enVraS5wb3Vsb3NlQGFybS5jb20+DQo+ID4gPiA+IENjOiBDYXRhbGluIE1hcmluYXMgPGNhdGFs
aW4ubWFyaW5hc0Bhcm0uY29tPg0KPiA+ID4gPiBDYzogV2lsbCBEZWFjb24gPHdpbGxAa2VybmVs
Lm9yZz4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICBhcmNoL2FybTY0L2luY2x1ZGUvYXNtL2t2bV9o
b3N0LmggfCAgMSArDQo+ID4gPiA+ICBhcmNoL2FybTY0L2t2bS9hcm0uYyAgICAgICAgICAgICAg
fCAgMSArDQo+ID4gPiA+ICBhcmNoL2FybTY0L2t2bS9wbXUtZW11bC5jICAgICAgICAgfCAxMCAr
KysrKysrKy0tDQo+ID4gPiA+ICBhcmNoL2FybTY0L2t2bS9wbXUuYyAgICAgICAgICAgICAgfCAx
NSArKysrKysrKysrKysrKysNCj4gPiA+ID4gIGluY2x1ZGUva3ZtL2FybV9wbXUuaCAgICAgICAg
ICAgICB8ICAzICsrKw0KPiA+ID4gPiAgNSBmaWxlcyBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQ0KPiA+ID4gPiANCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJt
NjQvaW5jbHVkZS9hc20va3ZtX2hvc3QuaA0KPiA+ID4gPiBiL2FyY2gvYXJtNjQvaW5jbHVkZS9h
c20va3ZtX2hvc3QuaA0KPiA+ID4gPiBpbmRleCA3Y2Q3ZDVjOGM0YmMuLjIzNzZhZDNjMmZjMiAx
MDA2NDQNCj4gPiA+ID4gLS0tIGEvYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9rdm1faG9zdC5oDQo+
ID4gPiA+ICsrKyBiL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20va3ZtX2hvc3QuaA0KPiA+ID4gPiBA
QCAtNzQ1LDYgKzc0NSw3IEBAIHN0YXRpYyBpbmxpbmUgaW50DQo+ID4gPiA+IGt2bV9hcmNoX3Zj
cHVfcnVuX3BpZF9jaGFuZ2Uoc3RydWN0IGt2bV92Y3B1ICp2Y3B1KQ0KPiA+ID4gPiAgdm9pZCBr
dm1fc2V0X3BtdV9ldmVudHModTMyIHNldCwgc3RydWN0IHBlcmZfZXZlbnRfYXR0cg0KPiA+ID4g
PiAqYXR0cik7DQo+ID4gPiA+ICB2b2lkIGt2bV9jbHJfcG11X2V2ZW50cyh1MzIgY2xyKTsNCj4g
PiA+ID4gDQo+ID4gPiA+ICt2b2lkIGt2bV92Y3B1X3BtdV9yZXN0b3JlKHN0cnVjdCBrdm1fdmNw
dSAqdmNwdSk7DQo+ID4gPiA+ICB2b2lkIGt2bV92Y3B1X3BtdV9yZXN0b3JlX2d1ZXN0KHN0cnVj
dCBrdm1fdmNwdSAqdmNwdSk7DQo+ID4gPiA+ICB2b2lkIGt2bV92Y3B1X3BtdV9yZXN0b3JlX2hv
c3Qoc3RydWN0IGt2bV92Y3B1ICp2Y3B1KTsNCj4gPiA+ID4gICNlbHNlDQo+ID4gPiA+IGRpZmYg
LS1naXQgYS9hcmNoL2FybTY0L2t2bS9hcm0uYyBiL2FyY2gvYXJtNjQva3ZtL2FybS5jDQo+ID4g
PiA+IGluZGV4IGU3MjAxNDgyMzJhMC4uYzY2ZjZkMTZlYzA2IDEwMDY0NA0KPiA+ID4gPiAtLS0g
YS9hcmNoL2FybTY0L2t2bS9hcm0uYw0KPiA+ID4gPiArKysgYi9hcmNoL2FybTY0L2t2bS9hcm0u
Yw0KPiA+ID4gPiBAQCAtNDA4LDYgKzQwOCw3IEBAIHZvaWQga3ZtX2FyY2hfdmNwdV9sb2FkKHN0
cnVjdCBrdm1fdmNwdQ0KPiA+ID4gPiAqdmNwdSwNCj4gPiA+ID4gaW50IGNwdSkNCj4gPiA+ID4g
ICAgICAgaWYgKGhhc192aGUoKSkNCj4gPiA+ID4gICAgICAgICAgICAgICBrdm1fdmNwdV9sb2Fk
X3N5c3JlZ3NfdmhlKHZjcHUpOw0KPiA+ID4gPiAgICAgICBrdm1fYXJjaF92Y3B1X2xvYWRfZnAo
dmNwdSk7DQo+ID4gPiA+ICsgICAgIGt2bV92Y3B1X3BtdV9yZXN0b3JlKHZjcHUpOw0KPiA+ID4g
DQo+ID4gPiBJZiB0aGlzIG9ubHkgbmVlZHMgdG8gYmUgcnVuIG9uY2UgcGVyIHZjcHUsIHdoeSBu
b3QgdHJpZ2dlciBpdA0KPiA+ID4gZnJvbQ0KPiA+ID4ga3ZtX2FybV9wbXVfdjNfZW5hYmxlKCks
IHdoaWNoIGlzIGFsc28gY2FsbGVkIG9uY2UgcGVyIHZjcHU/DQo+ID4gPiANCj4gPiA+IFRoaXMg
Y2FuIGRvbmUgb24gdGhlIGJhY2sgb2YgYSByZXF1ZXN0LCBzYXZpbmcgbW9zdCBvZiB0aGUNCj4g
PiA+IG92ZXJoZWFkDQo+ID4gPiBhbmQgbm90IHJlcXVpcmluZyBhbnkgZXh0cmEgZmllbGQuIEVz
c2VudGlhbGx5LCBzb21ldGhpbmcgbGlrZQ0KPiA+ID4gdGhlDQo+ID4gPiAodW50ZXN0ZWQpIHBh
dGNoIGJlbG93Lg0KPiA+ID4gDQo+ID4gPiA+ICAgICAgIGt2bV92Y3B1X3BtdV9yZXN0b3JlX2d1
ZXN0KHZjcHUpOw0KPiA+ID4gPiAgICAgICBpZiAoa3ZtX2FybV9pc19wdnRpbWVfZW5hYmxlZCgm
dmNwdS0+YXJjaCkpDQo+ID4gPiA+ICAgICAgICAgICAgICAga3ZtX21ha2VfcmVxdWVzdChLVk1f
UkVRX1JFQ09SRF9TVEVBTCwgdmNwdSk7DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0
L2t2bS9wbXUtZW11bC5jIGIvYXJjaC9hcm02NC9rdm0vcG11LQ0KPiA+ID4gPiBlbXVsLmMNCj4g
PiA+ID4gaW5kZXggZmQxNjdkNGY0MjE1Li4xMmE0MGY0YjVmMGQgMTAwNjQ0DQo+ID4gPiA+IC0t
LSBhL2FyY2gvYXJtNjQva3ZtL3BtdS1lbXVsLmMNCj4gPiA+ID4gKysrIGIvYXJjaC9hcm02NC9r
dm0vcG11LWVtdWwuYw0KPiA+ID4gPiBAQCAtNTc0LDEwICs1NzQsMTYgQEAgdm9pZCBrdm1fcG11
X2hhbmRsZV9wbWNyKHN0cnVjdCBrdm1fdmNwdQ0KPiA+ID4gPiAqdmNwdSwgdTY0IHZhbCkNCj4g
PiA+ID4gICAgICAgICAgICAgICBrdm1fcG11X2Rpc2FibGVfY291bnRlcl9tYXNrKHZjcHUsIG1h
c2spOw0KPiA+ID4gPiAgICAgICB9DQo+ID4gPiA+IA0KPiA+ID4gPiAtICAgICBpZiAodmFsICYg
QVJNVjhfUE1VX1BNQ1JfQykNCj4gPiA+ID4gKyAgICAgLyoNCj4gPiA+ID4gKyAgICAgICogQ3lj
bGUgY291bnRlciBuZWVkcyB0byByZXNldCBpbiBjYXNlIG9mIGZpcnN0IHZjcHUNCj4gPiA+ID4g
bG9hZC4NCj4gPiA+ID4gKyAgICAgICovDQo+ID4gPiA+ICsgICAgIGlmICh2YWwgJiBBUk1WOF9Q
TVVfUE1DUl9DIHx8DQo+ID4gPiA+ICFrdm1fYXJtX3BtdV92M19yZXN0b3JlZCh2Y3B1KSkNCj4g
PiA+IA0KPiA+ID4gV2h5PyBUaGVyZSBpcyBubyBhcmNoaXRlY3R1cmFsIGd1YXJhbnRlZSB0aGF0
IGEgY291bnRlciByZXNldHMgdG8NCj4gPiA+IDANCj4gPiA+IHdpdGhvdXQgd3JpdGluZyBQTUNS
X0VMMC5DLiBBbmQgaWYgeW91IHdhbnQgdGhlIGd1ZXN0IHRvIGNvbnRpbnVlDQo+ID4gPiBjb3Vu
dGluZyB3aGVyZSBpdCBsZWZ0IG9mZiwgcmVzZXR0aW5nIHRoZSBjb3VudGVyIGlzIGF0IGJlc3QN
Cj4gPiA+IGNvdW50ZXItcHJvZHVjdGl2ZS4NCj4gPiANCj4gPiBXaXRob3V0IHRoaXMgd2Ugd291
bGQgbm90IGJlIHJlc2V0dGluZyBQTVUgd2hpY2ggaXMgcmVxdWlyZWQgZm9yDQo+ID4gY3JlYXRp
bmcgaG9zdCBwZXJmIGV2ZW50cy4gV2l0aCB0aGUgcGF0Y2ggdGhhdCB5b3Ugc3VnZ2VzdGVkIHdl
IGFyZQ0KPiA+IHJlc3RvcmluZyBQTUNSX0VMMCBwcm9wZXJseSBidXQgc3RpbGwgbWlzc2luZyBy
ZWNyZWF0aW9uIG9mIGhvc3QNCj4gPiBwZXJmDQo+ID4gZXZlbnRzLg0KPiANCj4gSG93PyBUaGUg
cmVxdWVzdCB0aGF0IGdldHMgc2V0IG9uIHRoZSBmaXJzdCB2Y3B1IHJ1biB3aWxsIGNhbGwNCj4g
a3ZtX3BtdV9oYW5kbGVfcG1jcigpIC0+IGt2bV9wbXVfZW5hYmxlX2NvdW50ZXJfbWFzaygpIC0+
DQo+IGt2bV9wbXVfY3JlYXRlX3BlcmZfZXZlbnQoKS4gV2hhdCBhcmUgd2UgbWlzc2luZz8NCj4g
DQoNCkkgZm91bmQgb3V0IHdoYXQgSSB3YXMgbWlzc2luZy4gSSB3YXMgd29ya2luZyB3aXRoIGFu
IG9sZGVyIGtlcm5lbA0Kd2hpY2ggd2FzIG1pc3NpbmcgdGhpcyB1cHN0cmVhbSBwYXRjaDoNCg0K
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIwMDEyNDE0MjUzNS4yOTM4Ni0zLWVyaWMu
YXVnZXJAcmVkaGF0LmNvbS8NCg0KPiA+IEFuZCB3aXRob3V0IGhvc3QgcGVyZiBldmVudHMsIGd1
ZXN0IHdvdWxkIHN0aWxsIHplcm9zIGFmdGVyIGxpdmUNCj4gPiBtaWdyYXRpb24uIEluIG15IG9w
aW5pb24gd2UgaGF2ZSB0d28gd2F5cyB0byBmaXggaXQuIFdlIGNhbiBmaXggaXQNCj4gPiBpbnNp
ZGUgdGhlIGtlcm5lbCBvciBsZXQgdXNlcnNwYWNlL1ZNTSBzZXQgdGhvc2UgYml0cyBiZWZvcmUN
Cj4gPiByZXN0YXJ0aW5nIHRoZSBndWVzdCBvbiB0aGUgZGVzdGluYXRpb24gbWFjaGluZS4gV2hh
dCBkbyB5b3UgdGhpbms/DQo+IA0KPiBJIHRoaW5rIGVpdGhlciB5b3UncmUgbWlzc2luZyBteSBw
b2ludCBhYm92ZSwgb3IgSSdtIGNvbXBsZXRlbHkNCj4gbWlzc2luZyB5b3Vycy4gQW5kIEkgc3Rp
bGwgZG9uJ3QgdW5kZXJzdGFuZCB3aHkgeW91IHdhbnQgdG8gemVybyB0aGUNCj4gY291bnRlcnMg
dGhhdCB5b3UgaGF2ZSBqdXN0IHJlc3RvcmVkLiBIb3cgZG9lcyB0aGF0IGhlbHA/DQo+IA0KPiAg
ICAgICAgIE0uDQo+IA0KPiAtLQ0KPiBXaXRob3V0IGRldmlhdGlvbiBmcm9tIHRoZSBub3JtLCBw
cm9ncmVzcyBpcyBub3QgcG9zc2libGUuDQoKCgpBbWF6b24gRGV2ZWxvcG1lbnQgQ2VudGVyIEdl
cm1hbnkgR21iSApLcmF1c2Vuc3RyLiAzOAoxMDExNyBCZXJsaW4KR2VzY2hhZWZ0c2Z1ZWhydW5n
OiBDaHJpc3RpYW4gU2NobGFlZ2VyLCBKb25hdGhhbiBXZWlzcwpFaW5nZXRyYWdlbiBhbSBBbXRz
Z2VyaWNodCBDaGFybG90dGVuYnVyZyB1bnRlciBIUkIgMTQ5MTczIEIKU2l0ejogQmVybGluClVz
dC1JRDogREUgMjg5IDIzNyA4NzkKCgo=

