Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F95F32BF11
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 00:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344134AbhCCR5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244872AbhCCO6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 09:58:54 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2112C0613DF
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 06:56:09 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id l132so22987615qke.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 06:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GCVBkcjwS8xou5ENP18noackPsgmiBquGIS8Hog/eSE=;
        b=N4dwTvQNhnfriJ7lW9hmG4Rm/dLiHXEzX+rqpBFthvKyI+VC8ZKHDwqFn4WRbiNGqD
         Kw7iIZ80oCweQDO3hXduuhkyvYWN+QXpmGADkW/LkoL0CJuMrUhqhhrFRvzN2QIXWvFw
         usuhBzTzBwd/RyX8aFQE/O8Pe7l0zMopwC6pM6ScLyMcvYJ+HuBEosQkAOfrN0JHBlOG
         spWM9c32TJyijMalRunXzLLpVpP0iyYR8VPRcV6Dksr88KABc6C17nsH1SRrOt1a3D8V
         WQNtWLflCvayslz3+6j3sn6GbcggWMVOJQDv5bE1qhvTJ4QiF9EITuH9L6qO2G0fBs13
         tYbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GCVBkcjwS8xou5ENP18noackPsgmiBquGIS8Hog/eSE=;
        b=rTN03Np41yoNRkAkU8DZL4jarJVjJx9Xg2EZ9EHxutkCKwin2OL8L14rYguqY0oY1N
         D+Xio9oQh0QHNjjsGyE+9LEeXD6+Bs4FTnxverm0uqgXHjkrHlFZQ8AlTiLKU/p7HjJX
         GQ7InikZXFId+CUPF0QH+NkRYlOpL9+WgHxSLV5MR8cdNTw6Yrvt8gNVK0VkvdHpz1Ea
         LWPVLnZzHpgO6r77+9tp8ZnZs0bsih/IZFVm/x3t7giGhEGD140xxfYyf7YHXHmZDPJG
         8SQNfelzA6ONs7dz5skIZ3fwK/SQsc8hzjKfIFpkd91AgqX7Rdv2EpHAyzdaCklzWKQp
         Digg==
X-Gm-Message-State: AOAM531reI2CdEZiEDKK8U3dx8EQuq8yt/tB9UkLIRBiViFPe8mW2Ukl
        dWr1lZRFAyNsyWALKGC3La2yIQ==
X-Google-Smtp-Source: ABdhPJzKnzX3lr4bdF9Mc6pH8NZHRpNgiBOXEe9paujIygbdP6n3ubdfgTb3+ExjgfqYkRSbGS5MFw==
X-Received: by 2002:a37:6887:: with SMTP id d129mr24786816qkc.252.1614783369023;
        Wed, 03 Mar 2021 06:56:09 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:5636])
        by smtp.gmail.com with ESMTPSA id j32sm6886304qtd.16.2021.03.03.06.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 06:56:08 -0800 (PST)
Date:   Wed, 3 Mar 2021 09:56:06 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com
Subject: Re: [PATCH v2 2/4] psi: Use ONCPU state tracking machinery to detect
 reclaim
Message-ID: <YD+jhiaf01S/eR+6@cmpxchg.org>
References: <20210303034659.91735-1-zhouchengming@bytedance.com>
 <20210303034659.91735-3-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303034659.91735-3-zhouchengming@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 11:46:57AM +0800, Chengming Zhou wrote:
> Move the reclaim detection from the timer tick to the task state
> tracking machinery using the recently added ONCPU state. And we
> also add task psi_flags changes checking in the psi_task_switch()
> optimization to update the parents properly.
> 
> In terms of performance and cost, this ONCPU task state tracking
> is not cheaper than previous timer tick in aggregate. But the code is
> simpler and shorter this way, so it's a maintainability win. And
> Johannes did some testing with perf bench, the performace and cost
> changes would be acceptable for real workloads.
> 
> Thanks to Johannes Weiner for pointing out the psi_task_switch()
> optimization things and the clearer changelog.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
