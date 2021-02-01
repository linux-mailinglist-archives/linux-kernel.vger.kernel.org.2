Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0F9D30B1DE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 22:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbhBAVF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 16:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhBAVFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 16:05:54 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4EF3C061573;
        Mon,  1 Feb 2021 13:05:13 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id u14so472303wmq.4;
        Mon, 01 Feb 2021 13:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=P8dkQkjqD2gwV3MQiGBWsFTjvZddS+bmBUxb8YDs2tA=;
        b=hao2QtTHy0KUml3yXdS+FKt3bB4FKeUb0iu0dmgI8xWYkLYXSye7IPpjrrAJ8n6WsM
         DV5xyBE/AvLHgwvCLS1tSf6iLDaOzDYNt3e8wwHebCYGYcJ5YVrXJIUQ0z5ShVcd1lkm
         1UIZFmjaOmMinduJJey9b6P9vo07HmZ7z8Cf3Cp3V8Ixuk5So5azU8hkB5LvfvMz4PjL
         3JXChqkqDnIY/WDyR23DWJTsUVl8aUgm8cEBru9ea1XIy8Du9bKwOZJ21Q5tH7zYCpmu
         PCD65r86ipmCfQyZyD2YOoY4crNM/YVE9wUbzdcvnAPTqxrNXzzX+4AEItO3U/I6NKDy
         ZFHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=P8dkQkjqD2gwV3MQiGBWsFTjvZddS+bmBUxb8YDs2tA=;
        b=LXPI2QdyqRbZH/G5gOjbpjXjDEZKoB7GTbni0eHUQa4X3B955yRQaMXD69AolbCTMP
         dkk/qtzUrLg4HvlwrOYCDdLo6wqxjtg1Wwh00YfX5WUt9xxW1Mvk5CjNC4UsSn1B6hKQ
         RkHsGw+qRMiCJXp8OrUzzNtv+RfQ/EUtvrjv3p9NPazZbXnT01wV71zsfwdcJKToQuel
         VJCsaUrSQciUJ3FnVvVsCQHS5VmlMApQOQQ6QME236ze5WCJUbMwLcJ2GbLrHpikp9bA
         TVe5BVcOAKLh64LzB9NbFREAQb4oIkbM4MeP+/q/q0uadclvFeypMT5yDbRZ0cXx40gd
         b7MQ==
X-Gm-Message-State: AOAM531al9nr0XhwtZDouilV+4qXHDzD6bHLc4NhWNKkCuDdfMpe3S5l
        n9b3EZEmM4WjkK/sv2kd9j4=
X-Google-Smtp-Source: ABdhPJxI5EXxpQ9UEKN4I5pXxUfvewg+JcTERZciIrohkJ/ovxK4Vdhx2DL16F2e46pYcc8D6Tq7Cw==
X-Received: by 2002:a7b:cc16:: with SMTP id f22mr606263wmh.131.1612213512518;
        Mon, 01 Feb 2021 13:05:12 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id 36sm29769846wrj.97.2021.02.01.13.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 13:05:11 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 1/2] dt-bindings: arm: amlogic: add support for the Minix NEO U9-H
Date:   Mon,  1 Feb 2021 21:05:07 +0000
Message-Id: <20210201210508.1528-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Minix NEO U9-H is a small form-factor Android STB based on the
Amlogic Q200 reference board with an S912-H chip.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 6bef60ddda64..dccfc048fb1c 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -120,6 +120,7 @@ properties:
               - khadas,vim2
               - kingnovel,r-box-pro
               - libretech,aml-s912-pc
+              - minix,neo-u9h
               - nexbox,a1
               - tronsmart,vega-s96
               - wetek,core2
-- 
2.17.1

