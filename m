Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF4F837BBDA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 13:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbhELLeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 07:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbhELLes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 07:34:48 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378F9C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 04:33:40 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id h202so30244960ybg.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 04:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hwqwx4LJYn+nGrs/s7vt3MWR+fST/FOpGPjuEVfqI1Y=;
        b=ZzghOpmFjMBck1DvPmfzHW9Sdd7J4gJKsYxzxHyT/K6yCOmAqFHSIghrHgQCxbq2tl
         3UVfc6d1p1Xt+yDdLD6Og7RCTTD8O+NPaToKV/DXRYMEaMhWju5fad+YssppnmMA5hTA
         Z5Ar6zGcfi35Lw0yHYk/Zcxi4psHs7/la7mptBxbVoeGmlUYvbyZ9jzzygTn8kP87K+Y
         hksbrePF7VxFYOG7wBoN6L6/QCNQgUzRTtPP5SQMWYx9Tvru9NKiJbKbV2NvXrVbojHs
         k4xoMJe4TL+6PrKAe+cQLMehmqVWre2lC6vNQ2Oq9a43g4ghs+6UzBJv//PpYfeXb1qE
         a4Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hwqwx4LJYn+nGrs/s7vt3MWR+fST/FOpGPjuEVfqI1Y=;
        b=rr3E8TpPiuo3AxBUE6N5zEJrA3Deuj+MlHG888d/mceJ83V0KUhPMXThojCUc/f1lL
         vkiXHhdQAOLlhMvrqe/WQ3CM9iifr4IrTcc5OgHwAUQt6ctAkWHAlMyHW3HiM7Vif1qT
         O1nb9tJ8R1+V0ykILC+LJHF9oRYsWp5rSeaaoVpbt+44WVi0GWDSjU68YMWQSE7emsdt
         WNkpflu6L06aLcQUFPfXu9lAWpkeYYPDV0zm3v88ddrff6jJIz9HPADLnTcmv3sMBT4S
         GKJAwL2ECfU0sK+URlYmSY43ZUZCPVHwZPkZDjSI20dyv4WYX487QkYO/H5sscyJwqRl
         4AqA==
X-Gm-Message-State: AOAM532sfoO07DMDE7jmyRmFfn0OYc49XxUzsBtCC/ROubmisgxotS/T
        QTRS4nEy0QHZP4yOmASXfjmKYjrXNkw0U5WGTWMdQw==
X-Google-Smtp-Source: ABdhPJzVDgzsy/eNX1ps1bd8bp+PkNNtBxIF7Wh4nsVHVqC87fdjHMvHoqdIsZ0U8nQlU9VMEcEjqK5fZzdFDLjoMGQ=
X-Received: by 2002:a25:dbca:: with SMTP id g193mr20139314ybf.0.1620819219357;
 Wed, 12 May 2021 04:33:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210511050511.5973-1-jbx6244@gmail.com> <20210511050511.5973-2-jbx6244@gmail.com>
In-Reply-To: <20210511050511.5973-2-jbx6244@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 12 May 2021 13:33:28 +0200
Message-ID: <CAMpxmJU9K9t+LOT6SLarXQYZs1YCqVZHMz_ZM+iMpzfMtqUH8g@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] dt-bindings: gpio: convert rk3328-grf-gpio.txt to YAML
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        jay.xu@rock-chips.com, shawn.lin@rock-chips.com,
        david.wu@rock-chips.com, zhangqing@rock-chips.com,
        Tao Huang <huangtao@rock-chips.com>, cl@rock-chips.com,
        linux-gpio <linux-gpio@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 7:05 AM Johan Jonker <jbx6244@gmail.com> wrote:
>
> Current dts files with RK3328 GRF 'gpio' nodes are manually verified.
> In order to automate this process rk3328-grf-gpio.txt has to be
> converted to YAML.
>
> Rename 'grf-gpio' nodename to 'gpio'.
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Patch applied, thanks!

Bartosz
