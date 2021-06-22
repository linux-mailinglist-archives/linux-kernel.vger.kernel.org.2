Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 786F13B08A0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 17:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbhFVPWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 11:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbhFVPWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 11:22:49 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4405EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 08:20:32 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id j2so36601722lfg.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 08:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bpqGkk/JGVe/MnPyoETv0p8uKc3pSJj4YexxopDDd2U=;
        b=WLtAFBCczgLWoAx5u/xKxcRWJO0HNR6yVqDk+l8R3m+JsOWedfC6dxPJ0mhagcz+5K
         pzjeCg9kaBJUrpA2ySWvC5cu6MfVaxmxHmNjq2FNGbWzWw4/7Y2IKQXHnAR0CtM0spvG
         6ql5tmTlMHQNAGJ2lOmr7QKkejf+ZwcjpfhlvwZVgToxzbfSrYren053WLBLciXXr7AS
         bvggn8Kiz0A3YCR9fNo1hIfKyk/0ei3k7nRWo1Y0j944cFgoxzbUwTWlnLMtJre4oqZN
         znE/RpQ6dhr/I20sFxQDyiV2Txk8sOqA7IFz0r2LCkuZYgmWccid1xu5pOCRtWPLnUaO
         bWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bpqGkk/JGVe/MnPyoETv0p8uKc3pSJj4YexxopDDd2U=;
        b=kUG3h7FKzTDohS8YTgd7Ip81UiGPxL5artGg73lCKx8/SGx3Vcr3YPI1moY83vxYZn
         2xWuoBtR6fAa3usHz3z/mQfmHURTJZVqVcu3ZHBLMLLUl/J4sG7tPWLsLnDQ6zEQeHNm
         B+rlThDY/r5clsuvya7+oRR3LjuOLXphXYE9oBEOotn9LtHiQRXy9XJdr1WTbwso5jqG
         qrRpcGX34Mpq6f6//8PRpMb6jeksb+NfVKwR+e+GZm8nG9lsV2k85MGq9GHrh+PRt/H8
         Iqgh6uMgQKFI2+Lmc44W7+ZGXprTrTzfei49UeSdhSBxSkkhZYToiOGvEHECJf4zvGT+
         2eig==
X-Gm-Message-State: AOAM533mFLSFaLnFqlR47bkplg5XPGNNWkDteNAx+6i/vycKlzHW9IJW
        d1W1j+xKnzRjKQZ7+N4K1oc1I5ErLwmnDzC3BoM=
X-Google-Smtp-Source: ABdhPJzlzy1eLbw1J5ldiP+ql0q+z9KvG3TP9jztXX37rcURHYnYtIPG00PB5rkr0m28KIYSpdRMxVt50kjP3cde070=
X-Received: by 2002:ac2:4d25:: with SMTP id h5mr3257357lfk.583.1624375230527;
 Tue, 22 Jun 2021 08:20:30 -0700 (PDT)
MIME-Version: 1.0
References: <1624365084-7934-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1624365084-7934-1-git-send-email-shengjiu.wang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 22 Jun 2021 12:20:19 -0300
Message-ID: <CAOMZO5A_0KncwCgfZ6LSAO-LA01U9LS4=Hopn-_9qj8cv1Qhmg@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_spdif: Fix unexpected interrupt after suspend
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021 at 9:50 AM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
>
> When system enter suspend, the machine driver suspend callback
> function will be called, then the cpu driver trigger callback
> (SNDRV_PCM_TRIGGER_SUSPEND) be called, it would disable the
> interrupt.
>
> But the machine driver suspend and cpu dai driver suspend order
> maybe changed, the cpu dai driver's suspend callback is called before
> machine driver's suppend callback, then the interrupt is not cleared
> successfully in trigger callback.
>
> So need to clear interrupts in cpu dai driver's suspend callback
> to avoid such issue.
>
> Fixes: 9cb2b3796e08 ("ASoC: fsl_spdif: Add pm runtime function")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
