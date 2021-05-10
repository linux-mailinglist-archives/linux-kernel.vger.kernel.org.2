Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B529E3784DC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 13:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbhEJK4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 06:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbhEJKop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:44:45 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFCEC06137D
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 03:34:00 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id s5-20020a7bc0c50000b0290147d0c21c51so8582466wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 03:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=KfBhlxED/z8OAiqCMB0G+udAHqmSGRzT6CR07W8C+DQ=;
        b=rhAjurvrBMlrXW64wFgbm82tI4lJ+SkX65++JBQa29vp7TqbZtVy1dxP8fm3bMWtMU
         5LnLYmfS4gjF88Y1DHRoHqMsQ1Qv5CSizCA/wf/MSwPNXh+uBD6fm3XBJKRHZW5nZg1U
         HtwIlVcsLyK5AbAhQSeZ3BBJc7g/YpgLpoVKgO8SL1bjxzqTEm2HR89U81nLb810HUKm
         0cH6DvGA8tNW+JsazwQ0PmcmY5xn7C8oUa3K+j3whYkOyc1ja1N1KFOYFsRmqL9IN3pv
         leiy03bR7vjVo72VaRwDwJ2SEr2+jzB3LFD7lt53nQ5MIuMkr79QJl2BAx3V/ms5Nj1A
         snYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KfBhlxED/z8OAiqCMB0G+udAHqmSGRzT6CR07W8C+DQ=;
        b=mAQXyUcnXYsT0wFqRFm41e8breGrN0Fqwu0mERyM+p7eHliMNynnqPGlwVGaHP+myO
         nvoK6hsBGBPI9LzSg2CiPIRq6434hqhvRrjzxu5YwL9Oi5d6LqvWK2zcphDb+TOUZ9yj
         WNpBI4tFERwUzH4uVgw+nVVvyhB/6N64SWIpTcaaWYevlwCOVTc7xOJMYuvvm5k9Hl7S
         ODzJTKEyo9O+PwqpiMr0Owp5DkEquqEgBGHpXZNUKx3d73K/vpFBOHLLEXuaVZnwKzUc
         dyxGpapUSfIJ8oVOi5jL4zQjPmDgL5+iw3ZB0aLNlChPtbrcVU+psPdafk9p8CddhZ53
         Ayow==
X-Gm-Message-State: AOAM530Fc+W/PQrPM8Kbj3h3OTvxgHZJvaCi32eSmlxppqz0VDS1lB4u
        kbL4CU5k5s+Ht9IlW+kdwbo/Uw==
X-Google-Smtp-Source: ABdhPJzPorWGLmcfj2n+wX3BMD0ncPs53HtRGgvM3tWFfn+JE+mErnP+KoT+Xkv4p7i5L0Bp3yVaQw==
X-Received: by 2002:a05:600c:4f8b:: with SMTP id n11mr25018082wmq.11.1620642839569;
        Mon, 10 May 2021 03:33:59 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id m184sm19040458wme.40.2021.05.10.03.33.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 May 2021 03:33:59 -0700 (PDT)
Subject: Re: [PATCH] ASoC:q6dsp:q6afe-dai: Fix a typo in module description
To:     Masanari Iida <standby24x7@gmail.com>,
        linux-kernel@vger.kernel.org, dunlap@infradead.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org
References: <20210510102752.40620-1-standby24x7@gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <db812ab6-ab13-7f37-68a2-4a3f351fba6b@linaro.org>
Date:   Mon, 10 May 2021 11:33:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210510102752.40620-1-standby24x7@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the patch,

On 10/05/2021 11:27, Masanari Iida wrote:
> This patch fixes a spelling typo in MODULE_DESCRIPTION
> in q6afe-dai.c
> 
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>


Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

> ---
>   sound/soc/qcom/qdsp6/q6afe-dai.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
> index b539af86e8f7..2166fc305c8f 100644
> --- a/sound/soc/qcom/qdsp6/q6afe-dai.c
> +++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
> @@ -1706,5 +1706,5 @@ static struct platform_driver q6afe_dai_platform_driver = {
>   };
>   module_platform_driver(q6afe_dai_platform_driver);
>   
> -MODULE_DESCRIPTION("Q6 Audio Fronend dai driver");
> +MODULE_DESCRIPTION("Q6 Audio Frontend dai driver");
>   MODULE_LICENSE("GPL v2");
> 
