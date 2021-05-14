Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42CEB3807C7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 12:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbhENK5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 06:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbhENK5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 06:57:13 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EAC7C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 03:56:02 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id ep16-20020a17090ae650b029015d00f578a8so1449622pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 03:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aU+ubvcEDxtx7iqh3kjxqYe4+PGXBlZPjPFl/laTWYo=;
        b=L71ptwjauC4J/cyrkYPqQXxhvdclDkYjVRq791ibLdUQuKFnJhxwADtLOe1HKHbQHe
         9aBgrx2IiMQIMmoIfbj9OHkPrkNrHSfdrlGug4j0gpefP4wtTZ4eoCAKgqMtzf/tvQMW
         AhX45S7JStF1dPux+sIDEujXAeoWCYRphCJfDr8A4vHNwkTxhZteTrKfPzb+zjgBN5SV
         KH/Pk+u2vZyBHaqw5PIhLIuLZwTahP4M426f/ItSimSHrXv6g7P9B3Aw9j/iN2ssvdF0
         1+mVzABHLnWL+Tw8ZrkNqcevSRT61luhU8TwlL+d8gd4ts/kP2rylVMqCa2PhfftULq3
         ebqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aU+ubvcEDxtx7iqh3kjxqYe4+PGXBlZPjPFl/laTWYo=;
        b=RQMPKXwxvzu8cC2k2VB4fNtuu1ANhpTFpCJRGzg3Q/prGVjB/96TuynjxQsFbp97W3
         xMRCEbkEryJPCc9qWbb10drV+QzRZC+KovCufjRfpbOvWMqy6J4SDe6cYV+SZevVuMmI
         49x7m380l60BOxwNzcV3YP0QsiaYXlWmhEEOaflzF2XfBCTZgUtGcgg40VHiwt/hvyiV
         IInhzoBlkmdHf9aVbhFGTACxwv2CB1QE/lVxrJwzkauhTGlM3CTY/YGOKJrw30701gC4
         SCAPnwl7LpbtqTzATedenkMDOjXDs4HT9nqmTq3LR9A8t729aNe1HLtV3vcz770wAu4i
         vvZg==
X-Gm-Message-State: AOAM533pLXKK/R83xxVi9Nvtq8z/qTIWVLxPSAnj356jypeDZgjhThYL
        b5EbKUmWQfu9F1kf8QLWzJ0=
X-Google-Smtp-Source: ABdhPJyjYC6lHzlc5LqkQHD+JGPzAhHKNOw2GV8muIT24p/2IBVvtXT+oTRHN8beKeYq8e3jxeYMVA==
X-Received: by 2002:a17:90a:aa96:: with SMTP id l22mr10406586pjq.173.1620989762063;
        Fri, 14 May 2021 03:56:02 -0700 (PDT)
Received: from test-System-Product-Name.sunix.com.tw (61-220-142-250.HINET-IP.hinet.net. [61.220.142.250])
        by smtp.gmail.com with ESMTPSA id q194sm3930504pfc.62.2021.05.14.03.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 03:56:01 -0700 (PDT)
From:   Moriis Ku <saumah@gmail.com>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Morris Ku <saumah@gmail.com>
Subject: [PATCH] mfd:Add SUNIX SDC series mfd driver
Date:   Fri, 14 May 2021 18:55:46 +0800
Message-Id: <20210514105546.3809-1-saumah@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Morris Ku <saumah@gmail.com>

This patch add support for SUNIX SDC series board.

Signed-off-by: Morris Ku <saumah@gmail.com>
---
 mfd/Kconfig | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/mfd/Kconfig b/mfd/Kconfig
index a24ff27..e0247d0 100644
--- a/mfd/Kconfig
+++ b/mfd/Kconfig
@@ -2012,6 +2012,19 @@ config RAVE_SP_CORE
 	  Select this to get support for the Supervisory Processor
 	  device found on several devices in RAVE line of hardware.
 
+config MFD_SUNIX_SDC
+	tristate
+	select MFD_CORE
+	select SERIAL_8250_SDC
+	
+config MFD_SUNIX_SDC_PCI
+	tristate "SUNIX SDC PCIe multi-function board support"
+	select MFD_SUNIX_SDC
+	depends on X86 && PCI
+	help
+		Selecting this option will add support for SUNIX SDC PCIe multi-function board.
+
+
 
 
 endmenu
-- 
2.20.1

