Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15C5F369EF8
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 08:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbhDXGA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 02:00:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:40224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229654AbhDXGA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 02:00:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F2B7761476;
        Sat, 24 Apr 2021 05:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619243989;
        bh=Ni5d0JFTtplCZtSRb+Wqkkju1qYBWYjLXRgjMgmIFyY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=InGnb4K6jRYCpaXeCghwec/WL0SusiCBRgQ5c724yz2h8z0rCgtur+RxbVa+m0yH5
         k7AttLi405RJ2xAOMHEJTNSEwrb8IfUvcW3EM+vvawhe5y2ETuVXrGXRQImbbq8oOi
         IMaxMiy3c0aH/2QCzqYMIWtrxRptSfZX88Flc5fQ=
Date:   Sat, 24 Apr 2021 07:59:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ashish Kalra <eashishkalra@gmail.com>
Cc:     Abheek Dhawan <adawesomeguy222@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Romain Perier <romain.perier@gmail.com>,
        Waiman Long <longman@redhat.com>,
        Allen Pais <apais@linux.microsoft.com>,
        Ivan Safonov <insafonov@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wlan-ng: silence incorrect type in argument 1
 (different address spaces) warning
Message-ID: <YIOz0LwSP5mmPYIg@kroah.com>
References: <20210420090142.GA4086@ashish-NUC8i5BEH>
 <YIE3IffGcjrkz4ZE@kroah.com>
 <20210423152619.GA2469@ashish-NUC8i5BEH>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423152619.GA2469@ashish-NUC8i5BEH>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 08:56:19PM +0530, Ashish Kalra wrote:
> On Thu, Apr 22, 2021 at 10:43:13AM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Apr 20, 2021 at 02:31:42PM +0530, Ashish Kalra wrote:
> > > Upon running sparse, "warning: incorrect type in argument 1 (different address spaces)
> > > is brought to notice for this file.let's add correct typecast to make it cleaner and
> > > silence the Sparse warning.
> > > 
> > > Signed-off-by: Ashish Kalra <eashishkalra@gmail.com>
> > > ---
> > >  drivers/staging/wlan-ng/p80211netdev.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/staging/wlan-ng/p80211netdev.c b/drivers/staging/wlan-ng/p80211netdev.c
> > > index 6f9666dc0277..70570e8a5ad2 100644
> > > --- a/drivers/staging/wlan-ng/p80211netdev.c
> > > +++ b/drivers/staging/wlan-ng/p80211netdev.c
> > > @@ -569,7 +569,7 @@ static int p80211knetdev_do_ioctl(struct net_device *dev,
> > >  		goto bail;
> > >  	}
> > >  
> > > -	msgbuf = memdup_user(req->data, req->len);
> > > +	msgbuf = memdup_user((void __user *)req->data, req->len);
> > 
> > Why isn't data being declared as a __user pointer to start with?  Why is
> > the cast needed here?
> > 
> > This feels wrong as if it is papering over the real problem.
> > 
> > thanks,
> > 
> > greg k-h
> Thanks for your inputs
> variable data in structure p80211ioctl_req is used only inside this function and is 
> already casted to void __user * for copy_to_user. Should it be changed 
> to void __user from caadr_t inside p80211ioctl.h. it should be same at runtime
> 
> --- a/drivers/staging/wlan-ng/p80211ioctl.h
> +++ b/drivers/staging/wlan-ng/p80211ioctl.h
> @@ -81,7 +81,7 @@
>  
>  struct p80211ioctl_req {
>         char name[WLAN_DEVNAMELEN_MAX];
> -       caddr_t data;
> +       void __user *data;
> 
> Does this looks ok to you and is there any other check possible if this is ok?

THat looks better.  What does running sparse on that change show?

thanks,

greg k-h
