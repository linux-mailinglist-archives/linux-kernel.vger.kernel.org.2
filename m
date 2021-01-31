Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 896FC309F21
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 22:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbhAaVjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 16:39:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhAaVjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 16:39:03 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88EEAC061573
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 13:38:22 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id i71so1426308ybg.7
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 13:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NJU/3nLWfYE6pExP6qKy6M7Ia1JZ9MD5Cnrrl/f4oLc=;
        b=Y+1tg/H1Xmx7A4aTCK/ZDj0zKR48+r+xKEsp02jI2bykn8ngL9Z03SNKVaO7Njjn2E
         XZM7yd5xsTDewfMVV3Xvd7DzXf2HEsQRQEbwvGbiHLpB3v3VyWCXgkDgRMdHutG2TsYr
         CpYCd1maTZwD2fqAS9ZBWiDq68sUNFnaCydO15H3zZvFsxsrFYX0nzPEETc5rtg3FYW1
         tECluSTl+oXOLNRfaCpxvZWIPlHM8oPYemQuyljAO9bdKWvPYCNgBL2ShNSHZfOT47O9
         KyfhgkN8W6p3c2Yy8jKCl6azv//27bKOkLXMw2r0KvbIMVDI7M8VtJsJ1JFMpPl8G1ew
         Nh2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NJU/3nLWfYE6pExP6qKy6M7Ia1JZ9MD5Cnrrl/f4oLc=;
        b=SPHWy8+6CjrwQ8FGRyR9xO5ahPNw2SNBOSl/XIDAi4uC+Xe5ffhJkW87CWyMD2vi6l
         Cf8tTqWf8rbdfdn8FQ1W+x2PvOtMoRly9bf2jaedgrt9zZak87TTglvrLb+z2ySelhru
         HdTNtiuekAjxyyDjarYLdow6JCfGv8nnfA6cE9dybYQ/2tG6d6OTedmyQtE969JdXrMS
         siDBG8m1kY9d+GHs5D6TaaZZozJ2gzWRL6c2yV2WaC2pPog9X3RQnpyIIO8oLSO0tjno
         BSX9noFF5+nZjDektRW1SltWHzyJH2X3AQDc2s+2HuI61UkSGOJbs22wg5iH3KMFgp5f
         E0sQ==
X-Gm-Message-State: AOAM532hwd4UmFR23yhEy/49GM92J4L2cYRT7lqMknI+83beOe0u3M2k
        HgZovQl32P05WMbERz/NeKwHaEdZUBF/zVBDycS8aA==
X-Google-Smtp-Source: ABdhPJz/13wWoQdSbZnWPMrkTpNSQb3LIC9NeVXKKd6iyCDn/zPoL2mUGoD6gLMrbhIq163e5RuMecC98dFMYWfF22Q=
X-Received: by 2002:a25:cc89:: with SMTP id l131mr19432852ybf.346.1612129101478;
 Sun, 31 Jan 2021 13:38:21 -0800 (PST)
MIME-Version: 1.0
References: <20210130040344.2807439-1-saravanak@google.com>
In-Reply-To: <20210130040344.2807439-1-saravanak@google.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Sun, 31 Jan 2021 13:37:45 -0800
Message-ID: <CAGETcx9Qg5cwMckeqxUCrf+e4d49Ph-yPYPfHMzUQLYR9jsdNw@mail.gmail.com>
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

Actually, thinking more about this, we should keep the gpiolib patch.
It'll ensure the suspend/resume order is always correct.

This series basically gives up on creating device links to firmware
nodes that don't have a corresponding device added. The gpiolib patch
makes sure the nodes have a device that corresponds to them. So device
links will get created to the gpio_device and will make sure the
parent of the gpio_device doesn't suspend before the consumers of the
gpio.

-Saravana
