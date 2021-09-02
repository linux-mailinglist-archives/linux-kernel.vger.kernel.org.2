Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE4E33FE84B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 06:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbhIBEK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 00:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbhIBEKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 00:10:55 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA96AC061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 21:09:57 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id m4so1055837ljq.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 21:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JXKbpLk4h7Ao06eJIqaxheO/cI5CI+ZgSWDWtLCGvbc=;
        b=ZCCJiiH+3ebz+FzXolFtWo3a2Uc50u+MknyDGLIpuyy+qsgFlOJilk48p4yKW4GnsF
         zGi+i3oihAQPiUmYZYwmk/dkFdUJMtu5jJqJMx5+z3fUyybE1Z7Ur71kXcXEt7zavMSt
         mmTPVikhxa9zCiutWIqIUtVp6XomVjhVpzWfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JXKbpLk4h7Ao06eJIqaxheO/cI5CI+ZgSWDWtLCGvbc=;
        b=c1Q9f1OuRQC3grUxTGvr9wgSto58mLngOvG8b7NsKdsrZryDeDPTSbLew8ly220iwH
         iWV7b7Mtp/pzGJp6gSL4BxWPyeaoACF0d5/Eq/Nx+1e4MWSaMPPF8Gq657SdNhMCKnxI
         MtPcMbCR9t3Sg+5udxCriYK73MrPWHK5pdRZPkuiBPGCqsWTndS00BtYe4noFbWSqGq+
         W3HF4EqR61rB5YXG10J6oDAC/vK/XQ5w/+tfEfvKEFW7fiquyTN3sVE63OmU3qhZTgU0
         7+qLnpeL+vsfACJuUjjdum62hC9r5oFrtZjfc1EuI4G9p1tSLVzeuxoRAqmSgBnDVM6b
         oH2A==
X-Gm-Message-State: AOAM531z0GiUx/BsR9DwKVwm/3uB3puuEzRpfitiS7SJe9zpq2hVDpMp
        NGfKU2avpGorKVrG8il08gqVVT8dV6pMEvNhRo6qVHrhTVi8nA==
X-Google-Smtp-Source: ABdhPJy0cqz/9DdXWwE/UZBVnVj9o8VFpYaiOP//rjwIl2ByCNLqIGOJTeEvavjpqv00McBQocdCWNAqwWsqJg9J6/k=
X-Received: by 2002:a2e:964b:: with SMTP id z11mr852429ljh.91.1630555796348;
 Wed, 01 Sep 2021 21:09:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210826124015.1.Iab79c6dd374ec48beac44be2fcddd165dd26476b@changeid>
 <20210901150840.GF5976@sirena.org.uk> <CA+ASDXMLBpF6bQLCoxkN-+CqjxOX-ujzYBTV1f=zU1J7fFNuDA@mail.gmail.com>
In-Reply-To: <CA+ASDXMLBpF6bQLCoxkN-+CqjxOX-ujzYBTV1f=zU1J7fFNuDA@mail.gmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 2 Sep 2021 12:09:45 +0800
Message-ID: <CAGXv+5EpjHtHPY0jQ5m4iZ8hvEc=7XCnK33_YQUT+0Oi+WUfFg@mail.gmail.com>
Subject: Re: [PATCH] regulator: core: resolve supply voltage deferral silently
To:     Mark Brown <broonie@kernel.org>
Cc:     Brian Norris <briannorris@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 2, 2021 at 4:06 AM Brian Norris <briannorris@chromium.org> wrote:
>
> On Wed, Sep 1, 2021 at 8:09 AM Mark Brown <broonie@kernel.org> wrote:
> >
> > On Thu, Aug 26, 2021 at 12:40:17PM -0700, Brian Norris wrote:
> >
> > >               if (current_uV < 0) {
> > > -                     rdev_err(rdev,
> > > -                              "failed to get the current voltage: %pe\n",
> > > -                              ERR_PTR(current_uV));
> > > +                     if (current_uV != -EPROBE_DEFER)
> > > +                             rdev_err(rdev,
> > > +                                      "failed to get the current voltage: %pe\n",
> > > +                                      ERR_PTR(current_uV));
> >
> > This doesn't make sense to me.  Why are we getting as far as trying to
> > read the voltage if we've been told to defer probe?  This suggests that
> > we ought to be doing this earlier on.  I see that the logic is already
> > there to handle a deferral being generated here but it looks off.
>
> Take a look at the commit this "Fixes":
>
> 21e39809fd7c ("regulator: vctrl: Avoid lockdep warning in enable/disable ops")
>
> The target |rdev| hasn't deferred probe, but it's telling the
> regulator core to DEFER because the supply (which is required for
> |rdev| to "get" its present voltage) isn't yet resolved. So the probe
> deferral isn't really about the device framework, but about the
> regulator framework.
>
> If this were a device framework deferral, then agreed, this would be
> bad -- we can't guarantee, for one, that the second try will not also
> defer. But in this case, vctrl_probe() has already ensured that its
> supply regualator is there (devm_regulator_get(..., "ctrl")) -- it
> just isn't wired up into |rdev->supply| yet.
>
> Frankly, I'm not sure if we're abusing regulator framework features
> (particularly, around use of ->supply) in commit 21e39809fd7c, or if
> this is just a lacking area in the framework. I'm interested in
> whether you have thoughts on doing this Better(TM).

I do think we are slightly stretching the use of ->supply, but IIUC
this error message path will also get hit if the regulator in question
is in bypass mode and the core needs to read the voltage of its supply,
which is exactly the case described here:

https://elixir.bootlin.com/linux/latest/source/drivers/regulator/core.c#L5475

ChenYu
