Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 631FE405D24
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 21:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242417AbhIITIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 15:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236112AbhIITIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 15:08:39 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38662C061574
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 12:07:29 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id v2so3877525oie.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 12:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=G9dUwShNMYXGB/q/uN2ZV/y+8anbGGrbXrA5U+GWj0U=;
        b=J8M7gukBXOlqt3Qnk31Q/m/ukBjBf1I/WS/7vLoRa+D9UXZq+f9y5yKYXdXwYeCBCf
         ouIae5n5sKyOyhlFRPVhPd+0KvljOC/l0hPIZBdBOnuDCrFzsKYkSa4h0G6b4PWLj5eQ
         9LdRco6AX1+ILrX7tkkdL/3R6Lu7UvVmdNEJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=G9dUwShNMYXGB/q/uN2ZV/y+8anbGGrbXrA5U+GWj0U=;
        b=moIyoWaUOAxERrB5xVVAebpAURJ5RniPKyOQFE+P1lllqZCBK6M4gDoLBMteFIxbd1
         ULXagAEI10LE2kalxkaiKQWMQ6VRiMjqHx8mf9sRQ/MeVdfruYkRF4/clNCNpDKtSf76
         H+ckPsT5kh1Heu/YkuX3rktt9cZavx0ts0eT5esjuRRxDS07jJlknGHl22CUq8IhGOIg
         dsnC2pD8EWcrGyGiU4tCY4Dkt5xqra3ZwkMGckjlbKm1juGCVkaFri7aeR+9aehFVGCW
         1/jaZMDEBjNi+WdtRqT3odQylcfQwCc4RuhokMHZ3yBB/JuAYFp8NyCTfPDndVHpeeyi
         U5Nw==
X-Gm-Message-State: AOAM530rhbtA0wKUv0GQwyIiMZA2LusLtuA4Ft+EBAgzCNrcPVfBlqjK
        ayEMj8CHxDzYZUhBFZBTE+XOkpVI5nHxXaaCUjQDAg==
X-Google-Smtp-Source: ABdhPJxJW90rSg2/mqU/5eSBp78t7+FgcJqlRJKB1JjXXrdPRkQ4+IhgmV3AW6jJQq/kWgnx5TMjNWhEaEQNQlb8gD4=
X-Received: by 2002:a05:6808:909:: with SMTP id w9mr1131951oih.164.1631214448523;
 Thu, 09 Sep 2021 12:07:28 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Sep 2021 12:07:27 -0700
MIME-Version: 1.0
In-Reply-To: <CA+cxXhnPd1Z_HVjgM8b0wskASF-ZGuvYDh0quiVMwKFhKVx-JA@mail.gmail.com>
References: <20210908111500.1.I9f6dac462da830fa0a8ccccbe977ca918bf14e4a@changeid>
 <20210908111500.2.Iac57921273b27d7f7d65e12ff7be169657f4c1eb@changeid>
 <CAE-0n50mp5F79iJ+zVrbt4ZP7V+UUOcVQe9H3TwEcFFyZWMoNA@mail.gmail.com> <CA+cxXhnPd1Z_HVjgM8b0wskASF-ZGuvYDh0quiVMwKFhKVx-JA@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 9 Sep 2021 12:07:27 -0700
Message-ID: <CAE-0n51s2MmOthCUSm0+KNBnWmNV=Zzf6eWhYJBme4LpMUUcAQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/bridge: parade-ps8640: Add support for AUX channel
To:     Philip Chen <philipchen@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Philip Chen (2021-09-09 11:15:27)
> On Wed, Sep 8, 2021 at 3:27 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Philip Chen (2021-09-08 11:18:06)
> >
> > > +
> > > +       data = (len - 1) & AUX_LENGTH_MASK;
> > > +       regmap_write(map, PAGE0_AUX_LENGTH, data);
> > > +
> > > +       if (request == DP_AUX_NATIVE_WRITE || request == DP_AUX_I2C_WRITE) {
> > > +               ret = regmap_noinc_write(map, PAGE0_AUX_WDATA, buf, len);
> > > +               if (ret < 0) {
> > > +                       DRM_ERROR("failed to write PAGE0_AUX_WDATA");
> >
> > Needs a newline.
> Adding an empty line here doesn't look like a common Linux style?
> Could you point me to any similar instances in the Linux codebase?

Sorry. I meant on the DRM_ERROR message itself. Add a newline.
