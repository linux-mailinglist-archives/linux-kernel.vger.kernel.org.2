Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49EEB34FE2A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 12:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhCaKgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 06:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234862AbhCaKgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 06:36:36 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32EEC061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 03:36:35 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id l18so21723798edc.9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 03:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=psGbAtFNcu5ED/UDNB3lCu6rq++to5JqkbeYH9vux0g=;
        b=j/mXdgAf42FIcClhqWC0WlPM7lGfrjxfC+C7Y2vOc7NTfskbcrtVx/+R6GdiAUbkCn
         LPwdrXfqrBkgbEvsl33uHtPfZqdAJXtF37P48soMjRNcTHCuzabYi8/w67iWFJiACU08
         xsOx4cZ2Bm/IfWOPYmP3nSP1LkOdTFI4lARF88bXkHM3fXUiMYwzmP7jU0iMTwLGS/9t
         qVEIj10y7NAxuc2hQuhooGEuqdDcUcsZna+1sBK2wc19MXyATx39e3XBRVy7IbeYIhzg
         4Gz2izrqWzd9WsnrgVnjHsHY11/IZV1VHWtCt7OZLV9KJExa6yxkry9FEBKrWqU05fRs
         wQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=psGbAtFNcu5ED/UDNB3lCu6rq++to5JqkbeYH9vux0g=;
        b=TcNfDmVPyDtkJBNONNdD+/SD4d+489pJ1DFDlUnfn6qgoH2kANjvW4dMmqy9SKi5YA
         tz9Fvr6QyozBTDgk564rk+XYRnIDCtq4HYkMLpo+eMiaCIbFr6sUOeixy3k0td2cdWwY
         /lIO86+ZR9701DJAclWQhJ89Vi5FTGQzqgqgT0hFJuCPi6muBB8OL7Y3uqvgbWuGUB1P
         3RDrChheM3UUSbimUVtvonV5MiTZ6UYnYDZyIDz6Mqlx6ab8w3RjVRkaC9CiNASwxLVl
         oxwQh4B3tprCemrYyaIkv+NsM9lMR2BQ7hTeDg7kB6O2+cX7hYKalDjuE9H1EbdXQ7R5
         FAJg==
X-Gm-Message-State: AOAM531VYKpesYnRcbnwkgyzrEmZ4PfMkQTxw56pjc1YUNq2Oe8L7gwD
        gAwj8mBS6KVX2YGMMlOovLw=
X-Google-Smtp-Source: ABdhPJx/vfml6QnDlmi5412iIO6VWeNDhS+sZjmBNo7GFOv+ojHFTNkFP8V6JpUd756sMevCYTp0Fg==
X-Received: by 2002:a05:6402:2070:: with SMTP id bd16mr2795802edb.133.1617186994718;
        Wed, 31 Mar 2021 03:36:34 -0700 (PDT)
Received: from agape.jhs ([5.171.73.44])
        by smtp.gmail.com with ESMTPSA id la15sm916096ejb.46.2021.03.31.03.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 03:36:34 -0700 (PDT)
Date:   Wed, 31 Mar 2021 12:36:31 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/40] staging: rtl8723bs: replace RT_TRACE with public
 printk wrappers in core/rtw_eeprom.c
Message-ID: <20210331103630.GA1450@agape.jhs>
References: <cover.1617183374.git.fabioaiuto83@gmail.com>
 <39c2cd878bc914a00e71ea988c3cacb651670822.1617183374.git.fabioaiuto83@gmail.com>
 <YGROiD19tgF8XnK6@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGROiD19tgF8XnK6@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 12:27:20PM +0200, Greg KH wrote:
> On Wed, Mar 31, 2021 at 11:39:31AM +0200, Fabio Aiuto wrote:
> > replace private macro RT_TRACE for tracing with in-kernel
> > pr_* printk wrappers
> > 
> > Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> > ---
> >  drivers/staging/rtl8723bs/core/rtw_eeprom.c | 26 ++++++++++-----------
> >  1 file changed, 13 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8723bs/core/rtw_eeprom.c b/drivers/staging/rtl8723bs/core/rtw_eeprom.c
> > index 3cbd65dee741..6176d741d60e 100644
> > --- a/drivers/staging/rtl8723bs/core/rtw_eeprom.c
> > +++ b/drivers/staging/rtl8723bs/core/rtw_eeprom.c
> > @@ -36,7 +36,7 @@ void shift_out_bits(_adapter *padapter, u16 data, u16 count)
> >  _func_enter_;
> >  
> >  	if (padapter->bSurpriseRemoved == true) {
> > -		RT_TRACE(_module_rtl871x_eeprom_c_, _drv_err_, ("padapter->bSurpriseRemoved==true"));

I looked at this ---------------------------------------^
and so I thought that pr_err was good...

> > +		pr_err("%s padapter->bSurpriseRemoved==true", DRIVER_PREFIX);
> 
> As Dan said, this is not the same thing.  You are now always printing
> out this mess, when before you were not unless you explicitly enabled
> "tracing".
> 
> And you are sending it to the error log?
> 
> And finally, drivers should never be using pr_*() for messages, they
> should be using dev_*() instead as they are a driver and have access to
> a device pointer.
> 

thank you, I didn't know about dev_*

> thanks,
> 
> greg k-h

my aim was remove private macros replicating component tracing and log levels...

so what's best? Keep a simplyfied RT_TRACE encapsulating a dev_* call?

thank you,

fabio

