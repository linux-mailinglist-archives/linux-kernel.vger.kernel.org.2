Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41A154254D7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 15:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241784AbhJGN4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 09:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241783AbhJGN4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 09:56:34 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCD2C061570
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 06:54:41 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id i12so6767897wrb.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 06:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JmI9Xb1yRSSSNlr3bLX03Fwf/+HcWlHnhsZDlHxB6vE=;
        b=dYj5vqnSQwe5DgTOReWWmmfQLM4MrKLltnTo3um2EWr33clCTkzznA4ppLNtrHZjyK
         FWAhLR+4z882pjupUtfHVJlDBp4PXKBOoeQU8I+n/eu5SCdEMWWLrP8UZIvBTPeJTBsd
         0uQMo+o/t29f5eCUd+JnE7sTW1DP1qO0BYA7oGI/1YFxPZ6cJ2yA+UAr8paCBEY+L2J9
         BoLl5aM2Hn3T2G01wLjfjisETY412ydBWjcnw2P9m3xY7ziCi+AvYpe3awHBX5hePijU
         46TPCQvyQ275BnutZ11qBJ2uOgr25e5WycpvgAOsgciZyHe9sFbOs4w/tGP9Tj0S+iUS
         929Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JmI9Xb1yRSSSNlr3bLX03Fwf/+HcWlHnhsZDlHxB6vE=;
        b=qocl9mipPX2Jb0UcEobri1rB5cINsuRGOf0sYh6nofQkvSpChVDU71CgxyFfSpzZj9
         uFaKNWDW9eJJTgLs9POYTrjaylUP5u6b9By+CB0Da1NjrFOR4lcmAizC1qRK7U3KlWUj
         wDzzick9MRhQJOP/nB9GasVWcMW7zBaAZTFjnGdoypwTnmaEnZDkN+ZE/nrqtN6oPbkk
         eGTiteTlXv3GYAj7nGxmhovKPp9MIo5ynoIONywHNaSXyJItXW6QlYBFks/fH6epn40v
         9GsZt3ZMv9qkChWImPmiPfxeSt0Wwk4Iq40SWAZ8Il4QijJE08Hj1BpZhOVYaia4fQPh
         DX+A==
X-Gm-Message-State: AOAM533FZYndoya0JTsZkvcD1GPPF4uqxN966TVebGSvHfSHhaMnK1xm
        gmcZO8XTeUT/eBVWFd38ZC87wg==
X-Google-Smtp-Source: ABdhPJzvJg/xj+gie63fewWxxYbalLYjwPQBUmTPcgHHReNhtcnYsGUoOl7IeXm9TXMiIZ0ZTQJEgg==
X-Received: by 2002:a1c:1b90:: with SMTP id b138mr4836177wmb.160.1633614879620;
        Thu, 07 Oct 2021 06:54:39 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id l12sm17979848wro.14.2021.10.07.06.54.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Oct 2021 06:54:39 -0700 (PDT)
Subject: Re: [PATCH] ASoC: wcd938x: Fix jack detection issue
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        rohitkr@codeaurora.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org
Cc:     Venkata Prasad Potturu <potturu@codeaurora.org>
References: <1633614619-27026-1-git-send-email-srivasam@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <ee2e0088-da35-d01e-3207-6bcd41743d30@linaro.org>
Date:   Thu, 7 Oct 2021 14:54:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1633614619-27026-1-git-send-email-srivasam@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/10/2021 14:50, Srinivasa Rao Mandadapu wrote:
> This patch is to fix audio 3.5mm jack detection failure
> on wcd938x codec based target.
> 
> Fixes: bcee7ed09b8e (ASoC: codecs: wcd938x: add Multi Button Headset Control support)
> 
> Signed-off-by: Venkata Prasad Potturu <potturu@codeaurora.org>
> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

> ---
>   sound/soc/codecs/wcd938x.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
> index f0daf8d..52de7d1 100644
> --- a/sound/soc/codecs/wcd938x.c
> +++ b/sound/soc/codecs/wcd938x.c
> @@ -4144,10 +4144,10 @@ static int wcd938x_codec_set_jack(struct snd_soc_component *comp,
>   {
>   	struct wcd938x_priv *wcd = dev_get_drvdata(comp->dev);
>   
> -	if (!jack)
> +	if (jack)
>   		return wcd_mbhc_start(wcd->wcd_mbhc, &wcd->mbhc_cfg, jack);
> -
> -	wcd_mbhc_stop(wcd->wcd_mbhc);
> +	else
> +		wcd_mbhc_stop(wcd->wcd_mbhc);
>   
>   	return 0;
>   }
> 
