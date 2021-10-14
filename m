Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A25142D006
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 03:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbhJNBtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 21:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhJNBtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 21:49:03 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8021FC061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 18:46:59 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r10so14262427wra.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 18:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hdr4uO/8YFoSPcjOUHFlKHlEJ1GJYDefEgm7W7Vh5/0=;
        b=K6FnicxKxwMW+37arAahv73CFmafkAGES+NBZaC4lfJR2wevYmB43oHHXReFbcnxRJ
         S7PufufFhFMYXZq0WMN4a5xlVzYh+Z34d0uGQeOFAfdcAXuE5FGDf9WaXbTGWnvz/3+b
         1A/w9bIBZ/wj/cS0W1pQLSF9MBWJrxB3eKrj1n7Vo1UvT2gqwZ1/159LjVSgeknWec5e
         SZ8DK2gDbKPa0OA+0GcYC/h1iaAxOGC7CSEvlcPOQBDJIV4Tz3ulS31JRQhUgYpv2/Ns
         GwMbB+4idXQINMR5L0GCQedt84coRN59NSkidlNjPTn9A6ERwhle4jmtuGEBEL0kEQr6
         tLsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hdr4uO/8YFoSPcjOUHFlKHlEJ1GJYDefEgm7W7Vh5/0=;
        b=l7AmuttKPfT/WMr9wg8xREYbB6p1/fBBxNEDSfW9AzgVbNJky9knruTBKF1reUQ8fd
         Qrn0w8q3LHwILzCNR2pUDRAv96nPrHEXb6JWdnCktzamAglY+K+pseL+hTM1wKXkklOz
         kWZgOI5s9JOL8n2Mv67qgMhHRSuuXj1JNB+6FR4pHKVjc8kUxJMV2vugylCjz018X1vy
         OvA26k7PVNPNebShM+nFfudHiTx8Id79vXdlua6FzJ+0mDJVQ8OvWSVWssrJ8Bm4awFa
         56yWPapRsvr/C0g33mVfDK0ZMdAUeBfQCWUxqDLHZEvNCmRW9n13dvgvcM42w5IZQZaI
         csbg==
X-Gm-Message-State: AOAM530ZMwHcNnLnI6inJEZqeFubbUTQjkBBCdaRwiXNUCiYSo30jxW0
        lcUIyYOfx7WIx9qYiRoKWtr0qpbNJk5MXifFX/Y=
X-Google-Smtp-Source: ABdhPJyTh1aW9hFWUQ7/0Rc3X5iIAjAS+UbSKFCyXKmaF/CGm09wkf7PljMMzSUpNTc/Ei0abNslvJIuq0+CYdVOtk8=
X-Received: by 2002:a05:6000:15c6:: with SMTP id y6mr3167673wry.210.1634176018110;
 Wed, 13 Oct 2021 18:46:58 -0700 (PDT)
MIME-Version: 1.0
References: <20211013102346.179642-1-laoar.shao@gmail.com> <20211013102346.179642-2-laoar.shao@gmail.com>
 <20211013091104.4ea0e05b@gandalf.local.home>
In-Reply-To: <20211013091104.4ea0e05b@gandalf.local.home>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 14 Oct 2021 09:46:21 +0800
Message-ID: <CALOAHbDn8xzm79R8_YJ+MF3SpKDKbouNCG21XYA0gsEO9xYNbw@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] elfcore: use TASK_COMM_LEN instead of 16 in prpsinfo
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
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 9:11 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 13 Oct 2021 10:23:42 +0000
> Yafang Shao <laoar.shao@gmail.com> wrote:
>
> > kernel test robot reported a -Wstringop-truncation warning after I
> > extend task comm from 16 to 24. Below is the detailed warning:
> >
> >    fs/binfmt_elf.c: In function 'fill_psinfo.isra':
> > >> fs/binfmt_elf.c:1575:9: warning: 'strncpy' output may be truncated copying 16 bytes from a string of length 23 [-Wstringop-truncation]
> >     1575 |         strncpy(psinfo->pr_fname, p->comm, sizeof(psinfo->pr_fname));
> >          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > This patch can fix this warning.
> >
> > struct elf_prpsinfo was moved from include/uapi/linux/elfcore.h into
> > include/linux/elfcore.h in commit
> > 1e6b57d6421f ("unexport linux/elfcore.h")
> >
> > As it is not UAPI code, we can replace 16 with TASK_COMM_LEN without
> > worrying about breaking userspace things.
> >
> > struct elf_prpsinfo is used to dump the task information in userspace
> > coredump or kernel vmcore. So I verified what will happen to vmcore if
> > I extend the size of TASK_COMM_LEN to 24. The result is that the vmcore
> > still work fine as expected, for example:
> >
> > crash> ps
> >    PID    PPID  CPU       TASK        ST  %MEM     VSZ    RSS  COMM
> > >     0      0   0  ffffffff8501a940  RU   0.0       0      0  [swapper/0]
> > >     0      0   1  ffff996e00f81f80  RU   0.0       0      0  [swapper/1]
> > >     0      0   2  ffff996e00f80000  RU   0.0       0      0  [swapper/2]
> > >     0      0   3  ffff996e00f85e80  RU   0.0       0      0  [swapper/3]
> > >     0      0   4  ffff996e00f83f00  RU   0.0       0      0  [swapper/4]
> >       0      0   5  ffff996e00f8de80  RU   0.0       0      0  [swapper/5]
> > >     0      0   6  ffff996e00f8bf00  RU   0.0       0      0  [swapper/6]
> > >     0      0   7  ffff996e00f89f80  RU   0.0       0      0  [swapper/7]
> > >     0      0   8  ffff996e00f88000  RU   0.0       0      0  [swapper/8]
> > >     0      0   9  ffff996e00f93f00  RU   0.0       0      0  [swapper/9]
> > >     0      0  10  ffff996e00f91f80  RU   0.0       0      0  [swapper/10]
> > >     0      0  11  ffff996e00f90000  RU   0.0       0      0  [swapper/11]
> > >     0      0  12  ffff996e00f95e80  RU   0.0       0      0  [swapper/12]
> > >     0      0  13  ffff996e00f98000  RU   0.0       0      0  [swapper/13]
> > >     0      0  14  ffff996e00f9de80  RU   0.0       0      0  [swapper/14]
> > >     0      0  15  ffff996e00f9bf00  RU   0.0       0      0  [swapper/15]
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > Cc: Petr Mladek <pmladek@suse.com>
> > ---
> >  include/linux/elfcore-compat.h | 2 +-
> >  include/linux/elfcore.h        | 4 ++--
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/elfcore-compat.h b/include/linux/elfcore-compat.h
> > index e272c3d452ce..8a52a782161d 100644
> > --- a/include/linux/elfcore-compat.h
> > +++ b/include/linux/elfcore-compat.h
> > @@ -43,7 +43,7 @@ struct compat_elf_prpsinfo
> >       __compat_uid_t                  pr_uid;
> >       __compat_gid_t                  pr_gid;
> >       compat_pid_t                    pr_pid, pr_ppid, pr_pgrp, pr_sid;
> > -     char                            pr_fname[16];
> > +     char                            pr_fname[TASK_COMM_LEN];
> >       char                            pr_psargs[ELF_PRARGSZ];
> >  };
>
> Nice clean up, but should we add "#include <linux/sched.h>" to this header,
> to make sure that it pulls in TASK_COMM_LEN define and not just hope it
> gets pulled in beforehand by chance?
>

Sure, I will add it.
Thanks for the suggestion.

> >
> > diff --git a/include/linux/elfcore.h b/include/linux/elfcore.h
> > index 2aaa15779d50..ff4e4e455160 100644
> > --- a/include/linux/elfcore.h
> > +++ b/include/linux/elfcore.h
> > @@ -65,8 +65,8 @@ struct elf_prpsinfo
> >       __kernel_gid_t  pr_gid;
> >       pid_t   pr_pid, pr_ppid, pr_pgrp, pr_sid;
> >       /* Lots missing */
> > -     char    pr_fname[16];   /* filename of executable */
> > -     char    pr_psargs[ELF_PRARGSZ]; /* initial part of arg list */
> > +     char    pr_fname[TASK_COMM_LEN]; /* filename of executable */
> > +     char    pr_psargs[ELF_PRARGSZ];  /* initial part of arg list */
>
> This header is fine, as it pulls in sched/task_stack.h which includes
> sched.h.
>
> -- Steve
>
> >  };
> >
> >  static inline void elf_core_copy_regs(elf_gregset_t *elfregs, struct pt_regs *regs)
>


-- 
Thanks
Yafang
