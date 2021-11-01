Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14CD8442124
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 20:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhKAT7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 15:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhKAT7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 15:59:01 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3990C061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 12:56:27 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id w10so19629225ilc.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 12:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sesa2n7BRx7ff2rAiAnxY9lr07K+lfskV6JL7f2ZDR0=;
        b=aTiZJoG3UbqEJ+VMckDQWZ3JxrAVVmZQbnTgBT4A8kwRoc6IjcFRJXP5QpBs32Q1W7
         f2+F3ZBis+OR3TtXku+hEntoUdr5NjIUXoF7wcPN13vvbMvJVQPP4k/TjHYej/Zz+quO
         KT/KrCYO4pM3vO0+0M74ESp3LS3idUSn+JbS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sesa2n7BRx7ff2rAiAnxY9lr07K+lfskV6JL7f2ZDR0=;
        b=RGP9V6rT3J899EHAmqyRufFu8aNUf4kw8Q+8p226Nc+2cCtjV9VSmOESwgpCfgsaGx
         EB2L2hTZebduXHZ2VC5ubPgw7K4oykr/bPnwzfyDA4o5o1GYbavYfUpZovPkSgjeFFod
         rTq9auTR4DiUHFJN6NiRg0D9FBhvWdJV8BSR7f+NmKBUljlYidPKieVvgViP+7Huzpi3
         gSH6tA/P6rJiOw9C9wTMoACKQmlSvSydosGX/DyMXEyrwP6APrlyH43+FNe+2L+uFO8o
         EC0OZZMMk5tXQa6wm7Y/uZxzteyCkQBKbc5OAimMdOTEMMvsonFR+z7EHclLQa08bgzd
         jYiw==
X-Gm-Message-State: AOAM530pCRnECMFtfAcrRDvhQRr1BYo0/h9WYj3/s/cHSmLo20p76N5I
        FEGKF2dr1bk0lJHKL+sCy/jc04m9z3+xnQ==
X-Google-Smtp-Source: ABdhPJxWcZQF8nIUJ3X1x9qievWvvPfT2AyuKO7onjlCh6TXsXb4hBZfaQdrlWIZsSvGObK5ao5nJQ==
X-Received: by 2002:a05:6e02:1c2a:: with SMTP id m10mr688294ilh.275.1635796586840;
        Mon, 01 Nov 2021 12:56:26 -0700 (PDT)
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com. [209.85.166.181])
        by smtp.gmail.com with ESMTPSA id 11sm1299608ilx.55.2021.11.01.12.56.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 12:56:26 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id s14so2353618ilv.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 12:56:26 -0700 (PDT)
X-Received: by 2002:a05:6e02:18ce:: with SMTP id s14mr9870241ilu.142.1635796585764;
 Mon, 01 Nov 2021 12:56:25 -0700 (PDT)
MIME-Version: 1.0
References: <20211101174344.3220974-1-daniel.thompson@linaro.org>
In-Reply-To: <20211101174344.3220974-1-daniel.thompson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 1 Nov 2021 12:56:13 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VVV4n4sDziWRbY517Eb8mRJVxwH+ggxf37FXfYKiTJ6A@mail.gmail.com>
Message-ID: <CAD=FV=VVV4n4sDziWRbY517Eb8mRJVxwH+ggxf37FXfYKiTJ6A@mail.gmail.com>
Subject: Re: [PATCH v3] kdb: Adopt scheduler's task classification
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Xiang wangx <wangxiang@cdjrlc.com>,
        jing yangyang <jing.yangyang@zte.com.cn>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        Patch Tracking <patches@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 1, 2021 at 10:44 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> Currently kdb contains some open-coded routines to generate a summary
> character for each task. This code currently issues warnings, is
> almost certainly broken and won't make sense to any kernel dev who
> has ever used /proc to examine task states.
>
> Fix both the warning and the potential for confusion by adopting the
> scheduler's task classification. Whilst doing this we also simplify the
> filtering by using mask strings directly (which means we don't have to
> guess all the characters the scheduler might give us).
>
> Unfortunately we can't quite match the scheduler classification completely.
> We add four extra states: - for idle loops and i, m and s sleeping system
> daemons (which means kthreads in one of the I, M and S states). These
> extra states are used to manage the filters for tools to make the output
> of ps and bta less noisy.
>
> Note: The Fixes below is the last point the original dubious code was
>       moved; it was not introduced by that patch. However it gives us
>       the last point to which this patch can be easily backported.
>       Happily that should be enough to cover the introduction of
>       CONFIG_WERROR!
>
> Fixes: 2f064a59a11f ("sched: Change task_struct::state")
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>
> Notes:
>     v3:
>     - Fix the uninitialized cpu variable (Doug and 0-day CI bot)
>     - Added a Fixes: (Doug)
>     - Changed "state I" -> "state -" and "state M" to "state [ism]"
>
>     v2:
>     - Fix the typos in the description (Doug)
>     - Stop trying to bend to world so I can keep 'I' exactly as
>       it was before. Instead we now replace 'I' with '-' and
>       fully adopt the scheduler description of tasks. kdb
>       it an interactive tool, not ABI so this is OK. (Doug)
>     - Don't try to enumerate all possible letters in the
>       comments and help. You can learn what to filter from
>       the output of ps anyway, (Doug)
>     - Fix the sleeping system daemon stuff.
>
>  kernel/debug/kdb/kdb_bt.c      |  14 ++--
>  kernel/debug/kdb/kdb_main.c    |  35 +++++-----
>  kernel/debug/kdb/kdb_private.h |   4 +-
>  kernel/debug/kdb/kdb_support.c | 118 +++++++--------------------------
>  4 files changed, 51 insertions(+), 120 deletions(-)
>
> diff --git a/kernel/debug/kdb/kdb_bt.c b/kernel/debug/kdb/kdb_bt.c
> index 1f9f0e47aeda..3368a2d15d73 100644
> --- a/kernel/debug/kdb/kdb_bt.c
> +++ b/kernel/debug/kdb/kdb_bt.c
> @@ -74,7 +74,7 @@ static void kdb_show_stack(struct task_struct *p, void *addr)
>   */
>
>  static int
> -kdb_bt1(struct task_struct *p, unsigned long mask, bool btaprompt)
> +kdb_bt1(struct task_struct *p, const char *mask, bool btaprompt)

(Copied from v1 review):

In the comment above this function there is still a reference to
"DRSTCZEUIMA". Update that?


> @@ -2271,37 +2271,30 @@ static int kdb_cpu(int argc, const char **argv)
>  void kdb_ps_suppressed(void)
>  {
>         int idle = 0, daemon = 0;
> -       unsigned long mask_I = kdb_task_state_string("I"),
> -                     mask_M = kdb_task_state_string("M");
>         unsigned long cpu;
>         const struct task_struct *p, *g;
>         for_each_online_cpu(cpu) {
>                 p = kdb_curr_task(cpu);
> -               if (kdb_task_state(p, mask_I))
> +               if (kdb_task_state(p, "-"))
>                         ++idle;
>         }
>         for_each_process_thread(g, p) {
> -               if (kdb_task_state(p, mask_M))
> +               if (kdb_task_state(p, "ims"))
>                         ++daemon;
>         }
>         if (idle || daemon) {
>                 if (idle)
> -                       kdb_printf("%d idle process%s (state I)%s\n",
> +                       kdb_printf("%d idle process%s (state -)%s\n",
>                                    idle, idle == 1 ? "" : "es",
>                                    daemon ? " and " : "");
>                 if (daemon)
> -                       kdb_printf("%d sleeping system daemon (state M) "
> +                       kdb_printf("%d sleeping system daemon (state [ism]) "

super nitty: elsewhere you use "ims", not "ism". Can you be consistent
and change the above to "ims"?


 @@ -2742,8 +2743,8 @@ static kdbtab_t maintab[] = {
>         },
>         {       .name = "bta",
>                 .func = kdb_bt,
> -               .usage = "[D|R|S|T|C|Z|E|U|I|M|A]",
> -               .help = "Backtrace all processes matching state flag",
> +               .usage = "[<state_chars>|A]",
> +               .help = "Backtrace all processes matching whose state matches",

"matching whose state matches" sounds odd. Clean it up and use the
saved chars to document "A":

.help = "Backtrace all processes whose state matches (A=all)",


-Doug
