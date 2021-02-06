Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2BCF311935
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 04:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbhBFC6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 21:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbhBFCdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:33:23 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24ED0C08ED3E
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 15:21:07 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id l11so4326716qvt.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 15:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SkxWmY1OEi5ew/OSKLvpq24apidSW6DwKqLmpKsAI24=;
        b=dhJm5DFgG5FfOYeun7i2ErLsVXGm89DNuESD4ai0pZA9JRMXOL49fcDBKB7extQ27X
         Tu9PDANUQC4qGLS7Z7bZB6dQ1IOZRIUKeugve68PY0ozncrU6jqeTYyZ7BqteTcuQOpW
         8nu7d+SvxvYW9YIgUXskMc9cXCKatE1mnSXJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SkxWmY1OEi5ew/OSKLvpq24apidSW6DwKqLmpKsAI24=;
        b=WmqD+G2s3ypk6rjt4J1wU0ANxaRNm/3js7t5jkkMOJYoszP0W+GUgNBBP7GDkxv20n
         uXehPJu+8he2DMBujdIlkZIsg1XPdE7xW30cby6UXIQphmEPy9g0DWATADRV2oT6auNN
         6NmLpQkGuN3eqBafTWKRJdUaxeKLQp0nAp+z73txQf6ugCTH2WHPaIHk8IrTZ4+SmMgb
         DDIKUJEdv9NtMY4G6IWqq44EX2C/bFIR035CliP3kvUzzAH0maAQ0Y5qDmWk9AmN5VSs
         eZBZvxYUni45HkHAqfpF5oXWBeexAh3o4t4xoYW8g1aoyZs+eN/zW7zd2n+u/g5NOA1L
         VzOQ==
X-Gm-Message-State: AOAM533QNoiKhFIbGPYIhxQn5s8nLENfEPay0S5bNVs0I1DpqRrvty3W
        AmPeMhiY1sOLpxekAbzIZTEgXmoFvsl4ng==
X-Google-Smtp-Source: ABdhPJzNqX4YgqmVY5nxqHe09gF0W7e/3Job0OYtIbGGHdsHw42lCB/suwTCjrJSpGUboKAsSTApMg==
X-Received: by 2002:a05:6214:592:: with SMTP id bx18mr6750081qvb.32.1612567265954;
        Fri, 05 Feb 2021 15:21:05 -0800 (PST)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id h22sm9082889qth.55.2021.02.05.15.21.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Feb 2021 15:21:05 -0800 (PST)
Received: by mail-yb1-f172.google.com with SMTP id m76so8413010ybf.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 15:21:04 -0800 (PST)
X-Received: by 2002:a25:b048:: with SMTP id e8mr10485056ybj.0.1612567264272;
 Fri, 05 Feb 2021 15:21:04 -0800 (PST)
MIME-Version: 1.0
References: <20210202194752.247301-1-swboyd@chromium.org>
In-Reply-To: <20210202194752.247301-1-swboyd@chromium.org>
From:   Fritz Koenig <frkoenig@chromium.org>
Date:   Fri, 5 Feb 2021 15:20:53 -0800
X-Gmail-Original-Message-ID: <CAMfZQbyM-3mMchUgFZgiX48x7WG=BG=dZ6aBwAyu-K_y05=qkw@mail.gmail.com>
Message-ID: <CAMfZQbyM-3mMchUgFZgiX48x7WG=BG=dZ6aBwAyu-K_y05=qkw@mail.gmail.com>
Subject: Re: [PATCH -next] media: venus: Include io.h for memremap()
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Dikshita Agarwal <dikshita@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 2, 2021 at 11:51 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> This file uses memremap() now, so we should include io.h instead of
> relying on any sort of implicit include elsewhere.
>
> Cc: Dikshita Agarwal <dikshita@codeaurora.org>
> Fixes: 0ca0ca980505 ("media: venus: core: add support to dump FW region")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/media/platform/qcom/venus/core.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> index 1471c7f9c89d..915b3ed8ed64 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c
> @@ -5,6 +5,7 @@
>   */
>  #include <linux/init.h>
>  #include <linux/interconnect.h>
> +#include <linux/io.h>
>  #include <linux/ioctl.h>
>  #include <linux/delay.h>
>  #include <linux/devcoredump.h>
>
> base-commit: 0ca0ca9805055bb0efc16890f9d6433c65bd07cc
> --
> https://chromeos.dev

Reviewed-by: Fritz Koenig <frkoenig@chromium.org>
