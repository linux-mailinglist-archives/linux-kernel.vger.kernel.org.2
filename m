Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C560042B23C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 03:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235775AbhJMBbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 21:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbhJMBbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 21:31:05 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A9DC061570;
        Tue, 12 Oct 2021 18:29:02 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id s75so744205pgs.5;
        Tue, 12 Oct 2021 18:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=IWgl1aq+EmvJ2d1nb99MQFV+HXmaPV8gEoyBP45tPlo=;
        b=oybon7n1j7VI3+S8Po2yOnHaq7Pl8/cuf4hjNsRkIFikANw1PNe6g9SbSedn5yYxHj
         bTs6BdxKLRT7CNTL364NGq+G+dSo2qGuT4HHAnS49NkCQjfiyoZLlrxmBBK53o2EjEfQ
         XeFh8MbAoaobg9rcxFQBYWi1fHSpCuNQwhiOKrQGcmVPmW/qoawLQW/12tdVSU3kvl1E
         Ki/0+PrAeWOnJwS1O1WOt9x8/cquw8UN0Kz23ffdx10Gt2JoaU4AHIxkOMzIWiOdw58G
         NR8wZK0MpLVbJG569YPEJVPpzytc5VNX5wg2Y2DZi8WuYRX9YUbuDadmjOaSujBES+By
         mZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IWgl1aq+EmvJ2d1nb99MQFV+HXmaPV8gEoyBP45tPlo=;
        b=H2XgQiXUOzRiuKjM46bjFJEgF5jUPay7R6Tp7ZBATQiWe6yMyoPP7YGg5f59OPtO+p
         XdPbrJ3rlV09HuR7C7/lK5C2/PZ0mii/v5eTwru3ZBQUlbYTZqJBACpA/Xx6Ly0Tyo1g
         nyHOLI6C8NG8wU/Si4U74UHg+zjTEj7iFSWhkL3IjyKUTNvG9xMJ7SZqrBgMoaUeh95k
         MdHA/L+OZX6ewms6d7YJCfMJMR2BW4Ny7rmJqmDwGQ068dEBVMmMprRWEW48WCGyqSMM
         65UfZrmZZE7IaF6cq+e5hvbPIzCQhch41nUnCJEeOTAVcP8e+5K2RxYHlsxuB+G5oQWV
         7OEg==
X-Gm-Message-State: AOAM532Z+I2YR7/xN9BmpXd/B1gd8Dz+PRyYrrFJtMZSXEA/9jwKq164
        9I8AV4LkYxB0uWE4K1VxL54=
X-Google-Smtp-Source: ABdhPJwBrpexdxGh/CJ5RpGs1codruYtlEMm2qAbpV65dApsrHonnuOgePMXfn20uq17VGh/KGZpbQ==
X-Received: by 2002:aa7:8198:0:b0:44b:e191:7058 with SMTP id g24-20020aa78198000000b0044be1917058mr35290626pfi.39.1634088542216;
        Tue, 12 Oct 2021 18:29:02 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:578:7fd7:52a:ae77:5bec:efe9])
        by smtp.gmail.com with ESMTPSA id b11sm12144788pge.57.2021.10.12.18.28.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Oct 2021 18:29:01 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     oder_chiou@realtek.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, robh+dt@kernel.org
Cc:     lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, cy_huang@richtek.com,
        devicetree@vger.kernel.org, allen_lin@richtek.com
Subject: [PATCH v4 0/2] ASoC: rt9120: Add Richtek RT9120 supprot
Date:   Wed, 13 Oct 2021 09:28:37 +0800
Message-Id: <1634088519-995-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

This patch series Add the Richtek RT9120 support.

In v4:
- Add 'classd_tlv' for 'SPK Gain Volume' control item.
- Unify the tlv declaration to the postfix '_tlv'.
- Fix 'digital_tlv' mute as 1 to declare the minimum is muted.

In v3:
- Add dvdd regulator binding to check the dvdd voltage domain.
- Refine sdo_select_text.
- Use switch case in 'internal_power_event' function.
- Remove the volume and mute initially write in component probe.
- Remove the mute API. It's no need by HW design.

In v2:
- Add missing #sound-dai-cells property.

ChiYuan Huang (2):
  ASoC: dt-bindings: rt9120: Add initial bindings
  ASoC: rt9120: Add rt9210 audio amplifier support

 .../devicetree/bindings/sound/richtek,rt9120.yaml  |  59 +++
 sound/soc/codecs/Kconfig                           |  10 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/rt9120.c                          | 495 +++++++++++++++++++++
 4 files changed, 566 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/richtek,rt9120.yaml
 create mode 100644 sound/soc/codecs/rt9120.c

-- 
2.7.4

