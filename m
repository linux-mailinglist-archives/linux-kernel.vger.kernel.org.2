Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70F663ED4A4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 15:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236784AbhHPNEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 09:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236280AbhHPNEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 09:04:13 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5726C0613C1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 06:03:41 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id q10so23555882wro.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 06:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9UoamzRECn/H6bcGR/4brg3LZ3eUZ0lyLrwMwmz5pKA=;
        b=ZC0UofNZ2hAtDFaQZcHbKsP/7FVJIrXQ8QBEZZIvkxS7tDnch983O909mgZ3MFNIBb
         8QHG6gwfo9NW+blGTDLi1MXcmYhPwFnQIZUYojsAKHdNqmhna8wgITIns8wBbBuuo7wY
         J9oQ8NqFDWDI0zZsNpAKlUa9oZKhhpCeEylRZ8JYzmLHvgZVUN+YvBlQX01l+9BW3TLm
         M8DW8Qf8hBk7BXqrZV4GGKPa/CmTlOTquLgk/FJg5mfL86Vr6JimUouEKtDMT/69HEoB
         URVbjm9Frs8AU68yYbpfFH4OgCjKN844HpNfAKkJLu3tam9zZi1/4zS0GwvjuaHLm7ng
         LUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9UoamzRECn/H6bcGR/4brg3LZ3eUZ0lyLrwMwmz5pKA=;
        b=JnEQx2jqlg1EEq92MvIDWe2pYzLyB2EaAYn/+qdiaoww0WkOwPy9q/9h6osPXxEw4o
         xNydRQzrhqy0yqcHvlrvjbfaKRpItOHwd73bF45Aw/qV7SgCAB/5A5FzrNp5nxrlnh45
         jNVYWMAK8qIaD2TgN0zxKM/paJVDuXWcwDI/9MgVnERWv1kVcIkIYEQHoeXfoFwYNXGE
         v4WtyVWa5xEtOJdhYatmgf9xuoGMjsu8SKklAKY2vQupaDCaikUr6dk6CpVobplq2LCx
         OSPp76aHiFVT9NSB9hQwOlHrY4Pt8fVN1YgxPKq/hsiEZyar9TRhtwlLiO+zx/8+D1OQ
         UrmA==
X-Gm-Message-State: AOAM530myzberF/ofX/3pbNCDEmWxqMsfydrFOqdzMSM16LTAsfHim1m
        nuF9GRZkwBzMga+h9RZVdNFMOw==
X-Google-Smtp-Source: ABdhPJyEWDxdRRAYh1vk0lNY3i6eBbD7ldr1tb7QH1PupZemnFfsMCqlej0tE14FKPG2zd0G28mejg==
X-Received: by 2002:a5d:534c:: with SMTP id t12mr8871507wrv.219.1629119020395;
        Mon, 16 Aug 2021 06:03:40 -0700 (PDT)
Received: from google.com ([2.31.167.59])
        by smtp.gmail.com with ESMTPSA id z15sm11307578wrp.30.2021.08.16.06.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 06:03:39 -0700 (PDT)
Date:   Mon, 16 Aug 2021 14:03:38 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: ti_am335x_tscadc: Delete superfluous error message
Message-ID: <YRpiKsOMB0PF23EH@google.com>
References: <20210811121934.23548-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210811121934.23548-1-tangbin@cmss.chinamobile.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Aug 2021, Tang Bin wrote:

> In the function ti_tscadc_probe(), when get irq failed,
> platform_get_irq() logs an error message, so remove
> redundant message here.
> 
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---
>  drivers/mfd/ti_am335x_tscadc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
