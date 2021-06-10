Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 039D33A31C6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 19:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbhFJRMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 13:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbhFJRMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 13:12:52 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2DFC061574
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 10:10:55 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id h12-20020a17090aa88cb029016400fd8ad8so4254266pjq.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 10:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fGe4DY8mKKnygk1FE1mf6upUstyZmptYOrEfvpk5Mh4=;
        b=mdhUfAb6YifrK82K1uc/PcW7Zxwk4vR3l4dsm8mWZeEkgaENHt8dNJfm9RlVGfAeFg
         HXWfyBTRkCAA8Sw4IU5MahyfcRsTv/7i7ZCIWQYC3dG698lzzVo/PsMeIyKPMhZEfBsb
         BteICrFlQFZxM6TsPbdHKk39bzZo97p/pLGzdq0hMwTd3yHSqFH0PS9iTeMImIX2OL8k
         kJkfTNlkVynbsIoVk10EyMZr7Y25M4buoHWx/ITZV395lRP6gJktiI3zgSmSUMMqFbaC
         3ZqEqdOqRYCsDJ8OWLH2tGhy++wUmUBZrwymWmqSBguSYnRrQZPQhIyIP334l1g9wSxW
         MC4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fGe4DY8mKKnygk1FE1mf6upUstyZmptYOrEfvpk5Mh4=;
        b=ahBIICxyJ800JPb+S4E5I7+IzZZqFfbRxJ8geHeG1KUjuC9IXOfdavNlONlRGWpI0i
         j316PIRncBNLqZMG0dqXKy+eDBiPU18tSfAYqokXEaq/cAlGtsu4CmamnWL6hsaXBxUd
         tpWAZk8m7il6mnrgFXLnXrtDiQFElkFmEwCnAP9MR0nXQQVP8Oxf9RhhDdk0qCvrIQyq
         K2LNOL+bFAk4IQ8rZLQrBWZJNrrd8ugl3euIweY70UwohFUHDZGcpESVKWerthL9PXAn
         3S4Appi3cyeituKilTjT3vbuotZ6HdEmiAsfLOy+mRASNnlEjIdkmQ/QqeJuwd/8Y7ua
         WKEw==
X-Gm-Message-State: AOAM530JHQC8ADppzyVYMtDnRo1AzYSqEZD80l5LOl+x2aD8zgnybDFT
        sGPSls4r/mv5JF50fJ/coOOJwQ==
X-Google-Smtp-Source: ABdhPJz7u6AlNLguXb+LpDc0K2GTrwuNFStkzdToNRbtHqF0bLOWIe1cPg3HAR319u2Dk5WLeiBA0g==
X-Received: by 2002:a17:90a:7c02:: with SMTP id v2mr4377021pjf.118.1623345055266;
        Thu, 10 Jun 2021 10:10:55 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id g6sm3010793pfq.110.2021.06.10.10.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 10:10:53 -0700 (PDT)
Date:   Thu, 10 Jun 2021 11:10:52 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] rpmsg: Fix rpmsg_create_ept return when RPMSG config is
 not defined
Message-ID: <20210610171052.GF34238@p14s>
References: <20210604160549.2122-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604160549.2122-1-arnaud.pouliquen@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 06:05:49PM +0200, Arnaud Pouliquen wrote:
> This is a minor fix.
> 
> According to the description of the rpmsg_create_ept in rpmsg_core.c
> the function should return NULL on error.
> 

You are correct, and none of the client return an error code either.

> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
>  include/linux/rpmsg.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
> index d97dcd049f18..a8dcf8a9ae88 100644
> --- a/include/linux/rpmsg.h
> +++ b/include/linux/rpmsg.h
> @@ -231,7 +231,7 @@ static inline struct rpmsg_endpoint *rpmsg_create_ept(struct rpmsg_device *rpdev
>  	/* This shouldn't be possible */
>  	WARN_ON(1);
>  
> -	return ERR_PTR(-ENXIO);
> +	return NULL;

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  }
>  
>  static inline int rpmsg_send(struct rpmsg_endpoint *ept, void *data, int len)
> -- 
> 2.17.1
> 
