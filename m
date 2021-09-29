Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3715941CB91
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 20:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345809AbhI2SOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 14:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244341AbhI2SOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 14:14:06 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23B0C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 11:12:24 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id lp15-20020a17090b4a8f00b0019f4059bd90so1176963pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 11:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FHDT82b5KB8syw+NMOJUmt2lQS9ECSu/BSPAxbnyL+g=;
        b=m55zZTudwe+l8G97DQdwmw6bH/VZdzwM5/pGJr53C12S9KGKzBmxzgpwP1BxoJxsjT
         DGLvIv5VGAmhDsqedFEfDrgkZCILgQFTfULGIkfV7n+4KrR3QKMqrtLA64eTUB+eGNDk
         4f6TirWRE4sTAqBbNZTgT7is245zlP190sfUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FHDT82b5KB8syw+NMOJUmt2lQS9ECSu/BSPAxbnyL+g=;
        b=wP9LtEOz+j+mvN0loeIkpTUdgR4w8n21L+pU+ysAgf1Z5TvfgPK2fP4EYOwYCoSxV0
         TXnVJAUlzKEn0ts0KpVCnMc0Cf/L7yUEwpxd1NwKuwoFEmhxZlnNQPlB8oODrG7xbC3m
         Jh5b57e1+Sz6anddxMKhfHf6JhaAoJPEh8DYDwZOtt0PVUBvfgQMpUH4dO5tEuSnB9xK
         R+aIZSPH+YgqlQLs3YCtL+VETvq1CvsexvfJo9VGEpRIe48fHCzFv+W81OR+O7Jsw5hA
         Nv7FztJQeNqmFLffEb5wwYso26nkLg2MGdtSdvrK9OBVR0Q4Ng4EoT3kCYWnhnzEdkUC
         cQ6g==
X-Gm-Message-State: AOAM531uZ3/04KaudfkEQXUQ1sbE14gmuP2yAyGs2vR9EECkTb0dIpz1
        /XP+sOI5XvD+v1qF0EMx+10ZWg==
X-Google-Smtp-Source: ABdhPJwEEjSgCAF/qxbshAFC5Ok4Kd7jJ15JWojb39E2gcDhh8excyNifAudqex+M+AOsaVQJCNR+A==
X-Received: by 2002:a17:90b:38c6:: with SMTP id nn6mr1392701pjb.94.1632939144350;
        Wed, 29 Sep 2021 11:12:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g19sm2560936pjl.25.2021.09.29.11.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 11:12:23 -0700 (PDT)
Date:   Wed, 29 Sep 2021 11:12:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     akpm@linux-foundation.org, pmladek@suse.com, peterz@infradead.org,
        valentin.schneider@arm.com, mathieu.desnoyers@efficios.com,
        qiang.zhang@windriver.com, robdclark@chromium.org,
        viro@zeniv.linux.org.uk, christian@brauner.io,
        dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] kernel/sched: improve the BUILD_BUG_ON() in
 get_task_comm()
Message-ID: <202109291111.31671B6A6@keescook>
References: <20210929115036.4851-1-laoar.shao@gmail.com>
 <20210929115036.4851-4-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929115036.4851-4-laoar.shao@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 11:50:34AM +0000, Yafang Shao wrote:
> What we really want to guarantee is that the buf size can't be less than
> TASK_COMM_LEN. While the size be greater than TASK_COMM_LEN is
> acceptable.

This makes sense when task_struct::comm is a pointer. (But I think it's
not a good idea to do that.)

-Kees

> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  include/linux/sched.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index b387b5943db4..959eaef248fc 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1931,7 +1931,7 @@ static inline void set_task_comm(struct task_struct *tsk, const char *from)
>  
>  extern char *__get_task_comm(char *to, size_t len, struct task_struct *tsk);
>  #define get_task_comm(buf, tsk) ({			\
> -	BUILD_BUG_ON(sizeof(buf) != TASK_COMM_LEN);	\
> +	BUILD_BUG_ON(sizeof(buf) < TASK_COMM_LEN);	\
>  	__get_task_comm(buf, sizeof(buf), tsk);		\
>  })
>  
> -- 
> 2.17.1
> 

-- 
Kees Cook
