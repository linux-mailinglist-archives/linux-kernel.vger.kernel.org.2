Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50FBB33F55F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 17:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbhCQQWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 12:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbhCQQW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 12:22:28 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE1CC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 09:22:28 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id y133so2651324ybe.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 09:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gSloqn/zPcb4my2AQhUlcF6toHtAZsAY6i+CcPAxeT0=;
        b=iId9NZeiIVnUAr1BvdTvUnpyUEVZfJ/+4+x+3ugboCmh7R6o/KzWC2YlYXMhIZWKx/
         qhepSJ9VyzQBQ2WrwLPSsdlYPHlpN5OFCK7/OKPLKmoC9BJC+9id1IDrBOS7i3f+Wu7G
         Fkfyk4TeDuVUPmxcPz0d2TovbVyIUO71WC8UXItQnzIVn+qYg8f9xNyLNkCGgC3yniDA
         DF7js65BSPGbi3DVFeJTHiZWzGUO8JEWXvS8J3VS+mdo6EB1Hzyya6UWmkpsrDXTP+xG
         umysdZWdfQiwxBiXgfXolNYMba0uIVB3mdxe8cE5lno/Jyizy9d+1pzveNguohhAeIOT
         ROmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gSloqn/zPcb4my2AQhUlcF6toHtAZsAY6i+CcPAxeT0=;
        b=UjMZVOi0NJ09DjC18uoqHimVfhC5w38IKl6YTuJm4XqPePaK+rYErxXtK6+ty0GLlV
         IZ4Rk74SVccA1RtkN3GljfsyMo5rrHQ/yiscm56vHfTSybFcKG3ZBjSQkeIu7ZV79ZJQ
         ga1oRdb+YH6RKz0EAk2plhzjF6DIzbD8gWLHvC4hR6Oe0jvlBAFy/WoV6kJUahAyVmy8
         GzHVH+KtdJ+Cz5Ek88P25hXr+8n7eqyJzZN+x+eiwPzj2fYEpdXxgbcltry0gD8k9U/+
         BtARUPfX5QpU8vVd68REDiXnSI6XdtAOsX1PlHAaZlAWw/iPwX7HZovo5gY2y0RVKJIy
         rcpw==
X-Gm-Message-State: AOAM532IW35Wi6lt7Bd7hMMCDmoztdM/Uf99Ak9euPl3a4gfTKTBJ8V8
        +MxLm7kiLFrpQl6y+E6vB7UPHYtNa6cIotTrBiVkRQ==
X-Google-Smtp-Source: ABdhPJzDQj5X0SZV8FtniC1hloxIGOILZiomd+l8X35wDmhMiWn7/XZRb4y4M4Rkk85lSEz2XtjBgPUjDd9UWdEWjds=
X-Received: by 2002:a25:e4c4:: with SMTP id b187mr5508166ybh.92.1615998147092;
 Wed, 17 Mar 2021 09:22:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210317150858.02b1bbc8@canb.auug.org.au> <20210317105432.GA32135@zn.tnic>
In-Reply-To: <20210317105432.GA32135@zn.tnic>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 17 Mar 2021 09:22:15 -0700
Message-ID: <CAP-5=fWKCtJq-9zd5A-XALJWNf8tsds44m-G07sc+kCUoXB8zg@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the tip tree
To:     Borislav Petkov <bp@suse.de>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 3:54 AM Borislav Petkov <bp@suse.de> wrote:
>
> + Ian.
>
> On Wed, Mar 17, 2021 at 03:08:58PM +1100, Stephen Rothwell wrote:
> > Hi all,
> >
> > After merging the tip tree, today's linux-next build (native perf)
> > failed like this:
> >
> > In file included from util/intel-pt-decoder/intel-pt-insn-decoder.c:15:
> > util/intel-pt-decoder/../../../arch/x86/lib/insn.c:14:10: fatal error: =
asm/inat.h: No such file or directory
> >    14 | #include <asm/inat.h> /*__ignore_sync_check__ */
> >       |          ^~~~~~~~~~~~
> >
> > This is a powerpc build of perf.  I can't see what caused this failure,
> > so I have used the version of the tip tree from next-20210316 for today=
.
>
> Yah, this has come up in the past during review but the wrong version
> somehow snuck in, sorry. ;-\
>
> Can you guys verify this fixes the build issue? I don't have a ppc build
> setup.
>
> Thx.

The <asm/emulate_prefix.h> path also needs fixing. With the following
I was able to build for arm64 and powerpc.

Thanks,
Ian

diff --git a/tools/arch/x86/lib/insn.c b/tools/arch/x86/lib/insn.c
index cd4dedde3265..968360bf2150 100644
--- a/tools/arch/x86/lib/insn.c
+++ b/tools/arch/x86/lib/insn.c
@@ -11,13 +11,13 @@
 #else
 #include <string.h>
 #endif
-#include <asm/inat.h> /*__ignore_sync_check__ */
-#include <asm/insn.h> /* __ignore_sync_check__ */
+#include "../include/asm/inat.h" /*__ignore_sync_check__ */
+#include "../include/asm/insn.h" /* __ignore_sync_check__ */

 #include <linux/errno.h>
 #include <linux/kconfig.h>

-#include <asm/emulate_prefix.h> /* __ignore_sync_check__ */
+#include "../include/asm/emulate_prefix.h" /* __ignore_sync_check__ */

 #define leXX_to_cpu(t, r)                                              \
 ({                                                                     \

> ---
> From 50d91054fc421e2a90923706d5ca79e941e28300 Mon Sep 17 00:00:00 2001
> From: Borislav Petkov <bp@suse.de>
> Date: Wed, 17 Mar 2021 11:33:04 +0100
> Subject: [PATCH] tools/insn: Restore the relative include paths for cross
>  building
>
> Building perf on ppc causes:
>
>   In file included from util/intel-pt-decoder/intel-pt-insn-decoder.c:15:
>   util/intel-pt-decoder/../../../arch/x86/lib/insn.c:14:10: fatal error: =
asm/inat.h: No such file or directory
>      14 | #include <asm/inat.h> /*__ignore_sync_check__ */
>         |          ^~~~~~~~~~~~
>
> Restore the relative include paths so that the compiler can find the
> headers.
>
> Fixes: 93281c4a9657 ("x86/insn: Add an insn_decode() API")
> Reported-by: Ian Rogers <irogers@google.com>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> NOT-Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>  tools/arch/x86/lib/insn.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/arch/x86/lib/insn.c b/tools/arch/x86/lib/insn.c
> index cd4dedde3265..999fbd4c9bea 100644
> --- a/tools/arch/x86/lib/insn.c
> +++ b/tools/arch/x86/lib/insn.c
> @@ -11,8 +11,8 @@
>  #else
>  #include <string.h>
>  #endif
> -#include <asm/inat.h> /*__ignore_sync_check__ */
> -#include <asm/insn.h> /* __ignore_sync_check__ */
> +#include "../include/asm/inat.h" /* __ignore_sync_check__ */
> +#include "../include/asm/insn.h" /* __ignore_sync_check__ */
>
>  #include <linux/errno.h>
>  #include <linux/kconfig.h>
> --
> 2.29.2
>
> --
> Regards/Gruss,
>     Boris.
>
> SUSE Software Solutions Germany GmbH, GF: Felix Imend=C3=B6rffer, HRB 368=
09, AG N=C3=BCrnberg
