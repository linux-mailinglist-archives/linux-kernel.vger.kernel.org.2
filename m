Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82E673EDEEC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 23:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbhHPVDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 17:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbhHPVDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 17:03:20 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A381C0613C1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 14:02:49 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id p4so35477005yba.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 14:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9tBnOccmzh2NJZYx5oDaY8MOAHPBqp1qYchURvuFzso=;
        b=R16oiv/oceeUQV3a8yDdzod/rO3qI0SEJlVFlqqsHY1kJ2SIGsYuwOrp7cudXALITL
         KHJxOV3loaVswHpYg9mED7WahY3ZCZbN+kf/QcUJRM4Nkx+oQ9Nbhaye9JkT5rKoPZhZ
         TXlUCUmKKQMZLOGx3gLZ/0A1BAxBD6hhNzch/x2ygnciQhCT4Q8OxxVsdEieebUda1j4
         Yl5srS5Ig3HVcPXA3fI8QBi++ZQlE8UYCRA66y1xaceEiDvRK+/CaxA7WHUrSc3caYOu
         FURHrXGr/JK3v89xSxs0acxIdq+Qdc6w7o9jIDqfQVElfYY/ogERPimfyKtdY4fyzNdh
         GH7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9tBnOccmzh2NJZYx5oDaY8MOAHPBqp1qYchURvuFzso=;
        b=KYGj94QqewgfabbF/vzJJHqGKfEUWbM5721FTU5Fxmizr1S3E5EWwLUt8j4VxH/cxD
         nrQSjMJnZzprOBg+1hSwE4jQiUvw2xrngige3hVJ36uqQ+V9/ptmZqX+7uZcya2ByU6b
         z4LzUZu1Oit7YdtMyJS5LXsxzHJzPLcsYvj9yHdgsVwTfNgyfAksV+x+VccnmbV7D4aF
         4jGU8CXx29V/f48x92/gSgL2cdNPkSbWpYK9yzf26jah2GNdGSI6gnrZYKxyG8LSR2Gn
         Abf4B9EYQd/KfnFj58guvK8oYuoRCDQPZd952u2WW7e6utvsdkDKiFIvFLwpIKPiBH2l
         BIHQ==
X-Gm-Message-State: AOAM531bhkI0udb5JhlhvFUmXRe5GQF95UBaptRHiRxIGnUhdZP/eT5S
        0be8CPtVAq6XoyupZDGcHW5Ee7zo+t1CUm7QVH5YIQ==
X-Google-Smtp-Source: ABdhPJzfOeoMrqnOumdBEyULbR12pEKizh9VCI5n4TPyzQfeauroCIr1y3HOIzCK1KqhoZVCucYu6yxU1MKOU+MlGp4=
X-Received: by 2002:a25:d1c2:: with SMTP id i185mr483413ybg.466.1629147768118;
 Mon, 16 Aug 2021 14:02:48 -0700 (PDT)
MIME-Version: 1.0
References: <87r1hwwier.wl-maz@kernel.org> <7h7diwgjup.fsf@baylibre.com>
 <87im0m277h.wl-maz@kernel.org> <CAGETcx9OukoWM_qprMse9aXdzCE=GFUgFEkfhhNjg44YYsOQLw@mail.gmail.com>
 <87sfzpwq4f.wl-maz@kernel.org> <CAGETcx95kHrv8wA-O+-JtfH7H9biJEGJtijuPVN0V5dUKUAB3A@mail.gmail.com>
 <CAGETcx8bpWQEnkpJ0YW9GqX8WE0ewT45zqkbWWdZ0ktJBhG4yQ@mail.gmail.com>
 <YQuZ2cKVE+3Os25Z@google.com> <YRpeVLf18Z+1R7WE@google.com>
 <CAGETcx-gSJD0Ra=U_55k3Anps11N_3Ev9gEQV6NaXOvqwP0J3g@mail.gmail.com> <YRrOvJBLp3WreEUf@lunn.ch>
In-Reply-To: <YRrOvJBLp3WreEUf@lunn.ch>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 16 Aug 2021 14:02:12 -0700
Message-ID: <CAGETcx_Q2-7B5RpHSfDu1KB0n+pT8nkCwGsthN20QBvgePcUtQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] irqchip: irq-meson-gpio: make it possible to build as
 a module
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Lee Jones <lee.jones@linaro.org>, Marc Zyngier <maz@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 1:46 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > Not that I'm aware of. Andrew added a "Reviewed-by" to all 3 of my
> > proper fix patches. I didn't think I needed to send any newer patches.
> > Is there some reason you that I needed to?
> > https://lore.kernel.org/lkml/20210804214333.927985-1-saravanak@google.com/T/#t
>
> https://patchwork.kernel.org/project/netdevbpf/list/?series=&submitter=&state=*&q=net%3A+mdio-mux%3A+Delete+unnecessary+devm_kfree&archive=both&delegate=
>
> State Changes Requested. I guess because you got the subject wrong.

I'm assuming the prefix is wrong? What should it be? I went by looking
at the latest commit in:
$ git log --oneline  drivers/net/mdio/
ac53c26433b5 net: mdiobus: withdraw fwnode_mdbiobus_register

What prefix do I need to use to be considered correct?
net: mdio:?

>
> With netdev, if it has not been merged within three days, you probably
> need to resubmit.

Ah, thanks for the info. Since you didn't say anything, I assumed it'd
get in eventually and didn't really check the patchwork status.

-Saravana
