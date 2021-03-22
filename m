Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF39E3451B4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 22:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbhCVVVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 17:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbhCVVUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 17:20:50 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD46C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 14:20:50 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id l3so12037615pfc.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 14:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iQ3MR3pIpBpekX6itg9dx4Nv4sSLl+GAinmP3XP/rag=;
        b=Qa4al1wO3hx0Wz1hABtDYi2AZu8Q1dRMeszbeM7VXMqahmn0DSdSm1F+OqWk0WsIXg
         W4Lw+Trzwrzq7r7UP2CGohdyJTB1i1kgxu1m09LAisdRqHUn3mSDovUqr0hogxNjt3fx
         UxRfycce2tuNv7QHZLrMGxtUzpPuIdsZ0/k5m68E0krZQsm7da1deho7EUk8mZvst6P0
         R3EIMFP4iGqKJ4ZxVNwKLR+wXbhRGIBRC9mLL+dKDGuArxPw6m6q+vac/VYQg4yi+Hb+
         jiLjcZioEOTO6ZBrUQ3PKVBibNeIWGujLfTRIe1/t/ZR6XHyzacXgCkz24uHmJn5nHEG
         YzPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iQ3MR3pIpBpekX6itg9dx4Nv4sSLl+GAinmP3XP/rag=;
        b=ljveqgHfHrON/7UKC15ALEYCs5qUjz/9DPz2Hqc5Sq4g9ajbuzhQxPyQ93oTpZFava
         b7nQ/upHLS1IGhnb/SFoJ4N6bMVihP3doPal7j3SG8PsZ/H1wCxFhGeUe3WairLOG5JY
         BhzXVcUpCm1t8+zb8tC6KeKmRMZmmgSRr5+Gpp6lOvnckryE/oJrmDaDsqEfHOajFudC
         gEjN5IY2H70ruM+KrbUmeL7wQANSPiKlIJUeqbXdmqwo6yYCgDkr2CyCGre/ltYxqQw0
         7bckgk1YEPw60JrsFrqbihZQy5u/pS6cfyoipRDtcI4rLrCx6xtOUGrRsYgltETv7E+S
         k+YA==
X-Gm-Message-State: AOAM5322SBaT4Q+9la7OJTybgdONo/0A7EXPEvU+I0pbrZrBh3y1gEGW
        QOTB22OOuTIugXMF2BAm1Eujgg==
X-Google-Smtp-Source: ABdhPJwUrDyed61o/S8LoRZp3mZYhkx1npYyAHJUqzFytgNxanjDXd6xM/cF/YTGI2wScufOyYVDEw==
X-Received: by 2002:aa7:9989:0:b029:1f5:aa05:94af with SMTP id k9-20020aa799890000b02901f5aa0594afmr1767101pfh.34.1616448050228;
        Mon, 22 Mar 2021 14:20:50 -0700 (PDT)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id l2sm298268pji.45.2021.03.22.14.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 14:20:49 -0700 (PDT)
Date:   Mon, 22 Mar 2021 15:20:47 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mike.leach@linaro.org, anshuman.khandual@arm.com,
        leo.yan@linaro.org
Subject: Re: [PATCH v4 18/19] coresight: sink: Add TRBE driver
Message-ID: <20210322212047.GA1684006@xps15>
References: <20210225193543.2920532-1-suzuki.poulose@arm.com>
 <20210225193543.2920532-19-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225193543.2920532-19-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 07:35:42PM +0000, Suzuki K Poulose wrote:
> From: Anshuman Khandual <anshuman.khandual@arm.com>
> 
> Trace Buffer Extension (TRBE) implements a trace buffer per CPU which is
> accessible via the system registers. The TRBE supports different addressing
> modes including CPU virtual address and buffer modes including the circular
> buffer mode. The TRBE buffer is addressed by a base pointer (TRBBASER_EL1),
> an write pointer (TRBPTR_EL1) and a limit pointer (TRBLIMITR_EL1). But the
> access to the trace buffer could be prohibited by a higher exception level
> (EL3 or EL2), indicated by TRBIDR_EL1.P. The TRBE can also generate a CPU
> private interrupt (PPI) on address translation errors and when the buffer
> is full. Overall implementation here is inspired from the Arm SPE driver.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes:
>  - Replaced TRBLIMITR_LIMIT_SHIFT with TRBBASER_BASE_SHIFT in set_trbe_base_pointer()
>  - Dropped TRBBASER_BASE_MASK and TRBBASER_BASE_SHIFT from get_trbe_base_pointer()
>  - Indentation changes for TRBE_BSC_NOT_[STOPPED|FILLED|TRIGGERED] definitions
>  - Moved DECLARE_PER_CPU(...., csdev_sink) into coresight-priv.h
>  - Moved isb() from trbe_enable_hw() into set_trbe_limit_pointer_enabled()
>  - Dropped the space after type casting before vmap()
>  - Return 0 instead of EINVAL in arm_trbe_update_buffer()
>  - Add a comment in trbe_handle_overflow()
>  - Add a comment in arm_trbe_cpu_startup()
>  - Unregister coresight TRBE device when not supported
>  - Fix potential NULL handle dereference in IRQ handler with a spurious IRQ
>  - Read TRBIDR after is_trbe_programmable() in arm_trbe_probe_coresight_cpu()
>  - Replaced and modified trbe_drain_and_disable_local() in IRQ handler
>  - Updated arm_trbe_update_buffer() for handling a missing interrupt
>  - Dropped kfree() for all devm_xxx() allocated buffer
>  - Dropped additional blank line in documentation coresight/coresight-trbe.rst
>  - Added Documentation/ABI/testing/sysfs-bus-coresight-devices-trbe
>  - Changed CONFIG_CORESIGHT_TRBE options, dependencies and helper write up
>  - Added comment for irq_work_run()
>  - Updated comment for minumum buffer length in arm_trbe_alloc_buffer()
>  - Dropped redundant smp_processor_id() from arm_trbe_probe_coresight_cpu()
>  - Fixed indentation in arm_trbe_probe_cpuhp()
>  - Added static for arm_trbe_free_buffer()
>  - Added comment for trbe_base element in trbe_buf structure
>  - Dropped IS_ERR() check from vmap() returned pointer
>  - Added WARN_ON(trbe_csdev) in arm_trbe_probe_coresight_cpu()
>  - Changed TRBE device names from arm_trbeX to just trbeX
>  - Dropped unused argument perf_output_handle from trbe_get_fault_act()
>  - Dropped IS_ERR() from kzalloc_node()/kcalloc() buffer in arm_trbe_alloc_buffer()
>  - Dropped IS_ERR() and return -ENOMEM in arm_trbe_probe_coresight()
>  - Moved TRBE HW disabling before coresight cleanup in arm_trbe_remove_coresight_cpu()
>  - Changed error return codes from arm_trbe_probe_irq()
>  - Changed error return codes from arm_trbe_device_probe()
>  - Changed arm_trbe_remove_coresight() order in arm_trbe_device_remove()
>  - Changed TRBE CPU support probe/remove sequence with for_each_cpu() iterator
>  - Changed coresight_register() in arm_trbe_probe_coresight_cpu()
>  - Changed error return code when cpuhp_setup_state_multi() fails in arm_trbe_probe_cpuhp()
>  - Changed error return code when cpuhp_state_add_instance() fails in arm_trbe_probe_cpuhp()
>  - Changed trbe_dbm as trbe_flag including its sysfs interface
>  - Handle race between update_buffer & IRQ handler
>  - Rework and split the TRBE probe to avoid lockdep due to memory allocation
>    from IPI calls (via coresight_register())
>  - Fix handle->head updat for snapshot mode.

All of the above make this driver much easier to read.

> ---
>  .../testing/sysfs-bus-coresight-devices-trbe  |   14 +
>  .../trace/coresight/coresight-trbe.rst        |   38 +
>  drivers/hwtracing/coresight/Kconfig           |   14 +
>  drivers/hwtracing/coresight/Makefile          |    1 +
>  drivers/hwtracing/coresight/coresight-trbe.c  | 1149 +++++++++++++++++
>  drivers/hwtracing/coresight/coresight-trbe.h  |  153 +++
>  6 files changed, 1369 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight-devices-trbe
>  create mode 100644 Documentation/trace/coresight/coresight-trbe.rst
>  create mode 100644 drivers/hwtracing/coresight/coresight-trbe.c
>  create mode 100644 drivers/hwtracing/coresight/coresight-trbe.h
>

[...]
 
> +
> +static void *arm_trbe_alloc_buffer(struct coresight_device *csdev,
> +				   struct perf_event *event, void **pages,
> +				   int nr_pages, bool snapshot)
> +{
> +	struct trbe_buf *buf;
> +	struct page **pglist;
> +	int i;
> +
> +	/*
> +	 * TRBE LIMIT and TRBE WRITE pointers must be page aligned. But with
> +	 * just a single page, there would not be any room left while writing
> +	 * into a partially filled TRBE buffer after the page size alignment.
> +	 * Hence restrict the minimum buffer size as two pages.
> +	 */
> +	if (nr_pages < 2)
> +		return NULL;
> +
> +	buf = kzalloc_node(sizeof(*buf), GFP_KERNEL, trbe_alloc_node(event));
> +	if (!buf)
> +		return ERR_PTR(-ENOMEM);
> +
> +	pglist = kcalloc(nr_pages, sizeof(*pglist), GFP_KERNEL);
> +	if (!pglist) {
> +		kfree(buf);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	for (i = 0; i < nr_pages; i++)
> +		pglist[i] = virt_to_page(pages[i]);
> +
> +	buf->trbe_base = (unsigned long)vmap(pglist, nr_pages, VM_MAP, PAGE_KERNEL);
> +	if (!buf->trbe_base) {
> +		kfree(pglist);
> +		kfree(buf);
> +		return ERR_PTR(buf->trbe_base);

return ERR_PTR(-ENOMEM); 

> +	}
> +	buf->trbe_limit = buf->trbe_base + nr_pages * PAGE_SIZE;
> +	buf->trbe_write = buf->trbe_base;
> +	buf->snapshot = snapshot;
> +	buf->nr_pages = nr_pages;
> +	buf->pages = pages;
> +	kfree(pglist);
> +	return buf;
> +}
> +
