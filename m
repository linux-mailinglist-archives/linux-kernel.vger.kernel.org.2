Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E57C3374B61
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 00:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbhEEWnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 18:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234044AbhEEWnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 18:43:40 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB91C0613ED
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 15:42:42 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id t3so3126054iol.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 15:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=95LjVeoKX0halrIHWKfznAOSPthxN4T+yN1CIh34OYo=;
        b=Y/Iyosime/zrm3dwbPzl94FyH5pNAQXBvnr4wYdEKpCJf1gpKR+5zNfTxSJ0cdyKzy
         sEEE+Prb1cIMDFRzlCfhOiwPCKR5zW6gisdTK1iaAF2lJR2mG7fne0u5mtrjwUNMOjVR
         JC35Rw7tjFGuGapyQV/I3wgg7Km06yqQB5bug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=95LjVeoKX0halrIHWKfznAOSPthxN4T+yN1CIh34OYo=;
        b=fF/sp7jSghBbyqyp1bdgfL1N7i9Dgh1Ng03/lb9TqjykELtuv1ttMY5WYNrFJvDTyL
         2WHcRpQRDeUJkUJoXYmOJnSFQt1oRotBGBpn2XoC2L7tjfv8laHOHoS46RGP+9xQiI8y
         k3KP5G+r78gKigwJIH9OkSbGAy/subxf7qSr952+Re0Eg571ihg5DeRUgm3BC494hx1/
         80g0Iv+SUs3ra2wtLNYuCebRufyxEUOoM0lt3gvxwnbikkt1YT9DkMC0Byl4vj8p8Bu5
         t1soUFsrZZzKNN+KxOdOdZlOecEfv9qrfyRLMb+WQUHiMQVYwV0pKYKr6rI2EoMxZ7RX
         a13w==
X-Gm-Message-State: AOAM533cDvBPtFZfrn7RyElhQqymOxxnLw3mHWBGAIo3yMJMqJxQIBBC
        Gw702G9kIZC1JcK6I+ZxZHD+zAGhDYRO4LCV
X-Google-Smtp-Source: ABdhPJzWhR3C0XV8YCyPJa4cdRfcJXj95oozMakfPs9uap9CgiukVvEoE9rsiVxa4ccZmJU7llqj/g==
X-Received: by 2002:a02:3712:: with SMTP id r18mr885452jar.11.1620254562247;
        Wed, 05 May 2021 15:42:42 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id a17sm377033ili.6.2021.05.05.15.42.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 15:42:41 -0700 (PDT)
Subject: Re: [PATCH v1 2/7] net: ipa: endpoint: Don't read unexistant register
 on IPAv3.1
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>, elder@kernel.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org, davem@davemloft.net,
        kuba@kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, konrad.dybcio@somainline.org,
        marijn.suijten@somainline.org, phone-devel@vger.kernel.org
References: <20210211175015.200772-1-angelogioacchino.delregno@somainline.org>
 <20210211175015.200772-3-angelogioacchino.delregno@somainline.org>
From:   Alex Elder <elder@ieee.org>
Message-ID: <7c42e7fb-d2d5-3402-f17d-3dc34d73153d@ieee.org>
Date:   Wed, 5 May 2021 17:42:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210211175015.200772-3-angelogioacchino.delregno@somainline.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/21 11:50 AM, AngeloGioacchino Del Regno wrote:
> On IPAv3.1 there is no such FLAVOR_0 register so it is impossible
> to read tx/rx channel masks and we have to rely on the correctness
> on the provided configuration.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

What you do here is a very simple solution to the problem that
the FLAVOR_0 register is not available prior to IPA v3.5.

I wanted to try to do something that might allow the configured
endpoints to be checked, but for IPA v3.0 and IPA v3.1 they
just aren't laid out the same way, so it's not so simple.

I will post a patch that does essentially the same thing
you do, but which includes a little more complete explanation
in comments.  It will credit you for the suggestion and provide
a link to this original patch.

					-Alex

> ---
>   drivers/net/ipa/ipa_endpoint.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/net/ipa/ipa_endpoint.c b/drivers/net/ipa/ipa_endpoint.c
> index 06d8aa34276e..10c477e1bb90 100644
> --- a/drivers/net/ipa/ipa_endpoint.c
> +++ b/drivers/net/ipa/ipa_endpoint.c
> @@ -1659,6 +1659,15 @@ int ipa_endpoint_config(struct ipa *ipa)
>   	u32 max;
>   	u32 val;
>   
> +	/* Some IPA versions don't provide a FLAVOR register and we cannot
> +	 * check the rx/tx masks hence we have to rely on the correctness
> +	 * of the provided configuration.
> +	 */
> +	if (ipa->version == IPA_VERSION_3_1) {
> +		ipa->available = U32_MAX;
> +		return 0;
> +	}
> +
>   	/* Find out about the endpoints supplied by the hardware, and ensure
>   	 * the highest one doesn't exceed the number we support.
>   	 */
> 

