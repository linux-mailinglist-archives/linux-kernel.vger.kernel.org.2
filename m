Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67AE03EABD3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 22:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237501AbhHLUeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 16:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbhHLUeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 16:34:06 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168C1C0613D9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 13:33:41 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id q16so7834787ioj.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 13:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A9UDRRG4q1idI206MNqvq77jJ/SQ1JDQ5Hwl3h3QBmc=;
        b=PG349MzRnm8flbAtjVx9mm08lRYtiHgnYq6jP5dFDvUEFvpq5tgupPqfvJPHXFS1rK
         zUx/LvMTF7WOkbgJwGpt5o/fiTDkHR0ShtOTm0y1X0eB5SLAm+EYKKpiHave3awT1bJV
         3yMoZ4MAtQtJdKuMxLsQbJLX8dey4A2oLUkM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A9UDRRG4q1idI206MNqvq77jJ/SQ1JDQ5Hwl3h3QBmc=;
        b=Mvey89GG5Py22Ilvk/sJsDu0Tng+NFLPBvly5YUEGg3rF5miv+8ApSgu3ebFCuJvbF
         3/YEaRDpy3hijd8/V2NOXCFIZaw2NesKf5Gq9YKX8CMKPxm8cfkdKl3nDiXmk2zjnmjW
         wHQqKnYUrO9Q210cznbFFUb6W941+kttvvW2o+zcX7E8U+G5zLpZOrVa3p7dZsqQLRUm
         B/1t3PC4YGrazhRwzpeDUF/cHPAXblTgnVk983tdAs9QA42/sHgCnt0HvFDFF4RkQ7mq
         d5Jp1HhCeDwFj/wFhjz9+ZmVI3lVeZjcYuZTKHQMVSwTHF+YWBjeE3Gl8jGVh8XWxSt0
         5bNg==
X-Gm-Message-State: AOAM530vpABCUdeD1O8ErftZYUf+5JMOQzF6wnyO31EgbhQvZhXpON+5
        Ryib9OPHdA2agHQuruHYEwyrbk0Zy/zGqg==
X-Google-Smtp-Source: ABdhPJw6g9dIjzRLTmdMgJ25XLokf61CoiQJR5Cfx/2AoogDQG5WSbk4m/TBjqda4Yq5qtGJWzElQQ==
X-Received: by 2002:a6b:f416:: with SMTP id i22mr4366610iog.162.1628800420338;
        Thu, 12 Aug 2021 13:33:40 -0700 (PDT)
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com. [209.85.166.171])
        by smtp.gmail.com with ESMTPSA id x15sm2110695ilp.23.2021.08.12.13.33.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 13:33:39 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id j18so8404337ile.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 13:33:39 -0700 (PDT)
X-Received: by 2002:a92:d304:: with SMTP id x4mr324759ila.82.1628800419387;
 Thu, 12 Aug 2021 13:33:39 -0700 (PDT)
MIME-Version: 1.0
References: <1628777955-7198-1-git-send-email-tdas@codeaurora.org>
In-Reply-To: <1628777955-7198-1-git-send-email-tdas@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 12 Aug 2021 13:33:26 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UF1MMKg9Y0HD3xpZ36BVZyuzr3xkwXzeSz__T1XD1r=w@mail.gmail.com>
Message-ID: <CAD=FV=UF1MMKg9Y0HD3xpZ36BVZyuzr3xkwXzeSz__T1XD1r=w@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: qcom-hw: Set dvfs_possible_from_any_cpu
 cpufreq driver flag
To:     Taniya Das <tdas@codeaurora.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Aug 12, 2021 at 7:19 AM Taniya Das <tdas@codeaurora.org> wrote:
>
> As remote cpufreq updates are supported on QCOM platforms, set
> dvfs_possible_from_any_cpu cpufreq driver flag.
>
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>
> [v2]
>   * update the dvfs_possible_from_any_cpu always.
>
>  drivers/cpufreq/qcom-cpufreq-hw.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index f86859b..53d3898 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -223,6 +223,8 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
>
>         table[i].frequency = CPUFREQ_TABLE_END;
>         policy->freq_table = table;
> +       policy->dvfs_possible_from_any_cpu = true;
> +

Why is this in the qcom_cpufreq_hw_read_lut() function? Shouldn't it
be straight in qcom_cpufreq_hw_cpu_init()?

-Doug
