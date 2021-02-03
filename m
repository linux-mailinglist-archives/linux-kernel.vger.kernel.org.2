Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE1A030D889
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 12:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbhBCLXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 06:23:52 -0500
Received: from smtp-fw-9103.amazon.com ([207.171.188.200]:40712 "EHLO
        smtp-fw-9103.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234218AbhBCLXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 06:23:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1612351404; x=1643887404;
  h=to:cc:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding:subject;
  bh=18cLPBSgASmoHqw1uCd93wj7L5Z/l3QTe+arYV9VCPw=;
  b=e6IwtyXC6AI3Uy9uIlEI8VIKI9ONgk56ua/9AIXy+2RaASWimUDBXSHW
   u44vYD6l2jjap3BXEbSG2+wdEAUN2UDfX9aYs2NuvTF0MzXMSWq3XlXEh
   u7WEOrqwUB1Ur9MZ46gUGyVnqDLa8qxZM2AoDEDx6z0YOjT+RN5ASZRco
   w=;
X-IronPort-AV: E=Sophos;i="5.79,398,1602547200"; 
   d="scan'208";a="915302612"
Subject: Re: [PATCH] nvme: Add 48-bit DMA address quirk
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-119b4f96.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9103.sea19.amazon.com with ESMTP; 03 Feb 2021 11:22:36 +0000
Received: from EX13MTAUEE002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2a-119b4f96.us-west-2.amazon.com (Postfix) with ESMTPS id CDCC91AADE7;
        Wed,  3 Feb 2021 11:22:35 +0000 (UTC)
Received: from EX13D08UEE001.ant.amazon.com (10.43.62.126) by
 EX13MTAUEE002.ant.amazon.com (10.43.62.24) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 3 Feb 2021 11:22:35 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D08UEE001.ant.amazon.com (10.43.62.126) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 3 Feb 2021 11:22:35 +0000
Received: from u2196cf9297dc59.ant.amazon.com (10.1.212.5) by
 mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 3 Feb 2021 11:22:33 +0000
To:     Christoph Hellwig <hch@lst.de>
CC:     <serebrin@amazon.com>, <dwmw@amazon.co.uk>, <kbusch@kernel.org>,
        <axboe@fb.com>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20210203094338.19473-1-sironi@amazon.de>
 <20210203095148.GA8897@lst.de>
 <0c38f5eb-41ef-7934-940b-77b6e73c5239@amazon.de>
 <20210203111548.GA11075@lst.de>
From:   Filippo Sironi <sironi@amazon.de>
Message-ID: <396b45d5-3dd5-8159-34c2-5668510d1d68@amazon.de>
Date:   Wed, 3 Feb 2021 12:22:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210203111548.GA11075@lst.de>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ck9uIDIvMy8yMSAxMjoxNSBQTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4gCj4gT24gV2Vk
LCBGZWIgMDMsIDIwMjEgYXQgMTI6MTI6MzFQTSArMDEwMCwgRmlsaXBwbyBTaXJvbmkgd3JvdGU6
Cj4+IEkgZG9uJ3QgZGlzYWdyZWUgb24gdGhlIGZpcnN0IHBhcnQgb2YgeW91ciBzZW50ZW5jZSwg
dGhpcyBpcyBhIGJpZwo+PiBvdmVyc2lnaHQuCj4gCj4gQnV0IGl0IGlzIG5vdCB3aGF0IHlvdXIg
Y29tbWl0IGxvZyBzdWdnZXN0cy4KCkkgY2FuIGRlZmluaXRlbHkgcmVwaHJhc2UgdGhlIGNvbW1p
dC4KCj4+IE9uIHRoZSBvdGhlciBoYW5kLCB0aG9zZSBjb250cm9sbGVycyBhcmUgb3V0IHRoZXJl
IGFuZCBhcmUgaW4gdXNlIGJ5IGEgbG90Cj4+IG9mIGN1c3RvbWVycy4gIFdlIGNhbiBrZWVwIHJl
bHlpbmcgb24gbHVjaywgaG9waW5nIHRoYXQgY3VzdG9tZXJzIGRvbid0IHJ1bgo+PiBpbnRvIHRy
b3VibGVzIG9yIHdlIGNhbiBtZXJnZSBhIGZldyBsaW5lcyBvZiBjb2RlIDopCj4gCj4gWW91ciBw
YXRjaCBkb2VzIG5vdCBqdXN0IHF1aXJrIGEgZmV3IGNvbnRyb2xsZXJzIG91dCB0aGVyZSwgYnV0
IGFsbAo+IGN1cnJlbnQgYW5kIGZ1dHVyZSBjb250cm9sbGVycyB3aXRoIGFuIEFtYXpvbiB2ZW5k
b3IgSUQuICBXZSBjb3VsZAo+IHByb2JhYmx5IHRhbGsgYWJvdXQgcXVpcmtpbmcgYW4gZXhpc3Rp
bmcgdmVuZG9yIElEIG9yIHR3byBhcyBsb25nIGFzCj4gdGhpcyBkb2Vzbid0IGhhcHBlbiBmb3Ig
ZnV0dXJlIGhhcmR3YXJlLgoKSSBrbm93IHRoYXQgdGhlIGhhcmR3YXJlIHRlYW0gaXMgd29ya2lu
ZyBvbiB0aGlzIGJ1dCBJIGRvbid0IGtub3cgdGhlIAp0aW1lbGluZXMgYW5kIHRoZXJlIGFyZSBh
IGZldyB1cGNvbWluZyBjb250cm9sbGVycyAtIG9mIHdoaWNoIEkgZG9uJ3QgCmtub3cgdGhlIGRl
dmljZSBpZHMgeWV0IC0gdGhhdCBoYXZlIHRoZSBzYW1lIGlzc3VlLgoKVG8gYXZvaWQgaXNzdWVz
LCBpdCBpcyBlYXNpZXIgdG8gYXBwbHkgdGhlIHF1aXJrIHRvIGFsbCBBbWF6b24gTlZNZSAKY29u
dHJvbGxlcnMgZm9yIG5vdyB0aWxsIHRoZSBuZXcgbGluZXMgb2YgY29udHJvbGxlcnMgd2l0aCB0
aGUgZml4IGNvbWVzIApvdXQuICBBdCB0aGF0IHBvaW50LCB3ZSdsbCBiZSBhYmxlIHRvIHJlc3Ry
aWN0IHRoZSBhcHBsaWNhdGlvbiB0byB0aGUgCmtub3duIGJhZCBjb250cm9sbGVycy4KCgoKQW1h
em9uIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgKS3JhdXNlbnN0ci4gMzgKMTAxMTcg
QmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0aWFuIFNjaGxhZWdlciwgSm9uYXRoYW4g
V2Vpc3MKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxvdHRlbmJ1cmcgdW50ZXIgSFJC
IDE0OTE3MyBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6IERFIDI4OSAyMzcgODc5CgoK

