Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2A034A9A1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 15:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhCZOYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 10:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbhCZOYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 10:24:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27616C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 07:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3zdhSQlhhwrxBKfUCXtYo1aVuthTa4RspYumYkxr2tU=; b=TVevRb/AuLO99XTwECUsVJfTnD
        wtP6lRRRohmj7njnovL0/2XJx+omW+kg5hplWJtFbIj2d2QyYCW+OU8GVmtEGNGE98rOjftf0fZNH
        gG9uCw2WHHa7OoBAwrvnnb6EOIyrhFUj/LCMSdKTUps0GJyVYLmS+H2+P/ZhDK9JlwX0LhhzLBCCY
        0Eh5kDB10chZDOmvr1+I4X4aSNEh5k0nob5HaKDMhqcnUuVAnhpEZ0Xxjt7p5sspSbL4mSZi0Ua4H
        cXO4N0IvyJFrkFPu2YS3nXnQzaanEfqZA6ZhwcSD28JmpCtyP0ITFlg8qyFtg7qJ9lFYp5BAQh/mR
        N6FHrQuQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lPnM6-00EwY6-8n; Fri, 26 Mar 2021 14:22:49 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5F98798103F; Fri, 26 Mar 2021 15:22:30 +0100 (CET)
Date:   Fri, 26 Mar 2021 15:22:30 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Greg KH <greg@kroah.com>, mingo@kernel.org, mgorman@suse.de,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, joshdon@google.com, valentin.schneider@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/9] debugfs: Implement debugfs_create_str()
Message-ID: <20210326142230.GJ4746@worktop.programming.kicks-ass.net>
References: <20210326103352.603456266@infradead.org>
 <20210326103935.183934395@infradead.org>
 <YF2/41K4xs3ZOQdV@kroah.com>
 <YF3DF+T8nPRgt7Ao@hirez.programming.kicks-ass.net>
 <YF3F0JbbEpeSGzW6@kroah.com>
 <YF3Hv5zXb/6lauzs@hirez.programming.kicks-ass.net>
 <70594935-18e6-0791-52f9-0448adf37155@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70594935-18e6-0791-52f9-0448adf37155@rasmusvillemoes.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 01:53:59PM +0100, Rasmus Villemoes wrote:
> On 26/03/2021 12.38, Peter Zijlstra wrote:

> > +
> > +again:
> > +	rcu_read_lock();
> > +	str = rcu_dereference(*(char **)file->private_data);
> > +	len = strlen(str) + 1;
> > +
> > +	if (!copy || copy_len < len) {
> > +		rcu_read_unlock();
> > +		kfree(copy);
> > +		copy = kmalloc(len + 1, GFP_KERNEL);
> > +		if (!copy) {
> > +			debugfs_file_put(dentry);
> > +			return -ENOMEM;
> > +		}
> > +		copy_len = len;
> > +		goto again;
> > +	}
> > +
> > +	strncpy(copy, str, len);
> > +	copy[len] = '\n';
> > +	copy[len+1] = '\0';
> > +	rcu_read_unlock();
> 
> As noted (accidentally off-list), this is broken. I think you want this
> on top
> 
> - len = strlen(str) + 1;
> + len = strlen(str);

  kmalloc(len + 2, ...);

> - strncpy(copy, str, len);
> + memcpy(copy, str, len);
>   copy[len] = '\n';
> - copy[len+1] = '\0';

I'll go with strscpy() I tihnk, something like:

	len = strscpy(copy, str, len);
	if (len < 0)
		return len;
	copy[len] = '\n';
	copy[len + 1] = '\0';

> > +EXPORT_SYMBOL_GPL(debugfs_read_file_str);
> 
> Why?

Copy-pasta from debugfs_*_bool(). This thing seems to export everything
and I figured I'd go along with that.
