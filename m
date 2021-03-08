Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 142C7331903
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 22:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhCHVDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 16:03:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbhCHVCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 16:02:37 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692C3C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 13:02:37 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id lr10-20020a17090b4b8ab02900dd61b95c5eso1469616pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 13:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qVM6aF4+Z0E3PMKrGgvJCjoVZqdQ6xy0HWF9QbJkCLk=;
        b=RlT5RTElqPa03A8arxVZr3DBMCMCnALPaHiCl6JWLxVKLtkGPv/+ROmOk0tYmq2LOR
         jxRIU7Oiix/MS2fSCfawkOSKFw4z7nrqaHKK4YufTdVVl+9nSO3Vn6sEx2nI7CKdyJst
         8xI3so0PhxkzuTwMLYHI1k6T++aWZmMkr2RcVCddGMMz4qTDRvBhMfAxMgvopE/DSRIw
         CO4anmzLPvzN4UgaOx5+yBiONIkvfxWizbzQGhIo/MwEggk38+NVyhfUJvNatR7cMgbq
         C7qQ1Ca8ZhBNsAUtlbM6+dAS7xTJlBcBzGURCC7kZPDLiKeAv7/3m+w1EGIF2TDj4gVR
         SGCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qVM6aF4+Z0E3PMKrGgvJCjoVZqdQ6xy0HWF9QbJkCLk=;
        b=nJDVaVXaNoPjiPEyVdWfuoTwvXDOKP1eXxO5GZq3zqWQiiMyiWsqHIwnockg/L493J
         ow90tyF4iNzAP/W7DDhFeGKsm42FRJO+DZpM8KmAsa77yhxW/SaZhiUrJ4CSLLSYrMTn
         wRaNme3O8id/mbzQqoYMBHRJRXmIsVinT1AK5BCNOmhLO7vhYmnA2rqdCw03opXDYKrv
         Hde1n2MXPhQ3z85muGPQGZ1KLahG0KM0TjEistPxeSE4qtLB3TrIfoE62rYS0GxAfta9
         7PBxpXCqBjCMS1DgG/0+wxMNb/KCoowYd/JUXKDhYtiSJJEOEHDKYZ66wYb6wmjgygL1
         UySg==
X-Gm-Message-State: AOAM5311xMVoeiflkpzJqsZeyZJhfE3RZ0GHvr6RgUuZmeZQyzwDdRii
        6CDI6io7XHHJyBsOG8nJAn2VYYKdnAXcida/cxC4Mg==
X-Google-Smtp-Source: ABdhPJyLdMAXvzF8zJTJyhVhLwce0bXWxv7Hn2L0ZQO4cpRHP+UUi199V4TYicINA1bULiEGm6p7h/Zvc/rdxF1ZQYY=
X-Received: by 2002:a17:902:8641:b029:e4:7e05:c916 with SMTP id
 y1-20020a1709028641b02900e47e05c916mr21769229plt.57.1615237356824; Mon, 08
 Mar 2021 13:02:36 -0800 (PST)
MIME-Version: 1.0
References: <20210308161434.33424-1-vincenzo.frascino@arm.com>
In-Reply-To: <20210308161434.33424-1-vincenzo.frascino@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 8 Mar 2021 22:02:25 +0100
Message-ID: <CAAeHK+xEc8spQWh9Mz7z-mVQRavD2y84ufnGx6cm-gK3AkJfAw@mail.gmail.com>
Subject: Re: [PATCH v14 0/8] arm64: ARMv8.5-A: MTE: Add async mode support
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
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 8, 2021 at 5:14 PM Vincenzo Frascino
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
> [1] https://git.gitlab.arm.com/linux-arm/linux-vf.git mte/v12.async.akpm

Hi Vincenzo,

As previously discussed, here's the tree with tests support added to
this series:

https://github.com/xairy/linux/tree/vf-v12.async.akpm-tests

Please take a look at the last two patches. Feel free to include them
into v15 if they look good.

Thanks!
