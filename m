Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD19D31DFC9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 20:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbhBQTn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 14:43:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:58244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233314AbhBQTnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 14:43:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9658464E45;
        Wed, 17 Feb 2021 19:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613590981;
        bh=LlwTiP8/hl3yvWK78ty94eQWzvbMMEBmhJXYr7fFCGw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LeXPpXW9sSFaAMYkPWATCI2c1AmR8XraBwEzu5gLRubwCcRT9TpTY5pdqFijlZ6cS
         sNYSONm5cxfkGtWN6CCBpsMNab/3Y9Jkkna3UoBYjbVUm6xU2OyKzHdkydxAE6G+Uu
         z7+jerCAAEivb+o496+evKQQTz3YGqqTAHvJtJkEtiS0IzVKfq8tNm5kdC1LgQRiIQ
         PsXfC+u33/sKbcm7fzUsnaWVWzJ/yYEhjahbNpE6EwUdjmXQM3dVHFemrJpGaSqfFV
         Gibb4YwNeyZStStpMRIIPS99PbQ+x7YjBmwAbjZ+hzRItz8MLJqCZiLoi9nitzKnjk
         hKBUCFah2uQSA==
Received: by mail-ej1-f54.google.com with SMTP id f14so24334673ejc.8;
        Wed, 17 Feb 2021 11:43:01 -0800 (PST)
X-Gm-Message-State: AOAM531s01eQyS4tnsrN+EU1SxiYMRuzy9973VLuoLnDuBkH2sFPGn2w
        4zAhEDHpuE537cLPD6iEIC3Nm7o6vTGeq99POw==
X-Google-Smtp-Source: ABdhPJzAMNa126EXLIevgRQHmZuiDRjOGeslDBdTqUCA1s4KD+K8imQWfogzr0YaUNopBqs64UbcpGOwQFT9y0JO5q8=
X-Received: by 2002:a17:906:d1d0:: with SMTP id bs16mr553549ejb.468.1613590980184;
 Wed, 17 Feb 2021 11:43:00 -0800 (PST)
MIME-Version: 1.0
References: <20210215224258.1231449-1-saravanak@google.com>
In-Reply-To: <20210215224258.1231449-1-saravanak@google.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 17 Feb 2021 13:42:47 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKQ=J2KnUL3EN16p5uPLnF3kHqUU_82FMt9g_yWYBrm_Q@mail.gmail.com>
Message-ID: <CAL_JsqKQ=J2KnUL3EN16p5uPLnF3kHqUU_82FMt9g_yWYBrm_Q@mail.gmail.com>
Subject: Re: [PATCH] of: property: fw_devlink: Ignore interrupts property for
 some configs
To:     Saravana Kannan <saravanak@google.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <treding@nvidia.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Android Kernel Team <kernel-team@android.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 15, 2021 at 4:43 PM Saravana Kannan <saravanak@google.com> wrote:
>
> When CONFIG_OF_IRQ is not defined, it doesn't make sense to parse
> interrupts property.
>
> Also, parsing and tracking interrupts property breaks some PPC
> devices[1].  But none of the IRQ drivers in PPC seem ready to be
> converted to a proper platform (or any bus) driver. So, there's not much
> of a point in tracking the interrupts property for CONFIG_PPC. So, let's
> stop parsing interrupts for CONFIG_PPC.
>
> [1] - https://lore.kernel.org/lkml/20210213185422.GA195733@roeck-us.net/
> Fixes: 4104ca776ba3 ("of: property: Add fw_devlink support for interrupts")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
> Greg/Rob,
>
> I believe this needs to land on driver-core-next.

Acked-by: Rob Herring <robh@kernel.org>
