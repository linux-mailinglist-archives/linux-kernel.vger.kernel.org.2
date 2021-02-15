Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFFA31C096
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 18:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbhBOR2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 12:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbhBOQ2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 11:28:19 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8632AC0617A7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 08:27:38 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id j11so6720452wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 08:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y1rcHCUmSNtiITeSpRJjNoEPqFQsoQV92rCJkLWYkIk=;
        b=jltdazZP6wymsmNQCETHf7PGmeyehmBd49HvkHeSiSFcSmZVLygBRXoFh3A4Nnq4Zc
         ys8fFxc4Bijk1+uQRTQKvl7nqY/VtL9RmdHqVEg2PpVedDL8wgZy9nUaX231bikZhz1p
         Sri/0WZZYNpN6NOsj36E2e/JRFcmKr7GnjIP2v9cGhb6S0IlEjXeTjY8KUARMLe2o8eR
         r06jQydfllFBH5kAH5mPZBUB9kdRsm58ajxfOAcUAl4UysaoqtNYauoMkhp277gOLQRn
         a3/+4mUVK+QieKa+fbX6KtPtJn1NZxmxnClbkU2kqJ+Sg06Ae0ZAb5WE6KnO+yxkEjyO
         riHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y1rcHCUmSNtiITeSpRJjNoEPqFQsoQV92rCJkLWYkIk=;
        b=Gu3yih/W4vr1537aQP2E28FskELzfYun27zmn90Im6aoar8IBq/U6ZEvl6fLJHnCPC
         35phiqfskK4F8AunnTepy2WDVWGvHcOfICUQh2TnE/cbg3DN8TUUXXGOqA/fOxfRkeeJ
         14uVL5rKdMl1JwjId5i5ZIIpkF9IbFXs7FAmI1SH4zd0uGUWZHI9N+3cdS8iAXOcM3lE
         KFJjVFQXfgcwk2WYnOqKii//F0DB51wGkwvptkKvCxQjcrXTG0CVPfhrVay/ZUVfe+71
         2OiaQGpD2G9zZFwokKE/vlFcoOrgIEsmzO6RuAjKLLyRsRgQLuvKLxUu8wihIhPrbau7
         dJyw==
X-Gm-Message-State: AOAM530fEZRkqwhw6I+jItwNw6IeaHeS2JUgt2CZhycD/FT11XUTKaKw
        AtgL8FJ2RNua7I1zljEnUp94nXZz8xSP2n4Yn6Sv3g==
X-Google-Smtp-Source: ABdhPJxk/1spqoY1Ye0kZtxe0ODquKQUd7zjwiGOvxgpnPohwchr5EGP2aBbBwm6bDIZV8u99csHaQ6ZtTT7g29srpM=
X-Received: by 2002:a05:600c:3551:: with SMTP id i17mr14817858wmq.92.1613406457225;
 Mon, 15 Feb 2021 08:27:37 -0800 (PST)
MIME-Version: 1.0
References: <1611737738-1493-1-git-send-email-anshuman.khandual@arm.com> <1611737738-1493-9-git-send-email-anshuman.khandual@arm.com>
In-Reply-To: <1611737738-1493-9-git-send-email-anshuman.khandual@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Mon, 15 Feb 2021 16:27:26 +0000
Message-ID: <CAJ9a7VgC0j4TmOYXdUVd19sQqxWOk-tsvv3r5DQzmY59ZptzDQ@mail.gmail.com>
Subject: Re: [PATCH V3 08/14] coresight: core: Add support for dedicated
 percpu sinks
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Linu Cherian <lcherian@marvell.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Anshuman

On Wed, 27 Jan 2021 at 08:55, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
> Add support for dedicated sinks that are bound to individual CPUs. (e.g,
> TRBE). To allow quicker access to the sink for a given CPU bound source,
> keep a percpu array of the sink devices. Also, add support for building
> a path to the CPU local sink from the ETM.
>

Really need to tighten up the terminology here - I think what you mean
is a PE architecturally defined sink - i.e. one that can be determined
by reading the feature registers on the PE, rather than an ETR which
cannot.
However, the Coresight Base System Architecture specification does
recommend a per cpu design using an ETR per CPU - now I assume that
this case is not catered for in this patch?

> This adds a new percpu sink type CORESIGHT_DEV_SUBTYPE_SINK_PERCPU_SYSMEM.
> This new sink type is exclusively available and can only work with percpu
> source type device CORESIGHT_DEV_SUBTYPE_SOURCE_PERCPU_PROC.
>

CORESIGHT_DEV_SUBTYPE_SOURCE_PERCPU_PROC - this does not exist.

>
> This defines a percpu structure that accommodates a single coresight_device
> which can be used to store an initialized instance from a sink driver. As
> these sinks are exclusively linked and dependent on corresponding percpu
> sources devices, they should also be the default sink device during a perf
> session.
>
> Outwards device connections are scanned while establishing paths between a
> source and a sink device. But such connections are not present for certain
> percpu source and sink devices which are exclusively linked and dependent.
> Build the path directly and skip connection scanning for such devices.
>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> Changes in V3:
>
> - Updated coresight_find_default_sink()
>
>  drivers/hwtracing/coresight/coresight-core.c | 16 ++++++++++++++--
>  include/linux/coresight.h                    | 12 ++++++++++++
>  2 files changed, 26 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 0062c89..4795e28 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -23,6 +23,7 @@
>  #include "coresight-priv.h"
>
>  static DEFINE_MUTEX(coresight_mutex);
> +DEFINE_PER_CPU(struct coresight_device *, csdev_sink);
>

If you do indeed mean the architecturally defined sinks then this
could be 'csdev_pe_arch_sink' - or something similar to indicate the
reliance on the PE architecture, unless per-cpu ETR topologies are
also handled here.

>  /**
>   * struct coresight_node - elements of a path, from source to sink
> @@ -784,6 +785,13 @@ static int _coresight_build_path(struct coresight_device *csdev,
>         if (csdev == sink)
>                 goto out;
>
> +       if (coresight_is_percpu_source(csdev) && coresight_is_percpu_sink(sink) &&
> +           sink == per_cpu(csdev_sink, source_ops(csdev)->cpu_id(csdev))) {
> +               _coresight_build_path(sink, sink, path);
> +               found = true;
> +               goto out;
> +       }
> +
>         /* Not a sink - recursively explore each port found on this element */
>         for (i = 0; i < csdev->pdata->nr_outport; i++) {
>                 struct coresight_device *child_dev;
> @@ -999,8 +1007,12 @@ coresight_find_default_sink(struct coresight_device *csdev)
>         int depth = 0;
>
>         /* look for a default sink if we have not found for this device */
> -       if (!csdev->def_sink)
> -               csdev->def_sink = coresight_find_sink(csdev, &depth);
> +       if (!csdev->def_sink) {
> +               if (coresight_is_percpu_source(csdev))
> +                       csdev->def_sink = per_cpu(csdev_sink, source_ops(csdev)->cpu_id(csdev));
> +               if (!csdev->def_sink)
> +                       csdev->def_sink = coresight_find_sink(csdev, &depth);
> +       }
>         return csdev->def_sink;
>  }
>
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index 976ec26..bc3a5ca 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -50,6 +50,7 @@ enum coresight_dev_subtype_sink {
>         CORESIGHT_DEV_SUBTYPE_SINK_PORT,
>         CORESIGHT_DEV_SUBTYPE_SINK_BUFFER,
>         CORESIGHT_DEV_SUBTYPE_SINK_SYSMEM,
> +       CORESIGHT_DEV_SUBTYPE_SINK_PERCPU_SYSMEM,

If this is needed then could it not be ..._SINK_SYSMEM_PROC - to be
consistent with ..._SOURCE_PROC?

>  };
>
>  enum coresight_dev_subtype_link {
> @@ -428,6 +429,17 @@ static inline void csdev_access_write64(struct csdev_access *csa, u64 val, u32 o
>                 csa->write(val, offset, false, true);
>  }
>
> +static inline bool coresight_is_percpu_source(struct coresight_device *csdev)

All cpu sources are per cpu - that is ETMv3, ETMv4, PTM, ETE - this
might be better as simply coresight_is_cpu_source() as all the
aforementioned types will return true.

> +{
> +       return csdev && (csdev->type == CORESIGHT_DEV_TYPE_SOURCE) &&
> +              csdev->subtype.source_subtype == CORESIGHT_DEV_SUBTYPE_SOURCE_PROC;
> +}
> +
> +static inline bool coresight_is_percpu_sink(struct coresight_device *csdev)
> +{
> +       return csdev && (csdev->type == CORESIGHT_DEV_TYPE_SINK) &&
> +              csdev->subtype.sink_subtype == CORESIGHT_DEV_SUBTYPE_SINK_PERCPU_SYSMEM;
> +}
>  #else  /* !CONFIG_64BIT */
>
>  static inline u64 csdev_access_relaxed_read64(struct csdev_access *csa,
> --
> 2.7.4
>

Regards

Mike
-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
