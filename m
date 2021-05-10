Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7FC337928A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 17:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbhEJPZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 11:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234156AbhEJPXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 11:23:55 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE0AC046872
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 07:58:00 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id l24-20020a7bc4580000b029014ac3b80020so11347497wmi.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 07:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=31kJRsKagqOpbjDnu1zqGbG73UcMqHUG/HT91hnTQiE=;
        b=G8MzGuGkBJgACi9lAgiqQR0u/OEC1Kqpgo1LFgAdh6IMZSA4n4TUIuWGZNELHZAvfv
         BcAVOj8dWhCuXQ66EK+GSQpPdOu8nLyP9cxp1I1/DPLzFbteb3cywPOwYvxt/OhzLixG
         ZegPbp0HlIMLjN6x1/ALC/zB4cIMt1Ltrmcc87oiJ/KDtKahRhFphNH9Pxk7L4gqp5IV
         tPqAfvdoZ03M06NfYOSEb9t2Z8sCa5h0andzWcXtw6XYrXvL7kbUyjHZtgjT12x7bqLK
         6r8aTlH5pmtfOuWvlLrs5dHDFnAzGJiE9v9xF2gJzDdxfNAMGSkeJC+2W4qH1eY1ocnH
         A5uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=31kJRsKagqOpbjDnu1zqGbG73UcMqHUG/HT91hnTQiE=;
        b=l4CugrchOQO0ZTRaMq7TEV47K3R03fqMGnqVbyF9VU85AjE3/GoI0df/ytG71OQiPn
         8F1LxyCn3A5Zziyk/bu6m+imcRmhRNcxFxVpcHj0xbDqOdZ2EhlFHHiux5YvQ6szd/xx
         Pdcw+XP+JdC75X+qMaSlCBL6ARvR1IPFS61EOasy9yRozxX9BxIq0f++mh8FO5r8X1zb
         otcGHJ+RxCiW3hEevuwOMUzhDOSX+WwAPkieUpl6FJZbXnz5wVlZwlx09zInsYOMsMJG
         PO0SPEK8MfRQ5F0NiMLWy1jUBID7qHDuJ8WPatjDXrZqCKiIcr543ol6DOePFzDh1XvX
         xLDQ==
X-Gm-Message-State: AOAM530QmfzDWHhSZfv327Daw2FB5vkTT0VbnaGsAgY7jHZJ2E0VbIrs
        wwuEoU4v3g7tGrLQ5agohzCm1JCLFh669Q==
X-Google-Smtp-Source: ABdhPJyc37zCKChyOOINt4jxe3UJZhzTIRmJ7rm2+oqdaKoR5S+30egeQ2BxqBrCSp9JuGz6js4cmQ==
X-Received: by 2002:a05:600c:3510:: with SMTP id h16mr17445338wmq.38.1620658678837;
        Mon, 10 May 2021 07:57:58 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id k15sm24635294wro.87.2021.05.10.07.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 07:57:58 -0700 (PDT)
Date:   Mon, 10 May 2021 15:57:56 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] mfd: intel-lpss: Add Intel Alder Lake-M PCI IDs
Message-ID: <20210510145756.GA751702@dell>
References: <20210414142943.60563-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210414142943.60563-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Apr 2021, Andy Shevchenko wrote:

> Add Intel Alder Lake-M LPSS PCI IDs.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel-lpss-pci.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
