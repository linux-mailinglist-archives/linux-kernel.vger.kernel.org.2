Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98F7F398A55
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 15:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbhFBNYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 09:24:54 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:39643 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhFBNYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 09:24:54 -0400
Received: by mail-wr1-f44.google.com with SMTP id l2so2302381wrw.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 06:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=X0vC9gjEiFrFKn0k/ysh+fIfdHP8TqqV8LRqsN9KMx0=;
        b=Gz055sbh5dNdYNGv5RTV/1V4YRMcdvT2ZgFOaF59DZFmdhzFBmnRFsQU4AguQSLTdc
         7kvcTmZM+PaJ/M3vAEiAb8y50b6+sYZqipmlicvmvKVvx+wFP818HywfJt4fhnZwiqch
         poPfzXXcjzFPjbYKKBmH3RF6ucNEuL0UCOTQPH3PLBvo7ArEysRa29+1kr0BcTn954DY
         Q1C/8kxFv36FwG7F3pjlVEdWFl7GtkoHnoDP1tECNYApA4pgSdrpervyi1bint3Wukr5
         o2WaqN6v5Ysrrx4+/V+mjjSHTrWOOAh5AI3f+8uHlFtwBg/tdxkaQAo8m0cmMmURawQh
         Luig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=X0vC9gjEiFrFKn0k/ysh+fIfdHP8TqqV8LRqsN9KMx0=;
        b=bdB4RlhcvgUpN1h2TM4upf0LFvDOC2NUhGETsAXDqC9f0qAC7jSRL7nOcSRpFKAVDI
         f+lVaW7y8dfdJuIe0XFkJ4oxi1jIXdLcO1b93KY4AMDYoYPuKSS2ZeFXi68SEZitlqET
         AlR1kOEeVZJZ4+lw4rEmcnwa1gVksyUu+CUQfs+tv3Ug+BN4kwRI87zlkvGrnuq0MSjI
         dd7eb3nbMxt7yaOeqNTrYC8WX03hgt4stIau4KCgVKK+YoqSuxiRA1efg+qEU9mQkUaE
         wEibg7j2hOVF0mjvbjcIrBkeb+MjC9ZSfxBaQS6chAP7+dplGW9bs/g/W6QQhwH8G+C6
         viZQ==
X-Gm-Message-State: AOAM533jb7GPpPYMVOgupFYRPZQyorvEVjcTCwWcA0PScJkhJfKYkBss
        1idhBSNFMdHCfgh1Vm1X4iBGTw==
X-Google-Smtp-Source: ABdhPJxKy1GZAQ26fFiaEtlgdOhXyKH+PMPZPd1AuSiu7gTiW+550K1/ERKILAnn7CGlsNwRncjtsw==
X-Received: by 2002:adf:e404:: with SMTP id g4mr7752730wrm.414.1622640130235;
        Wed, 02 Jun 2021 06:22:10 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id l8sm8931766wrf.0.2021.06.02.06.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 06:22:09 -0700 (PDT)
Date:   Wed, 2 Jun 2021 13:22:07 +0000
From:   Quentin Perret <qperret@google.com>
To:     Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        zhang.lyra@gmail.com, xuewyan@foxmail.com,
        patrick.bellasi@matbug.net, tj@kernel.org
Subject: Re: [PATCH] sched/uclamp: Avoid setting cpu.uclamp.min bigger than
 cpu.uclamp.max
Message-ID: <YLeF/556Wbvx1Ssc@google.com>
References: <20210602123803.15738-1-xuewen.yan94@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210602123803.15738-1-xuewen.yan94@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+CC Patrick and Tejun

On Wednesday 02 Jun 2021 at 20:38:03 (+0800), Xuewen Yan wrote:
> From: Xuewen Yan <xuewen.yan@unisoc.com>
> 
> When setting cpu.uclamp.min/max in cgroup, there is no validating
> like uclamp_validate() in __sched_setscheduler(). It may cause the
> cpu.uclamp.min is bigger than cpu.uclamp.max.

ISTR this was intentional. We also allow child groups to ask for
whatever clamps they want, but that is always limited by the parent, and
reflected in the 'effective' values, as per the cgroup delegation model.

> Although there is protection in cpu_util_update_eff():
> “eff[UCLAMP_MIN] = min(eff[UCLAMP_MIN], eff[UCLAMP_MAX])”, it's better
> not to let it happen.
> 
> Judging the uclamp value before setting uclamp_min/max, avoid
> the cpu.uclamp.min is bigger than cpu.uclamp.max.
> 
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
>  kernel/sched/core.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 5226cc26a095..520a2da40dc9 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8867,6 +8867,30 @@ static ssize_t cpu_uclamp_write(struct kernfs_open_file *of, char *buf,
>  	rcu_read_lock();
>  
>  	tg = css_tg(of_css(of));
> +
> +	switch (clamp_id) {
> +	case UCLAMP_MIN: {
> +		unsigned int uc_req_max = tg->uclamp_req[UCLAMP_MAX].value;
> +
> +		if (req.util > uc_req_max) {
> +			nbytes = -EINVAL;
> +			goto unlock;
> +		}
> +		break;
> +	}
> +	case UCLAMP_MAX: {
> +		unsigned int uc_req_min = tg->uclamp_req[UCLAMP_MIN].value;
> +
> +		if (req.util < uc_req_min) {
> +			nbytes = -EINVAL;
> +			goto unlock;
> +		}
> +		break;
> +	}
> +	default:
> +		nbytes = -EINVAL;
> +		goto unlock;
> +	}
>  	if (tg->uclamp_req[clamp_id].value != req.util)
>  		uclamp_se_set(&tg->uclamp_req[clamp_id], req.util, false);
>  
> @@ -8878,7 +8902,7 @@ static ssize_t cpu_uclamp_write(struct kernfs_open_file *of, char *buf,
>  
>  	/* Update effective clamps to track the most restrictive value */
>  	cpu_util_update_eff(of_css(of));
> -
> +unlock:
>  	rcu_read_unlock();
>  	mutex_unlock(&uclamp_mutex);
>  
> -- 
> 2.25.1
> 
