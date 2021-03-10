Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC7C333604
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 07:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbhCJGuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 01:50:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:39758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231453AbhCJGuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 01:50:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99BBB64FE3;
        Wed, 10 Mar 2021 06:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615359008;
        bh=0iq7+MXnAugaS8tGYJcIZQ46Nvi0Y80pR9IOpJAY8B4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RLk4J/aj3YTlilDpi5gBT0HSib+K7M3fgCi4BXIHM4S6/iRn/aX/i73Db1Hg6HTJL
         ZC2RgX6frI0ipwzI38k5tU2uhLxYK2Ph5v39v8U9PT7dZq1LOMqXraDjyp7Q4K9Ikh
         eGm7ryIiMw3rxCPf1RFROQg8JAaRkGFgAeXKyHak=
Date:   Wed, 10 Mar 2021 07:50:04 +0100
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
Message-ID: <YEhsHELBM20f4MRE@kroah.com>
References: <YEgvR6Wc1xt0qupy@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEgvR6Wc1xt0qupy@chrisdown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 02:30:31AM +0000, Chris Down wrote:
> +	ps->file = debugfs_create_file(pi_get_module_name(mod), 0444, dfs_index,
> +				       ps, &dfs_index_fops);
> +
> +	if (IS_ERR(ps->file)) {
> +		pi_sec_remove(mod);
> +		return;
> +	}

No need to check this and try to clean up if there is a problem, just
save the pointer off and call debugfs_remove() when you want to clean
up.

Or better yet, no need to save anything, you can always look it up when
you want to remove it, that will save you one pointer per module.

thanks,

greg k-h
