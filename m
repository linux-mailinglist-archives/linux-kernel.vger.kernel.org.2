Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C381339790A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 19:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234569AbhFAR3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 13:29:18 -0400
Received: from foss.arm.com ([217.140.110.172]:54946 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233925AbhFAR3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 13:29:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B8336D;
        Tue,  1 Jun 2021 10:27:35 -0700 (PDT)
Received: from [10.57.73.64] (unknown [10.57.73.64])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C82713F719;
        Tue,  1 Jun 2021 10:27:34 -0700 (PDT)
Subject: Re: [PATCH 3/4] iommu/amd: Do not sync on page size changes
To:     Nadav Amit <namit@vmware.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Jiajun Cao <caojiajun@vmware.com>
References: <20210502070001.1559127-1-namit@vmware.com>
 <20210502070001.1559127-5-namit@vmware.com>
 <f00bd0ce-e4a7-93c6-39ae-db19779b9331@arm.com>
 <F5D25BE7-FA34-4017-AA22-DDAB24F634BC@vmware.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <7e0b4b12-c68a-ff90-5d86-4ab88ddd7991@arm.com>
Date:   Tue, 1 Jun 2021 18:27:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <F5D25BE7-FA34-4017-AA22-DDAB24F634BC@vmware.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-01 17:39, Nadav Amit wrote:
> 
> 
>> On Jun 1, 2021, at 8:59 AM, Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 2021-05-02 07:59, Nadav Amit wrote:
>>> From: Nadav Amit <namit@vmware.com>
>>> Some IOMMU architectures perform invalidations regardless of the page
>>> size. In such architectures there is no need to sync when the page size
>>> changes or to regard pgsize when making interim flush in
>>> iommu_iotlb_gather_add_page().
>>> Add a "ignore_gather_pgsize" property for each IOMMU-ops to decide
>>> whether gather's pgsize is tracked and triggers a flush.
>>
>> I've objected before[1], and I'll readily object again ;)
>>
>> I still think it's very silly to add a bunch of indirection all over the place to make a helper function not do the main thing it's intended to help with. If you only need trivial address gathering then it's far simpler to just implement trivial address gathering. I suppose if you really want to you could factor out another helper to share the 5 lines of code which ended up in mtk-iommu (see commit f21ae3b10084).
> 
> Thanks, Robin.
> 
> I read your comments but I cannot fully understand the alternative that you propose, although I do understand your objection to the indirection “ignore_gather_pgsize”. Would it be ok if “ignore_gather_pgsize" was provided as an argument for iommu_iotlb_gather_add_page()?

No, I mean if iommu_iotlb_gather_add_page() doesn't have the behaviour 
your driver wants, just don't call it. Write or factor out a suitable 
helper that *does* do what you want and call that, or just implement the 
logic directly inline. Indirect argument or not, it just doesn't make 
much sense to have a helper function call which says "do this except 
don't do most of it".

> In general, I can live without this patch. It probably would have negligent impact on performance anyhow.

As I implied, it sounds like your needs are the same as the Mediatek 
driver had, so you could readily factor out a new page-size-agnostic 
gather helper from that. I fully support making the functional change to 
amd-iommu *somehow* - nobody likes unnecessary syncs - just not with 
this particular implementation :)

Robin.
