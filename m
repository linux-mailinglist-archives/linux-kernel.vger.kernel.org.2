Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B183241C64D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 16:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245292AbhI2OIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 10:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245240AbhI2OIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 10:08:12 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3ECC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 07:06:31 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id k7so4400933wrd.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 07:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SFy5oTvPPK9VruAErak/Pzx/A6/LmR8De7wfW7KazyE=;
        b=nw6sGwMFP4IjwoVj7Gp/1u3WBijqzUmI+6fEHWxom4fr6UuMVBLwet8dyk2alK/7c5
         EgyIOK1ETwyz9fDD3xQNHfqou2gg4ad9aOmi3Wlf6sEEyPpHbp9hGGkc+zlq7jNzrQB9
         AdjSt92Wy8zZy9fI4UYivS/2MKjRsDuM4lXHCFw3PXuyfpPWDjvKjjL/A10BVipTn+ZT
         d0vqmLOMEDJpP2x0Cioorkttud+zLWh0T26aiLczU/psHwTS/kCmaeNSvIQo5a1U2lno
         NAlsTXKpemqSGw/LscIfG7gkSAIy2Fc8zNyA/7yw9yYBpekClzi1YF8VVV2u3pkDa8av
         Y3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SFy5oTvPPK9VruAErak/Pzx/A6/LmR8De7wfW7KazyE=;
        b=jdzCQqVaRk+wNPjfbXVGxTbhkWferksuUv1wVBCZFBBFKc9WcKdgqh7oUnMBSnUJx+
         Gwz4Vjs4mtnSEwBY3qnGWdVlZushq0OzgwWDBs4jingQ+r/xfD9Qv4XdluBZwvRByy7y
         0HB4g8Hy8FsB9wfmVOKDUk/iXYWOICojfnrwisdwRA/snkNyo/6/Q9B8hH7XTbCP9wRB
         K+l+ImiHy2rroNTCaADPrQe46SVW24NhLuq2NF/DEV+QOy+JobrC1pZCp2xyEQ69OsPC
         nu9Dwq00oOPXpa3NpRdWItn5PAsLWhqFc4aJaOcd3jZAEGLlztcg1mH0AodTVLjCG0IS
         J/Qw==
X-Gm-Message-State: AOAM531vMjtbHbmT3MU0SE7P/Dq1T7LtV9KT/jl1EMahwqHtL2loSzJ9
        tUKPLNr02DZwo2E5O9dSjvwJRQ==
X-Google-Smtp-Source: ABdhPJyA2DjI2GvXl/gHuRpTbA5t0N37aYrHFSZR5zv8AYOa/wP9DWbReobp1l/Y+bp+AYzWmmJa6w==
X-Received: by 2002:a5d:44d1:: with SMTP id z17mr7214967wrr.187.1632924390084;
        Wed, 29 Sep 2021 07:06:30 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id m2sm1767881wmm.3.2021.09.29.07.06.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Sep 2021 07:06:29 -0700 (PDT)
Subject: Re: [PATCH 1/4] dt-bindings: devicetree documentation for secure
 domain
To:     Jeya R <jeyr@codeaurora.org>, linux-arm-msm@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        fastrpc.upstream@qti.qualcomm.com
References: <1632485951-13473-1-git-send-email-jeyr@codeaurora.org>
 <1632485951-13473-2-git-send-email-jeyr@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <18d78005-828c-eea3-2b6f-8bf6333a6963@linaro.org>
Date:   Wed, 29 Sep 2021 15:06:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1632485951-13473-2-git-send-email-jeyr@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Jeya,


Subject line should look something like "misc: dt-bindings: fastrpc..."


On 24/09/2021 13:19, Jeya R wrote:
> Add information about secure domain property.
> 
> Signed-off-by: Jeya R <jeyr@codeaurora.org>
> ---
>   Documentation/devicetree/bindings/misc/qcom,fastrpc.txt | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt b/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
> index 2a1827a..276c1d1 100644
> --- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
> +++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
> @@ -49,6 +49,12 @@ on the dsp.
>   		    context bank. Defaults to 1 when this property
>   		    is not specified.
>   
> +- secure-domains:

Should this not be qcom,secure-domain ??

You have added this binding for compute banks but the driver changes 
suggest that it should be for fastrpc.



> +	Usage: Optional
> +	Value type: <empty>

boolean?

> +	Definition: Specify DSP domain is secure, must be
> +		    "qcom,secure-domain"
May be reword this to "Only applicable for CDSP domains, presence of 
this property indicates that domain in secured"



> +
>   Example:
>   
>   adsp-pil {
> 
