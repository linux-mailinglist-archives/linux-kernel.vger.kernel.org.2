Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0E82436008
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 13:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbhJULPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 07:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbhJULPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 07:15:17 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03442C06161C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 04:13:02 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r10so215026wra.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 04:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+sK7kbwDZnVkIcc5xCM2r8+zkW1Gy+yDDZz94ysv3k0=;
        b=mifsgmDPZFjV+b3vIBEbaIz74tCOcDMSIQ6mbNDi0pOTzj13+6ID680PNACMsCV3H9
         xDyGyE0rJlci6gMj30eFj0/PzEkNwBZYneH/IE0zfEkL4H8wcy8DpHBVBk39OZ1EYx5K
         1jGnXofMdUJidwhO1pjMaWCST5GsoDkpJz0P/ai8KduCWKwdESTBemmTEOpg64g317Io
         ziu+4MsNXC1GoOWBBZ0HXVQ01txq6XS1uT5d5kQWg/uinE71ey4BroY6rz8PXLj82Bmy
         WVUnYuAEHjUZWf5sNvOlO0VsPR2JeHpXTgW3ptpPMH2Bcz0Nvr/1cGPyDtz9VZIH2IOl
         QtyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+sK7kbwDZnVkIcc5xCM2r8+zkW1Gy+yDDZz94ysv3k0=;
        b=khkp4LQ1Gc1/YKwbn3YrNIEKYil9xmvTUmQ8+YyWmy/7teldz8Yz4tnnciSSozgjBQ
         jdA1lhVYOUiHtqcpfsY5oRRnVD2bmWBuPiZSXFK0JhXiF4VFWGgPQxlXfJbO/QaVXZFX
         WmrTTGvvSm7gPrWtTsmPOOwObqGBw1qIb5QOorYBpP1+vhFZl8G2zBisW7hY1+W/12NW
         w6DAvf4Me7BM0dWVVARazIwPfN8JhwD0k9aoeOI0XAwmMFh/5LWpDmW+kiooi/XUljl+
         6XfAvTn9kaznHOMci781tAWjWoCaEZ6ZY9iybV4HaGZMOWs9OZXVFx+7FWgMzMRWd9Nk
         u+wQ==
X-Gm-Message-State: AOAM532IB8c+x20cJ05RTmlUPOecj/8E4coAdh04UzJZ00LfjmO59vzB
        X8MnHyZArE0TpUepS262oCfLdMRD0gkd3g==
X-Google-Smtp-Source: ABdhPJx3prO35Md3TPX1026ZSE9EanLOAIK0KUbIHGq+ufDMyH7n6Y1P0A1yObr5aczppccjSy7MRQ==
X-Received: by 2002:adf:e50b:: with SMTP id j11mr5630999wrm.129.1634814780592;
        Thu, 21 Oct 2021 04:13:00 -0700 (PDT)
Received: from google.com ([95.148.6.207])
        by smtp.gmail.com with ESMTPSA id n26sm5889697wmi.16.2021.10.21.04.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 04:13:00 -0700 (PDT)
Date:   Thu, 21 Oct 2021 12:12:58 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Thor Thayer <thor.thayer@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: altera-a10sr: include linux/module.h
Message-ID: <YXFLOmeHdRPHy2he@google.com>
References: <20211013144402.2292128-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211013144402.2292128-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Oct 2021, Arnd Bergmann wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> Without the header, the MODULE_DEVICE_TABLE() declaration fails:
> 
> drivers/mfd/altera-a10sr.c:153:1: error: data definition has no type or storage class [-Werror]
>   153 | MODULE_DEVICE_TABLE(of, altr_a10sr_spi_of_match);
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/mfd/altera-a10sr.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
