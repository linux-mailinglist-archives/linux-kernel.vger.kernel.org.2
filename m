Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACF64256BF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 17:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242269AbhJGPkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 11:40:12 -0400
Received: from smtp-fw-80006.amazon.com ([99.78.197.217]:61952 "EHLO
        smtp-fw-80006.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241273AbhJGPkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 11:40:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1633621098; x=1665157098;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rZsLNQurAm5LuuMaru/89I1hRmsznwrAuxPEH5/tVkA=;
  b=aUlqHkR+3I04TuVz8EjMk20HFlRoRJOD4dE6hnKYCmH2b22fnG/h4drO
   /9QVpay/QoNAtHZ6AO1YS/r+pq6mzssE8B2+mexVxDf8a3G8+sYG/MNQs
   kLqSeC0Sfy2omR50JbP2z+b3T+mcjijN9tGuICHgTZxnUPl76Sp2l2N1t
   Y=;
X-IronPort-AV: E=Sophos;i="5.85,355,1624320000"; 
   d="scan'208";a="32559027"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-02ee77e7.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP; 07 Oct 2021 15:38:10 +0000
Received: from EX13D16EUB003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2b-02ee77e7.us-west-2.amazon.com (Postfix) with ESMTPS id F00F84201E;
        Thu,  7 Oct 2021 15:38:07 +0000 (UTC)
Received: from [10.85.103.147] (10.43.160.106) by EX13D16EUB003.ant.amazon.com
 (10.43.166.99) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Thu, 7 Oct
 2021 15:38:00 +0000
Message-ID: <77537d8a-0306-69d3-8ec3-ef1267b8c200@amazon.com>
Date:   Thu, 7 Oct 2021 18:37:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.2
Subject: Re: [PATCH v2 3/4] nitro_enclaves: add test framework for the misc
 functionality
Content-Language: en-US
To:     "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kamal@canonical.com" <kamal@canonical.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "sgarzare@redhat.com" <sgarzare@redhat.com>,
        "stefanha@redhat.com" <stefanha@redhat.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "ne-devel-upstream@amazon.com" <ne-devel-upstream@amazon.com>,
        "lexnv@amazon.com" <lexnv@amazon.com>,
        "alcioa@amazon.com" <alcioa@amazon.com>
References: <20210921151039.1502-1-longpeng2@huawei.com>
 <20210921151039.1502-4-longpeng2@huawei.com>
 <ccb2b514-6fb7-440a-b498-037f0163e0c3@amazon.com>
 <03ec1f44847d4fc196080c28aadc1b65@huawei.com>
From:   "Paraschiv, Andra-Irina" <andraprs@amazon.com>
In-Reply-To: <03ec1f44847d4fc196080c28aadc1b65@huawei.com>
X-Originating-IP: [10.43.160.106]
X-ClientProxiedBy: EX13D44UWC004.ant.amazon.com (10.43.162.209) To
 EX13D16EUB003.ant.amazon.com (10.43.166.99)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpPbiAwNy8xMC8yMDIxIDA1OjA1LCBMb25ncGVuZyAoTWlrZSwgQ2xvdWQgSW5mcmFzdHJ1Y3R1
cmUgU2VydmljZSAKUHJvZHVjdCBEZXB0Likgd3JvdGU6Cj4gCj4gCj4+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tCj4+IEZyb206IFBhcmFzY2hpdiwgQW5kcmEtSXJpbmEgW21haWx0bzphbmRy
YXByc0BhbWF6b24uY29tXQo+PiBTZW50OiBTdW5kYXksIE9jdG9iZXIgMywgMjAyMSA5OjUwIFBN
Cj4+IFRvOiBMb25ncGVuZyAoTWlrZSwgQ2xvdWQgSW5mcmFzdHJ1Y3R1cmUgU2VydmljZSBQcm9k
dWN0IERlcHQuKQo+PiA8bG9uZ3BlbmcyQGh1YXdlaS5jb20+Cj4+IENjOiBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBHb25nbGVpIChBcmVpKSA8YXJlaS5nb25nbGVpQGh1YXdlaS5jb20+
Owo+PiBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsga2FtYWxAY2Fub25pY2FsLmNvbTsgcGJv
bnppbmlAcmVkaGF0LmNvbTsKPj4gc2dhcnphcmVAcmVkaGF0LmNvbTsgc3RlZmFuaGFAcmVkaGF0
LmNvbTsgdmt1em5ldHNAcmVkaGF0LmNvbTsKPj4gbmUtZGV2ZWwtdXBzdHJlYW1AYW1hem9uLmNv
bTsgbGV4bnZAYW1hem9uLmNvbTsgYWxjaW9hQGFtYXpvbi5jb20KPj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2MiAzLzRdIG5pdHJvX2VuY2xhdmVzOiBhZGQgdGVzdCBmcmFtZXdvcmsgZm9yIHRoZSBt
aXNjCj4+IGZ1bmN0aW9uYWxpdHkKPj4KPj4KPj4KPj4gT24gMjEvMDkvMjAyMSAxODoxMCwgTG9u
Z3BlbmcoTWlrZSkgd3JvdGU6Cj4+PiBBZGQgdGVzdCBmcmFtZXdvcmsgZm9yIHRoZSBtaXNjIGZ1
bmN0aW9uYWxpdHkuCj4+Cj4+IExldCdzIGFkZCBtb3JlIHNwZWNpZmljcyBoZXJlLgo+Pgo+PiBu
aXRyb19lbmNsYXZlczogQWRkIEtVbml0IHRlc3RzIHNldHVwIGZvciB0aGUgbWlzYyBkZXZpY2Ug
ZnVuY3Rpb25hbGl0eQo+Pgo+PiBBZGQgdGhlIGluaXRpYWwgc2V0dXAgZm9yIHRoZSBLVW5pdCB0
ZXN0cyB0aGF0IHdpbGwgdGFyZ2V0IHRoZSBOaXRybwo+PiBFbmNsYXZlcyBtaXNjIGRldmljZSBm
dW5jdGlvbmFsaXR5Lgo+Pgo+IAo+IE9LLCB0aGFua3MuCj4gCj4+Pgo+Pj4gU2lnbmVkLW9mZi1i
eTogTG9uZ3BlbmcoTWlrZSkgPGxvbmdwZW5nMkBodWF3ZWkuY29tPgo+Pj4gLS0tCj4+PiAgICBk
cml2ZXJzL3ZpcnQvbml0cm9fZW5jbGF2ZXMvS2NvbmZpZyAgICAgICAgfCAgOCArKysrKysrKwo+
Pj4gICAgZHJpdmVycy92aXJ0L25pdHJvX2VuY2xhdmVzL25lX21pc2NfZGV2LmMgIHwgMjcKPj4g
KysrKysrKysrKysrKysrKysrKysrKysrKysrCj4+PiAgICBkcml2ZXJzL3ZpcnQvbml0cm9fZW5j
bGF2ZXMvbmVfbWlzY190ZXN0LmMgfCAxNyArKysrKysrKysrKysrKysrKwo+Pj4gICAgMyBmaWxl
cyBjaGFuZ2VkLCA1MiBpbnNlcnRpb25zKCspCj4+PiAgICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJp
dmVycy92aXJ0L25pdHJvX2VuY2xhdmVzL25lX21pc2NfdGVzdC5jCj4+Cj4+IFBsZWFzZSBtb2Rp
ZnkgaW4gYWxsIHBsYWNlcyB3aGVyZSBuZWNlc3NhcnkgdG8gbWVudGlvbiBOaXRybyBFbmNsYXZl
cwo+PiAibWlzYyBkZXZpY2UiLCBpbnN0ZWFkIG9mIGp1c3QgIm1pc2MiLCB0byBiZSBtb3JlIHNw
ZWNpZmljLgo+Pgo+PiBGb3IgZXhhbXBsZSwgaGVyZSBjYW4gYmUgIm5lX21pc2NfZGV2X3Rlc3Qu
YyIuCj4+Cj4gCj4gT0suCj4gCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydC9uaXRy
b19lbmNsYXZlcy9LY29uZmlnCj4+IGIvZHJpdmVycy92aXJ0L25pdHJvX2VuY2xhdmVzL0tjb25m
aWcKPj4+IGluZGV4IDhjOTM4N2EuLjI0YzU0ZGEgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL3Zp
cnQvbml0cm9fZW5jbGF2ZXMvS2NvbmZpZwo+Pj4gKysrIGIvZHJpdmVycy92aXJ0L25pdHJvX2Vu
Y2xhdmVzL0tjb25maWcKPj4+IEBAIC0xOCwzICsxOCwxMSBAQCBjb25maWcgTklUUk9fRU5DTEFW
RVMKPj4+Cj4+PiAgICAJICBUbyBjb21waWxlIHRoaXMgZHJpdmVyIGFzIGEgbW9kdWxlLCBjaG9v
c2UgTSBoZXJlLgo+Pj4gICAgCSAgVGhlIG1vZHVsZSB3aWxsIGJlIGNhbGxlZCBuaXRyb19lbmNs
YXZlcy4KPj4+ICsKPj4+ICtjb25maWcgTklUUk9fRU5DTEFWRVNfTUlTQ19URVNUCj4+Cj4+IE5J
VFJPX0VOQ0xBVkVTX01JU0NfREVWX1RFU1QKPj4KPj4+ICsJYm9vbCAiVGVzdHMgZm9yIHRoZSBt
aXNjIGZ1bmN0aW9uYWxpdHkgb2YgTml0cm8gZW5jbGF2ZXMiCj4+Cj4+IG1pc2MgZGV2aWNlIGZ1
bmN0aW9uYWxpdHkgb2YgdGhlIE5pdHJvIEVuY2xhdmVzCj4+Cj4+PiArCWRlcGVuZHMgb24gTklU
Uk9fRU5DTEFWRVMgJiYgS1VOSVQ9eQo+Pj4gKwloZWxwCj4+PiArCSAgRW5hYmxlIEtVbml0IHRl
c3RzIGZvciB0aGUgbWlzYyBmdW5jdGlvbmFsaXR5IG9mIE5pdHJvIEVuY2xhdmVzLiBTZWxlY3QK
Pj4KPj4gbWlzYyBkZXZpY2UgZnVuY3Rpb25hbGl0eSBvZiB0aGUgTml0cm8gRW5jbGF2ZXMKPj4K
PiAKPiBPSywgdGhhbmtzLgo+IAo+Pj4gKwkgIHRoaXMgb3B0aW9uIG9ubHkgaWYgeW91IHdpbGwg
Ym9vdCB0aGUga2VybmVsIGZvciB0aGUgcHVycG9zZSBvZiBydW5uaW5nCj4+PiArCSAgdW5pdCB0
ZXN0cyAoZS5nLiB1bmRlciBVTUwgb3IgcWVtdSkuIElmIHVuc3VyZSwgc2F5IE4uCj4+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy92aXJ0L25pdHJvX2VuY2xhdmVzL25lX21pc2NfZGV2LmMKPj4gYi9k
cml2ZXJzL3ZpcnQvbml0cm9fZW5jbGF2ZXMvbmVfbWlzY19kZXYuYwo+Pj4gaW5kZXggZDU1MWI4
OC4uMDEzMWUxYiAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvdmlydC9uaXRyb19lbmNsYXZlcy9u
ZV9taXNjX2Rldi5jCj4+PiArKysgYi9kcml2ZXJzL3ZpcnQvbml0cm9fZW5jbGF2ZXMvbmVfbWlz
Y19kZXYuYwo+Pj4gQEAgLTE3MzUsOCArMTczNSwzMyBAQCBzdGF0aWMgbG9uZyBuZV9pb2N0bChz
dHJ1Y3QgZmlsZSAqZmlsZSwgdW5zaWduZWQgaW50Cj4+IGNtZCwgdW5zaWduZWQgbG9uZyBhcmcp
Cj4+PiAgICAJcmV0dXJuIDA7Cj4+PiAgICB9Cj4+Pgo+Pj4gKyNpZiBkZWZpbmVkKENPTkZJR19O
SVRST19FTkNMQVZFU19NSVNDX1RFU1QpCj4+PiArI2luY2x1ZGUgIm5lX21pc2NfdGVzdC5jIgo+
Pj4gKwo+Pj4gK3N0YXRpYyBpbmxpbmUgaW50IG5lX21pc2NfdGVzdF9pbml0KHZvaWQpCj4+PiAr
ewo+Pj4gKwlyZXR1cm4gX19rdW5pdF90ZXN0X3N1aXRlc19pbml0KG5lX21pc2NfdGVzdF9zdWl0
ZXMpOwo+Pj4gK30KPj4+ICsKPj4+ICtzdGF0aWMgaW5saW5lIHZvaWQgbmVfbWlzY190ZXN0X2V4
aXQodm9pZCkKPj4+ICt7Cj4+PiArCV9fa3VuaXRfdGVzdF9zdWl0ZXNfZXhpdChuZV9taXNjX3Rl
c3Rfc3VpdGVzKTsKPj4+ICt9Cj4+PiArI2Vsc2UKPj4+ICtzdGF0aWMgaW5saW5lIGludCBuZV9t
aXNjX3Rlc3RfaW5pdCh2b2lkKQo+Pj4gK3sKPj4+ICsJcmV0dXJuIDA7Cj4+PiArfQo+Pj4gKwo+
Pj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBuZV9taXNjX3Rlc3RfZXhpdCh2b2lkKQo+Pj4gK3sKPj4+
ICt9Cj4+PiArI2VuZGlmCj4+Cj4+IHMvbWlzYy9taXNjX2Rldi9nCj4+Cj4+IFdoeSBhcmUgdGhl
c2UgbmVlZGVkPyBDYW4ndCB0aGUgdGVzdCBzdWl0ZSBiZSBzZXR1cCB1c2luZwo+PiAia3VuaXRf
dGVzdF9zdWl0ZSIgYXMgaW4gdGhlIEtVbml0IGRvY3VtZW50YXRpb24gZXhhbXBsZSBbMV0/Cj4+
Cj4+IFdvdWxkbid0IGJlIG5lY2Vzc2FyeSB0byBjb25kaXRpb25hbGx5IGNvbXBpbGUgdGhlIG5l
X21pc2NfZGV2X3Rlc3QsCj4+IGJhc2VkIG9uIHRoZSBrZXJuZWwgY29uZmlnIGFib3ZlPwo+Pgo+
PiBbMV0KPj4gaHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2MvaHRtbC9sYXRlc3QvZGV2LXRvb2xz
L2t1bml0L3N0YXJ0Lmh0bWwjd3JpdGluZy15Cj4+IG91ci1maXJzdC10ZXN0Cj4+Cj4gCj4gQm90
aCBvZiB0aGVzZSB0d28gd2F5cyBhcmUgc3VwcG9ydGVkIGluIGtlcm5lbCwgZm9yIGV4YW1wbGUg
WzJdLgo+IAo+IFRoZXJlIGFyZSB0d28gcmVhc29ucyB3aHkgSSBjaG9vc2UgdGhpcyB3YXk6Cj4g
MS4gVGhlIGZ1bmN0aW9ucyAodG8gdGVzdCkgaW4gIm5lX21pc2NfZGV2LmMiIGFyZSAnc3RhdGlj
Jywgd2UgY2Fubm90IGludm9rZQo+ICAgICAgdGhlbSBpbiAgIm5lX21pc2NfZGV2X3Rlc3QuYyIu
Cj4gMi4ga3VuaXRfdGVzdF9zdWl0ZSBkZWZpbmVzIGEgbW9kdWxlIGluaXQgZnVuY3Rpb24gaW50
ZXJuYWwsIGFuZCAibmVfbWlzY19kZXYuYyIKPiAgICAgIGFsc28gZGVmaW5lcyBvbmUsIHNvIHRo
ZXkgY2Fubm90IGJlIGNvbXBpbGVkIGludG8gb25lIG1vZHVsZS4KCgpUaGFua3MgZm9yIHRoZSBl
eHBsYW5hdGlvbi4KCkFuZHJhCgo+IAo+IAo+IFsyXQo+IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4u
Y29tL2xpbnV4L3Y1LjE1LXJjNC9zb3VyY2UvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1hc3Bl
ZWQuYyNMNjEyCj4gCj4+PiArCj4+PiAgICBzdGF0aWMgaW50IF9faW5pdCBuZV9pbml0KHZvaWQp
Cj4+PiAgICB7Cj4+PiArCW5lX21pc2NfdGVzdF9pbml0KCk7Cj4+PiArCj4+PiAgICAJbXV0ZXhf
aW5pdCgmbmVfY3B1X3Bvb2wubXV0ZXgpOwo+Pj4KPj4+ICAgIAlyZXR1cm4gcGNpX3JlZ2lzdGVy
X2RyaXZlcigmbmVfcGNpX2RyaXZlcik7Cj4+PiBAQCAtMTc0Nyw2ICsxNzcyLDggQEAgc3RhdGlj
IHZvaWQgX19leGl0IG5lX2V4aXQodm9pZCkKPj4+ICAgIAlwY2lfdW5yZWdpc3Rlcl9kcml2ZXIo
Jm5lX3BjaV9kcml2ZXIpOwo+Pj4KPj4+ICAgIAluZV90ZWFyZG93bl9jcHVfcG9vbCgpOwo+Pj4g
Kwo+Pj4gKwluZV9taXNjX3Rlc3RfZXhpdCgpOwo+Pj4gICAgfQo+Pj4KPj4+ICAgIG1vZHVsZV9p
bml0KG5lX2luaXQpOwo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydC9uaXRyb19lbmNsYXZl
cy9uZV9taXNjX3Rlc3QuYwo+PiBiL2RyaXZlcnMvdmlydC9uaXRyb19lbmNsYXZlcy9uZV9taXNj
X3Rlc3QuYwo+Pj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPj4+IGluZGV4IDAwMDAwMDAuLjM0MjZj
MzUKPj4+IC0tLSAvZGV2L251bGwKPj4+ICsrKyBiL2RyaXZlcnMvdmlydC9uaXRyb19lbmNsYXZl
cy9uZV9taXNjX3Rlc3QuYwo+Pj4gQEAgLTAsMCArMSwxNyBAQAo+Pj4gKy8vIFNQRFgtTGljZW5z
ZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyCj4+PiArCj4+PiArI2luY2x1ZGUgPGt1bml0
L3Rlc3QuaD4KPj4+ICsKPj4+ICtzdGF0aWMgc3RydWN0IGt1bml0X2Nhc2UgbmVfbWlzY190ZXN0
X2Nhc2VzW10gPSB7Cj4+PiArCXt9Cj4+PiArfTsKPj4+ICsKPj4+ICtzdGF0aWMgc3RydWN0IGt1
bml0X3N1aXRlIG5lX21pc2NfdGVzdF9zdWl0ZSA9IHsKPj4+ICsJLm5hbWUgPSAibmVfbWlzY190
ZXN0IiwKPj4+ICsJLnRlc3RfY2FzZXMgPSBuZV9taXNjX3Rlc3RfY2FzZXMsCj4+PiArfTsKPj4+
ICsKPj4+ICtzdGF0aWMgc3RydWN0IGt1bml0X3N1aXRlICpuZV9taXNjX3Rlc3Rfc3VpdGVzW10g
PSB7Cj4+PiArCSZuZV9taXNjX3Rlc3Rfc3VpdGUsCj4+PiArCU5VTEwKPj4+ICt9Owo+Pj4KPj4K
Pj4gQ2FuIHJlcGxhY2UgIm5lX21pc2MiIHdpdGggIm5lX21pc2NfZGV2Ii4KPj4KPj4gVGhhbmtz
LAo+PiBBbmRyYQo+Pgo+Pgo+Pgo+PiBBbWF6b24gRGV2ZWxvcG1lbnQgQ2VudGVyIChSb21hbmlh
KSBTLlIuTC4gcmVnaXN0ZXJlZCBvZmZpY2U6IDI3QSBTZi4gTGF6YXIKPj4gU3RyZWV0LCBVQkM1
LCBmbG9vciAyLCBJYXNpLCBJYXNpIENvdW50eSwgNzAwMDQ1LCBSb21hbmlhLiBSZWdpc3RlcmVk
IGluIFJvbWFuaWEuCj4+IFJlZ2lzdHJhdGlvbiBudW1iZXIgSjIyLzI2MjEvMjAwNS4KCgoKQW1h
em9uIERldmVsb3BtZW50IENlbnRlciAoUm9tYW5pYSkgUy5SLkwuIHJlZ2lzdGVyZWQgb2ZmaWNl
OiAyN0EgU2YuIExhemFyIFN0cmVldCwgVUJDNSwgZmxvb3IgMiwgSWFzaSwgSWFzaSBDb3VudHks
IDcwMDA0NSwgUm9tYW5pYS4gUmVnaXN0ZXJlZCBpbiBSb21hbmlhLiBSZWdpc3RyYXRpb24gbnVt
YmVyIEoyMi8yNjIxLzIwMDUuCg==

