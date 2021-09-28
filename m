Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7D441B88D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 22:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242815AbhI1UoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 16:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242226AbhI1UoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 16:44:16 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7570FC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 13:42:36 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 97-20020a9d006a000000b00545420bff9eso75166ota.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 13:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=uegvCqgF33M3moNAXxbTAqPKWgE2zUFv3rJPDnCK318=;
        b=bTGLeyAqVm4yvVybxFMvfr82sU4tDikUIegRQQB2zrmSWA2/zpvsM79ITuVnhLIS3y
         cy0ov0MHqaZXUa48g1wwmcKzX/Ym9dC6tBedVGhUrduILDfeVkl3Anc9L3hLXRQrT2FW
         X0cQtuXqNiJzsuCZRMczREtR8wOuChTM/babo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=uegvCqgF33M3moNAXxbTAqPKWgE2zUFv3rJPDnCK318=;
        b=qCQ8OGYM+Tt0Z0i108UUdwBasT8OyEkjdQ91QswbKwsZ9lkPTFUCR9olSY3+1EJQMR
         GUmriCz/HLVlPtJrqmlQGE+FAyR1EZNoL3Jcem8LcFDElWjbCtfGnicEPTa8QLyYsMBj
         /yUe57PFX2pUWAv/60jvjlnWn/W2z7kmmAn26vYxidwAAyKgioIv6nCvWExM+hhRXn/w
         xLw1tgs79tLn+jsRpIflcaZcV/Vw5YkmfLg8/+K+KYI+scvNa4yGC74GVh0+8cCX8Lgy
         vCuol90TfIuHj+4ADdlgqjjCL9xQwcg6EE6cdMmacZT+WtH/frhzgKBcv1FC8CNs4y/7
         Og0Q==
X-Gm-Message-State: AOAM533u2RdltRqkUzGfcE9Rn+La0AaEjGzBJCvVc7CsF2nMnIUQk/Hi
        EwjJwLFr55eAgnTBUkodtMc9rgJDnX1o7R1usHCzhA==
X-Google-Smtp-Source: ABdhPJzbrReCsPak9qtP+xmmFsOIy27/pz5auaxnHNLOf59z46/3FuUj4GNV6gNgUU6sLbKtpPIPTPQA/PZ66xgDUdU=
X-Received: by 2002:a05:6830:358:: with SMTP id h24mr6640507ote.159.1632861755401;
 Tue, 28 Sep 2021 13:42:35 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Sep 2021 13:42:34 -0700
MIME-Version: 1.0
In-Reply-To: <1632845472-29276-1-git-send-email-khsieh@codeaurora.org>
References: <1632845472-29276-1-git-send-email-khsieh@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 28 Sep 2021 13:42:34 -0700
Message-ID: <CAE-0n53qPN_ujrs8ABnvdUWgg7mKvcgZBaNq3Os17i7iPKnoTA@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dp: only signal audio when disconnected detected
 at dp_pm_resume
To:     Kuogee Hsieh <khsieh@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, robdclark@gmail.com, sean@poorly.run,
        vkoul@kernel.org
Cc:     abhinavk@codeaurora.org, aravindh@codeaurora.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2021-09-28 09:11:12)
> Only signal audio when disconnected detected at dp_pm_resume since
> connected status will be signaled to audio at next plugin handler.

Please add more details. This says what the patch does but it would be
better if it included why it is important. Does it fix something?
There's a fixes tag so it must fix something. Is it bad to signal audio
plug change on resume when it hasn't actually changed from last time?
Why is that bad? What if the cable is unplugged and then plugged in
before resume? Does audio still get signalled in that case?

>
> Fixes: 078867ce04ed ("drm/msm/dp: signal audio plugged change at dp_pm_resume")
> Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 0e543a03..6f13008 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -1356,14 +1356,14 @@ static int dp_pm_resume(struct device *dev)
>          * can not declared display is connected unless
>          * HDMI cable is plugged in and sink_count of
>          * dongle become 1
> +        * also only signal audio when disconnected
>          */
> -       if (dp->link->sink_count)
> +       if (dp->link->sink_count) {
>                 dp->dp_display.is_connected = true;
> -       else
> +       } else {
>                 dp->dp_display.is_connected = false;
> -
> -       dp_display_handle_plugged_change(g_dp_display,
> -                               dp->dp_display.is_connected);
> +               dp_display_handle_plugged_change(g_dp_display, false);
> +       }
