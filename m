Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D460A369EF9
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 08:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbhDXGA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 02:00:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:40514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229654AbhDXGAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 02:00:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 652086137D;
        Sat, 24 Apr 2021 06:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619244016;
        bh=5y+JNpXhdcfwvkMSZyc1L+mhCIh3vzIaCOc/xaucCOk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rIIzwE/f2Z1g/HvP86RIhBhxWazNn9/1G1J7uaQXCDlT5QcRqDTdG0Bh6CEH5mHfk
         PnoqjNrOVbg7b6ixi8Fz0+qwstkc1iIeOHJu4AWD9dZ2t1YjCE/PX9Jd4ezokXZT+4
         zUIyw2QyKZVAGPZ8M7S9DGNmPpP8U9WQlvI6AQZI=
Date:   Sat, 24 Apr 2021 08:00:10 +0200
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
Message-ID: <YIOz6o8gwHv+cAN7@kroah.com>
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

Wait, what is "caddr_t"?  Try unwinding that mess first...
