Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86743101D9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 01:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbhBEAsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 19:48:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbhBEAsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 19:48:41 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DB9C0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 16:48:01 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id w1so8821970ejf.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 16:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6cxI6fZNStXxMO/aSetmOwSh08Jb00YMW0Z3C4YiT+4=;
        b=I7tOFQ2enpaxxNhJTbnozjO29GdRwNQaBkgUWYPwRQhECNdl4aZLGkxYF95XaQygqV
         YCfqA8vKImogXJbbsaDNRfRdUWHXFK95ZrKSR10cNIoxooyiRiYYxzjkt7F04+8AlnJQ
         yVwu/RdggeZUvv/s3KsBDYfzeUWnGwWYia5qk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6cxI6fZNStXxMO/aSetmOwSh08Jb00YMW0Z3C4YiT+4=;
        b=fLGEbNxDFglryfq6pKW0XDlmhUoDt+f7Ag9DJP1cPDqvUGLGaoC2cFpTeePC6/FElG
         ee3F4awsGFeTbTfIEScRo3E/0UrtU7dq6LPjfITfeHp9hg15vkcCkCUIlobK5ZOs+YNH
         hb1kVMf8Z1wR/+93AUw4J4wpbHcrcnuZGTRRH/U9pMrTQIRZ5bKF6UCJc2+0OvsGmiTw
         1c0nkz9o/nwYmcH25/f+SN9ByqjkLs1K3N3DypQ1E0XcQq/Z/NmOkZCpEU/TzJH6WVZB
         qyQO+eFRKWQIe9AXtImkk1XCCLlfbko5bp0pjnokQBc5snQejDLjTrE6aITcSkPU2Jqo
         9i8A==
X-Gm-Message-State: AOAM531mGQvTbTrfPf1qqEKQyiihbEs+S192E3/Ec4hsZpvBobG6Xc9G
        Dma4aS/Zj6x+rsF3MWInsxQShOAy6j2vpF2a
X-Google-Smtp-Source: ABdhPJyClbkMpCkf2Z4FMFAG5Q3KDnMAIjnynD91K1+V/ixKcfRDW8XxOItfnA/1AMm7kc3w0JKeoQ==
X-Received: by 2002:a17:906:ecb6:: with SMTP id qh22mr1674012ejb.252.1612486079699;
        Thu, 04 Feb 2021 16:47:59 -0800 (PST)
Received: from localhost ([2620:10d:c093:400::4:2256])
        by smtp.gmail.com with ESMTPSA id l12sm1195546edn.83.2021.02.04.16.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 16:47:59 -0800 (PST)
Date:   Fri, 5 Feb 2021 00:47:58 +0000
From:   Chris Down <chris@chrisdown.name>
To:     linux-kernel@vger.kernel.org
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>, kernel-team@fb.com
Subject: Re: [PATCH] printk: Userspace format enumeration support
Message-ID: <YByVvsFL5/X/+kLc@chrisdown.name>
References: <YBwU0G+P0vb9wTwm@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YBwU0G+P0vb9wTwm@chrisdown.name>
User-Agent: Mutt/2.0.5 (da5e3282) (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some improvements I noticed that I'll include when sending v2.

Chris Down writes:
>+static void remove_printk_fmt_sec(const struct module *mod)
>+{
>+	struct printk_fmt_sec *tmp = NULL, *ps = NULL;
>+	const char **fptr = NULL;

fptr can be scoped to list_for_each_entry_safe, I'll move it.

>+static int proc_pf_show(struct seq_file *s, void *v)
>+{
>+	const struct printk_fmt_sec *ps = NULL;
>+	const char **fptr = NULL;

Ditto for list_for_each_entry.

>+
>+	mutex_lock(&printk_fmts_mutex);
>+
>+	list_for_each_entry(ps, &printk_fmts_list, list) {
>+		const char *mod_name = ps_get_module_name(ps);
>+
>+		for (fptr = ps->start; fptr < ps->end; fptr++) {
>+			seq_puts(s, mod_name);
>+			seq_putc(s, ',');
>+			seq_puts(s, *fptr);
>+			seq_putc(s, '\0');
>+		}
>+	}

Not sure why I didn't just use seq_printf here. I'll do that.

I'll wait a few days for feedback then will send v2 either way. :-)
