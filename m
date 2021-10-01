Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A6341F4EE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 20:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354947AbhJASYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 14:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbhJASY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 14:24:29 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E429C06177D
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 11:22:45 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id y15so11448693ilu.12
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 11:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z4PlRJREpIlisJK+SBpA8a969GXc7LbffCI4L4F6DWQ=;
        b=PgvnbgKjU4zogDfwxsiGLPsUvXeFumI1+qnxR1OaY5DXIXvIt7VpWZW/ZUi1N8IkFT
         FIlk4+dnBKqcfAVJL8PeWYVuiEB7hydRhs+195E4NDvxr6RalkhAE0nsscbtkNfMk2PZ
         fB9ytXiKOsuzQwE6puDHLL+QGdocif6GkPBXKjyveU88m+b/fouBYteWyJeSLWL3pm3J
         vi1rEXI5A63QFA+YyOaJss8qsO8u3x1dMuPiqEXgzXskcC6rpUjjeFxX3Hieizs/3HVS
         YXp6Rg8MH1mCC48Cheg1mBgXRnWnmF0nZxU1NgmgUblfjIbLneGh4aDpvHo0dbqwibSE
         dkwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z4PlRJREpIlisJK+SBpA8a969GXc7LbffCI4L4F6DWQ=;
        b=Qc7MI3jDmyDSUg8feddCECT9MHC0Fzxyx76AfOWFBLtcXfryEkpRLcbwhJB/Kkgxtx
         5x3+GFlTaPV19IqFuFNzsmW0f0k2j99ya4w8O0vdEmNm9BlpVeX/WDBWvuWxAQ52N7ra
         SWTeNzM9SEWcqpakn5NNe6+ss1h72aNKrXnDwhFBFCnKl4I6j6UrQkET5aCmAscqWlsg
         sF9l7SM5OG0rffKyliTOoV0vIKcRyU3OqlqXB1q9iVsxVTq8nir16oRBAO/IWNSSEOr8
         F9LPtwyTV3GESTiTHbu9NbSbGJH80HUdYntL7fC0HJYs3JT63DCdVVCPRLxWNnWq2zw2
         rp5A==
X-Gm-Message-State: AOAM533m2+8qoT8kXZxyRtLAcAERexw1387RfYTrdTlw4rxTff8DKl8I
        POhFupNv5pstFaNLkQMFd3NSswZARhagN3gLi7v9IA==
X-Google-Smtp-Source: ABdhPJyvPZL6WM2MRnD48qzDDCcBwBg5XcjWMviS8cTZS9vnZVGoxCi9y1+Jn7Y1N+V3pssQ2sCoi1DYiv57DKB+alQ=
X-Received: by 2002:a05:6e02:1807:: with SMTP id a7mr8669862ilv.310.1633112564560;
 Fri, 01 Oct 2021 11:22:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210916001748.1525291-1-namhyung@kernel.org> <20210916135418.GA383600@leoy-ThinkPad-X240s>
 <CAM9d7chQjzEm7=UpjtTBbsob7kT+=9v16P30hWxnna7mbHu=2g@mail.gmail.com>
 <20210923142305.GA603008@leoy-ThinkPad-X240s> <CAM9d7cixyD6ZmXnBnoB8Zg-JN-tWYXUdqURHGn+2ZMD5x9evew@mail.gmail.com>
 <CABPqkBTW9dnfSz1KrtiGNzbOf7QfzB6ga+EQvK28J+3-SzBsgQ@mail.gmail.com> <8cc1574a-29a9-f550-0b09-a23ce69467d3@arm.com>
In-Reply-To: <8cc1574a-29a9-f550-0b09-a23ce69467d3@arm.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Fri, 1 Oct 2021 11:22:33 -0700
Message-ID: <CABPqkBTD9Jst9vXPbU+n_MwPSAUyD5Pa0uwkiQhJN0iXJsjzrQ@mail.gmail.com>
Subject: Re: [RFC] perf arm-spe: Track task context switch for cpu-mode events
To:     James Clark <james.clark@arm.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 1, 2021 at 3:44 AM James Clark <james.clark@arm.com> wrote:
>
>
>
> On 30/09/2021 19:47, Stephane Eranian wrote:
> > On Thu, Sep 23, 2021 at 9:02 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >>
> >> Hi Leo,
> >>
> >> On Thu, Sep 23, 2021 at 7:23 AM Leo Yan <leo.yan@linaro.org> wrote:
> >>>
> >>> Hi Namhyung,
> >>>
> >>> On Thu, Sep 16, 2021 at 02:01:21PM -0700, Namhyung Kim wrote:
> >>>
> >>> [...]
> >>>
> >>>>> Before we had discussion for enabling PID/TID for SPE samples; in the patch
> >>>>> set [1], patches 07, 08 set sample's pid/tid based on the Arm SPE context
> >>>>> packets.  To enable hardware tracing context ID, you also needs to enable
> >>>>> kernel config CONFIG_PID_IN_CONTEXTIDR.
> >>>>
> >>>> Thanks for sharing this.
> >>>>
> >>>> Yeah I also look at the context info but having a dependency on a kconfig
> >>>> looks limiting its functionality.  Also the kconfig says it has some overhead
> >>>> in the critical path (even if perf is not running, right?) - but not sure how
> >>>> much it can add.
> >>>
> >>> Yes, after enabled config PID_IN_CONTEXTIDR, the kernel will always
> >>> write PID into the system register CONTEXTIDR during process context
> >>> switching.  Please see the flow:
> >>>
> >>>   __switch_to() (arch/arm64/kernel/process.c)
> >>>     `-> contextidr_thread_switch(next)
> >>
> >> Thanks for the info.  I assume it's a light-weight operation.
> >>
> >>
> > I'd like to understand why it was believed that having SPE record to
> > PID could be too expensive
> > vs. what I am seeing with all the tracking of context switches and the
> > volume of data this generates.
> >
>
> I think the justification about it being expensive is that when PID_IN_CONTEXTIDR
> is set, there is an extra few instructions to write that value on every context
> switch, whether SPE is enabled or not. So it has a system wide impact.

You could use a static key to make this conditional to having SPE
running on the CPU like
it is done for other PMU features on other architectures.
