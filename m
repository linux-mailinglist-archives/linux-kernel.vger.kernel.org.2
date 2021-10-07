Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 934F44255CE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 16:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242202AbhJGOyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 10:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbhJGOyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 10:54:12 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCF8C061570
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 07:52:18 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id q19so5076869pfl.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 07:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XzU6oWjvmOHgCKTPrKN0uGNh1889uFEZ8Tg39EoSLKM=;
        b=JCEpDS3KTeXpR8Z/rZUHez8x3bbvKmt/de9LG9aO7vvj1JDE9LdN50zKW3tC9Cdtvo
         t1ioptpTk0zh1bdqaGOshS9+hMna0KS/z2RkSiaRDOivGX33cppYPs8kOpjFtU/M/Aet
         wzxH5vkr1tslrTinXtn9k0rODukyqSeDSX9Vg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XzU6oWjvmOHgCKTPrKN0uGNh1889uFEZ8Tg39EoSLKM=;
        b=3auOxv6C92c//TawKheLCONghUZevRR7e+pf1O/+q0Wxharw8/tFh8IaoAfI13O7zD
         du6l/yTUpyjJ6ZSzfy1iowFp4hIZ7bDTnC2SRI3tqybhFLjksDTX8LHw7pKgMm95J08v
         rhILtLzUeuyW2IXpDKtjf53ANMtT5otfCW3G3w6sNfx/D/VxPk8c9smGlQPwWkiHs0Z/
         pS2IrhOA+HDIteKV9YRxaybfAk/HyEguUJvCCu0U8mrKNA2vlvO/7OtHsXOUtnyVy1dv
         Zf8IG6Drcqh4Q78CdQs/QGM12VzkvKPootIvhGFXHgbWmWscIMv5i/1l7VgVzoiHUTrw
         CG2w==
X-Gm-Message-State: AOAM531iK8c49GUej0t1LlpkTHUU6+k+hTOHSMCn2EIUETX6eQC2XQ/e
        1FWx6xAs0bp3KXLS4F7hlMy0Jw==
X-Google-Smtp-Source: ABdhPJx02qsLlnxcSayzlm98BBxWeT7fi5YclxkRodrFmaUOuJTyiXI8sl+/+tXePSd+w1stfWO79Q==
X-Received: by 2002:a65:6919:: with SMTP id s25mr103960pgq.14.1633618337790;
        Thu, 07 Oct 2021 07:52:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id mu7sm1062709pjb.12.2021.10.07.07.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 07:52:17 -0700 (PDT)
Date:   Thu, 7 Oct 2021 07:52:16 -0700
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
Subject: Re: [PATCH v2 2/4] fs/exec: use strscpy instead of strlcpy in
 __set_task_comm
Message-ID: <202110070751.929BA101@keescook>
References: <20211007120752.5195-1-laoar.shao@gmail.com>
 <20211007120752.5195-3-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211007120752.5195-3-laoar.shao@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2021 at 12:07:50PM +0000, Yafang Shao wrote:
> Fix a warning by checkpatch -
> WARNING: Prefer strscpy over strlcpy - see: https://lore.kernel.org/r/CAHk-=wgfRnXz0W3D37d01q3JFkr_i_uTL=V6A6G1oUZcprmknw@mail.gmail.com/
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Petr Mladek <pmladek@suse.com>

Acked-by: Kees Cook <keescook@chromium.org>

> ---
>  fs/exec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index a098c133d8d7..de804c566200 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1224,7 +1224,7 @@ void __set_task_comm(struct task_struct *tsk, const char *buf, bool exec)
>  {
>  	task_lock(tsk);
>  	trace_task_rename(tsk, buf);
> -	strlcpy(tsk->comm, buf, sizeof(tsk->comm));
> +	strscpy(tsk->comm, buf, sizeof(tsk->comm));
>  	task_unlock(tsk);
>  	perf_event_comm(tsk, exec);
>  }
> -- 
> 2.18.2
> 

-- 
Kees Cook
