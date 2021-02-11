Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4CC319080
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 17:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbhBKQ7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 11:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbhBKPuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 10:50:52 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F31EC0613D6;
        Thu, 11 Feb 2021 07:50:11 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id 125381F45C38
Subject: Re: [PATCH RESEND v2 4/5] iommu/tegra-smmu: Rework
 tegra_smmu_probe_device()
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     will@kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
        jonathanh@nvidia.com, vdumpa@nvidia.com, thierry.reding@gmail.com,
        joro@8bytes.org, kernel@collabora.com,
        Dmitry Osipenko <digetx@gmail.com>,
        "kernelci-results@groups.io" <kernelci-results@groups.io>
References: <20201125101013.14953-1-nicoleotsuka@gmail.com>
 <20201125101013.14953-5-nicoleotsuka@gmail.com>
 <46a96cf9-91cc-2ad4-702a-e95ba7200375@collabora.com>
 <20210205052422.GA11329@Asurada-Nvidia>
 <20210205094556.GA32677@Asurada-Nvidia>
 <f45c94b4-2949-4eac-5944-85d43a8afef5@collabora.com>
 <20210210082052.GA11455@Asurada-Nvidia>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <df170d15-f5b5-4238-f998-5b8f8e45849a@collabora.com>
Date:   Thu, 11 Feb 2021 15:50:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210210082052.GA11455@Asurada-Nvidia>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2021 08:20, Nicolin Chen wrote:
> Hi Guillaume,
> 
> On Sat, Feb 06, 2021 at 01:40:13PM +0000, Guillaume Tucker wrote:
>>> It'd be nicer if I can get both logs of the vanilla kernel (failing)
>>> and the commit-reverted version (passing), each applying this patch.
>>
>> Sure, I've run 3 jobs:
>>
>> * v5.11-rc6 as a reference, to see the original issue:
>>   https://lava.collabora.co.uk/scheduler/job/3187848
>>
>> * + your debug patch:
>>   https://lava.collabora.co.uk/scheduler/job/3187849
>>
>> * + the "breaking" commit reverted, passing the tests:
>>   https://lava.collabora.co.uk/scheduler/job/3187851
> 
> Thanks for the help!
> 
> I am able to figure out what's probably wrong, yet not so sure
> about the best solution at this point.
> 
> Would it be possible for you to run one more time with another
> debugging patch? I'd like to see the same logs as previous:
> 1. Vanilla kernel + debug patch
> 2. Vanilla kernel + Reverted + debug patch

As it turns out, next-20210210 is passing all the tests again so
it looks like this got fixed in the meantime:

  https://lava.collabora.co.uk/scheduler/job/3210192
  https://lava.collabora.co.uk/results/3210192/0_igt-kms-tegra

And here's a more extensive list of IGT tests on next-20210211,
all the regressions have been fixed:

  https://kernelci.org/test/plan/id/60254c42f51df36be53abe62/


I haven't run a reversed bisection to find the fix, but I guess
it wouldn't be too hard to find out what happened by hand anyway.
I see the drm/tegra/for-5.12-rc1 tag has been merged into
linux-next, maybe that solved the issue?

FYI I've also run some jobs with your debug patch and with the
breaking patch reverted:

  https://lava.collabora.co.uk/scheduler/job/3210245
  https://lava.collabora.co.uk/scheduler/job/3210596

Meanwhile I'll see what can be done to improve the automated
bisection so if there are new IGT regressions they would get
reported earlier.  I guess it would have saved us all some time
if it had been bisected in December.

Thanks,
Guillaume
