Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6213FBA47
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 18:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237836AbhH3Qnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 12:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237049AbhH3Qno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 12:43:44 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1424C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 09:42:50 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id o16-20020a9d2210000000b0051b1e56c98fso19139548ota.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 09:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Fg2HLpc/Y8p5q8laKLvVJ4xOF+tJpAooiTCrFY/pd6I=;
        b=Z2D6bmYnq2AdDuS4av1I2bsitXQ/9yS5Atvo/sSrCmIh+WxevwJHL1st3uHQJ5WZTF
         qtVoD563PzsxSiXgsYnyGlWN+DPEd4URtAbuquCsqaEaa6NM8H/JGBtbNDDhFJuSQEK2
         YWoSaYeVjXcICkP7bbqAiP0bS5TyzajwN6tDA/GfBsIhOrccGl+WuGWUv+DSKqgybZ1G
         VoFxJAArNu7m/1fZIjAl8HB/MMkdZ2KpT48/MtUvWKMctYak7dVCGOHKWOcD42sfy25X
         4FxXue1lU6jwXICH9sDFp3mlD9geD9cewwFRRgPNwNz+joO9Myw2Xh8xsn82L9a6eGWj
         DCkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Fg2HLpc/Y8p5q8laKLvVJ4xOF+tJpAooiTCrFY/pd6I=;
        b=A4KphBePpnUAhUp15T4NR60jeGT6OYMI9dcyppCyYN9rd+nwupgitXEbeUtJFz7XGM
         jLl11taujjnyoSNe34ajF6jPQ64Mx1qCR864+r5DljdPeG/MYT/J1luUP/zv9oo4QIo8
         /OJ6j5nuop8oaocNVpacUxuuq3osaZmn/W2EKM2AGsyyEtFnH961YBHoMktqJ3oR4HMm
         +hojw53XstJLte/g5n8ZSVIa/5l3YWHC7TRULZ1qInb0v0do1DSZInGvE80NdD6r1JSB
         k/JkAeaiDII1Z4e99Sd6unCWWC5N5i7Yb3KMTvI8rSL3C8huJku9IHj/54ibt1ZJx42C
         p/rA==
X-Gm-Message-State: AOAM530lly8EGQ3MRPbVwIlaVJHXYOSg5RK+xPv8q/uMrjFhuqsBanTz
        +PHn9m60pmXXsC+zAGU0u+NCfnP1LwKODw==
X-Google-Smtp-Source: ABdhPJyvKta1OiYK3+e/w+DuP1uVKJNNfWDs2FGCaFcRX82bigZprGpqn1FKCFOU3Tzsi0bSiZnRmg==
X-Received: by 2002:a05:6830:4196:: with SMTP id r22mr21340006otu.231.1630341770017;
        Mon, 30 Aug 2021 09:42:50 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id u18sm3009253ooi.40.2021.08.30.09.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 09:42:49 -0700 (PDT)
Date:   Mon, 30 Aug 2021 11:42:47 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Niklas Cassel <nks@flawful.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmem: core: Add stubs for
 nvmem_cell_read_variable_le_u32/64 if !CONFIG_NVMEM
Message-ID: <YS0Kh5ojnhuOZDer@yoga>
References: <20210830083449.1.I38e95343209fe1f808c3b4860795a00a2b539701@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210830083449.1.I38e95343209fe1f808c3b4860795a00a2b539701@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 30 Aug 10:35 CDT 2021, Douglas Anderson wrote:

> When I added nvmem_cell_read_variable_le_u32() and
> nvmem_cell_read_variable_le_u64() I forgot to add the "static inline"
> stub functions for when CONFIG_NVMEM wasn't defined. Add them
> now. This was causing problems with randconfig builds that compiled
> `drivers/soc/qcom/cpr.c`.
> 
> Fixes: 6feba6a62c57 ("PM: AVS: qcom-cpr: Use nvmem_cell_read_variable_le_u32()")
> Fixes: a28e824fb827 ("nvmem: core: Add functions to make number reading easy")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
> It might be handy if this commit could somehow end up in the SoC tree
> soon-ish to fix the build warning. I expect that the "qcom-cpr" patch
> will be part of the pull requests send in the next merge window and
> it'd be nice if we didn't end up with the build warning in -rc1.
> 

Right, CPR is about to break some builds in -rc1, so it would be nice to
get this in asap.

That said, the qcom pull is in the pipes already, so pushing it through
Srinivas tree will work just fine.

Thanks,
Bjorn

>  include/linux/nvmem-consumer.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
> index 923dada24eb4..c0c0cefc3b92 100644
> --- a/include/linux/nvmem-consumer.h
> +++ b/include/linux/nvmem-consumer.h
> @@ -150,6 +150,20 @@ static inline int nvmem_cell_read_u64(struct device *dev,
>  	return -EOPNOTSUPP;
>  }
>  
> +static inline int nvmem_cell_read_variable_le_u32(struct device *dev,
> +						 const char *cell_id,
> +						 u32 *val)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int nvmem_cell_read_variable_le_u64(struct device *dev,
> +						  const char *cell_id,
> +						  u64 *val)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>  static inline struct nvmem_device *nvmem_device_get(struct device *dev,
>  						    const char *name)
>  {
> -- 
> 2.33.0.259.gc128427fd7-goog
> 
