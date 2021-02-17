Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8F6E31DB45
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 15:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233327AbhBQOPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 09:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbhBQOPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 09:15:36 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065CDC061756
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 06:14:56 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id v15so17566106wrx.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 06:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UDFCRTsuiZ3IiAm76Fu7UKNR+ruV15r3mLWBUKSRUYk=;
        b=FMzIj+DJ25ZBr9XVddM/3sw4Ehs2ShlUSy4+IsWMKw5/EiywQmPWCY+BijAzt40ZEf
         Mtyzv7WTU5/nktwY9Li/Lc9lCgMCkXMjgfWGtKroR5kUH8iVwslpgv/lVOUl7bwQw8Sj
         HjbciOmOvBoNm9YhGrNvkeSMLLl+0gKuN7RzSB0/6qXuykp+ZY9vZjJTI5S5kGgtBIYy
         NgoPxH4wFk7lo+xQoYpv80b1F4KqgwDFrMEcxqJbDcEwnSyF3JNhtEsMFX6kBP8e8g2r
         OBi8707/VxQnfjF4L3NU9A1iMG3vJGXS2V5ICBiRn2xFO1CYcyx7Oh2BMmTxioXRD3eK
         BiIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UDFCRTsuiZ3IiAm76Fu7UKNR+ruV15r3mLWBUKSRUYk=;
        b=heebN4yXv2DyO8MejGUh5Sbx3wDPe/MtyF2TMJLUrrapy/VlYSfELzzAj6HK9heKls
         KXRs88/FGnhDGkvriQf322cxl6NMKFLFXUyUGV3gJ3TeDG2Rx6k0YAxabRlz2c2UIC7I
         ncobvei+3n+8dFVLT4IQnvBMfjM1kZ/atDcNYO1ZckZYSIljJUxl532KKWWPDCEJxu5L
         oF4QFi9kYQV+342SvnXGJS1Ywkm/Z0SasNHQRJ89h1MEVtlhIm5XqISGlGf+qtbvPDsB
         AEaVaFNuwzDXux9Rcv9My++W6lOYQd8/jicE+PksgyaCOY4ACGdPrTmFXPkh19C/2Qf+
         WKKA==
X-Gm-Message-State: AOAM532YQY/9qxlq2kZUwvtEN7r94wqJC3LHr1ifujmSgOr66gAou+VY
        kH1HLLAtQQERryAFZMNpi6aSM3ukOqPXHw==
X-Google-Smtp-Source: ABdhPJwNxrY3w7dpix3j+g9HhjNKICiJJZam+Eh0j5KukroXDcYynUnVCkkLPfAbhQS67/4wu1zBxg==
X-Received: by 2002:a5d:4850:: with SMTP id n16mr29797243wrs.296.1613571292946;
        Wed, 17 Feb 2021 06:14:52 -0800 (PST)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id m17sm3083820wmq.5.2021.02.17.06.14.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Feb 2021 06:14:52 -0800 (PST)
Subject: Re: [PATCH][next] ASoC: codecs: lpass-rx-macro: remove redundant
 initialization of variable hph_pwr_mode
To:     Colin King <colin.king@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210215200501.90697-1-colin.king@canonical.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <4e261a11-4577-4568-8ab3-f2ef1a9a8474@linaro.org>
Date:   Wed, 17 Feb 2021 14:14:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210215200501.90697-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/02/2021 20:05, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable hph_pwr_mode is being initialized with a value that is
> never read and it is being updated later with a new value.  The
> initialization is redundant and can be removed.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
Thanks for the patch!

LGTM,


Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

>   sound/soc/codecs/lpass-rx-macro.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
> index 8c04b3b2c907..76909c50d7b9 100644
> --- a/sound/soc/codecs/lpass-rx-macro.c
> +++ b/sound/soc/codecs/lpass-rx-macro.c
> @@ -2038,7 +2038,7 @@ static int rx_macro_load_compander_coeff(struct snd_soc_component *component,
>   {
>   	u16 comp_coeff_lsb_reg, comp_coeff_msb_reg;
>   	int i;
> -	int hph_pwr_mode = HPH_LOHIFI;
> +	int hph_pwr_mode;
>   
>   	if (!rx->comp_enabled[comp])
>   		return 0;
> 
