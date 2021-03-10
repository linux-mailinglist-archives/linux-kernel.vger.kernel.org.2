Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9A17333C75
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 13:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhCJMRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 07:17:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:35976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233081AbhCJMRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 07:17:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9D0CB64FE7;
        Wed, 10 Mar 2021 12:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615378629;
        bh=TMe7CnR9HKbioIrZulViQgGBc86z1nxs2RXTijWx1AM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0BwWNpThmsoX6mfUyfP3AL+FIKOImoTwkVWlVs9q36CfbyFei3hDoaoG4e9xBF6O1
         eIvFLDPECZ+kfFPvsTY60TiZfAOLnTyC69liC36WgHjETPk8Rp16Nuj0IqQpr83km2
         NXoBeqo21kHH7TBo93lvoYYrhstxJVQuX9hNqm2Y=
Date:   Wed, 10 Mar 2021 13:16:43 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>, kernel-team@fb.com
Subject: Re: [PATCH v5] printk: Userspace format enumeration support
Message-ID: <YEi4qwBAd/O+sXyq@kroah.com>
References: <YEgvR6Wc1xt0qupy@chrisdown.name>
 <YEhsHELBM20f4MRE@kroah.com>
 <YEi3ySLkw3hZinnS@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEi3ySLkw3hZinnS@chrisdown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 12:12:57PM +0000, Chris Down wrote:
> Greg Kroah-Hartman writes:
> > On Wed, Mar 10, 2021 at 02:30:31AM +0000, Chris Down wrote:
> > > +	ps->file = debugfs_create_file(pi_get_module_name(mod), 0444, dfs_index,
> > > +				       ps, &dfs_index_fops);
> > > +
> > > +	if (IS_ERR(ps->file)) {
> > > +		pi_sec_remove(mod);
> > > +		return;
> > > +	}
> > 
> > No need to check this and try to clean up if there is a problem, just
> > save the pointer off and call debugfs_remove() when you want to clean
> > up.
> 
> Petr, what are your thoughts on this, since you requested the cleanup on
> debugfs failure? :-)

There is nothing to "clean up" if there is a debugfs failure here so I
don't see the need.

> > Or better yet, no need to save anything, you can always look it up when
> > you want to remove it, that will save you one pointer per module.
> 
> That's a good point, and with that maybe we can even do away with the pi_sec
> entirely then since that only leaves start/end pointers which we can
> calculate on demand from existing data.

Please do, that makes the code simpler overall.

thanks,

greg k-h
