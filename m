Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED69324C82
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 10:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236097AbhBYJLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 04:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235252AbhBYJHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 04:07:16 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091A9C061786
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 01:06:36 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id o63so3365011pgo.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 01:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XDTZ33fjLbE2/tgGk4BUqIi9+Z24fcyTW3i1iRPooGA=;
        b=n7e8Rw3AVuSWzHat8SJs5B0TxUQEamnDc6kCmvsEN1ECxIv0PK4eCwkMudmQbYUCzC
         DS6i+KU4/Lmc7pU9bJd862r3RsY4FFF8AtWEdPtOsHW7ZecFr/yLkzwcS5q43IUmiOG6
         DlFOCVUJ5mSYemsrdAN5ZzW2vxId9WU6QBP91Y3hZdwxW7kI7g0bf2tA1W0OTVxPjXRj
         HXwN4Jxl6gUYOwPyUmTTmPm73cHjzPYPtRtHAhMkkQgDkRELidKNlYS43mVRovV3I2HF
         jSPDCcI0o6LnjFHtoLwkc0d5FlZEv5QzFFx4DwideGT9lvNxgE7jRWiKlbpw8udnQXe3
         7rzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XDTZ33fjLbE2/tgGk4BUqIi9+Z24fcyTW3i1iRPooGA=;
        b=ku1DHhvM2ih0i14IHJR2Ta5YAx63jtJV/0lTv1D9damHfUDdLvWtIBwNw4t/8g1BW/
         J0W/B3m3fj0RstCp7sTttUy2t9ZKHnh+ZuxiqgJa4WCeESzYKMTHhPZyodeDJZP+nMEs
         tSv8P0W9mH6W8ovcwWr6lscZ9cBwRm8+PcYJibVPXJ+ljvhDlbXw+xPrD9cyMG6PGoRM
         3ca1lqpDLjhRzLoAt9kvud8F8RLczwFQRnq/RGgEvA0Fnt95dxnRMor7498cNCTAKnif
         GSKplLavGD3KEBZLV3yYQYxaBFKQrm5TZ7qvK1iRu9VECLZf9+gyn4p3RdQ5seeqWHCZ
         tM5w==
X-Gm-Message-State: AOAM5329Tn4r+L6SVt2AicoqKf8VMtzxpGOWaQDZic8ensyXqgyK4h5o
        QWHPN2i3blMt6SG3Z5Dr1hs=
X-Google-Smtp-Source: ABdhPJwVS1uC0P1ohEib08/wGhPLo8oCIymghGRpA2CD6+kCe1O9HQ0O7l1XKktl8V3dFnHDcjFlrA==
X-Received: by 2002:a62:a108:0:b029:1c1:119b:8713 with SMTP id b8-20020a62a1080000b02901c1119b8713mr2341428pff.74.1614243995660;
        Thu, 25 Feb 2021 01:06:35 -0800 (PST)
Received: from localhost.localdomain ([49.207.194.79])
        by smtp.gmail.com with ESMTPSA id n11sm5098373pgm.30.2021.02.25.01.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 01:06:35 -0800 (PST)
From:   Allen Pais <allen.lkml@gmail.com>
To:     jens.wiklander@linaro.org, zajec5@gmail.com
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org,
        Allen Pais <apais@linux.microsoft.com>
Subject: [PATCH v2 2/2] firmware: tee_bnxt: implement shutdown method to handle kexec reboots
Date:   Thu, 25 Feb 2021 14:36:10 +0530
Message-Id: <20210225090610.242623-3-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210225090610.242623-1-allen.lkml@gmail.com>
References: <20210225090610.242623-1-allen.lkml@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Allen Pais <apais@linux.microsoft.com>

 On kexec reboot the firmware driver fails to deallocate
shm memory leading to a memory leak. Implement .shutdown()
method to handle kexec reboots and to release shm buffers
correctly.

Signed-off-by: Allen Pais <apais@linux.microsoft.com>
---
 drivers/firmware/broadcom/tee_bnxt_fw.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/firmware/broadcom/tee_bnxt_fw.c b/drivers/firmware/broadcom/tee_bnxt_fw.c
index ed10da5313e8..4c62e044a99f 100644
--- a/drivers/firmware/broadcom/tee_bnxt_fw.c
+++ b/drivers/firmware/broadcom/tee_bnxt_fw.c
@@ -242,6 +242,14 @@ static int tee_bnxt_fw_remove(struct device *dev)
 	return 0;
 }
 
+static void tee_bnxt_fw_shutdown(struct device *dev)
+{
+	tee_shm_free(pvt_data.fw_shm_pool);
+	tee_client_close_session(pvt_data.ctx, pvt_data.session_id);
+	tee_client_close_context(pvt_data.ctx);
+	pvt_data.ctx = NULL;
+}
+
 static const struct tee_client_device_id tee_bnxt_fw_id_table[] = {
 	{UUID_INIT(0x6272636D, 0x2019, 0x0716,
 		    0x42, 0x43, 0x4D, 0x5F, 0x53, 0x43, 0x48, 0x49)},
@@ -257,6 +265,7 @@ static struct tee_client_driver tee_bnxt_fw_driver = {
 		.bus		= &tee_bus_type,
 		.probe		= tee_bnxt_fw_probe,
 		.remove		= tee_bnxt_fw_remove,
+		.shutdown	= tee_bnxt_fw_shutdown,
 	},
 };
 
-- 
2.25.1

