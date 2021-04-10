Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE4A535ACEC
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 13:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbhDJLXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 07:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234587AbhDJLXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 07:23:39 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B525C061763
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 04:23:24 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a7so12619701eju.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 04:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9ZPKl5HJ+8LOZQrHb8tNPFqcLBfQT7NaXwLBkRLXcNc=;
        b=Q5ArPaqQgR9NI/PxHIOFBaFAOyiTlSAkWS3jgZkicA9SKv46OUBy0lHaI682ae0rNv
         lX9PGF2rQnFF0oRJFBLqHAtopzAbGt7gfoBrIbu5LC092BQ73CK4mDduyczs3GPmohea
         3dOaco8tefv6rNAzgq7Txu3V6ZFlWKVCGPjaVCqkCQnGtoe72VYXTi4I8C+dGYvx9RKF
         Xl1Qvs+edMQEZFGtETHmv1tCM9p286W3kePCy48vsZNfIU1I1nzjAQYAUsUOWayqsAJ0
         U2j8Zeq6H1I6jl/hKkjN0d/OOzp7ry81SSJmXssxNACJH0sFRXqM/sGkX8wFoCqAe7pD
         1ovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ZPKl5HJ+8LOZQrHb8tNPFqcLBfQT7NaXwLBkRLXcNc=;
        b=hZViXcS3KuLC2Z183ffyK/Z+umoWfZ/Dof5z9mq98leFNn7LF/dyUoShvboeEIWo6l
         kNyWZZCsm2WmLTC951Vhu8v9c9If4VoFu5HDIcQj38m4rp3CkbYerN3bhuWAlLIAFLoj
         dwVRP5u2sYmR0qEXP/TDKw5DvUjx658MswIbz1oEtvl0CmVz47340a+smo9GJiqS+3Cx
         AJnNuraLb+L5m0DrObsit5E48mN17t8FKaszdmOxts113phC32wqyllRCgFahZ7poaXm
         u+xBnkqsm1HlaIu/CigepQdCTCzrVPnIb2Vr8MGakbpMWo1Cn+tDxQ0AJ1vJj7idDJsr
         a7XQ==
X-Gm-Message-State: AOAM533Ww8uLnxX3b40PpO15SKaVPfdclIrI/LkGMwosLgwDDDyp0vQh
        A/JgmPLhh6wRpR9wS+pcCH0=
X-Google-Smtp-Source: ABdhPJxKZCJswrYJ5MzKLLEvv6kdPvJ9ER0KKpjyMZ9/GNI6W1Rcc/puceOlExrAJQQK39kdSzQ0fA==
X-Received: by 2002:a17:906:3643:: with SMTP id r3mr19414067ejb.527.1618053803039;
        Sat, 10 Apr 2021 04:23:23 -0700 (PDT)
Received: from localhost.localdomain (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id y2sm2511658ejf.30.2021.04.10.04.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 04:23:22 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, julia.lawall@inria.fr
Subject: Re: [Outreachy kernel] [PATCH 4/4] staging: rtl8723bs: Change the type and use of a variable
Date:   Sat, 10 Apr 2021 13:23:21 +0200
Message-ID: <10115279.QsZogQpAqX@localhost.localdomain>
In-Reply-To: <YHGGBpSLj+W8ikXz@kroah.com>
References: <20210410092232.15155-1-fmdefrancesco@gmail.com> <4547533.LBOHeWh67L@localhost.localdomain> <YHGGBpSLj+W8ikXz@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, April 10, 2021 1:03:34 PM CEST Greg KH wrote:
> On Sat, Apr 10, 2021 at 12:58:06PM +0200, Fabio M. De Francesco wrote:
> > On Saturday, April 10, 2021 12:31:27 PM CEST Greg KH wrote:
> > > On Sat, Apr 10, 2021 at 11:56:48AM +0200, Fabio M. De Francesco 
wrote:
> > > > On Saturday, April 10, 2021 11:31:16 AM CEST Greg KH wrote:
> > > > > On Sat, Apr 10, 2021 at 11:22:32AM +0200, Fabio M. De Francesco
> > 
> > wrote:
> > > > > > Change the type of fw_current_in_ps_mode from u8 to bool,
> > > > > > because
> > > > > > it is used everywhere as a bool and, accordingly, it should be
> > > > > > declared as a bool. Shorten the controlling
> > > > > > expression of an 'if' statement.
> > > > > > 
> > > > > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > > > > ---
> > > > > > 
> > > > > >  drivers/staging/rtl8723bs/hal/hal_intf.c        | 2 +-
> > > > > >  drivers/staging/rtl8723bs/include/rtw_pwrctrl.h | 2 +-
> > > > > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c
> > > > > > b/drivers/staging/rtl8723bs/hal/hal_intf.c index
> > > > > > 96fe172ced8d..8dc4dd8c6d4c 100644
> > > > > > --- a/drivers/staging/rtl8723bs/hal/hal_intf.c
> > > > > > +++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
> > > > > > @@ -348,7 +348,7 @@ void rtw_hal_dm_watchdog(struct adapter
> > > > > > *padapter)
> > > > > > 
> > > > > >  void rtw_hal_dm_watchdog_in_lps(struct adapter *padapter)
> > > > > >  {
> > > > > > 
> > > > > > -	if (adapter_to_pwrctl(padapter)->fw_current_in_ps_mode ==
> > 
> > true)
> > 
> > > > {
> > > > 
> > > > > > +	if (adapter_to_pwrctl(padapter)->fw_current_in_ps_mode) {
> > > > > > 
> > > > > >  		if (padapter->HalFunc.hal_dm_watchdog_in_lps)
> > > > > >  		
> > > > > >  			padapter-
> > > > >
> > > > >HalFunc.hal_dm_watchdog_in_lps(padapter); /* this
> > > > >
> > > > > >  			function caller is in interrupt 
context
> > > > 
> > > > */>
> > > > 
> > > > > >  	}
> > > > > > 
> > > > > > diff --git a/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
> > > > > > b/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h index
> > > > > > 0a48f1653be5..0767dbb84199 100644
> > > > > > --- a/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
> > > > > > +++ b/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
> > > > > > @@ -203,7 +203,7 @@ struct pwrctrl_priv {
> > > > > > 
> > > > > >  	u8 LpsIdleCount;
> > > > > >  	u8 power_mgnt;
> > > > > >  	u8 org_power_mgnt;
> > > > > > 
> > > > > > -	u8 fw_current_in_ps_mode;
> > > > > > +	bool fw_current_in_ps_mode;
> > > > > > 
> > > > > >  	unsigned long	DelayLPSLastTimeStamp;
> > > > > >  	s32		pnp_current_pwr_state;
> > > > > >  	u8 pnp_bstop_trx;
> > > > > 
> > > > > If this is only checked, how can it ever be true?  Who ever sets
> > > > > this
> > > > > value?
> > > > 
> > > > You're right. It is not set, therefore the "if" control expression
> > > > cannot ever be "true".
> > > > 
> > > > Can I delete this statement in a new patch? Or you prefer I send
> > > > the
> > > > whole series again with this change in patch 4/4?
> > > 
> > > Just delete the variable from the structure entirely and when it is
> > > used.
> > 
> > I've read the code of the function whom that 'if' statement belongs to.
> > This function takes a pointer whose name is 'padapter' and this is has
> > global scope. I think that since fw_current_in_ps_mode is dereferenced
> > by the function adapter_to_pwrctl(padapter) it can and is indeed
> > initialized and modified in some other files of the driver.
> 
> Where does that happen, and why did the build not break when you changed
> the variable name?  
>
The build didn't break because I changed the name of that variable 
everywhere it is used in the driver. This patch is against all the affected 
files of each subdirectory of staging/rtl8723bs.
>
> Is the whole variable assigned to a specific
> location in memory in the device?  Where is it initialized?
>
That variable has global scope and is assigned at least in:

drivers/staging/rtl8723bs/core/rtw_pwrctrl.c:368:                       
pwrpriv->fw_current_in_ps_mode = false;

drivers/staging/rtl8723bs/core/rtw_pwrctrl.c:380:                       
pwrpriv->fw_current_in_ps_mode = true;

drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c:433:  
adapter_to_pwrctl(padapter)->fw_current_in_ps_mode = false;

drivers/staging/rtl8723bs/core/rtw_pwrctrl.c:981:       
pwrctrlpriv->fw_current_in_ps_mode = false;

Thanks,

Fabio
> 
> > That's why I'll leave the if statement as is now. If I am wrong there's
> > time to change it later in a future patch.
> 
> Don't change obviously wrong code, we can clean it up properly :)
> 
> thanks,
> 
> greg k-h




