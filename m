Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCF19395995
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 13:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbhEaLWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 07:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbhEaLVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 07:21:47 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D214C061760
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 04:19:33 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id t15so3162985eju.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 04:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3BI+WxFeJVP/z4UaiBvZQjKoXdxnhoRpGlAlohrIfqk=;
        b=Je6AmO3k7uAXvUnE/I3GzXmyor6nphE3Brq+PSZx3AeFDCGiaTdDWdrGOPn+AKjCn/
         Vw0uGlBtR9Cgdhx5ozG5RiN/RJjX6TsGxGDpgS4WUo2rmJxF3gCLoVH5dF+57a5ljdHN
         Ef1i7torbtI3FcsALpLqEgttAxFXUQ3WYyceoiWY5Tw7oMuYEYhfqDq4LA9/oCHRszJ+
         pjsfXZSm3m3+wveFvyEEzvIKI3X9ZzhIvqpBaurwoxmZF4rqZa+PrSVVY+DjWt4mTqJi
         2qgnbqAZSkfhqyFOFlQP861TEp0wRbuCGeE0hHUYSiljyqMooxhTPr0aXpLw6rQcA+Ym
         KZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3BI+WxFeJVP/z4UaiBvZQjKoXdxnhoRpGlAlohrIfqk=;
        b=DagDpknv6SUQ93P4qogQ23S8OX2ByP8E80x51OinUMKcaBlFiCJ4GyLNbrzpJ/d066
         JDEUmlHEdD/1mxQxYLDK2iKRddGc/ha/nYM+FSceC+hX0JsgiwVJwIQvqWm2bY8Z29dh
         d1QhJn2V64JR9HQwDE4FlswcclgcMvAJ3ImWvRs0NID0XBggHhkqYVmPvTVnyK/LSOp6
         a49JDMjHLieooGKFlKAsTNZ/4xq7WXpbbP5h3wa/Nq903whSIK605yzgjS/ZtqRBrRPl
         5UvVIO2aNwCBMy4moSK44WGxCLzPStsPZ3VR8kU0qa5NH8/gfMgemR7pkeNH2g6V895b
         YxiA==
X-Gm-Message-State: AOAM5327hZsNkSf+u2d8IsVHEW+uOchNwc6JWyNn3chCycIavrya+U6Y
        Lih2a2Un3qX60l9O0jzCQJ+1RA==
X-Google-Smtp-Source: ABdhPJxxUEd7xyydidSoSmThKBcU+xRMvqiwt1PryCgVYHpffzNDjd/oUUhfEb7YVXX8kPyDcjhusQ==
X-Received: by 2002:a17:906:22c6:: with SMTP id q6mr22567073eja.275.1622459972171;
        Mon, 31 May 2021 04:19:32 -0700 (PDT)
Received: from [192.168.1.28] (hst-221-6.medicom.bg. [84.238.221.6])
        by smtp.googlemail.com with ESMTPSA id q4sm6699275edv.24.2021.05.31.04.19.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 04:19:31 -0700 (PDT)
Subject: Re: [PATCH 3/7] media: venus: Add num_vpp_pipes to resource structure
To:     Dikshita Agarwal <dikshita@codeaurora.org>,
        linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, vgarodia@codeaurora.org
References: <1621417008-6117-1-git-send-email-dikshita@codeaurora.org>
 <1621417008-6117-4-git-send-email-dikshita@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <705244eb-33af-57aa-9c96-9076a11e8436@linaro.org>
Date:   Mon, 31 May 2021 14:19:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1621417008-6117-4-git-send-email-dikshita@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/19/21 12:36 PM, Dikshita Agarwal wrote:
> V6 HW can have vpp pipes as 1 or 4, add num_vpp_pipes
> to resource struture to differentiate.
> 
> Signed-off-by: Dikshita Agarwal <dikshita@codeaurora.org>
> ---
>  drivers/media/platform/qcom/venus/core.c            |  2 ++
>  drivers/media/platform/qcom/venus/core.h            |  1 +
>  drivers/media/platform/qcom/venus/helpers.c         |  2 +-
>  drivers/media/platform/qcom/venus/hfi_platform.c    | 13 -------------
>  drivers/media/platform/qcom/venus/hfi_platform.h    |  2 --
>  drivers/media/platform/qcom/venus/hfi_platform_v6.c |  6 ------
>  6 files changed, 4 insertions(+), 22 deletions(-)
> 

Acked-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>

-- 
regards,
Stan
