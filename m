Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2F46318952
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 12:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbhBKLXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 06:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbhBKK6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 05:58:00 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F709C061786
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 02:57:07 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id df22so6494813edb.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 02:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=caSVfOVCyXZi4K6uM0rmrJ0XGff0G0ewWwkWS9QfX9g=;
        b=BIzLsJKbHvY/jIsiLzOjsu7Z3QPV+xtkpdIMJd0bhpYP35X6+a1niHtxColqbFzzH9
         Fz3cC02Qbov37J+Tq/0oLkRI/zjuEo6H8uZDregp1ahozo9sV/uEF+wl7/PlWQTLopKH
         mRhit3HkP51YZHJ/uVwdoNPXK9VGoI9tLCYofyBiMTCF6XnQ7H3vn2AFEB7FtiuWjzp3
         PrxstwgIW7MHBTw/pKlQOGMxZHHCEnN0Lly/m9qZkhstkmGDlAXnnTnFK6H/8n3Ba5y5
         ObZY9bNpJBP2jgpIyTyKM6iz/Dp1o4WPJafWbvDAsXUFDGvkPj7wxUEqKJW6HGVQMmpH
         HNgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=caSVfOVCyXZi4K6uM0rmrJ0XGff0G0ewWwkWS9QfX9g=;
        b=oBjrC2Ks1iP8k+9l1tPy90VvKN22gd3Df1pDkxRBVT70PADWk3q4HpLyxWTDY8GfMX
         XhXQ8QCSHlqKF5Y03u6NXk2cpxE8dWMccs1aySPgZrwCb5KaHYACr5IRBOQl5SwivGta
         iQ2mvgFJntBB+4CLLZ15Qnl+3oyT5rrjzghppjlDaISWnnfkdX2hF92ww8krRPpKUeB6
         ZRAYdI9MA49+bIXUsWumBFXnjqtf/dkzm3yBg1f21gLyxeby/n/7n/T6MRxQaotiNGb0
         ZxXwUW10gZA1GLX8Z4WTZNIto1/SSuacJ6Mi451o9AirJW7MaD+MW3NM90tERnThGQ80
         sRMA==
X-Gm-Message-State: AOAM533U06NllC/MKxPwTii+grioxvIYdLp9/RbVZr9PV/EEshXxQQKi
        e9Jx7G5lZy1h57uUiGe96Lw5M8cP1EDL8w==
X-Google-Smtp-Source: ABdhPJyqsAPx3nyXAZwt4GcT4hkdhJR2mcnbf5sWwXrBa9alLs4G8z7DyDvz7TTkiwY6mppGj7bkZA==
X-Received: by 2002:a05:6402:11d3:: with SMTP id j19mr7799711edw.314.1613041026130;
        Thu, 11 Feb 2021 02:57:06 -0800 (PST)
Received: from TRWS9215.usr.ingenico.loc ([95.13.23.74])
        by smtp.gmail.com with ESMTPSA id n6sm3924794ejy.123.2021.02.11.02.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 02:57:05 -0800 (PST)
Date:   Thu, 11 Feb 2021 13:57:04 +0300
From:   Fatih YILDIRIM <yildirim.fatih@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     gustavo@embeddedor.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] staging: ks7010: Macros with complex values
Message-ID: <20210211105704.GA10351@TRWS9215.usr.ingenico.loc>
References: <20210211092239.10291-1-yildirim.fatih@gmail.com>
 <YCUAy1VhLV3lwa3H@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCUAy1VhLV3lwa3H@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 11:02:51AM +0100, Greg KH wrote:
> On Thu, Feb 11, 2021 at 12:22:39PM +0300, Fatih Yildirim wrote:
> > Fix for checkpatch.pl warning:
> > Macros with complex values should be enclosed in parentheses.
> > 
> > Signed-off-by: Fatih Yildirim <yildirim.fatih@gmail.com>
> > ---
> >  drivers/staging/ks7010/ks_hostif.h | 24 ++++++++++++------------
> >  1 file changed, 12 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
> > index 39138191a556..c62a494ed6bb 100644
> > --- a/drivers/staging/ks7010/ks_hostif.h
> > +++ b/drivers/staging/ks7010/ks_hostif.h
> > @@ -498,20 +498,20 @@ struct hostif_mic_failure_request {
> >  #define TX_RATE_FIXED		5
> >  
> >  /* 11b rate */
> > -#define TX_RATE_1M	(u8)(10 / 5)	/* 11b 11g basic rate */
> > -#define TX_RATE_2M	(u8)(20 / 5)	/* 11b 11g basic rate */
> > -#define TX_RATE_5M	(u8)(55 / 5)	/* 11g basic rate */
> > -#define TX_RATE_11M	(u8)(110 / 5)	/* 11g basic rate */
> > +#define TX_RATE_1M	((u8)(10 / 5))	/* 11b 11g basic rate */
> > +#define TX_RATE_2M	((u8)(20 / 5))	/* 11b 11g basic rate */
> > +#define TX_RATE_5M	((u8)(55 / 5))	/* 11g basic rate */
> > +#define TX_RATE_11M	((u8)(110 / 5))	/* 11g basic rate */
> 
> But these are not "complex macros" that need an extra () added to them,
> right?
> 
> Checkpatch is a hint, it's not a code parser and can not always know
> what is happening.  With your knowledge of C, does this look like
> something that needs to be "fixed"?
> 
> thanks,
> 
> greg k-h

Hi Greg,

Thanks for your reply.
Actually, I'm following the Eudyptula Challenge and I'm at task 10.
Task is to find and fix a coding style in linux-next/drivers/staging.
I've checked many files with checkpatch.pl but they are almost fine :)
I found this one and prepared a patch for it.
Thanks in advance for your comments and advice.

Thanks,
Fatih
