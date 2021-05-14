Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF33380BD0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 16:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbhENObi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 10:31:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:41364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230141AbhENObh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 10:31:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 52DDE6144A;
        Fri, 14 May 2021 14:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621002626;
        bh=cVKN89jy54XBxo7mbdNUEkDVIEVc5l44VDPutDRAdro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EKiwz62p8TsvPeBC8c+eTJ0ZEj7i/hJVD14Fb/UFzGe9bvtb/CA9P4TenTtNTAxwh
         oggBfBiJbxoWsCJUsVBPBVvNzPznEIojyCztm5s174/G5mIGY3hJXndfXBP3LDyQ8E
         dELuuLmhCOIes//fKW3qd6NZsvaTp4+x0g0Uu664=
Date:   Fri, 14 May 2021 16:30:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
Cc:     pure.logic@nexus-software.ie, johan@kernel.org, elder@kernel.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: fix gb_loopback_stats_attrs definition
Message-ID: <YJ6Jf+Z1ReVgDt64@kroah.com>
References: <20210514133039.304760-1-chouhan.shreyansh630@gmail.com>
 <YJ582f3O9K9YD3QA@kroah.com>
 <YJ5/tqFfcjxOLsF0@fedora>
 <YJ6DrLiMsdkG5loA@kroah.com>
 <YJ6H/WsojYcN/bLO@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJ6H/WsojYcN/bLO@fedora>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 07:53:57PM +0530, Shreyansh Chouhan wrote:
> On Fri, May 14, 2021 at 04:05:32PM +0200, Greg KH wrote:
> > On Fri, May 14, 2021 at 07:18:38PM +0530, Shreyansh Chouhan wrote:
> > > On Fri, May 14, 2021 at 03:36:25PM +0200, Greg KH wrote:
> > > > On Fri, May 14, 2021 at 07:00:39PM +0530, Shreyansh Chouhan wrote:
> > > > > The gb_loopback_stats_attrs macro, (defined in loopback.c,) is a
> > > > > multiline macro whose statements were not enclosed in a do while
> > > > > loop.
> > > > > 
> > > > > This patch adds a do while loop around the statements of the said
> > > > > macro.
> > > > > 
> > > > > Signed-off-by: Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
> > > > > ---
> > > > >  drivers/staging/greybus/loopback.c | 10 ++++++----
> > > > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/staging/greybus/loopback.c b/drivers/staging/greybus/loopback.c
> > > > > index 2471448ba42a..c88ef3e894fa 100644
> > > > > --- a/drivers/staging/greybus/loopback.c
> > > > > +++ b/drivers/staging/greybus/loopback.c
> > > > > @@ -162,10 +162,12 @@ static ssize_t name##_avg_show(struct device *dev,		\
> > > > >  }									\
> > > > >  static DEVICE_ATTR_RO(name##_avg)
> > > > >  
> > > > > -#define gb_loopback_stats_attrs(field)				\
> > > > > -	gb_loopback_ro_stats_attr(field, min, u);		\
> > > > > -	gb_loopback_ro_stats_attr(field, max, u);		\
> > > > > -	gb_loopback_ro_avg_attr(field)
> > > > > +#define gb_loopback_stats_attrs(field)					\
> > > > > +	do {								\
> > > > > +		gb_loopback_ro_stats_attr(field, min, u);		\
> > > > > +		gb_loopback_ro_stats_attr(field, max, u);		\
> > > > > +		gb_loopback_ro_avg_attr(field);				\
> > > > > +	} while (0)
> > > > >  
> > > > >  #define gb_loopback_attr(field, type)					\
> > > > >  static ssize_t field##_show(struct device *dev,				\
> > > > > -- 
> > > > > 2.31.1
> > > > > 
> > > > > 
> > > > 
> > > > Did you test build this change?
> > > 
> > > I built the module using make -C . M=drivers/staging/greybus to test
> > > build it. I didn't get any errors.
> > 
> > Really?  Can you provide the full build output for this file with your
> > change?  I don't think you really built this file for the obvious
> > reasons...
> 
> I ran make -C . M=drivers/staging/greybus
> 
> I got a three line output saying:
> make: Entering directory '/work/linux'
>   MODPOST drivers/staging/greybus//Module.symvers
> make: Leaving directory '/work/linux'
> 
> I just tried rebuilding the kernel with CONFIG_GREYBUS=m, and now I can
> see what you are talking about. Why weren't these errors reported when I
> ran the previous make command? Does that too check for the config
> variables even when I specifically asked it to build a module?

You were just asking it to build a subdirectory, not a specific
individual file, and when you do that it looks at the configuration
settings.

It's always good to ensure that you actually build the files you modify
before sending patches out.

thanks,

greg k-h
