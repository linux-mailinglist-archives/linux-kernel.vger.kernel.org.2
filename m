Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEDC37251F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 06:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbhEDEdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 00:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbhEDEde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 00:33:34 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC979C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 21:32:39 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id d25so7611670oij.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 21:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=a37uZcs6HgM1/vP3znI4pHBE2+32UeBTKsWjif6oY20=;
        b=bMJ1UxfO8SLLcF5VTUyHFMK6yyvLdYtQ0+rOu6/p/CMzJ3IUKOip7iTYuaSfoB9zTt
         Le4Vxr9JFqv/14dflPJkUPSE3NC4BwMvFEMvRrOOC5Aiid0aUh0DhEOQquSbuD0SELUz
         J+EjSurLkZGwqtJHC/vk9B7NvTv13FibmmtdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=a37uZcs6HgM1/vP3znI4pHBE2+32UeBTKsWjif6oY20=;
        b=WBgvM9iw1vrXGlYc4JsoK80kmEdYKGdA5gwvCqfq7sMtWG91daL23kEq2PNCzFbHqq
         F9PaPWeAXR2nlwp3EuPuqexhsmfjnebaofmEIWuG9T/oMzDStP94CXYJ/qgTf2H3pFJ7
         x5cCQz1zKh0llYZ/Q3dfd7iUQWlMTvfRZFMPtvD4ZyBbH5GnU7FI5KqMe4xkQPSO3gci
         9jY3APinRIb55y+4epH2JWHyS6abnj++KSFXEX5QMhdWmyjCNrbVZw2tNkB8bTbxGdfc
         9FjvL9H3nqW34eNjJ7xXlPUq7A0C3rxy7ve3jb1/PJcpnuqvgCE6nTbSKYMPKaCbu2II
         WdPA==
X-Gm-Message-State: AOAM532+WHTmCN9IV9WF2cRzBNPtBazZnA5Ibx9sA69bx64G+wYhSW2Y
        6bf1W+9IqyYcodaEKq5fEwp6tDKB9ONm7iEQXUypWg==
X-Google-Smtp-Source: ABdhPJwxC4sqafnYqb5HJOdhvJmLXHvqL+OU/If/hOekFCKccr6eGMJfx7S38QhGYX+BQMD+ABjT7LsntzFbiFW0+Kc=
X-Received: by 2002:aca:2311:: with SMTP id e17mr4215692oie.160.1620102759239;
 Mon, 03 May 2021 21:32:39 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 May 2021 21:32:38 -0700
MIME-Version: 1.0
In-Reply-To: <1619048258-8717-3-git-send-email-khsieh@codeaurora.org>
References: <1619048258-8717-1-git-send-email-khsieh@codeaurora.org> <1619048258-8717-3-git-send-email-khsieh@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 3 May 2021 21:32:38 -0700
Message-ID: <CAE-0n53Qb6+Epzf=1MfbqphApos+bMpi+OSDYfdVXPbyfMCMQg@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] drm/msm/dp: initialize audio_comp when audio starts
To:     Kuogee Hsieh <khsieh@codeaurora.org>, robdclark@gmail.com,
        sean@poorly.run
Cc:     abhinavk@codeaurora.org, aravindh@codeaurora.org, airlied@linux.ie,
        daniel@ffwll.ch, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2021-04-21 16:37:36)
> Initialize audio_comp when audio starts and wait for audio_comp at
> dp_display_disable(). This will take care of both dongle unplugged
> and display off (suspend) cases.
>
> Changes in v2:
> -- add dp_display_signal_audio_start()
>
> Changes in v3:
> -- restore dp_display_handle_plugged_change() at dp_hpd_unplug_handle().
>
> Changes in v4:
> -- none
>
> Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Tested-by: Stephen Boyd <swboyd@chromium.org>
Fixes: c703d5789590 ("drm/msm/dp: trigger unplug event in
msm_dp_display_disable")
