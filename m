Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D1741FDF9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 22:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbhJBUFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 16:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhJBUFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 16:05:31 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C543AC061714
        for <linux-kernel@vger.kernel.org>; Sat,  2 Oct 2021 13:03:44 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id j5so48270228lfg.8
        for <linux-kernel@vger.kernel.org>; Sat, 02 Oct 2021 13:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=13J5NCM9YubkgnF2CpC0yWl/i0g0jlxsWta30UGyZs0=;
        b=oegKqyu7mPdwoj9O7UaSL7cBNwXG4+DCDfIIwHzwmEDyXxNlBxYXNWubfWrtiVv22I
         yMpvmEagtIR5jGGfEm7WleKL+gYwYbph9rAcr9tnJefvYCkFRpBs2ZbyrF8QcxsIGyay
         v4N+ETsW9Hc2f1yZXGdwrYSiBmYKAizqEgG1XU+vlBDIxA40atShmhTtum2ljLmwZxk6
         P6+cL/GcTNYowwBd7M0ZWEDUlIvpP3SNu0uzyVwnXmuhmU6tY69nQ9FL4W7k80F/DpIu
         sfz/1WcR3qd4/GSdZZoLVVe2UnliC3RysOdV+0ZXGzoE54qc+OaTbcmLltdN5nR44KNE
         pOtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=13J5NCM9YubkgnF2CpC0yWl/i0g0jlxsWta30UGyZs0=;
        b=me9CgBnWANOoyinHTQMVX33ZF5bNGo7WRsCfOFmavxd/i6TXairnQ1wc9KAk92jJ8/
         ac0U3WHW1hcaRm59GzIfRDQQK0ay6ZHxhoP87+gKyCAGYCDxAcVH/pMcSy6HEfBIgj0J
         c6D8HCifCLBWWG+OFHVdmRVAXjWxgvF4TMUaUbCZpktw2ALBOL/DtbvoI40mEEnabjTG
         JaP3SPs9N5c1+0N27QR9jcxhu2oReQRNIipTC52bHa7Dyu01azV3yOzwWrACmTZF+uMS
         Y0KBeCAL5e5PBE1wb9CFzNhP8G/VtvDlzEygCSKEUd6W/0w++Wq2Lh6Oorjap/8m4o2N
         muzg==
X-Gm-Message-State: AOAM530U6pRID6Elrzfj/8N5UuMh5oziHl39DCats7M4d2u/4iuK3Q5f
        1IfIy4jA3RYGv1FYLdVeI9+Rqg==
X-Google-Smtp-Source: ABdhPJxMzC5Hbab+sd5joT8D86weC5/IpuCQJrBVIIXEaN35dhD0lCCRcJVMffgtoz1UV//z8P6stw==
X-Received: by 2002:a05:651c:504:: with SMTP id o4mr5475218ljp.393.1633205023010;
        Sat, 02 Oct 2021 13:03:43 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id bj40sm1009896ljb.106.2021.10.02.13.03.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Oct 2021 13:03:42 -0700 (PDT)
Subject: Re: [PATCH] drm/msm: delete conversion from bool value to bool return
To:     Bernard Zhao <bernard@vivo.com>, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Drew Davenport <ddavenport@chromium.org>,
        Zheng Bin <zhengbin13@huawei.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
References: <20201102125030.6209-1-bernard@vivo.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <2e2abdc5-d426-a0f4-9fbb-640560b4abd4@linaro.org>
Date:   Sat, 2 Oct 2021 23:03:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20201102125030.6209-1-bernard@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/2020 15:50, Bernard Zhao wrote:
> Delete the conversion from bool value to bool function return.
> 
> Signed-off-by: Bernard Zhao <bernard@vivo.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
> index 8493d68ad841..411222f4cd6f 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
> @@ -37,7 +37,7 @@
>   
>   static bool dpu_encoder_phys_cmd_is_master(struct dpu_encoder_phys *phys_enc)
>   {
> -	return (phys_enc->split_role != ENC_ROLE_SLAVE) ? true : false;
> +	return (phys_enc->split_role != ENC_ROLE_SLAVE);
>   }
>   
>   static bool dpu_encoder_phys_cmd_mode_fixup(
> 


-- 
With best wishes
Dmitry
