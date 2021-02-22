Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E5A3222A1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 00:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbhBVX0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 18:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbhBVX0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 18:26:08 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCE3C061786
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 15:25:27 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id d6so344980qvs.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 15:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/oxheRV/zYlSYJgiTUORu/R/sZ9O15RX0FoUHQXYP0A=;
        b=L1VU0bgJMRWAPIlu7JlvZYs4sMFK0Rfgee/BaMVitzOXQEwyOFVTGmvIIrHp87Zs7C
         fTS9WDZmca6Q5MhVf143lkSoEVlBN3I/MrosQ/zRKY6Sb5suIx5R6V7ne6HhGZ2Mtge8
         WkDfz0uMBGptMDbjLSvoscg5PrfoGfwwNffrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/oxheRV/zYlSYJgiTUORu/R/sZ9O15RX0FoUHQXYP0A=;
        b=H5oHrcDbNkg4JgJwLfdlKU2g8Yx/ApHsfxWnXvCTlrreoZU5Z+z+P88nrcMAm7Gsld
         4ZBNR2CE3pOEZA5HROciLlXCUh/nxbILsQLsxws9MXrl9NMLrwAVa+P0v8zAUBLgOGAA
         xAtn7Ixas6jHaoIbyVIBQrz6MvMWcBeSGjHEv9WQ04CJYrpDptiUS08zkmN13PtES3PX
         ezBZel+UDyvL6xHqOClA1SiBW6f2K6QknVsKDMvCvbaMWOFHd1UsqTnNUATTj79rRm6Y
         pbwkWVJM4ErBkfQaKD8uTQiFlZLOzWVuWdg0/1/24adnqNj0HHMdeidMI2pbNh3IKn5/
         8JKg==
X-Gm-Message-State: AOAM532pSz7K8JF/hvglgu3pa+8oOtzpz1sCJneUbno47mZSiokf0OaI
        1qn/S2l33H3tsaNzqDD09sV1sqASdQjhFg==
X-Google-Smtp-Source: ABdhPJzPQzZfsPmqhDwx18N/XydxFhHxGtdxOjtPSCqoBFq9sc/4WhAL4rykRGRXZI+XH4HzLmVRew==
X-Received: by 2002:a0c:8304:: with SMTP id j4mr22938436qva.18.1614036326766;
        Mon, 22 Feb 2021 15:25:26 -0800 (PST)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id a6sm12415631qkn.89.2021.02.22.15.25.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Feb 2021 15:25:26 -0800 (PST)
Received: by mail-yb1-f181.google.com with SMTP id p193so14675285yba.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 15:25:26 -0800 (PST)
X-Received: by 2002:a25:aa43:: with SMTP id s61mr38889621ybi.32.1614036325816;
 Mon, 22 Feb 2021 15:25:25 -0800 (PST)
MIME-Version: 1.0
References: <20210219181032.1.I23e12818c4a841ba9c37c60b3ba8cfeeb048285f@changeid>
 <20210219181032.2.I6a426324db3d98d6cfae8adf2598831bb30bba74@changeid>
In-Reply-To: <20210219181032.2.I6a426324db3d98d6cfae8adf2598831bb30bba74@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 22 Feb 2021 15:25:14 -0800
X-Gmail-Original-Message-ID: <CAD=FV=W7W9RT3SjGChP16o1Mz4_EwCJ=t8nNFYiS5QvK6E27OA@mail.gmail.com>
Message-ID: <CAD=FV=W7W9RT3SjGChP16o1Mz4_EwCJ=t8nNFYiS5QvK6E27OA@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sc7180: trogdor: Add labels to
 charger thermal zone and ADC channel
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Feb 19, 2021 at 6:11 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Some revisions of trogdor boards use a thermistor for the charger
> temperature which currently isn't supported by the PM6150 ADC
> driver. Add labels for the charger thermal zone and ADC channel
> to allow the removal of these nodes from affected boards and
> avoid the use of bogus temperature values.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
