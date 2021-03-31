Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB18334FD39
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234696AbhCaJlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234645AbhCaJks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:40:48 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9D9C061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:40:48 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id x21so21515598eds.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WC93Jj91nT0yHUtoR6XD1Ph0OiGFSURlPEL1KdaqINI=;
        b=jwE4Bumc/4JCW5XYmdIE82e0POJpxlMwT6Dvl8Q9TD5SFWsnpdLXTX1+RZKDYR+/7Z
         d7CiKIoW08jWJ8kolU2dpDg+IV8cbVY+m5G/MLqmfkFXc3wMz6wptEqlEOcVFxxcSAZS
         gSL0o5zXq8ZEoWeElTYUzN7GIE+SIqSM5NUUDcgimzcW+aJkqYCIQ9syUKyXCE9/VkIK
         snRTC85TVd4v9n9m0P+y8XKKAErUcsHETCCAajJO94XuxjZ/UyNUBZ5uiTexjVjHG8Dy
         gxDW2IBNuS+RKh9DwVHVgN8BW3rzWnis7CvUD4EmH7gvPODRmPmwtF8v42YqavISdHI3
         Q+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WC93Jj91nT0yHUtoR6XD1Ph0OiGFSURlPEL1KdaqINI=;
        b=G4a0xSr8OZVqX0MtEnyPBU8mqGu/BmTgy+ypVap/B2QfW+jmB4mQwLYpzk0Cv197Ho
         g2MruMLaAWJAF7EayzZ/boscmtr0R6EZNduE5JeDxWYPCNIOQyTgu1m6aL9Zudx6f4L4
         2j71D3m9Yal+FIKFEWE9jKiqKgVy73C77+zvOGxNLASix/gGGLLMbR+yrHZISEKhjYRM
         Cv935+/vkg4lFsJ+2DZ8WPzVW0Uq7LhrEQ97f7DiR0pVxwNWEghNLZpulAMHrUQHNnVx
         l5iAemguQgW1LR9di0P2G+uMrf/9PiVSo/xr6LqpJJJCH3e7jqsllSsKNqgOCnYQYrsv
         V10w==
X-Gm-Message-State: AOAM5337CE2KkbEmGW0+0kyG4mK1IFlPgdKbGAL2au+xWb46m7xmYhLG
        ezqkl8QB7zpSf8S8P2QhnFM=
X-Google-Smtp-Source: ABdhPJyhHs+E37K7WkRjfykrsPqBFemi7Q1L8zEdGOSdXgfuPSp9puVT3haRJq3aalGfRUht2DXEoQ==
X-Received: by 2002:a05:6402:3115:: with SMTP id dc21mr2601112edb.173.1617183647086;
        Wed, 31 Mar 2021 02:40:47 -0700 (PDT)
Received: from agape ([5.171.73.44])
        by smtp.gmail.com with ESMTPSA id z9sm1147155edr.75.2021.03.31.02.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 02:40:46 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 18/40] staging: rtl8723bs: added driver prefix in log messages
Date:   Wed, 31 Mar 2021 11:39:46 +0200
Message-Id: <a6cf9cf83491f4dc0ea17d4aa084945d2e57fcef.1617183374.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617183374.git.fabioaiuto83@gmail.com>
References: <cover.1617183374.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

added driver prefix in log messages in hal/rtl8723b_hal_init.c

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 0f7da8dbd80c..7b92bc5ed1c7 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -396,13 +396,14 @@ s32 rtl8723b_FirmwareDownload(struct adapter *padapter, bool  bUsedWoWLANFw)
 
 	rtStatus = request_firmware(&fw, fwfilepath, device);
 	if (rtStatus) {
-		pr_err("Request firmware failed with error 0x%x\n", rtStatus);
+		pr_err("%s Request firmware failed with error 0x%x\n",
+		       DRIVER_PREFIX, rtStatus);
 		rtStatus = _FAIL;
 		goto exit;
 	}
 
 	if (!fw) {
-		pr_err("Firmware %s not available\n", fwfilepath);
+		pr_err("%s Firmware %s not available\n", DRIVER_PREFIX, fwfilepath);
 		rtStatus = _FAIL;
 		goto exit;
 	}
-- 
2.20.1

