Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3801410A82
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 09:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbhISH1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 03:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232832AbhISH1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 03:27:48 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E10C061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 00:26:23 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id y4so11744793pfe.5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 00:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n2xhpCyxH1A9Jgv6rcqXhKxtccBxdHhDJzYMXlyJTZ8=;
        b=Ae60tgH8gsPKG8W/2/8Hliu058o58hxk8N6W+azuMjmR6INoAbJHrTyifzf8yS3W9O
         aAzdUYwHxVMBNuWaku/GWIrPAe90zJxjnJmeIMMAjF0+5LFjWlOpZpevI0AywTOKmYSR
         nJGcJju3AHfZVnPueBl90ZCxJT2fv1kmWf14A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n2xhpCyxH1A9Jgv6rcqXhKxtccBxdHhDJzYMXlyJTZ8=;
        b=kHuONFPSN4ZA1aeXHKJf/pktNqCpZSbAtx8wi7DtU2Mt8PliOF5ZmlSnxT7UidrivA
         5ffebNnMI+3O6jeVT3XtZqIrXLffurEHs4rDy2k+ulrfsKZgXqCmSp37qQM/sV24meTy
         H9Qu/i4JTcVWx8XXF2xpWla75jvYoi5I5FlLDyirJrQt4TnsSUooxbij3WKyZceibbXe
         qnDpvIIdP6aRtm5UeHR7weIvWn1tAfgQL6SjD8G9RgVxP3PFG81116oJosaJb3qDOO+K
         V1XjzV2TcuW8fhihRZF4qrEh60olvObqE8SRls1moCUVwgzLW65voeYMrQfhcEMS2Pac
         AoSg==
X-Gm-Message-State: AOAM532moFHMsqpmBhxluZwMyFg42xkcuqEgbBjJOHpMIv7nOBSMClnG
        It9MR0gSdUgyyKk4x2v23Rc++Z6qbkkiqQ==
X-Google-Smtp-Source: ABdhPJxeUnLVR9v70ts1dTQxxFwZEkqFY16CJyNybW1zgtyM/M7svL5Iv4wJrtHvhEEi7QF8Z3aruQ==
X-Received: by 2002:aa7:96db:0:b0:43b:64f4:21e9 with SMTP id h27-20020aa796db000000b0043b64f421e9mr19072573pfq.52.1632036382283;
        Sun, 19 Sep 2021 00:26:22 -0700 (PDT)
Received: from shiro.work (p864106-ipngn200510sizuokaden.shizuoka.ocn.ne.jp. [180.9.58.106])
        by smtp.googlemail.com with ESMTPSA id l11sm14727372pjg.22.2021.09.19.00.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 00:26:21 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH] iio: accel: mma7660: Mark acpi match table as maybe unused
Date:   Sun, 19 Sep 2021 16:26:16 +0900
Message-Id: <20210919072616.3849723-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building kernels without ACPI support the table is declared
but is not used because ACPI_PTR() turns it into a NULL.

Add the __maybe_unused attribute to stop the compiler whining.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 drivers/iio/accel/mma7660.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/mma7660.c b/drivers/iio/accel/mma7660.c
index 47f5cd66e996..cd6cdf2c51b0 100644
--- a/drivers/iio/accel/mma7660.c
+++ b/drivers/iio/accel/mma7660.c
@@ -254,7 +254,7 @@ static const struct of_device_id mma7660_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, mma7660_of_match);
 
-static const struct acpi_device_id mma7660_acpi_id[] = {
+static const struct acpi_device_id __maybe_unused mma7660_acpi_id[] = {
 	{"MMA7660", 0},
 	{}
 };
-- 
2.33.0

