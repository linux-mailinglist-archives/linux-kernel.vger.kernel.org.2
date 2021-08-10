Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56B13E5058
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 02:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236098AbhHJA3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 20:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235165AbhHJA3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 20:29:10 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF70C061796
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 17:28:49 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id c23-20020a0568301af7b029050cd611fb72so1415942otd.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 17:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=HRoKBbC120mpZO7Rwf3yY2Wqv2ZDw0SsZhaaP3iG9Kw=;
        b=b7oTI7pXK4UvT/slNhXBHpYCZP7+MeBmfeSSbjI/aKYSqGEunyiYcIMcqA1eq8BC+H
         oBPqmdPIA6cv0p6LCUDFdtUC2mXrZd5B+ZzB5di1KJyFAwfYBrwtoEgy2bp7dQ9B6FCr
         yJ+hAioIV+wD6A0vvTE08xu163VL+w/zKRi7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=HRoKBbC120mpZO7Rwf3yY2Wqv2ZDw0SsZhaaP3iG9Kw=;
        b=jBG329br97FsnyxubdfObxaUGTzaJ5ifZdcMhrr5MPj5s+iyrxAeKwIlbKTrYW0Ryu
         MMQVcplhXJSCJbZiMFN5+vq2KUUlm9l+EYCEJCp8o30xXbVsxfEAPhgxFI7GCZe+MA2c
         ++w9AgNBmHxFqAH20n4AD5qqZ5u/ZwI1qCeVuJp6sPdXaXLrd0Va9Qv6BLI1eQfC5WYC
         9QMsVEfAVjx+/Fr8/Yf3fxGtvkgIpLaOX9bOtrPD+dG3EAhJ3x7c9NkucuqjUsopVI0d
         8COgUaqN8SSMGkR6exEKqzcYb+J6zZJSzz64DUmuPSx/Q9ou8vfYBohFHQBroA+sFoOs
         YD9w==
X-Gm-Message-State: AOAM533wKKUzj8Nve+EPa3iJ9i7+EEoAgRIR8WguU9qNIb7eF5OYESRq
        V1vnv+g0QIlg5VXBhgYLeRPYdoXltepynETOXdWHmg==
X-Google-Smtp-Source: ABdhPJxoo8NK9wFlwHerqC8A8M68otlXDKJXzE8FXoEI3Z9Tb47KJ4Do1b1frIJJ5Zy4cKOXDh55LHg6NY73iIRVaGI=
X-Received: by 2002:a05:6830:1490:: with SMTP id s16mr19010939otq.233.1628555328400;
 Mon, 09 Aug 2021 17:28:48 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Aug 2021 17:28:47 -0700
MIME-Version: 1.0
In-Reply-To: <1628546337-15517-1-git-send-email-khsieh@codeaurora.org>
References: <1628546337-15517-1-git-send-email-khsieh@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 9 Aug 2021 17:28:47 -0700
Message-ID: <CAE-0n52Ebezuek_HrBHRFVyUv28aj=F+6FqnBkZZLMYwUa8veA@mail.gmail.com>
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

BTW, I have no idea what commit this is. Best to probably just drop it?
