Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF454101D7
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 01:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235755AbhIQXnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 19:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbhIQXnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 19:43:00 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F815C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 16:41:38 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id m3so37098291lfu.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 16:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PnbdN3UCLAUCSO4VZIIA2qQL73S6L45jVruxNydbTrE=;
        b=aWqIVvX9llY6+8fAsRoJ5vE0qofZ3Ge2tLqBWaHXKlXI++P+q9sHj+3Vs8HM+V+EeX
         7enIyaJbxFhE/wSf5//Xx2Zyhz5Y2NrVXE+ByHojfqDz9JOlmMjxBJ2oyS8xF3n22ctK
         62b9Fk8lBZG9h7xOzDtP1d9WWD1Ia0pFRuuzCtx+on5rE72/Qv1PN3QGUDb+4INDIgvK
         UP3U90hcFVxlw31d4TX3CdSKE/ZS/qdVn2VNfESCFO1b3zDd1rX4xzoMvpfxQp0uQuli
         CZCPCkMCPRvnzFoOnXYFlidK8l99mOysSDqVJNJVnPk3+erdS8Ml9wzdlIkVNIlbed4F
         6YWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PnbdN3UCLAUCSO4VZIIA2qQL73S6L45jVruxNydbTrE=;
        b=JfLUDCS6il81fR5HMrhs2+oOTjt4t6ioxwMRVTYs+dzWAU42KMixBavbsCSKGs72aQ
         c4vLVI71KPJlhMQmHt7TL8y9x9kWii4JR6qVeiikgQvYVgeFsOtc8jSrS/6dU/v2wHRj
         OP4mYjdcheSKzMAdZDT86TkLd/LN7KiKMuRyeefgGqQ+wJdMV93Px8RbH8bOLNC4uja/
         55ZOrdydJ5jMECHZbfkKr3304rdVKZgy8CuVw3uB8G8hiq0RMqvWBxqQG4WXxlpr4RIG
         hJF0SwcwCPGYRBGSJx9+sqlGC2PWzoQIYA85HjRb1Zc5B1/yw0G7RDsCFx7WPHeEV+RO
         ZF+A==
X-Gm-Message-State: AOAM530/DPBNCM17C3rVH86+VdkJbrmN/UiSjIzt8BGvf2YcuXCzatIf
        4JpPgvfMYTz9rlN6GoIVWxAN78NHVnXgSrvVqo7nWg==
X-Google-Smtp-Source: ABdhPJzIV512qryJ+JnO7qP7YBFgWkpHpPcXbqnJv8d2u3jbvziAQ2liUehMup4iRBRk+n/kRb/tARgPhmw9tlb6rxU=
X-Received: by 2002:a2e:5758:: with SMTP id r24mr11874618ljd.432.1631922095497;
 Fri, 17 Sep 2021 16:41:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210909213118.1087083-1-robh@kernel.org> <20210909213118.1087083-7-robh@kernel.org>
In-Reply-To: <20210909213118.1087083-7-robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 18 Sep 2021 01:41:24 +0200
Message-ID: <CACRpkdbYGtzfc5qDGCgqFnYLi4eSB3K61DWz9ypUH9mneUrLGQ@mail.gmail.com>
Subject: Re: [PATCH 6/8] ARM: dts: arm: Update register-bit-led nodes 'reg'
 and node names
To:     Rob Herring <robh@kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 9, 2021 at 11:31 PM Rob Herring <robh@kernel.org> wrote:

> Add a 'reg' entry for register-bit-led nodes on the Arm Ltd platforms.
> The 'reg' entry is the LED control register address. With this, the node
> name can be updated to use a generic node name, 'led', and a
> unit-address.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
