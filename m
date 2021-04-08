Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390F2358BE0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 20:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbhDHSCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 14:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbhDHSCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 14:02:33 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7175C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 11:02:18 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id f6so3059586wrv.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 11:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IireDPjuDif/ZcRD6su9CmuR9LjCsbIE1itw4DDICWQ=;
        b=w1R/S7VVg7hx49s2SzC8lZ2GF7Hra6UL7MACcAr9EwZWz+koY5F5X0rgZahCDSXlWi
         dIpR6SfcrHae57soeYUmm/Mn4tkP6ufjmfDx5uTnTHjIn+XlxVHMRAUs1Eknal/3bGiP
         DUotyqOMC/jwXvk70yNR6+6h6G238SUuRmBAUAZg1YdxFv+eNQLV1ECOlL3n7bV3y6KK
         zBXzsknRrQPevLntBGszpmziBLXl8+/6hDv0qUwN0AJ7wfdORwE2ZViQs9D5cew16c3q
         zO7clPCBav8QNKbkyopEKLqzBlknPdMJka+YRFTA1rwSZhUMzs9UtHXsw3vFnHIGPKtX
         idIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IireDPjuDif/ZcRD6su9CmuR9LjCsbIE1itw4DDICWQ=;
        b=izVeN5CXWw9hTO0FVMzxnJoVcqpHWRtGF+4ZXh4cU3uyefw82IAErQSqwCZ/3Ne5BV
         X6a8oSNLxEwZPTNe658Vg8jhOX+ElJqS2sITP4qqPTtCEGc5+FNVQHW153C4qiXs8Edj
         F9v8lH8huSvNRBqu3jAG9wcRstFMQaUaJGMVeYRxAKfeNuAKz33Tc7Li251uMLJYe2B1
         ubcYRelnokyU3rANl9QlhtPqmLBSYybAmwpW+eaZehXX7kKgW86JAYw7B9F5Q6QhLpxW
         5GRPPtTcVFwJf5lwuiECkp0xwb74ajeUMP9Ka2mxZnTZJRAg077FkDU2wXDsjiZ27UWL
         BPRA==
X-Gm-Message-State: AOAM531hDSpkVH4E/t2XTLfb43BNBE0FdTeWvHn4OPXGHjy//roDwlyZ
        lpXYQl6KkQtvrdkCJyoJOmabtw==
X-Google-Smtp-Source: ABdhPJy2EAY7kBw4FPApksscvm7rQzlz2zqE7QkslxBFo2dft5KnLfghxCEf/CGd4zd3ofX3FSqbhg==
X-Received: by 2002:a05:6000:18cd:: with SMTP id w13mr13098070wrq.20.1617904937231;
        Thu, 08 Apr 2021 11:02:17 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:9407:6619:589b:441e? ([2a01:e34:ed2f:f020:9407:6619:589b:441e])
        by smtp.googlemail.com with ESMTPSA id b12sm8471wrf.39.2021.04.08.11.02.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 11:02:16 -0700 (PDT)
Subject: Re: [GIT PULL] cpuidle for v5.13-rc1
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>, He Ying <heying24@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
References: <03743d3c-a3bf-066f-614c-1a49f566fdb2@linaro.org>
 <CAJZ5v0iGQGRvjaesmvvxpmot9vkyEEVWHkj3Wka24xZCzL351w@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <4b8b0bc5-492c-7e95-9b08-ab87c9ac65d5@linaro.org>
Date:   Thu, 8 Apr 2021 20:02:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0iGQGRvjaesmvvxpmot9vkyEEVWHkj3Wka24xZCzL351w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/2021 19:24, Rafael J. Wysocki wrote:
> On Thu, Apr 8, 2021 at 5:10 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>>
>> Hi Rafael,
>>
>> please consider pulling the following change for cpuidle on ARM for
>> v5.13-rc1
>>
>> Thanks
>>
>>   -- Daniel
>>
>>
>> The following changes since commit dde8740bd9b505c58ec8b2277d5d55c6951b7e42:
>>
>>   Merge branch 'acpi-processor-fixes' into linux-next (2021-04-07
>> 19:02:56 +0200)
> 
> Can you please rebase this on 5.12-rc6?  My linux-next branch is
> re-merged on a regular basis.
> 
> Generally speaking, if you want me to pull from a branch, please make
> sure that this branch is based on a commit present in the Linus' tree,
> preferably one of the commits tagged as -rc or a specific merge.
> 

Sure, here is the pull request based on v5.12-rc6 with the signed tag
cpuidle-v5.13-rc1

Thanks

  -- Daniel


The following changes since commit e49d033bddf5b565044e2abe4241353959bc9120:

  Linux 5.12-rc6 (2021-04-04 14:15:36 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/daniel.lezcano/linux tags/cpuidle-v5.13-rc1

for you to fetch changes up to 498ba2a8a2756694b6f3888857426dbc8a5e6b6c:

  cpuidle: Fix ARM_QCOM_SPM_CPUIDLE configuration (2021-04-08 19:54:14
+0200)

----------------------------------------------------------------
- Fix the C7 state on the tegra114 by setting the L2-no-flush flag
  unconditionally (Dmitry Osipenko)

- Remove the do_idle firmware call as it is not supported by the ATF
  on tegra SoC (Dmitry Osipenko)

- Add a missing dependency on CONFIG_MMU to prevent linkage error (He
  Ying)

----------------------------------------------------------------
Dmitry Osipenko (2):
      cpuidle: tegra: Fix C7 idling state on Tegra114
      cpuidle: tegra: Remove do_idle firmware call

He Ying (1):
      cpuidle: Fix ARM_QCOM_SPM_CPUIDLE configuration

 drivers/cpuidle/Kconfig.arm     |  2 +-
 drivers/cpuidle/cpuidle-tegra.c | 19 ++++---------------
 2 files changed, 5 insertions(+), 16 deletions(-)

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
