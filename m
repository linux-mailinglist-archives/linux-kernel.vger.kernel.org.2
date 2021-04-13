Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1321E35E2C6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 17:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344209AbhDMPYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 11:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbhDMPYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 11:24:31 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14F6C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 08:24:10 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id u17so26612083ejk.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 08:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jK/ZPtHk9uvMxSIko7jw6vjwCxriFJfcRMyFensq8Io=;
        b=fGi7Ivm90QF1t75+F6/XInNNdXGH9wmVEO0FnSJcasknjGm8zDgQEUzztsOCKsuudx
         LHNF63FJ6rzEAUhGXYii7WG5gd+sFNAau3MkUnAnTk+hFUEAmpq/DnOm+lOcaX4fDc0k
         2wzFneQBIRp6tm41d4kZGIIaqTNo4UhBY0JYjXO96Lpz8NqFlxSi+7FFhJKrNhHXLOxj
         +asImYLAQHxPd98OoaFbNYr4aiTeU2h5MuqN5/sZSf+nRq0GUhirGC86EJqVH8peA/Np
         0bBHLQzJxVauhKCQX6j6S5yiNUUjUY7pVjPhsfUZ78gj5jwx7MYZpczt4J6Ur419a/uT
         88WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jK/ZPtHk9uvMxSIko7jw6vjwCxriFJfcRMyFensq8Io=;
        b=qMY5lBRHCgSMixBuRYCHmLNdrK3Aa71IsWH3cmVVjh2t3SHOo8hl3YM9WjPkZfUSI5
         ZlxjcHTMfBIW0e37vZeciBFZWtBqEhZP/WHR6rxyBp0ZUT5fpp8LrSrywOT29HDNoPAN
         ogqRY5SLI6vcae8tIBSi3ZQTlp5SPBEvbGjimUv89ElAUFjo39UDiXcRSRMx7DLMnckB
         hLBKnmTbLwcPkCFJxkFYtCA2f5/pTl0mk7S/wOJl+t+P0luFXyZGQQxTFn0HflcU5GFB
         a/l9u3DqUOr1Ngl2v5/guLwM2u1P7m1Zuu5Nyh6e/cVje082iZMovz21Cm89wf/5b7Od
         sQ1A==
X-Gm-Message-State: AOAM532ML5Z17ZLVUl6BVLizLGXrwnvx/bM+5yYpHTQPUQAPgYkznWXn
        2bMycJQ+U/l0g9U3AE3V3y8=
X-Google-Smtp-Source: ABdhPJyRImYDQhFq9ZhQjfTIEoZuZb9TiJ/PaIjI2YVqhJaMg1BXbPlIIXK/Jcf2O8xhdD+5C2/Lsg==
X-Received: by 2002:a17:906:2a46:: with SMTP id k6mr32490136eje.206.1618327449581;
        Tue, 13 Apr 2021 08:24:09 -0700 (PDT)
Received: from linux.local (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id c16sm8308410ejx.81.2021.04.13.08.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 08:24:09 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] staging: rtl8723bs: core: Remove unused but set variable
Date:   Tue, 13 Apr 2021 17:24:08 +0200
Message-ID: <1627371.15on97xvor@linux.local>
In-Reply-To: <alpine.DEB.2.22.394.2104131715560.8430@hadrien>
References: <20210413150517.12533-1-fmdefrancesco@gmail.com> <alpine.DEB.2.22.394.2104131715560.8430@hadrien>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="US-ASCII"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, April 13, 2021 5:16:17 PM CEST Julia Lawall wrote:
> On Tue, 13 Apr 2021, Fabio M. De Francesco wrote:
> > Removed "ledBlink_param" because it was set to the value of "pbuf" but
> > was never reused. This set was made by direct assignment (no helper
> > had been called), therefore it had no side effect to the location
> > pointed by "pbuf".
> > 
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> > 
> >  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> > b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c index
> > f19a15a3924b..440e22922106 100644
> > --- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> > +++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> > @@ -6191,12 +6191,10 @@ u8 set_chplan_hdl(struct adapter *padapter,
> > unsigned char *pbuf)> 
> >  u8 led_blink_hdl(struct adapter *padapter, unsigned char *pbuf)
> >  {
> > 
> > -	struct LedBlink_param *ledBlink_param;
> > 
> >  	if (!pbuf)
> >  	
> >  		return H2C_PARAMETERS_ERROR;
> > 
> > -	ledBlink_param = (struct LedBlink_param *)pbuf;
> > 
> >  	return	H2C_SUCCESS;
> >  
> >  }
> 
> Is this function actually useful?
> 
> julia
>
Actually, it is completely useless.
We should ask the original authors for explanations :)

I'm about to grep the whole driver for the purpose to check if there are 
callers elsewhere and then delete any call and the function itself.

Thanks,

Fabio



