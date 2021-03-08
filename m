Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE7D3314D0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 18:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhCHR0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 12:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbhCHR0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 12:26:34 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A8DC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 09:26:33 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id e10so12268660wro.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 09:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j01iBaJJKYf/nC6teF5adqKSYrx5B4C/T1dPmEcKqE8=;
        b=z0fGSq2W0UPubBImYfEh5Q/7AJAK3Y9La3daNSfn/gLFScIqmNkodee4UCjVboW+Jt
         PeVZtLHB3qGOpS+Y4Z3liiKBC1cznKibGJOenJ360oXzkpyJN881AaE3bzUq19Z/mrB1
         7Xy3mTmfm7FNQxoypG0EF6ypVg2iYYjljwiZsLJCEG62LfPZKc16Fz2GE3WA8AKFkmFv
         NSyE8lOymPuWV1v3Auw6L+VtjUwB9eetl0kiuZYt1KsQMxfhHqpo6mzznAOfXp325jGj
         KGEcjTIcgJ8BL6pkUi03+cpegpy7wOxJJ0gtSaiSY77n5YwAwuCq9TWwcaxTGZpJzy1m
         +uHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j01iBaJJKYf/nC6teF5adqKSYrx5B4C/T1dPmEcKqE8=;
        b=Y9lTwlLTPMgeN4G9xNM63saA/w6ZpHXbkOTM18Ecc++JRfDGOjxp9a5VMJGy2BBoxA
         fg3lJG7rgGWuxYrAydfhgXXohShhAWq6g0y4TetFnLIDbym+P+x0TKnj/S1DZJ9PjKXe
         IAa8ywA1HU73A7DMv/vFBqLm37rf3jXEVsGAFl8pR/lwpkYljqg7X96dH8zM2mbH24cu
         M23yeMx/dgeWaifQ34VYG81kXGxpnBh3ERzNKj0K1W/LKxNVacwviIjrVO6lmRwWFeCE
         hmdlWb/4DxRfM+Ry18ZGRoNgpGUy8jPg5+5c7SvTv6bNZ/ZyF2CgxbBtYuUzeSwpJ+hx
         hYsA==
X-Gm-Message-State: AOAM532G/efjejgFMxmuuJqzp22DnGgtVfx1+ttB+6O16N3kYHYkllHP
        d5BlHfeyvOBeHqDVsQvJNsbuNxi535cpmwsjPw8jfA==
X-Google-Smtp-Source: ABdhPJzNMsW1hQO3xJDFV3QQUJ1Znpsi784v7A51c4XE1vdtE+QXihNaWkpYsIVny5KJSCq39wu8WenAiLGrGPAa/4s=
X-Received: by 2002:a5d:4688:: with SMTP id u8mr23852349wrq.39.1615224392576;
 Mon, 08 Mar 2021 09:26:32 -0800 (PST)
MIME-Version: 1.0
References: <20210225193543.2920532-1-suzuki.poulose@arm.com> <20210225193543.2920532-18-suzuki.poulose@arm.com>
In-Reply-To: <20210225193543.2920532-18-suzuki.poulose@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Mon, 8 Mar 2021 17:26:21 +0000
Message-ID: <CAJ9a7VgWop-ifXgEoofGOJrKUWuSSK2VxD+6nchQiBxOOg3m3Q@mail.gmail.com>
Subject: Re: [PATCH v4 17/19] coresight: core: Add support for dedicated
 percpu sinks
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Leo Yan <leo.yan@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 25 Feb 2021 at 19:36, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> From: Anshuman Khandual <anshuman.khandual@arm.com>
>
> Add support for dedicated sinks that are bound to individual CPUs. (e.g,
> TRBE). To allow quicker access to the sink for a given CPU bound source,
> keep a percpu array of the sink devices. Also, add support for building
> a path to the CPU local sink from the ETM.
>
> This adds a new percpu sink type CORESIGHT_DEV_SUBTYPE_SINK_PERCPU_SYSMEM.
> This new sink type is exclusively available and can only work with percpu
> source type device CORESIGHT_DEV_SUBTYPE_SOURCE_PROC.
>

Minor nit:  FEAT_TRBE architecturally guarantees a compatible
architectural FEAT_ETE source.
However _all_ CPU sources have CORESIGHT_DEV_SUBTYPE_SOURCE_PROC set,
ETMv3.x, PTM, ETM4.x and ETE alike.
In the code that follows - coresight_is_percpu_source() checks it is
any type of CPU source, not the FEAT_ETE type, which is fine as we
then check the cpu and if it has TRBE.
So the simplifications to the code from the first couple of patch sets
make this explanation slightly misleading. Could do to adjust if
re-spinning set.

Reviewed-by: Mike Leach <mike.leach@linaro.org>



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
> Tested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> [Moved the set/get percpu sink APIs from TRBE patch to here]
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes:
>  - Export methods to set/get percpu sinks for fixing module
>    build for TRBE
>  - Addressed coding style comments (Suzuki)
>  - Check status of _coresight_build_path() (Mathieu)
> ---
>  drivers/hwtracing/coresight/coresight-core.c | 29 ++++++++++++++++++--
>  drivers/hwtracing/coresight/coresight-priv.h |  3 ++
>  include/linux/coresight.h                    | 12 ++++++++
>  3 files changed, 42 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 0062c8935653..55c645616bf6 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -23,6 +23,7 @@
>  #include "coresight-priv.h"
>
>  static DEFINE_MUTEX(coresight_mutex);
> +DEFINE_PER_CPU(struct coresight_device *, csdev_sink);
>
>  /**
>   * struct coresight_node - elements of a path, from source to sink
> @@ -70,6 +71,18 @@ void coresight_remove_cti_ops(void)
>  }
>  EXPORT_SYMBOL_GPL(coresight_remove_cti_ops);
>
> +void coresight_set_percpu_sink(int cpu, struct coresight_device *csdev)
> +{
> +       per_cpu(csdev_sink, cpu) = csdev;
> +}
> +EXPORT_SYMBOL_GPL(coresight_set_percpu_sink);
> +
> +struct coresight_device *coresight_get_percpu_sink(int cpu)
> +{
> +       return per_cpu(csdev_sink, cpu);
> +}
> +EXPORT_SYMBOL_GPL(coresight_get_percpu_sink);
> +
>  static int coresight_id_match(struct device *dev, void *data)
>  {
>         int trace_id, i_trace_id;
> @@ -784,6 +797,14 @@ static int _coresight_build_path(struct coresight_device *csdev,
>         if (csdev == sink)
>                 goto out;
>
> +       if (coresight_is_percpu_source(csdev) && coresight_is_percpu_sink(sink) &&
> +           sink == per_cpu(csdev_sink, source_ops(csdev)->cpu_id(csdev))) {
> +               if (_coresight_build_path(sink, sink, path) == 0) {
> +                       found = true;
> +                       goto out;
> +               }
> +       }
> +
>         /* Not a sink - recursively explore each port found on this element */
>         for (i = 0; i < csdev->pdata->nr_outport; i++) {
>                 struct coresight_device *child_dev;
> @@ -999,8 +1020,12 @@ coresight_find_default_sink(struct coresight_device *csdev)
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
> diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
> index f5f654ea2994..ff1dd2092ac5 100644
> --- a/drivers/hwtracing/coresight/coresight-priv.h
> +++ b/drivers/hwtracing/coresight/coresight-priv.h
> @@ -232,4 +232,7 @@ coresight_find_csdev_by_fwnode(struct fwnode_handle *r_fwnode);
>  void coresight_set_assoc_ectdev_mutex(struct coresight_device *csdev,
>                                       struct coresight_device *ect_csdev);
>
> +void coresight_set_percpu_sink(int cpu, struct coresight_device *csdev);
> +struct coresight_device *coresight_get_percpu_sink(int cpu);
> +
>  #endif
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index 976ec2697610..8a3a3c199087 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -50,6 +50,7 @@ enum coresight_dev_subtype_sink {
>         CORESIGHT_DEV_SUBTYPE_SINK_PORT,
>         CORESIGHT_DEV_SUBTYPE_SINK_BUFFER,
>         CORESIGHT_DEV_SUBTYPE_SINK_SYSMEM,
> +       CORESIGHT_DEV_SUBTYPE_SINK_PERCPU_SYSMEM,
>  };
>
>  enum coresight_dev_subtype_link {
> @@ -428,6 +429,17 @@ static inline void csdev_access_write64(struct csdev_access *csa, u64 val, u32 o
>                 csa->write(val, offset, false, true);
>  }
>
> +static inline bool coresight_is_percpu_source(struct coresight_device *csdev)
> +{
> +       return csdev && (csdev->type == CORESIGHT_DEV_TYPE_SOURCE) &&
> +              (csdev->subtype.source_subtype == CORESIGHT_DEV_SUBTYPE_SOURCE_PROC);
> +}
> +
> +static inline bool coresight_is_percpu_sink(struct coresight_device *csdev)
> +{
> +       return csdev && (csdev->type == CORESIGHT_DEV_TYPE_SINK) &&
> +              (csdev->subtype.sink_subtype == CORESIGHT_DEV_SUBTYPE_SINK_PERCPU_SYSMEM);
> +}
>  #else  /* !CONFIG_64BIT */
>
>  static inline u64 csdev_access_relaxed_read64(struct csdev_access *csa,
> --
> 2.24.1
>


--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
