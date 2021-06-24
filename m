Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B15753B2E5D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 13:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbhFXMBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 08:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbhFXMBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 08:01:52 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00A9C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 04:59:32 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id i13so9826160lfc.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 04:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xqb0SfAot0T+bnLINqL6hkkrh27//4C+mrBYM/KExsw=;
        b=Htc1HoEBVFI1XgWupgitxfKw2XCjbvFJLPtUXneiCFiC55vuz7F4xJVJJGeJAoElBv
         tQuMdzME3RzbdQdWJklBAeHsx615hk+q7O3alOu+0dqeRbiG3UOJFx1rD1RyZGVa5HKX
         XnuRoAcubnoRC3yUKp0ksMR/cNkLFcag7qHeWM3OnyfdEMME7Uw59ftxNU70Y02gr0SL
         1gxaOiWOjzBLwIg+G93gLfvsmovvo2PnbYH5qVbt59c6s+8ac2Cc8Eyi8zzFXq2Ann1I
         i50oU5+uodLhB3bSoeI86H40CGuhfLK19fZZfG2ezCTtw6cvbzpjN9WDiFT3Ch3oaz8u
         9Qiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xqb0SfAot0T+bnLINqL6hkkrh27//4C+mrBYM/KExsw=;
        b=m7AuJM1ggQ55aKUfDwhOfb02nFhzDOM5J+0XFqEu3Pl7ayF73Nl7OS6C3zbhGF8xEa
         bfVRKM5ghwUqckSf4sW6Go5r7zVAcAtA2GAwfi71XLmq78I9iNhuGUtc8WMpRX7RGuOr
         P3qrA2nZZi9cl75QuJyssAnQIiJHkMYojKDoCvxr48GfdrKJe8UKEb/svo0QIj6C4a+Z
         IVcYFDDlLdgDkvIzDOziqBDekzZ4wHCzoVx+1UVQpe4h3nIyJrO02/zPqs4DAJBgMuue
         UvtUDMStBQJ3EBBsmVtnf2BL3a5v+idcJtND1a7csUDw2zuhSlbTUAY7y0ZpXhckq21O
         6sEg==
X-Gm-Message-State: AOAM5326je5Lj17usUnqJEpTvU/+no6g/AMbXVjPs7jUCG10iNE5FmQ2
        5UJ2sv901d2Wv5q9BsR+iFqxskEAepAscZRa936IQw==
X-Google-Smtp-Source: ABdhPJzK8p0rLHruF0h6c9pudWIg1OvZj36XsxI8LCFy7lfwKzc2PVeNTV6LZQeE64ic0MPUgFC3+gTs4CRcnPdkB+c=
X-Received: by 2002:ac2:4949:: with SMTP id o9mr3675161lfi.254.1624535971136;
 Thu, 24 Jun 2021 04:59:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1624266901.git.viresh.kumar@linaro.org> <09a39f5c-b47b-a931-bf23-dc43229fb2dd@quicinc.com>
 <20210623041613.v2lo3nidpgw37abl@vireshk-i7> <2c540a58-4fef-5a3d-85b4-8862721b6c4f@quicinc.com>
 <20210624025414.4iszkovggk6lg6hj@vireshk-i7> <CAKfTPtAXMYYrG1w-iwSWXb428FkwFArEwXQgHnjShoCEMjdYcw@mail.gmail.com>
 <20210624104734.GA11487@arm.com> <CAKfTPtAYuon+V96WmuLz+ekWuqVcb5k17w8ZwNuCzm2KMvZw+w@mail.gmail.com>
 <20210624112331.GA22416@arm.com>
In-Reply-To: <20210624112331.GA22416@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 24 Jun 2021 13:59:20 +0200
Message-ID: <CAKfTPtCUazQu7GRUD=5-VHXBq-6rzaU5xnX_LgVr+i2YcKdvSg@mail.gmail.com>
Subject: Re: [PATCH V3 0/4] cpufreq: cppc: Add support for frequency invariance
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Qian Cai <quic_qiancai@quicinc.com>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jun 2021 at 13:23, Ionela Voinescu <ionela.voinescu@arm.com> wrote:
>
> On Thursday 24 Jun 2021 at 13:15:04 (+0200), Vincent Guittot wrote:
> > On Thu, 24 Jun 2021 at 12:48, Ionela Voinescu <ionela.voinescu@arm.com> wrote:
> > >
> > > Hi guys,
> > >
> > > On Thursday 24 Jun 2021 at 11:49:53 (+0200), Vincent Guittot wrote:
> > > > On Thu, 24 Jun 2021 at 04:54, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > > >
> > > > > On 23-06-21, 08:57, Qian Cai wrote:
> > > > > > Viresh, I am afraid I don't feel comfortable yet. I have a few new tests in
> > > > > > development, and will provide an update once ready.
> > > > >
> > > > > Oh sure, np.
> > > > >
> > > > > > Also, I noticed the delivered perf is even smaller than lowest_perf (100).
> > > > >
> > > > > > # cat /sys/devices/system/cpu/cpu8/acpi_cppc/feedback_ctrs
> > > > > >  ref:103377547901 del:54540736873
> > > > > > # cat /sys/devices/system/cpu/cpu8/acpi_cppc/feedback_ctrs
> > > > > >  ref:103379170101 del:54541599117
> > > > > >
> > > > > > 100 * (54541599117 - 54540736873) / (103379170101 - 103377547901) = 53
> > > >
> > > > I'm not sure that I understand your point. The formula above says that
> > > > cpu8 run @ 53% of nominal performance
> > > >
> > >
> > > I think this is based on a previous example Qian had where:
> > >
> > > /sys/devices/system/cpu/cpu0/acpi_cppc/highest_perf
> > > 300
> > > /sys/devices/system/cpu/cpu0/acpi_cppc/lowest_freq
> > > 1000
> > > /sys/devices/system/cpu/cpu0/acpi_cppc/lowest_perf
> > > 100
> > > /sys/devices/system/cpu/cpu0/acpi_cppc/reference_perf
> > > 100
> > >
> > > ..so the 100 is not from obtaining percentage, is the reference
> > > performance.
> > >
> > > The logic of the formula is to obtain the delivered performance when
> > > knowing the number of ticks for each counter, so:
> > >
> > > So if one gets (103379170101 - 103377547901) ticks for the counter at
> > > running at 1GHz(perf 100), what is the frequency of the core, if its
> > > counter ticked (54541599117 - 54540736873) times in the same interval
> > > of time?
> > >
> > > The answer is 530MHz(perf 53), which is lower than the lowest frequency
> > > at 1GHz(perf 100).
> >
> > But the nominal_perf is 280 and not 100 if i'm not wrong so the perf
> > value is 148 > lowest_perf in this case
> >
>
> Nominal performance has no meaning here. The reference counter ticks
> with the frequency equivalent to reference performance.
>
> Nominal performance is the maximum performance when !boost. Highest
> performance is the maximum performance available including boost
> frequencies. So nominal performance has no impact in these translations
> from counter values to delivered performance.

my bad, nominal_perf == reference_perf on the systems that I have locally

>
> Hope it helps,
> Ionela.
>
> >
> > >
> > >
> > > > > >
> > > > > > My understanding is that the delivered perf should fail into the range between
> > > > > > lowest_perf and highest_perf. Is that assumption correct? This happens on
> > > > > > 5.4-based kernel, so I am in process running your series on that system to see
> > > > > > if there is any differences. In any case, if it is a bug it is pre-existing,
> > > > > > but I'd like to understand a bit better in that front first.
> > > > >
> > > > > Vincent:
> > > > >
> > > > > Can that happen because of CPU idle ?
> > > > >
> > >
> > > Not if the counters are implemented properly. The kernel considers that
> > > both reference and delivered performance counters should stop or reset
> > > during idle. The kernel would not account for idle itself.
> > >
> > > If the reference performance counter does not stop during idle, while
> > > the core performance counter (delivered) does stop, the behavior above
> > > should be seen very often.
> > >
> > > Qian, do you see these small delivered performance values often or
> > > seldom?
> > >
> > > Thanks,
> > > Ionela.
> > >
> > > > > --
> > > > > viresh
