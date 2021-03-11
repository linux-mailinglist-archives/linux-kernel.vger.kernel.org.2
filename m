Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1776337B9A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 19:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbhCKSB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 13:01:26 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:25835 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhCKSA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 13:00:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1615485658; x=1647021658;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=hHiE2Fj7HclUhCU3wVryRnGIXFbUXKZ4cNoeZhT7hAU=;
  b=QuWJN195TxKdBc4aMr4JKlAAgtIXH4ucpj2i5AdUsGlSLUdoeD+4ZFVs
   SyA2pe030lj8yp/wUxZJ8Svinqvk6berBHFTzDF1ZpF49BvXDOFyH47ek
   AUPOXoO7kjcgLfN3QDxh26GE6c1cpTMPDQQMzED7XJ+uB1llzT7oLCmsT
   U=;
IronPort-HdrOrdr: A9a23:mT+wi6/2irjurghqMeNuk+AAI+orLtY04lQ7vn1ZYxpTb8Ceio
 SSh/wdzxD5k3I8X3snlNCGNsC7IE/035hz/IUXIPOeTBDr0VHHEKhO5ZbvqgeNJwTQ7ehYvJ
 0LT4FbKPndSWd3ltz75g7QKb0d6eKK+qypmuvSpk0FJT1CUb1q7AtyF2+gfXFeeQ8uP/cEKK
 Y=
X-IronPort-AV: E=Sophos;i="5.81,241,1610409600"; 
   d="scan'208";a="96534095"
Subject: Re: [PATCH 0/3] Add support for free vmemmap pages of HugeTLB for arm64
Thread-Topic: [PATCH 0/3] Add support for free vmemmap pages of HugeTLB for arm64
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2c-cc689b93.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 11 Mar 2021 18:00:47 +0000
Received: from EX13D22EUA004.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2c-cc689b93.us-west-2.amazon.com (Postfix) with ESMTPS id 987C0121740;
        Thu, 11 Mar 2021 18:00:45 +0000 (UTC)
Received: from EX13D22EUA003.ant.amazon.com (10.43.165.210) by
 EX13D22EUA004.ant.amazon.com (10.43.165.129) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 11 Mar 2021 18:00:44 +0000
Received: from EX13D22EUA003.ant.amazon.com ([10.43.165.210]) by
 EX13D22EUA003.ant.amazon.com ([10.43.165.210]) with mapi id 15.00.1497.012;
 Thu, 11 Mar 2021 18:00:44 +0000
From:   "Bodeddula, Balasubramaniam" <bodeddub@amazon.com>
To:     Chen Huang <chenhuang5@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        "will@kernel.org" <will@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "david@redhat.com" <david@redhat.com>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "rientjes@google.com" <rientjes@google.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "duanxiongchun@bytedance.com" <duanxiongchun@bytedance.com>,
        "Umesh Sargur, Gautam" <sargur@amazon.com>
Thread-Index: AQHXFX2f1iiLEa+yjUWtpclelFHNUap+Lo8AgABpoYD//7SwAIABJUCA
Date:   Thu, 11 Mar 2021 18:00:44 +0000
Message-ID: <FE02DFEF-9706-4CEE-8949-89BD13C2AE00@amazon.com>
References: <20210310071535.35245-1-songmuchun@bytedance.com>
 <3eae8b3e-d6e0-83c8-e9c6-5420767788d5@huawei.com>
 <ED06294F-F046-4B21-9E52-F439C2B32B45@amazon.com>
 <aa3a5951-9dab-d1e1-8257-3569c269e3cf@huawei.com>
In-Reply-To: <aa3a5951-9dab-d1e1-8257-3569c269e3cf@huawei.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.166.119]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C3B7EA81B9044E4AB8103B2854F4AA97@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGV5LCB0aGFua3MgZm9yIHRoZSB0ZXN0aW5nIHN0ZXBzLg0KDQpJIHRyaWVkIGFwcGx5aW5nIHRo
ZXNlIHBhdGNoZXMgb24gNS4xMSBzb3VyY2UgdHJlZS4gVGhlc2UgcGF0Y2hlcyB3ZXJlIGFwcGxp
ZWQgb24gdG9wIG9mIHRoZSB4ODYgcGF0Y2gsIHdoaWNoIHdvcmtlZCBmaW5lLiBCdXQgaW4gdGhp
cyBjYXNlIHdlIGRvbid0IHNlZSB0aGUgc2FtZSBpbXByb3ZlbWVudHMgaW4gb3VyIHRlc3Rpbmcu
IFdlIG1hZGUgc3VyZSB3ZSBzZXQgQ09ORklHX0hVR0VUTEJfUEFHRV9GUkVFX1ZNRU1NQVA9eSBp
biBvdXIgLmNvbmZpZyBmaWxlLg0KDQpBcmUgd2UgbWlzc2luZyBhbnkgbW9yZSBjb25maWd1cmF0
aW9uIHNldHRpbmdzIHRvIGdldCB0aGlzIHBhdGNoIHRvIHdvcmsgb24gQVJNPyBDYW4geW91IHBs
ZWFzZSBoZWxwIHdpdGggZ2VuZXJhbCB0cm91Ymxlc2hvb3Rpbmcgc3RlcHMgdG8gZGVidWcgd2hh
dCBjb3VsZCBiZSBnb2luZyB3cm9uZy4NCg0K77u/T24gMTEvMDMvMjEsIDExOjMyIEFNLCAiQ2hl
biBIdWFuZyIgPGNoZW5odWFuZzVAaHVhd2VpLmNvbT4gd3JvdGU6DQoNCiAgICBDQVVUSU9OOiBU
aGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIHRoZSBvcmdhbml6YXRpb24uIERv
IG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UgY2FuIGNvbmZp
cm0gdGhlIHNlbmRlciBhbmQga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KDQoNCg0KICAgIOWc
qCAyMDIxLzMvMTEgMTM6MDAsIEJvZGVkZHVsYSwgQmFsYXN1YnJhbWFuaWFtIOWGmemBkzoNCiAg
ICA+IENoZW4sIGlzIHlvdXIgdGVzdGluZyBzdGVwcyBkb2N1bWVudGVkIHNvbWV3aGVyZSwgY2Fu
IHlvdSBwbGVhc2UgcG9pbnQgdXMgdG8gdGhlIHNhbWUuIEkgZm9sbG93ZWQgc29tZSBzdGVwcyBm
b3IgdGVzdGluZyB0aGUgeDg2IHBhdGNoZXMsIGp1c3Qgd2FudGVkIHRvIG1ha2Ugc3VyZSBJIGFt
IGNvdmVyaW5nIHlvdXIgdGVzdHMgYXMgd2VsbC4gV2UgYXJlIGFjdGl2ZWx5IHdvcmtpbmcgb24g
YnVpbGRpbmcgYW5kIHRlc3RpbmcgdGhlc2UgcGF0Y2hlcyBmb3IgQVJNLg0KICAgID4NCiAgICA+
IE9uIDExLzAzLzIxLCA5OjQ0IEFNLCAiQ2hlbiBIdWFuZyIgPGNoZW5odWFuZzVAaHVhd2VpLmNv
bT4gd3JvdGU6DQogICAgPg0KICAgID4gICAgIENBVVRJT046IFRoaXMgZW1haWwgb3JpZ2luYXRl
ZCBmcm9tIG91dHNpZGUgb2YgdGhlIG9yZ2FuaXphdGlvbi4gRG8gbm90IGNsaWNrIGxpbmtzIG9y
IG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBjYW4gY29uZmlybSB0aGUgc2VuZGVyIGFuZCBr
bm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQogICAgPg0KICAgID4NCiAgICA+DQogICAgPiAgICAg
5ZyoIDIwMjEvMy8xMCAxNToxNSwgTXVjaHVuIFNvbmcg5YaZ6YGTOg0KICAgID4gICAgID4gVGhp
cyBwYXRjaHNldCBpcyBiYXNlZCBvbiB0aGUgc2VyaWVzIG9mICJGcmVlIHNvbWUgdm1lbW1hcCBw
YWdlcyBvZiBIdWdlVExCDQogICAgPiAgICAgPiBwYWdlIi4gTW9yZSBkZXRhaWxzIGNhbiByZWZl
ciB0byB0aGUgYmVsb3cgbGluay4NCiAgICA+ICAgICA+DQogICAgPiAgICAgPiAgIGh0dHBzOi8v
bGttbC5rZXJuZWwub3JnL3IvMjAyMTAzMDgxMDI4MDcuNTk3NDUtMS1zb25nbXVjaHVuQGJ5dGVk
YW5jZS5jb20NCiAgICA+ICAgICA+DQogICAgPiAgICAgPiBJIG9mdGVuIHJlY2VpdmVkIHNvbWUg
ZmVlZGJhY2sgKFdlIHdhbnQgdG8gdGVzdCB0aGlzIGZlYXR1cmUgb24gYXJtNjQpIGJlZm9yZS4N
CiAgICA+ICAgICA+IEJlY2F1c2UgdGhlIHByZXZpb3VzIGNvZGUgaGFzIGJlZW4gcmV2aWV3ZWQg
Zm9yIDE4IHZlcnNpb25zIGFuZCBpcyBtZXJnZWQNCiAgICA+ICAgICA+IGludG8gbW0gdHJlZSwg
SSB0aGluayB0aGF0IGl0IGlzIHRpbWUgdG8gcmVsZWFzZSB0aGlzIHBhdGNoc2V0LiBJZiB5b3Ug
d2FudA0KICAgID4gICAgID4gdG8gdGVzdCB0aGVuIHlvdSBjYW4gc3RhcnQgbm93IDotKS4gQW5k
IEkgYWxzbyBob3BlIHNvbWVvbmUgY2FuIHJldmlldyB0aGlzLg0KICAgID4gICAgID4NCiAgICA+
ICAgICA+IFRoYW5rcy4NCiAgICA+ICAgICA+DQogICAgPiAgICAgPiBNdWNodW4gU29uZyAoMyk6
DQogICAgPiAgICAgPiAgIG1tOiBib290bWVtX2luZm86IG1hcmsgcmVnaXN0ZXJfcGFnZV9ib290
bWVtX2luZm9fc2VjdGlvbiBfX2luaXQNCiAgICA+ICAgICA+ICAgbW06IGh1Z2V0bGI6IGludHJv
ZHVjZSBhcmNoX2ZyZWVfdm1lbW1hcF9wYWdlDQogICAgPiAgICAgPiAgIGFybTY0OiBtbTogaHVn
ZXRsYjogYWRkIHN1cHBvcnQgZm9yIGZyZWUgdm1lbW1hcCBwYWdlcyBvZiBIdWdlVExCDQogICAg
PiAgICAgPg0KICAgID4gICAgID4gIGFyY2gvYXJtNjQvbW0vbW11LmMgICB8IDUgKysrKysNCiAg
ICA+ICAgICA+ICBhcmNoL3g4Ni9tbS9pbml0XzY0LmMgfCA1ICsrKysrDQogICAgPiAgICAgPiAg
ZnMvS2NvbmZpZyAgICAgICAgICAgIHwgNCArKy0tDQogICAgPiAgICAgPiAgbW0vYm9vdG1lbV9p
bmZvLmMgICAgIHwgNCArKy0tDQogICAgPiAgICAgPiAgbW0vc3BhcnNlLXZtZW1tYXAuYyAgIHwg
OSArKysrKysrLS0NCiAgICA+ICAgICA+ICA1IGZpbGVzIGNoYW5nZWQsIDIxIGluc2VydGlvbnMo
KyksIDYgZGVsZXRpb25zKC0pDQogICAgPiAgICAgPg0KICAgID4NCiAgICA+ICAgICBUZXN0ZWQt
Ynk6IENoZW4gSHVhbmcgPGNoZW5odWFuZzVAaHVhd2VpLmNvbT4NCiAgICA+DQogICAgPiAgICAg
SSBoYXZlIHRlc3RlZCB0aGUgcGF0Y2ggYW5kIHRoZSByZXN1bHQgaXMgc2FtZSBhcyB0aGUgbGFz
dCB0aW1lLg0KICAgID4NCg0KICAgIFRoZSB0ZXN0IHdvcmsgaXMgdGhhdDogSSBzZXQgdGhlIHRv
dGFsIG1lbW9yeSBvZiA0MEcsIGFuZCB1c2UgMTBHIGZvciBodWdlcGFnZXMuDQogICAgRmlyc3Qg
SSByZXNlcnZlIDEwRyBodWdlcGFnZXMgZnJvbSB0aGUgY29tbWFuZCBsaW5lIGFuZCB0aGUgcmVz
dWx0IGlzIHRoYXQ6DQogICAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
DQogICAgICAgICAgICAgICAgICAgICAgICAyTSBwYWdlICAgICAgICAgICAgICAgICAgICB8ICAg
ICAgICAgICAgICAgICAgICAxRyBwYWdlICAgICAgICAgICAgICAgICAgICB8DQogICAgLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLXwtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS18LS0tLS0tLS0tLS0tLS0t
LS0tLS0tLXwtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS18DQogICAgICAgICAgIGVuYWJsZSAgICAg
ICAgIHwgICAgICAgIGRpc2FibGUgICAgICAgICB8ICAgICAgZW5hYmxlICAgICAgICAgIHwgICAg
ICAgIGRpc2FibGUgICAgICAgICB8DQogICAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXwtLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS18LS0tLS0tLS0tLS0tLS0tLS0tLS0tLXwtLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS18DQogICAgdG90YWwgIHwgIHVzZWQgfCBmcmVlIHwgdG90YWwgIHwgIHVzZWQgfCBm
cmVlICB8dG90YWwgIHwgIHVzZWQgfCBmcmVlIHwgdG90YWwgIHwgIHVzZWQgfCBmcmVlICB8DQog
ICAgMzksNjk3IHwgMTAyNzkgfDI5LDQxNXwgMzk1ODAgIHwgMTAyNzkgfCAyOSwyOTfigKx8Mzks
NzM5IHwgMTAyNzkgfDI5LDQ1NXwgMzk1ODAgIHwgMTAyNzkgfCAyOSwyOTZ8DQogICAgLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQogICAgRm9yIDJNIGh1Z2VwYWdlLCB3
ZSBjYW4gc2F2ZSAxMThNIG1lbW9yeSB3aGljaCBpcyBjb3JyZXNwb2luZGluZyB0byB0aGUgZXhw
ZWN0ZWQgMTIwTSBtZW1vcnkuDQogICAgRm9yIDFHIGh1Z2VwYWdlLCB3ZSBjYW4gc2F2ZSAxNTlN
IG1lbW9yeSB3aGljaCBpcyBjb3JyZXNwb2luZGluZyB0byB0aGUgZXhwZWN0ZWQgMTYwTSBtZW1v
cnkuDQoNCiAgICBUaGVuIEkgYWxsb2MgMTBHIGh1Z2VwYWdlcyB1c2luZyAiZWNobyBYWCA+IC9z
eXMva2VybmVsL21tL2h1Z2VwYWdlcy9odWdlcGFnZXMtWFhrQi9ucl9odWdlcGFnZXMiLA0KICAg
IGFuZCBnZXQgdGhlIHJlc3VsdDoNCiAgICAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0NCiAgICAgICAgICAgICAgICAgICAgICAgIDJNIHBhZ2UgICAgICAgICAgICAgICAg
ICAgIHwgICAgICAgICAgICAgICAgICAgIDFHIHBhZ2UgICAgICAgICAgICAgICAgICAgIHwNCiAg
ICAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tfC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXwtLS0tLS0t
LS0tLS0tLS0tLS0tLS0tfC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXwNCiAgICAgICAgICAgZW5h
YmxlICAgICAgICAgfCAgICAgICAgZGlzYWJsZSAgICAgICAgIHwgICAgICBlbmFibGUgICAgICAg
ICAgfCAgICAgICAgZGlzYWJsZSAgICAgICAgIHwNCiAgICAtLS0tLS0tLS0tLS0tLS0tLS0tLS0t
fC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXwtLS0tLS0tLS0tLS0tLS0tLS0tLS0tfC0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLXwNCiAgICB0b3RhbCAgfCAgdXNlZCB8IGZyZWUgfCB0b3RhbCAgfCAg
dXNlZCB8IGZyZWUgIHx0b3RhbCAgfCAgdXNlZCB8IGZyZWUgfCB0b3RhbCAgfCAgdXNlZCB8IGZy
ZWUgIHwNCiAgICAzOSw2OTkgfCAxMDI3OSB8MjksNDE1fCAzOTU4MCAgfCAxMDI3OSB8IDI5LDI5
N+KArOKArHwzOSw3MzkgfCAxMDI3OSB8MjksNDU1fCAzOTU4MCAgfCAxMDI3OSB8IDI5LDI5NnwN
CiAgICAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCiAgICBGb3IgMk0g
aHVnZXBhZ2UsIHdlIGNhbiBzYXZlIDExOE0gbWVtb3J5IHdoaWNoIGlzIGNvcnJlc3BvaW5kaW5n
IHRvIHRoZSBleHBlY3RlZCAxMjBNIG1lbW9yeS4NCiAgICBGb3IgMUcgaHVnZXBhZ2UsIHdlIGNh
biBzYXZlIDE1OU0gbWVtb3J5IHdoaWNoIGlzIGNvcnJlc3BvaW5kaW5nIHRvIHRoZSBleHBlY3Rl
ZCAxNjBNIG1lbW9yeS4NCg0K
