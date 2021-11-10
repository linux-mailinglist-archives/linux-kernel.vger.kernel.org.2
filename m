Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A53D44C9F2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 21:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbhKJUEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 15:04:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbhKJUEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 15:04:10 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7913C061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 12:01:22 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id f18so8706012lfv.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 12:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bOoXuUtuBFoRdimZlGd0hZ6ppoJ6XBMiccEP8Jcpxhs=;
        b=MZmyZ7EZND/KW7gDRJdVoL1TbqyQJZ+vfp6RqIx5B7cXyksXKA7sESwCkNI1+b0W61
         EH0Sp8GJulueL72ug/1Y1cVwFcAxRLlmfYfVmgysp9MWji2A9TNuJRypFYtqvk9DDKZ2
         k8SGnFjVgcJNXFD2gQHMO49mW7dXk2zLavEvMen6gJHCzRV6LqTaC8wzyrnXYDkUFv4Y
         qXyF0S1hvDxP3xrM8k5F/7JjT3R+4IJuEi1IQJxkalqxIY5AhMEQffGvZfXW7fGpM3iM
         Z1c7koqmZirxdsUK3izqTqdpduaolQooJoYoXJD+8CTYImz3wruLbK++gKKefP8+u1rt
         2BjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bOoXuUtuBFoRdimZlGd0hZ6ppoJ6XBMiccEP8Jcpxhs=;
        b=sPFvOb0uKeYALviT27lIOU+yj/hudHGn1rkQ1xmKBD5LKy+82ZlzyfrQNRxqmLAPuK
         45IZhPsuFLr7Nfo2Kun9EFskgxU0w5If6RlG+3uEt/cEZCSS2TJbXCamlIlsO9s6cMPa
         LxRcuRoiCPyUjSGo6zngi3rxZo8i3b4WyjSyQs8yjJfKh025nw8SmvfuIyfAtLdpaaV5
         6WiAJMCsWcK/G6Qnb4O/vsq+ZrSo9F0hMZvH1sYSD7K85wLFNgWii32OGy0bPP9r/uPI
         Jtub31yHcNxZr4vsaah1SPRPgYGBE6emVXRvw2GJqtRX0AfAvMJYG1FkCWpqvfW6vCL/
         ZREQ==
X-Gm-Message-State: AOAM533FA4ECrKT45P2TDrefCXnTnOPPPgHBNMdp6LljP+4hDWmQa6NI
        6dHnBV+2Vmvbqe81s3WnF+rphGqmQ0BwMfPZMqCs+Q==
X-Google-Smtp-Source: ABdhPJx4e6muE3OOZUnw7SVZuFmf3EKEXLbwnBKp0zptjSoyknQolTyufouyua50ueW4r3IM+Ib/QfQfeJYxsvMJCzQ=
X-Received: by 2002:a05:6512:607:: with SMTP id b7mr1565363lfe.489.1636574480546;
 Wed, 10 Nov 2021 12:01:20 -0800 (PST)
MIME-Version: 1.0
References: <20211107162641.324688-1-masahiroy@kernel.org>
In-Reply-To: <20211107162641.324688-1-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 10 Nov 2021 12:01:09 -0800
Message-ID: <CAKwvOdmEU+GD3d+p8n3jnToKXgGcQN4EWSd+ATg_gs4Cwr4+gQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/vdso: remove -nostdlib compiler flag
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        clang-built-linux@googlegroups.com,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 7, 2021 at 8:27 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> The -nostdlib option requests the compiler to not use the standard
> system startup files or libraries when linking. It is effective only
> when $(CC) is used as a linker driver.
>
> Since
>
>   379d98ddf413 ("x86: vdso: Use $LD instead of $CC to link")
>
> $(LD) is directly used, hence -nostdlib is unneeded.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
>  arch/x86/entry/vdso/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
> index a2dddcc189f6..693f8b9031fb 100644
> --- a/arch/x86/entry/vdso/Makefile
> +++ b/arch/x86/entry/vdso/Makefile
> @@ -172,7 +172,7 @@ $(obj)/vdso32.so.dbg: $(obj)/vdso32/vdso32.lds $(vobjs32) FORCE
>  # The DSO images are built using a special linker script.
>  #
>  quiet_cmd_vdso = VDSO    $@
> -      cmd_vdso = $(LD) -nostdlib -o $@ \
> +      cmd_vdso = $(LD) -o $@ \
>                        $(VDSO_LDFLAGS) $(VDSO_LDFLAGS_$(filter %.lds,$(^F))) \
>                        -T $(filter %.lds,$^) $(filter %.o,$^) && \
>                  sh $(srctree)/$(src)/checkundef.sh '$(NM)' '$@'
> --
> 2.30.2
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20211107162641.324688-1-masahiroy%40kernel.org.



-- 
Thanks,
~Nick Desaulniers
