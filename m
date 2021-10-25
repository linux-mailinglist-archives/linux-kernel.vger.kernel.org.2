Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160F743A474
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 22:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236109AbhJYUZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 16:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237437AbhJYUZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 16:25:32 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39267C04A40D
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 13:10:02 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id y207so17178860oia.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 13:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=XpWOcugTG74fbWN1bpzK+xM/2QXAORc3DyN8mZ3TGcc=;
        b=cWYlranl+VvYT6cGBkvRituonRCQ8xo287DlQ3TggtEV9MT0Lui36QoBArMMef4wI8
         6URDG2bbYFXmfYDDkM92TSLP7m4YETsbeGB9ODSAuYkzqyg9BamcV26fwufYD6NwPm/T
         GgxP/KhyGvLPGqbR1/eJfIhZjkL20fH1Gq4M4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=XpWOcugTG74fbWN1bpzK+xM/2QXAORc3DyN8mZ3TGcc=;
        b=bPATbyoDzsSARPYmFWEMEGm8mNyUxGiC4nbU8OOy/I+rgGzvy3BO9UWC9bj98dDfLT
         aA7L/6HegeBF109QqLbhxSNJb0UxUiFPHsZUoXkZMGfZsyHKck3g1ELIkFWlTczxvyIu
         H327ZiTy4MA+3fe3eCal9TRIzlXoGFfjrkP4m/2ppUKblp/8MQ6WLBkbKepPCbsjsOHJ
         NLn+4VCYtMMeFU9po3JkbNNMmawGSzt3XoDDK8sw/ajFvSvPT+uWuzrDohq5EbO1OoRK
         ZZ/kkncLAR8qX3+uPHNLR8SW3MU3//tMiX+tUBiB/YhYyxqXH/yXqfOhDb+Rw6yuYFoZ
         B64g==
X-Gm-Message-State: AOAM530ZuPiG7eNI8A4tSYf0BBc7VerCkPxcBYf0nsOE6NV6SIO874Rv
        BSAo+2MdGEP/ELQUbFkscqCz/CBVYByCr3NMmzfRrhIljFs=
X-Google-Smtp-Source: ABdhPJwVCoH6cJbBQw7TBTQyxYfFW8TBVTgn8/Ih2eZq4+BNrwx1P+AnmpfMimTUQg0ThRRoDX003B02GnzQXa2j/W8=
X-Received: by 2002:a05:6808:1d9:: with SMTP id x25mr12883185oic.64.1635192601567;
 Mon, 25 Oct 2021 13:10:01 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 25 Oct 2021 13:10:01 -0700
MIME-Version: 1.0
In-Reply-To: <20211021140552.v2.2.I3ed2a84c58d9e81965f497d587f735eea56c1684@changeid>
References: <20211021140552.v2.1.I9d81c3b44f350707b5373d00524af77c4aae862b@changeid>
 <20211021140552.v2.2.I3ed2a84c58d9e81965f497d587f735eea56c1684@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 25 Oct 2021 13:10:01 -0700
Message-ID: <CAE-0n52UdhHwM0rViVdyE4wO3sw8DzU5fEFp_aKTQBwLfR-qgA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/bridge: parade-ps8640: Populate devices on aux-bus
To:     LKML <linux-kernel@vger.kernel.org>,
        Philip Chen <philipchen@chromium.org>
Cc:     dianders@chromium.org, Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Philip Chen (2021-10-21 14:06:00)
> diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
> index 220ca3b03d24..f99a2e0808b7 100644
> --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> @@ -149,6 +150,23 @@ static inline struct ps8640 *aux_to_ps8640(struct drm_dp_aux *aux)
>         return container_of(aux, struct ps8640, aux);
>  }
>
> +static bool ps8640_of_panel_on_aux_bus(struct device *dev)
> +{
> +       struct device_node *bus, *panel;
> +
> +       bus = of_get_child_by_name(dev->of_node, "aux-bus");
> +       if (!bus)
> +               return false;
> +       of_node_put(bus);

This should come after the next line...

> +
> +       panel = of_get_child_by_name(bus, "panel");

here, so that 'bus' can't go away before getting children nodes. It
doesn't actually matter in this case because 'device' holds the aux-bus,
but we shouldn't add anti-patterns to the code lest someone copies it
where it actually matters.

> +       if (!panel)
> +               return false;
> +       of_node_put(panel);
> +
> +       return true;
> +}
> +
>  static void ps8640_ensure_hpd(struct ps8640 *ps_bridge)
>  {
>         struct regmap *map = ps_bridge->regmap[PAGE2_TOP_CNTL];

Otherwise

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
