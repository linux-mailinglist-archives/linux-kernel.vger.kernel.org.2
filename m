Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB87444CB69
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 22:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbhKJVtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 16:49:18 -0500
Received: from smtp-fw-80006.amazon.com ([99.78.197.217]:57049 "EHLO
        smtp-fw-80006.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233324AbhKJVtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 16:49:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1636580789; x=1668116789;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ObcRssWUGBT6uTxMC9H60MuAaK2LYaXuqa2t/Q71n4k=;
  b=gdYxu+YTpOCmx9a7fvA6iF/YDg6iXFkHH7uVjej3keic0kJTbiBJzWQy
   u2PFPrfzpnYmYl3PQGIBySG12SZg5jxIZICaejXhJzGkXmbQ0IxOAqwsa
   6vD5eNVgCCgJwr47h3BZHP0KaQ3eqY88BYl6GYfTqiDcRJsxhDj0XAoQx
   4=;
X-IronPort-AV: E=Sophos;i="5.87,224,1631577600"; 
   d="scan'208";a="40583589"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-02ee77e7.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP; 10 Nov 2021 21:46:14 +0000
Received: from EX13D16EUB003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2b-02ee77e7.us-west-2.amazon.com (Postfix) with ESMTPS id 15E4041630;
        Wed, 10 Nov 2021 21:46:13 +0000 (UTC)
Received: from [192.168.22.233] (10.43.160.157) by
 EX13D16EUB003.ant.amazon.com (10.43.166.99) with Microsoft SMTP Server (TLS)
 id 15.0.1497.24; Wed, 10 Nov 2021 21:46:05 +0000
Message-ID: <4617b5db-cca4-fe00-4480-d72cf107ca76@amazon.com>
Date:   Wed, 10 Nov 2021 23:45:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [RFC] hypercall-vsock: add a new vsock transport
Content-Language: en-US
To:     Stefano Garzarella <sgarzare@redhat.com>,
        "Wang, Wei W" <wei.w.wang@intel.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "mst@redhat.com" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "kys@microsoft.com" <kys@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        Sergio Lopez Pascual <slp@redhat.com>
References: <71d7b0463629471e9d4887d7fcef1d8d@intel.com>
 <20211110111718.5cvt6vgory3fzqld@steredhat>
From:   "Paraschiv, Andra-Irina" <andraprs@amazon.com>
In-Reply-To: <20211110111718.5cvt6vgory3fzqld@steredhat>
X-Originating-IP: [10.43.160.157]
X-ClientProxiedBy: EX13D13UWA003.ant.amazon.com (10.43.160.181) To
 EX13D16EUB003.ant.amazon.com (10.43.166.99)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpPbiAxMC8xMS8yMDIxIDEzOjE3LCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6Cj4gCj4gT24g
V2VkLCBOb3YgMTAsIDIwMjEgYXQgMDc6MTI6MzZBTSArMDAwMCwgV2FuZywgV2VpIFcgd3JvdGU6
Cj4+IEhpLAo+Pgo+PiBXZSBwbGFuIHRvIGFkZCBhIG5ldyB2c29jayB0cmFuc3BvcnQgYmFzZWQg
b24gaHlwZXJjYWxsIChlLmcuIHZtY2FsbCAKPj4gb24gSW50ZWwgQ1BVcykuCj4+IEl0IHRyYW5z
cG9ydHMgQUZfVlNPQ0sgcGFja2V0cyBiZXR3ZWVuIHRoZSBndWVzdCBhbmQgaG9zdCwgd2hpY2gg
aXMgCj4+IHNpbWlsYXIgdG8KPj4gdmlydGlvLXZzb2NrLCB2bWNpLXZzb2NrIGFuZCBoeXBlcnYt
dnNvY2suCj4+Cj4+IENvbXBhcmVkIHRvIHRoZSBhYm92ZSBsaXN0ZWQgdnNvY2sgdHJhbnNwb3J0
cyB3aGljaCBhcmUgZGVzaWduZWQgZm9yIAo+PiBoaWdoIHBlcmZvcm1hbmNlLAo+PiB0aGUgbWFp
biBhZHZhbnRhZ2VzIG9mIGh5cGVyY2FsbC12c29jayBhcmU6Cj4+Cj4+IDEpwqDCoMKgwqDCoMKg
IEl0IGlzIFZNTSBhZ25vc3RpYy4gRm9yIGV4YW1wbGUsIG9uZSBndWVzdCB3b3JraW5nIG9uIAo+
PiBoeXBlcmNhbGwtdnNvY2sgY2FuIHJ1biBvbgo+Pgo+PiBlaXRoZXIgS1ZNLCBIeXBlcnYsIG9y
IFZNd2FyZS4KPj4KPj4gMinCoMKgwqDCoMKgwqAgSXQgaXMgc2ltcGxlci4gSXQgZG9lc24ndCBy
ZWx5IG9uIGFueSBjb21wbGV4IGJ1cyBlbnVtZXJhdGlvbgo+Pgo+PiAoZS5nLiB2aXJ0aW8tcGNp
IGJhc2VkIHZzb2NrIGRldmljZSBtYXkgbmVlZCB0aGUgd2hvbGUgaW1wbGVtZW50YXRpb24gCj4+
IG9mIFBDSSkuCj4+Cj4+IEFuIGV4YW1wbGUgdXNhZ2UgaXMgdGhlIGNvbW11bmljYXRpb24gYmV0
d2VlbiBNaWdURCBhbmQgaG9zdCAoUGFnZSA4IGF0Cj4+IGh0dHBzOi8vc3RhdGljLnNjaGVkLmNv
bS9ob3N0ZWRfZmlsZXMva3ZtZm9ydW0yMDIxL2VmL1REWCUyMExpdmUlMjBNaWdyYXRpb25fV2Vp
JTIwV2FuZy5wZGYpLiAKPj4KPj4gTWlnVEQgY29tbXVuaWNhdGVzIHRvIGhvc3QgdG8gYXNzaXN0
IHRoZSBtaWdyYXRpb24gb2YgdGhlIHRhcmdldCAodXNlcikKPj4gVEQuCj4+IE1pZ1REIGlzIHBh
cnQgb2YgdGhlIFRDQiwgc28gaXRzIGltcGxlbWVudGF0aW9uIGlzIGV4cGVjdGVkIHRvIGJlIGFz
IAo+PiBzaW1wbGUgYXMgcG9zc2libGUKPj4gKGUuZy4gYmFyZSBtZW50YWwgaW1wbGVtZW50YXRp
b24gd2l0aG91dCBPUywgbm8gUENJIGRyaXZlciBzdXBwb3J0KS4KClRoYW5rcyBmb3IgQ0MuIE1p
eGluZyBib3RoIHRocmVhZHMuCgogRnJvbSBTdGVmYW46CgoiCkFGX1ZTT0NLIGlzIGRlc2lnbmVk
IHRvIGFsbG93IG11bHRpcGxlIHRyYW5zcG9ydHMsIHNvIHdoeSBub3QuIFRoZXJlIGlzCmEgY29z
dCB0byBkZXZlbG9waW5nIGFuZCBtYWludGFpbmluZyBhIHZzb2NrIHRyYW5zcG9ydCB0aG91Z2gu
CgpJIHRoaW5rIEFtYXpvbiBOaXRybyBlbmNsYXZlcyB1c2UgdmlydGlvLXZzb2NrIGFuZCBJJ3Zl
IENDZWQgQW5kcmEgaW4KY2FzZSBzaGUgaGFzIHRob3VnaHRzIG9uIHRoZSBwcm9zL2NvbnMgYW5k
IGhvdyB0byBtaW5pbWl6ZSB0aGUgdHJ1c3RlZApjb21wdXRpbmcgYmFzZS4KCklmIHNpbXBsaWNp
dHkgaXMgdGhlIHRvcCBwcmlvcml0eSB0aGVuIFZJUlRJTydzIE1NSU8gdHJhbnNwb3J0IHdpdGhv
dXQKaW5kaXJlY3QgZGVzY3JpcHRvcnMgYW5kIHVzaW5nIHRoZSBwYWNrZWQgdmlydHF1ZXVlIGxh
eW91dCByZWR1Y2VzIHRoZQpzaXplIG9mIHRoZSBpbXBsZW1lbnRhdGlvbjoKaHR0cHM6Ly9kb2Nz
Lm9hc2lzLW9wZW4ub3JnL3ZpcnRpby92aXJ0aW8vdjEuMS9jczAxL3ZpcnRpby12MS4xLWNzMDEu
aHRtbCN4MS0xNDQwMDAyCgpTdGVmYW4KIgoKCk9uIHRoZSBOaXRybyBFbmNsYXZlcyBwcm9qZWN0
IHNpZGUsIHZpcnRpby1tbWlvIGlzIHVzZWQgZm9yIHRoZSB2c29jayAKZGV2aWNlIHNldHVwIGZv
ciB0aGUgZW5jbGF2ZS4gVGhhdCBoYXMgd29ya2VkIGZpbmUsIGl0IGhhcyBoZWxwZWQgdG8gCmhh
dmUgYW4gYWxyZWFkeSBhdmFpbGFibGUgaW1wbGVtZW50YXRpb24gKGUuZy4gdmlydGlvLW1taW8g
LyB2aXJ0aW8tcGNpKSAKZm9yIGFkb3B0aW9uIGFuZCBlYXNlIG9mIHVzZSBpbiBkaWZmZXJlbnQg
dHlwZXMgb2Ygc2V0dXBzIChlLmcuIGRpc3Ryb3MsIAprZXJuZWwgdmVyc2lvbnMpLgoKIEZyb20g
U3RlZmFubzoKCj4gCj4gQWRkaW5nIEFuZHJhIGFuZCBTZXJnaW8sIGJlY2F1c2UgSUlSQyBGaXJl
Y3JhY2tlciBhbmQgbGlia3J1biBlbXVsYXRlcwo+IHZpcnRpby12c29jayB3aXRoIHZpcnRpby1t
bWlvIHNvIHRoZSBpbXBsZW1lbnRhdGlvbiBzaG91bGQgYmUgc2ltcGxlIGFuZAo+IGFsc28gbm90
IGRpcmVjdGx5IHRpZWQgdG8gYSBzcGVjaWZpYyBWTU0uCj4gCj4gTWF5YmUgdGhpcyBmaXQgZm9y
IHlvdXIgdXNlIGNhc2UgdG9vLCBpbiB0aGlzIHdheSB3ZSBkb24ndCBoYXZlIHRvCj4gbWFpbnRh
aW4gYW5vdGhlciBkcml2ZXIuCj4gCj4gVGhhbmtzLAo+IFN0ZWZhbm8KPiAKCkluZGVlZCwgb24g
dGhlIEZpcmVjcmFja2VyIHNpZGUsIHRoZSB2c29jayBkZXZpY2UgaXMgc2V0dXAgdXNpbmcgCnZp
cnRpby1tbWlvIFsxXVsyXVszXS4gT25lIHNwZWNpZmljIHRoaW5nIGlzIHRoYXQgb24gdGhlIGhv
c3QsIGluc3RlYWQgCm9mIHVzaW5nIHZob3N0LCBBRl9VTklYIHNvY2tldHMgYXJlIHVzZWQgWzRd
LgoKVGhhbmtzLApBbmRyYQoKWzFdIApodHRwczovL2dpdGh1Yi5jb20vZmlyZWNyYWNrZXItbWlj
cm92bS9maXJlY3JhY2tlci9ibG9iL21haW4vc3JjL2RldmljZXMvc3JjL3ZpcnRpby92c29jay9t
b2QucnMjTDMwClsyXSAKaHR0cHM6Ly9naXRodWIuY29tL2ZpcmVjcmFja2VyLW1pY3Jvdm0vZmly
ZWNyYWNrZXIvYmxvYi9tYWluL3NyYy92bW0vc3JjL2J1aWxkZXIucnMjTDkzNgpbM10gCmh0dHBz
Oi8vZ2l0aHViLmNvbS9maXJlY3JhY2tlci1taWNyb3ZtL2ZpcmVjcmFja2VyL2Jsb2IvbWFpbi9z
cmMvdm1tL3NyYy9idWlsZGVyLnJzI0w4NTkKWzRdIApodHRwczovL2dpdGh1Yi5jb20vZmlyZWNy
YWNrZXItbWljcm92bS9maXJlY3JhY2tlci9ibG9iL21haW4vZG9jcy92c29jay5tZAoKCgpBbWF6
b24gRGV2ZWxvcG1lbnQgQ2VudGVyIChSb21hbmlhKSBTLlIuTC4gcmVnaXN0ZXJlZCBvZmZpY2U6
IDI3QSBTZi4gTGF6YXIgU3RyZWV0LCBVQkM1LCBmbG9vciAyLCBJYXNpLCBJYXNpIENvdW50eSwg
NzAwMDQ1LCBSb21hbmlhLiBSZWdpc3RlcmVkIGluIFJvbWFuaWEuIFJlZ2lzdHJhdGlvbiBudW1i
ZXIgSjIyLzI2MjEvMjAwNS4K

