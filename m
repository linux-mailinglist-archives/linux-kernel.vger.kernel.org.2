Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E931B405BE7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 19:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbhIIRVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 13:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbhIIRVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 13:21:14 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06430C061574
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 10:20:05 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id n2so5207406lfk.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 10:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kqUD7oeU8HrXDjBJQpN5xhdFutamIM3hkjDh1/885jM=;
        b=H77m2xie2dGASo7ILgUvr71C7Qyqg/VE3sFblaFoqMcqegsT2Wn5FRFaHIJlFTVlba
         x10XdWIQ+3jezU+CqJLCBLOeH5ldw9YTYCWs+c49pMo+ohTapGe4pvcWOvqj66oYYvRg
         ZMwZVaJkS+WD8bUQTy81ixX5ca0baC8Vc7U8kFHWQvyCTM1rh2ZX/e4Gn2zEN2xENstY
         jsMQCjl3jUAIAn9FSS6mniigRNYmjyNfVFodERHKVr+CtAKg852CAmf4TdCKzP7XQMSd
         6rNyqLQuD0nT7qQKmLWgBE11J6elARXD5DAmUHWbDWYwWoZIgvkw6oQDQ4SugROj1qQv
         TzaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kqUD7oeU8HrXDjBJQpN5xhdFutamIM3hkjDh1/885jM=;
        b=4Ef7cQrQ9q2L/qfwx0rNJj7nYHjXgZGjsE8tHBsdOF2p0rCEKc/BBUmRn4z82xb9/I
         LEkVFgT6c4PpSFiKJi4NogiNL9SD/6E5a3pvKWzMBS5KiSyTbkWgaDH7AiLc8RLHms3D
         HBC87Ld0VjaLRY+UvsS7q+Qc1NF9RwgEwYYuFs9Nlzz2FUgte2+oWHpvUVzaVRz0jthc
         RJ4dIx7z+9rAL7vIde0gGUx2qJw8KnmlWAmxwji14B4G4+fd9dr135oyWAO7GOYo8Fc2
         88R6YrzLqnhvVqOsKlj1++1oMcSDjpBDKaKIfei2BiWJsrUPWJ4cAvbgsli8YlHRZQMd
         BVlQ==
X-Gm-Message-State: AOAM5325ftBrrA7G+/otM39Iqsr+/42f1JvuBVsoLwitaVk/CNcjKSaL
        zBD040zh+2q9f80kZDQeHJjyAJYY/iSXdFbktxVluw==
X-Google-Smtp-Source: ABdhPJx1Gd3h1I6lfLJre8pI7N4/5nUmVmFOR0uKMHU0YO+3eibPqTMvFa8njk1IhOYBx9H5vzTMz3NF2T9TAa4YYFk=
X-Received: by 2002:a05:6512:139c:: with SMTP id p28mr642656lfa.523.1631208003105;
 Thu, 09 Sep 2021 10:20:03 -0700 (PDT)
MIME-Version: 1.0
References: <1631173363-40160-1-git-send-email-ashimida@linux.alibaba.com>
In-Reply-To: <1631173363-40160-1-git-send-email-ashimida@linux.alibaba.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 9 Sep 2021 10:19:52 -0700
Message-ID: <CAKwvOdnuiV3mHxxCpWbMaZn9vggL4B+PPrMtuX=QOO-yUQj2mA@mail.gmail.com>
Subject: Re: [PATCH] [RFC] kbuild: add CLANG_TRIPLE to prevent clang from
 compiling with wrong --target
To:     ashimida <ashimida@linux.alibaba.com>
Cc:     masahiroy@kernel.org, michal.lkml@markovi.net, nathan@kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Alistair Delva <adelva@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 9, 2021 at 12:42 AM ashimida <ashimida@linux.alibaba.com> wrote:
>
> Kernel compiled with tool chain CROSS_COMPILE=aarch64-linux-android-
> will panic during the startup phase.
>
> Clang's --target option comes from $(CROSS_COMPILE). At the time
> -fstack-protector-strong is enabled, and compiled with command:
> make CC=clang HOSTCC=clang ARCH=arm64 CROSS_COMPILE=aarch64-linux-android-
>
> clang will insert code like:
>    mrs     x8, TPIDR_EL0        //default value is zero
>    str     x8, [sp]
>    ldr     x8, [x8, #40]        //access addr 0x40
>
> instead of the code that accesses __stack_chk_guard to get the
> canary, which will cause the kernel to crash due to 0x40
> address access.
>
> This patch (from android) is used to remind the user that current
> tool chain cannot be used as the "--target" of clang, the user
> should specify an additional "--target" through CLANG_TRIPLE.

Hi Ashimida,
Thanks for sending this patch; I recognize it from Android, which we
had to carry for years due to:
1. reliance on GNU `as` ie. "GAS"
2. not distributing binary prefixes of GNU binutils with a target
triple that clang recognized. (ie. Android's binutils were prefixed
aarch64-linux-android- while Clang expected something more like
aarch64-linux-gnu for --target=)

We solved this by working out the issues in clang's assembler.  With
LLVM=1 LLVM_IAS=1, we no longer rely on GNU binutils, and no longer
need such patch.  You'll find it's been dropped from Android Common
Kernels now.  With mainline, LLVM_IAS=1 is now the default when
building with LLVM=1, and CROSS_COMPILE is now inferred from ARCH for
LLVM=1 as well.

So all you should need is:
$ ARCH=arm64 make LLVM=1 -j$(nproc)

Is there a reason why the above doesn't work for you?  I do not wish
to see this patch upstream (or downstream; it should be unnecessary).

>
> Signed-off-by: ashimida <ashimida@linux.alibaba.com>
> ---
>  Makefile                 | 6 +++++-
>  scripts/clang-android.sh | 4 ++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
>  create mode 100755 scripts/clang-android.sh
>
> diff --git a/Makefile b/Makefile
> index 61741e9..09bb314 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -586,7 +586,11 @@ CC_VERSION_TEXT = $(subst $(pound),,$(shell $(CC) --version 2>/dev/null | head -
>
>  ifneq ($(findstring clang,$(CC_VERSION_TEXT)),)
>  ifneq ($(CROSS_COMPILE),)
> -CLANG_FLAGS    += --target=$(notdir $(CROSS_COMPILE:%-=%))
> +CLANG_TRIPLE    ?= $(CROSS_COMPILE)
> +CLANG_FLAGS     += --target=$(notdir $(CLANG_TRIPLE:%-=%))
> +ifeq ($(shell $(srctree)/scripts/clang-android.sh $(CC) $(CLANG_FLAGS)), y)
> +$(error "Clang with Android --target detected. Did you specify CLANG_TRIPLE?")
> +endif
>  endif
>  ifeq ($(LLVM_IAS),1)
>  CLANG_FLAGS    += -integrated-as
> diff --git a/scripts/clang-android.sh b/scripts/clang-android.sh
> new file mode 100755
> index 0000000..9186c4f
> --- /dev/null
> +++ b/scripts/clang-android.sh
> @@ -0,0 +1,4 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +
> +$* -dM -E - </dev/null 2>&1 | grep -q __ANDROID__ && echo "y"
> --
> 2.7.4
>


-- 
Thanks,
~Nick Desaulniers
