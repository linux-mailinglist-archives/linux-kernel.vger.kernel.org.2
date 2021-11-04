Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7438644577E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 17:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbhKDQwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 12:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbhKDQwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 12:52:32 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA52C061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 09:49:53 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id bi29so6276012qkb.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 09:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NG0a2LPj0Rm5uH+ZlOJwC4OFBmvwtJpCqqTROU65rfc=;
        b=D9JKZO0I3cO995W6OlUO+gHfe1iY7izKBGhfEheO5AWlm0l6HRfskfnlBnzxGLmVA/
         ptntfDA5ECjwuJQFIoU/2R8GKKn0sCUu+/AxdrBUyHis1MMsQVqIEYKVe1W5e0mn5F6M
         RUWaaywPTIOqtAf1DngH7RQx3S/lyje9W2XTCGEx3p5+iiiz4MRKTP1gw25Kxqg90dbY
         +hKu3JP9+atgqLXM6graGAJtyPoUaRXvDfRQqQGB++Qtqj3yYmlTM7s0tx/wXhrhbSBe
         hKY0ECowJkn7CCGzb0TZvAffGdix/LzBt8CGp6OqXGtyAe9/bCxFIwuFbyipIoU5bBxB
         2EIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NG0a2LPj0Rm5uH+ZlOJwC4OFBmvwtJpCqqTROU65rfc=;
        b=a05/6YH2PaWfa+S3yO16wgBRhXaWuVU2tTQJ8be34Bw4hROCMljVi/PBfkFKbfH9uG
         b5BvSTP7vZWJRqSLyoa/7c3Oc8Jr/I5dCB/1zQ/7Uta6gkbYfYaINmQEPA+tCIqDRmDm
         AKYvH9O0zuQIvKHXZ1ZOoUS/9tvXHEAC5KfL/+QLbDlJYX23d+9snPuS302/4jm1Hons
         /bIQv7USa7eQMwe3KqHUoslWk6KdB4em5rZddVN1hlGF7dbmimBjGPeTVc4Z+tvp2ZtT
         9wD4Y92g2ogypPLTqmNCosCCXmAxmgAvAbUuOpz1sPt2CgHK4iamA1zQgbDWENnceDWo
         Osvw==
X-Gm-Message-State: AOAM530UirF+j1EIpLQVaaKa/IcNsPX3gVkdgX33AAhzbDJdo9ekhsfM
        qPFj3V/QWhyd5VIYHLPGJUKEEg==
X-Google-Smtp-Source: ABdhPJx55CW/LTLbBRGfWWbPp+4/J6HIbG1TvEoGT80BYU3uxAvJSzMxJfAdiu2+q8BnKyYeAk4FhQ==
X-Received: by 2002:a05:620a:1035:: with SMTP id a21mr41979645qkk.354.1636044592873;
        Thu, 04 Nov 2021 09:49:52 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id k23sm438624qtm.49.2021.11.04.09.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 09:49:51 -0700 (PDT)
Date:   Thu, 4 Nov 2021 12:49:51 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Liu Xinpeng <liuxp11@chinatelecom.cn>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, zhouchengming@bytedance.com,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/2] psi: Remove repeated verbose comment
Message-ID: <YYQPL4exZUP2eruI@cmpxchg.org>
References: <1635133586-84611-1-git-send-email-liuxp11@chinatelecom.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1635133586-84611-1-git-send-email-liuxp11@chinatelecom.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 11:46:25AM +0800, Liu Xinpeng wrote:
> Comment in function psi_task_switch,there are two same lines.
> ...
> * runtime state, the cgroup that contains both tasks
> * runtime state, the cgroup that contains both tasks
> ...
> 
> Signed-off-by: Liu Xinpeng <liuxp11@chinatelecom.cn>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Peter, could you please take this through -tip?

> ---
>  kernel/sched/psi.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 1652f2b..526af84 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -833,7 +833,6 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
>  		/*
>  		 * When switching between tasks that have an identical
>  		 * runtime state, the cgroup that contains both tasks
> -		 * runtime state, the cgroup that contains both tasks
>  		 * we reach the first common ancestor. Iterate @next's
>  		 * ancestors only until we encounter @prev's ONCPU.
>  		 */
