Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1932D345A58
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 10:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhCWJGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 05:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbhCWJGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 05:06:03 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6E0C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 02:06:03 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id l4so25793890ejc.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 02:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=sZVfJTiSfgzad4x1B4qbxeMOS+HKq7RG0MW4JfsZXYY=;
        b=BjqvBq+QUWuAyzOrVBa+P4VJIRSdP3i8llIT2jcEa/pclQMqYwbj/rt2Xwi33wCena
         IlMr7k1mk344h4M8P9wP7h9WBhvHfqgTDick4XYdeoCs47KjqoopFuHDKPXh9OUQJ2Re
         syHapOCyYN2qO4knm44BLxxC82oqA4tCmaOTMvPwnBDwvmOSBEHLD1YbFONmWFOvS5RW
         iiNr8saLhFUB1lyCQEb/ySb0BzZkHCMWyJdOteysYQDBJyjnnUwIr+BbAo34B5qgl3Up
         T4XtAmIsB1NTKA6+uNAujiPQbqeBkTW21uxrI/0Ohhir6mChC2KmM7IqKCzld/O9pQjp
         1Yxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=sZVfJTiSfgzad4x1B4qbxeMOS+HKq7RG0MW4JfsZXYY=;
        b=qIQz87oM9Ak70/OJeRaiB0eDMChUJhw5nl/8QUROa4FuefyhDm8hctZRWjftBKPTPs
         8PcKCRyFCjs/BKJ33wBB1HMG8UWI2g6tn/SSmRiAxmzvesf60GNOieXXT+crJshKaA1j
         TS3bQxmDdaF9IVeD956QHUAvlodAJVPAVfnaEbm1Go9wEa1cjMlk5k45Tf7dvrpQxiLF
         oWUYqimPIizhthwuaq0GTxwL7mDEjKp+1M/lk1N4CV3soIrJyXA6HHzJRW1HvdWJWQRA
         2NhVElY3ra6kIcCrqTx4lfXov/1Y4gHH9FIkJ7EqJim1b1U0/hyY0N8ckDhvbKdVRmCk
         ICmA==
X-Gm-Message-State: AOAM531SynSqQ0UaP5NTHGGpXqmFzziRLsf8WCuCVitUgOkbKPpx69wD
        +2aUWUO5TL9ltn2OY1dtJjWW5g==
X-Google-Smtp-Source: ABdhPJzlMiNp5i8acBv84mg/eMQyI0zTtx4aOxXIAprzTOX4a5lOPH2LNEu41dfutgOsOxbTea/6ig==
X-Received: by 2002:a17:907:75c2:: with SMTP id jl2mr3977569ejc.334.1616490362194;
        Tue, 23 Mar 2021 02:06:02 -0700 (PDT)
Received: from dell ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id rs24sm10862215ejb.75.2021.03.23.02.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 02:06:01 -0700 (PDT)
Date:   Tue, 23 Mar 2021 09:06:00 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: ABX500_CORE should depend on ARCH_U8500
Message-ID: <20210323090600.GK2916463@dell>
References: <20210316133700.2376662-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210316133700.2376662-1-geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Mar 2021, Geert Uytterhoeven wrote:

> The ST-Ericsson ABX500 Mixed Signal IC family chips are only present on
> ST-Ericsson U8500 Series platforms.  Hence add a dependency on
> ARCH_U8500, to prevent asking the user about this driver when
> configuring a kernel without U8500 support.
> 
> Also, merely enabling CONFIG_COMPILE_TEST should not enable additional
> code, and thus should not enable this driver by default.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/mfd/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
