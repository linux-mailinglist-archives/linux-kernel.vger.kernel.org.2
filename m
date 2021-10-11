Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F11B4291E4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 16:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241180AbhJKOe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 10:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236626AbhJKOeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 10:34:21 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D74C061764
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 07:29:52 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id s11so10970935pgr.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 07:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nYMYp4NGdploAj7mgz7P2IugFmvQ1M84gTEqAQR4q5Y=;
        b=N5BM/HpeuXQwN5UBKBYQxB2ZuBg1THPu+Hw2Uqu34hlnM5yJcLkiKLBQ6z5qikfU6F
         0SNS4fTdanjLqU2xb0XQ8qxwjX5fcZTkCFsUdfbwkbhJcsKzxx1G5e8vTTmtHqAd30z9
         RRh3YjfBtYKHd5d4R+/jBNsC+sacWji3hm/k865YDejj3Uq18U5z+EInqohvyYOiC4Se
         YIGHU7EmmrhzuGkiC66B6UoP6BoSnm9TiksmuM9X+ehTyhK5em9KCy+858DKtOAjFvC0
         4n6jgDseisQIqciNfWBg45DO5z0ng5hybmkvHIOIhZe2FGv1sEKH/1kdWJ1OjokBwvdz
         gFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nYMYp4NGdploAj7mgz7P2IugFmvQ1M84gTEqAQR4q5Y=;
        b=PSLHon2kYveulVIu8HPmPf5oXI9vG781x8qHjkI7Zy8/bMRokieYT1jl3kL0NgloUR
         FAiB1WwiwR13+wy/Qhp1MDas4qv0YGfg2A1/ZEwYk1UDfZaz+cdWxGwpdDy6iGFG7RFB
         eVPXZHSZPXW+CwbcG4E3kYqqQ1jqxRmWxs5dgz5yCI7D2m2ZAuqypgzT1dBNTNn81FIp
         Z+ho7uh83rtMF/gAh7aunjP/kvzKyM3e2IKcXBchc0JhxFdJbCMX1yuWJEdTJtxl5RjG
         +2xx68jyfP4YIIb+c6irGSTNkUQNt4x2ybxNiozIMtGJ7SZCH4b6ZcMHKdXeVEUgZw+a
         ei7A==
X-Gm-Message-State: AOAM530xspzhutM7FvrLetJ/5MvsoWeoL/gFuTW1fXR2lKHG8/ahCGHU
        8zXbm9voCkgxfZmV5ab2pJCf6UUrpYqNwCuM+Mc=
X-Google-Smtp-Source: ABdhPJy+nXHR1kVzmOhe0/iRFFyb9m0nyzeoC7iKt8/iT6OCg3slcdOkaoeNNYfAnBkBoYUm02X2oQ==
X-Received: by 2002:a05:6a00:1a01:b0:44c:1ec3:364f with SMTP id g1-20020a056a001a0100b0044c1ec3364fmr26850878pfv.86.1633962592072;
        Mon, 11 Oct 2021 07:29:52 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id z2sm8279844pfe.210.2021.10.11.07.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 07:29:51 -0700 (PDT)
Date:   Mon, 11 Oct 2021 22:29:40 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC] perf arm-spe: Track task context switch for cpu-mode events
Message-ID: <20211011142940.GB37383@leoy-ThinkPad-X240s>
References: <CAM9d7chQjzEm7=UpjtTBbsob7kT+=9v16P30hWxnna7mbHu=2g@mail.gmail.com>
 <20210923142305.GA603008@leoy-ThinkPad-X240s>
 <363c4107-fc6f-51d0-94d8-a3f579c8f5a2@arm.com>
 <20211004062638.GB174271@leoy-ThinkPad-X240s>
 <f877cfa6-9b25-6445-3806-ca44a4042eaf@arm.com>
 <20211006093620.GA14400@leoy-ThinkPad-X240s>
 <CAM9d7cghXgUbAqUUJjyKAea+9=jxei7RDScgV5Fd_i9bXyXkKA@mail.gmail.com>
 <be937a2e-311b-2a8b-1094-39c203c6d9f3@arm.com>
 <CAM9d7cho2hN+NDWd9-P-AQAf3D8WfPgCpEDe7cD6hk5FoA_c8Q@mail.gmail.com>
 <87dad53f-a9a5-cd36-7348-ee10f4edd8fb@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87dad53f-a9a5-cd36-7348-ee10f4edd8fb@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi German,

On Mon, Oct 11, 2021 at 02:58:40PM +0100, German Gomez wrote:
> Hi Namhyung,
> 
> On 09/10/2021 01:12, Namhyung Kim wrote:
> 
> > Hi German,
> >
> > On Fri, Oct 8, 2021 at 4:08 AM German Gomez <german.gomez@arm.com> wrote:
> >
> > [...]
> >
> > I think we should use context-switch even for kernel samples, but
> > only if the context packets are not available.
> >
> > Thanks,
> > Namhyung
> 
> I think I agree with that you say. If --switch-events is not enabled by
> default like you mention, an user could opt-in to using the fallback if
> there's no better option for kernel tracing yet.

Actually I took time to try to find some way to enable switch events
conditionally.  As Namhyung suggested, we can enable the switch events
in the perf tool (should do this in arm_spe_recording_options()), I am
just wandering if perf tool can enable switch event only when it runs
in the non-root namespace.  I looked the code util/namespaces.c but
still fail to find any approach to confirm the perf is running in
the root namespace...  anyway, this is not critical for this work.

Welcome if anyone has idea for this.

> @Leo, what are your thoughts on this? Perhaps adding a warning message
> to tell the user to please enable context packets, otherwise the results
> will have workload-dependant inaccuracies, could be a good enough
> compromise?

Yeah, this is exactly what I think.  It's good to give a warning so
users have knowledge for the potential inaccuracies.

Thanks,
Leo
