Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDDC3820A2
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 21:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbhEPT0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 15:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbhEPT0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 15:26:17 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239D4C061573;
        Sun, 16 May 2021 12:25:02 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id j19so3441038qtp.7;
        Sun, 16 May 2021 12:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2qL4/0Z0j2EC7jbRRZzIaoh/R+YfUxEYzXyjEiPdLIw=;
        b=MHlJIQoKIs9FDmz5xDjmKZtttdAJPcjjYWGNoa2yp5EtWPNDemGFZTsumk7+WDqtRI
         9qzbmH9gyslbvtgyglH/sMERerS47EQLpi/iMC7fctQ68nxXM8hNvSGjq6WlzOTOH06m
         GRxU8XjE44sMeSYVsSq0j5fpBmDiTXoi38ErzDXPXskSuDXchNWGEqyRvh9gzQpWMrb1
         fK8sdBig/Yrf1RogdTYcqM6hGvE6fRN4BrF6Zy+b0W4Br3K8Enc+mjURoYO/6vQZNmhU
         9dYx5R5mOOFnFrRlus/uRuToJNNxZKJCDu4dNVFBxQMP5AYTz1YNkpEXLyLVr01myvNa
         ZS4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=2qL4/0Z0j2EC7jbRRZzIaoh/R+YfUxEYzXyjEiPdLIw=;
        b=dXr0ZbjSMycVOapBLySSSTiNCXyXkSwJnBJAQvzmQD+GvCMmkBLiprs4gosEh5vy0Q
         I451z3FsmxyAiIQVxXmoDVDsghWpAfgTvj6SteRtcsxcfM/IGPYKCUgucDQMbsk89tx1
         KpFxGQtWhGcAw4jBcCzRu/XDjzj5vrcbMv3s9wYkaE0K6FKiwXTEBwRw4o9BFU0i1aP1
         eq8RLn8EHKH9E5nuhcNP18XvEgL94bNuym9VR1NuyHoYfOdbTqJaywsRHUpRgl2ASLGN
         OP5h4H+wsQyLX2PvHemS1VCOjho6jeKOr3fV56IfyXZojnG2OZs9DpHA7QbFqS7QrO88
         KHJg==
X-Gm-Message-State: AOAM530ljs8IjDPg8r6/YmP+C3vszZwvvNpimy3pao1DPDifUh2OolL2
        z+vcTYBpOJB+TBMMYWcdFkb8UsyLp5Y=
X-Google-Smtp-Source: ABdhPJySW7oGInihkMTiq6GGDc4qKYHH9h1/OWMrzEJikC2X5P9mNZ7o6lRc0p7ulDGDt6AhuP4+7g==
X-Received: by 2002:ac8:67d3:: with SMTP id r19mr52674143qtp.23.1621193101413;
        Sun, 16 May 2021 12:25:01 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 7sm10061446qtu.38.2021.05.16.12.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 12:25:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 16 May 2021 12:24:59 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] staging: rtl8188eu: use safe iterator in
 rtw_free_xmitframe_queue
Message-ID: <20210516192459.GF2126643@roeck-us.net>
References: <20210516160613.30489-1-martin@kaiser.cx>
 <20210516160613.30489-6-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210516160613.30489-6-martin@kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 16, 2021 at 06:06:13PM +0200, Martin Kaiser wrote:
> Use list_for_each_safe, we may delete list items while iterating over
> the list.
> 
> Fixes: 23017c8842d2 ("staging: rtl8188eu: Use list iterators and helpers")
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> compile-tested only
> 
>  drivers/staging/rtl8188eu/core/rtw_xmit.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c b/drivers/staging/rtl8188eu/core/rtw_xmit.c
> index 3763d188b892..62b8f178280e 100644
> --- a/drivers/staging/rtl8188eu/core/rtw_xmit.c
> +++ b/drivers/staging/rtl8188eu/core/rtw_xmit.c
> @@ -1329,13 +1329,13 @@ s32 rtw_free_xmitframe(struct xmit_priv *pxmitpriv, struct xmit_frame *pxmitfram
>  
>  void rtw_free_xmitframe_queue(struct xmit_priv *pxmitpriv, struct __queue *pframequeue)
>  {
> -	struct list_head *plist, *phead;
> +	struct list_head *plist, *phead, *temp;
>  	struct	xmit_frame	*pxmitframe;
>  
>  	spin_lock_bh(&pframequeue->lock);
>  
>  	phead = get_list_head(pframequeue);
> -	list_for_each(plist, phead) {
> +	list_for_each_safe(plist, temp, phead) {
>  		pxmitframe = list_entry(plist, struct xmit_frame, list);
>  
>  		rtw_free_xmitframe(pxmitpriv, pxmitframe);
> -- 
> 2.20.1
> 
