Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B89263B71B4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 14:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbhF2MGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 08:06:51 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:62494 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbhF2MGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 08:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1624968259; x=1656504259;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4VTqRt/doBhcHug+DYEpXm+V0vDuSlC/ctdi9x/3mQY=;
  b=SaDfVkv2Tt48PjDiFVFJRvuLGygL5RCpOtrvTZhUgVP9y1sSHvfWtwch
   hjoUtgJ6tjEXCtdHtly5S9W7CDBw//4oHn1wzYp0/kWhd178vAEmeQ/Pr
   ovExh0xsHz8/svWH4xapjge35TkSr59TE5UCEzBLMUjg76/WnxuG2UmXK
   8=;
X-IronPort-AV: E=Sophos;i="5.83,308,1616457600"; 
   d="scan'208";a="119057987"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2b-baacba05.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP; 29 Jun 2021 12:04:10 +0000
Received: from EX13MTAUWC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2b-baacba05.us-west-2.amazon.com (Postfix) with ESMTPS id F07C8A1FD3;
        Tue, 29 Jun 2021 12:04:08 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC002.ant.amazon.com (10.43.162.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.18; Tue, 29 Jun 2021 12:04:08 +0000
Received: from [192.168.9.117] (10.43.161.153) by EX13D20UWC001.ant.amazon.com
 (10.43.162.244) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 29 Jun
 2021 12:04:05 +0000
Message-ID: <50d48c57-b6f4-aad9-2471-ea3d3066563d@amazon.com>
Date:   Tue, 29 Jun 2021 14:04:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:90.0)
 Gecko/20100101 Thunderbird/90.0
Subject: Re: [PATCH v4 1/3] iommu: io-pgtable: add DART pagetable format
Content-Language: en-US
To:     Sven Peter <sven@svenpeter.dev>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
CC:     Arnd Bergmann <arnd@kernel.org>, <devicetree@vger.kernel.org>,
        "Hector Martin" <marcan@marcan.st>, <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        "Stan Skowronek" <stan@corellium.com>,
        <linux-arm-kernel@lists.infradead.org>,
        "Mark Kettenis" <mark.kettenis@xs4all.nl>,
        Petr Mladek via iommu <iommu@lists.linux-foundation.org>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Rouven Czerwinski" <r.czerwinski@pengutronix.de>
References: <20210627143405.77298-1-sven@svenpeter.dev>
 <20210627143405.77298-2-sven@svenpeter.dev>
 <3a43b2de-6a71-2373-8695-5e96657c8fc2@amazon.com>
 <fedb8d5a-a0f1-4216-bb46-1af31b716309@www.fastmail.com>
From:   Alexander Graf <graf@amazon.com>
In-Reply-To: <fedb8d5a-a0f1-4216-bb46-1af31b716309@www.fastmail.com>
X-Originating-IP: [10.43.161.153]
X-ClientProxiedBy: EX13D21UWA004.ant.amazon.com (10.43.160.252) To
 EX13D20UWC001.ant.amazon.com (10.43.162.244)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpPbiAyOS4wNi4yMSAwOTozNywgU3ZlbiBQZXRlciB3cm90ZToKPiAKPiBPbiBNb24sIEp1biAy
OCwgMjAyMSwgYXQgMTI6NTQsIEFsZXhhbmRlciBHcmFmIHdyb3RlOgo+Pgo+Pgo+PiBPbiAyNy4w
Ni4yMSAxNjozNCwgU3ZlbiBQZXRlciB3cm90ZToKPj4+Cj4+PiBBcHBsZSdzIERBUlQgaW9tbXUg
dXNlcyBhIHBhZ2V0YWJsZSBmb3JtYXQgdGhhdCBzaGFyZXMgc29tZQo+Pj4gc2ltaWxhcml0aWVz
IHdpdGggdGhlIG9uZXMgYWxyZWFkeSBpbXBsZW1lbnRlZCBieSBpby1wZ3RhYmxlLmMuCj4+PiBB
ZGQgYSBuZXcgZm9ybWF0IHZhcmlhbnQgdG8gc3VwcG9ydCB0aGUgcmVxdWlyZWQgZGlmZmVyZW5j
ZXMKPj4+IHNvIHRoYXQgd2UgZG9uJ3QgaGF2ZSB0byBkdXBsaWNhdGUgdGhlIHBhZ2V0YWJsZSBo
YW5kbGluZyBjb2RlLgo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IFN2ZW4gUGV0ZXIgPHN2ZW5Ac3Zl
bnBldGVyLmRldj4KPj4+IC0tLQo+Pj4gICAgZHJpdmVycy9pb21tdS9pby1wZ3RhYmxlLWFybS5j
IHwgNjIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+Pj4gICAgZHJpdmVycy9p
b21tdS9pby1wZ3RhYmxlLmMgICAgIHwgIDEgKwo+Pj4gICAgaW5jbHVkZS9saW51eC9pby1wZ3Rh
YmxlLmggICAgIHwgIDcgKysrKwo+Pj4gICAgMyBmaWxlcyBjaGFuZ2VkLCA3MCBpbnNlcnRpb25z
KCspCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW8tcGd0YWJsZS1hcm0uYyBi
L2RyaXZlcnMvaW9tbXUvaW8tcGd0YWJsZS1hcm0uYwo+Pj4gaW5kZXggODdkZWY1OGU3OWI1Li4x
ZGQ1YzQ1YjRiNWIgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2lvbW11L2lvLXBndGFibGUtYXJt
LmMKPj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvaW8tcGd0YWJsZS1hcm0uYwo+Pj4gQEAgLTEyNyw2
ICsxMjcsOSBAQAo+Pj4gICAgI2RlZmluZSBBUk1fTUFMSV9MUEFFX01FTUFUVFJfSU1QX0RFRiAg
MHg4OFVMTAo+Pj4gICAgI2RlZmluZSBBUk1fTUFMSV9MUEFFX01FTUFUVFJfV1JJVEVfQUxMT0Mg
MHg4RFVMTAo+Pj4KPj4+ICsjZGVmaW5lIEFQUExFX0RBUlRfUFRFX1BST1RfTk9fV1JJVEUgKDE8
PDcpCj4+PiArI2RlZmluZSBBUFBMRV9EQVJUX1BURV9QUk9UX05PX1JFQUQgKDE8PDgpCj4+PiAr
Cj4+PiAgICAvKiBJT1BURSBhY2Nlc3NvcnMgKi8KPj4+ICAgICNkZWZpbmUgaW9wdGVfZGVyZWYo
cHRlLGQpIF9fdmEoaW9wdGVfdG9fcGFkZHIocHRlLCBkKSkKPj4+Cj4+PiBAQCAtMzgxLDYgKzM4
NCwxNSBAQCBzdGF0aWMgYXJtX2xwYWVfaW9wdGUgYXJtX2xwYWVfcHJvdF90b19wdGUoc3RydWN0
IGFybV9scGFlX2lvX3BndGFibGUgKmRhdGEsCj4+PiAgICB7Cj4+PiAgICAgICAgICAgYXJtX2xw
YWVfaW9wdGUgcHRlOwo+Pj4KPj4+ICsgICAgICAgaWYgKGRhdGEtPmlvcC5mbXQgPT0gQVJNX0FQ
UExFX0RBUlQpIHsKPj4+ICsgICAgICAgICAgICAgICBwdGUgPSAwOwo+Pj4gKyAgICAgICAgICAg
ICAgIGlmICghKHByb3QgJiBJT01NVV9XUklURSkpCj4+PiArICAgICAgICAgICAgICAgICAgICAg
ICBwdGUgfD0gQVBQTEVfREFSVF9QVEVfUFJPVF9OT19XUklURTsKPj4+ICsgICAgICAgICAgICAg
ICBpZiAoIShwcm90ICYgSU9NTVVfUkVBRCkpCj4+PiArICAgICAgICAgICAgICAgICAgICAgICBw
dGUgfD0gQVBQTEVfREFSVF9QVEVfUFJPVF9OT19SRUFEOwo+Pj4gKyAgICAgICAgICAgICAgIHJl
dHVybiBwdGU7Cj4+Cj4+IFdoYXQgYWJvdXQgdGhlIG90aGVyIGJpdHMsIHN1Y2ggYXMgc2hhcmFi
aWxpdHksIFhOLCBldGM/IERvIHRoZXkgbm90Cj4+IGV4aXN0IG9uIERBUlQ/IE9yIGhhdmUgdGhl
eSBub3QgYmVlbiByZXZlcnNlIGVuZ2luZWVyZWQgYW5kIDBzIGhhcHBlbiB0bwo+PiAianVzdCB3
b3JrIj8KPiAKPiBJJ20gZmFpcmx5IGNlcnRhaW4gdGhleSBkb24ndCBleGlzdCAob3IgYXJlIGF0
IGxlYXN0IG5vdCB1c2VkIGJ5IFhOVSkuCj4gCj4gVGhlIGNvLXByb2Nlc3NvcnMgdGhhdCBjYW4g
cnVuIGNvZGUgYWxzbyBlaXRoZXIgdXNlIGFuIGVudGlyZSBzZXBhcmF0ZSBpb21tdQo+IChlLmcu
IHRoZSBHUFUpIG9yIG9ubHkgdXNlIERBUlQgYXMgYSAic2Vjb25kIHN0YWdlIiBhbmQgaGF2ZSB0
aGVpciBvd24KPiBNTVUgd2hpY2ggZS5nLiBoYW5kbGVzIFhOIChlLmcuIHRoZSBTRVAgb3IgQU9Q
KS4KCk9rIDopLgoKPiAKPj4KPj4+ICsgICAgICAgfQo+Pj4gKwo+Pj4gICAgICAgICAgIGlmIChk
YXRhLT5pb3AuZm10ID09IEFSTV82NF9MUEFFX1MxIHx8Cj4+PiAgICAgICAgICAgICAgIGRhdGEt
PmlvcC5mbXQgPT0gQVJNXzMyX0xQQUVfUzEpIHsKPj4+ICAgICAgICAgICAgICAgICAgIHB0ZSA9
IEFSTV9MUEFFX1BURV9uRzsKPj4+IEBAIC0xMDQzLDYgKzEwNTUsNTEgQEAgYXJtX21hbGlfbHBh
ZV9hbGxvY19wZ3RhYmxlKHN0cnVjdCBpb19wZ3RhYmxlX2NmZyAqY2ZnLCB2b2lkICpjb29raWUp
Cj4+PiAgICAgICAgICAgcmV0dXJuIE5VTEw7Cj4+PiAgICB9Cj4+Pgo+Pj4gK3N0YXRpYyBzdHJ1
Y3QgaW9fcGd0YWJsZSAqCj4+PiArYXBwbGVfZGFydF9hbGxvY19wZ3RhYmxlKHN0cnVjdCBpb19w
Z3RhYmxlX2NmZyAqY2ZnLCB2b2lkICpjb29raWUpCj4+PiArewo+Pj4gKyAgICAgICBzdHJ1Y3Qg
YXJtX2xwYWVfaW9fcGd0YWJsZSAqZGF0YTsKPj4+ICsgICAgICAgaW50IGk7Cj4+PiArCj4+PiAr
ICAgICAgIGlmIChjZmctPm9hcyA+IDM2KQo+Pj4gKyAgICAgICAgICAgICAgIHJldHVybiBOVUxM
Owo+Pj4gKwo+Pj4gKyAgICAgICBkYXRhID0gYXJtX2xwYWVfYWxsb2NfcGd0YWJsZShjZmcpOwo+
Pj4gKyAgICAgICBpZiAoIWRhdGEpCj4+PiArICAgICAgICAgICAgICAgcmV0dXJuIE5VTEw7Cj4+
PiArCj4+PiArICAgICAgIC8qCj4+PiArICAgICAgICAqIEFwcGxlJ3MgREFSVCBhbHdheXMgcmVx
dWlyZXMgdGhyZWUgbGV2ZWxzIHdpdGggdGhlIGZpcnN0IGxldmVsIGJlaW5nCj4+PiArICAgICAg
ICAqIHN0b3JlZCBpbiBmb3VyIE1NSU8gcmVnaXN0ZXJzLiBXZSBhbHdheXMgY29uY2F0ZW5hdGUg
dGhlIGZpcnN0IGFuZAo+Pj4gKyAgICAgICAgKiBzZWNvbmQgbGV2ZWwgc28gdGhhdCB3ZSBvbmx5
IGhhdmUgdG8gc2V0dXAgdGhlIE1NSU8gcmVnaXN0ZXJzIG9uY2UuCj4+PiArICAgICAgICAqIFRo
aXMgcmVzdWx0cyBpbiBhbiBlZmZlY3RpdmUgdHdvIGxldmVsIHBhZ2V0YWJsZS4KPj4+ICsgICAg
ICAgICovCj4+PiArICAgICAgIGlmIChkYXRhLT5zdGFydF9sZXZlbCA8IDEpCj4+PiArICAgICAg
ICAgICAgICAgcmV0dXJuIE5VTEw7Cj4+PiArICAgICAgIGlmIChkYXRhLT5zdGFydF9sZXZlbCA9
PSAxICYmIGRhdGEtPnBnZF9iaXRzID4gMikKPj4+ICsgICAgICAgICAgICAgICByZXR1cm4gTlVM
TDsKPj4+ICsgICAgICAgaWYgKGRhdGEtPnN0YXJ0X2xldmVsID4gMSkKPj4+ICsgICAgICAgICAg
ICAgICBkYXRhLT5wZ2RfYml0cyA9IDA7Cj4+PiArICAgICAgIGRhdGEtPnN0YXJ0X2xldmVsID0g
MjsKPj4+ICsgICAgICAgY2ZnLT5hcHBsZV9kYXJ0X2NmZy5uX3R0YnJzID0gMSA8PCBkYXRhLT5w
Z2RfYml0czsKPj4KPj4gTWF5YmUgYWRkIGEgQlVHX09OIGlmIG5fdHRicnMgPiBBUlJBWV9TSVpF
KHR0YnIpPyBPciBhbHRlcm5hdGl2ZWx5LCBkbyBhCj4+IG5vcm1hbCBydW50aW1lIGNoZWNrIGFu
ZCBiYWlsIG91dCB0aGVuLgo+IAo+IG5fdHRicnMgY2FuJ3QgYWN0dWFsbHkgYmUgbGFyZ2VyIHRo
YW4gNCBhdCB0aGlzIHBvaW50IGFscmVhZHkgZHVlIHRvIHRoZQo+IHByZXZpb3VzIGNoZWNrcy4K
PiBJIGNhbiBhZGQgYSBCVUdfT04gdGhvdWdoIGp1c3QgdG8gbWFrZSBpdCBleHBsaWNpdCBhbmQg
YmUgc2FmZSBpbiBjYXNlIHRob3NlCj4gY2hlY2tzIG9yIHRoZSBhcnJheSBzaXplIGV2ZXIgY2hh
bmdlLgoKQWgsIG5vdyBJIHNlZSBpdCB0b28uIE5vIHdvcnJpZXMgdGhlbiAtIEkgYWdyZWUgdGhh
dCB5b3UgaGF2ZSBhbGwgY2FzZXMgCmNvdmVyZWQuCgpSZXZpZXdlZC1ieTogQWxleGFuZGVyIEdy
YWYgPGdyYWZAYW1hem9uLmNvbT4KCgpBbGV4CgoKCkFtYXpvbiBEZXZlbG9wbWVudCBDZW50ZXIg
R2VybWFueSBHbWJICktyYXVzZW5zdHIuIDM4CjEwMTE3IEJlcmxpbgpHZXNjaGFlZnRzZnVlaHJ1
bmc6IENocmlzdGlhbiBTY2hsYWVnZXIsIEpvbmF0aGFuIFdlaXNzCkVpbmdldHJhZ2VuIGFtIEFt
dHNnZXJpY2h0IENoYXJsb3R0ZW5idXJnIHVudGVyIEhSQiAxNDkxNzMgQgpTaXR6OiBCZXJsaW4K
VXN0LUlEOiBERSAyODkgMjM3IDg3OQoKCg==

