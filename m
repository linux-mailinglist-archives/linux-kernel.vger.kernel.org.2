Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD34632ADEA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2360151AbhCBWRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 17:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1837053AbhCBUae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 15:30:34 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9690C06121E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 09:46:49 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id hs11so36900109ejc.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 09:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RPmqkm376YmcwT7JP2kVIYMk9ag7VM/mKieAOclAGOA=;
        b=Tv0kPggItmAsQeD+UDRSdoWoPIZmSHRqOwGwVaLgE3f/vdWKaa+v3oNYgQf3EbzIVe
         L8//O9Z2jF0G7KMiO02g5vFF9mEMOAE8waWGElgzgQ/nWWQV1djlKjllB/d+VUt/yLEz
         ELblIL8wi4BU5OawUFYxbxg2vOK8De7qVPXcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RPmqkm376YmcwT7JP2kVIYMk9ag7VM/mKieAOclAGOA=;
        b=tM3pPjHDQdfvLNSxdD7WbgZgGfhlP3qX3OHzsJfwxbycIZVI8vUre2Kqfunuo9mtUz
         wpuTWPXilU0TZFSRaMpoqyqPXW2jYgkuAJOBC++/uIJ37q8PD2qzPuAR5UFTE6ZLnvCQ
         b+NmmMdEy+fvjIriMfn5ujWoMSd5ohCKi32L1jttkJLmZrEo/4x4+XP9/rqpKyc+/OFE
         SIKLWnpPWc6I84SEdW3Dn7Sl9r8Foc6mWDCUmwWStbhPvwWGH79bSTwatK2Y7ugGH1cF
         vNblfmKV093XMhC7d5JH1oXYcG2gQt5rCBUGRIlLKZdI8qKLFnYy+wYZowBUFm9cFBEV
         MLfA==
X-Gm-Message-State: AOAM532+tebHb33S45JfJoZ/Q52qMhsMDOi9mhmRpH281ttn4zzegVWF
        mst22i/e+5LSQYq3zanQVg/PS34/hQ7hXCM7k2IBvw==
X-Google-Smtp-Source: ABdhPJx7AkaIyyOwx2qyxpqGH7hcad7AAViqsSy3TOF4cnDdUJk27MkJvw07Ek8vNPvIjRJlIknBwJ9rzXlKGT1e3v0=
X-Received: by 2002:a17:907:3fa3:: with SMTP id hr35mr22059253ejc.418.1614707202338;
 Tue, 02 Mar 2021 09:46:42 -0800 (PST)
MIME-Version: 1.0
References: <20210214194102.126146-1-jagan@amarulasolutions.com>
 <20210214194102.126146-7-jagan@amarulasolutions.com> <20210226165723.szblbiswz5vgapq2@hendrix>
 <CAMty3ZC0ynvk3qnWDSnpMD-_hJiP-edga6+HfqhRH_g0BkAqgg@mail.gmail.com> <20210302163505.2d42x364qsm26jo7@gilmour>
In-Reply-To: <20210302163505.2d42x364qsm26jo7@gilmour>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Tue, 2 Mar 2021 23:16:30 +0530
Message-ID: <CAMty3ZAxm3QtWNDm6yN6UKXz5HrWVU17NA6rQaOAae0XSPEmLQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] drm: sun4i: dsi: Use drm_panel_bridge, connector API
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-amarula <linux-amarula@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 2, 2021 at 10:05 PM Maxime Ripard <maxime@cerno.tech> wrote:
>
> On Fri, Feb 26, 2021 at 10:40:24PM +0530, Jagan Teki wrote:
> > On Fri, Feb 26, 2021 at 10:27 PM Maxime Ripard <mripard@kernel.org> wrote:
> > >
> > > Hi,
> > >
> > > On Mon, Feb 15, 2021 at 01:11:01AM +0530, Jagan Teki wrote:
> > > > Use drm_panel_bridge to replace manual panel handling code.
> > > >
> > > > This simplifies the driver to allows all components in the
> > > > display pipeline to be treated as bridges, paving the way
> > > > to generic connector handling.
> > > >
> > > > Use drm_bridge_connector_init to create a connector for display
> > > > pipelines that use drm_bridge.
> > > >
> > > > This allows splitting connector operations across multiple bridges
> > > > when necessary, instead of having the last bridge in the chain
> > > > creating the connector and handling all connector operations
> > > > internally.
> > > >
> > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > >
> > > Most of the code removed in that patch was actually introduced earlier
> > > which feels a bit weird. Is there a reason we can't do that one first,
> > > and then introduce the bridge support?
> >
> > This patch adds new bridge API's which requires the driver has to
> > support the bridge first.
>
> I'm not sure what you're saying, you can definitely have a bridge
> without support for a downstream bridge.

I understand your point. what I'm saying here is, This patch
introduces two new bridge API's

devm_drm_panel_bridge_add
drm_bridge_connector_init

In order to add these API's the driver has to support the bridge
first. All the patches before this one support bridge and this patch
introduce new APIs, ie the reason we have code removed in this patch
which has been added before.

Okay. I think I will send the next version series till bridge
conversion. Improvement patches like this can take care of later
versions and even it depends on Patch v3 5/7 which indeed require a
separate discussion. This way it makes less confusion.

Hope it's fine for you?

Jagan.
