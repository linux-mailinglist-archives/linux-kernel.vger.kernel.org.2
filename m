Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5D930E2A0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 19:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbhBCShS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 13:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232760AbhBCShN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 13:37:13 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0664BC0613ED
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 10:36:33 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id n8so449241qtp.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 10:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zRad3jf+bR+tIOugcGQc/4V8uVsUGmP5WmEHBEMRiz4=;
        b=CVVxYbxbvVsGcP5UduJ+D+yFn6wv+RLdHnjIw/RQBfSsfx6F28MXHAntqaqQVI+8xU
         DBJiHM4FLHs94ldKMgioQnK7QZVY+7BAPeJTeBstDkfkETulNH1Mg4jwfu3fdA4nnRBo
         nAumwV5nAOsbZKlI7YuRR0dbYwuFqxE8fTg+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zRad3jf+bR+tIOugcGQc/4V8uVsUGmP5WmEHBEMRiz4=;
        b=bq0QQMoiGWfpePWV4LrLP3adDekx2nwYNHEC45clETkNz246Qb/vzY+SLY43yhn+XQ
         tkStbnz9Tglaet9H1MwX8Ajo9lt8OG+pX8B5kBbo6RvHaLE1P4M8QbGofE2BG8DVHSkf
         ASC0i2gtN/nt/rAEFJXQue3G/dW0paIyp2I3HIiVFZoyPRNlM6OduP0aQap0VhWt+gEX
         66xH3NGu9GcJ0o3C28XgwVxCz6azwU5Xd1KMyN1ei3klOp78TKkgP0pFVgZCReTiZgvD
         NZr1iqqBUKjzzJy4IS8dAbUS4JGSvb893oLPdm5ujNJUNy2ey8q5FkZc6R5nFD6Xyls6
         WZmw==
X-Gm-Message-State: AOAM533wt7qUfQhZcZvZdM8AdaCamw6cTxhlXWUfL0LcB3dQvXrEAoz9
        sKowZ4cZPOP1fzYdXCINyUnBoY0XnNnN1A==
X-Google-Smtp-Source: ABdhPJwf2x3yewHXtwdQ9UPUCzjjael2ekdmJiiNLRkxQ5KT+nkEhFn2hqPNiqB0s2F9eSfiZKtK3w==
X-Received: by 2002:a05:622a:144:: with SMTP id v4mr3746307qtw.191.1612377391869;
        Wed, 03 Feb 2021 10:36:31 -0800 (PST)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id z30sm2006336qtd.21.2021.02.03.10.36.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 10:36:31 -0800 (PST)
Received: by mail-yb1-f182.google.com with SMTP id j84so595374ybg.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 10:36:30 -0800 (PST)
X-Received: by 2002:a25:c683:: with SMTP id k125mr7009841ybf.32.1612377390520;
 Wed, 03 Feb 2021 10:36:30 -0800 (PST)
MIME-Version: 1.0
References: <1611555637-7688-1-git-send-email-mkshah@codeaurora.org> <1611555637-7688-2-git-send-email-mkshah@codeaurora.org>
In-Reply-To: <1611555637-7688-2-git-send-email-mkshah@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 3 Feb 2021 10:36:19 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Vi4a-uUuEStPpOvzF+goNZ7W5zTBbMg3oqmWq9urObBg@mail.gmail.com>
Message-ID: <CAD=FV=Vi4a-uUuEStPpOvzF+goNZ7W5zTBbMg3oqmWq9urObBg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] soc: qcom: rpmh: Add rpmh_write_sleep_and_wake() function
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Todd Kjos <tkjos@google.com>, Lina Iyer <ilina@codeaurora.org>,
        Srinivas Rao L <lsrao@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Jan 24, 2021 at 10:21 PM Maulik Shah <mkshah@codeaurora.org> wrote:
>
> Let RPMH clients call rpmh_write_sleep_and_wake() to immediately
> write cached sleep and wake data to the TCSes.
>
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> ---
> (no changes since v1)
> ---
>  drivers/soc/qcom/rpmh.c | 16 ++++++++++++++++
>  include/soc/qcom/rpmh.h |  5 +++++
>  2 files changed, 21 insertions(+)
>
> diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
> index cbe6b96..725b8f0 100644
> --- a/drivers/soc/qcom/rpmh.c
> +++ b/drivers/soc/qcom/rpmh.c
> @@ -515,6 +515,22 @@ int rpmh_flush(struct rpmh_ctrlr *ctrlr)
>  }
>
>  /**
> + * rpmh_write_sleep_and_wake() - Writes the buffered wake and sleep sets
> + * to TCSes
> + *
> + * @dev: The device making the request
> + *
> + * Return:
> + * * 0          - Success
> + * * Error code - Otherwise
> + */
> +int rpmh_write_sleep_and_wake(const struct device *dev)
> +{
> +       return rpmh_flush(get_rpmh_ctrlr(dev));
> +}

This patch doesn't hold weight on its own.  Please squash with patch
#3.  Specifically any clients actually trying to call this function
will hit the problems that patch #3 fixes.  There's no reason to add
broken code first and then fix it with a later patch in the same
series.


-Doug
