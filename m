Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B71EC3E376A
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 00:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhHGWi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 18:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhHGWi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 18:38:28 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECD4C061760
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 15:38:10 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id x8so25867676lfe.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 15:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lj89aSQV7OCOrepNKn8koFUUrCNiOnfBqunvMMwzNw8=;
        b=oh7DQA5GxYuqxO4BZrykAhKNgaCAYME7OWjMo/uOvn1pw1az/pLIOa4YTbr7jJ5i3+
         M0TrPWjgVIhRP6ayY8ABnAQaVoiNCM9EN7vSxgmlLZoFyGVjvy9JuatUzFmp8fd1I3lp
         j9YxntVjVbdq5tqJknAbwvBpm5zGCvgDQDV9BnMVDgUhHt9DQ3aCVZkKfcftoVhtC0W2
         sEHvusMNS5VrWqpFdPclhyfB8sZZVFNZyd0iaFsG2ceAoG62pOKMryAV6d6kMvOf67OG
         5agI0NJnowmzqbfOFOsm1a25FcwYvz1VDfMT2op3NBtkM6mgWhxuRMW+Gx1xTHu/ZSQl
         VzqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lj89aSQV7OCOrepNKn8koFUUrCNiOnfBqunvMMwzNw8=;
        b=MsdWSTdlhmtghISAgL2Spgej3V5kvHIXTCaCyuIB4vobJN3Vtt4Jo64gfFkgVZ+kn/
         h2swj9RJ5xSLL+vjs0ya4Ti4qg9jgC4CdDG0u9Z0aZRw735CPsEhDkgqAh7B9vxitmMp
         v7aDJBK+J5yAe787REgSgoRLx8BByAGxmFFvphWTm0k1ZZGWntIszW0CRmiR2X1iBbB9
         +OlZoNsc5ZvisDLl+sdZMDhtU5Jf0RWRu5Km7zqsAimSnBGXJENIgyH1bjaHbiFE985f
         59e0xvLyq0lAnfb71pdfx9aB14sSoAgMFRxeW6dbBrOxBg65twjql6MKU+rJO0qOZU7h
         eHvw==
X-Gm-Message-State: AOAM531FLX0zGwsZZqBtBaBv9M/YsRFkNVaMrefD9hIdEIqsVsrkHtF5
        HmO9M4Bc2y/uNoeGyg5qcFj/cooQCiFD2h9sU6wulw==
X-Google-Smtp-Source: ABdhPJygNJetu7Q3WHCj4Rb3EJS60ayEOW6Cf3me7T+gPMKRUGV5KHs8bfbUiAmOv/uIL8pe6VU7fSK5IaW9mbhg+w8=
X-Received: by 2002:a05:6512:1084:: with SMTP id j4mr12499776lfg.586.1628375888754;
 Sat, 07 Aug 2021 15:38:08 -0700 (PDT)
MIME-Version: 1.0
References: <YQw7M7OF6OZLcLjk@ravnborg.org> <20210807133111.5935-1-markuss.broks@gmail.com>
 <20210807133111.5935-3-markuss.broks@gmail.com>
In-Reply-To: <20210807133111.5935-3-markuss.broks@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 8 Aug 2021 00:37:57 +0200
Message-ID: <CACRpkdYu5fdLvSYPV=fs0ry59abpTWoVVkKpd9cApSbmyssjmw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/panel: s6d27a1: Add driver for Samsung S6D27A1
 display panel
To:     Markuss Broks <markuss.broks@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, phone-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markuss,

this is looking really good, the following is just nitty gritty details
I could fix while applying, we're mostly waiting for DT review now.

On Sat, Aug 7, 2021 at 3:31 PM Markuss Broks <markuss.broks@gmail.com> wrote:

> +       /*
> +        * Exit sleep mode and initialize display - some hammering is
> +        * necessary.
> +        */
> +       mipi_dbi_command(dbi, MIPI_DCS_EXIT_SLEEP_MODE);
> +       mipi_dbi_command(dbi, MIPI_DCS_EXIT_SLEEP_MODE);

Check if this hammering is really necessary on s6d27a1, on Widechips
this is just a bug, what happens if you put just one of them?

> +       msleep(50);

This should be msleep(120) on s6d27a1 (according to board-codina-mcde.c)

Yours,
Linus Walleij
