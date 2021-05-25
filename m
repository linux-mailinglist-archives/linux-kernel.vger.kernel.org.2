Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A460F39017E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 15:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbhEYNCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 09:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232922AbhEYNCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 09:02:03 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008BDC061756
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 06:00:33 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id o27so30225043qkj.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 06:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y28saWW4RbQx7WFyioP30Xg1gnMSgGnjvex8TrgoAmQ=;
        b=SmfdiXxkr36Ea/32dUzc9goah/P/GDAmfDbfC23QxapWU+TYijU+tfipqVELo7UnNb
         kCjW74Q30JDB5fgFGsHqgJCEmxBDKG9IApVbKABuX/KOwPBR0S9vlJjymq+MrMGk51h3
         6ydpK/iuWp9N2XdHcbwhGAfcdpizobjsabPIpm0tzrNvmu9Bxekatij9qaP2uru6JWkm
         9Q/bdYcBQsR1yN1XYUK+IHclcbpDWwfEhDxrstMqMj+GfnNWOoDjxxvTrZpSn3pYUBV+
         tBirFOf/cNxOyaXXED4cDuzfXDrAdEmlM6leYVvOPcAJrsNxmqDTUvm5putYq5K3bzNj
         AP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y28saWW4RbQx7WFyioP30Xg1gnMSgGnjvex8TrgoAmQ=;
        b=chzkRr9liQmQ1HwWIepcu5KAbsBhavTL93SpCpBm6mFPFJJZAfTYubLM6TNgRTOGwT
         ILJ8/RCxv2Np8IupCVPvS3LIADdotwEdZw2K08edyR+sEmY5Zx+2CjPHBz2OtmIgP953
         0nWUWYd5EK3zvvWm/IE9G5ww8me1AoD6ewTxQv2r3F2Ve5QJk6Z90cZoZEK6jtPoKmPH
         01nEr0wkhjScTa4+5m2zXmcfLFuUtx6/hhDUfEDwjkmwbQnsksfUT24JWq06gjTwUgvm
         AvkpF409lXxx/+apoDUl9JZgR0nA+A1n1ERtEbnJiz7lzz8l1Btd44FXnik2jZDS206f
         MCAg==
X-Gm-Message-State: AOAM533CmkBohkOMBA+NU1jGaWBtbY2P1EtqmyZvOJ4AbdHkbhJa1HG2
        QxLejHr7xlJG22p5NtPJmDf9Ew==
X-Google-Smtp-Source: ABdhPJweYIK4QVt1oGBJstiLAQCOmbfbqmVA42aSLZNXQ/Hhy/JZ23PoCnqA1TrO1jkKqaIdstwAUA==
X-Received: by 2002:a37:9a44:: with SMTP id c65mr23489338qke.152.1621947632397;
        Tue, 25 May 2021 06:00:32 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:4f4e])
        by smtp.gmail.com with ESMTPSA id o5sm4565264qkl.25.2021.05.25.06.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 06:00:31 -0700 (PDT)
Date:   Tue, 25 May 2021 09:00:30 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, mingo@redhat.com,
        peterz@infradead.org, shakeelb@google.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        minchan@kernel.org, corbet@lwn.net, bristot@redhat.com,
        paulmck@kernel.org, rdunlap@infradead.org,
        akpm@linux-foundation.org, tglx@linutronix.de, macro@orcam.me.uk,
        viresh.kumar@linaro.org, mike.kravetz@oracle.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 1/1] cgroup: make per-cgroup pressure stall tracking
 configurable
Message-ID: <YKz07nx3E8UEo1xa@cmpxchg.org>
References: <20210524195339.1233449-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210524195339.1233449-1-surenb@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 12:53:39PM -0700, Suren Baghdasaryan wrote:
> PSI accounts stalls for each cgroup separately and aggregates it at each
> level of the hierarchy. This causes additional overhead with psi_avgs_work
> being called for each cgroup in the hierarchy. psi_avgs_work has been
> highly optimized, however on systems with large number of cgroups the
> overhead becomes noticeable.
> Systems which use PSI only at the system level could avoid this overhead
> if PSI can be configured to skip per-cgroup stall accounting.
> Add "cgroup_disable=pressure" kernel command-line option to allow
> requesting system-wide only pressure stall accounting. When set, it
> keeps system-wide accounting under /proc/pressure/ but skips accounting
> for individual cgroups and does not expose PSI nodes in cgroup hierarchy.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
