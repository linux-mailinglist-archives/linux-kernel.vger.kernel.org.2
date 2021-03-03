Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D114A32C3D2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbhCCX7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 18:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245202AbhCCTja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 14:39:30 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8A0C061764
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 11:38:21 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id dj14so4758554qvb.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 11:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UbsOlX/Efpv9e6ooaVM4TezWsBLKz5r+VY0CNJCWQLM=;
        b=USNV/sH53Tg+d5lOmsUobNiMV9JAIJ9FucqtdhE5XExLin+NYzIwT4JgSVU2j7MqO4
         W2dDSH+ZYm7QEUyMNApd44WJGoO/sG88IOiOnZ5pmfDA3wU8W4tLhmqwoVZDOY52sGUg
         W9KB+5/4FXtEGkFAuceyMBuN7pYX3PqSr/kFGZeTyikfyp2TkXi8jo/P92+1d+QxLyKo
         kWyxOAXdFNF9TP3C0fAjobHnYcxEyHCsfUHp/FMKWDNUI2vlbsMbS4LIq8QcPnb/+v3O
         fpveTGTHlPVi/t2rMI5BGiduxzZM9b1peXRf5BZ+MyOYWVuEnnjLP+0fKXBjCi/IXtLA
         hM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UbsOlX/Efpv9e6ooaVM4TezWsBLKz5r+VY0CNJCWQLM=;
        b=PhQ1hOJAiLaElZurX4cF5b469HlJkd6lgpDO7g7qq98xWqRPI3mshTmhcpu3ow7sUm
         m47dkgL3UMbdvDv6gnDpCGN8fsQRCS4MEKTuf2ccMsBc+ZsGtR6WmKO2l1QO20J9SqDM
         TQ4an9t17NjbnoT0tuJFZUy+khm7tuIzEPU8mEadBtSZi2WBKRLGpOg8HOPcQgfVFdVW
         RGemgda+lrdZunn3Uud+GG/8nDwXIGUYw9BaCpkH9baHrixEhWERxHOM1isvaL4NBDZ0
         ujAEG82KhUoXMwD58Aw8GLIqhJ75fa1syYDkWn6S+fbqPLiGFYufFWHCNZwO49VrwqJz
         STSQ==
X-Gm-Message-State: AOAM530c91oXUNgujAsw38xc2Pt8rGTVkvY8Olq2H6pIztNCR5RSIlA4
        IPZD1wrdvZycrXS5YdQ0l9IfWw==
X-Google-Smtp-Source: ABdhPJwyl7Isz8fA/La2BGlC44wFHkFdXhLiGi8Ephcamm8SoSoIW01zhiahU5NYnwy2HdVlqD5L4A==
X-Received: by 2002:a05:6214:242f:: with SMTP id gy15mr777521qvb.17.1614800300570;
        Wed, 03 Mar 2021 11:38:20 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:5636])
        by smtp.gmail.com with ESMTPSA id d16sm17291890qka.43.2021.03.03.11.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 11:38:19 -0800 (PST)
Date:   Wed, 3 Mar 2021 14:38:18 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com
Subject: Re: [PATCH v2 0/4] psi: Add PSI_CPU_FULL state and some code
 optimization
Message-ID: <YD/lqiRnUEHrw1TR@cmpxchg.org>
References: <20210303034659.91735-1-zhouchengming@bytedance.com>
 <YD+kP0z0yWm9UeDK@cmpxchg.org>
 <YD+sAnZ+Ep0il5lp@hirez.programming.kicks-ass.net>
 <YD+zu0UVKEG1ZK/H@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YD+zu0UVKEG1ZK/H@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 05:05:15PM +0100, Peter Zijlstra wrote:
> On Wed, Mar 03, 2021 at 04:32:18PM +0100, Peter Zijlstra wrote:
> 
> > Yes, I can do that. Thanks!
> 
> Please double check the patches as found here:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=sched/core
> 
> I've manually edited the tags.

Looks good to me, thanks!
