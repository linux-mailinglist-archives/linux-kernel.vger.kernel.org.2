Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDCE43B69EE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 22:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237512AbhF1U63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 16:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237324AbhF1U6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 16:58:24 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26E0C061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 13:55:58 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id x16so15218314pfa.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 13:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Mb3LYqy4tYD5twHKe5/2sd9B60PMKocbZfeTltPQ2BA=;
        b=WoMDjJl05tWoY3t7FXLznAV+bl/f6pLz4aarqzGr13/vJAPKaCxvZL67tRZ/YyXDQK
         9Lfmzgk1eSp/x8IPsTQZpkaXBQoCVI/VKTMB5MMnIE+yXPAGWiNsiTS4MDMoVUyk3U88
         OG+0y5jxaQO9t0xj6a1Umh0mmutPOFBWj6SeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Mb3LYqy4tYD5twHKe5/2sd9B60PMKocbZfeTltPQ2BA=;
        b=k2yW5IN70ghqyztpybDMbYDaa3Eq5U0pYHj2CWh7sWI+j+9+NiUVsYTt2wXsKR6eiW
         lzA1B8ry7FUPyIy1+i1Z1spSQjPYjBwEHWpbzUJlvC78VPXUPrwFgFxgPLVufa/xC1Wl
         xATJt/AgtgjTxCLXpIEYrpuDc4gEw8fBASkaCAmalts3fhph8riICkHcIGf9hNZMAowm
         ZLZiL/rsn21nJJxFb90NMPrU+qBoLlvUJVF/BJHocEpSmZE5vJlkDSLsJVCAXb3/Ihc9
         pQChvg1kVFxRFpyG8V0DaJWOErqHEa6qH2PLglFdlIIPIHF2EJ8mg8OnEvmmTMPSim1G
         Xazg==
X-Gm-Message-State: AOAM530WUjF8QoJrBcPkaOaS+J5O5/hf39SiL89O1GADicSBdshD2DEe
        n7GjO8wcO/vnZvI8r9l6yYnACnNmq5RSXw==
X-Google-Smtp-Source: ABdhPJzz2Q5BWj5HcfRU5luan48X8U8Ub4ra1oEA1Wtzyo2swVZR+LOj24GVC6RH2OnD7ufNiwcjaw==
X-Received: by 2002:aa7:9436:0:b029:30b:30ba:5942 with SMTP id y22-20020aa794360000b029030b30ba5942mr11026196pfo.47.1624913758326;
        Mon, 28 Jun 2021 13:55:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j20sm14572965pfc.85.2021.06.28.13.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 13:55:57 -0700 (PDT)
Date:   Mon, 28 Jun 2021 13:55:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lkdtm: remove duplicated include of init.h
Message-ID: <202106281355.3FEE09E@keescook>
References: <20210628123512.38090-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628123512.38090-1-wanjiabing@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2021 at 08:35:12PM +0800, Wan Jiabing wrote:
> Fix following checkincludes.pl warning:
> ./drivers/misc/lkdtm/core.c
> 26	#include <linux/init.h>
>     29	#include <linux/init.h>
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>

Whoops! Thank you. :)

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/misc/lkdtm/core.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
> index 9dda87c6b54a..c9a0ad6d5d72 100644
> --- a/drivers/misc/lkdtm/core.c
> +++ b/drivers/misc/lkdtm/core.c
> @@ -26,7 +26,6 @@
>  #include <linux/init.h>
>  #include <linux/slab.h>
>  #include <linux/debugfs.h>
> -#include <linux/init.h>
>  
>  #define DEFAULT_COUNT 10
>  
> -- 
> 2.20.1
> 

-- 
Kees Cook
