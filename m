Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58BE9426D37
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 17:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242870AbhJHPIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 11:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbhJHPIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 11:08:13 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC645C061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 08:06:17 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id q205so11068867iod.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 08:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nq/azJeEGbD1WnrPK14hpQApbcUJf/IRdz5vFG4BSxE=;
        b=J43F8mclugqMy9/dsjCSgtUqxG19MCEw1ACvISp4/ifSlkXNM+YeHzXrOtRwX9cs7D
         wokVxxqJ9zM0NKA9G0kis3NrUTvjgIEvRtmQ8kjKvkXBFhqw10ZV9B9jg/PCuRWb1mxN
         /BwNDPH8isKyUOTmZYz4NCf1JzIOzYcesPy4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nq/azJeEGbD1WnrPK14hpQApbcUJf/IRdz5vFG4BSxE=;
        b=q3C2o2TOki+vGclEDs5vPNPPpSwoY6ESei75735NUSmEyOw8plHcleXYt31Ph1P1ja
         s4J5Kuk7SNo0RoUF1oA0nFlTlz/8BpBmEjUOeEUPLICGHTg89xSV11nPd+icMc0kXwFw
         GBb/EULkWhkTRJQR2cau+5UZJE46dN2YlHV2v0t+Ar69U5mHrsy4W3Ug+mwqnfiyzrDG
         dYnJFIBHUDZzHFDd5WQOwwoXemgjrTmZNFmwjbXHhw13ucvpuDDNMXvTZww+nRciIK2N
         AVekMyYiS6dBWBJ+LQ5PM5Wyqq0P1m7CYQ3wteshHvzkKzyhY5VwYZLqDj9GFHqXbsU9
         oLjw==
X-Gm-Message-State: AOAM533IbXqjPHkZYUAAlDo2mnBhOv9uV8q/LjPXwm9oV1XkhNvAsmUf
        dCCCMzoa+YAK0ZAS4T19D0cE6O0Syke5Lg==
X-Google-Smtp-Source: ABdhPJz2DYUeH+ICGadLQmoOqEWu8zqOASmizhTX5/n0S5aK2ujSESlU0tXTb8om35of9gp3pcptPg==
X-Received: by 2002:a5d:8242:: with SMTP id n2mr8041096ioo.170.1633705576545;
        Fri, 08 Oct 2021 08:06:16 -0700 (PDT)
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com. [209.85.166.43])
        by smtp.gmail.com with ESMTPSA id f13sm1105942ioz.48.2021.10.08.08.06.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Oct 2021 08:06:15 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id b78so11099541iof.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 08:06:14 -0700 (PDT)
X-Received: by 2002:a6b:6a0c:: with SMTP id x12mr7755781iog.177.1633705574549;
 Fri, 08 Oct 2021 08:06:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210929173343.v2.1.Ib7e63ae17e827ce0636a09d5dec9796043e4f80a@changeid>
 <20210929173343.v2.2.I6050ba184b24d887e92692a72ee3054d643d6091@changeid>
In-Reply-To: <20210929173343.v2.2.I6050ba184b24d887e92692a72ee3054d643d6091@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 8 Oct 2021 08:06:01 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WkyYc7VGEuhafMFfTtc+kjYb2kO_R70bbss4kur6Dwbw@mail.gmail.com>
Message-ID: <CAD=FV=WkyYc7VGEuhafMFfTtc+kjYb2kO_R70bbss4kur6Dwbw@mail.gmail.com>
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

Landed on drm-misc-next:

e539a77e44c7 dt-bindings: drm/bridge: ps8640: Add aux-bus child

Then v3 can contain just the dts bits which will eventually land in
the Qualcomm tree.

-Doug
