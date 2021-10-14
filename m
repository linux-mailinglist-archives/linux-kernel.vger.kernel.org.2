Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A91E742E3E0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 23:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbhJNV6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 17:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbhJNV6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 17:58:02 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD76C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 14:55:53 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id d23so6740010pgh.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 14:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8KCBa22fzebnliwJ53TUX2fQlBe4pRKtp4NpVWdwOr8=;
        b=qUWezM8050J0V+GxuKsquuBbgOIDJEj7el0dJXeJoiutXaMGaRuOSzpGcdgBNrQHVf
         Hk2+d3Et4utpx4syAAEgMErJrUkWVGjER3d9Hq4u9QqTS+Jfk83VJcq9PHZ/1a3sxvwV
         QQEFip53cP0GFBRzGI5k82Cf7xmB2BUbpDD/BrxzLrL0/j/JauN4XI6kPKoU+jttAvUs
         Hfr+S31m8dvMQbpf4RAbKyZATHNG5ad9Mq8L4FJnZma7yFY+/S6XDKIBFNe2jXtBUaxh
         Wf2t9OAIwC4mJHCW26FUAUTpb0z+N7EoX+0WSzC5X5ATVbNnNQr0Q6AlsmaaJSA7lR/G
         FcJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8KCBa22fzebnliwJ53TUX2fQlBe4pRKtp4NpVWdwOr8=;
        b=yholK5UN+ZVBEolNg4Qgkw/H3tJ5UqstL5N8lZgtPAECdzc/Zr7XiWTqucbgjKF/Rw
         B7+iFQWyR/XiS6JfFbzgOhbQ5VxkcN1svcV2MlaptDykssfD8pyT7qTXJ+U/RMiOjWur
         UDGdh3qUSNR/giFNDIjBG3QSglc22vmks745dkQjQv27PU+wdu+lxdD5zlQgWupttE/T
         cVABBdTkbEjcrVCry6Bny0CTBQ/MTrABDhGFR/ChrckhRgXRVHeddokScAI9YwU+g4p7
         Wo51+eHEAABLd6LscL5J0B3gOiLB0wYrk5ppUWqUh9kqaO0+dCx+LLSh18Zq9fOVON+8
         axcQ==
X-Gm-Message-State: AOAM531y9xKHi8SX6yG4Q/GbTT62PPn84r8bp4tF4N0lNrEaqf9cjufT
        5LSfAxP2Xh/urcHlGF2Y32xjd6EhDEU=
X-Google-Smtp-Source: ABdhPJxAw8w0toZYCzOK18nFgbk71QjmGJspCXMOt1ZD3VHqX62T/T7iJhAdlQgIb3G/xO/y/3S52w==
X-Received: by 2002:a65:6854:: with SMTP id q20mr6239818pgt.228.1634248552634;
        Thu, 14 Oct 2021 14:55:52 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id y22sm3288178pjj.5.2021.10.14.14.55.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 14:55:52 -0700 (PDT)
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
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <6755cf07-fa5a-cbb7-c076-57c162a08c99@gmail.com>
Date:   Thu, 14 Oct 2021 14:55:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <e526de16-5efd-6474-20e1-3f96a2e3c524@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/21 12:23 PM, Rafael J. Wysocki wrote:
> On 10/14/2021 6:26 PM, Florian Fainelli wrote:
>> On 10/14/21 12:57 AM, kernel test robot wrote:
>>>
>>> Greeting,
>>>
>>> FYI, we noticed the following commit (built with gcc-9):
>>>
>>> commit: bfcc1e67ff1e4aa8bfe2ca57f99390fc284c799d ("PM: sleep: Do not
>>> assume that "mem" is always present")
>>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>>>
>>>
>>> in testcase: kernel-selftests
>>> version: kernel-selftests-x86_64-c8c9111a-1_20210929
>>> with following parameters:
>>>
>>>     group: group-00
>>>     ucode: 0x11
>>>
>>> test-description: The kernel contains a set of "self tests" under the
>>> tools/testing/selftests/ directory. These are intended to be small
>>> unit tests to exercise individual code paths in the kernel.
>>> test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
>>>
>>>
>>> on test machine: 288 threads 2 sockets Intel(R) Xeon Phi(TM) CPU 7295
>>> @ 1.50GHz with 80G memory
>>>
>>> caused below changes (please refer to attached dmesg/kmsg for entire
>>> log/backtrace):
>>>
>>>
>>>
>>>
>>> If you fix the issue, kindly add following tag
>>> Reported-by: kernel test robot <oliver.sang@intel.com>
>> Thanks for your report. Assuming that the code responsible for
>> registering the suspend operations is drivers/acpi/sleep.c for your
>> platform, and that acpi_sleep_suspend_setup() iterated over all possible
>> sleep states, your platform must somehow be returning that ACPI_STATE_S3
>> is not a supported state somehow?
>>
>> Rafael have you ever encountered something like that?
> 
> Yes, there are systems with ACPI that don't support S3.

OK and do you know what happens when we enter suspend with "mem" in
those cases? Do we immediately return because ultimately the firmware
does not support ACPI S3?

I will rework
tools/testing/selftests/breakpoints/step_after_suspend_test.c not to
assume that "mem" is always available, since it may not be.
-- 
Florian
