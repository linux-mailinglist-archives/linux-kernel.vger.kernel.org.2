Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA7C30AA1E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 15:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbhBAOo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 09:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbhBAOl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 09:41:58 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DD0C06121E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 06:39:58 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id d16so16793944wro.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 06:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g/xsj8QnzTyjZTuByN2rtr+7Bim8nVB2CCDQafkvd6A=;
        b=nfEkhzEbgz14R/tMpOwQ02Eojho5vUVU6vM5evj27Ooo/l1N7p5vTWgkfFKNa0uKE7
         +gL6H7kg3w41Bpb8ofpNmElwXHFyNIzGswnfbEVq/OFUytD3g/H/mgX+4QlicbyFv0/w
         WljXKAe/AzV6xBwDr0P8gni8A31IN+pDSzCjGJuPRXFeFypKWYwrh+IzBWGDbTzPOHlm
         bIWi94gCiNKCUhCft7VLMbp9LwTOu26W7vti9odQn6WaLswVKDBHrRMrkc85EeApTMHC
         YbMkMAAZXD/5paEW4cT6W09tmhnY1tzAB/fUOvKHbMBAcCbWQrVd5pc3c1Lh7e9sI2He
         OsOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g/xsj8QnzTyjZTuByN2rtr+7Bim8nVB2CCDQafkvd6A=;
        b=gzKMoXf5mWp0lElkJAjELSJNcBmMG4wbL6z/PgZIYbdltCvGa9NGKilonOeTbR7mEn
         XdBbcv+jL8Gj07BAFLsv4+fUkd7nY2J4RcusepyL6vXJyvUFAsLrviAZyIZw4JrWIF9c
         mmacUYd7YmUap5zQkJ9WqmpQUGuFM9mRXogQnEiORqMMlkuRAB67J4RovNKvpC9tEmG3
         oU8C4AsFILBxlJt/xomaZKjMTZXafxCf0b7peIw1Y+y68BJFtXQgo17N+ND/A0SzEiwy
         Sx26LF7j7hsK2Oc7bdZKJmQ1/9mAoZqGBSOcH2mAX4aJJvAX+Ta0rNacJNjm+eQSiDnM
         b2ow==
X-Gm-Message-State: AOAM531BJrMa5xJ+g3J/R5vvZyKVM2EszghNDgFrX3hvMDxGCfXY9MVg
        sLZiaSwy/W06mPKZjSSEibMQSjX/ymokV9gx
X-Google-Smtp-Source: ABdhPJzPmYic1cm2Sz5pCBPwPCfylEgtpIbm5kuKCNjN5CBDvdpU0QDAwGLOOSsk3STc3hYIRx2dGQ==
X-Received: by 2002:adf:dd10:: with SMTP id a16mr18522509wrm.207.1612190396737;
        Mon, 01 Feb 2021 06:39:56 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id h15sm27301359wrt.10.2021.02.01.06.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 06:39:56 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org
Subject: [PATCH 12/20] ata: pata_amd: Fix incorrectly named function in the header
Date:   Mon,  1 Feb 2021 14:39:32 +0000
Message-Id: <20210201143940.2070919-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201143940.2070919-1-lee.jones@linaro.org>
References: <20210201143940.2070919-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/pata_amd.c:331: warning: expecting prototype for nv_probe_init(). Prototype was for nv_pre_reset() instead

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/pata_amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_amd.c b/drivers/ata/pata_amd.c
index 75b830eb3c542..c8acba162d02f 100644
--- a/drivers/ata/pata_amd.c
+++ b/drivers/ata/pata_amd.c
@@ -319,7 +319,7 @@ static unsigned long nv_mode_filter(struct ata_device *dev,
 }
 
 /**
- *	nv_probe_init	-	cable detection
+ *	nv_pre_reset	-	cable detection
  *	@link: ATA link
  *	@deadline: deadline jiffies for the operation
  *
-- 
2.25.1

