Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7638834A6FE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 13:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhCZMTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 08:19:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:50750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229866AbhCZMSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 08:18:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF42C61879;
        Fri, 26 Mar 2021 12:18:54 +0000 (UTC)
Date:   Fri, 26 Mar 2021 13:18:52 +0100
From:   Greg KH <greg@kroah.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, mgorman@suse.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        joshdon@google.com, valentin.schneider@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/9] debugfs: Implement debugfs_create_str()
Message-ID: <YF3RLAYbewYS7vqc@kroah.com>
References: <20210326103352.603456266@infradead.org>
 <20210326103935.183934395@infradead.org>
 <YF2/41K4xs3ZOQdV@kroah.com>
 <YF3DF+T8nPRgt7Ao@hirez.programming.kicks-ass.net>
 <YF3F0JbbEpeSGzW6@kroah.com>
 <YF3Hv5zXb/6lauzs@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YF3Hv5zXb/6lauzs@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 12:38:39PM +0100, Peter Zijlstra wrote:
> On Fri, Mar 26, 2021 at 12:30:24PM +0100, Greg KH wrote:
> > Great, change that and limit the size of the string that can be written
> > and it looks good to me, thanks for adding this.
> 
> Here goes..

Great, except one tiny thing:

> + * This function will return a pointer to a dentry if it succeeds.  This
> + * pointer must be passed to the debugfs_remove() function when the file is
> + * to be removed (no automatic cleanup happens if your module is unloaded,
> + * you are responsible here.)  If an error occurs, ERR_PTR(-ERROR) will be
> + * returned.
> + *
> + * NOTE: when writing is enabled it will replace the string, string lifetime is
> + * assumed to be RCU managed.
> + *
> + * If debugfs is not enabled in the kernel, the value ERR_PTR(-ENODEV) will
> + * be returned.

Nothing is returned anymore so the top and bottom paragraphs here no
longer apply.

Fix that up and feel free to add:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

thanks,

greg k-h
