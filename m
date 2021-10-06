Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1646A423CAC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 13:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238485AbhJFLZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 07:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238386AbhJFLZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 07:25:01 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555D7C06174E;
        Wed,  6 Oct 2021 04:23:09 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id u18so7790073wrg.5;
        Wed, 06 Oct 2021 04:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=47s/bZHvgq69ktivg5JJy6fUXMerQl2jUwwg3kpWhpE=;
        b=g1QA2+UjfP3hztVr1sVD8MWAB6aunYsFT2KalsjBUEvAk3VvWMKn0W9UZ8byMcobWs
         ao8H4xXe914XRE4bMNt7FAsQXCl8p5gO/uQ9SRBQOC7l92/aQjSrf/BQhlOI19dqUM3j
         oZwk22G51nlNTL59CVUt1xx/B/x/wFoToPdAxOsNL/BjCUHw69Dw7fn8Ez9uotXGJS4Y
         XPqVsYnyzzNBsicY0FLxjVEZsMhjuuLR2NtwX3mcxa9Pp2lBZrJW7E5L10aZxVbu2UW4
         4olTHkGlmzesj+dVnQdLEC5gB4XjV1dwFpjL6FP6ZKIpbcT5lSKSWxR3lj23sgGrxIsO
         PuZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=47s/bZHvgq69ktivg5JJy6fUXMerQl2jUwwg3kpWhpE=;
        b=VK5iHFkhZDnXIaBRBAFzFVja2WT3JM8LogTyUa3RRbh88LvE+wwuWOwcQQ0/HJXv5L
         qwfWOiyGQvF5Xd5kyt8EuxXeJecxXtbxi0oOiuJNtciL7kY/QgP4W1uRiFRYLt7zME6U
         Z9OJmyFhL88pNJ0lZeLAvIPQpobp2ZoshqLHIQJD7W6nidFgdIU3+bfV0Z0SWMfoYVp3
         ZXgcZhodrkD52AizExOztx7xSmfWcBRswpGbST6rmTsff7mba52/AJd6kStPzwIe2sDu
         N1VRf8gACZHS/UCAgbXszzpcJqaKwbNkiYyqpWCHE8QkFARMAftPmEWNuY8gruBUQkzf
         5M4Q==
X-Gm-Message-State: AOAM531Xs7wNvmQVE/jlTScpYw+RgDXUnVR9AO/zEfg3kSl4z8CU15JA
        TU+CFJaO9767xN9GGWk83TmQFZcPfq0=
X-Google-Smtp-Source: ABdhPJxO8m46fxb9zABvCoD+pMl/Q0dgsharY/sFYhpKLR4z8Rul9+G4k+vwxTx1LRFFmTI+0V9YeA==
X-Received: by 2002:a1c:f310:: with SMTP id q16mr9556452wmq.145.1633519387985;
        Wed, 06 Oct 2021 04:23:07 -0700 (PDT)
Received: from localhost.localdomain (252.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.252])
        by smtp.gmail.com with ESMTPSA id e14sm10801985wrw.33.2021.10.06.04.23.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Oct 2021 04:23:07 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     sboyd@kernel.org
Cc:     linux-clk@vger.kernel.org, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-staging@lists.linux.dev, neil@brown.name,
        linux-kernel@vger.kernel.org, john@phrozen.org
Subject: [PATCH v2 0/4] clk: ralink: make system controller a reset provider
Date:   Wed,  6 Oct 2021 13:23:02 +0200
Message-Id: <20211006112306.4691-1-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch series add minimal change to provide mt7621 resets properly
defining them in the 'mediatek,mt7621-sysc' node which is the system
controller of the SoC and is already providing clocks to the rest of
the world.

There is shared architecture code for all ralink platforms in 'reset.c'
file located in 'arch/mips/ralink' but the correct thing to do to align
hardware with software seems to define and add related reset code to the 
already mainlined clock driver.

After this changes, we can get rid of the useless reset controller node
in the device tree and use system controller node instead where the property
'#reset-cells' has been added. Binding documentation for this nodeq has
been updated with the new property accordly.

This series also provide a bindings include header where all related
reset bits for the MT7621 SoC are defined.

Also, please take a look to this review [0] to understand better motivation
for this series.

Thanks in advance for your feedback.

Changes in v2:
 - Address review comments of Dan Carpenter [1]:
    + Avoid 'inline' in function definition.
    + Return proper error codes (-EINVAL) instead of '-1'. 
    + Make use of 'devm_kzalloc' instead of 'kzalloc'.

Best regards,
    Sergio Paracuellos

[0]: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20210926145931.14603-3-sergio.paracuellos@gmail.com/ 
[1]: https://lkml.org/lkml/2021/10/6/204

Sergio Paracuellos (4):
  dt-bindings: reset: add dt binding header for Mediatek MT7621 resets
  dt-bindings: clock: mediatek,mt7621-sysc: add '#reset-cells' property
  clk: ralink: make system controller node a reset provider
  staging: mt7621-dts: align resets with binding documentation

 .../bindings/clock/mediatek,mt7621-sysc.yaml  | 12 +++
 drivers/clk/ralink/clk-mt7621.c               | 79 +++++++++++++++++++
 drivers/staging/mt7621-dts/mt7621.dtsi        | 27 +++----
 include/dt-bindings/reset/mt7621-reset.h      | 37 +++++++++
 4 files changed, 140 insertions(+), 15 deletions(-)
 create mode 100644 include/dt-bindings/reset/mt7621-reset.h

-- 
2.33.0

