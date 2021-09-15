Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E74C40C0B8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 09:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236703AbhIOHqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 03:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbhIOHqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 03:46:35 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBC5C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 00:45:16 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id c21so3022558edj.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 00:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HxQjhQXN3bRnhRUJpqv4hHysfQ80FIOsFoJ2cZMAAUM=;
        b=cKUx5CxpCpbAAq2qCxIMvKNBhIz0fx5suWBiceWCMArEhS2ray50WNIn86PB3s2gwF
         g3llTqFtrqh4uhD8cyU6G07ebbdkkRrs6hJ5b1vCVC7jHW8xl6vm+KyvH7iPbvQej8XL
         DEbEG39H8zUZAwIrvMgU20zMi1WAll0xX8E+MY5Cjr44MK5jAL8qieKpEDVSSs2GiVNx
         GkP7uIL82ZWMoclgFUixzYZCH9uuCQoHvcxLmAK2WKrAQ6GZKQUAo/25GDTJwkkHy+th
         n0Zys+DP4glpLPMpAJDO0cUF24R6zBbi2Y6QZalxpbnAqu7XCHY6JHQbJvYkK5utgM5P
         Tdjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HxQjhQXN3bRnhRUJpqv4hHysfQ80FIOsFoJ2cZMAAUM=;
        b=AdXLB/lQkozHsmcCJDvdZKOr7X1mT7lvml2yri2tQsdkd3SPUCvWafR1xH/xQRzi+a
         zg2e5lQ9jKsUOOJtKVwJqJSl9tUs/ZMY0yW7TxjTyjxUsAELO6jSoeyAYUqmJBVqWpP3
         de7kqJH4VETS7WmLaWr7gpWfKrl2r5lEz+HurOrPzoMYFt7XuO+F4+vqax1FrfPIFxLM
         xVZQ1NSp/1fo5ZCHTyd9JEqwAMhsYaGJBQcR6r7HFg/CcHVPkYmvYLJp4ELW/EhqLU8y
         4TLDTHjOwBngi7J0+jqTU6qtJf2JK4OaEdwOF9CEy/Tjw76XFVKqINpNugfUscgEE+2d
         uFtg==
X-Gm-Message-State: AOAM533Txr0NFTI+gz73Ke+7bKKLo7yULVl5YivUakcdWPZxessIFHii
        4L4OK/VYI9UiqegjgFMiVpgfqrb6ArkcxmXPCG4+VMSPeG8geA==
X-Google-Smtp-Source: ABdhPJwMf2J9lQa4aZ4sqX+mDRjKrFb64KoUdLZzpc3BWNNgS2vsX6aXpn2XojPVDtl8kfSa0snk3hTTR6eKgSs3a8Q=
X-Received: by 2002:aa7:dcd0:: with SMTP id w16mr24185019edu.288.1631691915298;
 Wed, 15 Sep 2021 00:45:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210913163547.5156-1-will@kernel.org>
In-Reply-To: <20210913163547.5156-1-will@kernel.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 15 Sep 2021 13:15:03 +0530
Message-ID: <CA+G9fYtmyKL-z-mf=VM2EczdnjXX77U9k+q2EJgjSY0-eB4dJQ@mail.gmail.com>
Subject: Re: [PATCH] x86/uaccess: Fix 32-bit __get_user_asm_u64() when CC_HAS_ASM_GOTO_OUTPUT=y
To:     Will Deacon <will@kernel.org>
Cc:     open list <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Sept 2021 at 22:06, Will Deacon <will@kernel.org> wrote:
>
> Commit 865c50e1d279 ("x86/uaccess: utilize CONFIG_CC_HAS_ASM_GOTO_OUTPUT")
> added an optimised version of __get_user_asm() for x86 using 'asm goto'.
>
> Like the non-optimised code, the 32-bit implementation of 64-bit get_user()
> expands to a pair of 32-bit accesses. Unlike the non-optimised code, the
> _original_ pointer is incremented to copy the high word instead of loading
> through a new pointer explicitly constructed to point at a 32-bit type.
> Consequently, if the pointer points at a 64-bit type then we end up
> loading the wrong data for the upper 32-bits.
>
> This was observed as a mount() failure in Android targetting i686 after
> b0cfcdd9b967 ("d_path: make 'prepend()' fill up the buffer exactly on
> overflow") because the call to copy_from_kernel_nofault() from
> prepend_copy() ends up in __get_kernel_nofault() and casts the source
> pointer to a 'u64 __user *'. An attempt to mount at "/debug_ramdisk"
> therefore ends up failing trying to mount "/debumdismdisk".
>
> Use the existing '__gu_ptr' source pointer to unsigned int for 32-bit
> __get_user_asm_u64() instead of the original pointer.
>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Bill Wendling <morbo@google.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Fixes: 865c50e1d279 ("x86/uaccess: utilize CONFIG_CC_HAS_ASM_GOTO_OUTPUT")
> Signed-off-by: Will Deacon <will@kernel.org>

This patch merged into Linux next (next-20210914) and the reported
problem has been fixed.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

--
Linaro LKFT
https://lkft.linaro.org
