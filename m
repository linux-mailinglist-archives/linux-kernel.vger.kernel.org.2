Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14F5034A79A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 13:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbhCZMym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 08:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbhCZMyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 08:54:04 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DB7C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 05:54:03 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id h10so6148818edt.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 05:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OIPb4PnfeNb7aO7QS1Gt6gR1nM0DjD7xm0FQGOCf1ow=;
        b=Rr5AjKGW7xZSLkThKiHkUxSaDEamQZG5tNhGKajCxO+kCCg5i0JjTLZkmB1/J3s5mf
         di3SAGqFCiYFlcjbhue1VFt3YKhwggVQrkv9pGyi7nL7UGj0r6y3SQHxq7ArU3CYGWxk
         9ef8Uy0+2edrIBk47lSJI+N2ut1r42kHDDXXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OIPb4PnfeNb7aO7QS1Gt6gR1nM0DjD7xm0FQGOCf1ow=;
        b=AUkeis4WqxIkX0gDFAlseCKTtSi81OOlX95WEi3jVOviw9N5Yu+yGCqYvohYqk9Jk/
         IbVD+XyRYXJ1A9k0O/njZn4uhWkXf7q12B814MhHquDzs4CafFosOr/vYj6hiVrxD6VY
         LlVzPwa8wuSAvKk19j8aD8O+jBoX8C2+n33L+UAgmGgfrmHcDr725iyHhoof2N7OWOS7
         YpFjUtGD/6RszC7wlEtuoDVLLAqVZ8eQVp5qX7Qzliy6COov/L896xuKKEmGGsK+NYR+
         vsOCnEiFeeipfkx/edRSaQwWq8NZ1Ls/UxqsiCcq6x8ZN/8zeow4oDWZEv4BkQHXi7ty
         M/+w==
X-Gm-Message-State: AOAM531jJj0UAL1PgzgOU/O+IOKDEj5O8gCsH1aPHn2FWIo2p3idbxpc
        4YFZS7xYl5iNcdWWbzqZMH3Mcg+ZTnGXKJPC
X-Google-Smtp-Source: ABdhPJw6JY5OOJZYzgEja0KQDbi/yrh57tWQo42RHXucxPw1HK8ZOUjOLv/4Ky73UbNcpl6bXS/8Mg==
X-Received: by 2002:aa7:dd97:: with SMTP id g23mr14749156edv.154.1616763241668;
        Fri, 26 Mar 2021 05:54:01 -0700 (PDT)
Received: from [172.16.11.38] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id rs24sm3823828ejb.75.2021.03.26.05.54.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Mar 2021 05:54:01 -0700 (PDT)
Subject: Re: [PATCH v2 6/9] debugfs: Implement debugfs_create_str()
To:     Peter Zijlstra <peterz@infradead.org>, Greg KH <greg@kroah.com>
Cc:     mingo@kernel.org, mgorman@suse.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        joshdon@google.com, valentin.schneider@arm.com,
        linux-kernel@vger.kernel.org
References: <20210326103352.603456266@infradead.org>
 <20210326103935.183934395@infradead.org> <YF2/41K4xs3ZOQdV@kroah.com>
 <YF3DF+T8nPRgt7Ao@hirez.programming.kicks-ass.net>
 <YF3F0JbbEpeSGzW6@kroah.com>
 <YF3Hv5zXb/6lauzs@hirez.programming.kicks-ass.net>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <70594935-18e6-0791-52f9-0448adf37155@rasmusvillemoes.dk>
Date:   Fri, 26 Mar 2021 13:53:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YF3Hv5zXb/6lauzs@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/2021 12.38, Peter Zijlstra wrote:

> Implement debugfs_create_str() to easily display names and such in
> debugfs.

Patches 7-9 don't seem to add any users of this. What's it for precisely?

> +
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

As noted (accidentally off-list), this is broken. I think you want this
on top

- len = strlen(str) + 1;
+ len = strlen(str);

- strncpy(copy, str, len);
+ memcpy(copy, str, len);
  copy[len] = '\n';
- copy[len+1] = '\0';

> +EXPORT_SYMBOL_GPL(debugfs_read_file_str);

Why?

> +
> +ssize_t debugfs_write_file_str(struct file *file, const char __user *user_buf,
> +			       size_t count, loff_t *ppos)
> +{
> +	struct dentry *dentry = F_DENTRY(file);
> +	char *old, *new = NULL;
> +	int pos = *ppos;
> +	int r;
> +
> +	r = debugfs_file_get(dentry);
> +	if (unlikely(r))
> +		return r;
> +
> +	old = *(char **)file->private_data;
> +
> +	/* only allow strict concattenation */
> +	r = -EINVAL;
> +	if (pos && pos != strlen(old))
> +		goto error;

Other than the synchronize_rcu() below, I don't see any rcu stuff in
here. What prevents one task from kfree'ing old while another computes
its strlen()? Or two tasks from getting the same value of old and both
kfree'ing the same pointer?

And what part of the kernel periodically looks at some string and
decides something needs to be done? Shouldn't a write imply some
notification or callback? I can see the usefulness of the read part to
expose some otherwise-maintained string, but what good does allowing
writes do?

Rasmus
