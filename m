Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 297FF414A6A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 15:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbhIVNWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 09:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbhIVNWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 09:22:00 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E51C061756
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 06:20:30 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id t8so6786951wrq.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 06:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jjzSfIzClFJRZt6zoxy9+X07TFiUbqIQipBKrjAoe98=;
        b=YZh3wbHywRzfNgvGsz2PxmMtxzVcfBTDFp/L6t0olpfG2FTqHPfGt/LMunBwu0VpDV
         vgF+KOFRVbNnOIGGgkhHnLnQIn9YG/3R0845li00jDU6c2FJlYmM5SkSil4kVNz08C49
         O+BvmLy9js+xbeNmujyh2SFNzsrHfDD52mUCbJsrCTwX3VjAC5KoqukrkT7NtZWJxp5N
         qNDwXVk/+NiBYlZ0k2JfUgkV7dVs2OdfIP40yi5IVHiNqFXPaxXhlF9r9emcEHg/n97I
         tfXPL2GrpycfvaCZpS0tS8q9XXDCc7sVn7SXVlORZJ6WwIvbTOqc5U5lqEic0xXeqnS0
         WvSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jjzSfIzClFJRZt6zoxy9+X07TFiUbqIQipBKrjAoe98=;
        b=P0z1Zf8qaCeWc7PHlDhDxqL1+llx+tpabdZ9smBqU+2aInV2tSaAdMY5OtCv6p8pM3
         ATW00t8CbxYYDqJqL3nhkk+GiNtkfTCoyMDl6+WM4Wv7t7B9P4kEwxuPF9E7JWq+8P8Z
         3a7bhW53tka118nR7HFhrq8PJdG1IUw/Y7GGki05kfZemYDh19fVCWo+3gLWLVxBg1yW
         Y27A2iLMRxup+h6onbX6cINfYx0PVYUN1X3pbfq5xWvfQrYpYBQEGr5zOHzDOCDz7xGD
         Vy4UXxfbcPz/ba+A/KkGlaTiCePt2m0FydWo9KPftRjp6DnoSeT101F1LX45KfV3x17q
         7wlg==
X-Gm-Message-State: AOAM530x2UvGRQRUiQjgJIcSdxm4NSKnGzgjZ5k2agkoy83NNpHaaY9y
        vu3/sUbU+iTp4uUv5ytsM1Q9fA==
X-Google-Smtp-Source: ABdhPJzGiU9xZHbENXdAsMe9dr7Z8vB1CduNwHHuDp0EQjehFK414KjWZDMAX/2LL3N+eMOQ0gcxBQ==
X-Received: by 2002:a5d:4810:: with SMTP id l16mr41619169wrq.3.1632316828967;
        Wed, 22 Sep 2021 06:20:28 -0700 (PDT)
Received: from google.com ([95.148.6.233])
        by smtp.gmail.com with ESMTPSA id g205sm2138712wmg.18.2021.09.22.06.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 06:20:28 -0700 (PDT)
Date:   Wed, 22 Sep 2021 14:20:27 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Carlos de Paula <me@carlosedp.com>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: da9063: Add support for latest EA silicon revision
Message-ID: <YUstm5QU/92oN+Fn@google.com>
References: <20210830195345.71853-1-me@carlosedp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210830195345.71853-1-me@carlosedp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Aug 2021, Carlos de Paula wrote:

> This update adds new regmap to support the latest EA silicon
> which will be selected based on the chip and variant
> information read from the device.
> 
> Signed-off-by: Carlos de Paula <me@carlosedp.com>
> ---
>  drivers/mfd/da9063-i2c.c        | 2 ++
>  include/linux/mfd/da9063/core.h | 1 +
>  2 files changed, 3 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
