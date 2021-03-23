Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A7A345A8F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 10:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhCWJPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 05:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhCWJO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 05:14:57 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C7EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 02:14:56 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ce10so25850203ejb.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 02:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=FGcGZYBzmHqAWGCJXBOUp2P7e3463RA3CVqvCOWmvqM=;
        b=OFd8yWwWA+XObBts4AvN1qsbYYoIeOvtbw/cqXwjC4gPLhFz8IPhy/eNxUBFtztq8v
         15YUZOSrYE1ipZ6udbGDHkB7HvmU0A2WTasw6kGBaDcivlAlBIQW/DJslMwRWUjbLrX+
         dbYNwIhL20FAUZ3oiuvbaKRmfpYmgDpUA2GO2fV0kTX3lwA4ZmvZ/boJQhItfqYvZrKg
         zlrJzjMASANig86Hoqdbm11tJjccMdGoza12xM/cc6uC5IQVK3yHkDs8b+IdjMq6RpvF
         lF076uC5rDCghwS0OusQIhW2SszT4zJEfF3+zMxzav+S2zlunElpKKq68+loSJJ6oSMs
         4l+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=FGcGZYBzmHqAWGCJXBOUp2P7e3463RA3CVqvCOWmvqM=;
        b=XKpqvsa6LIRvC+E7C2gcqcBRr3kdtBBRezPQLpF6wyG4oVWZ9uS5jSuCpMcNeUP1wo
         DuxkduMruuVQgNgaUHzcyK/OB7hNdDbfpp4eS0sVa1JvM2FkCTf3Br6GNsNrfh0Szv6h
         6WbVQCqJl7YrOPz4LybP89MG/ZE6QMaLK3eQj8m6nJ7wMX/bhweBMLlzpPg0rptXZbjP
         1g5prhZ9LWuJaGT1xtBrnDAHWbTNSu26rG4MhCgK3qretaHXBfJKd3cZcBl1h2w7zktj
         5/gbfesEmoW236fv4JOo668d13os/vshqRWuDbufsDJyfqJdALUQAJzCceMOk/5Fs13c
         suQA==
X-Gm-Message-State: AOAM531L7DDfbKtgilbR1H1gGvfcuaj9Dm722l9gi/xkbMicAprcMZtR
        o7hDfeziXbr8HAyXGfEyAAm/Cs5iWFZudA==
X-Google-Smtp-Source: ABdhPJxXgucwrfbPSQoWcHApy1i9EJ6f0pIc27umpUjSIcLFrcc4em2pcjCz6Q9icxTVUXsIMbyKxg==
X-Received: by 2002:a17:906:e84:: with SMTP id p4mr3939940ejf.248.1616490895735;
        Tue, 23 Mar 2021 02:14:55 -0700 (PDT)
Received: from dell ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id b18sm10918797ejb.77.2021.03.23.02.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 02:14:55 -0700 (PDT)
Date:   Tue, 23 Mar 2021 09:14:53 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: Re: [PATCH v1 1/5] mfd: intel_quark_i2c_gpio: revert "Constify
 static struct resources"
Message-ID: <20210323091453.GL2916463@dell>
References: <20210302135620.89958-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210302135620.89958-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Mar 2021, Andy Shevchenko wrote:

> The structures are used as place holders, so they are modified at run-time.
> Obviously they may not be constants.
> 
>   BUG: unable to handle page fault for address: d0643220
>   ...
>   CPU: 0 PID: 110 Comm: modprobe Not tainted 5.11.0+ #1
>   Hardware name: Intel Corp. QUARK/GalileoGen2, BIOS 0x01000200 01/01/2014
>   EIP: intel_quark_mfd_probe+0x93/0x1c0 [intel_quark_i2c_gpio]
> 
> This partially reverts the commit c4a164f41554d2899bed94bdcc499263f41787b4.
> 
> While at it, add a comment to avoid similar changes in the future.
> 
> Fixes: c4a164f41554 ("mfd: Constify static struct resources")
> Cc: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel_quark_i2c_gpio.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Applied to -fixes for testing, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
