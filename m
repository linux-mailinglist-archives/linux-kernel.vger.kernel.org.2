Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9154535C5CD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 13:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240773AbhDLL5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 07:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239202AbhDLL5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 07:57:40 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18800C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 04:57:22 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id p6so5912752wrn.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 04:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=26Z5+AmQkQeLw9JlKRYpbSMEomtaV7uiUzdp3tF/h3M=;
        b=QAHqM7KtRWGaWyiVCAKHTW2n3QGFWLMbRDJsG5wuUJqDMRPZPh9ojwb8/tvpQUCCEV
         rJku7h1V3GZXTEZIe8Cgxtw8rffogTunu7W7ND4cPloyb1PF1e0GUrI3Fh+OcPWw2MTs
         3RMdQJ+RaoFPxouPWZ+LvyRouvZwJdxoVulvwoipA8sbNQHXol287cyIW0LVW5Ggllsb
         HGnmGXRayG2YXMXHE2MXBPfFIfTp4kvnSSM400FEgOErBHbWvbG81LXE/AUIHIle8cmk
         qSEzOMhxwcqiIVlqGN30YilqID37lcUM07Te7rZtO7T0Kr7ZT/1BoZTvSOWkIanbtwWn
         Yi5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=26Z5+AmQkQeLw9JlKRYpbSMEomtaV7uiUzdp3tF/h3M=;
        b=FP84iHBSzyxSwH5dKUo9MzLyKo7BEt0CSTreN84/PA9bz1m52jepRWbkaNBCeZsHkB
         n2cf89zsh9bQOSF2FiarLosXYlFjfE5uSh4tbXavBPVkHE8dcUluqSTw6qq/0DTVMv97
         c42B7cFCnfWG3uuxsfUrcRnJH2ugdnCdaU8Q6npsNRAeRIjek1o8+C6JIcc4Vd+UQlqr
         O7u8H7f5p2ZGOjsp6+TcD6pEf5QRr8oN4YHavM5AN2aTB3W4rxsTH64dhc3/sdMgFL/H
         m8DffZh4ViyiqvoataIYIuMgt/pZQetRc8n8M/KlXfTNkv/YIn7HqE1SMQmDG4aeF3Iw
         RM6g==
X-Gm-Message-State: AOAM532/rVlZNZhHLxlEljJDTSchfngIWb+4pKG9zafnMZUNt9g+sMbk
        WZ9N5bjRBisoMmSDNRm254qMSIqafuaJIg==
X-Google-Smtp-Source: ABdhPJzECpBATP6pixPwCmw6QQc3EYzQxea8Rcf5D2cpeRFwqgeCxZexC0oGlzoXDGHHIcixFzV9Kw==
X-Received: by 2002:a05:6000:24f:: with SMTP id m15mr8982690wrz.226.1618228640852;
        Mon, 12 Apr 2021 04:57:20 -0700 (PDT)
Received: from agape.jhs ([5.171.81.2])
        by smtp.gmail.com with ESMTPSA id s64sm8909285wmf.2.2021.04.12.04.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 04:57:20 -0700 (PDT)
Date:   Mon, 12 Apr 2021 13:57:17 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        lkp@intel.com
Subject: Re: [PATCH 1/3] staging: rtl8723bs: remove unused variable ret in
 hal/sdio_halinit.c
Message-ID: <20210412115716.GA1415@agape.jhs>
References: <cover.1618145345.git.fabioaiuto83@gmail.com>
 <fbba90b0c8fb9f65b0dc7bc0b02560724a5502ab.1618145345.git.fabioaiuto83@gmail.com>
 <YHQVKPOoGS3auAeQ@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHQVKPOoGS3auAeQ@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 11:38:48AM +0200, Greg KH wrote:
> On Sun, Apr 11, 2021 at 02:57:35PM +0200, Fabio Aiuto wrote:
> > fix following compiler warning issue:
> > 
> >    drivers/staging/rtl8723bs/hal/sdio_halinit.c:
> >  In function 'CardDisableRTL8723BSdio':
> > >> drivers/staging/rtl8723bs/hal/sdio_halinit.c:881:5:
> > warning: variable 'ret' set but not used [-Wunused-but-set-variable]
> >      881 |  u8 ret = _FAIL;
> >          |     ^~~
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> > ---
> >  drivers/staging/rtl8723bs/hal/sdio_halinit.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
> > index 2098384efe92..936181a73d73 100644
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
> 
> Why isn't the return value being checked and returned to the caller if
> something goes wrong?  Ignoring it feels wrong to me.
> 
> thanks,
> 
> greg k-h

ok, I will propagate the return value to the whole caller chain.
CardDisableRTL8723BSdio returns void, will change this to u8...

thank you,

fabio
