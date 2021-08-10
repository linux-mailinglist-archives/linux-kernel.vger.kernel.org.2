Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA4C3E830E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 20:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbhHJSeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 14:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbhHJSeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 14:34:06 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB4AC0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 11:33:43 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id t128so482648oig.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 11:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=gYZz10QOH/TLSpK9xInSP5W9KjyrAu8lPPeUY1ToCJE=;
        b=UkvTnleb2ewtinuVC7dDQEd5XOLkYp23xWGkwCzb6rbXV4wMfIeKFe8mHA8REQnDU6
         zGcRQ4iXxZoqPZSXdY2hTOG25VHEEnhB5DnBZVq/0HB/QDmw0jte5gSNNAFfDuw1RDvN
         6vxdDI/B+WY8yszlYAUNnPhoiWJpC8GPZsS3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=gYZz10QOH/TLSpK9xInSP5W9KjyrAu8lPPeUY1ToCJE=;
        b=We1wcEwC2O26UyaJ90SYWodJtVy3ga4qNLYZvJuUr2h0OzN6TPxpkxEKKqfRK6HhTo
         cbgpZhV3xgd99vs+tFnFjQ4r+tNVN9PZpqw1QZuleVX6F+D9cAQBLq/1KJXvBzGmyZsR
         DCX8Rou5XXknDGI9pOTRD0ocNWBj0GL8Uchk/Unz7Vf9vU/JCHvjI9DUsPSfcyerk6fE
         oJHgn/t1E4hsVVmhnLVPc2a8EXSLImQt5qFUeho2rBJPyyi7amfHfRGbprj5vHLuxgHm
         X/kEnB1PfJXswWG9mLnsoJD35JTGJTW4eD15WxaXBOV2aeHg8Lg+gKUaarOj3XNaPn6z
         qp4A==
X-Gm-Message-State: AOAM532TXgj8tqRJDbvlstvMmlHzKnAfXlLU4BiyOs/16ANnWsJhTsT5
        I/8HLeV/Gum+3Ul16btm/aTLPiwnnk0RglNr4Ciouw==
X-Google-Smtp-Source: ABdhPJx0r1eGpKElyHXDzuipufR0h+pMIYXO/v3pEKBRmpQ1oxloy4TUZvZtg8REVo/F47kGgJfrsCMhXbD/8mXWsTE=
X-Received: by 2002:a05:6808:984:: with SMTP id a4mr4781026oic.166.1628620423016;
 Tue, 10 Aug 2021 11:33:43 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 10 Aug 2021 11:33:42 -0700
MIME-Version: 1.0
In-Reply-To: <1628609362-2109-1-git-send-email-khsieh@codeaurora.org>
References: <1628609362-2109-1-git-send-email-khsieh@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 10 Aug 2021 11:33:42 -0700
Message-ID: <CAE-0n52a8i-2oNxtqKaS+XGBE0+wcp0Jx05VgL2KnHoQLW-vDQ@mail.gmail.com>
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
>  drivers/gpu/drm/msm/dp/dp_display.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

BTW, this conflicts with commit e8a767e04dbc7b201cb17ab99dca723a3488b6d4
in msm-next. The resolution is trivial but just wanted to mention it.
