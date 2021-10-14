Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB5E042D09D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 04:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhJNCpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 22:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbhJNCpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 22:45:23 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32794C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 19:43:19 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id f15so1879105ilu.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 19:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g39CSEOp4O15FcdzhPLxqLxd3uXN3mN8W1vtWL8zuSY=;
        b=I7wC3xQzI7yXhGhBEU0olaeZP7qiE59PN9hxW2e7069TtAz84DqxLs6oPjEBi7tUXV
         MOlQTGlmfL5Vsjd9U7Aca7B88u0eEzxFl0tbnSbAP2KA0nqIz/rJCBN4ybvaN8ITju9f
         uMgmE7Mi/G6s4Sp91FPAJy8mnaz63LbI+3Xnq9+a0IbSQT9syaQtVnsd4dLdzUlGGlJg
         OOikfOrC5EEf2LsqEad0zMCX/lQZUkSvGNqhumHdQUWO9B9IHDfhT/RRGcUqCKnswJ+8
         aeqD0ygIGjVxSKG2KabBiJbY3SD8s9h/Q24d/z6d3NFYYdDsj5aSCHaZDrcVd+/IakHT
         rP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g39CSEOp4O15FcdzhPLxqLxd3uXN3mN8W1vtWL8zuSY=;
        b=thoDeIzyvOow76mHbiBaH66EddKcwlGKtF0GbXFW7bNnepsbfmRunywDgonb806m4d
         RlWfZ8pAOdmKSNbTX2UYgWJ/Sv+dAkUVMMzUYsdLDqe07jLjZL82VZwMpJF4bhhvKLeo
         Ic9/hMXV5JIamxvC+/wD4h/0+5VkxaNXdc078VIGZ7TTm2G243YtP8BgvTc9TPEujdbw
         nB+SYsrNiUaur7gSM9HvhmPXcv+YKy3rlvt0+Vg39DOT98nh9UjFjidulQCvkUimM6Wx
         CnbQb9G4xPp+wURceTt4l+kJo3qHSGUB97KrRgUmf8kf95mye9vD14RFArk1wyMD3chA
         +xmw==
X-Gm-Message-State: AOAM532rwrpkFqlpKbDQR+8EY9UGfrWyJxmbR9VJgRlhdl76SsOVpuqk
        q9/XCiTrM50dxZJw9C0ARMsdT4J4GIZFDrq0joY=
X-Google-Smtp-Source: ABdhPJzkI7WtGGnNQ6E56146YRds+Ms4Ixcwj9a9QFHckFXZWOFBzbZvilkxvxL4DcDI623VyDCl8kBEC9lq14TbOF4=
X-Received: by 2002:a05:6e02:c11:: with SMTP id d17mr440044ile.25.1634179398676;
 Wed, 13 Oct 2021 19:43:18 -0700 (PDT)
MIME-Version: 1.0
References: <20211013102346.179642-1-laoar.shao@gmail.com> <20211013102346.179642-3-laoar.shao@gmail.com>
 <20211013101921.0843aaf0@gandalf.local.home> <CALOAHbCt+rLiPE4_zZO_f5sKybKwYntqupx_L9V_J+yByoFvOw@mail.gmail.com>
 <20211013222418.7ea9727d@oasis.local.home>
In-Reply-To: <20211013222418.7ea9727d@oasis.local.home>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 14 Oct 2021 10:42:42 +0800
Message-ID: <CALOAHbDb7OicA1m8CTCX3RS9h5N=_xS-Jiq+88Nn4A1Vk6TWrw@mail.gmail.com>
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

On Thu, Oct 14, 2021 at 10:24 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Thu, 14 Oct 2021 09:48:09 +0800
> Yafang Shao <laoar.shao@gmail.com> wrote:
>
> > > __get_task_comm() uses strncpy() which my understanding is, does not add
> > > the nul terminating byte when truncating. Which changes the functionality
> > > here. As all task comms have a terminating byte, the old method would copy
> > > that and include it. This won't add the terminating byte if the buffer is
> > > smaller than the comm, and that might cause issues.
> > >
> >
> > Right, that is a problem.
> > It seems that we should add a new helper get_task_comm_may_truncated().
>
> Or simply change __get_task_comm() to:
>
> char *__get_task_comm(char *buf, size_t buf_size, struct task_struct *tsk)
> {
>         task_lock(tsk);
>         strncpy(buf, tsk->comm, buf_size);
>         /* The copied value is always nul terminated */
>         buf[buf_size - 1] = '\0';
>         task_unlock(tsk);
>         return buf;
> }
>

That is better! Thanks for the suggestion.

> But that should probably be a separate patch.
>

Sure.

-- 
Thanks
Yafang
