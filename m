Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04EF430D8A1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 12:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbhBCL1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 06:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234301AbhBCLYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 06:24:43 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025DBC0613ED
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 03:24:03 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id q7so23752186wre.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 03:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Cw7UIydNqpTnPNbV9Dais44nPvIYJ47KoXAvHqGkryY=;
        b=HWw52il3iu9wL7OqkJttQDQGWCtAyonYBAhCxe/hnPMkHVk1zPWSifDqxe6gNJaSvf
         1TexbQktppsNld7d9+ONa4uBR1idm9hdcjtVxvBXQH73T2SneYH4x8jPUYkrYLF+jMrZ
         Opg3baywHqhO0PlmX3VuAZCOM98Mq8QrKOWtSQx3EJTZ0YaVxxxtwxzV+FEQtYmfa9ka
         aVMwvpTEbOENcY7ua4zPn5Ha4o205CWHZ6rEM00z/CqcBg1uuiE6f82oZKPCNj+JARg/
         Z6X6pGU0MaqNme+ljDbxac4buNc3XbD0P4ezZz9ILmgObsFqy8TRKYjrztAq1QFYHfp4
         z6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Cw7UIydNqpTnPNbV9Dais44nPvIYJ47KoXAvHqGkryY=;
        b=lAY/vAP+eKa1oX7HoxueIfI7k2SNXjCwmzn5chhaSab+PlEx6hasg5lo8+lN2y2XdW
         Y2uaGlolCbQRWrBfh+2Wena2+rkCSOUB/RHVJwy/LeoxpX03FMqAln8vnyjg3/K9jw5f
         v8Hz0Hr73wegR09UPOb9TPaxD8Uy6QwL6eFqpzs4Hf7tFp3uXM9sSZ20T6oVpx7Z5hPH
         vIyEdKZdpDPoh5+Da54iWq20TvFXuQ4jtxi3qy2/lA6OinbLQdSLh4rRtRNNQ1peLHUS
         Ut3wT4akW0LrDr4GmhJOBDleAqdG0S6p319udkWTbDqqO3lbVDjiMfHKNwYkUmHTpuHT
         8S+w==
X-Gm-Message-State: AOAM530FHz/F0bYCgcuFuvug3ZV0DD3+/xjOCki2v7T03B5+m95B3NQn
        8ilcdnZ5RKbdeBIu2CPlkPxA0L2JDI9B9g==
X-Google-Smtp-Source: ABdhPJzwXjlrTH8kNM50GBnKNvDqQJSZbArmyTMX9cF4llfTBsQ6uE0Q3W/8dJzLNwFTFoBS40t2Ew==
X-Received: by 2002:adf:ecd2:: with SMTP id s18mr2952704wro.311.1612351441721;
        Wed, 03 Feb 2021 03:24:01 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id j14sm3389443wrd.36.2021.02.03.03.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 03:24:00 -0800 (PST)
Date:   Wed, 3 Feb 2021 11:23:59 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     samirweng1979 <samirweng1979@163.com>
Cc:     jason.wessel@windriver.com, dianders@chromium.org,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        wengjianfeng <wengjianfeng@yulong.com>
Subject: Re: [PATCH] kernel: debug: fix typo issue
Message-ID: <20210203112359.cdy73gw4wip5cnyn@maple.lan>
References: <20210203081034.9004-1-samirweng1979@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203081034.9004-1-samirweng1979@163.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 04:10:34PM +0800, samirweng1979 wrote:
> From: wengjianfeng <wengjianfeng@yulong.com>
> 
> change 'regster' to 'register'.
> 
> Signed-off-by: wengjianfeng <wengjianfeng@yulong.com>

It looks like the Subject line might not be correct for this patch?

Is it really the first time this patch has been circulated or should it
have been tagged RESEND or v2?


Daniel.


> ---
>  kernel/debug/gdbstub.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/debug/gdbstub.c b/kernel/debug/gdbstub.c
> index a77df59..e149a0a 100644
> --- a/kernel/debug/gdbstub.c
> +++ b/kernel/debug/gdbstub.c
> @@ -595,7 +595,7 @@ static char *gdb_hex_reg_helper(int regnum, char *out)
>  			    dbg_reg_def[i].size);
>  }
>  
> -/* Handle the 'p' individual regster get */
> +/* Handle the 'p' individual register get */
>  static void gdb_cmd_reg_get(struct kgdb_state *ks)
>  {
>  	unsigned long regnum;
> @@ -610,7 +610,7 @@ static void gdb_cmd_reg_get(struct kgdb_state *ks)
>  	gdb_hex_reg_helper(regnum, remcom_out_buffer);
>  }
>  
> -/* Handle the 'P' individual regster set */
> +/* Handle the 'P' individual register set */
>  static void gdb_cmd_reg_set(struct kgdb_state *ks)
>  {
>  	unsigned long regnum;
> -- 
> 1.9.1
> 
> 
