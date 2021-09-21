Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D05412E3A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 07:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbhIUFfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 01:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhIUFfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 01:35:46 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CF9C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 22:34:18 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id r5so1297326edi.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 22:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=raCTCJXxXg/ItVbRzM7CGl3oXuyIE/XxbNyI6hSTq7E=;
        b=KrZNpc22Ky0v9hnMfwLmqJTdXsD8std2aRtIrgg5SnHJEl7l2E8YA5OCEur0iZ7EYL
         /HnvUPw4q6eF87hlO/0oqmOhrh8l8bv0qWl9LXV6kTish/c+Gv3CiQRBfLZyaq3ExmQ0
         NwJA86w4VXwQ+MyixtGSeaDJOTfGf6GVMbbYZwdp9vDT4KTiR7vl+Vy4qIXHQHcdytV/
         UxL9JbPldCuFnIAfipYqKpPYQL4OCfsZjf899aclIvtIqVsKLQ3bg+4UyYrKGtNjxV8V
         +E2PX77CJf1r2xbb8wGA6Azma2z3C54st8nc2x0GHZfN6Y0KyzD+YNm3Mc8/MWJwgJPR
         rvoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=raCTCJXxXg/ItVbRzM7CGl3oXuyIE/XxbNyI6hSTq7E=;
        b=5oG/fHV2FE+pZs8PZbS1ma70EGnVd/DSAlwl+HXLdio76h0gxwdWYka/eyWsa6t3dk
         lQy/sZYRMN6npl5qnI2/yEtvB1u2yOeLj+0z9JrCvNPfxeNyBLoMY8/byuyVuUjwTth3
         TR5H8XAA63KRdKdI3gkVftrSLKtUmuz/F7321JHaRIIS1xP7BSw6x1qdXwfnV3fKBeIX
         5RlV34/f42M1DGZxYb+tbFNs0FGiKsF93EinlJuVKowj59kz0e8tv1/39Wc+P64HBRzw
         Qwi8igC+PT7C3KFtOslwWOJIQxaR3FhwN2vcB9L4gNc3Lg9DiknvN8gYF3Q36Nczioid
         5yBg==
X-Gm-Message-State: AOAM530LBu5Zt1LaXhesFgCXA+k3bqBSZ8pQWZ9JojkFocfl4ic2rc/g
        ckcIbMdFnsKLYLwEkFMu53nFsYBFglaeLN0hsSc=
X-Google-Smtp-Source: ABdhPJxK95W+u/Y1+Ydk4XFb2GShNgBwLsQzG9NQtWZFjqU3HFcA0JJgOlldIARODeZSSAWoXyJkXXkox8nv02jUuN4=
X-Received: by 2002:a17:906:e105:: with SMTP id gj5mr32019021ejb.408.1632202457171;
 Mon, 20 Sep 2021 22:34:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210920203735.675-1-linux.amoon@gmail.com>
In-Reply-To: <20210920203735.675-1-linux.amoon@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 21 Sep 2021 07:34:06 +0200
Message-ID: <CAFBinCB682kFB47=K5-Pod5cbrnNTtKdAj3i8PHrxj8VxOH8FA@mail.gmail.com>
Subject: Re: [PATCHv2] regulator: pwm-regulator: Make use of the helper
 function dev_err_probe()
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anand,

On Mon, Sep 20, 2021 at 10:38 PM Anand Moon <linux.amoon@gmail.com> wrote:
>
> devm_pwm_get() can return -EPROBE_DEFER if the pwm regulator is not
> ready yet. Use dev_err_probe() for pwm regulator resources
> to indicate the deferral reason when waiting for the
> resource to come up.
>
> Fixes: 0cd71b9a43ad ("regulator: pwm: Don't warn on probe deferral")
Personally I consider this as an improvement (having the deferral
reason show up in debugfs), not a bugfix.
Because of that I would drop the Fixes tag.
Let's wait on other people's opinions though.

[...]
> -                       dev_err(&pdev->dev, "Failed to get PWM: %d\n", ret);
> -               return ret;
> +               return dev_err_probe(&pdev->dev, PTR_ERR(drvdata->pwm),
> +                                    "Failed to register regulator %s\n",
The message here should still be similar to the original one since the
actual problem is that we could not get a reference to the PWM
controller. At this point we are not trying to register the
pwm-regulator yet.


Best regards,
Martin
