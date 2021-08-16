Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33CA03EDD1C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 20:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhHPSdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 14:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhHPSdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 14:33:31 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4ECC061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 11:32:59 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id h17so28587189ljh.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 11:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=W8Fy2zeilbZUVjVN0KITdsrqcookdRVPAeyuky/LCDY=;
        b=jaH1ZDMjfFdDMxDtK3oJHDLrrW56vNGTeqw5Jla+RgaOoJbEaJ8EeIssT7pOuAADIK
         BzhEFPFKiB/boC6GuYf/vBq+y/vKxcIItOV2gkHW2Zhi0SKtuHkTnrjONYA+lM3OVDy4
         MOdPR1aPYZ7Cippui03ZlspPPdDPMbwHvOYLhg7C5/VFvne6mHnGvMEXf2nWFATWUD+Y
         Hgt9JNM95Y3S+sHEYgcee1J++l0ffj5jEtLm9wMF6auCFGvm6xVd1CcPR0TpFaHZuW0b
         d5Yd3zj0CnDu2P3sO18IVGKy39s7TAig5sUxalbvyH++1TzaovWndJhCghw+wR4oSkM1
         K/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W8Fy2zeilbZUVjVN0KITdsrqcookdRVPAeyuky/LCDY=;
        b=uV/kXwkkfD2/mniZqnUSH4ihU5DAUu5pGwsCTrXzJjFwFe21piMh82CjwAIFG+XA+9
         Lxdt+8fALwJ7B8OLSWi9vtcBWS0o0ed9WeB7ntCOCiIZl3A9XnnTPiqaXupMDwmDw5zn
         dTGfsk6Jpn6V4d+d8w/TvbvMn+GpbzcKX7xunXECjMmlRr1omKKeBSIYCxB5GcKNoPGI
         jVEsJ+YaH+WnR9VpMAuxnK0Z87iaoLaXv3YARMexQF5vPF0VqO0qzH3FNJs4AIqGIAtL
         /6toU38e7+wDuTuVjfTEvuY32NVN9lvbktK3nYZocr2HHc+ZS7cwjcoSf4X3TbifxCt5
         0Ugw==
X-Gm-Message-State: AOAM530KBb2XQfWRgZEbCtJXbO8l0drMXqjODlBRwCQAbWhE51U/PvqM
        lZSjcGJfmRKdWTYmRPUZ7z4=
X-Google-Smtp-Source: ABdhPJyW8Wdp2IzGFmH0NpyCmsmmSc1VdmUQWMBp+SRvcEDpura5qc+nvBSaPQLm7JOg/B0KbT6EeQ==
X-Received: by 2002:a2e:b5d0:: with SMTP id g16mr13587913ljn.349.1629138777850;
        Mon, 16 Aug 2021 11:32:57 -0700 (PDT)
Received: from [10.0.0.40] (91-155-111-71.elisa-laajakaista.fi. [91.155.111.71])
        by smtp.gmail.com with ESMTPSA id h22sm10645ljk.133.2021.08.16.11.32.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 11:32:57 -0700 (PDT)
Subject: Re: [PATCH 1/3] ASoC: ti: davinci-mcasp: Use of_device_get_match_data
To:     Aakash Hemadri <aakashhemadri123@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Takashi Iwai <tiwai@suse.com>, Jawoslav Kysela <perex@perex.cz>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bjorn@helgaas.com>
References: <cover.1628972198.git.aakashhemadri123@gmail.com>
 <ffe9b568be52cc075df56bbf07f20a92cb54f07d.1628972198.git.aakashhemadri123@gmail.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Message-ID: <b7541f9c-8e21-300d-ed3c-ea5e610b7266@gmail.com>
Date:   Mon, 16 Aug 2021 21:33:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <ffe9b568be52cc075df56bbf07f20a92cb54f07d.1628972198.git.aakashhemadri123@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/08/2021 23:19, Aakash Hemadri wrote:
> Prefer `of_device_get_match_data` over `of_match_device`
> 
> Retrieve OF match data using `of_device_get_match_data`, this is cleaner
> and better expresses intent.
> 
> Signed-off-by: Aakash Hemadri <aakashhemadri123@gmail.com>
> ---
>  sound/soc/ti/davinci-mcasp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
> index 56a19eeec5c7..b26e8d324078 100644
> --- a/sound/soc/ti/davinci-mcasp.c
> +++ b/sound/soc/ti/davinci-mcasp.c
> @@ -1881,7 +1881,7 @@ static bool davinci_mcasp_have_gpiochip(struct davinci_mcasp *mcasp)
>  static int davinci_mcasp_get_config(struct davinci_mcasp *mcasp,
>  				    struct platform_device *pdev)
>  {
> -	const struct of_device_id *match = of_match_device(mcasp_dt_ids, &pdev->dev);
> +	const struct of_device_id *match = of_device_get_match_data(&pdev->dev);

No.
of_device_get_match_data() returns the match->data

>  	struct device_node *np = pdev->dev.of_node;
>  	struct davinci_mcasp_pdata *pdata = NULL;
>  	const u32 *of_serial_dir32;
> 

-- 
Péter
