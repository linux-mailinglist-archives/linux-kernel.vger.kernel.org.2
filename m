Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F9E3091EC
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 05:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbhA3E4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 23:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233684AbhA3EKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 23:10:32 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBFFC061794
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 20:09:28 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id x78so10949526ybe.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 20:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=95p8CDySwlEPpDyMemwHXgdfJvENumz8XyyNURaCtIA=;
        b=Z/9meVqdj8T+ALAcCeJw77pNOtJNfdwLquqgBeI7MsJLJgr4q5uiRQSuIphg7NEYj4
         Yjmz58xZLPUETS2oQIBsBsZA9behyuht2phPg9P2CR/uqJ/5Rk/OGxhX3mnm5NWLM+2g
         s6OcYGQRKUHbPGCke9sr5jkzDFRZSDbaaTrvhVOxkBiK2MamN9OxylWE5T+2Uwqj0XNh
         ko4f5rfcETYKBEHBXFFrBWSSP2O+sjjl7m9RqnLEYGdJeHApug0xSEpJxQcUVabXvl1b
         XIHanBpAfa1n9OXOSwxiTfp6IVLA0JBqgJr+9/C1BkNJNjTefxq/w5Prb7JQQUh3fwOX
         pGww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=95p8CDySwlEPpDyMemwHXgdfJvENumz8XyyNURaCtIA=;
        b=qAeIEplTaF2xnUxqhV7J4FKIi2kHonGQYil+AZjdxQ9Wg5KOt/0FNJLM5RrZ4IRaBw
         wPLjq5gwoDXUqm73kuvfQ3ChcHreBPD0ySXBd0Mfwo38xM4ddxgASodHQLgJeFe+OV9e
         omhdiyfZcDuk5tJwjX01ACBMPqRhu9uFYsJidh3SFCSeqDAFgdyXvkTXeps8OprcHubQ
         pOCXj81njmDABWqdIXU7z6zei3ImxRtHexT6dNgA0kqPsFkwxsTkOzpc425eJOYi38WD
         8LHDIkhsySrPUmeOVS801l3XaLitM5MzinWZbij+cOXI0N/gwePkGcEA0sPoi1WLS2cj
         rVWQ==
X-Gm-Message-State: AOAM531DI9Wm1F81n55JfhmpalgFfgj7b0pTIGu1+8/xJpPwkfVc7kKj
        oYiDnAavxQcmB463OE5Y5ukUTh1Cl6JOAeDNUc8FRA==
X-Google-Smtp-Source: ABdhPJyWaXzkEQNAG7mDAUSEr50DKKgO8Pep8vybHqn/Gg93Oxi9x+iBA2JO76g3tv7GVUUX4EAb7oNeSypFErZTWHE=
X-Received: by 2002:a05:6902:1025:: with SMTP id x5mr10579964ybt.96.1611979767538;
 Fri, 29 Jan 2021 20:09:27 -0800 (PST)
MIME-Version: 1.0
References: <20210130040344.2807439-1-saravanak@google.com>
In-Reply-To: <20210130040344.2807439-1-saravanak@google.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 29 Jan 2021 20:08:51 -0800
Message-ID: <CAGETcx941J7Zhrf=ZjO6PW0fiax5VXcV3gbsLQfM_wU_U0EnYw@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Make fw_devlink=on more forgiving
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Marc Zyngier <maz@kernel.org>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 29, 2021 at 8:03 PM Saravana Kannan <saravanak@google.com> wrote:
>
> This patch series solves two general issues with fw_devlink=on
>
> Patch 1/2 addresses the issue of firmware nodes that look like they'll
> have struct devices created for them, but will never actually have
> struct devices added for them. For example, DT nodes with a compatible
> property that don't have devices added for them.
>
> Patch 2/2 address (for static kernels) the issue of optional suppliers
> that'll never have a driver registered for them. So, if the device could
> have probed with fw_devlink=permissive with a static kernel, this patch
> should allow those devices to probe with a fw_devlink=on. This doesn't
> solve it for the case where modules are enabled because there's no way
> to tell if a driver will never be registered or it's just about to be
> registered. I have some other ideas for that, but it'll have to come
> later thinking about it a bit.
>
> These two patches might remove the need for several other patches that
> went in as fixes for commit e590474768f1 ("driver core: Set
> fw_devlink=on by default"), but I think all those fixes are good
> changes. So I think we should leave those in.
>
> Marek, Geert,
>
> Can you try this series on a static kernel with your OF_POPULATED
> changes reverted? I just want to make sure these patches can identify
> and fix those cases.
>
> Tudor,
>
> You should still make the clock driver fix (because it's a bug), but I
> think this series will fix your issue too (even without the clock driver
> fix). Can you please give this a shot?

Marek, Geert, Tudor,

Forgot to say that this will probably fix your issues only in a static
kernel. So please try this with a static kernel. If you can also try
and confirm that this does not fix the issue for a modular kernel,
that'd be good too.

-Saravana

>
> Marc,
>
> Can you try this series with the gpiolib fix reverted please? I'm pretty
> sure this will fix that case.
>
> Linus,
>
> This series very likely removes the need for the gpiolib patch (we can
> wait for Marc to confirm). I'm split on whether we should leave it in or
> not. Thoughts?
>
> Thanks,
> Saravana
>
> Saravana Kannan (2):
>   driver core: fw_devlink: Detect supplier devices that will never be
>     added
>   driver core: fw_devlink: Handle missing drivers for optional suppliers
>
>  drivers/base/base.h |   2 +
>  drivers/base/core.c | 134 +++++++++++++++++++++++++++++++++++++-------
>  drivers/base/dd.c   |   5 ++
>  3 files changed, 121 insertions(+), 20 deletions(-)
>
> --
> 2.30.0.365.g02bc693789-goog
>
