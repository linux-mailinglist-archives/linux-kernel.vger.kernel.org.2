Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A80304FEC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236451AbhA0Ded (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:34:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730156AbhAZVhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 16:37:15 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A535C061574
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 13:36:35 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id u17so36849348iow.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 13:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/ustJ0/aPlx4iAkk4IQ7oOTUDCbseUwYBGj9G/doyi0=;
        b=aRQPVtVQWvj+0JgMoeSv1tbxkyyKJKp5rhr+iKTA+dqaYS5cAcTj0yb69/ROdSPTVs
         awqkofJxKIYC+3lALvwuxeUYNWxIhxsVdfaZsfGU/9TVu88A53J2zFxhsA71d3WLUDIX
         555139CXWDue9MMhcnwtw1r926W3gNac1W8rIe4qgxqO3UyvIcagtRfQlML1WO+lKruO
         EBVBK1yuo615WTIXa9WGH5nbwMl4c6EP3xr+FedOSbKmp2xsFyTJQfLV0RnwujhbNls8
         8YdckUwosOCRojjTNk9D23BaUu3ytsnn0gwOaMjyA2J4M8nVZFsPU/9TIDg76sLXMPJ1
         BLUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/ustJ0/aPlx4iAkk4IQ7oOTUDCbseUwYBGj9G/doyi0=;
        b=cKBdKYOAVfOVuslvr7olBWuF380uLLLfkE47Gy3Tp5GK+KgQb07vfH9KOE5YkA4BjE
         RGZnqUI12kaiesxn58chABR57j4zESMr94vjzZEDDxd9j60xXb6772H6N15Dhj6fRWW3
         ixSDSXYtuXl0mcUIFOsCjjhropR5idncqcmGYen0RwjYoec/SEVNVp/viBvAZHK3wzZ0
         IOrX/oMaOZQVnSZXFvahBkYgHlD6pP12RbE+7E76q183+ms3GnvWwazaDsIElLUjNSt6
         mlJygkM4r4UJ3qwxlsQpGRVCsEbKMTED2qohyQejE1/iDxkjmwJR3sX1tcdWUvvXXELS
         S6QA==
X-Gm-Message-State: AOAM531ewGLYSWA9YduQWQTOf715xKcL6HVq1lRGfDNEBJx6qG8DHf+R
        UsdzvhvjLzmFiwXi/Nz95k82JQjizVQXb1n1Gzw=
X-Google-Smtp-Source: ABdhPJxZsKjbMvUBw7jG6/aVnfplIA3VZdiKLNfG8H8yOQPCusbf9QUiQztyi1mZ2Iae/ZStL2V4RsH7GwIlsy91f3M=
X-Received: by 2002:a92:aac5:: with SMTP id p66mr6386791ill.238.1611696994232;
 Tue, 26 Jan 2021 13:36:34 -0800 (PST)
MIME-Version: 1.0
References: <20210126171141.122639-1-paul.gortmaker@windriver.com> <20210126171141.122639-9-paul.gortmaker@windriver.com>
In-Reply-To: <20210126171141.122639-9-paul.gortmaker@windriver.com>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Tue, 26 Jan 2021 13:36:23 -0800
Message-ID: <CAAH8bW_kiReeYrXmFp=2o_YkOitsSrtN9evKaR6SWdZk8TNuoQ@mail.gmail.com>
Subject: Re: [PATCH 8/8] rcu: deprecate "all" option to rcu_nocbs=
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lizefan@huawei.com, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, josh@joshtriplett.org,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, fweisbec@gmail.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 9:12 AM Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
>
> With the core bitmap support now accepting "N" as a placeholder for
> the end of the bitmap, "all" can be represented as "0-N" and has the
> advantage of not being specific to RCU (or any other subsystem).
>
> So deprecate the use of "all" by removing documentation references
> to it.  The support itself needs to remain for now, since we don't
> know how many people out there are using it currently, but since it
> is in an __init area anyway, it isn't worth losing sleep over.
>
> Cc: Yury Norov <yury.norov@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 4 +---
>  kernel/rcu/tree_plugin.h                        | 6 ++----
>  2 files changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index a10b545c2070..a116c0ff0a91 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4037,9 +4037,7 @@
>                                 see CONFIG_RAS_CEC help text.
>
>         rcu_nocbs=      [KNL]
> -                       The argument is a cpu list, as described above,
> -                       except that the string "all" can be used to
> -                       specify every CPU on the system.
> +                       The argument is a cpu list, as described above.
>
>                         In kernels built with CONFIG_RCU_NOCB_CPU=y, set
>                         the specified list of CPUs to be no-callback CPUs.
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 7e291ce0a1d6..56788dfde922 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -1463,14 +1463,12 @@ static void rcu_cleanup_after_idle(void)
>
>  /*
>   * Parse the boot-time rcu_nocb_mask CPU list from the kernel parameters.
> - * The string after the "rcu_nocbs=" is either "all" for all CPUs, or a
> - * comma-separated list of CPUs and/or CPU ranges.  If an invalid list is
> - * given, a warning is emitted and all CPUs are offloaded.
> + * If the list is invalid, a warning is emitted and all CPUs are offloaded.
>   */
>  static int __init rcu_nocb_setup(char *str)
>  {
>         alloc_bootmem_cpumask_var(&rcu_nocb_mask);
> -       if (!strcasecmp(str, "all"))
> +       if (!strcasecmp(str, "all"))            /* legacy: use "0-N" instead */

I think 'all' and 'none' is a good idea. It's simple and convenient.
But if you don't
like it, can you please at least put this comment in system log using
WARN_ON_ONCE(). It's quite possible that Linux users don't read source code
comments.

>                 cpumask_setall(rcu_nocb_mask);
>         else
>                 if (cpulist_parse(str, rcu_nocb_mask)) {
> --
> 2.17.1
>
