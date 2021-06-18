Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3F2A3AC9E9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 13:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbhFRLcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 07:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbhFRLcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 07:32:45 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA7AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 04:30:36 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id r19so3346380qvw.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 04:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ci4ihwZuSGYUz/uI1CC0IKXaTwpsvEkfIF44obOzcVo=;
        b=ChROJdeeybN0A0GyVkUZ00DaA0/sv6VhnbBXNK5g+iSZ80gDcQcWfnGzAg4JZ0MVq6
         liR6c2q0zDZH/VmK0Jf73O2BFdCmlWAem8bKGNKceXlXhxkBsdiVv4gXoGG3Dr6nYIb6
         Cp/xouNPB//YGH+e+nqXTO1NY7BF9X6W1uQKwP/GabccnUbgUAX1LtkAySQudBsfap1B
         Hb1wV/CrH+QDRAZe4LUvZdbDQfn++afNzGEkhE7PZxNYIXOWmn6geLdRiQx1HPQWl1G1
         8ltVdJKhKXCHLEx2zElEI/Awa1OT68GUYJYpBOZ0LRGZ0OTwzg5c2Bi7iN6s8VDyP4+C
         ys2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ci4ihwZuSGYUz/uI1CC0IKXaTwpsvEkfIF44obOzcVo=;
        b=Lx7IP7uHbtouzdFjFle/80Uo6kYOG6TNKBWybzffQLVL2pbgmFqnrolURC+y3wQoWu
         SwwSUCzFDJHw44kiUD7cu2KOIMutQBHQsFMc4r3GjkC6btpv1V0CW9+lQTNKaclwmr7H
         WLhw+798Kt7hxFWJAGRjGJ9VoK/d2Y5vNe7Uv6+5NBcOYxOvgcTtEnZvp1nOx0jpqaq8
         sloy60a2EaDffye/6EqrJjXjBtlfFO26BRlxZX8yJ/eZ8M6ND2L2eM7kZcgY792+fi82
         zHuHYKuG6j0ByxKVBppYXXj/UXyZYfxTshPudQ9xxypOeL7GV571gXiImgiQFsIGcI+C
         WW8w==
X-Gm-Message-State: AOAM530sJqToTHGSGAno8CQjofYveh93GvU1ajzTHkzP7S7rTfX7KD6v
        N8QU/OHzOQhofuQGFEv70ALBoyFqvq4hWprF+Q8=
X-Google-Smtp-Source: ABdhPJw+VBKBbMWiTjprq1OpB940uynK7mBEANOGQm1YOzX7yGaE4oP+e5A8DcDG6tW5eqdyQLtI1iFpklMBWiD25Bs=
X-Received: by 2002:ad4:576c:: with SMTP id r12mr5209117qvx.28.1624015836116;
 Fri, 18 Jun 2021 04:30:36 -0700 (PDT)
MIME-Version: 1.0
References: <1624009876-3076-1-git-send-email-shengjiu.wang@nxp.com> <CAOMZO5DYLZmz6f0yjrOpaL4B_wicq0ofrYpW6QqzNPEc0j407Q@mail.gmail.com>
In-Reply-To: <CAOMZO5DYLZmz6f0yjrOpaL4B_wicq0ofrYpW6QqzNPEc0j407Q@mail.gmail.com>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Fri, 18 Jun 2021 19:30:25 +0800
Message-ID: <CAA+D8AOiL2otCBRyP3q7EWd2C7RnUhWZjRtxcJWQyXXXydf_ZQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_xcvr: disable all interrupts when suspend happens
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio

On Fri, Jun 18, 2021 at 7:21 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Shengjiu,
>
> On Fri, Jun 18, 2021 at 7:10 AM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
> >
> > There is an unhandled interrupt after suspend, which cause endless
> > interrupt when system resume, so system may hang.
> >
> > Disable all interrupts in runtime suspend callback to avoid above
> > issue.
>
> Fixe tag?

ok, I will add it.

>
> > +       ret = regmap_update_bits(xcvr->regmap, FSL_XCVR_EXT_IER0,
> > +                                FSL_XCVR_IRQ_EARC_ALL, 0);
> > +       if (ret < 0)
> > +               dev_err(dev, "Failed to clear IER0: %d\n", ret);
> > +
>
> The operations in _suspend() are usually balanced with the ones in _resume().
>
> Shouldn't you enable the interrupts in resume() then?

No,  as you said below, the interrupts are enabled in fsl_xcvr_prepare().
so this change should not block anything.

>
> I see that the interrupts are currently enabled inside fsl_xcvr_prepare().
