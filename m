Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1FE832A9AA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 19:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1581222AbhCBSlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 13:41:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448909AbhCBPnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:43:16 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92E1C06121E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 06:44:49 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id e2so17060306ljo.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 06:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9feuLaRLYMtlgGOGr1daR8c2TEzfBi5+yLsyG2URtB8=;
        b=JklTdr9IlRTbGAiHM56tbsNizr51DdFen7QQqTNEe4+kXWl9RFHlr+d7N01dM/Wz/d
         bjnKc3qF4JXg6T/br+HXQP5dFpy0VNrIseTx3vedOER4EewKzx++0XzXXfKKPX93Tiwr
         4ug2KpGIDbEnZmlgs3e3QoR+TTFrHIFppXsivwPcnGVfo+YNfAPdAWpEOTrLfeeC5TW1
         +KAIlbavTCMgD2YNW6y05ODzsplG9RQndFYanGBz4i0kCe3C0N5SRlrxxHSxmKW1p0lt
         dW+a52TlO+LKTrHiUpQ5ks0mnsgLXH1e4gU5ymC0IiNdVrH2xZAIVy1brxo5eytkM2sB
         mUcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9feuLaRLYMtlgGOGr1daR8c2TEzfBi5+yLsyG2URtB8=;
        b=JIe1FPpU9OVlkUZb4GJ+OcOxAPKrNZqk38VW0eqD8eiq6CW0eC6b2QSAVkVfmNBCGC
         8I1F6vstBNpjw88uthEBbHwm1zrdt8oNi9c1fRIMSBS5jXyUY3m7ffQUD7HvCFZXZlTJ
         7v5iuZ5xEKpGiu71VfNCQeldgoJ1C9JZOp0ywsvuYBBq10wADx2L3+ink7HZDdloc8u8
         ktql6b2mpgQmhgYBfwu3ccFd7tPVBcg7jAXLBPuZWRKHOp0WmfJOue11BWWaV6sErl5f
         koZ4iGSKfvU4sI5EWB12PPITVwWgnLOoA/VuMx8okkGb3C7LVvzklLEnfk78RoM0mKOb
         kUjw==
X-Gm-Message-State: AOAM530HpZY8vyQrCTliDkDd3lrIlmTlF1sn6Jn4Cq1k7Lc7y9yPkPAF
        JcgUBCmeKh8OQe6EFYc9CSk8D2d+8dO/MmLnlpx5rg==
X-Google-Smtp-Source: ABdhPJwUwDB4hBw580rpuMjcCg9Rc9naVpfnsju755C/7VCHrkfYZ4JZhz3B2iBHv/f5gsNYiaB5FME/2iHR6jMAthw=
X-Received: by 2002:a2e:9cb:: with SMTP id 194mr3203087ljj.438.1614696288299;
 Tue, 02 Mar 2021 06:44:48 -0800 (PST)
MIME-Version: 1.0
References: <20210224185316.17942-1-brgl@bgdev.pl>
In-Reply-To: <20210224185316.17942-1-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Mar 2021 15:44:37 +0100
Message-ID: <CACRpkdZ915TABrSt0A_1tM3Jt_op4gcCY1b-d2ocM7wjKJFoPA@mail.gmail.com>
Subject: Re: [PATCH] selftests: gpio: update .gitignore
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Kent Gibson <warthog618@gmail.com>, Shuah Khan <shuah@kernel.org>,
        Bamvor Jian Zhang <bamv2005@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 7:53 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> The executable that we build for GPIO selftests was renamed to
> gpio-mockup-cdev. Let's update .gitignore so that we don't show it
> as an untracked file.
>
> Fixes: 8bc395a6a2e2 ("selftests: gpio: rework and simplify test implementation")
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
