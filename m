Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB2D41D340
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 08:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348278AbhI3GZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 02:25:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:50904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348249AbhI3GZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 02:25:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5B4CC61528;
        Thu, 30 Sep 2021 06:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632983010;
        bh=STfPrcR+qhNazajrQjGH7gnqY8hcQZWmoWxQzI++mw4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VE5exjS1ral1XqXVYd7dCgXqFlK2GDC/+7u2fen3TlJdmpS/HOgAJjhI4WbWmxhfA
         OLGM54BnDJkjTNDfdz4pIchp7c2+jxMhi8hwIVUUmJK9JWKO7MD06+A7z/r9iMCcgG
         Gvpmr4cFZ9+MD/N2tBjHHiEql7hf87HzysOxONVQ=
Date:   Thu, 30 Sep 2021 08:23:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     Yang Li <yang.lee@linux.alibaba.com>, 0day robot <lkp@intel.com>,
        Abaci Robot <abaci@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [driver core]  eedc73d4f3:
 BUG:kernel_reboot-without-warning_in_boot_stage
Message-ID: <YVVX3ir2DHg0FUxF@kroah.com>
References: <1614590004-69592-1-git-send-email-yang.lee@linux.alibaba.com>
 <20210929150240.GB12854@xsang-OptiPlex-9020>
 <YVSCs7BDC6ODf+oZ@kroah.com>
 <20210930055944.GA29843@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930055944.GA29843@xsang-OptiPlex-9020>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 01:59:44PM +0800, Oliver Sang wrote:
> Hi, Greg KH,
> 
> On Wed, Sep 29, 2021 at 05:13:55PM +0200, Greg KH wrote:
> > On Wed, Sep 29, 2021 at 11:02:40PM +0800, kernel test robot wrote:
> > > 
> > > 
> > > Greeting,
> > > 
> > > FYI, we noticed the following commit (built with gcc-9):
> > > 
> > > commit: eedc73d4f330cf7a8d18d64f327837ae9a00d003 ("[PATCH] driver core: Switch to using the new API kobj_to_dev()")
> > > url: https://github.com/0day-ci/linux/commits/Yang-Li/driver-core-Switch-to-using-the-new-API-kobj_to_dev/20210929-102216
> > > base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git 5816b3e6577eaa676ceb00a848f0fd65fe2adc29
> > 
> > There is no such commit in my tree, or anywhere else I can see, so I
> > have no idea what is happening here :(
> > 
> 
> this report was sent to Yang Li, who is the patch author.
> https://lore.kernel.org/lkml/1614590004-69592-1-git-send-email-yang.lee@linux.alibaba.com/
> 
> since Yang sent the patch to you, so our Rot automatically add you in
> the Cc list.

That patch was sent back on March 1.  And was instantly rejected for the
obvious reason it was never tested :)

Why is 0-day running on such old changes now?

And it is not obvious that this is being run on an email submission at
all, where would I have found that information in this response?  I see
a git id that points to a kernel tree.  No email link at all.

thanks,

greg k-h
