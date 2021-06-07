Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0C2939EA0B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 01:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbhFGXUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 19:20:53 -0400
Received: from mail-pf1-f170.google.com ([209.85.210.170]:44985 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbhFGXUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 19:20:51 -0400
Received: by mail-pf1-f170.google.com with SMTP id u18so14240967pfk.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 16:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7enO4NtQ2aqqP6tz58zY+25dGjq834VWlAo1YL2PSJU=;
        b=i/Yo9IxIolr0k6IvaDYl3yGrjIePm0xy63F6tv5De7tDIvpygn0PRJYxXHTuH5dbaZ
         QON6wL1BAg4Q+KUJgu/+n0rlivX1dUnaHFOJdULPM2uhy2Q4WGIFh9MBVEINj1SMFPlM
         d85gwJXyBhRi2GJ7caPsoQWPtlxPhKoCTgwrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7enO4NtQ2aqqP6tz58zY+25dGjq834VWlAo1YL2PSJU=;
        b=FI3nYL3lK668EHwUEodJAdaJAbjcusSka9GbnEbijBUViNi1FqC5C+IAhjyISLGR3D
         Wpcp5e7oaOqMVsKUBSlEVapP40CdbtcSjA7KLZPUEinAizlpe+in3RCJna8y+rlQpyLR
         G9ndPIqg8oJesqkvA0O+bKB0kj0DMIwC5dQLXeHCoUK555mGLj98tdJ3EVgxeP0Y7asf
         qGd5qdGRdN9Tsowp72YYKBoYv68a313EZ5mden1ysaxpeA6gXAJgrBgTG+mWAbF3hsKL
         oGClWCirsMkapKOqGTOqYXwwe3ZtghCyDAWDo7ld1fLvQFyCZ2ykr9xF75mtJBd/Vnom
         8j0w==
X-Gm-Message-State: AOAM531Lq8RrdfraJEUda2mrb8qbr0dDJ6SmQbdvH6w2z25f8MVIBcCG
        pjeLR6ZW5yRMZVBmZ6PA2yZsDQ==
X-Google-Smtp-Source: ABdhPJzoloNWwXXzGEtNUVdr2Eg3gvBKxyCkTkENCk3XmjikAfGX4r4l8HQpyrVi7sqk0A+e9b7euw==
X-Received: by 2002:a63:e253:: with SMTP id y19mr19920458pgj.137.1623107865845;
        Mon, 07 Jun 2021 16:17:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 192sm8838002pfw.200.2021.06.07.16.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 16:17:42 -0700 (PDT)
Date:   Mon, 7 Jun 2021 16:17:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] exec: Copy oldsighand->action under spin-lock
Message-ID: <202106071617.5713E0A01@keescook>
References: <AM8PR10MB470871DEBD1DED081F9CC391E4389@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM8PR10MB470871DEBD1DED081F9CC391E4389@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 03:54:27PM +0200, Bernd Edlinger wrote:
> unshare_sighand should only access oldsighand->action
> while holding oldsighand->siglock, to make sure that
> newsighand->action is in a consistent state.
> 
> Signed-off-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
> ---
>  fs/exec.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index d8af85f..8344fba 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1193,11 +1193,11 @@ static int unshare_sighand(struct task_struct *me)
>  			return -ENOMEM;
>  
>  		refcount_set(&newsighand->count, 1);
> -		memcpy(newsighand->action, oldsighand->action,
> -		       sizeof(newsighand->action));
>  
>  		write_lock_irq(&tasklist_lock);
>  		spin_lock(&oldsighand->siglock);
> +		memcpy(newsighand->action, oldsighand->action,
> +		       sizeof(newsighand->action));
>  		rcu_assign_pointer(me->sighand, newsighand);
>  		spin_unlock(&oldsighand->siglock);
>  		write_unlock_irq(&tasklist_lock);

Oh, yeah, that's a nice catch.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
