Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 096EA4201EF
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 16:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbhJCOQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 10:16:37 -0400
Received: from smtp-fw-9103.amazon.com ([207.171.188.200]:7132 "EHLO
        smtp-fw-9103.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbhJCOQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 10:16:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1633270486; x=1664806486;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cpvWUbn5u4+9Slt4X2kusSQbNmn8bQiZPCQVAByX90U=;
  b=HKasIamcvl1VY1SXTB0vOF3kqyuIjADk6dAkPpyjPd5lNMCcF5lVDM1M
   eE49yQxD4NfaOatJFrG99ExM0gxqnZfwHxblT22R5J4uzDMZxegNesyV0
   Qu1aJB4Qqjhd4l5WeE/1w7GJ5q7JWBYFXibcuWke0IOkSGgp49sElO4BJ
   g=;
X-IronPort-AV: E=Sophos;i="5.85,343,1624320000"; 
   d="scan'208";a="962130714"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-05e8af15.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP; 03 Oct 2021 14:14:38 +0000
Received: from EX13D16EUB003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2b-05e8af15.us-west-2.amazon.com (Postfix) with ESMTPS id B322DA2820;
        Sun,  3 Oct 2021 14:14:36 +0000 (UTC)
Received: from [192.168.13.185] (10.43.162.248) by
 EX13D16EUB003.ant.amazon.com (10.43.166.99) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Sun, 3 Oct 2021 14:14:30 +0000
Message-ID: <d4558386-8925-085b-e2d0-7bc999c7fd6c@amazon.com>
Date:   Sun, 3 Oct 2021 17:14:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.2
Subject: Re: [PATCH v2 4/4] nitro_enclaves: add kunit tests for physical
 contiguous region merging
Content-Language: en-US
To:     "Longpeng(Mike)" <longpeng2@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <arei.gonglei@huawei.com>,
        <gregkh@linuxfoundation.org>, <kamal@canonical.com>,
        <pbonzini@redhat.com>, <sgarzare@redhat.com>,
        <stefanha@redhat.com>, <vkuznets@redhat.com>,
        <ne-devel-upstream@amazon.com>, <lexnv@amazon.com>,
        <alcioa@amazon.com>
References: <20210921151039.1502-1-longpeng2@huawei.com>
 <20210921151039.1502-5-longpeng2@huawei.com>
From:   "Paraschiv, Andra-Irina" <andraprs@amazon.com>
In-Reply-To: <20210921151039.1502-5-longpeng2@huawei.com>
X-Originating-IP: [10.43.162.248]
X-ClientProxiedBy: EX13D38UWB003.ant.amazon.com (10.43.161.178) To
 EX13D16EUB003.ant.amazon.com (10.43.166.99)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpPbiAyMS8wOS8yMDIxIDE4OjEwLCBMb25ncGVuZyhNaWtlKSB3cm90ZToKPiBBZGQga3VuaXQg
dGVzdHMgZm9yIHRoZSBwaHlzaWNhbCBjb250aWd1b3VzIG1lbW9yeSByZWdpb24gbWVyZ2luZwo+
IGZ1bmN0aW9uYWxpdHkuCgpuaXRyb19lbmNsYXZlczogQWRkIEtVbml0IHRlc3RzIGZvciBjb250
aWd1b3VzIHBoeXNpY2FsIG1lbW9yeSByZWdpb25zIAptZXJnaW5nCgpBZGQgS1VuaXQgdGVzdHMg
Zm9yIHRoZSBjb250aWd1b3VzIHBoeXNpY2FsIG1lbW9yeSByZWdpb25zIG1lcmdpbmcgCmZ1bmN0
aW9uYWxpdHkgZnJvbSB0aGUgTml0cm8gRW5jbGF2ZXMgbWlzYyBkZXZpY2UgbG9naWMuCgo+IAo+
IFNpZ25lZC1vZmYtYnk6IExvbmdwZW5nKE1pa2UpIDxsb25ncGVuZzJAaHVhd2VpLmNvbT4KPiAt
LS0KPiAgIGRyaXZlcnMvdmlydC9uaXRyb19lbmNsYXZlcy9uZV9taXNjX3Rlc3QuYyB8IDQ2ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDQ2IGluc2Vy
dGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0L25pdHJvX2VuY2xhdmVzL25l
X21pc2NfdGVzdC5jIGIvZHJpdmVycy92aXJ0L25pdHJvX2VuY2xhdmVzL25lX21pc2NfdGVzdC5j
Cj4gaW5kZXggMzQyNmMzNS4uODUzMmJlYyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZpcnQvbml0
cm9fZW5jbGF2ZXMvbmVfbWlzY190ZXN0LmMKPiArKysgYi9kcml2ZXJzL3ZpcnQvbml0cm9fZW5j
bGF2ZXMvbmVfbWlzY190ZXN0LmMKPiBAQCAtMiw3ICsyLDUzIEBACj4gICAKPiAgICNpbmNsdWRl
IDxrdW5pdC90ZXN0Lmg+Cj4gICAKPiArI2RlZmluZSBNQVhfUEhZU19SRUdJT05TCTE2Cj4gKwo+
ICtzdHJ1Y3QgcGh5c19yZWdpb25zX3Rlc3Qgewo+ICsJdTY0IHBhZGRyOwo+ICsJdTY0IHNpemU7
Cj4gKwlpbnQgZXhwZWN0X3JjOwo+ICsJdW5zaWduZWQgbG9uZyBleHBlY3RfbnVtOwo+ICsJdTY0
IGV4cGVjdF9sYXN0X3BhZGRyOwo+ICsJdTY0IGV4cGVjdF9sYXN0X3NpemU7CgpQbGVhc2UgYWxp
Z24gdGhlIGZpZWxkcyBpbiB0aGUgZGF0YSBzdHJ1Y3R1cmUgc28gdGhhdCdzIGVhc2llciB0byAK
dmlzdWFsaXplIHRoZW0uCgp1NjQgICAgICAgICAgICAgIHBhZGRyOwp1NjQgICAgICAgICAgICAg
IHNpemU7CmludCAgICAgICAgICAgICAgZXhwZWN0X3JjOwp1bnNpZ25lZCBsb25nICAgIGV4cGVj
dF9udW07Ci4uLi4uLi4uLi4uLgoKPiArfSBwaHlzX3JlZ2lvbnNfdGVzdGNhc2VzW10gPSB7Cgpw
aHlzX3JlZ2lvbnNfdGVzdF9jYXNlcwoKPiArCXsweDEwMDAsIDB4MjAwMDAwLCAtRUlOVkFMLCAw
LCB+MCwgfjB9LAo+ICsJezB4MjAwMDAwLCAweDEwMDAsIC1FSU5WQUwsIDAsIH4wLCB+MH0sCj4g
Kwl7MHgyMDAwMDAsIDB4MjAwMDAwLCAwLCAxLCAweDIwMDAwMCwgMHgyMDAwMDB9LAo+ICsJezB4
MCwgMHgyMDAwMDAsIDAsIDIsIDB4MCwgMHgyMDAwMDB9LAo+ICsJezB4NjAwMDAwLCAweDQwMDAw
MCwgMCwgMywgMHg2MDAwMDAsIDB4NDAwMDAwfSwKPiArCXsweGEwMDAwMCwgMHg0MDAwMDAsIDAs
IDMsIDB4NjAwMDAwLCAweDgwMDAwMH0sCj4gKwl7MHgxMDAwLCAweDIwMDAwMCwgLUVJTlZBTCwg
MywgMHg2MDAwMDAsIDB4ODAwMDAwfSwKClBsZWFzZSBhZGQgYSBjb21tZW50IGJlZm9yZSBlYWNo
IG9mIHRoZSBhYm92ZSB0ZXN0IGNhc2VzLCBpbmNsdWRpbmcgYSAKYnJpZWYgZGVzY3JpcHRpb24g
b2Ygd2hhdCBlYWNoIG9mIHRoZW0gaW50ZW5kcyB0byB0ZXN0LiBTbyB0aGF0IGl0J3MgCmVhc2ll
ciB0byByZWxhdGUgdG8gdGhlIG51bWJlcnMuCgo+ICt9Owo+ICsKPiArc3RhdGljIHZvaWQgbmVf
bWlzY190ZXN0X3NldF9waHlzX3JlZ2lvbihzdHJ1Y3Qga3VuaXQgKnRlc3QpCgpuZV9taXNjX2Rl
dl90ZXN0X21lcmdlX3BoeXNfY29udGlnX21lbW9yeV9yZWdpb25zCgo+ICt7Cj4gKwlzdHJ1Y3Qg
cGh5c19jb250aWdfbWVtX3JlZ2lvbiAqcmVnaW9uczsKPiArCXNpemVfdCBzejsKPiArCWludCBp
LCByYzsKClBsZWFzZSBpbml0aWFsaXplIHRoZSB2YXJpYWJsZXMuCgpUaGFua3MsCkFuZHJhCgo+
ICsKPiArCXN6ID0gc2l6ZW9mKCpyZWdpb25zKSArIE1BWF9QSFlTX1JFR0lPTlMgKiBzaXplb2Yo
c3RydWN0IHBoeXNfbWVtX3JlZ2lvbik7Cj4gKwlyZWdpb25zID0ga3VuaXRfa3phbGxvYyh0ZXN0
LCBzeiwgR0ZQX0tFUk5FTCk7Cj4gKwlLVU5JVF9BU1NFUlRfVFJVRSh0ZXN0LCByZWdpb25zICE9
IE5VTEwpOwo+ICsKPiArCWZvciAoaSA9IDA7IGkgPCBBUlJBWV9TSVpFKHBoeXNfcmVnaW9uc190
ZXN0Y2FzZXMpOyBpKyspIHsKPiArCQlyYyA9IG5lX2FkZF9waHlzX21lbW9yeV9yZWdpb24ocmVn
aW9ucywgcGh5c19yZWdpb25zX3Rlc3RjYXNlc1tpXS5wYWRkciwKPiArCQkJCQkgICAgICAgcGh5
c19yZWdpb25zX3Rlc3RjYXNlc1tpXS5zaXplKTsKPiArCQlLVU5JVF9FWFBFQ1RfRVEodGVzdCwg
cmMsIHBoeXNfcmVnaW9uc190ZXN0Y2FzZXNbaV0uZXhwZWN0X3JjKTsKPiArCQlLVU5JVF9FWFBF
Q1RfRVEodGVzdCwgcmVnaW9ucy0+bnVtLCBwaHlzX3JlZ2lvbnNfdGVzdGNhc2VzW2ldLmV4cGVj
dF9udW0pOwo+ICsKPiArCQlpZiAocGh5c19yZWdpb25zX3Rlc3RjYXNlc1tpXS5leHBlY3RfbGFz
dF9wYWRkciA9PSB+MHVsKQo+ICsJCQljb250aW51ZTsKPiArCj4gKwkJS1VOSVRfRVhQRUNUX0VR
KHRlc3QsIHJlZ2lvbnMtPnJlZ2lvbltyZWdpb25zLT5udW0gLSAxXS5wYWRkciwKPiArCQkJCXBo
eXNfcmVnaW9uc190ZXN0Y2FzZXNbaV0uZXhwZWN0X2xhc3RfcGFkZHIpOwo+ICsJCUtVTklUX0VY
UEVDVF9FUSh0ZXN0LCByZWdpb25zLT5yZWdpb25bcmVnaW9ucy0+bnVtIC0gMV0uc2l6ZSwKPiAr
CQkJCXBoeXNfcmVnaW9uc190ZXN0Y2FzZXNbaV0uZXhwZWN0X2xhc3Rfc2l6ZSk7Cj4gKwl9Cj4g
K30KPiArCj4gICBzdGF0aWMgc3RydWN0IGt1bml0X2Nhc2UgbmVfbWlzY190ZXN0X2Nhc2VzW10g
PSB7Cj4gKwlLVU5JVF9DQVNFKG5lX21pc2NfdGVzdF9zZXRfcGh5c19yZWdpb24pLAo+ICAgCXt9
Cj4gICB9Owo+ICAgCj4gCgoKCkFtYXpvbiBEZXZlbG9wbWVudCBDZW50ZXIgKFJvbWFuaWEpIFMu
Ui5MLiByZWdpc3RlcmVkIG9mZmljZTogMjdBIFNmLiBMYXphciBTdHJlZXQsIFVCQzUsIGZsb29y
IDIsIElhc2ksIElhc2kgQ291bnR5LCA3MDAwNDUsIFJvbWFuaWEuIFJlZ2lzdGVyZWQgaW4gUm9t
YW5pYS4gUmVnaXN0cmF0aW9uIG51bWJlciBKMjIvMjYyMS8yMDA1Lgo=

