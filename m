Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91D664254E1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 15:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241901AbhJGN65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 09:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241775AbhJGN6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 09:58:55 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37FAC061746
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 06:57:01 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r18so19420918wrg.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 06:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kQq0xCGqotFLmmvs4jPCrD6mVz7A9gMb8nAtNV0dxeM=;
        b=HWsW/9OcJDxgqkkiBU5+qjxZoCSIB1shHRB+Sb9HVtqJ4XUIq8IHStPoon98fq5AlA
         tQL18prYExD5HuJ/q51xDAIxa73iSTqP+caEJgVhotTekYDxw3GzzTrUzl3xD1kbIbte
         GSGrDPY7amQU1ZtLPxS+v7aoyzRwH1/x6XGBgrCsOa3k7ygT5YXUoMCJwPORlfJD/VBe
         RPd70qF/boWR6xWNPKzUrZgvA8SpqW6YnEjut8ZWGpwDtiNsIFb6eyEGdv9/BkgESm1W
         X1+I/n7PQewysIaWhfp3QoAzDTOdUG/O0FGplrFvZS0GnO5/VSvVehqEaWvq5eBLjzj9
         o6hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kQq0xCGqotFLmmvs4jPCrD6mVz7A9gMb8nAtNV0dxeM=;
        b=0/zavt5cpB5JuWiWvhREQOr34/wCDTGNb7+HcgyMHoUWnWFzTOIf06PO2xGyMJLXRQ
         ljgcTViZTpgUiz6QiboVhjVWQy+aQA5DVvFp/gVcJMZ/Ckbb9W5Mekg/p/pSpQ+V8Ml/
         7qsD6Uokzy5GsrAdfNVDhkDnaqb2GSFzBEDKzyeNlYoI2NA3iU2RbHsHTvuYbbOvLL/G
         4hlQJUCCqTsPpHaTMCn3RI3L/hlvRn+iivmzaCjQWkK/1tlDmWzb/Gy9TGPeqwPgwlgO
         0LfPuqAj6c1KDqPOPA1WB5R5EVQo6xrRNfuCqe5L/l2k8xQAws7lj85fXBxFDNjITukJ
         MUyw==
X-Gm-Message-State: AOAM530lu9gT6iM3Nd8Qy9i4wAv7PJ8Wz5OKaGn/724BL3/6ISEEl7DM
        r56oLfqJoVr7r03n2eDurK2XCg==
X-Google-Smtp-Source: ABdhPJxHCzaN93g3HhmQUt/+mxJ7EZDf5b2xG9w94uqi//2O64Y6WdJ6bv5skd3oTFllx0TjKqLm7A==
X-Received: by 2002:adf:c70b:: with SMTP id k11mr5478970wrg.154.1633615020393;
        Thu, 07 Oct 2021 06:57:00 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id q18sm8800003wmc.7.2021.10.07.06.56.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Oct 2021 06:56:59 -0700 (PDT)
Subject: Re: [PATCH] ASoC: codec: wcd938x: Add irq config support
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        rohitkr@codeaurora.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org
Cc:     Venkata Prasad Potturu <potturu@codeaurora.org>
References: <1633614675-27122-1-git-send-email-srivasam@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <217797a8-b37d-9084-f2de-b9162e21718f@linaro.org>
Date:   Thu, 7 Oct 2021 14:56:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1633614675-27122-1-git-send-email-srivasam@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/10/2021 14:51, Srinivasa Rao Mandadapu wrote:
> This patch fixes compilation error in wcd98x codec driver.
> 
> Fixes: 045442228868 ("ASoC: codecs: wcd938x: add audio routing and Kconfig")
> 
> Signed-off-by: Venkata Prasad Potturu <potturu@codeaurora.org>
> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>

LGTM,

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


> ---
>   sound/soc/codecs/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index 82ee233..216cea0 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -1583,6 +1583,7 @@ config SND_SOC_WCD938X_SDW
>   	tristate "WCD9380/WCD9385 Codec - SDW"
>   	select SND_SOC_WCD938X
>   	select SND_SOC_WCD_MBHC
> +	select REGMAP_IRQ
>   	depends on SOUNDWIRE
>   	select REGMAP_SOUNDWIRE
>   	help
> 
