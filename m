Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42B8F3F4A7E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 14:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236868AbhHWMVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 08:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236769AbhHWMVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 08:21:20 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66903C061757
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 05:20:37 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id o10so37495174lfr.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 05:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J/9lMngJdsO39utn1rnBXQpLcoAkKWd+nQfEyzAGaq0=;
        b=A93zXOcuEP4Kz+850M7QkS6YIvg0xSj1PenNxv1W64YmPWMa57DygFf75G6oclbkYa
         ffnVJQo3HSz4vUCXNF61F9MhY2o4RIijteGevGpyGLcXGRH637WleRHHheLDBRu0qYHH
         CnitHEo+t/IibGAfmbAcyFWPiLoUu5omC1EaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J/9lMngJdsO39utn1rnBXQpLcoAkKWd+nQfEyzAGaq0=;
        b=Et67tyHh4tkSWzCZm/5ofaMedtI8Zrb5LUmxFioXPMuWmN8QYCbsbXh8oopmr+oW6v
         dRTf6FArVGCqqhV+vtNie8x0Y6oryFyIsei4swxHZMD12fvi+CpKHycXiddwk38vZhUv
         S6ZKUh+Sc6n/mKfsqWA7iaC5dxyetI0j6v8IRFU4+DBMly8csqNX9r6STuX8Yqay+Erh
         Lwwg77g5VHZIPZQ1CWNHc2bpwYNFWhfnYlrSJ+/IXQLjjFRBfGPzNNoWm8jFZ7rjavqT
         0zd9Ov69elvfNc6tgoOILHoF8xluJLQ5Fi/MCN0t5F4EsQ6CLP76ogMJzAm9K8FS68VB
         C8zw==
X-Gm-Message-State: AOAM533xmhz18egWYdoqMH13xSJK7nLDCU/ma1uCitl/zB6WU1jXo677
        uVxQ5ojzLEha4xCHnO4G/cjr3pfigoKjwak9+PIaXg==
X-Google-Smtp-Source: ABdhPJzZV+X+GD9FTgIY+7KEoZ0aRWDNfvAX10pwPbA9Jx1RGnfwwCvySJdrhtlRgTZ1eoaOFCpMJ/yt+XRo3rHFWRE=
X-Received: by 2002:ac2:4116:: with SMTP id b22mr25323200lfi.587.1629721235847;
 Mon, 23 Aug 2021 05:20:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210820111504.350-1-chun-jie.chen@mediatek.com> <20210820111504.350-14-chun-jie.chen@mediatek.com>
In-Reply-To: <20210820111504.350-14-chun-jie.chen@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 23 Aug 2021 20:20:24 +0800
Message-ID: <CAGXv+5Fj69MQroMZV5ecpEg7cBcin0rA7C6XNCZcvcHebV-HQg@mail.gmail.com>
Subject: Re: [v2 13/24] clk: mediatek: Add MT8195 ipesys clock support
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, linux-clk@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 7:25 PM Chun-Jie Chen
<chun-jie.chen@mediatek.com> wrote:
>
> Add MT8195 ipesys clock controller which provides clock gate
> control for ipe IP block.

Could you describe "ipe" in generic terms?

ChenYu
