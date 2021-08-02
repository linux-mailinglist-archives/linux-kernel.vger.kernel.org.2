Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D05013DDAA7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 16:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235253AbhHBOSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 10:18:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47387 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238124AbhHBOQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 10:16:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627913782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nZqfKZzbTUBRPXqE+WeXWJfvXCTFxHbXBmjAjfpVQps=;
        b=WrfhgBOoc5WhkH9mNlWC3tvAwZEfK5cOezPo4cf5xebZ13yvxb4NBNj9NgB2Cw2d5UQIfy
        5JE2xaTg+qAc6GglFpL2EnvXh8T4Ls+rIpkdLtACHgzJ8KgwP93BEjpcyqf4oxjOzQd9RI
        Pv3b/Fd5yeSJr6MpwX25LR4SSmpQdqE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-OJGBWtxmMGmNKSsvy3As6w-1; Mon, 02 Aug 2021 10:16:18 -0400
X-MC-Unique: OJGBWtxmMGmNKSsvy3As6w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 14C47760C1;
        Mon,  2 Aug 2021 14:16:17 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 43B8E5D6CF;
        Mon,  2 Aug 2021 14:16:16 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 2051441752A3; Mon,  2 Aug 2021 11:16:11 -0300 (-03)
Date:   Mon, 2 Aug 2021 11:16:11 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Nitesh Lal <nilal@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>
Subject: Re: [patch 1/4] add basic task isolation prctl interface
Message-ID: <20210802141611.GA40008@fuller.cnet>
References: <20210730201827.269106165@fuller.cnet>
 <20210730202010.240095394@fuller.cnet>
 <CAFki+LkQVQOe+5aNEKWDvLdnjWjxzKWOiqOvBZzeuPWX+G=XgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFki+LkQVQOe+5aNEKWDvLdnjWjxzKWOiqOvBZzeuPWX+G=XgA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2021 at 10:02:03AM -0400, Nitesh Lal wrote:
> On Fri, Jul 30, 2021 at 4:21 PM Marcelo Tosatti <mtosatti@redhat.com> wrote:
> 
> > Add basic prctl task isolation interface, which allows
> > informing the kernel that application is executing
> > latency sensitive code (where interruptions are undesired).
> >
> > Interface is described by task_isolation.rst (added by this patch).
> >
> > Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> >
> >
>  [...]
> 
> +extern void __tsk_isol_exit(struct task_struct *tsk);
> > +
> > +static inline void tsk_isol_exit(struct task_struct *tsk)
> > +{
> > +       if (tsk->isol_info)
> > +               __tsk_isol_exit(tsk);
> > +}
> > +
> > +
> >
> 
> nit: we can get rid of this extra line.
> 
> 
> > +int prctl_task_isolation_feat(unsigned long arg2, unsigned long arg3,
> > +                             unsigned long arg4, unsigned long arg5);
> > +int prctl_task_isolation_get(unsigned long arg2, unsigned long arg3,
> > +                            unsigned long arg4, unsigned long arg5);
> > +int prctl_task_isolation_set(unsigned long arg2, unsigned long arg3,
> > +                            unsigned long arg4, unsigned long arg5);
> > +int prctl_task_isolation_ctrl_get(unsigned long arg2, unsigned long arg3,
> > +                                 unsigned long arg4, unsigned long arg5);
> > +int prctl_task_isolation_ctrl_set(unsigned long arg2, unsigned long arg3,
> > +                                 unsigned long arg4, unsigned long arg5);
> > +
> > +#else
> > +
> > +static inline void tsk_isol_exit(struct task_struct *tsk)
> > +{
> > +}
> > +
> > +static inline int prctl_task_isolation_feat(unsigned long arg2,
> > +                                           unsigned long arg3,
> > +                                           unsigned long arg4,
> > +                                           unsigned long arg5)
> > +{
> > +       return -EOPNOTSUPP;
> > +}
> > +
> > +static inline int prctl_task_isolation_get(unsigned long arg2,
> > +                                          unsigned long arg3,
> > +                                          unsigned long arg4,
> > +                                          unsigned long arg5)
> > +{
> > +       return -EOPNOTSUPP;
> > +}
> > +
> > +static inline int prctl_task_isolation_set(unsigned long arg2,
> > +                                          unsigned long arg3,
> > +                                          unsigned long arg4,
> > +                                          unsigned long arg5)
> > +{
> > +       return -EOPNOTSUPP;
> > +}
> > +
> > +static inline int prctl_task_isolation_ctrl_get(unsigned long arg2,
> > +                                               unsigned long arg3,
> > +                                               unsigned long arg4,
> > +                                               unsigned long arg5)
> > +{
> > +       return -EOPNOTSUPP;
> > +}
> > +
> > +static inline int prctl_task_isolation_ctrl_set(unsigned long arg2,
> > +                                               unsigned long arg3,
> > +                                               unsigned long arg4,
> > +                                               unsigned long arg5)
> > +{
> > +       return -EOPNOTSUPP;
> > +}
> > +
> > +#endif /* CONFIG_CPU_ISOLATION */
> > +
> > +#endif /* __LINUX_TASK_ISOL_H */
> > Index: linux-2.6/kernel/task_isolation.c
> > ===================================================================
> > --- /dev/null
> > +++ linux-2.6/kernel/task_isolation.c
> > @@ -0,0 +1,274 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + *  Implementation of task isolation.
> > + *
> > + * Authors:
> > + *   Chris Metcalf <cmetcalf@mellanox.com>
> > + *   Alex Belits <abelits@belits.com>
> > + *   Yuri Norov <ynorov@marvell.com>
> > + *   Marcelo Tosatti <mtosatti@redhat.com>
> > + */
> > +
> > +#include <linux/sched.h>
> > +#include <linux/task_isolation.h>
> > +#include <linux/prctl.h>
> > +#include <linux/slab.h>
> > +#include <linux/kobject.h>
> > +#include <linux/string.h>
> > +#include <linux/sysfs.h>
> > +#include <linux/init.h>
> > +
> > +static unsigned long default_quiesce_mask;
> > +
> > +static int tsk_isol_alloc_context(struct task_struct *task)
> > +{
> > +       struct isol_info *info;
> > +
> > +       info = kzalloc(sizeof(*info), GFP_KERNEL);
> > +       if (unlikely(!info))
> > +               return -ENOMEM;
> > +
> > +       task->isol_info = info;
> > +       return 0;
> > +}
> > +
> > +void __tsk_isol_exit(struct task_struct *tsk)
> > +{
> > +       kfree(tsk->isol_info);
> > +       tsk->isol_info = NULL;
> > +}
> > +
> > +static int prctl_task_isolation_feat_quiesce(unsigned long type)
> > +{
> > +       switch (type) {
> > +       case 0:
> > +               return ISOL_F_QUIESCE_VMSTATS;
> > +       case ISOL_F_QUIESCE_DEFMASK:
> > +               return default_quiesce_mask;
> > +       default:
> > +               break;
> > +       }
> > +
> > +       return -EINVAL;
> > +}
> > +
> > +static int task_isolation_get_quiesce(void)
> > +{
> > +       if (current->isol_info != NULL)
> >
> 
> Should replace the above with just 'if (current->isol_info)'.
> 
> +               return current->isol_info->quiesce_mask;
> > +
> > +       return 0;
> > +}
> > +
> > +static int task_isolation_set_quiesce(unsigned long quiesce_mask)
> > +{
> > +       if (quiesce_mask != ISOL_F_QUIESCE_VMSTATS && quiesce_mask != 0)
> > +               return -EINVAL;
> > +
> > +       current->isol_info->quiesce_mask = quiesce_mask;
> > +       return 0;
> > +}
> > +
> > +int prctl_task_isolation_feat(unsigned long feat, unsigned long arg3,
> > +                             unsigned long arg4, unsigned long arg5)
> > +{
> > +       switch (feat) {
> > +       case 0:
> > +               return ISOL_F_QUIESCE;
> > +       case ISOL_F_QUIESCE:
> > +               return prctl_task_isolation_feat_quiesce(arg3);
> > +       default:
> > +               break;
> > +       }
> > +       return -EINVAL;
> > +}
> > +
> > +int prctl_task_isolation_get(unsigned long feat, unsigned long arg3,
> > +                            unsigned long arg4, unsigned long arg5)
> > +{
> > +       switch (feat) {
> > +       case ISOL_F_QUIESCE:
> > +               return task_isolation_get_quiesce();
> > +       default:
> > +               break;
> > +       }
> > +       return -EINVAL;
> > +}
> > +
> > +int prctl_task_isolation_set(unsigned long feat, unsigned long arg3,
> > +                            unsigned long arg4, unsigned long arg5)
> > +{
> > +       int ret;
> > +       bool err_free_ctx = false;
> > +
> > +       if (current->isol_info == NULL)
> >
> 
> Can replace this with 'if (!current->isol_info).
> There are other places below where similar improvement can be done.
> 
> 
> > +               err_free_ctx = true;
> > +
> > +       ret = tsk_isol_alloc_context(current);
> > +       if (ret)
> > +               return ret;
> > +
> > +       switch (feat) {
> > +       case ISOL_F_QUIESCE:
> > +               ret = task_isolation_set_quiesce(arg3);
> > +               if (ret)
> > +                       break;
> > +               return 0;
> > +       default:
> > +               break;
> > +       }
> > +
> > +       if (err_free_ctx)
> > +               __tsk_isol_exit(current);
> > +       return -EINVAL;
> > +}
> > +
> > +int prctl_task_isolation_ctrl_set(unsigned long feat, unsigned long arg3,
> > +                                 unsigned long arg4, unsigned long arg5)
> > +{
> > +       if (current->isol_info == NULL)
> > +               return -EINVAL;
> > +
> > +       if (feat != ISOL_F_QUIESCE && feat != 0)
> > +               return -EINVAL;
> > +
> > +       current->isol_info->active_mask = feat;
> > +       return 0;
> > +}
> > +
> > +int prctl_task_isolation_ctrl_get(unsigned long arg2, unsigned long arg3,
> > +                                 unsigned long arg4, unsigned long arg5)
> > +{
> > +       if (current->isol_info == NULL)
> > +               return 0;
> > +
> > +       return current->isol_info->active_mask;
> > +}
> > +
> > +struct qoptions {
> > +       unsigned long mask;
> > +       char *name;
> > +};
> > +
> > +static struct qoptions qopts[] = {
> > +       {ISOL_F_QUIESCE_VMSTATS, "vmstat"},
> > +};
> > +
> > +#define QLEN (sizeof(qopts) / sizeof(struct qoptions))
> > +
> > +static ssize_t default_quiesce_store(struct kobject *kobj,
> > +                                    struct kobj_attribute *attr,
> > +                                    const char *buf, size_t count)
> > +{
> > +       char *p, *s;
> > +       unsigned long defmask = 0;
> > +
> > +       s = (char *)buf;
> > +       if (count == 1 && strlen(strim(s)) == 0) {
> > +               default_quiesce_mask = 0;
> > +               return count;
> > +       }
> > +
> > +       while ((p = strsep(&s, ",")) != NULL) {
> > +               int i;
> > +               bool found = false;
> > +
> > +               if (!*p)
> > +                       continue;
> > +
> > +               for (i = 0; i < QLEN; i++) {
> > +                       struct qoptions *opt = &qopts[i];
> > +
> > +                       if (strncmp(strim(p), opt->name,
> > strlen(opt->name)) == 0) {
> > +                               defmask |= opt->mask;
> > +                               found = true;
> > +                               break;
> > +                       }
> > +               }
> > +               if (found == true)
> > +                       continue;
> > +               return -EINVAL;
> > +       }
> > +       default_quiesce_mask = defmask;
> > +
> > +       return count;
> > +}
> > +
> > +#define MAXARRLEN 100
> > +
> > +static ssize_t default_quiesce_show(struct kobject *kobj,
> > +                                   struct kobj_attribute *attr, char *buf)
> > +{
> > +       int i;
> > +       char tbuf[MAXARRLEN] = "";
> > +
> > +       for (i = 0; i < QLEN; i++) {
> > +               struct qoptions *opt = &qopts[i];
> > +
> > +               if (default_quiesce_mask & opt->mask) {
> > +                       strlcat(tbuf, opt->name, MAXARRLEN);
> > +                       strlcat(tbuf, "\n", MAXARRLEN);
> > +               }
> > +       }
> > +
> > +       return sprintf(buf, "%s", tbuf);
> > +}
> > +
> > +static struct kobj_attribute default_quiesce_attr =
> > +                               __ATTR_RW(default_quiesce);
> > +
> > +static ssize_t available_quiesce_show(struct kobject *kobj,
> > +                                     struct kobj_attribute *attr, char
> > *buf)
> > +{
> > +       int i;
> > +       char tbuf[MAXARRLEN] = "";
> > +
> > +       for (i = 0; i < QLEN; i++) {
> > +               struct qoptions *opt = &qopts[i];
> > +
> > +               strlcat(tbuf, opt->name, MAXARRLEN);
> > +               strlcat(tbuf, "\n", MAXARRLEN);
> > +       }
> > +
> > +       return sprintf(buf, "%s", tbuf);
> > +}
> > +
> > +static struct kobj_attribute available_quiesce_attr =
> > +                               __ATTR_RO(available_quiesce);
> > +
> > +static struct attribute *task_isol_attrs[] = {
> > +       &available_quiesce_attr.attr,
> > +       &default_quiesce_attr.attr,
> > +       NULL,
> > +};
> > +
> > +static const struct attribute_group task_isol_attr_group = {
> > +       .attrs = task_isol_attrs,
> > +       .bin_attrs = NULL,
> > +};
> > +
> > +static int __init task_isol_ksysfs_init(void)
> > +{
> > +       int ret;
> > +       struct kobject *task_isol_kobj;
> > +
> > +       task_isol_kobj = kobject_create_and_add("task_isolation",
> > +                                               kernel_kobj);
> > +       if (!task_isol_kobj) {
> > +               ret = -ENOMEM;
> > +               goto out;
> > +       }
> > +
> > +       ret = sysfs_create_group(task_isol_kobj, &task_isol_attr_group);
> > +       if (ret)
> > +               goto out_task_isol_kobj;
> > +
> > +       return 0;
> > +
> > +out_task_isol_kobj:
> > +       kobject_put(task_isol_kobj);
> > +out:
> > +       return ret;
> > +}
> > +
> > +arch_initcall(task_isol_ksysfs_init);
> > Index: linux-2.6/samples/Kconfig
> > ===================================================================
> > --- linux-2.6.orig/samples/Kconfig
> > +++ linux-2.6/samples/Kconfig
> > @@ -223,4 +223,11 @@ config SAMPLE_WATCH_QUEUE
> >           Build example userspace program to use the new mount_notify(),
> >           sb_notify() syscalls and the KEYCTL_WATCH_KEY keyctl() function.
> >
> > +config SAMPLE_TASK_ISOLATION
> > +       bool "task isolation sample"
> > +       depends on CC_CAN_LINK && HEADERS_INSTALL
> > +       help
> > +         Build example userspace program to use prctl task isolation
> > +         interface.
> > +
> >  endif # SAMPLES
> > Index: linux-2.6/samples/Makefile
> > ===================================================================
> > --- linux-2.6.orig/samples/Makefile
> > +++ linux-2.6/samples/Makefile
> > @@ -30,3 +30,4 @@ obj-$(CONFIG_SAMPLE_INTEL_MEI)                += mei/
> >  subdir-$(CONFIG_SAMPLE_WATCHDOG)       += watchdog
> >  subdir-$(CONFIG_SAMPLE_WATCH_QUEUE)    += watch_queue
> >  obj-$(CONFIG_DEBUG_KMEMLEAK_TEST)      += kmemleak/
> > +subdir-$(CONFIG_SAMPLE_TASK_ISOLATION) += task_isolation
> > Index: linux-2.6/samples/task_isolation/Makefile
> > ===================================================================
> > --- /dev/null
> > +++ linux-2.6/samples/task_isolation/Makefile
> > @@ -0,0 +1,4 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +userprogs-always-y += task_isolation
> > +
> > +userccflags += -I usr/include
> >
> >
> >
> I am wondering if it is possible to further split this patch into smaller
> ones?

OK, will try to split in smaller patches and fix the
style issues.

Thanks.

