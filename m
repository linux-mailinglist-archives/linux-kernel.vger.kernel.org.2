Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E938D447304
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 14:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbhKGNPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 08:15:51 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:13449 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbhKGNPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 08:15:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1636290789; x=1667826789;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SpqU/F34x2bkmO8BrNJ8ykElLgpC+0fGtSc6RSoiaG0=;
  b=sZCcLmGqwnTJeVcCRwl7kIaxIdLSdeLJKUogJs1bZfN4fMwoMYYgGtdf
   Q5fDJyiAwbHkax6msxwAz+glWjOP0NEo4MqnnZgB+WcLqh8iS9VFfVE0X
   V1v+1YHtqRGv5N1MXasP60gxIlScOvKbnEuZoSg4ptx8V5fvYb2H/lmYQ
   U=;
X-IronPort-AV: E=Sophos;i="5.87,216,1631577600"; 
   d="scan'208";a="157790664"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-39fdda15.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP; 07 Nov 2021 13:12:54 +0000
Received: from EX13D16EUB003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2a-39fdda15.us-west-2.amazon.com (Postfix) with ESMTPS id 5E1E3417AF;
        Sun,  7 Nov 2021 13:12:52 +0000 (UTC)
Received: from [192.168.0.248] (10.43.162.57) by EX13D16EUB003.ant.amazon.com
 (10.43.166.99) with Microsoft SMTP Server (TLS) id 15.0.1497.24; Sun, 7 Nov
 2021 13:12:45 +0000
Message-ID: <c730e964-4f97-3f78-22eb-b63a11f6e805@amazon.com>
Date:   Sun, 7 Nov 2021 15:12:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH v4 3/4] nitro_enclaves: Add KUnit tests setup for the misc
 device functionality
Content-Language: en-US
To:     "Longpeng(Mike)" <longpeng2@huawei.com>
CC:     <arei.gonglei@huawei.com>, <gregkh@linuxfoundation.org>,
        <kamal@canonical.com>, <pbonzini@redhat.com>,
        <sgarzare@redhat.com>, <stefanha@redhat.com>,
        <vkuznets@redhat.com>, <linux-kernel@vger.kernel.org>,
        <ne-devel-upstream@amazon.com>, <lexnv@amazon.com>,
        <alcioa@amazon.com>
References: <20211103140035.2001-1-longpeng2@huawei.com>
 <20211103140035.2001-4-longpeng2@huawei.com>
From:   "Paraschiv, Andra-Irina" <andraprs@amazon.com>
In-Reply-To: <20211103140035.2001-4-longpeng2@huawei.com>
X-Originating-IP: [10.43.162.57]
X-ClientProxiedBy: EX13D47UWA002.ant.amazon.com (10.43.163.30) To
 EX13D16EUB003.ant.amazon.com (10.43.166.99)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpPbiAwMy8xMS8yMDIxIDE2OjAwLCBMb25ncGVuZyhNaWtlKSB3cm90ZToKPiAKPiBGcm9tOiBM
b25ncGVuZyA8bG9uZ3BlbmcyQGh1YXdlaS5jb20+Cj4gCj4gQWRkIHRoZSBpbml0aWFsIHNldHVw
IGZvciB0aGUgS1VuaXQgdGVzdHMgdGhhdCB3aWxsIHRhcmdldCB0aGUgTml0cm8KPiBFbmNsYXZl
cyBtaXNjIGRldmljZSBmdW5jdGlvbmFsaXR5Lgo+IAo+IFNpZ25lZC1vZmYtYnk6IExvbmdwZW5n
IDxsb25ncGVuZzJAaHVhd2VpLmNvbT4KPiAtLS0KPiBDaGFuZ2VzIHYzIC0+IHY0Ogo+ICAgIC0g
Tml0cm8gZW5jbGF2ZXMgLT4gTml0cm8gRW5jbGF2ZXMgICBbQW5kcmFdCj4gICAgLSBjaGVjayB0
aGUgcmV0dXJuIGNvZGUgb2YgIm5lX21pc2NfZGV2X3Rlc3RfaW5pdCgpIiAgW0FuZHJhXQo+ICAg
IC0gR1BMLTIuMC1vci1sYXRlciAtPiBHUEwtMi4wICBbQW5kcmFdCj4gCj4gQ2hhbmdlcyB2MiAt
PiB2MzoKPiAgICAtIHVwZGF0ZSB0aGUgY29tbWl0IHRpdGxlIGFuZCBjb21taXQgbWVzc2FnZS4g
IFtBbmRyYV0KPiAgICAtIHVzZSAibWlzY19kZXYiLyJtaXNjIGRldmljZSIvIk1JU0NfREVWIiB0
byBiZSBtb3JlIHNwZWNpZmljLiAgW0FuZHJhXQo+IC0tLQo+ICAgZHJpdmVycy92aXJ0L25pdHJv
X2VuY2xhdmVzL0tjb25maWcgICAgICAgICAgICB8ICA5ICsrKysrKysrCj4gICBkcml2ZXJzL3Zp
cnQvbml0cm9fZW5jbGF2ZXMvbmVfbWlzY19kZXYuYyAgICAgIHwgMzEgKysrKysrKysrKysrKysr
KysrKysrKysrKysKPiAgIGRyaXZlcnMvdmlydC9uaXRyb19lbmNsYXZlcy9uZV9taXNjX2Rldl90
ZXN0LmMgfCAxNyArKysrKysrKysrKysrKwo+ICAgMyBmaWxlcyBjaGFuZ2VkLCA1NyBpbnNlcnRp
b25zKCspCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy92aXJ0L25pdHJvX2VuY2xhdmVz
L25lX21pc2NfZGV2X3Rlc3QuYwoKUmV2aWV3ZWQtYnk6IEFuZHJhIFBhcmFzY2hpdiA8YW5kcmFw
cnNAYW1hem9uLmNvbT4KClRoYW5rcywKQW5kcmEKCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dmlydC9uaXRyb19lbmNsYXZlcy9LY29uZmlnIGIvZHJpdmVycy92aXJ0L25pdHJvX2VuY2xhdmVz
L0tjb25maWcKPiBpbmRleCA4YzkzODdhLi5hN2U1MDIwIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMv
dmlydC9uaXRyb19lbmNsYXZlcy9LY29uZmlnCj4gKysrIGIvZHJpdmVycy92aXJ0L25pdHJvX2Vu
Y2xhdmVzL0tjb25maWcKPiBAQCAtMTgsMyArMTgsMTIgQEAgY29uZmlnIE5JVFJPX0VOQ0xBVkVT
Cj4gCj4gICAgICAgICAgICBUbyBjb21waWxlIHRoaXMgZHJpdmVyIGFzIGEgbW9kdWxlLCBjaG9v
c2UgTSBoZXJlLgo+ICAgICAgICAgICAgVGhlIG1vZHVsZSB3aWxsIGJlIGNhbGxlZCBuaXRyb19l
bmNsYXZlcy4KPiArCj4gK2NvbmZpZyBOSVRST19FTkNMQVZFU19NSVNDX0RFVl9URVNUCj4gKyAg
ICAgICBib29sICJUZXN0cyBmb3IgdGhlIG1pc2MgZGV2aWNlIGZ1bmN0aW9uYWxpdHkgb2YgdGhl
IE5pdHJvIEVuY2xhdmVzIgo+ICsgICAgICAgZGVwZW5kcyBvbiBOSVRST19FTkNMQVZFUyAmJiBL
VU5JVD15Cj4gKyAgICAgICBoZWxwCj4gKyAgICAgICAgIEVuYWJsZSBLVW5pdCB0ZXN0cyBmb3Ig
dGhlIG1pc2MgZGV2aWNlIGZ1bmN0aW9uYWxpdHkgb2YgdGhlIE5pdHJvCj4gKyAgICAgICAgIEVu
Y2xhdmVzLiBTZWxlY3QgdGhpcyBvcHRpb24gb25seSBpZiB5b3Ugd2lsbCBib290IHRoZSBrZXJu
ZWwgZm9yCj4gKyAgICAgICAgIHRoZSBwdXJwb3NlIG9mIHJ1bm5pbmcgdW5pdCB0ZXN0cyAoZS5n
LiB1bmRlciBVTUwgb3IgcWVtdSkuIElmCj4gKyAgICAgICAgIHVuc3VyZSwgc2F5IE4uCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdmlydC9uaXRyb19lbmNsYXZlcy9uZV9taXNjX2Rldi5jIGIvZHJp
dmVycy92aXJ0L25pdHJvX2VuY2xhdmVzL25lX21pc2NfZGV2LmMKPiBpbmRleCAzNzQxYWU3Li5l
YzQ2YzEyIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmlydC9uaXRyb19lbmNsYXZlcy9uZV9taXNj
X2Rldi5jCj4gKysrIGIvZHJpdmVycy92aXJ0L25pdHJvX2VuY2xhdmVzL25lX21pc2NfZGV2LmMK
PiBAQCAtMTc1NCw4ICsxNzU0LDM3IEBAIHN0YXRpYyBsb25nIG5lX2lvY3RsKHN0cnVjdCBmaWxl
ICpmaWxlLCB1bnNpZ25lZCBpbnQgY21kLCB1bnNpZ25lZCBsb25nIGFyZykKPiAgICAgICAgICBy
ZXR1cm4gMDsKPiAgIH0KPiAKPiArI2lmIGRlZmluZWQoQ09ORklHX05JVFJPX0VOQ0xBVkVTX01J
U0NfREVWX1RFU1QpCj4gKyNpbmNsdWRlICJuZV9taXNjX2Rldl90ZXN0LmMiCj4gKwo+ICtzdGF0
aWMgaW5saW5lIGludCBuZV9taXNjX2Rldl90ZXN0X2luaXQodm9pZCkKPiArewo+ICsgICAgICAg
cmV0dXJuIF9fa3VuaXRfdGVzdF9zdWl0ZXNfaW5pdChuZV9taXNjX2Rldl90ZXN0X3N1aXRlcyk7
Cj4gK30KPiArCj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBuZV9taXNjX2Rldl90ZXN0X2V4aXQodm9p
ZCkKPiArewo+ICsgICAgICAgX19rdW5pdF90ZXN0X3N1aXRlc19leGl0KG5lX21pc2NfZGV2X3Rl
c3Rfc3VpdGVzKTsKPiArfQo+ICsjZWxzZQo+ICtzdGF0aWMgaW5saW5lIGludCBuZV9taXNjX2Rl
dl90ZXN0X2luaXQodm9pZCkKPiArewo+ICsgICAgICAgcmV0dXJuIDA7Cj4gK30KPiArCj4gK3N0
YXRpYyBpbmxpbmUgdm9pZCBuZV9taXNjX2Rldl90ZXN0X2V4aXQodm9pZCkKPiArewo+ICt9Cj4g
KyNlbmRpZgo+ICsKPiAgIHN0YXRpYyBpbnQgX19pbml0IG5lX2luaXQodm9pZCkKPiAgIHsKPiAr
ICAgICAgIGludCByYyA9IDA7Cj4gKwo+ICsgICAgICAgcmMgPSBuZV9taXNjX2Rldl90ZXN0X2lu
aXQoKTsKPiArICAgICAgIGlmIChyYyA8IDApCj4gKyAgICAgICAgICAgICAgIHJldHVybiByYzsK
PiArCj4gICAgICAgICAgbXV0ZXhfaW5pdCgmbmVfY3B1X3Bvb2wubXV0ZXgpOwo+IAo+ICAgICAg
ICAgIHJldHVybiBwY2lfcmVnaXN0ZXJfZHJpdmVyKCZuZV9wY2lfZHJpdmVyKTsKPiBAQCAtMTc2
Niw2ICsxNzk1LDggQEAgc3RhdGljIHZvaWQgX19leGl0IG5lX2V4aXQodm9pZCkKPiAgICAgICAg
ICBwY2lfdW5yZWdpc3Rlcl9kcml2ZXIoJm5lX3BjaV9kcml2ZXIpOwo+IAo+ICAgICAgICAgIG5l
X3RlYXJkb3duX2NwdV9wb29sKCk7Cj4gKwo+ICsgICAgICAgbmVfbWlzY19kZXZfdGVzdF9leGl0
KCk7Cj4gICB9Cj4gCj4gICBtb2R1bGVfaW5pdChuZV9pbml0KTsKPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy92aXJ0L25pdHJvX2VuY2xhdmVzL25lX21pc2NfZGV2X3Rlc3QuYyBiL2RyaXZlcnMvdmly
dC9uaXRyb19lbmNsYXZlcy9uZV9taXNjX2Rldl90ZXN0LmMKPiBuZXcgZmlsZSBtb2RlIDEwMDY0
NAo+IGluZGV4IDAwMDAwMDAuLjY4NjJlOTkKPiAtLS0gL2Rldi9udWxsCj4gKysrIGIvZHJpdmVy
cy92aXJ0L25pdHJvX2VuY2xhdmVzL25lX21pc2NfZGV2X3Rlc3QuYwo+IEBAIC0wLDAgKzEsMTcg
QEAKPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAKPiArCj4gKyNpbmNsdWRl
IDxrdW5pdC90ZXN0Lmg+Cj4gKwo+ICtzdGF0aWMgc3RydWN0IGt1bml0X2Nhc2UgbmVfbWlzY19k
ZXZfdGVzdF9jYXNlc1tdID0gewo+ICsgICAgICAge30KPiArfTsKPiArCj4gK3N0YXRpYyBzdHJ1
Y3Qga3VuaXRfc3VpdGUgbmVfbWlzY19kZXZfdGVzdF9zdWl0ZSA9IHsKPiArICAgICAgIC5uYW1l
ID0gIm5lX21pc2NfZGV2X3Rlc3QiLAo+ICsgICAgICAgLnRlc3RfY2FzZXMgPSBuZV9taXNjX2Rl
dl90ZXN0X2Nhc2VzLAo+ICt9Owo+ICsKPiArc3RhdGljIHN0cnVjdCBrdW5pdF9zdWl0ZSAqbmVf
bWlzY19kZXZfdGVzdF9zdWl0ZXNbXSA9IHsKPiArICAgICAgICZuZV9taXNjX2Rldl90ZXN0X3N1
aXRlLAo+ICsgICAgICAgTlVMTAo+ICt9Owo+IC0tCj4gMS44LjMuMQo+IAoKCgpBbWF6b24gRGV2
ZWxvcG1lbnQgQ2VudGVyIChSb21hbmlhKSBTLlIuTC4gcmVnaXN0ZXJlZCBvZmZpY2U6IDI3QSBT
Zi4gTGF6YXIgU3RyZWV0LCBVQkM1LCBmbG9vciAyLCBJYXNpLCBJYXNpIENvdW50eSwgNzAwMDQ1
LCBSb21hbmlhLiBSZWdpc3RlcmVkIGluIFJvbWFuaWEuIFJlZ2lzdHJhdGlvbiBudW1iZXIgSjIy
LzI2MjEvMjAwNS4K

