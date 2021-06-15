Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA9D3A7D9D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 13:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbhFOLx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 07:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbhFOLx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 07:53:56 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1645C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 04:51:51 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id i94so17954488wri.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 04:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ZmDdvySgqdUlY2q8ke4e4ZpA292A0Wud2ttf4plmCMY=;
        b=pvQaJNNzDKK3GpIZeua9CqXPirqGx6NKgfmbtjihjABYe6IUz2vRqb0WpKkUguR76e
         6UP7caynyBTU5ExTVZhi7ewqC6Gp4nHzLp8ZITCkeApr1at1nsDnYYjIKej/na6G4cZh
         AuHKmHW9raTxyFdOpXLVTZ04/qTomhvqTxe5ywACySanWgwkwT/HShC98HAcWuJGOjL2
         XecOcWVIBLcb1EjvG5iM6rOlqEBrLV051S6Ms8P0PPIMx1yBimI7Ce5gNNpOgjtpo+v5
         kkInIioMuPnsEcdbrxPvdW98GP/xD+uPxLSeXwL5MGl6OZ8lqBMGG/XGUNsDumS7Ld9x
         /3yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZmDdvySgqdUlY2q8ke4e4ZpA292A0Wud2ttf4plmCMY=;
        b=e9ixIrw2yN/8yI3m3D6tuw4Srl1zGZCUhr/lWR2SwoDAFq9f92EiY+FK94JB/QUO3y
         ip+t3h0enKZa2euPJVaFQrP8q2qmmSMdwFZbCFj+zhCPzl+68RkO9gY+rMYg4w4FfFWw
         uOsstVv2zVpsa+VkWgOeLrs64zxViJhC6/mA6xLuX78oeshNxHKWTHC93Gu9dOZNFBQE
         80jY5NlcT6F4A9r+1z98Fvh48H9ypBcPYzAHaVEOYgnQ/9rmP4LcODT6hQMry63DIS59
         KP339NvQ2i1D9UiuMM1VxNoqhvzuP8OIL1IuuBT0mxKFzTJ3hzGt7Ni68aKiqpY07zIf
         kvRQ==
X-Gm-Message-State: AOAM531Q1uisEFU8DYkD3zno4ToLD9mgtLOJ/+tZ0UkxGbwBM3G1n2oo
        BdqXqUHTULeM1W1d0RE/CNu0JQ==
X-Google-Smtp-Source: ABdhPJymFrFA9Tr+UC2MqlIHxE7AQHRohn0x+RAeDamz4LU63AcE7R4SuOg5nVo4nZoP26ITolt81A==
X-Received: by 2002:adf:de91:: with SMTP id w17mr25122541wrl.352.1623757910499;
        Tue, 15 Jun 2021 04:51:50 -0700 (PDT)
Received: from dell ([91.110.221.170])
        by smtp.gmail.com with ESMTPSA id u15sm1926281wmq.48.2021.06.15.04.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 04:51:50 -0700 (PDT)
Date:   Tue, 15 Jun 2021 12:51:48 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     patches <patches@opensource.cirrus.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/9] mfd: timberdale: use DEVICE_ATTR_RO macro
Message-ID: <YMiUVMNe9i14DCEe@dell>
References: <20210602114339.11223-1-thunder.leizhen@huawei.com>
 <20210602114339.11223-4-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210602114339.11223-4-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Jun 2021, Zhen Lei wrote:

> Use DEVICE_ATTR_RO macro helper instead of plain DEVICE_ATTR, which makes
> the code a bit shorter and easier to read.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/mfd/timberdale.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
