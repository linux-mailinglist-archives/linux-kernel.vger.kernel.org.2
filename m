Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68C1B314221
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 22:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236315AbhBHVny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 16:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235622AbhBHVQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 16:16:34 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C010AC06178A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 13:15:53 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id g6so5902632wrs.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 13:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nl24aBu6VlDGNZ7aIznSxL6vPEfdrBS3BpNpZ57YGjw=;
        b=XqtjWz5JeEz4SxtEHUno0fGRUwKcGm/28uayE8naVV3NhjfgWpBy6C3kFfA1NyCqaB
         0op1dbvXUucs1zZ4dmzBVjdFwszhdWLrfCy1SEqksUKtppfjt3Wsg0PhXuBhfAjaoA5q
         l24GYWrqJPmpkNfgBugBs3UGvq0CJGfcjqJOD9fbY0e0PKEZF3wAEgft403iUebRfHUp
         ar26k7hcvny3Mw5vdWaN3W1VXSGL+9fciG4hthCRBot80fl+J1/ZWwzdjyywp5c4A8kZ
         gGB1OommyQYpGk7NQfnfXbcSgbjzC0eNsnFnvKO0yWW6YI7OlUd8NktN81cS8C5R9Lci
         e6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nl24aBu6VlDGNZ7aIznSxL6vPEfdrBS3BpNpZ57YGjw=;
        b=dmNuKS2T65L5j4xGadoYlWJrax7BK5lyEmQsZcOqhbWRc2BwXRtjGWyXx8wCbY3Ge+
         EbmZhfcf2YoYgbRLt8UmWiwtauqGcASjesgzuzTXyLxnJw546IdjsfnA/RTpwfFfpnBb
         kISmmQdJuEwG5ZGoJ61BFlJNv68s+TFPQwEFL3/Una3a4+rdjzcg1gz0dpm3aXj0415U
         E5nkuAz2YfoUDPVBRBiEYEkbxjJ6Hs+vm+SajDp96LuSlJ+skbXHEi5jvIGoYHWDw5sz
         8N+Qm2DrfCWdee3dFIRC+76wq6rd40vze9l7BWg3uUk/9F1uOAMy8N0A0ToonubakJ3i
         m+qg==
X-Gm-Message-State: AOAM5334VWR3JM2/VBUhwUnQb8h7yNbHLG5P2L0XRus6onkzDliIniOZ
        FhubAsEK8AZz0c8kyIzblIROPrnVd3YicKp0MNdieA==
X-Google-Smtp-Source: ABdhPJyA2eBkS3cE7KKbo7Rs9na9pXbaSA+d9pi1IhPdrrbmQPtGARl85bTCVHPU+l8/0llSzvGY35At1dSMEGGGxRw=
X-Received: by 2002:a5d:54ce:: with SMTP id x14mr12979919wrv.182.1612818952437;
 Mon, 08 Feb 2021 13:15:52 -0800 (PST)
MIME-Version: 1.0
References: <20210206150833.42120-1-leo.yan@linaro.org> <20210206150833.42120-9-leo.yan@linaro.org>
 <20210208205009.GF2077938@xps15>
In-Reply-To: <20210208205009.GF2077938@xps15>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Mon, 8 Feb 2021 21:15:41 +0000
Message-ID: <CAJ9a7Vj0T7Yh8mduqAMJtmBwxjWBgEa1O5CO1gw8gYqX8hRmyQ@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] Documentation: coresight: Add PID tracing description
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Kiss <Daniel.Kiss@arm.com>,
        Denis Nikitin <denik@chromium.org>,
        Al Grant <al.grant@arm.com>,
        Coresight ML <coresight@lists.linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think Suzuki may be on holiday for two weeks. But this does appear
to pick up both mine and his suggestions.
Suzuki gave his conditional reviewed by in the last patch.

Reviewed-by: Mike Leach <mike.leach@linaro.org>


On Mon, 8 Feb 2021 at 20:50, Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
>
> On Sat, Feb 06, 2021 at 11:08:33PM +0800, Leo Yan wrote:
> > After support the PID tracing for the kernel in EL1 or EL2, the usage
> > gets more complicated.
> >
> > This patch gives description for the PMU formats of contextID configs,
> > this can help users to understand how to control the knobs for PID
> > tracing when the kernel is in different ELs.
> >
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
>
> As I indicated I have picked up the kernel patches in this set and there should
> be a new patchset sent to Arnaldo.  The only thing left is this patch and I will
> give time to Mike and Suzuki to look at it before I add it to my tree.
>
> Thanks,
> Mathieu
>
> > ---
> >  Documentation/trace/coresight/coresight.rst | 32 +++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> >
> > diff --git a/Documentation/trace/coresight/coresight.rst b/Documentation/trace/coresight/coresight.rst
> > index 0b73acb44efa..169749efd8d1 100644
> > --- a/Documentation/trace/coresight/coresight.rst
> > +++ b/Documentation/trace/coresight/coresight.rst
> > @@ -512,6 +512,38 @@ The --itrace option controls the type and frequency of synthesized events
> >  Note that only 64-bit programs are currently supported - further work is
> >  required to support instruction decode of 32-bit Arm programs.
> >
> > +2.2) Tracing PID
> > +
> > +The kernel can be built to write the PID value into the PE ContextID registers.
> > +For a kernel running at EL1, the PID is stored in CONTEXTIDR_EL1.  A PE may
> > +implement Arm Virtualization Host Extensions (VHE), which the kernel can
> > +run at EL2 as a virtualisation host; in this case, the PID value is stored in
> > +CONTEXTIDR_EL2.
> > +
> > +perf provides PMU formats that program the ETM to insert these values into the
> > +trace data; the PMU formats are defined as below:
> > +
> > +  "contextid1": Available on both EL1 kernel and EL2 kernel.  When the
> > +                kernel is running at EL1, "contextid1" enables the PID
> > +                tracing; when the kernel is running at EL2, this enables
> > +                tracing the PID of guest applications.
> > +
> > +  "contextid2": Only usable when the kernel is running at EL2.  When
> > +                selected, enables PID tracing on EL2 kernel.
> > +
> > +  "contextid":  Will be an alias for the option that enables PID
> > +                tracing.  I.e,
> > +                contextid == contextid1, on EL1 kernel.
> > +                contextid == contextid2, on EL2 kernel.
> > +
> > +perf will always enable PID tracing at the relevant EL, this is accomplished by
> > +automatically enable the "contextid" config - but for EL2 it is possible to make
> > +specific adjustments using configs "contextid1" and "contextid2", E.g. if a user
> > +wants to trace PIDs for both host and guest, the two configs "contextid1" and
> > +"contextid2" can be set at the same time:
> > +
> > +  perf record -e cs_etm/contextid1,contextid2/u -- vm
> > +
> >
> >  Generating coverage files for Feedback Directed Optimization: AutoFDO
> >  ---------------------------------------------------------------------
> > --
> > 2.25.1
> >



--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
