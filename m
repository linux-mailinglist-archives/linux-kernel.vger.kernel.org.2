Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A16143E10EA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 11:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239152AbhHEJMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 05:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbhHEJL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 05:11:59 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07DAC061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 02:11:45 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id p38so9837243lfa.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 02:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JGy6Zf1Gz/DvNLOUOgVqZw1voM6TCsaMrfyL2VVTA2M=;
        b=Czpou3fdBuvMRgQdRobXPBNmSPmet30GmWm2xaQ8xlkiaXiT9pq1VJ5Sz3m72V5qwc
         3gA09WBzEqX4wBMbAWb2aL+u3uxCI5tSmxJK2GrkgtzaztR0jzf0hXqnh/rxekaLRzCH
         XQ9NRRqtzN5mRX5BxSFi8xj4rJHxMs28Tw4tL+iOXcP378akJNAZm9rLVJ3kQ7Gx/wqU
         hmc9MxNHu7e2hVUrAzorRfo7qKK8MPzvzo8I0Z4M4QcsLfDNwbKFbO3Onvasga885UF+
         MuD438vz+7ymSeAsFMLiFokCcNh8DTEfPEy5F5HPk3V4dvqE2xr2ESyF0X6dAPBaiE+4
         WRVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JGy6Zf1Gz/DvNLOUOgVqZw1voM6TCsaMrfyL2VVTA2M=;
        b=YlUKF7xncye4hQMPEbqB/6PWyWXdCRob6YYaWKHEA1jvmyLKmJTuEMRhcNb7lNacgw
         qM2A3YTmmJYKCbHCPbcgRdhIz4nJUc6hBBTZp8ZTtLoKITJdC4wvVmJ5l6za+BXI9gYp
         BAZhwpYmW59cXNNLVXTyRCp6mrzIXIvD6PZh3YNrHc4Bf535p60gedeQ+O5Wz57muh6u
         aTpavbwmIXyj2bbJN9Nc1eXxBTCqI+oV5ehNrLpTEyn8fsWdo9FdpvcmZS1jEbRf9C2r
         PxIJ1k3Ogejnfzz17QrdShdTFkTdBhSLvR++9M5hk0sk+84Ey4NWpyMqLUogAFOcEGHS
         QLxw==
X-Gm-Message-State: AOAM533Vpwu123jjMHZdaRnODrQEzOV5YRgCQv0/MrbUw+dT81En/sUx
        DV0ncRVH5uIqI+Qrsrx+l7JeSMntdZwU/2MuVSBBxQ==
X-Google-Smtp-Source: ABdhPJxrf9wmOoKiTifiOSKjkHpaxgSpZEW0ggxZq8N4Li6hZYEwsHuFZuOzq7JEu33rr4FIZfdLktcn7Mucw0+3gv4=
X-Received: by 2002:a05:6512:132a:: with SMTP id x42mr2814304lfu.291.1628154703391;
 Thu, 05 Aug 2021 02:11:43 -0700 (PDT)
MIME-Version: 1.0
References: <1627098243-2742-1-git-send-email-dillon.minfei@gmail.com> <1627098243-2742-3-git-send-email-dillon.minfei@gmail.com>
In-Reply-To: <1627098243-2742-3-git-send-email-dillon.minfei@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 5 Aug 2021 11:11:31 +0200
Message-ID: <CACRpkdYReUdg_7oSTqcsA_+9tS9w6MH90=KV1rGyr4YWT=NW-w@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] ARM: dts: stm32: fix dtbs_check warning on ili9341
 dts binding
To:     dillon min <dillon.minfei@gmail.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        kbuild-all@lists.01.org, linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 24, 2021 at 5:44 AM <dillon.minfei@gmail.com> wrote:

> From: Dillon Min <dillon.minfei@gmail.com>
>
> Since the compatible string defined from ilitek,ili9341.yaml is
> "st,sf-tc240t-9370-t", "ilitek,ili9341"
>
> so, append "ilitek,ili9341" to avoid the below dtbs_check warning.
>
> arch/arm/boot/dts/stm32f429-disco.dt.yaml: display@1: compatible:
> ['st,sf-tc240t-9370-t'] is too short
>
> Fixes: a726e2f000ec ("ARM: dts: stm32: enable ltdc binding with ili9341, gyro l3gd20 on stm32429-disco board")
> Signed-off-by: Dillon Min <dillon.minfei@gmail.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
> v4: no change.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Please funnel this patch through the STM and ARM SoC tree.

Yours,
Linus Walleij
