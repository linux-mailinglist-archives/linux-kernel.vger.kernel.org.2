Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C1642D00A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 03:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhJNBuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 21:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbhJNBuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 21:50:51 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F009C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 18:48:47 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id t2so14365674wrb.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 18:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kVH0kaeOj57wkHN4yL00qa3HiDy3zcOXZu80Mp+X5lE=;
        b=cdkMepIprdbSBOTb+X+Y/58dYEd6l6HL1vRJSBQ8lPCFcELewmNjvsTADlYAmQsZUI
         9/3bb39OvnZpy/AtK6/BQDhoO1b+G0ogFzcpGf5ZfySk4eduB9ox25trwxKRkh7v2pXG
         NR6gNcVKkv1BRKp7P3DdJL5KaBqO3DMVjrqg/qnGKITbUs++XEQknErhhuH1rnKz5/4d
         7oAzkVvi7tpO7DdASj71jeYyCs/L3N3vDcW8tFOVJJhVXBBMxFdwq59XluioyZd/uiBl
         xutsWAufc3uLWxn+S8c9bRVrD4K0Phekr3r+l84a60bVXVaHCLC68Y79ysOazBpuUCrs
         Nlsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kVH0kaeOj57wkHN4yL00qa3HiDy3zcOXZu80Mp+X5lE=;
        b=6JH1ZZ47t1v5cyFrHsiq2sTLmaEG/iWsvCX5quUMTA/cv+rND0X4Ti1Fus8nZ/kyhG
         VzoW6U5zLsMhSG3RsRnVpx7ziABwOkN/LNamaRf0Pu098P3IMSYvGEOhXjVQ4J8IaNl4
         fJSdeHkKCtGErJSdyQpjnPw6oNHJS/3eAtjQH7wgdYz4XzFDJ71LXDdYEDU13HnWA2Nb
         Wq92hVwTIjR0eEC7rLk2SeZyOlc5Au7/+man0peV/7pi8IJ6nuvJbxTW9sEjWzxaTDpZ
         aSRdJpPz2x2zH3XqObuPvk7vjqMitzFtkp4USNgFY8iVzFYsTPEA/0uGP5O/F4Hg10eR
         JoFQ==
X-Gm-Message-State: AOAM530NWp0wcFNDuMW75hW8qkNILwSsDA41lTiCiu2kLIvk3npr3bq9
        s2D1R1N9ljvbOfWSimns+Fuog6ZXVcPo+ELNbIU=
X-Google-Smtp-Source: ABdhPJz39cwF0NRKjLyHpiazuYvSy5bPmCZdqP1lwiDuwJ+IRXRXpeHRqGtvN6OEoVxqLtwOMb8enstJD0Ptv95l3z0=
X-Received: by 2002:a05:6000:15c6:: with SMTP id y6mr3174423wry.210.1634176125813;
 Wed, 13 Oct 2021 18:48:45 -0700 (PDT)
MIME-Version: 1.0
References: <20211013102346.179642-1-laoar.shao@gmail.com> <20211013102346.179642-3-laoar.shao@gmail.com>
 <20211013101921.0843aaf0@gandalf.local.home>
In-Reply-To: <20211013101921.0843aaf0@gandalf.local.home>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 14 Oct 2021 09:48:09 +0800
Message-ID: <CALOAHbCt+rLiPE4_zZO_f5sKybKwYntqupx_L9V_J+yByoFvOw@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] connector: use __get_task_comm in proc_comm_connector
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        qiang.zhang@windriver.com, robdclark@chromium.org,
        christian@brauner.io, Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        David Miller <davem@davemloft.net>, kuba@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Vladimir Zapolskiy <vzapolskiy@gmail.com>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 10:19 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 13 Oct 2021 10:23:43 +0000
> Yafang Shao <laoar.shao@gmail.com> wrote:
>
> > --- a/drivers/connector/cn_proc.c
> > +++ b/drivers/connector/cn_proc.c
> > @@ -230,7 +230,10 @@ void proc_comm_connector(struct task_struct *task)
> >       ev->what = PROC_EVENT_COMM;
> >       ev->event_data.comm.process_pid  = task->pid;
> >       ev->event_data.comm.process_tgid = task->tgid;
> > -     get_task_comm(ev->event_data.comm.comm, task);
> > +
> > +     /* This may get truncated. */
> > +     __get_task_comm(ev->event_data.comm.comm,
> > +                     sizeof(ev->event_data.comm.comm), task);
> >
> >       memcpy(&msg->id, &cn_proc_event_id, sizeof(msg->id));
> >       msg->ack = 0; /* not used */
>
> __get_task_comm() uses strncpy() which my understanding is, does not add
> the nul terminating byte when truncating. Which changes the functionality
> here. As all task comms have a terminating byte, the old method would copy
> that and include it. This won't add the terminating byte if the buffer is
> smaller than the comm, and that might cause issues.
>

Right, that is a problem.
It seems that we should add a new helper get_task_comm_may_truncated().

-- 
Thanks
Yafang
