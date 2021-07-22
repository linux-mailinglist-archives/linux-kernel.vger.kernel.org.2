Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56A013D2C3D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 21:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbhGVSU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 14:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhGVSUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 14:20:54 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE51C061575
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 12:01:29 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id p67so7708028oig.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 12:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=7Ps4RwIG6XxXEH9dDOqdo2BIvmsObr7mTJxhT6gePXI=;
        b=gNpk0Cpx9lWZ2uCwsB/kcTfPh+1K9iB+EDMv+ITNQxIi0uF+cfnykM1D7qwr+sXIu1
         C4UsfhxUoxPtHzoauLJAMCXX5ORhEV6TfPvly9wQSKI6Ndm+5GGQcZeJqoNU1YhHBqzd
         3HUMA5UwuNAAXpkwhE+tCQ2ifijzqZJukQM8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=7Ps4RwIG6XxXEH9dDOqdo2BIvmsObr7mTJxhT6gePXI=;
        b=uZQWtcDQ2zlyAXniS+rFaLJ/ODzXAcjDhLP+pEn7eaaSF6N5NJHLdSBMX7JlPg4tm2
         2c5ceH1AMqn5AHBgQb6Grc4zldKIHPLsisLyZ9Bh6/6xIEE5B6nYZk1d1v044qZ9w4KB
         tRmHOgYhq71KAoiHMyCn2OOkKmKKy/+i3EIT6Ee2XfpbMfPv0MtnWUbH7UoKYAz2rcDX
         pF7Bn10hWlLbjt+h5CI2v5PmPAx5W1a7QXeoMUASHevRRkF2PEUjf3SGrvzA7+8KAD6d
         RhLTrK8kUlEgW6zuEbXWA8sGcIYv0fz5i+zccpxzjG3JiMvKQyV9tBmpHSbCqdKxTRF5
         YKGQ==
X-Gm-Message-State: AOAM532dGi1K//0u2/AwgIad7IpEUkWfXCN2stPS0q5+xlzh0OcmdjFu
        DxCzbM44UrrdXAILDUGx7M7ZI/ZdWM23OrHCaYoDlg==
X-Google-Smtp-Source: ABdhPJxQNi5FQCMbhTIZY1DogS2Ny4lCD+0Ic7kNij6RwwSTL/wAv3FKZBJNJ150MFs4NFiNsZf52qF6aTUeZdpMpkM=
X-Received: by 2002:a05:6808:a83:: with SMTP id q3mr6706715oij.125.1626980488491;
 Thu, 22 Jul 2021 12:01:28 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Jul 2021 19:01:27 +0000
MIME-Version: 1.0
In-Reply-To: <1626191647-13901-2-git-send-email-khsieh@codeaurora.org>
References: <1626191647-13901-1-git-send-email-khsieh@codeaurora.org> <1626191647-13901-2-git-send-email-khsieh@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 22 Jul 2021 19:01:27 +0000
Message-ID: <CAE-0n52F2bVLS8xnTefQ+3cEmcXVo7p=BPOBmky3NJ0=8oMmMg@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] drm/msm/dp: use dp_ctrl_off_link_stream during PHY
 compliance test run
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

Quoting Kuogee Hsieh (2021-07-13 08:54:01)
> DP cable should always connect to DPU during the entire PHY compliance
> testing run. Since DP PHY compliance test is executed at irq_hpd event
> context, dp_ctrl_off_link_stream() should be used instead of dp_ctrl_off().
> dp_ctrl_off() is used for unplug event which is triggered when DP cable is
> dis connected.
>
> Changes in V2:
> -- add fixes statement
>
> Fixes: f21c8a276c2d ("drm/msm/dp: handle irq_hpd with sink_count = 0 correctly")
>
> Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
