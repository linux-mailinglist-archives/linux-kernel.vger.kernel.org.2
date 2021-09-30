Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D312F41DA19
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 14:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350831AbhI3MqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 08:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348891AbhI3MqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 08:46:02 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C41C06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 05:44:19 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id e144so7324535iof.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 05:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SOZ136F1V5KatbF5xg7JfoYahNogyyEnuoEkeITu1zM=;
        b=V8KGBRcnc8tsefQwcTE22hKEwDPSLoVjav+BvZNP0YKns+soXtovnug1uXb0DX+J5A
         nivKMW1ULgI84uNgmUVBvkWF7HNF4+rmIXBqOLn3ykxtgdZFTGD+e61OriiQh6461jfq
         u7aiyChp0E8NFR94BVbd4BlM4aKQyMe2iNwmaPD+0h2B27hgH7Sm0rhQUmKabUu4Ghw3
         u74p1Z6Wj3jZOYBdBHne0sKlCeC3hjsy8NN/KyFK5EO0xG0LDQA2g5ZWAS3hOYD9/7Ri
         ltdyYyD39jxzQTsnCNCtwQ+A+IgGH4HoTX79bYwZM0voY22iKehQGokjMeRBwkelsVZL
         qMJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SOZ136F1V5KatbF5xg7JfoYahNogyyEnuoEkeITu1zM=;
        b=yx2+xR06CRpGsWVg+A0owWKbrxRSoRa9IgnKqNr09/oR7zGvleMeYSiuQ5EEsLbZyj
         jvXkrS91hvatxtpXPUY1b9827wJv2XpuGhvJBy9TUsc3pFMq6f+A2jFYp/x76cNBJ2fF
         hsQzJ9YAKPEDVxjgsytALCiDHUJiTmzqSDi7q0r9Lkn9PNyQKcZbhoPRJ5bDxOO7EmTh
         V0XWB3Q07xnLUcaa3slVt+XvO3ex2MTZfizdLxHcHhtUE6RvX5I+N3zLPyRrq8PgXHj9
         L51tI1HLvVD1rqca3u4ZC734h3SUieKUga641Zj6YwXYsrzc8TmqVHjICsV/+LzLw0MF
         MD/g==
X-Gm-Message-State: AOAM532SOBEl9MxGxdTRA7LJk0HGG+bzHq60P/mTl3btN8c+JNWaIAFJ
        20PnoDm5MqlkcKXnxYiRsUI5+NPSPZ7TgdhaySE=
X-Google-Smtp-Source: ABdhPJyxZgpVLncX+QFcl9T8HH5cr3eRzf8NrShaGlf1HyuT0Cb9IzmvvoDkTWn6T/C4DEa/QbIXUbEDMEP0eMughn4=
X-Received: by 2002:a05:6638:1b2:: with SMTP id b18mr4614301jaq.95.1633005859268;
 Thu, 30 Sep 2021 05:44:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210929115036.4851-1-laoar.shao@gmail.com> <20210929115036.4851-4-laoar.shao@gmail.com>
 <202109291111.31671B6A6@keescook>
In-Reply-To: <202109291111.31671B6A6@keescook>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 30 Sep 2021 20:43:43 +0800
Message-ID: <CALOAHbANTC8vQ+f4q_YzFtYtd5Ffrm_nx8Y42552X1kXTCCS7Q@mail.gmail.com>
Subject: Re: [PATCH 3/5] kernel/sched: improve the BUILD_BUG_ON() in get_task_comm()
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        qiang.zhang@windriver.com, robdclark@chromium.org,
        Al Viro <viro@zeniv.linux.org.uk>, christian@brauner.io,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 2:12 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Sep 29, 2021 at 11:50:34AM +0000, Yafang Shao wrote:
> > What we really want to guarantee is that the buf size can't be less than
> > TASK_COMM_LEN. While the size be greater than TASK_COMM_LEN is
> > acceptable.
>
> This makes sense when task_struct::comm is a pointer. (But I think it's
> not a good idea to do that.)
>

OK, I won't make this change.

> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  include/linux/sched.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index b387b5943db4..959eaef248fc 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -1931,7 +1931,7 @@ static inline void set_task_comm(struct task_struct *tsk, const char *from)
> >
> >  extern char *__get_task_comm(char *to, size_t len, struct task_struct *tsk);
> >  #define get_task_comm(buf, tsk) ({                   \
> > -     BUILD_BUG_ON(sizeof(buf) != TASK_COMM_LEN);     \
> > +     BUILD_BUG_ON(sizeof(buf) < TASK_COMM_LEN);      \
> >       __get_task_comm(buf, sizeof(buf), tsk);         \
> >  })
> >
> > --
> > 2.17.1
> >
>
> --
> Kees Cook



-- 
Thanks
Yafang
