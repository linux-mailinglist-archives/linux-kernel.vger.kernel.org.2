Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5963B5CC2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 12:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbhF1K5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 06:57:06 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:37345 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232700AbhF1K5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 06:57:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1624877679; x=1656413679;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=40yGFLlFdyP2oUyLOKMw3GyY1D5jUGecldbwh8C4AXo=;
  b=i4e+T2PgpeRNmhoxC1/eKxa/yI5pGslVNYz9glM1cxzvpLHa+0Jk6ylx
   6SO22jdm5ZPf/weiLHMbNhGm9+iRrLvonj44vFEXYdc7jXCXDKF2ISJw9
   v6w5O0Z1T6EGrpdG3Oij+HzDsw1dWOGkBwRnZ1QOvg9Umx8lVimLcDzij
   g=;
X-IronPort-AV: E=Sophos;i="5.83,305,1616457600"; 
   d="scan'208";a="118759721"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2c-579b7f5b.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP; 28 Jun 2021 10:54:30 +0000
Received: from EX13MTAUWC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2c-579b7f5b.us-west-2.amazon.com (Postfix) with ESMTPS id 45F81A1DC8;
        Mon, 28 Jun 2021 10:54:29 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1497.18; Mon, 28 Jun 2021 10:54:28 +0000
Received: from [192.168.24.203] (10.43.161.153) by
 EX13D20UWC001.ant.amazon.com (10.43.162.244) with Microsoft SMTP Server (TLS)
 id 15.0.1497.18; Mon, 28 Jun 2021 10:54:25 +0000
Message-ID: <3a43b2de-6a71-2373-8695-5e96657c8fc2@amazon.com>
Date:   Mon, 28 Jun 2021 12:54:23 +0200
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
        <iommu@lists.linux-foundation.org>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Rob Herring <robh+dt@kernel.org>, <r.czerwinski@pengutronix.de>
References: <20210627143405.77298-1-sven@svenpeter.dev>
 <20210627143405.77298-2-sven@svenpeter.dev>
From:   Alexander Graf <graf@amazon.com>
In-Reply-To: <20210627143405.77298-2-sven@svenpeter.dev>
X-Originating-IP: [10.43.161.153]
X-ClientProxiedBy: EX13D17UWB001.ant.amazon.com (10.43.161.252) To
 EX13D20UWC001.ant.amazon.com (10.43.162.244)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpPbiAyNy4wNi4yMSAxNjozNCwgU3ZlbiBQZXRlciB3cm90ZToKPiAKPiBBcHBsZSdzIERBUlQg
aW9tbXUgdXNlcyBhIHBhZ2V0YWJsZSBmb3JtYXQgdGhhdCBzaGFyZXMgc29tZQo+IHNpbWlsYXJp
dGllcyB3aXRoIHRoZSBvbmVzIGFscmVhZHkgaW1wbGVtZW50ZWQgYnkgaW8tcGd0YWJsZS5jLgo+
IEFkZCBhIG5ldyBmb3JtYXQgdmFyaWFudCB0byBzdXBwb3J0IHRoZSByZXF1aXJlZCBkaWZmZXJl
bmNlcwo+IHNvIHRoYXQgd2UgZG9uJ3QgaGF2ZSB0byBkdXBsaWNhdGUgdGhlIHBhZ2V0YWJsZSBo
YW5kbGluZyBjb2RlLgo+IAo+IFNpZ25lZC1vZmYtYnk6IFN2ZW4gUGV0ZXIgPHN2ZW5Ac3ZlbnBl
dGVyLmRldj4KPiAtLS0KPiAgIGRyaXZlcnMvaW9tbXUvaW8tcGd0YWJsZS1hcm0uYyB8IDYyICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPiAgIGRyaXZlcnMvaW9tbXUvaW8tcGd0
YWJsZS5jICAgICB8ICAxICsKPiAgIGluY2x1ZGUvbGludXgvaW8tcGd0YWJsZS5oICAgICB8ICA3
ICsrKysKPiAgIDMgZmlsZXMgY2hhbmdlZCwgNzAgaW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2lvbW11L2lvLXBndGFibGUtYXJtLmMgYi9kcml2ZXJzL2lvbW11L2lvLXBn
dGFibGUtYXJtLmMKPiBpbmRleCA4N2RlZjU4ZTc5YjUuLjFkZDVjNDViNGI1YiAxMDA2NDQKPiAt
LS0gYS9kcml2ZXJzL2lvbW11L2lvLXBndGFibGUtYXJtLmMKPiArKysgYi9kcml2ZXJzL2lvbW11
L2lvLXBndGFibGUtYXJtLmMKPiBAQCAtMTI3LDYgKzEyNyw5IEBACj4gICAjZGVmaW5lIEFSTV9N
QUxJX0xQQUVfTUVNQVRUUl9JTVBfREVGICAweDg4VUxMCj4gICAjZGVmaW5lIEFSTV9NQUxJX0xQ
QUVfTUVNQVRUUl9XUklURV9BTExPQyAweDhEVUxMCj4gCj4gKyNkZWZpbmUgQVBQTEVfREFSVF9Q
VEVfUFJPVF9OT19XUklURSAoMTw8NykKPiArI2RlZmluZSBBUFBMRV9EQVJUX1BURV9QUk9UX05P
X1JFQUQgKDE8PDgpCj4gKwo+ICAgLyogSU9QVEUgYWNjZXNzb3JzICovCj4gICAjZGVmaW5lIGlv
cHRlX2RlcmVmKHB0ZSxkKSBfX3ZhKGlvcHRlX3RvX3BhZGRyKHB0ZSwgZCkpCj4gCj4gQEAgLTM4
MSw2ICszODQsMTUgQEAgc3RhdGljIGFybV9scGFlX2lvcHRlIGFybV9scGFlX3Byb3RfdG9fcHRl
KHN0cnVjdCBhcm1fbHBhZV9pb19wZ3RhYmxlICpkYXRhLAo+ICAgewo+ICAgICAgICAgIGFybV9s
cGFlX2lvcHRlIHB0ZTsKPiAKPiArICAgICAgIGlmIChkYXRhLT5pb3AuZm10ID09IEFSTV9BUFBM
RV9EQVJUKSB7Cj4gKyAgICAgICAgICAgICAgIHB0ZSA9IDA7Cj4gKyAgICAgICAgICAgICAgIGlm
ICghKHByb3QgJiBJT01NVV9XUklURSkpCj4gKyAgICAgICAgICAgICAgICAgICAgICAgcHRlIHw9
IEFQUExFX0RBUlRfUFRFX1BST1RfTk9fV1JJVEU7Cj4gKyAgICAgICAgICAgICAgIGlmICghKHBy
b3QgJiBJT01NVV9SRUFEKSkKPiArICAgICAgICAgICAgICAgICAgICAgICBwdGUgfD0gQVBQTEVf
REFSVF9QVEVfUFJPVF9OT19SRUFEOwo+ICsgICAgICAgICAgICAgICByZXR1cm4gcHRlOwoKV2hh
dCBhYm91dCB0aGUgb3RoZXIgYml0cywgc3VjaCBhcyBzaGFyYWJpbGl0eSwgWE4sIGV0Yz8gRG8g
dGhleSBub3QgCmV4aXN0IG9uIERBUlQ/IE9yIGhhdmUgdGhleSBub3QgYmVlbiByZXZlcnNlIGVu
Z2luZWVyZWQgYW5kIDBzIGhhcHBlbiB0byAKImp1c3Qgd29yayI/Cgo+ICsgICAgICAgfQo+ICsK
PiAgICAgICAgICBpZiAoZGF0YS0+aW9wLmZtdCA9PSBBUk1fNjRfTFBBRV9TMSB8fAo+ICAgICAg
ICAgICAgICBkYXRhLT5pb3AuZm10ID09IEFSTV8zMl9MUEFFX1MxKSB7Cj4gICAgICAgICAgICAg
ICAgICBwdGUgPSBBUk1fTFBBRV9QVEVfbkc7Cj4gQEAgLTEwNDMsNiArMTA1NSw1MSBAQCBhcm1f
bWFsaV9scGFlX2FsbG9jX3BndGFibGUoc3RydWN0IGlvX3BndGFibGVfY2ZnICpjZmcsIHZvaWQg
KmNvb2tpZSkKPiAgICAgICAgICByZXR1cm4gTlVMTDsKPiAgIH0KPiAKPiArc3RhdGljIHN0cnVj
dCBpb19wZ3RhYmxlICoKPiArYXBwbGVfZGFydF9hbGxvY19wZ3RhYmxlKHN0cnVjdCBpb19wZ3Rh
YmxlX2NmZyAqY2ZnLCB2b2lkICpjb29raWUpCj4gK3sKPiArICAgICAgIHN0cnVjdCBhcm1fbHBh
ZV9pb19wZ3RhYmxlICpkYXRhOwo+ICsgICAgICAgaW50IGk7Cj4gKwo+ICsgICAgICAgaWYgKGNm
Zy0+b2FzID4gMzYpCj4gKyAgICAgICAgICAgICAgIHJldHVybiBOVUxMOwo+ICsKPiArICAgICAg
IGRhdGEgPSBhcm1fbHBhZV9hbGxvY19wZ3RhYmxlKGNmZyk7Cj4gKyAgICAgICBpZiAoIWRhdGEp
Cj4gKyAgICAgICAgICAgICAgIHJldHVybiBOVUxMOwo+ICsKPiArICAgICAgIC8qCj4gKyAgICAg
ICAgKiBBcHBsZSdzIERBUlQgYWx3YXlzIHJlcXVpcmVzIHRocmVlIGxldmVscyB3aXRoIHRoZSBm
aXJzdCBsZXZlbCBiZWluZwo+ICsgICAgICAgICogc3RvcmVkIGluIGZvdXIgTU1JTyByZWdpc3Rl
cnMuIFdlIGFsd2F5cyBjb25jYXRlbmF0ZSB0aGUgZmlyc3QgYW5kCj4gKyAgICAgICAgKiBzZWNv
bmQgbGV2ZWwgc28gdGhhdCB3ZSBvbmx5IGhhdmUgdG8gc2V0dXAgdGhlIE1NSU8gcmVnaXN0ZXJz
IG9uY2UuCj4gKyAgICAgICAgKiBUaGlzIHJlc3VsdHMgaW4gYW4gZWZmZWN0aXZlIHR3byBsZXZl
bCBwYWdldGFibGUuCj4gKyAgICAgICAgKi8KPiArICAgICAgIGlmIChkYXRhLT5zdGFydF9sZXZl
bCA8IDEpCj4gKyAgICAgICAgICAgICAgIHJldHVybiBOVUxMOwo+ICsgICAgICAgaWYgKGRhdGEt
PnN0YXJ0X2xldmVsID09IDEgJiYgZGF0YS0+cGdkX2JpdHMgPiAyKQo+ICsgICAgICAgICAgICAg
ICByZXR1cm4gTlVMTDsKPiArICAgICAgIGlmIChkYXRhLT5zdGFydF9sZXZlbCA+IDEpCj4gKyAg
ICAgICAgICAgICAgIGRhdGEtPnBnZF9iaXRzID0gMDsKPiArICAgICAgIGRhdGEtPnN0YXJ0X2xl
dmVsID0gMjsKPiArICAgICAgIGNmZy0+YXBwbGVfZGFydF9jZmcubl90dGJycyA9IDEgPDwgZGF0
YS0+cGdkX2JpdHM7CgpNYXliZSBhZGQgYSBCVUdfT04gaWYgbl90dGJycyA+IEFSUkFZX1NJWkUo
dHRicik/IE9yIGFsdGVybmF0aXZlbHksIGRvIGEgCm5vcm1hbCBydW50aW1lIGNoZWNrIGFuZCBi
YWlsIG91dCB0aGVuLgoKCkFsZXgKCgoKQW1hem9uIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55
IEdtYkgKS3JhdXNlbnN0ci4gMzgKMTAxMTcgQmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzogQ2hy
aXN0aWFuIFNjaGxhZWdlciwgSm9uYXRoYW4gV2Vpc3MKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmlj
aHQgQ2hhcmxvdHRlbmJ1cmcgdW50ZXIgSFJCIDE0OTE3MyBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6
IERFIDI4OSAyMzcgODc5CgoK

