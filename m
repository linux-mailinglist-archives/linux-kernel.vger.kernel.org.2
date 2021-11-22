Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5FA0458756
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 01:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbhKVALk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 19:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbhKVALg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 19:11:36 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59ADC061714
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 16:08:30 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id x43-20020a056830246b00b00570d09d34ebso26326698otr.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 16:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qp8qvP1duE4sps65Ryua2FND+EVymcNt7eeEnZjkT9w=;
        b=Iv6b8LbWkjDNWnKH8fvIb6Oe6siOZd+BVjZno64KhP8n8v1lqYl1vyt2jrCWUX3v/Z
         RMvLzySTb7M+OVGY1Rc+KH0xPgfClvdZ1lLkuBHyGkIff7WOnq257NFNbAVhLhDcaFbB
         ViSoveTiqQQdqIX9f5xXAbIfJbTVA9nAx0ZLcKMWMJxE/duF4cXlNuEaSLNNyJiZqfP7
         VM7vg55IrN/u9OcHbUR8mb3HDDfWbu+LrV2/JDHWEyKEX2kdU3RjMMpUreOCd+ORm49e
         7fKYiOxtOaC1O+czvIb4OGDyLXGozwGppdHfCeaIp0aNdyW+mftBwp5i7ll6e2a+qY+r
         hTcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qp8qvP1duE4sps65Ryua2FND+EVymcNt7eeEnZjkT9w=;
        b=76EiJ/wpbrSGun0hF+H9B8Pw4k+WnOhQHzfVPrryvQWgNqZmGM3NuL2CILOGpd6Ozn
         a4cBGo4Ldg5N/6BBhR3YcefzbeBXck0uYwEA88N2M/z8i3990v64AT08QNhlp5UMNnaQ
         XFv/WzS21JvozDvmxrddhjMEunTF4sCeOqbSJ36jiSeyGz7pD/dushn1gpw4sWoYJSVN
         rZXqfi/FTzXjNViIFwTFXGskOyylbqNBSVlVh5NzQVUbaknpwz9sf5YWbNfxrfNisd7P
         ugfXr8xWZuKSs4jP9qKLeGz7FeuunMnlsmLUvFM4P0+hR3DiL+yChBGVcJKygB787JxY
         1aUA==
X-Gm-Message-State: AOAM531E5ntG+Z1tKMWk8raXH4kXxPZC0Aw1eCO+gzVg9YL0BtWgbBP8
        BvIR2Zo02/6m9X2XeKlL+lkeoQZLxQt/lnOhdfCU8A9b1bw=
X-Google-Smtp-Source: ABdhPJxvD0lqe5bwW7jZKcmW+MhtmK8dNWRzRSetu7eKkiJACTRAo/bXNHATiEu80R+mPong6K1cbtOQDP+bs6Bk/3U=
X-Received: by 2002:a9d:a42:: with SMTP id 60mr21620754otg.179.1637539710298;
 Sun, 21 Nov 2021 16:08:30 -0800 (PST)
MIME-Version: 1.0
References: <20211119195928.2498441-1-colin.foster@in-advantage.com>
In-Reply-To: <20211119195928.2498441-1-colin.foster@in-advantage.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 22 Nov 2021 01:08:18 +0100
Message-ID: <CACRpkdad-_annWF2f-aKqTrLdTosO2Q7c0jxknP8jL6kWk9qEA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 0/4] pinctrl: update drivers to utilize regmap
To:     Colin Foster <colin.foster@in-advantage.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 8:59 PM Colin Foster
<colin.foster@in-advantage.com> wrote:

> Colin Foster (4):
>   pinctrl: ocelot: combine get resource and ioremap into single call
>   pinctrl: ocelot: update pinctrl to automatic base address
>   pinctrl: ocelot: convert pinctrl to regmap
>   pinctrl: microchip-sgpio: update to support regmap

Patches applied to the pinctrl tree for v5.17!
If reviewers don't like that we can always pull them out or do
some fixes on top.

Yours,
Linus Walleij
