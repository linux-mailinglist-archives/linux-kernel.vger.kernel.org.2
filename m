Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1BB3BA629
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jul 2021 00:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhGBXAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 19:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhGBXAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 19:00:43 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989EEC061762;
        Fri,  2 Jul 2021 15:58:09 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id l24so15237006edr.11;
        Fri, 02 Jul 2021 15:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vD/TqU6XibWuKwYjrV7s56wP7tIAz61+brCWfIO8Z2U=;
        b=XjBvD2TBKWWknE0OCd9OoUjARi5xxbwhs4C6y7LA5KBJ+XVEf4PLQHxLA9h3l0hKlB
         qJ+kn3S9k27KrLK9izjUJqMpTPnzS4H9klZ9IvuLfOEhj0O4WFrh90+zqHa7p8igLkQ6
         x43wE7EcFN4vWBTR2Xfnb4heyvbkGgRGN1K7fwf+ZofT7ao2WtI5QK/Qc9wrD14MI4yt
         CQD6QApV+vLOTnAG4bP4StCgTWHf3cu/XwrpBpntVbLZD9h4Aw16gIAu8Ns3IpPyRz3z
         IE4YoTYFQ9ZGJl/sVlWs/Bxt1F+t7LdcQbPvpyVkt99X91IKAr5E7hs21Smu4ZiMHl2+
         zxIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vD/TqU6XibWuKwYjrV7s56wP7tIAz61+brCWfIO8Z2U=;
        b=MVVHzAJMr1i0jPL+sLmO56ZxkVJwuyei/r1NzP4hrRjQHxtAl80lzbUWztq5C4MLzv
         w2ozkC3Afn0xg7rRYeeGGb/+xnsxgCXhP71Lx3HbvA+cyRSukWYQ6sdN8hfMqd7qbZKN
         3xq8FzVbZEfS61dlHAr8UWrZz4FaQYDS4T+u6QSt+Wfx6M8Dgje53B5e6uP96vlbkAzJ
         lBdGurVbTXtqkS9r4SMQkvLRxyuxSYsnLrS1uayrAtqnILo8y68GeUxr0Z17T3sPQWAh
         iS7Atr2LiUord6utk4oym1e/GgEf9dHO2YAtIF8a2FhAgKpkHAm9C3PdZS3TNEcC71IV
         iyRg==
X-Gm-Message-State: AOAM533fOoRcI/xLj7YXTzb7Y7ENdZOqMGYp4j39IXhEVY8Nx25e6Gtx
        RCMXvAIfB1DAo6wCp/oRQG5zP13dzV4dRaaOFEQ=
X-Google-Smtp-Source: ABdhPJxXJfuDOqau0i9bIe7paYpcmNa20KnLmKDh8yc2DV1RzGhDNRIB8IZvZkTatJvfWGjnqztGHlGhSGbu/YbPKos=
X-Received: by 2002:aa7:d74b:: with SMTP id a11mr2191239eds.40.1625266688199;
 Fri, 02 Jul 2021 15:58:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210627223959.188139-1-martin.blumenstingl@googlemail.com>
 <20210627223959.188139-3-martin.blumenstingl@googlemail.com>
 <20210701202540.GA1085600@roeck-us.net> <CAFBinCC2KB-_pOenpWPknCuHV+CCjhP5hqukSkwD3qwRe6OtQw@mail.gmail.com>
 <162518776607.3570193.14348711594242395887@swboyd.mtv.corp.google.com>
 <CAFBinCAASQUB=cg5EFsBQ4jd3TvcCJzV1=sYJci4ibR7FjRcww@mail.gmail.com> <162525955027.3570193.16463056788252699243@swboyd.mtv.corp.google.com>
In-Reply-To: <162525955027.3570193.16463056788252699243@swboyd.mtv.corp.google.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 3 Jul 2021 00:57:57 +0200
Message-ID: <CAFBinCBsveheUZeW892J+1iyB_5P67rdLiJHtq4+PoNF4r_4CQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] clk: divider: Switch from .round_rate to
 .determine_rate by default
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, mturquette@baylibre.com,
        linux-clk@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>, jbrunet@baylibre.com,
        khilman@baylibre.com, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Fri, Jul 2, 2021 at 10:59 PM Stephen Boyd <sboyd@kernel.org> wrote:
[...]
> I'd prefer we leave round_rate assigned in clk_divider_ops and
> clk_divider_ro_ops but then also assign the determine_rate function. We
> have some duplication but that's OK. Then make individual patches to
> migrate each driver over to the new clk op.
I just sent a series with those changes: [0]

> We could stack a final patch on top to remove the round_rate function
> from clk divider.  Unfortunately, if some driver wants to use round_rate
> then it will fail in interesting ways. Probably best to live with it
> until we decide to drop round_rate entirely. Patches to convert all the
> round_rate code over to determine_rate would be welcome in the meantime.
For now I have omitted the patch to remove .round_rate from clk_divider_ops.
Also I will start migrating .round_rate over to .determine_rate in
drivers/clk/meson/ (as it's the only hardware with CCF support that I
have).


Best regards,
Martin


[0] https://patchwork.kernel.org/project/linux-clk/cover/20210702225145.2643303-1-martin.blumenstingl@googlemail.com/
