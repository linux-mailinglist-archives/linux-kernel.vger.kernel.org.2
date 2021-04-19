Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84D76363993
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 05:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237342AbhDSDDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 23:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbhDSDDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 23:03:39 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD0BC06174A
        for <linux-kernel@vger.kernel.org>; Sun, 18 Apr 2021 20:03:10 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id n184so8096557oia.12
        for <linux-kernel@vger.kernel.org>; Sun, 18 Apr 2021 20:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bqnvfHSQYNF4pvJ4mjc+HwtWh0C16GYEE3A80983hxI=;
        b=B4ewnibF9EHh8ijqrdNx6zYdfJy2upFzbtR2KcxcPAQstGakUWk/Rj2RTbP8hpwDKP
         S5p/gEaCCt5F5PP6blgoi9l7aYSYdCLMVT2aUbmKS6oTuXw9MWycD3P6te4Bf5SDfHB3
         bTH5TZmVGW8K8dX3+/6LQh9nr0mNUNlNGZe/VCXInsfmP9Wef4C3W6W5QnHyX/9wIjpK
         6tWxkW32M1cJwvRjPTiQ8uxpNgr7UthwhTM7c+qVlC5hCd5zNxKj4kkK66QQDU+cHxpQ
         2NbEsKrC4kScpISxzxt93q1I0II0tMchCFdBNSNHE1PPP9hurBVNqe/j28Dyii53pUUr
         fuCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bqnvfHSQYNF4pvJ4mjc+HwtWh0C16GYEE3A80983hxI=;
        b=Tu4Qdb1vjVwZoaLv2tl71LYbDKHwsMdYausEVsDkabToRhfosC48UrGcD4FZvzGT7W
         cy1mqISKVNjXP5P4VQVmA0xT8OSKkZ07nb65Q6P+a1lHMAvsOTlNiYWcthiKlepl9Vx3
         gssvyO/lgLE+5Q2G+ySygZV1Nd7Z1gd3R4MAu0JZ5PhYYY8sB/infy4k7x8VnMZnJPDB
         10HBtSRD+7eD5Zv6Yz6tuLLtqrlbmYUoCyvjolrw8Nml0nzXfDTWPhos6rt1Tx1Q7iDZ
         1vRIOrYyiG3crEtjd99jLsEBBju9nX7f7Bp4sSpdsAyIxOarbyC2BnxdhTGDaOC7KJOm
         ji7g==
X-Gm-Message-State: AOAM531hrT4+NbAyvurQ9NUbHu0zs5Yx6LMjGN0MabO/lfgCfeZq9Wdl
        ZO58QRgpxZKsfiKppC1wt3S/1w==
X-Google-Smtp-Source: ABdhPJyICQDHV5hiccixkRQbqfwPNkvLfdThlqYZKYj5tImWfvauBoTI+1+1h39g1nRUIL+Z1SCeuw==
X-Received: by 2002:a05:6808:60f:: with SMTP id y15mr13917092oih.23.1618801389231;
        Sun, 18 Apr 2021 20:03:09 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id h25sm2656856oou.44.2021.04.18.20.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Apr 2021 20:03:08 -0700 (PDT)
Date:   Sun, 18 Apr 2021 22:03:05 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [Patch v2 3/7] crypto: qce: Add mode for rfc4309
Message-ID: <20210419030305.GJ1538589@yoga>
References: <20210417132503.1401128-1-thara.gopinath@linaro.org>
 <20210417132503.1401128-4-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210417132503.1401128-4-thara.gopinath@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 17 Apr 08:24 CDT 2021, Thara Gopinath wrote:

> rf4309 is the specification that uses aes ccm algorithms with IPsec
> security packets. Add a submode to identify rfc4309 ccm(aes) algorithm
> in the crypto driver.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
> 
> v1->v2:
> 	- Moved up the QCE_ENCRYPT AND QCE_DECRYPT bit positions so that
> 	  addition of other algorithms in future will not affect these
> 	  macros.
> 
>  drivers/crypto/qce/common.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/crypto/qce/common.h b/drivers/crypto/qce/common.h
> index 3bc244bcca2d..b135440bf72b 100644
> --- a/drivers/crypto/qce/common.h
> +++ b/drivers/crypto/qce/common.h
> @@ -51,9 +51,11 @@
>  #define QCE_MODE_CCM			BIT(12)
>  #define QCE_MODE_MASK			GENMASK(12, 8)
>  
> +#define QCE_MODE_CCM_RFC4309		BIT(13)
> +
>  /* cipher encryption/decryption operations */
> -#define QCE_ENCRYPT			BIT(13)
> -#define QCE_DECRYPT			BIT(14)
> +#define QCE_ENCRYPT			BIT(30)
> +#define QCE_DECRYPT			BIT(31)
>  
>  #define IS_DES(flags)			(flags & QCE_ALG_DES)
>  #define IS_3DES(flags)			(flags & QCE_ALG_3DES)
> @@ -73,6 +75,7 @@
>  #define IS_CTR(mode)			(mode & QCE_MODE_CTR)
>  #define IS_XTS(mode)			(mode & QCE_MODE_XTS)
>  #define IS_CCM(mode)			(mode & QCE_MODE_CCM)
> +#define IS_CCM_RFC4309(mode)		((mode) & QCE_MODE_CCM_RFC4309)
>  
>  #define IS_ENCRYPT(dir)			(dir & QCE_ENCRYPT)
>  #define IS_DECRYPT(dir)			(dir & QCE_DECRYPT)
> -- 
> 2.25.1
> 
