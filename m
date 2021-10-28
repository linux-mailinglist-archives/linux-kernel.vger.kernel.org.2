Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C143143DB1C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 08:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbhJ1Gd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 02:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbhJ1Gdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 02:33:55 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17848C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 23:31:29 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id x27-20020a9d459b000000b0055303520cc4so7151886ote.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 23:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=fl3/6+D1WzrjlO9U2XlvyAbP1wGZPooZUWolFXNY6RE=;
        b=icJvMa5pUjALY+NkhGVS54Ds28x++ZE3VJJWfsC4PaJl0wk9D0YnQX8VgrkoN1N+jf
         2XmMVSkoHKJAQY1yroE0GbT2nKRKFPJJoOL7J1FiJwRoemobn38o4iTMCRgTpjbbNkoV
         wZ5HpRl/I3U6Mea/Wf46aCNQnb1zLIaYkJ0IQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=fl3/6+D1WzrjlO9U2XlvyAbP1wGZPooZUWolFXNY6RE=;
        b=ZxxRNloCBRFdq+E2Acflp0QIw04qKQ0amTIOYqHgyLOvkKd6dUmwulQJNHEavj53En
         AnY2cuPPA5WeEbeE5al+ivLzDXMomKy9S91L8lP4xdDh0CAyUXp69Fxauy4AbKCho3Oq
         iKnnM2MJIkAvqHc18XJKT38zkn3Shy7I6H4x6TTuZKXRN+aQcfNs9P9e+c3YXrA/W1+O
         kwazB/AMdC0x8LaN3zZ9E0bTeEV6V6LzVaU4sm6KoINkHEBhT62Ic9EyFGxtijdC2Z1+
         qYwAOgfis+JznU4zAsh9jhoCIocBrfLcvSXJD6sTlCFED7aOktdcyJQl7SxYFzGYbdKA
         cX8w==
X-Gm-Message-State: AOAM531mg+lz4IUksrp+3EKPMXBqY3qr9WVNZqZjDl/pGmGJObSMMa5T
        U9iH+zXozChqYdavFO9BXVcf/LRlPFHZMfyLP13+GQ==
X-Google-Smtp-Source: ABdhPJwOH+dMU3ZV+EAZWCrAfkMlWceuSfzj8nbggbBIE6vGZwr08wjI7kbJHzryENUczI1dk388o3ot156zGeQHIH4=
X-Received: by 2002:a9d:6e16:: with SMTP id e22mr1856094otr.77.1635402688480;
 Wed, 27 Oct 2021 23:31:28 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 27 Oct 2021 23:31:27 -0700
MIME-Version: 1.0
In-Reply-To: <1635386088-18089-4-git-send-email-quic_sbillaka@quicinc.com>
References: <1635386088-18089-1-git-send-email-quic_sbillaka@quicinc.com> <1635386088-18089-4-git-send-email-quic_sbillaka@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 27 Oct 2021 23:31:27 -0700
Message-ID: <CAE-0n52o0FtVhd_TPEf_NhpXwLErcYm9NX+dqW8RnwrYGrM6-Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] drm/dp: Add macro to check max_downspread capability
To:     Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     robdclark@gmail.com, seanpaul@chromium.org,
        kalyan_t@codeaurora.org, abhinavk@codeaurora.org,
        dianders@chromium.org, khsieh@codeaurora.org,
        mkrishn@codeaurora.org, sbillaka@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sankeerth Billakanti (2021-10-27 18:54:45)
> Add a macro to check for the max_downspread capability in
> drm_dp_helper.
>
> Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
> ---

Looks OK to me. One question below

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

>  include/drm/drm_dp_helper.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
> index afdf7f4..b39e7a0 100644
> --- a/include/drm/drm_dp_helper.h
> +++ b/include/drm/drm_dp_helper.h
> @@ -1784,6 +1784,12 @@ drm_dp_tps3_supported(const u8 dpcd[DP_RECEIVER_CAP_SIZE])
>  }
>
>  static inline bool
> +drm_dp_max_downspread(const u8 dpcd[DP_RECEIVER_CAP_SIZE])
> +{
> +       return dpcd[DP_MAX_DOWNSPREAD] & DP_MAX_DOWNSPREAD_0_5;

Does it need a dpcd[DP_DPCD_REV] >= 0x11 check? Reading the spec I think
the answer may be that we check for 1.1 and always return 1 if so just
to make sure devices don't break the spec and put a 0 here when they're
rev is >= v1.1?

> +}
> +
> +static inline bool
>  drm_dp_tps4_supported(const u8 dpcd[DP_RECEIVER_CAP_SIZE])
>  {
>         return dpcd[DP_DPCD_REV] >= 0x14 &&
