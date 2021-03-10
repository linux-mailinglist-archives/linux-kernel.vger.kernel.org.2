Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 777E0334211
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 16:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbhCJPu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 10:50:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbhCJPuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 10:50:17 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42117C061761
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 07:50:17 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id g185so17263306qkf.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 07:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ekC/nFGtEL8dr/twPzXg0dnfB2QA+TE97mZugeSHujE=;
        b=nVkPzA5PWbGKtCV/O4KmTjeguVxqEHa6Hi0oXmfFqd10i1m8jjjEQhhgSjYPF+fLce
         zj1kn0HYxG66PKVD7er7Gyp5uhw6VNo0qjaeAELNT2PxkcVWosl+R+ofwLIXwwxDiHyD
         nzESW7a1Mo27/b4fw+lEToDuDuOcPyNzUMHIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ekC/nFGtEL8dr/twPzXg0dnfB2QA+TE97mZugeSHujE=;
        b=c3laGa5EdMbv4Dm4Qoqz1JCwWAotzAdhbpFbzsivOZ5wKbTBQI45IiYqrc2yvg6nPl
         ktguYB3rC7HGLkhC+EwXh5R0gf1HHMELZkw0TwBdd0R2gWcd0WnR1UyS52zKeXCaQvWq
         YlrdVkb1wKrIWRlgv6OrUp6bGcXXfw3nhpgkUUN05bkGjlIkmnNafKUbcSg4FzjYjxRT
         e6E8yQqhF99cvmaZJiGqIP1WbKwFSm2Y5ZXYqMlk6XQSccd22NH9K9ICf6S2ztaiWaMl
         XT75YrtI1DMki5eOXVy66pgP60InW+2YETDdknQg2zOosn5y0U2Br7m+QLMAL2X87DSU
         4JXw==
X-Gm-Message-State: AOAM5308LSGXfcX0lK40aAYFWHvhywhUpoFLQtdO8bOOJQumxMskwBhx
        28/wOPcIVE1VMXDeJl4Qj9cg66Wcwfxb3w==
X-Google-Smtp-Source: ABdhPJyPOV+yNtUDAZ+fXlNiCkjsGBsaJqVlX7sI+4vRyL5Vd5GrQCPOoMi2a4h9AjbebT2M886Hng==
X-Received: by 2002:a37:87c4:: with SMTP id j187mr3232598qkd.408.1615391416188;
        Wed, 10 Mar 2021 07:50:16 -0800 (PST)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id x36sm7189324qte.1.2021.03.10.07.50.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Mar 2021 07:50:14 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id 133so18318602ybd.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 07:50:14 -0800 (PST)
X-Received: by 2002:a05:6902:70a:: with SMTP id k10mr1604610ybt.257.1615391414296;
 Wed, 10 Mar 2021 07:50:14 -0800 (PST)
MIME-Version: 1.0
References: <20210305162546.1.I323dad4343256b48af2be160b84b1e87985cc9be@changeid>
 <8e274cc7-0c9e-b983-7dd9-c501c159e95a@linaro.org>
In-Reply-To: <8e274cc7-0c9e-b983-7dd9-c501c159e95a@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 10 Mar 2021 07:50:02 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WU1-5gtgBz1SNdS7Vkf8QLivrVdH4O2p1Vn-X57g3-dw@mail.gmail.com>
Message-ID: <CAD=FV=WU1-5gtgBz1SNdS7Vkf8QLivrVdH4O2p1Vn-X57g3-dw@mail.gmail.com>
Subject: Re: [PATCH 1/3] nvmem: core: Add functions to make number reading easy
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Rob Clark <robdclark@gmail.com>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Mar 10, 2021 at 2:37 AM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
>
>
> On 06/03/2021 00:26, Douglas Anderson wrote:
> > Sometimes the clients of nvmem just want to get a number out of
> > nvmem. They don't want to think about exactly how many bytes the nvmem
> > cell took up. They just want the number. Let's make it easy.
> >
> > In general this concept is useful because nvmem space is precious and
> > usually the fewest bits are allocated that will hold a given value on
> > a given system. However, even though small numbers might be fine on
> > one system that doesn't mean that logically the number couldn't be
> > bigger. Imagine nvmem containing a max frequency for a component. On
> > one system perhaps that fits in 16 bits. On another system it might
> > fit in 32 bits. The code reading this number doesn't care--it just
> > wants the number.
> >
> > We'll provide two functions: nvmem_cell_read_variable_le_u32() and
> > nvmem_cell_read_variable_le_u64().
> >
> > Comparing these to the existing functions like nvmem_cell_read_u32():
> > * These new functions have no problems if the value was stored in
> >    nvmem in fewer bytes. It's OK to use these function as long as the
> >    value stored will fit in 32-bits (or 64-bits).
> > * These functions avoid problems that the earlier APIs had with bit
> >    offsets. For instance, you can't use nvmem_cell_read_u32() to read a
> >    value has nbits=32 and bit_offset=4 because the nvmem cell must be
> >    at least 5 bytes big to hold this value. The new API accounts for
> >    this and works fine.
> > * These functions make it very explicit that they assume that the
> >    number was stored in little endian format. The old functions made
> >    this assumption whenever bit_offset was non-zero (see
> >    nvmem_shift_read_buffer_in_place()) but didn't whenever the
> >    bit_offset was zero.
> >
> > NOTE: it's assumed that we don't need an 8-bit or 16-bit version of
> > this function. The 32-bit version of the function can be used to read
> > 8-bit or 16-bit data.
> >
> > At the moment, I'm only adding the "unsigned" versions of these
> > functions, but if it ends up being useful someone could add a "signed"
> > version that did 2's complement sign extension.
> >
> > At the moment, I'm only adding the "little endian" versions of these
> > functions. Adding the "big endian" version would require adding "big
> > endian" support to nvmem_shift_read_buffer_in_place().
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > This is a logical follow-up to:
> >    https://lore.kernel.org/r/20210227002603.3260599-1-dianders@chromium.org/
> > ...but since it doesn't really share any of the same patches I'm not
> > marking it as a v2.
> >
> >   drivers/nvmem/core.c           | 95 ++++++++++++++++++++++++++++++++++
> >   include/linux/nvmem-consumer.h |  4 ++
> >   2 files changed, 99 insertions(+)
> >
>
> This patch as it is LGTM.
>
> If you plan to take this via other trees, here is
>
> Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Thanks! I think none of this is terribly urgent, though. Unless
someone has a different opinion, my thought would be:

* This patch lands in your tree for 5.13.

* I'll snooze the email for 2 months and poke patch #2 and #3 once
5.13-rc1 is out.

Does that sound OK to you?

-Doug
