Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A73B3DF94C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 03:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbhHDBgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 21:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbhHDBgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 21:36:46 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEFFC06175F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 18:36:33 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id y200so668254iof.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 18:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bhIVG0r/qPK2TcXgdoBmOu4PcDkyct/LwknBdo9Vm44=;
        b=etBcJ3hu100rjwpYbtkwmf8cHrGicv0c9BRH5dqeQvhA8zcw3+yGFBvmd2oy+G61Xg
         FsrZRQSWT9OxH3+a1u6lJZxFDV9XYgG/FvTcnwo8fC56qa/OxJtasWYEcn5uJc/3oShm
         N64c/k7CWL+iVZm6/xstuh0srxrA5safwTTUq74m3MQrr+DDHmHioUbw7r5FbDqude+X
         T0KT0TIFtReLsSuwFzynBBT4o8SN9WcNQxCWDCj9kyt+w+K/Dfz9x2RXl/xUbbC2i91h
         GA5JWnotazSaiGpQAdn3yGcxIpNjeks+ztzGtI5FXnQN6QauvcXWDewu4VrqlSLq5EGu
         +EGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bhIVG0r/qPK2TcXgdoBmOu4PcDkyct/LwknBdo9Vm44=;
        b=L2HHAK+7NYSrxg4ycLgqGcp1NIH7hGYHIc2oxfrCioQwxLnSAZvOuw5QFYb3102wOr
         eiveRykK2SzVdChdU9EKLhjYpOkDRmNUZ/nKg3iShaHO8H/FELzParRRWsNaEdCBk76Z
         QVwYP6oGk/wMByh87sLJJB8hFrDKLLELQXzswmDHcf/x/6JTla1ZKP2ri69hIB+ScgZe
         5fz5Q4rv9V3Raewoa/slgXUMmTwILt/DxFUXO0tS1wzxIfemTfYgHehd438yQD+41Ywi
         QZZ4ZjVbf8fHHFKpEzGpZenMbekMxySILbN3Gj21SMIXlaQOK2YJG6hpDFWdjfRtTGCW
         oG2g==
X-Gm-Message-State: AOAM532iuIgzOUHzlKPa+0K/m3bG15xhm85n4iAWNG8FqaLLKQTUBE4D
        0Kf//NhZzTUVRMSuPRRw/yi2HaBoMoMZXlQsIWA=
X-Google-Smtp-Source: ABdhPJycfMu+ic0YNnSUcQN1/5sg6KuvTG4vElZbfMKEXBBPpsDnPy61q94tyZVwsYb/Ok7/beqk5C+zLHKVOSQqG98=
X-Received: by 2002:a02:2243:: with SMTP id o64mr21894799jao.40.1628040993394;
 Tue, 03 Aug 2021 18:36:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210803141621.780504-1-bigeasy@linutronix.de> <20210803141621.780504-38-bigeasy@linutronix.de>
In-Reply-To: <20210803141621.780504-38-bigeasy@linutronix.de>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Wed, 4 Aug 2021 09:36:21 +0800
Message-ID: <CAJhGHyAjXDxcktZLCcZiN8cCvMX8LqO5-UyLAwEJoELBoRxhZw@mail.gmail.com>
Subject: Re: [PATCH 37/38] workqueue: Replace deprecated CPU-hotplug functions.
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 3, 2021 at 10:17 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> The functions get_online_cpus() and put_online_cpus() have been
> deprecated during the CPU hotplug rework. They map directly to
> cpus_read_lock() and cpus_read_unlock().
>
> Replace deprecated CPU-hotplug functions with the official version.
> The behavior remains unchanged.
>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---


Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>

>  kernel/workqueue.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index f148eacda55a9..f967aa4050d08 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -3293,7 +3293,7 @@ int schedule_on_each_cpu(work_func_t func)
>         if (!works)
>                 return -ENOMEM;
>
> -       get_online_cpus();
> +       cpus_read_lock();
>
>         for_each_online_cpu(cpu) {
>                 struct work_struct *work = per_cpu_ptr(works, cpu);
> @@ -3305,7 +3305,7 @@ int schedule_on_each_cpu(work_func_t func)
>         for_each_online_cpu(cpu)
>                 flush_work(per_cpu_ptr(works, cpu));
>
> -       put_online_cpus();
> +       cpus_read_unlock();
>         free_percpu(works);
>         return 0;
>  }
> @@ -4016,14 +4016,14 @@ static void apply_wqattrs_commit(struct apply_wqattrs_ctx *ctx)
>  static void apply_wqattrs_lock(void)
>  {
>         /* CPUs should stay stable across pwq creations and installations */
> -       get_online_cpus();
> +       cpus_read_lock();
>         mutex_lock(&wq_pool_mutex);
>  }
>
>  static void apply_wqattrs_unlock(void)
>  {
>         mutex_unlock(&wq_pool_mutex);
> -       put_online_cpus();
> +       cpus_read_unlock();
>  }
>
>  static int apply_workqueue_attrs_locked(struct workqueue_struct *wq,
> @@ -4068,7 +4068,7 @@ static int apply_workqueue_attrs_locked(struct workqueue_struct *wq,
>   *
>   * Performs GFP_KERNEL allocations.
>   *
> - * Assumes caller has CPU hotplug read exclusion, i.e. get_online_cpus().
> + * Assumes caller has CPU hotplug read exclusion, i.e. cpus_read_lock().
>   *
>   * Return: 0 on success and -errno on failure.
>   */
> @@ -4196,7 +4196,7 @@ static int alloc_and_link_pwqs(struct workqueue_struct *wq)
>                 return 0;
>         }
>
> -       get_online_cpus();
> +       cpus_read_lock();
>         if (wq->flags & __WQ_ORDERED) {
>                 ret = apply_workqueue_attrs(wq, ordered_wq_attrs[highpri]);
>                 /* there should only be single pwq for ordering guarantee */
> @@ -4206,7 +4206,7 @@ static int alloc_and_link_pwqs(struct workqueue_struct *wq)
>         } else {
>                 ret = apply_workqueue_attrs(wq, unbound_std_wq_attrs[highpri]);
>         }
> -       put_online_cpus();
> +       cpus_read_unlock();
>
>         return ret;
>  }
> @@ -5168,10 +5168,10 @@ long work_on_cpu_safe(int cpu, long (*fn)(void *), void *arg)
>  {
>         long ret = -ENODEV;
>
> -       get_online_cpus();
> +       cpus_read_lock();
>         if (cpu_online(cpu))
>                 ret = work_on_cpu(cpu, fn, arg);
> -       put_online_cpus();
> +       cpus_read_unlock();
>         return ret;
>  }
>  EXPORT_SYMBOL_GPL(work_on_cpu_safe);
> @@ -5443,7 +5443,7 @@ static ssize_t wq_pool_ids_show(struct device *dev,
>         const char *delim = "";
>         int node, written = 0;
>
> -       get_online_cpus();
> +       cpus_read_lock();
>         rcu_read_lock();
>         for_each_node(node) {
>                 written += scnprintf(buf + written, PAGE_SIZE - written,
> @@ -5453,7 +5453,7 @@ static ssize_t wq_pool_ids_show(struct device *dev,
>         }
>         written += scnprintf(buf + written, PAGE_SIZE - written, "\n");
>         rcu_read_unlock();
> -       put_online_cpus();
> +       cpus_read_unlock();
>
>         return written;
>  }
> --
> 2.32.0
>
