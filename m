Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04C3D3FCB13
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 17:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239421AbhHaP4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 11:56:02 -0400
Received: from mail-vs1-f49.google.com ([209.85.217.49]:43756 "EHLO
        mail-vs1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238994AbhHaP4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 11:56:01 -0400
Received: by mail-vs1-f49.google.com with SMTP id m19so13648863vsj.10
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 08:55:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rXAig6svknWENNxhE5MWFDZ85DSokchu1E/IR78sJuc=;
        b=gBPL4dgySVCLJIvh2wTzQzJga4T3HNlaBo5OWe9oyrVTgUMFqakrgw+yVpeotfo7Y0
         eT+Z9WDCiFxsD/4PSqkqkRm0V5GO9gEuqOxpIFb4HDqMphnVQ+5SL+ehCaxzDH2N2LVZ
         5zvkzTMeJGyn99GinfX8XDHZQd+zMcoRBJwtaWLvcfPynsbvxFa8XiBykOr0eW2YJ526
         m/S/N04ZQZUvRWjytyrv+lEakUHHkIk6i6rCc7kS8j04CcC4h3rZRg+7toLWdEYxTE40
         wVeaHoPjM9cimhe0LKrcxw1vC96CkNCB1FoXzd+ppS3CvkY+8AjVXr98O4272TrhFJOe
         SOWA==
X-Gm-Message-State: AOAM531OFXSZQmWyn+4HskCjBBKYIpgatCFQSd4kSx5JLQlM6RO+yRBT
        3YqC2XovQCCOA227ifZQ+YJfAjo7PxJjD7xOqMc6zpgd
X-Google-Smtp-Source: ABdhPJwd3g3qcsq1rJfE/U29ijK2E1/xXlt4GtyR/vrF5Gnlkgm76LK5kuxADxvS2KbERjJuC/N8lbT7cr8u52dbA/o=
X-Received: by 2002:a67:3349:: with SMTP id z70mr18508950vsz.7.1630425305956;
 Tue, 31 Aug 2021 08:55:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210831062539.898293-1-imran.f.khan@oracle.com> <20210831062539.898293-2-imran.f.khan@oracle.com>
In-Reply-To: <20210831062539.898293-2-imran.f.khan@oracle.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 31 Aug 2021 17:54:54 +0200
Message-ID: <CAMuHMdUwdGHjOH7GTpq0nNg7Mx5bAwGEWJwEwUSoJL3GrEfv_A@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] lib, stackdepot: Add input prompt for STACKDEPOT option.
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Imran,

On Tue, Aug 31, 2021 at 8:28 AM Imran Khan <imran.f.khan@oracle.com> wrote:
> So far CONFIG_STACKDEPOT option was being selected by
> features that need STACKDEPOT support for their operations,
> for example KASAN.
> Since next patch makes use of STACKDEPOT to store user tracking
> information for slub debugger and since user tracking info may
> or may not store stack trace for allocating and freeing contexts,
> make STACKDEPOT explicitly configurable.
>
> Signed-off-by: Imran Khan <imran.f.khan@oracle.com>

Thanks for your patch!

> ---
>  lib/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 6a6ae5312fa0..7e4b54f48af7 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -665,8 +665,9 @@ config ARCH_STACKWALK
>         bool
>
>  config STACKDEPOT
> -       bool
> +       def_bool n

Why this change? "n" is the default anyway.

>         select STACKTRACE
> +       prompt "Enable stackdepot support"
>
>  config STACK_HASH_ORDER
>         int "stack depot hash size (12 => 4KB, 20 => 1024KB)"

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
