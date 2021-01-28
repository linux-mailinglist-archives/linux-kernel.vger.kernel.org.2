Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D5B307821
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 15:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbhA1Ocz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 09:32:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbhA1Ocp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 09:32:45 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAB0C061574
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 06:32:05 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id c132so4413611pga.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 06:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R9tH9YjKdu4SV5abNwwJi97SLfnNUb/O813edamRM6Q=;
        b=JDmPw59tJk29B48kwIPKMz8KmvxLlJaaL1BgF4PLqrTIPWOsd2twVS3BZHj3LqHf/U
         tVkocwsz1ijDsPRE8Lh0rHKqIaPBxD68EvPZuRDRxeyFh0/RydPe00W8XBvxCIezyQDE
         U7o4h7sq3V+jfnHYdfXa1zced+kebVZ5WwWH0AuZbpl8NrmTChkCa4zu6Pfij7OwB+Pe
         xnLp++aHRlDNuc2B9fwl5dGTmL4I8ekGdMANiQefjJt9CwRK07Xt++q6WH8YZHf1kuOQ
         CheoPG0P6G5bqkQugw+92XkrSKpZ+Q5qoio15YLoW05cd0ey4B9mSoo+ptj0jxQZyujf
         cigQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R9tH9YjKdu4SV5abNwwJi97SLfnNUb/O813edamRM6Q=;
        b=AVGk1aJcSXVbpzaA/naqqZu7RHATDl7bw+cehF95r9zVTX5g7BUyHwgwLxapgYv6Vs
         Ij02TqC2PSzracMQGx/Nqdq68aYM992HeH0OZ2CuaV78bzP7H3oUHNLRA929ZSBJFrsM
         e4KTnagA4C9/O2acZOYVP8qe4mZ78xX+8qa1/6vjiQsBklBKfm3Hfj/yJz7bDMznaRBE
         M5d93ktcTVPjYwBxcBh7I7lT6tpsy5m7bLnyQGcK7ed9p/2XWgsJBJWNaaoRMjVHNOrV
         Ov7vuTj+Mpw0S0zia0CwM5mSb+V0H+99LRbhowjDZFmU+fBlLeSSQFnKKzjpi8fAO7qp
         7uMg==
X-Gm-Message-State: AOAM530LHYTJjpTPpGTY+xZFW/rjXz0tBTW8/fbGGklBLSkidxbNK2f3
        RnZwTi/GWqFTHELNb6dDr99gvF0ObMDxMg==
X-Google-Smtp-Source: ABdhPJyn8mjoxYrivmEV09qI42ucQQdWuIe50sPqGBeCUhM8pOyzcP5QzWmZEXPMW98hrtXAZDR3Ig==
X-Received: by 2002:a63:4507:: with SMTP id s7mr16729858pga.390.1611844324746;
        Thu, 28 Jan 2021 06:32:04 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id 6sm5827613pfz.34.2021.01.28.06.32.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 06:32:04 -0800 (PST)
Subject: Re: [PATCH v3] blk-cgroup: Use cond_resched() when destroy blkgs
To:     Baolin Wang <baolin.wang@linux.alibaba.com>, tj@kernel.org
Cc:     joseph.qi@linux.alibaba.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <0be1a0a03367f7230497a2e7a5ed47d2a2d5ae1a.1611809091.git.baolin.wang@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9087d02b-ef9b-46c4-6933-82bb3e520597@kernel.dk>
Date:   Thu, 28 Jan 2021 07:32:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0be1a0a03367f7230497a2e7a5ed47d2a2d5ae1a.1611809091.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/21 10:58 PM, Baolin Wang wrote:
> On !PREEMPT kernel, we can get below softlockup when doing stress
> testing with creating and destroying block cgroup repeatly. The
> reason is it may take a long time to acquire the queue's lock in
> the loop of blkcg_destroy_blkgs(), or the system can accumulate a
> huge number of blkgs in pathological cases. We can add a need_resched()
> check on each loop and release locks and do cond_resched() if true
> to avoid this issue, since the blkcg_destroy_blkgs() is not called
> from atomic contexts.
> 
> [ 4757.010308] watchdog: BUG: soft lockup - CPU#11 stuck for 94s!
> [ 4757.010698] Call trace:
> [ 4757.010700]  blkcg_destroy_blkgs+0x68/0x150
> [ 4757.010701]  cgwb_release_workfn+0x104/0x158
> [ 4757.010702]  process_one_work+0x1bc/0x3f0
> [ 4757.010704]  worker_thread+0x164/0x468
> [ 4757.010705]  kthread+0x108/0x138

Thanks, applied.

-- 
Jens Axboe

