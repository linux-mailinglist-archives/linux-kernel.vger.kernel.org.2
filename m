Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5E43DA904
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 18:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhG2Q3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 12:29:37 -0400
Received: from foss.arm.com ([217.140.110.172]:52372 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229565AbhG2Q3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 12:29:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EAFD81FB;
        Thu, 29 Jul 2021 09:29:32 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F63C3F73D;
        Thu, 29 Jul 2021 09:29:30 -0700 (PDT)
Subject: Re: [PATCH v2 00/24] iommu: Refactor DMA domain strictness
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>, joro@8bytes.org,
        will@kernel.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
        john.garry@huawei.com, dianders@chromium.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Yong Wu <yong.wu@mediatek.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Maxime Ripard <mripard@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <cover.1627468308.git.robin.murphy@arm.com>
 <2947762.k3LOHGUjKi@diego> <ade9f10e-836c-f29e-030b-23fe0a3187fb@arm.com>
 <2152676.3VsfAaAtOV@diego>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <ca9c5667-8f60-0d1c-6bca-323382e7a391@arm.com>
Date:   Thu, 29 Jul 2021 17:29:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <2152676.3VsfAaAtOV@diego>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-07-29 16:53, Heiko Stübner wrote:
> Am Donnerstag, 29. Juli 2021, 17:43:07 CEST schrieb Robin Murphy:
>> On 2021-07-29 16:04, Heiko Stübner wrote:
>>> Hi Robin,
>>>
>>> Am Mittwoch, 28. Juli 2021, 17:58:21 CEST schrieb Robin Murphy:
>>>> Hi all,
>>>>
>>>> Here's v2 where things start to look more realistic, hence the expanded
>>>> CC list. The patches are now based on the current iommu/core branch to
>>>> take John's iommu_set_dma_strict() cleanup into account.
>>>>
>>>> The series remiains in two (or possibly 3) logical parts - for people
>>>> CC'd on cookie cleanup patches, the later parts should not affect you
>>>> since your drivers don't implement non-strict mode anyway; the cleanup
>>>> is all pretty straightforward, but please do yell at me if I've managed
>>>> to let a silly mistake slip through and broken your driver.
>>>>
>>>> This time I have also build-tested x86 as well as arm64 :)
>>>
>>> TL;DR: arm64 yay, arm32 nay ;-)
>>
>> Cheers Heiko!
>>
>>> testcase:
>>> 5.14-rc3
>>> + iommu/next
>>> + patches 1+8 (the ones you cc'd me on)
>>>     iommu: Pull IOVA cookie management into the core
>>>     iommu/rockchip: Drop IOVA cookie management
>>>
>>> rk3399+hdmi (puma): boots with graphics
>>> rk3399+edp (kevin): boots with graphics
>>> px30+dsi (minievb): boots with graphics
>>>
>>> rk3288 (arm32, veyron-pinky): hangs when trying to start the rockchip-drm
>>> at some points the rest of the system recovers and fills the log with
>>>
>>> [   47.193776] [drm:drm_crtc_commit_wait] *ERROR* flip_done timed out
>>> [   47.193867] [drm:drm_atomic_helper_wait_for_dependencies] *ERROR* [PLANE:31:plane-0] commit wait timed out
>>> [   57.433743] [drm:drm_crtc_commit_wait] *ERROR* flip_done timed out
>>> [   57.433828] [drm:drm_atomic_helper_wait_for_dependencies] *ERROR* [PLANE:40:plane-4] commit wait timed out
>>>
>>> spews
>>>
>>> testcase 2:
>>> 5.14-rc3
>>> + iommu/next
>>>
>>> all works fine on both arm32+arm64
>>>
>>>
>>> That whole iommu voodoo is a bit over my head right now, so I'm not sure
>>> what to poke to diagnose this.
>>
>> Dang, this wasn't supposed to affect 32-bit Arm at all, since that
>> doesn't touch any of the default domain stuff either way. I have both my
>> RK3288 box (which IIRC doesn't currently boot) and an Odroid-U3 in the
>> "desk pile" right in front of me, so at worst I'll try bringing one of
>> those to life to see what silly thing I have indeed done to break 32-bit.
>>
>> I have a vague idea forming already, which suggests that it might get
>> better again once patch #12 is applied, but even if so there's no excuse
>> not to be bisectable, so I need to dig in and fix it - many thanks for
>> yelling as requested :D
> 
> That vague idea was actually quite correct, applying
> 	iommu/dma: Unexport IOVA cookie management
> on top of the the two patches makes my rk3288 boot correctly again
> and the display also works again.

Yup, since the !CONFIG_IOMMU_DMA stub for iommu_get_dma_cookie() returns 
-ENODEV, rather than the -ENOMEM that the temporary special case is 
expecting from the real function, it will inadvertently allow the 
default domain to be created (when it wasn't before). I still have no 
idea why that causes a problem though, since arm_iommu_attach_device() 
should end up kicking a default domain out of the way even if one does 
exist... :/

Either way I'll fix my bug - indeed it was an oversight that I hadn't 
considered which exact error code the stub "fails" with - to avoid the 
temporary change in behaviour, but I'll have to keep digging into the 
arch/arm code and rockchip-iommu to see if something's also off there.

Cheers,
Robin.
