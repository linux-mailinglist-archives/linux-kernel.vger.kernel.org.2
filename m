Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFF2A3FE8DA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 07:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbhIBFpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 01:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbhIBFpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 01:45:38 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BA5C061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 22:44:40 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id f2so1427176ljn.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 22:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=whtV4mfvH1NLVqepuQoF5mH+azqIMtCQpWr7A8sgds8=;
        b=SflWTuRVnPnyoXhl1IDxe8Xhe1X3He0u1LQUl9xdq8VoKmatudBt38yCMfhCOyLRwA
         27LAUAnu6ZZZ4MUxJHwqoZB3a8YbmECVSQErelN/6POW1UXw83HIV2YzOGR/r/MLFOvj
         GDJSbRyjSFncm33xccJJZhE/f31DdMVTe4shtUqnf4Bt7gtHr4CAlG/tsZkFY6VYl6Py
         JFyvYSgPape+UxjoOmFp74GDigJ6OwgmL+7JNNe2VCbuyS/Aw32KLbxA2+WcQhEayzV9
         xgdkL+wzClFNIVhnogRI30f3Ro7K9aBoUz+WQ19y9cWXHfDe2gaaTuUE+ycmSGb5L8JZ
         DdsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=whtV4mfvH1NLVqepuQoF5mH+azqIMtCQpWr7A8sgds8=;
        b=t4f9c2xfOvFEvPuV0M/qHY9pxlRRtF/eLfcq2pULikhI9d4heEU0EpaVKwyhivXGev
         KmafJ6DuLdMnqbke1ueLDhQ7HkHR1duphF9cUtKR6XaSrHX0NH2VGbeTHDA7h0bRqV1w
         1VXTAR9C7pHJEQAgDr8sUBzsDdrPwfIADhh4Mqlb2aIIZ+5DjLco1zSkXZWwez/G5xzG
         2M6MPGqiDpxXfAnlONreubmDXhrdhCwVI3SINw+8q1CTLszbumUW10iV5prYVbKXEHV1
         9u00NnoP88fDqGQb+SXhNCFmYyOyQTJWyLK6O2yS0JUWSxSX7O/q2zCGQJ9D2gYKT7e0
         3RSg==
X-Gm-Message-State: AOAM530U8U8vsUB6IVZTbfN/QpvjClCkrQGCKBQHwyfR+7ET2eYt6XK6
        NmZl69TitFVDsiBB4cjRBgYy1Pk0S25O2++8PS0=
X-Google-Smtp-Source: ABdhPJyV/25oXu9weIAPEu81AwyV5yGPI5+pU6NMDGYNq7Am9/WGIHp7CTHevGSEs3uixH6nBSuOxQ==
X-Received: by 2002:a2e:991a:: with SMTP id v26mr1103580lji.111.1630561478507;
        Wed, 01 Sep 2021 22:44:38 -0700 (PDT)
Received: from [10.0.0.115] (91-155-111-71.elisa-laajakaista.fi. [91.155.111.71])
        by smtp.gmail.com with ESMTPSA id t12sm91315lfg.151.2021.09.01.22.44.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 22:44:37 -0700 (PDT)
Subject: Re: [PATCH] ASoC: ti: rename CONFIG_SND_SOC_DM365_VOICE_CODEC_MODULE
To:     Masahiro Yamada <masahiroy@kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        linux-kernel@vger.kernel.org
References: <20210901164009.1546967-1-masahiroy@kernel.org>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Message-ID: <2f5d4845-631c-525f-c624-c41bd71f5815@gmail.com>
Date:   Thu, 2 Sep 2021 08:44:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210901164009.1546967-1-masahiroy@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/09/2021 19:40, Masahiro Yamada wrote:
> Kconfig generates include/generated/autoconf.h to make CONFIG options
> available to the pre-processor. Symbols with the value 'm' are suffixed
> with '_MODULE'
> 
> Here is a conflict; CONFIG_FOO=m results in '#define CONFIG_FOO_MODULE 1',
> but CONFIG_FOO_MODULE=y also results in the same define.
> 
> Also, CONFIG options that end with '_MODULE' confuse the Kconfig/fixdep
> interaction; fixdep always assumes CONFIG_FOO_MODULE comes from
> CONFIG_FOO=m, so the dependency is not properly tracked for symbols
> that end with '_MODULE'.
> 
> For these reasons, CONFIG options that end with '_MODULE' should be
> avoided in general. (I am planning on adding a check in Kconfig.)
> 
> This is the only case in the current kernel.
> 
> The new option name was suggested by Péter Ujfalusi. [1]
> 
> [1] https://lore.kernel.org/all/d9e777dc-d274-92ee-4d77-711bfd553611@gmail.com/
> 
> Fixes: 147162f57515 ("ASoC: ti: fix SND_SOC_DM365_VOICE_CODEC dependencies")
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Thank you,

Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> ---
> 
>  sound/soc/ti/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/ti/Kconfig b/sound/soc/ti/Kconfig
> index 698d7bc84dcf..3260a30d3d54 100644
> --- a/sound/soc/ti/Kconfig
> +++ b/sound/soc/ti/Kconfig
> @@ -211,7 +211,7 @@ config SND_SOC_DM365_VOICE_CODEC
>  	  Say Y if you want to add support for SoC On-chip voice codec
>  endchoice
>  
> -config SND_SOC_DM365_VOICE_CODEC_MODULE
> +config SND_SOC_DM365_SELECT_VOICE_CODECS
>  	def_tristate y
>  	depends on SND_SOC_DM365_VOICE_CODEC && SND_SOC
>  	select MFD_DAVINCI_VOICECODEC
> 

-- 
Péter
