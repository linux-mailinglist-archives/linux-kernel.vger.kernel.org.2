Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4BD6374FF4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 09:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbhEFHU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 03:20:57 -0400
Received: from mail-vs1-f48.google.com ([209.85.217.48]:40513 "EHLO
        mail-vs1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233127AbhEFHUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 03:20:54 -0400
Received: by mail-vs1-f48.google.com with SMTP id o192so2437420vsd.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 00:19:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WNhCIMMz7EzD3Z1FLPhhrJxU/Pgtk8lSDeyYeHyvjnk=;
        b=l759jmjeaf3yFBDuOjS16wacqTsuGq+UF+0Z82XA8l+vBNUxz2knrAU+nSEksZ63oz
         eEqGlv5bBFWiz7ZA6pFpeV74Ze/MUNAcT5nOytDGfd4KegABlyXX96H+EPG19DpptjL7
         +POCpt32b6Z05KtnUR8vMwnO+xS4/Kz3tmy3E4sKWoESvEYwQIS0c2OQK9hvqD9FfXNO
         bY9vMpzPBQnRY5gzncqTpBWu1kxuvoCKE1ByMH1NxunvYkUEN3YD/cSgKZ1hesAwZTIs
         UW/vsoy2P/SoLmCy/G5NukfxDn2zyk/Dm3EOmTVUiOYFfVQayEcKMaieDdF6CVpK/3/v
         KOGw==
X-Gm-Message-State: AOAM531/t5n5uBpWBbrswvOTh5UB6CnuYx7Oa9X1Cge0ZjYejhMy0LgA
        5l4P0s1H1QggZj4d4VmBFZvGyhnMQPxxqlHGUIo=
X-Google-Smtp-Source: ABdhPJzTeKFGFQqvUEjFf5Vbfbp5PKOUppqjU6DRC6fr+Pd7kUthXHrPr+geHxvbYr1zsn8WsIfhFueF7awWQJmholI=
X-Received: by 2002:a67:f25a:: with SMTP id y26mr2273655vsm.40.1620285596056;
 Thu, 06 May 2021 00:19:56 -0700 (PDT)
MIME-Version: 1.0
References: <baa95d7235921dff23bed6320518f3fa90396603.1612681353.git.fthain@telegraphics.com.au>
In-Reply-To: <baa95d7235921dff23bed6320518f3fa90396603.1612681353.git.fthain@telegraphics.com.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 6 May 2021 09:19:44 +0200
Message-ID: <CAMuHMdVurQcwHcP7QnOrxLVuqUAnokJ-2R+11FOyG-htS9Fu9w@mail.gmail.com>
Subject: Re: [PATCH] m68k: Drop -fno-strength-reduce from KBUILD_CFLAGS
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 7, 2021 at 8:08 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> This workaround became redundant either when the driver in question was
> removed (in Linux v2.6.23) or when the compiler flag became a no-op
> (in GCC v4.2). Linux has required GCC v4.6 or later since v4.19.
>
> Link: https://gcc.gnu.org/git/?p=gcc.git;a=commitdiff;h=efa1cdf01850b28c2f6f7035ebd4420259494615
> References: commit 565bae6a4a8f ("[SCSI] 53c7xx: kill driver")
> References: commit cafa0010cd51 ("Raise the minimum required gcc version to 4.6")
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v5.14 branch.

> --- a/arch/m68k/Makefile
> +++ b/arch/m68k/Makefile
> @@ -66,8 +66,7 @@ KBUILD_CFLAGS += $(cpuflags-y)
>  KBUILD_CFLAGS += -pipe -ffreestanding
>
>  ifdef CONFIG_MMU
> -# without -fno-strength-reduce the 53c7xx.c driver fails ;-(
> -KBUILD_CFLAGS += -fno-strength-reduce -ffixed-a2
> +KBUILD_CFLAGS += -ffixed-a2
>  else
>  # we can use a m68k-linux-gcc toolchain with these in place
>  KBUILD_CPPFLAGS += -DUTS_SYSNAME=\"uClinux\"

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
