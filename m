Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB7336C630
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 14:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236039AbhD0Mkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 08:40:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:54886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235410AbhD0Mkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 08:40:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A9D3613C2;
        Tue, 27 Apr 2021 12:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619527198;
        bh=c5N3WbqsojdSsTwqANIzFRqj+y1qdfjxsQVVwX7SktQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A6oPTDnuuxTg+YCpj9Nm7KnWelXw87PIcEo3nOIuK7GSMt2jGL7RyFuMn3ZEfrdDB
         0YNRzhZtN/FHQqLfWaPGxjdur9sMcFgV6wZOXfDj+mND5VRHQUzLP9+EIOdts7vhKK
         hO0c4oRBYDZKS6GfN9rYCVJJuutF61NbnGdDgQRs=
Date:   Tue, 27 Apr 2021 14:39:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     ashish <eashishkalra@gmail.com>
Cc:     Joe Perches <joe@perches.com>,
        Abheek Dhawan <adawesomeguy222@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Romain Perier <romain.perier@gmail.com>,
        Waiman Long <longman@redhat.com>,
        Allen Pais <apais@linux.microsoft.com>,
        Ivan Safonov <insafonov@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wlan-ng: silence incorrect type in argument 1
 (different address spaces) warning
Message-ID: <YIgGHNP2pWI7bYsI@kroah.com>
References: <20210420090142.GA4086@ashish-NUC8i5BEH>
 <YIE3IffGcjrkz4ZE@kroah.com>
 <20210423152619.GA2469@ashish-NUC8i5BEH>
 <YIOz6o8gwHv+cAN7@kroah.com>
 <bc8873a274bf489ad856386a9d9ee1110de4c4d3.camel@perches.com>
 <20210424081529.GA1731@ubuntu>
 <YIPWq6rp246rg9D0@kroah.com>
 <YIgCQtwK8tpGSOQ5@ashish-NUC8i5BEH>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YIgCQtwK8tpGSOQ5@ashish-NUC8i5BEH>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 05:53:30PM +0530, ashish wrote:
> On Sat, Apr 24, 2021 at 10:28:27AM +0200, Greg Kroah-Hartman wrote:
> > On Sat, Apr 24, 2021 at 01:45:29PM +0530, Ashish Kalra wrote:
> > > On Fri, Apr 23, 2021 at 11:11:05PM -0700, Joe Perches wrote:
> > > > On Sat, 2021-04-24 at 08:00 +0200, Greg Kroah-Hartman wrote:
> > > > > On Fri, Apr 23, 2021 at 08:56:19PM +0530, Ashish Kalra wrote:
> > > > > > On Thu, Apr 22, 2021 at 10:43:13AM +0200, Greg Kroah-Hartman wrote:
> > > > > > > On Tue, Apr 20, 2021 at 02:31:42PM +0530, Ashish Kalra wrote:
> > > > > > > > Upon running sparse, "warning: incorrect type in argument 1 (different address spaces)
> > > > > > > > is brought to notice for this file.let's add correct typecast to make it cleaner and
> > > > > > > > silence the Sparse warning.
> > > > []
> > > > > >  struct p80211ioctl_req {
> > > > > >         char name[WLAN_DEVNAMELEN_MAX];
> > > > > > -       caddr_t data;
> > > > > > +       void __user *data;
> > > > > > 
> > > > > > Does this looks ok to you and is there any other check possible if this is ok?
> > > > > 
> > > > > Wait, what is "caddr_t"?  Try unwinding that mess first...
> > > > 
> > > > Might not be that simple.
> > > > 
> > > > include/linux/types.h:typedef __kernel_caddr_t  caddr_t;
> > > > include/uapi/linux/coda.h:typedef void * caddr_t;
> > > > include/uapi/asm-generic/posix_types.h:typedef char *           __kernel_caddr_t;
> > > > 
> > > > 
> > > data is part of p80211ioctl_req and is used at two places only inside p80211knetdev_do_ioctl
> > > it seems both places it will be used as void __user* only
> > > 
> > > 	msgbuf = memdup_user(req->data, req->len);
> > >         
> > > 	if (result == 0) {
> > >                 if (copy_to_user
> > >                     ((void __user *)req->data, msgbuf, req->len)) {
> > >                         result = -EFAULT;
> > >                 }
> > >         }
> > > 
> > > Will it still be problem if we change it from char * to void *.?
> > 
> > Why do you want to change it to void *?  Never use a void * unless it
> > has to point to unknown data.  That does not seem the case here.
> > 
> > > is there any way to check how caller of this function will be using it?
> > 
> > Look at the code to determine this...
> > 
> > thanks,
> > 
> > greg k-h
> Thanks Greg and Joe
> I have found that adding __user to data is also fixing this warning, 
> It should be fine logically to make this change
> Please share your opinion and will post v2 for this patch
> 
> --- a/drivers/staging/wlan-ng/p80211ioctl.h
> +++ b/drivers/staging/wlan-ng/p80211ioctl.h
> @@ -81,7 +81,7 @@
> 
>  struct p80211ioctl_req {
>         char name[WLAN_DEVNAMELEN_MAX];
> -       caddr_t data;
> +       char __user *data;
>         u32 magic;
>         u16 len;
>         u32 result;
> -- 
> 2.30.2
> 
> 
> 

What do you think, try it and see and if you think it is correct, please
submit that change.  Don't wait for us...

thanks,

greg k-h
