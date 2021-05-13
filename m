Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67FF837F8FD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 15:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbhEMNqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 09:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234134AbhEMNqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 09:46:14 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D2AC061574;
        Thu, 13 May 2021 06:45:03 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 131so8399397ljj.3;
        Thu, 13 May 2021 06:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FBPasmM/koYk8hAIqdY3f2KiMrXHrlFGMqFB3oaVE/M=;
        b=UQZ1qIlhOC5IXhSBZjQWBA1TB8avfWoOWFC6GP8TBEI1qtuZON9be+NI4onn4ZJZKD
         hiDB4EPhpKKp1JVinhjFeIncphN0sG0bMkBlC+l0DXSAmEqfJrYVySFxvw4HCfiH/74o
         qID/FFNUgdyiBVdAyO4znV1qW3XKv5NuVg00rocTeOCZZm6tMiDK0bKBjmuCblILWlRU
         REHvJta1/BZuD0P379qs+fnYWMtAajWHXL0ACRrlHdRFc+KwQwFmgjCdOM0Q0/6gcA9P
         sqnjHbP2wNXMhNsPStHh0WQjiz0Xzqyi0HbiqmtKfPyg+5SafjZOsDca0VTytnRyUplS
         vh9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FBPasmM/koYk8hAIqdY3f2KiMrXHrlFGMqFB3oaVE/M=;
        b=QVFPbOkYz8L8hcdC457yFpOecgrfMptSv0lfDTjZNmaX8hsUTRiaNRwE6FlsyLcalN
         hFH/l8nKGWIB/1xTPGHo6rYSfUqnU0yhz7qW9Tz1VsX8lFd7fXMTJlun0v6kVUf+UDkZ
         KwbC+prManFjOj5hvPFP04qqitn2EzVPNPWoClcZ6Y5ODzEI0E9EI62D3w2fgt7OE3Gv
         SxszRynbdg+0lz4TgKR+ocwsP1+wiOPpS5pxgJnNsrGSHBw7mdzytAIeEmtsqGD93mRG
         8ACS7dU685IJSLQN50VQ7NqMxdHMVLR4q18jmuFmFPAYOdOpssNnx7DT6gOBIFMQoZVm
         PyWA==
X-Gm-Message-State: AOAM532W72DxOvHvoxltpNFFEVxKPHlCZKgo7e/CvlbrqGNaEpoKlmb3
        +EByuc3X0w0sU0gWxbNbbBg=
X-Google-Smtp-Source: ABdhPJx3PZf9GaKZ2dlSV2URvf6k6labAM601mYcJMAcNA/I40sQE91fIIwA6cbkASIWFs6K5jIm/Q==
X-Received: by 2002:a2e:3619:: with SMTP id d25mr3764062lja.247.1620913501899;
        Thu, 13 May 2021 06:45:01 -0700 (PDT)
Received: from xws.localdomain ([37.58.58.229])
        by smtp.gmail.com with ESMTPSA id m25sm294089lfr.288.2021.05.13.06.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 06:45:01 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] platform/surface: dtx: Fix poll function
Date:   Thu, 13 May 2021 15:44:37 +0200
Message-Id: <20210513134437.2431022-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The poll function should not return -ERESTARTSYS.

Furthermore, locking in this function is completely unnecessary. The
ddev->lock protects access to the main device and controller (ddev->dev
and ddev->ctrl), ensuring that both are and remain valid while being
accessed by clients. Both are, however, never accessed in the poll
function. The shutdown test (via atomic bit flags) be safely done
without locking, so drop locking here entirely.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 1d609992832e ("platform/surface: Add DTX driver)
Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/platform/surface/surface_dtx.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/platform/surface/surface_dtx.c b/drivers/platform/surface/surface_dtx.c
index 63ce587e79e3..5d9b758a99bb 100644
--- a/drivers/platform/surface/surface_dtx.c
+++ b/drivers/platform/surface/surface_dtx.c
@@ -527,20 +527,14 @@ static __poll_t surface_dtx_poll(struct file *file, struct poll_table_struct *pt
 	struct sdtx_client *client = file->private_data;
 	__poll_t events = 0;
 
-	if (down_read_killable(&client->ddev->lock))
-		return -ERESTARTSYS;
-
-	if (test_bit(SDTX_DEVICE_SHUTDOWN_BIT, &client->ddev->flags)) {
-		up_read(&client->ddev->lock);
+	if (test_bit(SDTX_DEVICE_SHUTDOWN_BIT, &client->ddev->flags))
 		return EPOLLHUP | EPOLLERR;
-	}
 
 	poll_wait(file, &client->ddev->waitq, pt);
 
 	if (!kfifo_is_empty(&client->buffer))
 		events |= EPOLLIN | EPOLLRDNORM;
 
-	up_read(&client->ddev->lock);
 	return events;
 }
 
-- 
2.31.1

