Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0180C3EDD1F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 20:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbhHPSeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 14:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbhHPSeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 14:34:24 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CFFC061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 11:33:52 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id d16so10531348ljq.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 11:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YTS8ZgXCuH1PuqQv5c9vfhOBKUsRFjCQLfWXK7K1MRc=;
        b=NOitTu/47BOg5MpNdaYFQ7Dno4q6xm8dU1P6f5zjdlyVLEJ8Z/asMZW1XsBErQLaiI
         cOXtgJcyR+jwpZT5F0TcFtw9iwUOPlSUr7Io61W6MFceIzXD8aBVYsrA+bluGOxkaKM2
         G4w4cPffp1gWB3hmrS/ZBFxUG1g/wC2Sj4FjSUU0f1gAtWvCv6M3/IA2GbxVfGozrvgh
         BpjM4HvFFTPAjwpza7nepEa+WvBPIkTSq4oh26QxYq779cFw7xtRfcQoB73jYIN3Ly6I
         LDXwxxkLd543p2zDb0RKNLiL9W6TSO1i4inBO30ug4ynLBdenUjptPJfgdSb8hS0LOH8
         IKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YTS8ZgXCuH1PuqQv5c9vfhOBKUsRFjCQLfWXK7K1MRc=;
        b=EfK8XmpMh44UnthVGfTqGb6q9YAy69lFY9Z6kjwxEHMNC5Ni4BG4IgzbTkkxN6zKkH
         byNujVLGrnh0hVg6VwOzPt8la3nhJjpNFXB3ifduWNg/4rb4g09eI4cCqhSwieLDzGcw
         I2dQT6Q+Rqdf+hmk15ucHXuFZuhiRgkr+FwDcBCyV4GCIxcwMqOK8l1DqGNmJWuXtJee
         ODjMHaf3gpPORwnsIj0ea6xUwvRLMLjoJ5/m/Ltb8TJZOAcUUbtDqrfJJlesLFBH4Uem
         baumIjdSrADNlSLLrNCb7Ih17i3b/eIgqpujyy4B6QThInX+5znL/5u7jFMy85Clc1Ld
         SUIg==
X-Gm-Message-State: AOAM533/R7BelssEbZGxASCQfNSJkoONCK5D8vuA7A+CQm7BRAWwaGiT
        2RBqSNO4qudddNjfvtVLPL4=
X-Google-Smtp-Source: ABdhPJw38xHx3nos1WlUP6JJqE+mD3b9t9CUEFVpmd6uX2c8AzflQM/WrxswEmPSISK7ZyrQC76u4w==
X-Received: by 2002:a2e:8008:: with SMTP id j8mr4401ljg.233.1629138831261;
        Mon, 16 Aug 2021 11:33:51 -0700 (PDT)
Received: from [10.0.0.40] (91-155-111-71.elisa-laajakaista.fi. [91.155.111.71])
        by smtp.gmail.com with ESMTPSA id bu14sm3076lfb.6.2021.08.16.11.33.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 11:33:50 -0700 (PDT)
Subject: Re: [PATCH 3/3] ASoC: ti: davinci-evm: Use of_device_get_match_data
To:     Aakash Hemadri <aakashhemadri123@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Takashi Iwai <tiwai@suse.com>, Jawoslav Kysela <perex@perex.cz>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bjorn@helgaas.com>
References: <cover.1628972198.git.aakashhemadri123@gmail.com>
 <6ebb350fa8a960b8775ce324b7786dbaa865a1c8.1628972198.git.aakashhemadri123@gmail.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Message-ID: <b096a803-093a-b70f-2999-38bfe8978513@gmail.com>
Date:   Mon, 16 Aug 2021 21:34:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <6ebb350fa8a960b8775ce324b7786dbaa865a1c8.1628972198.git.aakashhemadri123@gmail.com>
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
>  sound/soc/ti/davinci-evm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/ti/davinci-evm.c b/sound/soc/ti/davinci-evm.c
> index b043a0070d20..bf13f3d25cec 100644
> --- a/sound/soc/ti/davinci-evm.c
> +++ b/sound/soc/ti/davinci-evm.c
> @@ -389,7 +389,7 @@ static int davinci_evm_probe(struct platform_device *pdev)
>  	struct clk *mclk;
>  	int ret = 0;
>  
> -	match = of_match_device(of_match_ptr(davinci_evm_dt_ids), &pdev->dev);
> +	match = of_device_get_match_data(&pdev->dev);

incorrect,
of_device_get_match_data() is retrieving the match->data

>  	if (!match) {
>  		dev_err(&pdev->dev, "Error: No device match found\n");
>  		return -ENODEV;
> 

-- 
Péter
