Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E62642494F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 23:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239777AbhJFWAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 18:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbhJFWAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 18:00:02 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE65C061746
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 14:58:09 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id z11so8127585lfj.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 14:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a2vkiFNg4+cpDMQYRGibcmjYWmRafNbbIdjbDKvPRkE=;
        b=X6ggAXaJ/6+8Zfg/+iL0FXZCq9u1ZMqPbdGye1+9hEI/sMMwmTifOjB9SuH0dsxOtE
         mD11mblNMsgYWwxQ6ZgGzzSLcuCYOsCXWd0wjQNEkIAQybnhlL8wC3os1S5cTitJ4quH
         rZsBFQyGanaU9dgCrtE5KawCgf2RVs2eodKvXlBR0gYAwTSicHnabyHuplA5XFEYOuYb
         QQhm1PbUVCPUwApDXkpoEx5b1/n3VqdZLDOJOVUbjpWOU5PjxMg+M9UFsrVO5lF99j56
         9BdMLVlt96XhcihBC9Gn6qjuRXRQ1LP+igPQgRNAaCK++1atlBJOmmO+5WZ88e9jBNoJ
         kwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a2vkiFNg4+cpDMQYRGibcmjYWmRafNbbIdjbDKvPRkE=;
        b=wFS1OGVNRVasZ1lfYd/oQuMjlufs5B64SirHI2tCTglEPJ3OM/imf2VJuVlJKGMFM1
         AVcQqAyq/0OLz5bMrSN5QKr3Wha/eP7F9Nho02vx/56jLIlhSVmILWOfxi/HuH7b3YGE
         JR1rRbWD9lG2fGijJ0iFb3qaOVr8oDpvkAKSmYZLmbr2aGKY1EqKIgFUz4AOEEl1oCGt
         hiZTlltfumwb9qgsLof2b7G4zm95FKNT3Pa3dyoet7IXL+gdRVdOUvTGjK/Rb1QVzu8L
         Qr49UjbP/YV+N+WXyNzXOb+LqOZ1H0sIuiH1w5Yd0SsvOfzqzFidP1UZA2XYn3iTsMGV
         B0hQ==
X-Gm-Message-State: AOAM531VB5aBVc9dzHVZMM3FB+fy8mXsAqHRKi/eM2xAqd5+lVs0oxFE
        G2t+vCWzFl0sNp7mRtR0YzxjcMMrII82Mo4zyDhVsA==
X-Google-Smtp-Source: ABdhPJyOusrlIq/p6kjOO4UVXQHzZYy/q9uQ/yGH7/bc4rLTdC5K9cYr5LUo8StNlvWhvQIxCR6nue2yqhzEBe5MG6k=
X-Received: by 2002:a05:6512:31e:: with SMTP id t30mr520776lfp.82.1633557487467;
 Wed, 06 Oct 2021 14:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <20211006181119.2851441-1-catalin.marinas@arm.com>
In-Reply-To: <20211006181119.2851441-1-catalin.marinas@arm.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 6 Oct 2021 14:57:56 -0700
Message-ID: <CAKwvOdk2tj0bzTajd6F4bPvwXComJSnS+8Jwj3t7EEP5gGoK+A@mail.gmail.com>
Subject: Re: [PATCH] elfcore: um: Fix CONFIG_UM typo in linux/elfcore.h
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Barret Rhoden <brho@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 6, 2021 at 11:11 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> There is no CONFIG_UM, only UML. In addition, the arch/x86/um/elfcore.c
> file is only compiled if CONFIG_X86_32. Fix the #if conditions in the
> linux/elfcore.h header accordingly.
>
> Fixes: 6e7b64b9dd6d ("elfcore: fix building with clang")
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>

Lukas noticed and sent a patch coincidentally just before you:
https://lore.kernel.org/lkml/20211006082209.417-1-lukas.bulwahn@gmail.com/

Let me cc' you and Arnd into that thread.

> ---
>
> I'm doing some arm64 changes to allow MTE tags to be dumped in the core
> file and I came across this. In a subsequent patch I'll change the #if
> check with a dedicated Kconfig option but I thought I'd send the fix
> first in case anyone deems it important to backport.
>
>  include/linux/elfcore.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/elfcore.h b/include/linux/elfcore.h
> index 2aaa15779d50..957ebec35aad 100644
> --- a/include/linux/elfcore.h
> +++ b/include/linux/elfcore.h
> @@ -109,7 +109,7 @@ static inline int elf_core_copy_task_fpregs(struct task_struct *t, struct pt_reg
>  #endif
>  }
>
> -#if defined(CONFIG_UM) || defined(CONFIG_IA64)
> +#if (defined(CONFIG_UML) && defined(CONFIG_X86_32)) || defined(CONFIG_IA64)
>  /*
>   * These functions parameterize elf_core_dump in fs/binfmt_elf.c to write out
>   * extra segments containing the gate DSO contents.  Dumping its



-- 
Thanks,
~Nick Desaulniers
