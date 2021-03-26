Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3B134A9E2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 15:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbhCZOfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 10:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbhCZOfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 10:35:08 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D34AC0613BD
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 07:35:06 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id v4so5828352wrp.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 07:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+wgJT+2rlYaTQGPBJtoa9jo055QORNuijpExOiSwidg=;
        b=lhmKo8zYKTVyHkCYOUL8Dmj6IslDEfKHrK7GAtHgyFM+v+1DMGJttuRZCYrRqhawjr
         PirvVfHNF9jYSluJR4hybQ/3tCmoo56VvcgBlA+HranEzseWKphmEjEU5UQfxAVYpSiX
         dK4LtlrTSfBVJHwjXbG8sx4RFK1aZ8ZH+8gERBrmfT6APFWq4Cbzfiso0lau9kKcrEzM
         3GLT7dNmExpzi8s+Mra9LKmfWL4lvMp9zuAGuMKbSjaKMPOzg2NrgdZzLrEPgryvJtEN
         ctf+Sb46ftgGZq2s29qGWzB8fXw0zGb9zm6bzFwFJ1Oo00AaQ5fL5BtlnBkax8hKKqJW
         5hCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+wgJT+2rlYaTQGPBJtoa9jo055QORNuijpExOiSwidg=;
        b=CyBIU2w2EgSF1KDqu71jbQON8wDiXrVxSyh9GMgzPZ8YITfQwCoQ898KdPv2l6uhIB
         9b4PAy9UTGOf8pwqpnynQUa4dIwlgeHbajIVOv/9U4eSRnvV3fcYkCQi9hqdnm/dQge3
         JQssJ54Q1s7aH6i4wTPztDZYhK4Dy+NPKs2xnFiN4swZhCttOY3OskMAtSo7X0zF/Vl5
         B9oSVdcWYwQOvfTEpd69LDiwuq7Xh9Ij3xxA1x2j5TUAnigUWTo766KUMXaPnD0sPNj9
         y90hnmjwMUyYX/iruYgT+y8GHW4oH/MLDT7brMJqEyd0wkM/WmaFxl9mpQAR7j5ACUbM
         VWjQ==
X-Gm-Message-State: AOAM533a0fPBCkXz3ybH8pQszDNFhSdFw2mX0P29pAsuvv/zndQH8wWw
        ncsYTXrrKMslvn+CNyK/TCQuog==
X-Google-Smtp-Source: ABdhPJyimJxsZ3rpCSt/gL4lDDTPGwlAOyhXFrW4+tUdqifDhNF/eAHunyWtOVKE1d7NoJ9tWlVVqg==
X-Received: by 2002:a5d:4e85:: with SMTP id e5mr15102455wru.218.1616769305350;
        Fri, 26 Mar 2021 07:35:05 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id j26sm12878225wrh.57.2021.03.26.07.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 07:35:05 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Zhang Lixu <lixu.zhang@intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Daniel Drubin <daniel.drubin@intel.com>,
        linux-input@vger.kernel.org
Subject: [PATCH 03/25] HID: intel-ish-hid: pci-ish: Remove unused variable 'ret'
Date:   Fri, 26 Mar 2021 14:34:36 +0000
Message-Id: <20210326143458.508959-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210326143458.508959-1-lee.jones@linaro.org>
References: <20210326143458.508959-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/hid/intel-ish-hid/ipc/pci-ish.c: In function ‘ish_resume_handler’:
 drivers/hid/intel-ish-hid/ipc/pci-ish.c:264:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]

Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Zhang Lixu <lixu.zhang@intel.com>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Daniel Drubin <daniel.drubin@intel.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/intel-ish-hid/ipc/pci-ish.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
index 06081cf9b85a2..61efc30ed9afb 100644
--- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
+++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
@@ -261,7 +261,6 @@ static void __maybe_unused ish_resume_handler(struct work_struct *work)
 	struct pci_dev *pdev = to_pci_dev(ish_resume_device);
 	struct ishtp_device *dev = pci_get_drvdata(pdev);
 	uint32_t fwsts = dev->ops->get_fw_status(dev);
-	int ret;
 
 	if (ish_should_leave_d0i3(pdev) && !dev->suspend_flag
 			&& IPC_IS_ISH_ILUP(fwsts)) {
@@ -273,7 +272,7 @@ static void __maybe_unused ish_resume_handler(struct work_struct *work)
 
 		/* Waiting to get resume response */
 		if (dev->resume_flag)
-			ret = wait_event_interruptible_timeout(dev->resume_wait,
+			wait_event_interruptible_timeout(dev->resume_wait,
 				!dev->resume_flag,
 				msecs_to_jiffies(WAIT_FOR_RESUME_ACK_MS));
 
-- 
2.27.0

