Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 185DA312B78
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 09:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhBHIIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 03:08:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39075 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229609AbhBHIIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 03:08:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612771624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Lpxpa2kYKZq2T7KOylkeH5GurcJpKBZ4r2O2D2ivH5w=;
        b=BE+PvLYx+uu84k4l3T2zT/NqQ+bOiIOPVRqDg2ei8UB6R5m2cndGG6djMNOyOAX2xe2KPp
        OjoPdC0Jd5LZr4y+Jbmdyl+byviLmuCwE6abW4X9TyZaPmw2+RFAprTVvjmJO3tVHyY7Cw
        peKd9RlZbIHqqQeKi2cXJQ2S/ok/Tzo=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-579-ivZYPOf9M4Wqeir44qhxKw-1; Mon, 08 Feb 2021 03:07:00 -0500
X-MC-Unique: ivZYPOf9M4Wqeir44qhxKw-1
Received: by mail-pf1-f198.google.com with SMTP id j7so1825421pfa.14
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 00:07:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lpxpa2kYKZq2T7KOylkeH5GurcJpKBZ4r2O2D2ivH5w=;
        b=XImNfOi/l2nsMwk52ir5bTyBBOvbaUMs9pjHzNn77cZsDC5VCXthn5X9+8rcWKorrf
         A9F8GKWTb8s8iLkOSsoiWa5Ipat916kyOy0enRq18hPRhxy3qyTWAS8G7WihPAoZNrFP
         axjVId/ROmA6szzXG/9w2+/GUK/rLcqJpGyvycjCjivLPjBzJNJX7+NkqCNlYZ+re5ne
         l8KT5a6j7ufqKD4x1B2+DT8rP6AxM8+3o/B+EsPuNI9EprPK6TSUqSEQGWdqv7q1fiCX
         KFtcBFtyKPcw/e0EBqP08I+ln4OHrkDSx8HnI8gm1z/LJCvm5qDAX5cEYLPlSvHgf9NK
         o6kw==
X-Gm-Message-State: AOAM5336fEe7b0jarA7Dxsc8sPNhc9hAc2LpEjk+0y/J+v6ROAsLTbWa
        0wADccvM5HgnCMqreOwm59pib0Dg3BiUn/MgDH06Ouoj5BebUgV3IThVyovt+XpYXbssASY85Im
        86vb16YSTt54nHOFBCRz8eoq98bsWFFzWc6DzDvA6
X-Received: by 2002:a62:e205:0:b029:1dd:b063:8872 with SMTP id a5-20020a62e2050000b02901ddb0638872mr3382154pfi.44.1612771619443;
        Mon, 08 Feb 2021 00:06:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzAQDqeIL3uKwvgCr3sK0XFgd6KHtFGxwetDAWekwnkU31fTiEIkvaVcBGNAf2zljmwF8QuxcO0flw8wFkbWFg=
X-Received: by 2002:a62:e205:0:b029:1dd:b063:8872 with SMTP id
 a5-20020a62e2050000b02901ddb0638872mr3382143pfi.44.1612771619207; Mon, 08 Feb
 2021 00:06:59 -0800 (PST)
MIME-Version: 1.0
References: <20210208075205.3784059-1-nickel@altlinux.org>
In-Reply-To: <20210208075205.3784059-1-nickel@altlinux.org>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 8 Feb 2021 09:06:48 +0100
Message-ID: <CAO-hwJJpUj=+mpqQ7eMtbtwX6CPAkt2ZpDnpmX9GUDo1EuEOiw@mail.gmail.com>
Subject: Re: [PATCH] Input: elantech - add LEN2146 to SMBus blacklist for
 ThinkPad L13 Gen2
To:     Nikolai Kostrigin <nickel@altlinux.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikolai,

On Mon, Feb 8, 2021 at 9:01 AM Nikolai Kostrigin <nickel@altlinux.org> wrote:
>
> ThinkPad L13 Gen2 has both touchpad and trackpoint.
> PNP: LEN2146 PNP0f13
> With the default protocol (elantech-smbus) trackpoint is not operating,
> while touchpad does. Changing to elantech renders both operational.
>
> Signed-off-by: Nikolai Kostrigin <nickel@altlinux.org>

Instead of downgrading the capabilities of the touchpad, couldn't we
fix the trackpoint issues?

I am surprised elantech doesn't work with the trackpoint, because I am
pretty sure I wrote patches in that regard. Which kernel version have
you been testing?

Cheers,
Benjamin

> ---
>  drivers/input/mouse/elantech.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> index 90f8765f9efc..c4c3fa5828d8 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -1776,6 +1776,7 @@ static const char * const i2c_blacklist_pnp_ids[] = {
>          * These are known to not be working properly as bits are missing
>          * in elan_i2c.
>          */
> +       "LEN2146", /* ThinkPad L13 Gen2 */
>         NULL
>  };
>
> --
> 2.29.2
>

