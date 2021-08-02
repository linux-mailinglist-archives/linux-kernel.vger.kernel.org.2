Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 066063DDDA8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 18:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbhHBQ1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 12:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233093AbhHBQ1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 12:27:30 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425E1C0617B1
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 09:27:13 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id t66so17175767qkb.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 09:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hfG5pLLGBVmijGs7xD1CuYUYuRgtJdbg/w8jfytxMq8=;
        b=KCMBWwrB7rl9OU23KgEVRMNrHkjI1UKzf688kWLXVEwgeNJcNUEFn/VqxfBmj/RpNi
         fU7laMr621aEhNdbx+OdRBeG+gRjYLKUtX6YwfYdGH1jiOfiYbFh9RvqsE7G7X2Hcr6L
         IJD1goHuBubu29rquTw+430JSLxAt+s34C3IcQXoIbHdotn0TAHF96EnLgoC091BV6D8
         vKRxR4BW5FYKCX85Vyxg7ZVVfl6YOhLMldCnEvHDcsFJe8Fwf2EhaQjExoDYOarkFf0Y
         O41YnyeQ9I6FHv+VtEkpTJAWuNqqcU0IxGZo2xIbPmfEF6kRc4gS1MBxUmJXU2e9LQ32
         Knxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hfG5pLLGBVmijGs7xD1CuYUYuRgtJdbg/w8jfytxMq8=;
        b=NeJDOTXKPF6aInEbueKu1Z56jK2Hf7mJuUFYLprPPpWJux2YWtRMYxhGMGa++yXSCA
         yXy6Fb/tf50eDk39FteapJGZRqo+//f3OQxKdbHI7dq7liAsXn0NYvmSFajZl7+9gVUD
         +Pmdt6MV/d6gCMEKH3kaGSBh2IfbBW7dGqFPpkFngqHoqD8bEeT67WdM/81VuZsa0maX
         g714Ykr1r3uUn3L3anLrKpItGNOKV029lfC1MGi09DdcPEgv2+Fkuotrp3RsG1tgZ36S
         zJ2q3N+3mheFVrcxqd3nVxRs5cy5O2vrr69pN1eriZ4TAQmiV9jfFfd9BpCO6++3YQpg
         T9zg==
X-Gm-Message-State: AOAM530zJ6CnJKSOec5hKWy8te75Q9tejhbJ6Obn+N3e1bzPGDPnADoO
        4ACDvxN/pyfLH8CQ7oG1nB/xmOu6Oh4cRzdLIEQ=
X-Google-Smtp-Source: ABdhPJw2gIhU+kR4Sx6iXg7nZweEAbd8+bVuItdW1omD41KUb06isEtVR9mByToT58siGUrRB/NUDTpHz2hl5JtZxys=
X-Received: by 2002:a37:64d:: with SMTP id 74mr16642727qkg.407.1627921632473;
 Mon, 02 Aug 2021 09:27:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210731214211.657280-1-jim.cromie@gmail.com> <20210731214211.657280-6-jim.cromie@gmail.com>
In-Reply-To: <20210731214211.657280-6-jim.cromie@gmail.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Mon, 2 Aug 2021 17:27:01 +0100
Message-ID: <CACvgo53iF4Gk3XhQAtogf52CBFuB9tDxp+Mp8A1UwcvEOQto6Q@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] i915/gvt: control pr_debug("gvt:")s with bits in parameters/debug_gvt
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jason Baron <jbaron@akamai.com>,
        Ashley Thomas <Ashley.Thomas2@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Wyatt Wood <Wyatt.Wood@amd.com>, Jessica Yu <jeyu@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@gooogle.com>,
        Joe Perches <joe@perches.com>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        intel-gvt-dev@lists.freedesktop.org,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jim,

On Sat, 31 Jul 2021 at 22:42, Jim Cromie <jim.cromie@gmail.com> wrote:

> DYNDBG_BITMAP_DESC(__gvt_debug, "dyndbg bitmap desc",
>         { "gvt: cmd: ",  "command processing" },
>         { "gvt: core: ", "core help" },
>         { "gvt: dpy: ",  "display help" },
>         { "gvt: el: ",   "help" },
>         { "gvt: irq: ",  "help" },
>         { "gvt: mm: ",   "help" },
>         { "gvt: mmio: ", "help" },
>         { "gvt: render: ", "help" },
>         { "gvt: sched: " "help" });
>
Previous commit removed the space after the colon. The above example
needs updating.

This concludes a casual read-through on my end. Hope it helps o/
-Emil
