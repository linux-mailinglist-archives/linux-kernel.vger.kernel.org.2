Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC83B31D032
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 19:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhBPS1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 13:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbhBPS1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 13:27:22 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AC9C061756
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 10:26:35 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id c131so6551219ybf.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 10:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=86ZOTfo2pRLUjt+3X3QjxmKkX8aHJubkBHJvWhxkHZg=;
        b=jplIDjDGKUUBlrkHKo/8ABuCOHTog1UcXNNzGLP/87K7e4DMHib05919ZF/TTX7W56
         gksGp+fBfgYV+wRWsJOiz49XBqYw8badhUpVwJ18+IpoBwL952ghsJbcFLQYK0zlvAeK
         u3wGJRA7XC5wM2qVL8egr/TZLGgN6BtChopZGxZc1Z57bW9Ad6lrhz2LnzZA7UWAD5aS
         6bZkf4sTUJl2Kbb9BMeje1rvCS/pmNGoH4CLObA70++6wh8WaxlN/NasICuqSF4sXCub
         zVHKmj68JZUnwKt/ikuoKYdLAxiw+/lw/FPhzU4LARv6YIviQbZlAQWDjbNsQb2Wbx9Q
         NzJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=86ZOTfo2pRLUjt+3X3QjxmKkX8aHJubkBHJvWhxkHZg=;
        b=G5JDNOBLNuZ+GKvnNQ/6RICod3YqdNV9pn9DHv0IhSoAj3SaQHZKN++rGC0q1dse+5
         Zke/nz+QKLLGheKIRardj8g2Q7PbQaTSmouxASqKeRq9r4HBz9dv10LIOce7h53ItQJA
         16MWPXQsaEAPyE1JETWjegDKRfyqJC0cZE+EE3R8l2Er8V6HwWL/jYYcLCbLTnwc5Own
         fFAA9VXoYn1S6s9uKWABCrqEQ/dL9rPHxujTF6Z6VMnXRqj9O3A9vSiYBm4dVfaqfcAE
         lbOyQcAZH5FXlIY6j/AQu1TAwPPVqo01R3EWq0HC743RrHPKOBJ5t9bc06QFakoy07ge
         L5sg==
X-Gm-Message-State: AOAM532XcNThUxFnZTjdjiKgMZcRX+p2o3KnDDoe/sPBkOGsNdgr9/6Y
        YGs71uqc8VySx+x6uOJ/wdb5LPtA2u9fbv6R54G0VA==
X-Google-Smtp-Source: ABdhPJyZspXVqzarSXof+RAxF+6vufj39CfyT7WwHzYfMgr/xSoC2BqtLkJKBPt11/r+1as7k8cT/4rUscOBlCdaR9M=
X-Received: by 2002:a25:b74c:: with SMTP id e12mr34402113ybm.20.1613499994962;
 Tue, 16 Feb 2021 10:26:34 -0800 (PST)
MIME-Version: 1.0
References: <20210216123958.3180014-1-geert+renesas@glider.be>
In-Reply-To: <20210216123958.3180014-1-geert+renesas@glider.be>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 16 Feb 2021 10:25:59 -0800
Message-ID: <CAGETcx_YeiNAMkSxtbTSZcsQugxK4=CwhR6UfbSLLHzQ2EfguA@mail.gmail.com>
Subject: Re: [PATCH v2] soc: renesas: rmobile-sysc: Mark fwnode when PM domain
 is added
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 4:40 AM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> Currently, there are two drivers binding to the R-Mobile System
> Controller (SYSC):
>   - The rmobile-sysc driver registers PM domains from a core_initcall(),
>     and does not use a platform driver,
>   - The optional rmobile-reset driver registers a reset handler, and
>     does use a platform driver.
>
> As fw_devlink only considers devices, commit bab2d712eeaf9d60 ("PM:
> domains: Mark fwnodes when their powerdomain is added/removed") works
> only for PM Domain drivers where the DT node is a real device node, and
> not for PM Domain drivers using a hierarchical representation inside a
> subnode.  Hence if fw_devlink is enabled, probing of on-chip devices
> that are part of the SYSC PM domain is deferred until the optional
> rmobile-reset driver has been bound.   If the rmobile-reset driver is
> not available, this will never happen, and thus lead to complete system
> boot failures.
>
> Fix this by explicitly marking the fwnode initialized.
>
> Suggested-by: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> This is v2 of "soc: renesas: rmobile-sysc: Set OF_POPULATED and absorb
> reset handling".
> To be queued in renesas-devel as a fix for v5.12 if v5.12-rc1 will have
> fw_devlink enabled.
>
> v2:
>   - Call fwnode_dev_initialized() instead of setting OF_POPULATED,
>   - Drop reset handling move, as fwnode_dev_initialized() does not
>     prevent the rmobile-reset driver from binding against the same
>     device.
> ---
>  drivers/soc/renesas/rmobile-sysc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/soc/renesas/rmobile-sysc.c b/drivers/soc/renesas/rmobile-sysc.c
> index bf64d052f9245db5..204e6135180b919c 100644
> --- a/drivers/soc/renesas/rmobile-sysc.c
> +++ b/drivers/soc/renesas/rmobile-sysc.c
> @@ -342,6 +342,8 @@ static int __init rmobile_init_pm_domains(void)
>                         of_node_put(np);
>                         break;
>                 }
> +
> +               fwnode_dev_initialized(&np->fwnode, true);
>         }
>
>         put_special_pds();

Acked-by: Saravana Kannan <saravanak@google.com>

Keep in mind that this might have to land in driver-core-next since
that API is currently only in driver-core-next.

-Saravana
