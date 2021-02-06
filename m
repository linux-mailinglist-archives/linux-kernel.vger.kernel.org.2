Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52CA8311ABC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 05:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhBFENX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 23:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbhBFCzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:55:21 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E0DC06121C
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 18:31:34 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id n81so9275668ybg.20
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 18:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=pg0W/R7zse7EuXBb4JSBY3vmlRcXUGF9rrk9VSwX6b0=;
        b=D4K1oHbfzEXavSAr43Kq1T1ta0mIdfD0L/KzpYR9dz0d1EbcXv4UCnOskw77CXX41L
         PchyM/pIK9P0Jxc9CvbYnehDMCfVMNpMGqQEi4W1vIGf3K2ueOzIfryEaEmRl8Nzn9wx
         JAKgIW51v8P/WT5AVSXcjNzBfrUtE6T4G18rMxXIsOsCUN2DbSR6OS24OLhcKfDjpdfz
         uPii70C03VwZ95GoojWY+etO3VyDUzgmm8+5k6rrIkx85LmaXNyXz1ncs36MAp6SXujV
         Dax44IAWzk+vLcLHAfrBvHLYpNKqzqOWEnD94EiOVQmO+sjB+Qao/83gRYzRJ6y8bHEY
         BbLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=pg0W/R7zse7EuXBb4JSBY3vmlRcXUGF9rrk9VSwX6b0=;
        b=ivC2eSAtDKB0oIikEb9xcjEmSkeXJgx5DZRPf/benU/7Sow6Tm9QH1SvdbuugeGLFZ
         uRwhxfsJf41vU6UxmwrjQFeke3V+5/ZCq12lsjLZRoZYVqI7KuclbAPZ9Z0ri9FUIMWR
         a8rCbOEkpY8asr4oEuCQrwk0IDrO64CAPaLndyNLNfslsYv2vZVw7A8iHfshXTlvDmxY
         Pe2/vi+FtRYovcn26zjfGyPIIPO2GfCWYE0vPx8h6PtKWLH4wqRFRfc7rB/2Wco50u0g
         ti86U0WrSKQXWp6TF/cnHge8cRZDlXvY/XribHYld7vx/2uzwYm0+mD8Xz7y/EOWn0rL
         /nyg==
X-Gm-Message-State: AOAM531ZdCVPmNpDKdyBXIe4iverMsGnjwgkwiuuT5VUCmHL922V5MJu
        cAX+ZHvtluyIPQO958pEdsu42LvZ
X-Google-Smtp-Source: ABdhPJzeJvpuloADryZgdGQ60MX7y1ab5Igdr3YB1r2d9IocONYjEbck+WeQDNAJ+cvcznehGUmZl9w3
Sender: "rkir via sendgmr" <rkir@rkir.kir.corp.google.com>
X-Received: from rkir.kir.corp.google.com ([2620:15c:29:200:6406:401c:95df:fca2])
 (user=rkir job=sendgmr) by 2002:a25:a4ea:: with SMTP id g97mr11166275ybi.286.1612578693448;
 Fri, 05 Feb 2021 18:31:33 -0800 (PST)
Date:   Fri,  5 Feb 2021 18:31:18 -0800
Message-Id: <20210206023118.1521194-1-rkir@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH] Remove the GOLDFISH dependency from BATTERY_GOLDFISH
From:   rkir@google.com
To:     sre@kernel.org
Cc:     linux-kernel@vger.kernel.org, lfy@google.com,
        Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Kiryanov <rkir@google.com>

This will allow to use the BATTERY_GOLDFISH driver
without enabling GOLDFISH.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 drivers/power/supply/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index eec646c568b7..8704fe644b1f 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -683,11 +683,11 @@ config AB8500_BM
 
 config BATTERY_GOLDFISH
 	tristate "Goldfish battery driver"
-	depends on GOLDFISH || COMPILE_TEST
 	depends on HAS_IOMEM
 	help
-	  Say Y to enable support for the battery and AC power in the
-	  Goldfish emulator.
+	  Say Y to enable support for the Goldfish battery and AC power
+	  driver. Originated in the Android Studio Emulator (goldfish) it is
+	  going to be used in other emulators.
 
 config BATTERY_RT5033
 	tristate "RT5033 fuel gauge support"
-- 
2.30.0.478.g8a0d178c01-goog

