Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0B23161E9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 10:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbhBJJRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 04:17:19 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:62483 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbhBJJOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 04:14:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1612948452; x=1644484452;
  h=to:cc:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding:subject;
  bh=04NIynoa/p0bYIjfkLz8VNDkF3qP7YQq7Yjflu2JPsY=;
  b=vda68wgb5JTaNWF2yUT4QC5Hko2i4Cxv/or0TZ5qUMdxU+7uka0G4REX
   8cNlm6BnJ4Kk+txl0S9mHlL9JjrYEsDGl/JjWi4a9MnbrXteMSURQVSur
   1UtDA3juhR3X5xSJM0v9Dp2BVtz11B3YwnKbxpChQuNiLenehjFIc6TTn
   o=;
X-IronPort-AV: E=Sophos;i="5.81,167,1610409600"; 
   d="scan'208";a="81286321"
Subject: Re: [PATCH v2] nvme: Add 48-bit DMA address quirk for Amazon NVMe controllers
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 10 Feb 2021 09:13:23 +0000
Received: from EX13MTAUEE002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com (Postfix) with ESMTPS id 7C57CA1838;
        Wed, 10 Feb 2021 09:13:21 +0000 (UTC)
Received: from EX13D08UEE001.ant.amazon.com (10.43.62.126) by
 EX13MTAUEE002.ant.amazon.com (10.43.62.24) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 10 Feb 2021 09:13:21 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D08UEE001.ant.amazon.com (10.43.62.126) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 10 Feb 2021 09:13:20 +0000
Received: from u2196cf9297dc59.ant.amazon.com (10.1.212.32) by
 mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 10 Feb 2021 09:13:18 +0000
To:     Christoph Hellwig <hch@lst.de>
CC:     <serebrin@amazon.com>, <dwmw@amazon.co.uk>, <benh@amazon.com>,
        <kbusch@kernel.org>, <axboe@fb.com>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20210203094338.19473-1-sironi@amazon.de>
 <20210210003942.25700-1-sironi@amazon.de> <20210210073759.GA23269@lst.de>
From:   Filippo Sironi <sironi@amazon.de>
Message-ID: <8a375a50-1aad-96c5-2743-f91120fbc6f9@amazon.de>
Date:   Wed, 10 Feb 2021 10:13:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210210073759.GA23269@lst.de>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi8xMC8yMSA4OjM3IEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPiAKPiBPbiBXZWQs
IEZlYiAxMCwgMjAyMSBhdCAwMTozOTo0MkFNICswMTAwLCBGaWxpcHBvIFNpcm9uaSB3cm90ZToK
Pj4gQW1hem9uIE5WTWUgY29udHJvbGxlcnMgZG8gbm90IHN1cHBvcnQgNjQtYml0IERNQSBhZGRy
ZXNzZXM7IHRoZXkgYXJlCj4+IGxpbWl0ZWQgdG8gNDgtYml0IERNQSBhZGRyZXNzZXMuICBMZXQn
cyBhZGQgYSBxdWlyayB0byBlbnN1cmUgdGhhdCB3ZQo+PiBtYWtlIHVzZSBvZiA0OC1iaXQgRE1B
IGFkZHJlc3NlcyB0byBhdm9pZCBtaXNiZWhhdmlvci4KPiAKPiBUaGlzIHNob3VsZCBwcm9iYWJs
eSBzYXkgc29tZSwgYW5kIG1lbnRpb24gdGhhdCB0aGV5IGRvIG5vdCBmb2xsb3cKPiB0aGUgc3Bl
Yy4gIEJ1dCBJIGNhbiBmaXggdGhpcyB1cCB3aGVuIGFwcGx5aW5nIHRoZSBwYXRjaC4KPiAKClRo
YW5rcyEKCkZpbGlwcG8KCgoKQW1hem9uIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgK
S3JhdXNlbnN0ci4gMzgKMTAxMTcgQmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0aWFu
IFNjaGxhZWdlciwgSm9uYXRoYW4gV2Vpc3MKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hh
cmxvdHRlbmJ1cmcgdW50ZXIgSFJCIDE0OTE3MyBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6IERFIDI4
OSAyMzcgODc5CgoK

