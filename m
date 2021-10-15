Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7D242FC4B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 21:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242767AbhJOTmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 15:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242750AbhJOTmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 15:42:14 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65540C061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 12:40:07 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id lk8-20020a17090b33c800b001a0a284fcc2so10069071pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 12:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1a/6peZLSAD85mz3HpJfFRT3p8OOlLaLJWrrCdBU9sA=;
        b=e3mQV9GvtxxTsES/ruNVsn6hkp1PVZogK12qCFJREQXgexbzc2xBWXnyiq1sDF6gZ3
         ySEFTeusj6kmZm5dg6klqEH91CH6aTk3oAbwNNMYkg9KhXeS60IMBFSZO+oe06Phso/i
         A1gDHWb7YjtZOWG283MFXHXPLEW7j0gqApLmIvX19BTVmOedMzS4bmnEHw8/EDybcut5
         NkHBMogA5uf5fg1D1lBZTufjcdOs18jrCAqxDCj5efrPYGrmRiKnPLK3o0oxoUOIEz6M
         CjKhypphO0l2u9jnBdrFtodeLvLMDgmmcbVAk3wDDfj5lb2t/qvynBi+X8lgscAlXAKF
         /ENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1a/6peZLSAD85mz3HpJfFRT3p8OOlLaLJWrrCdBU9sA=;
        b=2jEICRkSwlY56VK5Yu1OuFVCXp/EBHvyOs+hxn3CFIlvuswbiQ2lrtWDQieP79ePI3
         2qB3bI9Ol0XbhDs6benk+31scpLQfux3wiTrIKW4PhDpRY+I0a4DVleTROrY0cQh7jbu
         Kx/cMluK6XgmUvJCwjqWHyBq7Eotnl0dsOosYr/5jP174uFP1Ym6xHKzivZ/9DHnP/T0
         bqnMb3IHhor27SuhD/IcfJr4ulbpdLM0MoOcXeLoeDxzN6F86HVeP9xM7CGvg0Btzlf/
         Haijsct5AkDE21eNPkZWOstOycsOLXJVbp5z3Wg52PTmVbglprdWTL4hB7yIuX1YtgI2
         PTxQ==
X-Gm-Message-State: AOAM532sc8ijBa+TiRtw2mgGL14JcW4Ut181MWB9p3ts8GMMw1rkXjj+
        +vjs7VUdtjlxevkP9ZBW9mo=
X-Google-Smtp-Source: ABdhPJwTkc5fakXK/OOUpTRwuPBEbNMV1p0wKou25kBF6F95B/UvzmLUt1WvJ3igATMggAn0rhz88g==
X-Received: by 2002:a17:90a:b391:: with SMTP id e17mr30100849pjr.137.1634326806762;
        Fri, 15 Oct 2021 12:40:06 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id g14sm5225415pgo.88.2021.10.15.12.40.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 12:40:05 -0700 (PDT)
Subject: Re: [PM] bfcc1e67ff:
 kernel-selftests.breakpoints.step_after_suspend_test.fail
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, lkp@intel.com,
        kernel test robot <oliver.sang@intel.com>
References: <20211014075731.GB18719@xsang-OptiPlex-9020>
 <51c0a15f-1941-f161-dcec-a7a9acc726f2@gmail.com>
 <e526de16-5efd-6474-20e1-3f96a2e3c524@intel.com>
 <6755cf07-fa5a-cbb7-c076-57c162a08c99@gmail.com>
 <d3cf18f1-2af7-5e4d-abe4-c882f25bd5c3@intel.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <20aedfba-14e3-3677-d21a-b87610095445@gmail.com>
Date:   Fri, 15 Oct 2021 12:40:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <d3cf18f1-2af7-5e4d-abe4-c882f25bd5c3@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/21 11:45 AM, Rafael J. Wysocki wrote:
> On 10/14/2021 11:55 PM, Florian Fainelli wrote:
>> On 10/14/21 12:23 PM, Rafael J. Wysocki wrote:
>>> On 10/14/2021 6:26 PM, Florian Fainelli wrote:
>>>> On 10/14/21 12:57 AM, kernel test robot wrote:
>>>>> Greeting,
>>>>>
>>>>> FYI, we noticed the following commit (built with gcc-9):
>>>>>
>>>>> commit: bfcc1e67ff1e4aa8bfe2ca57f99390fc284c799d ("PM: sleep: Do not
>>>>> assume that "mem" is always present")
>>>>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git
>>>>> master
>>>>>
>>>>>
>>>>> in testcase: kernel-selftests
>>>>> version: kernel-selftests-x86_64-c8c9111a-1_20210929
>>>>> with following parameters:
>>>>>
>>>>>      group: group-00
>>>>>      ucode: 0x11
>>>>>
>>>>> test-description: The kernel contains a set of "self tests" under the
>>>>> tools/testing/selftests/ directory. These are intended to be small
>>>>> unit tests to exercise individual code paths in the kernel.
>>>>> test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
>>>>>
>>>>>
>>>>> on test machine: 288 threads 2 sockets Intel(R) Xeon Phi(TM) CPU 7295
>>>>> @ 1.50GHz with 80G memory
>>>>>
>>>>> caused below changes (please refer to attached dmesg/kmsg for entire
>>>>> log/backtrace):
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> If you fix the issue, kindly add following tag
>>>>> Reported-by: kernel test robot <oliver.sang@intel.com>
>>>> Thanks for your report. Assuming that the code responsible for
>>>> registering the suspend operations is drivers/acpi/sleep.c for your
>>>> platform, and that acpi_sleep_suspend_setup() iterated over all
>>>> possible
>>>> sleep states, your platform must somehow be returning that
>>>> ACPI_STATE_S3
>>>> is not a supported state somehow?
>>>>
>>>> Rafael have you ever encountered something like that?
>>> Yes, there are systems with ACPI that don't support S3.
>> OK and do you know what happens when we enter suspend with "mem" in
>> those cases? Do we immediately return because ultimately the firmware
>> does not support ACPI S3?
> 
> "mem" should not be present in the list of available strings then, so it
> should be rejected right away.

Well yes, that was the purpose of the patch I submitted, but assuming
that we did provide "mem" as one of the possible standby modes even
though that was wrong (before patch), and the test was trying to enter
ACPI S3 standby, what would have happened, would the ACPI firmware honor
the request but return an error, or would it actually enter ACPI S3?

In any case, I will change the test to check that this is a supported
standby mode before trying it.
-- 
Florian
