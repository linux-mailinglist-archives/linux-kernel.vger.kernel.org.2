Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 271BF33EBAC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 09:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhCQIkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 04:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhCQIjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 04:39:51 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3F1C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:39:50 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id x13so902081wrs.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xLwnO5Gydmgv5cwKEaZra+s3KSP8Jl4DqNWGhXdHZkc=;
        b=BxU6OHVFd4gz1UDTn7RWD9rsd8CQ7eULj7rp1xWxFNe+dYHdG4gQHy23jT6m3hk+0G
         pbtu9oXGTO7wQI9T+yFBcctBQeqQex7XhQqijJ97W7iq1sfDGbmKO3rIwNerHaLQA39q
         2+CRsGAaQtn1ElZm4KWxhfgMbRQ4h7Q1raCXUeunPn9oV2jqyp14bYU3cuCUqhkDxEmN
         tyQwZ37F89AftOi18D1mhwscq3IXMumBAd02WOKC4ThJ7woEABZ0N0/KrnPbk28/iDIB
         IrZV6WhPdW1cBSey2a5wlRv89KKbu4dROi/NtMLse3k5z5RHcWpMKT/cjK5Y7AUGPGI+
         I0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=xLwnO5Gydmgv5cwKEaZra+s3KSP8Jl4DqNWGhXdHZkc=;
        b=rrDDgGSeLDeQwFhqYfvDg/M46/dhv+offheTTyjHtHXu2iQhfEUknJmtarMPXiPDFO
         MdT2/brqc6r3MWvfal45iyXpZSvTmVBvVjYL4Bz1CuldMVTgfSapVL0CdSS5ktik+PSH
         KikxEfeKUfeTThmiQsSjlCyx++g37jtoc+No3dEFhcZ51l3hsLHnvjNmbbl9ZQt28dRB
         Bu77rO3I38XrtFx9Ghnl76onqYoAk8Eh1O/onaEJ64hAWfABapgLIDj8uu0xQKYyFSAS
         VwpeizalQ60IJfO7tXjMlCfgt6KupFTJWeMlcfE8AFi6R9Kl0zZjyz98+Ld6636YClz+
         jBbg==
X-Gm-Message-State: AOAM530OjY27zFfoZYd6CB7tbt8lhmgUMicucWJyFlIvrS2oAWT8L5oc
        e6ryeeSMrllMbbysfHlU+EI=
X-Google-Smtp-Source: ABdhPJznUGP7nUjVeEoJ1NGowgr3dDV1imDrFLthFlaYP4+ZgA2eDup8/C2Ssl2lgDjqVltSZPd4tQ==
X-Received: by 2002:a5d:404f:: with SMTP id w15mr3332018wrp.106.1615970389519;
        Wed, 17 Mar 2021 01:39:49 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id s9sm1796189wmh.31.2021.03.17.01.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 01:39:49 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 17 Mar 2021 09:39:47 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: replace if (cond) BUG() with BUG_ON()
Message-ID: <20210317083947.GD3881262@gmail.com>
References: <1615949121-70877-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615949121-70877-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Jiapeng Chong <jiapeng.chong@linux.alibaba.com> wrote:

> Fix the following coccicheck warnings:
> 
> ./kernel/sched/core.c:8039:2-5: WARNING: Use BUG_ON instead of if
> condition followed by BUG.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  kernel/sched/core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 9819121..7392bc0 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8035,8 +8035,7 @@ void __init sched_init_smp(void)
>  	mutex_unlock(&sched_domains_mutex);
>  
>  	/* Move init over to a non-isolated CPU */
> -	if (set_cpus_allowed_ptr(current, housekeeping_cpumask(HK_FLAG_DOMAIN)) < 0)
> -		BUG();
> +	BUG(set_cpus_allowed_ptr(current, housekeeping_cpumask(HK_FLAG_DOMAIN)) < 0);

The patch doesn't quite do what the title & changelog claims...

Thanks,

	Ingo
