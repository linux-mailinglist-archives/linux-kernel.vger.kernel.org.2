Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4529A388D76
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 14:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353269AbhESMGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 08:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbhESMGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 08:06:31 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D503C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 05:05:10 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id u4-20020a05600c00c4b02901774b80945cso3281718wmm.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 05:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=gJ6Dh+Db1o/nFk+i1XwBUQHdQxjXRzlUyea0FDXmzLY=;
        b=h++6B3hwaLcK0rGpigQD1JZCXWEXBJzcSQEPlTXB1knhuGJll/pWNQ/IzltxPb1Lrz
         9B7un8UnBif2dgtpyL+0qpC+bSrVfvJrBdEzy884Wi1z7uw9cBLOUIEMWEddc3GUbSDW
         efe66I0dnDFjrapsgv1tvONtp1MBSfKZFUaQW+I9IF7SW2vueZPSSxSAYb5JqcRz/rub
         f1LF5C2boIZ/ArAAf0CQtZ4rmtpiv+H3VvCObygL256n5TBUZaT8zi0yaS237lG8GTSj
         rZiYy/FMJ8/BWA9zLGu3ZyxlL6LZbK5gGmEGgt9WxwV//wl2cB7uMh/+/8tVEhW4svEh
         Lstg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=gJ6Dh+Db1o/nFk+i1XwBUQHdQxjXRzlUyea0FDXmzLY=;
        b=q/KO+mddhJuvy7/Tf8ZcdbqBeeJDSBsS0HB6OFSwEbJWCmUpWtw2vlDAZF1VQKHrXg
         OO3N0y3tPMfNM4EytrTMjoUmyWBEHsJ/ecb6pOYSb7wEUq0rhbH8g6ijUdvM5PjDI21e
         NZh4aiKXewmRD/R8H7fgvRTHW5Qxe3bl6SvM4XwoH5AI9sfimi7tW2zZ8sha0XG3Fclt
         nJF/+MOEkOdmFRylQ7N5sZuXOewviOSYmbigXdkGK3H1sI1Fjh7uYT66fFG5J1qw/It/
         Oa+9sUQlUvI1uKJMasI58pdSQHlDqg4m3PnLWQeHZ0nDdec6Fg3za/eUxPGwDnavzFhF
         fAKw==
X-Gm-Message-State: AOAM531torJ7jZozyS1TO3yoY6tc6Ft6VbS1OhAY+NtL8BMiXO4gwkj2
        XeXS8U7Rshvnb9luy7o5gxE09iGDJFHtSw==
X-Google-Smtp-Source: ABdhPJxuQEM82+by9HhUbq3LLXV5S5kkHt32Zuy9aRu+bKZw3km/GSbhR95THPM7b4uTeuy2UeLwOQ==
X-Received: by 2002:a7b:c1c6:: with SMTP id a6mr11338984wmj.189.1621425908940;
        Wed, 19 May 2021 05:05:08 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id a18sm5680923wmb.13.2021.05.19.05.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 05:05:08 -0700 (PDT)
Date:   Wed, 19 May 2021 13:05:06 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Meng.Li@windriver.com
Cc:     linux-kernel@vger.kernel.org, maz@kernel.org, arnd@arndb.de
Subject: Re: [PATCH] mfd: syscon: free the allocated name field of struct
 regmap_config
Message-ID: <20210519120506.GA2414669@dell>
References: <20210407052525.27592-1-Meng.Li@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210407052525.27592-1-Meng.Li@windriver.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Apr 2021, Meng.Li@windriver.com wrote:

> From: Limeng <Meng.Li@windriver.com>
> 
> The commit 529a1101212a("mfd: syscon: Don't free allocated name
> for regmap_config") doesn't free the allocated name field of struct
> regmap_config, but introduce a memory leak. There is another
> commit 94cc89eb8fa5("regmap: debugfs: Fix handling of name string
> for debugfs init delays") fixing this debugfs init issue from root
> cause. With this fixing, the name field in struct regmap_debugfs_node
> is removed. When initialize debugfs for syscon driver, the name
> field of struct regmap_config is not used anymore. So, the allocated
> name field of struct regmap_config is need to be freed directly after
> regmap initialization to avoid memory leak.
> 
> Fixes: 529a1101212a("mfd: syscon: Don't free allocated name for regmap_config")
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Meng Li <Meng.Li@windriver.com>
> ---
>  drivers/mfd/syscon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
