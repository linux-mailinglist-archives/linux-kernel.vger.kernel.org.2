Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB8ED3E462C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 15:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235018AbhHINJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 09:09:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:51566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234597AbhHINJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 09:09:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0BE6E60EC0;
        Mon,  9 Aug 2021 13:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628514563;
        bh=c6YJj4mhhNAXx6eVWt/9O44DDuMRQSozD29Cp4nkeC4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dFUthAbq5qF7TRptNmUkrRcgE3Pm/TgwlG5vaCI/Ih4nOb914rc2Bq7Gr9nus0F8/
         Vsa6CRs0lYZSkOP9/cr4LkgbhSuVGenhJwpPSL7P2PaET/jZr7ZHKDhDihvmLtxQDc
         s9TJwQeB4dhkYTlAmkI9sJ3tMFKGKQabR2B3WVd25EP1h1RJq2dnn29Q+xNHxqc9i8
         nXswAkf6pI0o8d0y/fWall3OsWwIywpekINKrCHLjLruXzjGu1X0TBO9T9nbENsCZJ
         R+N2mE4pZfJGPXm1KU6tzZPY/5bXitA5fG8vCUna4bQwd/FOr8dvIAeZ/EGqSoHRzv
         D2cYdhCIQBTXQ==
Date:   Mon, 9 Aug 2021 14:09:17 +0100
From:   Will Deacon <will@kernel.org>
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "julien.thierry.kdev@gmail.com" <julien.thierry.kdev@gmail.com>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "Alexandru.Elisei@arm.com" <Alexandru.Elisei@arm.com>,
        "qperret@google.com" <qperret@google.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v3 4/4] KVM: arm64: Clear active_vmids on vCPU schedule
 out
Message-ID: <20210809130917.GA1207@willie-the-truck>
References: <20210729104009.382-1-shameerali.kolothum.thodi@huawei.com>
 <20210729104009.382-5-shameerali.kolothum.thodi@huawei.com>
 <20210803114034.GB30853@willie-the-truck>
 <ee2863107d614ef8a36006b5aa912eca@huawei.com>
 <20210803153036.GA31125@willie-the-truck>
 <b2146ea5db47485f8410a4c1ab0c15fe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2146ea5db47485f8410a4c1ab0c15fe@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2021 at 12:24:36PM +0000, Shameerali Kolothum Thodi wrote:
> These are some test numbers with and without this patch, run on two
> different test setups.
> 
> 
> a)Test Setup -1
> -----------------------
> 
> Platform: HiSilicon D06 with 128 CPUs, VMID bits = 16
> Run 128 VMs concurrently each with 2 vCPUs. Each Guest will execute hackbench
> 5 times before exiting.
> 
> Measurements taken avg. of 10 Runs.
> 
> Image : 5.14-rc3
> ---------------------------
>   Time(s)       44.43813888
>   No. of exits    145,348,264
> 
> Image: 5.14-rc3 + vmid-v3
> ----------------------------------------
>   Time(s)        46.59789034
>   No. of exits     133,587,307
> 
> %diff against 5.14-rc3
>   Time: 4.8% more
>   Exits: 8% less 
> 
> Image: 5.14-rc3 + vmid-v3 + Without active_asid clear
> ---------------------------------------------------------------------------
>   Time(s)         44.5031782
>   No. of exits      144,443,188
> 
> %diff against 5.14-rc3
>   Time: 0.15% more
>   Exits: 2.42% less
> 
> b)Test Setup -2
> -----------------------
> 
> Platform: HiSilicon D06 + Kernel with maxcpus set to 8 and VMID bits set to 4.
> Run 40 VMs concurrently each with 2 vCPUs. Each Guest will execute hackbench
> 5 times before exiting.
> 
> Measurements taken avg. of 10 Runs.
> 
> Image : 5.14-rc3-vmid4bit
> ------------------------------------
>   Time(s)        46.19963266
>   No. of exits     23,699,546
> 
> Image: 5.14-rc3-vmid4bit + vmid-v3
> ---------------------------------------------------
>   Time(s)          45.83307736
>   No. of exits      23,260,203
> 
> %diff against 5.14-rc3-vmid4bit
>   Time: 0.8% less
>   Exits: 1.85% less 
> 
> Image: 5.14-rc3-vmid4bit + vmid-v3 + Without active_asid clear
> -----------------------------------------------------------------------------------------
>   Time(s)           44.5031782
>   No. of exits        144,443,188

Really? The *exact* same numbers as the "Image: 5.14-rc3 + vmid-v3 + Without
active_asid clear" configuration? Guessing a copy-paste error here.

> %diff against 5.14-rc3-vmid4bit
>   Time: 1.05% less
>   Exits: 2.06% less
> 
> As expected, the active_asid clear on schedule out is not helping.
> But without this patch, the numbers seems to be better than the
> vanilla kernel when we force the setup(cpus=8, vmd=4bits)
> to perform rollover.

I'm struggling a bit to understand these numbers. Are you saying that
clearing the active_asid helps in the 16-bit VMID case but not in the
4-bit case?

Why would the active_asid clear have any impact on the number of exits?

The problem I see with not having the active_asid clear is that we will
roll over more frequently as the number of reserved VMIDs increases.

Will
