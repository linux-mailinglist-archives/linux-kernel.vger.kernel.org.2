Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC3BE3D49F2
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 22:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhGXUEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 16:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbhGXUEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 16:04:23 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD07AC061575
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 13:44:54 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id q17-20020a17090a2e11b02901757deaf2c8so8781408pjd.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 13:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=AEgVPunMfOUWF41Ji9kSiUdVwjfFjhBj8emwtXLE7Eo=;
        b=VIibu6WVgKujJFY6O2lnZj4Mv46J+Ak9vIKq7Igsbf9nyh1H/N7yNWHurYxrPoo1TP
         1JTvOR6IRC2pQVR1NW9jHnzjRHtrn1Ph3WnUdgFl08ygfafF2UZKN/6W9PkyWeaP/7ml
         Z9lCXFKeAwl9rDXG+4lKOvnfUiVNrG0CVCEeORpUWBie3onvm7tVzx8uM/4hikU6Jipv
         /q1Y1v+fGdCJ6S1Wn5CDq387L7YUL3XJrsZXi4R5wuNFaoDglzjMcj3nAQ2pTHqh4pi9
         VUs2NuJ687TdOlvFeaMU8rW7tsa9OVOyzBofsKtvtIOC+oQCCYvIl4bH/pofjJaWBZQ4
         aZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=AEgVPunMfOUWF41Ji9kSiUdVwjfFjhBj8emwtXLE7Eo=;
        b=cq93Yz0ICR4s1DdzJNocgrQYZ6UYWEFwhDfg76Vs1ODhcPL8MWxe6QmFybltOdhWbC
         eJNvzZCMR887nWQU34jBYGQBaFT0uyhjdXBqtUPx5Z60TxSy5MBUOixyFUqc6VfQT4/a
         Mio74EqlR+vVqgCRFcWxlH7r/UuC3+ahsPbKnvf9yzSDl0r7z8L16RLuMJow8O4sxgU1
         2PMw4BuRbx7rmx3AU12QSSUstrJsumzaZpHHfbR11OzpsooqCp5UepBLYQIUT4oZB4Hz
         VQtf697UdUcRmcspZbkkx6QLVtViZZLCu8misJXJf8fcWd05xNb+kH/zSAsfmXF5THTf
         LGtQ==
X-Gm-Message-State: AOAM531DRTKjmmGO64cKqUb8vLse5mW2v4RaudW4BjRRQgb8e9Xy7cIN
        5Y3HGnikUOISVaxKczrXYV/ZSw==
X-Google-Smtp-Source: ABdhPJz1SGYTzDUo4dIm5rW7aRmU0r78xpAbrQipWGrWin01hgv2RXlWbZgu4exhB/2aL+2jc6BXMg==
X-Received: by 2002:a17:902:d682:b029:12c:13e9:adaf with SMTP id v2-20020a170902d682b029012c13e9adafmr343853ply.74.1627159494416;
        Sat, 24 Jul 2021 13:44:54 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id m18sm39302378pff.88.2021.07.24.13.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 13:44:53 -0700 (PDT)
Date:   Sat, 24 Jul 2021 13:44:53 -0700 (PDT)
X-Google-Original-Date: Sat, 24 Jul 2021 13:44:51 PDT (-0700)
Subject:     Re: [GIT PULL] RISC-V Fixes for 5.13-rc3
In-Reply-To: <mhng-5cd676be-7ed7-48de-b740-0e809ae67a56@palmerdabbelt-glaptop>
CC:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-3e77f70c-4c2d-416f-8d07-3fffd2a23aa4@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Jul 2021 13:44:02 PDT (-0700), Palmer Dabbelt wrote:
> The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:
>
>   Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.14-rc3
>
> for you to fetch changes up to ea196c548c0ac407afd31d142712b6da8bd00244:
>
>   riscv: __asm_copy_to-from_user: Fix: Typos in comments (2021-07-23 17:49:12 -0700)
>
> ----------------------------------------------------------------
> RISC-V Fixes for 5.13-rc3

Oops, that should be 5.14-rc3.  The tag name is right.

>
> * A fix to properly set the memory size, which fixes 32-bit systems.
> * A fix to allow the initrd to load anywhere in memory, rather that
>   restricting it to the first 256MiB.
> * A fix for the mem= parameter on 64-bit systems, to properly account
>   for the maximum supported memory now that the kernel is outside the
>   linear map.
> * A fix to avoid installing mappings into the last 4KiB of memory, which
>   conflicts with error values.
> * A fix to avoid the stack from being freed while it is being walked.
> * A handful of fixes to the new copy to/from user routines.
> ---
> There is one particularly odd bit in the history here: the fix for the 32-bit
> boot failure is based on an older release, because a recent feature addition
> also fixed the bug.  I wanted to take that patch so it could be backported to
> stable, but it's erased by its own merge.  Not sure if there's a better way to
> do this, but I figured this was saner than reverting the feature and then
> bringing it back.
>
> ----------------------------------------------------------------
> Akira Tsukamoto (4):
>       riscv: __asm_copy_to-from_user: Fix: overrun copy
>       riscv: __asm_copy_to-from_user: Fix: fail on RV32
>       riscv: __asm_copy_to-from_user: Remove unnecessary size check
>       riscv: __asm_copy_to-from_user: Fix: Typos in comments
>
> Alexandre Ghiti (3):
>       riscv: Fix memory_limit for 64-bit kernel
>       riscv: Make sure the linear mapping does not use the kernel mapping
>       riscv: Make sure the kernel mapping does not overlap with IS_ERR_VALUE
>
> Bin Meng (1):
>       riscv: Fix 32-bit RISC-V boot failure
>
> Heinrich Schuchardt (1):
>       RISC-V: load initrd wherever it fits into memory
>
> Jisheng Zhang (1):
>       riscv: stacktrace: pin the task's stack in get_wchan
>
> Palmer Dabbelt (1):
>       Merge remote-tracking branch 'riscv/riscv-fix-32bit' into fixes
>
>  arch/riscv/include/asm/efi.h   |  4 ++--
>  arch/riscv/kernel/stacktrace.c |  6 +++++-
>  arch/riscv/lib/uaccess.S       | 27 +++++++++++++--------------
>  arch/riscv/mm/init.c           | 32 ++++++++++++++++++++++++++++----
>  4 files changed, 48 insertions(+), 21 deletions(-)
