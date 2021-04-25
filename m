Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8461536A943
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 22:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbhDYUuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 16:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbhDYUuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 16:50:24 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA147C061574
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 13:49:43 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id s16so48721979iog.9
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 13:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+CjY/BeYZawNKicl6vyRrVfgxDrQti0ByfrXh5ynJ1g=;
        b=MvHkrpsDc/s8YcsoK6tEhN6hZUOs3e5cS9Ay4ONM+vtFVImNeXWEEbnIboOGkBMJb4
         zMinlSNBi3IgMNBKxWZJYFvqpbnYJzvxuUbLugUai1K+V95rBi6R7MNX16rno/dCysRa
         C1xYUnOnj8d6MOo0MKoUMxEiBOctbSBBpLI5hBvexYn20CaeTjqvO7n97C4tdOOLz2o/
         TbvRm7/XUFDZ28zbNEmQVjtyP+dmUHqPfJN2QQc/NRZacllC/ZQ7qzx7yGT8WM0whsh7
         mGWJp8EETCsQRHIOvyZdw1OyfwmcEIKgX/ukngyud8qSFxI1ZH2LOu+l9JS8jLVJJXnW
         CXGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+CjY/BeYZawNKicl6vyRrVfgxDrQti0ByfrXh5ynJ1g=;
        b=TQ8XRjq+9DPwyVr5oNXmBwy6AsxUUAp/h2x2zD2GY/Fq6iTqHqKw0VycKcoHCipVki
         8DiR2LHtnspT677vwFBWdiIoIdFQOs8rQoyqLO0tPrmKbEYMdsJe3eF3wMi9aM12Jrj8
         Pn+Y8X+qfcT4HbjgQ931tmHOejAgItlyaizHAoTj9l8yxzstcYIkYVSB8DNjRuBlJnMZ
         ii2L/79c2G6UUlx0S7SCojzOCstPq1QuV/LH/BhQLOS9Es3oSRaIZkCiMFmFS/hoYY5B
         zo15LhMFPo03xydX9HXMmdbDAQtHRmAb/jnb/ZXZ93Nsb7tDGOZKHnm1uITFGUlBP7M3
         g16g==
X-Gm-Message-State: AOAM530JrkRD4aGguwCgU5RQnzk+9KwGjq8L7qe1ldoqlj87c2RSfNKI
        OByEVGeyR0MhMSCt0BRKCIwg6jgSwi6Tqao1/IHAmg==
X-Google-Smtp-Source: ABdhPJyzyhAeVoCxzGJBpI7ofZZUrwbPMix43i3eCNOJ3jrK76Xn6+Fr9LGAkFGCza0bxM1496YMLbiToroYPL3oOo4=
X-Received: by 2002:a5d:9cd8:: with SMTP id w24mr11597320iow.78.1619383783189;
 Sun, 25 Apr 2021 13:49:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210412074309.38484-1-psampat@linux.ibm.com> <20210412074309.38484-3-psampat@linux.ibm.com>
In-Reply-To: <20210412074309.38484-3-psampat@linux.ibm.com>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Sun, 25 Apr 2021 13:49:32 -0700
Message-ID: <CAAYoRsXhH3d8AwBgHD1kyWjw2GUvMQ42br72CfjHTx6NSYKp6w@mail.gmail.com>
Subject: Re: [RFC v4 2/2] selftest/cpuidle: Add support for cpuidle latency measurement
To:     Pratik Rajesh Sampat <psampat@linux.ibm.com>
Cc:     rjw@rjwysocki.net, Daniel Lezcano <daniel.lezcano@linaro.org>,
        shuah@kernel.org, ego@linux.vnet.ibm.com, svaidy@linux.ibm.com,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, pratik.r.sampat@gmail.com,
        dsmythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pratik,

On Mon, Apr 12, 2021 at 12:43 AM Pratik Rajesh Sampat
<psampat@linux.ibm.com> wrote:
>
> The cpuidle latency selftest provides support to systematically extract,
> analyse and present IPI and timer based wakeup latencies for each CPU
> and each idle state available on the system.
>
> The selftest leverages test-cpuidle_latency module's debugfs interface
> to interact and extract latency information from the kernel.
>
> The selftest inserts the module if already not inserted, disables all
> the idle states and enables them one by one testing the following:
> 1. Keeping source CPU constant, iterate through all the CPUS measuring
>   IPI latency for baseline (CPU is busy with cat /dev/random > /dev/null
>   workload) and then when the CPU is allowed to be at rest
> 2. Iterating through all the CPUs, sending expected timer durations to
>   be equivalent to the residency of the deepest idle state enabled
>   and extracting the difference in time between the time of wakeup and
>   the expected timer duration
>
> The timer based test produces run to run variance on some intel based
> systems that sport a mechansim "C-state pre-wake" which can
> pre-wake a CPU from an idle state when timers are armed. For systems and
> architectures that don't have this mechansim can leverage timer tests
> with the -i option.
>
> To run this test specifically:
> $ sudo make -C tools/testing/selftests TARGETS="cpuidle" run_tests
>
> There are a few optional arguments too that the script can take
>         [-h <help>]
>         [-i <run timer tests>]
>         [-m <location of the module>]
>         [-o <location of the output>]
>         [-v <verbose> (run on all cpus)]
> Default Output location in: tools/testing/selftest/cpuidle/cpuidle.log
>
> To run the test without re-compiling:
> $ cd tools/testing/selftest/cpuidle/
> $ sudo ./cpuidle.sh
>
> Signed-off-by: Pratik Rajesh Sampat <psampat@linux.ibm.com>

Reviewed-by: Doug Smythies <dsmythies@telus.net>
...
