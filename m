Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9438930B150
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 21:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbhBAUGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 15:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbhBAUF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 15:05:29 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A60C061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 12:04:49 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id k4so18120354ybp.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 12:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L9sw9hSS8Z/uEqXF5ukYAI1b9wH2rffWPop3oA1u9N8=;
        b=OaqXg573LwGDOY7qNJNrh0QcBeqsUIIqangIggwrbBQxOBAtBk3cpdcdqa2WsrVSS2
         laGL44tiLg1XML8BpM1iubpZljC7ujabB9YqWWAdNvvTZgQzuTE9+OO8/JkhCszWCvNv
         LrxCQeksu44w3KXdZXVK1HUeoBD/nP1TJub5dyxoB6NOkN4sBiBXm26tmGqhhOKPK7C8
         kUo91KC2IK7GUrmmCz1/CGH7H1GK/IzjMDzoTMhzf0Ac4nl7COJGy6l0plw/GiPX/H5B
         mfD9sO3BVpSlv61DGdi+uXE1iG5Ct92fELaimdzlNifeFGUB2wl92f1tL4+b4IvWDjk0
         zyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L9sw9hSS8Z/uEqXF5ukYAI1b9wH2rffWPop3oA1u9N8=;
        b=fxUShGy11QylTWVMuZKiQ4OgLgfiZvZP9i2uOXXhS3ci/vNN9xgR431ePprSRRHy3a
         Pl0hBM+4GUshjJ7Jh4GIQOyj2ABOhggiJ5I+RunH++liI5F1yUea5kXwT7PHBzjQKu8w
         7o33dDdCKD3wxJq0+T6MVeB2SkFyAqH9wQP81WyUoZrF4zeLQU9z8XVzTCNyuQii1JOR
         PZVC7W2pJOjdA9uYwIw33+zwRv9/LlG9KsvpBAOhY5Unac01byirNIdvsuZemPiU7WU+
         Czubp1kq46ck2DeWq/pt+/uIYMTwin1J/1laJ9DfHCrL3SwMKaZGThcBUHD0DqtqUY8j
         HJ8g==
X-Gm-Message-State: AOAM5304cTk+z9jTFwbHXEkmc3jGuHketI3ssiGYMGZ2XxnFd0RPa6A7
        plxJHyyE6s9jAM3OBDiPiXtnrQkUfrqm0L/IYhBhwA==
X-Google-Smtp-Source: ABdhPJw4RFUaM2c3Knj9a5xMEVR7SKifxohoJtjamohf1LlW3VtIH11Ase4ZEm/ickH5qdpZf1yRO+hhRtckErqk53A=
X-Received: by 2002:a25:c683:: with SMTP id k125mr29048716ybf.32.1612209888649;
 Mon, 01 Feb 2021 12:04:48 -0800 (PST)
MIME-Version: 1.0
References: <20210121225712.1118239-1-saravanak@google.com>
 <20210131163823.c4zb47pl4tukcl7c@viti.kaiser.cx> <CAGETcx8A_+Y0sCLPdyeeT+rHOsAPsmg4LVn_ahF0NaD6hfRiZw@mail.gmail.com>
 <20210201105204.GA1467@martin-debian-1.paytec.ch>
In-Reply-To: <20210201105204.GA1467@martin-debian-1.paytec.ch>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 1 Feb 2021 12:04:11 -0800
Message-ID: <CAGETcx91CdvqYpSr6Eg45jrToEFLPBSgzMxTjHh=1rBqi8V3pg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] of: property: Add fw_devlink support for more props
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Marc Zyngier <maz@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 1, 2021 at 2:52 AM Martin Kaiser <martin@kaiser.cx> wrote:
>
> Hi Saravana,
>
> Thus wrote Saravana Kannan (saravanak@google.com):
>
> > This series [1] has a high chance of fixing it for you if
> > CONFIG_MODULES is disabled in your set up. Can you give it a shot?
>
> sure. This fixes things for me if CONFIG_MODULES is disabled. Booting is
> still stuck if modules are enabled.
>
> > The real problem is that arch/arm/mach-imx/avic.c doesn't set the
> > OF_POPULATED flag for the "fsl,avic" node. fw_devlink uses this
> > information to know that this device node will never have a struct
> > device created for it. The proper way to do this for root IRQCHIP
> > nodes is to use IRQCHIP_DECLARE(). I Cc'ed you on a clean up patch for
> > IMX [2], can you please give [2] a shot *without* [1] and with
> > CONFIG_MODULES enabled? Things should boot properly with this
> > combination too.
>
> This works as well.

Thanks for testing both. Mind giving Tested-by for [1] too?

-Saravana
