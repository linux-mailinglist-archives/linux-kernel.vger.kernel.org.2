Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B65344784
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 15:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhCVOim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 10:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhCVOiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:38:10 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D476FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:38:09 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id u5so21681855ejn.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=mxYUtMBb2mh+RuKkbFHDap2LrV+8+7mvjwyPGr3hDug=;
        b=s1rinXsmNk8EhfAIwYfCa6dWxAxubDye4a2T1AOjngfoz0W0HdvDC7HULTUZN6cat6
         mMQarvzB5fQLKuqJTVoDtOC/oj2fQ2upfoAb8XgEAjaWelR5wjFrYYrj4hZ8PGa6Qlr3
         4DhJ4RQG0UfwaCBRkz8XLqbbgnepDBKsGV2lc4E+p8F7qaISnBA1DJ5P35JiRhYtEqTO
         +M1MRiqpV6okQBx9Z5j1eolYCwWA+70YgaXDhvBUPhWj2ET6/5o7sQQwN/XiOFxNrBLy
         gx8evtfB1+JhAbroi79G5JCUe8MFCl3MciihUI8EhQaoNOtcjmg0NRV2d9ew4X5aUVH2
         mQqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mxYUtMBb2mh+RuKkbFHDap2LrV+8+7mvjwyPGr3hDug=;
        b=Kcurpdw7u/slFBTtvSfj4Kcv9Cte2GB/GXttXkBTivq2XGhTh/LRCRSvVne9wk+Mrc
         HnTaAgOnDPYtFs5ZWNbrryFOuxCk0MqJGCL/e3knbCMDouCTu1K/ZrfE0fwgKenydawz
         75VQtJpzC8cw+zNR00dZSFi31SsfBGCgNUKhiLjE6imZgxPqipixWw4CBqWeSBU+I7ae
         RHB0g3GmDOGzIKtgGVBiLJColZPGkpo+ZzdWpMgZDZv6N1xMKih7IwjYaNkxjfNuacGf
         uQmW4Kdvv4Gq55+/Qy1bms+0ih93rwwedxaFq6/D5qDMHKZ4I3TqeOefhd7ieOocADgz
         ipIg==
X-Gm-Message-State: AOAM5319uXVHYYlJxfO3qthVtzW0RoCwCSuZjX2eM9h38LttBwK1hpuT
        G7kx5d0F3h+ahU0DkEleyuIknmztTjeBVA==
X-Google-Smtp-Source: ABdhPJxeLFNxxt4mp4YO7ncm+doChiXv0Sui7PLP69ncLofJ3qMlGPbka0cbjNukDX+SVpGHGJIrtA==
X-Received: by 2002:a17:906:565a:: with SMTP id v26mr62200ejr.516.1616423888607;
        Mon, 22 Mar 2021 07:38:08 -0700 (PDT)
Received: from dell ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id v8sm11443997edc.30.2021.03.22.07.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 07:38:08 -0700 (PDT)
Date:   Mon, 22 Mar 2021 14:38:06 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/4] mfd: core: Add support for software nodes
Message-ID: <20210322143806.GS2916463@dell>
References: <20210301144222.31290-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210301144222.31290-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Mar 2021, Andy Shevchenko wrote:

> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> 
> The old device property API is going to be removed and
> replaced with the newer software node API. This prepares MFD
> subsystem for the transition.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/mfd-core.c   | 9 +++++++++
>  include/linux/mfd/core.h | 4 ++++
>  2 files changed, 13 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
