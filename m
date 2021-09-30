Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06E1D41DE17
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 17:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346870AbhI3P4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 11:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346577AbhI3P4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 11:56:21 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0125DC06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 08:54:38 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id y15so7362838ilu.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 08:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ukJ8UdRAzd7VtHSG6snSf8AUrJFYkThG12qKfJkt93s=;
        b=KHQ+XS/wHzQMF8hxQILBr6I5RH0LLHNIqRTK46hcDUprihlf/AgVCh/Sw5Fb+4CSxZ
         hhg3Fb7YS//HumuLCDxYnrfLttqXQI3nlysMibZw0+9a86UkLtqA1eLwB4vbt5H5Jak3
         2FSP4zTBTlGarUuj+EE8Vy6oq7mI3TPGsXyNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ukJ8UdRAzd7VtHSG6snSf8AUrJFYkThG12qKfJkt93s=;
        b=vQfPLX486V8S1q+uc27AGqCy6/BICatbOsO0COMnIiURV0DKlTraE00GrrudBe96V0
         WYVGH3KHo0xzR9zKaBNcDcOSyalQQPkBTyFnqh06BlhlcYLac16iuPD/kpNqdHi4DxsJ
         gyqdaHyzujuI/vybqJxAmsc8LDmut8rmORRnXaJTOtOY+AU1jqFVHI7EU4pA48JiG0hR
         IpTkVPbnPWriH7D1qeXqGxp4IQBkUopUXtmX0KvPBDJj0i9zbiH0Oc8qt2Zc3r+h1Mbx
         chAFLsHToQo6YmL734sTJ+5IQ1W+4koCPe8E1T4mvYzwnn3Ek1UXcKVO9rTVv7LUlwZz
         14Lg==
X-Gm-Message-State: AOAM533HGkpnH75GqQlREeDJjN0tac8LECbcyyVGB2+txrIeXwCclkpg
        IfyapAbfvzZHyfk/Q8zDjhOUC9Fzi/ueAA==
X-Google-Smtp-Source: ABdhPJyGcsnchwkbw4WNJdmcEaWxToDTB6FuBk4hShsmX6V5tIrXyf5pF6LxtZ223XjmcX/4sxHYLw==
X-Received: by 2002:a05:6e02:16c8:: with SMTP id 8mr4660510ilx.250.1633017275882;
        Thu, 30 Sep 2021 08:54:35 -0700 (PDT)
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com. [209.85.166.175])
        by smtp.gmail.com with ESMTPSA id k6sm2049664ilh.55.2021.09.30.08.54.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Sep 2021 08:54:35 -0700 (PDT)
Received: by mail-il1-f175.google.com with SMTP id d11so7387709ilc.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 08:54:35 -0700 (PDT)
X-Received: by 2002:a05:6e02:1bad:: with SMTP id n13mr4681374ili.142.1633016843140;
 Thu, 30 Sep 2021 08:47:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210929173343.v2.1.Ib7e63ae17e827ce0636a09d5dec9796043e4f80a@changeid>
 <20210929173343.v2.2.I6050ba184b24d887e92692a72ee3054d643d6091@changeid>
In-Reply-To: <20210929173343.v2.2.I6050ba184b24d887e92692a72ee3054d643d6091@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 30 Sep 2021 08:47:11 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V2gf6jJuLaX+4fDjJ0QKmdZgD-HvL+OJ-NxyY5WOna2A@mail.gmail.com>
Message-ID: <CAD=FV=V2gf6jJuLaX+4fDjJ0QKmdZgD-HvL+OJ-NxyY5WOna2A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: drm/bridge: ps8640: Add aux-bus child
To:     Philip Chen <philipchen@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Balletbo i Serra <enric.balletbo@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Lee Jones <lee.jones@linaro.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Sep 29, 2021 at 5:35 PM Philip Chen <philipchen@chromium.org> wrote:
>
> dp-aux-bus.yaml says we can list an eDP panel as a child of
> an eDP controller node to represent the fact that the panel
> is connected to the controller's DP AUX bus.
>
> Let's add it to the ps8640 bindings.
>
> Signed-off-by: Philip Chen <philipchen@chromium.org>
> ---
>
> (no changes since v1)
>
>  .../bindings/display/bridge/ps8640.yaml       | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
