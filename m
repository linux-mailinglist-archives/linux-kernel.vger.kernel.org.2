Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2D01459C67
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 07:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbhKWGr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 01:47:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:46954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230270AbhKWGr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 01:47:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 582B060FE7;
        Tue, 23 Nov 2021 06:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637649888;
        bh=LdsPqBZuTyvpRRc+gvPluX5K1lWkm5aEpueyQs4EQTQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N/A1crIrAN3le+gq+caSfyWWwxm5wTUJX0BWdnasf/p6xUddP3TvMWYg3QDG+KMyL
         fBe/PmR5JnfS4Sm5vON9bIkEn6u9+mrbbxoV9l2FbvBhvfl0X73zZ3yEg5plx3vhXA
         E3EKqmTIM6TynqDbibRNYndiak6pSNiWjrfYHplg=
Date:   Tue, 23 Nov 2021 07:44:45 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kernfs: switch global kernfs_rwsem lock to per-fs lock
Message-ID: <YZyN3Tr7bPhimaq9@kroah.com>
References: <20211118230008.2679780-1-minchan@kernel.org>
 <YZbbxK1F7jY/RBFF@slm.duckdns.org>
 <YZvV0ESA+zHHqHBU@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZvV0ESA+zHHqHBU@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 09:39:28AM -0800, Minchan Kim wrote:
> On Thu, Nov 18, 2021 at 01:03:32PM -1000, Tejun Heo wrote:
> > On Thu, Nov 18, 2021 at 03:00:08PM -0800, Minchan Kim wrote:
> > > The kernfs implementation has big lock granularity(kernfs_rwsem) so
> > > every kernfs-based(e.g., sysfs, cgroup) fs are able to compete the
> > > lock. It makes trouble for some cases to wait the global lock
> > > for a long time even though they are totally independent contexts
> > > each other.
> > > 
> > > A general example is process A goes under direct reclaim with holding
> > > the lock when it accessed the file in sysfs and process B is waiting
> > > the lock with exclusive mode and then process C is waiting the lock
> > > until process B could finish the job after it gets the lock from
> > > process A.
> > > 
> > > This patch switches the global kernfs_rwsem to per-fs lock, which
> > > put the rwsem into kernfs_root.
> > > 
> > > Suggested-by: Tejun Heo <tj@kernel.org>
> > > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > 
> > Acked-by: Tejun Heo <tj@kernel.org>
> > 
> > Greg, I think this is the right thing to do even if there is no concrete
> > performance argument (not saying there isn't). It's just weird to entangle
> > these completely unrelated users in a single rwsem.
> > 
> > Thanks.
> 
> Greg, Do you mind picking this patch?

$ mdfrm -c ~/mail/todo/
1872 messages in /home/gregkh/mail/todo/

Give me a chance to catch up...

thanks,

greg k-h
