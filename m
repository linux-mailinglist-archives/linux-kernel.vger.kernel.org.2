Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBA835AC98
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 11:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbhDJJ5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 05:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhDJJ5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 05:57:05 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB4AC061762
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 02:56:51 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id z1so9303797edb.8
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 02:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R7rBJwvSAC/U1G/3zxbwR8KyBOKUXLbBfKOEweX//uY=;
        b=NErw0TlHpG+ciy/hxMying/Srgf0B9zekhOJhuYaDR23UNAPrZEdMoXSrijuTarJET
         5WMeRO26b30orBqbL9eYFdLuEV5UcnlYTInKiZiaqup4J9LWLq/SBoKdJpaFhHDHPzCU
         fPFx9k0zEJ6HyxVRelnydGHG7ZOiAJ+EPwVoZHj03/UHHDtFleHXEokYwOCoN8ZoSuRJ
         HKyTHpSrG/89jlzjEKiD8u6jH/L5OYfiStV6da+NAjsvzYBEHuwogdo2/7lidszjIXxQ
         tksN3r0yIy+3q4+vZy5lZd9JbWFt4KAsbmMbGJDpdd3a7Qi95yV+OCH8RrpDbE6m5MT6
         AVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R7rBJwvSAC/U1G/3zxbwR8KyBOKUXLbBfKOEweX//uY=;
        b=gnEZ/PeJ21DcYls45Ojwq3lSDvnjbAjwFQmZSz+EzjTNGl7PJdcRn2nuWsiOtjH5t6
         YeSHoNReiUzZn85396zTVwu/uGUzZvUlGoof5RiqrNZ6jrsCHCiD74L4uN5lY0g9WJuj
         WOBs7H+FyucCcesfXRU3AOBhi2Y/8CbQ2WnZKZtPo7yU9WvxOu6Kxh079R0Q8FvMoqdU
         VRHNX0nbv5TVJgcbgkSWWLYmAZudVITWANCyezGqm8KQMb+OjgAprjIweh28tPF5lzkA
         idVYMwo5zU4UEUaLB1ZBv+UEl2byItvygIPYCWqHfHG06syakJEV3zjzsITKfy0XHki0
         zO0A==
X-Gm-Message-State: AOAM533d9xy9OvieAD9+mqIkkL7o+U7673bAN64lhGrYuX3LBXhHN1aE
        rJe6F3PHAAKrK/BmRbsg1RU=
X-Google-Smtp-Source: ABdhPJyq0zgm5wR9LvWiesZ3tQROh+rNBKo1IgyXHhG5GB+hK/nkqpnsHWeEj15Vyp2t3dAT1QQ8Eg==
X-Received: by 2002:a05:6402:104c:: with SMTP id e12mr20648735edu.108.1618048609947;
        Sat, 10 Apr 2021 02:56:49 -0700 (PDT)
Received: from localhost.localdomain (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id p4sm2209078edr.43.2021.04.10.02.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 02:56:49 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH 4/4] staging: rtl8723bs: Change the type and use of a variable
Date:   Sat, 10 Apr 2021 11:56:48 +0200
Message-ID: <24152421.bNubvhIgUM@localhost.localdomain>
In-Reply-To: <YHFwZCh+s7ymrsQN@kroah.com>
References: <20210410092232.15155-1-fmdefrancesco@gmail.com> <20210410092232.15155-5-fmdefrancesco@gmail.com> <YHFwZCh+s7ymrsQN@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, April 10, 2021 11:31:16 AM CEST Greg KH wrote:
> On Sat, Apr 10, 2021 at 11:22:32AM +0200, Fabio M. De Francesco wrote:
> > Change the type of fw_current_in_ps_mode from u8 to bool, because
> > it is used everywhere as a bool and, accordingly, it should be
> > declared as a bool. Shorten the controlling
> > expression of an 'if' statement.
> > 
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> > 
> >  drivers/staging/rtl8723bs/hal/hal_intf.c        | 2 +-
> >  drivers/staging/rtl8723bs/include/rtw_pwrctrl.h | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c
> > b/drivers/staging/rtl8723bs/hal/hal_intf.c index
> > 96fe172ced8d..8dc4dd8c6d4c 100644
> > --- a/drivers/staging/rtl8723bs/hal/hal_intf.c
> > +++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
> > @@ -348,7 +348,7 @@ void rtw_hal_dm_watchdog(struct adapter *padapter)
> > 
> >  void rtw_hal_dm_watchdog_in_lps(struct adapter *padapter)
> >  {
> > 
> > -	if (adapter_to_pwrctl(padapter)->fw_current_in_ps_mode == true) 
{
> > +	if (adapter_to_pwrctl(padapter)->fw_current_in_ps_mode) {
> > 
> >  		if (padapter->HalFunc.hal_dm_watchdog_in_lps)
> >  		
> >  			padapter-
>HalFunc.hal_dm_watchdog_in_lps(padapter); /* this
> >  			function caller is in interrupt context 
*/>  	
> >  	}
> > 
> > diff --git a/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
> > b/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h index
> > 0a48f1653be5..0767dbb84199 100644
> > --- a/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
> > +++ b/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
> > @@ -203,7 +203,7 @@ struct pwrctrl_priv {
> > 
> >  	u8 LpsIdleCount;
> >  	u8 power_mgnt;
> >  	u8 org_power_mgnt;
> > 
> > -	u8 fw_current_in_ps_mode;
> > +	bool fw_current_in_ps_mode;
> > 
> >  	unsigned long	DelayLPSLastTimeStamp;
> >  	s32		pnp_current_pwr_state;
> >  	u8 pnp_bstop_trx;
> 
> If this is only checked, how can it ever be true?  Who ever sets this
> value?
>
You're right. It is not set, therefore the "if" control expression cannot 
ever be "true".

Can I delete this statement in a new patch? Or you prefer I send the whole 
series again with this change in patch 4/4?

Thanks,

Fabio
>
> thanks,
> 
> greg k-h




