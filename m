Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241374293C3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 17:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239047AbhJKPuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 11:50:01 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:60788 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbhJKPuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 11:50:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1633967281; x=1665503281;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Uz5SLdqqwf2jZFNHkseJdzUB9njPHV6Ut+HH+oA36ew=;
  b=Ne+lERBs2fDkBFpbzycIfOgYK3jL9GUFd0LySn7nbu/Njg7WVX6R6yWW
   ynf+kZO91F/i4mDdGael4Bnk86yoz5dDVKWo1fvhkEYRpx4Sa2mYKkBU7
   gf3EovNPZDv2Dv7zDLlTSCVwdgjWgdzYDw1mvHZD7AO8GtWkMmdP55U9m
   Q=;
X-IronPort-AV: E=Sophos;i="5.85,364,1624320000"; 
   d="scan'208";a="146857285"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-1c682de1.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP; 11 Oct 2021 15:47:38 +0000
Received: from EX13D16EUB003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1d-1c682de1.us-east-1.amazon.com (Postfix) with ESMTPS id ABD9AA0D42;
        Mon, 11 Oct 2021 15:47:35 +0000 (UTC)
Received: from [192.168.22.146] (10.43.162.148) by
 EX13D16EUB003.ant.amazon.com (10.43.166.99) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Mon, 11 Oct 2021 15:47:29 +0000
Message-ID: <d0b1f070-e706-e298-e2fe-9a893870edc1@amazon.com>
Date:   Mon, 11 Oct 2021 18:47:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.2
Subject: Re: [PATCH v3 0/4] Merge contiguous physical memory regions
Content-Language: en-US
To:     "Longpeng(Mike)" <longpeng2@huawei.com>
CC:     <arei.gonglei@huawei.com>, <gregkh@linuxfoundation.org>,
        <kamal@canonical.com>, <pbonzini@redhat.com>,
        <sgarzare@redhat.com>, <stefanha@redhat.com>,
        <vkuznets@redhat.com>, <linux-kernel@vger.kernel.org>,
        <ne-devel-upstream@amazon.com>, <lexnv@amazon.com>,
        <alcioa@amazon.com>
References: <20211009013248.1174-1-longpeng2@huawei.com>
From:   "Paraschiv, Andra-Irina" <andraprs@amazon.com>
In-Reply-To: <20211009013248.1174-1-longpeng2@huawei.com>
X-Originating-IP: [10.43.162.148]
X-ClientProxiedBy: EX13D14UWC004.ant.amazon.com (10.43.162.99) To
 EX13D16EUB003.ant.amazon.com (10.43.166.99)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpPbiAwOS8xMC8yMDIxIDA0OjMyLCBMb25ncGVuZyhNaWtlKSB3cm90ZToKPiBGcm9tOiBMb25n
cGVuZyA8bG9uZ3BlbmcyQGh1YXdlaS5jb20+Cj4gCj4gSGkgZ3V5cywKPiAKPiBUaGlzIHBhdGNo
c2V0IHRyeSB0byBtZXJnZSB0aGUgY29udGlndW91cyBwaHlzaWNhbCBtZW1vcnkgcmVnaW9ucyB3
aGVuCj4gc2V0IHVzZXIgbWVtb3J5IHJlZ2lvbnMsIHlvdSBjYW4gc2VlIG1lc3NhZ2UgaW4gUEFU
Q0ggMSBmb3IgZGV0YWlscy4KPiBQbGVhc2UgcmV2aWV3IHdoZW4geW91IGZyZWUsIHRoYW5rIQo+
IAo+IENoYW5nZXMgdjIgLT4gdjM6Cj4gICAgUGF0Y2ggMToKPiAgICAgIC0gdXBkYXRlIHRoZSBj
b21taXQgdGl0bGUgYW5kIGNvbW1pdCBtZXNzYWdlLiAgW0FuZHJhXQo+ICAgICAgLSB1c2UgJ3N0
cnVjdCByYW5nZScgdG8gaW5zdGVhZCBvZiAnc3RydWN0IHBoeXNfbWVtX3JlZ2lvbicuICBbQW5k
cmEsIEdyZWcgS0hdCj4gICAgICAtIGFkZCBjb21tZW50cyBiZWZvcmUgdGhlIGZ1bmN0aW9uIGRl
ZmluaXRpb24uICBbQW5kcmFdCj4gICAgICAtIHJlbmFtZSBzZXZlcmFsIHZhcmlhYmxlcywgcGFy
YW1ldGVycyBhbmQgZnVuY3Rpb24uICBbQW5kcmFdCj4gICAgUGF0Y2ggMjoKPiAgICAgIC0gdXBk
YXRlIHRoZSBjb21taXQgdGl0bGUgYW5kIGNvbW1pdCBtZXNzYWdlLiAgW0FuZHJhXQo+ICAgICAg
LSBhZGQgY29tbWVudHMgYmVmb3JlIHRoZSBmdW5jdGlvbiBkZWZpbml0aW9uLiAgW0FuZHJhXQo+
ICAgICAgLSByZW1vdmUgJ2lubGluZScgYXR0cmlidXRlIG9mIG5lX3Nhbml0eV9jaGVja19waHlz
X21lbV9yZWdpb24uIFtBbmRyYV0KPiAgICAgIC0gbGVhdmUgYSBibGFuayBsaW5lIGJlZm9yZSBy
ZXR1cm4uICBbQW5kcmFdCj4gICAgICAtIG1vdmUgc2FuaXR5IGNoZWNrIGluIG5lX21lcmdlX3Bo
eXNfY29udGlnX21lbW9yeV9yZWdpb25zIHRvCj4gICAgICAgIHRoZSBiZWdpbm5pbmcgb2YgdGhl
IGZ1bmN0aW9uLiAgW0FuZHJhXQo+ICAgICAgLSBkb3VibGUgc2FuaXR5IGNoZWNraW5nIGFmdGVy
IHRoZSBtZXJnZSBvZiBwaHlzaWNhbCBjb250aWd1b3VzCj4gICAgICAgIG1lbW9yeSByZWdpb25z
IGhhcyBiZWVuIGNvbXBsZXRlZC4gIFtBbmRyYV0KPiAgICBQYXRjaCAzOgo+ICAgICAgLSB1cGRh
dGUgdGhlIGNvbW1pdCB0aXRsZSBhbmQgY29tbWl0IG1lc3NhZ2UuICBbQW5kcmFdCj4gICAgICAt
IHVzZSAibWlzY19kZXYiLyJtaXNjIGRldmljZSIvIk1JU0NfREVWIiB0byBiZSBtb3JlIHNwZWNp
ZmljLiAgW0FuZHJhXQo+ICAgIFBhdGNoIDQ6Cj4gICAgICAtIHVwZGF0ZSB0aGUgY29tbWl0IHRp
dGxlIGFuZCBjb21taXQgbWVzc2FnZS4gIFtBbmRyYV0KPiAgICAgIC0gYWxpZ24gdGhlIGZpbGVk
cyBpbiAnc3RydWN0IHBoeXNfcmVnaW9uc190ZXN0Jy4gIFtBbmRyYV0KPiAgICAgIC0gcmVuYW1l
ICdwaHlzX3JlZ2lvbnNfdGVzdGNhc2VzJyB0byAncGh5c19yZWdpb25zX3Rlc3RfY2FzZXMnLiAg
W0FuZHJhXQo+ICAgICAgLSBhZGQgY29tbWVudHMgYmVmb3JlIGVhY2ggdGVzdCBjYXNlcy4gIFtB
bmRyYV0KPiAgICAgIC0gaW5pdGlhbGl6ZSB0aGUgdmFyaWFibGVzIGluIG5lX21pc2NfZGV2X3Rl
c3RfbWVyZ2VfcGh5c19jb250aWdfbWVtb3J5X3JlZ2lvbnMuICBbQW5kcmFdCj4gCj4gQ2hhbmdl
cyB2MSAtPiB2MjoKPiAgICAtIHVwZGF0ZSB0aGUgY29tbWl0IG1lc3NhZ2UgYXMgQW5kcmEncyBz
dWdnZXN0aW9uICBbQW5kcmFdCj4gICAgLSByZW1vdmUgVE9ETyBjb21wbGV0ZWx5IGluIG5lX3Nl
dF91c2VyX21lbW9yeV9yZWdpb25faW9jdGwgIFtBbmRyYV0KPiAgICAtIGV4dHJhY3QgdGhlIHBo
eXNpY2FsIG1lbW9yeSByZWdpb25zIHNldHVwIGludG8gaW5kaXZpZHVhbAo+ICAgICAgZnVuY3Rp
b24KPiAgICAtIGFkZCBrdW5pdCB0ZXN0cyAgW0FuZHJhXQo+IAo+IExvbmdwZW5nICg0KToKPiAg
ICBuaXRyb19lbmNsYXZlczogTWVyZ2UgY29udGlndW91cyBwaHlzaWNhbCBtZW1vcnkgcmVnaW9u
cwo+ICAgIG5pdHJvX2VuY2xhdmVzOiBTYW5pdHkgY2hlY2sgcGh5c2ljYWwgbWVtb3J5IHJlZ2lv
bnMgZHVyaW5nIG1lcmdpbmcKPiAgICBuaXRyb19lbmNsYXZlczogQWRkIEtVbml0IHRlc3RzIHNl
dHVwIGZvciB0aGUgbWlzYyBkZXZpY2UKPiAgICAgIGZ1bmN0aW9uYWxpdHkKPiAgICBuaXRyb19l
bmNsYXZlczogQWRkIEtVbml0IHRlc3RzIGZvciBjb250aWd1b3VzIHBoeXNpY2FsIG1lbW9yeSBy
ZWdpb25zCj4gICAgICBtZXJnaW5nCj4gCj4gICBkcml2ZXJzL3ZpcnQvbml0cm9fZW5jbGF2ZXMv
S2NvbmZpZyAgICAgICAgICAgIHwgICA5ICsrCj4gICBkcml2ZXJzL3ZpcnQvbml0cm9fZW5jbGF2
ZXMvbmVfbWlzY19kZXYuYyAgICAgIHwgMTYzICsrKysrKysrKysrKysrKysrKystLS0tLS0KPiAg
IGRyaXZlcnMvdmlydC9uaXRyb19lbmNsYXZlcy9uZV9taXNjX2Rldl90ZXN0LmMgfCAxNTMgKysr
KysrKysrKysrKysrKysrKysrKysKPiAgIDMgZmlsZXMgY2hhbmdlZCwgMjg1IGluc2VydGlvbnMo
KyksIDQwIGRlbGV0aW9ucygtKQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvdmlydC9u
aXRyb19lbmNsYXZlcy9uZV9taXNjX2Rldl90ZXN0LmMKPiAKClRoYW5rIHlvdS4gSSdsbCBnbyB0
aHJvdWdoIHRoZW0gdGlsbCB0aGUgZW5kIG9mIHRoaXMgd2Vlay4KCkFuZHJhCgoKCkFtYXpvbiBE
ZXZlbG9wbWVudCBDZW50ZXIgKFJvbWFuaWEpIFMuUi5MLiByZWdpc3RlcmVkIG9mZmljZTogMjdB
IFNmLiBMYXphciBTdHJlZXQsIFVCQzUsIGZsb29yIDIsIElhc2ksIElhc2kgQ291bnR5LCA3MDAw
NDUsIFJvbWFuaWEuIFJlZ2lzdGVyZWQgaW4gUm9tYW5pYS4gUmVnaXN0cmF0aW9uIG51bWJlciBK
MjIvMjYyMS8yMDA1Lgo=

