Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B99935CA69
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 17:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243117AbhDLPur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 11:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243042AbhDLPuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 11:50:39 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE38AC06138C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 08:50:21 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id a21so796486oib.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 08:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NZYZrqYCNCv2bxpNxPSl3nXWCQe4Fvp0PwQSK0b1hpU=;
        b=Vx5mpzCj+enoGx9KqcYEWgEiZhKJWzoqSUtR72eSgqZtcWN2ie+bYKb8MbLhjQRfM6
         qi1Dy0regakn0YcVsX5B9cGxYuAq3tDrFjwVp1DPcWASoXPSniF0Mv7BKr/CPQmr0yU9
         FFKABGEFgXaEFRuqUrTX+iEl6xvNJuRBCqHv6j9B+VRqNmX19gVn76JmwDAQqS0bUUN4
         RKSNOqQC4XgBif+68UagaWV8p+YicdH8v3bKF8rjZFqWH2i74qsek+wy3ElqA2Uvc9NI
         Cue4rBg3IVwo1TGS8CSWF00s1Z0W7oMecfJnU+7uxdDzfikV3sb+iskWOOIk0xY2w1Xq
         H/XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NZYZrqYCNCv2bxpNxPSl3nXWCQe4Fvp0PwQSK0b1hpU=;
        b=Gdu/wyu0IhTRUOxYYlrs7dsOYMELP8I4on6U5TdpYQGzdcNbC9ae9G/wu6piz5LljX
         c+5L7m3XRbAhPJRCFHXQROaN79FwrAEfMNijMLKE+Dv0EkRE6awHocAPKbbLfQ7vZIyV
         Hg18Gxo83NkpEiNkDpqLMVoJEqAv0t1qo6GcsINFZYBHJpyVMFwZ/4lj96cOFNPW760J
         IcGZSmp4xh2+rCppIeK4BbXeCawH5P/3hYqPSA4kB1Mqvx/yxcJs6gdtamM+C0ZwzYnj
         eAqrcEaF6m8chEnP07a+2htFu7OOHqiurY3+yZfLL/6QWQcfytloGvpuPg59FdKK9ox9
         1rDg==
X-Gm-Message-State: AOAM533OOsnhlqS/8mJ+RMVzdleiwsnHosVYWX64NDRKrFPqgUkwdEUQ
        azbzc4lC65XYYIU96kQ6mvxzNg==
X-Google-Smtp-Source: ABdhPJzxSaAxYZ9t5xAi07FjyuqSb0/GV2NeW6bl4Gr0VuUqXKbbceEq2bqv5yehZXeYnstbJSoo9w==
X-Received: by 2002:aca:f30b:: with SMTP id r11mr10894310oih.133.1618242621027;
        Mon, 12 Apr 2021 08:50:21 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.233.147])
        by smtp.gmail.com with ESMTPSA id p3sm2803640otk.9.2021.04.12.08.50.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Apr 2021 08:50:19 -0700 (PDT)
Subject: Re: [PATCH V12 0/3] Charge loop device i/o to issuing cgroup
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Dan Schatzberg <schatzberg.dan@gmail.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>
References: <20210402191638.3249835-1-schatzberg.dan@gmail.com>
 <YHRrJ9V6ivpH2QUN@cmpxchg.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <072a9ad4-b63e-e540-9314-f3e3763111f5@kernel.dk>
Date:   Mon, 12 Apr 2021 09:50:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YHRrJ9V6ivpH2QUN@cmpxchg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/21 9:45 AM, Johannes Weiner wrote:
> It looks like all feedback has been addressed and there hasn't been
> any new activity on it in a while.
> 
> As per the suggestion last time [1], Andrew, Jens, could this go
> through the -mm tree to deal with the memcg conflicts?

Yep, I think that would make it the most painless for everyone.

Dan/Andrew, you can add my Acked-by to the series.

-- 
Jens Axboe

