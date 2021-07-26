Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC803D5928
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 14:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233878AbhGZL0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 07:26:21 -0400
Received: from foss.arm.com ([217.140.110.172]:50934 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233738AbhGZL0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 07:26:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AADC631B;
        Mon, 26 Jul 2021 05:06:48 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F3BD3F70D;
        Mon, 26 Jul 2021 05:06:47 -0700 (PDT)
Subject: Re: [PATCH 00/23] iommu: Refactor DMA domain strictness
To:     John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will@kernel.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
        dianders@chromium.org
References: <cover.1626888444.git.robin.murphy@arm.com>
 <8e9da41e-4e3a-7098-bece-7f6cba89a2aa@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <519d4a00-a251-3437-6c3e-6ee3e75bf64c@arm.com>
Date:   Mon, 26 Jul 2021 13:06:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <8e9da41e-4e3a-7098-bece-7f6cba89a2aa@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-07-26 09:13, John Garry wrote:
> On 21/07/2021 19:20, Robin Murphy wrote:
>> Hi all,
>>
>> First off, yes, this conflicts with just about everything else
>> currently in-flight. Sorry about that. If it stands up to initial review
>> then I'll start giving some thought to how to fit everything together
>> (particularly John's cleanup of strictness defaults, which I'd be
>> inclined to fold into a v2 of this series).
> 
> It seems to me that patch #20 is the only real conflict, and that is 
> just a different form of mine in that passthrough, strict, and lazy are 
> under a single choice, as opposed to passthrough being a separate config 
> (for mine). And on that point, I did assume that we would have a 
> different sysfs file for strict vs lazy in this series, and not a new 
> domain type. But I assume that there is a good reason for that.

Yes, as mentioned by patch #18 it helps a surprising number of things 
fall into place really neatly.

> Anyway, I'd really like to see my series just merged now.

Sure, I was going to say I can happily rebase on top of your series 
as-is if Joerg wants to apply it first, and now that's just happened :)

Cheers,
Robin.
