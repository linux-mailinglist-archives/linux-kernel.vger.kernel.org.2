Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFA5338AC1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 11:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbhCLK4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 05:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233680AbhCLKzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 05:55:43 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21074C061761
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 02:55:43 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id j7so1518887wrd.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 02:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IHYhJM9nMyAbr9kC0PuVmzVL2n+2I82Ba3dsjUeY+AI=;
        b=d9pSu1o7M26wU29kEvwgXHR/9OVEDjrsKEs7qA14xPmWODrzW4tRDS+O/ts0F6JnJj
         x8LEZn2Mxngo9It+fCDXY5fgfGOD4zgSTA6ebhbt4XLG9X5WFjcMG1GW/qH9Dc54vTTQ
         qtO6jZ6Q12Be2RxnqCH6coaZLJ1/7iKCa4GUEm3PK9l9ecouej6FvqT4qQtwC9EEBjfC
         6UCJZ01F8JIqq0ga1L79yVOaCcrGTLakUKnzqxO4hIjCiE5+wJ02o3TyIz3uifCAb/s+
         xnthZx1vQSV8G+vAhq1he8Qp91qlJKzBGpZKDLAaMHHOE+iWfyWF65ScVDsCEdij7GLM
         mAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IHYhJM9nMyAbr9kC0PuVmzVL2n+2I82Ba3dsjUeY+AI=;
        b=ogqx5xzIUeM2SS8aMrvWvADV7/v1qy4XUlbF5Bb9KGEu/B4wvIcAxPsCXopaSG0rkD
         MAP7gvd5RMTqHWzUmGjabngaCsmDMT+F+Gpk23Wed+cOir1yrKXKv9HX2bmJmpmr5gOp
         Gs1rVJ0/JcdLA5eP8HKU/W91PmIPi4xNJpuQUmCDUfrEnEnLPH3oVzPl3oNsZL7WjZas
         UHaOdWcMJLOsjzH7i9DVZRnk2qCRLGT354kbQpL9fgr8BK1SuXD0P7ZbSXzudC875ONn
         V1o6yT0mz+6LclAlJ2u77zbHuahMHKNzvIZ+7GVrL3TT6bvri/Ybw4wcALYqQWAUogmY
         6mTA==
X-Gm-Message-State: AOAM532w7lynf65xBNO6yuJAPmsLu9dtqtXGR6fNm0UgBd8pmBK7dwvl
        rd2aJaYEKrN/5ukamLlZGmA3Kw==
X-Google-Smtp-Source: ABdhPJwn83lXba8ON91dxvqRmuL6Fo3sSgrermJApEsbmfY2Mjz9q/po8sAA6SAMQtVCUVHM4Ak+VQ==
X-Received: by 2002:a5d:4445:: with SMTP id x5mr13658139wrr.30.1615546541806;
        Fri, 12 Mar 2021 02:55:41 -0800 (PST)
Received: from dell.default ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id q15sm7264962wrr.58.2021.03.12.02.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 02:55:41 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org
Subject: [PATCH 06/11] block: drbd: drbd_main: Remove duplicate field initialisation
Date:   Fri, 12 Mar 2021 10:55:25 +0000
Message-Id: <20210312105530.2219008-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210312105530.2219008-1-lee.jones@linaro.org>
References: <20210312105530.2219008-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[P_RETRY_WRITE] is initialised more than once.

Fixes the following W=1 kernel build warning(s):

 drivers/block/drbd/drbd_main.c: In function ‘cmdname’:
 drivers/block/drbd/drbd_main.c:3660:22: warning: initialized field overwritten [-Woverride-init]
 drivers/block/drbd/drbd_main.c:3660:22: note: (near initialization for ‘cmdnames[44]’)

Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com
Cc: linux-block@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/block/drbd/drbd_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 25cd8a2f729db..69c9640d407df 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -3657,7 +3657,6 @@ const char *cmdname(enum drbd_packet cmd)
 		[P_RS_CANCEL]		= "RSCancel",
 		[P_CONN_ST_CHG_REQ]	= "conn_st_chg_req",
 		[P_CONN_ST_CHG_REPLY]	= "conn_st_chg_reply",
-		[P_RETRY_WRITE]		= "retry_write",
 		[P_PROTOCOL_UPDATE]	= "protocol_update",
 		[P_RS_THIN_REQ]         = "rs_thin_req",
 		[P_RS_DEALLOCATED]      = "rs_deallocated",
-- 
2.27.0

