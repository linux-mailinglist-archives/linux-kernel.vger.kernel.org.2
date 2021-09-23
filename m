Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C98B416723
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 23:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243248AbhIWVLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 17:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243216AbhIWVLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 17:11:45 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F8DC061757
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 14:10:13 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id i4so31440815lfv.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 14:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RzCYOEChqS52ihYCFoLsCYGGR6ap8pXnjkTEkEmy1IM=;
        b=DwUvUexVIQ2f+G5CJTygnALkzFfFQTEkUtuLnis44qdnGAWeGJ1siEXg4btlfrJY0L
         1fp9oe9j1lL//ULw/51YZrFxU+cEPivYFu25FzHbGjZxHVFI9IomFikZHjhXLn+YNww9
         tDgvefSWm5+2yZauq/3TM5oKOEcjntfUQ2wdk9cJi3+hqbSBICoo8SWpJskJw/prNYAA
         OU9Tz+6FsN0/uprjvV9uZaLTpccMMnVoWE0eyaUp/9hPz982ubh2U3UXTuDqwPjuzHq+
         A+mCQBddelyPSz7OhxZ5gcgWWYfhd85+nw8YeBLVgD9czkCk+60/4GWpi5Lw9225jOSp
         oPzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RzCYOEChqS52ihYCFoLsCYGGR6ap8pXnjkTEkEmy1IM=;
        b=k/GNSXezLvc7Yz0YJU7pUg+eg4HmRURLl19NE2XqDTJ3pR8AGcKz02JJG3CwZLUwE3
         U2quzNchDRKklP8ArC9bh5Et6omegMnWEds0+Xsbw5vt0sYsad9c+9JqezY8BQYZqjSZ
         E4LcZG5zmpmo673Qqifdpze50YkgCYkDfjL3ZSLol7Z0pHiwBC8jJT6iBGVX8eYljgGH
         NiDR5Pt2CCar5bvP2kq+XBMSyj22iV2qZx9DZpqIuNkoHCr62lSIby/EjX50b24fEn9g
         EnXpyHpQacWwlXwUfN7n8ND8m0FTwpAnQC1cphCrB4tZZNojnN2/9u0CMtqZPvMpdhnJ
         XF0g==
X-Gm-Message-State: AOAM530nl7oOdc5VqW/dz8jUsYBjAYegJByZt1FpRUv9iCvmRbIfoUWu
        qquMWL4A4eem/y0HiYzC3XxcU8BWVkvkR/uxhD12rw==
X-Google-Smtp-Source: ABdhPJyvWnA5YfxMUa0cPBb67wdrszJXaQYs8/Ln8r6azwb7B76KLd8cP1MpRLp2CqAdwCnLqyZlEYKeslxOgKWfpOM=
X-Received: by 2002:ac2:4651:: with SMTP id s17mr6100025lfo.584.1632431412003;
 Thu, 23 Sep 2021 14:10:12 -0700 (PDT)
MIME-Version: 1.0
References: <1632389487-11283-1-git-send-email-rnayak@codeaurora.org>
In-Reply-To: <1632389487-11283-1-git-send-email-rnayak@codeaurora.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 23 Sep 2021 23:10:01 +0200
Message-ID: <CACRpkdYSqyk4yhguZ0yWr5NDAsDZx8gR1Wchr=TPHaDpWg=KtA@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: qcom: sc7280: Add PM suspend callbacks
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 11:31 AM Rajendra Nayak <rnayak@codeaurora.org> wrote:

> Use PM suspend callbacks from msm core, without this the hog_sleep
> pins don't change state in suspend.
>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
> v2: removed some stale diffstat

Patch applied for fixes!

Yours,
Linus Walleij
