Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E791F30AD62
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 18:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbhBARG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 12:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhBARGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 12:06:20 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADCEC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 09:05:40 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id g15so12476871pgu.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 09:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rV0K3F4zmeFdrVc02lSWJwOMPX58ML+v7RlA79PMicU=;
        b=jJ0VbsO9t5DSWgyjy9Zb5XMirkM538/h0z7vYekgbJ8VlWdqeZod2gMdQ3QMxRPHl6
         ygozOMFrOcOukUqgY50TWQWWL+JHiDtB3fgFN6bnBU0eRFYxCMNM6CxbhOVgXYTEm0YB
         GZ0dLFspeAGIXaZ1qhcVxW8VoAvjHOXLfO9jKMS6/P9O/hdoqSqnlhSDDleO3FXavl3K
         q4sFyAI678eZ5SzBFKb6N3hkzRjyIVszFsB6nmnzk7y6QOSGh6sU89b3k9G7XDVxR5uI
         rkgKoN7TWGUU8ze+8YxFQi7Agv2KIurgquVNzY+RFDsO20cMqBtIEofyFUWfAHuhx4OA
         MHjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rV0K3F4zmeFdrVc02lSWJwOMPX58ML+v7RlA79PMicU=;
        b=DV1kjqbUyOB4Evw2k+q5BkHQzLLWu9BUINCwCeCMdr3VNuloe7TB+GkXb9FBqBzIcO
         aGLlw4rjeD17C5Fpg8sm6QrwtmWghbGf8cn48/kvMnnMB/NBYWP/JETpyYMg7Jkug3z7
         zbirp4EZkUpCMedcMdWJfKAVO3VVMW/Nmv9XZFIkN6bSCDuZBttKKG0aMBGmxyd+aSG1
         sM8z9YmySKtnDIUpANZRqYhGwPyA/bI0O5DWiH3IsnqsMYvK+17CacUh/wQbgyEnF9XX
         qfRIEZ7O7f5DO4ZgCe0rp+FzueY7c4sZ16GjgqmqnhysWAuSOOEUseQalLK1rlt15l+U
         hOXQ==
X-Gm-Message-State: AOAM533gLChPqTdInPXAtsPQ8Y9qMHBWyi+LE+/+2CQRepSb1B58xlpj
        5x9EMNWFkGuh26VxR7J4d6p/5w==
X-Google-Smtp-Source: ABdhPJz6dnxvU47KSjmsC0//Ahz4yMlX3PAzHgWbP7GrUCLItx4zzF7U7B/Tt8UP1HO+8ysyXMfnDw==
X-Received: by 2002:a63:1f21:: with SMTP id f33mr18240572pgf.31.1612199140061;
        Mon, 01 Feb 2021 09:05:40 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id i9sm18878851pfo.146.2021.02.01.09.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 09:05:39 -0800 (PST)
Date:   Mon, 1 Feb 2021 10:05:37 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Qi Liu <liuqi115@huawei.com>
Cc:     suzuki.poulose@arm.com, mike.leach@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxarm@openeuler.org
Subject: Re: [PATCH] coresight: Remove duplicate header files of coresight
 drivers
Message-ID: <20210201170537.GA1399621@xps15>
References: <1612184564-26613-1-git-send-email-liuqi115@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612184564-26613-1-git-send-email-liuqi115@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good day,

On Mon, Feb 01, 2021 at 09:02:44PM +0800, Qi Liu wrote:
> Remove duplicate included header files, as coresight-priv.h is included in
> these coresight drivers.
> 
> Signed-off-by: Qi Liu <liuqi115@huawei.com>
> ---
>  drivers/hwtracing/coresight/coresight-catu.c         | 2 --
>  drivers/hwtracing/coresight/coresight-core.c         | 3 ---
>  drivers/hwtracing/coresight/coresight-cpu-debug.c    | 3 ---
>  drivers/hwtracing/coresight/coresight-cti-core.c     | 3 ---
>  drivers/hwtracing/coresight/coresight-cti-platform.c | 1 -
>  drivers/hwtracing/coresight/coresight-cti.h          | 1 -
>  drivers/hwtracing/coresight/coresight-etb10.c        | 4 ----
>  drivers/hwtracing/coresight/coresight-etm-perf.c     | 1 -
>  drivers/hwtracing/coresight/coresight-etm3x-sysfs.c  | 1 -
>  drivers/hwtracing/coresight/coresight-etm4x-core.c   | 5 -----
>  drivers/hwtracing/coresight/coresight-etm4x-sysfs.c  | 1 -
>  drivers/hwtracing/coresight/coresight-funnel.c       | 3 ---
>  drivers/hwtracing/coresight/coresight-platform.c     | 2 --
>  drivers/hwtracing/coresight/coresight-replicator.c   | 3 ---
>  drivers/hwtracing/coresight/coresight-stm.c          | 3 ---
>  drivers/hwtracing/coresight/coresight-tmc-core.c     | 3 ---
>  drivers/hwtracing/coresight/coresight-tmc-etf.c      | 1 -
>  drivers/hwtracing/coresight/coresight-tmc-etr.c      | 1 -
>  drivers/hwtracing/coresight/coresight-tpiu.c         | 4 ----
>  19 files changed, 45 deletions(-)

The idea is to make sure every file stands on its own without dependencies on
other header files.  Otherwise it is difficult and expensive to move files
around or make changes to any header file.   As such I will not move forward
with this set.

Thanks,
Mathieu


> 
> diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
> index a61313f..fcc0367 100644
> --- a/drivers/hwtracing/coresight/coresight-catu.c
> +++ b/drivers/hwtracing/coresight/coresight-catu.c
> @@ -7,10 +7,8 @@
>   * Author: Suzuki K Poulose <suzuki.poulose@arm.com>
>   */
> 
> -#include <linux/amba/bus.h>
>  #include <linux/device.h>
>  #include <linux/dma-mapping.h>
> -#include <linux/io.h>
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
> 
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 4ba801d..5fb8b12 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -7,17 +7,14 @@
>  #include <linux/init.h>
>  #include <linux/types.h>
>  #include <linux/device.h>
> -#include <linux/io.h>
>  #include <linux/err.h>
>  #include <linux/export.h>
>  #include <linux/slab.h>
>  #include <linux/stringhash.h>
>  #include <linux/mutex.h>
>  #include <linux/clk.h>
> -#include <linux/coresight.h>
>  #include <linux/of_platform.h>
>  #include <linux/delay.h>
> -#include <linux/pm_runtime.h>
> 
>  #include "coresight-etm-perf.h"
>  #include "coresight-priv.h"
> diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
> index e1d2324..f8df512 100644
> --- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
> +++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
> @@ -4,15 +4,12 @@
>   *
>   * Author: Leo Yan <leo.yan@linaro.org>
>   */
> -#include <linux/amba/bus.h>
> -#include <linux/coresight.h>
>  #include <linux/cpu.h>
>  #include <linux/debugfs.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/init.h>
> -#include <linux/io.h>
>  #include <linux/iopoll.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> diff --git a/drivers/hwtracing/coresight/coresight-cti-core.c b/drivers/hwtracing/coresight/coresight-cti-core.c
> index 61dbc1a..ed7ab82 100644
> --- a/drivers/hwtracing/coresight/coresight-cti-core.c
> +++ b/drivers/hwtracing/coresight/coresight-cti-core.c
> @@ -4,18 +4,15 @@
>   * Author: Mike Leach <mike.leach@linaro.org>
>   */
> 
> -#include <linux/amba/bus.h>
>  #include <linux/atomic.h>
>  #include <linux/bits.h>
>  #include <linux/coresight.h>
>  #include <linux/cpu_pm.h>
>  #include <linux/cpuhotplug.h>
>  #include <linux/device.h>
> -#include <linux/io.h>
>  #include <linux/kernel.h>
>  #include <linux/list.h>
>  #include <linux/mutex.h>
> -#include <linux/pm_runtime.h>
>  #include <linux/property.h>
>  #include <linux/spinlock.h>
> 
> diff --git a/drivers/hwtracing/coresight/coresight-cti-platform.c b/drivers/hwtracing/coresight/coresight-cti-platform.c
> index ccef04f..60b0580 100644
> --- a/drivers/hwtracing/coresight/coresight-cti-platform.c
> +++ b/drivers/hwtracing/coresight/coresight-cti-platform.c
> @@ -2,7 +2,6 @@
>  /*
>   * Copyright (c) 2019, The Linaro Limited. All rights reserved.
>   */
> -#include <linux/coresight.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/of.h>
> diff --git a/drivers/hwtracing/coresight/coresight-cti.h b/drivers/hwtracing/coresight/coresight-cti.h
> index acf7b54..0a3b313 100644
> --- a/drivers/hwtracing/coresight/coresight-cti.h
> +++ b/drivers/hwtracing/coresight/coresight-cti.h
> @@ -7,7 +7,6 @@
>  #ifndef _CORESIGHT_CORESIGHT_CTI_H
>  #define _CORESIGHT_CORESIGHT_CTI_H
> 
> -#include <linux/coresight.h>
>  #include <linux/device.h>
>  #include <linux/fwnode.h>
>  #include <linux/list.h>
> diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
> index 0cf6f0b..8d5bc04 100644
> --- a/drivers/hwtracing/coresight/coresight-etb10.c
> +++ b/drivers/hwtracing/coresight/coresight-etb10.c
> @@ -10,17 +10,13 @@
>  #include <linux/init.h>
>  #include <linux/types.h>
>  #include <linux/device.h>
> -#include <linux/io.h>
>  #include <linux/err.h>
>  #include <linux/fs.h>
>  #include <linux/miscdevice.h>
>  #include <linux/uaccess.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
> -#include <linux/pm_runtime.h>
>  #include <linux/seq_file.h>
> -#include <linux/coresight.h>
> -#include <linux/amba/bus.h>
>  #include <linux/clk.h>
>  #include <linux/circ_buf.h>
>  #include <linux/mm.h>
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index bdc34ca..01aba63 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -4,7 +4,6 @@
>   * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
>   */
> 
> -#include <linux/coresight.h>
>  #include <linux/coresight-pmu.h>
>  #include <linux/cpumask.h>
>  #include <linux/device.h>
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> index e8c7649..5cf6660 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> @@ -5,7 +5,6 @@
>   */
> 
>  #include <linux/pid_namespace.h>
> -#include <linux/pm_runtime.h>
>  #include <linux/sysfs.h>
>  #include "coresight-etm.h"
>  #include "coresight-priv.h"
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index b20b6ff..0438ef7 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -3,13 +3,11 @@
>   * Copyright (c) 2014, The Linux Foundation. All rights reserved.
>   */
> 
> -#include <linux/bitops.h>
>  #include <linux/kernel.h>
>  #include <linux/moduleparam.h>
>  #include <linux/init.h>
>  #include <linux/types.h>
>  #include <linux/device.h>
> -#include <linux/io.h>
>  #include <linux/err.h>
>  #include <linux/fs.h>
>  #include <linux/slab.h>
> @@ -20,14 +18,11 @@
>  #include <linux/clk.h>
>  #include <linux/cpu.h>
>  #include <linux/cpu_pm.h>
> -#include <linux/coresight.h>
>  #include <linux/coresight-pmu.h>
>  #include <linux/pm_wakeup.h>
> -#include <linux/amba/bus.h>
>  #include <linux/seq_file.h>
>  #include <linux/uaccess.h>
>  #include <linux/perf_event.h>
> -#include <linux/pm_runtime.h>
>  #include <linux/property.h>
> 
>  #include <asm/sections.h>
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> index 989ce7b..347ccb7 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> @@ -5,7 +5,6 @@
>   */
> 
>  #include <linux/pid_namespace.h>
> -#include <linux/pm_runtime.h>
>  #include <linux/sysfs.h>
>  #include "coresight-etm4x.h"
>  #include "coresight-priv.h"
> diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
> index 071c723..c79ded9 100644
> --- a/drivers/hwtracing/coresight/coresight-funnel.c
> +++ b/drivers/hwtracing/coresight/coresight-funnel.c
> @@ -15,9 +15,6 @@
>  #include <linux/slab.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> -#include <linux/pm_runtime.h>
> -#include <linux/coresight.h>
> -#include <linux/amba/bus.h>
>  #include <linux/clk.h>
> 
>  #include "coresight-priv.h"
> diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
> index 3629b78..ca22409 100644
> --- a/drivers/hwtracing/coresight/coresight-platform.c
> +++ b/drivers/hwtracing/coresight/coresight-platform.c
> @@ -13,8 +13,6 @@
>  #include <linux/of_graph.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
> -#include <linux/amba/bus.h>
> -#include <linux/coresight.h>
>  #include <linux/cpumask.h>
>  #include <asm/smp_plat.h>
> 
> diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
> index 7e2a2b7..36788de 100644
> --- a/drivers/hwtracing/coresight/coresight-replicator.c
> +++ b/drivers/hwtracing/coresight/coresight-replicator.c
> @@ -6,14 +6,11 @@
>   */
> 
>  #include <linux/acpi.h>
> -#include <linux/amba/bus.h>
>  #include <linux/kernel.h>
>  #include <linux/device.h>
>  #include <linux/platform_device.h>
> -#include <linux/io.h>
>  #include <linux/err.h>
>  #include <linux/slab.h>
> -#include <linux/pm_runtime.h>
>  #include <linux/property.h>
>  #include <linux/clk.h>
>  #include <linux/of.h>
> diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
> index 9979177..75f0bd8 100644
> --- a/drivers/hwtracing/coresight/coresight-stm.c
> +++ b/drivers/hwtracing/coresight/coresight-stm.c
> @@ -17,17 +17,14 @@
>   */
>  #include <asm/local.h>
>  #include <linux/acpi.h>
> -#include <linux/amba/bus.h>
>  #include <linux/bitmap.h>
>  #include <linux/clk.h>
> -#include <linux/coresight.h>
>  #include <linux/coresight-stm.h>
>  #include <linux/err.h>
>  #include <linux/kernel.h>
>  #include <linux/moduleparam.h>
>  #include <linux/of_address.h>
>  #include <linux/perf_event.h>
> -#include <linux/pm_runtime.h>
>  #include <linux/stm.h>
> 
>  #include "coresight-priv.h"
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
> index 8169dff..4fff281 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
> @@ -9,7 +9,6 @@
>  #include <linux/types.h>
>  #include <linux/device.h>
>  #include <linux/idr.h>
> -#include <linux/io.h>
>  #include <linux/err.h>
>  #include <linux/fs.h>
>  #include <linux/miscdevice.h>
> @@ -21,8 +20,6 @@
>  #include <linux/spinlock.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/of.h>
> -#include <linux/coresight.h>
> -#include <linux/amba/bus.h>
> 
>  #include "coresight-priv.h"
>  #include "coresight-tmc.h"
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> index 989d965..b263f75 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> @@ -6,7 +6,6 @@
> 
>  #include <linux/atomic.h>
>  #include <linux/circ_buf.h>
> -#include <linux/coresight.h>
>  #include <linux/perf_event.h>
>  #include <linux/slab.h>
>  #include "coresight-priv.h"
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index bf5230e..1ab0b28 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -5,7 +5,6 @@
>   */
> 
>  #include <linux/atomic.h>
> -#include <linux/coresight.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/iommu.h>
>  #include <linux/idr.h>
> diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
> index d5dfee9..c5675f9 100644
> --- a/drivers/hwtracing/coresight/coresight-tpiu.c
> +++ b/drivers/hwtracing/coresight/coresight-tpiu.c
> @@ -9,12 +9,8 @@
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/device.h>
> -#include <linux/io.h>
>  #include <linux/err.h>
>  #include <linux/slab.h>
> -#include <linux/pm_runtime.h>
> -#include <linux/coresight.h>
> -#include <linux/amba/bus.h>
>  #include <linux/clk.h>
> 
>  #include "coresight-priv.h"
> --
> 2.8.1
> 
