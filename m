Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE8E3354897
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 00:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241462AbhDEWX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 18:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236072AbhDEWXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 18:23:25 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367AAC061788
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 15:23:17 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id i3so13069926oik.7
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 15:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ky3Mb7bPQtqaP2BIFct2mjgskwKoT25u7uZeAyvH+30=;
        b=pNFbmgXu918kaPLZI7ByrZ7NFY23efWQ9FbUs+DKyyNFEQ11dsaJ8B36Fjn1lrW7iF
         kUsVEGZwz+ncH2/scECwQEsP6QXZnzLlONdswe/tiYWz54iUrVzrZ03lHIf8cgmBZfHZ
         uR55PpPOuva7JXoQ/4fa2Vy3YJ33R11ACLdRF++nJ7yS1t+r8B1kstFaxmZdozASr+Oq
         ajuN+gQbNhiUi/np4eh9QdJ9wwRQ8HnNc3apdQnoXBOyX4BNCsW8R7NceTcW4yYBdS1R
         kyKmerRFSmFSxd5aUrIAHPlZ2YxqYMwbN1umm1dkuFJJ243kcjE86AAr7FcDZMpjjMKd
         OF0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ky3Mb7bPQtqaP2BIFct2mjgskwKoT25u7uZeAyvH+30=;
        b=eW/Yy51neNkIYKe4YnYNO5svUjavzuOdjwu/GGjbwvhkT/Kt6vcrPhZ8Oi5RecB/Vd
         lI8iyQ+vf1agizn+NcFREgjaxkTZ3lCZZiBiM9GXyyO4ykJgv3ugjT8uraOfkN+of8lx
         1oN+0y8bhyc1rcK4o4vczTDLX09bwxqMnMe3ggbFW50vR0qzhD9Tkg2+zcWYdgxd5r5e
         1ExdnsXBpOULjG9mWN6+ZdteFaH5l9lIZcg4AHZ46gew86V6Ld9SVdYHNBIeXc1WdBvu
         FFzuH1JOjou5lHUEOELWEUBtjKKoigr/SfMeHbbLNwFM+R0viwicfTpekpqiWWnSTCc+
         cfzQ==
X-Gm-Message-State: AOAM532r+JqPhW6Yh5qFp0etf5WKwNzSHbb7I+EjkrjfOkovLpkzdogE
        kMn1ODSB9GdUmRYvig6zkGtc0g==
X-Google-Smtp-Source: ABdhPJwWmJZu+Tz7ftUhVSI3sG478q8f8K40hmLekySf3zqgRbClQ76HEcKl28tf+pzu/0PINkOEHw==
X-Received: by 2002:a05:6808:483:: with SMTP id z3mr953203oid.166.1617661396524;
        Mon, 05 Apr 2021 15:23:16 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id v65sm3351764oib.42.2021.04.05.15.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 15:23:16 -0700 (PDT)
Date:   Mon, 5 Apr 2021 17:23:13 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] crypto: qce: common: Make result dump optional
Message-ID: <20210405222313.GB904837@yoga>
References: <20210225182716.1402449-1-thara.gopinath@linaro.org>
 <20210225182716.1402449-3-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225182716.1402449-3-thara.gopinath@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 25 Feb 12:27 CST 2021, Thara Gopinath wrote:

> Qualcomm crypto engine allows for IV registers and status register
> to be concatenated to the output. This option is enabled by setting the
> RESULTS_DUMP field in GOPROC  register. This is useful for most of the
> algorithms to either retrieve status of operation or in case of
> authentication algorithms to retrieve the mac. But for ccm
> algorithms, the mac is part of the output stream and not retrieved
> from the IV registers, thus needing a separate buffer to retrieve it.
> Make enabling RESULTS_DUMP field optional so that algorithms can choose
> whether or not to enable the option.
> Note that in this patch, the enabled algorithms always choose
> RESULTS_DUMP to be enabled. But later with the introduction of ccm
> algorithms, this changes.
> 
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/crypto/qce/common.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/crypto/qce/common.c b/drivers/crypto/qce/common.c
> index 7c3cb483749e..2485aa371d83 100644
> --- a/drivers/crypto/qce/common.c
> +++ b/drivers/crypto/qce/common.c
> @@ -88,9 +88,12 @@ static void qce_setup_config(struct qce_device *qce)
>  	qce_write(qce, REG_CONFIG, config);
>  }
>  
> -static inline void qce_crypto_go(struct qce_device *qce)
> +static inline void qce_crypto_go(struct qce_device *qce, bool result_dump)
>  {
> -	qce_write(qce, REG_GOPROC, BIT(GO_SHIFT) | BIT(RESULTS_DUMP_SHIFT));
> +	if (result_dump)
> +		qce_write(qce, REG_GOPROC, BIT(GO_SHIFT) | BIT(RESULTS_DUMP_SHIFT));
> +	else
> +		qce_write(qce, REG_GOPROC, BIT(GO_SHIFT));
>  }
>  
>  #ifdef CONFIG_CRYPTO_DEV_QCE_SHA
> @@ -219,7 +222,7 @@ static int qce_setup_regs_ahash(struct crypto_async_request *async_req)
>  	config = qce_config_reg(qce, 1);
>  	qce_write(qce, REG_CONFIG, config);
>  
> -	qce_crypto_go(qce);
> +	qce_crypto_go(qce, true);
>  
>  	return 0;
>  }
> @@ -380,7 +383,7 @@ static int qce_setup_regs_skcipher(struct crypto_async_request *async_req)
>  	config = qce_config_reg(qce, 1);
>  	qce_write(qce, REG_CONFIG, config);
>  
> -	qce_crypto_go(qce);
> +	qce_crypto_go(qce, true);
>  
>  	return 0;
>  }
> -- 
> 2.25.1
> 
