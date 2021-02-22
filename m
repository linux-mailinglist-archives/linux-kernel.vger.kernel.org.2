Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D48B73220C3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 21:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbhBVUWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 15:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbhBVUWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 15:22:51 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89299C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 12:22:10 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id t23so7234531vsk.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 12:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=na2/RnRgnH/8w2EWhU1MCTH0hcdu6Lj44empnumnDy4=;
        b=Y5bCllchHHbP8XBCtGC46iSxTXUj3JkmfFo1TORkiyAIROLZ7UB51MkUUfXoyqLfc5
         dQ4ChFamfDNB9SUiwQi4k3N/CEIPf5ryloDp6GwHQ2kwl/iy7hdcZeEZNHCQ5fibbKKf
         Iy58IGl2dVvuYfrd1ISKuhPSzulYZDYDJtCIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=na2/RnRgnH/8w2EWhU1MCTH0hcdu6Lj44empnumnDy4=;
        b=Jw6AAkzt6uZYiFeE0Mko6E5Gor+/xOmEWcrr+hs4Z7unBQ8lOIgnA0hgff9VOtneNq
         q6kQONe2dv3FQqF32ieS+9ZAMRacaBybAcnCWwD04Rvb6UBkgMSz1KNTon3QaON5ZANl
         2eseCfFq6Khe53rOVh5D9XlLDKm4boM2Qb/Dlgl2DvvHA4gGHZQSOFXE4aY9N9n2nG0d
         BY5dlXNEFF1feb+uQT+J2nDw3ju2vzzyRBH55AhLapllYgTmf/XM0RfO+Ql4x8T9sYfV
         xmj4DI3QDJREoUehMiumnrJHcVKEFearnsnbUODI09Tk/898qD8/2NDSFZZbOGdHtosw
         vF9w==
X-Gm-Message-State: AOAM532fJMmzuu3K9t5Y0BdfGzN72zNKkzRJ1geegjSuhHcH+W7QfXNU
        dTQzkj3h/iNvxbQomx/aVu7nvuZ2m7coCA==
X-Google-Smtp-Source: ABdhPJzv6i8otzX7FDlC69j4xjr1hmJyYCW83FPngF8V2K+6SCYtVVcYE/mW5zh/hr7oYbm4qPOOmw==
X-Received: by 2002:a67:fa13:: with SMTP id i19mr5091833vsq.24.1614025329534;
        Mon, 22 Feb 2021 12:22:09 -0800 (PST)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id e13sm1778400vsp.7.2021.02.22.12.22.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Feb 2021 12:22:09 -0800 (PST)
Received: by mail-ua1-f51.google.com with SMTP id r19so4487108uak.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 12:22:09 -0800 (PST)
X-Received: by 2002:a25:aa43:: with SMTP id s61mr37800696ybi.32.1614024875145;
 Mon, 22 Feb 2021 12:14:35 -0800 (PST)
MIME-Version: 1.0
References: <cover.1611909025.git.saiprakash.ranjan@codeaurora.org> <5d063d6035ff079b10e34cee110a26b856957ebe.1611909025.git.saiprakash.ranjan@codeaurora.org>
In-Reply-To: <5d063d6035ff079b10e34cee110a26b856957ebe.1611909025.git.saiprakash.ranjan@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 22 Feb 2021 12:14:23 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WUxPrFYGWbTAUYMC1nuPSHT3fk=fcE-fGVveHpr1KPhQ@mail.gmail.com>
Message-ID: <CAD=FV=WUxPrFYGWbTAUYMC1nuPSHT3fk=fcE-fGVveHpr1KPhQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] coresight: etm4x: Add support to exclude kernel mode tracing
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
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

On Fri, Jan 29, 2021 at 11:08 AM Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> @@ -1202,6 +1207,13 @@ void etm4_config_trace_mode(struct etmv4_config *config)
>         /* excluding kernel AND user space doesn't make sense */
>         WARN_ON_ONCE(mode == (ETM_MODE_EXCL_KERN | ETM_MODE_EXCL_USER));
>
> +       if (!(mode & ETM_MODE_EXCL_KERN) && IS_ENABLED(CONFIG_EXCLUDE_KERNEL_HW_ITRACE)) {
> +               dev_err(&drvdata->csdev->dev,
> +                       "Kernel mode tracing is not allowed, check your kernel config\n");
> +               config->mode |= ETM_MODE_EXCL_KERN;
> +               return;

So I'm not an expert on this code, but the above looks suspicious to
me.  Specifically you are still modifying "config->mode" even though
printing an "error" (dev_err, not dev_warn) and then skipping the rest
of this function.  Since you're skipping the rest of this function
you're not applying the access, right?  Naively I'd have expected one
of these:

1. Maybe the "dev_err" should be a "dev_warn" and then you shouldn't
"return".  In this case you're just implicitly adding
"ETM_MODE_EXCL_KERN" (and shouting) but then making things work.  Of
course, then what happens if the user already specified
"ETM_MODE_EXCL_USER" too?  As per the comment above that "doesn't make
sense".  ...so maybe the code wouldn't behave properly...

2. Maybe you should be modifying this function to return an error code.

3. Maybe you should just be updating the one caller of this function
to error check this right at the beginning of the function and then
fail the sysfs write if the user did the wrong thing.  Then in
etm4_config_trace_mode you could just have a WARN_ON_ONCE if the
kernel wasn't excluded...

-Doug
