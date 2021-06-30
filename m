Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C503A3B7DDD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 09:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbhF3HMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 03:12:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55726 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232823AbhF3HMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 03:12:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625036981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q18aGERUrb8MXoJ7uF/M0uiRsJPxf2agVURvlb+VBVE=;
        b=ervHHmumT2IArFzymCk4+4pN3RLq8IZfYm8sL3dg7+6do2k4YoH+T0ERl4bpuYrove2UQa
        NdeZ/VWmmbBPzJGl/WQeWMhj+UmEzIQPmQSgOTtTa69RBDy+/2ruVYZ9BNle7uMLdWw05V
        EMn7NwWP/u+nJWX1VzP5/d6XFGrYEvM=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-563-HWnVALD_MsmXaxD4qjoqvg-1; Wed, 30 Jun 2021 03:09:39 -0400
X-MC-Unique: HWnVALD_MsmXaxD4qjoqvg-1
Received: by mail-pg1-f200.google.com with SMTP id d28-20020a634f1c0000b02902238495b6a7so1061633pgb.16
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 00:09:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q18aGERUrb8MXoJ7uF/M0uiRsJPxf2agVURvlb+VBVE=;
        b=C7Oid4gzd8gU8GBijhjjXiLoFYm3DDw2BsEbMzqsmeOq4webDA24W+BMsGgvsr0WLE
         M4dzuVws7wsEXSpU5uuwKZTiMgZsei1I1Y/0mOXBfuOSnUrMKqCScgJCzHTDsZel87HR
         UrNGteG4BuTmOAuLCkwJ31dd3e/8xsSMrfJrW+21nBSODY2bH81l/0U9txsOh6B1m2Vp
         47/yOtFyP0Pz6AAMTINJe44aXGcNH8XaeNkqbVnwVBqH+05KEsVxBDBlaVSO/hYa9Y60
         J96KuLPYHHrUL66NvdrZ7WdS4l7Xd0cKjQN51vdMrHfxDzQRcvgviWANcugQiKssqQR+
         YNCw==
X-Gm-Message-State: AOAM531I+EAspzMmBhix+AZfIxIjtN8pP3Fu/AaT8KcUJW8fb4iR0uUy
        7f6tvgSdY0Rs9V/EOw5SHgaDaGWM/CG0ug9wCYbkbXBJfQmPTqrnpyzOiRk6W4fk2Yb8vx6wD4u
        cCUpi5qUOz6ucQBhDLFH6PGGVkI4G6HZ1XS9+bX35
X-Received: by 2002:a17:90a:5889:: with SMTP id j9mr38116479pji.234.1625036978313;
        Wed, 30 Jun 2021 00:09:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwyfRTZ234ZIqRtqXaVxOazEOugzigkHX+SuWQnUapE6hJKzL6PWnsWKH0UoiAtg14WGWpsaRbMv84hFVc2rYc=
X-Received: by 2002:a17:90a:5889:: with SMTP id j9mr38116460pji.234.1625036978035;
 Wed, 30 Jun 2021 00:09:38 -0700 (PDT)
MIME-Version: 1.0
References: <YNtlrrKZVQY4byVa@google.com>
In-Reply-To: <YNtlrrKZVQY4byVa@google.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 30 Jun 2021 09:09:27 +0200
Message-ID: <CAO-hwJJ-VyKBohETJabxmgjZ8RtmZHWWOBr2kZNC=feOxHgTtQ@mail.gmail.com>
Subject: Re: [PATCH] HID: input: do not report stylus battery state as "full"
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bastien Nocera <hadess@hadess.net>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Kenneth Albanowski <kenalba@google.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Tue, Jun 29, 2021 at 8:26 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> The power supply states of discharging, charging, full, etc, represent
> state of charging, not the capacity level of the battery (for which
> we have a separate property). Current HID usage tables to not allow
> for expressing charging state of the batteries found in generic
> styli, so we should simply assume that the battery is discharging
> even if current capacity is at 100% when battery strength reporting
> is done via HID interface. In fact, we were doing just that before
> commit 581c4484769e.

This commit is 4 year old already, so I'd like to have the opinion of
Bastien on the matter for the upower side (or at least notify him).

>
> This change helps UIs to not mis-represent fully charged batteries in
> styli as being charging/topping-off.
>
> Fixes: 581c4484769e ("HID: input: map digitizer battery usage")
> Reported-by: Kenneth Albanowski <kenalba@google.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/hid/hid-input.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index e982d8173c9c..e85a1a34ff39 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -417,8 +417,6 @@ static int hidinput_get_battery_property(struct power_supply *psy,
>
>                 if (dev->battery_status == HID_BATTERY_UNKNOWN)
>                         val->intval = POWER_SUPPLY_STATUS_UNKNOWN;

What's the point of keeping the HID_BATTERY_UNKNOWN code path? AFAICT,
before 581c4484769e, we were just returning
POWER_SUPPLY_STATUS_DISCHARGING. If we don't need to check for the
capacity, I think we could also drop the hunk just before where we do
the query of the capacity.

Cheers,
Benjamin


> -               else if (dev->battery_capacity == 100)
> -                       val->intval = POWER_SUPPLY_STATUS_FULL;
>                 else
>                         val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
>                 break;
> --
> 2.32.0.93.g670b81a890-goog
>
> --
> Dmitry
>

