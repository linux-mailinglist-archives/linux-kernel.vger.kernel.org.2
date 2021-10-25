Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0D143A5CA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 23:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbhJYV1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 17:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbhJYV05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 17:26:57 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687A6C061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 14:24:35 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id oa12-20020a17090b1bcc00b0019f715462a8so1049730pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 14:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cVVSf4gV+VHKaMcPkqXKR+j1Pi643cPAlkbYEqi72eA=;
        b=KaZ4GqG+L5BbOZwNRz+ZFzGoL6DWdRGwHmkuHMpBhtnIoIFP7poSXqXdiC9eBIyduE
         6sSiiJ6O5yk+WTD2QWicyc0FTSHsKOmopPGxh0MCwFc1j6PJnh91QVp8PhupQgoFO3oT
         Q3TjaKiDTb/FYgwk7I8NiHqVtaa3U7K42dudE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cVVSf4gV+VHKaMcPkqXKR+j1Pi643cPAlkbYEqi72eA=;
        b=e/EbudlFpFwA7xOqqItiNrxLsflVoqPI58Y5vEtXkgJiF89VLFeyA71h1MFNGYyIj7
         AbixooKGRruFz9YgdwPfBVNyUKUPV0MLDZgMu0N66htP9Ss7htAN5CgWKQaBcCLrwvLw
         butD5pm0zUQbDrvl0aBNj9fuR/xfkeB9hUT9s0lSD8JN1/KKyKD4RUrHbUHIB+viKMw9
         +PklVCdMlGHRNT0GPEkVxJjg9TwdkhE1AWDwsev95yHRjvsAeceLAUUGSQxrXl3VmZFW
         RSUv3Z89M3KkTmFufjI8XcXOzW4pGxun+vuzEwF6Emu0xVSFWaC3Wx122jfMXcJnlxeu
         YywQ==
X-Gm-Message-State: AOAM533dOpy1C4g3Al3Kf6Vbqp9cWPwhaDGwSW1VYF6N+HeoE29hUfu0
        Y52RHeMTBAw1cfUVxR/hYL2LlQ==
X-Google-Smtp-Source: ABdhPJxJj5ssF3jbgx6poVT90eIK8mxh0IHB+tSEXpyDuQrCC/LZvCXj6OL26lmlGf8XqbtQ3X6+/A==
X-Received: by 2002:a17:90a:514f:: with SMTP id k15mr15033244pjm.71.1635197075028;
        Mon, 25 Oct 2021 14:24:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t11sm21841162pfj.173.2021.10.25.14.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 14:24:34 -0700 (PDT)
Date:   Mon, 25 Oct 2021 14:24:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     akpm@linux-foundation.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, arnaldo.melo@gmail.com,
        pmladek@suse.com, peterz@infradead.org, viro@zeniv.linux.org.uk,
        valentin.schneider@arm.com, qiang.zhang@windriver.com,
        robdclark@chromium.org, christian@brauner.io,
        dietmar.eggemann@arm.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        dennis.dalessandro@cornelisnetworks.com,
        mike.marciniszyn@cornelisnetworks.com, dledford@redhat.com,
        jgg@ziepe.ca, linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, oliver.sang@intel.com, lkp@intel.com,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH v6 08/12] tools/bpf/bpftool/skeleton: make it adopt to
 task comm size change
Message-ID: <202110251421.7056ACF84@keescook>
References: <20211025083315.4752-1-laoar.shao@gmail.com>
 <20211025083315.4752-9-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025083315.4752-9-laoar.shao@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 08:33:11AM +0000, Yafang Shao wrote:
> bpf_probe_read_kernel_str() will add a nul terminator to the dst, then
> we don't care about if the dst size is big enough.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Petr Mladek <pmladek@suse.com>

So, if we're ever going to copying these buffers out of the kernel (I
don't know what the object lifetime here in bpf is for "e", etc), we
should be zero-padding (as get_task_comm() does).

Should this, instead, be using a bounce buffer?

get_task_comm(comm, task->group_leader);
bpf_probe_read_kernel_str(&e.comm, sizeof(e.comm), comm);

-Kees

> ---
>  tools/bpf/bpftool/skeleton/pid_iter.bpf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
> index d9b420972934..f70702fcb224 100644
> --- a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
> +++ b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
> @@ -71,8 +71,8 @@ int iter(struct bpf_iter__task_file *ctx)
>  
>  	e.pid = task->tgid;
>  	e.id = get_obj_id(file->private_data, obj_type);
> -	bpf_probe_read_kernel(&e.comm, sizeof(e.comm),
> -			      task->group_leader->comm);
> +	bpf_probe_read_kernel_str(&e.comm, sizeof(e.comm),
> +				  task->group_leader->comm);
>  	bpf_seq_write(ctx->meta->seq, &e, sizeof(e));
>  
>  	return 0;
> -- 
> 2.17.1
> 

-- 
Kees Cook
