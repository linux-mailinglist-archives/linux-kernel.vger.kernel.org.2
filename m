Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D039D313E24
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234505AbhBHSy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233814AbhBHRKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 12:10:45 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F7BC06178A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 09:10:04 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id bl23so26069971ejb.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 09:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xgAl1yyQTai0WWqdODaJRh56JLGDYIju8qObmZRLJrs=;
        b=Wy652esdymUcMjYRffimkbybxLl7BOGM/1wvpSMrqBJjlM0qSh+jV+QEYOb949UCDy
         qDK0YwO9WGHXmNLY18oM68OfOVimv5u4+GM2vx9ECTJ0v4kjTEm2klBcbSPMEhtg3wiW
         hhGKsRTVaoInfHjd0GemgMju2R+KE7uPC674xWGQ8gFWJCfuBX0xwgSJGRfOQ9zFApwN
         CvP3j06/PuDijMxznxqq+PXfHJ7Nsj06GM6z8288kUkrjSJKrWyRPUlJqDcp55hnpEs+
         q4bm0vWhiEX5azDVqPMWDVupSaJ0WA0dGObT6dONCCYkc12V82fKTgycLlH3rqSjXPx5
         f9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xgAl1yyQTai0WWqdODaJRh56JLGDYIju8qObmZRLJrs=;
        b=C4p+XWAYFCKOvfQFFHaDuDP9OnH7dji+EASjOvrYrVj/Nsp5df2BxOnqniErDOJUoV
         SjJT6+4sD/QEAI2vdKGNzmFR7Bs7/+abHuuCm3umA3iwPEBS4bUyeoarLovJmmVD+fop
         OBEJKD6N2ch4RYLwqlDj6B1GKKUoBDZ2L0t185LP016IlO2xVF1xrx1AMpeHG5sQOGcE
         nY+uAklDe3rXDEByfCm+fkhWdcha/yDFfnGKiLAnGYEvyKGfoYJtFpJxFHG0WxLNXbfD
         iygb3aDcguUx8JEjIMT94z8WYV7gtwICnsGHf8Kj0C7A0CMUk+Sk0vDMCyautz84dNoC
         ZZJg==
X-Gm-Message-State: AOAM531qjaxx7m8yxT35PUPCleAomUfA/2SP+tviWF3Vi/l5c9hB9LJ8
        W84aPEUMbaT7gHt6hkQbQAQ=
X-Google-Smtp-Source: ABdhPJyRvqiT9YGMal+UWRDDAnKTkNzs+SfzeyKnxngjTayZIUEDvTWYtXeuu7Zo6Ls2VZWFUCEYUQ==
X-Received: by 2002:a17:907:2088:: with SMTP id pv8mr17465138ejb.131.1612804203502;
        Mon, 08 Feb 2021 09:10:03 -0800 (PST)
Received: from yoga-910.localhost (5-12-227-87.residential.rdsnet.ro. [5.12.227.87])
        by smtp.gmail.com with ESMTPSA id m10sm9834479edi.54.2021.02.08.09.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 09:10:02 -0800 (PST)
From:   Ioana Ciornei <ciorneiioana@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     laurentiu.tudor@nxp.com, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 1/3] bus: fsl-mc: Fix test for end of loop
Date:   Mon,  8 Feb 2021 19:09:47 +0200
Message-Id: <20210208170949.3070898-2-ciorneiioana@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210208170949.3070898-1-ciorneiioana@gmail.com>
References: <20210208170949.3070898-1-ciorneiioana@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

The "desc" pointer can't possibly be NULL here.  If we can't find the
correct "desc" then tt points to the last element of the
fsl_mc_accepted_cmds[] array.  Fix this by testing if
"i == FSL_MC_NUM_ACCEPTED_CMDS" instead.

Fixes: 2cf1e703f066 ("bus: fsl-mc: add fsl-mc userspace support")
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/bus/fsl-mc/fsl-mc-uapi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-uapi.c b/drivers/bus/fsl-mc/fsl-mc-uapi.c
index eeb988c9f4bb..bdcd9d983a78 100644
--- a/drivers/bus/fsl-mc/fsl-mc-uapi.c
+++ b/drivers/bus/fsl-mc/fsl-mc-uapi.c
@@ -338,7 +338,7 @@ static int fsl_mc_command_check(struct fsl_mc_device *mc_dev,
 		if ((cmdid & desc->cmdid_mask) == desc->cmdid_value)
 			break;
 	}
-	if (!desc) {
+	if (i == FSL_MC_NUM_ACCEPTED_CMDS) {
 		dev_err(&mc_dev->dev, "MC command 0x%04x: cmdid not accepted\n", cmdid);
 		return -EACCES;
 	}
-- 
2.30.0

