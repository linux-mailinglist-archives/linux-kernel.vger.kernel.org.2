Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71D0332A031
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575486AbhCBD4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344253AbhCAWwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 17:52:18 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DF0C061788
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 14:51:37 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id x62so5654132oix.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 14:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lod5AV9stobf9YNREve+YsqCj5E/GdBeQLdaIwH06w8=;
        b=J+1SzQlP7bzH6srtUJ5VsXzAJWbsJC91YMbGucsxFWtvOoqjiUQJuvFiOKPPGAFbZn
         uBGKb2TP1MBkakw/ZKMPRyJkNQwAYQHx5IaBzczl+N4CdBPVv2HgVh+WLOvUWGXMTwUQ
         7T997WUnCUbqgoyxLmeMmGEH//xMy3QoEfirU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lod5AV9stobf9YNREve+YsqCj5E/GdBeQLdaIwH06w8=;
        b=hzO0sjbgw+aMds3IZtuASNOluHBzlA7ZJ/pCuvapuEwgZKYa2XF50jdh7fIiA8XCNk
         Gkk6IyAoNUHoSe0njpI3zlpBZ0Av+DuvW/hqvfcWWR7m2KrAbTLJAyoeNzTbnup8HBvk
         t/0iYGeUXG8DOhkRZHo970HvskBTtfZTXEOuMLkCNkVZdDSF166CCCA6qLbi5lnKEwYD
         Kb2e43J+54vuHGeW+cUIksAlpHp+7uMLgU5UHFvRsOULt94pycFpRvJdZOGCdB32SvA/
         YgO6gvJSr1c54Nx5WrYv3PDEZZJAUDgE+ZyMJ4XOG94KjtRNIabwNDQSdf2X+1oWECzc
         ECNw==
X-Gm-Message-State: AOAM531fBuQ1A/iYJHRYKDliqx4tC4q7IsShKBZUQ03sqTCoMgzYqIjy
        aEnvc9zCHpfFJR1Ug6th3+uFF2L+ro69JQ==
X-Google-Smtp-Source: ABdhPJxR/N9QRFza/hE7ZgJAUMOrvTzQQbavv0bgqCHoNQuQSFz6foo9vvmH9vhN52UFYzGnIU46+g==
X-Received: by 2002:aca:5c07:: with SMTP id q7mr1030953oib.90.1614639097032;
        Mon, 01 Mar 2021 14:51:37 -0800 (PST)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com. [209.85.210.50])
        by smtp.gmail.com with ESMTPSA id h15sm4089595otq.13.2021.03.01.14.51.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Mar 2021 14:51:36 -0800 (PST)
Received: by mail-ot1-f50.google.com with SMTP id g8so14509914otk.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 14:51:36 -0800 (PST)
X-Received: by 2002:a25:ab54:: with SMTP id u78mr27378505ybi.276.1614638632804;
 Mon, 01 Mar 2021 14:43:52 -0800 (PST)
MIME-Version: 1.0
References: <cover.1614624041.git.saiprakash.ranjan@codeaurora.org> <defd34e2a8744fc93404abdaad2d429fa3f69850.1614624041.git.saiprakash.ranjan@codeaurora.org>
In-Reply-To: <defd34e2a8744fc93404abdaad2d429fa3f69850.1614624041.git.saiprakash.ranjan@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 1 Mar 2021 14:43:41 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XCi_+yW6DPeUYmtjMhn-qpjMiB0E4_Qkz6d_e6G-CoVA@mail.gmail.com>
Message-ID: <CAD=FV=XCi_+yW6DPeUYmtjMhn-qpjMiB0E4_Qkz6d_e6G-CoVA@mail.gmail.com>
Subject: Re: [PATCHv2 3/4] coresight: etm4x: Add support to exclude kernel
 mode tracing
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
> On production systems with ETMs enabled, it is preferred to exclude
> kernel mode(NS EL1) tracing for security concerns and support only
> userspace(NS EL0) tracing. Perf subsystem interface uses the newly
> introduced kernel config CONFIG_EXCLUDE_KERNEL_PMU_TRACE to exclude
> kernel mode tracing, but there is an additional interface via sysfs
> for ETMs which also needs to be handled to exclude kernel
> mode tracing. So we use this same generic kernel config to handle
> the sysfs mode of tracing. This config is disabled by default and
> would not affect the current configuration which has both kernel and
> userspace tracing enabled by default.
>
> Tested-by: Denis Nikitin <denik@chromium.org>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>  drivers/hwtracing/coresight/coresight-etm4x-core.c  | 6 +++++-
>  drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 6 ++++++
>  2 files changed, 11 insertions(+), 1 deletion(-)

Not that I'm an expert in the perf subsystem, but the concern I had
with v1 is now addressed.  FWIW this seems fine to me now.

Reviewed-by: Douglas Anderson <dianders@chromium.org>


> --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> @@ -296,6 +296,12 @@ static ssize_t mode_store(struct device *dev,
>         if (kstrtoul(buf, 16, &val))
>                 return -EINVAL;
>
> +       if (IS_ENABLED(CONFIG_EXCLUDE_KERNEL_PMU_TRACE) && (!(val & ETM_MODE_EXCL_KERN))) {
> +               dev_warn(dev,
> +                       "Kernel mode tracing is not allowed, check your kernel config\n");

slight nit that I think your string needs to be indented by 1 space.  ;-)
