Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C333502E2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 17:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235487AbhCaPCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 11:02:09 -0400
Received: from mail-ua1-f43.google.com ([209.85.222.43]:43958 "EHLO
        mail-ua1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235114AbhCaPB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 11:01:57 -0400
Received: by mail-ua1-f43.google.com with SMTP id b7so6173009uam.10
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 08:01:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1mc9nk86dCN75VHp4R/+UxN4s8fz6T5fsikzkkqFEsQ=;
        b=rcfsDv/kL7EyRTTfUoDRqFJ/61AzekbtLVVmOB8ZiDWMb8MnADWMCAdGy/JcSWwpaT
         dqcKrIZopB+XBnEing2NrEkZ7vLlTPxFG9uxjfA1HjAqEQVOlK3ZqH/vdqGyWOq2e1rU
         U80pbhhkBYQBujvxYybiE+BnaFfSbTsAI7N4oy5n+mZ5Aix3qqP9SA3SNQhfRpowSJwr
         SmL6isUgDLou2nOhfW6UuLMCwulkg6R3OuIhO5e59T7Dw2Pwkl0nb+Xtpb2s2bMEBknM
         5PeXYTVkiQ1CvyOn4Z07AwHEWfKlzLERaqrVciUldg3hH4uGPIg1vZe/gpBlWKhzivFI
         YGDQ==
X-Gm-Message-State: AOAM531q/L5f6vtl99ZzqV/uYNNwqpz5/sQeMKv836iO5Yb1jbM5juLh
        zpXdcX1x1oob1dVI9LE3YWEAel2kP6wtjop4u/s=
X-Google-Smtp-Source: ABdhPJwv4UB5s4DrbZZrnToPi7FlyCQu9FFusTEse7S+9tKnQx8PerYCa0X16G17xqd6zcem/NHi8kzk7ZZIQsBRMrw=
X-Received: by 2002:ab0:64cf:: with SMTP id j15mr1794879uaq.4.1617202917239;
 Wed, 31 Mar 2021 08:01:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210331144336.25628-1-masahiroy@kernel.org> <20210331144336.25628-2-masahiroy@kernel.org>
In-Reply-To: <20210331144336.25628-2-masahiroy@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 31 Mar 2021 17:01:46 +0200
Message-ID: <CAMuHMdW5+ZgLeJ_jFBiWLL0MGEQZhXx56AuJNQb4p8UvQsGB1g@mail.gmail.com>
Subject: Re: [PATCH 2/2] m68k: remove meaningless EXTRA_LDFLAGS
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 4:44 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> These two Makefiles contain only built-in objects (i.e. obj-y), which
> are collected by $(AR) into a thin-archive.
>
> EXTRA_LDFLAGS is meaningless because $(LD) is not used here.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v5.13 branch.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
