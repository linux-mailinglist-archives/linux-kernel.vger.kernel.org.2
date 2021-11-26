Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6181B45F298
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 18:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238821AbhKZRHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 12:07:52 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41546 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbhKZRFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 12:05:51 -0500
X-Greylist: delayed 6451 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Nov 2021 12:05:50 EST
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33CA0B82857
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 17:02:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46BDBC93056;
        Fri, 26 Nov 2021 17:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637946149;
        bh=yuE+BreTQT02yvn8X1u7k+Z03tC9pJONhbHdFlU5fDw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GFLbnAlBGzqnesySG38WMS+nG1yJXFvLI/1+fMGUeZqqUIr0EIeDBFs/WIj8Z26dP
         6RQEXrEF46kuRe4u9SD0Z5PIxUVKoIsXDGoMe/0L0DswGLOB+/8AlZnTc/J3JWiMfI
         TEBS/ZopFOFZvVOIj5Q+G3Mmtr8gPDV4b3jgSJ9U=
Date:   Fri, 26 Nov 2021 18:02:27 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Evgeniy Polyakov <zbr@ioremap.net>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] w1: Misuse of get_user()/put_user() reported by sparse
Message-ID: <YaETI1AD0dt/Haqv@kroah.com>
References: <926b572075a26835f4e39d05710cd1b75fd4d5a4.1637945194.git.christophe.leroy@csgroup.eu>
 <YaERVtyYpJ+BTQ/f@kroah.com>
 <8e5493ac-dd05-9bad-c9ae-169114e0fdcf@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e5493ac-dd05-9bad-c9ae-169114e0fdcf@csgroup.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 05:57:58PM +0100, Christophe Leroy wrote:
> 
> 
> Le 26/11/2021 � 17:54, Greg Kroah-Hartman a �crit�:
> > On Fri, Nov 26, 2021 at 05:47:58PM +0100, Christophe Leroy wrote:
> > > sparse warnings: (new ones prefixed by >>)
> > > > > drivers/w1/slaves/w1_ds28e04.c:342:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char [noderef] __user *_pu_addr @@     got char *buf @@
> > >     drivers/w1/slaves/w1_ds28e04.c:342:13: sparse:     expected char [noderef] __user *_pu_addr
> > >     drivers/w1/slaves/w1_ds28e04.c:342:13: sparse:     got char *buf
> > > > > drivers/w1/slaves/w1_ds28e04.c:356:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const [noderef] __user *_gu_addr @@     got char const *buf @@
> > >     drivers/w1/slaves/w1_ds28e04.c:356:13: sparse:     expected char const [noderef] __user *_gu_addr
> > >     drivers/w1/slaves/w1_ds28e04.c:356:13: sparse:     got char const *buf
> > > 
> > > The buffer buf is a failsafe buffer in kernel space, it's not user
> > > memory hence doesn't deserve the use of get_user() or put_user().
> > > 
> > > Access 'buf' content directly.
> > > 
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Link: https://lore.kernel.org/lkml/202111190526.K5vb7NWC-lkp@intel.com/T/
> > > Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> > > ---
> > > v2: Use sysfs_emit() and kstrtobool()
> > > ---
> > >   drivers/w1/slaves/w1_ds28e04.c | 25 +++----------------------
> > >   1 file changed, 3 insertions(+), 22 deletions(-)
> > > 
> > > diff --git a/drivers/w1/slaves/w1_ds28e04.c b/drivers/w1/slaves/w1_ds28e04.c
> > > index e4f336111edc..98f80f412cfd 100644
> > > --- a/drivers/w1/slaves/w1_ds28e04.c
> > > +++ b/drivers/w1/slaves/w1_ds28e04.c
> > > @@ -32,7 +32,7 @@ static int w1_strong_pullup = 1;
> > >   module_param_named(strong_pullup, w1_strong_pullup, int, 0);
> > >   /* enable/disable CRC checking on DS28E04-100 memory accesses */
> > > -static char w1_enable_crccheck = 1;
> > > +static bool w1_enable_crccheck = true;
> > >   #define W1_EEPROM_SIZE		512
> > >   #define W1_PAGE_COUNT		16
> > > @@ -339,32 +339,13 @@ static BIN_ATTR_RW(pio, 1);
> > >   static ssize_t crccheck_show(struct device *dev, struct device_attribute *attr,
> > >   			     char *buf)
> > >   {
> > > -	if (put_user(w1_enable_crccheck + 0x30, buf))
> > > -		return -EFAULT;
> > > -
> > > -	return sizeof(w1_enable_crccheck);
> > > +	return sysfs_emit(buf, "%d\n", w1_enable_crccheck);
> > >   }
> > >   static ssize_t crccheck_store(struct device *dev, struct device_attribute *attr,
> > >   			      const char *buf, size_t count)
> > >   {
> > > -	char val;
> > > -
> > > -	if (count != 1 || !buf)
> > > -		return -EINVAL;
> > > -
> > > -	if (get_user(val, buf))
> > > -		return -EFAULT;
> > > -
> > > -	/* convert to decimal */
> > > -	val = val - 0x30;
> > > -	if (val != 0 && val != 1)
> > > -		return -EINVAL;
> > > -
> > > -	/* set the new value */
> > > -	w1_enable_crccheck = val;
> > > -
> > > -	return sizeof(w1_enable_crccheck);
> > > +	return kstrtobool(buf, &w1_enable_crccheck) ? : count;
> > 
> > Please spell this line out, using ? : is unreadable at times.
> > 
> 
> You prefer something like:
> 
> 	int err = kstrtobool(buf, &w1_enable_crccheck);
> 
> 	return err ? err : count;
> 
> 
> Or
> 
> 	int err = kstrtobool(buf, &w1_enable_crccheck);
> 
> 	if (err)
> 		return err;
> 
> 	return count;

This one.  Write code for people to read first, compiler second.

thanks,

greg k-h
