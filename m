Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C75803E503C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 02:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237119AbhHJAHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 20:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237108AbhHJAHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 20:07:10 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DD4C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 17:06:49 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id r16-20020a0568304190b02904f26cead745so19658357otu.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 17:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=z7lFn/OgIbozxfPpWIL41tqWAyoo1c25CUhE+wVHy2E=;
        b=YhtgTTL24J2Q901pxxraRzr2e6aEAsvLQkHaiYTevOHYcVNNb70cjDiaEwdsIq8BXN
         wpYvPIjDyag/iyLToGVOJkKLG7uJdWDBeQ0RrSjIpGoUS+WRXWr4Uuc+9lFlSBwQdix3
         ZJi1BJJhihwUbTrgXthbzJEm8hOQtXIW2ldEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=z7lFn/OgIbozxfPpWIL41tqWAyoo1c25CUhE+wVHy2E=;
        b=glmFDZdJ2LgcW7XIVifIZLbjJpOI6hmDq9Ql4t+PN4vvkkVMJ0pLzA1L4sQo/rpqX7
         5lAecmrRuXtVAMXCfnNKK7kWT5IkmOxNZ3JzdXgfCR30WHL9XkcOIRujHveMLIvecPKY
         Sm+r+em6shJ9BdXL4fWlPC+uKmjBknOQ0NNTj854sxo0GTXbb+dp2sNl2+572apxGPjd
         IzkKCLXueeq0J3lNE4RX9yvaX2ozoko2gFuopKsAzLIDJfMTgAXwnjHcYwF9Jgs6e/Nm
         BmFdFNeRI9p9rC3aI0RhVmqLTxHBcS0gX0kuLg4lALcwbrr++FZ7wOPOFpKlL+07QZcE
         xZGQ==
X-Gm-Message-State: AOAM5317LgnUNPMwzUEc5/zWq6gJAtuUlYSXNmq2BTpY8pSaX935+pjM
        VexzqTBq8gp+yyqmJTp7kzWoROCoj35hlyTqZp09Fg==
X-Google-Smtp-Source: ABdhPJyHxPiz+4jZdua08WndVHVUUZwOp93vnlfR/lihn4zZ0NeOwGKE8URDZ20NU/NwrBeRkck27YsGd7/EAhlLU98=
X-Received: by 2002:a05:6830:1490:: with SMTP id s16mr18959569otq.233.1628554009313;
 Mon, 09 Aug 2021 17:06:49 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Aug 2021 17:06:48 -0700
MIME-Version: 1.0
In-Reply-To: <1628546337-15517-1-git-send-email-khsieh@codeaurora.org>
References: <1628546337-15517-1-git-send-email-khsieh@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 9 Aug 2021 17:06:48 -0700
Message-ID: <CAE-0n52+DWvcO54WJEJUaFQ9y=4sb4SeuVzQ5LSXGm24bJ-16w@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dp: add drm debug logs to dp_pm_resume/suspend
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

Quoting Kuogee Hsieh (2021-08-09 14:58:57)
> Add drm debug logs to dp_pm_resume and dp_pm_suspend to help
> debug suspend/resume issues.
>
> Fixes: 355ab7428f09 ("drm/msm/dp: add debug logs to dp_pm_resume/suspend")
> Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
