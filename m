Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE7A32A02C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575445AbhCBD4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344159AbhCAWuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 17:50:11 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DDDC061794
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 14:49:22 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id b130so6789315qkc.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 14:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xA2EiPMtYi+Gfmg1Yc47LmxZNfLbHszPXKAA6vPAIh8=;
        b=jYofzajioBOR03n4mCqbrDpH6/uBSr/aENM4iC5Q2rRptMDrqaVIPX0nIF14iyLROZ
         0RJhJQi0W1CELV1slYYaWGBnwqyUQmUjzRgurOCryijZ4pLbPkuTw2H4JAGuFs9fL/kW
         iirv9/cgEYCYikSJ/JtOiSHuDX0WkB5obllmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xA2EiPMtYi+Gfmg1Yc47LmxZNfLbHszPXKAA6vPAIh8=;
        b=G/K/0TnYwBSQqbA4Fhde/YaXSDO2OXF0/AYOx55VYBjlGwxUtLnAoWKC7Vj6te7ERP
         hLueGvgG+bwqmJ6DKye36r/LNUcHllYeIoR3JAAGzSANb+oiltw3Vr1TpT/4ujLX8ulm
         WWPDq7dZs8FB5SLouJb6uBOtOdW9HTMcjzDd6AEtdl/SD1C9msLH15RaZKN7fSWAPLVd
         QHj0rr9Pl5059K/QjZxn8L3VFcgv89PZHcb53G9tij6R4NGsBG5wScK3KO/3nQTk3HVR
         q2p+VSjeTmoUFPeKqRRFHE6wTyXgSUGHTjiFXyjcraZGFDTgRmVaUl9QcCpn7mtAFef7
         RJWA==
X-Gm-Message-State: AOAM530bh/0iOrwV4Xst2Z6BQuz/F5h1ZrnZo61nTAvT2fLU79+DJqyM
        UUl5lhXcBOq2DrEBPGoxuNNMDJLnE/ZSlQ==
X-Google-Smtp-Source: ABdhPJza8Qp8LGS2SRA4D7UElj58Zp4mtDcVi67mcesg2JLE0JG7eVKqSx8QKAs3notN7TLIYzjeBw==
X-Received: by 2002:a05:620a:1353:: with SMTP id c19mr6265662qkl.392.1614638961925;
        Mon, 01 Mar 2021 14:49:21 -0800 (PST)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id b27sm2884116qkl.102.2021.03.01.14.49.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Mar 2021 14:49:21 -0800 (PST)
Received: by mail-yb1-f171.google.com with SMTP id 133so18681553ybd.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 14:49:21 -0800 (PST)
X-Received: by 2002:a25:4e83:: with SMTP id c125mr24079401ybb.343.1614638581776;
 Mon, 01 Mar 2021 14:43:01 -0800 (PST)
MIME-Version: 1.0
References: <cover.1614624041.git.saiprakash.ranjan@codeaurora.org> <def1a6b37cbb54cb15329765266ed90c2f7aa24e.1614624041.git.saiprakash.ranjan@codeaurora.org>
In-Reply-To: <def1a6b37cbb54cb15329765266ed90c2f7aa24e.1614624041.git.saiprakash.ranjan@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 1 Mar 2021 14:42:50 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UzhLX4bdRV5gEXZgsbnQW9ViZxC9Vs2TXeSxXu72Dagg@mail.gmail.com>
Message-ID: <CAD=FV=UzhLX4bdRV5gEXZgsbnQW9ViZxC9Vs2TXeSxXu72Dagg@mail.gmail.com>
Subject: Re: [PATCHv2 1/4] perf/core: Add support to exclude kernel mode PMU tracing
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, coresight@lists.linaro.org,
        Stephen Boyd <swboyd@chromium.org>,
        Denis Nikitin <denik@chromium.org>,
        Mattias Nissler <mnissler@chromium.org>,
        Al Grant <al.grant@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Mar 1, 2021 at 11:05 AM Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> Hardware assisted tracing families such as ARM Coresight, Intel PT
> provides rich tracing capabilities including instruction level
> tracing and accurate timestamps which are very useful for profiling
> and also pose a significant security risk. One such example of
> security risk is when kernel mode tracing is not excluded and these
> hardware assisted tracing can be used to analyze cryptographic code
> execution. In this case, even the root user must not be able to infer
> anything.
>
> To explain it more clearly in the words of a security team member
> (credits: Mattias Nissler),
>
> "Consider a system where disk contents are encrypted and the encryption
> key is set up by the user when mounting the file system. From that point
> on the encryption key resides in the kernel. It seems reasonable to
> expect that the disk encryption key be protected from exfiltration even
> if the system later suffers a root compromise (or even against insiders
> that have root access), at least as long as the attacker doesn't
> manage to compromise the kernel."
>
> Here the idea is to protect such important information from all users
> including root users since root privileges does not have to mean full
> control over the kernel [1] and root compromise does not have to be
> the end of the world.
>
> But "Peter said even the regular counters can be used for full branch
> trace, the information isn't as accurate as PT and friends and not easier
> but is good enough to infer plenty". This would mean that a global tunable
> config for all kernel mode pmu tracing is more appropriate than the one
> targeting the hardware assisted instruction tracing.
>
> Currently we can exclude kernel mode tracing via perf_event_paranoid
> sysctl but it has following limitations,
>
>  * No option to restrict kernel mode instruction tracing by the
>    root user.
>  * Not possible to restrict kernel mode instruction tracing when the
>    hardware assisted tracing IPs like ARM Coresight ETMs use an
>    additional interface via sysfs for tracing in addition to perf
>    interface.
>
> So introduce a new config CONFIG_EXCLUDE_KERNEL_PMU_TRACE to exclude
> kernel mode pmu tracing which will be generic and applicable to all
> hardware tracing families and which can also be used with other
> interfaces like sysfs in case of ETMs.
>
> [1] https://lwn.net/Articles/796866/
>
> Suggested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Suggested-by: Al Grant <al.grant@arm.com>
> Tested-by: Denis Nikitin <denik@chromium.org>
> Link: https://lore.kernel.org/lkml/20201015124522.1876-1-saiprakash.ranjan@codeaurora.org/
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>  init/Kconfig         | 11 +++++++++++
>  kernel/events/core.c |  3 +++
>  2 files changed, 14 insertions(+)

I'm not really knowledgeable at all about the perf subsystem so my
review doesn't hold a lot of weight.  However, Sai's patch seems sane
to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
