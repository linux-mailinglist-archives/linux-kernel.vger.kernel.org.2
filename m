Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9EDD39C63F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 08:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbhFEG07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 02:26:59 -0400
Received: from mail-pg1-f175.google.com ([209.85.215.175]:40608 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbhFEG06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 02:26:58 -0400
Received: by mail-pg1-f175.google.com with SMTP id j12so9557174pgh.7;
        Fri, 04 Jun 2021 23:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NaibPNLx+MUOnhnXMB6TkyMyA3F3CqoWfhdvwpm1Q3M=;
        b=PnFCJ0towIX1KYUshsmSxTwwqsLY7pFlpMwp5dzKPTbcQ7zm5s44tn/cIye6xmbDEp
         JvZwe/YpogpiP5cIvwd8FIdi/SXl5B4ojYWKMwmpVA5EZAgxR0fGj3aBS4tHLDn6/db+
         hK6dp7OuBv5dsLbz+WjTjI4dCO+YtK0GIWCtK+fvKASjv/Kk9gmhn+wY6ztyd3n9qx+X
         37o96ECzaa1LSQrFpHFsABNp0uT+UWun8m/VoMnptfAmfG2fj0t6MQPN7g+QkE4Kz9LZ
         vNe/7e2WSjuPSz9susKThd6Txu3zOZzYohji3t5jnSC9nfo/reaTqCvLSRKgxYCgsPTz
         NrPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NaibPNLx+MUOnhnXMB6TkyMyA3F3CqoWfhdvwpm1Q3M=;
        b=VfqDEiNSKhZrKHgFwSm4404Rx++N3Zuvw/MzpN5S5dGKz6QeR2JmbcpzrdWpAKU1/r
         59jsQZeuMo219UA88KPDUVWu84Xxer314Vn+l+/pTuf/YperQZTxLqdWZqBof2567Hvg
         ow2IUlvIn/EYZtTV04MI13aMfCasMjUlcXgQ39RWhzqeXrDUm4cz0eA43ZZ73MSrkXZF
         VkakLoPkzaeUjloxp7QkfKI07bxuq3bkl5x4OzAZ46db/OmwVscEI5VDxYE3Mytxx4Gn
         94s/PsvpdOZadQwex/komsyG4YO/MYXAITGJET0rzXn4FW7pA4iSV6DHZKwNF9RgKMBV
         cu+w==
X-Gm-Message-State: AOAM533I4iWECXJ9+wn605j5kFfU8hEGw2ezjsgDsfjOmKf16cGZzNkC
        fh7mh9lLBZ50b3w2df0PD2M=
X-Google-Smtp-Source: ABdhPJy+SN/JCW9y73jk7Rv4CeWcqTl+YX031QCi0JX3Fp4CIJ2+LFrGSaYRussS1JVjlMiB/Y0XKQ==
X-Received: by 2002:a65:64c8:: with SMTP id t8mr8403199pgv.96.1622874238348;
        Fri, 04 Jun 2021 23:23:58 -0700 (PDT)
Received: from localhost.localdomain (199.19.111.227.16clouds.com. [199.19.111.227])
        by smtp.gmail.com with ESMTPSA id v14sm2800870pgo.89.2021.06.04.23.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 23:23:58 -0700 (PDT)
From:   xieqinick@gmail.com
To:     robh+dt@kernel.org, narmstrong@baylibre.com, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     nick@khadas.com, artem@khadas.com
Subject: [PATCH 3/6] arm64: dts: meson: vim2: update serial aliases
Date:   Sat,  5 Jun 2021 14:23:10 +0800
Message-Id: <20210605062313.418343-4-xieqinick@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210605062313.418343-1-xieqinick@gmail.com>
References: <20210605062313.418343-1-xieqinick@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Xie <nick@khadas.com>

Update serial aliases for Khadas VIM2.

Signed-off-by: Nick Xie <nick@khadas.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
index 18a4b7a6c5df..70488ae45876 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
@@ -17,7 +17,10 @@ / {
 
 	aliases {
 		serial0 = &uart_AO;
-		serial2 = &uart_AO_B;
+		serial1 = &uart_A;
+		serial2 = &uart_B;
+		serial3 = &uart_C;
+		serial4 = &uart_AO_B;
 	};
 
 	chosen {
-- 
2.25.1

