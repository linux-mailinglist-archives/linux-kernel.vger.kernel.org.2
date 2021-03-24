Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 312AB347C8C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 16:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236668AbhCXPZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 11:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236691AbhCXPZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 11:25:06 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F437C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 08:25:06 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id w18so28144943edc.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 08:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=yNCsM/97dlcgvHlb2h3owzTS2y5vMhHS3L4wctKM85M=;
        b=xi7mYiUwA4xDfMDrIWl4sRbAZAb+L0J3hkZvYHRzqPh7CzEDc4XqpJQHcPqTdXJNce
         aRAjBK6+JCzyDhn/LD2sBSWAyYoZMQDrEgC/H4ZAzzTFGF/bJLMvf6YieU6hBKfEDwNg
         ZcVGHtp0TihFQClhjt4Mll5aDBvJgU0k+P+CGGdxnEscTgTp3pGPOSvy7EkRpTdCBMdE
         MIC3KF8A6b1qFawf9hWmGLiPvcm6gyZj1qhL71Pme1nJGtQYPobnfCH+G9OvvijL/I+p
         l4hCEnHVqDeOqDlANfCsi9xSBr7Wg2dGZa/U8AhpIHLVhm+U9+0EBMrsI6swbbqF3IaM
         HfCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yNCsM/97dlcgvHlb2h3owzTS2y5vMhHS3L4wctKM85M=;
        b=KHD3IUVgKQi4j0ZMDk7QufXJfSm3ZZHIM1WSDpZognV9NiQIKsMQ2xIqvuoD0dhbMT
         OTSshQ2k+m78WiZxHiaSE7GKVc+nEEUhkSFLqHdsGYdDpehvCBJBmkA41Bwatdp2SgG0
         zAO6nTr6MzObM3f7Z5XMWZmWQkCblY9Gzqc2oLzSdOds34gCFIitXCF1RQWtlx1dh/To
         OHdjD5N7sHavn7ITdRC9rESAiJIJq9sTme3p00Ruq8vYUm595bWvvKc39Eo5IzZHxbMW
         uDfsjZ1ogTzkg/2R7H7l/Oy8cElPh1id6KEAimztyMDNfQs2UigZYANN5cUt+gQAdvp1
         EkGA==
X-Gm-Message-State: AOAM53096IRBhzMUnJZvnObzPxz0CWvTbXZUeape8GC0hA3kT+1iTS9e
        cNMbh7rHrDNpf62jYjxko5Y22g==
X-Google-Smtp-Source: ABdhPJwfa5t8yAq/Hq72eq8bA4vVrknyuI3qqu/9wPbYrgEfoYcMKhaBSwIYVnNCjrb07O7cyaRB2A==
X-Received: by 2002:aa7:c550:: with SMTP id s16mr4044862edr.98.1616599504904;
        Wed, 24 Mar 2021 08:25:04 -0700 (PDT)
Received: from dell ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id be27sm1305309edb.47.2021.03.24.08.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 08:25:04 -0700 (PDT)
Date:   Wed, 24 Mar 2021 15:25:02 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] mfd: intel_quark_i2c_gpio: enable MSI interrupt
Message-ID: <20210324152502.GQ2916463@dell>
References: <20210324151929.36844-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210324151929.36844-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Mar 2021, Andy Shevchenko wrote:

> Allow interrupts to be MSI if supported by hardware.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v3: added a comment about magic 1s (Lee)
> 
>  drivers/mfd/intel_quark_i2c_gpio.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)

Doesn't apply.  :(

What repo is this based on?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
