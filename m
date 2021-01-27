Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77ADE30594D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 12:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236550AbhA0LLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 06:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236472AbhA0LIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 06:08:43 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29B3C061573
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 03:08:03 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id md11so1058672pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 03:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9DSp1ITep33VIP4T/u0LeIm5l24Xs5M+93A44dskiuI=;
        b=U3eoiFzA8So9NA95+GzS0IxZ26RDKj3MyDQaNXr7MSnALdL8aoPLlvO3x6Iky+WC2w
         dtIR4XS5jHlOZcRlHFNsvM51ihmO6DM/nAIEv7cVhPdQplsiuN/lpYZBKLF0SeIiAP/Y
         qdckRiYJINY1vxikeKFLbGCIhd5noF28NpA1s40Ue/byHcDpS7JJstjKxUPnWMId27le
         qIQt7pJHR6p6WEenQejdPAIzNXLDMngP1/+KUr0ZImX4y25tBt6xJonOBTLRDedcGmXF
         bDdIcAZM1teHN2ujTUHpvpibYhtAPuJY4xgPqonSQbKIJ8LbPL0yYYN31tWaQZAKWwto
         +wEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9DSp1ITep33VIP4T/u0LeIm5l24Xs5M+93A44dskiuI=;
        b=Lpbo/E8Ekp/6uUex2IgW3MezXG0iyl2+co3pkYrI+Az3HNJyYvPWIVQdv8hQ8esN72
         HXXmBn2uJvaWZ40cyUr0Ue2BPWqGBN79gN04upJ6nvod8jzh6ApzzrMZaqCWm8aNq5TS
         W6PbG4Kr0uOhamJ406fmXjExLhsNbVHZq5e2dupXdQdjfZb+xKV/73EoDE6sH2sZKwHb
         4MjbIgFmqCdZHYBtgyd2Eq+xn7IofdWb3WzXBxOc/oWL+WEbfhQTJeE0dnHOfoBftJ3P
         yLnR1BipGrov3Kt+NrkByqrh7i4piK7UiNPfmbo0+4p1xdV6aFmwt2p+WHSPyS7EzF+0
         0+Dw==
X-Gm-Message-State: AOAM533Er5xdadPLaJw8RqIKUe+sZFvFhgrd5in3wNRupOsTAHyS3VyH
        FJLGtlDvyjOEDrTS9qVGiUo=
X-Google-Smtp-Source: ABdhPJwY0fy5JTst6rgnJwhbCbilPLY2QElGyIiQnrurtioOVz+ZolpmQNIQp6Y0ewJTXNvXshnuTg==
X-Received: by 2002:a17:902:e551:b029:de:8dba:84a3 with SMTP id n17-20020a170902e551b02900de8dba84a3mr10956585plf.8.1611745683039;
        Wed, 27 Jan 2021 03:08:03 -0800 (PST)
Received: from localhost (61-68-227-208.tpgi.com.au. [61.68.227.208])
        by smtp.gmail.com with ESMTPSA id w6sm2150106pfq.162.2021.01.27.03.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 03:08:01 -0800 (PST)
Date:   Wed, 27 Jan 2021 22:07:58 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     Weiping Zhang <zwp10758@gmail.com>
Cc:     davem@davemloft.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2] taskstats: add /proc/taskstats to fetch pid/tgid
 status
Message-ID: <20210127110758.GA59838@balbir-desktop>
References: <20201217170009.GA29186@192.168.3.9>
 <CAA70yB6O2on1tpoA8TpT+Hp03iu_Xrpaa_d0HjVa75UFMTA4yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA70yB6O2on1tpoA8TpT+Hp03iu_Xrpaa_d0HjVa75UFMTA4yg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 28, 2020 at 10:10:03PM +0800, Weiping Zhang wrote:
> Hi David,
> 
> Could you help review this patch ?
> 
> thanks

I've got it on my review list, thanks for the ping!
You should hear back from me soon.

Balbir Singh.

> 
> On Fri, Dec 18, 2020 at 1:24 AM Weiping Zhang
> <zhangweiping@didiglobal.com> wrote:
> >
> > If a program needs monitor lots of process's status, it needs two
> > syscalls for every process. The first one is telling kernel which
> > pid/tgid should be monitored by send a command(write socket) to kernel.
> > The second one is read the statistics by read socket. This patch add
> > a new interface /proc/taskstats to reduce two syscalls to one ioctl.
> > The user just set the target pid/tgid to the struct taskstats.ac_pid,
> > then kernel will collect statistics for that pid/tgid.
> >
> > Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
> > ---
> > Changes since v1:
> >  * use /proc/taskstats instead of /dev/taskstats
> >
> >  include/uapi/linux/taskstats.h |  5 +++
> >  kernel/taskstats.c             | 73 +++++++++++++++++++++++++++++++++-
> >  2 files changed, 77 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/uapi/linux/taskstats.h b/include/uapi/linux/taskstats.h
> > index ccbd08709321..077eab84c77e 100644
> > --- a/include/uapi/linux/taskstats.h
> > +++ b/include/uapi/linux/taskstats.h
> > @@ -214,6 +214,11 @@ enum {
> >
> >  #define TASKSTATS_CMD_ATTR_MAX (__TASKSTATS_CMD_ATTR_MAX - 1)
> >
> > +/* ioctl command */
> > +#define TASKSTATS_IOC_ATTR_PID _IO('T', TASKSTATS_CMD_ATTR_PID)
> > +#define TASKSTATS_IOC_ATTR_TGID        _IO('T', TASKSTATS_CMD_ATTR_TGID)
> > +
> > +
> >  /* NETLINK_GENERIC related info */
> >
> >  #define TASKSTATS_GENL_NAME    "TASKSTATS"
> > diff --git a/kernel/taskstats.c b/kernel/taskstats.c
> > index a2802b6ff4bb..c0f9e2f2308b 100644
> > --- a/kernel/taskstats.c
> > +++ b/kernel/taskstats.c
> > @@ -21,6 +21,8 @@
> >  #include <net/genetlink.h>
> >  #include <linux/atomic.h>
> >  #include <linux/sched/cputime.h>
> > +#include <linux/proc_fs.h>
> > +#include <linux/uio.h>
> >
> >  /*
> >   * Maximum length of a cpumask that can be specified in
> > @@ -28,6 +30,10 @@
> >   */
> >  #define TASKSTATS_CPUMASK_MAXLEN       (100+6*NR_CPUS)
> >
> > +#ifdef CONFIG_PROC_FS
> > +#define PROC_TASKSTATS "taskstats"
> > +#endif
> > +
> >  static DEFINE_PER_CPU(__u32, taskstats_seqnum);
> >  static int family_registered;
> >  struct kmem_cache *taskstats_cache;
> > @@ -666,6 +672,60 @@ static struct genl_family family __ro_after_init = {
> >         .n_ops          = ARRAY_SIZE(taskstats_ops),
> >  };
> >
> > +#ifdef CONFIG_PROC_FS
> > +static long taskstats_ioctl_pid_tgid(unsigned long arg, bool tgid)
> > +{
> > +       struct taskstats kstat;
> > +       struct taskstats *ustat = (struct taskstats *)arg;
> > +       u32 id;
> > +       unsigned long offset = offsetof(struct taskstats, ac_pid);
> > +       long ret;
> > +
> > +       /* userspace set monitored pid/tgid to the field "ac_pid" */
> > +       if (unlikely(copy_from_user(&id, (void *)(arg + offset), sizeof(u32))))
> > +               return -EFAULT;
> > +
> > +       if (tgid)
> > +               ret = fill_stats_for_tgid(id, &kstat);
> > +       else
> > +               ret = fill_stats_for_pid(id, &kstat);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       if (unlikely(copy_to_user(ustat, &kstat, sizeof(struct taskstats))))
> > +               return -EFAULT;
> > +
> > +       return 0;
> > +}
> > +
> > +static long taskstats_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> > +{
> > +       long ret;
> > +
> > +       switch (cmd) {
> > +       case TASKSTATS_IOC_ATTR_PID:
> > +               ret = taskstats_ioctl_pid_tgid(arg, false);
> > +               break;
> > +       case TASKSTATS_IOC_ATTR_TGID:
> > +               ret = taskstats_ioctl_pid_tgid(arg, true);
> > +               break;
> > +       default:
> > +               ret = -EINVAL;
> > +               break;
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> > +static const struct proc_ops taskstats_proc_ops = {
> > +       .proc_ioctl = taskstats_ioctl,
> > +#ifdef CONFIG_COMPAT
> > +       .proc_compat_ioctl = taskstats_ioctl,
> > +#endif
> > +};
> > +#endif
> > +
> > +
> >  /* Needed early in initialization */
> >  void __init taskstats_init_early(void)
> >  {
> > @@ -682,9 +742,20 @@ static int __init taskstats_init(void)
> >  {
> >         int rc;
> >
> > +#ifdef CONFIG_PROC_FS
> > +       if (!proc_create(PROC_TASKSTATS,  0, NULL, &taskstats_proc_ops)) {
> > +               pr_err("failed to create /proc/%s\n", PROC_TASKSTATS);
> > +               return -1;
> > +       }
> > +#endif
> > +
> >         rc = genl_register_family(&family);
> > -       if (rc)
> > +       if (rc) {
> > +#ifdef CONFIG_PROC_FS
> > +               remove_proc_entry(PROC_TASKSTATS, NULL);
> > +#endif
> >                 return rc;
> > +       }
> >
> >         family_registered = 1;
> >         pr_info("registered taskstats version %d\n", TASKSTATS_GENL_VERSION);
> > --
> > 2.17.2
> >
