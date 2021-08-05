Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2323B3E0FA4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 09:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239011AbhHEHu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 03:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238834AbhHEHuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 03:50:55 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369AEC0617A4
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 00:50:40 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id d8so5263060wrm.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 00:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zUZnybOtcqfD5sy4n9GcAXWKsLqQn6Mi0yNhn1TJs8Q=;
        b=b40vf5opQl78jOOKEADu2/NGxsLEAHcx8zb/g/Xv69lyRp/lPO5wRx52tjAhOsi74g
         R+0P7hiy5tO+TFrrSQtM++yqPRACRZJOju/FYgYAiraWnkfJw9nvSS/fwRTA18SU3Y/F
         eFfC7B3Qlf6jtN0ehG2ufafKVp4Yzxq5fpSF2uVD0zPkSsiFtCJtOC4RhGibi/aoQXmW
         Sd06F1YpApSGrMx3SpV/9Hrk8nvxi1NCf3TTvcWslxQ4jzEHhGjQ1q4X21BuW/YM2l55
         OiOOsBv1uUs5RKn7QYTv7wL+7MzbJxgep3Cu2AvR3hEEUwjGqW8+yflMCMgfxi0CkQcF
         6ClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zUZnybOtcqfD5sy4n9GcAXWKsLqQn6Mi0yNhn1TJs8Q=;
        b=gvXS77Og+T5OpNV3+dYSkoK6ZBNY1l/Cm1DjdOvMlZ4sxuff3vzZRIq4gYEWKm0tD0
         DU6pHTVw1R8Z786UKvazdDH9MKDSKq10mUrZ7gD3WqEVyboYSeqSvg9Lb0GLzbiBkpWU
         iJRgaQQEcE1yh/2x2YD/JL0AR2e/yj2+XNZgZhphTvid5SSDskUUvelUpYsxbyo4aU0+
         jBxJYgM3wuu+xhM3TTBIlll0MWW2oP52+JYxSfue7HzGJc+/2XdBGPztG612ZWYguRXo
         QZ0Du7uf2Lezk0sUNmJ0uRZ46y+8zu3x6TwjOewGZ8X8ecFXQh+Ey+4jU0XyKouYBnsG
         uDrw==
X-Gm-Message-State: AOAM532P0sCtZ8DlqJUf9EE2E9e0Bx9dRzCdY3o6HRROCEvQcXyQTmdP
        TfsTnWumS+mJfHwS29ZaJmfWOA==
X-Google-Smtp-Source: ABdhPJy+3j19yabOOIazM6nVcJ8O5oEhgcEZA226SMM1ZKJ/q0ZyCET2ren5wvi/NjD7Zm6ek9eg2Q==
X-Received: by 2002:adf:dcd1:: with SMTP id x17mr3503054wrm.59.1628149838895;
        Thu, 05 Aug 2021 00:50:38 -0700 (PDT)
Received: from localhost.localdomain ([109.180.115.228])
        by smtp.gmail.com with ESMTPSA id h16sm5154491wre.52.2021.08.05.00.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 00:50:38 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Elliot Berman <eberman@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 2/3] reboot: Export reboot_mode
Date:   Thu,  5 Aug 2021 08:50:31 +0100
Message-Id: <20210805075032.723037-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
In-Reply-To: <20210805075032.723037-1-lee.jones@linaro.org>
References: <20210805075032.723037-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Elliot Berman <eberman@codeaurora.org>

Export reboot_mode to support kernel modules wishing to modify reboot_mode.

Signed-off-by: Elliot Berman <eberman@codeaurora.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 kernel/reboot.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index a6ad5eb2fa733..7ca414aa070b6 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -32,7 +32,9 @@ EXPORT_SYMBOL(cad_pid);
 #define DEFAULT_REBOOT_MODE
 #endif
 enum reboot_mode reboot_mode DEFAULT_REBOOT_MODE;
+EXPORT_SYMBOL_GPL(reboot_mode);
 enum reboot_mode panic_reboot_mode = REBOOT_UNDEFINED;
+EXPORT_SYMBOL_GPL(panic_reboot_mode);
 
 /*
  * This variable is used privately to keep track of whether or not
-- 
2.32.0.605.g8dce9f2422-goog

