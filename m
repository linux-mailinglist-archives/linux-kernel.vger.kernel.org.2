Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6797D314610
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 03:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbhBICIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 21:08:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:58882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229683AbhBICIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 21:08:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A86F864E7D;
        Tue,  9 Feb 2021 02:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612836491;
        bh=Ltb9+BmwBOeM7mtAzRuVHyRilVNgXhqS09CXwZDOZCw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=by2HQ+5EloMJfvya8q6f6ahBhthPIMnIkN0CJu+KPXgOaOgq740hN1m9H3BbhFU5m
         9W09OeCvN8qF2P9otcrtue7SuFwfxfeBxbr9/5NIIrLS7G+zAdFoSMZ8ZmEj2vsFh1
         P8mENmBTc3bHCAEnuvQFgv7gvWK91EyfYF/tUJDiAKMts5YfR+uywp4gtpSX5ms+3C
         h0hygDF1LHMEZyQIOxXGqBJoDfPAivtfcof1fZwAJLHlKmvOAMUuvU55YTpZJWcxeV
         cz1lQqN1GcZNRUPAUgkkV5JRay+v7Joeqc6SU2rFVW6hgjznLOWsuN4dbiB4bHn00z
         P38ROfOKLmHiw==
Received: by mail-ej1-f53.google.com with SMTP id y9so28812472ejp.10;
        Mon, 08 Feb 2021 18:08:10 -0800 (PST)
X-Gm-Message-State: AOAM532iDzrwsvTmSJGhp5vHW3xIaUB7SGHmfX0OSNmZBWuVnqjMWSxP
        HJ+Xee56CejoVj+sjRToHj0vdDDvlp5xXJcT3Q==
X-Google-Smtp-Source: ABdhPJwFwMKgyM+S67pVy/bBXFnAdJXQkuS+LVViC01nwawVI35CCyVNoeIN4xO1suGpju+cYiArhcHB6PeT+Z/hQUA=
X-Received: by 2002:a17:906:4301:: with SMTP id j1mr19698263ejm.108.1612836489061;
 Mon, 08 Feb 2021 18:08:09 -0800 (PST)
MIME-Version: 1.0
References: <20210209010439.3529036-1-saravanak@google.com>
In-Reply-To: <20210209010439.3529036-1-saravanak@google.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 8 Feb 2021 20:07:56 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKHSkjY2LC_RucLr8HTNHuhY0ALQetOUBGUXcMGXpeKDA@mail.gmail.com>
Message-ID: <CAL_JsqKHSkjY2LC_RucLr8HTNHuhY0ALQetOUBGUXcMGXpeKDA@mail.gmail.com>
Subject: Re: [PATCH] of: property: Fix fw_devlink handling of interrupts/interrupts-extended
To:     Saravana Kannan <saravanak@google.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Android Kernel Team <kernel-team@android.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 8, 2021 at 7:04 PM Saravana Kannan <saravanak@google.com> wrote:
>
> Commit 4104ca776ba3 ("of: property: Add fw_devlink support for interrupts")
> was not taking interrupt-map into account. Fix that.
>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Fixes: 4104ca776ba3 ("of: property: Add fw_devlink support for interrupts")
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> Greg,
>
> This needs to go into driver-core as the "Fixes" commit is only in
> driver-core if I'm not mistaken.
>
> -Saravana
>
>  drivers/of/property.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
