Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7449637544B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 15:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbhEFNBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 09:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbhEFNBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 09:01:38 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CABBC061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 06:00:39 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id x20so7667477lfu.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 06:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=co6Tu6p7gwdreS8j+kzhyH/BpJmEW7gcEZ8FRox2VLM=;
        b=imjkp9zgX91dHPVMnXtZjX6RL8An3N4T5kLaqqZ6UKOJo9faTrNHFaPZELcNYuaypq
         uQ0/erVuIlCfOsrMExtH/3x/rE9AIDaoYdRD7IrMtbmzzNF+jCZ91F3hF4DXulvJ6zP/
         MuHOWqMS5MWRUIAAm/gj0Ow6coQgPBzRVIiF0tbBbonfjtA0fkRH7Ofu2gJc4sFh4VdW
         sMUdEY07akP+Z82iHfIBKrK5uAdOQyVWleVZtjHg9DWsguCqgfIU/qgMkTmCwb6F0X6c
         dykfROgNLyZEnLXx3Ol6DzFYXh8Gi3IuCvomWSHe7l1JjMTLqe1pyPpxL6b2H45b1H1J
         TQag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=co6Tu6p7gwdreS8j+kzhyH/BpJmEW7gcEZ8FRox2VLM=;
        b=SArrZfMa4hchaBsrIifmoMDJO/mAIyciPNlcPT9PuLrSxwbd7l6Kuc3w+RxhFtQ1s0
         Qg/tGXX+dAIzGlZBy+fngSrVqnBuT43ojASdrXWD5xqY5RGCfvQ1DqOYfB04dv0KERCt
         n4WJBUJacG/c2K+A1Jn8nC9eNjhOviPGMv+DhXT3ipdX0o4DD21LyKkmEGQej5wKhK4R
         sNDGg3Tlj81DUcgUQuWPGF0D+uCLvYJJXh1CjRYRTlPAQH+93iX21v/QmCWyl0TQ1dGC
         k6YJ2D30Q918u/cpPdb9mDP5UwN61Ec9Y4pRYXJrY7mx4RkqV9yR41m9KVTuMqJvFHYP
         0SDQ==
X-Gm-Message-State: AOAM5320z4F9kFO2qZadJDFf0PsvQATmnO/IhxsmTvKpP+OCUpDd2M0x
        SfK558Q0vEOa5tfuE9gDB5thhGtKxLnrFzI14xbruQ==
X-Google-Smtp-Source: ABdhPJwechm8k/LJgQ4yWdTtDYG9Go8iYVJJpJ+sWs2TdhwxF8w4kKFdR4XnUVrgxVAIpiJ8CaDV03AcGU3DFLg9ZH0=
X-Received: by 2002:a19:a418:: with SMTP id q24mr2688212lfc.649.1620306037628;
 Thu, 06 May 2021 06:00:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210504161222.101536-1-ulf.hansson@linaro.org> <20210504161222.101536-7-ulf.hansson@linaro.org>
In-Reply-To: <20210504161222.101536-7-ulf.hansson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 6 May 2021 15:00:26 +0200
Message-ID: <CACRpkdZUWP5hOCLpVvOSfR3YNXF6HC4GaO5ptYify2_EPa=wOQ@mail.gmail.com>
Subject: Re: [PATCH 06/11] mmc: core: Prepare mmc_send_cxd_data() to be
 re-used for additional cmds
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 4, 2021 at 6:12 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:

>   * NOTE: void *buf, caller for the buf is required to use DMA-capable
>   * buffer or on-stack buffer (with some overhead in callee).
>   */
> -static int
> -mmc_send_cxd_data(struct mmc_card *card, struct mmc_host *host,
> -               u32 opcode, void *buf, unsigned len)
> +int mmc_send_adtc_data(struct mmc_card *card, struct mmc_host *host, u32 opcode,
> +                      u32 args, void *buf, unsigned len)

Just a note here (the change is good)

When applying please add some kerneldoc above mmc_send_adtc_data()
and expand the ADTC acronym and add some info explaining what it
is maybe a small protocol ref or so, so readers of the code get an
intuitive feeling for what this function does and what ADTC is.

Yours,
Linus Walleijq
