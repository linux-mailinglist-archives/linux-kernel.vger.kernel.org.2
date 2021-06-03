Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E91DF3997DA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 04:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhFCCFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 22:05:35 -0400
Received: from mga07.intel.com ([134.134.136.100]:49736 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229541AbhFCCFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 22:05:33 -0400
IronPort-SDR: gXksGlg6wMZ38k/R14iVqL83/0bn14pWy1jWMYxxOFZQkpjOzf6CdPgEcto/iAJ40OjfYcZcqq
 p5NJLm1jVRWg==
X-IronPort-AV: E=McAfee;i="6200,9189,10003"; a="267812276"
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="scan'208";a="267812276"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 19:03:49 -0700
IronPort-SDR: 3l4OYGXTPqbxSxOvUGo09jcOcihVNH59aPcFpeSbajzoXQVVvKgjW1rvBE9b2XrPPmhaLf+Wnv
 PHYqc7c/f80A==
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="scan'208";a="550521295"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.87.193]) ([10.209.87.193])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 19:03:48 -0700
Subject: Re: [PATCH v1 5/8] dma: Use size for swiotlb boundary checks
To:     Konrad Rzeszutek Wilk <konrad@darnok.org>
Cc:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        iommu@lists.linux-foundation.org, x86@kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org
References: <20210603004133.4079390-1-ak@linux.intel.com>
 <20210603004133.4079390-6-ak@linux.intel.com>
 <YLg096ycQ60lcuHe@localhost.localdomain>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <665925d2-d6d5-218f-15f8-c6c5abaaba40@linux.intel.com>
Date:   Wed, 2 Jun 2021 19:03:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YLg096ycQ60lcuHe@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/2/2021 6:48 PM, Konrad Rzeszutek Wilk wrote:
> On Wed, Jun 02, 2021 at 05:41:30PM -0700, Andi Kleen wrote:
>> swiotlb currently only uses the start address of a DMA to check if something
>> is in the swiotlb or not. But with virtio and untrusted hosts the host
>> could give some DMA mapping that crosses the swiotlb boundaries,
>> potentially leaking or corrupting data. Add size checks to all the swiotlb
>> checks and reject any DMAs that cross the swiotlb buffer boundaries.
> I seem to be only CC-ed on this and #7, so please bear with me.
You weren't cc'ed originally so if you get partial emails it must be 
through some list.
>
> But could you explain to me why please:
>
> commit daf9514fd5eb098d7d6f3a1247cb8cc48fc94155 (swiotlb/stable/for-linus-5.12)
> Author: Martin Radev <martin.b.radev@gmail.com>
> Date:   Tue Jan 12 16:07:29 2021 +0100
>
>      swiotlb: Validate bounce size in the sync/unmap path
>
> does not solve the problem as well?

Thanks. I missed that patch, race condition.

One major difference of my patch is that it supports an error return, 
which allows virtio to error out. This is important in virtio because 
otherwise you'll end up with uninitialized memory on the target without 
any indication. This uninitialized memory could be an potential attack 
vector on the guest memory, e.g. if the attacker finds some way to echo 
it out again.

But the error return could be added to your infrastructure too and what 
would make this patch much shorter. I'll take a look at that.

-Andi





