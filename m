Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5BA38D76D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 22:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbhEVUw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 16:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbhEVUwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 16:52:24 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D979C061574
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 13:50:59 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id x7so4787082wrt.12
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 13:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FqGZVkSfOTjIydyeIzbBzvazr+vyEv7M9XhPMOmAi8A=;
        b=QEHzQjuimSdSUCq0g6rbtS2Wu2L2XqH2E5ihW6/I0ZlO8/r96exAq6WS0+WuY1Lkwy
         DWFy+YoImr9R4c8iNKorjUNR58DIvio7UH2KQ/L5A4899DLl3CSHeK96e+77eoKaqmIF
         zka8aEiIL7Q9sRIzJA8zj1+BHd0Y1lgmO84monohfLj13F99hqA3+kCKxOKXjpxulK6k
         xAPfgGuFt2jGwCW/zteVtYclYWMYe+sBK8gW0rMMPOGJxPSx5xNJLAvQaqoZV7zwTGDP
         ajxyPL4bDcKKpUpCe36RnK3Dk+gqQcuENhn1mMNfgyTxXHp4zgyBNKhRVVozr3ecV+zu
         Shmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FqGZVkSfOTjIydyeIzbBzvazr+vyEv7M9XhPMOmAi8A=;
        b=C+GICGIh1FaToBKdMyG8alGGfXiVMIrwoEm0bIj3XvjiNevwxJttTUCBPHlF4GkYlh
         XMj/iq0sAfTGFVO0nK/zxlQmzGI41Plwq5gpLcawWh9Y2yAZeNn10jrHQx6C/IUTsrO+
         8FnXb6SzMoHiJwDrktrcVVWF/jpKOq5NlBqY5NKtdHAPdzkvWcTAiwLhrUiGc0EcWtIb
         yVqkHMCIIB1nhG6gD4CebmuboWFh8BmNHYrDlSOBaC0LJ2Hepa0NE+gu32gqieturj0Z
         lXM/LFdz7uCF0/EOk8COU/6wl5HOjP1V2jzg1Ug2WiT5i1IFWC6RJ9qbgxJw4+LiNLAi
         xyNw==
X-Gm-Message-State: AOAM531uUQfEggog7AGSgiHsoj/NytwAszKdGgLs/vYf44oTzrDsrLaA
        IOKWeQDauC03Jfs5TNMgIdc=
X-Google-Smtp-Source: ABdhPJxrh0ij+DcignA5QkW1HZigF7cAQ5Raqv/pvvx0ZTChgrdYsg7JYWhgJoNWKsASNXHXWTX7Eg==
X-Received: by 2002:a5d:4384:: with SMTP id i4mr13798343wrq.332.1621716658150;
        Sat, 22 May 2021 13:50:58 -0700 (PDT)
Received: from flex-5.fritz.box (dynamic-077-012-139-231.77.12.pool.telefonica.de. [77.12.139.231])
        by smtp.gmail.com with ESMTPSA id p6sm3447055wma.4.2021.05.22.13.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 13:50:57 -0700 (PDT)
From:   Andreas Rehn <rehn.andreas86@gmail.com>
To:     mripard@kernel.org, wens@csie.org, jernej.skrabec@gmail.com
Cc:     linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andreas Rehn <rehn.andreas86@gmail.com>
Subject: [PATCH] ARM: dts: sun8i: v3s: enable emac for zero Dock
Date:   Sat, 22 May 2021 22:50:39 +0200
Message-Id: <20210522205039.179486-1-rehn.andreas86@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dwmac-sun8i supports v3s and
Licheepi-zero Dock provides an ethernet port

Signed-off-by: Andreas Rehn <rehn.andreas86@gmail.com>
---
 arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts b/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts
index db5cd0b8574b..2d78b7a52fd3 100644
--- a/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts
+++ b/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts
@@ -94,3 +94,8 @@ button-800 {
 		voltage = <800000>;
 	};
 };
+
+&emac {
+	allwinner,leds-active-low;
+	status = "okay";
+};
-- 
2.25.1

