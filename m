Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC163E376D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 00:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhHGWmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 18:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbhHGWmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 18:42:02 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347B6C0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 15:41:43 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id a7so17643392ljq.11
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 15:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6hVw1r1xpEEInLXXoh33JupWqqEySNuELXLxCfeyrys=;
        b=RcsslV0xypOfQvV0lHtWdMMrmMoto9aibjGdTKlZ6OdVZsgthRLJWU3VBcar1WBu+4
         4WNOvmiLtnedt0KjCDiLGHCiTAYaHWeAy3WzUhsOAHFMgQ4Too5QCUh/bvkR6NhoA5Fd
         LV1ILblpt2cVewmiYg1QYCSstJjV44chQKGk5SqAAQu8Tf3cf4DIuYTf7wQaJH738Pi7
         zJdbwmXNUrknrCJJUUSZBTqyyNJYPbshkfB+aGmZpC584KtfGFHijNmxng9tENAQ7P23
         CNnM8jDfIwB2A3eY1JCSZi26mba09h4ol+UnZluoX0KCHKCK0Qw6eCpDrM76M3h5ucFD
         vrDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6hVw1r1xpEEInLXXoh33JupWqqEySNuELXLxCfeyrys=;
        b=k9lHjsqoRMtO6sHRuDFc6u/81ZDMJM89A2U+r11xyqrd5LK3hmrm5axO34Bd1lASyM
         P7g+ptVEkk0YgbrMnQU2IKn/yMld1fLDaXx37ZFg+1zhdF0bzTDoDRVEDKSXObcGfgIa
         g3iCm6sOukH1Pxt1/7vfRq2zE1Q3ZjzTJOF7xzkoY+yWdUgTtlb7jTfGuRZlnBKk6twr
         zbDHnW14LHwcBsjw5e36/K36J0sBr+pl8xsk4MvO4m8oFNzouVVm288LomA1HcWQ4Pue
         W5J6xJls/iyYHySWspRvC+fkkZeQffz9Mq6J/s4HGgWhk32Z3ygWRPx7X471PhCnlIez
         jNGg==
X-Gm-Message-State: AOAM530dr2YoTkfR4cvQTfPlnkUCPyoQ36t7Nm3bibFK/tCnvEPFce2w
        Y8nQbCQvfBbGkQLEmP4JQlZED5AS6qaujknHgIyg2g==
X-Google-Smtp-Source: ABdhPJwJvd9YehjH3Z7NxGJZ4qtVeQRm9MP0I86bEkJjIUPV/Ii2uwT9draQbeHYvx/NrjwYUO1yGuqblYUBqBwqnxw=
X-Received: by 2002:a05:651c:1318:: with SMTP id u24mr10696662lja.200.1628376101474;
 Sat, 07 Aug 2021 15:41:41 -0700 (PDT)
MIME-Version: 1.0
References: <YQw7M7OF6OZLcLjk@ravnborg.org> <20210807133111.5935-1-markuss.broks@gmail.com>
 <20210807133111.5935-2-markuss.broks@gmail.com>
In-Reply-To: <20210807133111.5935-2-markuss.broks@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 8 Aug 2021 00:41:30 +0200
Message-ID: <CACRpkda5CX2AVh4=Kt7Fn_6TrW7btX0Vqb30-60SMG5u05JBgg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/panel: Add DT bindings for Samsung S6D27A1
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

On Sat, Aug 7, 2021 at 3:31 PM Markuss Broks <markuss.broks@gmail.com> wrote:

> This adds device-tree bindings for the Samsung S6D27A1 RGB
> DPI display panel.
>
> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
>
> v1 -> v2:
> changed additionalProperties to unevaluatedProperties;
> added vci-supply and vccio-supply as required;

These bindings look good to me:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Will give DT reviewers some slack before applying the patches.

Yours,
Linus Walleij
