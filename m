Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54ABA306CA2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 06:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbhA1FNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 00:13:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhA1FNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 00:13:12 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0341FC061573
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 21:12:32 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id e18so4809369lja.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 21:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lRMblRuvpgkCUXMjL7udQPNGPedNtxUO5H5aUcWux1Q=;
        b=AtNdQdTHkF9Ap0SSwUyv2YMmZdL/X5B5VbMwjvqHojkAVgmOyPyVCnv52MoKnGDtEg
         9utj+xgMaDdIYmyNg+FFfFnbZawleq/tioIAgMnpcYNGpxAnBhc938kVBojphQ+4VaT5
         MR/7u42BWqwR3lwVk5CBIiOpJMo/gphyuZDhWdKChx9/P7yZj6F+ySS0pCbVhMKa6E5U
         aQJVDaclLX+42VHIQtNiRyZCovG3H69k0lFVo+JfETcQur4k+0DG91ShgOvOl3OBHJpQ
         CBb6VedAZ3MGZKOdQVwRayORbTZRu7ItyULxBr1HAuFzGv6qcSmq7T56FnRQAYOgbUTP
         SHvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lRMblRuvpgkCUXMjL7udQPNGPedNtxUO5H5aUcWux1Q=;
        b=IBbCPcjrz/JtW+t0xqHU04rBQK2hZtH+q0VvzANQhlWjQaFKb7FWUQolzGwSH9wXtQ
         pypFUE/srYnXCpR41IKn5tTagJRNCkBsL95rM/yD773u4BP5Mud/E6Vu7CPH6spiVyj2
         W+xenbClKEengHpmuhvO6MJkE5R+hfGkQ8Ufi230qDFkPfwdselFaU9CAGl9IBrS10mF
         k8Odl/irV023rNRdLaba8Zcn825weFXmlLg43f5ih+rdMcDp5c1SRQl7QE6iLZwpbGPT
         Wr3eLgCBEIjAkpBjvC7RfTbV+9oZXLwneWB07lmYevvnoAr2u4JA8mHuCcY4QkQCK/Ti
         8W1w==
X-Gm-Message-State: AOAM531Fmzu0XA9MQo2WVJW41d8/FtxkQ00LfuLNBUvIeL2WDIupVAOU
        K+gpKRHG6Jf0+Vntd4YAABBkHX6trLckEtA4bbXIiw==
X-Google-Smtp-Source: ABdhPJyQdom+qaZmHu7lxZgdJ8DQriX1J3vN4N4VrXthyy3Jk2Xt8QQmliKNeAzd+HZT3MMK6OULRIT9ICyZHtgvc2w=
X-Received: by 2002:a2e:9b57:: with SMTP id o23mr7729720ljj.314.1611810750523;
 Wed, 27 Jan 2021 21:12:30 -0800 (PST)
MIME-Version: 1.0
References: <1611558371-14414-1-git-send-email-sumit.garg@linaro.org> <CAD=FV=X-rA6F_dS-f7f5WO2SZbVYrrg5A5dOrXe_6FrE=ZhqQg@mail.gmail.com>
In-Reply-To: <CAD=FV=X-rA6F_dS-f7f5WO2SZbVYrrg5A5dOrXe_6FrE=ZhqQg@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 28 Jan 2021 10:42:18 +0530
Message-ID: <CAFA6WYMZEU3Sme0GH16i+QHv3uhzSevjpEMzfY8trKvT_gV_Hw@mail.gmail.com>
Subject: Re: [PATCH v2] kdb: Simplify kdb commands registration
To:     Doug Anderson <dianders@chromium.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jan 2021 at 21:32, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Sun, Jan 24, 2021 at 11:06 PM Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > Simplify kdb commands registration via using linked list instead of
> > static array for commands storage.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >
> > Changes in v2:
> > - Remove redundant NULL check for "cmd_name".
> > - Incorporate misc. comment.
> >
> >  kernel/debug/kdb/kdb_main.c    | 119 ++++++++++++-----------------------------
> >  kernel/debug/kdb/kdb_private.h |   1 +
> >  2 files changed, 34 insertions(+), 86 deletions(-)
> >
> > diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> > index 930ac1b..a0989a0 100644
> > --- a/kernel/debug/kdb/kdb_main.c
> > +++ b/kernel/debug/kdb/kdb_main.c
> > @@ -33,6 +33,7 @@
> >  #include <linux/kallsyms.h>
> >  #include <linux/kgdb.h>
> >  #include <linux/kdb.h>
> > +#include <linux/list.h>
> >  #include <linux/notifier.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/delay.h>
> > @@ -84,15 +85,8 @@ static unsigned int kdb_continue_catastrophic =
> >  static unsigned int kdb_continue_catastrophic;
> >  #endif
> >
> > -/* kdb_commands describes the available commands. */
> > -static kdbtab_t *kdb_commands;
> > -#define KDB_BASE_CMD_MAX 50
> > -static int kdb_max_commands = KDB_BASE_CMD_MAX;
> > -static kdbtab_t kdb_base_commands[KDB_BASE_CMD_MAX];
> > -#define for_each_kdbcmd(cmd, num)                                      \
> > -       for ((cmd) = kdb_base_commands, (num) = 0;                      \
> > -            num < kdb_max_commands;                                    \
> > -            num++, num == KDB_BASE_CMD_MAX ? cmd = kdb_commands : cmd++)
> > +/* kdb_cmds_head describes the available commands. */
> > +static LIST_HEAD(kdb_cmds_head);
> >
> >  typedef struct _kdbmsg {
> >         int     km_diag;        /* kdb diagnostic */
> > @@ -921,7 +915,7 @@ int kdb_parse(const char *cmdstr)
> >         char *cp;
> >         char *cpp, quoted;
> >         kdbtab_t *tp;
> > -       int i, escaped, ignore_errors = 0, check_grep = 0;
> > +       int escaped, ignore_errors = 0, check_grep = 0;
> >
> >         /*
> >          * First tokenize the command string.
> > @@ -1011,25 +1005,18 @@ int kdb_parse(const char *cmdstr)
> >                 ++argv[0];
> >         }
> >
> > -       for_each_kdbcmd(tp, i) {
> > -               if (tp->cmd_name) {
> > -                       /*
> > -                        * If this command is allowed to be abbreviated,
> > -                        * check to see if this is it.
> > -                        */
> > -
> > -                       if (tp->cmd_minlen
> > -                        && (strlen(argv[0]) <= tp->cmd_minlen)) {
> > -                               if (strncmp(argv[0],
> > -                                           tp->cmd_name,
> > -                                           tp->cmd_minlen) == 0) {
> > -                                       break;
> > -                               }
> > -                       }
> > -
> > -                       if (strcmp(argv[0], tp->cmd_name) == 0)
> > +       list_for_each_entry(tp, &kdb_cmds_head, list_node) {
> > +               /*
> > +                * If this command is allowed to be abbreviated,
> > +                * check to see if this is it.
> > +                */
> > +               if (tp->cmd_minlen && (strlen(argv[0]) <= tp->cmd_minlen)) {
> > +                       if (strncmp(argv[0], tp->cmd_name, tp->cmd_minlen) == 0)
> >                                 break;
> >                 }
>
> The old code had the same problem, but since you're touching it you could fix?
>
> if (a) {
>   if (b)
>     break;
> }
>
> ...is the same as:
>
> if (a && b)
>   break;
>

Sure, I will fix it in the next version.

> In any case, this looks like quite a nice cleanup, so:
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Thanks,
Sumit
