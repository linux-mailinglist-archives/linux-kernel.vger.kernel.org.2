Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB9A3B2536
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 04:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbhFXC4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 22:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhFXC4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 22:56:38 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCF5C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 19:54:19 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id y14so3467116pgs.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 19:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EZtiIZXLAbCl5jLHqK1+lf6V6SP0mpZsmLqgJ+RTBrs=;
        b=KoqtnfhMV/W89LhqRLh+1OYFx2USIS1tsVLx3UrSx4S2C7B0Z4mLY8a+2OXNMx5q+0
         K6V3ArCZj2DR+pxF/qc+VOp+NAyw/e6CHy+3iPOA1T1QJ9LHi17n/GNeNXmMkbi84CbB
         UGdafLOOKt+P/JHZ/Pj+ZgVbU2KeiBHjBIJdscNugzv0do1i6lzsLmW19hk7eaJfR/ET
         hrH1Lx6GC4RFbsPHWa6BQWyBpSdkGPUqpZrh4CvwuK4SGDxZoAJApRko0f8PVZK+k7qC
         Eh2yyjxIA/OY69soXQVe9K8Wx0sQi8k1L4SyE/iPoR7JunGU44NThR9AE3YEokZKGiQW
         YDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EZtiIZXLAbCl5jLHqK1+lf6V6SP0mpZsmLqgJ+RTBrs=;
        b=Eads2FBb14/pYaUeLftzqmqyxeVoDaDm+S4duW04bFuCpJN/GcATwoTyC3+AVf1OVc
         RDaIjrWm31HvH/2lHsfBGJRSD36LnLqemM+DpcrgwlS4Xp40wc8lStjdomyW+5qSrXDG
         9Awf7298NsCN2FJwuRQywjYlU2a71y9ihfv21zTdhsW6UXC9QilLq/5azQhLgwTZ6wLI
         0qmdc9OqV9aXHowTgo26bofJCjMU2DHLOE5lEIsYPz7aBX7SAiWedCd2M7Lm7sVGDhGY
         czYwd0Wu9gfHq1QZDI5FmZxRKzMkQjA5ixDBrdKh2yshA3BVVQFYQI4o+Egz3+sokDoU
         MwyA==
X-Gm-Message-State: AOAM533Lt4I3KPX6jefQEgZGfGR7wqcXWJQXx3K+b21RxFL7GzlxGFvD
        qU7bZOqTExZtLqqUBShQKlRKJA==
X-Google-Smtp-Source: ABdhPJzpz4Wdmkby5CYYPfvOjumLHTc525MdbSaDIp32RKEwPpxu3eR2dbF6bbqAhfzcT/S5BC265Q==
X-Received: by 2002:a65:6a12:: with SMTP id m18mr2561679pgu.229.1624503258102;
        Wed, 23 Jun 2021 19:54:18 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id y7sm6524339pja.8.2021.06.23.19.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 19:54:17 -0700 (PDT)
Date:   Thu, 24 Jun 2021 08:24:14 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Will Deacon <will@kernel.org>, linux-pm@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH V3 0/4] cpufreq: cppc: Add support for frequency
 invariance
Message-ID: <20210624025414.4iszkovggk6lg6hj@vireshk-i7>
References: <cover.1624266901.git.viresh.kumar@linaro.org>
 <09a39f5c-b47b-a931-bf23-dc43229fb2dd@quicinc.com>
 <20210623041613.v2lo3nidpgw37abl@vireshk-i7>
 <2c540a58-4fef-5a3d-85b4-8862721b6c4f@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c540a58-4fef-5a3d-85b4-8862721b6c4f@quicinc.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-06-21, 08:57, Qian Cai wrote:
> Viresh, I am afraid I don't feel comfortable yet. I have a few new tests in
> development, and will provide an update once ready.

Oh sure, np.

> Also, I noticed the delivered perf is even smaller than lowest_perf (100).

> # cat /sys/devices/system/cpu/cpu8/acpi_cppc/feedback_ctrs
>  ref:103377547901 del:54540736873
> # cat /sys/devices/system/cpu/cpu8/acpi_cppc/feedback_ctrs
>  ref:103379170101 del:54541599117
> 
> 100 * (54541599117 - 54540736873) / (103379170101 - 103377547901) = 53
> 
> My understanding is that the delivered perf should fail into the range between
> lowest_perf and highest_perf. Is that assumption correct? This happens on
> 5.4-based kernel, so I am in process running your series on that system to see
> if there is any differences. In any case, if it is a bug it is pre-existing,
> but I'd like to understand a bit better in that front first.

Vincent:

Can that happen because of CPU idle ?

-- 
viresh
