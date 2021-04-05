Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 683853548A1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 00:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242804AbhDEWdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 18:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233086AbhDEWc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 18:32:57 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA79C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 15:32:50 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id g8-20020a9d6c480000b02901b65ca2432cso12811256otq.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 15:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yjPJwTgEEcZdNSuKzyQlQgPz3fsRy1o33yFNzxrrfac=;
        b=xAXIV4X/g6BfggIfAFOUMGYh4Qis6ID9Rp+nCu/5HpbbtRmk6sgPyzhuH4imjBuSuc
         fkAoiT0P5ZaihDOaUgy8Us/d+uAMpOK4jdAmqB2Z60vp6DcHXNtN5CjXKR6SCbXdUzpB
         wurVZZTQpQRh0/laCKet/OfkyPE/OLoYGkRlq6YYKnckWX8e55KmI6svRADScEezsa6U
         PJOzu214E5nYo4x13XzJfhBaDzFGPm/TwUKxX101NWVuwyCpLaJ+5t475irN19ApFsx3
         usqcx8L95XSar3XRjpLBWl+4Ugbm2eL46ndGRWW4TjTmSevdo5Ow/5+1MBkw5Re60gj0
         hu6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yjPJwTgEEcZdNSuKzyQlQgPz3fsRy1o33yFNzxrrfac=;
        b=mrkVABRUqkRip6D35cl12pdiBCSyynmLmbWfQgT3vWqnrthWFwpjMy3Tgsgdwdv8ad
         Lv2FsvsHdE5T7h1Arff4/158CX3KU15f7hiT7PVHW0DPoFADK7XlmYwwISyHbc0olZzg
         4HlVsefCwdjSwAetT8vbyVPxRLcH/MEqMu3KxlNVrRBWnUc1dSUPuvI/38Z0oxiHtC74
         lZw5Ni8ZqFUlZ03wLyJKf/FnidA15AIM704dLf0cZyWD5sQxK/rvJRoekeAP3xO3L7vt
         I0ZwgXkI/YqqnxOEjuEVNSycIQrdx616+v4gEhEw8jlBISWuPjF8ZhRdUDP0J5LeveJM
         cJow==
X-Gm-Message-State: AOAM533KoE80G4zcv/CfASUOE2njyMDpxMPVS8Q4hDo5uTswnVRXLTHY
        gBYZiq89r9ZMzYJB/GNPNK49IA==
X-Google-Smtp-Source: ABdhPJw8JfV6bWrAR19dcf37Wd/Jg1+1EQEokY3+VsHwPAew4dvfVPqK2ZNPlzNagWez4h8f76SNNA==
X-Received: by 2002:a05:6830:2248:: with SMTP id t8mr23660323otd.211.1617661970066;
        Mon, 05 Apr 2021 15:32:50 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id z14sm3293523oid.12.2021.04.05.15.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 15:32:49 -0700 (PDT)
Date:   Mon, 5 Apr 2021 17:32:47 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] crypto: qce: Add mode for rfc4309
Message-ID: <20210405223247.GC904837@yoga>
References: <20210225182716.1402449-1-thara.gopinath@linaro.org>
 <20210225182716.1402449-4-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225182716.1402449-4-thara.gopinath@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 25 Feb 12:27 CST 2021, Thara Gopinath wrote:

> rf4309 is the specification that uses aes ccm algorithms with IPsec
> security packets. Add a submode to identify rfc4309 ccm(aes) algorithm
> in the crypto driver.
> 
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>  drivers/crypto/qce/common.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/crypto/qce/common.h b/drivers/crypto/qce/common.h
> index 3bc244bcca2d..3ffe719b79e4 100644
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
> +#define QCE_ENCRYPT			BIT(14)
> +#define QCE_DECRYPT			BIT(15)

Can't we move these further up, so that next time we want to add
something it doesn't require that we also move the ENC/DEC bits?

>  
>  #define IS_DES(flags)			(flags & QCE_ALG_DES)
>  #define IS_3DES(flags)			(flags & QCE_ALG_3DES)
> @@ -73,6 +75,7 @@
>  #define IS_CTR(mode)			(mode & QCE_MODE_CTR)
>  #define IS_XTS(mode)			(mode & QCE_MODE_XTS)
>  #define IS_CCM(mode)			(mode & QCE_MODE_CCM)
> +#define IS_CCM_RFC4309(mode)		((mode) & QCE_MODE_CCM_RFC4309)

While leaving room for the typical macro issues, none of the other
macros wrap the argument in parenthesis. Please follow the style of the
driver, and perhaps follow up with a cleanup patch that just wraps them
all in parenthesis?

Regards,
Bjorn

>  
>  #define IS_ENCRYPT(dir)			(dir & QCE_ENCRYPT)
>  #define IS_DECRYPT(dir)			(dir & QCE_DECRYPT)
> -- 
> 2.25.1
> 
