Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12D0D308D50
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 20:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbhA2TYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 14:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbhA2TWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 14:22:43 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613CFC061756
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 11:21:47 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id j2so5681053pgl.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 11:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NcjbEbjTpWYG73gblgVXiKLVQUYE+zg3Ldwequmr1XM=;
        b=IjgzGb7wSosmWX3N8qQMPieaNTY1ZrwQjJK6wDzPWYwP+o4HUK6OciPi9BKzZBEU+c
         NN8a8hfjFT6QjamzS9/i0zi3CBGG5RDQbPqKUAJviW9Uwu7GFNU9pmGOYd/zlYkxTG/q
         XIF1jQHenmBTbYF1Rv3u5pnSPkEjveSYprg89jnFY4iCiSRapIFBhyeRPAS8SCLE4jJH
         oQLC+YwfBqdQ2xLzUdYJCaxrZLRctERz/Izn5ZQpNVQcxvGXMQHCKpwv8idb+vawkUx9
         8zXt251urzC8t/w0TBoOPCqvibcKiFXKW5HW1opi83DjZ6lVg9surRb/A6hNW8kxwnPK
         WD+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NcjbEbjTpWYG73gblgVXiKLVQUYE+zg3Ldwequmr1XM=;
        b=agF42d5qJoIzTM/E/a9DZhO+H8MJ6SpPAHawV0STfPqwt6XUgni9V7KwV3FhnE9KA0
         BNvstTAI7DCZYnngntwTk4CPJgtxMk7qFou25N2X9EXGInyR1H5drKA6LmkgaPnfwjy5
         JgC6EcIYrCEMe/znZTs+HRLBDAHjdMdGtS2AF5hmotO57f+b6RlTGVa2N1QfX/vHPhwm
         iziDAXbmXi/bQIytZmum7y4/cg7E5WZi/Tt45sdlk3wRLYSAS94KUslJ/+LMt47Hvm3z
         hNdklzZDh9aguxztgpfprB/EfOxy37zfedYB2k6RL7gY0ulIsWJc79EidV7mHyRWnb91
         CSsQ==
X-Gm-Message-State: AOAM531kIUdwbcv/AE/FYuuMM79dBaOT616hMAk24Fez8758ETwlcPj+
        QvmnBB/Je77CBffE/T77JCxyXm/wSCfj+CSpMX0+yjObxso=
X-Google-Smtp-Source: ABdhPJxVoHkINxoHVcwpjKb5H2mf+PCk96C8H8NjHmmHKSj2jCyy9JQaKMXjWgAUtblIt5I3lhmhXgP43bagqQj52Ec=
X-Received: by 2002:a62:115:0:b029:1b4:c593:acd4 with SMTP id
 21-20020a6201150000b02901b4c593acd4mr5704865pfb.2.1611948106699; Fri, 29 Jan
 2021 11:21:46 -0800 (PST)
MIME-Version: 1.0
References: <20210129184905.29760-1-vincenzo.frascino@arm.com>
In-Reply-To: <20210129184905.29760-1-vincenzo.frascino@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 29 Jan 2021 20:21:35 +0100
Message-ID: <CAAeHK+w5hHcN-4Q8KYpMnG1rQvz9N_kXc7=uY07nH=937MUTjA@mail.gmail.com>
Subject: Re: [PATCH v10 0/4] arm64: ARMv8.5-A: MTE: Add async mode support
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 29, 2021 at 7:49 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> This patchset implements the asynchronous mode support for ARMv8.5-A
> Memory Tagging Extension (MTE), which is a debugging feature that allows
> to detect with the help of the architecture the C and C++ programmatic
> memory errors like buffer overflow, use-after-free, use-after-return, etc.
>
> MTE is built on top of the AArch64 v8.0 virtual address tagging TBI
> (Top Byte Ignore) feature and allows a task to set a 4 bit tag on any
> subset of its address space that is multiple of a 16 bytes granule. MTE
> is based on a lock-key mechanism where the lock is the tag associated to
> the physical memory and the key is the tag associated to the virtual
> address.
> When MTE is enabled and tags are set for ranges of address space of a task,
> the PE will compare the tag related to the physical memory with the tag
> related to the virtual address (tag check operation). Access to the memory
> is granted only if the two tags match. In case of mismatch the PE will raise
> an exception.
>
> The exception can be handled synchronously or asynchronously. When the
> asynchronous mode is enabled:
>   - Upon fault the PE updates the TFSR_EL1 register.
>   - The kernel detects the change during one of the following:
>     - Context switching
>     - Return to user/EL0
>     - Kernel entry from EL1
>     - Kernel exit to EL1
>   - If the register has been updated by the PE the kernel clears it and
>     reports the error.
>
> The series is based on linux-next/akpm.
>
> To simplify the testing a tree with the new patches on top has been made
> available at [1].
>
> [1] https://git.gitlab.arm.com/linux-arm/linux-vf.git mte/v10.async.akpm
>
> Changes:
> --------
> v10:
>   - Rebase on the latest linux-next/akpm
>   - Address review comments.

Thinking again about this: properly fixing that tracing issue is
similar to fixing the issue with the tests. Let's do both as a part of
this series.

Here's a tree with the fixes. I've marked the ones that need to be
squashed with "fix!". PTAL, and if the additions look good, please
send v11 with them included.

https://github.com/xairy/linux/commits/vf-v10.async.akpm-fixes
