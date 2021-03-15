Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C460633C1F0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 17:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbhCOQcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 12:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233626AbhCOQcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 12:32:21 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F2FC06175F
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 09:32:21 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id d20so32274277qkc.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 09:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wSDzwZbj+0vxP+554qTTvCPOo7GPQQW7PtVpXOR2Y4U=;
        b=FetC9ltqIaCLxNdmHDvRxJjzUI0PCf2tEgp5CE05LdSaKPJugguqprjMjPNDorS7Gb
         SMLZ21YfS9W6mDAWMTTmgSmZ77K3Zye10u9DPDepX8cyaGCvgn6eKh0T/1kTF/hfNKa4
         Sr91+vICNArqJrjCOFRVjUJYHpV1ZBwUCpmG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wSDzwZbj+0vxP+554qTTvCPOo7GPQQW7PtVpXOR2Y4U=;
        b=SZuVA5uKE7dK5K/yGEj/uXhrLhZl63eeTAk1fc4oynZPNMSrn+uY+Ya+VIHdgu2YPP
         CH3r7RJR98jeSESV/wKR/jFgy+YSUOq+VpY1rgehQdPzjNDQGwYngvwP7UPAqAcV90ao
         8jbBBxK/E0UdYbs0FTyYVdA2yBRkkWJeUg4/f92Ee56B8TUS/oeL+6AXqy1jmi7BWpd6
         f2v7nQat+0C2/eP/i4QFmYtt3HBGFIDY+XHyNdvxtjhCbeNp30TNoI/bOQkwEeIMkSO4
         bBj2WiwYN+MaP2J8BQZs3YxV5JOgD2C9Te9p3c/9Bu+cfy9fKOUBNmWTc+/fs1npXj9A
         WrGA==
X-Gm-Message-State: AOAM530Qh8BwWneSnXZ190EcDrHflPBvGIVnSIXrcY5/ANxlerHnSCVx
        2L//Eev9xDrKrBrr1zN2ipNp/E9zsRNPbw==
X-Google-Smtp-Source: ABdhPJyMozv8qXuJEHNTpqjz8/SHfnqAf/5RWsFesJvGZ5Z18z2vxcXrVDfObPKk6ceGZjTwjCbPsA==
X-Received: by 2002:a05:620a:1443:: with SMTP id i3mr25709636qkl.354.1615825938527;
        Mon, 15 Mar 2021 09:32:18 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id l129sm12795738qkd.76.2021.03.15.09.32.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Mar 2021 09:32:17 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 133so33843853ybd.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 09:32:17 -0700 (PDT)
X-Received: by 2002:a05:6902:70a:: with SMTP id k10mr669116ybt.257.1615825936810;
 Mon, 15 Mar 2021 09:32:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210304155144.1.Ic9c04f960190faad5290738b2a35d73661862735@changeid>
 <20210304155144.2.Id492ddb6e2cdd05eb94474b93654b04b270c9bbe@changeid> <YE0qyYedS0NilsCy@pendragon.ideasonboard.com>
In-Reply-To: <YE0qyYedS0NilsCy@pendragon.ideasonboard.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 15 Mar 2021 09:31:41 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X_HAdNkvZ7NGKDH9KapRRLgOfN23OZyy3VyaX+ywjRkQ@mail.gmail.com>
Message-ID: <CAD=FV=X_HAdNkvZ7NGKDH9KapRRLgOfN23OZyy3VyaX+ywjRkQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/bridge: ti-sn65dsi86: Move code in prep for EDID
 read fix
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org, robdclark@chromium.org,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Mar 13, 2021 at 1:13 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Douglas,
>
> Thank you for the patch.
>
> On Thu, Mar 04, 2021 at 03:52:00PM -0800, Douglas Anderson wrote:
> > This patch is _only_ code motion to prepare for the patch
> > ("drm/bridge: ti-sn65dsi86: Properly get the EDID, but only if
> > refclk") and make it easier to understand.
>
> s/make/makes/

I was never an expert at grammar, but I think either "make" or "makes"
are fine. Simple version with parenthesis:

Mine:

This patch is <blah> to (prepare for the patch <blah>) and (make it
easier to understand).

Yours:

This patch is <blah> (to prepare for the patch <blah>) and (makes it
easier to understand).

I suppose also valid would be:

This patch is <blah> (to prepare for the patch <blah>) and (to make it
easier to understand).


In any case if/when I spin this patch I'm fine changing it to your
version just because (as I understand) it's equally valid and maybe
looks slightly better?

> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks for the reviews!

-Doug
