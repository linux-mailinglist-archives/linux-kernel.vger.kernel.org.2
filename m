Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB57398977
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 14:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbhFBM15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 08:27:57 -0400
Received: from mail-ej1-f49.google.com ([209.85.218.49]:42774 "EHLO
        mail-ej1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbhFBM1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 08:27:47 -0400
Received: by mail-ej1-f49.google.com with SMTP id qq22so3528292ejb.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 05:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KwzIciJcRMLFeuSk+73IfkH7cFnyIlKyHf0qK2B6F5s=;
        b=YLu782R4rDcdufVKCWyFar1u0k6ZHIS149dEuY/M5/REZQmi81VEd0HYxa83bcsHrq
         Ph/aAm5w6euQn1Gk2P/2HibUDzDJaszXa6Sh8AoWF1dxeSubYazVzxeNMy+UsHgq4lZq
         r0mWTqK5wk9E5LZkcU7TtLXMdyLzQv5fGG1I8VHGX1ePRV3zQdnpuRYnSPTcwDCHD96a
         +Srku5qHx4JSQsrRe/JyFM+JhmjOwFSc8AQ/JrkqHFgdDHBpQq412gKfzpJ1Mb33UOeG
         0t1++gb+1Q1nIvrnzdh2c0tESVfU4RuGgK7aJBu24qrb/h+/684mjxJxvDZ9xkgt3bYH
         HsBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KwzIciJcRMLFeuSk+73IfkH7cFnyIlKyHf0qK2B6F5s=;
        b=bdykntBAnbcrWvCCC+WlPLXFcLpfMPAkMgaHeWb/hwUeRkkNhFHY12u2Qb216MBf58
         AqyoiwOnY/xAfuGMhxXfFATbFAm8Q0kc2gbkqDrlwq30fe9jvZizTes66KKB/8t0tKnM
         4x+HyP8w3stDjWds3Tv4lX3It4L6z31f4fc3wWQUXRUwS+jxGpQDn06fRuMOJTvhYfFQ
         7/sKUfxe11zGie1zgv+UZ1CFVVl6fEA+ec/SmYBlUTwMPDlD4VDhCOaZ0yBrkSxPSt1T
         Sw/wWcQnBm4nxA/CK9sI58byZKN+SyAXAZuvyjfbwppC7EN7G2oTHLuGeoke3HrLgAUi
         mmlg==
X-Gm-Message-State: AOAM533inMNb8Gl2SVBxxllnlufDWSf37scd/WyKA+wCBqOyrkMKM6yM
        4vyAF3+h9cL+bkX3/qvGp7/5rA==
X-Google-Smtp-Source: ABdhPJyUATHNryaU2UdW7mbUDR3V6ErfrzvZ7r7XgrMT94yfOmagV2tucEdTb8VY/t4Cv9cfiRAjEg==
X-Received: by 2002:a17:906:1848:: with SMTP id w8mr631935eje.277.1622636694788;
        Wed, 02 Jun 2021 05:24:54 -0700 (PDT)
Received: from localhost.localdomain (dh207-96-250.xnet.hr. [88.207.96.250])
        by smtp.googlemail.com with ESMTPSA id z17sm8539340ejc.69.2021.06.02.05.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 05:24:54 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        robh+dt@kernel.org, lee.jones@linaro.org, p.zabel@pengutronix.de,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     luka.perkov@sartura.hr, jmp@epiphyte.org, pmenzel@molgen.mpg.de,
        buczek@molgen.mpg.de, Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v4 6/6] MAINTAINERS: Add Delta Networks TN48M CPLD drivers
Date:   Wed,  2 Jun 2021 14:24:39 +0200
Message-Id: <20210602122439.2084775-6-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602122439.2084775-1-robert.marko@sartura.hr>
References: <20210602122439.2084775-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add maintainers entry for the Delta Networks TN48M
CPLD MFD drivers.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9450e052f1b1..82d9c2943c34 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5096,6 +5096,15 @@ W:	https://linuxtv.org
 T:	git git://linuxtv.org/media_tree.git
 F:	drivers/media/platform/sti/delta
 
+DELTA NETWORKS TN48M CPLD DRIVERS
+M:	Robert Marko <robert.marko@sartura.hr>
+S:	Maintained
+F:	Documentation/devicetree/bindings/gpio/delta,tn48m-gpio.yaml
+F:	Documentation/devicetree/bindings/mfd/delta,tn48m-cpld.yaml
+F:	Documentation/devicetree/bindings/reset/delta,tn48m-reset.yaml
+F:	drivers/gpio/gpio-tn48m.c
+F:	include/dt-bindings/reset/delta,tn48m-reset.h
+
 DENALI NAND DRIVER
 L:	linux-mtd@lists.infradead.org
 S:	Orphan
-- 
2.31.1

