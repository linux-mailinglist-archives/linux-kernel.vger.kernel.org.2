Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF5F435AD4D
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 14:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234427AbhDJMei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 08:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234091AbhDJMeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 08:34:36 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8441DC061762
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 05:34:21 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id mj7-20020a17090b3687b029014d162a65b6so6324599pjb.2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 05:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PXHn0JTgY+La3+5YIGKYFWelzukB7RedFElx6gczrqk=;
        b=KPPCL8xefCVfIQ/eO0Gf7y0/Jx3dpw/yEh+nij8tebQlWjMY2IBKtk2rpnv3mSWkvq
         24EnqrK6KwfPinNDIJZq5KlFIR/b9TlXxqIOfd8u8dfj4Kz0PJuq2bMYsyJcJI5wK/Ff
         EvGmVWkoI9N21zSWE6ikaobNvPynGiKELZXS04ydxV3KZgJcrbNHZ6fcJTP9Qd3D6iAl
         +MXGCZ5ojWEJE2lzPauji9RsbwFa77A135b9mCKlLC9EWM7ArZl7104lyxmF4DVI27yh
         eHSIMi9BmYlHaOZnli5ao3t8ydxhwdm5fOAikLT4AorejTFNiitzaF8RcAHBn8IEURPR
         zEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PXHn0JTgY+La3+5YIGKYFWelzukB7RedFElx6gczrqk=;
        b=aSJerJIRJ19vDklIa2A6Sa/NJYJ41EKM/sHd81qD8ELdYaF4tTw7s+ABoUGiHxaygg
         KcIMr//almOwn2i0VS3+lpKRX6nAe9blHsCCOR43EynzNSYu0m4r75iegERVg1U8Q7JL
         xQ9IHAVyPnHYjGnyMjmxefDz+rZErDVNbBpjpBu4F8CzHb2L8+xsNFU1/swmr2XtFlrZ
         9pD0/+8Eu420eRFY7zdsOADTrj5eXBbdsoec8uijcjNK/lKYFC0oDY8i67CoiYGnsAQ6
         Z64B8iEC+7Ps8flU5WsFElllfVyd1ClJhxi7kMaZc7yaaTseXBykFp1KIOuHXYzWL8r3
         8+tA==
X-Gm-Message-State: AOAM531NW3hGCV2MZdM2pFU7Gca20iBrKZNFbQlkXhJLU/VR1ExgHQAk
        WEwyY+/KIpki7FDoLuxCwv8=
X-Google-Smtp-Source: ABdhPJzwTMEdOsR0vy3cArPM/2aBvJDhgMNvXNE+UCI4/J7xEYgsSSDCbRVv3ksuHZYN1E6X62TwVA==
X-Received: by 2002:a17:90a:4309:: with SMTP id q9mr18091539pjg.40.1618058060802;
        Sat, 10 Apr 2021 05:34:20 -0700 (PDT)
Received: from kali ([103.141.87.253])
        by smtp.gmail.com with ESMTPSA id fs9sm5109138pjb.40.2021.04.10.05.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 05:34:20 -0700 (PDT)
Date:   Sat, 10 Apr 2021 18:04:11 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: Re: [Outreachy kernel] [PATCH] staging: rtl8192e: replace comparison
 to NULL by bool
Message-ID: <YHGbQ+y0Fplssz44@kali>
References: <YHDnWpWztxeZospi@kali>
 <alpine.DEB.2.22.394.2104101408100.2975@hadrien>
 <YHGVvn8Yi0tWL3sa@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHGVvn8Yi0tWL3sa@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2021 at 02:10:38PM +0200, Greg KH wrote:
> On Sat, Apr 10, 2021 at 02:08:30PM +0200, Julia Lawall wrote:
> > 
> > 
> > On Sat, 10 Apr 2021, Mitali Borkar wrote:
> > 
> > > Fixed Comparison to NULL can be written as '!...' by replacing it with
> > > simpler form i.e boolean expression. This makes code more readable alternative.
> > > Reported by checkpatch.
> > >
> > > Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
> > > ---
> > >  drivers/staging/rtl8192e/rtl819x_TSProc.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
> > > index 65eac33aaa5b..476875125e87 100644
> > > --- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
> > > +++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
> > > @@ -269,12 +269,12 @@ static void MakeTSEntry(struct ts_common_info *pTsCommonInfo, u8 *Addr,
> > >  {
> > >  	u8	count;
> > >
> > > -	if (pTsCommonInfo == NULL)
> > > +	if (!pTsCommonInfo)
> > >  		return;
> > >
> > >  	memcpy(pTsCommonInfo->Addr, Addr, 6);
> > >
> > > -	if (pTSPEC != NULL)
> > > +	if (pTSPEC)
> > >  		memcpy((u8 *)(&(pTsCommonInfo->TSpec)), (u8 *)pTSPEC,
> > >  		       sizeof(union tspec_body));
> > >
> > > @@ -328,7 +328,7 @@ bool GetTs(struct rtllib_device *ieee, struct ts_common_info **ppTS,
> > >  	}
> > >
> > >  	*ppTS = SearchAdmitTRStream(ieee, Addr, UP, TxRxSelect);
> > > -	if (*ppTS != NULL)
> > > +	if (ppTS)
> > 
> > You lost a * here.
> 
> Ugh, good catch.
> 
> Mitali, can you send me a fix-up patch for this, or do you want me to
> drop your original patch from my tree?
>
Yes Sir, I am making corrections right now in this patch. Will send the
fix up patch in an hour.


> thanks,
> 
> greg k-h
