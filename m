Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B576367BC1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 10:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234475AbhDVIKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 04:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbhDVIKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 04:10:52 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B982EC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 01:10:17 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id x12so46671062ejc.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 01:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h+CMl0wy3Vjr3C3/bC9rZ5K1PCcuzB8i4uU1sLoEz/Q=;
        b=REWRFzLC60dlqnMXMPEWx38bd5GYmNw56uXhyWHcnMYr3Tv5NpMHovQnA5Bb+5InmN
         4b+4f0c1dH/bJ06BBd0tlLT9CpiaeANYTqzerfaaKs42oIiIp1kXhG4vlCosi3/d5fu2
         ElHUSdzzB0d8IjpqH4NOgi+LZkCL7w/YXTu+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h+CMl0wy3Vjr3C3/bC9rZ5K1PCcuzB8i4uU1sLoEz/Q=;
        b=P45GhBOlcHrQx4Te/gt1wAogVYfru+K7vul+s/mXtcPwQVjGNU5wtdhvRsev/I2NG7
         /uBQFDq5EvSR9RC+kNs096cCH/S6L/X332GhQoG6E9+fGUgqEoVKsrPumwK88WuNsDf6
         fzTSxGwYaRajYcFRksHOjbheN6tvyeOsbIWRdi/rdKsfDy6Jf71JhjqyAxJikA0WgbXr
         sob6Rlug61AbafLzFSlwEpKz6PkM8DzKQhjWBgpTKOUmn1rcriCnsOXTbR4M3CW00dPa
         4qSOpat8z/Ce4iwk6xHkQQpRVZCNomrn1fDc7yNkEYSdD3WXa5VUFejZM2DH1XXy6OoQ
         h8mQ==
X-Gm-Message-State: AOAM53088MwkYt4FD5Hy7tHMC6FKr/G3bI9isG7swd/AAIiKL1gtcn0f
        ZviecqwFA4k4ALxjT2ZMKMOvCpqcYY6ApxfyF/ZUhg==
X-Google-Smtp-Source: ABdhPJz86iG8pbA8A6dOaF9RURCM9V6vojTjv4f6LyDRLnUH+5yxZV2UZ3/KAwNZFRV4cxKgrwj0Yfx3i4LiRRYoxeY=
X-Received: by 2002:a17:906:235b:: with SMTP id m27mr2083664eja.336.1619079016529;
 Thu, 22 Apr 2021 01:10:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210214174453.104616-1-jagan@amarulasolutions.com>
 <d7f9b241-3cfc-836a-2519-3b6621899108@denx.de> <CAMty3ZBMt+bx7ZrCQf0b3wrJUtZVe3CS=8-t_wYZ4+=PwP+mbQ@mail.gmail.com>
 <2d9a88e9-e443-0243-4b68-85fc01d9677b@denx.de>
In-Reply-To: <2d9a88e9-e443-0243-4b68-85fc01d9677b@denx.de>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 22 Apr 2021 13:40:05 +0530
Message-ID: <CAMty3ZAhdOesrEA26_rduEOaxpwScd5Og6biXT5SzULbH6GR6w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: display: bridge: Add bindings for SN65DSI83/84/85
To:     Marek Vasut <marex@denx.de>
Cc:     Claudius Heine <ch@denx.de>, Rob Herring <robh+dt@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-amarula <linux-amarula@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 4:04 AM Marek Vasut <marex@denx.de> wrote:
>
> On 4/8/21 4:45 PM, Jagan Teki wrote:
> > On Wed, Mar 24, 2021 at 7:26 PM Claudius Heine <ch@denx.de> wrote:
> >>
> >> Hi Jagan,
> >>
> >> On 2021-02-14 18:44, Jagan Teki wrote:
> >>> SN65DSI83/84/85 devices are MIPI DSI to LVDS based bridge
> >>> controller IC's from Texas Instruments.
> >>>
> >>> SN65DSI83 - Single Channel DSI to Single-link LVDS bridge
> >>> SN65DSI84 - Single Channel DSI to Dual-link LVDS bridge
> >>> SN65DSI85 - Dual Channel DSI to Dual-link LVDS bridge
> >>>
> >>> Right now the bridge driver is supporting Channel A with single
> >>> link, so dt-bindings documented according to it.
> >>
> >> Do you know when we can expect a v4 for this?
> >>
> >> I am currently working on top of your patch set to setup a dual-link
> >> LVDS bridge of SN65DSI84.
> >
> > Yes, I'm planning to send v4 this week. will keep you in CC. thanks!
>
> I haven't seen any activity here for over two weeks, so I decided to
> send V2 of the driver I wrote, now tested on both DSI83 and DSI84.

It delayed me since I have considered several comments from the
Mailing list to wrote Dual Link-LVDS configuration support. I have a
plan to send v4 in the coming weekend with these changes, I thought it
would be the possible driver to support 1 and 2 links LVDS.

Jagan.
