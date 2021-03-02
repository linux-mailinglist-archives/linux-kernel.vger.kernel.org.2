Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA59432A1CA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 15:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1836226AbhCBG73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 01:59:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:32816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1577051AbhCBFhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 00:37:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 42A646146B;
        Tue,  2 Mar 2021 05:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614663431;
        bh=yX8R/LjOcUGHn7E8QsZIMKBDISkHQNvZsgQfi9+ryv0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bJU9KzjLHfl/9E8tw3i6NCPZFOAGdePX+61d3eg1jII1ljWgSZtPyTJE4PdPZLsIm
         yTUdaIRU34UV0srxahPPEbKT6xbSV4Ngr5tBi9nmHbsB+gTglBzg92bhM4qw/A8tL6
         V3xC5dPHa2tDPTZvvTKtEQVqp7OBZwM4kQ8bDO0I=
Date:   Tue, 2 Mar 2021 06:37:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "tiantao (H)" <tiantao6@huawei.com>
Cc:     Tian Tao <tiantao6@hisilicon.com>, zbr@ioremap.net,
        rikard.falkeborn@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] w1: ds2708 and ds2781 use the new API kobj_to_dev()
Message-ID: <YD3PArQe8x20lJJ0@kroah.com>
References: <1614603535-24046-1-git-send-email-tiantao6@hisilicon.com>
 <YDzne3KtnGJD1J0E@kroah.com>
 <9be69246-fb8b-27dc-c459-0f9aa25c5c88@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9be69246-fb8b-27dc-c459-0f9aa25c5c88@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 08:51:08AM +0800, tiantao (H) wrote:
> Hi:
> 
> 在 2021/3/1 21:09, Greg KH 写道:
> > On Mon, Mar 01, 2021 at 08:58:55PM +0800, Tian Tao wrote:
> > > fix the below warnning:
> > > /drivers/w1/slaves/w1_ds2780.c:93:60-61: WARNING opportunity for
> > > kobj_to_dev()
> > What creates that warning?
> This is reported by coccicheck.

Then include that in the changelog text, otherwise this looks like a
warning by the complier, which it is not.

> > > Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> > > ---
> > >   drivers/w1/slaves/w1_ds2780.c | 3 ++-
> > >   drivers/w1/slaves/w1_ds2781.c | 2 +-
> > >   2 files changed, 3 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/w1/slaves/w1_ds2780.c b/drivers/w1/slaves/w1_ds2780.c
> > > index c281fe5..3cde1bb 100644
> > > --- a/drivers/w1/slaves/w1_ds2780.c
> > > +++ b/drivers/w1/slaves/w1_ds2780.c
> > > @@ -90,7 +90,8 @@ static ssize_t w1_slave_read(struct file *filp, struct kobject *kobj,
> > >   			     struct bin_attribute *bin_attr, char *buf,
> > >   			     loff_t off, size_t count)
> > >   {
> > > -	struct device *dev = container_of(kobj, struct device, kobj);
> > > +	struct device *dev = kobj_to_dev(kobj);
> > > +
> > Why the extra line here, but not in the other chunk?
> 
> This is reported by checkpatch.
> 
> tiantao@ubuntu:~/mailline/linux-next$ ./scripts/checkpatch.pl
> drivers/w1/slaves/w1_ds2780.c
> 
> WARNING: Missing a blank line after declarations
> #94: FILE: drivers/w1/slaves/w1_ds2780.c:94:
> +       struct device *dev = kobj_to_dev(kobj);
> +       return w1_ds2780_io(dev, buf, off, count, 0);

Yes, but you made this change in only one of the hunks, and not the
other.

And, it is a different type of change, only do one "logical" thing per
patch.  This should be a 2 patch series if you care about the coding
style of this driver.

Please fix up and resend.

thanks,

greg k-h
