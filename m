Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1FD3309ACA
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 07:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbhAaF5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 00:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhAaFyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 00:54:07 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83680C06174A;
        Sat, 30 Jan 2021 21:54:09 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id c12so13029599wrc.7;
        Sat, 30 Jan 2021 21:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HtKg2mQ7AbqX2dbubhJvxGnJfUMSZejUtnrYl0NAkaM=;
        b=tI/DBXXeMpplc+r+lIwAGvfziF/KRBMKJRcJhIebQPezC5U0odeFCCQPSonEHfl7rd
         5Z9iisXH4OxACjDcQRPdaA8Iwd5QoWR6A3Im33OFHnUgdxZnhTCRq8/zI7+UCI21UReP
         3Cp+qSe0QGoHt+1UAKOnax/XVBDMtQNvuyxCJ9HxXxqxjt/IxADnHHkcurI7efLVe8x9
         nFpOPTvtXTOToKGE8utwhAmOi1yL34+DFzUmInGqNvM5NdK0XmpbRG7oQvBqhMws1eHe
         Vl26CldotsI9OsWe1cdHyQBWJH+ejrkh4WB4g5d0PDVFW3bTbz3fd2AFgaL3YGdP9jzo
         x3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HtKg2mQ7AbqX2dbubhJvxGnJfUMSZejUtnrYl0NAkaM=;
        b=XHswg4ubYGRUMze7phwRzA5FCiN2PwzvTn+AKoUxSThOx5NJvaDu7g25HYhLFgmzAR
         kEkYI48PMhR9RJgUgu1BLyODsFahgBOLiLvjyYp2gqjmSWoPScx+OlVMItXnjCeKM7tN
         vrTsT3HaQcod0LcsFJiNLmmh97nqp8DULk9MrIJbB+I4WIgZu4MSwyZ/Rt2mnbkFcRJV
         rpjHjCpQOUGRRzFmaBUUeFuCssTgBqJOvyWV/kTTfq6zHlb3s51/Ag7sXwMiD6egaAn5
         2Rc/tkDyPYwEZgaOYGn/TtGOv/NJsH7iXY1COS787rvZJlVa3Wjd2oHux1xC6B5A28r9
         V8uA==
X-Gm-Message-State: AOAM5339pXu4np0DdYBV6zkb8olsse8nmJJuMSbm3s/We4F4K/6xbVpb
        //lwhzqYZhdYJI/+f6faBeSCmv6zCPk=
X-Google-Smtp-Source: ABdhPJyM0cZqa11Erzs/jcJO7XNCRwpDu8Dn/ScfhBbUjrlcVOrzdf7tI7SaescIXmBF3ZxM7Yn6Eg==
X-Received: by 2002:adf:e384:: with SMTP id e4mr12197899wrm.13.1612072448132;
        Sat, 30 Jan 2021 21:54:08 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id c9sm20056589wrw.76.2021.01.30.21.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 21:54:07 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Dongjin Kim <tobetter@gmail.com>
Subject: [PATCH v2 2/5] arm64: dts: meson: sort Amlogic dtb Makefile
Date:   Sun, 31 Jan 2021 05:53:55 +0000
Message-Id: <20210131055358.21293-3-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210131055358.21293-1-christianshewitt@gmail.com>
References: <20210131055358.21293-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort the Makefile before adding new SM1 devices.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index dce41cd3f347..f3c8a85fe987 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -45,7 +45,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxm-rbox-pro.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-s912-libretech-pc.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-vega-s96.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-wetek-core2.dtb
-dtb-$(CONFIG_ARCH_MESON) += meson-sm1-sei610.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-sm1-khadas-vim3l.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-sm1-odroid-c4.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-sm1-sei610.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-a1-ad401.dtb
-- 
2.17.1

