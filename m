Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6D8E31CA7C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 13:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhBPMSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 07:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbhBPMSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 07:18:13 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F362FC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 04:17:30 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id v5so15315356lft.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 04:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rFwOmulNONpMQjilEPemhnsjOZneCKsayzE9iyzOr6s=;
        b=P9u0BFR4TD7k0i2Woh9Pkq+FlwaxvbtdnoEkVty3Y8DEp1PI0P6WgMb7geBsPJ2OFI
         fIb7V2N4rCeIxs+44I7VqSURvcBSgEtZ5ykabjTFuNyEtehvXcT5cec+oN0JZtk3HDsk
         hOWhiGNTGb5JhQQThe0wm75fI+B83YMaXQhaJTqsssLk2VpcdkfYtOLGlDwX5GYjwSCd
         afDPyk86iGejPEFBUCDFa8z9PqUdqEu/VlqTqHacih0kdZGLeAHh0Md41f7Hnc1C1bN7
         y1ZAPLEoTOID1ANJs8JeMAQWKS9Xip2+2R78ze5odRS6NVaT9hAHKZSsMUjITLr97m8j
         3U8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rFwOmulNONpMQjilEPemhnsjOZneCKsayzE9iyzOr6s=;
        b=BlhQLxf+FP5jMpTGOFc5WX3sNX81AE+MacxI4OX62Kby1O6fb6k6ps0QQLuwfNeaW6
         PmJSXqhOimhNOeWJQp9DpT/ymN7YvCPaEczQAepOsvLzB3GNeqMmwt8nzO8bU+fur3qs
         DADkJgvUA14oKv/JiZVrND1wF2YSsZfzKFOCwtrEx8PkAjjRVrNtocco1Qv8mURnITHd
         Hx1WLlPm2YJ024a4UhmZxLtEDooiJwt8/YDteYcxYipyzP2KnkjkfzCMx/Oc4FUAgJgH
         25vJaVa8Vidp7yn9TRNevEy3oYDseAIlA+sAUB9og6Xzzh8dMz6UMUjnWXIxhsGXjAOu
         wI8Q==
X-Gm-Message-State: AOAM532DLPtaDkSQRzdiy6imv8wXRgAv2aXTO3GAQcERHRc/DWs2TNrA
        uXeDzfWuob9KQPizjqr0FqmVrfjEbfU=
X-Google-Smtp-Source: ABdhPJz4KBuhCoueSPOF983ytvDxij5CRwPUKn1HGBZ2XnuwtHlAddPir6QWAFplsXH6wKNHDVhaOg==
X-Received: by 2002:a05:6512:5ca:: with SMTP id o10mr11240207lfo.619.1613477849497;
        Tue, 16 Feb 2021 04:17:29 -0800 (PST)
Received: from [192.168.1.2] (broadband-37-110-156-170.ip.moscow.rt.ru. [37.110.156.170])
        by smtp.gmail.com with ESMTPSA id t27sm3963531ljk.132.2021.02.16.04.17.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Feb 2021 04:17:28 -0800 (PST)
Subject: Re: [RFC PATCH 00/13] Add futex2 syscalls
From:   Andrey Semashev <andrey.semashev@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
References: <9557a62c-ab64-495b-36bd-6d8db426ddce@gmail.com>
Cc:     andrealmeid@collabora.com
Message-ID: <b7df4ac2-91a4-a52a-4455-611e0c6d7107@gmail.com>
Date:   Tue, 16 Feb 2021 15:17:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <9557a62c-ab64-495b-36bd-6d8db426ddce@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding André Almeida to CC.

On 2/16/21 3:13 PM, Andrey Semashev wrote:
> Sorry for posting out-of-tree, I just subscribed to the list to reply to 
> a post that was already sent.
> 
> André Almeida wrote:
> 
>> ** "And what's about FUTEX_64?"
>>
>>  By supporting 64 bit futexes, the kernel structure for futex would
>>  need to have a 64 bit field for the value, and that could defeat one of
>>  the purposes of having different sized futexes in the first place:
>>  supporting smaller ones to decrease memory usage. This might be
>>  something that could be disabled for 32bit archs (and even for
>>  CONFIG_BASE_SMALL).
>>
>>  Which use case would benefit for FUTEX_64? Does it worth the trade-offs?
> 
> I strongly believe that 64-bit futex must be supported. I have a few use 
> cases in mind:
> 
> 1. Cooperative robust futexes.
> 
> I have a real-world case where multiple processes need to communicate 
> via shared memory and synchronize via a futex. The processes run under a 
> supervisor parent process, which can detect termination of its children 
> and also has access to the shared memory. In order to make the 
> communication more or less safe in face of one of the child process 
> crashing, the futex currently contains a portion of pid of the process 
> that locked it. The parent supervisor is then able to tell that the 
> crashed child was holding the futex locked and then marke the futex as 
> "broken" and notify any other threads blocked on it.
> 
> Given that pid can be up to 32-bits in size, and we also need some bits 
> in the futex to implement its logic (i.e. at least "locked" and "broken" 
> bits, some bits for the ABA counter, etc.), the pid can be truncated and 
> the above logic may be broken. In the real application, only 15 bits are 
> left for the pid, which is already less than the actual pid range on the 
> system.
> 
> Note: We're not using the proper pthread robust mutexes because we also 
> need a condition variable, and condition variables contain a non-robust 
> mutex internally, which basically nullifies robustness. One could argue 
> to fix pthread instead, but I view that as a more difficult task as 
> pthread interface is standardized. We would rather use futex directly 
> anyway because of more flexibility and less performance overhead.
> 
> 2. Parity with WaitOnAddress[1] on Windows.
> 
> WaitOnAddress is explicitly documented to support 8-byte states, and its 
> interface allows for further extension. I'm not a Wine developer, but I 
> would guess that having a 8-byte futex support to match would be useful 
> there.
> 
> Besides Wine, having a 64-bit futex would be important for 
> std::atomic[2] and Boost.Atomic in C++, which support waiting and 
> notifying operations (for std::atomic, introduced in C++20). Waiting and 
> notifying operations are normally implemented using futex API on Linux 
> and WaitOnAddress on Windows, and can be emulated with a process-wide 
> global mutex pool if such API is unavailable for a given atomic size on 
> the target platform. This means that 64-bit atomics on Linux currently 
> must be implemented with a lock and therefore cannot be used in 
> process-shared memory, while there is no such limitation on Windows.
> 
> 
> I'm not sure how much memory is saved by not having 64-bit state in the 
> kernel futex structures, but this doesn't look like a huge deal on 
> modern systems - server, desktop or mobile. It may make sense for 
> extremely low memory embedded systems, and for those targets the support 
> may be disabled with a switch. In fact, such systems would probably not 
> support 64-bit atomics anyway. For any other targets I would prefer 
> 64-bit futex to be available by default.
> 
> My main issue with 64-bit being optional though is that applications and 
> libraries like Boost.Atomic would like (or even require) to know if the 
> feature is available at compile time rather than run time. std::atomic, 
> for example, is supposed to be a thin abstraction over atomic 
> instructions and OS primitives like futex, so performing runtime 
> detection of the available features in the kernel would be detrimental 
> there. I'm not sure if this is possible in the current kernel 
> infrastructure, but it would be best if the lack of 64-bit atomics in 
> the kernel was detectable through kernel headers (e.g. by a macro for 
> 64-bit futexes not being defined or something like that), which means 
> the headers must be generated at kernel configuration time.
> 
> [1]: 
> https://docs.microsoft.com/en-us/windows/win32/api/synchapi/nf-synchapi-waitonaddress 
> 
> [2]: https://en.cppreference.com/w/cpp/atomic/atomic

