Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD3E325A92
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 01:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbhBZAID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 19:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbhBZAH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 19:07:59 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5AD1C061786
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 16:07:18 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id p2so8947445edm.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 16:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0dMNeVGeNEmq1dAI13Mytw4Ljru52gLa+2kqt1mu+Ns=;
        b=METfQ3BbsD7YYDm9ZB2eQh1FLAqtJK/MIpVHTLeVQbpVt9Ux685sNV3kKIidveaJR7
         Pc322TlXOrqsKq6CUOsEkxghMCtAQXXTXW3rv/oO8M4TeXIg6vPy5bsT0LKJC/wenc2e
         z0ATStODbpurtX2KqgKVZ+ZZjg6ROh0h0g9oYtI3X7NszSMrmqMBIoJ94CAuCf8fJFD6
         xYxYDis8HF/y13Wp1l8P+RdzBNRFESddiBSwBP4dYOP1l/kJEA1XkETk7nmZGpY1Kz75
         6h8PpGz0wFn6l/Bxh4BQd0y10iLvR2BhE0lu+14D1yqv3pUsCIAJXJQOObcMXCm6uHbY
         /K5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0dMNeVGeNEmq1dAI13Mytw4Ljru52gLa+2kqt1mu+Ns=;
        b=qxhlfj/ClZGe3W/sENeih3kiluL3KCzQMVhdb+4N31qS25wNKc7DT/KqmGVFFsA6E0
         xdQd6fyyzyNodKFzgMxO4HOk+Zcaf4N9Z1rWty5rgFQxixhIfe5sPv+NGIVF73lTRKI3
         bP2yQHJ54sX6Yyz2td4G21XtE9pWl12WJvHigvIG8LONfgL9cg1jf7/MxSyAQKpzsWpO
         QeyBqYvmZDtCYPXyYtGzmZmaK5xtqLwEjAx4f20XSqM/4FRM9VjQKhpbgDijaKTgI9nl
         lXtpE+MagtJYwE2zbdScsh9quLt7+L1e6uMdPx4ZTVBW9wLXMu1LC//RQwdpR/I2it+r
         Z6hQ==
X-Gm-Message-State: AOAM530iFfsXUEDyqNLPF3h279z8cZilEcDFGREjLdqnbtAkRbQWSElL
        G5tZUzxZ/eiPLhJgMdmoK8wONVSIFMx8Reo+8NaKAw==
X-Google-Smtp-Source: ABdhPJz3vDnmJKa1/D8y2YKRdHcDVB2YrPbbchrmyz/pA3o6/3+TJEWKTt8v+d+9rqLT6nw3XmAQzPHb1Ft4fkxcspA=
X-Received: by 2002:a05:6402:2ce:: with SMTP id b14mr500529edx.13.1614298037635;
 Thu, 25 Feb 2021 16:07:17 -0800 (PST)
MIME-Version: 1.0
References: <20210225120601.669238-1-enric.balletbo@collabora.com>
In-Reply-To: <20210225120601.669238-1-enric.balletbo@collabora.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Thu, 25 Feb 2021 21:07:05 -0300
Message-ID: <CAAEAJfAubBp4t=6N1vVmH6ksuChZK9GnHydGf-v-3wy9Z9GQrg@mail.gmail.com>
Subject: Re: [PATCH] media: hantro: Auto generate the AXI ID to avoid conflicts
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        fbuergisser@google.com, Doug Anderson <dianders@google.com>,
        Collabora Kernel ML <kernel@collabora.com>,
        acourbot@google.com, tfiga@google.com,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devel@driverdev.osuosl.org,
        linux-media <linux-media@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

Thanks a lot for the patch.

On Thu, 25 Feb 2021 at 09:08, Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> The AXI ID is an AXI bus configuration for improve bus performance. If
> read and write operations use different ID the operations can be
> paralleled, whereas when they have the same ID the operations will be
> serialized. Right now, the write ID is fixed to 0 but we can set it to
> 0xff to get auto generated ID to avoid possible conflicts.
>
> This change has no functional changes, but seems reasonable to let the
> hardware to autogenerate the ID instead of hardcoding in software.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>
>  drivers/staging/media/hantro/hantro_g1_h264_dec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/media/hantro/hantro_g1_h264_dec.c b/drivers/staging/media/hantro/hantro_g1_h264_dec.c
> index 845bef73d218..090088cd98ea 100644
> --- a/drivers/staging/media/hantro/hantro_g1_h264_dec.c
> +++ b/drivers/staging/media/hantro/hantro_g1_h264_dec.c
> @@ -30,7 +30,7 @@ static void set_params(struct hantro_ctx *ctx)
>         u32 reg;
>
>         /* Decoder control register 0. */
> -       reg = G1_REG_DEC_CTRL0_DEC_AXI_WR_ID(0x0);
> +       reg = G1_REG_DEC_CTRL0_DEC_AXI_WR_ID(0xff);

Can we define a macro to avoid this magic number,
and add some comments explaining what's 0xff for?

Given this is AXI configuration, I'd expect it's CODEC-agnostic.
Maybe we could move CODEC-agnostic path to avoid duplicating the code?

Does this change apply to the rkvdec driver?

Thanks,
Ezequiel
