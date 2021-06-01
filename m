Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C22CB397788
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 18:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbhFAQLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 12:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhFAQLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 12:11:11 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C04C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 09:09:26 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id t4-20020a1c77040000b029019d22d84ebdso1937379wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 09:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=C6Q550/eANL96iUNLAowFBRxhw9fUJjEuG+TUdGZjDM=;
        b=bCjSgH1mOxQfNot9Us35SaRJcSiJpNCOUNyy/+jP4HvuTuIUyMaB7p/6AvjGXuLm3C
         roEVJQYtO0tKcmdNiWJ+r883YLtQg/8OusItxddVyboNK9Odc40DNxPcb0jZI0ZJDlU0
         vHsa5lejmsMu9H6nUGtwOCBEHN/f6g8vU18jxJ491FMVZJD3FAm5PhHNfwsMP6ysxlUL
         JpLtEkZ6dOMndMF1ybjP5WbBmMW5t4UZa6dbtqwrg3KzXbI4DRDiH5is08hKYK38CyEg
         5eyjystyNAHCABBrfE8/bsHPOF10UJ0DTxzvOdBTHceu4hotLioLcmWD8pzeNe9llpTM
         8shQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=C6Q550/eANL96iUNLAowFBRxhw9fUJjEuG+TUdGZjDM=;
        b=A8zCGXe9ddzdrNNd1jH8mWPMISF1eSPiU+MioInm4Njr2MZO9bmoJ9XEmbXZnmy+KO
         wUqLli7nyNIH77Fd0290zj1yhwST6NZkNgflGlEk/EOprvvL9C2P6ae+hr9U+5O8Jw7y
         a4cH6HB1wSWpYI6jH03/0baQFGvTAf4cTPkkj6uCdY0eGCCgmFUUe0FU4h6IRyMUZTzu
         ICTLCH1bokoKLak6hBPs8DFEJaRJiWhAcLQrAzWETQLaH6jzsrQ7fHevrzBU8ooqa86O
         EiWABATXHnlh+w2D1DzMLFZXbrAbivA74Vj2QIZh50IeTgfkn4TCSmdjdQSkx2IhzPOj
         d9/g==
X-Gm-Message-State: AOAM530fqPE7w9M5ZHt2EfhHr5lRnEm1xxOOH0y7MAntrlTZmSXOtQJj
        MuYheppK/2OWxneQzHr63CX1dbc4rtCRvA==
X-Google-Smtp-Source: ABdhPJyZZW+ZwN/oELgTzUON176eAfJvgHT9INBqMu7UETJTW3LUjRcn9aUC3vujoQKndXBgSGEDZw==
X-Received: by 2002:a1c:146:: with SMTP id 67mr667396wmb.61.1622563764813;
        Tue, 01 Jun 2021 09:09:24 -0700 (PDT)
Received: from dell ([91.110.221.249])
        by smtp.gmail.com with ESMTPSA id u3sm4144960wre.76.2021.06.01.09.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 09:09:24 -0700 (PDT)
Date:   Tue, 1 Jun 2021 17:09:22 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] mfd: t7l66xb: Use DEFINE_RES_MEM() and
 DEFINE_RES_IRQ() to simplify code
Message-ID: <20210601160922.GE2165650@dell>
References: <20210601074706.10425-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210601074706.10425-1-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Jun 2021, Zhen Lei wrote:

> No functional change.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/mfd/t7l66xb.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)

All 8 patches applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
