Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67BD2363990
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 05:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237332AbhDSDCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 23:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbhDSDCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 23:02:43 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6803EC06174A
        for <linux-kernel@vger.kernel.org>; Sun, 18 Apr 2021 20:02:14 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 101-20020a9d0d6e0000b02902816815ff62so25377917oti.9
        for <linux-kernel@vger.kernel.org>; Sun, 18 Apr 2021 20:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7wC8QKTZ9xEtfwhjX+LEpEPMChmLBOlIJZB30u0tbsA=;
        b=Uvdz1wJBOBjBaXaPv6ZIzSTvt21UnnYo9XTaOjEIipgENy1+TkdxAELnu9I11RV3xM
         ewyJmzytDcNgT0mul+pu7uItN8CdSU0E/OjJl+I1o6I5xYNGRQoBoeBNB83BaTVFo4L9
         mLIzUbdEVt9YMoHLINVWGKECJeFo0k69soG2KxlBR9CwMULm/A3kbLuWd2+If5kXjRr+
         t/xurUh2hYvGMqSksLyPOOSJaTNb5C3T1u1z/7L9O8d2Dt8DaWMXmPsucKpdiqutgbKo
         MhqqRyVCR9Bs2wQ4VdiUebeSUJiRI5x2zoqDKcfc0YLZlL5YwGJ0eVaiTZ0ZBk5n6L2o
         1wAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7wC8QKTZ9xEtfwhjX+LEpEPMChmLBOlIJZB30u0tbsA=;
        b=DT6xS7btQ4v2Q7EBRAqt8GCtObyOKGF8Mr8OPrAdknu8v0yECPIcYMcEcLTY9Dzxcu
         YPYFS9MqY/x9d3VJmzS1azWuRZF5DN6BWaFwGFf50YGyHXWCL+BXZ2dbgAQaV0vYifBi
         VgVCBSvUHpleBqHw+tbFDnR/OTIuRGxP030JxilP1xMP7BduViiRBX77l/E7avQttBSW
         T3lI5fP1DUuGxYM8/RODPxErNsmM06KkrVy7IHxunbvBN56aQqsaX206vNGbeutoG392
         +41JhRBpc1lL57EZFQLeZ8Gg6gOtbhTw9F600Ev+bZ3PpTdPmISUjaw3sQA9MCuOtb/s
         0pDw==
X-Gm-Message-State: AOAM530Yzv14Qm2PAjh+IWouWYnuF0gUZeRqvU92LvgCRe90R3b6i5AV
        X6lDvSv4jwH+NEgJwNQnofrvIw==
X-Google-Smtp-Source: ABdhPJxVKdpll0qVOlEiXZSl3AiLgR5ik1EzcgMRAExmmeNOHf0qqRZ5lcvvMZI/VPmYGynZ1uHgng==
X-Received: by 2002:a9d:5541:: with SMTP id h1mr12472367oti.246.1618801333755;
        Sun, 18 Apr 2021 20:02:13 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id a6sm2863108oiw.44.2021.04.18.20.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Apr 2021 20:02:13 -0700 (PDT)
Date:   Sun, 18 Apr 2021 22:02:11 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [Patch v2 1/7] crypto: qce: common: Add MAC failed error checking
Message-ID: <20210419030211.GI1538589@yoga>
References: <20210417132503.1401128-1-thara.gopinath@linaro.org>
 <20210417132503.1401128-2-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210417132503.1401128-2-thara.gopinath@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 17 Apr 08:24 CDT 2021, Thara Gopinath wrote:

> MAC_FAILED gets set in the status register if authenthication fails
> for ccm algorithms(during decryption). Add support to catch and flag
> this error.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
> 
> v1->v2:
> 	- Split the error checking for -ENXIO and -EBADMSG into if-else clause
> 	  so that the code is more readable as per Bjorn's review comment.
> 
>  drivers/crypto/qce/common.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/crypto/qce/common.c b/drivers/crypto/qce/common.c
> index dceb9579d87a..dd76175d5c62 100644
> --- a/drivers/crypto/qce/common.c
> +++ b/drivers/crypto/qce/common.c
> @@ -419,6 +419,8 @@ int qce_check_status(struct qce_device *qce, u32 *status)
>  	 */
>  	if (*status & STATUS_ERRORS || !(*status & BIT(OPERATION_DONE_SHIFT)))
>  		ret = -ENXIO;
> +	else if (*status & BIT(MAC_FAILED_SHIFT))
> +		ret = -EBADMSG;
>  
>  	return ret;
>  }
> -- 
> 2.25.1
> 
