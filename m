Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 759ED33DAFB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 18:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbhCPR3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 13:29:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:33258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238374AbhCPR3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 13:29:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5937264F17;
        Tue, 16 Mar 2021 17:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615915751;
        bh=lV8PweIP8gOM3/NCWUWqs8QeJNQNF3mh0R8CA+oyv24=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZZfLxv6cvEeQiInTwCaKI1gLTZKPxEdTrUv7q6rkWvWp1iQBbcO0zxaTOgjtXcbPU
         d7WsEZoaULr3afIZU1fYgkwqQgekyKVhl58xI/OJE6iXzUPX4Bhf3uBuP8I4ijN9KM
         9psNsnPI3+AUOWMMi0lwg/Um5JHrG76dDNTGYuU4=
Date:   Tue, 16 Mar 2021 18:29:09 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mihai Carabas <mihai.carabas@oracle.com>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        bobo.shaobowang@huawei.com, rdunlap@infradead.org
Subject: Re: [PATCH v5 3/3] misc/pvpanic: add PCI driver
Message-ID: <YFDq5Wj4AQOm/Bm4@kroah.com>
References: <1615897229-4055-1-git-send-email-mihai.carabas@oracle.com>
 <1615897229-4055-4-git-send-email-mihai.carabas@oracle.com>
 <YFDhZbRYE5szZ4l/@kroah.com>
 <b3d33f82-21ab-2244-13b0-700fc54b2093@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3d33f82-21ab-2244-13b0-700fc54b2093@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 07:08:38PM +0200, Mihai Carabas wrote:
> ..snip..
> > > +};
> > > +static unsigned int capability = PVPANIC_PANICKED | PVPANIC_CRASH_LOADED;
> > > +static unsigned int events;
> > > +
> > > +static ssize_t capability_show(struct device *dev,
> > > +			       struct device_attribute *attr, char *buf)
> > > +{
> > > +	return sysfs_emit(buf, "%x\n", capability);
> > A global capability for all devices?  No, this needs to be a per-device
> > attttribute as you are showing it to userspace as such.
> 
> We can only have a pvpanic-pci device. This is necessary in that case?

Why would it not be?  Why constrain yourself to something that someone
will only have to fix sometime in the future?

> ...snip..
> > > +static struct attribute *pvpanic_pci_dev_attrs[] = {
> > > +	&dev_attr_capability.attr,
> > > +	&dev_attr_events.attr,
> > > +	NULL
> > > +};
> > > +ATTRIBUTE_GROUPS(pvpanici_pci_dev);
> > You did not document these new sysfs files in Documentation/ABI/ so it's
> > hard to judge what they do.  Please do so next version.
> 
> This appeared after 5.12 rebase on pvpanic-mmio. I did this changes to
> pvpanic-pci to be on the same page as pvpanic-mmio which is described here:
> Documentation/ABI/testing/sysfs-bus-pci-devices-pvpanic.

Ah, missed that, my fault, sorry.  But you also now do this for the
other device type right?  So does the documentation need to reflect that
too?

thanks,

greg k-h
