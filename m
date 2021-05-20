Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D36A389EA6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 09:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbhETHJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 03:09:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:49196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229953AbhETHJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 03:09:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D3BA6124C;
        Thu, 20 May 2021 07:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621494506;
        bh=vyLAtGMQO50f0B4tMr5Ie5sS01PDBidzS4f5U/kcH0c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QzFFmI833N9MqnAa0zU/wo10tSYWPpia43R/LYQTyx3FZ56KR4kMxNdUIVNQJoMuB
         HLbOBNCyXqoaKQkHYU8UJxZsV2v02G/vmCSvGhmd/C4+9kf69aY3ZMioQ5LZOjqM61
         /bmTZE++IYBqyef549TPG1f3bP5T2q92L3gRTWHw=
Date:   Thu, 20 May 2021 09:08:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?utf-8?B?SmnFmcOt?= Prchal <jiri.prchal@aksignal.cz>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Christian Eggers <ceggers@arri.de>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 4/4] nvmem: eeprom: at25: export FRAM serial num
Message-ID: <YKYK6HlQYHBPPCKq@kroah.com>
References: <20210520054714.8736-1-jiri.prchal@aksignal.cz>
 <20210520054714.8736-5-jiri.prchal@aksignal.cz>
 <YKX5Iqm3AoCXsDV6@kroah.com>
 <f0951762-8067-e353-f585-2cb17f7be134@aksignal.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f0951762-8067-e353-f585-2cb17f7be134@aksignal.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 08:56:39AM +0200, Jiří Prchal wrote:
> Here I'm completlly lost:
> 
> On 20. 05. 21 7:52, Greg Kroah-Hartman wrote:
> > On Thu, May 20, 2021 at 07:47:14AM +0200, Jiri Prchal wrote:
> > > This exports serial number of FRAM in sysfs file named "sernum".
> > > Formatted in hex, each byte separated by space.
> > > Example:
> > > $ cat /sys/class/spi_master/spi0/spi0.0/sernum
> > 
> > No new Documentation/ABI/ entry for this?
> No, should I do and how / where?

All sysfs files need a Documentation/ABI/ entry.

> > > +static ssize_t sernum_show(struct device *dev, struct device_attribute *attr, char *buf)
> > > +{
> > > +	struct at25_data *at25;
> > > +	int i;
> > > +
> > > +	at25 = dev_get_drvdata(dev);
> > > +	for (i = 0; i < FM25_SN_LEN; i++)
> > > +		buf += sprintf(buf, "%02x ", at25->sernum[i]);
> > > +	sprintf(--buf, "\n");
> > > +	return (3 * i);
> > 
> > No, that is not how sysfs files work, sorry.  They are "one value per
> > file".  This looks like multiple values in the same file, why not just
> > one file per "sernum"?
> It's formatted by spaces. It's one long number like MAC addr, so is better
> to expose it as hex string without spaces? Or like MAC separated by colon?

Why format it at all?  Just dump out the whole thing as a string.

But who is going to care about this?  What tool will be reading it and
what will it be for?  The Documentation/ABI/ entry would help explain
all of this.

> > > +	/* Export the FM25 serial number */
> > > +	if (at25->has_sernum) {
> > > +		err = device_create_file(&spi->dev, &dev_attr_sernum);
> > 
> > You just raced with userspace and lost :(
> ?
> > 
> > Please do this correctly, by setting the driver group if you need a file
> > like this.
> Any example, please?

Loads, see any platform driver that sets the dev_groups pointer.

thanks,

greg k-h
