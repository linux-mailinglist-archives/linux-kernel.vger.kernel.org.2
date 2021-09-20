Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4420411443
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 14:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbhITMXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 08:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbhITMXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 08:23:14 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A11C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 05:21:47 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id j13so60666289edv.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 05:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OMqTqQ3o+d+6GfbtQsxUwYcb6s9vIrc/5HEeEclyLzQ=;
        b=hq7G0Wpz4PLLxLib8QVIJe8EGkJBxZD19L3D4EJvvUm5Vz5o1U3Ye6oXVo5g/MfTck
         QJ8AGMjpAcyGrVv8+OfZ+m1bliDsLkEFVY6KHT0BkuGYlxRTviCMcK3NMM/UZVavamDV
         o3PdaFwezf0iDJ5PEnqGATWjxFHZ43vuF77QpSiYGHiAm7SdO+sNGYBnW0t3rRPE1QVs
         WNRtnMlFmZgRQA/D5uY7nPQOvOF67S9epH5/U2NF8ntnhmUvBUYH988Szi0VwObEh5I8
         DVR9fAXQY9bZGtA5f+OaVySUf7fo90Rxqi74VcrC5wWiWX1+HhsxmHFy2k+HI8925uGt
         GCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OMqTqQ3o+d+6GfbtQsxUwYcb6s9vIrc/5HEeEclyLzQ=;
        b=HGZE5YQZ5mWzrCYsyo0+e6kloF/JaiinzSm+CCm8FxemubA3k+fL/OXW2cZzR7FFYc
         P7CurbE/C9sJY5UEzvzBirndIRlxTCWJfNUQI53G2DpPU18WKHw2j39z1ILrMpCiUG5l
         ijc8UXw7lQwohJeK5Tt8+AA8xe/vvTj2HDIPuTHMtlOvAM1bE4dmslzRPe+1ISIKpu5u
         P68zXYuifYyg3yxcacvbdHlpylgE0OwfNNslu02iTd2laQAu8960Q07eyevc8LpHNKMq
         XQ3X9JIlQ4PS+/MaNM38AqymgcsgMZCjtJXZWjOQ01XZ/Cqa8iIM0BY/FRzURBgAHscp
         lZBQ==
X-Gm-Message-State: AOAM533pDi9c7XyyOIAodi1tXv25AUhKsB5cVgnERMhLd2LkQlIco8pC
        yz7eF9Xzd5FrDceVzUM+HfjjiA==
X-Google-Smtp-Source: ABdhPJwZ4JkYbgaiL0F4Lc4j5lELaBYBhliiuoTx4gg/Z6V+5rA8bld2mHIaUsVbiCyvnqhXbFVi6Q==
X-Received: by 2002:a17:906:dbf2:: with SMTP id yd18mr14404324ejb.536.1632140506214;
        Mon, 20 Sep 2021 05:21:46 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id ca4sm6095001ejb.1.2021.09.20.05.21.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 05:21:45 -0700 (PDT)
Subject: Re: [PATCH] misc: fastrpc: fix improper packet size calculation
To:     Jeya R <jeyr@codeaurora.org>, linux-arm-msm@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        fastrpc.upstream@qti.qualcomm.com
References: <1632125731-18768-1-git-send-email-jeyr@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <a26e3210-50e0-c665-0841-8b45c7f5497c@linaro.org>
Date:   Mon, 20 Sep 2021 13:21:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1632125731-18768-1-git-send-email-jeyr@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Jeya for the fix,

On 20/09/2021 09:15, Jeya R wrote:
> The buffer list is sorted and this is not being
> considered while calculating packet size. This
> would lead to improper copy length calculation
> for non-dmaheap buffers which would eventually
> cause sending improper buffers to DSP.
> 
we need below fixes tag:

Fixes: c68cfb718c8f ("misc: fastrpc: Add support for context Invoke method")

> Signed-off-by: Jeya R <jeyr@codeaurora.org>
> ---
>   drivers/misc/fastrpc.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index beda610..a7e550f 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -719,16 +719,21 @@ static int fastrpc_get_meta_size(struct fastrpc_invoke_ctx *ctx)
>   static u64 fastrpc_get_payload_size(struct fastrpc_invoke_ctx *ctx, int metalen)
>   {
>   	u64 size = 0;
> -	int i;
> +	int oix = 0;
Unnecessary initialization here.


>   
>   	size = ALIGN(metalen, FASTRPC_ALIGN);
> -	for (i = 0; i < ctx->nscalars; i++) {
> +	for (oix = 0; oix < ctx->nbufs; oix++) {
> +		int i = ctx->olaps[oix].raix;
> +

[--
> +		if (ctx->args[i].length == 0)
> +			continue;
> +
--]
This additional check will not really have any effect on size 
calculations, as (ctx->olaps[oix].mend - ctx->olaps[oix].mstart) would 
result in zero.
Any reason why this check was added?

--srini


>   		if (ctx->args[i].fd == 0 || ctx->args[i].fd == -1) {
>   
> -			if (ctx->olaps[i].offset == 0)
> +			if (ctx->olaps[oix].offset == 0)
>   				size = ALIGN(size, FASTRPC_ALIGN);
>   
> -			size += (ctx->olaps[i].mend - ctx->olaps[i].mstart);
> +			size += (ctx->olaps[oix].mend - ctx->olaps[oix].mstart);
>   		}
>   	}
>   
> 
