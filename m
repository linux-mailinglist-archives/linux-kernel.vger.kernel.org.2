Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF1C83B7A44
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 00:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235343AbhF2WKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 18:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234110AbhF2WKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 18:10:01 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DF2C061766
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 15:07:34 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id yy20so518328ejb.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 15:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1q7Ain0DLUkGOfXS9EwfmlJ7f9E2SKVgo1z1o4tW/v8=;
        b=sNJP561TgLPulHMOn7QGOO2ndcGumuoOg3lMJmx9mePF3ls5eTTIX0sGZ2zNpLEXaU
         J7rzQdc5YT5pdKkAAGvaAk0gQ9sll7hgjRY21wJm9/USdN0drvSZW32uTYMAM2y/HLO/
         dAIYpyHzjZ/TyDiws9b6v7fPcMCh7EaztHjSwWNPAjbO+vYfTnmJq+IpaWRfmneoCIAy
         b4IKFit61HKhQ1MVC1J8wb4lZcP8k1+gcu7hEHf1rK5xmTAsfk4k6bQcAKCyhXShefaf
         Rt11rvdrWGjo56phA0v1fYSWwwv+rhBsLbsecSW5JfB9H6yrLzroABGfbaWHPh4EyuVc
         A35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1q7Ain0DLUkGOfXS9EwfmlJ7f9E2SKVgo1z1o4tW/v8=;
        b=fpRkSM2VzIlGJA7+F+/EW66MFBt7vZ11/QHvxL/v+UVCkGMN3p8oVVX7U4zo7idWOK
         duZXZQHE4r2P6OJLQseDcJyjn1jRJQWUWxfYEPiwRq5nHOWgptNfmY5ciP96MUbBs1dF
         8xEi46avAZmLbM3YKfMVHMsokmGN/QZ6x42/oYqMWE9s34Rx0uCsZn6nryc0jkpRztjf
         d8qUgteo5CJweD6uo8zLbjOw5Qk9Dil90bNXP6kehIVn/R5nxp/Po0iBB1dnH5wyDmPr
         JBmkWtUFeyUlHOkn4m8hH06+dT9QrIkyHKLjtdz1e6CCMWJs0ip9fUFkhLxFuaNJXXZd
         q9bQ==
X-Gm-Message-State: AOAM530YBLwiRtzE6iuliNj1Ot0PnvjGmj0m4YdiKXoqXhxkDAH/qz7D
        fHvemx8iyDTWjvUOyaxzGrQVEVMj8Eb2CL69fO/pFw==
X-Google-Smtp-Source: ABdhPJyFL8pCPijezwPCujfo677fGnEMrbfTjwpgNpqLmPtMLLSo5Wkmd3U8I7RWYi73MzJC1yy4wGds03Y/Y7Fh8OQ=
X-Received: by 2002:a17:906:70cf:: with SMTP id g15mr31769008ejk.366.1625004452346;
 Tue, 29 Jun 2021 15:07:32 -0700 (PDT)
MIME-Version: 1.0
References: <YNtlrrKZVQY4byVa@google.com>
In-Reply-To: <YNtlrrKZVQY4byVa@google.com>
From:   Kenneth Albanowski <kenalba@google.com>
Date:   Tue, 29 Jun 2021 15:07:20 -0700
Message-ID: <CALvoSf7y2WRtX5R8-_Uo1Gzhq4i_WnMRw0AGMW+JQdZvXMX_Xg@mail.gmail.com>
Subject: Re: [PATCH] HID: input: do not report stylus battery state as "full"
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've tested it on a 5.4 derivative, and that works as expected. Looks
good to me.

- Kenneth Albanowski



- Kenneth


On Tue, Jun 29, 2021 at 11:25 AM Dmitry Torokhov
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
