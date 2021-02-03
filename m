Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F144C30DA22
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 13:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbhBCMsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 07:48:33 -0500
Received: from smtp-fw-9103.amazon.com ([207.171.188.200]:5210 "EHLO
        smtp-fw-9103.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbhBCMpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 07:45:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1612356314; x=1643892314;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JlqT0iY4SMHZ8h4y0c1Zzk0bHiFhUm38Yn3c9enjTFQ=;
  b=ugmN2wALhS6asTCpzbS0ioFBYr+EGiaC5xRS6LpG2RTPYRCyQec9o2UU
   fgtW/A4bmt8rsJiyy7ldOi5Q2DM3kdm5ek7T1d9rLCKninT0Bg6gXuQ+P
   v1mvfab8PQ+d4Tw6U4Rq7KgI/j7PWU8HU/Fh/RILOMPo+yMnQ+H/dBqu1
   s=;
X-IronPort-AV: E=Sophos;i="5.79,398,1602547200"; 
   d="scan'208";a="915324724"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-af6a10df.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9103.sea19.amazon.com with ESMTP; 03 Feb 2021 12:44:19 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1a-af6a10df.us-east-1.amazon.com (Postfix) with ESMTPS id C1510A2243;
        Wed,  3 Feb 2021 12:44:14 +0000 (UTC)
Received: from EX13D07UWB004.ant.amazon.com (10.43.161.196) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 3 Feb 2021 12:44:14 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D07UWB004.ant.amazon.com (10.43.161.196) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 3 Feb 2021 12:44:13 +0000
Received: from 8c85908914bf.ant.amazon.com (10.1.212.23) by
 mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Wed, 3 Feb 2021 12:44:09 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     <jgg@ziepe.ca>
CC:     <aarcange@redhat.com>, <akpm@linux-foundation.org>,
        <gokhale2@llnl.gov>, <hch@lst.de>, <jack@suse.cz>,
        <jannh@google.com>, <jhubbard@nvidia.com>, <kirill@shutemov.name>,
        <ktkhai@virtuozzo.com>, <leonro@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <mcfadden8@llnl.gov>, <oleg@redhat.com>, <peterx@redhat.com>,
        <torvalds@linux-foundation.org>, <wzam@amazon.com>,
        <yang.shi@linux.alibaba.com>
Subject: Re: [PATCH 1/4] mm: Trial do_wp_page() simplification
Date:   Wed, 3 Feb 2021 14:43:58 +0200
Message-ID: <20210203124358.59017-1-galpress@amazon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210202171327.GN4718@ziepe.ca>
References: <20210202171327.GN4718@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Feb 02, 2021 at 12:05:36PM -0500, Peter Xu wrote:
> 
>> > Gal, you could also MADV_DONTFORK this range if you are explicitly
>> > allocating them via special mmap.
>> 
>> Yeah I wanted to mention this one too but I just forgot when reply: the issue
>> thread previously pasted smells like some people would like to drop
>> MADV_DONTFORK, but if it's able to still be applied I don't know why
>> not..
> 
> I want to drop the MADV_DONTFORK for dynamic data memory allocated by
> the application layers (eg with malloc) without knowledge of how they
> will be used.
> 
> This case is a buffer internal to the communication system that we
> know at allocation time how it will be used; so an explicit,
> deliberate, MADV_DONTFORK is fine

We are referring to libfabric's bounce buffers, correct?
Libfabric could be considered as the "app" here, it's not clear why these
buffers should be DONTFORK'd before ibv_reg_mr() but others don't.

Anyway, it should be simple enough to madvise them after allocation, although I
think it's part of libfabric's generic code (which isn't necessarily used on
top of rdma-core).

I'll take this discussion with the libfabric guys.
Thanks Peter and Jason.
