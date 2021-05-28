Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02CC2394656
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 19:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbhE1RXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 13:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbhE1RXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 13:23:10 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A37C061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 10:21:34 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id o127so2517731wmo.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 10:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=scHG+8hUPjtbaxqAIRrNTESjQXzSH5JKl2wenbFc2w8=;
        b=eFsE+o2qmtozyY3vcZ5kChHif66Zz7w0LGa+0qR/yny+Eq63joHpR0T9uLI7KYeDwe
         E/97imlGcQldR/Xs1VjBGkSKYHemWveFoMY1O4VqByLTtJKKSK6tZ31V4nclGy66T01h
         3kt+osmVafd4clK7SkYS0fM4BhQniaKp5vg+5iOM44Zxdx2VW3oTmd9r2KLRpcQg28QU
         IMX5ajbh8K8O+uf/aqgjf7IsS5wqUrsoSjtQUbApxNSNZHHm7FTKQ0Hs6uMWGZ7PpiEs
         LsTQURHghAxQmEg8EaZu/1n+ZzI0d/7fCxWVszp59txlXGMQlipYpQgRHUruRizU2epx
         9nQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=scHG+8hUPjtbaxqAIRrNTESjQXzSH5JKl2wenbFc2w8=;
        b=EQHNkHxMcU1qdw2EML7qjvFkWa4zPgQa1UCaXINYg6JIK+4TK4xBaEBP/IZ7Owko65
         QO7ZbAMeZ4uIbfFSfumIlM1kdEYNprzSEMKVklscL19AwTXu3Dya0gzp2iSebHUSg8Io
         k2geNkJ9O//I+MVumkkNWHzEMuiSYBmI/LVC8wUSnU4xWN2e/R92HqeSHhnU0rNr/g5w
         zdnUCcdDjIZ8K5ZcAmDGfoUMBcML2OQ4K7mCvpwiHZ8jSefoTA/9h1Hxs0WGYOrJPTKb
         cDj7wP4KNGaNK0pbdghrFvGV+n2anW/wgJNj+YnpMFkXnXvRYNOKLEuwmPALbIaAqo2Z
         LNgg==
X-Gm-Message-State: AOAM53043NmYxkhnwoGYIxomWSJ7grBFCuDS96UWgqfIs8scacVbv6Zw
        ERT8gkVYLfSB20mvEAw3yyj3sA==
X-Google-Smtp-Source: ABdhPJwDSWZ04EbaFWGZL6KGWkl1fL/jAW11ceb1vkO71Tn+4xdhReJ0jxgiwkSAbkpbB5CyCxToAw==
X-Received: by 2002:a05:600c:21c3:: with SMTP id x3mr9311858wmj.131.1622222493417;
        Fri, 28 May 2021 10:21:33 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id z17sm8767546wrt.81.2021.05.28.10.21.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 May 2021 10:21:32 -0700 (PDT)
Subject: Re: [PATCH] venus: helper: do not set constrained format for UBWC
To:     Mansur Alisha Shaik <mansur@codeaurora.org>,
        linux-media@vger.kernel.org, stanimir.varbanov@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vgarodia@codeaurora.org, dikshita@codeaurora.org
References: <1622195288-18541-1-git-send-email-mansur@codeaurora.org>
From:   Bryan O'Donoghue <pure.logic@nexus-software.ie>
Message-ID: <a66e00f2-af3a-9550-0779-625152cc2719@nexus-software.ie>
Date:   Fri, 28 May 2021 18:23:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1622195288-18541-1-git-send-email-mansur@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/05/2021 10:48, Mansur Alisha Shaik wrote:
> Do not set constrained format explicitly for UBWC
> 
> Signed-off-by: Mansur Alisha Shaik <mansur@codeaurora.org>

Could you give a little bit more detail on why, what the side effects are ?

Should this be a Fixes: ?

> ---
>   drivers/media/platform/qcom/venus/helpers.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
> index b813d6dba..e4b8a2a 100644
> --- a/drivers/media/platform/qcom/venus/helpers.c
> +++ b/drivers/media/platform/qcom/venus/helpers.c
> @@ -1138,8 +1138,12 @@ int venus_helper_set_format_constraints(struct venus_inst *inst)
>   	if (!IS_V6(inst->core))
>   		return 0;
>   
> +	if (inst->opb_fmt == HFI_COLOR_FORMAT_NV12_UBWC)
> +		return 0;
> +
>   	pconstraint.buffer_type = HFI_BUFFER_OUTPUT2;
>   	pconstraint.num_planes = 2;
> +

Additional newline should be removed.

>   	pconstraint.plane_format[0].stride_multiples = 128;
>   	pconstraint.plane_format[0].max_stride = 8192;
>   	pconstraint.plane_format[0].min_plane_buffer_height_multiple = 32;
> 

---
bod
