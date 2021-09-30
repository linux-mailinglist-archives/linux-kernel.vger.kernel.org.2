Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 424DD41E161
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 20:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344771AbhI3Sty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 14:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237166AbhI3Stv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 14:49:51 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF47CC06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 11:48:08 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id q205so8849607iod.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 11:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ev+xmyKh52SVBl+xJOLXhCxYSiB9U59vNgyG8V24HnU=;
        b=OPTtuRSKSBmCu8TqisU23ynxmBFjszT3rmpIFJJsmxwfVf6uMtydWkscvBwkwn92nm
         CgOAzuLb6zbRvsvLsCSUrH7xTp8otC09+1ZnQ1V6XPm59RpR6Ip95dvlgxPFeWL3RMHf
         rKdmh23aMo8xJalNLcFNcyYOd4Tkxv2d3q4zLZ6DuNvvKh4tMvvsDq8Vfydx+PdL4xZu
         l5dhwHEVY9T+nK3XUQ0WtpFSmrtU4SKiLb3r9lJdKQkB5PWfUcOEloIr6ACi4vSdaqpf
         dyOoFHld/zgtRRCeRa9e6J+QqNkAg4rcr3ph6HVMPUXvKjAD8NfMPQIjPsIiUaWhBoEu
         xkkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ev+xmyKh52SVBl+xJOLXhCxYSiB9U59vNgyG8V24HnU=;
        b=d44J+pvbuH+q6hg2tVctjHD7H93jVJ3jhI4pjzo5bd9HJ/p0Ic6LyD7UhefrLzncKO
         7Z0miWkq7At1lLmplfMAEmwjhlnqgTfXzqgAwWJn0o17FByHSsJynDvTOKWQuL4aO/9Z
         uo/4HJLtxPV5lpZgmyDlgeMme9YCdOijDIdo3B+jXBu2luVNIMWNuZP5YLHKhULxQied
         ppkD4DIsxkc8M2oxLff1snEywN1yTyxuq30KwQOu3IrQ0BMb7KmSM4HYifHUOB6PwBQV
         hdwh5In/T1Zdu70u9N90+TKpeAXR62de67kZSE344kRlmEdQF4AWwGjOY4UVDOuQBq/6
         ss2Q==
X-Gm-Message-State: AOAM532ioi6YflrGBrgdWMV8kKYTFbeXVhRBa7FZfDFpuRp2/NZR1/C8
        HEbf0hgAcKlVd+WoTGeBwgvl4cUwX5F2NAAsEniv3g==
X-Google-Smtp-Source: ABdhPJzdrS19ptuJ9EfdM4woASby4yjdFbwgDH0IA35mriyKk/c+u/pM1hy5J5e5Mqk9FjCDJ17sZiWmjgep/6F8lvY=
X-Received: by 2002:a05:6602:345:: with SMTP id w5mr4953077iou.49.1633027687730;
 Thu, 30 Sep 2021 11:48:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210916001748.1525291-1-namhyung@kernel.org> <20210916135418.GA383600@leoy-ThinkPad-X240s>
 <CAM9d7chQjzEm7=UpjtTBbsob7kT+=9v16P30hWxnna7mbHu=2g@mail.gmail.com>
 <20210923142305.GA603008@leoy-ThinkPad-X240s> <CAM9d7cixyD6ZmXnBnoB8Zg-JN-tWYXUdqURHGn+2ZMD5x9evew@mail.gmail.com>
In-Reply-To: <CAM9d7cixyD6ZmXnBnoB8Zg-JN-tWYXUdqURHGn+2ZMD5x9evew@mail.gmail.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Thu, 30 Sep 2021 11:47:56 -0700
Message-ID: <CABPqkBTW9dnfSz1KrtiGNzbOf7QfzB6ga+EQvK28J+3-SzBsgQ@mail.gmail.com>
Subject: Re: [RFC] perf arm-spe: Track task context switch for cpu-mode events
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 9:02 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hi Leo,
>
> On Thu, Sep 23, 2021 at 7:23 AM Leo Yan <leo.yan@linaro.org> wrote:
> >
> > Hi Namhyung,
> >
> > On Thu, Sep 16, 2021 at 02:01:21PM -0700, Namhyung Kim wrote:
> >
> > [...]
> >
> > > > Before we had discussion for enabling PID/TID for SPE samples; in the patch
> > > > set [1], patches 07, 08 set sample's pid/tid based on the Arm SPE context
> > > > packets.  To enable hardware tracing context ID, you also needs to enable
> > > > kernel config CONFIG_PID_IN_CONTEXTIDR.
> > >
> > > Thanks for sharing this.
> > >
> > > Yeah I also look at the context info but having a dependency on a kconfig
> > > looks limiting its functionality.  Also the kconfig says it has some overhead
> > > in the critical path (even if perf is not running, right?) - but not sure how
> > > much it can add.
> >
> > Yes, after enabled config PID_IN_CONTEXTIDR, the kernel will always
> > write PID into the system register CONTEXTIDR during process context
> > switching.  Please see the flow:
> >
> >   __switch_to() (arch/arm64/kernel/process.c)
> >     `-> contextidr_thread_switch(next)
>
> Thanks for the info.  I assume it's a light-weight operation.
>
>
I'd like to understand why it was believed that having SPE record to
PID could be too expensive
vs. what I am seeing with all the tracking of context switches and the
volume of data this generates.
