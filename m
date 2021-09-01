Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7B863FE297
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 20:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244950AbhIAS4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 14:56:09 -0400
Received: from foss.arm.com ([217.140.110.172]:40728 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347104AbhIASy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 14:54:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E847F1063;
        Wed,  1 Sep 2021 11:53:30 -0700 (PDT)
Received: from [10.57.15.112] (unknown [10.57.15.112])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 623C13F694;
        Wed,  1 Sep 2021 11:53:29 -0700 (PDT)
Subject: Re: [PATCH v2 6/8] iommu: Move IOMMU pagesize check to attach_device
To:     Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc:     iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Alexander Graf <graf@amazon.com>,
        Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org
References: <20210828153642.19396-1-sven@svenpeter.dev>
 <20210828153642.19396-7-sven@svenpeter.dev> <YS6hl0gAOMoMxNhf@sunset>
 <adee671d-976a-4906-8592-c7391da9906b@www.fastmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <ede06b33-38ff-1ba2-c32c-c5bb3aaddb62@arm.com>
Date:   Wed, 1 Sep 2021 19:53:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <adee671d-976a-4906-8592-c7391da9906b@www.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-09-01 18:14, Sven Peter wrote:
> 
> 
> On Tue, Aug 31, 2021, at 23:39, Alyssa Rosenzweig wrote:
>>> +	if ((1 << __ffs(domain->pgsize_bitmap)) > PAGE_SIZE) {
>>
>> Not a fan of this construction. Could you assign `(1 <<
>> __ffs(domain->pgsize_bitmap))` to an appropriately named temporary (e.g
>> min_io_pgsize) so it's clearer what's going on?
> 
> Good point, will do that for the next version.

Or maybe just test "__ffs(domain->pgsize_bitmap) > PAGE_SHIFT", or 
perhaps even avoid shifts altogether with something like 
"domain->pgsize_bitmap & (PAGE_SIZE | PAGE_SIZE - 1)".

Robin.

> 
>>
>>> +		pr_warn("IOMMU page size cannot represent CPU pages.\n");
>>
>> "Represent" how?
>>
> 
> Looks like I dropped an "exactly" there when taking this line from iova.c :)
> 
> 
> 
> Thanks,
> 
> 
> Sven
> 
