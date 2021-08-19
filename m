Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18F773F1DB0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 18:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhHSQVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 12:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhHSQVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 12:21:08 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EC7C061756
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 09:20:31 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id w20so14125821lfu.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 09:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=3asku0pLtHQRy/+xXumiM58BWe9crM57UxtzOfQVQq4=;
        b=bNYG/IJ/v86SVujewP4QJxLlN/utOyYqjWhe3wbSTEcCLJDtxm3Dr7bqajuumek1FY
         4Cde2gyL7jmUrv6J3cvLu8H4m8nP2BXCOW53Fckz38BkRNUq62n9GkYUz8ebeJgBO43e
         Tu7fi+nbJDnDgYk/qu/4KpR5MEi6vHE4CFb0ZSUc4rMwwVbEf0s3cChC7t9w1yMjrUHh
         0S+JunTw2an+s5pAFUgEV878CM/EmtGtexBRNwOEClD91Jvc0tZKMI9j87vaSEQPkbuz
         4mO2fBIKj41KlWaXzlxkt5QqSA0nL9x2pGA8zorzIp9NwvIM0TD1mhInDZsYbRfFEO8B
         L19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3asku0pLtHQRy/+xXumiM58BWe9crM57UxtzOfQVQq4=;
        b=Asywf8EIL+WDKVzt1+RVkgf4tMzYa+92/n8Ab7Oa0+/yrRG6Sc6n+GZaznSt2bSqMJ
         My9pbtFEKQtOV09C8pf5Q84BFsCEFiOYSXrpotKDw51IdisIU7PowAG86HulFUiu/nNJ
         m+h0xWitsDNhw2IFk+hEm42QjYFcVytuVG60v3lIPoIp+SujpSfAvU0jucKhowiwqVcf
         oKkilqDOP2M2F4WvML37KI0CFw/tsjPgNPSjgF+7nQKXvDlqnydREcTxeHV3rQFmG5x1
         5r+jEhPdKgq1rvqfZEK5mLpqdokCmMCIa6NfwQFv9nrDbpmyOgUK2B/1eW2EkzzUsmWh
         FX/A==
X-Gm-Message-State: AOAM5335X+21RVWEd6sGfRZ5Ez5U8gJQyHYefnygByu8rR7aZ5VciTBs
        roe3xg4ft27AmjXjo+8I1fqEwr0WlfmPEA==
X-Google-Smtp-Source: ABdhPJyXdxWtx1IexvtSBR0aUvfLyPXwSJV4HhYjAENl0Srz4sZjkoHT9yHpNluBqLYsRnLFr2hSKQ==
X-Received: by 2002:a05:6512:110b:: with SMTP id l11mr11099003lfg.199.1629390029852;
        Thu, 19 Aug 2021 09:20:29 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id c9sm348734lfb.236.2021.08.19.09.20.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Aug 2021 09:20:29 -0700 (PDT)
Subject: Re: [PATCH v1] drm/msm/dpu: Fix address of SM8150 PINGPONG5 IRQ
 register
To:     Robert Foss <robert.foss@linaro.org>, robdclark@gmail.com,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        abhinavk@codeaurora.org, angelogioacchino.delregno@somainline.org,
        mkrishn@codeaurora.org, kalyan_t@codeaurora.org,
        lee.jones@linaro.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20210819133636.2045766-1-robert.foss@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <acf419d8-724b-4df3-a610-0c8cb7502094@linaro.org>
Date:   Thu, 19 Aug 2021 19:20:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210819133636.2045766-1-robert.foss@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/08/2021 16:36, Robert Foss wrote:
> Both PINGPONG4 and PINGPONG5 IRQ registers are using the
> same address, which is incorrect. PINGPONG4 should use the
> register offset 30, and PINGPONG5 should use the register
> offset 31 according to the downstream driver.
> 
> Fixes: 667e9985ee24 ("drm/msm/dpu: replace IRQ lookup with the data in hw catalog")
> Signed-off-by: Robert Foss <robert.foss@linaro.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> index 2e482cdd7b3c5..420d78cfce8af 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> @@ -794,7 +794,7 @@ static const struct dpu_pingpong_cfg sm8150_pp[] = {
>   			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 30),
>   			-1),
>   	PP_BLK("pingpong_5", PINGPONG_5, 0x72800, MERGE_3D_2, sdm845_pp_sblk,
> -			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 30),
> +			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 31),
>   			-1),
>   };
>   
> 


-- 
With best wishes
Dmitry
