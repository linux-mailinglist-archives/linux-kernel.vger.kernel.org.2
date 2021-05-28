Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE2F393CA3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 07:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234205AbhE1FGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 01:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbhE1FGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 01:06:05 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43C4C061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 22:04:29 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id c12so2352703pfl.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 22:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dWz97qp3aYEwx4aYBmweXk5pR/ChRPV5OQnEm0rdSUA=;
        b=QLrYPU5MBaGNnj1jTyN1oLzp6BuHXD4IX410/85FEXTALx8rsq/XXnVZi6HDpMx3BV
         c9tQDHkk3ZNkLOiVO0WTSpXJ8vpGSZz4iqGdkd225PEbMbfJ+h8O2THVNR5oJ6XNtZU6
         V9/doGHERqZavYq6T+5p7KShW7nYjgmRifbvcSzHI6Mu3YhGwkNd0C1FsAzpSJ8VNQrg
         3iZwoJ26TBMRWbb3sR1xk5I6OKQRzO+HvKr+Zc9XgGBQUX7pbhS6ac+3y5XgMef8I7jE
         PRLPOIYAFuLGa6hEVwmN5fB0Ba80otZyligY2KLjlo654t3AT6iEq17Ijta9rE6MD3s8
         LXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dWz97qp3aYEwx4aYBmweXk5pR/ChRPV5OQnEm0rdSUA=;
        b=rKhiOt8gMNOEXANRWJ1vhEYFA+gEV7nbtyFxx7/2cWEmoPyf+XMGBI9lQkVrQdSznF
         q4Sxzx3NY2tfh8pfhbhQAP1MSlua5rEXqgMfFnY8bnR+nADQy58epu9Rjk3d0OX9WRdp
         prVOFA53Ys/2bCDp5Ik3BXTQiRk9oCy4YUFmeU/PjdRl/VfvRW3V3lcBCDJ6YcRmyb8N
         /sqskowdlOGiV9zoaHprwzhlRC1chwITH24/GoONLMcB08UF9ddH78VbaEbD6pRkIK+R
         eTdQuknnt5UmVbLzZil8GCIt1Y7eS/RQqxGw2Ep6VFzH18OuvAA1K/QDidR1K6Dr1gZd
         wrFw==
X-Gm-Message-State: AOAM530YDeE/aOYZL4fYXfyJ4etNVQT1ArPZNHZP3WLE6VffBOuy2dRL
        aC9dRSgXtxIDqrW3fzLGxMRpgA==
X-Google-Smtp-Source: ABdhPJyEDl3+ML2Aego1FUudK1gI6ReVcNPu+y/7JcHV/tJjdz99xp3oy5vBj43OUkX+ylS5wHuQsg==
X-Received: by 2002:a65:5181:: with SMTP id h1mr7148484pgq.330.1622178269419;
        Thu, 27 May 2021 22:04:29 -0700 (PDT)
Received: from localhost ([136.185.154.93])
        by smtp.gmail.com with ESMTPSA id 35sm3098119pgq.91.2021.05.27.22.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 22:04:28 -0700 (PDT)
Date:   Fri, 28 May 2021 10:34:26 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net,
        vincent.guittot@linaro.org, qperret@google.com,
        linux-kernel@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com
Subject: Re: [PATCH v2 3/3] PM / EM: Skip inefficient OPPs
Message-ID: <20210528050426.txs4kx2s37jwzpfe@vireshk-i7>
References: <1621616064-340235-1-git-send-email-vincent.donnefort@arm.com>
 <1621616064-340235-4-git-send-email-vincent.donnefort@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621616064-340235-4-git-send-email-vincent.donnefort@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-05-21, 17:54, Vincent Donnefort wrote:
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> +static inline
> +struct em_perf_state *em_pd_get_efficient_state(struct em_perf_domain *pd,
> +						unsigned long freq)
> +{
> +	struct em_perf_state *ps;
> +	int i;
> +
> +	for (i = 0; i < pd->nr_perf_states; i++) {
> +		ps = &pd->table[i];
> +		if (ps->flags & EM_PERF_STATE_INEFFICIENT)
> +			continue;
> +		if (ps->frequency >= freq)
> +			break;

I believe it may be more optimal if we change the sequence of these two 'if'
blocks here. We only need to check for inefficient frequencies if it is >= freq.

> +	}
> +
> +	return ps;
> +}


> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> @@ -153,6 +154,9 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
>  
>  	freq = map_util_freq(util, freq, max);
>  
> +	/* Avoid inefficient performance states */
> +	freq = em_pd_get_efficient_freq(em_cpu_get(policy->cpu), freq);
> +
>  	if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
>  		return sg_policy->next_freq;

Assume this freq-table (E=efficient, IE=inefficient): 800M (E), 1G (E), 1.2G (IE), 1.4G (IE), 1.6G (E).
Thermal limits max to 1.4G

Freq returned by map_util_freq() is 1.01G.

Will we not end up selecting 1.4G here ? Inefficient as well as much higher than
what we requested for ?

-- 
viresh
