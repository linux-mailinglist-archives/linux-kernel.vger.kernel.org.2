Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 813143D422D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 23:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbhGWUpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 16:45:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:48444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231600AbhGWUpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 16:45:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C6D7160EB5;
        Fri, 23 Jul 2021 21:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627075557;
        bh=Y2+4vWDQsufrxtPr5dxwMNbkWMxKsU9EX96nJ+a043I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=E3ffraGq+WB0mYUbWa/KYU56Sph76jOXKA6DXdo8+V4/V+zHT8v9bAO78r853ZOTe
         frTm+xmE3fPBKWYOe2706hl1CGL0CX/11AilB5wh9ejNuMg8iMCOwr9HHAGu9jfvSj
         iEjjcayPfIXP6fp2lCPPmGN/hftU/nU3lB4o2d6d2E8ScpknRYFr9Lm99wvMKVjyyq
         E+5XL6QAD0jkaI/4R+rOV7a8B1yGf+ul/EWBb9HWk+HBIAtgZolwtIitla0N7gQWtt
         DeQfw8jucg/nRkZdNHkUSiPpZv7oREmXgCi1eUH4aBadAh/D0g6nVKD1UO5Lp5hlBj
         grvg/xCQZt2ig==
Received: by mail-ed1-f51.google.com with SMTP id da26so3405961edb.1;
        Fri, 23 Jul 2021 14:25:57 -0700 (PDT)
X-Gm-Message-State: AOAM533HiaqyRa5OlR9e8DgFTOLxU4Uc/YwX3u9gGgHSA2UNUj33AoRz
        MnEKhIBbipCI1O0k/070yqVbT2QHO7iJxFlCRA==
X-Google-Smtp-Source: ABdhPJy1c3eyy/FP6EjBD5reeZRC6kaYEX0oNwJSz6lKuHUlbPJr2EpqmbxNRfwJj6+f08LjSJayXEiOO+ZI5WMI+Fo=
X-Received: by 2002:aa7:df12:: with SMTP id c18mr7914633edy.62.1627075556418;
 Fri, 23 Jul 2021 14:25:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210719195001.2412345-1-robh@kernel.org> <YPXZODWTE3qHQqEv@ravnborg.org>
In-Reply-To: <YPXZODWTE3qHQqEv@ravnborg.org>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 23 Jul 2021 15:25:45 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJt=ifqBuvpAXkd5hXb=1tg16a4Sjcq+WuvsinccPuvuQ@mail.gmail.com>
Message-ID: <CAL_JsqJt=ifqBuvpAXkd5hXb=1tg16a4Sjcq+WuvsinccPuvuQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: display: Fix graph 'unevaluatedProperties'
 related warnings
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     devicetree@vger.kernel.org, Marek Vasut <marex@denx.de>,
        Krishna Manikandan <mkrishn@codeaurora.org>,
        David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sean Paul <sean@poorly.run>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2021 at 1:57 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Rob,
> On Mon, Jul 19, 2021 at 01:50:01PM -0600, Rob Herring wrote:
> > The graph schema doesn't allow custom properties on endpoint nodes for
> > '#/properties/port' and '#/$defs/port-base' should be used instead. This
> > doesn't matter until 'unevaluatedProperties' support is implemented.
> >
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Rob Clark <robdclark@gmail.com>
> > Cc: Sean Paul <sean@poorly.run>
> > Cc: Marek Vasut <marex@denx.de>
> > Cc: Krishna Manikandan <mkrishn@codeaurora.org>
> > Cc: dri-devel@lists.freedesktop.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>

Thanks. FYI, your mail only went thru on dri-devel, but not DT or LKML lists.

Rob
