Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80FE84256F3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 17:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242509AbhJGPrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 11:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241809AbhJGPri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 11:47:38 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EF8C061570
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 08:45:45 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id h189so4412036iof.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 08:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lLE94W7Cb7MOh7/Kqofoi+/V7Oc/OdkRNGgULVhtzUs=;
        b=M2Ey2nm7WSrqtPyR11GNTt/bemp0MR7gOEvG9Tj3BlnpPn7Uo3OU4xfVNrFNRfY6qf
         ypngVlsG0N5ycNw1Tk0kLvAGNsqgmB0H4EgxqNj8GzSCPJPct4ihjWuX0rzxcN+6vtu5
         BXgx6+5NkbVcm1JaOpolBvyZsd+PNActcOvmYlRe2KYbsw0gABMUpKwpQl5PH7RNNLAB
         PnVDt0OSY94JPVw6SfsUrUH+EvkreOnoMjtNZHvM6sq7DKhu4JNtLphpuRYPNep88smJ
         OYJ2917V9rM9ckAh24kdBiQ6rT6JyIhMkSKyiVyJKq1wWQiyYM8HAEwEWiESRYXD7evp
         Lcng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lLE94W7Cb7MOh7/Kqofoi+/V7Oc/OdkRNGgULVhtzUs=;
        b=O8iVvSkuhOvlfIo3U8LUoxStJUdxUzNkSGk+c5wWJ3Xt6Ovlo+7eHHk+xJPk4oB5Yp
         kqI+quj2LBI22qrq7mKwIShNeM5PkL7ZM7PkyQMzqdIC0DQ+WCGQ25iW3Rbrx7ONxEhk
         e+e5UYyULMy0nlTu+nuqLXGCCh8uIe44Y9qJFHXwzZgWCWUTOzraXpN9GXcEpSRZokZi
         OFloVe/vvzME7vZDE225M4G506EcBap98OjeH5VHJc8rHvtLZYKoI12+fBChT0R/D8EK
         uZ7Q24o1pq609dBbNcpj93/+wq5q7IbVkI7kORiHzShC2/jvPBXUdZN+nolB+P2zkvcL
         NNPg==
X-Gm-Message-State: AOAM53199yRxlid36eJNcUJVuDOboRH64+78yJ8P1svKSq9suP8rPgzr
        74YzSeOn3D3ecOZHzsRzMHmqUH2nTQhgL4UX69Y=
X-Google-Smtp-Source: ABdhPJzPTSCEkhPgCsX8jNVB924qSzWxOy/P0INN3y3ToVdVP1ljhCygVX/HhPJZyt1iJ5ViUYwSETkVO9ijrjaBMAA=
X-Received: by 2002:a02:661d:: with SMTP id k29mr3554872jac.49.1633621544612;
 Thu, 07 Oct 2021 08:45:44 -0700 (PDT)
MIME-Version: 1.0
References: <20211007120752.5195-1-laoar.shao@gmail.com> <20211007120752.5195-2-laoar.shao@gmail.com>
 <202110070750.8754AA33@keescook> <202110070808.43B5AAEB9@keescook>
In-Reply-To: <202110070808.43B5AAEB9@keescook>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 7 Oct 2021 23:45:08 +0800
Message-ID: <CALOAHbArfDWT8VhL3btWme8s+T8VLGUYKtYDmotgSnY1heBjJA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] cn_proc.h: use TASK_COMM_LEN instread of 16 in
 struct proc_event
To:     Kees Cook <keescook@chromium.org>
Cc:     Petr Mladek <pmladek@suse.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        qiang.zhang@windriver.com, robdclark@chromium.org,
        christian@brauner.io, Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Vladimir Zapolskiy <vzapolskiy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 7, 2021 at 11:09 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Oct 07, 2021 at 07:51:35AM -0700, Kees Cook wrote:
> > On Thu, Oct 07, 2021 at 12:07:49PM +0000, Yafang Shao wrote:
> > > struct comm_proc_event was introduced in commit
> > > f786ecba4158 ("connector: add comm change event report to proc connector").
> > > It seems that there is no strong reason we must define the comm as a
> > > hardcode 16 bytes. So we can use TASK_COMM_LEN instead.
> > >
> > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > Cc: Vladimir Zapolskiy <vzapolskiy@gmail.com>
> > > Cc: Kees Cook <keescook@chromium.org>
> > > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > > Cc: Petr Mladek <pmladek@suse.com>
> > > ---
> > >  include/uapi/linux/cn_proc.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/include/uapi/linux/cn_proc.h b/include/uapi/linux/cn_proc.h
> > > index db210625cee8..351d02786350 100644
> > > --- a/include/uapi/linux/cn_proc.h
> > > +++ b/include/uapi/linux/cn_proc.h
> > > @@ -110,7 +110,7 @@ struct proc_event {
> > >             struct comm_proc_event {
> > >                     __kernel_pid_t process_pid;
> > >                     __kernel_pid_t process_tgid;
> > > -                   char           comm[16];
> > > +                   char           comm[TASK_COMM_LEN];
> > >             } comm;
> >
> > Hrmm. This is UAPI -- we can't change it without potentially breaking
> > things (i.e. userspace binaries have this size built in, so we can't
> > just change the size). This will either need to stay truncated, or may
> > need a new interface with a variable-sized structure...
>
> Specifically, this is needed for this series:
>
>
> diff --git a/drivers/connector/cn_proc.c b/drivers/connector/cn_proc.c
> index 646ad385e490..34bcba25c488 100644
> --- a/drivers/connector/cn_proc.c
> +++ b/drivers/connector/cn_proc.c
> @@ -230,7 +230,9 @@ void proc_comm_connector(struct task_struct *task)
>         ev->what = PROC_EVENT_COMM;
>         ev->event_data.comm.process_pid  = task->pid;
>         ev->event_data.comm.process_tgid = task->tgid;
> -       get_task_comm(ev->event_data.comm.comm, task);
> +       /* This may get truncated. */
> +       __get_task_comm(ev->event_data.comm.comm,
> +                       sizeof(ev->event_data.comm.comm), task);
>
>         memcpy(&msg->id, &cn_proc_event_id, sizeof(msg->id));
>         msg->ack = 0; /* not used */
>

Thanks for the suggestion.  I will keep the UAPI code as-is and change
it as you suggested.

-- 
Thanks
Yafang
