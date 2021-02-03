Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E4B30DD61
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbhBCO6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 09:58:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:50216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232890AbhBCO54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:57:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0544D64F50;
        Wed,  3 Feb 2021 14:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612364236;
        bh=jRL9Mf2hD+5x5L/yI8T8FfZ/g47XDS0hehgtFMqg8UE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WQq5eq37k/xS2PaA1AFC/a8JKEJRPTW6ANS22Ln6mFTxjjShvwSUCXfexPYwklQSE
         Pk2FvJNr/bc38rUjXfk7SGURdxQt0CBs4DnKcnLAZ2LBSJTUWZtOYua/tvmoUCUeu5
         +EdIODnKd6ZzZeX37XnxUuZZb48U8titzf7H0G/4=
Date:   Wed, 3 Feb 2021 15:57:13 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     Joe Perches <joe@perches.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [External] [PATCH] misc: pvpanic: sysfs_emit uses should have a
 newline
Message-ID: <YBq5yVokKwOxmcS8@kroah.com>
References: <13b1c892d52c27d4caeccc89506aadda74f61365.camel@perches.com>
 <3369537d-27a9-2a48-9a46-f241a5077dc2@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3369537d-27a9-2a48-9a46-f241a5077dc2@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 09:56:57AM +0800, zhenwei pi wrote:
> On 1/30/21 3:08 AM, Joe Perches wrote:
> > Add newline terminations to the sysfs_emit uses added by -next
> > commit 8d6da6575ffe ("misc: pvpanic: introduce events device attribue")
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> > ---
> >   drivers/misc/pvpanic.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
> > index b1e4922a7fda..9f350e05ef68 100644
> > --- a/drivers/misc/pvpanic.c
> > +++ b/drivers/misc/pvpanic.c
> > @@ -25,13 +25,13 @@ static unsigned int events;
> >   static ssize_t capability_show(struct device *dev,
> >   			       struct device_attribute *attr, char *buf)
> >   {
> > -	return sysfs_emit(buf, "%x", capability);
> > +	return sysfs_emit(buf, "%x\n", capability);
> >   }
> >   static DEVICE_ATTR_RO(capability);
> >   static ssize_t events_show(struct device *dev,  struct device_attribute *attr, char *buf)
> >   {
> > -	return sysfs_emit(buf, "%x", events);
> > +	return sysfs_emit(buf, "%x\n", events);
> >   }
> >   static ssize_t events_store(struct device *dev,  struct device_attribute *attr,
> > 
> > 
> 
> Hi, Greg is the maintainer of this driver.

No I am not:
$ ./scripts/get_maintainer.pl drivers/misc/pvpanic.c
Arnd Bergmann <arnd@arndb.de> (supporter:CHAR and MISC DRIVERS)
Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:CHAR and MISC DRIVERS)
linux-kernel@vger.kernel.org (open list)

As the developer of this driver, it would be great if you
could review the change and provide a "Signed-off-by" line that I can
use to accept this patch.

thanks,

greg k-h
