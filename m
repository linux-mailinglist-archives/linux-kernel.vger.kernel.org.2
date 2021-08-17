Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 461F83EEB05
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 12:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236594AbhHQKdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 06:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234605AbhHQKdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 06:33:32 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB9DC061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 03:32:59 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id a21so12012055ioq.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 03:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PKbSeN4+Cmups93O1IHb3uzQsoTZaUe6j4ZOOZ0T96g=;
        b=Ot3EMK6zlgbVFzyMonFw1RciGP2Z0eAUruugg9+Nh3XxJA4yvxok/yj8AvyeP0gPsq
         VfOexX5Z5+tLPeQJiVz8LAjlVmks8FbJ3iOHm9F/emjwKPHDsRv6OVh+1lj0RSANp94n
         0ZPZXcU594Bvl7NNqbqeZxcYhlnuUswE9caRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PKbSeN4+Cmups93O1IHb3uzQsoTZaUe6j4ZOOZ0T96g=;
        b=rhLkKGoyTEEVAtgqL6u1ewCBeMr2XUWv5PeFeGlau454wV9n9kR5a+mNNrcYFogSSa
         /CZUYSHkp4hA842elSRuQauRyI8hxYP+yPIPVKNAROUX4PR4kh28Mqt1jdUN4R3P0VwD
         5pj0d65ksbM27GPG+LDw+Xws0wgQJ6y/Bva1vrzHKbVB8UDxgpc1nJgQQQUPqPKBeW/l
         uteABzYRCtqGAF3Z/hjH9JAp3VjZysTogCqG+XIhZTrEH/pjnr8JUn0+M6zo3WazNdUS
         jgqSEJjW+F4EX63Z9glAOUn6xlbe2jLa1Mui2Y5A8jDQkT5+zehDK2HI5B4g8ffvu4Vp
         K5Dg==
X-Gm-Message-State: AOAM530i6e4AOvxnPG8cYVAQ85F7F15eW1UXwRP8chZIlkmj5z6smWhK
        5B85bbdqsjeMc3mkKvixcVHShpvL0Ek1Qmarozeb1Q==
X-Google-Smtp-Source: ABdhPJxoAI2n/TTPeOxdJViJhU71lL8vd+F7mpwucXSKO3zITTXH7MWb4WRW/zdi6ILM/Rqw8U+z/FwgPi235BCy79w=
X-Received: by 2002:a02:6a24:: with SMTP id l36mr2338514jac.4.1629196379357;
 Tue, 17 Aug 2021 03:32:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210705081724.168523-1-hsinyi@chromium.org> <CAG3jFyuT09KOG9Xn-wbrr2DSOB=jSRvBVj96Vx4ja0PQWPKh6g@mail.gmail.com>
In-Reply-To: <CAG3jFyuT09KOG9Xn-wbrr2DSOB=jSRvBVj96Vx4ja0PQWPKh6g@mail.gmail.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Tue, 17 Aug 2021 18:32:33 +0800
Message-ID: <CAJMQK-ixwkR2ECJdYXXtHJTGsSfV_Axs0-E1-rbS8e3XF92FLQ@mail.gmail.com>
Subject: Re: [PATCH] media: ov8856: Set default mbus format but allow caller
 to alter
To:     Robert Foss <robert.foss@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dongchun Zhu <dongchun.zhu@mediatek.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andrey Konovalov <andrey.konovalov@linaro.org>,
        linux-media <linux-media@vger.kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 7:22 PM Robert Foss <robert.foss@linaro.org> wrote:
>
> Hey Hsin-Yi,
>
> Thanks for looking into this.
>
> On Mon, 5 Jul 2021 at 10:17, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> >
> > Setting the value of V_WIN_OFF (0x3818) from 0x02 to 0x01 to use GRBG
> > format still results in wrong color output if data is tuned in BGGR mode
> > before.
> >
> > Set default mbus format for the supported modes, but allow the caller of
> > set(get)_fmt to change the bayer format between BGGR and GRBG.
> >
> > Set the default mbus format for 3264x2448 (and 1632x1224) to BGGR as the
> > data sheet states the value of this reg should be 0x02 by default.
> >
> > If new modes are added in the future, they can add the
> > mipi_data_mbus_{format} settings into bayer_offset_configs to adjust their
> > offset regs.
> >
> > Fixes: 2984b0ddd557 ("media: ov8856: Configure sensor for GRBG Bayer for all modes")
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > ---
<snip>
>
> Looks good to me.
>
> Reviewed-by: Robert Foss <robert.foss@linaro.org>

Hello maintainers,

kindly ping on this patch, thanks!
