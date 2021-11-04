Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC804453B7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 14:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbhKDNW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 09:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbhKDNWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 09:22:25 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BFCC061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 06:19:47 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id n8so7177232plf.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 06:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6znl9g1aF/ktgrLgP4pKgxmC6R6G/5lzoN2lQ83r4Mg=;
        b=SScnlvLKSBYSwGgZP4vXFrjpR6++jonn1IAkJ/8MW2BJSA2mHq9ozIp5zOWltU4txf
         KEcAkUp7XKW/+xjgW7JHZmku4Gs1DG1S9cxWEc9mAGaJjLIp/M4m6vr+GREIlJkTIG1M
         Q30ULMEpm+YSsPBT+BzB4nLMw1tkXFptMuD90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6znl9g1aF/ktgrLgP4pKgxmC6R6G/5lzoN2lQ83r4Mg=;
        b=oGJqrfWTTLS3GfcSl6NcwoJ5Pjbg9kfZqILj/I6x7l385k4d4Ds42kxtAwlCigdVPj
         bcvOmP8evWycEGxAAvZmHyuhigYdT8Es7YSl7hKwnsGrDpCafHbA4ST/ZLODL5iavOz6
         7jr+8smQw/TQIFbihhbL8jGUps3aQAU+dChINFZEf885Wz6WAAC873GFJFVY30brmoRw
         t0OtAR0X2lzAjoeUtdooHu6TSuVtD4kF8lV/KKq5Bf5TshwMBI3b+/Qc5reRR9TV4RdY
         wd1HnYMAPGMovCUx4LbGrWk0E9WM+l51HnVCgyaBRRG32Y7mr4eob92sK1E3aphh8mgr
         Dc2A==
X-Gm-Message-State: AOAM531jsSqgwogPq1q1bECOTpYx+2Z9I1Z1qvo2fcjSxuh8N/kB64Un
        EtVpU53u6XsJgjwgIPA8AGyabHkESAAsOZe0E/kcEw==
X-Google-Smtp-Source: ABdhPJwRuqvbL3YNO+3lAhAYC8fQPcfdCceIuT0J9FcvnJEdBufdZI50ieoIk0wLUXqk5ffazI6KxxaDW3Yu6J/9Ljs=
X-Received: by 2002:a17:902:6a86:b0:13f:f048:9778 with SMTP id
 n6-20020a1709026a8600b0013ff0489778mr44611543plk.27.1636031986615; Thu, 04
 Nov 2021 06:19:46 -0700 (PDT)
MIME-Version: 1.0
References: <20211016102232.202119-1-michael@amarulasolutions.com> <YWrFIz08A8ZVKXvi@ravnborg.org>
In-Reply-To: <YWrFIz08A8ZVKXvi@ravnborg.org>
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Thu, 4 Nov 2021 14:19:33 +0100
Message-ID: <CAOf5uwnv=MxqK772YJ3mggkqFQJW+Z3_WrCNHgDPTpDH8d-2Xw@mail.gmail.com>
Subject: Re: [PATCH 0/5] Add support for Wanchanglong panel used in px30-evb v11
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        devicetree@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam

On Sat, Oct 16, 2021 at 2:27 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Michael,
>
> On Sat, Oct 16, 2021 at 10:22:27AM +0000, Michael Trimarchi wrote:
> > This patch series add support for W552946ABA panel. This panel is used
> > in px30-evb v11. All the patches can be applied on top of drm-fixes
> > branch. The last patch is suppose to fix a race when the panel is built
> > in. Tested on px30 evb
> >
> > Michael Trimarchi (5):
> >   dt-bindings: vendor-prefix: add Wanchanglong Electronics Technology
> >   drm/panel: ilitek-ili9881d: add support for Wanchanglong W552946ABA
> >     panel
> >   dt-bindings: ili9881c: add compatible string for Wanchanglong
> >     w552946aba
> >   drm/panel: ilitek-ili9881c: Make gpio-reset optional
> The four patches has been applied to drm-misc-next.
>

I sent another fix on the same panel. Are those patches queued on some tree?

> >   drm/bridge: dw-mipi-dsi: Fix dsi registration during drm probing
> This patch looks like it does not belong in this series.
> Anyway - commented on it as I did not understand the code.
>
>         Sam

Michael
