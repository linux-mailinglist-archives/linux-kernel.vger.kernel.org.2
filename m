Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 801ED35B744
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 00:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236103AbhDKWjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 18:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235229AbhDKWjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 18:39:11 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307DFC061574
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 15:38:54 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id r20so13046867ljk.4
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 15:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GlzJVbgzEzxyFk4ld79xZfr2eJxUUsHtNzopxs0DmQk=;
        b=eHJWPpZvi7CEukspll+MNgS0TRFIeP+xuS90jJPT1Au3ajrEKr2wUgaQ0jMlhehYb6
         OZs6wurt38e7KQkVpxWOFbcWiRnyFcg8cdi2u+5MvcHEsfOQUqrqVjSgrkSqedB7z64P
         nwHTZhhr+O9oR7UTaFvPtXYrW75hG2WHKwveRlKcv8Oq8VMN9sD2dykvKF25nV0zxx1z
         Y0u/hGSVMw9BW3ws3YxIjJHb/yUE6VAHT0oqIzPVggF6cRncjQVfZ132qHYa8ISXFKX/
         coWpPJInN6Gv3CYgwX6N20odDxF7Ta6FCC1CcNNeiLE5R4BhKKOkNDJ+b19jPM2BTwLW
         HkaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GlzJVbgzEzxyFk4ld79xZfr2eJxUUsHtNzopxs0DmQk=;
        b=DJsOkxtmLjxO03QdRKmIH6XxLMyEA/J0+mYnNuO4oCCri2d2QoXyKIO6oK19WiHHtF
         q5SfcakTgZvhQteNRYB4p+iZDq0/9VtCUNavm7WMYHpCKLE/WxGYuZw/n7XiiyWONbAC
         Dq7cU23FktzkxcuYOumBLB40h/ktXTnk+0A9IqtkxxvCbFQnQmzEFLp4eMytgx4wPRrk
         zxNejkrm9hURzAVISXk47L7e/F78DEY8RTvR1fc+1YvOyTxlsfepHjjrY8lfAYPSuVtG
         nxalJXu+cbWezPPpCwPDX37HKRBZug9ALrgRGMbpXX1ovTJ9AQ7BVydeB0FFjCE9Q6Xq
         5sOA==
X-Gm-Message-State: AOAM532T+I8gIPWn1kU7V+Rq+aji8XbZoixebk1QJZwlYnrY33LiGJKZ
        ZYG4xgDkE/urF7knEurWip+MKOHhi1fbGbFybvGcoQ==
X-Google-Smtp-Source: ABdhPJznZiIjuSNH752uSYR7rwq3n6+T7BfX/4X8zRIeZZumq2SzIb5+ymgeuQaEIF1IueX0mHbH7lFKLILO+C+OFLI=
X-Received: by 2002:a2e:7001:: with SMTP id l1mr16203459ljc.200.1618180732649;
 Sun, 11 Apr 2021 15:38:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210407034927.16882-1-dinghao.liu@zju.edu.cn> <20210411160720.037c405c@jic23-huawei>
In-Reply-To: <20210411160720.037c405c@jic23-huawei>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 12 Apr 2021 00:38:41 +0200
Message-ID: <CACRpkdYrRi3pa6Gw4_Q+P=WYbv-a27FHmOupKVv5s=yU53RFWA@mail.gmail.com>
Subject: Re: [PATCH] iio: light: gp2ap002: Fix rumtime PM imbalance on error
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Dinghao Liu <dinghao.liu@zju.edu.cn>, Kangjie Lu <kjlu@umn.edu>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 11, 2021 at 5:07 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Wed,  7 Apr 2021 11:49:27 +0800
> Dinghao Liu <dinghao.liu@zju.edu.cn> wrote:
>
> > When devm_request_threaded_irq() fails, we should decrease the
> > runtime PM counter to keep the counter balanced. But when
> > iio_device_register() fails, we need not to decrease it because
> > we have already decreased it before.
>
> Whilst agree with your assessment that the code is wrong, I'm not
> totally sure why we need to do the pm_runtime_get_noresume() in
> the first place.   Why do we need to hold the reference for
> the operations going on here?  What can race against this that
> might care about that reference count?

pm_runtime_get_noresume() is increasing the runtime PM
reference without calling the pm_runtime_resume() callback.

It is often called in sequence like this:

    pm_runtime_get_noresume(dev);
    pm_runtime_set_active(dev);
    pm_runtime_enable(dev);

This increases the reference, sets the device as active
and enables runtime PM.

The reason that probe() has activated resources such as
enabling two regulators, and want to leave them on so that
later on pm_runtime_suspend() will disable them, i.e.
handover to runtime PM with the device in resumed state.

I hope this is answering the question, not sure.

Yours,
Linus Walleij
