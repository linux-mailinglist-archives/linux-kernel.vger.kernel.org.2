Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D396933DC5C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 19:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236217AbhCPSQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 14:16:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:57350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235933AbhCPSQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 14:16:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8FFA265131;
        Tue, 16 Mar 2021 18:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615918577;
        bh=ngUbnGjt2eSCTsQ8RzHWN6s7Gk/4w6ZxOf1sitZL8ho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=usUl6LkKFhLKh+7zLuCdZImq8GWtlP92D1Q5gslYwEo0Nwo13DW/fVYaR44Bonzin
         VyTxt3DSipx3hAt2xOkoKasAriRjF8SzYhRMnFdlxo+ONrS8xAeurr96sbCwnQlxO/
         n9vI5jpwKtbmnvWKi+vvFNSwqKdv9ww2PrnvtYNw=
Date:   Tue, 16 Mar 2021 19:16:14 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mihai Carabas <mihai.carabas@oracle.com>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        bobo.shaobowang@huawei.com, rdunlap@infradead.org
Subject: Re: [PATCH v5 3/3] misc/pvpanic: add PCI driver
Message-ID: <YFD17kCSR26FSCdE@kroah.com>
References: <1615897229-4055-1-git-send-email-mihai.carabas@oracle.com>
 <1615897229-4055-4-git-send-email-mihai.carabas@oracle.com>
 <YFDhZbRYE5szZ4l/@kroah.com>
 <b3d33f82-21ab-2244-13b0-700fc54b2093@oracle.com>
 <YFDq5Wj4AQOm/Bm4@kroah.com>
 <91231b60-d559-5d1e-aff8-303fefc1f25e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91231b60-d559-5d1e-aff8-303fefc1f25e@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 08:02:14PM +0200, Mihai Carabas wrote:
> La 16.03.2021 19:29, Greg KH a scris:
> > On Tue, Mar 16, 2021 at 07:08:38PM +0200, Mihai Carabas wrote:
> > > ..snip..
> > > > > +};
> > > > > +static unsigned int capability = PVPANIC_PANICKED | PVPANIC_CRASH_LOADED;
> > > > > +static unsigned int events;
> > > > > +
> > > > > +static ssize_t capability_show(struct device *dev,
> > > > > +			       struct device_attribute *attr, char *buf)
> > > > > +{
> > > > > +	return sysfs_emit(buf, "%x\n", capability);
> > > > A global capability for all devices?  No, this needs to be a per-device
> > > > attttribute as you are showing it to userspace as such.
> > > We can only have a pvpanic-pci device. This is necessary in that case?
> > Why would it not be?  Why constrain yourself to something that someone
> > will only have to fix sometime in the future?
> 
> Agree. But why this got in in Jan2021 for pvpanic-mmio.c (ex. pvpanic.c)
> like this :)?
> 

Because I didn't object strong enough :)
