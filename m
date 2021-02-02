Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFDB30B514
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 03:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbhBBCLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 21:11:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbhBBCLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 21:11:11 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77363C061756;
        Mon,  1 Feb 2021 18:10:31 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id c12so18733183wrc.7;
        Mon, 01 Feb 2021 18:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HtKg2mQ7AbqX2dbubhJvxGnJfUMSZejUtnrYl0NAkaM=;
        b=S2RmV+iHo6KF/P4gwUPKuZ82XVQvbKK940YWK3r8RIH8Hqj/JNMwmJHeJn2F8r9GVm
         i0jmCMTjE0AQxpPtVB6QnlEprXd/lEC2PfzS27qc2h5jsO3l6rRqO+6kNMumGd4E6UBU
         H+dxPhaXyq4x3+MYY//1gfuOCpwqLAI9SwSLuieA0R7Ju6PNGn5sxBuPI3ywUrxQJ++d
         Dqj5lwdcMSBiDo0CJDBtxeRQZXRNyBKwYwRPzvLSVNOBtFXLxDdHTTcVxX6+yBZ+gISI
         d3mEDTQnZqJ280DQtGL+aW+oMoh9+QkSAb64dyn6ngrrU6xY5aRqgWgZaR7crs/fapL4
         6ELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HtKg2mQ7AbqX2dbubhJvxGnJfUMSZejUtnrYl0NAkaM=;
        b=o+Iyema7VVUy+XskFPKBZu4bhJ8lqm/a7KL6UGpASGhSU8u76+F0fSaIYS7VY9i95t
         g96KEl6VK2lJm0gktJotJMVh9e4hSIWyodQkCpIftF/vXYmit4dpLc71gePjd+4mXhRb
         dWxjvEHFWOWVTC1WWvlUe1iCgLfeJHZoxAAoZtOrIgsN5/0ftPo5WAeVHsnwWAMb2zGX
         BrsTqHFXen/zC9EwDl9y4X6sMasOoBLKpzVDmJGpLI/Ms3Cl+yZChzGZKQNSzkMlTBDs
         7bPz8ibwx7FQwlcyWafTCjthBKx41hoLMzqvKMZtDkrIfPwy0MzpI8ovE8Fcs6VYbSXo
         SaeA==
X-Gm-Message-State: AOAM531gkSm55FpWGEizl7DorwSGKkLEnb0XvF2sHsPUgB4cWd3R8Biv
        QmI367WhIRicYBUmAjHmBApCCsBpux4s6g==
X-Google-Smtp-Source: ABdhPJwDOKB0Id5giF23/zSBauSGZO3ItHfy03V46n6Tq8lk7NMbSQm9x6d1GxNbCypfgGZofrIg3g==
X-Received: by 2002:adf:e807:: with SMTP id o7mr21867281wrm.308.1612231830277;
        Mon, 01 Feb 2021 18:10:30 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id u14sm990570wmq.45.2021.02.01.18.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 18:10:29 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Dongjin Kim <tobetter@gmail.com>
Subject: [PATCH v3 2/5] arm64: dts: meson: sort Amlogic dtb Makefile
Date:   Tue,  2 Feb 2021 02:10:18 +0000
Message-Id: <20210202021021.11068-3-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210202021021.11068-1-christianshewitt@gmail.com>
References: <20210202021021.11068-1-christianshewitt@gmail.com>
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

