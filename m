Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D48C73E8307
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 20:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbhHJScW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 14:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234169AbhHJScU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 14:32:20 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B993C0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 11:31:58 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id t128so473908oig.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 11:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=bRoFoIrgb6DbxUcPZ4qNbvdQX1dffX7W/rihsgTb2z4=;
        b=QWJyaYLaSvyDInTM/b9ve7OmtT4fI/gbefn4OkqqYoJoS7qSL4WjCukVdCd2aFJn2+
         zgWtJrsWMWdriv+2tJAI0RqmwdkA/XtnmcxTNQ7J1bav4E8LazOhIbDE7cG92Wk9e7aA
         uptQrHkXkrQlnroBRb7ExPIZiqo7aqnrrjCRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=bRoFoIrgb6DbxUcPZ4qNbvdQX1dffX7W/rihsgTb2z4=;
        b=MzHno8s9cHJeDQx7BgvHRSevX3HbwE/Tg1F7z8/TYJlex7Xjc3/ks2fQADS/jF297B
         GLMAHXNmmRSt4UTxF4LdEhAI4CeuT5MsCNi0WQvvuFQZuVzlRZKOSLBsaEg2Edsirid/
         lu6oBguWaQf2czcNHNg3hxtm32HFRsViNGZSWzEFinQHbCbQUrKnEG/RQ2IudaetwJwd
         9hdeihc4TR2cqGW/Mf5ml5wAwP3Th/WXdh+ztKvzuyziHBeDFMEVu5ysUPUUR6C8k3sE
         1C3KQ0GeqrEr91h+r92dpTVWd9M5MTETMn6lsO0a66IbkujZ7ydlDJ7jS/DG5m63Pjqn
         hCog==
X-Gm-Message-State: AOAM5306qbO1tHumrI2mqk4cAppWKQnSCVsnmEOt3ahAiM183wMVcMoz
        DfRoCYscLEtTlj/ZpKN/1fh6O+dETVK+n6kqB/iv8w==
X-Google-Smtp-Source: ABdhPJzuO8bdHRY8YfA6qtIShSohbIviDAruhTY93vX+OuVbguE9JaTNgfjrPkPDvsy+kBJf3jR5BGgDV0t7AZoC898=
X-Received: by 2002:a54:468d:: with SMTP id k13mr4595160oic.125.1628620317662;
 Tue, 10 Aug 2021 11:31:57 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 10 Aug 2021 11:31:57 -0700
MIME-Version: 1.0
In-Reply-To: <1628609362-2109-1-git-send-email-khsieh@codeaurora.org>
References: <1628609362-2109-1-git-send-email-khsieh@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 10 Aug 2021 11:31:57 -0700
Message-ID: <CAE-0n51wQMmL-TYshTugGbR7JNnVeTq257OQMMQ6LSTcB30w5g@mail.gmail.com>
Subject: Re: [PATCH v2] drm/msm/dp: add drm debug logs to dp_pm_resume/suspend
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

Quoting Kuogee Hsieh (2021-08-10 08:29:22)
> Changes in V2:
> -- correct Fixes text
> -- drop commit text
>
> Fixes: 601f0479c583 ("drm/msm/dp: add logs across DP driver for ease of debugging")
> Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
