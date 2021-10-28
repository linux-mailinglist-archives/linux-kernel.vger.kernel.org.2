Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1692843DB4B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 08:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbhJ1Gkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 02:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhJ1Gkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 02:40:52 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00781C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 23:38:25 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id s23-20020a056830125700b00553e2ca2dccso2354757otp.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 23:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=Q0aPYShzUHQahtTa1rDM0UEGu5hh3TXopg752neKMGg=;
        b=KruDRqjhoLjx+sYOUpcq3sXk+XjHwJCdCH64uMmttuPc0A1Ta8HjzGKGqfQturSuV4
         eJC8zMQU25XhO1/5qaLQ9Z4UUuhozYFk6zA47U4yYRH/7RQDkdwNLZ0B9O5Nm8wv8ldd
         /jFaUIShVutNM8YxnxPYE1zdvlfpCnyPyxfxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=Q0aPYShzUHQahtTa1rDM0UEGu5hh3TXopg752neKMGg=;
        b=WSU3L6B/eHesB18ukkeTPP3orrCda9sSzhcJ1bwIq8Y1jWcz8vejtix6i1kBAmk2kO
         fOW5YTfB/Lz8A3jrjcCqe8gk9ZvAKJnwLVe0M+4ABtQ4P/HE3UD95XO0MOcS5d/Dvaj0
         4k7m+8to/qJOUwdVXzStcyZLVyI1A+y+/DtF0K2V3smRO2yntPUW3NzSi0ahR1urvZ8Z
         h8S25XwnxuRpQ9GREosCpvJCLiCwAk5t5sMGsGmF5HC2C7CVPEAprHkpZNCxT2taTvGt
         B76zU0UlIRtu6JZy5e89jeCqtwk3vSEVo2q3o+jpIK8vMklddTiL3c/Jw/OeFHJ3yVTE
         gxig==
X-Gm-Message-State: AOAM532Uns1K8TAHVpJQMEpAVMauZK3zWm6eFdmp3LAJ1GVnC7tyfePY
        lnHsn+pjVz4lhIYwE0bNFRnO62FRFod7u+4PXpKk5w==
X-Google-Smtp-Source: ABdhPJy5II9bUKXp0PmXN9iZD0uyK1uwYoFfurzgzrVy+zidgimkf19uyPDV0C7OcPK1KlpMppshRp1NEBWVvR6ePUk=
X-Received: by 2002:a9d:7655:: with SMTP id o21mr1932382otl.126.1635403105338;
 Wed, 27 Oct 2021 23:38:25 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 27 Oct 2021 23:38:25 -0700
MIME-Version: 1.0
In-Reply-To: <1635386088-18089-7-git-send-email-quic_sbillaka@quicinc.com>
References: <1635386088-18089-1-git-send-email-quic_sbillaka@quicinc.com> <1635386088-18089-7-git-send-email-quic_sbillaka@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 27 Oct 2021 23:38:24 -0700
Message-ID: <CAE-0n50YcX6sCoTR0bUy_GrZM7=UdHPAGYNwE3Nvj6GL4iTmMg@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] drm/msm/dp: Remove the hpd init delay for eDP
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

Quoting Sankeerth Billakanti (2021-10-27 18:54:48)
> DP driver needs a 10 second delay before phy_init so that
> the usb combo phy initializes and sets up the necessary
> clocks for usb devices such as keyboard and mouse.
>
> eDP controller uses a standalone phy and need not wait for
> phy initialization from any other component. This change
> will remove the delay for eDP controller.
>
> Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 61385d6..de6a1fd 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -1438,7 +1439,15 @@ void msm_dp_irq_postinstall(struct msm_dp *dp_display)
>
>         dp_hpd_event_setup(dp);
>
> -       dp_add_event(dp, EV_HPD_INIT_SETUP, 0, 100);
> +       if (dp->dp_display.connector_type == DRM_MODE_CONNECTOR_eDP) {
> +               /* eDP does not need any delay before phy init */
> +               delay = 0;
> +       } else {
> +               /* DP needs 10 second delay to let usb combo phy initialize */

This seems to be a different approach to the patch Kuogee sent a week or
two ago. Can we figure out what's wrong with the DP phy starting before
the USB phy? I suppose this patch is OK as a temporary hack to keep
moving with eDP, but we really need to figure out what's wrong with DP
so this delay can be removed entirely. Has any progress been made on
that?

> +               delay = 100;
> +       }
> +
> +       dp_add_event(dp, EV_HPD_INIT_SETUP, 0, delay);
