Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67654334A33
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 22:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbhCJV4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 16:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbhCJV4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 16:56:42 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A318FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 13:56:42 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id v13so28268edw.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 13:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VVOVwyMyJPWIYMuGyr0Sa4Arv7cvqZ/k7O8fTb2RCLw=;
        b=mAjciraf9aHmyBGLHUr8xDsXYJ3b2pHUUvFGKdF2VYNnx6Z9/1KtmdkueR5Ex+j6dR
         QfDDSyAxWRMuafdRAVATK6+sTaW/L7MeL2ZgDskILEM2mBTHuR1uK1jTd+mQl1qP4ZwF
         Wt3teC221TYejdipPs7vTpX/3l7uOTlHTsKrHuju6PO/+2mLStMUy9BK5sJ7o1U6aVeC
         YBmC2gticm4D5VAcao7UsuMSRg32egPZ8V0aAWN2SP53cuFtB/cHEEFdPC09YNot2C3Q
         dGhQL4Foay0FfvGOkNWUcyB9z4fw8NOkU5pk0aKycKJj7GcyQGtv6qQiF8oA0p1eJxP2
         xNPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VVOVwyMyJPWIYMuGyr0Sa4Arv7cvqZ/k7O8fTb2RCLw=;
        b=P9kfb36GFfkPKnLfNhkmhUo7l1osG2r+CO4KMinvcGNBF0Tzqb2OPqZkMK1fa7sgDW
         mna5kd6okIoPwWJB8/98snwKhd9ylH57hAAK8PgPAIH5/I0WRryPyoH7RP5dG5zAdYOp
         B1RZTM3isLG7EUSakb2senryLoB9GGP5fc2qEuhqFonWgvbH5NHMtzC5hsoglGBeQd+N
         dCmeQkWfUulbai/+pSrO0K7X78fjRyvMz47nGJEM5b/Q+QatJ78ZJwAmLHhdRcoJYyoG
         krBD+zp8EEWQvceMm4J7ERlSftA2DIrLTblOTQxaRViVSzb44sw29r1U5E8wvkBCkt0o
         EHsw==
X-Gm-Message-State: AOAM532ZDcOA5njEFgL9/szH2ZYXFVP+zkqb2rK+tI/s3v+mWKFVso7r
        NaITcGnt5evM3kaLy28YJNpwx4CKQDt1iZQ2LZhj8A==
X-Google-Smtp-Source: ABdhPJzGat1mD9Xsk4PPqruPJht8J8OJU6Q7XCXUz0lOaJYDlaAfPYhnlGLYeGjBQ8N/5hduJwp1Wq+B1j4J3Cyu754=
X-Received: by 2002:aa7:c815:: with SMTP id a21mr5662366edt.38.1615413400913;
 Wed, 10 Mar 2021 13:56:40 -0800 (PST)
MIME-Version: 1.0
References: <20201202123420.g3ivr5le4imcrdsa@DESKTOP-E1NTVVP.localdomain> <20201221201019.2897731-1-lpy@google.com>
In-Reply-To: <20201221201019.2897731-1-lpy@google.com>
From:   Peiyong Lin <lpy@google.com>
Date:   Wed, 10 Mar 2021 13:56:29 -0800
Message-ID: <CA+0soAnXOknfWBbuHiq4VG8byoQ89u8NdYBtq-n-JMURPUOhUw@mail.gmail.com>
Subject: Re: [PATCH v5] Add power/gpu_frequency tracepoint.
To:     Brian Starkey <brian.starkey@arm.com>
Cc:     alexdeucher@gmail.com, android-kernel@google.com,
        dri-devel@lists.freedesktop.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        nd@arm.com, Paul Walmsley <paul.walmsley@sifive.com>,
        Pavel Machek <pavel@ucw.cz>,
        Prahlad Kilambi <prahladk@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sidath Senanayake <sidaths@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        zzyiwei@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 12:10 PM Peiyong Lin <lpy@google.com> wrote:
>
> Historically there is no common trace event for GPU frequency, in
> downstream Android each different hardware vendor implements their own
> way to expose GPU frequency, for example as a debugfs node.  This patch
> standardize it as a common trace event in upstream linux kernel to help
> the ecosystem have a common implementation across hardware vendors.
> Toolings in the Linux ecosystem will benefit from this especially in the
> downstream Android, where this information is critical to graphics
> developers.
>
> Signed-off-by: Peiyong Lin <lpy@google.com>
> ---
>
> Changelog since v4:
>  - Explicitly use class id and instance id to identify a GPU instance.
>  - Change gpu_id to clock_id to call out its the clock domain in
>    the GPU instance.
>
> Changelog since v3:
>  - Correct copyright title.
>
> Changelog since v2:
>  - Add more comments to indicate when the event should be emitted.
>  - Change state to frequency.
>
> Changelog since v1:
>  - Use %u in TP_printk
>
>  drivers/gpu/Makefile                    |  1 +
>  drivers/gpu/trace/Kconfig               |  3 ++
>  drivers/gpu/trace/Makefile              |  1 +
>  drivers/gpu/trace/trace_gpu_frequency.c | 13 ++++++++
>  include/trace/events/power.h            | 41 +++++++++++++++++++++++++
>  5 files changed, 59 insertions(+)
>  create mode 100644 drivers/gpu/trace/trace_gpu_frequency.c
>
> diff --git a/drivers/gpu/Makefile b/drivers/gpu/Makefile
> index 835c88318cec..f289a47eb031 100644
> --- a/drivers/gpu/Makefile
> +++ b/drivers/gpu/Makefile
> @@ -6,3 +6,4 @@ obj-$(CONFIG_TEGRA_HOST1X)      += host1x/
>  obj-y                  += drm/ vga/
>  obj-$(CONFIG_IMX_IPUV3_CORE)   += ipu-v3/
>  obj-$(CONFIG_TRACE_GPU_MEM)            += trace/
> +obj-$(CONFIG_TRACE_GPU_FREQUENCY)              += trace/
> diff --git a/drivers/gpu/trace/Kconfig b/drivers/gpu/trace/Kconfig
> index c24e9edd022e..ac4aec8d5845 100644
> --- a/drivers/gpu/trace/Kconfig
> +++ b/drivers/gpu/trace/Kconfig
> @@ -2,3 +2,6 @@
>
>  config TRACE_GPU_MEM
>         bool
> +
> +config TRACE_GPU_FREQUENCY
> +       bool
> diff --git a/drivers/gpu/trace/Makefile b/drivers/gpu/trace/Makefile
> index b70fbdc5847f..2b7ae69327d6 100644
> --- a/drivers/gpu/trace/Makefile
> +++ b/drivers/gpu/trace/Makefile
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
>
>  obj-$(CONFIG_TRACE_GPU_MEM) += trace_gpu_mem.o
> +obj-$(CONFIG_TRACE_GPU_FREQUENCY) += trace_gpu_frequency.o
> diff --git a/drivers/gpu/trace/trace_gpu_frequency.c b/drivers/gpu/trace/trace_gpu_frequency.c
> new file mode 100644
> index 000000000000..668fabd6b77a
> --- /dev/null
> +++ b/drivers/gpu/trace/trace_gpu_frequency.c
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * GPU frequency trace points
> + *
> + * Copyright (C) 2020 Google LLC
> + */
> +
> +#include <linux/module.h>
> +
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/power.h>
> +
> +EXPORT_TRACEPOINT_SYMBOL(gpu_frequency);
> diff --git a/include/trace/events/power.h b/include/trace/events/power.h
> index af5018aa9517..590e16169dd1 100644
> --- a/include/trace/events/power.h
> +++ b/include/trace/events/power.h
> @@ -500,6 +500,47 @@ DEFINE_EVENT(dev_pm_qos_request, dev_pm_qos_remove_request,
>
>         TP_ARGS(name, type, new_value)
>  );
> +
> +/**
> + * gpu_frequency - Reports the GPU frequency in GPU clock domains.
> + *
> + * This event should be emitted whenever there's a GPU frequency change happens,
> + * or a GPU goes from idle state to active state, or vice versa.
> + *
> + * When the GPU goes from idle state to active state, this event should report
> + * the GPU frequency of the active state. When the GPU goes from active state to
> + * idle state, this event should report a zero frequency value.
> + *
> + * @frequency:  New frequency (in KHz)
> + * @gpu_class_id: Id representing the class of the GPU
> + * @gpu_instance_id: Id representing the instance of class &gpu_class_id
> + * @clock_id: Id for the clock domain in &gpu_instance_id running at &frequency
> + */
> +TRACE_EVENT(gpu_frequency,
> +
> +       TP_PROTO(unsigned int frequency, unsigned int gpu_class_id,
> +                unsigned int gpu_instance_id, unsigned int clock_id),
> +
> +       TP_ARGS(frequency, gpu_class_id, gpu_instance_id, clock_id),
> +
> +       TP_STRUCT__entry(
> +               __field(unsigned int, frequency)
> +               __field(unsigned int, gpu_class_id)
> +               __field(unsigned int, gpu_instance_id)
> +               __field(unsigned int, clock_id)
> +       ),
> +
> +       TP_fast_assign(
> +               __entry->frequency = frequency;
> +               __entry->gpu_class_id = gpu_class_id;
> +               __entry->gpu_instance_id = gpu_instance_id;
> +               __entry->clock_id = clock_id;
> +       ),
> +
> +       TP_printk("frequency=%u gpu_class_id=%u gpu_instance_id=%u clock_id=%u",
> +               __entry->frequency, __entry->gpu_class_id,
> +               __entry->gpu_instance_id, __entry->clock_id)
> +);
>  #endif /* _TRACE_POWER_H */
>
>  /* This part must be outside protection */
> --
> 2.29.2.684.gfbc64c5ab5-goog
>

Hi there,

Could you please take a look at this patch?

Thanks,
Peiyong
