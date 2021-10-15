Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1CB42F48C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 15:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240202AbhJOOAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 10:00:50 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:41779 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239577AbhJOOAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 10:00:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1634306323; x=1665842323;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+FWJolYwP5IhD2hYF71GXj/1VoXOqfZz9ZhrnIG31nk=;
  b=V7Jl9tuir5jNOyuOU7xbqofXV++xRBfyJLiDC8sZaKAJYH6KAmIg7i8X
   Du8cGTNmN7mmoZFOVzMcQWExqKv35h6Bd1V1STV/eD/DNuRsaSKbvOm5L
   eprzqk+TRP63lNVDoi+ooM6tO1QHPdFltKSHuOAJYgGjAet0RNKgbfBz7
   Y=;
X-IronPort-AV: E=Sophos;i="5.85,375,1624320000"; 
   d="scan'208";a="153742503"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-e823fbde.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP; 15 Oct 2021 13:58:42 +0000
Received: from EX13D16EUB003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1a-e823fbde.us-east-1.amazon.com (Postfix) with ESMTPS id B5FDAC08FE;
        Fri, 15 Oct 2021 13:58:38 +0000 (UTC)
Received: from [10.85.100.8] (10.43.162.248) by EX13D16EUB003.ant.amazon.com
 (10.43.166.99) with Microsoft SMTP Server (TLS) id 15.0.1497.24; Fri, 15 Oct
 2021 13:58:32 +0000
Message-ID: <58693f94-f110-a1cf-d464-df2107f56529@amazon.com>
Date:   Fri, 15 Oct 2021 16:58:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.0
Subject: Re: [PATCH v3 3/4] nitro_enclaves: Add KUnit tests setup for the misc
 device functionality
Content-Language: en-US
To:     "Longpeng(Mike)" <longpeng2@huawei.com>
CC:     <arei.gonglei@huawei.com>, <gregkh@linuxfoundation.org>,
        <kamal@canonical.com>, <pbonzini@redhat.com>,
        <sgarzare@redhat.com>, <stefanha@redhat.com>,
        <vkuznets@redhat.com>, <linux-kernel@vger.kernel.org>,
        <ne-devel-upstream@amazon.com>, <lexnv@amazon.com>,
        <alcioa@amazon.com>
References: <20211009013248.1174-1-longpeng2@huawei.com>
 <20211009013248.1174-4-longpeng2@huawei.com>
From:   "Paraschiv, Andra-Irina" <andraprs@amazon.com>
In-Reply-To: <20211009013248.1174-4-longpeng2@huawei.com>
X-Originating-IP: [10.43.162.248]
X-ClientProxiedBy: EX13D18UWC004.ant.amazon.com (10.43.162.77) To
 EX13D16EUB003.ant.amazon.com (10.43.166.99)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpPbiAwOS8xMC8yMDIxIDA0OjMyLCBMb25ncGVuZyhNaWtlKSB3cm90ZToKPiBGcm9tOiBMb25n
cGVuZyA8bG9uZ3BlbmcyQGh1YXdlaS5jb20+Cj4gCj4gQWRkIHRoZSBpbml0aWFsIHNldHVwIGZv
ciB0aGUgS1VuaXQgdGVzdHMgdGhhdCB3aWxsIHRhcmdldCB0aGUgTml0cm8KPiBFbmNsYXZlcyBt
aXNjIGRldmljZSBmdW5jdGlvbmFsaXR5Lgo+IAo+IFNpZ25lZC1vZmYtYnk6IExvbmdwZW5nIDxs
b25ncGVuZzJAaHVhd2VpLmNvbT4KPiAtLS0KPiBDaGFuZ2VzIHYyIC0+IHYzOgo+ICAgIC0gdXBk
YXRlIHRoZSBjb21taXQgdGl0bGUgYW5kIGNvbW1pdCBtZXNzYWdlLiAgW0FuZHJhXQo+ICAgIC0g
dXNlICJtaXNjX2RldiIvIm1pc2MgZGV2aWNlIi8iTUlTQ19ERVYiIHRvIGJlIG1vcmUgc3BlY2lm
aWMuICBbQW5kcmFdCj4gLS0tCj4gICBkcml2ZXJzL3ZpcnQvbml0cm9fZW5jbGF2ZXMvS2NvbmZp
ZyAgICAgICAgICAgIHwgIDkgKysrKysrKysrCj4gICBkcml2ZXJzL3ZpcnQvbml0cm9fZW5jbGF2
ZXMvbmVfbWlzY19kZXYuYyAgICAgIHwgMjcgKysrKysrKysrKysrKysrKysrKysrKysrKysKPiAg
IGRyaXZlcnMvdmlydC9uaXRyb19lbmNsYXZlcy9uZV9taXNjX2Rldl90ZXN0LmMgfCAxNyArKysr
KysrKysrKysrKysrCj4gICAzIGZpbGVzIGNoYW5nZWQsIDUzIGluc2VydGlvbnMoKykKPiAgIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3ZpcnQvbml0cm9fZW5jbGF2ZXMvbmVfbWlzY19kZXZf
dGVzdC5jCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydC9uaXRyb19lbmNsYXZlcy9LY29u
ZmlnIGIvZHJpdmVycy92aXJ0L25pdHJvX2VuY2xhdmVzL0tjb25maWcKPiBpbmRleCA4YzkzODdh
Li45MDgwMmIxIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmlydC9uaXRyb19lbmNsYXZlcy9LY29u
ZmlnCj4gKysrIGIvZHJpdmVycy92aXJ0L25pdHJvX2VuY2xhdmVzL0tjb25maWcKPiBAQCAtMTgs
MyArMTgsMTIgQEAgY29uZmlnIE5JVFJPX0VOQ0xBVkVTCj4gICAKPiAgIAkgIFRvIGNvbXBpbGUg
dGhpcyBkcml2ZXIgYXMgYSBtb2R1bGUsIGNob29zZSBNIGhlcmUuCj4gICAJICBUaGUgbW9kdWxl
IHdpbGwgYmUgY2FsbGVkIG5pdHJvX2VuY2xhdmVzLgo+ICsKPiArY29uZmlnIE5JVFJPX0VOQ0xB
VkVTX01JU0NfREVWX1RFU1QKPiArCWJvb2wgIlRlc3RzIGZvciB0aGUgbWlzYyBkZXZpY2UgZnVu
Y3Rpb25hbGl0eSBvZiB0aGUgTml0cm8gZW5jbGF2ZXMiCgpOaXRybyBlbmNsYXZlcyA9PiBOaXRy
byBFbmNsYXZlcwoKPiArCWRlcGVuZHMgb24gTklUUk9fRU5DTEFWRVMgJiYgS1VOSVQ9eQo+ICsJ
aGVscAo+ICsJICBFbmFibGUgS1VuaXQgdGVzdHMgZm9yIHRoZSBtaXNjIGRldmljZSBmdW5jdGlv
bmFsaXR5IG9mIHRoZSBOaXRybwo+ICsJICBFbmNsYXZlcy4gU2VsZWN0IHRoaXMgb3B0aW9uIG9u
bHkgaWYgeW91IHdpbGwgYm9vdCB0aGUga2VybmVsIGZvcgo+ICsJICB0aGUgcHVycG9zZSBvZiBy
dW5uaW5nIHVuaXQgdGVzdHMgKGUuZy4gdW5kZXIgVU1MIG9yIHFlbXUpLiBJZgo+ICsJICB1bnN1
cmUsIHNheSBOLgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnQvbml0cm9fZW5jbGF2ZXMvbmVf
bWlzY19kZXYuYyBiL2RyaXZlcnMvdmlydC9uaXRyb19lbmNsYXZlcy9uZV9taXNjX2Rldi5jCj4g
aW5kZXggYThmYTU2Yi4uZjg5NWZjMyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZpcnQvbml0cm9f
ZW5jbGF2ZXMvbmVfbWlzY19kZXYuYwo+ICsrKyBiL2RyaXZlcnMvdmlydC9uaXRyb19lbmNsYXZl
cy9uZV9taXNjX2Rldi5jCj4gQEAgLTE3NTYsOCArMTc1NiwzMyBAQCBzdGF0aWMgbG9uZyBuZV9p
b2N0bChzdHJ1Y3QgZmlsZSAqZmlsZSwgdW5zaWduZWQgaW50IGNtZCwgdW5zaWduZWQgbG9uZyBh
cmcpCj4gICAJcmV0dXJuIDA7Cj4gICB9Cj4gICAKPiArI2lmIGRlZmluZWQoQ09ORklHX05JVFJP
X0VOQ0xBVkVTX01JU0NfREVWX1RFU1QpCj4gKyNpbmNsdWRlICJuZV9taXNjX2Rldl90ZXN0LmMi
Cj4gKwo+ICtzdGF0aWMgaW5saW5lIGludCBuZV9taXNjX2Rldl90ZXN0X2luaXQodm9pZCkKPiAr
ewo+ICsJcmV0dXJuIF9fa3VuaXRfdGVzdF9zdWl0ZXNfaW5pdChuZV9taXNjX2Rldl90ZXN0X3N1
aXRlcyk7Cj4gK30KPiArCj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBuZV9taXNjX2Rldl90ZXN0X2V4
aXQodm9pZCkKPiArewo+ICsJX19rdW5pdF90ZXN0X3N1aXRlc19leGl0KG5lX21pc2NfZGV2X3Rl
c3Rfc3VpdGVzKTsKPiArfQo+ICsjZWxzZQo+ICtzdGF0aWMgaW5saW5lIGludCBuZV9taXNjX2Rl
dl90ZXN0X2luaXQodm9pZCkKPiArewo+ICsJcmV0dXJuIDA7Cj4gK30KPiArCj4gK3N0YXRpYyBp
bmxpbmUgdm9pZCBuZV9taXNjX2Rldl90ZXN0X2V4aXQodm9pZCkKPiArewo+ICt9Cj4gKyNlbmRp
Zgo+ICsKPiAgIHN0YXRpYyBpbnQgX19pbml0IG5lX2luaXQodm9pZCkKPiAgIHsKPiArCW5lX21p
c2NfZGV2X3Rlc3RfaW5pdCgpOwoKTGV0J3MgaGF2ZToKCmludCByYyA9IDA7CgphbmQgdGhlbiBj
aGVjayB0aGUgcmV0dXJuIGNvZGUgb2YgIm5lX21pc2NfZGV2X3Rlc3RfaW5pdCgpIi4KCj4gKwo+
ICAgCW11dGV4X2luaXQoJm5lX2NwdV9wb29sLm11dGV4KTsKPiAgIAo+ICAgCXJldHVybiBwY2lf
cmVnaXN0ZXJfZHJpdmVyKCZuZV9wY2lfZHJpdmVyKTsKPiBAQCAtMTc2OCw2ICsxNzkzLDggQEAg
c3RhdGljIHZvaWQgX19leGl0IG5lX2V4aXQodm9pZCkKPiAgIAlwY2lfdW5yZWdpc3Rlcl9kcml2
ZXIoJm5lX3BjaV9kcml2ZXIpOwo+ICAgCj4gICAJbmVfdGVhcmRvd25fY3B1X3Bvb2woKTsKPiAr
Cj4gKwluZV9taXNjX2Rldl90ZXN0X2V4aXQoKTsKPiAgIH0KPiAgIAo+ICAgbW9kdWxlX2luaXQo
bmVfaW5pdCk7Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydC9uaXRyb19lbmNsYXZlcy9uZV9t
aXNjX2Rldl90ZXN0LmMgYi9kcml2ZXJzL3ZpcnQvbml0cm9fZW5jbGF2ZXMvbmVfbWlzY19kZXZf
dGVzdC5jCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPiBpbmRleCAwMDAwMDAwLi5iY2I3NTVlCj4g
LS0tIC9kZXYvbnVsbAo+ICsrKyBiL2RyaXZlcnMvdmlydC9uaXRyb19lbmNsYXZlcy9uZV9taXNj
X2Rldl90ZXN0LmMKPiBAQCAtMCwwICsxLDE3IEBACj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlm
aWVyOiBHUEwtMi4wLW9yLWxhdGVyCgpMZXQncyBrZWVwIHRoZSBzYW1lIG1hcmtlciBhcyBpbiB0
aGUgb3RoZXIgZmlsZXMgb2YgdGhlIE5FIGtlcm5lbCBkcml2ZXIgCmNvZGViYXNlLgoKLy8gU1BE
WC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAKClRoYW5rcywKQW5kcmEKCj4gKwo+ICsjaW5j
bHVkZSA8a3VuaXQvdGVzdC5oPgo+ICsKPiArc3RhdGljIHN0cnVjdCBrdW5pdF9jYXNlIG5lX21p
c2NfZGV2X3Rlc3RfY2FzZXNbXSA9IHsKPiArCXt9Cj4gK307Cj4gKwo+ICtzdGF0aWMgc3RydWN0
IGt1bml0X3N1aXRlIG5lX21pc2NfZGV2X3Rlc3Rfc3VpdGUgPSB7Cj4gKwkubmFtZSA9ICJuZV9t
aXNjX2Rldl90ZXN0IiwKPiArCS50ZXN0X2Nhc2VzID0gbmVfbWlzY19kZXZfdGVzdF9jYXNlcywK
PiArfTsKPiArCj4gK3N0YXRpYyBzdHJ1Y3Qga3VuaXRfc3VpdGUgKm5lX21pc2NfZGV2X3Rlc3Rf
c3VpdGVzW10gPSB7Cj4gKwkmbmVfbWlzY19kZXZfdGVzdF9zdWl0ZSwKPiArCU5VTEwKPiArfTsK
PiAKCgoKQW1hem9uIERldmVsb3BtZW50IENlbnRlciAoUm9tYW5pYSkgUy5SLkwuIHJlZ2lzdGVy
ZWQgb2ZmaWNlOiAyN0EgU2YuIExhemFyIFN0cmVldCwgVUJDNSwgZmxvb3IgMiwgSWFzaSwgSWFz
aSBDb3VudHksIDcwMDA0NSwgUm9tYW5pYS4gUmVnaXN0ZXJlZCBpbiBSb21hbmlhLiBSZWdpc3Ry
YXRpb24gbnVtYmVyIEoyMi8yNjIxLzIwMDUuCg==

