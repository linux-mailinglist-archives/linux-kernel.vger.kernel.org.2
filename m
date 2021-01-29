Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A66C308359
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 02:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhA2BrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 20:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhA2BrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 20:47:03 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2810BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 17:46:15 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id j4so3805788qvk.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 17:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WJaQj8mG9CX4kUc/x7/N9X46utWcZpn5W7Qx0g4TWFc=;
        b=PhBQ+5UQxxq32pqppv8VUzq3XcZe498mjTGVbiiB/rf8ESF4evfDtyEnCNW/mntDbr
         f4pZI6/NE7xCFOJE1PWlR2c6mXlqdv66oOeeOav8m8tXiHqN3z9LCpynbTavP5D2EK9W
         J+CoSyqPIF+rec1D/nGQyyAxoLt7BHPYAmC6bKT/m6tiRX+BXgqKJ24DOXo6Vx6CbiO8
         Da3gepe4+y2z6ffGV+XnAEPyVL7dAcm3ZGfnmYRvqDjXx/tZKDebakwV6HH9m/Ga2gdg
         agppg3qkgrtggz8k9JFS2GFb3hQaAyS2+NDDi7oCfrK07ISeQKSjAxpbwWDKpzmJ4UAV
         Moog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WJaQj8mG9CX4kUc/x7/N9X46utWcZpn5W7Qx0g4TWFc=;
        b=H9bmj3UN11n0c9oX3fCwpqY6/6ccNRjHwyq4qZu02ezP/9nGhMRKTHxyclSfLcRL3m
         Ljj76tJs+VqdGPu1v7pXsgG8W0TWktrW1OmSzxqn15ed6/pL5inG5QVs3+mgV5WN382n
         MIh2M7ZRM/5V5jrGH/5GjFUPUj79UuO6VdLyadrtq6rjqinvukrubP97LdZ6qhdKwOLm
         Septc83z07R0CtkcNka4tOvUuqOqcsTJes/GdisjETYu8H0+v3U6cM9lPjLg20DpSYE/
         D5luILxR7oWoiEayuiuadmh5TaL9Wwh4uOeRK5msRYv9IXwelOG0JzKepVDMsUc7qvJ+
         UlWA==
X-Gm-Message-State: AOAM530iAphE8DuhAFnX7Lcwv9mctl4atyHzYaUsC/JIk8/068mn2M6v
        rJfPJ5Y0LSm81nixmDIvDwyzSx9eFRM5nqsNdk1DnA==
X-Google-Smtp-Source: ABdhPJzBG64hDJBh1ZVGpej8tL4hDZfEG8NODtdSELy6MVlZ1tQpNf1TV0uNta1LT+bAxj+GkNs2Unrjc+6p8sGdlhs=
X-Received: by 2002:a0c:f7d2:: with SMTP id f18mr2075531qvo.39.1611884774178;
 Thu, 28 Jan 2021 17:46:14 -0800 (PST)
MIME-Version: 1.0
References: <20210122235238.655049-1-elavila@google.com> <87im7l2lcr.fsf@jogness.linutronix.de>
 <CAGFReeNEf7a4W4hEx5bD+v0qsdszrgPfh1Sa-B-2HeaAY5natg@mail.gmail.com>
In-Reply-To: <CAGFReeNEf7a4W4hEx5bD+v0qsdszrgPfh1Sa-B-2HeaAY5natg@mail.gmail.com>
From:   "J. Avila" <elavila@google.com>
Date:   Thu, 28 Jan 2021 17:46:03 -0800
Message-ID: <CAGFReeOKwvsUb5hMMXLY3eTdqMDOae9mNjfp5BXx+BYfn5vMiw@mail.gmail.com>
Subject: Re: Issue in dmesg time with lockless ring buffer
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello John,

I=E2=80=99ve done some additional digging on my end. I tested using a 5.10.=
11
kernel and observed the following:

1) With the default of CONFIG_LOG_BUF_SHIFT=3D17, I was not able to reprodu=
ce
   the issue.
2) With CONFIG_LOG_BUF_SHIFT=3D20, I was able to reproduce the behavior
   mentioned before.
3) With (2) + reverting up to and including 896fbe20b4e2 (printk: use the
   lockless ringbuffer), I saw short dmesg times again.

It seems that this issue may only exist with a sufficiently big log buffer
size. Despite 1MB being a relatively uncommon size for linux kernel log
buffers, this still indicates a potential issue in the code; do you think
it's worth investigation?

Thanks,

Avila

On Mon, Jan 25, 2021 at 4:00 PM J. Avila <elavila@google.com> wrote:
>
> Hello,
>
> This dmesg uses /dev/kmsg; we've verified that we don't see this long
> dmesg time when reading from syslog (via dmesg -S).
>
> We've also tried testing this with logging daemons disabled as well as
> within initrd - both result in similar behavior.
>
> If it's relevant, this was done on a toybox shell.
>
> Thanks,
>
> Avila
>
> On Mon, Jan 25, 2021 at 5:32 AM John Ogness <john.ogness@linutronix.de> w=
rote:
> >
> > On 2021-01-22, "J. Avila" <elavila@google.com> wrote:
> > > When doing some internal testing on a 5.10.4 kernel, we found that th=
e
> > > time taken for dmesg seemed to increase from the order of millisecond=
s
> > > to the order of seconds when the dmesg size approached the ~1.2MB
> > > limit. After doing some digging, we found that by reverting all of th=
e
> > > patches in printk/ up to and including
> > > 896fbe20b4e2333fb55cc9b9b783ebcc49eee7c7 ("use the lockless
> > > ringbuffer"), we were able to once more see normal dmesg times.
> > >
> > > This kernel had no meaningful diffs in the printk/ dir when compared
> > > to Linus' tree. This behavior was consistently reproducible using the
> > > following steps:
> > >
> > > 1) In one shell, run "time dmesg > /dev/null"
> > > 2) In another, constantly write to /dev/kmsg
> > >
> > > Within ~5 minutes, we saw that dmesg times increased to 1 second, onl=
y
> > > increasing further from there. Is this a known issue?
> >
> > The last couple days I have tried to reproduce this issue with no
> > success.
> >
> > Is your dmesg using /dev/kmsg or syslog() to read the buffer?
> >
> > Are there any syslog daemons or systemd running? Perhaps you can run
> > your test within an initrd to see if this effect is still visible?
> >
> > John Ogness
