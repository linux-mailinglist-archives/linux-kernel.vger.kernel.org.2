Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD0030F302
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 13:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235884AbhBDMPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 07:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235780AbhBDMPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 07:15:05 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9796CC0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 04:14:24 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id w4so2909318wmi.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 04:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YlsD+cRNrHz/Ii0OHergJMIOhA0CCcsMf8wXcukvVbo=;
        b=PFiTL3STdxKsGHophd8oOpn+5LPXZl8NH/xo18/8+BtAnvpaZ5F3xFsXwFPk3ZonJR
         Mffgnbmj1AO3EGl3jEFrOrG9IsiQj99c6HCGQ12KgEu0HjwuymO3kgjoGi/+dx8g7LCP
         mhgInVuJss2JSGk/+o4GCbUV7JlIs1HAGGQzzEkbeknxROjBy0DHmYIgBCUJsbP4EE34
         j5iC0wevnUG8lupkKCNsxfXU+aOslO8IZGKgztgfekNm/n21NSK68mQTQ/g/FcrQ+xa7
         fqOn3OR3eTO9RIcpJ10VO4qMj4yqivVxTltEUmh0IR8cYy/xPdo6mk3epngD1TmZ4jFF
         XVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YlsD+cRNrHz/Ii0OHergJMIOhA0CCcsMf8wXcukvVbo=;
        b=C/Dp72iXkJqWgmI68foiHchZr3BM6McNV8mZvDwqGCs+/QVplky/DzmrdTft6DpQVV
         CTOdliv8NmmsGkuIAsDW4dB9Iu0kZIn3Tl0g16zSX9XddbQ6DRCUWpBvStyGZWJ1nhZL
         c6Oe9jLKjtd2mz5lazScQax9Gaq415/62Weqr/BMj2pJuXtwCjG9M5KAy4r8mpnqyRm8
         SR0/YPmfytKDGjn0ZOL2FCiACds6yK79yFmmPuNHxf7ChEkGVAsldpDefs+DwNRl7Lb6
         nAEtyJj3OdvXY83q8I9hDu0f/g2WGP0okTuILxDEvRSXTMLgD3Y8ZRIKQrGPrXAIw4dM
         tvSQ==
X-Gm-Message-State: AOAM532SV7MispqQAm1Fc3Yw4U/JezgF0ddFBy/ljsOxCITBWJILVDaG
        cc9H8fIyMK/4SHHUPfYLh3I9+doajyfvsroW9NvYdQ==
X-Google-Smtp-Source: ABdhPJzUT2+IJKjXRV4XeStSHhzdkZNBE2yQpFw/LZcMZYbhR3F9froO+xXHvyJRxPsySzhmUi1lVTkcls4x4rJ9sjg=
X-Received: by 2002:a7b:c856:: with SMTP id c22mr1774125wml.5.1612440863175;
 Thu, 04 Feb 2021 04:14:23 -0800 (PST)
MIME-Version: 1.0
References: <20210202163842.134734-1-leo.yan@linaro.org> <20210202163842.134734-8-leo.yan@linaro.org>
 <CAJ9a7VgzNphx=OkxjrxHJsuFAYEbOgHuAm9ysdwHq20=GhbgTg@mail.gmail.com>
 <20210204040909.GH11059@leoy-ThinkPad-X240s> <a6ee6d9e-a17f-0861-60b5-585abe99ce92@arm.com>
In-Reply-To: <a6ee6d9e-a17f-0861-60b5-585abe99ce92@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Thu, 4 Feb 2021 12:14:12 +0000
Message-ID: <CAJ9a7VgQUAsD46DQARXm1qwiNgd4KU+yymezSEqmoX_7Umvt_A@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] Documentation: coresight: Add PID tracing description
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Kiss <Daniel.Kiss@arm.com>,
        Denis Nikitin <denik@chromium.org>,
        Coresight ML <coresight@lists.linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 4 Feb 2021 at 11:08, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> On 2/4/21 4:09 AM, Leo Yan wrote:
> > Hi Mike,
> >
> > On Wed, Feb 03, 2021 at 05:39:54PM +0000, Mike Leach wrote:
> >
> > [...]
> >
> >>> +2.2) Tracing PID
> >>> +
> >>> +When the kernel is running at EL2 with Virtualization Host Extensions (VHE),
> >>> +perf records CONTEXTIDR_EL2 in the trace data and can be used as PID when
> >>> +decoding; and if the kernel is running at EL1 with nVHE, CONTEXTIDR_EL1 is
> >>> +traced for PID.
> >>> +
> >>
> >> Would this introductory paragraph be better if is explained where the
> >> kernel stores the PID for the different levels, then we logically move
> >> on to how to trace this in perf.
> >>
> >> e.g:-
> >>
> >> "The lernel can be built to write the PID value into the PE ContextID registers.
> >> For a kernel running at EL1, the PID is stored in CONTEXTIDR_EL1.
> >> A PE may implement ARM Virtualisation Host Extensions (VHE), were the
> >> kernel can run at EL2 as a virtualisation host.
> >> In this case the PID value is stored in CONTEXTIDR_EL2.
> >> perf provides PMU options which program the ETM to insert these values
> >> into the trace data."
> >
> > Will in next spin; thanks a lot for writing up!
> >
> >>> +To support tracing PID for the kernel runs at different exception levels,
> >>> +the PMU formats are defined as follow:
> >>> +
> >>> +  "contextid1": Available on both EL1 kernel and EL2 kernel.  When the
> >>> +                kernel is running at EL1, "contextid1" enables the PID
> >>> +                tracing; when the kernel is running at EL2, this enables
> >>> +                tracing the PID of guest applications.
> >>> +
> >>> +  "contextid2": Only usable when the kernel is running at EL2.  When
> >>> +                selected, enables PID tracing on EL2 kernel.
> >>> +
> >>> +  "contextid":  Will be an alias for the option that enables PID
> >>> +                tracing.  I.e,
> >>> +                contextid == contextid1, on EL1 kernel.
> >>> +                contextid == contextid2, on EL2 kernel.
> >>> +
> >>> +The perf tool automatically sets corresponding bit for the "contextid" config,
> >>> +therefore, the user doesn't have to bother which EL the kernel is running.
> >>> +
> >>> +  i.e, perf record -e cs_etm/contextid/u -- uname
> >>> +    or perf record -e cs_etm//u -- uname
> >>> +
> >>> +will always do the "PID" tracing, independent of the kernel EL.
> >>> +
> >>
> >> This is telling me that both cs_etm// and cs_etm/contextid/ have the
> >> same effect - trace PID. Is this correct?
> >
>
> Just to make this clear, this is not a side effect of the patch.

Which is fine - but the documentation should accurately reflect what
is happening on the system.
This is a new paragraph about the PID tracing or otherwise, Even if
some of the effects pre-date this patch, they have to be accurately
communicated.
I am also reading the new paragraph in the context of the rest of the
coresight.rst document - which is a user level document explaining the
basic operation of the coresight system and tools.
This document mentions no other perf command line parameters relevant
to coresight other than the @sink option.It actually calls out to the
OpenCSD docs to provide further information.

> The perf
> tool driver automatically adds the "contextid" tracing and timestamp for
> "system wide" and process bound events, as they traces get mixed into
> the single sink. So these options are added implicitly by the perf tool
> to make the decoding easier.
>

That's fine - I have no problem with contextID trace enabled by
default. Context ID is relatively low overhead - and only emitted at
start of trace  / context changes.
But the explanation of the parameters currently reads as though they
always have an effect - and not putting them in there will omit the
effect - unless you spot the very subtle line at the end.

The user does not need to know about parameters that have no effect!

Perhaps a better approach would be to explain the above - an explicit
statement that "perf will always enable PID/ contextID tracing at the
relevant EL - but for EL2 it is possible to make specific adjustments
using parameters......."

Cheers

Mike


> > Correct.
> >
> >> If so, then contextid, contextid1 and contextid2 have no effect except
> >> in specific EL2 circumstances.
>
> These are required when perf tool may not automatically request them.
> With this series the EL2 is on par with the EL1, where we get the PID
> automatcially in the trace.
>
> And as you rightly said, contextid1, contextid2 are for EL2 specific
> usage.
>
> Cheers
> Suzuki
>
> >
> > Yes, exactly.
> >
> > Thanks,
> > Leo
> >
> >>> +When the kernel is running at EL2 with VHE, if user wants to trace both the
> >>> +PIDs for both host and guest, the two configs "contextid1" and "contextid2"
> >>> +can be set at the same time:
> >>> +
> >>> +  perf record -e cs_etm/contextid1,contextid2/u -- uname
> >>> +
> >>>
> >>
> >>
> >> Regards
> >>
> >> Mike
> >>
> >>
> >>>   Generating coverage files for Feedback Directed Optimization: AutoFDO
> >>>   ---------------------------------------------------------------------
> >>> --
> >>> 2.25.1
> >>>
> >>
> >>
> >> --
> >> Mike Leach
> >> Principal Engineer, ARM Ltd.
> >> Manchester Design Centre. UK
>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
