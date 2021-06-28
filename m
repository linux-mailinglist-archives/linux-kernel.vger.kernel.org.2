Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 760A53B669E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 18:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233510AbhF1QYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 12:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233108AbhF1QYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 12:24:04 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024EEC061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 09:21:39 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id g7so17365136wri.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 09:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1pcR5tMU/VIx6xCSCNVqJYXpFrepEwplXarGUNlayJw=;
        b=PUEajlAOMSfNEQVGHHBZi+GBuWnQVbPZ7UZHguWB2qCTQpxAuFWjp0S7JcZu0giexj
         sLywXW4nvrhvt/KJsA+oHrmJuR53Pw4wLMf3jebhgcICm7K0s14ma3lx3FWI8OAKoeZf
         iBIoceYxvLDYouTEKAeMRpNdSYhZKqv21bZ84vAoOSwYdtLZML5QdTYj5sRYf6bYDJ07
         e7rHJPqwxO3BsESgiYupz3tragCon1NK32HY34kJR/yeQ+am1gG6ka+DUCs69Cp+JTgY
         9FdDQ62E/696rTSGKyal2/ZO4cfq7GlAeO4sE8MJsXpV6g0KJleTOqdMrWencJDOiqdo
         GNdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1pcR5tMU/VIx6xCSCNVqJYXpFrepEwplXarGUNlayJw=;
        b=HOOpsuMSmn+ylfQCRERFUnxWJUW3jR9nIYVwlgprL7EpnNVhveAMxG0s85xOR+6y9+
         pEdS1T0yCey4rjy/UyKL1PtbbmyaAOew/C7UG2GUaqnrAIBafPQOHDYWr2KClrqz05Kh
         87pyFOJirx9PRZUE+ttaCH6TFOjCvO2ejhnxNoMlD4Duclh19+QJVUnjUOV/x5Ywyyya
         dvaNee5ianxXF2c9co0xYxglbAbQk8Ec7iD4mzoVRX4gLwjNuEL4IGjZ+rDarOWu5By1
         TRgLX1LF/rh2bsTtWFsiP1kr6bStS+Gvx9j18pWA+vrhulnwVgd3Yt0srccKmRuDy52J
         b/1w==
X-Gm-Message-State: AOAM530gm6H9ANzQCmT7XYDfbOqdz9oCCvUTH90pZAuY8IvugaEI8Xro
        /Y+/puYOOi1fzX5rqLXMEElhjA==
X-Google-Smtp-Source: ABdhPJyPkJWaD8OYx/+J8u3zOEVq+8krO8Fpd/gooB7bX5eBrHqxq+n7zVOLfSP0nsFg0PRX7Qx+Rw==
X-Received: by 2002:a5d:4e8a:: with SMTP id e10mr28326002wru.199.1624897297651;
        Mon, 28 Jun 2021 09:21:37 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id t16sm835175wrx.89.2021.06.28.09.21.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 09:21:37 -0700 (PDT)
Subject: Re: [V2] venus: helper: do not set constrained parameters for UBWC
To:     Mansur Alisha Shaik <mansur@codeaurora.org>,
        linux-media@vger.kernel.org, stanimir.varbanov@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vgarodia@codeaurora.org, dikshita@codeaurora.org
References: <1624896105-26852-1-git-send-email-mansur@codeaurora.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Message-ID: <ae9dcc09-4628-d9b3-788e-90c49085e2da@linaro.org>
Date:   Mon, 28 Jun 2021 17:23:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1624896105-26852-1-git-send-email-mansur@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/06/2021 17:01, Mansur Alisha Shaik wrote:
> onstrained parameters are to override the default alignment for
> a given color format. By default venus hardware has alignments as
> 128x32, but NV12 was defined differently to meet various usecases.
> Compressed NV12 has always been aligned as 128x32, hence not needed
> to override the default alignment.
> 
> Fixes: bc28936bbba9 ("media: venus: helpers, hfi, vdec: Set actual plane
> constraints to FW")
> Signed-off-by: Mansur Alisha Shaik <mansur@codeaurora.org>
> 
> Changes in V2:
> - Elaborated commit message as per comments by Bryan
> ---
>   drivers/media/platform/qcom/venus/helpers.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
> index 1fe6d46..601ee3e 100644
> --- a/drivers/media/platform/qcom/venus/helpers.c
> +++ b/drivers/media/platform/qcom/venus/helpers.c
> @@ -1137,8 +1137,12 @@ int venus_helper_set_format_constraints(struct venus_inst *inst)
>   	if (!IS_V6(inst->core))
>   		return 0;
>   
> +	if (inst->opb_fmt == HFI_COLOR_FORMAT_NV12_UBWC)
> +		return 0;
> +
>   	pconstraint.buffer_type = HFI_BUFFER_OUTPUT2;
>   	pconstraint.num_planes = 2;
> +
>   	pconstraint.plane_format[0].stride_multiples = 128;
>   	pconstraint.plane_format[0].max_stride = 8192;
>   	pconstraint.plane_format[0].min_plane_buffer_height_multiple = 32;
> 

Looks better to me on the commit log thanks.

You've missed the "C" from "Constrained parameters" though, also I don't 
know if its my mail client or not but "Fixes: xxx ("thing fixed") should 
all be on the one line even if it exceeds the 75 character limit.

---
bod
