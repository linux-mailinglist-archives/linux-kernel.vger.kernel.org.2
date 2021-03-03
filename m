Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0556F32BF24
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 00:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1577876AbhCCSBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350910AbhCCPA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 10:00:27 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13493C0613E4
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 06:59:15 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id n79so12596938qke.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 06:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pJZXq2Sc9eDC6LWgGqw2Nfh7xd04n05s4qGwqtA30FM=;
        b=cC4DY5nuQsmSPZzgYXABD/Lkm8Ms27XL4nYL+LBlPodLXzNm3msHYjaB/kwno5uibV
         +ZZ9vteAAOu45PCBSYrxTsRd39Bd/KMfZCOr+zcCV29Hp/H6sAWhbLw6NR0bKypraxhx
         pYGFn4Eu24lZqIJrmavcn4SWLkJvQ4edLrzYbpIDRG0fJLgh1Lg2hk/ooQYbcW2RDodk
         qZ79mu8kATs1maicjJ9b9j7yKlScLIeZHzxyb8V31D3eU8kttffbgeHnqoicT0zazQtB
         LHJ+Qeh5gjz99GTM1ZPF2X+yUu5KZFhCnaL0qrjqIrWXwDiwGNXIQEqlop/Ahyn/+afD
         aZ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pJZXq2Sc9eDC6LWgGqw2Nfh7xd04n05s4qGwqtA30FM=;
        b=FB2m8FdORwKsAzUryvOPDIuQ6IAciwKJrnNURffg0Jx1TA/tgxXD1+rn6jIOkC5Vcj
         B12LwkfJyMFmgzFj5sNZFOA1WirXCzTxurTKgB5PNgLXSPXd4xn+/pQs60gpjGQUSNt3
         6etCT013thllymgCXDV6S2xN3KT6UOInIeay1Mis4E0s1rUkTEX3kA/Qe5uLLoVDNTS/
         5EPOabO/TiPYseBEoxgl6uS4qbsRCZExbv1vQ7GYFHlJ8YCnt50q+MyaU8D0puknoMui
         DV7qzLw0wj/n5CV5PSgyoWLnJNBfcye+YBCxLquaPgP1ZsWXBJv/aUKhUYZF0DAbCsg1
         wcPA==
X-Gm-Message-State: AOAM530V9FE/THKBjKzA3rgoV6i8CcFdMRH8lQqF8k2foj1L/bFh4bji
        mEpDHevts4IyAl5cPXqNeolNmw==
X-Google-Smtp-Source: ABdhPJxmpLqlOivb8kIeXad+FTwROHhPsa9WCiJ/qawhuL1TjcH6IBYrgpVkbnKxWtOICLXeS00BvQ==
X-Received: by 2002:a37:9e4e:: with SMTP id h75mr10848018qke.180.1614783554353;
        Wed, 03 Mar 2021 06:59:14 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:5636])
        by smtp.gmail.com with ESMTPSA id q65sm6514888qkb.51.2021.03.03.06.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 06:59:13 -0800 (PST)
Date:   Wed, 3 Mar 2021 09:59:11 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     peterz@infradead.org
Cc:     Chengming Zhou <zhouchengming@bytedance.com>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com
Subject: Re: [PATCH v2 0/4] psi: Add PSI_CPU_FULL state and some code
 optimization
Message-ID: <YD+kP0z0yWm9UeDK@cmpxchg.org>
References: <20210303034659.91735-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303034659.91735-1-zhouchengming@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 11:46:55AM +0800, Chengming Zhou wrote:
> This patch series is RESEND of the previous patches on psi subsystem. A few
> weeks passed since the last review, so I put them together and resend for
> more convenient review and merge.
> 
> Patch 1 add PSI_CPU_FULL state means all non-idle tasks in a cgroup are delayed
> on the CPU resource which used by others outside of the cgroup or throttled
> by the cgroup cpu.max configuration.
> 
> Patch 2 use ONCPU state and the current in_memstall flag to detect reclaim,
> remove the hook in timer tick to make code more concise and maintainable.
> And patch 3 adds unlikely() annotations to move the pressure state branches
> out of line to eliminate undesirable jumps during wakeup and sleeps.
> 
> Patch 4 optimize the voluntary sleep switch by remove one call of
> psi_group_change() for every common cgroup ancestor of the two tasks.
> 
> Chengming Zhou (3):
>   psi: Add PSI_CPU_FULL state
>   psi: Use ONCPU state tracking machinery to detect reclaim
>   psi: Optimize task switch inside shared cgroups
> 
> Johannes Weiner (1):
>   psi: pressure states are unlikely

Peter, would you mind routing these through the sched tree for 5.13?
