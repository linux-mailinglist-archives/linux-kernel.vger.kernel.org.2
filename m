Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4934F38E0F0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 08:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbhEXGSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 02:18:48 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:34652 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbhEXGSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 02:18:47 -0400
Received: by mail-lf1-f54.google.com with SMTP id f30so2026729lfj.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 23:17:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc
         :in-reply-to:references:mime-version:date:user-agent
         :content-transfer-encoding;
        bh=w+uXbwcpYa351KpyXBaA7CGKwFt4BTnB/7IpdjhbrNA=;
        b=jifGtBLJOWmme5f9cdDHDXvc7TQhqEnPhQlfar9K6JgbY5fdFOtzhtW/flbeBdKmzo
         W9PBIPvE0LiTnsKidNXozxxHukS1SGy5zv1uIrET35LkII3BPdVqrNt1mxhOu9pGzw2J
         tdI2f4zECJ1dfUWbgk46nNTLTmIEmz6KuPbGwM4gCq8ZOtR6NWc5cf2WqvjgzvwxuWQP
         BtFih1XmGIYdrzZd6po+U2diQGB+/rLkqBFSB4woq8DUlTGdv2l7NXllw85s/xWfmqL5
         lplUwAl+w99XZFT9vCpjj9P7PcUCpfCgpCRT16TO2tHdpu94EOK1TnUJGeNEoOQTVqhH
         9dnw==
X-Gm-Message-State: AOAM531D30q3CkktCIUUSVLyS989QAQ3heOisHAVEvL6mOIm0GY1c1zA
        iza4lLi+xiorQoEsjDh6bmM=
X-Google-Smtp-Source: ABdhPJz6FGIcUy/AV24s5nxWESb2UrFPRhfLaETBmlSSSAXqjT1Vh6201gPoAOloaQxWk21jBAyrAw==
X-Received: by 2002:a19:7d82:: with SMTP id y124mr9456517lfc.76.1621837038630;
        Sun, 23 May 2021 23:17:18 -0700 (PDT)
Received: from dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi (dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::4])
        by smtp.gmail.com with ESMTPSA id l6sm1333365lfk.49.2021.05.23.23.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 23:17:18 -0700 (PDT)
Message-ID: <5639c1af646367caf345d0c346dded4e52178030.camel@fi.rohmeurope.com>
Subject: Re: [PATCH 2/2] regulator: bd71828: Fix .n_voltages settings
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reply-To: matti.vaittinen@fi.rohmeurope.com
To:     Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, linux-power@fi.rohmeurope.com
In-Reply-To: <20210523071045.2168904-2-axel.lin@ingics.com>
References: <20210523071045.2168904-1-axel.lin@ingics.com>
         <20210523071045.2168904-2-axel.lin@ingics.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Mon, 24 May 2021 09:17:11 +0300
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 2021-05-23 at 15:10 +0800, Axel Lin wrote:
> Current .n_voltages settings do not cover the latest 2 valid
> selectors,
> so it fails to set voltage for the hightest voltage support.
> The latest linear range has step_uV = 0, so it does not matter if we
> count the .n_voltages to maximum selector + 1 or the first selector
> of
> latest linear range + 1.
> To simplify calculating the n_voltages, let's just set the
> .n_voltages to maximum selector + 1.
> 
> Fixes: 522498f8cb8c ("regulator: bd71828: Basic support for ROHM
> bd71828 PMIC regulators")
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---

Thank you Axel. I never stop being surprized by your accuracy what
comes spotting errors like this. I had to look-up my calculator and the
data-sheet to verify your fix - and you did find this just by reviewing
the existing code(?) Really impressive. It seems the biggest supported
voltage (2V) was really not reachable as it only belonged to the last
(step 0) range. Big thanks!

Reviewed-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

>  include/linux/mfd/rohm-bd71828.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/mfd/rohm-bd71828.h
> b/include/linux/mfd/rohm-bd71828.h
> index c7ab69c87ee8..3b5f3a7db4bd 100644
> --- a/include/linux/mfd/rohm-bd71828.h
> +++ b/include/linux/mfd/rohm-bd71828.h
> @@ -26,11 +26,11 @@ enum {
>  	BD71828_REGULATOR_AMOUNT,
>  };
>  
> -#define BD71828_BUCK1267_VOLTS		0xEF
> -#define BD71828_BUCK3_VOLTS		0x10
> -#define BD71828_BUCK4_VOLTS		0x20
> -#define BD71828_BUCK5_VOLTS		0x10
> -#define BD71828_LDO_VOLTS		0x32
> +#define BD71828_BUCK1267_VOLTS		0x100
> +#define BD71828_BUCK3_VOLTS		0x20
> +#define BD71828_BUCK4_VOLTS		0x40
> +#define BD71828_BUCK5_VOLTS		0x20
> +#define BD71828_LDO_VOLTS		0x40
>  /* LDO6 is fixed 1.8V voltage */
>  #define BD71828_LDO_6_VOLTAGE		1800000
>  


