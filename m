Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D36345AAE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 10:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhCWJWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 05:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhCWJVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 05:21:52 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AE1C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 02:21:52 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id o19so22591023edc.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 02:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pBI52rEjd5hQCW3eaBGevAdY4oF/3PwRdERKHvVzrQA=;
        b=P6uj30fNU4WMYJOZI9z2jQz2uRPwc3SgwI1u/glSgiJBxrEmV0rpWtnBFLpzxKvEgE
         JXwZYH7p04gjz6mblT5f3NCn3J7XEXyifyUaEzzb86K47J5DVEIOtetzsYy9t6Sfe2PK
         2GoG+r5XcnTYvQo1qBQibAYIDtF8AkxjsdqdZ9A1Izu+isRNhqDA47I/27DVgj3tDqpv
         UiQTbbKfeshL8808u8veC5ueJkKwZJe7AUpQqa5iyDw4v5SgxdqroUOCr/h1doFhdWCn
         0EjP62yrUuts49LjhCesJvEMh8Ed/JUWJ0ScrtsRF5ufiZyGvWCr3Bkeylu86ozmAtFI
         PWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pBI52rEjd5hQCW3eaBGevAdY4oF/3PwRdERKHvVzrQA=;
        b=Qa416MB/qhyp7ENYWhlND2tXmfw0XMfsa+MdMk7wLc20WyyW6TvqJzfCx+fM4WRcXu
         mWHUU0TL4mPHxsvd5Ps9C6OUBQCISGf0/6y7B084WOxWfRQ6+yBijCvBZcMKrtsePLtC
         ta+2Di7UNjibAHGIdByh1R59FjJHe+IFKP0Rxn7iTzN3O8hW20tEMEIpFeVY/UNh6nsy
         hvDDeShzfDsjkelrMZHMtCYbdSh13S84CD64nL3Z9OKpkGXT7RYfBudAdr3DzzC+tFUd
         QLCPy8NiogRqMIjUqJsG3qYGdF+Y01jCqEKESqec96GN8zQd3jPMQR4GfZqd4fnknVXe
         3wJQ==
X-Gm-Message-State: AOAM532Mfz5AQXVeZXYOd6yXNmM2BPtHvsZZ0X5WtwL2638IA6NJQFt+
        KeQBRmaXhQDbrv+eWNsK3aOnMxbqVhAdJQ==
X-Google-Smtp-Source: ABdhPJzZoM664lUPO87UMRQOYL0a/K7PdrepjaqZ0VqDLwPpfoqF7Atvh17hK4xEKDzEsMcquew7ZA==
X-Received: by 2002:a05:6402:1d1a:: with SMTP id dg26mr3598040edb.266.1616491310763;
        Tue, 23 Mar 2021 02:21:50 -0700 (PDT)
Received: from dell ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id jj16sm10780685ejc.19.2021.03.23.02.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 02:21:50 -0700 (PDT)
Date:   Tue, 23 Mar 2021 09:21:48 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/5] mfd: intel_quark_i2c_gpio: Unregister resources
 in reversed order
Message-ID: <20210323092148.GN2916463@dell>
References: <20210302135620.89958-1-andriy.shevchenko@linux.intel.com>
 <20210302135620.89958-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210302135620.89958-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Mar 2021, Andy Shevchenko wrote:

> In ->remove() unregister resources in reversed order, i.e. MFD devices first
> followed by I²C clock.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel_quark_i2c_gpio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
