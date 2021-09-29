Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0D9541CBB5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 20:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344188AbhI2SWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 14:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343727AbhI2SWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 14:22:32 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEC6C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 11:20:51 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id w14so2698722pfu.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 11:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AcBDvdqL3LtQBpR2ivVZmwmH8hSzSyiK0ro2WwzMMBA=;
        b=Hbj598brnbLE9995IYxHYeuOe6iab8cbrGDh0JyU+h5eutFmdyWy/n0pq0ldQfuZo6
         fazCfmwJjinUO83u+lEhCO1R9C1kf3ZeSd6MrMhFsK/ZKK1nRDYvfSIAa8oQEgvU+dxl
         IldGiLQzPL3sMA9svoqnbA4vPcGmKnow1vIrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AcBDvdqL3LtQBpR2ivVZmwmH8hSzSyiK0ro2WwzMMBA=;
        b=uaksLyExx55ddxTdBWLbCjeg+UW506Kwn3MmO9ZlCa4gEfLi+cQCR0xZ5o8ASWIvPH
         moofxo+T4WloMLinD43ee6ilYlDQBIqn5ARbnDVaxHauY2679bPB5K8sCPL1auWripzY
         l47fwbvdEPRDYNUdmJ9Vzbl+wWbQEs6K0EUOsCRT0/f0fz8saRvXQOW+lHIgbzSmZpWR
         dsV3wuOlq++4vsQ12Tpm43S16UUp5UW5qziwAkY3I1YP7Wi7B8+NDzAB/VhgNSRbGGBg
         LyKj4oBUlOFDTMlk3Qq+EE+J6VzJgZNinuHi2ICQzMhm2/Pilg2QI7fy5Vy1XF2K4b2j
         bpfA==
X-Gm-Message-State: AOAM533V8+NCyFI7jmMQfeap6+XDHC/p5fe/AlCOPU7TyZR1uIH+2bQq
        8X6DTN4wmH9ikFHrYMeNXVDFzg==
X-Google-Smtp-Source: ABdhPJxtpQ8wBp3WrdpJOp0UQXZr0LR/dy5CHbH27T2hDP3QahKgcAca/ct6lKZbE+4nVTyCImN7pg==
X-Received: by 2002:aa7:9f5e:0:b0:447:baeb:bc4e with SMTP id h30-20020aa79f5e000000b00447baebbc4emr34029pfr.64.1632939651091;
        Wed, 29 Sep 2021 11:20:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v24sm453573pff.107.2021.09.29.11.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 11:20:50 -0700 (PDT)
Date:   Wed, 29 Sep 2021 11:20:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     akpm@linux-foundation.org, pmladek@suse.com, peterz@infradead.org,
        valentin.schneider@arm.com, mathieu.desnoyers@efficios.com,
        qiang.zhang@windriver.com, robdclark@chromium.org,
        viro@zeniv.linux.org.uk, christian@brauner.io,
        dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] kernel/kthread: show a warning if kthread's comm is
 still trucated
Message-ID: <202109291120.C37E6C9E6@keescook>
References: <20210929115036.4851-1-laoar.shao@gmail.com>
 <20210929115036.4851-6-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929115036.4851-6-laoar.shao@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 11:50:36AM +0000, Yafang Shao wrote:
> Show a warning if the ktrhead's comm is still trucated. Below is the
> result of my test case -
> 
> __kthread_create_on_node:410: comm of pid 14 is truncated from "I-am-a-kthread-with-long-name" to "I-am-a-kthread-with-lon"
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

I like this check as a reasonable way to make kthread authors aware of
the TASK_COMM_LEN limitation.

-Kees

> ---
>  kernel/kthread.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index 6def951c605a..aa093f1f423a 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -404,7 +404,11 @@ struct task_struct *__kthread_create_on_node(int (*threadfn)(void *data),
>  		 * task is already visible to other tasks, so updating
>  		 * COMM must be protected.
>  		 */
> -		vsnprintf(name, sizeof(name), namefmt, args);
> +		if (vsnprintf(name, KTHREAD_COMM_LEN, namefmt, args) >=
> +		    KTHREAD_COMM_LEN)
> +			pr_warn("%s:%d: comm of pid %d is truncated from \"%s\" to \"%s\"\n",
> +				__func__, __LINE__, task->pid, namefmt, name);
> +
>  		set_task_comm(task, name);
>  		/*
>  		 * root may have changed our (kthreadd's) priority or CPU mask.
> -- 
> 2.17.1
> 

-- 
Kees Cook
