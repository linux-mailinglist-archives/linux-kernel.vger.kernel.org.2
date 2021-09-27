Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B986418F9F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 09:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbhI0HCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 03:02:37 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:30123 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbhI0HCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 03:02:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1632726060; x=1664262060;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=exwg+DQW3mPYF7RYvTJWaREa8B5FVVCHy+LsCwyp0BQ=;
  b=VI6JV7OEjskKmc8GnnvgGwi1+eV3wYQgaAc3CMqZbWgX/2kg6bVGhnLv
   qXg1Mr8UeWJIm6LlEbFlT2CiCwl0y574gyV6xuCl8empJYX7HN5uDbHcp
   39uBbOeIZx0gul2y6G2IvfDIDHQCgRzEh2dtQDSRZVfLX6CR84E8EBT+H
   k=;
X-IronPort-AV: E=Sophos;i="5.85,325,1624320000"; 
   d="scan'208";a="150144983"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1box-d-0230bc7b.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP; 27 Sep 2021 07:00:51 +0000
Received: from EX13D16EUB003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1box-d-0230bc7b.us-east-1.amazon.com (Postfix) with ESMTPS id 24AE1C4CC6;
        Mon, 27 Sep 2021 07:00:47 +0000 (UTC)
Received: from [192.168.2.196] (10.43.161.199) by EX13D16EUB003.ant.amazon.com
 (10.43.166.99) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Mon, 27 Sep
 2021 07:00:41 +0000
Message-ID: <0ddefa29-d3c6-c328-1db4-98fab386423a@amazon.com>
Date:   Mon, 27 Sep 2021 10:00:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.0
Subject: Re: [PATCH v2 0/4] merge contiguous physical memory regions
Content-Language: en-US
To:     "Longpeng(Mike)" <longpeng2@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <arei.gonglei@huawei.com>,
        <gregkh@linuxfoundation.org>, <kamal@canonical.com>,
        <pbonzini@redhat.com>, <sgarzare@redhat.com>,
        <stefanha@redhat.com>, <vkuznets@redhat.com>,
        <ne-devel-upstream@amazon.com>, <lexnv@amazon.com>,
        <alcioa@amazon.com>
References: <20210921151039.1502-1-longpeng2@huawei.com>
From:   "Paraschiv, Andra-Irina" <andraprs@amazon.com>
In-Reply-To: <20210921151039.1502-1-longpeng2@huawei.com>
X-Originating-IP: [10.43.161.199]
X-ClientProxiedBy: EX13D41UWB004.ant.amazon.com (10.43.161.135) To
 EX13D16EUB003.ant.amazon.com (10.43.166.99)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpPbiAyMS8wOS8yMDIxIDE4OjEwLCBMb25ncGVuZyhNaWtlKSB3cm90ZToKPiAKPiBIaSBndXlz
LAo+IAo+IFRoaXMgcGF0Y2hzZXQgdHJ5IHRvIG1lcmdlIHRoZSBjb250aWd1b3VzIHBoeXNpY2Fs
IG1lbW9yeSByZWdpb25zIHdoZW4KPiBzZXQgdXNlciBtZW1vcnkgcmVnaW9ucywgeW91IGNhbiBz
ZWUgbWVzc2FnZSBpbiBQQVRDSCAxIGZvciBkZXRhaWxzLgo+IFBsZWFzZSByZXZpZXcgd2hlbiB5
b3UgZnJlZSwgdGhhbmshCj4gCj4gQ2hhbmdlcyB2MSAtPiB2MjoKPiAgICAtIHVwZGF0ZSB0aGUg
Y29tbWl0IG1lc3NhZ2UgYXMgQW5kcmEncyBzdWdnZXN0aW9uICBbQW5kcmFdCj4gICAgLSByZW1v
dmUgVE9ETyBjb21wbGV0ZWx5IGluIG5lX3NldF91c2VyX21lbW9yeV9yZWdpb25faW9jdGwgIFtB
bmRyYV0KPiAgICAtIGV4dHJhY3QgdGhlIHBoeXNpY2FsIG1lbW9yeSByZWdpb25zIHNldHVwIGlu
dG8gaW5kaXZpZHVhbAo+ICAgICAgZnVuY3Rpb24KPiAgICAtIGFkZCBrdW5pdCB0ZXN0cyAgW0Fu
ZHJhXQoKVGhhbmsgeW91IGZvciB0aGUgcGF0Y2ggc2VyaWVzLiBJJ2xsIHJldmlldyB0aGUgcGF0
Y2hlcyBkdXJpbmcgdGhpcyAKd2Vlay4gSSBoYWQgYSBjb3VwbGUgb2YgZGF5cyBvZmYuCgpUaGFu
a3MsCkFuZHJhCgo+IAo+IExvbmdwZW5nKE1pa2UpICg0KToKPiAgICBuaXRyb19lbmNsYXZlczog
bWVyZ2UgY29udGlndW91cyBwaHlzaWNhbCBtZW1vcnkgcmVnaW9ucwo+ICAgIG5pdHJvX2VuY2xh
dmVzOiBzYW5pdHkgY2hlY2sgdGhlIHBoeXNpY2FsIHJlZ2lvbiBkdXJpbmcgc2V0dGluZwo+ICAg
IG5pdHJvX2VuY2xhdmVzOiBhZGQgdGVzdCBmcmFtZXdvcmsgZm9yIHRoZSBtaXNjIGZ1bmN0aW9u
YWxpdHkKPiAgICBuaXRyb19lbmNsYXZlczogYWRkIGt1bml0IHRlc3RzIGZvciBwaHlzaWNhbCBj
b250aWd1b3VzIHJlZ2lvbiBtZXJnaW5nCj4gCj4gICBkcml2ZXJzL3ZpcnQvbml0cm9fZW5jbGF2
ZXMvS2NvbmZpZyAgICAgICAgfCAgIDggKysKPiAgIGRyaXZlcnMvdmlydC9uaXRyb19lbmNsYXZl
cy9uZV9taXNjX2Rldi5jICB8IDE2MCArKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLQo+ICAg
ZHJpdmVycy92aXJ0L25pdHJvX2VuY2xhdmVzL25lX21pc2NfdGVzdC5jIHwgIDYzICsrKysrKysr
KysrKwo+ICAgMyBmaWxlcyBjaGFuZ2VkLCAxODIgaW5zZXJ0aW9ucygrKSwgNDkgZGVsZXRpb25z
KC0pCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy92aXJ0L25pdHJvX2VuY2xhdmVzL25l
X21pc2NfdGVzdC5jCj4gCj4gLS0KPiAxLjguMy4xCj4gCgoKCkFtYXpvbiBEZXZlbG9wbWVudCBD
ZW50ZXIgKFJvbWFuaWEpIFMuUi5MLiByZWdpc3RlcmVkIG9mZmljZTogMjdBIFNmLiBMYXphciBT
dHJlZXQsIFVCQzUsIGZsb29yIDIsIElhc2ksIElhc2kgQ291bnR5LCA3MDAwNDUsIFJvbWFuaWEu
IFJlZ2lzdGVyZWQgaW4gUm9tYW5pYS4gUmVnaXN0cmF0aW9uIG51bWJlciBKMjIvMjYyMS8yMDA1
Lgo=

