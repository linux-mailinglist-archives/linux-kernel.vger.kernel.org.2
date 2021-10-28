Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E86343DB0C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 08:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhJ1GXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 02:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhJ1GXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 02:23:41 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A259DC061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 23:21:14 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id t17-20020a056830083100b00553ced10177so6978193ots.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 23:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=Mc9LKQAQoslOGm6o+pVM9AhRB1ZUOOEE/5oefVUl9Lc=;
        b=ispJvbrsPNohrDzzQOfGiAya2Gz/DXYBgvobMGSF8M38h1V5YLwF3zJvQ5mUvZWXwx
         dNEfCluGOMa///Ra8ket00k+BpYhjPld4QIjQuSaWuENr4YoQZ+SqqB8Z+bJu4ro7cMI
         wJxalHJpVDA7mjndkAe3QO2kjHgd/v7TFYCuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=Mc9LKQAQoslOGm6o+pVM9AhRB1ZUOOEE/5oefVUl9Lc=;
        b=vsMCl7MislVNBDTAaoEEs9rtCSlEIkXinaqbBxS470lRZffrNTdKOBKEGyFTTrV48p
         H0OtNBBfUKlrD/lo/JfjSSU/wj8zKdAQ6jOLpEXRE/9z3VLZy2ZQuCSXMAw/n/iPPpEy
         lIusYH249NOm7o6rlhE3mmWlzbVW5DXlBiJ4dZwPYvEKxdC5tSBby7fGqMxKSFDXzYCc
         PktlknYlyoP8PU3gk4xwd2EZtomnoE8DC5WO+esua+V/CT2g5iV1OsR7czN6BPYEChwN
         RRpx8U45XT6yW+fuMot1xMk5t13M0p4it2Q0PIIzT7wAqLEWGGA7U3YBB2sGYgyEX/Q0
         /U/A==
X-Gm-Message-State: AOAM532h+1P7HBVXN6SHIL7VJaqQ50BRUpzQtudDOn2py/qrBN8XL5yc
        y24HDnYGYtBp4E9ddds05uhcPgNEUq9y3YlZtzPtnw==
X-Google-Smtp-Source: ABdhPJwXQHqI3ICCqimmpImWWFhlxNmRD9J4BKAimAk2nP8JakuCfq++JC5QTUaAhvBLQQixIagkH4fHHMXy87/FcEE=
X-Received: by 2002:a9d:7655:: with SMTP id o21mr1891665otl.126.1635402074047;
 Wed, 27 Oct 2021 23:21:14 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 27 Oct 2021 23:21:13 -0700
MIME-Version: 1.0
In-Reply-To: <1635386088-18089-3-git-send-email-quic_sbillaka@quicinc.com>
References: <1635386088-18089-1-git-send-email-quic_sbillaka@quicinc.com> <1635386088-18089-3-git-send-email-quic_sbillaka@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 27 Oct 2021 23:21:13 -0700
Message-ID: <CAE-0n53gO-NtWosw8kjTkjv7eUPt+VH2rzAvDAYYwpGK+jJ=nw@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] drm/msm/dp: Add DP controllers for sc7280
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

Quoting Sankeerth Billakanti (2021-10-27 18:54:44)
> The eDP controller on SC7280 is similar to the eDP/DP controllers
> supported by the current driver implementation.
>
> SC7280 supports one EDP and one DP controller which can operate
> concurrently.
>
> This change adds the support for eDP and DP controller on sc7280.
>
> Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
>
> changes in v3:
>     - Split into patches according to function (Dmitry Baryshkov)
>     - Use DP_CONTROLLER_1 for eDP controller intf (Dmitry Baryshkov)
>     - Use DP_CONTROLLER_0 for sc7280-dp (Dmitry Baryshkov)
>     - Add macro in drm_helper.h for checking ssc capability (Stephen Boyd)
>     - Use existing macro to check assr capability (Stephen Boyd)
>     - Add comment for HPD_INIT_SETUP delay (Stephen Boyd)
>
> changes in v2:
>     - Don't initialize variables to 0 (Stephen Boyd)
>     - Use const for read-only dpcd (Stephen Boyd)
>     - Remove zero pixel clock check (Stephen Boyd)
>     - Sort compatible strings alphabetically (Stephen Boyd)
>     - Use pwm_bl.c for backlight instead of gpio (Stephen Boyd)
>     - Change return type for functions returning always 0 (Matthias Kaehlcke)
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
