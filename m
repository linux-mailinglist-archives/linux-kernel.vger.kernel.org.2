Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96B9B30E149
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 18:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhBCRky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 12:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbhBCRkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 12:40:46 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36319C061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 09:40:06 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id j11so494793wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 09:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2OgZancFGVnRbkkHKtol1BVz00zX7IPQWBe9YJ/qmQo=;
        b=DzD4AknrLgH1eOaKjbJNPpWrZEMoL8F9WSWIG6FDJHmfXHSPXEpV4HX5Ditjb3tSN9
         R0RvMNRX/9P4uI5wizJPTH3nmI30GmVA8Tq5YoT4wlln5kVSd8Sdl/gyGzW1mWExvsvv
         V8841gAohM8TLBNgcP0bJHkFks9ai46pBWdN1HxnVS3UwWzi7bMucjQwWJTvUp9UKRT5
         iTYzSFvzCD+P+zpGMPiFPaU6LOgZE/O9wM17qIL5duGdF2fXk+Rq8mbp6fOa9YF5z3Dj
         joHKow2FcXDKChQDwmxjwjNG0mkj4QNF67ADuOS1XaEvrsC6U0biWy4aP7knyCZPJpJa
         NGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2OgZancFGVnRbkkHKtol1BVz00zX7IPQWBe9YJ/qmQo=;
        b=ZqfgIcWxVNCCWbnKY6Vs00tuflSvx6U59Y5NaJusV6ocnH3BQjQJkzflO/r+gumNVI
         5ScSL+u4XtYtY7hjRIEZAY4S+fVvCLZy8RFZhR1+o/oa5pSRpErAsHi1IdAkwFmWWG0p
         LSBtqnxY/1rY1/OJ1Md/V3Iki+O90E0zPRNU7O/t+XQvqfSXsVJSl/8vf90cIGmxRGgM
         hCLJXZQRSEpBNKmrqRMHIAn2iq6hW/+zR81wz7qawmF722na4Gkm65kp2EiAth+Fe1V/
         bqIZwItL7NiFSkBE25jfn0PwOwwb8p9Z0JWfmVFN/nmBVh8v87U9yDioHvTRJYpGU6Wa
         J4dw==
X-Gm-Message-State: AOAM532GU8w0+HXbMvoQuKzLrY2jWhUFoDpDnnOzEs7a3l216N3bBAq9
        XQmIaIj4LV8Ps7YKBpgHolfdn+70E821TqoSURn+UA==
X-Google-Smtp-Source: ABdhPJy7yG8xKPiMitr1vEENqU/wSuA03K/4hntFwPJPyfa/gyY5+1nfWAB6IMNLn+9M7spbH4MPL0Dd3mADIBFz9wU=
X-Received: by 2002:a05:600c:28b:: with SMTP id 11mr3856882wmk.98.1612374004930;
 Wed, 03 Feb 2021 09:40:04 -0800 (PST)
MIME-Version: 1.0
References: <20210202163842.134734-1-leo.yan@linaro.org> <20210202163842.134734-8-leo.yan@linaro.org>
In-Reply-To: <20210202163842.134734-8-leo.yan@linaro.org>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Wed, 3 Feb 2021 17:39:54 +0000
Message-ID: <CAJ9a7VgzNphx=OkxjrxHJsuFAYEbOgHuAm9ysdwHq20=GhbgTg@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] Documentation: coresight: Add PID tracing description
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
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

On Tue, 2 Feb 2021 at 16:39, Leo Yan <leo.yan@linaro.org> wrote:
>
> After support the PID tracing for the kernel in EL1 or EL2, the usage
> gets more complicated.
>
> This patch gives description for the PMU formats of contextID configs,
> this can help users to understand how to control the knobs for PID
> tracing when the kernel is in different ELs.
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  Documentation/trace/coresight/coresight.rst | 37 +++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/Documentation/trace/coresight/coresight.rst b/Documentation/trace/coresight/coresight.rst
> index 0b73acb44efa..771558f22938 100644
> --- a/Documentation/trace/coresight/coresight.rst
> +++ b/Documentation/trace/coresight/coresight.rst
> @@ -512,6 +512,43 @@ The --itrace option controls the type and frequency of synthesized events
>  Note that only 64-bit programs are currently supported - further work is
>  required to support instruction decode of 32-bit Arm programs.
>
> +2.2) Tracing PID
> +
> +When the kernel is running at EL2 with Virtualization Host Extensions (VHE),
> +perf records CONTEXTIDR_EL2 in the trace data and can be used as PID when
> +decoding; and if the kernel is running at EL1 with nVHE, CONTEXTIDR_EL1 is
> +traced for PID.
> +

Would this introductory paragraph be better if is explained where the
kernel stores the PID for the different levels, then we logically move
on to how to trace this in perf.

e.g:-

"The lernel can be built to write the PID value into the PE ContextID registers.
For a kernel running at EL1, the PID is stored in CONTEXTIDR_EL1.
A PE may implement ARM Virtualisation Host Extensions (VHE), were the
kernel can run at EL2 as a virtualisation host.
In this case the PID value is stored in CONTEXTIDR_EL2.
perf provides PMU options which program the ETM to insert these values
into the trace data."

> +To support tracing PID for the kernel runs at different exception levels,
> +the PMU formats are defined as follow:
> +
> +  "contextid1": Available on both EL1 kernel and EL2 kernel.  When the
> +                kernel is running at EL1, "contextid1" enables the PID
> +                tracing; when the kernel is running at EL2, this enables
> +                tracing the PID of guest applications.
> +
> +  "contextid2": Only usable when the kernel is running at EL2.  When
> +                selected, enables PID tracing on EL2 kernel.
> +
> +  "contextid":  Will be an alias for the option that enables PID
> +                tracing.  I.e,
> +                contextid == contextid1, on EL1 kernel.
> +                contextid == contextid2, on EL2 kernel.
> +
> +The perf tool automatically sets corresponding bit for the "contextid" config,
> +therefore, the user doesn't have to bother which EL the kernel is running.
> +
> +  i.e, perf record -e cs_etm/contextid/u -- uname
> +    or perf record -e cs_etm//u -- uname
> +
> +will always do the "PID" tracing, independent of the kernel EL.
> +

This is telling me that both cs_etm// and cs_etm/contextid/ have the
same effect - trace PID. Is this correct?
If so, then contextid, contextid1 and contextid2 have no effect except
in specific EL2 circumstances.


> +When the kernel is running at EL2 with VHE, if user wants to trace both the
> +PIDs for both host and guest, the two configs "contextid1" and "contextid2"
> +can be set at the same time:
> +
> +  perf record -e cs_etm/contextid1,contextid2/u -- uname
> +
>


Regards

Mike


>  Generating coverage files for Feedback Directed Optimization: AutoFDO
>  ---------------------------------------------------------------------
> --
> 2.25.1
>


--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
