Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E08434255CD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 16:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbhJGOxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 10:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbhJGOxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 10:53:31 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF27EC061570
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 07:51:37 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id oa4so4356545pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 07:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3QB8saS3JRIZ6eavTTZGFEjLfGz41msFL13pyQ7z2Ao=;
        b=eS4Wyb/IyqSrxKywPLgyikXjs8UufTkpgqjooY9W6IplrRZTUUV4HUtBMGlzunygUB
         X/+XP65s+Sp7mD0fWy0lU4y9dtmkgcSeAQ2RS33PBvcqYC9GyfTA7naooUbiT5no8cs3
         Qlih58zatTHWEGYPgVbgz1DPGiNTGA6hiecPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3QB8saS3JRIZ6eavTTZGFEjLfGz41msFL13pyQ7z2Ao=;
        b=ikLGJGL7s/b+iASJobpTdOqqvnMuRSKifbndCKMlXEk1lR67FhxqAksHDt4eKTDwDc
         Qao1u8wgdiwyb3QXeSTa/IBpe5iIW46xsFoH8boWNUrVg0rkO183L30s5ca/K5vv0WkQ
         cZjENC32LTrE6GwYdajgfP3Yxz5iPU3p+9tAJu8++0dOp1x4ozESc9kRann4XA2WwuTT
         xFu1vHJd5N5fCyhiFI0KfEA6LtQISniz3kRkuso5Xcm22nX4VoTWkwY4AxBBGR7qtx84
         Vt2yka4ORbYA1IfN0trfQmE8vHjzJKhY9YZXraFBBIyYhKQlDJqQg+lTV40R+y07ubML
         05nQ==
X-Gm-Message-State: AOAM532DbbwhC45Dl6TCl84ptsRctTtrW+l15LkqiRMsnhO9vzdL8dc7
        Ngn3hBiiy4jvNxobtzJpjGOpbg==
X-Google-Smtp-Source: ABdhPJwfn/eBr+c8IrcUcAVwcmAt6Ws0XCqvOhT45BBeaNzP1oiku0gw/Z33R9FFyI9quPjUppbhkw==
X-Received: by 2002:a17:902:854c:b0:13a:519c:67ea with SMTP id d12-20020a170902854c00b0013a519c67eamr4464358plo.82.1633618297466;
        Thu, 07 Oct 2021 07:51:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b11sm24374575pge.57.2021.10.07.07.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 07:51:37 -0700 (PDT)
Date:   Thu, 7 Oct 2021 07:51:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     pmladek@suse.com, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, peterz@infradead.org,
        valentin.schneider@arm.com, mathieu.desnoyers@efficios.com,
        qiang.zhang@windriver.com, robdclark@chromium.org,
        christian@brauner.io, dietmar.eggemann@arm.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        Vladimir Zapolskiy <vzapolskiy@gmail.com>
Subject: Re: [PATCH v2 1/4] cn_proc.h: use TASK_COMM_LEN instread of 16 in
 struct proc_event
Message-ID: <202110070750.8754AA33@keescook>
References: <20211007120752.5195-1-laoar.shao@gmail.com>
 <20211007120752.5195-2-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211007120752.5195-2-laoar.shao@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2021 at 12:07:49PM +0000, Yafang Shao wrote:
> struct comm_proc_event was introduced in commit
> f786ecba4158 ("connector: add comm change event report to proc connector").
> It seems that there is no strong reason we must define the comm as a
> hardcode 16 bytes. So we can use TASK_COMM_LEN instead.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Vladimir Zapolskiy <vzapolskiy@gmail.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Petr Mladek <pmladek@suse.com>
> ---
>  include/uapi/linux/cn_proc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/cn_proc.h b/include/uapi/linux/cn_proc.h
> index db210625cee8..351d02786350 100644
> --- a/include/uapi/linux/cn_proc.h
> +++ b/include/uapi/linux/cn_proc.h
> @@ -110,7 +110,7 @@ struct proc_event {
>  		struct comm_proc_event {
>  			__kernel_pid_t process_pid;
>  			__kernel_pid_t process_tgid;
> -			char           comm[16];
> +			char           comm[TASK_COMM_LEN];
>  		} comm;

Hrmm. This is UAPI -- we can't change it without potentially breaking
things (i.e. userspace binaries have this size built in, so we can't
just change the size). This will either need to stay truncated, or may
need a new interface with a variable-sized structure...

-Kees

>  
>  		struct coredump_proc_event {
> -- 
> 2.18.2
> 

-- 
Kees Cook
