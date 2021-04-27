Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E35FE36CB80
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 21:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236775AbhD0TMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 15:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbhD0TMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 15:12:48 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581AEC061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 12:12:05 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id p17so5527445plf.12
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 12:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+SROfjuDf0LvnCgRM16+n6964r7e8cgU3/0ENTxesNQ=;
        b=lTEqBuj+nVbGPVu8/uF08bM5OB0fBAGKcFrX5ZyGjgnBpDwkl7BzvdT+RwRhGZzPfe
         RxU3qoJcWVbz4h1nM0Rnwqk3VOxuy1/DbkqCzudiATVfPiUxk6AdKXC23gW1aXwBT//D
         TGnQsjInr0CNB9kWpQs9CwVmyJniMH7SZpDa8lUKBJAgpSmt3+BVL/3ZMJh3eYrg+V2y
         AiggLKzxpiBb0GqiCzHcypwtg4GncxIppvkn1R3WFEHbdk6WxBJtKgyKFinuK73K67eE
         QS8jYYmG/+rhTqeKkuKF2EIqAjwHyd4IMOxAJ05kp+BzEJZbRX+RubssHw4bpVq3azjS
         eTog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+SROfjuDf0LvnCgRM16+n6964r7e8cgU3/0ENTxesNQ=;
        b=ghq0baglmIo+LIKGoFN6XctARIhi6Mf6hQSiTq6lEvsG3E0NMpszUBOLWQSF0aqSU9
         BxYMhMzIjkTvhgPHky6kUt1zmMOcP4wODvrJSCdz/GrLh7+h5r6uvPXQEJGxGSr4ag0n
         KyBw0TQ3B9tQOQgS6A+Um9KT77/pYw0ZNBOWUrl/EDZq8c0mDxmwEgZfaH+TnGW6/dEX
         Q+YBSQmSGmbgQoEQuqiXMs8LvHan3waJVjKLlJ/+awnzOqo+dUuWzXDdoJ+uXuuc+Z2P
         /KzeJ+iDBGku/w12fqDiK/2QfdMffPtccLCeY/D6IDl/DihDFJG2/4poLZEmmZXJWPlt
         d2rw==
X-Gm-Message-State: AOAM533+ZgVUlVxCZbIAdf3jQEuTPkeAAOTPBOET1bkE8MAMVjMLgX1G
        iv8pWfIp89mlP695dqxS5G2zRPFh9fnuNg==
X-Google-Smtp-Source: ABdhPJzcStLi1h7eE+Z2wOdg2Jmaq3PfNgkRNJlHpssKF2f3V0yCK/CgtPVt68V+d5Ejs8lrEPZi9Q==
X-Received: by 2002:a17:903:2288:b029:eb:6ca4:6493 with SMTP id b8-20020a1709032288b02900eb6ca46493mr26053305plh.85.1619550724769;
        Tue, 27 Apr 2021 12:12:04 -0700 (PDT)
Received: from user ([2001:4490:4409:fe15:9fd0:fa2c:4efc:28b5])
        by smtp.gmail.com with ESMTPSA id d1sm2790990pjs.12.2021.04.27.12.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 12:12:04 -0700 (PDT)
Date:   Wed, 28 Apr 2021 00:41:56 +0530
From:   SAURAV GIREPUNJE <saurav.girepunje@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     fabioaiuto83@gmail.com, john.oldman@polehill.co.uk,
        ross.schm.dev@gmail.com, marcocesati@gmail.com,
        insafonov@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, saurav.girepunje@hotmail.com
Subject: Re: [PATCH] staging: rtl8723bs: os_dep: remove unneeded variable ret
Message-ID: <20210427191156.GA11046@user>
References: <20210418164813.GA57451@user>
 <YIE2o/T9rKgm7TWm@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIE2o/T9rKgm7TWm@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 10:41:07AM +0200, Greg KH wrote:
> On Sun, Apr 18, 2021 at 10:18:13PM +0530, Saurav Girepunje wrote:
> > Fix the following coccicheck warning:
> > 
> > drivers/staging/rtl8723bs/os_dep/os_intfs.c:1156:5-8:
> > Unneeded variable: "ret". Return "0" on line 1199
> > 
> > Signed-off-by: Saurav Girepunje <saurav.girepunje@google.com>
> > ---
> >  drivers/staging/rtl8723bs/os_dep/os_intfs.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
> > index 1f34cb2e367c..920ec25c9a4f 100644
> > --- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
> > +++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
> > @@ -1153,7 +1153,6 @@ int rtw_suspend_common(struct adapter *padapter)
> >  	struct pwrctrl_priv *pwrpriv = dvobj_to_pwrctl(psdpriv);
> >  	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
> >  
> > -	int ret = 0;
> >  	unsigned long start_time = jiffies;
> >  
> >  	DBG_871X_LEVEL(_drv_always_, " suspend start\n");
> > @@ -1196,7 +1195,7 @@ int rtw_suspend_common(struct adapter *padapter)
> >  
> >  exit:
> >  
> > -	return ret;
> > +	return 0;
> >  }
> >  
> >  static int rtw_resume_process_normal(struct adapter *padapter)
> > -- 
> > 2.25.1
> > 
> > 
> 
> If this function can only ever return 0, why is it returning anything at
> all?  Please fix it up to not do that.
> 
> thanks,
> 
> greg k-h

Yes,this function always return 0. Function return type could be change
to void. I will send another patch.
