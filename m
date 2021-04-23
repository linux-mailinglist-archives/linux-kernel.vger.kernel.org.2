Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5425369624
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 17:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241174AbhDWP1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 11:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbhDWP1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 11:27:06 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2439DC061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 08:26:28 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id q2so2334470pfk.9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 08:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ALGtkYyLUpCBAJ1o9NtNwPSNEj38bupU6cSgQhJvZ7g=;
        b=pt/c4IGPhTI6pZIzeGammBX8fJIcQBiluwlHn4PG697rZJxtGpsaiV3tQJjivst8KM
         iTiX28Lsi7thwSa5atxwOpEQd7MBoSg0713xT1boUEufVpId/SHoZok89ftAAMiyJYqb
         agmVsZWYb/rsfpspzxQlopE/91g0Y03FPIaoJJcE7SuFa0u5+4Fv/ys2TRcEbg2Sc21E
         6IdcwvoCvtgJVwir6BTP8LS1pKo0blhoeicMm8is+kL28sPwgXkA52kvrcutC/k2Ka/x
         VOrfH4y81Yf7YKmYQR/1fKmhZk85RrDehHVh31X9myqXMR0SoVMsmY0GfhH3oWf19DUp
         LJ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ALGtkYyLUpCBAJ1o9NtNwPSNEj38bupU6cSgQhJvZ7g=;
        b=JQeI2s2LLRTNMOxneeLFIB9lmuWd50vGXg/SJ1ezI3HNhwJOwN0Ey2bQqxvAC14azM
         oFGlMQxCBDgXATzEbxu7q4eQKYiSdemWC/R7BoPXJCils1zaI8D3cv0LNCGBjNsiQ3K2
         I+f8gwb3eGZJdkkZCsWDv75hNdX9PI7fTp1dUvQxoWWYmmG8Am+MHRx+2eIvMFoVrOVe
         4YPOAzxlWBG+KVooq7HshjzdeGAWS4mRnKHe9Ifb5RDpJUr/ztTmKFf/LLIU/vKeNtzR
         Oe74N3NZGEu9pSBCAJI//AaAdf2bMdshEOQFRVa1vrdvbDmIE+GAF50qD2g7SDNBedvT
         yyTg==
X-Gm-Message-State: AOAM5309yfzQful1uY8WBDFeiwrxanqJtqGt0Ry4ERm9XH+kNXgDjOAD
        qY5gayfMSo3iSP9Cb7ba7/I=
X-Google-Smtp-Source: ABdhPJwEGEj0ALSzPIRf16F6cjXUJ6+tqkooFfGXCA6xraKG66yxCu4pIPAIED69ZqO0v7xWh7AClQ==
X-Received: by 2002:a65:4382:: with SMTP id m2mr4350176pgp.354.1619191587483;
        Fri, 23 Apr 2021 08:26:27 -0700 (PDT)
Received: from ashish-NUC8i5BEH ([182.77.14.23])
        by smtp.gmail.com with ESMTPSA id t1sm5044897pjo.33.2021.04.23.08.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 08:26:26 -0700 (PDT)
From:   Ashish Kalra <eashishkalra@gmail.com>
X-Google-Original-From: Ashish Kalra <ashish@ashish-NUC8i5BEH>
Date:   Fri, 23 Apr 2021 20:56:19 +0530
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ashish Kalra <eashishkalra@gmail.com>,
        Abheek Dhawan <adawesomeguy222@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Romain Perier <romain.perier@gmail.com>,
        Waiman Long <longman@redhat.com>,
        Allen Pais <apais@linux.microsoft.com>,
        Ivan Safonov <insafonov@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wlan-ng: silence incorrect type in argument 1
 (different address spaces) warning
Message-ID: <20210423152619.GA2469@ashish-NUC8i5BEH>
References: <20210420090142.GA4086@ashish-NUC8i5BEH>
 <YIE3IffGcjrkz4ZE@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIE3IffGcjrkz4ZE@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 10:43:13AM +0200, Greg Kroah-Hartman wrote:
> On Tue, Apr 20, 2021 at 02:31:42PM +0530, Ashish Kalra wrote:
> > Upon running sparse, "warning: incorrect type in argument 1 (different address spaces)
> > is brought to notice for this file.let's add correct typecast to make it cleaner and
> > silence the Sparse warning.
> > 
> > Signed-off-by: Ashish Kalra <eashishkalra@gmail.com>
> > ---
> >  drivers/staging/wlan-ng/p80211netdev.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/wlan-ng/p80211netdev.c b/drivers/staging/wlan-ng/p80211netdev.c
> > index 6f9666dc0277..70570e8a5ad2 100644
> > --- a/drivers/staging/wlan-ng/p80211netdev.c
> > +++ b/drivers/staging/wlan-ng/p80211netdev.c
> > @@ -569,7 +569,7 @@ static int p80211knetdev_do_ioctl(struct net_device *dev,
> >  		goto bail;
> >  	}
> >  
> > -	msgbuf = memdup_user(req->data, req->len);
> > +	msgbuf = memdup_user((void __user *)req->data, req->len);
> 
> Why isn't data being declared as a __user pointer to start with?  Why is
> the cast needed here?
> 
> This feels wrong as if it is papering over the real problem.
> 
> thanks,
> 
> greg k-h
Thanks for your inputs
variable data in structure p80211ioctl_req is used only inside this function and is 
already casted to void __user * for copy_to_user. Should it be changed 
to void __user from caadr_t inside p80211ioctl.h. it should be same at runtime

--- a/drivers/staging/wlan-ng/p80211ioctl.h
+++ b/drivers/staging/wlan-ng/p80211ioctl.h
@@ -81,7 +81,7 @@
 
 struct p80211ioctl_req {
        char name[WLAN_DEVNAMELEN_MAX];
-       caddr_t data;
+       void __user *data;

Does this looks ok to you and is there any other check possible if this is ok?

Regards
Ashish  

