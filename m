Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF7331CA74
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 13:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhBPMN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 07:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbhBPMNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 07:13:53 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F4CC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 04:13:12 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id v5so15297097lft.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 04:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=+mDSVHCQVJYYjHuHsfCfnBfGlumopLmHe1tSYL06S8I=;
        b=r07s0qX9zXds8m1e+njNmWeIzx6PbyXkOBf0uUIJOMRnDIZvR4F7iBZNUsvxphs2CL
         O79aibe7IzSesnOGjCHhdAQv1DGKpERvBtjGYDwkCswLhuoQnzoDV82EQAKVqUliggm/
         yEDc0ZtLeT/4bV306WElDOhlCl4kb+NCEkCyi4D15gOwYBAydS/J9WQRyExprzpNXn+m
         UkCbe6n+bDJVPd7U20nb7bDsygmlEaFVI+1IXcKxQdzNdMVp+XSs4QiZNBjUC4x5AtnK
         IaAz4cZxbWxqnG11R2G9JUbttxPBf5AnH8tGHJ7KeJ4yt5+87bbhwFdb/30CCYfah/fy
         gfbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=+mDSVHCQVJYYjHuHsfCfnBfGlumopLmHe1tSYL06S8I=;
        b=esx6LAPN+AHbVBAOalO9GAVfb+ZzhqysTY3d48R3MxVAgX8T2tZEycBxyUJLbyz/Y0
         6p4YWQ39eNg7XXek7gJeB7e0VKywN2TZNcKo/sh3JewjTYetZvcaGfdl7os0A/Bz5Ba4
         heo00lSI45E1/4d0D9O7EMVg9kil8H4kALZdiGcmUviFERfeP2o7PEy/FuYYwztuD59r
         LuQu3Xg1lGP6kNskHmagWPYDiKzEEV5OQ+32m8ehnUXUnC4HAN6BW3/SCi7aR8PFvIND
         pcmp0NrCI/vfyzwazQ3Fr7BtDaYlC/A8y2vEqEK9ARusHp+js/Z8atp93eHgMVQ1B35Y
         ovrQ==
X-Gm-Message-State: AOAM531+nuMJHrGvgB2Fm0+J7QqCOMw+IYfmgPB2TUJF9RgS4LogbHx9
        RG+YejA+S8rV6wy1Z0hdtZ8VJ/7S6ww=
X-Google-Smtp-Source: ABdhPJwtUibbV4HUgDD8+KJWe8FZ0Mdu39o4lNq5rlmvajFTD0/bh2ErfNUkeIONHR/Xz07Dq4r2/g==
X-Received: by 2002:a19:7911:: with SMTP id u17mr11967024lfc.214.1613477590226;
        Tue, 16 Feb 2021 04:13:10 -0800 (PST)
Received: from [192.168.1.2] (broadband-37-110-156-170.ip.moscow.rt.ru. [37.110.156.170])
        by smtp.gmail.com with ESMTPSA id z23sm1162245lji.73.2021.02.16.04.13.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Feb 2021 04:13:09 -0800 (PST)
To:     LKML <linux-kernel@vger.kernel.org>
From:   Andrey Semashev <andrey.semashev@gmail.com>
Subject: Re: [RFC PATCH 00/13] Add futex2 syscalls
Message-ID: <9557a62c-ab64-495b-36bd-6d8db426ddce@gmail.com>
Date:   Tue, 16 Feb 2021 15:13:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for posting out-of-tree, I just subscribed to the list to reply to 
a post that was already sent.

André Almeida wrote:

> ** "And what's about FUTEX_64?"
> 
>  By supporting 64 bit futexes, the kernel structure for futex would
>  need to have a 64 bit field for the value, and that could defeat one of
>  the purposes of having different sized futexes in the first place:
>  supporting smaller ones to decrease memory usage. This might be
>  something that could be disabled for 32bit archs (and even for
>  CONFIG_BASE_SMALL).
> 
>  Which use case would benefit for FUTEX_64? Does it worth the trade-offs?

I strongly believe that 64-bit futex must be supported. I have a few use 
cases in mind:

1. Cooperative robust futexes.

I have a real-world case where multiple processes need to communicate 
via shared memory and synchronize via a futex. The processes run under a 
supervisor parent process, which can detect termination of its children 
and also has access to the shared memory. In order to make the 
communication more or less safe in face of one of the child process 
crashing, the futex currently contains a portion of pid of the process 
that locked it. The parent supervisor is then able to tell that the 
crashed child was holding the futex locked and then marke the futex as 
"broken" and notify any other threads blocked on it.

Given that pid can be up to 32-bits in size, and we also need some bits 
in the futex to implement its logic (i.e. at least "locked" and "broken" 
bits, some bits for the ABA counter, etc.), the pid can be truncated and 
the above logic may be broken. In the real application, only 15 bits are 
left for the pid, which is already less than the actual pid range on the 
system.

Note: We're not using the proper pthread robust mutexes because we also 
need a condition variable, and condition variables contain a non-robust 
mutex internally, which basically nullifies robustness. One could argue 
to fix pthread instead, but I view that as a more difficult task as 
pthread interface is standardized. We would rather use futex directly 
anyway because of more flexibility and less performance overhead.

2. Parity with WaitOnAddress[1] on Windows.

WaitOnAddress is explicitly documented to support 8-byte states, and its 
interface allows for further extension. I'm not a Wine developer, but I 
would guess that having a 8-byte futex support to match would be useful 
there.

Besides Wine, having a 64-bit futex would be important for 
std::atomic[2] and Boost.Atomic in C++, which support waiting and 
notifying operations (for std::atomic, introduced in C++20). Waiting and 
notifying operations are normally implemented using futex API on Linux 
and WaitOnAddress on Windows, and can be emulated with a process-wide 
global mutex pool if such API is unavailable for a given atomic size on 
the target platform. This means that 64-bit atomics on Linux currently 
must be implemented with a lock and therefore cannot be used in 
process-shared memory, while there is no such limitation on Windows.


I'm not sure how much memory is saved by not having 64-bit state in the 
kernel futex structures, but this doesn't look like a huge deal on 
modern systems - server, desktop or mobile. It may make sense for 
extremely low memory embedded systems, and for those targets the support 
may be disabled with a switch. In fact, such systems would probably not 
support 64-bit atomics anyway. For any other targets I would prefer 
64-bit futex to be available by default.

My main issue with 64-bit being optional though is that applications and 
libraries like Boost.Atomic would like (or even require) to know if the 
feature is available at compile time rather than run time. std::atomic, 
for example, is supposed to be a thin abstraction over atomic 
instructions and OS primitives like futex, so performing runtime 
detection of the available features in the kernel would be detrimental 
there. I'm not sure if this is possible in the current kernel 
infrastructure, but it would be best if the lack of 64-bit atomics in 
the kernel was detectable through kernel headers (e.g. by a macro for 
64-bit futexes not being defined or something like that), which means 
the headers must be generated at kernel configuration time.

[1]: 
https://docs.microsoft.com/en-us/windows/win32/api/synchapi/nf-synchapi-waitonaddress
[2]: https://en.cppreference.com/w/cpp/atomic/atomic
