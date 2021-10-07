Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4919B4255DF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 16:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242220AbhJGO6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 10:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbhJGO6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 10:58:54 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424C6C061570
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 07:56:59 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id r201so53347pgr.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 07:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aY9YNaCzgoUZ9uT+Ybn9qFqS/TgJNUNrYOj5uKjtZis=;
        b=eq7nqeO7gD4JfZB5BNsV68QEzyUQAkTeYyRndfSvY/hscVVEna52P4W6ZL6Y95wdyK
         3OWRU9H71Yn5UWwpMr5sv+OvNQMlWu4Z6iSEvM6A9EismHzhme7kHz15SW26tYf+WSMu
         KOPNs+PxbtN03MF6n4st8zFcs0v+iteS7dkd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aY9YNaCzgoUZ9uT+Ybn9qFqS/TgJNUNrYOj5uKjtZis=;
        b=79ksEIht3EjZJ+or7UKXie9c4kAVPalOoNsYX7492tZXEmQSb+KyEdXyyxCKiDER88
         uwDOx55jncx9ssSMBh8DR4LJVF3ti+VJz19ZnYsr/L5ML3jDzyTzcyzBoPlGDlEOm1Lq
         hiNkiVHkzS7bczoy6d7oPqzOSbK6oajGTgPHX7ERSURCN1uNWc0q+1g7LIdkYeY6z9zy
         cA+yi59reYHKWdY1BBp4r7HuAcsw9h2KDW9iGSmMhNYzCbgapvzjuKTj3MlWp0TmZqoq
         iM+LwxZqTLJoJoB98bnsrzHKx87tfLaSWkAejwsuwV0rVqeJEB25j9bj5DNXw0B0YR7u
         latw==
X-Gm-Message-State: AOAM531wA3oLXPBIE7p/1NT0ev6AOm0Sq7xcwbjQjR94GCfZaGmtKdTz
        UrbKosdzpQnF+cDMWCAK7bbTNQ==
X-Google-Smtp-Source: ABdhPJwdjJVWqzJK8hHj1Fqq59k1QINSAPGBZwIJevmzwG7MkvAgaiMb4RYfSb8lGRNYW2Qf62JSCA==
X-Received: by 2002:a63:374c:: with SMTP id g12mr85093pgn.35.1633618618740;
        Thu, 07 Oct 2021 07:56:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z7sm14483740pff.23.2021.10.07.07.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 07:56:58 -0700 (PDT)
Date:   Thu, 7 Oct 2021 07:56:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     pmladek@suse.com, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, peterz@infradead.org,
        valentin.schneider@arm.com, mathieu.desnoyers@efficios.com,
        qiang.zhang@windriver.com, robdclark@chromium.org,
        christian@brauner.io, dietmar.eggemann@arm.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] sched.h: extend task comm from 16 to 24 for
 CONFIG_BASE_FULL
Message-ID: <202110070755.60DFB87711@keescook>
References: <20211007120752.5195-1-laoar.shao@gmail.com>
 <20211007120752.5195-4-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211007120752.5195-4-laoar.shao@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2021 at 12:07:51PM +0000, Yafang Shao wrote:
> When I was implementing a new per-cpu kthread cfs_migration, I found the
> comm of it "cfs_migration/%u" is truncated due to the limitation of
> TASK_COMM_LEN. For example, the comm of the percpu thread on CPU10~19 are
> all with the same name "cfs_migration/1", which will confuse the user. This
> issue is not critical, because we can get the corresponding CPU from the
> task's Cpus_allowed. But for kthreads correspoinding to other hardware
> devices, it is not easy to get the detailed device info from task comm,
> for example,
> 
>     jbd2/nvme0n1p2-
>     nvidia-modeset/
> 
> We can also shorten the name to work around this problem, but I find
> there are so many truncated kthreads:
> 
>     rcu_tasks_kthre
>     rcu_tasks_rude_
>     rcu_tasks_trace
>     poll_mpt3sas0_s
>     ext4-rsv-conver
>     xfs-reclaim/sd{a, b, c, ...}
>     xfs-blockgc/sd{a, b, c, ...}
>     xfs-inodegc/sd{a, b, c, ...}
>     audit_send_repl
>     ecryptfs-kthrea
>     vfio-irqfd-clea
>     jbd2/nvme0n1p2-
>     ...
> 
> Besides the in-tree kthreads listed above, the out-of-tree kthreads may
> also be truncated:
> 
>     rtase_work_queu
>     nvidia-modeset/
>     UVM global queu
>     UVM deferred re
>     ...
> 
> We should improve this problem fundamentally.
> 
> This patch extends the size of task comm to 24 bytes, which is the
> same length with workqueue's, for the CONFIG_BASE_FULL case. And for the
> CONFIG_BASE_SMALL case, the size of task comm is still kept as 16 bytes.
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

This, as expected, adds 8 bytes to task_struct, which is reasonable. I
don't see any easy places to consolidate other members to make this a
"free" change, but I did just remove 64 bytes from task_struct[1], so
this is okay. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

[1] https://lore.kernel.org/lkml/20210924025450.4138503-1-keescook@chromium.org/

-- 
Kees Cook
