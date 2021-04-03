Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4488D3531E5
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 03:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236106AbhDCBYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 21:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235668AbhDCBYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 21:24:12 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF608C06178C
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 18:24:10 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id y2so4752785qtw.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 18:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TekMjkgaWQi0sIeSwp8iDKdyw1q0V3gj1ztNBm6VfsI=;
        b=N93H9eELxbyttYkXPZebBizGOV8bPb8/GkIxOeahvB7o8DD+CwSF5js8w3/rg2VlDH
         Jegdl+ksK/OiNmyKXDTe2jBTHiRugasyJlv8lPuFbS8WNMZ2UmxS83m137Vb2bQanrO/
         pA/tn8tDOYsqxc4B1+8/E4vyS59ykJHPyFrlm0VTdTFA2vEmPP0sRzSi9rI5jbN2d4Re
         Kvbc11CJ4v5VvmwRwJh/f/VsnttafYgNYZaNRjnCV/gEnLzb1vcSha3dOCp0+GmL2F6g
         oJSDGTwvT7c1LmAdEKN8HsvJz8xZMtQrlAnEa3P+DDtTxVKtaEs6JhIm0ak2vjWct8Su
         RLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TekMjkgaWQi0sIeSwp8iDKdyw1q0V3gj1ztNBm6VfsI=;
        b=h7fNnY3megIrfydxY2mkRonnrxOHKzwsFUE/DgY5hdjzRBwKSujlSCr1fQzbqAx4Y1
         /9x+KaBRsiOYFmIvbnm0XZ7ILckZegLnHw7VKnWRZpsjW5zAEIQcNRyYYi5Yv08a1X4h
         N3QbtsFKFzaEuW7g1bP0Xh45xJ9gXa1WZ+b52DqBxmJ97VFQqaMxNHQk3y4Z9Z2ie0np
         6YE695CUSryUjTFTCHSCN12rTDaUqfnP+wcn8Wl4erVNOrpoE/wtBlgALYNF6F51gxPe
         U6MYLn3Uh7FcunmTsB1F2IrxD1MHwudTRLkLGrysyJP67fxV8hQ1AXZhtebc7Zj8RAzI
         Bd0Q==
X-Gm-Message-State: AOAM531xq5/vyXu1IzuVSJMQ+zeQtTOJcMBD0BNA2V9Ww/bGIMe/tfz0
        mM0n/AK/2ppmZSWdntYCAV4=
X-Google-Smtp-Source: ABdhPJwYBugEaDwe1Xsa5ZBJ3r2mYKteIzbVYg4ivN/MG7szv5scV+mfo4u1hfE/tVPdwJM7gfg5fg==
X-Received: by 2002:a05:622a:4d3:: with SMTP id q19mr13800123qtx.55.1617413050161;
        Fri, 02 Apr 2021 18:24:10 -0700 (PDT)
Received: from LuizSampaio-PC.localdomain ([2804:14d:5cd3:8f4f:bad9:1dc4:19d9:7ce3])
        by smtp.gmail.com with ESMTPSA id h14sm7439818qtx.64.2021.04.02.18.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 18:24:09 -0700 (PDT)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     zbr@ioremap.net
Cc:     corbet@lwn.net, rikard.falkeborn@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Luiz Sampaio <sampaio.ime@gmail.com>
Subject: [PATCH v2 3/9] w1: ds2438: fixed a coding style issue
Date:   Fri,  2 Apr 2021 22:24:40 -0300
Message-Id: <20210403012446.381516-4-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210403012446.381516-1-sampaio.ime@gmail.com>
References: <20210403012446.381516-1-sampaio.ime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since there is only one statement inside the if clause, no brackets
are required.

Signed-off-by: Luiz Sampaio <sampaio.ime@gmail.com>
---
 drivers/w1/slaves/w1_ds2438.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2438.c b/drivers/w1/slaves/w1_ds2438.c
index a5bb53042c93..eca50cec304f 100644
--- a/drivers/w1/slaves/w1_ds2438.c
+++ b/drivers/w1/slaves/w1_ds2438.c
@@ -338,9 +338,9 @@ static ssize_t temperature_read(struct file *filp, struct kobject *kobj,
 	if (!buf)
 		return -EINVAL;
 
-	if (w1_ds2438_get_temperature(sl, &temp) == 0) {
+	if (w1_ds2438_get_temperature(sl, &temp) == 0)
 		ret = snprintf(buf, count, "%i\n", temp);
-	} else
+	else
 		ret = -EIO;
 
 	return ret;
-- 
2.30.1

