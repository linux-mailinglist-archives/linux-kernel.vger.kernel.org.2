Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 272103ACACB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 14:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbhFRM3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 08:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbhFRM3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 08:29:01 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66E8C061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 05:26:51 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id z12so8437512edc.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 05:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VWDDLJjgn0EHJdARf/CI0iB9+tS/p4I47DaD75u4ICY=;
        b=MblTaNSd/oDlHFOoAUkTZGcb9VDT/teyxorP8WFhP6CuEbCDVBoLXbTjmZoIu0PSq2
         EePLo/bevCZQ+IFH/Klpgweq1OH3E/+D+MBt5sy1oSUPFoShBbU9oO533vITGgCABFEy
         WJ5KCY5L0GfM9HMJzAI31p0RyJjDm1dYQ4dxkfkKnllaqoFJZCDQoowCV+7//KYKagfz
         tCLz6MD6hKdArqNrDH6LL5KaUtgK5c1N1/RsnG6YwGrvNC9ekqhb1JV5CQ1kA0YhJefr
         nBePSBk+IcukFpboa8RyPzkG69jPW+kUN9ZMLyg6RxzerUe7P9EaD0zCy5gLyb2xZfZX
         Q2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VWDDLJjgn0EHJdARf/CI0iB9+tS/p4I47DaD75u4ICY=;
        b=F7Ep/fEwlzPxTL8LhZzETS6Om30epXbVnHyDQ4cw3qVS6NqGIHuUb/m6BE6R8QHXAv
         O8UbA3SRC2PhmwKTDS7rcb1x7jcGs5XORlepPHaQ17rZ0eUKk6WZDZ1FSWxa+ZYXKfOK
         aAzu2/7weTkgzecZgb4pk7o+4iUOU6rKCMbt91hwjEhHePrYstQK9HhVW3za9EOJtFAv
         t4zx64UlWoXFCjA3h8mFkzpuNF/eypFyhZbMvlkGHad33jzcg7vP1pQStmdT6bYu3h0u
         fjuPgGKW0xAKOCdUVmW0fGuPf65QHPjpN9pYXqKzshL4VN44fSo9FPVJI514wMcA1LI1
         dlHw==
X-Gm-Message-State: AOAM532sYqeNeTLdf02vqVPT9V++DgyhU9DNg8QTnkv6k4+hW+cOibTS
        hVliibpF6EhoQZ2QOu7sUjhKRz1ShaVd+f5dALCerkE5QQw=
X-Google-Smtp-Source: ABdhPJySmeaBFcg4YsH567Ixrpa9eygvtgUVwztI2AGOzwm6sokMOIthHKxLtCfCq/TiDMAKVEBi8VhgSQRe02cqQco=
X-Received: by 2002:aa7:de1a:: with SMTP id h26mr4576399edv.176.1624019210427;
 Fri, 18 Jun 2021 05:26:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210617194154.2397-1-linux.amoon@gmail.com> <20210617194154.2397-3-linux.amoon@gmail.com>
In-Reply-To: <20210617194154.2397-3-linux.amoon@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 18 Jun 2021 14:26:39 +0200
Message-ID: <CAFBinCAZn13-GpMw-b4=rd9zwwNCtvmv0Oq0BXt+1PTTQ+Gngw@mail.gmail.com>
Subject: Re: [RFCv1 2/8] phy: amlogic: meson8b-usb2: Use phy init callback function
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anand,

On Thu, Jun 17, 2021 at 9:43 PM Anand Moon <linux.amoon@gmail.com> wrote:
>
> Reorder the code for bulk clk_enable into .init callback function.
Depending on whether changes are made to the dwc2 driver this is
either fine or might cause some issues.
My understanding is that drivers which are using a PHY should use the
following code-flow:
- phy_init
- phy_power_on
- phy_power_off
- phy_exit

dwc2's platform.c [0] however currently uses the following order:
- phy_init
- phy_power_on
- (remaining ones omitted to keep this example short)

So with this patch and the way dwc2 is currently implemented the
phy_meson8b_usb2_power_on implementation might not work anymore.
That is because the clocks are turned off and in this case all
registers will read 0.
You might be lucky that u-boot left the clocks enabled for your case -
but in general I would not rely on this.

In case of the phy-meson-gxl-usb2 PHY driver the ordering is different
in the "consumer" driver (dwc3-meson-g12a.c).
There the order is:
- phy_init
- phy_power_on
- (remaining ones omitted to keep this example short)

I don't know if the order in the dwc2 driver can be changed easily
(without breaking other platforms).
Until that dwc2 driver issue is resolved I suggest not applying this
patch (even though in general I like the approach).
The same thing also applies for patch #3 from this series (for
implementing phy_ops.exit)


Best regards,
Martin


[0] https://elixir.bootlin.com/linux/latest/source/drivers/usb/dwc2/platform.c#L157
