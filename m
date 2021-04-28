Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60B1736DD49
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 18:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241174AbhD1QnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 12:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241138AbhD1QnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 12:43:17 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22259C061573
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 09:42:28 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id k128so34191628wmk.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 09:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KSF6Pij+oCZWv8GIdJGXO9GyJLWrt789k7MQt6XyiRs=;
        b=OQOO4MY6aSibgH++lNkvFpbOmvNXA7h9sW8y6dafOcjjjW1+d6WJP3VgTNCRmFVG3W
         nRGU4J90kEj+nRDYYxk74wirKyfsHKxJf6qYuScw4/b8WKyeSFP+jyTIeRgZI2EufLvU
         7pR7yKWfFsbYo5y3KQxC4USfsByJuNPnGVRlyv6oa+fZX/EZumWGOih904DSSWVzC21W
         maaxVK1Kp4+ZqUvRybJ9hHrR9Ugs4ewdv5u/7zjPxLWqnsML7vB/i7DIK7hISSreCEPv
         Gc9PW/z2fcc2alytzLatTnrdZSQUF7EpkTiRdCnhA5XhHKYZJtHCPiVw8uY5RDPiRCqj
         hE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KSF6Pij+oCZWv8GIdJGXO9GyJLWrt789k7MQt6XyiRs=;
        b=M4M9m8Qi7eakMjiGAoYLdCIp9ocQ2V1pobGXiYwYmUHa6ax/sTyy3W+pA4kM7fI6RK
         secKzwn+yJY96MDxJA5nRZacDGTZw34uKUP1jNAE8UMfjJMICNYGvwMMlnaO/9eFNxPh
         oHrwaSKhVw+bI5RUKr5jrJrOtU2VD4fCdA2bK6l8zyT3MDsnGiWiO5j3VHkP5AkpMpL0
         XhIL1ntd9PelDRoAF10+qQNWEAh6IJVtM5TRvq1JUHfkq/jczJduyHgS/VNkdYHVn3c4
         zYFtp6rsOAPiqeccLG7HTd02K+InalUmQP+m3tQX1CrpuZMqf35jrE5iGRHP0XRzNBB2
         9/PA==
X-Gm-Message-State: AOAM533MhRL1xxAuzFNxpEdFfUiD+yIgE+VfVJlDAS5ouJwwwfGN9olP
        ewrnuMECv+B11ZB1fK63Wt7I7A==
X-Google-Smtp-Source: ABdhPJyVSmNvzgpTISSckOFTwPe4BMSsBwptn//otLjLQhK4nnPGDJcuWxnqMK5HD5OOqGqB/b8sVg==
X-Received: by 2002:a7b:c156:: with SMTP id z22mr5652648wmi.86.1619628146887;
        Wed, 28 Apr 2021 09:42:26 -0700 (PDT)
Received: from groot.home ([2a01:cb19:826e:8e00:5864:ddd1:d623:f912])
        by smtp.gmail.com with ESMTPSA id o10sm351299wrx.35.2021.04.28.09.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 09:42:26 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     fparent@baylibre.com,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] mfd: mt6397: add mt6358 register definitions for power key
Date:   Wed, 28 Apr 2021 18:42:14 +0200
Message-Id: <20210428164219.1115537-3-mkorpershoek@baylibre.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210428164219.1115537-1-mkorpershoek@baylibre.com>
References: <20210428164219.1115537-1-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to support power/home key detection, add definitions for
two more MT6358 PMIC registers:

- TOPSTATUS: homekey and powerkey debounce status
- TOP_RST_MISC: controls homekey,powerkey long press reset time

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 include/linux/mfd/mt6358/registers.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/mfd/mt6358/registers.h b/include/linux/mfd/mt6358/registers.h
index 2ad0b312aa28..201139b12140 100644
--- a/include/linux/mfd/mt6358/registers.h
+++ b/include/linux/mfd/mt6358/registers.h
@@ -8,6 +8,8 @@
 
 /* PMIC Registers */
 #define MT6358_SWCID                          0xa
+#define MT6358_TOPSTATUS                      0x28
+#define MT6358_TOP_RST_MISC                   0x14c
 #define MT6358_MISC_TOP_INT_CON0              0x188
 #define MT6358_MISC_TOP_INT_STATUS0           0x194
 #define MT6358_TOP_INT_STATUS0                0x19e
-- 
2.27.0

