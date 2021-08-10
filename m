Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 783063E4B23
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 19:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234723AbhHIRsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 13:48:45 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:10974 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234745AbhHIRsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 13:48:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1628531295; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=8guuvupjL6NqII3stb55gN3OwOOwh2DbzAjTfValqJY=;
 b=FiuKgcQII/ydK0gv8qAIKBfKpDq8LvMC/5opqclIFfOHuEmfW3nxqqGfKnkoFjpZji5eAimI
 T6LqbLNQam9f6TjeFY8gbh1y0lsB0Fv+F9VIKeJOrkPMFLZcAzyjqd6PJj/HCBH+58oaUtqY
 co3yr7EQ28YzV2C3smImq8xWtnw=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 61116a3fb3873958f5f1c3ad (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 09 Aug 2021 17:47:43
 GMT
Sender: saiprakash.ranjan=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 22C33C43149; Mon,  9 Aug 2021 17:47:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 33FD9C433F1;
        Mon,  9 Aug 2021 17:47:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 09 Aug 2021 23:17:40 +0530
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Will Deacon <will@kernel.org>, Rob Clark <robdclark@gmail.com>
Cc:     Georgi Djakov <djakov@kernel.org>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        David Airlie <airlied@linux.ie>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        "list@263.net:IOMMU DRIVERS , Joerg Roedel <joro@8bytes.org>," 
        <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sean Paul <sean@poorly.run>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Kristian H Kristensen <hoegsberg@google.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [Freedreno] [PATCH 0/3] iommu/drm/msm: Allow non-coherent masters
 to use system cache
In-Reply-To: <20210809174022.GA1840@willie-the-truck>
References: <20210728140052.GB22887@mms-0441>
 <8b2742c8891abe4fec3664730717a089@codeaurora.org>
 <20210802105544.GA27657@willie-the-truck>
 <CAF6AEGvtpFu8st=ZFNoKjP9YsAenciLxL1zMFi_iqMCvdby73w@mail.gmail.com>
 <20210802151409.GE28735@willie-the-truck>
 <CAF6AEGtzvyEUm0Fc8QT5t9KNK7i0FbFyi7zDM2_PMCzZBp7qbw@mail.gmail.com>
 <20210809145651.GC1458@willie-the-truck>
 <CAF6AEGsSUojA=V0n2iRWTCn++buqN=Eoxo0r3=+=PBu1O=H-AQ@mail.gmail.com>
 <20210809170508.GB1589@willie-the-truck>
 <CAF6AEGtmZ3LzAJdtnKDQDbEN-a6_JgdN-fZ96pkU3dZqkiW91g@mail.gmail.com>
 <20210809174022.GA1840@willie-the-truck>
Message-ID: <76bfd0b4248148dfbf9d174ddcb4c2a2@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-09 23:10, Will Deacon wrote:
> On Mon, Aug 09, 2021 at 10:18:21AM -0700, Rob Clark wrote:
>> On Mon, Aug 9, 2021 at 10:05 AM Will Deacon <will@kernel.org> wrote:
>> >
>> > On Mon, Aug 09, 2021 at 09:57:08AM -0700, Rob Clark wrote:
>> > > On Mon, Aug 9, 2021 at 7:56 AM Will Deacon <will@kernel.org> wrote:
>> > > > On Mon, Aug 02, 2021 at 06:36:04PM -0700, Rob Clark wrote:
>> > > > > On Mon, Aug 2, 2021 at 8:14 AM Will Deacon <will@kernel.org> wrote:
>> > > > > > On Mon, Aug 02, 2021 at 08:08:07AM -0700, Rob Clark wrote:
>> > > > > > > On Mon, Aug 2, 2021 at 3:55 AM Will Deacon <will@kernel.org> wrote:
>> > > > > > > > On Thu, Jul 29, 2021 at 10:08:22AM +0530, Sai Prakash Ranjan wrote:
>> > > > > > > > > On 2021-07-28 19:30, Georgi Djakov wrote:
>> > > > > > > > > > On Mon, Jan 11, 2021 at 07:45:02PM +0530, Sai Prakash Ranjan wrote:
>> > > > > > > > > > > commit ecd7274fb4cd ("iommu: Remove unused IOMMU_SYS_CACHE_ONLY flag")
>> > > > > > > > > > > removed unused IOMMU_SYS_CACHE_ONLY prot flag and along with it went
>> > > > > > > > > > > the memory type setting required for the non-coherent masters to use
>> > > > > > > > > > > system cache. Now that system cache support for GPU is added, we will
>> > > > > > > > > > > need to set the right PTE attribute for GPU buffers to be sys cached.
>> > > > > > > > > > > Without this, the system cache lines are not allocated for GPU.
>> > > > > > > > > > >
>> > > > > > > > > > > So the patches in this series introduces a new prot flag IOMMU_LLC,
>> > > > > > > > > > > renames IO_PGTABLE_QUIRK_ARM_OUTER_WBWA to IO_PGTABLE_QUIRK_PTW_LLC
>> > > > > > > > > > > and makes GPU the user of this protection flag.
>> > > > > > > > > >
>> > > > > > > > > > Thank you for the patchset! Are you planning to refresh it, as it does
>> > > > > > > > > > not apply anymore?
>> > > > > > > > > >
>> > > > > > > > >
>> > > > > > > > > I was waiting on Will's reply [1]. If there are no changes needed, then
>> > > > > > > > > I can repost the patch.
>> > > > > > > >
>> > > > > > > > I still think you need to handle the mismatched alias, no? You're adding
>> > > > > > > > a new memory type to the SMMU which doesn't exist on the CPU side. That
>> > > > > > > > can't be right.
>> > > > > > > >
>> > > > > > >
>> > > > > > > Just curious, and maybe this is a dumb question, but what is your
>> > > > > > > concern about mismatched aliases?  I mean the cache hierarchy on the
>> > > > > > > GPU device side (anything beyond the LLC) is pretty different and
>> > > > > > > doesn't really care about the smmu pgtable attributes..
>> > > > > >
>> > > > > > If the CPU accesses a shared buffer with different attributes to those which
>> > > > > > the device is using then you fall into the "mismatched memory attributes"
>> > > > > > part of the Arm architecture. It's reasonably unforgiving (you should go and
>> > > > > > read it) and in some cases can apply to speculative accesses as well, but
>> > > > > > the end result is typically loss of coherency.
>> > > > >
>> > > > > Ok, I might have a few other sections to read first to decipher the
>> > > > > terminology..
>> > > > >
>> > > > > But my understanding of LLC is that it looks just like system memory
>> > > > > to the CPU and GPU (I think that would make it "the point of
>> > > > > coherence" between the GPU and CPU?)  If that is true, shouldn't it be
>> > > > > invisible from the point of view of different CPU mapping options?
>> > > >
>> > > > You could certainly build a system where mismatched attributes don't cause
>> > > > loss of coherence, but as it's not guaranteed by the architecture and the
>> > > > changes proposed here affect APIs which are exposed across SoCs, then I
>> > > > don't think it helps much.
>> > > >
>> > >
>> > > Hmm, the description of the new mapping flag is that it applies only
>> > > to transparent outer level cache:
>> > >
>> > > +/*
>> > > + * Non-coherent masters can use this page protection flag to set cacheable
>> > > + * memory attributes for only a transparent outer level of cache, also known as
>> > > + * the last-level or system cache.
>> > > + */
>> > > +#define IOMMU_LLC      (1 << 6)
>> > >
>> > > But I suppose we could call it instead IOMMU_QCOM_LLC or something
>> > > like that to make it more clear that it is not necessarily something
>> > > that would work with a different outer level cache implementation?
>> >
>> > ... or we could just deal with the problem so that other people can reuse
>> > the code. I haven't really understood the reluctance to solve this properly.
>> >
>> > Am I missing some reason this isn't solvable?
>> 
>> Oh, was there another way to solve it (other than foregoing setting
>> INC_OCACHE in the pgtables)?  Maybe I misunderstood, is there a
>> corresponding setting on the MMU pgtables side of things?
> 
> Right -- we just need to program the CPU's MMU with the matching memory
> attributes! It's a bit more fiddly if you're just using ioremap_wc()
> though, as it's usually the DMA API which handles the attributes under 
> the
> hood.
> 
> Anyway, sorry, I should've said that explicitly earlier on. We've done 
> this
> sort of thing in the Android tree so I assumed Sai knew what needed to 
> be
> done and then I didn't think to explain to you :(
> 

Right I was aware of that but even in the android tree there is no user 
:)
I think we can't have a new memory type without any user right in 
upstream
like android tree?

@Rob, I think you  already tried adding a new MT and used 
pgprot_syscached()
in GPU driver but it was crashing?

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
