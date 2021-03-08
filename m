Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4C3330F21
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 14:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhCHN2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 08:28:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhCHN1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 08:27:52 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349C8C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 05:27:52 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id u187so6045433wmg.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 05:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=saEc1TYY1nAUlSikKKtyGX11ogdSAWD1iYa2DLUScjk=;
        b=X1/0nYLNBABVsxNOuXZGfHgOwEJ5EfT2gOfFYC7cblRB+ZZoo/Ebbx4YVciS0f0kXy
         IW3mqlQPTsiEC1Bo/QlvZp/ZaBCWcvc68j8CDeaMfCSgFtn5LnPxPJ2Lwub6fattuNw1
         E8+ht0kY3792J5+clZhZigsPPFPTlBCEudFxsViApOuyNmRtkPVnNI919JKG4vfYnbTb
         CNH1FbagnqnjolIoti373crAYhXY/ZW7uLMBisXkHpgVVlW1F1D9N+SiwAcia74sGpDw
         C6BiVQeEucpl8mgRDje4vVfufTbDyVnHYr7E717xf1xkCsFP0S6vbXWzaGjDyld1HOk9
         lORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=saEc1TYY1nAUlSikKKtyGX11ogdSAWD1iYa2DLUScjk=;
        b=nEXcb6197dXCm5s8PIjHderykFwDV5zS5RoyNXvOXXv/2sX6jtfAN4RNpxmnV1EDYq
         6REiIBdF8S5GYbHOBAXJzd8LPlVnNAOKs6wl9xTPYlCll1xusLleLRpN6Rd3/mw6fVoP
         CSFxigppthQP4n3RuTsRc2J6xr/XljGEvxBQ5MSvKTKRTzeJTFoyurkzuw5m+YswZzyH
         7IhMZoXLOI5tawS1lq48KzBzv+da7I2daudZW5hqEjZzehzoX6co2dPKpyFs/Axkm1u/
         YzzrD2OAnrN9SXBFb6ntyQF2Mt++31XW1/TcoZm5iI9DmOajYPPrAU/z3ehZoeaqjnhV
         EXUw==
X-Gm-Message-State: AOAM53122zRJVOlFmWUIuviOWrTRsD5xl5xsY2G+0MGw+yVzem4zNuGh
        s97AEW7fiywbH4rQulHYd7DS5zUmVfdVmg==
X-Google-Smtp-Source: ABdhPJzU2Z+XOI5LR30oRfZuJ16i9NW08wq+GscCbN27BjsMg9Zte2tX7/R/UTOCP5YPHpeF0Ju5Xw==
X-Received: by 2002:a1c:17:: with SMTP id 23mr22319815wma.6.1615210070937;
        Mon, 08 Mar 2021 05:27:50 -0800 (PST)
Received: from dell ([91.110.221.130])
        by smtp.gmail.com with ESMTPSA id l15sm18255626wmh.21.2021.03.08.05.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 05:27:50 -0800 (PST)
Date:   Mon, 8 Mar 2021 13:27:48 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: dbx500-prcmu: Use true and false for bool variable
Message-ID: <20210308132748.GC4931@dell>
References: <1612940856-72537-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1612940856-72537-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Feb 2021, Jiapeng Chong wrote:

> Fix the following coccicheck warning:
> 
> ./include/linux/mfd/db8500-prcmu.h:723:8-9: WARNING: return of 0/1 in
> function 'db8500_prcmu_is_ac_wake_requested' with return type bool.
> 
> Reported-by: Abaci Robot<abaci@linux.alibaba.com>

This needs a ' ' before the '<'.

> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  include/linux/mfd/db8500-prcmu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I fixed the above and applied the patch, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
