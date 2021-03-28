Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61ED534BA44
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 01:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhC1Ade (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 20:33:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:57132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230384AbhC1AdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 20:33:18 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC9C061993;
        Sun, 28 Mar 2021 00:33:16 +0000 (UTC)
Date:   Sat, 27 Mar 2021 20:33:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        mgorman@suse.de, juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, bristot@redhat.com,
        joshdon@google.com, valentin.schneider@arm.com,
        linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [PATCH 6/9] debugfs: Implement debugfs_create_str()
Message-ID: <20210327203315.3cd7bcda@oasis.local.home>
In-Reply-To: <YF+wrUjnGTsH6FGT@zeniv-ca.linux.org.uk>
References: <20210326103352.603456266@infradead.org>
        <20210326103935.183934395@infradead.org>
        <YF+wrUjnGTsH6FGT@zeniv-ca.linux.org.uk>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Mar 2021 22:24:45 +0000
Al Viro <viro@zeniv.linux.org.uk> wrote:

> On Fri, Mar 26, 2021 at 11:33:58AM +0100, Peter Zijlstra wrote:
> 
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
> *Ow*
> 
> 	If the string can't change under you, what is RCU use about?
> And if it can, any use of string functions is asking for serious
> trouble; they are *not* guaranteed to be safe when any of the strings
> involved might be modified under them.

Just from looking at the above, RCU isn't protecting that the string
can change under you, but the pointer to file->private_data can.

	str = rcu_dereference(*(char **)file->private_data);

That's just getting a pointer to the string. While under rcu, the value
of that string wont change nor will it be free. But file->private_data
might change, and it might free its old value, but will do so after a
RCU grace period (which is why the above has rcu_read_lock).

What the above looks like to me is a way to copy that string safely,
without worrying that it will be freed underneath you. But there's no
worry that it will change.

-- Steve
