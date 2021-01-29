Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1272A308612
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 07:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbhA2Gwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 01:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbhA2Gw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 01:52:28 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB5DC061756;
        Thu, 28 Jan 2021 22:51:48 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id z6so7676096wrq.10;
        Thu, 28 Jan 2021 22:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZQ9750pb4Xv95/ZTBBgYNPr9nohfVHkkFloTO0dyCmM=;
        b=nvyF51r9x9/YLPdp/EyQFT5ZqKEaWwNhEuv+ovU9d2j8IpI2b2a9yGYJJwpNj0tUlU
         S3ItXjpty9P1Y0uMmUL0TigYSfMgKho62QG91yWNjl9mahgISyhRvFm2zS/U2B7ZPgtx
         62AaLRnZPQz798aOpw2neFjspIg1CU0Sd5BQ9M37wl+TErtP02QMB+DoDA/FKe5/1/RX
         VJSLg0V22jH/3cN0lkTV8RtavwEStmDp9X45TdtMNeuGShC8Ao8d94FKJ5kh9hiYZBJ1
         Z3w4Miito4l+plCAU3CcLei1nQBQWy8f+6vHGY39Of9V8OM9G4GdtFpk7I4z9CMPNSwz
         853w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZQ9750pb4Xv95/ZTBBgYNPr9nohfVHkkFloTO0dyCmM=;
        b=sKEPfIpG4DGQAJmuPM1nL6svihlqrWYqY9MpEHBAhfYw/OZvXt7PCmG8BWjcpGVf51
         f8WOwNQ4djLwZ9h8Hb8ibiqz+n+mDeb+181uNHY9d98W9b2B6uZw4AUETrmk76TQO5IW
         jdIYSchIT/kc29UBE1hVkmjfmTsDb6NS/yFVc0k5cDkwWqZzTCMiz/ZFtDZ2DPg/pB0H
         TKfZXPlD4XqVuWUPQeOK8U/zUWFT20DeRb0lcoftUQWFJH9iBPmecx1wd4jP0WG0saTx
         LUq71rTrqiTZV3a2Qku+dGYiJ/Ea7nScDqY46bVEvxITFWe9eUwfQkYHcqj2ZVtpG+7S
         jXQg==
X-Gm-Message-State: AOAM533eXQe5FLs1xgfZBMyKPWE4m9vYmFGDGKC6YvHQHi14se9TyE2w
        3cvr35jYc7V9nDjh7SHnLx0=
X-Google-Smtp-Source: ABdhPJz7FupnsVA3AiA68EDUKAtVpaNZLtThsTs40TQx9nWpoC9y/ZLso/zeMndRDIwLZ8lKOqmF8w==
X-Received: by 2002:a5d:66ce:: with SMTP id k14mr2739108wrw.397.1611903107123;
        Thu, 28 Jan 2021 22:51:47 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id b7sm11501236wrs.50.2021.01.28.22.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 22:51:46 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Dongjin Kim <tobetter@gmail.com>
Subject: [PATCH 2/5] arm64: dts: meson: sort Amlogic dtb Makefile
Date:   Fri, 29 Jan 2021 06:51:34 +0000
Message-Id: <20210129065137.5473-3-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210129065137.5473-1-christianshewitt@gmail.com>
References: <20210129065137.5473-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort the Makefile before adding new SM1 devices.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
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

