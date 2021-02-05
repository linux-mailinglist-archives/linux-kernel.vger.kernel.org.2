Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62A37310887
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 10:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbhBEJ5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 04:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbhBEJyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 04:54:53 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF77C06178A
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 01:54:12 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id z3so596394vsn.9
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 01:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kOysVJ3sc7xfuiW0Rozz11xFIhIOvQEqlfXvKMKI1kE=;
        b=smBQR3aBgWeBFd64gORBzsMxGKt7oPm7N0W0lZQlaRziRjATBtYwrMi4/E0Qs07PXp
         pRtTueio2f/poVlGW0iLrG2KfQSMoZduWof1OBkTkuoacHgiZkpWPPpzNNGACzJKM7kJ
         2ZtZ5jq3Z85Kwm8xNHoIEiBnLMrHQXV99vvXQDxkfd/y9miXo2kAtQlCgLOuB5qiS2+K
         pV3RuotkRfyv6rRQf9xXg76BJDmTdnjgx/RHjjx3KyJpEYer7b6QZs3qSfVU5L+zo5xu
         Lg9GlEXQ9+hjcC3T7haTH/wa1MHYcAXA9dLT6wf0VT4mt2PzTDXlx1uoVkN8YoKVnQ50
         G6vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kOysVJ3sc7xfuiW0Rozz11xFIhIOvQEqlfXvKMKI1kE=;
        b=R6+qP70AozP4AYj7vV4iyKoDLDYP4CsDn9O9ywvJBpc8W3UydheXm+eFhrUf4T6VWN
         yQF+A7Phww+3E6iBUndyv4447uNX7BglRVARacEXEKrNbYGYo4qsq2nx/+dN5NjTIkPX
         IAK77SwK9DQHX3nnwIZezYaDXy/M7uN3DOBE/TGFtlAkwiHR7um9/mT7XxdO5OdSvkan
         HuEkbMJ7g+abpmkzDQOAtXq35x6dqBjzoKVQjYzuFq+lFhvX/Hmy5bD8KJuBqoHjkRSS
         Qela9/lJV578n2NeqJYEmXhqv0iz7F3DndgxVb7e6eDl9NV2lz7O4dq1BO4Un9utQpq6
         G5kQ==
X-Gm-Message-State: AOAM530mNMOQ8yHxJ30j1zS77vU7xAjnq9SHFlxQEyZUd8P0ZiX55gpz
        NHzVwf57UxplSlThvkbzDlPn/D2oj5ryPaXLEcLO1FQXFMkYsOQO
X-Google-Smtp-Source: ABdhPJxDXLpo/rd6h4QfQjHmOl/racHSh6PBUgr50UsoEIi71tGvlqB8NUlEGXf78G0883FCvc7XKzBeh9BryR0cKaI=
X-Received: by 2002:a67:7d54:: with SMTP id y81mr2778856vsc.42.1612518851229;
 Fri, 05 Feb 2021 01:54:11 -0800 (PST)
MIME-Version: 1.0
References: <20210204120547.15381-1-yann.gautier@foss.st.com> <20210204120547.15381-2-yann.gautier@foss.st.com>
In-Reply-To: <20210204120547.15381-2-yann.gautier@foss.st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 5 Feb 2021 10:53:34 +0100
Message-ID: <CAPDyKFqdtK33HSW_AM0s9172V=cBM6wnKuHubXSOGCVqJ8nzFg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: mmci: enable MMC_CAP_NEED_RSP_BUSY
To:     Yann Gautier <yann.gautier@foss.st.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        ludovic.barre@foss.st.com,
        =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- trimmed cc-list

On Thu, 4 Feb 2021 at 13:08, <yann.gautier@foss.st.com> wrote:
>
> From: Yann Gautier <yann.gautier@foss.st.com>
>
> To properly manage commands awaiting R1B responses, the capability
> MMC_CAP_NEED_RSP_BUSY is enabled in mmci driver, for variants that
> manage busy detection.
> This R1B management needs both the flags MMC_CAP_NEED_RSP_BUSY and
> MMC_CAP_WAIT_WHILE_BUSY to be enabled together.

Would it be possible for you to share a little bit more about the
problem? Like under what circumstances does things screw up?

Is the issue only occurring when the cmd->busy_timeout becomes larger
than host->max_busy_timeout. Or even in other cases?

>
> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
> ---
>  drivers/mmc/host/mmci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 1bc674577ff9..bf6971fdd1a6 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -2148,7 +2148,7 @@ static int mmci_probe(struct amba_device *dev,
>                 if (variant->busy_dpsm_flag)
>                         mmci_write_datactrlreg(host,
>                                                host->variant->busy_dpsm_flag);
> -               mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
> +               mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_NEED_RSP_BUSY;

This isn't correct as the ux500 (and likely also other legacy
variants) don't need this. I have tried it in the past and it works
fine for ux500 without MMC_CAP_NEED_RSP_BUSY.

The difference is rather that the busy detection for stm32 variants
needs a corresponding HW busy timeout to be set (its
variant->busy_timeout flag is set). Perhaps we can use that
information instead?

Note that, MMC_CAP_NEED_RSP_BUSY, means that cmd->busy_timeout will
not be set by the core for erase commands, CMD5 and CMD6.

By looking at the code in mmci_start_command(), it looks like we will
default to a timeout of 10s, when cmd->busy_timeout isn't set. At
least for some erase requests, that won't be sufficient. Would it be
possible to disable the HW busy timeout in some way - and maybe use a
software timeout instead? Maybe I already asked Ludovic about this?
:-)

BTW, did you check that the MMCIDATATIMER does get the correct value
set for the timer in mmci_start_command() and if
host->max_busy_timeout gets correctly set in
mmci_set_max_busy_timeout()?

[...]

Kind regards
Uffe
