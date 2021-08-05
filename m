Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE0D23E1DB5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 23:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241729AbhHEVHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 17:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241555AbhHEVHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 17:07:00 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF3BC061799
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 14:06:44 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id y34so13667590lfa.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 14:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gjsfNCUHDF2l128sssKavdGD8G0WYEjRlXid67kgpQE=;
        b=E5dkRMn1u1x4oHRzSK8ctsaIs1Y8FaUyF1l2yBxY0aejO82HvzfgtGuQGpSbmTzGCk
         kWhXg4Wqsd0OkPJJL/SKWSQxgwLgahoZkCGnZanZm73yyCBeWKcsAncBkun/BGz+JU5q
         RHeFdEVRPp/5g/sJMpgU6kaE5EjRbJEnbSh97ikKLyY+aTn4k+8UHgSTEpHh2ko/fYFW
         fJZ0KRg31OUELKj0RUlG6RZr+fE4+1FTJekYo+OZJxahEdutd6OpbpGXzn6moKRC23/L
         m0KABb2OdH4xnmHuBn5lUvw/1BE6jlGen/jmSM0gs1THeBC+Qo0ezE/Ckek1qn3qKdxU
         dm7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gjsfNCUHDF2l128sssKavdGD8G0WYEjRlXid67kgpQE=;
        b=s0mcxuaY0TnAxbDNEGRoj6rNIxNbFek8mZxbyMAVoM82ehTu8rL0gkfpyO+erapzqE
         vfXkwudP21PDf86qqxXtCArc7mQUM3SH4/euABwc0gjYk24qLPloyq/upIC7OHtaeOLO
         E93O6BrGT1Ovo2hp3hK1XBnRV6UCXdm0d3ZXCtbvTCOgQRiJIzGjuy3m/rpUJaAAZdRU
         PWT9jhe+3Mc+62aCaciSI+XsqmYziwOkLaggctw0dcRfyAnQXdCSwwmG2S6i5Xajiw2V
         dpUFBCi5VxZP+/mFNjSbIouZO44VIicSXOWvv4lkziHprSK6JZ7hQqVOJskp/cENMUxM
         06jQ==
X-Gm-Message-State: AOAM5319HrHoLBaDkqjRymwYEypN7OeAN1TlXnuWpiHToR1Cpiwf7tby
        0uhLlrGW1LglBK3AVxoWyPuSsK0za5FVLAEGNtsslw==
X-Google-Smtp-Source: ABdhPJw6fssTolA66bgLiBJnBkcfc29bVY2AgY8ZqmtT5FPqQrFnL8uE0+7E0eO0eFAT06+vRoVWmNhOddMcF1y09zA=
X-Received: by 2002:a19:7b14:: with SMTP id w20mr5150929lfc.29.1628197602250;
 Thu, 05 Aug 2021 14:06:42 -0700 (PDT)
MIME-Version: 1.0
References: <YQmG6EbBherV+8px@ravnborg.org> <20210805133343.27032-1-markuss.broks@gmail.com>
 <20210805133343.27032-3-markuss.broks@gmail.com>
In-Reply-To: <20210805133343.27032-3-markuss.broks@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 5 Aug 2021 23:06:30 +0200
Message-ID: <CACRpkdZXRtP4Z2UEQz-gwuPFkVhXTth0nFDioO9a+JKOtHXU4w@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/panel: s6d27a1: Add driver for Samsung S6D27A1
 display panel
To:     Markuss Broks <markuss.broks@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        phone-devel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markuss,

sorry for reacting so late!

On Thu, Aug 5, 2021 at 3:36 PM Markuss Broks <markuss.broks@gmail.com> wrote:

> +#define s6d27a1_command(ctx, cmd, seq...) \
> +({ \
> +       struct mipi_dbi *dbi = &ctx->dbi; \
> +       int ret; \
> +       ret = mipi_dbi_command(dbi, cmd, seq);  \
> +       if (ret) { \
> +               dev_err(ctx->dev, "failure in writing command %02x\n", cmd); \
> +       } \
> +})

You don't need this wrapper anymore, just call mipi_dbi_command() directly
everywhere you use s6d27a1_command().

Because I merged this patch:
https://cgit.freedesktop.org/drm/drm-misc/commit/include/drm/drm_mipi_dbi.h?id=3f5aa5ac0b0f9704f0c60f5fbbbcdc8c043d6eb6

Yours,
Linus Walleij
