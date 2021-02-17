Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F36131DFF5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 21:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbhBQUGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 15:06:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47804 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233644AbhBQUGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 15:06:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613592294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vHoTmntEev68EJcmebE3piRT4pPjx5R2AdcGSR/9YdY=;
        b=J1nK8daiMEY/r56eXbg6QXcdKtaR8gZ9as2GKUE0nQZz4MYUlS746Etfj92zKBh706K6Yu
        sSUO7on3mEZCE1Ff53/x7xLDzjDj/2tzj8JTh8tY+lVmCBaV6XiNUcgbDdtliGNkeH0dZt
        u/NFArP/naZPh3xWeug4DVttfnUWmIw=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-CTGo-Nj0O7aiESI2u3zTpw-1; Wed, 17 Feb 2021 15:04:50 -0500
X-MC-Unique: CTGo-Nj0O7aiESI2u3zTpw-1
Received: by mail-pg1-f197.google.com with SMTP id n2so12556599pgj.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 12:04:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vHoTmntEev68EJcmebE3piRT4pPjx5R2AdcGSR/9YdY=;
        b=EjTOnAvD9u1cRpvKPby3tA5S2WG8W8QcDoVhMzIYcjsy10UAilK80CQAUCdQRKrGrF
         DVMo23uNP5NaV+iZTMR8kRmfbhq/nrx+ViTZJx/ZzQZLsxP+zymqRtSam4qEe04+YQWz
         SLKnFY0Jxoyb5zyzxwG2uTnlHB4QOX3+Ndrw8je2nEV+v2zIvwUX1IXrmJAkbPKwIqSG
         nmWBcbvN/X8mxfgOcj8/5YLAbbS49/I7TJWMCaEGKIxJmC/xby2jtH+oQE/3ehgEjEsC
         XnJodg3Qe/bD9G9Y4VRKnSmiv0OppDXAlXUnGcQYtwAN917bS6ituS5erBJsZttDlux6
         z5VQ==
X-Gm-Message-State: AOAM530EPa0qaMpvaUl6nGV4y2MUebLStA2Jkj8s1z0U6czmK7ol+Nv5
        pj9aThfHoNLZv8zeEE7nHxKMmvxdVuUcakEtQzpg5YyRs7CjGQ0+ffvarbEjlUAP18UrC2oi5iT
        CwOupgYrpPtEGFHKQpzIiui95pypJqqvRGDexrJq2
X-Received: by 2002:a17:902:d4d0:b029:e3:480a:cae3 with SMTP id o16-20020a170902d4d0b02900e3480acae3mr659682plg.41.1613592289317;
        Wed, 17 Feb 2021 12:04:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwHK4y3zAv0/eqFBkTaoINYheQA70AODu58g83uoMfRBuIwAAnwdz1Gnbi35DShRThTbkZayF790UdUG4DSrlY=
X-Received: by 2002:a17:902:d4d0:b029:e3:480a:cae3 with SMTP id
 o16-20020a170902d4d0b02900e3480acae3mr659658plg.41.1613592289030; Wed, 17 Feb
 2021 12:04:49 -0800 (PST)
MIME-Version: 1.0
References: <20210215163921.84283-1-colin.king@canonical.com>
In-Reply-To: <20210215163921.84283-1-colin.king@canonical.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 17 Feb 2021 21:04:38 +0100
Message-ID: <CAO-hwJ+P=jH3ByHdab=qmrOWupnq-fiA0UR8mdHF1pQAuEqbAw@mail.gmail.com>
Subject: Re: [PATCH][next] HID: playstation: fix array size comparison (off-by-one)
To:     Colin King <colin.king@canonical.com>
Cc:     Roderick Colenbrander <roderick.colenbrander@sony.com>,
        Jiri Kosina <jikos@kernel.org>,
        =?UTF-8?B?QmFybmFiw6FzIFDFkWN6ZQ==?= <pobrn@protonmail.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 15, 2021 at 5:39 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The comparison of value with the array size ps_gamepad_hat_mapping
> appears to be off-by-one. Fix this by using >= rather than > for the
> size comparison.
>
> Addresses-Coverity: ("Out-of-bounds read")
> Fixes: bc2e15a9a022 ("HID: playstation: initial DualSense USB support.")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---

Good catch.

Applied to for-5.12/playstation-v2

Cheers,
Benjamin

>  drivers/hid/hid-playstation.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-playstation.c b/drivers/hid/hid-playstation.c
> index 408b651174cf..568a3a067c88 100644
> --- a/drivers/hid/hid-playstation.c
> +++ b/drivers/hid/hid-playstation.c
> @@ -1064,7 +1064,7 @@ static int dualsense_parse_report(struct ps_device *ps_dev, struct hid_report *r
>         input_report_abs(ds->gamepad, ABS_RZ, ds_report->rz);
>
>         value = ds_report->buttons[0] & DS_BUTTONS0_HAT_SWITCH;
> -       if (value > ARRAY_SIZE(ps_gamepad_hat_mapping))
> +       if (value >= ARRAY_SIZE(ps_gamepad_hat_mapping))
>                 value = 8; /* center */
>         input_report_abs(ds->gamepad, ABS_HAT0X, ps_gamepad_hat_mapping[value].x);
>         input_report_abs(ds->gamepad, ABS_HAT0Y, ps_gamepad_hat_mapping[value].y);
> --
> 2.30.0
>

