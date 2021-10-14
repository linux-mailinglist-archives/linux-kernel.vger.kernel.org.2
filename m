Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC0D42DF1F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 18:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbhJNQ2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 12:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbhJNQ20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 12:28:26 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C30C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 09:26:21 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id x8so4523354plv.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 09:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0SGvu+BGXnunxmut5LMEnw5AJK5TgZXQgoFVs5Edd1U=;
        b=hte+ErVhGnbQF1uRu6XP0I9W8GCfn0IP/AkvOc5aAqHC4ifh9l1zifKc4xvTd2pIJm
         5mEF8HHseBEIiMrpOYwXXu6kXER6DxjQA8PFSafTifpjBS13QHzGHLBjZUDmLNM2iwqz
         p4soSQhlr9I143Ic4tg2Yaoi5Wj/InXHixXCxU5pTsokGfMkw3fPTmxY/qV8g17V+9zM
         dagqpsiff9iGB8KHiJvi+dOMyB3MmRVSzU3UkLHZcIZmxCaQQwf/pwxEjAEqe9rm2oPx
         pCOqhH/EvJnx76xJZqo3X1UxkHJ1Fj3nFsifbt756MC9AdajVFZZV+85K+LBFeEK9Stt
         2Hug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0SGvu+BGXnunxmut5LMEnw5AJK5TgZXQgoFVs5Edd1U=;
        b=wJmgmk1ONXH3PyR8v+odf82vYPyD3VCA5MMXhoc4n8ieC0HZwOszPd/QcM/EGf9uRE
         5TchY3uHMndNWA8mTB5K9o/jq4rftiy/ng2FErOlgxPJoFp8nUXsE4zpR6mci/Iksmrp
         R7x8tVsleI8e1iO0tdBTMfEe/Yw7+70KuibmAGB9IPBmgrGPLODI3/k3XAL7eFffAiP1
         AHsgwtDoJCrwgdg2Eb03fvemkg2fdmsE8yoRElqmEV3BZS1WqMnlgQKgqY5sTQJey1Sn
         B8lpqYjf0t91Mo9fnB63DbhnQMKy7K7xhaNjMeIsy+9AAwU0YERMLmpAiHZMCnLW97jD
         R0UA==
X-Gm-Message-State: AOAM533bS76Q73uiqy2LHKGd2xJ/8hi7OzxP4AwdQR41n00bKRH3mFFU
        CihKa0IAG1LgoxXV/LXLioM=
X-Google-Smtp-Source: ABdhPJyM22HvcaqhDBWIzWFl9xzrMSOtghSlH/axdKr+6Zos5xrxh3iaYzQ4iXnrIDXQI5IOidlLMQ==
X-Received: by 2002:a17:90a:9403:: with SMTP id r3mr21371483pjo.220.1634228781240;
        Thu, 14 Oct 2021 09:26:21 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id o11sm8222582pjp.0.2021.10.14.09.26.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 09:26:20 -0700 (PDT)
Subject: Re: [PM] bfcc1e67ff:
 kernel-selftests.breakpoints.step_after_suspend_test.fail
To:     kernel test robot <oliver.sang@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, lkp@intel.com
References: <20211014075731.GB18719@xsang-OptiPlex-9020>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <51c0a15f-1941-f161-dcec-a7a9acc726f2@gmail.com>
Date:   Thu, 14 Oct 2021 09:26:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211014075731.GB18719@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/21 12:57 AM, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: bfcc1e67ff1e4aa8bfe2ca57f99390fc284c799d ("PM: sleep: Do not assume that "mem" is always present")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> 
> in testcase: kernel-selftests
> version: kernel-selftests-x86_64-c8c9111a-1_20210929
> with following parameters:
> 
> 	group: group-00
> 	ucode: 0x11
> 
> test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
> test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
> 
> 
> on test machine: 288 threads 2 sockets Intel(R) Xeon Phi(TM) CPU 7295 @ 1.50GHz with 80G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>

Thanks for your report. Assuming that the code responsible for
registering the suspend operations is drivers/acpi/sleep.c for your
platform, and that acpi_sleep_suspend_setup() iterated over all possible
sleep states, your platform must somehow be returning that ACPI_STATE_S3
is not a supported state somehow?

Rafael have you ever encountered something like that?

> 
> 
> TAP version 13
> 1..2
> # selftests: breakpoints: step_after_suspend_test
> # TAP version 13
> # Bail out! Failed to enter Suspend state
> # # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
> not ok 1 selftests: breakpoints: step_after_suspend_test # exit=1
> 
> 
> 
> To reproduce:
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         sudo bin/lkp install job.yaml           # job file is attached in this email
>         bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
>         sudo bin/lkp run generated-yaml-file
> 
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
> 
> 
> 
> ---
> 0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
> https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation
> 
> Thanks,
> Oliver Sang
> 


-- 
Florian
