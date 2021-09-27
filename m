Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1BD64192AB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 13:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbhI0LCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 07:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233903AbhI0LC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 07:02:26 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D25C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 04:00:48 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id s24so114732wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 04:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XRPjobKyc5ikQATTaoAB7Ef8aUh+iksQjqZVpv1jq0M=;
        b=NhQBnKK7mtJZsLT0zSi+otuLrck7DozDRVmMoSvgzMD93dzVcJOKzGYhZxIjH4Me/7
         0Du+8TL/5Zv7xbbGINbEKEr3BlW2T1WtrKDtIxtHwrCWrT1kTf2fvkY0Lkw5Ix/m7wLD
         qgi7LDb45wt2PtYD7GCfsz2zurrBUaZRZnv7e74kb/1JkfaST+mzzlaFg9qNniw/NEg3
         uo3VJkpdIImegi8yjsYhVZbQ+dlKIUEH0N1PclJgtSxmKM3IS3DjqGmB8gHutPGAPfoP
         n+mmVrXB5N6PXNTlSz1wjhNfKwdx/7GK1+CvLRehLUY0ETXlI16Ufwcl5Rs+GX+f1b7F
         FtJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XRPjobKyc5ikQATTaoAB7Ef8aUh+iksQjqZVpv1jq0M=;
        b=lVEq3YtwVdsBM6GY0wRB+qmkvBqufsiSYl+O7HMb1jbMdsHC8knfgp14A/nZtuSpKC
         gdIhnpklHWs4FdguNPN4DAJ9w9Sxv3kHrS66F7pWTuQBxD2UnjSUcgQ+ZP9+p+t8BsOB
         U9eGOqTbk+IFp0yWOv2sNMo1NCgw5cEv3Q4/xpkCkgz03SNJaOAKPsB5OLhDri977X99
         flJE4HKdJt8A6ZAOSb2+uUaZOi/wC/jEOM3nI0j5aSFphmyg/3pzVGcRbSYkLAhGXkMy
         oFJwxm1VJW9uIgrY8ZdpsB+Ts1NPysfhdtETlSu6ZzlJmmgj5UBPd2UNMG+YKVzEjhEt
         dnEQ==
X-Gm-Message-State: AOAM531KQcYVcFw4QBWddFXMR93E08LDiJCIOq3y1y/wmqJp3PQGrqKk
        IZJHrxE+8NLGj1XsLR74eOc/Bu5r3UTZhQ==
X-Google-Smtp-Source: ABdhPJxdLf3oTwzJd3Le+/Za8FBBJicKwqsOBTFqoxg/0i9px3fsuAJIV0kgo6XJ5xIUB6tdqPE/4A==
X-Received: by 2002:a05:600c:aca:: with SMTP id c10mr15023179wmr.174.1632740447259;
        Mon, 27 Sep 2021 04:00:47 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id j14sm16114810wrp.21.2021.09.27.04.00.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 04:00:46 -0700 (PDT)
Subject: Re: [PATCH] ASoC: wcd9335: Use correct version to initialize Class H
To:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20210925022339.786296-1-y.oudjana@protonmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <43d70ca3-bd14-c83a-12df-8cd64056256a@linaro.org>
Date:   Mon, 27 Sep 2021 12:00:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210925022339.786296-1-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/09/2021 03:24, Yassine Oudjana wrote:
> The versioning scheme was changed in an earlier patch, which caused the version
> being used to initialize WCD9335 to be interpreted as if it was WCD937X, which
> changed code paths causing broken headphones output. Pass WCD9335 instead of
> WCD9335_VERSION_2_0 to wcd_clsh_ctrl_alloc to fix it.
> 
> Fixes: 19c5d1f6a0c3 ("ASoC: codecs: wcd-clsh: add new version support")
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---

Thanks for the fix,

LGTM,

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

--srini


>   sound/soc/codecs/wcd9335.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
> index d885ced34f60..bc5d68c53e5a 100644
> --- a/sound/soc/codecs/wcd9335.c
> +++ b/sound/soc/codecs/wcd9335.c
> @@ -4859,7 +4859,7 @@ static int wcd9335_codec_probe(struct snd_soc_component *component)
>   
>   	snd_soc_component_init_regmap(component, wcd->regmap);
>   	/* Class-H Init*/
> -	wcd->clsh_ctrl = wcd_clsh_ctrl_alloc(component, wcd->version);
> +	wcd->clsh_ctrl = wcd_clsh_ctrl_alloc(component, WCD9335);
>   	if (IS_ERR(wcd->clsh_ctrl))
>   		return PTR_ERR(wcd->clsh_ctrl);
>   
> 
