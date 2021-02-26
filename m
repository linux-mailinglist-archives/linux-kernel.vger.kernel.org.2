Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7815E3269AC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 22:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhBZVox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 16:44:53 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:52211 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229622AbhBZVow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 16:44:52 -0500
Received: from [192.168.0.5] (ip5f5aed0c.dynamic.kabel-deutschland.de [95.90.237.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 527DD20647910;
        Fri, 26 Feb 2021 22:44:09 +0100 (CET)
Subject: Re: [PATCH] iommu/amd: Fix event counter availability check
To:     Alexander Monakov <amonakov@ispras.ru>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        David Coe <david.coe@live.co.uk>,
        Joerg Roedel <joro@8bytes.org>,
        "Tj (Elloe Linux)" <ml.linux@elloe.vision>
References: <20200529200738.1923-1-amonakov@ispras.ru>
 <alpine.LNX.2.20.13.2005311014450.16067@monopod.intra.ispras.ru>
 <c0f9f676-eff8-572d-9174-4c22c6095a3d@linuxfoundation.org>
 <alpine.LNX.2.20.13.2006030935570.3181@monopod.intra.ispras.ru>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <4aba4c61-1878-3d4e-d52e-3ccac9715010@molgen.mpg.de>
Date:   Fri, 26 Feb 2021 22:44:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.20.13.2006030935570.3181@monopod.intra.ispras.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[cc: +suravee, +jörg]

Dear Alex, dear Shuah, dear Suravee, dear Jörg,


Am 03.06.20 um 08:54 schrieb Alexander Monakov:
> On Tue, 2 Jun 2020, Shuah Khan wrote:
> 
>> I changed the logic to read config to get max banks and counters
>> before checking if counters are writable and tried writing to all.
>> The result is the same and all of them aren't writable. However,
>> when disable the writable check and assume they are, I can run
> [snip]
> 
> This is similar to what I did. I also noticed that counters can
> be successfully used with perf if the initial check is ignored.
> I was considering sending a patch to remove the check and adjust
> the event counting logic to use counters as read-only, but after
> a bit more investigation I've noticed how late pci_enable_device
> is done, and came up with this patch. It's a path of less resistance:
> I'd expect maintainers to be more averse to removing the check
> rather than fixing it so it works as intended (even though I think
> the check should not be there in the first place).
> 
> However:
> 
> The ability to modify the counters is needed only for sampling the
> events (getting an interrupt when a counter overflows). There's no
> code to do that for these AMD IOMMU counters. A solution I would
> prefer is to not write to those counters at all. It would simplify or
> even remove a bunch of code. I can submit a corresponding patch if
> there's general agreement this path is ok.
> 
> What do you think?

I like this idea. Suravee, Jörg, what do you think?

Commit 6778ff5b21b (iommu/amd: Fix performance counter initialization) 
delays the boot up to 100 ms, which is over 20 % on fast systems, and 
also just a workaround, and does not seem to work always. The delay is 
also not mentioned in the commit message.


Kind regards,

Paul


[1]: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6778ff5b21bd8e78c8bd547fd66437cf2657fd9b
