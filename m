Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCCD935AD34
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 14:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234607AbhDJMK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 08:10:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:57554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231279AbhDJMKz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 08:10:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D1C5B611AF;
        Sat, 10 Apr 2021 12:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618056641;
        bh=QuA4EydXG7LZzEytUN7b8Jvd71QrqnoFflurUJs9urc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dr/FtupipdisbBRRu+vyTZv4a2w2I2tvLoEG0CmGOBKXnsP9xjsOGM/TZlphzbZzz
         6PG/1jeQ5Y5fU/nq5y1IkHOWYOZjG/Q3mq0nmPCx/uFsOzEZ4RX7jPYPn0VDqPAr61
         gr//Nvu0O0NHlYxB3vjAotho7PofzN4aIf7I8aRg=
Date:   Sat, 10 Apr 2021 14:10:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Mitali Borkar <mitaliborkar810@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: Re: [Outreachy kernel] [PATCH] staging: rtl8192e: replace comparison
 to NULL by bool
Message-ID: <YHGVvn8Yi0tWL3sa@kroah.com>
References: <YHDnWpWztxeZospi@kali>
 <alpine.DEB.2.22.394.2104101408100.2975@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2104101408100.2975@hadrien>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2021 at 02:08:30PM +0200, Julia Lawall wrote:
> 
> 
> On Sat, 10 Apr 2021, Mitali Borkar wrote:
> 
> > Fixed Comparison to NULL can be written as '!...' by replacing it with
> > simpler form i.e boolean expression. This makes code more readable alternative.
> > Reported by checkpatch.
> >
> > Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
> > ---
> >  drivers/staging/rtl8192e/rtl819x_TSProc.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
> > index 65eac33aaa5b..476875125e87 100644
> > --- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
> > +++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
> > @@ -269,12 +269,12 @@ static void MakeTSEntry(struct ts_common_info *pTsCommonInfo, u8 *Addr,
> >  {
> >  	u8	count;
> >
> > -	if (pTsCommonInfo == NULL)
> > +	if (!pTsCommonInfo)
> >  		return;
> >
> >  	memcpy(pTsCommonInfo->Addr, Addr, 6);
> >
> > -	if (pTSPEC != NULL)
> > +	if (pTSPEC)
> >  		memcpy((u8 *)(&(pTsCommonInfo->TSpec)), (u8 *)pTSPEC,
> >  		       sizeof(union tspec_body));
> >
> > @@ -328,7 +328,7 @@ bool GetTs(struct rtllib_device *ieee, struct ts_common_info **ppTS,
> >  	}
> >
> >  	*ppTS = SearchAdmitTRStream(ieee, Addr, UP, TxRxSelect);
> > -	if (*ppTS != NULL)
> > +	if (ppTS)
> 
> You lost a * here.

Ugh, good catch.

Mitali, can you send me a fix-up patch for this, or do you want me to
drop your original patch from my tree?

thanks,

greg k-h
