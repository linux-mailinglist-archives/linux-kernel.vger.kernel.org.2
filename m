Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E33363DC92C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 02:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhHAAtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 20:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbhHAAtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 20:49:08 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC279C0613D5;
        Sat, 31 Jul 2021 17:48:58 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id f6so10300801ioc.6;
        Sat, 31 Jul 2021 17:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dIcKvSDUxKhGQLJXFjHOTdn0zd4fY2Y+EtuO71E/gQw=;
        b=PtfYOsTDptsYy0YIEKDi64pNVZlu86W9/g3MGWNO9D4F0+kSIkJTZx51cIq/pAIPry
         FGLT3O2GOQByLQ/TZ7jCdA90M2IYoEoQ80inY+/mWzFZFqxzRUAtzHOVabEGyYaA/weC
         Ra+RFN80VoBK1uzt+PtmaFaeyU8hMO2aXDsGIENuSfmLt9ajY3KcOtEgiDFASb6VnCnX
         NefCtlsCttcKDS71HfPA2CVQnRMsevxLMBVLtHBYWfBvq87e0xM9ZtI6HGDR84QYf88R
         DYWKqz7RRnkJccRlrZDo/dMm9CWjJFlFwjU5+oew+qOuAiXFF8SeRHeUT6ELFMT3pmAR
         mhyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dIcKvSDUxKhGQLJXFjHOTdn0zd4fY2Y+EtuO71E/gQw=;
        b=laWmAgyebFyrBvk8ncEAFNm4zBRl5E1EdgKVh4sUrv8m1KZR7eaOBGBjs284kC2FVq
         FO97KhC4f43ZbiMEBtX8ZcFHeqncyegw/vOnke/RFEuJB3nCpAGzYy4yytVqA4yzXYpn
         5limo7BiQjXEm5ES/Z1Lpp+1WLV3dXonKkvhuE5yr0j2xsQyfcqEb7ABqtSdr8AV7YWP
         j7O/OH2mbREHdd9zCkIrIUsf3dWfIdD7WQWUuis16R0bkFtwW8ZdYkFdKThgOOySpK7X
         xoL1+r5sDb1BoDNlAIEzXQlxV9FmKQLpMDsbvJgE9JtqnUW0SbFn3MKd0jtd49zf330c
         h2Aw==
X-Gm-Message-State: AOAM533hz6BtZ++cLGapfcebQ2Qo5jIW/kSJ3hNQTZX9ajZKpmpu+c33
        g5leM91NAXvqLev0KgkU+qTqwyqRXplyq3Q8kpA=
X-Google-Smtp-Source: ABdhPJy6l5NQD1s1nsQCCad4HUdJ1fLYJkA3RRZGX5nEjYID7/ogMW80Fv49iGIGOGYA1cjXJq6cyMw6hS6YEGByPqU=
X-Received: by 2002:a5d:8541:: with SMTP id b1mr2090135ios.105.1627778938146;
 Sat, 31 Jul 2021 17:48:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210730121310.131-1-alistair@alistair23.me> <YQWV54S1nkJdcgce@ravnborg.org>
In-Reply-To: <YQWV54S1nkJdcgce@ravnborg.org>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Sun, 1 Aug 2021 10:48:31 +1000
Message-ID: <CAKmqyKM2CRfP_jKXUPEWQS0vCBLf0bVBQ1EE4gBer_F8Nv=A4A@mail.gmail.com>
Subject: Re: [PATCH v5] drm/panel: Add support for E Ink VB3300-KCA
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Alistair Francis <alistair@alistair23.me>,
        Rob Herring <robh+dt@kernel.org>, thierry.reding@gmail.com,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Daniel Palmer <daniel@0x0f.com>, linux@rempel-privat.de,
        kuninori.morimoto.gx@renesas.com, max.Merchel@tq-group.com,
        geert+renesas@glider.be, airlied@linux.ie,
        Daniel Vetter <daniel@ffwll.ch>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 1, 2021 at 4:26 AM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Alistair,
>
> On Fri, Jul 30, 2021 at 10:13:10PM +1000, Alistair Francis wrote:
> > Add support for the 10.3" E Ink panel described at:
> > https://www.eink.com/product.html?type=productdetail&id=7
> >
> > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> > Acked-by: Rob Herring <robh@kernel.org>
> > Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> > ---
> > v5:
> >  - Add .connector_type
>
> I missed this revision before sending my last mail.
> I tried to apply this patch but every patch confliced due to other
> changes since the kernel this is based on.
>
> I need you to generate a new patch on top of drm-misc-next,
> or as an alternative on top of linux-next.
> You are in a much better position to do this right than I am.
>
> Sorry for the troubles!

No worries! Just sent a v6 rebased on linux-next.

I am never sure if my patches should be based on master or linux-next.
Sorry for the conflicts.

Alistair
