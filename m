Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84DA23FCFB8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 01:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240043AbhHaXA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 19:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhHaXAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 19:00:25 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B738BC061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 15:59:29 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id y23so774859pgi.7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 15:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HY8zH7yQ9cgwovIx437Yv1hZRTnYGVBVhXtxvcQqz/k=;
        b=EpBnh6hfCpQMKtJdrRIrsOfxm1jDct99+/SjhAEQRtWj2rlrZSfWSptzM/4BZKX4EY
         a0S99dnypF/xz+l87um5yPdmrsdfogZjLL8pvmukkhD6SZsuP8PX4EDQM1AcQJESOxRL
         QHaGE707O7gf6dLOi8zX2hcnYJbfLGfQoEPoha8UVwdzgonGrEfKesgYi8TT7JeMiCvV
         UG36oQEavUheTpZJC5WRRZfKbKQea3lR7xlj2tLGbyEqQgFJJcwxdxzizrazgSb3zdVz
         Fp/33z9RZy0UU0eC3b3j0a9Q3zc4wr23k5v/XuUI4IXGOHCiiGn2EoAJNSmk7xFOkGsi
         l3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=HY8zH7yQ9cgwovIx437Yv1hZRTnYGVBVhXtxvcQqz/k=;
        b=BIN4plrpkaViI5Qqo0Xwrxjm++TIIy89G8p7ol8NQSy83YGw+dLIq1gmUt+ybXdgsG
         Sm3Accr1xDpV7xpTEnEHP/xMD0fbpYA3z1oxJyiysPGcBUDZ8qpAel6OlsjKKAetZPsE
         LItSxZVAW7DsQExqkfaqqxh4VIqs4aTiGeILHwuFpiGG0TOrrN6HYK3/gOzAnKhX+M9W
         f/jKZQcNKd0iycIUZehjd9cr2kX/Xzy8FtEuAzG0Tx+U4ZLGpqfTSK6UdGWXlewmf1US
         DAo/24Af4DpOiY5TdMOM79qRa+qRYhhY2+x2c3i/4vKddNV0mUtq8m8/AvalbMl8qyUW
         hGLw==
X-Gm-Message-State: AOAM530LYvdGClzWfR0oXtgaqEEOn4rLQDrixBVXt801eGeEdx2A5p40
        koSbTl2WeJ5svOyPox08P30=
X-Google-Smtp-Source: ABdhPJwRxrAWJ8HLFM96R/rfXTSdNFZ/UudNxace9NL1SiQ0Oud5JIcfZ1jhz4akYPdCqgU7l4oyTw==
X-Received: by 2002:a62:2c51:0:b029:329:932b:9484 with SMTP id s78-20020a622c510000b0290329932b9484mr30309030pfs.13.1630450769078;
        Tue, 31 Aug 2021 15:59:29 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id s15sm14268290pfu.67.2021.08.31.15.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 15:59:28 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 31 Aug 2021 12:59:27 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Zhang Qiao <zhangqiao22@huawei.com>
Cc:     peterz@infradead.org, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        vincent.guittot@linaro.org
Subject: Re: [PATCH] kernel/sched: Fix sched_fork() access an invalid
 sched_task_group
Message-ID: <YS60T2bfLpxb6SUY@slm.duckdns.org>
References: <20210826112635.7404-1-zhangqiao22@huawei.com>
 <YSztujInfNNXkG5/@hirez.programming.kicks-ass.net>
 <YS0WF0sxr0ysb6Za@mtj.duckdns.org>
 <1f0cd867-9c6d-4e22-cadd-06af9f852f7a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f0cd867-9c6d-4e22-cadd-06af9f852f7a@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Aug 31, 2021 at 03:58:42PM +0800, Zhang Qiao wrote:
> > I think this would allow cgroup migrations to take place before
> > sched_post_fork() is run, which likely will break stuff. The right
> > thing to do likely is taking sched_task_group (and whatever other
> > fields) after cgroup_can_fork(), which fixates the cgroup memberships,
>
> But it still seems possible that it accessed an invalid sched_task_group?
> because the child process does not update its sched_task_group util
> cgroup_post_fork().

Between cgroup_can_fork() and cgroup_post_fork(), the cgroup membership and
thus sched_task_group can't change, so if the child sets it to the parent's
inbetween, the sched_task_group can't go away.

Thanks.

-- 
tejun
