Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDA2D39B968
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 15:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhFDNGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 09:06:09 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:45731 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhFDNGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 09:06:08 -0400
Received: by mail-lj1-f181.google.com with SMTP id m3so11418207lji.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 06:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZBoXHXlgUsuLAEckHBS0L48gubREP9VZ3onJ5kB1vB4=;
        b=gM7CTqo8OaGtZE1nYdHLb7e2i3N7jW52LV8SVoowu/2uSz7/U5PUrUq9XyWpUY5htZ
         z4MG4fEO4/cZY2UOLCRMFh/doNOdULsHW6lV3oz3HYUYPq1zOmkiI2Nb40//P6myypWB
         vNoTYWsgb4pGV2Q/AdPcyQdftglZaILNSdpFFxbdFBZRPVwym3S0sdOulUhAbNPBlIVM
         m8HfTBtTACDT+BHTRzvzhf1z/uxMHWP5hHpqJWPKhV1WdzNomrv1qgq8P76jw8iILWDQ
         T7SFkzIGCtk3NES9Yn3+m/gL1BowrX9gd3xbNE47TPKDF3NQ7Ai169F0jMnB67lZ5MO7
         gdIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZBoXHXlgUsuLAEckHBS0L48gubREP9VZ3onJ5kB1vB4=;
        b=q9W33VaB2TCybDTu/gVPXTGUU4bTi6iFPj2a6nHYzWxRJ3dHpJ7r9GibxnGbpUEwNV
         EH4CZEPQqLAhzTe5OzxDwwS1DuoGXyRuWBHPHyNsvlZnQ9Em8DF6aSi5GDvscRspTTvz
         MxtQlJk3bd2EZOEnki0XKAYdPbiiX7QhGaszCHnlCvsy/rhtsT2uVUQJ6CuOW3nCZn+w
         fKFLxKdz9SqVvFPmHFFWDxLksps8KADVA6AS2poO0S/6NeKDpLm9/BRpTXo7Wo5rSKaO
         0omUYAR+DqNtHfPk/meKNmnJgFk1OU6yYRf+kO5pr201XCeIaC47Q0cCA7WJJ8/tNDfO
         lKGg==
X-Gm-Message-State: AOAM533Sf5f7vlwcSKpdD64v1TI39efpPZ+G8lEaf2Gzjpn/paeN3aTt
        Cs/WFcTzmc0fopbaNcinIHeFgxUzKlrJcd5gQa8lyw==
X-Google-Smtp-Source: ABdhPJydDrZaxizEYRElh40CcGeQ+zo5lpzn5pUrB4oNjTon44D3Dbs99hirdh/8q/w+xhKKUM5pguaI39rwH/DFhEY=
X-Received: by 2002:a05:651c:4c6:: with SMTP id e6mr3404073lji.326.1622811801312;
 Fri, 04 Jun 2021 06:03:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210604014055.4060521-1-keescook@chromium.org>
 <CACRpkdZEQ+C7tSppcJ83Go70CaBLe4XYKBqYqJfZWAYq-H2+wA@mail.gmail.com> <YLnvIYKduzv56YAA@phenom.ffwll.local>
In-Reply-To: <YLnvIYKduzv56YAA@phenom.ffwll.local>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 4 Jun 2021 15:03:09 +0200
Message-ID: <CACRpkda=5h+NE1xus-ZgT_F2KgUEDPNbhZ4yQd4MyuZ1p+=PDw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/pl111: Actually fix CONFIG_VEXPRESS_CONFIG depends
To:     Linus Walleij <linus.walleij@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Emma Anholt <emma@anholt.net>, David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 4, 2021 at 11:15 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> On Fri, Jun 04, 2021 at 09:44:59AM +0200, Linus Walleij wrote:
> > On Fri, Jun 4, 2021 at 3:41 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > > VEXPRESS_CONFIG needs to either be missing, built-in, or modular when
> > > pl111 is modular. Update the Kconfig to reflect the need.
> > >
> > > Fixes: 4dc7c97d04dc ("drm/pl111: depend on CONFIG_VEXPRESS_CONFIG")
> >
> > Yeah that doesn't work, thanks for fixing this!
> >
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> >
> > > -       depends on VEXPRESS_CONFIG
> > > +       depends on ARM || ARM64 || COMPILE_TEST
> > > +       depends on VEXPRESS_CONFIG || VEXPRESS_CONFIG=n
> >
> > That's the right solution,
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Since I screwed up already, care to also push this to drm-misc-next?

OK I applied and pushed it!

Yours,
Linus Walleij
