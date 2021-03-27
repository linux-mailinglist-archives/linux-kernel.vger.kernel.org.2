Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBC834B9EC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 23:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhC0WZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 18:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbhC0WZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 18:25:03 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD2AC0613B1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 15:25:03 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lQHML-000JpF-KS; Sat, 27 Mar 2021 22:24:45 +0000
Date:   Sat, 27 Mar 2021 22:24:45 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, mgorman@suse.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        joshdon@google.com, valentin.schneider@arm.com,
        linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [PATCH 6/9] debugfs: Implement debugfs_create_str()
Message-ID: <YF+wrUjnGTsH6FGT@zeniv-ca.linux.org.uk>
References: <20210326103352.603456266@infradead.org>
 <20210326103935.183934395@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326103935.183934395@infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 11:33:58AM +0100, Peter Zijlstra wrote:

> +again:
> +	rcu_read_lock();
> +	str = rcu_dereference(*(char **)file->private_data);
> +	len = strlen(str) + 1;
> +
> +	if (!copy || copy_len < len) {
> +		rcu_read_unlock();
> +		kfree(copy);
> +		copy = kmalloc(len + 1, GFP_KERNEL);
> +		if (!copy) {
> +			debugfs_file_put(dentry);
> +			return -ENOMEM;
> +		}
> +		copy_len = len;
> +		goto again;
> +	}
> +
> +	strncpy(copy, str, len);
> +	copy[len] = '\n';
> +	copy[len+1] = '\0';
> +	rcu_read_unlock();

*Ow*

	If the string can't change under you, what is RCU use about?
And if it can, any use of string functions is asking for serious
trouble; they are *not* guaranteed to be safe when any of the strings
involved might be modified under them.
