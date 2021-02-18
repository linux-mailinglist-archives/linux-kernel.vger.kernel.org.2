Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9D031EE26
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 19:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbhBRSU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 13:20:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbhBRPx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 10:53:59 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D1EC061788
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 07:53:16 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id b3so3521410wrj.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 07:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KySOASwa793Ua76KWy5R7JEdwfwwQx7L6/6kuI7w08E=;
        b=Kw7j+1+m5HcGUvH3ldtEH1oAJrEl8d24WwRUK5K40CYqbAk/Ph1OBaJT1L3xwBfadO
         CnOmNfNli9YwjbfeZoyN45Wtecpl7hzINT5N+853D0Sf3iddwkDszlP/UEiAQVt5yxf7
         xf51cE8oPNJnmfVlwGoZBtfHuyfPf8HWeOG6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KySOASwa793Ua76KWy5R7JEdwfwwQx7L6/6kuI7w08E=;
        b=QS71YqOpq2PkfRZagzYxgtkjAGdxikPePWbmOdyQ668Vlcee/9Utux07p4QMoKpy2U
         /5jrrCp+ckxfWORZ547VmRKIgel/8VsWFQrP4nkHvj+DTxvOGyqjhz8At0893NASagdS
         RNrrBnl0yHvyeaPhVExgEDoloXHCUKi6R2AJfJNl7GAQOB/lwBQDllgm44OUTF78bGmT
         Bf++sXy2atLvbRL4hIY9fQLiYJuGLyqZHpW+oPrj3I2kM3LWtOu8PffiV++ym0SQE2sc
         n5dxN90rJmC3tOOgvqmb7aJYSWw7GsPhUtwdOmMwLxnBLwnFya8Q93KvUcTa9m24OpD/
         BEtQ==
X-Gm-Message-State: AOAM531LJmXNQikFszSx51CjrM+KRDGf872CMZ5mV9JRPrW8hbGrd++l
        9y1wQHQt8XjyXY2GmsmskDqq3Q==
X-Google-Smtp-Source: ABdhPJzWA99C2yY8n/tMO7JrRQWN+szFE1jLelAnCSWzZtu4KbfxLiuGeLXPRmae9t8LYWkpbAjZqg==
X-Received: by 2002:a5d:4e0f:: with SMTP id p15mr4928885wrt.312.1613663595406;
        Thu, 18 Feb 2021 07:53:15 -0800 (PST)
Received: from localhost ([2620:10d:c093:400::4:f7e9])
        by smtp.gmail.com with ESMTPSA id n9sm8872645wmi.43.2021.02.18.07.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 07:53:15 -0800 (PST)
Date:   Thu, 18 Feb 2021 15:53:14 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, kernel-team@fb.com
Subject: Re: [PATCH v4] printk: Userspace format enumeration support
Message-ID: <YC6NaqZbNibxtS7f@chrisdown.name>
References: <YCafCKg2bAlOw08H@chrisdown.name>
 <YC5b4+hTjrGwG22o@chrisdown.name>
 <YC5flsiUEZnPs7qz@alley>
 <YC5ggyeC0uqtOD6R@chrisdown.name>
 <YC54vyU8ZZPiaYOQ@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YC54vyU8ZZPiaYOQ@alley>
User-Agent: Mutt/2.0.5 (da5e3282) (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Mladek writes:
>On Thu 2021-02-18 12:41:39, Chris Down wrote:
>> Petr Mladek writes:
>> > > - See if it's safe to pass a printk_fmt_sec to seq_file instead of a module
>> >
>> > Also it might be needed to store the pointer to struct module.
>>
>> You mean, have a `struct module` entry for this? I somewhat suspect that
>> module.c maintainers are not likely to be happy about injecting non-generic
>> code into there if it's possible to be avoided, but maybe I'm
>> misunderstanding?
>
>Yes, I suggest to store the pointer into struct module. It includes
>many external entries. It is similar to struct task_struct.

Ah yes, now you mention it that does look fine. Thanks!

Expect v5 in the coming days, then. :-)
