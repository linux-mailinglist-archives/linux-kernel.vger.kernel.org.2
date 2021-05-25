Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1BC3907AC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 19:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbhEYRay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 13:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbhEYRav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 13:30:51 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5761DC061756
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 10:29:20 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id q15so23288299pgg.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 10:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c1te1fmETHKIo/3PXTYiGotWvN1fuCwdsljvLwzWe+U=;
        b=mJmGP2FKoCUVm6+tCyuoComU94tA6XL0a4R+34I0aN641K+/qGPNewC70RrBwNYeLS
         fzv5aUMrbTS+o+sTSkPJ+mePf1s3kP9cIS9JcAgZIdfDCH1BDFhtpwVNMMRanzz8zQq0
         BbSdOT7QAE5ZkobtNdILsQe1pVvb6KR9fEOYFeT649qVlSJa0F0ZWXgOkE0IZi5qgpY9
         1PNRPwGlZa1b0nSIYqvGjO9xR/+eZP30wZ4wodXz2Nli7p7CcNTWakLxdari5xT7rctB
         e4dSh+BLHefbAGtvH59WKXDneoOTgh0pBNm9Y0QBlXFQrlbqaU1fUN999MT6TP/6dAyi
         XBOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c1te1fmETHKIo/3PXTYiGotWvN1fuCwdsljvLwzWe+U=;
        b=KxoDopa+xN9fAhua7pS1AKkKrx18DKnzb1SKyzSebCbSXELIWdKYaIH5IOna9n9RDf
         +6V7K5DdP6tyya0IqAudX00ZTuCrACNCqEpsJNvVQkifu3l3vt0RpSkwAKXxyD0uQNTV
         7XTKhatb6AqmfaeQriXFVsw1nuaXBdPeqs+TyNeUMo3bTdxuVnkoSwAmsSBGo5D5UA02
         hgo5eZTORaVOxkw7wgQ1YVJ+c2f/SuuTk1zz1cL29h5sTdAGN1B1d9w/FO9r0xVauogI
         nGPsuWWN5OMy7qJmiitFX47et6Pcen12IIBq/Bu04zqXtEfoMwD2Sj97ZhkMDIj5moAe
         Q+Qg==
X-Gm-Message-State: AOAM530+7ed2jrbwf/Uq7p0vkQRZ7CHRKekzevtncqiFDLT7QbuvIDlQ
        rZAHpEqC6lxSubkTxTxRdRLhQw==
X-Google-Smtp-Source: ABdhPJzTx6EvBIS+w3v6j8IhihjLGhwWbR+/AvLMKzy9ad3ht9mD5pnphdwupzdU8DBi2XWRaTYd+w==
X-Received: by 2002:a63:3c0e:: with SMTP id j14mr20301393pga.427.1621963759884;
        Tue, 25 May 2021 10:29:19 -0700 (PDT)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id ge5sm2681961pjb.45.2021.05.25.10.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 10:29:18 -0700 (PDT)
Date:   Tue, 25 May 2021 11:29:17 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v4 1/4] rpmsg: char: Remove useless include
Message-ID: <20210525172917.GA1113058@xps15>
References: <20210517171531.21205-1-arnaud.pouliquen@foss.st.com>
 <20210517171531.21205-2-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517171531.21205-2-arnaud.pouliquen@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 07:15:28PM +0200, Arnaud Pouliquen wrote:
> No facility requests the include of rpmsg_internal.h header file.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
>  drivers/rpmsg/rpmsg_char.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
> index 2bebc9b2d163..b5907b80727c 100644
> --- a/drivers/rpmsg/rpmsg_char.c
> +++ b/drivers/rpmsg/rpmsg_char.c
> @@ -22,8 +22,6 @@
>  #include <linux/uaccess.h>
>  #include <uapi/linux/rpmsg.h>
>  
> -#include "rpmsg_internal.h"
> -
>  #define RPMSG_DEV_MAX	(MINORMASK + 1)

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  
>  static dev_t rpmsg_major;
> -- 
> 2.17.1
> 
