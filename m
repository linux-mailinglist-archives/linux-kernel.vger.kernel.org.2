Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032B13E266C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 10:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243507AbhHFIuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 04:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241956AbhHFIuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 04:50:15 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE98C061798
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 01:49:59 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id m10-20020a17090a34cab0290176b52c60ddso16524969pjf.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 01:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qH33sCsdvNwcAdOQ4lar/ZHxaC7E5XO1MhHrUGkGMBc=;
        b=qnjQoQHxIRp0+bdqIOvjJH1sDDkSWql9GHtrk03LrS5B5Z3SMxi8VhakOWZ+Iwxg6x
         uSAIwjT+spwj+AgvcNmPf45kLcJ/14J0SjZlVWndlWspGtYr/ABoFwpWJFaXS0p+Jjam
         uI3Rtf27Ni+Yc2gZXBqbpZ+czxTBr/VKBHr9rr7uq1COQ6aWFIPjRlXJdEX7b+j56IWD
         tuXKOu2xW+TlWXCj5M3mFaJhSpnSiXCeYUXP23qvARP4J+HY8imRy43LRbbN2LQpe1N/
         tmHMnp1q2uxDIcuUOTqsN8TH6CUAR/EKJvJpe/dNPE0AUBZ5PZ3ayeD1T2KZfzvhcq3u
         SwYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qH33sCsdvNwcAdOQ4lar/ZHxaC7E5XO1MhHrUGkGMBc=;
        b=ZkqiHRyf+CaVVMlVPS7FVPi6NIOPZ1bu8dKUnzGwAHUFpomHJ/My2M+6Ye+13nWjpZ
         hHvIE3bKSeCbeErmXKkn/3vLnJ1flEaeE7N3nvgTOVeYkCoqJIa2K8nrS5lfcFZLTw56
         ARuM0R+cFmcM1aXqN/O/mO0XROQXm+RIgVMIbC2Jt4vTiaV8kkkteyTnvDDSg2KNY9Gb
         bad+lDvG+jTOSvVAryR9RfGThYK6Q5PkUAaL8/jNlKxnwiSFdlZijV+VbKB3ACoJ+mVN
         m1or+t1viQ6CzdH+aUZso9NZAsv5gYvYZ0sxXXuLlkce8wsIbtpeGa+B61nTpojyjN5x
         ndjQ==
X-Gm-Message-State: AOAM530QZkAqEiNb8koNwY5NBQvDc4K/jIakFh1KmFwgWCdCHHM2YY3M
        5TUjuWOH+FlrbJKVRLJupPAxVCbaHR3Xx/NRM68SOA==
X-Google-Smtp-Source: ABdhPJxUhN/2FiGiUbmdum2JbNWeh6/kiZCCEu1OuOrMDFEjeINK/6Q251/JuXK0kduq937OlbfbkvOIwcmmF/EonvY=
X-Received: by 2002:a63:494f:: with SMTP id y15mr408472pgk.185.1628239799068;
 Fri, 06 Aug 2021 01:49:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210805185039.402178-1-robert.foss@linaro.org> <3283765.IqGz30O6Nz@kista>
In-Reply-To: <3283765.IqGz30O6Nz@kista>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Fri, 6 Aug 2021 10:49:48 +0200
Message-ID: <CAG3jFysCX25k2QQqTqHCt3HRCG-s6cn2f99L7WM23K=zHv_wOg@mail.gmail.com>
Subject: Re: [PATCH v1] drm: bridge: it66121: Check drm_bridge_attach retval
To:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     Phong LE <ple@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Aug 2021 at 22:37, Jernej =C5=A0krabec <jernej.skrabec@gmail.com>=
 wrote:
>
> Hi!
>
> Dne =C4=8Detrtek, 05. avgust 2021 ob 20:50:39 CEST je Robert Foss napisal=
(a):
> > The return value of drm_bridge_attach() is ignored during
> > the it66121_bridge_attach() call, which is incorrect.
> >
> > Fixes: 988156dc2fc9 ("drm: bridge: add it66121 driver")
> > Signed-off-by: Robert Foss <robert.foss@linaro.org>
> > ---
> >  drivers/gpu/drm/bridge/ite-it66121.c | 2 ++
> >  1 file changed, 2 insertions(+)
>
> Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
>

Applied to drm-misc-next
