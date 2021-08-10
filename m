Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04DAF3E857A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 23:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234964AbhHJVgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 17:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234925AbhHJVgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 17:36:19 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D361C06179F
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 14:35:55 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id r17-20020a0568302371b0290504f3f418fbso769738oth.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 14:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=+XhXVGH3fkIOnE1t2XNmliygvN33fb2RS+mFgm8hrtU=;
        b=nssXy17hVHdZO0veyfk+XdCrAZ190q+aijoQHy4Dd8jrwccS37npEBDWKfa3tVRsX/
         +Fl4rkROGtig5v474uHf01f0pMk20xiMuc0h1oIPnL+D2G1YT6fL3foT9JFhM9c//9dr
         RsidGeTpYH3eYySbmAdTb06F49h/EbOOXoBT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=+XhXVGH3fkIOnE1t2XNmliygvN33fb2RS+mFgm8hrtU=;
        b=fQqTxIfTNtm+cvgaDADopOc6V9m3BZz6wCin5ZLlwrHtRDC3jhdqchkJckxPvKAVnD
         +HzU5lR5GGlLfo7tqAZcrUZh5UhPw40AlhvuKkbK3uhyJoeORW/Wl3vHRN6KjcPDBj40
         dAW3v7o3/yjvUSDmJx/6zuXplOZ78+AsL9fq8lMJxCfb6ceU+unLMEEgwQe9z+G8FfyV
         qs+x2nVNc15OmcyoqqEnJUBhx8wFrq3MWMF7pfm5b1phtD1NHlmqxwPXoK1FMfOJKwVX
         D0sKK8H+weU+TuoMY5jg6k9uYZtWJy+JLnTQj2+tso5Q9fE5z9dP7966JaSLp4yPU4ZX
         ySHg==
X-Gm-Message-State: AOAM531azQA9QUwtKTEn1VnGyyRrw2mNmYcHDdT53kV1K/+/BhzdU8LU
        wD2Q3QZVKhXFfbVxnYDlruKxZATwarnn9kpXU1vKqA==
X-Google-Smtp-Source: ABdhPJyiH0XE2MMSHvDD3YnTgiPVuRbdk1llKiBAiTDs/gIGZngoYWW5dJsF6iglEkjwRPIOdlrPTB7kIDitYcTjbyY=
X-Received: by 2002:a05:6830:1490:: with SMTP id s16mr22748568otq.233.1628631355080;
 Tue, 10 Aug 2021 14:35:55 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 10 Aug 2021 14:35:54 -0700
MIME-Version: 1.0
In-Reply-To: <1628196295-7382-7-git-send-email-khsieh@codeaurora.org>
References: <1628196295-7382-1-git-send-email-khsieh@codeaurora.org> <1628196295-7382-7-git-send-email-khsieh@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 10 Aug 2021 14:35:54 -0700
Message-ID: <CAE-0n52n6ypCLrA3mWHekh9Caq8rT5ngV2X5MWdGYA8DJQb92g@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] drm/msm/dp: do not end dp link training until
 video is ready
To:     Kuogee Hsieh <khsieh@codeaurora.org>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run
Cc:     abhinavk@codeaurora.org, aravindh@codeaurora.org, airlied@linux.ie,
        daniel@ffwll.ch, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2021-08-05 13:44:55)
> Initialize both pre-emphasis and voltage swing level to 0 before
> start link training and do not end link training until video is
> ready to reduce the period between end of link training and video
> start to meet Link Layer CTS requirement.  Some dongle main link
> symbol may become unlocked again if host did not end link training
> soon enough after completion of link training 2. Host have to re
> train main link if loss of symbol locked detected before end link
> training so that the coming video stream can be transmitted to sink
> properly. This fixes Link Layer CTS cases 4.3.2.1, 4.3.2.2, 4.3.2.3
> and 4.3.2.4.
>
> Changes in v3:
> -- merge retrain link if loss of symbol locked happen into this patch
> -- replace dp_ctrl_loss_symbol_lock() with dp_ctrl_channel_eq_ok()
>
> Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
