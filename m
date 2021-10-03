Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 492894201C7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 15:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbhJCNwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 09:52:01 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:44456 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbhJCNv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 09:51:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1633269011; x=1664805011;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DrcrXnE5d8uPecARdeB15sl1Dfs/EwEhidWj4O1EH7M=;
  b=c6wJYXWEbHmQ7aMlIuqobXvl5k+/7i0hsJDdldImbqCY0HSY4UlgQqRC
   vLlMWqLBfju3VSU15xZQaRSH0+9riD7rI8OAbtKaUVYwRkViC6MbsC8uB
   2t3/tLAEUVueseW9lXU/AwI//ApxXHOtXsJAVJvJOqPWMElJqMoic7neB
   k=;
X-IronPort-AV: E=Sophos;i="5.85,343,1624320000"; 
   d="scan'208";a="151403195"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-11a39b7d.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP; 03 Oct 2021 13:50:10 +0000
Received: from EX13D16EUB003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2a-11a39b7d.us-west-2.amazon.com (Postfix) with ESMTPS id 7BED342118;
        Sun,  3 Oct 2021 13:50:07 +0000 (UTC)
Received: from [192.168.13.185] (10.43.160.106) by
 EX13D16EUB003.ant.amazon.com (10.43.166.99) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Sun, 3 Oct 2021 13:50:00 +0000
Message-ID: <ccb2b514-6fb7-440a-b498-037f0163e0c3@amazon.com>
Date:   Sun, 3 Oct 2021 16:49:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.2
Subject: Re: [PATCH v2 3/4] nitro_enclaves: add test framework for the misc
 functionality
Content-Language: en-US
To:     "Longpeng(Mike)" <longpeng2@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <arei.gonglei@huawei.com>,
        <gregkh@linuxfoundation.org>, <kamal@canonical.com>,
        <pbonzini@redhat.com>, <sgarzare@redhat.com>,
        <stefanha@redhat.com>, <vkuznets@redhat.com>,
        <ne-devel-upstream@amazon.com>, <lexnv@amazon.com>,
        <alcioa@amazon.com>
References: <20210921151039.1502-1-longpeng2@huawei.com>
 <20210921151039.1502-4-longpeng2@huawei.com>
From:   "Paraschiv, Andra-Irina" <andraprs@amazon.com>
In-Reply-To: <20210921151039.1502-4-longpeng2@huawei.com>
X-Originating-IP: [10.43.160.106]
X-ClientProxiedBy: EX13D02UWB001.ant.amazon.com (10.43.161.240) To
 EX13D16EUB003.ant.amazon.com (10.43.166.99)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpPbiAyMS8wOS8yMDIxIDE4OjEwLCBMb25ncGVuZyhNaWtlKSB3cm90ZToKPiBBZGQgdGVzdCBm
cmFtZXdvcmsgZm9yIHRoZSBtaXNjIGZ1bmN0aW9uYWxpdHkuCgpMZXQncyBhZGQgbW9yZSBzcGVj
aWZpY3MgaGVyZS4KCm5pdHJvX2VuY2xhdmVzOiBBZGQgS1VuaXQgdGVzdHMgc2V0dXAgZm9yIHRo
ZSBtaXNjIGRldmljZSBmdW5jdGlvbmFsaXR5CgpBZGQgdGhlIGluaXRpYWwgc2V0dXAgZm9yIHRo
ZSBLVW5pdCB0ZXN0cyB0aGF0IHdpbGwgdGFyZ2V0IHRoZSBOaXRybyAKRW5jbGF2ZXMgbWlzYyBk
ZXZpY2UgZnVuY3Rpb25hbGl0eS4KCj4gCj4gU2lnbmVkLW9mZi1ieTogTG9uZ3BlbmcoTWlrZSkg
PGxvbmdwZW5nMkBodWF3ZWkuY29tPgo+IC0tLQo+ICAgZHJpdmVycy92aXJ0L25pdHJvX2VuY2xh
dmVzL0tjb25maWcgICAgICAgIHwgIDggKysrKysrKysKPiAgIGRyaXZlcnMvdmlydC9uaXRyb19l
bmNsYXZlcy9uZV9taXNjX2Rldi5jICB8IDI3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKwo+
ICAgZHJpdmVycy92aXJ0L25pdHJvX2VuY2xhdmVzL25lX21pc2NfdGVzdC5jIHwgMTcgKysrKysr
KysrKysrKysrKysKPiAgIDMgZmlsZXMgY2hhbmdlZCwgNTIgaW5zZXJ0aW9ucygrKQo+ICAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvdmlydC9uaXRyb19lbmNsYXZlcy9uZV9taXNjX3Rlc3Qu
YwoKUGxlYXNlIG1vZGlmeSBpbiBhbGwgcGxhY2VzIHdoZXJlIG5lY2Vzc2FyeSB0byBtZW50aW9u
IE5pdHJvIEVuY2xhdmVzIAoibWlzYyBkZXZpY2UiLCBpbnN0ZWFkIG9mIGp1c3QgIm1pc2MiLCB0
byBiZSBtb3JlIHNwZWNpZmljLgoKRm9yIGV4YW1wbGUsIGhlcmUgY2FuIGJlICJuZV9taXNjX2Rl
dl90ZXN0LmMiLgoKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0L25pdHJvX2VuY2xhdmVz
L0tjb25maWcgYi9kcml2ZXJzL3ZpcnQvbml0cm9fZW5jbGF2ZXMvS2NvbmZpZwo+IGluZGV4IDhj
OTM4N2EuLjI0YzU0ZGEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aXJ0L25pdHJvX2VuY2xhdmVz
L0tjb25maWcKPiArKysgYi9kcml2ZXJzL3ZpcnQvbml0cm9fZW5jbGF2ZXMvS2NvbmZpZwo+IEBA
IC0xOCwzICsxOCwxMSBAQCBjb25maWcgTklUUk9fRU5DTEFWRVMKPiAgIAo+ICAgCSAgVG8gY29t
cGlsZSB0aGlzIGRyaXZlciBhcyBhIG1vZHVsZSwgY2hvb3NlIE0gaGVyZS4KPiAgIAkgIFRoZSBt
b2R1bGUgd2lsbCBiZSBjYWxsZWQgbml0cm9fZW5jbGF2ZXMuCj4gKwo+ICtjb25maWcgTklUUk9f
RU5DTEFWRVNfTUlTQ19URVNUCgpOSVRST19FTkNMQVZFU19NSVNDX0RFVl9URVNUCgo+ICsJYm9v
bCAiVGVzdHMgZm9yIHRoZSBtaXNjIGZ1bmN0aW9uYWxpdHkgb2YgTml0cm8gZW5jbGF2ZXMiCgpt
aXNjIGRldmljZSBmdW5jdGlvbmFsaXR5IG9mIHRoZSBOaXRybyBFbmNsYXZlcwoKPiArCWRlcGVu
ZHMgb24gTklUUk9fRU5DTEFWRVMgJiYgS1VOSVQ9eQo+ICsJaGVscAo+ICsJICBFbmFibGUgS1Vu
aXQgdGVzdHMgZm9yIHRoZSBtaXNjIGZ1bmN0aW9uYWxpdHkgb2YgTml0cm8gRW5jbGF2ZXMuIFNl
bGVjdAoKbWlzYyBkZXZpY2UgZnVuY3Rpb25hbGl0eSBvZiB0aGUgTml0cm8gRW5jbGF2ZXMKCj4g
KwkgIHRoaXMgb3B0aW9uIG9ubHkgaWYgeW91IHdpbGwgYm9vdCB0aGUga2VybmVsIGZvciB0aGUg
cHVycG9zZSBvZiBydW5uaW5nCj4gKwkgIHVuaXQgdGVzdHMgKGUuZy4gdW5kZXIgVU1MIG9yIHFl
bXUpLiBJZiB1bnN1cmUsIHNheSBOLgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnQvbml0cm9f
ZW5jbGF2ZXMvbmVfbWlzY19kZXYuYyBiL2RyaXZlcnMvdmlydC9uaXRyb19lbmNsYXZlcy9uZV9t
aXNjX2Rldi5jCj4gaW5kZXggZDU1MWI4OC4uMDEzMWUxYiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJz
L3ZpcnQvbml0cm9fZW5jbGF2ZXMvbmVfbWlzY19kZXYuYwo+ICsrKyBiL2RyaXZlcnMvdmlydC9u
aXRyb19lbmNsYXZlcy9uZV9taXNjX2Rldi5jCj4gQEAgLTE3MzUsOCArMTczNSwzMyBAQCBzdGF0
aWMgbG9uZyBuZV9pb2N0bChzdHJ1Y3QgZmlsZSAqZmlsZSwgdW5zaWduZWQgaW50IGNtZCwgdW5z
aWduZWQgbG9uZyBhcmcpCj4gICAJcmV0dXJuIDA7Cj4gICB9Cj4gICAKPiArI2lmIGRlZmluZWQo
Q09ORklHX05JVFJPX0VOQ0xBVkVTX01JU0NfVEVTVCkKPiArI2luY2x1ZGUgIm5lX21pc2NfdGVz
dC5jIgo+ICsKPiArc3RhdGljIGlubGluZSBpbnQgbmVfbWlzY190ZXN0X2luaXQodm9pZCkKPiAr
ewo+ICsJcmV0dXJuIF9fa3VuaXRfdGVzdF9zdWl0ZXNfaW5pdChuZV9taXNjX3Rlc3Rfc3VpdGVz
KTsKPiArfQo+ICsKPiArc3RhdGljIGlubGluZSB2b2lkIG5lX21pc2NfdGVzdF9leGl0KHZvaWQp
Cj4gK3sKPiArCV9fa3VuaXRfdGVzdF9zdWl0ZXNfZXhpdChuZV9taXNjX3Rlc3Rfc3VpdGVzKTsK
PiArfQo+ICsjZWxzZQo+ICtzdGF0aWMgaW5saW5lIGludCBuZV9taXNjX3Rlc3RfaW5pdCh2b2lk
KQo+ICt7Cj4gKwlyZXR1cm4gMDsKPiArfQo+ICsKPiArc3RhdGljIGlubGluZSB2b2lkIG5lX21p
c2NfdGVzdF9leGl0KHZvaWQpCj4gK3sKPiArfQo+ICsjZW5kaWYKCnMvbWlzYy9taXNjX2Rldi9n
CgpXaHkgYXJlIHRoZXNlIG5lZWRlZD8gQ2FuJ3QgdGhlIHRlc3Qgc3VpdGUgYmUgc2V0dXAgdXNp
bmcgCiJrdW5pdF90ZXN0X3N1aXRlIiBhcyBpbiB0aGUgS1VuaXQgZG9jdW1lbnRhdGlvbiBleGFt
cGxlIFsxXT8KCldvdWxkbid0IGJlIG5lY2Vzc2FyeSB0byBjb25kaXRpb25hbGx5IGNvbXBpbGUg
dGhlIG5lX21pc2NfZGV2X3Rlc3QsIApiYXNlZCBvbiB0aGUga2VybmVsIGNvbmZpZyBhYm92ZT8K
ClsxXSAKaHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2MvaHRtbC9sYXRlc3QvZGV2LXRvb2xzL2t1
bml0L3N0YXJ0Lmh0bWwjd3JpdGluZy15b3VyLWZpcnN0LXRlc3QKCj4gKwo+ICAgc3RhdGljIGlu
dCBfX2luaXQgbmVfaW5pdCh2b2lkKQo+ICAgewo+ICsJbmVfbWlzY190ZXN0X2luaXQoKTsKPiAr
Cj4gICAJbXV0ZXhfaW5pdCgmbmVfY3B1X3Bvb2wubXV0ZXgpOwo+ICAgCj4gICAJcmV0dXJuIHBj
aV9yZWdpc3Rlcl9kcml2ZXIoJm5lX3BjaV9kcml2ZXIpOwo+IEBAIC0xNzQ3LDYgKzE3NzIsOCBA
QCBzdGF0aWMgdm9pZCBfX2V4aXQgbmVfZXhpdCh2b2lkKQo+ICAgCXBjaV91bnJlZ2lzdGVyX2Ry
aXZlcigmbmVfcGNpX2RyaXZlcik7Cj4gICAKPiAgIAluZV90ZWFyZG93bl9jcHVfcG9vbCgpOwo+
ICsKPiArCW5lX21pc2NfdGVzdF9leGl0KCk7Cj4gICB9Cj4gICAKPiAgIG1vZHVsZV9pbml0KG5l
X2luaXQpOwo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnQvbml0cm9fZW5jbGF2ZXMvbmVfbWlz
Y190ZXN0LmMgYi9kcml2ZXJzL3ZpcnQvbml0cm9fZW5jbGF2ZXMvbmVfbWlzY190ZXN0LmMKPiBu
ZXcgZmlsZSBtb2RlIDEwMDY0NAo+IGluZGV4IDAwMDAwMDAuLjM0MjZjMzUKPiAtLS0gL2Rldi9u
dWxsCj4gKysrIGIvZHJpdmVycy92aXJ0L25pdHJvX2VuY2xhdmVzL25lX21pc2NfdGVzdC5jCj4g
QEAgLTAsMCArMSwxNyBAQAo+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1v
ci1sYXRlcgo+ICsKPiArI2luY2x1ZGUgPGt1bml0L3Rlc3QuaD4KPiArCj4gK3N0YXRpYyBzdHJ1
Y3Qga3VuaXRfY2FzZSBuZV9taXNjX3Rlc3RfY2FzZXNbXSA9IHsKPiArCXt9Cj4gK307Cj4gKwo+
ICtzdGF0aWMgc3RydWN0IGt1bml0X3N1aXRlIG5lX21pc2NfdGVzdF9zdWl0ZSA9IHsKPiArCS5u
YW1lID0gIm5lX21pc2NfdGVzdCIsCj4gKwkudGVzdF9jYXNlcyA9IG5lX21pc2NfdGVzdF9jYXNl
cywKPiArfTsKPiArCj4gK3N0YXRpYyBzdHJ1Y3Qga3VuaXRfc3VpdGUgKm5lX21pc2NfdGVzdF9z
dWl0ZXNbXSA9IHsKPiArCSZuZV9taXNjX3Rlc3Rfc3VpdGUsCj4gKwlOVUxMCj4gK307Cj4gCgpD
YW4gcmVwbGFjZSAibmVfbWlzYyIgd2l0aCAibmVfbWlzY19kZXYiLgoKVGhhbmtzLApBbmRyYQoK
CgpBbWF6b24gRGV2ZWxvcG1lbnQgQ2VudGVyIChSb21hbmlhKSBTLlIuTC4gcmVnaXN0ZXJlZCBv
ZmZpY2U6IDI3QSBTZi4gTGF6YXIgU3RyZWV0LCBVQkM1LCBmbG9vciAyLCBJYXNpLCBJYXNpIENv
dW50eSwgNzAwMDQ1LCBSb21hbmlhLiBSZWdpc3RlcmVkIGluIFJvbWFuaWEuIFJlZ2lzdHJhdGlv
biBudW1iZXIgSjIyLzI2MjEvMjAwNS4K

