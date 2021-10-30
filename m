Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF97440884
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 13:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbhJ3LXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Oct 2021 07:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbhJ3LXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 07:23:32 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B1CC061714
        for <linux-kernel@vger.kernel.org>; Sat, 30 Oct 2021 04:21:02 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id h20so13377811ila.4
        for <linux-kernel@vger.kernel.org>; Sat, 30 Oct 2021 04:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fzrPWdrYK+uGIZVarnBib+gCZxAPn922Wg+8PFfxUYY=;
        b=hV54KDjgIxufXu2nlKaNsKyOfyFdkMFTxuESLgZDLcZGzORWjUCZGPmiV36nrZifXu
         now2fZpFn3iBm2cOniogtpXbg8JKzpgy0sNyFGPQ6DWOfcXOq/DrhNyEai+pq7ci6Q5O
         En4ot6pZd2hSDgERZPTSsFvefeTdLrWRSecqHS4P18dD7AI+1Axvh0gFvmxuLs1V8O2q
         fXkXKIEVepkOWH3Tc97RBf2XeS2FGpWv8TmNjD4h8+4OjVAhgLfnSZL5LuJMCf0Hs7dW
         PdpQGH6h462Xl37NZbF/3BtDMB8v1Qu3SVVdLF7ZunpEVPK/buy3zAJZNkrFx/EX51hx
         9MdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fzrPWdrYK+uGIZVarnBib+gCZxAPn922Wg+8PFfxUYY=;
        b=lWFKm5rSLcagdcVw7gHsv9LC7v+PgwzN2vXPrQJN4o1edjOHC5dXwm4QSOk9qY6zzT
         JQLnXPMFVp6D+S23fGPSyO3iCb0Eu5dyv60dmpuzLdd/WHASbQvw1vbFe3h3GVKoPx6D
         5UV8y/UtRIMzddTmxaMLCL2QfT65JhofTpCl1/cf1gUQbYvjEyf2OuD0UG1Z1hWGfljF
         1fJJMTWB58geW4cDFAvhUl4q43DQgfwOnovEgMg1398n4OKkMjt1VuHYTGgOa4YXn9SB
         RST8EupXBLhrWLAxCga7/FUz4Q24AFfyn9kmH4ADzVoq8e5GEAYDhpeXx8CNkGpkKXfc
         N8KQ==
X-Gm-Message-State: AOAM533XhU9uHxE4s1uI8ziYHVFFmTT2GaXc+JbDgLREeqCR6SF2laso
        OL1RhTp0Wq5xCIawkRnFbYIeRRkDQ9vJ+3jVU3kUEwt1q6/ETg==
X-Google-Smtp-Source: ABdhPJw/kzqj41zeqc4IU3MmFJ/HjzaIYIBb1AsGPPQtCFEpf+XRw7egBEmj0MwxE2dp/sHgp6UXzfxES4guaa1wvQw=
X-Received: by 2002:a05:6e02:2187:: with SMTP id j7mr6049830ila.323.1635592861248;
 Sat, 30 Oct 2021 04:21:01 -0700 (PDT)
MIME-Version: 1.0
References: <YXqv339PJTHcGxJg@fedora> <20211029111232.soknq7mu3r65laar@pengutronix.de>
In-Reply-To: <20211029111232.soknq7mu3r65laar@pengutronix.de>
From:   =?UTF-8?B?TWHDrXJhIENhbmFs?= <maira.canal@usp.br>
Date:   Sat, 30 Oct 2021 08:20:50 -0300
Message-ID: <CAH7FV3md_SBTHu9sTp-hLtLd0ERBdXx8HzM=W9hF79X5V=twQA@mail.gmail.com>
Subject: Re: [PATCH] media: ir-rx51: Switch to atomic PWM API
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Sean Young <sean@mess.org>, mchehab@kernel.org,
        thierry.reding@gmail.com, Lee Jones <lee.jones@linaro.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Uwe,

> Doing this here introduces a change in behaviour. Better do this after
> pwm_get().

I didn't really get this feedback. Isn't pwm_init_state after pwm_get?
Or should it be before the error treatment of pwm_get?

> Conceptually this last hunk belongs in a separate patch. And you don't
> need to repeat PTR_ERR(pwm), as dev_err_probe already emits this
> information. So
>
>         return dev_err_probe(&dev->dev, PTR_ERR(pwm), "pwm_get failed\n")=
;
>
> should be fine.

Thank you for the suggestion! I will fix it on v2.

Ma=C3=ADra
