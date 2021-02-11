Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48663318B0D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 13:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbhBKMlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 07:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbhBKMYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 07:24:10 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF5CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 04:23:28 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a9so9771532ejr.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 04:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=98DRdWMtJ5a8j+v9HHj8zV5HAmHUhIOMtOsk+5Zo6vY=;
        b=CF5lNLQVFU3hMolQxQlvsi0aU7Hp9V4iJ4niy6+p6TtAMfurVPzO2vp4HtLrMGzCAs
         5NUr63Z7RgrtQpMFudwwFG5CiA5MAeUAu+nKkxDgXQrRVoxx+rdF50V3HTfLufCMIn/7
         N6aUQzidhAsHI4dPCDIyoDSc6LCNH2wHdQjqK3zdGE8u6ubPK6KJ5yMwN2PSkzO+giJr
         rvJJ6R3EahCoK+VQCNzyQNIjgyxC8PHs4G3JtTyMT069StR7eAKCuhc1ejZBA8Ac31YF
         R54/45JuO836UUat9de8Wpxt0OOGw5/LtIH0HKDEYbh0o8JOQdcuYYPx0UZu8qjHntwA
         l1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=98DRdWMtJ5a8j+v9HHj8zV5HAmHUhIOMtOsk+5Zo6vY=;
        b=TlBRGcIge+uW7fQbkVruyrtDdrBursoJyEspjibR9DPc6P/pes9RFyab26iSZuQlkK
         5dFEzz7T9dsLdKamcgFcblJk8Z53hYxkWV6gM3xxvn2tUcLcPwG7ME19pwuuNvc9nJJR
         kHUVkK/M0nXcYsBB5cXpmU5aA/K4uAJseQ+qzHWC1mkzm/cfHnz93hDu2VANbJQruRGw
         YLCGXoC7lLTXCSun/dLNyYhBkqi5SahAhZn8iIplHKveL4hfJG00qYs2QZgFGOKPIvya
         00wL5hGQJ8IjPRIKLkMXarfOi4iwe8kIjbuRCQmok6pref/Jo15ohGWHNeuAwv/Yqwil
         zfCA==
X-Gm-Message-State: AOAM531rG1YhA1WsAQ9vqyxrRkTpNVkJs2K0byQkKJxODvQMTxkLITGn
        af9PFd1KbMf/vTCoXE5Mf30qlzPQFGgP3A==
X-Google-Smtp-Source: ABdhPJz9w5j4Zrbo/kiuVFeF6khzTfzKMB3QRq15Mbb3ZvLvmLWmTjoeC+x8zWbwxtQC/MrlDiL57w==
X-Received: by 2002:a17:906:c049:: with SMTP id bm9mr7996224ejb.535.1613046207179;
        Thu, 11 Feb 2021 04:23:27 -0800 (PST)
Received: from TRWS9215.usr.ingenico.loc ([95.13.23.74])
        by smtp.gmail.com with ESMTPSA id a1sm3921239edj.6.2021.02.11.04.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 04:23:26 -0800 (PST)
Date:   Thu, 11 Feb 2021 15:23:24 +0300
From:   Fatih Yildirim <yildirim.fatih@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        gustavo@embeddedor.com
Subject: Re: [PATCH -next] staging: ks7010: Macros with complex values
Message-ID: <20210211122324.GA10415@TRWS9215.usr.ingenico.loc>
References: <20210211092239.10291-1-yildirim.fatih@gmail.com>
 <YCUAy1VhLV3lwa3H@kroah.com>
 <20210211105704.GA10351@TRWS9215.usr.ingenico.loc>
 <YCUQtJk1XMsBRGBz@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCUQtJk1XMsBRGBz@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 12:10:44PM +0100, Greg KH wrote:
> On Thu, Feb 11, 2021 at 01:57:04PM +0300, Fatih YILDIRIM wrote:
> > On Thu, Feb 11, 2021 at 11:02:51AM +0100, Greg KH wrote:
> > > On Thu, Feb 11, 2021 at 12:22:39PM +0300, Fatih Yildirim wrote:
> > > > Fix for checkpatch.pl warning:
> > > > Macros with complex values should be enclosed in parentheses.
> > > > 
> > > > Signed-off-by: Fatih Yildirim <yildirim.fatih@gmail.com>
> > > > ---
> > > >  drivers/staging/ks7010/ks_hostif.h | 24 ++++++++++++------------
> > > >  1 file changed, 12 insertions(+), 12 deletions(-)
> > > > 
> > > > diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
> > > > index 39138191a556..c62a494ed6bb 100644
> > > > --- a/drivers/staging/ks7010/ks_hostif.h
> > > > +++ b/drivers/staging/ks7010/ks_hostif.h
> > > > @@ -498,20 +498,20 @@ struct hostif_mic_failure_request {
> > > >  #define TX_RATE_FIXED		5
> > > >  
> > > >  /* 11b rate */
> > > > -#define TX_RATE_1M	(u8)(10 / 5)	/* 11b 11g basic rate */
> > > > -#define TX_RATE_2M	(u8)(20 / 5)	/* 11b 11g basic rate */
> > > > -#define TX_RATE_5M	(u8)(55 / 5)	/* 11g basic rate */
> > > > -#define TX_RATE_11M	(u8)(110 / 5)	/* 11g basic rate */
> > > > +#define TX_RATE_1M	((u8)(10 / 5))	/* 11b 11g basic rate */
> > > > +#define TX_RATE_2M	((u8)(20 / 5))	/* 11b 11g basic rate */
> > > > +#define TX_RATE_5M	((u8)(55 / 5))	/* 11g basic rate */
> > > > +#define TX_RATE_11M	((u8)(110 / 5))	/* 11g basic rate */
> > > 
> > > But these are not "complex macros" that need an extra () added to them,
> > > right?
> > > 
> > > Checkpatch is a hint, it's not a code parser and can not always know
> > > what is happening.  With your knowledge of C, does this look like
> > > something that needs to be "fixed"?
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > Hi Greg,
> > 
> > Thanks for your reply.
> > Actually, I'm following the Eudyptula Challenge and I'm at task 10.
> 
> First rule of that challenge is that you are not allowed to talk about
> it in public :)
> 
> That being said, you didn't answer any of my questions above :(
> 
> greg k-h

Ohh no, missed the rule. Sorry for that, I feel rookie :)
You are right, they are not complex macros.
Besides that, type cast operator doesn't have the highest precedence.
So, I think we can use enclosing paranthesis.

Thanks,
Fatih
