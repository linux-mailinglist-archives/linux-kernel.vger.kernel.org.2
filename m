Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 250F43DDCAA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 17:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235250AbhHBPqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 11:46:55 -0400
Received: from foss.arm.com ([217.140.110.172]:37832 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234974AbhHBPqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 11:46:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0119311D4;
        Mon,  2 Aug 2021 08:46:45 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 074273F66F;
        Mon,  2 Aug 2021 08:46:43 -0700 (PDT)
Subject: Re: [Patch V2 0/2] iommu/arm-smmu: Fix races in iommu domain/group
 creation
To:     Will Deacon <will@kernel.org>, Ashish Mhetre <amhetre@nvidia.com>
Cc:     vdumpa@nvidia.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1623961837-12540-1-git-send-email-amhetre@nvidia.com>
 <20210802151607.GF28735@willie-the-truck>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <9c38c53c-c145-097a-4c7e-40f1c06a1f01@arm.com>
Date:   Mon, 2 Aug 2021 16:46:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210802151607.GF28735@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-02 16:16, Will Deacon wrote:
> On Fri, Jun 18, 2021 at 02:00:35AM +0530, Ashish Mhetre wrote:
>> Multiple iommu domains and iommu groups are getting created for the devices
>> sharing same SID. It is expected for devices sharing same SID to be in same
>> iommu group and same iommu domain.
>> This is leading to context faults when one device is accessing IOVA from
>> other device which shouldn't be the case for devices sharing same SID.
>> Fix this by protecting iommu domain and iommu group creation with mutexes.
> 
> Robin -- any chance you could take a look at these, please? You had some
> comments on the first version which convinced me that they are needed,
> but I couldn't tell whether you wanted to solve this a different way or not.

Sorry, I was lamenting that this came to light due to the 
of_iommu_configure() flow being yucky, but that wasn't meant to imply 
that there aren't - or couldn't be in future - better reasons for 
iommu_probe_device() to be robust against concurrency anyway. I do think 
these are legitimate fixes to make in their own right, even if the 
current need might get swept back under the rug in future.

I would say, however, that the commit messages seem to focus too much on 
the wrong details and aren't overly useful, and patch #2 is missing 
Ashish's sign-off.

Thanks,
Robin.
