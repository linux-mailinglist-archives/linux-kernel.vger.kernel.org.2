Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAE13B4DDF
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 11:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhFZJ76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 05:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhFZJ75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 05:59:57 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FE8C061574
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jun 2021 02:57:34 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id w21so21812645qkb.9
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jun 2021 02:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cjbdKcJqbGe8eTFHsQaTP4RfgkdJNUUzz4KYzjGwNSs=;
        b=gwh+27RTWHvOcAZhnXRAdQPqj2vzOnGf78tVLcJEDHmB3Cq8x3Z1Ri72oGBHVRDaTf
         DTKp5N+xtfnTlsBz1BQx7gg40cPFjOkC9rCRG7whZBGg+6fK4pTyzF5sXjzsdu0eVQR9
         cb4PiTsR5QWI7n8NvCFLvHwjhLz18VPS1rVhAHn+H4SuP04Bl42N/1KOna5dP6QavgYM
         TYoi97Cx2Z1XRaC6ZsTsc2od3rTsxmOHSAAyb8A/Zc+7aGG2IrZtAAfVnqosdsUIyNwR
         jsadUYU/TXXZ/9olz02kTmvMMRo3TCbCZQbFTQlwFSYSuMpKQECgIMXGb5N0DhkoXHJb
         XiJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=cjbdKcJqbGe8eTFHsQaTP4RfgkdJNUUzz4KYzjGwNSs=;
        b=hI0Gh99VEOUFa2Te39DduGbSK9p0RfVJeu5hN9J09fI+fcLKjSSK3nxt7xY4e186Pi
         PFiPhPNkGOI6Wc6cLJp+gE+OHGrY61vfDdKga8HoeV0uYWl1IGufz6S15xgjJCeAc7eW
         uVKkzMtz7hUETTmmqR5+3hNVUUbwhrXYhHKd3495/jsSuTZTAVvV3pXedF7/txPvQfex
         wJ7GPGX7yaNr7SQt31c/7+T7oAV8DvuRL2/jdLDJyDoZepe0/g6iuOsKK4OiVpTkbvcF
         A3HFqynVB+phm5TVJknacCVoeDshr+wNZrYPnmhp3zBu6xobVBXn6yWqTdEmo5P2g3tQ
         /crQ==
X-Gm-Message-State: AOAM530OTwBnm3ZMIIDmFKRxwZZacpJhMt5yMsQNBZ+Er1ErFO5jBCke
        T8v0IsPmEI3746e98WSqNMA=
X-Google-Smtp-Source: ABdhPJxRKNw4gG5Nx0IQKhkhA9TsAUF6hw+Frao37+2PwZUUXn6U2BzhjCJZWWl5L03dp1SH157DCw==
X-Received: by 2002:a37:6c4:: with SMTP id 187mr10859499qkg.421.1624701453458;
        Sat, 26 Jun 2021 02:57:33 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:cde6])
        by smtp.gmail.com with ESMTPSA id t187sm6775535qkc.56.2021.06.26.02.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jun 2021 02:57:32 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sat, 26 Jun 2021 05:57:28 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Paul Turner <pjt@google.com>,
        David Rientjes <rientjes@google.com>,
        Oleg Rombakh <olegrom@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steve Sistare <steven.sistare@oracle.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH] sched: cgroup SCHED_IDLE support
Message-ID: <YNb6CL6Q9CJnbB2R@mtj.duckdns.org>
References: <20210608231132.32012-1-joshdon@google.com>
 <YMobzbLecaFYuLtq@slm.duckdns.org>
 <CABk29NtcRUwskBjrvLKkEKQ0hpNPSrdzrGAGZy+bHSfnznOUSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABk29NtcRUwskBjrvLKkEKQ0hpNPSrdzrGAGZy+bHSfnznOUSg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Jun 16, 2021 at 06:01:59PM -0700, Josh Don wrote:
> Consider a tree like
> 
>                   root
>              /             \
>             A              C
>         /      \             |
>       B       idle       t4
>      |           |     \
>      t1         t2   t3
> 
> Here, 'idle' is our cpu.idle cgroup. The following properties would
> not be possible if we moved t2/t3 into SCHED_IDLE without the cgroup
> interface:
> - t1 always preempts t2/t3 on wakeup, but t4 does not
> - t2 and t3 have different, non-minimum weights. Technically we could
> also achieve this by adding another layer of nested cgroups, but that
> starts to make the hierarchy much more complex.
> - I've also discussed with Peter a possible extension (vruntime
> adjustments) to the current SCHED_IDLE semantics. Similarly to the
> first bullet here, we'd need a cgroup idle toggle to achieve certain
> scheduling behaviors with this.

Would you care to share some concrete use cases?

Thank you.

-- 
tejun
