Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58BD2345B2F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 10:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbhCWJnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 05:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbhCWJnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 05:43:18 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B259C061756
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 02:43:18 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id b16so22691622eds.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 02:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0hkbYACOMfkrmU9Itv7aBZoZaQN614rwNKXnBs92y0U=;
        b=KFK7Gl6Loz5yCvngMmCyE/TcVpLAju6hCgi8R6DLg/KHgWlEvE0PmzfRnJByr6f1dz
         y1JF5RZjDJumy3xAkwhWz1LkOa9b1w3jXof53gbR7gRw4PcDJBhoC2SbKsKsQ3NraBkX
         oj/WRAdbq1BTlNYCgbY6SsaZzTWabF9u7JN986LiHT98xbkcQsCjKui3PWoAN6QOkqIx
         LFP2D2GOjHRk4bdSI5RwZsZwau1ta9+kMzTD8+nHII+bFvg1e7JYNP1KjyEdNrdJfQX6
         eKipxfAVe3VDY1D4NrXIC6A22Jyn5KTg6jxLq1LcjuFu5EJcFZnt/4QqfND3c6UrhIkw
         qhIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0hkbYACOMfkrmU9Itv7aBZoZaQN614rwNKXnBs92y0U=;
        b=MuOT8wFJ/aubHZD0jc86HKkJvl5gxQtbH5Xb3CE1OgjOCzhV+FRqqQcpMEpGLXOrHR
         pVb6frfNu2/xxz61yz8NNIa7V55jD5eSgoOfUFnC80PVqChHsLp1TXJz7/pB3AKbaPKM
         t+rDq/Am5OySdU6LuMGJWdo0deCyQ69h8ImfdeI3mqrshcnrDappvnj7TCj2igm1BF+O
         l1OSQw5V3OE7TEi2O9Oh2HGNiN2ttAXdNmvml7yJhC06Xt7+6H14HsWtq0wy/PKvjtwh
         sfEQTMTE6gvPMLwA05q7MZ/lEdE0AaF1SXyHesddOKvp7nI0U9oTe8dw24sQjnVRiL88
         WqpA==
X-Gm-Message-State: AOAM532civnwoddbOAtjUiQnQ/+8z5CfoSI3N6fExkzI0IST/VxNqqZ5
        koM+JYw6DE5o5IDGUo44d03pIg==
X-Google-Smtp-Source: ABdhPJwfXBUZdaB1Qmf/e0goN/7hGlbXHdwvzBP8U1kMkO9nlQ2EQtfMy25rK2nJlLpWfLzwSL+1cw==
X-Received: by 2002:a05:6402:1d19:: with SMTP id dg25mr3789557edb.218.1616492597099;
        Tue, 23 Mar 2021 02:43:17 -0700 (PDT)
Received: from dell ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id s9sm12075958edd.16.2021.03.23.02.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 02:43:16 -0700 (PDT)
Date:   Tue, 23 Mar 2021 09:43:14 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Kristoffer Ericson <kristoffer.ericson@gmail.com>,
        Richard Purdie <rpurdie@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: journada720: fix Wmisleading-indentation
 warning
Message-ID: <20210323094314.GV2916463@dell>
References: <20210322164134.827091-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210322164134.827091-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Mar 2021, Arnd Bergmann wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> With gcc-11, we get a warning about code that looks correct
> but badly indented:
> 
> drivers/video/backlight/jornada720_bl.c: In function ‘jornada_bl_update_status’:
> drivers/video/backlight/jornada720_bl.c:66:11: error: this ‘else’ clause does not guard... [-Werror=misleading-indentation]
>    66 |         } else  /* turn on backlight */
>       |           ^~~~
> 
> Change the formatting according to our normal conventions.
> 
> Fixes: 13a7b5dc0d17 ("backlight: Adds HP Jornada 700 series backlight driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/video/backlight/jornada720_bl.c | 44 ++++++++++++-------------
>  1 file changed, 22 insertions(+), 22 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
