Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8C436CBF2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 21:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238666AbhD0Tq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 15:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235661AbhD0TqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 15:46:25 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00712C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 12:45:41 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id t22so7847125pgu.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 12:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=POiC7h/F8qpkmD5ylKPAvYAOcZ8fi4a52UGHvA+ZtQ4=;
        b=TeJuSOXojjbA1rVQyoZwAOnynby0MYLM2ZDasr1NI4HtlJ0bAOOggGnpJkFpmAidHM
         BNmz4OwVy5fQbJBJ3VBLTcUNUdNg+RtN8KrvMoKILiN/Qa5AJAvd0ejQBKL2n5YQARxM
         zAocbM+Ji7OLgNvuVRKqJsONC9x5DGCDy5eXIE8JeY96PqdvcZjdUsGGtNkIE0+926QF
         5UH7J6Icn6E3WPSfvn6LlmVvg1+Uj5OfK5hIVXQILATxLKsHv5yEZk8nfHme7AGBb5tK
         lqw4T4ae9B307cVNcykwyeGQE88RVwL674HBbl0A/261/FYpWsoiFlKcFq1g2x8mEF+/
         ZXBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=POiC7h/F8qpkmD5ylKPAvYAOcZ8fi4a52UGHvA+ZtQ4=;
        b=UVWVfZ09uLvlCUdtUhu/SsM/EUpNRqhKzO9XL083lvI29rQ8O3D8KTg4qRcySNrslN
         ZCk0S9x4JwQ7FMR5Rl9WVAcRnX1lGW8k3Fj5wkVzXW2PTLIAfGONDhsD5uvYPL7gtXow
         Fox3nnV4BAbuDRgb7TWB/it4Eb8fSyhJIYKigPs9r2b+gwWHNHU1uDVVmvxOwxUFhvRz
         r+R3S3HcMwu2wt2VElg//MVGmDZ9DSt3WX6A1RILQM/LP1kCHlEoTfVnwylbS+3qJfwo
         jKB05L863g0lBNNRxfwIG2oblVjvLWQlRFYh+xrY63ty7mbjNNCZn2Q/UbeiWCNuBcUa
         fx2A==
X-Gm-Message-State: AOAM5320IkuMbjsP49vcXEyg3AqusFc89uczErNUTXAgfDRZyI3IBomz
        bL0D2eqdrM0ec9vKQ8tpCEg=
X-Google-Smtp-Source: ABdhPJzvWZFCer3sa4EycqmukaIrqOzHyO/TpDSj7iuOddThtjgV7E5pj7tkfJu+kXwrYC8GLg9ryw==
X-Received: by 2002:a05:6a00:24cd:b029:27c:bbd5:1660 with SMTP id d13-20020a056a0024cdb029027cbbd51660mr296433pfv.40.1619552741431;
        Tue, 27 Apr 2021 12:45:41 -0700 (PDT)
Received: from user ([2001:4490:4409:fe15:9fd0:fa2c:4efc:28b5])
        by smtp.gmail.com with ESMTPSA id n11sm3392269pff.96.2021.04.27.12.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 12:45:40 -0700 (PDT)
Date:   Wed, 28 Apr 2021 01:15:33 +0530
From:   SAURAV GIREPUNJE <saurav.girepunje@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        hello@bryanbrattlof.com, hdegoede@redhat.com,
        saurav.girepunje@google.com, john.oldman@polehill.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        saurav.girepunje@hotmail.com
Subject: Re: [PATCH] staging: rtl8723bs: os_dep: remove multiple return
Message-ID: <20210427194533.GC11046@user>
References: <20210418173233.GA59153@user>
 <20210420110609.GD1981@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420110609.GD1981@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 02:06:09PM +0300, Dan Carpenter wrote:
> On Sun, Apr 18, 2021 at 11:02:33PM +0530, Saurav Girepunje wrote:
> > on sdio_intf.c rtw_sdio_suspend call we have multiple
> > return which can replace by goto exit. As in all the places
> > return value is 0.
> > 
> > Signed-off-by: Saurav Girepunje <saurav.girepunje@google.com>
> > ---
> >  drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> > index a9a9631dd23c..3e566cf97f6e 100644
> > --- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> > +++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> > @@ -445,14 +445,17 @@ static int rtw_sdio_suspend(struct device *dev)
> >  	struct debug_priv *pdbgpriv = &psdpriv->drv_dbg;
> >  
> >  	if (padapter->bDriverStopped)
> > -		return 0;
> > +		goto exit;
> >  
> >  	if (pwrpriv->bInSuspend) {
> >  		pdbgpriv->dbg_suspend_error_cnt++;
> > -		return 0;
> > +		goto exit;
> >  	}
> >  
> > -	return rtw_suspend_common(padapter);
> > +	rtw_suspend_common(padapter);
> 
> Also it's weird that your previous patch made rtw_suspend_common()
> return zero unconditionally.  But now we're modifying the only caller to
> not check the return.  Just make rtw_suspend_common() void and change
> this to:
> 
> 	rtw_suspend_common(padapter);
> 
> 	return 0;
> 
> regards,
> dan carpenter
>

Sure, rtw_suspend_common always return 0. It should be void.
I will merge and resend the patch.
