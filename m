Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 506F536E5DE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 09:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbhD2H1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 03:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbhD2H1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 03:27:13 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCB2C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 00:26:24 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id u3so19678907eja.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 00:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fKADZqVqSc0IQida3fCMkFkfc3lO4PjliPGIsHxxals=;
        b=AIjRR4E3nM59Xx7lq22qZifXk7zFyDH16ehnF8+kS+odSosc2HjT9yf6HLsME8yCZN
         3unezDVryQUxBu18wamkoKk96UfqcxfcLUhNgYeKbwhkhxtxokmrHBACYbg0YPmELa8H
         9icRo0oxhbE0Umgz9BWVN75nDycpXP0oF0lEIeZ/SGTHWeN/zOuYRTXwDS7ba9hm1LDo
         aqP4x6kk7eHJsA51LPiPvwNrNzGV/sOnaoNEQLDjPRf5V1IkJmGeZTKPdoH2ev4TbIrV
         pfC6oWgteX5fPnGT6SVvtLd38YPJjbFSq8mUO3pQ0MUwrWvUNgvncDU01gP4DozvxQps
         UjXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fKADZqVqSc0IQida3fCMkFkfc3lO4PjliPGIsHxxals=;
        b=MKm6N5udJkmofExoYKJESm8twjT9oFgDbbEz9CXgF6fpP+hn+nTKgvozsFPf/cIOkq
         EpyiL411KK5z98JERb6x5qrViwLqRNqeNSkgYG3Wf5wLphV7W2J0D0tCjjoIegE4tTi1
         Q//YxfUMkphCJAQh8APS72cHlWMTgwUyo+IpD3+cBcZ/USypDcSsG10A76HzDlAxe0oK
         8dkNd7MAZdbgkr1z7OroOFvai2EFPfiR786gt1YTmX5lXFKbkeyd0p+ETTPhjzy6HMUC
         tkZ8WJ8xFo/xn8sq6fK63UZtV2trnKwoK2SEZrm4O6SZtlROtVHMKcSlhkdZEig/pmpb
         OE+Q==
X-Gm-Message-State: AOAM531XT59K+MCDHcxvZQ+t/p+jbdlUCTgin1gjGACuspdQt8OMN6b9
        xRGtxUjGAfOMArP+YJVJ9XntcQMQAYkDGg==
X-Google-Smtp-Source: ABdhPJx36094XEd9oE9B0Pr9ryHSzM/l/3aZPDz4WPmIrlL0GbRn/4rlKygM5Br6EUQwTZyo68vcpA==
X-Received: by 2002:a17:906:7f97:: with SMTP id f23mr14673562ejr.74.1619681183343;
        Thu, 29 Apr 2021 00:26:23 -0700 (PDT)
Received: from agape.jhs ([5.171.81.14])
        by smtp.gmail.com with ESMTPSA id u11sm1688315edr.13.2021.04.29.00.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 00:26:23 -0700 (PDT)
Date:   Thu, 29 Apr 2021 09:26:20 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH 1/2] staging: rtl8723bs: hal: Remove
 set but unused variables
Message-ID: <20210429072619.GB1409@agape.jhs>
References: <20210428113346.28305-1-fmdefrancesco@gmail.com>
 <20210428113346.28305-2-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210428113346.28305-2-fmdefrancesco@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

On Wed, Apr 28, 2021 at 01:33:45PM +0200, Fabio M. De Francesco wrote:
> Removed four set but unused variables. Issue detected by gcc.
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
> index 082448557b53..96cb4426a0f4 100644
> --- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
> +++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
> @@ -3900,14 +3900,11 @@ u8 GetHalDefVar8723B(struct adapter *padapter, enum hal_def_variable variable, v
>  			u32 cmd;
>  			u32 ra_info1, ra_info2;
>  			u32 rate_mask1, rate_mask2;
> -			u8 curr_tx_rate, curr_tx_sgi, hight_rate, lowest_rate;
>  
>  			cmd = 0x40000100 | mac_id;
>  			rtw_write32(padapter, REG_HMEBOX_DBG_2_8723B, cmd);
>  			msleep(10);
>  			ra_info1 = rtw_read32(padapter, 0x2F0);
> -			curr_tx_rate = ra_info1&0x7F;
> -			curr_tx_sgi = (ra_info1>>7)&0x01;
>  
>  			cmd = 0x40000400 | mac_id;
>  			rtw_write32(padapter, REG_HMEBOX_DBG_2_8723B, cmd);
> @@ -3916,8 +3913,6 @@ u8 GetHalDefVar8723B(struct adapter *padapter, enum hal_def_variable variable, v
>  			ra_info2 = rtw_read32(padapter, 0x2F4);
>  			rate_mask1 = rtw_read32(padapter, 0x2F8);
>  			rate_mask2 = rtw_read32(padapter, 0x2FC);
> -			hight_rate = ra_info2&0xFF;
> -			lowest_rate = (ra_info2>>8)  & 0xFF;
>  
>  		}
>  		break;
> -- 
> 2.31.1
> 
>

rate_mask{1,2} and ra_info{1,2} seems to be unused as well.

thank you,

fabio 
