Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 618D63228A3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 11:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbhBWKLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 05:11:34 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:38462 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbhBWKKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 05:10:50 -0500
Received: by mail-oi1-f174.google.com with SMTP id h17so17103191oih.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 02:10:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0MlYBgfdK58hsknS5qunVqswD6LJ/9U9O0yXbfCCzBQ=;
        b=rot7C5uFpBF4gNG3B1kWdnJVfGh1lfhlXOYAbJPjXk3mUdL0fTFPuDsxc/+P3CmQRk
         WHd8gBEu6aVWshoz4LTYDAFVcXK8QHW3T22jpcgpsa8CnfM7raCnh0rfIVq6rXyuA5MM
         Hzqs/ErnvpID7j1kMFQoDg5bEW7yP5zOm5Rre4kiThy8mDPNmQDY26Q9zaAZWu/gIY6e
         9gT25UH2y6Yud2kGkQoLE7OGFyEXRzvidsdRtzdjUc2qT8OPmltaPLgDe+owTopb4vmq
         eORBsGlCR/oVuPQD57yK1cmJ1pz5j7/tAgY5Qzj0vraDM+bHDTTIEbBoPTEtEFvFLPkT
         bkVA==
X-Gm-Message-State: AOAM532dVvggrAMq2RylyMin0olE48dxWsqqthV8AL6hnuaw2kZfDNEc
        YInodnjP4G97V9CHWMmIpUQ/GJi2Q+IQp51Ac2TUlDYe
X-Google-Smtp-Source: ABdhPJxlU225Fd5JX2pcAtS5D/4cksptqGbxDEEIwJCMMIGPi36SNI4HODo0uFWj6GjkvTVk9NUa62g2DPG+UgmuAUQ=
X-Received: by 2002:aca:744:: with SMTP id 65mr18105788oih.153.1614075010194;
 Tue, 23 Feb 2021 02:10:10 -0800 (PST)
MIME-Version: 1.0
References: <20210217235130.1744843-1-saravanak@google.com>
In-Reply-To: <20210217235130.1744843-1-saravanak@google.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 23 Feb 2021 11:09:58 +0100
Message-ID: <CAMuHMdUo_2WPxDeckhF3nt2+p5eG=mpP84a_fWFZnXyeohqo0g@mail.gmail.com>
Subject: Re: [PATCH] driver core: Avoid pointless deferred probe attempts
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

On Thu, Feb 18, 2021 at 12:51 AM Saravana Kannan <saravanak@google.com> wrote:
> There's no point in adding a device to the deferred probe list if we
> know for sure that it doesn't have a matching driver. So, check if a
> device can match with a driver before adding it to the deferred probe
> list.
>
> Signed-off-by: Saravana Kannan <saravanak@google.com>

Thanks for your patch!

> ---
> Geert,
>
> Can you give this a shot for your I2C DMA issue with fw_devlink=on?

Yes, this makes I2C use DMA again on Salvator-XS during kernel boot-up.

I haven't run any more elaborate tests on other platforms.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
