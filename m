Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 351D5319E50
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 13:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhBLMYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 07:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbhBLMVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 07:21:20 -0500
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594D0C061756
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 04:20:40 -0800 (PST)
Received: by mail-vk1-xa29.google.com with SMTP id u22so2012954vke.9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 04:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K7cVpiyFvKnbzOkHpmdbCjD/gvDLBbbhp96xZdfeqF4=;
        b=vJxssJowYGLiIGwwoDnJH93+1/Ibpn6Kudfu0/PHyC/CuW2+GG/XPq4WhcMgj8d8Zi
         3XB4K0TxEF/0PxLEgZlvmy32jk2qL8zJXutEChCgExNIhcx2/wywziqBH4I/apfBc30f
         hZNP5NkeMTC0tWBBX+eg55yq6b9VkjA0v3o2O9JnaMtPD0PODgY2eJiSyHTnAD2rxqJm
         iZ5fEhpYvSQ68zLgZBNOo0Pm62ZhOEeklozxvfWXodz7ynJRcw+v7T8pQZRNZeYuP9y6
         xW8NTqCd9eIxa6KWBUnaV/0a0PtAlhPvgJmVcf0zpZa55A11jhyh1rkirfCn+0fUXRfG
         7Cdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K7cVpiyFvKnbzOkHpmdbCjD/gvDLBbbhp96xZdfeqF4=;
        b=WibiGPSW/3p3Wt/GjJLmbEvyE0WYogD/K0e/XHAHbK9CIhD/DQA62/oUDn3pTBfCpz
         QFKZftDJq5CPcxjKcMarJOK5dBYGx1hk8ed7vbwKxv5ZlwI1VZDfSp8nvNKzEx2VsOeD
         qzIkx+7UdqzPAT+WF/C7ZFQTz54vjQ0JPhlcmQtzjS3Uc9hRLj0enzOxTnz4+9JS1ehT
         wnZMJZ1BPY0oq8FG0sWZ9IPky51ND90VVOv5wz9+e/FuiVRw/hiuU34wQsvmW+8nKGbq
         SrY+CqoMc6M62J7nJqixsT0dIwV9VkcfBKYiWriwZdMBulpkchlKzVtnZqLZGBMbRNCq
         Fyqw==
X-Gm-Message-State: AOAM533BjU3r/Q0mqyQ9Y+39CqWJU7oRrwczBzPuPmbhB9EMEZV553dP
        nOWVhUlRWuX1lXBJyv2ymsbLbN0432cR5RRySXCjXQ==
X-Google-Smtp-Source: ABdhPJwQ1nSjux4OA93qdZZpDmtAPc2tQg5ZNbInA+vx/OIZYknuqD5ptknS6RW8OMMayzqjHyxN+/W+PYunEdkNWck=
X-Received: by 2002:a1f:5606:: with SMTP id k6mr1088106vkb.6.1613132439488;
 Fri, 12 Feb 2021 04:20:39 -0800 (PST)
MIME-Version: 1.0
References: <20210209145214.10518-1-yann.gautier@foss.st.com>
In-Reply-To: <20210209145214.10518-1-yann.gautier@foss.st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 12 Feb 2021 13:20:03 +0100
Message-ID: <CAPDyKFrdoCWy5+xnFbMesBwACyK4zbPSHEUPA4YMAmO1ys3Sxg@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: mmc_test: use erase_arg for mmc_erase command
To:     Yann Gautier <yann.gautier@foss.st.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        ludovic.barre@foss.st.com, Adrian Hunter <adrian.hunter@intel.com>,
        =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Feb 2021 at 15:52, <yann.gautier@foss.st.com> wrote:
>
> From: Yann Gautier <yann.gautier@foss.st.com>
>
> Since [1], the erase argument for mmc_erase() function is saved in
> erase_arg field of card structure. It is preferable to use it instead of
> hard-coded MMC_SECURE_ERASE_ARG, which from eMMC 4.51 spec is not
> recommended:
> "6.6.16 Secure Erase
> NOTE Secure Erase is included for backwards compatibility. New system
> level implementations (based on v4.51 devices and beyond) should use
> Erase combined with Sanitize instead of secure erase."
>
> On STM32MP157C-EV1 board, embedding a THGBMDG5D1LBAIL eMMC, using
> MMC_ERASE command with MMC_SECURE_ERASE_ARG may stuck the STM32 SDMMC IP,
> if test 37 or test 38 are launched just after a write test, e.g. test 36.
> Using the default MMC_ERASE argument from framework with erase_arg,
> which default in our case to MMC_DISCARD_ARG does no more trig the
> issue.
>
>  [1] commit 01904ff77676 ("mmc: core: Calculate the discard arg only once")
>
> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>

Applied for next, and by adding Adrian's ack from the previous version, thanks!

Kind regards
Uffe


> ---
>
> Changes in v2:
> - Drop patch 1 from the previous series
> - Update comment
>
>  drivers/mmc/core/mmc_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
> index 39a478874ca3..63524551a13a 100644
> --- a/drivers/mmc/core/mmc_test.c
> +++ b/drivers/mmc/core/mmc_test.c
> @@ -2110,7 +2110,7 @@ static int mmc_test_rw_multiple(struct mmc_test_card *test,
>         if (mmc_can_erase(test->card) &&
>             tdata->prepare & MMC_TEST_PREP_ERASE) {
>                 ret = mmc_erase(test->card, dev_addr,
> -                               size / 512, MMC_SECURE_ERASE_ARG);
> +                               size / 512, test->card->erase_arg);
>                 if (ret)
>                         ret = mmc_erase(test->card, dev_addr,
>                                         size / 512, MMC_ERASE_ARG);
> --
> 2.17.1
>
