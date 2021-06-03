Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A54F399A74
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 08:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhFCGFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 02:05:53 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:38480 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbhFCGFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 02:05:52 -0400
Received: by mail-oi1-f182.google.com with SMTP id z3so5224214oib.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 23:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=W4MRGvvlAsIvztCMODsejOnW9x+vcPEBs+GlUbnr7QU=;
        b=kPUJ5NjxGkUGtAhRbO5ZjIIXgnTH7iqzJmf4glxC699yJkOagEj5NCwDVwwBa4Kcn5
         UZaVpRJ+dogRyu9PWzJ+xA6ZJcmzaSWPbARjEQ6ZmY+VwM0+UH4dQTSjqrps7gu6iDPe
         XmUjSru4mP+DCOXotRSPPv1R1WLyOW0IH/CI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=W4MRGvvlAsIvztCMODsejOnW9x+vcPEBs+GlUbnr7QU=;
        b=csrfPMLub8FhXKgDrNsk1aKgA+xu5IjVBXn6Sp7w+XJLo0HyG6ItUWzkK1itREe8pR
         fjgclB471QixQ5ARaqN+d3h7xEOMStakH8jrKjzgQ4xgugwN/yvb5Gm5FwYOhL9MZ38U
         NxjPIgwjHDPDdryfXuTtTZGr8+ZJvPMJUpbGgnLoZeHiorovD0Izegzd7pySQUj+PpNo
         oiDDuGsPQdd0DyrwM7cWjpDakM/ueLwmo902PIuUIo3nB1dBQB345dDUd8x1mUnTiImm
         nuK6PEOhosTf8byLvmz+JGJsgnJGPHcen8pzIro/FEQzLE8syZsvqSV8SzkDgijaeO/L
         XWEw==
X-Gm-Message-State: AOAM533DkAwPyiXdzUJS4m+IW219oc2WYNlroYYr9iqbQw4uqL+G1xsG
        dwJt0Iedwqn3nK2vznOEMCoxN5IPVQJDIgeHWeO+gQ==
X-Google-Smtp-Source: ABdhPJwbZadfDpzhFToZSrCDEjvue32gZ2YzP9LLNu6q7SP0cOQDP7qleH6aBFPvVofyULuDdYDDPf7Y1Yeb6ZUQdwE=
X-Received: by 2002:aca:654d:: with SMTP id j13mr6376997oiw.125.1622700188427;
 Wed, 02 Jun 2021 23:03:08 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 2 Jun 2021 23:03:07 -0700
MIME-Version: 1.0
In-Reply-To: <1622652185-7157-1-git-send-email-khsieh@codeaurora.org>
References: <1622652185-7157-1-git-send-email-khsieh@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 2 Jun 2021 23:03:07 -0700
Message-ID: <CAE-0n516E_x+h2BFze0mozjdpwqa3_kb10cKWdcFURXkNj8k6w@mail.gmail.com>
Subject: Re: [PATCH v4] drm/msm/dp: power off DP phy at suspend
To:     Kuogee Hsieh <khsieh@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, robdclark@gmail.com, sean@poorly.run,
        vkoul@kernel.org
Cc:     abhinavk@codeaurora.org, aravindh@codeaurora.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2021-06-02 09:43:05)
> Normal DP suspend operation contains two steps, display off followed
> by dp suspend, to complete system wide suspending cycle if display is
> up at that time. In this case, DP phy will be powered off at display
> off. However there is an exception case that depending on the timing
> of dongle plug in during system wide suspending, sometimes display off
> procedure may be skipped and dp suspend was called directly. In this
> case, dp phy is stay at powered on (phy->power_count = 1) so that at
> next resume dp driver crash at main link clock enable due to phy is
> not physically powered on. This patch will call dp_ctrl_off_link_stream()
> to tear down main link and power off phy at dp_pm_suspend() if main link
> had been brought up.
>
> Changes in V2:
> -- stashed changes into dp_ctrl.c
> -- add is_phy_on to monitor phy state
>
> Changes in V3:
> -- delete is_phy_on
> -- call dp_ctrl_off_link_stream() from dp_pm_suspend()
>
> Changes in V4:
> -- delete changes made at dp_power.c
> -- move main link status checking to dp_pm_suspend
>
> Fixes: 0114f31a2903 ("drm/msm/dp: handle irq_hpd with sink_count = 0 correctly)

This should be 8dbde399044b
