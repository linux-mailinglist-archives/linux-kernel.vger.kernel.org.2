Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4CD401A5F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 13:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239463AbhIFLHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 07:07:14 -0400
Received: from foss.arm.com ([217.140.110.172]:54986 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231511AbhIFLHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 07:07:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF6486D;
        Mon,  6 Sep 2021 04:06:08 -0700 (PDT)
Received: from [10.57.15.112] (unknown [10.57.15.112])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E01D03F73D;
        Mon,  6 Sep 2021 04:06:07 -0700 (PDT)
Subject: Re: [git pull] IOMMU Updates for Linux v5.15
To:     Joerg Roedel <joro@8bytes.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     iommu <iommu@lists.linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <YTIrHxWNzIwuseXO@8bytes.org>
 <CAHk-=wjTpYOsRPm4T2EV=Sxm52buZrMpRdwSDeedCSF4jh=M1w@mail.gmail.com>
 <YTKXLjwkD3Kn8VUz@8bytes.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <11f8773b-1440-a94a-220b-9f994241d0b4@arm.com>
Date:   Mon, 6 Sep 2021 12:06:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YTKXLjwkD3Kn8VUz@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-09-03 22:44, Joerg Roedel wrote:
> On Fri, Sep 03, 2021 at 11:43:31AM -0700, Linus Torvalds wrote:
>>    choice
>>          prompt "IOMMU default domain type"
>>          depends on IOMMU_API
>>          default IOMMU_DEFAULT_DMA_LAZY if AMD_IOMMU || INTEL_IOMMU
>>          default IOMMU_DEFAULT_DMA_STRICT
> 
> Huh, yeah, that is bogus. Seems like I overlooked that part of the
> patch-set because I was so amazed by the simplifications and cleanups in
> the rest of it.

Mad as it looks, this does in fact capture the existing behaviour. What 
we've consolidated here was previously a weird mix of driver- and 
subsystem-level controls, and it is specifically those two drivers which 
have a long-standing expectation of using lazy behaviour by default.

>> See what I'm saying? Making the default be based on some random "this
>> driver is enabled" when it can then affect *other* drivers that are
>> also enabled and not part of the decision seems to be a fundamental
>> confusion about what is going on, when it's not at all clear which
>> driver will actually be IN USE.
> 
> The Kconfig option itself was actually my suggestion, but how the
> default value is chosen certainly needs improvement. I will sort this
> out with the people involved.
> 
>> IOW, the fix might be to just say "the default is always lazy".
>>
>> Or the fix might be something that is global to a configuration and
>> doesn't rely on which iommu is in use (eg "on x86, the default is
>> always LAZY")

We could certainly express it as "default IOMMU_DEFAULT_DMA_LAZY if X86" 
if people would prefer - virtio-iommu doesn't support lazy mode either 
way, so the end result will still be equivalent.

Robin.

>> Or the fix is to make that 'iommu_dma_strict' variable - and the
>> default value for it - be a per-IOMMU thing rather than be a global.
> 
> My preference would be to make 'lazy' or 'strict' the default for all,
> but the ARM folks might disagree. On the other side it also doesn't make
> sense to let IOMMU drivers override the users Kconfig choice at runtime.
> We will discuss this and come up with something better. >
> Thanks,
> 
> 	Joerg
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
