Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 373C23AE95B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 14:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhFUMrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 08:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhFUMrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 08:47:23 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586F1C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 05:45:08 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id b3so9249344wrm.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 05:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ewxjlfESBtSi0zj0qL9WBWTJ6mflD9jX2jhFXxxGDxE=;
        b=GGIJRfHU2Ka8BTGXzTSWkOYdIgTTn0TPWYYDyEn0LxhipvhWmZEUBzYdo7/tZRR6w5
         NzU2uKsGyWQxa4T81ehHcK/yvQX0z9Gf1mPDj+YtbAhiP0YmYTj9OSeVyV5bO5hH61JB
         UyetaLApi/xtcvzVNYglA2cxjVNcURUVTrrJqTT6zDI938NE4i6y1tsaYVgQGMYLR61g
         aqchbG3Lmddh5t2RCPblf655AyGKMfTMNTJ+VwtBEbQf9BZKio8Vrw4BQo7Qgj1/ughH
         xFGExKnn9KUvJR1h8L613rXyTX057R7VAnSU25cEJvAJWZFlJToF8ofKI2WAA0CsfFZg
         mJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ewxjlfESBtSi0zj0qL9WBWTJ6mflD9jX2jhFXxxGDxE=;
        b=ZlXe/AuLI3d5Z1GeltjDsXTORdwlFWZeQ7cLWYb0hF7bTGZslK39+ce/oZSlQRE1iY
         S/2IGf5WNd5sbVAEr25MEFR1p+kvQjnxx6+wS8r+gBEI24d+6rhOSXUW3YPJAiqlMYDI
         SFav/oAoEfZr6NF8BZiImzBUNihv8rDfmgTFCbfxNBqfZP4fIJP555LpyEXprJ00vORr
         bVC6X+Cczef1H/r/IdDW9xVGMy6z2oXMMzLDV+6N1Eejp91yPcwDbyoIa3v5aBQxcAt2
         ZVN+WPWZt/Tr4OWdBwn43LeO+BcvY2dmPzLVWPyVssCkkN0kG+RTRazzuougwosxUCqN
         XZXw==
X-Gm-Message-State: AOAM530Yz2FI4XXla+WlNRgdS//yfm1+fuyvPAP3nETvSYpJrkldpwMr
        0oqhQxqqRiOhX1QYIjy5U14=
X-Google-Smtp-Source: ABdhPJwbdxyhQW8H+YFfffLHtIRfwu5zQBJgjVNwDMEb1PF/RxRVybx/RLeO+vcsyOQZh3CFR5PwPA==
X-Received: by 2002:adf:f088:: with SMTP id n8mr18186291wro.227.1624279507016;
        Mon, 21 Jun 2021 05:45:07 -0700 (PDT)
Received: from agape.jhs ([5.171.73.54])
        by smtp.gmail.com with ESMTPSA id l16sm20214092wmj.47.2021.06.21.05.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 05:45:06 -0700 (PDT)
Date:   Mon, 21 Jun 2021 14:45:04 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/18] staging: rtl8723bs: remove register
 initializations tied to 802.11ac standard
Message-ID: <20210621124503.GC1408@agape.jhs>
References: <cover.1624099125.git.fabioaiuto83@gmail.com>
 <66706b5cb6474c4482c3342c4383fe62eba54967.1624099126.git.fabioaiuto83@gmail.com>
 <b3f7e373-a7f9-f48f-b510-7eb3e56e872e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3f7e373-a7f9-f48f-b510-7eb3e56e872e@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Hans,

On Mon, Jun 21, 2021 at 11:48:27AM +0200, Hans de Goede wrote:
> Hi,
> 
> On 6/19/21 12:47 PM, Fabio Aiuto wrote:
> > remove register initializations tied to 802.11ac standard which
> > is not supported by the device.
> > 
> > It's a dangerous operation, relying only on comments, but tested
> > on a Lenovo Ideapad MIIX 300-10IBY tablet seems to work.
> > 
> > Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> 
> TBH I think this patch should be dropped from the series, you
> are dropping a bunch of register writes which likely are actually
> doing something, so this is not just dead code removal.
> 
> Regards,
> 
> Hans
> 
> 
> > ---
> >  drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 12 ------------
> >  1 file changed, 12 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
> > index 059d3050acc6..3a03dfb8d275 100644
> > --- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
> > +++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
> > @@ -1718,24 +1718,12 @@ void _InitBurstPktLen_8723BS(struct adapter *Adapter)
> >  	struct hal_com_data *pHalData = GET_HAL_DATA(Adapter);
> >  
> >  	rtw_write8(Adapter, 0x4c7, rtw_read8(Adapter, 0x4c7)|BIT(7)); /* enable single pkt ampdu */
> > -	rtw_write8(Adapter, REG_RX_PKT_LIMIT_8723B, 0x18);		/* for VHT packet length 11K */
> >  	rtw_write8(Adapter, REG_MAX_AGGR_NUM_8723B, 0x1F);
> >  	rtw_write8(Adapter, REG_PIFS_8723B, 0x00);
> >  	rtw_write8(Adapter, REG_FWHW_TXQ_CTRL_8723B, rtw_read8(Adapter, REG_FWHW_TXQ_CTRL)&(~BIT(7)));
> >  	if (pHalData->AMPDUBurstMode)
> >  		rtw_write8(Adapter, REG_AMPDU_BURST_MODE_8723B,  0x5F);
> >  	rtw_write8(Adapter, REG_AMPDU_MAX_TIME_8723B, 0x70);
> > -
> > -	/*  ARFB table 9 for 11ac 5G 2SS */
> > -	rtw_write32(Adapter, REG_ARFR0_8723B, 0x00000010);
> > -	if (IS_NORMAL_CHIP(pHalData->VersionID))
> > -		rtw_write32(Adapter, REG_ARFR0_8723B+4, 0xfffff000);
> > -	else
> > -		rtw_write32(Adapter, REG_ARFR0_8723B+4, 0x3e0ff000);
> > -
> > -	/*  ARFB table 10 for 11ac 5G 1SS */
> > -	rtw_write32(Adapter, REG_ARFR1_8723B, 0x00000010);
> > -	rtw_write32(Adapter, REG_ARFR1_8723B+4, 0x003ff000);
> >  }
> >  
> >  static void ResumeTxBeacon(struct adapter *padapter)
> > 
> 

ok, I will drop it in next v2.

Thank you for review,

fabio
