Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 793E8360644
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 11:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbhDOJyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 05:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbhDOJyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 05:54:17 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E733C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 02:53:53 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id v6so34644981ejo.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 02:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=YBd8uxEa0vBCgQGvq97K/EtYMlg6W5HWp8ZX5EJtosA=;
        b=IwB+9hnUqaIdNRb1tnuE3ZEJjCiCd0wVhTc6uqtjhUMKZV5pZ0ikggYratkEgkFaIq
         /sUA9P5pa4J4mIf9XeOl3lAcFEabQxKV9hTVej7CM4ppz4lTGGUv6LETz/oc+Ld77eE6
         ZN0Pk/g3M7oor9ceC+hK91HitxilPQ0hF3/CSY/ayyl7xE5rmuFT/5Bq8P4VGug3wNZl
         izxw1/gnGH8JrShnmckZCTgCU42nSi5ERvLT68S5XrSc8q72nDRBMGorZiMHTzAHTyRf
         iVhUyyOuT0qp/l/+DPF0+vNihgJ0cQ6mocMrAj7i7ogHFxeI3TURk8v4tiUXQQCpRzCe
         32pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YBd8uxEa0vBCgQGvq97K/EtYMlg6W5HWp8ZX5EJtosA=;
        b=UBJKKeVLoS3UTK97LAsCbXFwACeUsEvKDZ7Iut5lHma1ax4iEtQ8m1X3Psfbtcwbdu
         CcOQnVqddBzave7P5OAjZPweU76mB3tMm16IwvIa+vVBKtMMF0mKG7CiiEl1LejJnZa4
         qkP+feLFGsteChfOyzapoCABHCEgpbsgZx1GS2cLSo0xcoH73Z5lDSfqJRTIB6KE75jk
         oxrU4103OiyqkZRwuXEfTco9YauQNE3R0uMbPnnlz0S8SNV6kUJN7h6euonXN91rIx9B
         RO4wejgAQxhadDAcNB4kk8DZQBMxo/6rf3abP9iY9vaEzELvJ+loRIIhqiUTM6hkfUp6
         MCRw==
X-Gm-Message-State: AOAM530Wvv3DD4GaLUbDa5QvZDciy/92sUK46osnAyg4k7XPEFXZ9BBt
        KOIS7c+oX+piCUOTpj5dGNYSyUbX8lK86A==
X-Google-Smtp-Source: ABdhPJz45PrYAR/WsBEJ1e9qmX5fxR0QuUdzOvqGzGMSs93mYpEHQDRzOvywMwgtkCsdvkzZHm9Kvg==
X-Received: by 2002:a17:906:6d8e:: with SMTP id h14mr2532963ejt.410.1618480431915;
        Thu, 15 Apr 2021 02:53:51 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id d10sm1513187ejw.125.2021.04.15.02.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 02:53:51 -0700 (PDT)
Date:   Thu, 15 Apr 2021 10:53:49 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stanley@bb.sd3, linux-staging@lists.linux.dev
Subject: Re: [PATCH 57/57] staging: rtl8723bs: hal: sdio_halinit: Remove
 unused variable 'ret'
Message-ID: <20210415095349.GX4869@dell>
References: <20210414181129.1628598-1-lee.jones@linaro.org>
 <20210414181129.1628598-58-lee.jones@linaro.org>
 <20210415091622.GC1431@agape.jhs>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210415091622.GC1431@agape.jhs>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Apr 2021, Fabio Aiuto wrote:

> On Wed, Apr 14, 2021 at 07:11:29PM +0100, Lee Jones wrote:
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  drivers/staging/rtl8723bs/hal/sdio_halinit.c: In function ‘CardDisableRTL8723BSdio’:
> >  drivers/staging/rtl8723bs/hal/sdio_halinit.c:881:5: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
> >  drivers/staging/rtl8723bs/hal/sdio_halinit.c: In function ‘CardDisableRTL8723BSdio’:
> >  drivers/staging/rtl8723bs/hal/sdio_halinit.c:881:5: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
> >  drivers/staging/rtl8723bs/hal/sdio_halinit.c: In function ‘CardDisableRTL8723BSdio’:
> >  drivers/staging/rtl8723bs/hal/sdio_halinit.c:881:5: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
> >  drivers/staging/rtl8723bs/hal/sdio_halinit.c: In function ‘CardDisableRTL8723BSdio’:
> >  drivers/staging/rtl8723bs/hal/sdio_halinit.c:881:5: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
> >  drivers/staging/rtl8723bs/hal/sdio_halinit.c: In function ‘CardDisableRTL8723BSdio’:
> >  drivers/staging/rtl8723bs/hal/sdio_halinit.c:881:5: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
> > 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Fabio Aiuto <fabioaiuto83@gmail.com>
> > Cc: Stanley@BB.SD3
> > Cc: linux-staging@lists.linux.dev
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/staging/rtl8723bs/hal/sdio_halinit.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
> > index f6d734dd1a24f..60d3d6d1ba678 100644
> > --- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
> > +++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
> > @@ -878,10 +878,9 @@ static void CardDisableRTL8723BSdio(struct adapter *padapter)
> >  {
> >  	u8 u1bTmp;
> >  	u8 bMacPwrCtrlOn;
> > -	u8 ret = _FAIL;
> >  
> >  	/*  Run LPS WL RFOFF flow */
> > -	ret = HalPwrSeqCmdParsing(padapter, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, rtl8723B_enter_lps_flow);
> > +	HalPwrSeqCmdParsing(padapter, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, rtl8723B_enter_lps_flow);
> >  
> >  	/* 	==== Reset digital sequence   ====== */
> >  
> > @@ -909,9 +908,8 @@ static void CardDisableRTL8723BSdio(struct adapter *padapter)
> >  	/* 	==== Reset digital sequence end ====== */
> >  
> >  	bMacPwrCtrlOn = false;	/*  Disable CMD53 R/W */
> > -	ret = false;
> >  	rtw_hal_set_hwreg(padapter, HW_VAR_APFM_ON_MAC, &bMacPwrCtrlOn);
> > -	ret = HalPwrSeqCmdParsing(padapter, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, rtl8723B_card_disable_flow);
> > +	HalPwrSeqCmdParsing(padapter, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, rtl8723B_card_disable_flow);
> >  }
> >  
> >  static u32 rtl8723bs_hal_deinit(struct adapter *padapter)
> 
> perhaps it's better to check the return value and return it
> to the caller if something goes wrong,

No problem.  Will fix.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
