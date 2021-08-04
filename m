Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8043E0867
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 20:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240449AbhHDS5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 14:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240398AbhHDS5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 14:57:37 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D87C06179A
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 11:57:22 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id a19so4003644oiw.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 11:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=W0RU2njrJYwNw31OX+GKz1dnas7rS+0peN2BXk2nTOM=;
        b=XQG1pb4WN8xpvB82dpmucAJRgEyqKxa/pnqs92acP0GjyGJg6pbgmHVkt4VIIBWHZ2
         9lg1QU4BnUj9PaX5g6rsqOV31lVBH/YiGh5Muf2InY6gVAzhbwCNcNt0M9ZT1kilr1lB
         peNOAvCJ/Gk4wKYe3BIAV7+jN1n2GxKn9pORY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=W0RU2njrJYwNw31OX+GKz1dnas7rS+0peN2BXk2nTOM=;
        b=P9UdOsdRqy/fokhnE5ERU+V1pFPAH/N5r5ITodPtWyN3f6e7c16pNa7QEGUE47eQef
         pVmPZCuQg7ZgTo+CNtRJV2Pco0Z1KoFU+PF8RbLafBSCH0mYW6nvPXPARba2QFApoowZ
         YhXsGofn2ZZIEC+SQoCjkMsp44CvD6ORnUcZLKkgLYT2TDLyAmjhilhmknqK4fh7C3K+
         DAwwbevE/p2X2CojEVPirnbvn/Jd3pVD5HCq3cCrz9pSl5H8uG7+YpzjkzOmLDyzgWwg
         0F9kiCO024VKzjvzW6Mxl3L8HHPkacTfhknWf8lG40bU4UHme28gWGyfuCtTyoiQGoIA
         uFvA==
X-Gm-Message-State: AOAM53274zADqk4lj9uMl7c5AhSGU6lzQoVWK5YVNsVGi/kAQFmyU4w8
        gjw3z0YCuo/7BAvfnMj/ElJrT+KjnFElOhPDGj7nyg==
X-Google-Smtp-Source: ABdhPJxnaosSbnczMAr1y6z1t5NO2fUtY+Th+88s1vPF8mmT7ZwOvdJJWTYMH3xeYdgzDiiMnXNGokR3TdHCDuJICOc=
X-Received: by 2002:a05:6808:619:: with SMTP id y25mr3998610oih.166.1628103441478;
 Wed, 04 Aug 2021 11:57:21 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Aug 2021 11:57:20 -0700
MIME-Version: 1.0
In-Reply-To: <1627581885-32165-4-git-send-email-sibis@codeaurora.org>
References: <1627581885-32165-1-git-send-email-sibis@codeaurora.org> <1627581885-32165-4-git-send-email-sibis@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 4 Aug 2021 11:57:20 -0700
Message-ID: <CAE-0n5249t-DCDY0-HSV5EYN5yOv02NKJwKpibpL5NdTmnCrfg@mail.gmail.com>
Subject: Re: [PATCH 3/4] arm64: dts: qcom: sc7280: Fixup the cpufreq node
To:     Sibi Sankar <sibis@codeaurora.org>, bjorn.andersson@linaro.org,
        mka@chromium.org, robh+dt@kernel.org
Cc:     viresh.kumar@linaro.org, agross@kernel.org, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dianders@chromium.org, tdas@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sibi Sankar (2021-07-29 11:04:44)
> Fixup the register regions used by the cpufreq node on SC7280 SoC to
> support per core L3 DCVS.
>
> Fixes: 7dbd121a2c58 ("arm64: dts: qcom: sc7280: Add cpufreq hw node")
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
