Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08CB631F379
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 01:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbhBSA4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 19:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbhBSA4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 19:56:30 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA12C061786
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 16:55:48 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id r77so4096339qka.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 16:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=apjhumUat3NAbjLhxDf0sfvDj5HYfNoWzUP7Ib3pj2w=;
        b=NNzBm8KEm527LO5xCGrc89inWBErH3vti2O/scd9JQfr4RVY/LeJBzHUByDjYNxzoi
         e23cAEeErnY5SK0FknxEM28oWILkuJpsMX6f5Npqea6xND5MUOrdisuDmS4rOzLeQCUW
         T9E6YAI9b5Qi3FPkXPoV/fakGz/MDW5PFv+QI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=apjhumUat3NAbjLhxDf0sfvDj5HYfNoWzUP7Ib3pj2w=;
        b=SgArVGtgCijBEZce7YfjHpvCScitDA2PoK6nEiFhEI3Ghy713352VjgnxikQ8U9jyC
         EYRvd1iPcSrNUUffXDPMCXJR6uRgObreQ6bOX+n4w8++2iHgF0rbgGnBrA2CHHM7udLW
         NU5ctDx6tysaD54o8AV/ci+o5Tm7GwZiLl5LjS0oVvrYSmx247lekp9skKx6Q/YCy584
         wE+vcqJVfHP7NdE7gpFZMZcgaVERPO0aR33HaUVlnnDGr1AaGWarp8KrdMV7BrusVuxy
         jLNPhtsVCLtAUrjW9dTlHE+IRy2ymyNEx7BvUh26QRuVO+8N0E8+2zYnl7MmrpkJC1ch
         I70g==
X-Gm-Message-State: AOAM532uAvXu9dIc5RMSvGpQtxe76NCFcdUXJPhqwlqFDsvIQjMd8mXH
        YeAmbqzipogw/H8qMIzQcz10RgUJO4/oQA==
X-Google-Smtp-Source: ABdhPJwxxze0LXBarEEPoN/3IFoHULZuV38UmHbjkNuTVYoKkvp/jtBELS5f+apxsikEemiOroIMxA==
X-Received: by 2002:a05:620a:a4a:: with SMTP id j10mr7482765qka.372.1613696147606;
        Thu, 18 Feb 2021 16:55:47 -0800 (PST)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id x9sm4460009qtr.74.2021.02.18.16.55.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Feb 2021 16:55:46 -0800 (PST)
Received: by mail-yb1-f178.google.com with SMTP id u75so3997589ybi.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 16:55:46 -0800 (PST)
X-Received: by 2002:a25:b74d:: with SMTP id e13mr10284347ybm.405.1613696146315;
 Thu, 18 Feb 2021 16:55:46 -0800 (PST)
MIME-Version: 1.0
References: <20210218145456.1.I1da01a075dd86e005152f993b2d5d82dd9686238@changeid>
In-Reply-To: <20210218145456.1.I1da01a075dd86e005152f993b2d5d82dd9686238@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 18 Feb 2021 16:55:33 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Xh5foM_RYCneVUJZmX39KPt22guopVyZpzLWHSt4T+Ww@mail.gmail.com>
Message-ID: <CAD=FV=Xh5foM_RYCneVUJZmX39KPt22guopVyZpzLWHSt4T+Ww@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Avoid glitching SPI CS at
 bootup on trogdor
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Akash Asthana <akashast@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Feb 18, 2021 at 2:55 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> it's believed
> that, under certain timing conditions, it could be getting the EC into
> a confused state causing the EC driver to fail to probe.

Believed => confirmed

I _think_ <https://issuetracker.google.com/180655198> is public.  It
explains why this was causing the EC driver to fail to prove.  In
short: it turns out that when we glitched the EC it printed to its
console.  If the EC's uptime was long enough then it would spend
enough time printing the timestamp for this error message (a bunch of
64-bit divide by 10) that it wouldn't be ready for the message we sent
to it.  Doh!

-Doug
