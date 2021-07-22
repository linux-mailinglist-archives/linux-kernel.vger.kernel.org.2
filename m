Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95B473D2C57
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 21:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhGVSY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 14:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbhGVSY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 14:24:58 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E325C061757
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 12:05:32 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id s2-20020a0568301e02b02904ce2c1a843eso6246346otr.13
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 12:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=congdFIKNx3UQvjcKCH7cpv7zvqp5GO1L/NygEo3sXY=;
        b=dDIPDFkyDDHfqVGTpIk+wx1GBgHwuS+5k3bX78JBMROdG0Il9Fa6gFRE3N4NL2Qk0f
         SqQZg2RIPA064hM8VFnMY2q+vHBzUFSnc7iN5K2p7p4BJ7A/sYHwrrcq3pXBnJC7CkMX
         6ETr8WW+bTfkdyUukPtX19G0Yed7uhKTttRjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=congdFIKNx3UQvjcKCH7cpv7zvqp5GO1L/NygEo3sXY=;
        b=ilsS0aF7diMkDpVw//biQ0AK+Vxy1vk3T6QBT2oAz+AsU/k/I99FbgOKn8zvSycFAX
         orYfrY3zCD5bC/1uPf45rgz+aLsPotg7sFs58DS/U4Iss6JpyYUi9yOUm05ZgWIemVpp
         5Zfi7/3PjexvXTy/hDXIO2NHx4OUvfltwPFqFk9b069pEWxIKMmxAradYVFyT51POHpH
         1iQwDXnFBK1xOU6dGDy4R09+8fNkfW12B6KZb/t7r6iBbYdi3F4RlMTbUVMevo+Vq5u2
         RdKmViieYTCoEPv4iST074aHU42pk5euZOqPG7/lA6SzUheT5NKaJJJwlm9myMLn4Plm
         4SlQ==
X-Gm-Message-State: AOAM530QpZe3hbqvby2jyrKH0P87PiDc9LjSwpYipYAdt2ES5g78k1U2
        fwssrjt8LzCHwLWncqmlpuxk+i6Q64lv4wwpqTCkKQ==
X-Google-Smtp-Source: ABdhPJxszP1Nvb9QVLAphQ4FMRQGZNgHTiAOHsXtE6VBCSK4Mkx8qQEaF06I/qJbcI+d9b6gULejIcgtbhtlsXTT8NA=
X-Received: by 2002:a9d:8c7:: with SMTP id 65mr842433otf.25.1626980731332;
 Thu, 22 Jul 2021 12:05:31 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Jul 2021 19:05:30 +0000
MIME-Version: 1.0
In-Reply-To: <1626191647-13901-3-git-send-email-khsieh@codeaurora.org>
References: <1626191647-13901-1-git-send-email-khsieh@codeaurora.org> <1626191647-13901-3-git-send-email-khsieh@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 22 Jul 2021 19:05:30 +0000
Message-ID: <CAE-0n52JWbqwZtSCcLyzpsaFyd8mRLiXxLO-9YDk5xMbj_uQiw@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] drm/msm/dp: reduce link rate if failed at link
 training 1
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

Quoting Kuogee Hsieh (2021-07-13 08:54:02)
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> index 27fb0f0..92cf331 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -1634,6 +1617,24 @@ void dp_ctrl_handle_sink_request(struct dp_ctrl *dp_ctrl)
>         }
>  }
>
> +static bool dp_ctrl_clock_recovery_any_ok(
> +                       const u8 link_status[DP_LINK_STATUS_SIZE],
> +                       int lane_count)
> +{
> +       int lane_cnt;
> +
> +       /*
> +        * only interested in the lane number after reduced
> +        * lane_cnt = 4, then only interested in 2 lanes
> +        * lane_cnt = 2, then only interested in 1 lane
> +        */
> +       lane_cnt = lane_count >> 1;
> +       if (lane_cnt == 0)
> +               return false;
> +
> +       return drm_dp_clock_recovery_ok(link_status, lane_count);

This doesn't work? Because drm_dp_clock_recovery_ok() requires every
lane to be OK whereas this function wants any lane to be OK? It may make
sense to have drm_dp_clock_recovery_ok() return false if lane_count == 0
too.

> +}
> +
>  int dp_ctrl_on_link(struct dp_ctrl *dp_ctrl)
>  {
>         int rc = 0;
