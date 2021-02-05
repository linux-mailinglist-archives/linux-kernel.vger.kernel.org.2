Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E054310A88
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 12:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbhBELpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 06:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbhBELlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 06:41:18 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CE9C0617A7;
        Fri,  5 Feb 2021 03:40:38 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id df22so8509856edb.1;
        Fri, 05 Feb 2021 03:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VKpw+TGxcSonBmJvYVbjnLKEXkavUls9cDkglgeREzs=;
        b=O3iPYbX4hg0w4sjb5uql2pazoXLBRhd3nlnGtE0Z6MRxETQ9aAo04oAycLYKf7DxoS
         Lp5IIHOM4Hs2AzazeNugfLCd7tV6c8IspQyFEHBo2aXNcAaHmC+uPaiF/lqFHN5d4gMc
         p93QTmDSZNOoPj1Y2B7DoJKkmjV4lYoLxNSJyGBknoswt7ZOs9UQvU8MjyJo2/H24edG
         NKR/7E29vD4TuX3bKdDJQvqKPD93QFoKUApHc4L20EzqtvScZBvqnaEBiPLeTmR3QprI
         qXwUdPEBPowIM/FkWCwBSswuoXdKmchZoK3JvYrylAwHdwkYlfVCGrbHPkiHsrnC5ZVf
         nfUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VKpw+TGxcSonBmJvYVbjnLKEXkavUls9cDkglgeREzs=;
        b=KUlJQxrCr2GEubgupV+nPEaCeck6ggS8ud65t6XvB3EmFRBI+ZomwkTogR4YVqGVpu
         mB1o0UQirmwyv7bBTudRsn1KnmXTbgloSCqighXv3HIKv57lo/LZyohK0RQR3TjkhXN+
         Jz4rrxaeYA9rrAUVdT9tWIuduNNqfW6MQAnjXhbm/RwAEINkFMUH9BWnQSz1ep2FMArs
         K2Y14DJs1dOhXLms6EP4YhUU3tAq7ITtjb4wYKytvoj342z/HwUD6IcTL3idGO717ctY
         sSNZLZ0s/9UuD69g8cI+pUcv3avbILPKscHLngYdULXWkjfaaQ5SUzUhKXDNXu4Zrgmm
         B0OA==
X-Gm-Message-State: AOAM530Q8VctpeNwMX8d+uZXvLgfiUM7jDqTgbKv/AXK3zoB+FxROLLB
        vMr7tNXe2P0DbF6ei4YRkM3UHkBh4+w=
X-Google-Smtp-Source: ABdhPJxS81UgtOu9TvukRpaKhut4UQ+qD1CMdOAim5WvZkmqsRE4OZy3Di8ETppRgpphBwWKyT4jgA==
X-Received: by 2002:aa7:c7d8:: with SMTP id o24mr3160923eds.121.1612525237159;
        Fri, 05 Feb 2021 03:40:37 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id o4sm3883476edw.78.2021.02.05.03.40.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Feb 2021 03:40:36 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org, balbi@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 8/8] dts64: rockchip: enable dwc3 usb for A95X Z2
Date:   Fri,  5 Feb 2021 12:40:11 +0100
Message-Id: <20210205114011.10381-8-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210205114011.10381-1-jbx6244@gmail.com>
References: <20210205114011.10381-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable dwc3 usb for A95X Z2.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
Changed V2:
  remove node wrapper
---
 arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts b/arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts
index 30c73ef25..e71870768 100644
--- a/arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts
@@ -357,6 +357,11 @@
 	status = "okay";
 };
 
+&usbdrd3 {
+	dr_mode = "host";
+	status = "okay";
+};
+
 &usb_host0_ehci {
 	status = "okay";
 };
-- 
2.11.0

