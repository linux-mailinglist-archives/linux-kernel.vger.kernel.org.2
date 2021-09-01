Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 684B53FE384
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 22:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237299AbhIAUHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 16:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbhIAUHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 16:07:40 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D662DC061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 13:06:42 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id h133so873085oib.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 13:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R1enbq8yB4buPgBZGgnLSFBVHXSHOu406NOCH1T9Ndw=;
        b=S4L71u4MeCBY1DCapSscjPH3pWv5jDN/C6C5lyYVZ9c+++9/JTqo2lZD43vvGwaWnt
         j2o5RhaM/4vNOaAhp1+7mPbqHHhJqaGnc1+oNi1EtyUdHNVEjEUxWcDeT8JkGmYW1Q7M
         CnvMperL6Q1tHOg5Vn/PxmP4vbOpeKzr39VYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R1enbq8yB4buPgBZGgnLSFBVHXSHOu406NOCH1T9Ndw=;
        b=O7TqtxbW3/M7Daf65SL1Zv4xynFfJ1aQ9r8HTjRiZ/j5m14PUO7ANbf2y4shlQQ49p
         K6lW0VnC7na5UjFJRBtXxE8SIMXUinm9WsQxL9qkfF0JTbrCrpkB3DOyA8XhEJxxWDtS
         9yGQdF9TxF43plgNgWBgkDBzrqSsgE6tS987W3TR3wjq6EqMfbqoxwNWDJDgnVlfnSW4
         tRGgkjK2gLvnFBbekXvpLMPFWvAFdj8PHAhrldCwCnqtX/vjMShfahA4XUxhyMsRltXg
         DyRfwZfqKLJbF/ERHmXOHK6hjJjcEIDQ5JpXRNHDM5WrqT6hHdKhbtdRGUuMKx3IDZK0
         zx2A==
X-Gm-Message-State: AOAM5333NVOepWLEcLRddMvCwy4gGyw5wbEDHemmzEeVtMZGUyFOwTj+
        YwsmavqJRXSaxX9VIivY02FDQExh3rSW5A==
X-Google-Smtp-Source: ABdhPJyh46wqvxPVZFVdlLnfx6jFy6PR1cu8ack4VROeBa57ptfKlqUZKFSI9R8RdG/SA2UME3Kfmg==
X-Received: by 2002:a54:4e8f:: with SMTP id c15mr1070825oiy.107.1630526801895;
        Wed, 01 Sep 2021 13:06:41 -0700 (PDT)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com. [209.85.167.179])
        by smtp.gmail.com with ESMTPSA id bj27sm108422oib.58.2021.09.01.13.06.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 13:06:41 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id w19so856811oik.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 13:06:40 -0700 (PDT)
X-Received: by 2002:aca:4557:: with SMTP id s84mr1047555oia.77.1630526799665;
 Wed, 01 Sep 2021 13:06:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210826124015.1.Iab79c6dd374ec48beac44be2fcddd165dd26476b@changeid>
 <20210901150840.GF5976@sirena.org.uk>
In-Reply-To: <20210901150840.GF5976@sirena.org.uk>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 1 Sep 2021 13:06:28 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMLBpF6bQLCoxkN-+CqjxOX-ujzYBTV1f=zU1J7fFNuDA@mail.gmail.com>
Message-ID: <CA+ASDXMLBpF6bQLCoxkN-+CqjxOX-ujzYBTV1f=zU1J7fFNuDA@mail.gmail.com>
Subject: Re: [PATCH] regulator: core: resolve supply voltage deferral silently
To:     Mark Brown <broonie@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 1, 2021 at 8:09 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Aug 26, 2021 at 12:40:17PM -0700, Brian Norris wrote:
>
> >               if (current_uV < 0) {
> > -                     rdev_err(rdev,
> > -                              "failed to get the current voltage: %pe\n",
> > -                              ERR_PTR(current_uV));
> > +                     if (current_uV != -EPROBE_DEFER)
> > +                             rdev_err(rdev,
> > +                                      "failed to get the current voltage: %pe\n",
> > +                                      ERR_PTR(current_uV));
>
> This doesn't make sense to me.  Why are we getting as far as trying to
> read the voltage if we've been told to defer probe?  This suggests that
> we ought to be doing this earlier on.  I see that the logic is already
> there to handle a deferral being generated here but it looks off.

Take a look at the commit this "Fixes":

21e39809fd7c ("regulator: vctrl: Avoid lockdep warning in enable/disable ops")

The target |rdev| hasn't deferred probe, but it's telling the
regulator core to DEFER because the supply (which is required for
|rdev| to "get" its present voltage) isn't yet resolved. So the probe
deferral isn't really about the device framework, but about the
regulator framework.

If this were a device framework deferral, then agreed, this would be
bad -- we can't guarantee, for one, that the second try will not also
defer. But in this case, vctrl_probe() has already ensured that its
supply regualator is there (devm_regulator_get(..., "ctrl")) -- it
just isn't wired up into |rdev->supply| yet.

Frankly, I'm not sure if we're abusing regulator framework features
(particularly, around use of ->supply) in commit 21e39809fd7c, or if
this is just a lacking area in the framework. I'm interested in
whether you have thoughts on doing this Better(TM).

Brian
