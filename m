Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17C7245F08E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 16:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378025AbhKZP03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 10:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354267AbhKZPY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 10:24:27 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC069C06173E;
        Fri, 26 Nov 2021 07:17:39 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id i5so19387593wrb.2;
        Fri, 26 Nov 2021 07:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AVVbDaYZ1nT4F8I3SSFNvTA1JC2esltgXh0RvaUMdwg=;
        b=O/Nm/AjqBAnEbO+lYmKJNG5QzD8/4slMiLelDbnJclqiyHXX7SdxoeiB0u43qQsIJZ
         VkXBBc+NdNWjthvF+m3BZwhhSIJ0q29C94FnShGm+uFubJrKaliWgQXhAwBGk3NhYu1y
         JEsLb5VH47Ba+0PvWD7CzIMYJvOUWTgP2Rj2lOyXxnVWgC2QaSMYcgvxy8hWT/cJMvrA
         06o4+qql98V2xgBNMWByoJr4Hz1uVbCExQ+DPsy/Rq3JBrTAW62iWRp+d7fdumjHbLgG
         Vd2foR7bBSI9cehOb6vrE9/xAJBNYPOlu+o0QB7D+FRVV3N76DwzQ/UqoC+fSR4u19cU
         bQ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AVVbDaYZ1nT4F8I3SSFNvTA1JC2esltgXh0RvaUMdwg=;
        b=D5y+9YZE1XQ9xuXNHMq5qKgodMcAC19U8exY2cx/6L2/WBr3XdQq3qINC8qax1bfJF
         JgsEuuVnSMOA7g9SfOFFN45KAhorQVHvFsCllgpQUL+WFfB+SeHI0OjpQizhuJvG76vU
         CrVDJtzJsIFSMZnwjqBa5Jdj0d0OPAkz3jDSWkMkSJ7rSrmQRfLe3P8+430xJEBmJxha
         AKr0153b14/mVaUdZn1R4YEgwNEpr+tfKcZoGJ8e0LxeUwgskm+B04v17uMDR4aAFX0v
         FbAbym4c/am1qkcKNnsiGMS0FPL9PUC1ojBXw8/9b5SlyLqnDf8t8j58AA7BKs9U53jp
         o4jA==
X-Gm-Message-State: AOAM533KAkbdJdTYdc6zo8Z4k1l1Blobr8PjKqn3Dc8FzKhxDUnUUGJ2
        4emUDgtlkH5kWwLVp268VA==
X-Google-Smtp-Source: ABdhPJyktxA6+ncorTA6vOY6WkGEHrmglR3P4RzcGudfhoOf8zZpLJ1IQAL5Bumu3LNKU8XU0+rXXg==
X-Received: by 2002:adf:e843:: with SMTP id d3mr14261459wrn.452.1637939858465;
        Fri, 26 Nov 2021 07:17:38 -0800 (PST)
Received: from alex-ThinkPad-E480.. (ip5b435a69.dynamic.kabel-deutschland.de. [91.67.90.105])
        by smtp.googlemail.com with ESMTPSA id k187sm12323496wme.0.2021.11.26.07.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 07:17:38 -0800 (PST)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH 0/4] add GPU for RK356x SoCs
Date:   Fri, 26 Nov 2021 16:17:25 +0100
Message-Id: <20211126151729.1026566-1-knaerzche@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a respin of Ezequiel's series which adds GPU for RK3568 [0]:

> I've decided to split the GPU off previous series:
>
> https://lore.kernel.org/linux-rockchip/2147216.TLkxdtWsSY@diego/
>
> This series now contains only the GPU support, as the VPU
> needs a tiny rework.
>
> This is compiled tested only, in this case. Similar patches
> have been tested on a v5.10-based kernel, so I'd say it's good
> to go.
>
> The mesa side is merged https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/10771
> and can be tested without a display, using something like weston --backend=headless-backend.so,
> which provides an environment for GL to work.

I hope to have resolved all DT-binding issues and added cooling map and trip points
which can make the GPU a cooling device.

Tested with mesa 21.3.0 on quartz64-a board.

[0] https://patchwork.kernel.org/project/linux-rockchip/list/?series=526661

Alex Bee (2):
  dt-bindings: gpu: mali-bifrost: Allow up to two clocks
  arm64: dts: rockchip: Add cooling map / trip points for RK356x' GPU

Ezequiel Garcia (2):
  arm64: dts: rockchip: Add GPU node for rk3568
  arm64: dts: rockchip: Enable the GPU on Quartz64 Model A

 .../bindings/gpu/arm,mali-bifrost.yaml        | 20 ++++-
 .../boot/dts/rockchip/rk3566-quartz64-a.dts   |  5 ++
 arch/arm64/boot/dts/rockchip/rk356x.dtsi      | 77 +++++++++++++++++++
 3 files changed, 101 insertions(+), 1 deletion(-)

-- 
2.30.2

