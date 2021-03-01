Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6CD32A02A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575429AbhCBD4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240254AbhCAWp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 17:45:58 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D58C061794
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 14:44:05 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id n4so6692927qvl.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 14:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AzzIj5aXFsgrkphFlIHeCI3vQXWdAnZoI6CShbhF4Vo=;
        b=Itin81SJQEhNJ7dXF6KO+tiNUxKJEzvX+O6McEL/dyKDNhpHQ/fuA1LkfIefVMVNi/
         ODqe3iKylQgrFGzuM2rvf+jtYzStxuQnaYL1ZOe8sGAwLG9ePX7yzwlNEndT1XwP/eyL
         cRIAVI6Ni4Ot21KmYjvQc/1L51r6WBjHCjgfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AzzIj5aXFsgrkphFlIHeCI3vQXWdAnZoI6CShbhF4Vo=;
        b=eHY8zdPIASbCwRGSGcfXS7Jz42IBxk8QPorIjBf+TPt/kjdN6p2I+VlgKFUPJg7g2y
         9ZQYo9XNeXhmMAoVckVwQuw0YEcRbEszgVqMQSiqad+N5TJ5MSzIvMMXoqErr63RsNg2
         Af+qQOdDCpi3fOq3U5DFcRgW2UD6xfHgAHQqfanPrNr0dpjQi1213lrSWt9xHBvJhSzK
         BA9/BppO0yEbfg1rlS5/w/oC/o9WlEcjb6EqW0l5MwmljTzAMXQ7j1basKy2hZq1DHxm
         /FKrpb6BcmrGY23/Wq9PNOM4QyHF+bF5+b0d2jol6r66FBxEsw93HbJilhv5EKxL+pGq
         Aigw==
X-Gm-Message-State: AOAM530D+q9tD8g6+f489LSPC91Q1daFA3+DSLqt/AKKdzeK49/5KXIp
        KWvwXTyT7oL9hTRmzkfqoCPDhEVcwRAvNA==
X-Google-Smtp-Source: ABdhPJwhFKfErV0DxZRfjYE0BIzwIZaBASJvWsEmvg0rZ4W7tigEqcx7PZBhaOcg4ZhZbyH1RcGd0w==
X-Received: by 2002:a0c:90ae:: with SMTP id p43mr1082900qvp.47.1614638644982;
        Mon, 01 Mar 2021 14:44:04 -0800 (PST)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id v2sm348449qkp.119.2021.03.01.14.44.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Mar 2021 14:44:04 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id x19so18702125ybe.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 14:44:03 -0800 (PST)
X-Received: by 2002:a25:cf88:: with SMTP id f130mr26716305ybg.476.1614638643440;
 Mon, 01 Mar 2021 14:44:03 -0800 (PST)
MIME-Version: 1.0
References: <cover.1614624041.git.saiprakash.ranjan@codeaurora.org> <0b165b2608eed1a61240539f4b812bd80b6ad1bd.1614624041.git.saiprakash.ranjan@codeaurora.org>
In-Reply-To: <0b165b2608eed1a61240539f4b812bd80b6ad1bd.1614624041.git.saiprakash.ranjan@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 1 Mar 2021 14:43:52 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VJ-+c-8Bi+=YeTshgOBC64rzM4T-40qtybw7qZtt0vhA@mail.gmail.com>
Message-ID: <CAD=FV=VJ-+c-8Bi+=YeTshgOBC64rzM4T-40qtybw7qZtt0vhA@mail.gmail.com>
Subject: Re: [PATCHv2 4/4] coresight: etm3x: Add support to exclude kernel
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
> kernel mode tracing, but there is an additional interface
> via sysfs for ETMs which also needs to be handled to exclude kernel
> mode tracing. So we use this same generic kernel config to handle
> the sysfs mode of tracing. This config is disabled by default and
> would not affect the current configuration which has both kernel and
> userspace tracing enabled by default.
>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>  drivers/hwtracing/coresight/coresight-etm3x-core.c  | 3 +++
>  drivers/hwtracing/coresight/coresight-etm3x-sysfs.c | 6 ++++++
>  2 files changed, 9 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>


> diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> index e8c7649f123e..f522fc2e01b3 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> @@ -116,6 +116,12 @@ static ssize_t mode_store(struct device *dev,
>         if (ret)
>                 return ret;
>
> +       if (IS_ENABLED(CONFIG_EXCLUDE_KERNEL_PMU_TRACE) && (!(val & ETM_MODE_EXCL_KERN))) {
> +               dev_warn(dev,
> +                       "Kernel mode tracing is not allowed, check your kernel config\n");

Same nit as in patch #3 that the above string should be indented by 1
more space.
