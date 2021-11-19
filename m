Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 130C145676B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 02:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbhKSBXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 20:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233985AbhKSBXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 20:23:19 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276F9C06173E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 17:20:18 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id bj13so18483722oib.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 17:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=+4u6zI2WbzNkx110yW93wXh++h279Kv8lQjw6fsVrvg=;
        b=cGZoDisejQaJ8p+P/87PSoJH1JRVUVt00xJ4d56gfBh0WO2C62Dnh4l0iGvqwXKYjn
         b8BRKi1vQXHXNYLWlfM6Fseenb6r8uKSHsw8dSav4HNu5dNVyNcxN43vt4rQVyirCleK
         QUcD2tndLp69InrIm4SXyHhZ49q2QhVqGBo88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=+4u6zI2WbzNkx110yW93wXh++h279Kv8lQjw6fsVrvg=;
        b=epmorCPshuntM1fmWuKPrP7OI9t/PWBGkI7u+maXKMN+gEDcxYAM0jkszWSLHWkTAr
         rvXC7AcM1iDsh67M2M+Cu41r9LqRPgVYpdpzi6bTKZ8rfwM0SjXhUFWnQUpgowqwNeWF
         XVpPf4glLvTjzpkOKuCFRqd19jieAtUI2+tyoU232CCt4uWKlBeA6m+S2S8zyFGv/4od
         XpFtSvb+VbBW2re0df1iuZHjgqZczrH3dS7MQ7z15P9N5T9qTxOLwZKD5Vlfj58gzTGN
         gHxGHBWSin9Q4mHtVF6KJbDj1IQ05bIK+3CZ0NOi0UjtfbJeTi6wYecpW82NuZW6NRz4
         cmvg==
X-Gm-Message-State: AOAM531Rt43pTE+4wMHbB18JaDjmv3mIivasZM4D2JQ+/TVhGjVqyb5V
        268rmVbJDojTgdaNU1Q5gtVOkIUk0YMcl0t8BWegYA==
X-Google-Smtp-Source: ABdhPJw/lFMRDpADbSuVq+e5zkxL2+/msM1iuh9pKofY63E+8BxMAfvDYsKcBUq8mQXD9V67bnHftwapPA2n0wvR65s=
X-Received: by 2002:a54:4506:: with SMTP id l6mr1436004oil.32.1637284817525;
 Thu, 18 Nov 2021 17:20:17 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 19 Nov 2021 02:20:17 +0100
MIME-Version: 1.0
In-Reply-To: <1636493893-7600-1-git-send-email-quic_khsieh@quicinc.com>
References: <1636493893-7600-1-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Fri, 19 Nov 2021 02:20:17 +0100
Message-ID: <CAE-0n505-VcS46WnVARsvuaizePP-3cYEw_rfipfq9Yj7AW=Ow@mail.gmail.com>
Subject: Re: [PATCH v4] drm/msm/dp: do not initialize phy until plugin
 interrupt received
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        dmitry.baryshkov@linaro.org, robdclark@gmail.com, sean@poorly.run,
        vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, aravindh@codeaurora.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kuogee Hsieh <khsieh@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2021-11-09 13:38:13)
> From: Kuogee Hsieh <khsieh@codeaurora.org>
>
> Current DP drivers have regulators, clocks, irq and phy are grouped
> together within a function and executed not in a symmetric manner.
> This increase difficulty of code maintenance and limited code scalability.
> This patch divided the driver life cycle of operation into four states,
> resume (including booting up), dongle plugin, dongle unplugged and suspend.
> Regulators, core clocks and irq are grouped together and enabled at resume
> (or booting up) so that the DP controller is armed and ready to receive HPD
> plugin interrupts. HPD plugin interrupt is generated when a dongle plugs
> into DUT (device under test). Once HPD plugin interrupt is received, DP
> controller will initialize phy so that dpcd read/write will function and
> following link training can be proceeded successfully. DP phy will be
> disabled after main link is teared down at end of unplugged HPD interrupt
> handle triggered by dongle unplugged out of DUT. Finally regulators, code
> clocks and irq are disabled at corresponding suspension.
>
> Changes in V2:
> -- removed unnecessary dp_ctrl NULL check
> -- removed unnecessary phy init_count and power_count DRM_DEBUG_DP logs
> -- remove flip parameter out of dp_ctrl_irq_enable()
> -- add fixes tag
>
> Changes in V3:
> -- call dp_display_host_phy_init() instead of dp_ctrl_phy_init() at
>         dp_display_host_init() for eDP
>
> Changes in V4:
> -- rewording commit text to match this commit changes
>
> Fixes: e91e3065a806 ("drm/msm/dp: Add DP compliance tests on Snapdragon Chipsets")
>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---

What commit is this patch based on?
