Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C21E36EB68
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 15:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236737AbhD2Njb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 09:39:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:40014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231343AbhD2Nja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 09:39:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1981A6144B;
        Thu, 29 Apr 2021 13:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619703523;
        bh=971hVuOP0+M93zEJ9v1aY+SpzUjnc6StqqxYcms7O80=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eS04rvmFqyspmQoC/9Dg+oqFg1OI6gSWe+n4ZCfKz9MwiVBKbH7kF8bPhKPpUc/9X
         cTsSvhY1D4lp9gwCSwqjugyR4sxVAnbcvvMcIZovu1w2Oi1cn5xyYDPcYQivTplHAL
         a9bCci6SUPJD3TvPoiQD33F/LQQQJvqVkCggLen8=
Date:   Thu, 29 Apr 2021 15:38:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>
Subject: Re: [PATCH 037/190] Revert "RDMA/core: Fix several reference count
 leaks."
Message-ID: <YIq24bDyB49QJm0S@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-38-gregkh@linuxfoundation.org>
 <20210421141444.GL1370958@nvidia.com>
 <YIgfbZDo9eQ2tKvc@kroah.com>
 <20210427161235.GB1370958@nvidia.com>
 <YIlTzGLpbRj3rh/R@kroah.com>
 <20210428130044.GQ1370958@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210428130044.GQ1370958@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 10:00:44AM -0300, Jason Gunthorpe wrote:
> On Wed, Apr 28, 2021 at 02:23:40PM +0200, Greg Kroah-Hartman wrote:
> 
> > > We've talked about this specifically before:
> > > 
> > > http://lore.kernel.org/r/20210331170720.GY2710221@ziepe.ca
> > > 
> > > I still don't understand what you mean by "udev sees it properly", as
> > > above, all the tests I thought of look OK.
> > 
> > Can you query the udev database to see the attribute values?
> 
> It appears so unless I misunderstand your ask:
> 
> $ udevadm info -a /sys/class/infiniband/ibp0s9
>     ATTR{ports/1/cm_rx_duplicates/dreq}=="0"

That works?  Nice, I didn't think it did.

But what about the uevent that fired for "1", isn't there attibutes
assigned to it that udev ignores?

> > As you say, it's uABI for now, so odds are nothing can be changed.  It's
> > just no fun for when other subsystems want to do this same thing, they
> > point at this code and say "see, they did it!" :)
> 
> Are you sure we shouldn't just formally support this?
> 
> What is the exact technical blocker?

Placing a raw kobject below a struct device breaks the "device tree"
model.  You now have devices with an arbritrary number of levels deep
set of attributes, making it impossible to determine all attributes for
a device in a simple way.

thanks,

greg k-h
