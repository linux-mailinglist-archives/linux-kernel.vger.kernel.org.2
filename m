Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF846430463
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 20:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240551AbhJPSz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 14:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbhJPSz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 14:55:27 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D55C061765
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 11:53:18 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id d9so51918035edh.5
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 11:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BtprXbIXI7MxDDg305llgHuCQHHKqelf16xVT32hzUo=;
        b=CVblfMWT89Xi/F9ZCMw95Kryy9Fz6VM+qCdOtBzVHBKRyur6SAhmnX+AbQpXIbrshk
         qD+SAbNgeCF8Qi5npkgRFrL6X4NGD/acLCMfs76D71UkqGBwPEpCHsW7zaPuUq9aT1UA
         JHEItwD9/wAdMSfDpljk3CEuGLudNSsTwW0wDCbQuF1sMJG5ej4gDKhsMQC+pbAb3/Be
         GSPooGr2Gm6nirr7arZKjCwOIFCamxwk+IUCHmP7RLAPW6Eiq3aW5V0zzD2CYOm4D5DJ
         FvFKjTUwVvibw6+wcPymw3EfKFVFYUEoxkDDFiInzCLu2lsY3bR2UXG2SkiwuEBVgmsQ
         cYKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BtprXbIXI7MxDDg305llgHuCQHHKqelf16xVT32hzUo=;
        b=y3l6730c385oWLCKNPPL/2lhngoIqxCUyT2XqVN9Cek07oKY1ug2JzPxNg71gllPH3
         IExAD2O1nuuGRr7nI1exNFGheKJnn3ExXYCi/0ogVn0zyRlcR8/mESNjQUTnMREBML3Z
         avaK5AtFUign+6K7JumnE1I1mKmbZv+klUHArHmrqiCIvR8HTkAeXNGvBoK6tBwOrfqE
         2c0PMUH2hx/qODLXj81xEsWSf4AyoB9tfAAZzg4fgLDonsFMp3vjOr9Vh7Co56/p/3FV
         VZ0xnj1yt/CyixZInFBb9sATI84SHHJrikuHe62Fgb3/2zoSp0Qn84W1Vusho064831a
         7Kiw==
X-Gm-Message-State: AOAM533bF2T7BPpJLcFXvwG0JHEnnnENenI5csoJhq54fp2QHB9NTtyd
        AuiRCLlyToGDrsjqozas1sppVWby+4c=
X-Google-Smtp-Source: ABdhPJzJKdn04DV/MlmrAKI3JAm4LATUrizAG7uwuzhNB9krJAR+31IspcdkLt++CfckUkFfGUBVPg==
X-Received: by 2002:a05:6402:4311:: with SMTP id m17mr28643646edc.368.1634410397223;
        Sat, 16 Oct 2021 11:53:17 -0700 (PDT)
Received: from localhost.localdomain (host-79-47-104-180.retail.telecomitalia.it. [79.47.104.180])
        by smtp.gmail.com with ESMTPSA id x22sm7142450edv.14.2021.10.16.11.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 11:53:16 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: Re: [PATCH 3/3] staging: r8188eu: don't accept SIGTERM for cmd thread
Date:   Sat, 16 Oct 2021 20:53:15 +0200
Message-ID: <2409617.cBYgoVRs56@localhost.localdomain>
In-Reply-To: <20211016181343.3686-4-martin@kaiser.cx>
References: <20211016181343.3686-1-martin@kaiser.cx> <20211016181343.3686-4-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, October 16, 2021 8:13:43 PM CEST Martin Kaiser wrote:
> At the moment, our command thread can be killed by user space.
> 
> [root@host ]# kill `pidof RTW_CMD_THREAD`
> 
> The driver will then stop working until the module is unloaded
> and reloaded.
> 
> Don't process SIGTERM in the command thread. Other drivers that have a
> command thread don't process SIGTERM either.

Hi Martin,

This is _really_ interesting :)

May be that you have had time to read my last email in reply to a message of 
Phillip P. Soon after writing of the arguments in favor of using 
wait_for_completion_killable() (in patch 2/3 of the series I sent today), I 
read your patch.

If you are right (and I think you are) I'll have to send a v2 that replaces 
the killable wait with an uninterruptible one.

Unfortunately I have not the needed experience to decide whether or not to 
ack your patch, even if I'm strongly tempted to do it.

Let's wait for more experienced people.

Thanks,

Fabio 

> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  drivers/staging/r8188eu/core/rtw_cmd.c          | 2 --
>  drivers/staging/r8188eu/include/osdep_service.h | 5 -----
>  2 files changed, 7 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/
r8188eu/core/rtw_cmd.c
> index e17332677daa..b834fac41627 100644
> --- a/drivers/staging/r8188eu/core/rtw_cmd.c
> +++ b/drivers/staging/r8188eu/core/rtw_cmd.c
> @@ -243,8 +243,6 @@ int rtw_cmd_thread(void *context)
>  	struct adapter *padapter = (struct adapter *)context;
>  	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
>  
> -	thread_enter("RTW_CMD_THREAD");
> -
>  	pcmdbuf = pcmdpriv->cmd_buf;
>  
>  	pcmdpriv->cmdthd_running = true;
> diff --git a/drivers/staging/r8188eu/include/osdep_service.h b/drivers/
staging/r8188eu/include/osdep_service.h
> index ee8a64bb3126..886a1b6f30b4 100644
> --- a/drivers/staging/r8188eu/include/osdep_service.h
> +++ b/drivers/staging/r8188eu/include/osdep_service.h
> @@ -160,11 +160,6 @@ static inline unsigned char _cancel_timer_ex(struct 
timer_list *ptimer)
>  	return del_timer_sync(ptimer);
>  }
>  
> -static __inline void thread_enter(char *name)
> -{
> -	allow_signal(SIGTERM);
> -}
> -
>  static inline void flush_signals_thread(void)
>  {
>  	if (signal_pending (current))
> -- 
> 2.20.1
> 
> 
> 




