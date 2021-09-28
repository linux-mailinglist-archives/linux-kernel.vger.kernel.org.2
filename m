Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D8641ACD8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 12:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240138AbhI1KXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 06:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239952AbhI1KXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 06:23:48 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D3AC061575
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 03:22:09 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id d6so56940093wrc.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 03:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9m6DLfcHCnKUWXMYbH38W0W83XsCINW3ABzmyCJT9tQ=;
        b=E2iJVnKzBFQOxDQAgYxSXg76zL5Tx8ndlUOrGdoQvzp6IrjihC4xEfoVdqd+45RlNV
         tZSF4f2Av5vv6L1x872M+ItaItQZr5NmTM+5ffUU8obbkhD6gZnFDhFx07MZ2taTeAD4
         iOgh9zGth293Jmz5NQyHYRf+RimO4a+V0DZge0gLasOux0JtJC7MiB/H2EK2bWI8zqxF
         6Ao0FQIVNnvPssr+lcJoS6R8KvRQksKlCO+6RtavLrDUlv7GzGRPRV5J43WFxHyKluOg
         50QAxNQiO4C/g1RKISI21A1sIQidP/BPtpahQjBhTb9EMn33AT4EvJL6pWoZpFzcDCo+
         0NFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9m6DLfcHCnKUWXMYbH38W0W83XsCINW3ABzmyCJT9tQ=;
        b=XN5wsVmlddVLaaWE7IxehV8KSYkp/BFZQ5bqkxnhARDxA6JyxukeSIGdhVIbbARpil
         5P0OZEiaxmoKTf28jSbQAuCfyhIRqScjt6hav1tIXPJkuInU95W9Ld/Olht3j4BJcFhW
         mH4P164em1aTiCa/2KDf01558plUtPY3w57OgK8icnNIX1Ynguft5702IwKhQgQhST+/
         YuDoLFxpJQbX7CncqUet/RFNBdlvT/E7ceL7XJmRNcphN2+qgKTyTpm+jk/4DyDhp+uG
         7f/JQT4a3AZgCiMgfQobTGMCPRIznt0BQYg9NNQsWpV7aAKqNWBzm3SdUHsF6IJVNfOi
         4EmQ==
X-Gm-Message-State: AOAM531Y38NS1oWmtn2OrhBNMPihGcDpWjvyQgRwb5jywep33nCVAIVq
        589ngkFm2p1bkVZ0c2dIdK+OXJsbLVCcWg==
X-Google-Smtp-Source: ABdhPJzWLun4Hy6+VX8xgCLdvrnNBTZkLMQkplxegp6c86YQe+aLDdkfYIR1iOFfL4ZLH9iQRzwAzQ==
X-Received: by 2002:adf:d851:: with SMTP id k17mr5629288wrl.54.1632824527598;
        Tue, 28 Sep 2021 03:22:07 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id j5sm6087548wrw.39.2021.09.28.03.22.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 03:22:07 -0700 (PDT)
Subject: Re: [PATCH] nvmem: Fix shift-out-of-bound (UBSAN) with byte size
 cells
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
References: <20210928000612.1618110-1-swboyd@chromium.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <0a4797bd-63d5-51e9-2493-cf8c18ef1253@linaro.org>
Date:   Tue, 28 Sep 2021 11:22:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210928000612.1618110-1-swboyd@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/09/2021 01:06, Stephen Boyd wrote:
> If a cell has 'nbits' equal to a multiple of BITS_PER_BYTE the logic
> 
>   *p &= GENMASK((cell->nbits%BITS_PER_BYTE) - 1, 0);
> 
> will become undefined behavior because nbits modulo BITS_PER_BYTE is 0, and we
> subtract one from that making a large number that is then shifted more than the
> number of bits that fit into an unsigned long.
> 
> UBSAN reports this problem:
> 
>   UBSAN: shift-out-of-bounds in drivers/nvmem/core.c:1386:8
>   shift exponent 64 is too large for 64-bit type 'unsigned long'
>   CPU: 6 PID: 7 Comm: kworker/u16:0 Not tainted 5.15.0-rc3+ #9
>   Hardware name: Google Lazor (rev3+) with KB Backlight (DT)
>   Workqueue: events_unbound deferred_probe_work_func
>   Call trace:
>    dump_backtrace+0x0/0x170
>    show_stack+0x24/0x30
>    dump_stack_lvl+0x64/0x7c
>    dump_stack+0x18/0x38
>    ubsan_epilogue+0x10/0x54
>    __ubsan_handle_shift_out_of_bounds+0x180/0x194
>    __nvmem_cell_read+0x1ec/0x21c
>    nvmem_cell_read+0x58/0x94
>    nvmem_cell_read_variable_common+0x4c/0xb0
>    nvmem_cell_read_variable_le_u32+0x40/0x100
>    a6xx_gpu_init+0x170/0x2f4
>    adreno_bind+0x174/0x284
>    component_bind_all+0xf0/0x264
>    msm_drm_bind+0x1d8/0x7a0
>    try_to_bring_up_master+0x164/0x1ac
>    __component_add+0xbc/0x13c
>    component_add+0x20/0x2c
>    dp_display_probe+0x340/0x384
>    platform_probe+0xc0/0x100
>    really_probe+0x110/0x304
>    __driver_probe_device+0xb8/0x120
>    driver_probe_device+0x4c/0xfc
>    __device_attach_driver+0xb0/0x128
>    bus_for_each_drv+0x90/0xdc
>    __device_attach+0xc8/0x174
>    device_initial_probe+0x20/0x2c
>    bus_probe_device+0x40/0xa4
>    deferred_probe_work_func+0x7c/0xb8
>    process_one_work+0x128/0x21c
>    process_scheduled_works+0x40/0x54
>    worker_thread+0x1ec/0x2a8
>    kthread+0x138/0x158
>    ret_from_fork+0x10/0x20
> 
> Fix it by making sure there are any bits to mask out.
> 
> Cc: Douglas Anderson <dianders@chromium.org>
> Fixes: 69aba7948cbe ("nvmem: Add a simple NVMEM framework for consumers")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Applied thanks,


--srini

> ---
>   drivers/nvmem/core.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 3d87fadaa160..8976da38b375 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -1383,7 +1383,8 @@ static void nvmem_shift_read_buffer_in_place(struct nvmem_cell *cell, void *buf)
>   		*p-- = 0;
>   
>   	/* clear msb bits if any leftover in the last byte */
> -	*p &= GENMASK((cell->nbits%BITS_PER_BYTE) - 1, 0);
> +	if (cell->nbits % BITS_PER_BYTE)
> +		*p &= GENMASK((cell->nbits % BITS_PER_BYTE) - 1, 0);
>   }
>   
>   static int __nvmem_cell_read(struct nvmem_device *nvmem,
> 
> base-commit: e4e737bb5c170df6135a127739a9e6148ee3da82
> 
