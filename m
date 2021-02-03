Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F409930D83F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 12:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbhBCLNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 06:13:36 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:10994 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233879AbhBCLNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 06:13:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1612350810; x=1643886810;
  h=to:cc:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding:subject;
  bh=BafQidahkXiub3U6Y+3Z6cbkXATtE2p3Hlpl71TTN7Q=;
  b=nV5hO2T6JySijhji7u0dZwRBq4ev0jRGgHHwK1jgnFWaKufMKesyhksx
   79S9hV7kFK5DkTy9QjIw9gW95TKlO2BhDHXfk2aZb3X418gm71asvAcug
   cTFiVNMDyFl0p5rhtfkzdCsUMHJ8hZ8dl4cGX4lXioJp8C+Aso85k7Gok
   4=;
X-IronPort-AV: E=Sophos;i="5.79,398,1602547200"; 
   d="scan'208";a="79396584"
Subject: Re: [PATCH] nvme: Add 48-bit DMA address quirk
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-af6a10df.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 03 Feb 2021 11:12:38 +0000
Received: from EX13MTAUEE001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1a-af6a10df.us-east-1.amazon.com (Postfix) with ESMTPS id A1913A1ECB;
        Wed,  3 Feb 2021 11:12:36 +0000 (UTC)
Received: from EX13D08UEE004.ant.amazon.com (10.43.62.182) by
 EX13MTAUEE001.ant.amazon.com (10.43.62.226) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 3 Feb 2021 11:12:35 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D08UEE004.ant.amazon.com (10.43.62.182) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 3 Feb 2021 11:12:35 +0000
Received: from u2196cf9297dc59.ant.amazon.com (10.1.212.5) by
 mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 3 Feb 2021 11:12:33 +0000
To:     Christoph Hellwig <hch@lst.de>
CC:     <serebrin@amazon.com>, <dwmw@amazon.co.uk>, <kbusch@kernel.org>,
        <axboe@fb.com>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20210203094338.19473-1-sironi@amazon.de>
 <20210203095148.GA8897@lst.de>
From:   Filippo Sironi <sironi@amazon.de>
Message-ID: <0c38f5eb-41ef-7934-940b-77b6e73c5239@amazon.de>
Date:   Wed, 3 Feb 2021 12:12:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210203095148.GA8897@lst.de>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ck9uIDIvMy8yMSAxMDo1MSBBTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4gCj4gT24gV2Vk
LCBGZWIgMDMsIDIwMjEgYXQgMTA6NDM6MzhBTSArMDEwMCwgRmlsaXBwbyBTaXJvbmkgd3JvdGU6
Cj4+IENlcnRhaW4gTlZNZSBjb250cm9sbGVycyBkb24ndCBzdXBwb3J0IDY0LWJpdCBETUEgYWRk
cmVzc2VzLiAgSW5zdGVhZCwKPj4gdGhleSBhcmUgbGltaXRlZCB0byA0OC1iaXQgRE1BIGFkZHJl
c3Nlcy4gIExldCdzIGFkZCBhIHF1aXJrIHRvIHVzZSB0aGVtCj4+IHByb3Blcmx5Lgo+IAo+IFdU
Rj8gIFRoaXMgaXMgc3VjaCBhIGdyYXZlIE5WTWUgc3BlYyBjb21waWFuY2UgYnVnIHRoYXQgSSBk
byBub3QgdGhpbmsKPiB3ZSBzaG91bGQgc3VwcG9ydCB0aGlzIGJ1Z2d5IG1lc3MgaW4gTGludXgu
Cj4gCgpJIGRvbid0IGRpc2FncmVlIG9uIHRoZSBmaXJzdCBwYXJ0IG9mIHlvdXIgc2VudGVuY2Us
IHRoaXMgaXMgYSBiaWcgCm92ZXJzaWdodC4KCk9uIHRoZSBvdGhlciBoYW5kLCB0aG9zZSBjb250
cm9sbGVycyBhcmUgb3V0IHRoZXJlIGFuZCBhcmUgaW4gdXNlIGJ5IGEgCmxvdCBvZiBjdXN0b21l
cnMuICBXZSBjYW4ga2VlcCByZWx5aW5nIG9uIGx1Y2ssIGhvcGluZyB0aGF0IGN1c3RvbWVycyAK
ZG9uJ3QgcnVuIGludG8gdHJvdWJsZXMgb3Igd2UgY2FuIG1lcmdlIGEgZmV3IGxpbmVzIG9mIGNv
ZGUgOikKCgoKQW1hem9uIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgKS3JhdXNlbnN0
ci4gMzgKMTAxMTcgQmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0aWFuIFNjaGxhZWdl
ciwgSm9uYXRoYW4gV2Vpc3MKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxvdHRlbmJ1
cmcgdW50ZXIgSFJCIDE0OTE3MyBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6IERFIDI4OSAyMzcgODc5
CgoK

