Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1053E0FD3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 10:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239351AbhHEIEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 04:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236777AbhHEIDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 04:03:10 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A271C0613C1
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 01:02:51 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id d8so5307288wrm.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 01:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zEZrBAG3edsTrFza0Z8asjlbiX/HavgDkBINPKbvcAM=;
        b=sf80PQyh0g4hqBFV2TeLsR48iW9FzUNYMQtGJnB2UKqddxMbNPT+BPJZz5FuAQw8xG
         xhYqpXvfw3s1mega4WRUoJhw5f//zQM2c01D7UG9TNYCxsAJvnZUI3C25hxl621Oarxy
         17pq6gAsMk/wJZd4OG+5RoYP2JjAQNmZ3aF8RK/eWh8tKsYdIHnezfsmR/qkT1b02/A/
         zJY0cNNo4gjgIaEro6Gmgcx1tFFkR+nuei3ZCtOvLh+F51Yb307nZ5MEM3e2f/JoQs3p
         Y2woAOqBBOCe4kuXh3ruFoSxyu0ScZviLpypM7a4yx/8vepxSRWEyPecBoDdwfxU25Nd
         kowQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zEZrBAG3edsTrFza0Z8asjlbiX/HavgDkBINPKbvcAM=;
        b=GAEIgvo0GxH58y1rJ+8cvQ9IXgo+0RVx5bbwMbiXpjSVNvrS+oh1CNrb+AEq/FE7q9
         XgKlzR3L6DcTAQXrXLlOBBiK8fIE6jK9ugcNhFz92de8Aj5qwD1N9uQrHUObrt8rvNXk
         gDogE52KP9fHQv3plHWQRevOvzSTh1miBVKqafbol3FXDEiYVIU3uZPK7X39l+HL/gY3
         HwkjGg2/Yvni5uYVqOwDQVWycggJY1kqc5zBjByNcJ4lhs5d18uIr5lDr0c3sYbMY787
         YWMLRpxDP+Q7HPUPHhRJJaJQFCw08vRgiFl6n54POqgd5GH3y2OO3vELnR5DJwdTo0bg
         R6+Q==
X-Gm-Message-State: AOAM531EKWMXngO94H2MXJ/M/8+/TImIahDdukmhFU+4Oi9JHCvxMmWJ
        MWt/BG3ySw+kLr1b7r1IGgsUbQ==
X-Google-Smtp-Source: ABdhPJwUHpbXsr54oVwa43NvkS8OBXErBcSn8URfjx8+/Xk332hqlN0C6QceSdH6I98R6nixioU/wQ==
X-Received: by 2002:a5d:6912:: with SMTP id t18mr3674677wru.234.1628150569746;
        Thu, 05 Aug 2021 01:02:49 -0700 (PDT)
Received: from google.com ([109.180.115.228])
        by smtp.gmail.com with ESMTPSA id j1sm8032594wmo.4.2021.08.05.01.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 01:02:49 -0700 (PDT)
Date:   Thu, 5 Aug 2021 09:02:47 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hoan Tran <hoan@os.amperecomputing.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 3/4] mfd: intel_quark_i2c_gpio: Convert GPIO to use
 software nodes
Message-ID: <YQubJ1s2YuEZk4lm@google.com>
References: <20210804160019.77105-1-andriy.shevchenko@linux.intel.com>
 <20210804160019.77105-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210804160019.77105-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Aug 2021, Andy Shevchenko wrote:

> The driver can provide a software node group instead of
> passing legacy platform data. This will allow to drop
> the legacy platform data structures along with unifying
> a child device driver to use same interface for all
> property providers, i.e. Device Tree, ACPI, and board files.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Tested-by: Serge Semin <fancer.lancer@gmail.com>
> ---
> v2: added tag (Serge)
>  drivers/mfd/intel_quark_i2c_gpio.c | 70 ++++++++++++++++--------------
>  1 file changed, 37 insertions(+), 33 deletions(-)

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
