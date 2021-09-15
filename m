Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B63740CBED
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 19:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbhIORud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 13:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhIORub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 13:50:31 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB004C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 10:49:11 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id h3so3469378pgb.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 10:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ODEgeFoafx2JBEh/07S48Zvy6ZDiaDzyf1KHObLnrxo=;
        b=o3w89WSqqzWCKHpF2cQU47klxfMX1CSU1IAq6XTVREqiRc0c8QIkKWU2nlWV/ub7aY
         sHdwH8s6YMqQcFtVZ4SX9EL2mgCeONNdrLIweYEA8DwbJkXMr2su8TJMvKQVAeZCdmd3
         DKd4u5cdxbOBKKmc6WdcFRfgV9l9CzRky0H7wUB4YKYWDOb63WCyaS+gPYYFOdH6Tncl
         uz52gPnnMuluykLszOoJq/EBLaR6ZuwDJ+Ar4eWf5gWqM9C6ZBoCum20rhRdR3XbqEY4
         cBCtk/dXnty64eWrEKUnIwCv1XBAD8qf9g/eCpfPDuf7iSSRiyyuRQlxHG12z9Ta9T2V
         55aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ODEgeFoafx2JBEh/07S48Zvy6ZDiaDzyf1KHObLnrxo=;
        b=LxsjFopkSH4Y7BqRImY8QEk1PNhcMKNSuyaVNxEYaiN0Mh/6bjgVdxvSmCWV9d1No+
         PtOATJuJ1RgrdOplG20B5+Kne5U5rJMutuUmFmEiEuImjBxgT9mQBm+BP1b6L91ePgC+
         Inwspm5pzvqtVp0QdeflYvQ6xZH/hTAQgqGMy8/7QYs3udMgRhgdnfGccspHs8UQiLmT
         e5AOJXsi+9nXH/P19Db2jAEQ3lGIj4UlXDYBSxqksrDC3Fw2ajIZSR6zcFMIX1cwfZnB
         bw/rl91UaRPuf/aUQ1czkWxthQ7S0BZBZUfRv8xfKIQiKjXXl3egWwafB1ttr2K6sB5b
         IIIQ==
X-Gm-Message-State: AOAM533SKJdjYk16NpQoF46vnTa3VuzWDX0Z9773hNs+HMKVdatGPN8s
        IlyVAohR4iJey3tlWQcKk35NbRM2Gdc=
X-Google-Smtp-Source: ABdhPJymjSKYEoqE9b/k+42T8u4lX/duvLE6oFSZMPvnC4nm/MsZhVWS7kfxr347qnKzzapbIaHEIQ==
X-Received: by 2002:a63:f145:: with SMTP id o5mr885295pgk.273.1631728151151;
        Wed, 15 Sep 2021 10:49:11 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id c11sm556261pfm.55.2021.09.15.10.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 10:49:10 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 15 Sep 2021 07:49:09 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Zhang Qiao <zhangqiao22@huawei.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] kernel/sched: Fix sched_fork() access an invalid
 sched_task_group
Message-ID: <YUIyFdrS3VVfgZhB@slm.duckdns.org>
References: <20210915064030.2231-1-zhangqiao22@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915064030.2231-1-zhangqiao22@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 02:40:30PM +0800, Zhang Qiao wrote:
...
> Between cgroup_can_fork() and cgroup_post_fork(), the cgroup
> membership and thus sched_task_group can't change. So update
> child's sched_task_group at sched_post_fork() and move task_fork()
> and __set_task_cpu() (where accees the sched_task_group) from
> sched_fork() to sched_post_fork().
> 
> Fixes: 8323f26ce342 ("sched: Fix race in task_group")
> Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>

From cgroup side,

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
