Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6ACB3AB39E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 14:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbhFQMf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 08:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhFQMfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 08:35:24 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07A2C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 05:33:16 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id y15so4903058pfl.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 05:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qw5j2pWzqbWJOcDMTiutKDLrZNJ5CmDl2cszSS1n3VQ=;
        b=nu3M8N9FLDMYEv3mqulW4zo7DRwTysVeor33sV4CuoHv7R3juqt62gB5FTr0FgzJ0H
         nVTiczA1FYIv8ymXZzj8VgCRBdv4OI9i3s7KUgUh6l+qzGWOHXZdUiIkBjdou19gC/sV
         exDwXhAnJ8lGNtYrkZO+fjy9u7cPmDzccgtepBawvdqbQd7I8CMrdRCfVZsbtqMKXzX8
         vI3qhS5IG+y+QJp8A8pLqvEHxWY5K7uk9i+sQM3LEusofKHq7+p4KXxe9DqxVdyxGmCt
         SsaPhKfANSSGOHm1yOSYpG0xFeWbQblvHRKz5p+ca0/umglCIZjuGUOhW3uhNnOG2oMQ
         TRDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qw5j2pWzqbWJOcDMTiutKDLrZNJ5CmDl2cszSS1n3VQ=;
        b=MLu+O7AqD2RnSPWghEy0FxNuwuQzAqh+nCc4vNFCL0C5SDZpZ2XCWj8ezH4xBhDZSI
         B3sPQ197XJppZ1WGfp144MvSYcDPz1Bl3+8+pqWrMQnz9+QxsLjc6H+LxjQkySmS3qfL
         lUCp2PMSCghZFhakCNRbWVc8W3Qtqe8SENkx3NTsSHPzsJN5xT0fcJzr8rE661k1TfZf
         ySncPGc2wyv9sVLdi/3Jl8s27QV/Y8wbnwgRs5oZAwY78QxJLHmmYKIQ7FRHJULUKk+U
         zHCp87z4KrOntWjKHnMQzucgAuB9KtP0hs7p5pw5FTjXq2rjq1Kl7XTyVU74IYkGpAwE
         apkg==
X-Gm-Message-State: AOAM533tRRKsWdPdasEneeRqEtjdd3YgWFWld+hUb02Z3NaR76qYFSSs
        VKo30W6rX5Iuz4mWF4T6uKl5w9y3Tonp3QwZ/t0=
X-Google-Smtp-Source: ABdhPJz+wtfHF9+/5Yhg4sQDvIGgpv3AVDSInHojZ6O4QcwH8U90SgvmSeOazFazkL4MgdJsN7lmuZsWK12pGQV2IH8=
X-Received: by 2002:a63:4145:: with SMTP id o66mr4857925pga.4.1623933196378;
 Thu, 17 Jun 2021 05:33:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1623775748.git.chris@chrisdown.name> <YMsfo3/b1LvOoiM0@alley>
In-Reply-To: <YMsfo3/b1LvOoiM0@alley>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 17 Jun 2021 15:33:00 +0300
Message-ID: <CAHp75VchoFoso54i1XHom_Wt49MtMEnjxZ-vq_C+OXCCK2=8sA@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] printk: Userspace format indexing support
To:     Petr Mladek <pmladek@suse.com>
Cc:     Chris Down <chris@chrisdown.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 2:10 PM Petr Mladek <pmladek@suse.com> wrote:
> On Tue 2021-06-15 17:52:20, Chris Down wrote:

> > Chris Down (5):
> >   string_helpers: Escape double quotes in escape_special
> >   printk: Straighten out log_flags into printk_info_flags
> >   printk: Rework parse_prefix into printk_parse_prefix
> >   printk: Userspace format indexing support
> >   printk: index: Add indexing support to dev_printk
>
> The patchset looks ready for linux-next from my POV. I could fixup the
> messages as suggested by Andy when pushing.
>
> Well, I would still like to get acks from:
>
>    + Andy for the 1st patch
>    + Jessica for the changes in the module loader code in 4th patch.

Assuming that Chris indeed spent time on checking string_esape_mem()
users along with %*pE (and all its variations with hardcoded length)
and haven't found any problems,
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>


-- 
With Best Regards,
Andy Shevchenko
