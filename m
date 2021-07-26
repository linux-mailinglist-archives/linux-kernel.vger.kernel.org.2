Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE073D53B9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 09:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbhGZGeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 02:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbhGZGel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 02:34:41 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A116AC061760
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 00:15:10 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id h11so10101469ljo.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 00:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cOfpNk8cBwygjzCjyHz8QRiXxo98sz2BqAuXNRnjjWg=;
        b=lEFUh/WH6uiITinRF/Iqnt5mx0rDbjrYjOAX+EqORbulhwCdiFCiM14vzgxuTeXiC4
         U+EmK0jTo5sdIvsyHjZA1IYkt3ySBDTyc5497lw0rHm4iBT4Hsp2JUGlUblQcD/rRVCc
         vjTLrw7tTOB22lnDgqVA3cgwhX5qOFXWku54RtGwwhfWA4zNCmq0ObobAB8J6IuE/Euj
         bw7GRhZPw4K+O83v4hHeCZNltTeKX8KimIWvHSpXglmT8oFVayW9ZMwSYWOAcSFjrmIM
         W6z4HnsYn48XBImAeDcOHqZdfp1d0E1Hu9UwP1NbHvyREsmKlQThD4Dgo5njIWEvrmE5
         zczA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cOfpNk8cBwygjzCjyHz8QRiXxo98sz2BqAuXNRnjjWg=;
        b=q88ZONkMqGaZ87qlvw4VMNrEh5ne9PiE1LJUUCdg6RqO92XPNMJtikJDR8/xvgqVp3
         gitILWL7O1dfgk/r8xvMU0qR0J5YJFUN5hSUFeuaP1NJMI6bsA6vPDXJAeTBXTtu8Q9E
         2fYv0npWZPlMWP71NuxxnbA1xFirQhIZYGFWuHJpD4AzJyDuIZ/W+oyOXQvikY62i4Lt
         XcjPwf69QgLM+TVLDFt53pWb82r+68v1GOsO+VXeyIAbRF0c5Up5ItogbiLGuf24hlro
         15o0axH0pre4RkMsiKnnNtpm4BbSqQpDQXxcCfls29n3nZJ0LcrIliM1tOR27MzctFjq
         0sMQ==
X-Gm-Message-State: AOAM531d+Pd8DFjb0w2shqM2U+NFcEsrYePsM0NlfgmKRWhImjWSHei5
        3fgRHEyoVH8/J7lopnHHa4VbfDatDldjTJdV77K2VQ==
X-Google-Smtp-Source: ABdhPJyUe92qyD4ubvU/cbw2RdqOOoO//w6eh4gn88UzLyuYn5bk8b3ggPXevchReZQ2PP7O1b8K+LWJqxxjari5FZU=
X-Received: by 2002:a2e:950:: with SMTP id 77mr11173508ljj.438.1627283708901;
 Mon, 26 Jul 2021 00:15:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210201165307.51443-1-iskren.chernev@gmail.com>
In-Reply-To: <20210201165307.51443-1-iskren.chernev@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 26 Jul 2021 09:14:57 +0200
Message-ID: <CACRpkdanNPaBOAo80wSvNU=ynkS5AVc6gV02jTfq-AePye+fGg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: panel: Add Samsung S6E3FA2 panel
To:     Iskren Chernev <iskren.chernev@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        phone-devel@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
        <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy
        Shevchenko <andy.shevchenko@gmail.com>," 
        <~postmarketos/upstreaming@lists.sr.ht>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Iskren,

thanks for your patch!

On Mon, Feb 1, 2021 at 5:56 PM Iskren Chernev <iskren.chernev@gmail.com> wrote:

> +required:
> +  - compatible
> +  - reset-gpios
> +  - iovdd-supply
> +  - vddr-supply
> +  - port

I do not think port should be required because the DSI
framework allows panels to be put as children right inside
the DSI controller node without any port linking the two.

Other than that it looks good!

Yours,
Linus Walleij
