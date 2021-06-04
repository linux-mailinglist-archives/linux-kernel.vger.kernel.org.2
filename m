Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11E6939BEE7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 19:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhFDRhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 13:37:11 -0400
Received: from foss.arm.com ([217.140.110.172]:44538 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229690AbhFDRhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 13:37:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2BFC21063;
        Fri,  4 Jun 2021 10:35:24 -0700 (PDT)
Received: from [10.57.6.115] (unknown [10.57.6.115])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 74ADE3F73D;
        Fri,  4 Jun 2021 10:35:23 -0700 (PDT)
Subject: Re: [PATCH] iommu/amd: Tidy up DMA ops init
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jussi Maki <joamaki@gmail.com>
References: <665db61e23ff8d54ac5eb391bef520b3a803fcb9.1622727974.git.robin.murphy@arm.com>
 <YLpGHx+rYnBF64Yh@8bytes.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <781da5b3-4856-9a76-d803-51800dec6033@arm.com>
Date:   Fri, 4 Jun 2021 18:35:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YLpGHx+rYnBF64Yh@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-04 16:26, Joerg Roedel wrote:
> On Thu, Jun 03, 2021 at 02:48:21PM +0100, Robin Murphy wrote:
>> As discussed on the report thread, I think it makes most sense to merge
>> this as a fix for 5.13 and not worry about any backporting.
>>
>>   drivers/iommu/amd/amd_iommu.h |  2 --
>>   drivers/iommu/amd/init.c      |  5 -----
>>   drivers/iommu/amd/iommu.c     | 31 +++++++++++++------------------
>>   3 files changed, 13 insertions(+), 25 deletions(-)
> 
> Applied for v5.13, thanks Robin et al for the quick work on this
> regression.
> 
> Robin, do you by chance have a Fixes tag which I can add?

For the sake of justifying this as "fix" rather than "cleanup", you may 
as well use the flush queue commit cited in the patch log - I maintain 
there's nothing technically wrong with that commit itself, but it is the 
point at which the underlying issue becomes worth fixing due to how they 
interact ;)

Cheers,
Robin.
