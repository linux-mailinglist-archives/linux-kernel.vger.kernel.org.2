Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7EBB3B6DC9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 06:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbhF2E5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 00:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbhF2E5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 00:57:33 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613CDC061766
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 21:55:06 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id c8so16187149pfp.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 21:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BbTKDwb2uW5ZQoTC03i3iOYsal8RdknYASpCZq5sOhM=;
        b=sPQ3Lph7+6T2JL44j4yaSzC2v+sAIub12k0D2sriGr5teRiSJ2qObvw0+2llyb16kt
         wm/si3RZP4EefxrwVObDBojG52AautAUqtgcjB0bLfe4YWDRps9NK+6R87Ifw2afd4sj
         u3ipk5oKdv6Rp7KPX8jbav2wyBpJs94UOJOd0myyf44MlW6ynO6Svar8+IrA6O0GQfLq
         FkEgc/yR5n5bxTFjsX/NVoKQYonmxECOundZ70vDIWPXCo7F0Rc3TGqOLDdo/K0gULhm
         zKfCoz9nanDv2DlFte9h4DEooZtVP242yi0EqetVa35IPk8On4lCvJZLWl9JCB90CCQc
         IGFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BbTKDwb2uW5ZQoTC03i3iOYsal8RdknYASpCZq5sOhM=;
        b=dJYHOe4d1e8oO1Qc6xfxVE0V+krZGYv9Wc8s2x7CUImCgxHIDbP6eP1nWARAebY4lm
         EW9h7umBHi5zzZJApiCtYb1FmSK/SReGB1lHsN6gt+ktXXa66FyRLW0b9mKoAn6Q+/uk
         PaxHegAC6UT5MNrTCbJPdwmtoKle2293aG8+zIst2mGz+plTGbqRv/3GuyRN6WdS/gMS
         AqN1nxwCAUvY1VHQpv+xRfHUyUK4mFc3v5oWGpnGOkLNzvXnR4UGMCycc/6QVuDkmHb/
         KFbRWaagkhgewA3lsvAYqJVmreJUFCgkkQ7W/Vi0YpU+o/obawBWwwZFMunzSDpK9LHW
         cfmg==
X-Gm-Message-State: AOAM5307kXUpXLaQqh99x3S3w4pYprRpWsN7H0wHYMNcdPEuZuT+GY7l
        +LpLRjmpjDayxA+jHE10hDLK2Q==
X-Google-Smtp-Source: ABdhPJwVvRDLtordvMpU6Gv1ZaBnGBkW/v3SlKsBN0AAW1ifyLYtRH7sZcFZFZiGVhfIEJh4LnD75Q==
X-Received: by 2002:a63:ff22:: with SMTP id k34mr26363851pgi.336.1624942505600;
        Mon, 28 Jun 2021 21:55:05 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id s3sm16431579pfe.49.2021.06.28.21.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 21:55:05 -0700 (PDT)
Date:   Tue, 29 Jun 2021 10:25:03 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
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
        Will Deacon <will@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH V3 0/4] cpufreq: cppc: Add support for frequency
 invariance
Message-ID: <20210629045503.tc6vdq773udmyho5@vireshk-i7>
References: <2c540a58-4fef-5a3d-85b4-8862721b6c4f@quicinc.com>
 <20210624025414.4iszkovggk6lg6hj@vireshk-i7>
 <CAKfTPtAXMYYrG1w-iwSWXb428FkwFArEwXQgHnjShoCEMjdYcw@mail.gmail.com>
 <20210624104734.GA11487@arm.com>
 <daf1ddf5-6f57-84a8-2ada-90590c0c94b5@quicinc.com>
 <20210625102113.GB15540@arm.com>
 <1f83d787-a796-0db3-3c2f-1ca616eb1979@quicinc.com>
 <20210625143713.GA7092@arm.com>
 <888b0178-00cc-ffa4-48a2-8563cef557a4@quicinc.com>
 <9096bdb2-2a38-6ba3-0315-f6e9bd5a4c0e@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9096bdb2-2a38-6ba3-0315-f6e9bd5a4c0e@quicinc.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-06-21, 09:41, Qian Cai wrote:
> Another date point is that set ACPI_CPPC_CPUFREQ_FIE=n fixed the issue that any CPU could run below the lowest freq.
> 
> schedutil:
> # cat /sys/devices/system/cpu/*/cpufreq/cpuinfo_cur_freq | sort | uniq  -c
>      80 1000000
>      78 1400000
>       1 2010000
>       1 2800000
> 
> userspace:
> # cat /sys/devices/system/cpu/*/cpufreq/cpuinfo_cur_freq | sort | uniq  -c
>     158 1000000
>       2 2000000

ACPI_CPPC_CPUFREQ_FIE can play a role with schedutil, but not with
userspace governor. Userspace doesn't use the values being updated by
ACPI_CPPC_CPUFREQ_FIE. So I think the CPUs may not have been idle,
just for some reason.

Also, now that you are able run on latest kernel (linux-next), it
would be better if we can talk in terms of that only going forward.
5.4 adds more to the already unstable results :)

-- 
viresh
