Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEBD73F9BB4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 17:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245460AbhH0P2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 11:28:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:43328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234044AbhH0P2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 11:28:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF09160232;
        Fri, 27 Aug 2021 15:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630078047;
        bh=YcuO1NmAv8VjO+U1iC07eG0TGAhra6EY6qYLzMjAgaA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ytgMCOlbA8xS9fK9fADxvgDVtHAxdZZdYbdHl8d9L3G439mhJbneI4c0KYZuBASB3
         SMTgmLPBYH9WPgyZhav/y7Pi7t5xq8ceOTnJbwi5Ymf7CnygBMjEO0Lgu4t5qfY6ko
         siwjxk2LH/DxcEJaereaBerz4SWfaS5AN1/TGkZQ=
Date:   Fri, 27 Aug 2021 17:27:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH 5/5] staging: r8188eu: Use vsprintf extension %phCX to
 format a copy_to_user string
Message-ID: <YSkEWBbOJmNSI4zn@kroah.com>
References: <cover.1630003183.git.joe@perches.com>
 <152e1b8f84c4686ea38182ca55344ed7f2cede65.1630003183.git.joe@perches.com>
 <YSildgE0Ul4akIUJ@kroah.com>
 <903a73b791466918ca72c8fc62406acb86e93018.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <903a73b791466918ca72c8fc62406acb86e93018.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 08:23:31AM -0700, Joe Perches wrote:
> On Fri, 2021-08-27 at 10:42 +0200, Greg Kroah-Hartman wrote:
> > On Thu, Aug 26, 2021 at 11:43:05AM -0700, Joe Perches wrote:
> > > This reduces object size without changing the string content.
> > > 
> > > compiled x86-64 defconfig w/ r8188eu and gcc 10.3.0
> > > 
> > > $ size drivers/staging/r8188eu/os_dep/ioctl_linux.o*
> > >    text	   data	    bss	    dec	    hex	filename
> > >   72556	   1548	      0	  74104	  12178	drivers/staging/r8188eu/os_dep/ioctl_linux.o.new
> > >   72758	   1548	      0	  74306	  12242	drivers/staging/r8188eu/os_dep/ioctl_linux.o.old
> > > 
> > > Signed-off-by: Joe Perches <joe@perches.com>
> > > ---
> > >  drivers/staging/r8188eu/os_dep/ioctl_linux.c | 9 +++------
> > >  1 file changed, 3 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> > > index ab4a9200f0791..048164659d872 100644
> > > --- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> > > +++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> > > @@ -2907,10 +2907,8 @@ static int rtw_p2p_get_groupid(struct net_device *dev,
> > >  	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
> > >  	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
> > >  
> > > 
> > > -	sprintf(extra, "\n%.2X:%.2X:%.2X:%.2X:%.2X:%.2X %s",
> > > -		pwdinfo->groupid_info.go_device_addr[0], pwdinfo->groupid_info.go_device_addr[1],
> > > -		pwdinfo->groupid_info.go_device_addr[2], pwdinfo->groupid_info.go_device_addr[3],
> > > -		pwdinfo->groupid_info.go_device_addr[4], pwdinfo->groupid_info.go_device_addr[5],
> > > +	sprintf(extra, "\n%pM %s",
> > > +		pwdinfo->groupid_info.go_device_addr,
> > >  		pwdinfo->groupid_info.ssid);
> > 
> > We can just use the lower-case one here, no need for a new modifier just
> > for something like this (i.e. log file output)
> 
> That was just a trivial conversion of log file output and is lower case
> as log file output is not ABI.
> 
> The copy_to_user bit (2nd diff block) is nominally an ABI and is upper case.
> IMO at a minimum, it's bad form to change it.
> 
> @@ -3075,8 +3073,7 @@ static int rtw_p2p_get_go_device_address(struct net_device *dev,
>         if (!blnMatch)
>                 sprintf(go_devadd_str, "\n\ndev_add = NULL");
>         else
> -               sprintf(go_devadd_str, "\ndev_add =%.2X:%.2X:%.2X:%.2X:%.2X:%.2X",
> -                       attr_content[0], attr_content[1], attr_content[2], attr_content[3], attr_content[4], attr_content[5]);
> +               sprintf(go_devadd_str, "\ndev_add =%6phCX", attr_content);
>  
>         if (copy_to_user(wrqu->data.pointer, go_devadd_str, 10 + 17))
>                 return -EFAULT;

That looks like a horrible driver-specific api that no one will really
be using and will be removed from the tree soon.  So it can be changed,
no need to worry about any "compatibility" issues here.

thanks,

greg k-h
