Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6E1333C55
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 13:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbhCJMNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 07:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbhCJMNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 07:13:04 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06D1C061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 04:12:59 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id v15so23073046wrx.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 04:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2jMJK28WtR6oXpGE7TxbnN5/n+ld3XVP7kWfc41ictM=;
        b=qgPAQatdo8lw9ehH18VYtXVaK6hjfA1M61kOFr4oGqC2PvgWSA9nZVYkoWw4U2PmHv
         K0Q70wEfp9StuwkNvGTXeo1w9cccMgBtL04zBFLkI2og8XHy2YosJvKCODzgUQIR1Qud
         vnvwrP/AksCKVHa9/l4DgoRmjeFJ9UDaj+brs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2jMJK28WtR6oXpGE7TxbnN5/n+ld3XVP7kWfc41ictM=;
        b=seCfNZScU4Z9bm4u5fD4xfsJ20Z9eHpgfZcAyM23CJAGzuCvZvZM1VLVWfD7WQC5Wz
         Qzn5g+KtqhqIPjnIW4ZJJN2Z2OssMXQHbHGAKEM1mNZUbGe8OCLJXx/dlkxEHK91+1i+
         uaD0XSck7GlYYhNBOaxhm5MZgNpcMhG2X6n7hboMlSss+VG9NOt1eOgFqwGtKe7rAcYt
         1rlv6R35GLgY4jBgJom4Knl6oddcxkLIhezJupS9NfUe6iO+0XiEoPcdXce8QXNFKquN
         HlPT1NQN8d6l2+PfuKuh2TmvoL3cDYD3TLySW650Ec57ernFgxNkGcgbBucRxvGSr1p6
         +gog==
X-Gm-Message-State: AOAM532NjyTlOZt2TDdntmAOatdAWLbxrdsysL1pgNQgT4bRgZlYNPuy
        hvoqnJETNYAb5Fkp3ETz+pMeNQ==
X-Google-Smtp-Source: ABdhPJzahn54Y0hS7bocTV2UANCHjLwYCzwTfXOwdjCqkH1YH7m4TXBWG0FzqamcvEp6kbs+B8sz6Q==
X-Received: by 2002:adf:f0c1:: with SMTP id x1mr3189443wro.7.1615378378638;
        Wed, 10 Mar 2021 04:12:58 -0800 (PST)
Received: from localhost ([2a01:4b00:8432:8a00:63de:dd93:20be:f460])
        by smtp.gmail.com with ESMTPSA id 75sm9491079wma.23.2021.03.10.04.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 04:12:58 -0800 (PST)
Date:   Wed, 10 Mar 2021 12:12:57 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>, kernel-team@fb.com
Subject: Re: [PATCH v5] printk: Userspace format enumeration support
Message-ID: <YEi3ySLkw3hZinnS@chrisdown.name>
References: <YEgvR6Wc1xt0qupy@chrisdown.name>
 <YEhsHELBM20f4MRE@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YEhsHELBM20f4MRE@kroah.com>
User-Agent: Mutt/2.0.5 (da5e3282) (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman writes:
>On Wed, Mar 10, 2021 at 02:30:31AM +0000, Chris Down wrote:
>> +	ps->file = debugfs_create_file(pi_get_module_name(mod), 0444, dfs_index,
>> +				       ps, &dfs_index_fops);
>> +
>> +	if (IS_ERR(ps->file)) {
>> +		pi_sec_remove(mod);
>> +		return;
>> +	}
>
>No need to check this and try to clean up if there is a problem, just
>save the pointer off and call debugfs_remove() when you want to clean
>up.

Petr, what are your thoughts on this, since you requested the cleanup on 
debugfs failure? :-)

>Or better yet, no need to save anything, you can always look it up when
>you want to remove it, that will save you one pointer per module.

That's a good point, and with that maybe we can even do away with the pi_sec 
entirely then since that only leaves start/end pointers which we can calculate 
on demand from existing data.
