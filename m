Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D1F33ECBF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 10:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbhCQJQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 05:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbhCQJQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 05:16:04 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA30C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:16:03 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id j18so1018388wra.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=oTL9AJaFLnaIJwp+xH/32TIHC+0/+FSk9wN00bes39U=;
        b=uMXE+VtjZWadyYCebKZ3fIggjz4V1ChdYHWACmzHieC+U5oQgoCuWUExVACd5lgsxw
         w8s4oFwYG2AfLmamwBO9l9q/0TJ0gCkYFIuji6TWH18CtdAPoR6InemljL7TIsIXKRtt
         4A7O7wFyg52FK5pUVZzz0oLvx9BjVIqhabtjd6KLq01ti84V3Jhp4GcEDmBBZ3vOAH1e
         fUDXTKuJbq6ffGadIu8bCA9YpaFqktUqK6fzurFSa82mW9TodOD9yp+4OW+3IXowiWBO
         aa59V0PpQbYGVaH6WRVool0cghcBDK8OnkTMFtqO/nFZAO4i2WcpJTi7t9ouldiPeFE6
         4N9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=oTL9AJaFLnaIJwp+xH/32TIHC+0/+FSk9wN00bes39U=;
        b=brI4TMVmJfAz36aQdDOMgia+8e1+bnCU6dNm3oJuhFZ0YyNGzfyzfF4gmPZCYt3I9o
         DKcwY4xXkeRGxQyG4HrtXtsSsr2XWHsSIxU82vtkxJ8nTVOSp53YQYYvXkaU1wegz/2B
         A0nAMVhPnRtV8QiM6JpCRdFuz8fsZGklnwVwKxoO1jlta/mpsZWZNpGUiO8Z4qY9W+Ch
         sc26xoMkeF6crYtYG0lzP5pDL0J/CIzrcQO/UY/tUeaet9Q/OoBTFSZKfdrWWmIpVp7A
         zq4yecD0JSOp4q5pQHgLsjE3mLjrRsRvzrFv4bdeuPZCR71zSF1vkUdazwFAa61uIx0j
         jzyA==
X-Gm-Message-State: AOAM533eBDWWgZD+GsglCTPLzkeugxKoSH3X4orVIVCQClKssFSTNHsb
        boNA+t0fxlEBoUxhMiXlxTAj6A==
X-Google-Smtp-Source: ABdhPJzccso7yYfvjZ0BNG+B/bhDroptmdi0xF07T+f0b52aGSdXhB4T8OlAfzgB2MnMHmOq7BNizg==
X-Received: by 2002:a5d:4587:: with SMTP id p7mr3343208wrq.205.1615972562580;
        Wed, 17 Mar 2021 02:16:02 -0700 (PDT)
Received: from dell ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id p14sm1765900wmc.30.2021.03.17.02.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 02:16:02 -0700 (PDT)
Date:   Wed, 17 Mar 2021 09:16:00 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Kiran Gunda <kgunda@codeaurora.org>,
        Obeida Shamoun <oshmoun100@googlemail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: qcom-wled: Use sink_addr for sync toggle
Message-ID: <20210317091600.GJ701493@dell>
References: <20210314101110.48024-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210314101110.48024-1-marijn.suijten@somainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Mar 2021, Marijn Suijten wrote:

> From: Obeida Shamoun <oshmoun100@googlemail.com>
> 
> WLED3_SINK_REG_SYNC is, as the name implies, a sink register offset.
> Therefore, use the sink address as base instead of the ctrl address.
> 
> This fixes the sync toggle on wled4, which can be observed by the fact
> that adjusting brightness now works.
> 
> It has no effect on wled3 because sink and ctrl base addresses are the
> same.  This allows adjusting the brightness without having to disable
> then reenable the module.
> 
> Signed-off-by: Obeida Shamoun <oshmoun100@googlemail.com>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>  drivers/video/backlight/qcom-wled.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
